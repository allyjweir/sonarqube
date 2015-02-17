/*
 * SonarQube, open source software quality management tool.
 * Copyright (C) 2008-2014 SonarSource
 * mailto:contact AT sonarsource DOT com
 *
 * SonarQube is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * SonarQube is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
package org.sonar.batch.scan.filesystem;

import com.google.common.base.Charsets;
import org.apache.commons.io.FileUtils;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.rules.TemporaryFolder;
import org.sonar.api.batch.AnalysisMode;

import java.io.File;
import java.nio.charset.Charset;

import static org.apache.commons.codec.digest.DigestUtils.md5Hex;
import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.mock;

public class FileMetadataTest {

  @Rule
  public ExpectedException thrown = ExpectedException.none();

  @Rule
  public TemporaryFolder temp = new TemporaryFolder();

  private AnalysisMode mode = mock(AnalysisMode.class);

  @Test
  public void empty_file() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.touch(tempFile);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(1);
    assertThat(metadata.nonBlankLines).isEqualTo(0);
    assertThat(metadata.hash).isNotEmpty();
    assertThat(metadata.originalLineOffsets).containsOnly(0);
    assertThat(metadata.empty).isTrue();
  }

  @Test
  public void windows_without_latest_eol() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "foo\r\nbar\r\nbaz", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(3);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("foo\nbar\nbaz"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 5, 10);
    assertThat(metadata.empty).isFalse();
  }

  @Test
  public void read_with_wrong_encoding() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "marker´s\n", Charset.forName("cp1252"));

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(2);
    assertThat(metadata.hash).isEqualTo(md5Hex("marker\ufffds\n"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 9);
  }

  @Test
  public void non_ascii_utf_8() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "föo\r\nbàr\r\n\u1D11Ebaßz\r\n", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(4);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("föo\nbàr\n\u1D11Ebaßz\n"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 5, 10, 18);
  }

  @Test
  public void non_ascii_utf_16() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "föo\r\nbàr\r\n\u1D11Ebaßz\r\n", Charsets.UTF_16, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_16);
    assertThat(metadata.lines).isEqualTo(4);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("föo\nbàr\n\u1D11Ebaßz\n"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 5, 10, 18);
  }

  @Test
  public void unix_without_latest_eol() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "foo\nbar\nbaz", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(3);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("foo\nbar\nbaz"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 4, 8);
  }

  @Test
  public void unix_with_latest_eol() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "foo\nbar\nbaz\n", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(4);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("foo\nbar\nbaz\n"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 4, 8, 12);
  }

  @Test
  public void mix_of_newlines_with_latest_eol() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "foo\nbar\r\nbaz\n", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(4);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("foo\nbar\nbaz\n"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 4, 9, 13);
  }

  @Test
  public void several_new_lines() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "foo\n\n\nbar", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(4);
    assertThat(metadata.nonBlankLines).isEqualTo(2);
    assertThat(metadata.hash).isEqualTo(md5Hex("foo\n\n\nbar"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 4, 5, 6);
  }

  @Test
  public void mix_of_newlines_without_latest_eol() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "foo\nbar\r\nbaz", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(3);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("foo\nbar\nbaz"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 4, 9);
  }

  @Test
  public void start_with_newline() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "\nfoo\nbar\r\nbaz", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(4);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("\nfoo\nbar\nbaz"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 1, 5, 10);
  }

  @Test
  public void start_with_bom() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, "\uFEFFfoo\nbar\r\nbaz", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(3);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex("foo\nbar\nbaz"));
    assertThat(metadata.originalLineOffsets).containsOnly(0, 4, 9);
  }

  @Test
  public void ignore_whitespace_when_computing_line_hashes() throws Exception {
    File tempFile = temp.newFile();
    FileUtils.write(tempFile, " foo\nb ar\r\nbaz \t", Charsets.UTF_8, true);

    FileMetadata.Metadata metadata = new FileMetadata(mode).read(tempFile, Charsets.UTF_8);
    assertThat(metadata.lines).isEqualTo(3);
    assertThat(metadata.nonBlankLines).isEqualTo(3);
    assertThat(metadata.hash).isEqualTo(md5Hex(" foo\nb ar\nbaz \t"));
  }

  @Test
  public void should_throw_if_file_does_not_exist() throws Exception {
    File tempFolder = temp.newFolder();
    File file = new File(tempFolder, "doesNotExist.txt");

    thrown.expect(IllegalStateException.class);
    thrown.expectMessage("Fail to read file '" + file.getAbsolutePath() + "' with encoding 'UTF-8'");

    new FileMetadata(mode).read(file, Charsets.UTF_8);
  }

  @Test
  public void line_feed_is_included_into_hash() throws Exception {
    File file1 = temp.newFile();
    FileUtils.write(file1, "foo\nbar\n", Charsets.UTF_8, true);

    // same as file1, except an additional return carriage
    File file1a = temp.newFile();
    FileUtils.write(file1a, "foo\r\nbar\n", Charsets.UTF_8, true);

    File file2 = temp.newFile();
    FileUtils.write(file2, "foo\nbar", Charsets.UTF_8, true);

    String hash1 = new FileMetadata(mode).read(file1, Charsets.UTF_8).hash;
    String hash1a = new FileMetadata(mode).read(file1a, Charsets.UTF_8).hash;
    String hash2 = new FileMetadata(mode).read(file2, Charsets.UTF_8).hash;
    assertThat(hash1).isEqualTo(hash1a);
    assertThat(hash1).isNotEqualTo(hash2);
  }

}
