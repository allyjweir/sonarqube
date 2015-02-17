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

package org.sonar.server.es.request;

import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.common.unit.TimeValue;
import org.junit.Before;
import org.junit.ClassRule;
import org.junit.Test;
import org.sonar.core.profiling.Profiling;
import org.sonar.server.es.EsTester;
import org.sonar.server.es.FakeIndexDefinition;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.fail;

public class ProxySearchScrollRequestBuilderTest {

  @ClassRule
  public static EsTester esTester = new EsTester().addDefinitions(new FakeIndexDefinition());

  @Before
  public void setUp() throws Exception {
    esTester.setProfilingLevel(Profiling.Level.NONE);
  }

  @Test
  public void search_scroll() {
    SearchResponse response = esTester.client().prepareSearch(FakeIndexDefinition.INDEX)
      .setSearchType(SearchType.SCAN)
      .setScroll(TimeValue.timeValueMinutes(1))
      .get();
    esTester.client().prepareSearchScroll(response.getScrollId()).get();
  }

  @Test
  public void with_profiling_full() {
    esTester.setProfilingLevel(Profiling.Level.FULL);

    SearchResponse response = esTester.client().prepareSearch(FakeIndexDefinition.INDEX)
      .setSearchType(SearchType.SCAN)
      .setScroll(TimeValue.timeValueMinutes(1))
      .get();
    esTester.client().prepareSearchScroll(response.getScrollId()).get();

    // TODO assert profiling
  }

  @Test
  public void fail_to_search_bad_query() throws Exception {
    try {
      esTester.client().prepareSearchScroll("unknown").get();
      fail();
    } catch (Exception e) {
      assertThat(e).isInstanceOf(IllegalStateException.class);
      assertThat(e.getMessage()).contains("Fail to execute ES search scroll request for scroll id 'null'");
    }
  }

  @Test
  public void get_with_string_timeout_is_not_yet_implemented() throws Exception {
    try {
      esTester.client().prepareSearchScroll("scrollId").get("1");
      fail();
    } catch (Exception e) {
      assertThat(e).isInstanceOf(IllegalStateException.class).hasMessage("Not yet implemented");
    }
  }

  @Test
  public void get_with_time_value_timeout_is_not_yet_implemented() throws Exception {
    try {
      esTester.client().prepareSearchScroll("scrollId").get(TimeValue.timeValueMinutes(1));
      fail();
    } catch (Exception e) {
      assertThat(e).isInstanceOf(IllegalStateException.class).hasMessage("Not yet implemented");
    }
  }

  @Test
  public void execute_should_throw_an_unsupported_operation_exception() throws Exception {
    try {
      esTester.client().prepareSearchScroll("scrollId").execute();
      fail();
    } catch (Exception e) {
      assertThat(e).isInstanceOf(UnsupportedOperationException.class).hasMessage("execute() should not be called as it's used for asynchronous");
    }
  }
}
