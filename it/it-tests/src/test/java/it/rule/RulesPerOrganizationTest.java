/*
 * SonarQube
 * Copyright (C) 2009-2017 SonarSource SA
 * mailto:info AT sonarsource DOT com
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
package it.rule;

import com.sonar.orchestrator.Orchestrator;
import it.Category6Suite;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.ClassRule;
import org.junit.Test;
import org.sonarqube.ws.client.WsClient;
import org.sonarqube.ws.client.organization.CreateWsRequest;

import static it.Category6Suite.enableOrganizationsSupport;
import static org.assertj.core.api.Assertions.assertThat;
import static util.ItUtils.deleteOrganizationsIfExists;
import static util.ItUtils.newAdminWsClient;

public class RulesPerOrganizationTest {

  private static WsClient adminWsClient;
  private static final String ORGANIZATION_FOO = "foo-org";
  private static final String ORGANIZATION_BAR = "bar-org";

  @ClassRule
  public static Orchestrator orchestrator = Category6Suite.ORCHESTRATOR;

  @BeforeClass
  public static void setUp() {
    adminWsClient = newAdminWsClient(orchestrator);
    enableOrganizationsSupport();
    createOrganization();
  }

  @AfterClass
  public static void tearDown() throws Exception {
    deleteOrganizationsIfExists(orchestrator, ORGANIZATION_FOO);
    deleteOrganizationsIfExists(orchestrator, ORGANIZATION_BAR);
  }

  private static void createOrganization() {
    adminWsClient.organizations().create(new CreateWsRequest.Builder().setKey(ORGANIZATION_FOO).setName(ORGANIZATION_FOO).build());
    adminWsClient.organizations().create(new CreateWsRequest.Builder().setKey(ORGANIZATION_BAR).setName(ORGANIZATION_BAR).build());
  }

  @Test
  public void should_not_show_tags_of_other_org() {
    setTagsForOrg("foo-tag", ORGANIZATION_FOO);
    setTagsForOrg("bar-tag", ORGANIZATION_BAR);
    assertThat(getTagsForOrg(ORGANIZATION_FOO)).contains("\"tags\":[\"foo-tag\"]");
    assertThat(getTagsForOrg(ORGANIZATION_BAR)).contains("\"tags\":[\"bar-tag\"]");
  }

  @Test
  public void should_not_list_tags_of_other_org() {
    setTagsForOrg("foo-tag", ORGANIZATION_FOO);
    setTagsForOrg("bar-tag", ORGANIZATION_BAR);
    assertThat(listForOrg(ORGANIZATION_FOO)).contains("\"foo-tag\"").doesNotContain("\"bar-tag\"");
  }

  @Test
  public void should_not_show_removed_tags() {
    setTagsForOrg("foo-tag", ORGANIZATION_FOO);
    setTagsForOrg("", ORGANIZATION_FOO);
    assertThat(getTagsForOrg(ORGANIZATION_FOO)).contains("\"tags\":[]");
  }

  @Test
  public void should_not_list_removed_tags() {
    setTagsForOrg("foo-tag", ORGANIZATION_FOO);
    setTagsForOrg("", ORGANIZATION_FOO);
    assertThat(listForOrg(ORGANIZATION_FOO)).doesNotContain("\"foo-tag\"");
  }

  private String listForOrg(String organization) {
    return orchestrator.getServer().adminWsClient().post("api/rules/tags", "organization", organization);
  }

  public String getTagsForOrg(String organization) {
    return orchestrator.getServer().adminWsClient().post("api/rules/show", "organization", organization, "key", "xoo:OneIssuePerFile");
  }

  public void setTagsForOrg(String tags, String organization) {
    orchestrator.getServer().adminWsClient().post("api/rules/update", "organization", organization, "key", "xoo:OneIssuePerFile", "tags", tags);
  }
}
