Return-Path: <linux-pci+bounces-668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EB5809F49
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A8661C209F1
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545112B75;
	Fri,  8 Dec 2023 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="UzAH0pyj";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="i0Iyjiv/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15117171D
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 94F37C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027146; bh=JZOiUUJwl/e/vrip1gIhdm/+Nwqn0MqXelRrRZxHE+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UzAH0pyj1f48FwMT1H3UpWEAh7lJ/HE2TCY+LNv2OUtdjooRl7ma4N6rUOdm4Tcfy
	 eodvkYWHTr5U0p74Uubi4rXNnbfUVcG+yXwxozlvbb9NujJJfJsSo9vTLepsp9O9v+
	 uSP8/rsyrpSiW8YwLpnOKs3EBZ5fnX5iBB08O/LcxZSnmcsnYbMiBuUPaDB8Z446Ej
	 zVaFPmOMYiv313wdlg+LIMVOpmFEq5qGFQ8kWVI1IjAVQTD54A7nSQ5sdmnexOss1q
	 yYiSilmEaX8+WUdEuQs2+U4lblOv7/Et8a+aQp/Noqf/ZAzSmHGGYUQV3g7OQJqgQH
	 W+23VNiX7LVdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027146; bh=JZOiUUJwl/e/vrip1gIhdm/+Nwqn0MqXelRrRZxHE+8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=i0Iyjiv/OM0OaapQwZnVSN/FeN8bp/xiMGkFGlc4FBsxjYr0aB4qlgcYbM0rrRuBp
	 rsP2DNJID2vok2hnk/Ord3C+mB9puL/7bukeL/NkhMKfzKzPQl0J//AdZpxLk5QKW6
	 vpMzmUxtHEqRElfHnRaooLWaAWfV43jMrXZn7Guw0ANLQJjnV/JHt7xMaev/zRKIaw
	 Bk5XhTjPeY2LNJaHiqG3sNqLPwZw2tJdkIXp/J6wZk8Ip4/4TTjGbQvBfgRWs6x3OI
	 3negIJ1swfwRr7WoWNhBhCg3qlqBIR2mOE+wZA6s3G+0PSI+g/lpYeb3LD0wWE5wpO
	 9uU4L5yzScZag==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 05/15] pciutils-pcilmr: Add margining process functions
Date: Fri, 8 Dec 2023 12:17:24 +0300
Message-ID: <20231208091734.12225-6-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208091734.12225-1-n.proshkin@yadro.com>
References: <20231208091734.12225-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-10.corp.yadro.com (172.17.11.60) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

* Implement the margining flow as described in the section "Example
  Software Flow for Lane Margining at Receiver" of the 5.0 spec;
* Implement margining commands formation and response parsing according
  to the table 4-26;
* Use Receiver margining parameters as described in the table 8-11;
* Support lane reversal and simultaneous margining of several link lanes.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr_lib/Makefile |   2 +-
 lmr_lib/margin.c | 404 +++++++++++++++++++++++++++++++++++++++++++++++
 lmr_lib/margin.h | 197 +++++++++++++++++++++++
 3 files changed, 602 insertions(+), 1 deletion(-)
 create mode 100644 lmr_lib/margin.c
 create mode 100644 lmr_lib/margin.h

diff --git a/lmr_lib/Makefile b/lmr_lib/Makefile
index 4f85a17..2003a67 100644
--- a/lmr_lib/Makefile
+++ b/lmr_lib/Makefile
@@ -1,4 +1,4 @@
-OBJS=margin_hw
+OBJS=margin_hw margin
 INCL=$(addsuffix .h,$(OBJS)) $(addprefix ../,$(PCIINC))
 
 $(addsuffix .o, $(OBJS)): %.o: %.c $(INCL)
diff --git a/lmr_lib/margin.c b/lmr_lib/margin.c
new file mode 100644
index 0000000..9d25973
--- /dev/null
+++ b/lmr_lib/margin.c
@@ -0,0 +1,404 @@
+#include <errno.h>
+#include <time.h>
+#include <stdio.h>
+#include <malloc.h>
+
+#include "margin.h"
+
+#define MARG_LANE_CTRL(lmr_cap_addr, lane) ((lmr_cap_addr) + 8 + 4 * (lane))
+#define MARG_LANE_STATUS(lmr_cap_addr, lane) ((lmr_cap_addr) + 10 + 4 * (lane))
+
+#define MARG_TIM(go_left, step, recvn) margin_make_cmd(((go_left) << 6) | (step), 3, recvn)
+#define MARG_VOLT(go_down, step, recvn) margin_make_cmd(((go_down) << 7) | (step), 4, recvn)
+
+// report commands
+#define REPORT_CAPS(recvn) margin_make_cmd(0x88, 1, recvn)
+#define REPORT_VOL_STEPS(recvn) margin_make_cmd(0x89, 1, recvn)
+#define REPORT_TIM_STEPS(recvn) margin_make_cmd(0x8A, 1, recvn)
+#define REPORT_TIM_OFFSET(recvn) margin_make_cmd(0x8B, 1, recvn)
+#define REPORT_VOL_OFFSET(recvn) margin_make_cmd(0x8C, 1, recvn)
+#define REPORT_SAMPL_RATE_V(recvn) margin_make_cmd(0x8D, 1, recvn)
+#define REPORT_SAMPL_RATE_T(recvn) margin_make_cmd(0x8E, 1, recvn)
+#define REPORT_SAMPLE_CNT(recvn) margin_make_cmd(0x8F, 1, recvn)
+#define REPORT_MAX_LANES(recvn) margin_make_cmd(0x90, 1, recvn)
+
+// set commands
+#define NO_COMMAND margin_make_cmd(0x9C, 7, 0)
+#define CLEAR_ERROR_LOG(recvn) margin_make_cmd(0x55, 2, recvn)
+#define GO_TO_NORMAL_SETTINGS(recvn) margin_make_cmd(0xF, 2, recvn)
+#define SET_ERROR_LIMIT(error_limit, recvn) margin_make_cmd(0xC0 | (error_limit), 2, recvn)
+
+static int msleep(long msec)
+{
+  struct timespec ts;
+  int res;
+
+  if (msec < 0)
+  {
+    errno = EINVAL;
+    return -1;
+  }
+
+  ts.tv_sec = msec / 1000;
+  ts.tv_nsec = (msec % 1000) * 1000000;
+
+  do
+  {
+    res = nanosleep(&ts, &ts);
+  } while (res && errno == EINTR);
+
+  return res;
+}
+
+union margin_cmd margin_make_cmd(uint8_t payload, uint8_t type, uint8_t recvn)
+{
+  return (union margin_cmd){.fields = {.payload.payload = payload, .recvn = recvn, 
+                                      .type = type, .reserved = 0}};
+}
+
+bool margin_read_params(struct margin_recv *recv)
+{
+  union margin_payload resp;
+  uint8_t lane = recv->lane_reversal ? recv->dev->width - 1 : 0;
+  margin_set_cmd(recv->dev, lane, NO_COMMAND);
+  bool status = margin_report_cmd(recv->dev, lane, REPORT_CAPS(recv->recvn), &resp);
+  if (status)
+  {
+    recv->volt_support = resp.caps.volt_support;
+    recv->ind_up_down_volt = resp.caps.ind_up_down_volt;
+    recv->ind_left_right_tim = resp.caps.ind_left_right_tim;
+    recv->sample_report_method = resp.caps.sample_report_method;
+    recv->ind_error_sampler = resp.caps.ind_error_sampler;
+    status = margin_report_cmd(recv->dev, lane, REPORT_VOL_STEPS(recv->recvn), &resp);
+  }
+  if (status)
+  {
+    recv->volt_steps = resp.voltage_steps;
+    status = margin_report_cmd(recv->dev, lane, REPORT_TIM_STEPS(recv->recvn), &resp);
+  }
+  if (status)
+  {
+    recv->timing_steps = resp.timing_steps;
+    status = margin_report_cmd(recv->dev, lane, REPORT_TIM_OFFSET(recv->recvn), &resp);
+  }
+  if (status)
+  {
+    recv->timing_offset = resp.offset;
+    status = margin_report_cmd(recv->dev, lane, REPORT_VOL_OFFSET(recv->recvn), &resp);
+  }
+  if (status)
+  {
+    recv->volt_offset = resp.offset;
+    status = margin_report_cmd(recv->dev, lane, REPORT_SAMPL_RATE_V(recv->recvn), &resp);
+  }
+  if (status)
+  {
+    recv->sample_rate_v = resp.sample_rate;
+    status = margin_report_cmd(recv->dev, lane, REPORT_SAMPL_RATE_T(recv->recvn), &resp);
+  }
+  if (status)
+  {
+    recv->sample_rate_t = resp.sample_rate;
+    status = margin_report_cmd(recv->dev, lane, REPORT_MAX_LANES(recv->recvn), &resp);
+  }
+  if (status)
+    recv->max_lanes = resp.max_lanes;
+  return status;
+}
+
+bool margin_report_cmd(struct margin_dev *dev, uint8_t lane, 
+                       union margin_cmd cmd, union margin_payload *result)
+{
+  pci_write_word(dev->dev, MARG_LANE_CTRL(dev->lmr_cap_addr, lane), cmd.cmd);
+  msleep(10);
+  union margin_cmd resp;
+  resp.cmd = pci_read_word(dev->dev, MARG_LANE_STATUS(dev->lmr_cap_addr, lane));
+  *result = resp.fields.payload;
+  return resp.fields.type == cmd.fields.type && resp.fields.recvn == cmd.fields.recvn 
+          && margin_set_cmd(dev, lane, NO_COMMAND);
+}
+
+bool margin_set_cmd(struct margin_dev *dev, uint8_t lane, union margin_cmd cmd)
+{
+  pci_write_word(dev->dev, MARG_LANE_CTRL(dev->lmr_cap_addr, lane), cmd.cmd);
+  msleep(10);
+  return pci_read_word(dev->dev, MARG_LANE_STATUS(dev->lmr_cap_addr, lane)) == cmd.cmd;
+}
+
+void margin_lanes(struct margin_lanes_data arg)
+{
+  uint8_t steps_done = 0;
+  union margin_cmd lane_status;
+  uint8_t marg_type;
+  union margin_cmd step_cmd;
+  bool timing = (arg.dir == TIM_LEFT || arg.dir == TIM_RIGHT);
+
+  if (timing)
+  {
+    marg_type = 3;
+    step_cmd = MARG_TIM(arg.dir == TIM_LEFT, steps_done, arg.recv->recvn);
+  }
+  else
+  {
+    marg_type = 4;
+    step_cmd = MARG_VOLT(arg.dir == VOLT_DOWN, steps_done, arg.recv->recvn);
+  }
+
+  bool failed_lanes[32] = {0};
+  uint8_t alive_lanes = arg.lanes_n;
+
+  for (uint8_t i = 0; i < arg.lanes_n; i++)
+  {
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, SET_ERROR_LIMIT(arg.recv->error_limit, arg.recv->recvn));
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+    arg.results[i].steps[arg.dir] = arg.steps_lane_total;
+    arg.results[i].statuses[arg.dir] = MARGIN_THR;
+  }
+
+  while (alive_lanes > 0 && steps_done < arg.steps_lane_total)
+  {
+    alive_lanes = 0;
+    steps_done++;
+    if (timing)
+      step_cmd.fields.payload.step_tim.steps = steps_done;
+    else
+      step_cmd.fields.payload.step_volt.steps = steps_done;
+
+    for (uint8_t i = 0; i < arg.lanes_n; i++)
+    {
+      if (!failed_lanes[i])
+      {
+        alive_lanes++;
+        int ctrl_addr = MARG_LANE_CTRL(arg.recv->dev->lmr_cap_addr, arg.results[i].lane);
+        pci_write_word(arg.recv->dev->dev, ctrl_addr, step_cmd.cmd);
+      }
+    }
+    msleep(MARGIN_STEP_MS);
+
+    for (uint8_t i = 0; i < arg.lanes_n; i++)
+    {
+      if (!failed_lanes[i])
+      {
+        int status_addr = MARG_LANE_STATUS(arg.recv->dev->lmr_cap_addr, arg.results[i].lane);
+        lane_status.cmd = pci_read_word(arg.recv->dev->dev, status_addr);
+        uint8_t step_status = lane_status.fields.payload.step_resp.status;
+        if (!(lane_status.fields.type == marg_type && lane_status.fields.recvn == arg.recv->recvn 
+            && step_status == 2 && lane_status.fields.payload.step_resp.err_count <= arg.recv->error_limit
+            && margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND))) 
+        {
+          alive_lanes--;
+          failed_lanes[i] = true;
+          arg.results[i].steps[arg.dir] = steps_done - 1;
+          arg.results[i].statuses[arg.dir] = (step_status == 3 || step_status == 1 ? MARGIN_NAK : MARGIN_LIM);
+        }
+      }
+    }
+
+    arg.steps_lane_done = steps_done;
+  }
+
+  for (uint8_t i = 0; i < arg.lanes_n; i++)
+  {
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, CLEAR_ERROR_LOG(arg.recv->recvn));
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, GO_TO_NORMAL_SETTINGS(arg.recv->recvn));
+    margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+  }
+}
+
+bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct margin_results *results)
+{
+  bool status = true;
+
+  uint8_t *lanes_to_margin = args->lanes;
+  uint8_t lanes_n = args->lanes_n;
+
+  results->recvn = recv->recvn;
+  recv->error_limit = args->error_limit;
+  recv->parallel_lanes = (args->parallel_lanes < 0 ? 1 : args->parallel_lanes);
+  results->lanes_n = lanes_n;
+
+  if (!margin_check_ready_bit(recv->dev->dev))
+  {
+    results->test_status = MARGIN_TEST_READY_BIT;
+    status = false;
+  }
+
+  if (status)
+  {
+    recv->lane_reversal = false;
+    if (!margin_read_params(recv))
+    {
+      recv->lane_reversal = true;
+      if (!margin_read_params(recv))
+      {
+        results->test_status = MARGIN_TEST_CAPS;
+        status = false;
+      }
+    }
+  }
+
+  if (status)
+  {
+    if (recv->parallel_lanes > recv->max_lanes + 1)
+      recv->parallel_lanes = recv->max_lanes + 1;
+
+    results->tim_coef = (double)recv->timing_offset / (double)recv->timing_steps;
+    results->volt_coef = (double)recv->volt_offset / (double)recv->volt_steps * 10.0;
+
+    results->ind_left_right_tim = recv->ind_left_right_tim;
+    results->volt_support = recv->volt_support;
+    results->ind_up_down_volt = recv->ind_up_down_volt;
+    results->lane_reversal = recv->lane_reversal;
+    results->link_speed = recv->dev->link_speed;
+    results->test_status = MARGIN_TEST_OK;
+
+    results->lanes = malloc(sizeof(struct margin_res_lane) * lanes_n);
+    for (uint8_t i = 0; i < lanes_n; i++)
+    {
+      results->lanes[i].lane = recv->lane_reversal ? recv->dev->width - lanes_to_margin[i] - 1 : lanes_to_margin[i];
+    }
+
+    if (args->run_margin)
+    {
+      struct margin_lanes_data margin_lanes_data = {.recv = recv,
+                                                    .verbosity = args->verbosity,
+                                                    .steps_margin_remaining = args->steps_margin_remaining};
+      enum margin_dir dir[] = {TIM_LEFT, TIM_RIGHT, VOLT_UP, VOLT_DOWN};
+
+      uint8_t lanes_done = 0;
+      uint8_t use_lanes = 0;
+      uint8_t steps_t = (args->steps_t < 0 ? recv->timing_steps : args->steps_t);
+      uint8_t steps_v = (args->steps_v < 0 ? recv->volt_steps : args->steps_v);
+      while (lanes_done != lanes_n)
+      {
+        use_lanes = (lanes_done + recv->parallel_lanes > lanes_n) ? lanes_n - lanes_done : recv->parallel_lanes;
+        margin_lanes_data.lanes_numbers = lanes_to_margin + lanes_done;
+        margin_lanes_data.lanes_n = use_lanes;
+        margin_lanes_data.results = results->lanes + lanes_done;
+
+        for (uint8_t i = 0; i < 4; i++)
+        {
+          bool timing = dir[i] == TIM_LEFT || dir[i] == TIM_RIGHT;
+          if (!timing && !recv->volt_support)
+            continue;
+          if (dir[i] == TIM_RIGHT && !recv->ind_left_right_tim)
+            continue;
+          if (dir[i] == VOLT_DOWN && !recv->ind_up_down_volt)
+            continue;
+
+          margin_lanes_data.ind = timing ? recv->ind_left_right_tim : recv->ind_up_down_volt;
+          margin_lanes_data.dir = dir[i];
+          margin_lanes_data.steps_lane_total = timing ? steps_t : steps_v;
+          if (*args->steps_margin_remaining >= margin_lanes_data.steps_lane_total)
+          {
+            *args->steps_margin_remaining -= margin_lanes_data.steps_lane_total;
+          }
+          else
+            *args->steps_margin_remaining = 0;
+          margin_lanes(margin_lanes_data);
+        }
+        lanes_done += use_lanes;
+      }
+      if (recv->lane_reversal)
+      {
+        for (uint8_t i = 0; i < lanes_n; i++)
+          results->lanes[i].lane = lanes_to_margin[i];
+      }
+    }
+  }
+
+  return status;
+}
+
+enum margin_test_status margin_process_args(struct margin_dev *dev, struct margin_args *args)
+{
+  uint8_t receivers_n = 2 + 2 * dev->retimers_n;
+
+  if (args->recvs_n <= 0)
+  {
+    for (uint8_t i = 1; i < receivers_n; i++)
+      args->recvs[i - 1] = i;
+    args->recvs[receivers_n - 1] = 6;
+    args->recvs_n = receivers_n;
+  }
+  else
+  {
+    for (uint8_t i = 0; i < args->recvs_n; i++)
+    {
+      uint8_t recvn = args->recvs[i];
+      if (recvn < 1 || recvn > 6 || (recvn != 6 && recvn > receivers_n - 1))
+      {
+        return MARGIN_TEST_ARGS_RECVS;
+      }
+    }
+  }
+
+  if (args->lanes_n <= 0)
+  {
+    args->lanes_n = dev->width;
+    for (uint8_t i = 0; i < args->lanes_n; i++)
+      args->lanes[i] = i;
+  }
+  else
+  {
+    for (uint8_t i = 0; i < args->lanes_n; i++)
+    {
+      if (args->lanes[i] >= dev->width)
+      {
+        return MARGIN_TEST_ARGS_LANES;
+      }
+    }
+  }
+
+  return MARGIN_TEST_OK;
+}
+
+struct margin_results *margin_link(struct margin_dev *down_port, struct margin_dev *up_port, 
+                                   struct margin_args *args, uint8_t *recvs_n)
+{
+  bool status = true;
+
+  status = margin_prep_dev(down_port);
+  if (status)
+    status = margin_prep_dev(up_port);
+
+  uint8_t receivers_n = status ? args->recvs_n : 1;
+  uint8_t *receivers = args->recvs;
+
+  struct margin_results *results = malloc(sizeof(*results) * receivers_n);
+  struct margin_recv receiver;
+
+  if (!status)
+  {
+    results[0].test_status = MARGIN_TEST_ASPM;
+  }
+
+  if (status)
+  {
+    for (uint8_t i = 0; i < receivers_n; i++)
+    {
+      receiver.dev = (receivers[i] == 6 ? up_port : down_port);
+      receiver.recvn = receivers[i];
+      margin_receiver(&receiver, args, &(results[i]));
+    }
+
+    margin_restore_dev(down_port);
+    margin_restore_dev(up_port);
+  }
+
+  *recvs_n = receivers_n;
+  return results;
+}
+
+void margin_free_results(struct margin_results *results, uint8_t results_n)
+{
+  for (uint8_t i = 0; i < results_n; i++)
+  {
+    if (results[i].test_status == MARGIN_TEST_OK)
+      free(results[i].lanes);
+  }
+  free(results);
+}
diff --git a/lmr_lib/margin.h b/lmr_lib/margin.h
new file mode 100644
index 0000000..bb57a76
--- /dev/null
+++ b/lmr_lib/margin.h
@@ -0,0 +1,197 @@
+#ifndef _MARGIN_H
+#define _MARGIN_H
+
+#include "margin_hw.h"
+
+#define MARGIN_STEP_MS 1000
+
+union margin_payload {
+  unsigned int payload : 8;
+
+  struct caps {
+    bool volt_support : 1;
+    bool ind_up_down_volt : 1;
+    bool ind_left_right_tim : 1;
+    bool sample_report_method : 1;
+    bool ind_error_sampler : 1;
+  } caps;
+
+  unsigned int timing_steps : 6;
+  unsigned int voltage_steps : 7;
+  unsigned int offset : 7;
+  unsigned int max_lanes : 5;
+  unsigned int sample_rate : 6;
+
+  struct step_resp {
+    unsigned int err_count : 6;
+    unsigned int status : 2;
+  } step_resp;
+
+  struct step_tim {
+    unsigned int steps : 6;
+    bool go_left : 1;
+  } step_tim;
+
+  struct step_volt {
+    unsigned int steps : 7;
+    bool go_down : 1;
+  } step_volt;
+
+} __attribute__((packed));
+
+union margin_cmd
+{
+  unsigned int cmd : 16;
+
+  struct fields {
+    unsigned int recvn : 3;
+    unsigned int type : 3;
+    unsigned int reserved : 2;
+    union margin_payload payload;
+  } fields;
+
+} __attribute__((packed));
+
+/*Receiver structure with Lane Margining capabilities fields*/
+struct margin_recv {
+  struct margin_dev *dev;
+  uint8_t recvn; /*Receiver Number*/
+  bool lane_reversal;
+
+  bool ind_error_sampler;
+  bool sample_report_method;
+  bool ind_left_right_tim;
+  bool ind_up_down_volt;
+  bool volt_support;
+
+  uint8_t max_lanes;
+  uint8_t parallel_lanes;
+
+  uint8_t timing_steps;
+  uint8_t timing_offset;
+
+  uint8_t volt_steps;
+  uint8_t volt_offset;
+
+  uint8_t error_limit;
+
+  uint8_t sample_rate_v;
+  uint8_t sample_rate_t;
+};
+
+/*Margining Fail reason*/
+enum margin_fail_status {
+  MARGIN_NAK = 0, /*NAK/Set up for margin*/
+  MARGIN_LIM,     /*Too many errors (device limit)*/
+  MARGIN_THR      /*Test threshold has been reached*/
+};
+
+enum margin_dir {
+  VOLT_UP = 0,
+  VOLT_DOWN,
+  TIM_LEFT,
+  TIM_RIGHT
+};
+
+/*Margining results of one lane of the receiver*/
+struct margin_res_lane {
+  uint8_t lane;
+
+  uint8_t steps[4];
+  enum margin_fail_status statuses[4];
+};
+
+enum margin_test_status {
+  MARGIN_TEST_OK = 0,
+  MARGIN_TEST_READY_BIT,
+  MARGIN_TEST_CAPS,
+
+  // Couldn't run test
+  MARGIN_TEST_PREREQS,
+  MARGIN_TEST_ARGS_LANES,
+  MARGIN_TEST_ARGS_RECVS,
+  MARGIN_TEST_ASPM
+};
+
+/*All lanes Receiver results*/
+struct margin_results {
+  uint8_t recvn; /*Receiver Number*/
+  bool ind_left_right_tim;
+  bool volt_support;
+  bool ind_up_down_volt;
+  bool lane_reversal;
+  uint8_t link_speed;
+
+  enum margin_test_status test_status;
+
+  /*Used to convert steps to physical quantity.
+  Calculated from MaxOffset and NumSteps*/
+  double tim_coef;
+  double volt_coef;
+
+  uint8_t lanes_n;
+  struct margin_res_lane *lanes;
+};
+
+/*pcilmr parameters*/
+struct margin_args {
+  int8_t steps_t;        // -1 == use NumTimingSteps
+  int8_t steps_v;        // -1 == use NumVoltageSteps
+  int8_t parallel_lanes; // [1; MaxLanes + 1]
+  uint8_t error_limit;   // [0; 63]
+  uint8_t recvs[6];      // Receivers Numbers
+  int8_t recvs_n;        // -1 == margin all available receivers
+  uint8_t lanes[32];
+  int8_t lanes_n; // -1 == margin all available lanes
+  bool run_margin;
+  uint8_t verbosity; // 0 - basic; 1 - add info about remaining time and lanes in progress during margining
+
+  uint64_t *steps_margin_remaining;
+};
+
+struct margin_lanes_data {
+  struct margin_recv *recv;
+
+  struct margin_res_lane *results;
+  uint8_t *lanes_numbers;
+  uint8_t lanes_n;
+
+  bool ind;
+  enum margin_dir dir;
+
+  uint8_t steps_lane_done;
+  uint8_t steps_lane_total;
+  uint64_t *steps_margin_remaining;
+
+  uint8_t verbosity;
+};
+
+union margin_cmd margin_make_cmd(uint8_t payload, uint8_t type, uint8_t recvn);
+
+/*Read Receiver Lane Margining capabilities.
+dev, recvn and lane_reversal fields must be initialized*/
+bool margin_read_params(struct margin_recv *recv);
+
+bool margin_report_cmd(struct margin_dev *dev, uint8_t lane, 
+                       union margin_cmd cmd, union margin_payload *result);
+
+bool margin_set_cmd(struct margin_dev *dev, uint8_t lane, union margin_cmd cmd);
+
+/*Uses Lane numbers from margin_res_lane structs.
+Margin all lanes_n lanes simultaneously*/
+void margin_lanes(struct margin_lanes_data arg);
+
+/*Awaits that Receiver is prepared through prep_dev function.
+recv fields dev and recvn must be initialized*/
+bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct margin_results *results);
+
+enum margin_test_status margin_process_args(struct margin_dev *dev, struct margin_args *args);
+
+/*Awaits that args are prepared through process_args.
+Returns number of margined Receivers through recvs_n*/
+struct margin_results *margin_link(struct margin_dev *down_port, struct margin_dev *up_port, 
+                                   struct margin_args *args, uint8_t *recvs_n);
+
+void margin_free_results(struct margin_results *results, uint8_t results_n);
+
+#endif
-- 
2.34.1


