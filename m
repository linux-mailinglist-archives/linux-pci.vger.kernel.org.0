Return-Path: <linux-pci+bounces-1421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8B081EDDD
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A861C223AE
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE7D286AC;
	Wed, 27 Dec 2023 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="uuTfaDlY";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="INQxQeuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7A428E2D
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 3C782C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670370; bh=944V6eKFcFh6oSxefV06MWTrb4ZVIRNgXCaMPIHHVPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=uuTfaDlY8Ink4o6KSTi08+1CqgAtp1PWNcznxObBq5Sp9ETvRXHgVClGqmLrkT+y4
	 0Kz1b5trtYjevy8sNzCpie8DYt5rLusNd27ho7f1ctLRsmIeBGvMzR5BMH6G49q8mg
	 FK4Tc6+xzkkBANCanMV1pMKC4zMOgWKaCMEreQuUEcfiscg1un5C8Ea8EopG3AptbL
	 sS4F3C4hXrG+X8EV5dm4zq5YzBlRm6VVmK7Acm6gBFkA0yWroB4oaP3884hOnTCG7L
	 eux32qdCqGnH6J8QTSlKQFYdf9qt875RDbKKwAN1ELh/EVFgO3hIvavGq22lqtH6Rw
	 pO+7k9Wlv2Duw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670370; bh=944V6eKFcFh6oSxefV06MWTrb4ZVIRNgXCaMPIHHVPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=INQxQeuElbJSVeMhlFkExCzHxgzmVSjB7mbZixTZWzlxQQPSXbt/UWOUhlvfEEwqU
	 BMQPF446rXbNKsnSczIqJZoRGNUaTaSEcDsVV4rin5dsLCk9oTOv7ZQjRRl6fYRI3Q
	 l3RhD3mJJhvm3c95bSKEsrICGPJso5LI7Ppib8zepgIIzhg+8j3VBD0PKQemMYyvZR
	 rw2LZJUuvCl3p5C2IGTqQeFOgpckyLbtYdGv1JhW0/Yaa6cPX4tgwHY8JOKp6ExS6a
	 odV2enExYzeTL5iLC/IhF6rcsyKfKyODCFpWo7RslvYr35hSgCaYgxHvJcV5koPe6R
	 SMiAxVhByMedA==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 06/15] pciutils-pcilmr: Add margining process functions
Date: Wed, 27 Dec 2023 14:44:55 +0500
Message-ID: <20231227094504.32257-7-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227094504.32257-1-n.proshkin@yadro.com>
References: <20231227094504.32257-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-09.corp.yadro.com (172.17.11.59) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)

* Implement the margining flow as described in the section "Example
  Software Flow for Lane Margining at Receiver"
  of the PCIe Base Spec Rev 5.0;
* Implement margining commands formation and response parsing according
  to the PCIe Base Spec Rev 5.0 table 4-26;
* Use Receiver margining parameters as described in the
  PCIe Base Spec Rev 5.0 table 8-11;
* Support lane reversal and simultaneous margining of several link lanes.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h    | 129 ++++++++++++
 lmr/margin.c | 539 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 668 insertions(+)
 create mode 100644 lmr/margin.c

diff --git a/lmr/lmr.h b/lmr/lmr.h
index 67fe0b0..fa627a3 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -15,6 +15,8 @@
 
 #include "pciutils.h"
 
+#define MARGIN_STEP_MS 1000
+
 /* PCI Device wrapper for margining functions */
 struct margin_dev {
   struct pci_dev *dev;
@@ -34,6 +36,118 @@ struct margin_link {
   struct margin_dev up_port;
 };
 
+/* Specification Revision 5.0 Table 8-11 */
+struct margin_params {
+  bool ind_error_sampler;
+  bool sample_report_method;
+  bool ind_left_right_tim;
+  bool ind_up_down_volt;
+  bool volt_support;
+
+  u8 max_lanes;
+
+  u8 timing_steps;
+  u8 timing_offset;
+
+  u8 volt_steps;
+  u8 volt_offset;
+
+  u8 sample_rate_v;
+  u8 sample_rate_t;
+};
+
+/* Step Margin Execution Status - Step command response */
+enum margin_step_exec_sts {
+  MARGIN_NAK = 0, // NAK/Set up for margin
+  MARGIN_LIM,     // Too many errors (device limit)
+  MARGIN_THR      // Test threshold has been reached
+};
+
+enum margin_dir { VOLT_UP = 0, VOLT_DOWN, TIM_LEFT, TIM_RIGHT };
+
+/* Margining results of one lane of the receiver */
+struct margin_res_lane {
+  u8 lane;
+  u8 steps[4];
+  enum margin_step_exec_sts statuses[4];
+};
+
+/* Reason not to run margining test on the Link/Receiver */
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
+/* All lanes Receiver results */
+struct margin_results {
+  u8 recvn; // Receiver Number
+  struct margin_params params;
+  bool lane_reversal;
+  u8 link_speed;
+
+  enum margin_test_status test_status;
+
+  /* Used to convert steps to physical quantity.
+     Calculated from MaxOffset and NumSteps     */
+  double tim_coef;
+  double volt_coef;
+
+  u8 lanes_n;
+  struct margin_res_lane *lanes;
+};
+
+/* pcilmr arguments */
+struct margin_args {
+  u8 steps_t;        // 0 == use NumTimingSteps
+  u8 steps_v;        // 0 == use NumVoltageSteps
+  u8 parallel_lanes; // [1; MaxLanes + 1]
+  u8 error_limit;    // [0; 63]
+  u8 recvs[6];       // Receivers Numbers
+  u8 recvs_n;        // 0 == margin all available receivers
+  u8 lanes[32];      // Lanes to Margin
+  u8 lanes_n;        // 0 == margin all available lanes
+  bool run_margin;   // Or print params only
+  u8 verbosity;      // 0 - basic;
+                     // 1 - add info about remaining time and lanes in progress during margining
+
+  u64 *steps_utility; // For ETA logging
+};
+
+/* Receiver structure */
+struct margin_recv {
+  struct margin_dev *dev;
+  u8 recvn; // Receiver Number
+  bool lane_reversal;
+  struct margin_params *params;
+
+  u8 parallel_lanes;
+  u8 error_limit;
+};
+
+struct margin_lanes_data {
+  struct margin_recv *recv;
+
+  struct margin_res_lane *results;
+  u8 *lanes_numbers;
+  u8 lanes_n;
+
+  bool ind;
+  enum margin_dir dir;
+
+  u8 steps_lane_done;
+  u8 steps_lane_total;
+  u64 *steps_utility;
+
+  u8 verbosity;
+};
+
 /* margin_hw */
 
 /* Verify that devices form the link with 16 GT/s or 32 GT/s data rate */
@@ -52,4 +166,19 @@ bool margin_prep_link(struct margin_link *link);
 /* Restore ASPM, Hardware Autonomous Speed/Width settings */
 void margin_restore_link(struct margin_link *link);
 
+/* margin */
+
+/* Fill margin_params without calling other functions */
+bool margin_read_params(struct pci_access *pacc, struct pci_dev *dev, u8 recvn,
+                        struct margin_params *params);
+
+enum margin_test_status margin_process_args(struct margin_dev *dev, struct margin_args *args);
+
+/* Awaits that args are prepared through process_args.
+   Returns number of margined Receivers through recvs_n */
+struct margin_results *margin_test_link(struct margin_link *link, struct margin_args *args,
+                                        u8 *recvs_n);
+
+void margin_free_results(struct margin_results *results, u8 results_n);
+
 #endif
diff --git a/lmr/margin.c b/lmr/margin.c
new file mode 100644
index 0000000..57bef88
--- /dev/null
+++ b/lmr/margin.c
@@ -0,0 +1,539 @@
+/*
+ *	The PCI Utilities -- Obtain the margin information of the Link
+ *
+ *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL v2+.
+ *
+ *	SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <errno.h>
+#include <malloc.h>
+#include <time.h>
+
+#include "lmr.h"
+
+/* Macro helpers for Margining command parsing */
+
+typedef u16 margin_cmd;
+
+/* Margining command parsing */
+
+#define LMR_CMD_RECVN   MASK(2, 0)
+#define LMR_CMD_TYPE    MASK(5, 3)
+#define LMR_CMD_PAYLOAD MASK(15, 8)
+
+// Payload parsing
+
+// Report Capabilities
+#define LMR_PLD_VOLT_SUPPORT         BIT(8)
+#define LMR_PLD_IND_U_D_VOLT         BIT(9)
+#define LMR_PLD_IND_L_R_TIM          BIT(10)
+#define LMR_PLD_SAMPLE_REPORT_METHOD BIT(11)
+#define LMR_PLD_IND_ERR_SAMPLER      BIT(12)
+
+#define LMR_PLD_MAX_T_STEPS MASK(13, 8)
+#define LMR_PLD_MAX_V_STEPS MASK(14, 8)
+#define LMR_PLD_MAX_OFFSET  MASK(14, 8)
+#define LMR_PLD_MAX_LANES   MASK(12, 8)
+#define LMR_PLD_SAMPLE_RATE MASK(13, 8)
+
+// Timing Step
+#define LMR_PLD_MARGIN_T_STEPS MASK(13, 8)
+#define LMR_PLD_T_GO_LEFT      BIT(14)
+
+// Voltage Timing
+#define LMR_PLD_MARGIN_V_STEPS MASK(14, 8)
+#define LMR_PLD_V_GO_DOWN      BIT(15)
+
+// Step Response
+#define LMR_PLD_ERR_CNT    MASK(13, 8)
+#define LMR_PLD_MARGIN_STS MASK(15, 14)
+
+/* Address calc macro for Lanes Margining registers */
+
+#define LMR_LANE_CTRL(lmr_cap_addr, lane)   ((lmr_cap_addr) + 8 + 4 * (lane))
+#define LMR_LANE_STATUS(lmr_cap_addr, lane) ((lmr_cap_addr) + 10 + 4 * (lane))
+
+/* Margining Commands */
+
+#define MARG_TIM(go_left, step, recvn)  margin_make_cmd(((go_left) << 6) | (step), 3, recvn)
+#define MARG_VOLT(go_down, step, recvn) margin_make_cmd(((go_down) << 7) | (step), 4, recvn)
+
+// Report commands
+#define REPORT_CAPS(recvn)         margin_make_cmd(0x88, 1, recvn)
+#define REPORT_VOL_STEPS(recvn)    margin_make_cmd(0x89, 1, recvn)
+#define REPORT_TIM_STEPS(recvn)    margin_make_cmd(0x8A, 1, recvn)
+#define REPORT_TIM_OFFSET(recvn)   margin_make_cmd(0x8B, 1, recvn)
+#define REPORT_VOL_OFFSET(recvn)   margin_make_cmd(0x8C, 1, recvn)
+#define REPORT_SAMPL_RATE_V(recvn) margin_make_cmd(0x8D, 1, recvn)
+#define REPORT_SAMPL_RATE_T(recvn) margin_make_cmd(0x8E, 1, recvn)
+#define REPORT_SAMPLE_CNT(recvn)   margin_make_cmd(0x8F, 1, recvn)
+#define REPORT_MAX_LANES(recvn)    margin_make_cmd(0x90, 1, recvn)
+
+// Set commands
+#define NO_COMMAND                          margin_make_cmd(0x9C, 7, 0)
+#define CLEAR_ERROR_LOG(recvn)              margin_make_cmd(0x55, 2, recvn)
+#define GO_TO_NORMAL_SETTINGS(recvn)        margin_make_cmd(0xF, 2, recvn)
+#define SET_ERROR_LIMIT(error_limit, recvn) margin_make_cmd(0xC0 | (error_limit), 2, recvn)
+
+static int
+msleep(long msec)
+{
+  struct timespec ts;
+  int res;
+
+  if (msec < 0)
+    {
+      errno = EINVAL;
+      return -1;
+    }
+
+  ts.tv_sec = msec / 1000;
+  ts.tv_nsec = (msec % 1000) * 1000000;
+
+  do
+    {
+      res = nanosleep(&ts, &ts);
+  } while (res && errno == EINTR);
+
+  return res;
+}
+
+static margin_cmd
+margin_make_cmd(u8 payload, u8 type, u8 recvn)
+{
+  return SET_REG_MASK(0, LMR_CMD_PAYLOAD, payload) | SET_REG_MASK(0, LMR_CMD_TYPE, type)
+         | SET_REG_MASK(0, LMR_CMD_RECVN, recvn);
+}
+
+static bool
+margin_set_cmd(struct margin_dev *dev, u8 lane, margin_cmd cmd)
+{
+  pci_write_word(dev->dev, LMR_LANE_CTRL(dev->lmr_cap_addr, lane), cmd);
+  msleep(10);
+  return pci_read_word(dev->dev, LMR_LANE_STATUS(dev->lmr_cap_addr, lane)) == cmd;
+}
+
+static bool
+margin_report_cmd(struct margin_dev *dev, u8 lane, margin_cmd cmd, margin_cmd *result)
+{
+  pci_write_word(dev->dev, LMR_LANE_CTRL(dev->lmr_cap_addr, lane), cmd);
+  msleep(10);
+  *result = pci_read_word(dev->dev, LMR_LANE_STATUS(dev->lmr_cap_addr, lane));
+  return GET_REG_MASK(*result, LMR_CMD_TYPE) == GET_REG_MASK(cmd, LMR_CMD_TYPE)
+         && GET_REG_MASK(*result, LMR_CMD_RECVN) == GET_REG_MASK(cmd, LMR_CMD_RECVN)
+         && margin_set_cmd(dev, lane, NO_COMMAND);
+}
+
+static bool
+read_params_internal(struct margin_dev *dev, u8 recvn, bool lane_reversal,
+                     struct margin_params *params)
+{
+  margin_cmd resp;
+  u8 lane = lane_reversal ? dev->width - 1 : 0;
+  margin_set_cmd(dev, lane, NO_COMMAND);
+  bool status = margin_report_cmd(dev, lane, REPORT_CAPS(recvn), &resp);
+  if (status)
+    {
+      params->volt_support = GET_REG_MASK(resp, LMR_PLD_VOLT_SUPPORT);
+      params->ind_up_down_volt = GET_REG_MASK(resp, LMR_PLD_IND_U_D_VOLT);
+      params->ind_left_right_tim = GET_REG_MASK(resp, LMR_PLD_IND_L_R_TIM);
+      params->sample_report_method = GET_REG_MASK(resp, LMR_PLD_SAMPLE_REPORT_METHOD);
+      params->ind_error_sampler = GET_REG_MASK(resp, LMR_PLD_IND_ERR_SAMPLER);
+      status = margin_report_cmd(dev, lane, REPORT_VOL_STEPS(recvn), &resp);
+    }
+  if (status)
+    {
+      params->volt_steps = GET_REG_MASK(resp, LMR_PLD_MAX_V_STEPS);
+      status = margin_report_cmd(dev, lane, REPORT_TIM_STEPS(recvn), &resp);
+    }
+  if (status)
+    {
+      params->timing_steps = GET_REG_MASK(resp, LMR_PLD_MAX_T_STEPS);
+      status = margin_report_cmd(dev, lane, REPORT_TIM_OFFSET(recvn), &resp);
+    }
+  if (status)
+    {
+      params->timing_offset = GET_REG_MASK(resp, LMR_PLD_MAX_OFFSET);
+      status = margin_report_cmd(dev, lane, REPORT_VOL_OFFSET(recvn), &resp);
+    }
+  if (status)
+    {
+      params->volt_offset = GET_REG_MASK(resp, LMR_PLD_MAX_OFFSET);
+      status = margin_report_cmd(dev, lane, REPORT_SAMPL_RATE_V(recvn), &resp);
+    }
+  if (status)
+    {
+      params->sample_rate_v = GET_REG_MASK(resp, LMR_PLD_SAMPLE_RATE);
+      status = margin_report_cmd(dev, lane, REPORT_SAMPL_RATE_T(recvn), &resp);
+    }
+  if (status)
+    {
+      params->sample_rate_t = GET_REG_MASK(resp, LMR_PLD_SAMPLE_RATE);
+      status = margin_report_cmd(dev, lane, REPORT_MAX_LANES(recvn), &resp);
+    }
+  if (status)
+    params->max_lanes = GET_REG_MASK(resp, LMR_PLD_MAX_LANES);
+  return status;
+}
+
+/* Margin all lanes_n lanes simultaneously */
+static void
+margin_test_lanes(struct margin_lanes_data arg)
+{
+  u8 steps_done = 0;
+  margin_cmd lane_status;
+  u8 marg_type;
+  margin_cmd step_cmd;
+  bool timing = (arg.dir == TIM_LEFT || arg.dir == TIM_RIGHT);
+
+  if (timing)
+    {
+      marg_type = 3;
+      step_cmd = MARG_TIM(arg.dir == TIM_LEFT, steps_done, arg.recv->recvn);
+    }
+  else
+    {
+      marg_type = 4;
+      step_cmd = MARG_VOLT(arg.dir == VOLT_DOWN, steps_done, arg.recv->recvn);
+    }
+
+  bool failed_lanes[32] = { 0 };
+  u8 alive_lanes = arg.lanes_n;
+
+  for (int i = 0; i < arg.lanes_n; i++)
+    {
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane,
+                     SET_ERROR_LIMIT(arg.recv->error_limit, arg.recv->recvn));
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+      arg.results[i].steps[arg.dir] = arg.steps_lane_total;
+      arg.results[i].statuses[arg.dir] = MARGIN_THR;
+    }
+
+  while (alive_lanes > 0 && steps_done < arg.steps_lane_total)
+    {
+      alive_lanes = 0;
+      steps_done++;
+      if (timing)
+        step_cmd = SET_REG_MASK(step_cmd, LMR_PLD_MARGIN_T_STEPS, steps_done);
+      else
+        step_cmd = SET_REG_MASK(step_cmd, LMR_PLD_MARGIN_V_STEPS, steps_done);
+
+      for (int i = 0; i < arg.lanes_n; i++)
+        {
+          if (!failed_lanes[i])
+            {
+              alive_lanes++;
+              int ctrl_addr = LMR_LANE_CTRL(arg.recv->dev->lmr_cap_addr, arg.results[i].lane);
+              pci_write_word(arg.recv->dev->dev, ctrl_addr, step_cmd);
+            }
+        }
+      msleep(MARGIN_STEP_MS);
+
+      for (int i = 0; i < arg.lanes_n; i++)
+        {
+          if (!failed_lanes[i])
+            {
+              int status_addr = LMR_LANE_STATUS(arg.recv->dev->lmr_cap_addr, arg.results[i].lane);
+              lane_status = pci_read_word(arg.recv->dev->dev, status_addr);
+              u8 step_status = GET_REG_MASK(lane_status, LMR_PLD_MARGIN_STS);
+              if (!(GET_REG_MASK(lane_status, LMR_CMD_TYPE) == marg_type
+                    && GET_REG_MASK(lane_status, LMR_CMD_RECVN) == arg.recv->recvn
+                    && step_status == 2
+                    && GET_REG_MASK(lane_status, LMR_PLD_ERR_CNT) <= arg.recv->error_limit
+                    && margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND)))
+                {
+                  alive_lanes--;
+                  failed_lanes[i] = true;
+                  arg.results[i].steps[arg.dir] = steps_done - 1;
+                  arg.results[i].statuses[arg.dir]
+                    = (step_status == 3 || step_status == 1 ? MARGIN_NAK : MARGIN_LIM);
+                }
+            }
+        }
+
+      arg.steps_lane_done = steps_done;
+    }
+
+  for (int i = 0; i < arg.lanes_n; i++)
+    {
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane, CLEAR_ERROR_LOG(arg.recv->recvn));
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane, GO_TO_NORMAL_SETTINGS(arg.recv->recvn));
+      margin_set_cmd(arg.recv->dev, arg.results[i].lane, NO_COMMAND);
+    }
+}
+
+/* Awaits that Receiver is prepared through prep_dev function */
+static bool
+margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
+                     struct margin_results *results)
+{
+  u8 *lanes_to_margin = args->lanes;
+  u8 lanes_n = args->lanes_n;
+
+  struct margin_params params;
+  struct margin_recv recv = { .dev = dev,
+                              .recvn = recvn,
+                              .lane_reversal = false,
+                              .params = &params,
+                              .parallel_lanes = args->parallel_lanes ? args->parallel_lanes : 1,
+                              .error_limit = args->error_limit };
+
+  results->recvn = recvn;
+  results->lanes_n = lanes_n;
+
+  if (!margin_check_ready_bit(dev->dev))
+    {
+      results->test_status = MARGIN_TEST_READY_BIT;
+      return false;
+    }
+
+  if (!read_params_internal(dev, recvn, recv.lane_reversal, &params))
+    {
+      recv.lane_reversal = true;
+      if (!read_params_internal(dev, recvn, recv.lane_reversal, &params))
+        {
+          results->test_status = MARGIN_TEST_CAPS;
+          return false;
+        }
+    }
+
+  results->params = params;
+
+  if (recv.parallel_lanes > params.max_lanes + 1)
+    recv.parallel_lanes = params.max_lanes + 1;
+
+  results->tim_coef = (double)params.timing_offset / (double)params.timing_steps;
+  results->volt_coef = (double)params.volt_offset / (double)params.volt_steps * 10.0;
+
+  results->lane_reversal = recv.lane_reversal;
+  results->link_speed = dev->link_speed;
+  results->test_status = MARGIN_TEST_OK;
+
+  results->lanes = xmalloc(sizeof(struct margin_res_lane) * lanes_n);
+  for (int i = 0; i < lanes_n; i++)
+    {
+      results->lanes[i].lane
+        = recv.lane_reversal ? dev->width - lanes_to_margin[i] - 1 : lanes_to_margin[i];
+    }
+
+  if (args->run_margin)
+    {
+      struct margin_lanes_data lanes_data
+        = { .recv = &recv, .verbosity = args->verbosity, .steps_utility = args->steps_utility };
+
+      enum margin_dir dir[] = { TIM_LEFT, TIM_RIGHT, VOLT_UP, VOLT_DOWN };
+
+      u8 lanes_done = 0;
+      u8 use_lanes = 0;
+      u8 steps_t = args->steps_t ? args->steps_t : params.timing_steps;
+      u8 steps_v = args->steps_v ? args->steps_v : params.volt_steps;
+
+      while (lanes_done != lanes_n)
+        {
+          use_lanes = (lanes_done + recv.parallel_lanes > lanes_n) ? lanes_n - lanes_done :
+                                                                     recv.parallel_lanes;
+          lanes_data.lanes_numbers = lanes_to_margin + lanes_done;
+          lanes_data.lanes_n = use_lanes;
+          lanes_data.results = results->lanes + lanes_done;
+
+          for (int i = 0; i < 4; i++)
+            {
+              bool timing = dir[i] == TIM_LEFT || dir[i] == TIM_RIGHT;
+              if (!timing && !params.volt_support)
+                continue;
+              if (dir[i] == TIM_RIGHT && !params.ind_left_right_tim)
+                continue;
+              if (dir[i] == VOLT_DOWN && !params.ind_up_down_volt)
+                continue;
+
+              lanes_data.ind = timing ? params.ind_left_right_tim : params.ind_up_down_volt;
+              lanes_data.dir = dir[i];
+              lanes_data.steps_lane_total = timing ? steps_t : steps_v;
+              if (*args->steps_utility >= lanes_data.steps_lane_total)
+                *args->steps_utility -= lanes_data.steps_lane_total;
+              else
+                *args->steps_utility = 0;
+              margin_test_lanes(lanes_data);
+            }
+          lanes_done += use_lanes;
+        }
+      if (recv.lane_reversal)
+        {
+          for (int i = 0; i < lanes_n; i++)
+            results->lanes[i].lane = lanes_to_margin[i];
+        }
+    }
+
+  return true;
+}
+
+bool
+margin_read_params(struct pci_access *pacc, struct pci_dev *dev, u8 recvn,
+                   struct margin_params *params)
+{
+  struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+  if (!cap)
+    return false;
+  u8 dev_dir = GET_REG_MASK(pci_read_word(dev, cap->addr + PCI_EXP_FLAGS), PCI_EXP_FLAGS_TYPE);
+
+  bool dev_down;
+  if (dev_dir == PCI_EXP_TYPE_ROOT_PORT || dev_dir == PCI_EXP_TYPE_DOWNSTREAM)
+    dev_down = true;
+  else
+    dev_down = false;
+
+  if (recvn == 0)
+    {
+      if (dev_down)
+        recvn = 1;
+      else
+        recvn = 6;
+    }
+
+  if (recvn > 6)
+    return false;
+  if (dev_down && recvn == 6)
+    return false;
+  if (!dev_down && recvn != 6)
+    return false;
+
+  struct pci_dev *down = NULL;
+  struct pci_dev *up = NULL;
+  struct margin_link link;
+
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
+    {
+      if (dev_down && pci_read_byte(dev, PCI_SECONDARY_BUS) == p->bus && dev->domain == p->domain
+          && p->func == 0)
+        {
+          down = dev;
+          up = p;
+          break;
+        }
+      else if (!dev_down && pci_read_byte(p, PCI_SECONDARY_BUS) == dev->bus
+               && dev->domain == p->domain)
+        {
+          down = p;
+          up = dev;
+          break;
+        }
+    }
+
+  if (!down)
+    return false;
+
+  if (!margin_fill_link(down, up, &link))
+    return false;
+
+  struct margin_dev *dut = (dev_down ? &link.down_port : &link.up_port);
+  if (!margin_check_ready_bit(dut->dev))
+    return false;
+
+  if (!margin_prep_link(&link))
+    return false;
+
+  bool status;
+  bool lane_reversal = false;
+  status = read_params_internal(dut, recvn, lane_reversal, params);
+  if (!status)
+    {
+      lane_reversal = true;
+      status = read_params_internal(dut, recvn, lane_reversal, params);
+    }
+
+  margin_restore_link(&link);
+
+  return status;
+}
+
+enum margin_test_status
+margin_process_args(struct margin_dev *dev, struct margin_args *args)
+{
+  u8 receivers_n = 2 + 2 * dev->retimers_n;
+
+  if (!args->recvs_n)
+    {
+      for (int i = 1; i < receivers_n; i++)
+        args->recvs[i - 1] = i;
+      args->recvs[receivers_n - 1] = 6;
+      args->recvs_n = receivers_n;
+    }
+  else
+    {
+      for (int i = 0; i < args->recvs_n; i++)
+        {
+          u8 recvn = args->recvs[i];
+          if (recvn < 1 || recvn > 6 || (recvn != 6 && recvn > receivers_n - 1))
+            {
+              return MARGIN_TEST_ARGS_RECVS;
+            }
+        }
+    }
+
+  if (!args->lanes_n)
+    {
+      args->lanes_n = dev->width;
+      for (int i = 0; i < args->lanes_n; i++)
+        args->lanes[i] = i;
+    }
+  else
+    {
+      for (int i = 0; i < args->lanes_n; i++)
+        {
+          if (args->lanes[i] >= dev->width)
+            {
+              return MARGIN_TEST_ARGS_LANES;
+            }
+        }
+    }
+
+  return MARGIN_TEST_OK;
+}
+
+struct margin_results *
+margin_test_link(struct margin_link *link, struct margin_args *args, u8 *recvs_n)
+{
+  bool status = margin_prep_link(link);
+
+  u8 receivers_n = status ? args->recvs_n : 1;
+  u8 *receivers = args->recvs;
+
+  struct margin_results *results = xmalloc(sizeof(*results) * receivers_n);
+
+  if (!status)
+    {
+      results[0].test_status = MARGIN_TEST_ASPM;
+    }
+
+  if (status)
+    {
+      struct margin_dev *dut;
+      for (int i = 0; i < receivers_n; i++)
+        {
+          dut = receivers[i] == 6 ? &link->up_port : &link->down_port;
+          margin_test_receiver(dut, receivers[i], args, &results[i]);
+        }
+
+      margin_restore_link(link);
+    }
+
+  *recvs_n = receivers_n;
+  return results;
+}
+
+void
+margin_free_results(struct margin_results *results, u8 results_n)
+{
+  for (int i = 0; i < results_n; i++)
+    {
+      if (results[i].test_status == MARGIN_TEST_OK)
+        free(results[i].lanes);
+    }
+  free(results);
+}
-- 
2.34.1


