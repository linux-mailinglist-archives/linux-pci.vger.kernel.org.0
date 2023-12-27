Return-Path: <linux-pci+bounces-1422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E455D81EDDF
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9C31F21673
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E51928E10;
	Wed, 27 Dec 2023 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ykcyHotF";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="jfJC+cj3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1444A2869B
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com A6A48C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670371; bh=Ax3NW0xu1vCClYRutt/b2zIyVE//qDwQnJ9GXTEPJXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ykcyHotFy/RtHGZjBV3MzQmfVzXW3dN0PIb9cAcP47Noe430zood+NPKf5/rU26qy
	 NT37/fyGrwjW+SUWUpvFcIXx9pr9M+x+svJHl6rI86+T6r3mE5wlrA+eoMjAF56OrT
	 YQ1c/uxN9cJbKIkQR87rga9df85RRmydrkV87np8pcWE1nheUr8GggXoMROOAPD1lN
	 05p9qeOvANEVtsqAfOXOcSuvtaph6/0vhatqSTeuSFy6IVgeIrXut+VEudOSLfDBR8
	 GYo0LDCjRkqgaaXqfAoZT67gj/lgQQXq+KpYQPU7eYGPoIeotYyk6wD5VLowpBMhx9
	 KX1mcofZaLTDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670371; bh=Ax3NW0xu1vCClYRutt/b2zIyVE//qDwQnJ9GXTEPJXk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=jfJC+cj3UWc5XuRvqHh20ekCV5Sxbf8ZSTUF3enZjLnflwp0GECnvL2BQZNE8HBiJ
	 VMSZrJojgSHYgUfrhYNah8nfMeoyXI1bB5IHY1YpqXCyekuweundfEMrd4LlaCTZsB
	 171PiV6z4bHUhXsKAcvGbnY2W/mDcu7XhfpGmf4NCxVOBL10f7NWZ3gMBvpVJXKv9/
	 vxfqAcNtkXCgE4gt35kaosB6u0xpZY+fs29nOQaJaj1bHsyLUEzAyLeJHfAYMaDXeS
	 NHVjdJ1tsjKL3bwIha+Ttns0cuRG3fyIx5NWPaXjMI+zhKkYLInTg4HAHV8SFSU8l9
	 xcNSO0d3h3vAg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 07/15] pciutils-pcilmr: Add logging functions for margining
Date: Wed, 27 Dec 2023 14:44:56 +0500
Message-ID: <20231227094504.32257-8-n.proshkin@yadro.com>
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

* Implement option to turn on/off logging for margining;
* Support systems with several PCI domains;
* margin_log_margining function prints margining in progress log using
  one line messages for each Receiver in the form:
  "Margining - <direction> - Lanes [<current simultaneous lanes>] - ETA:
  <current direction-lanes margining remaining time> Steps: <current
  margining steps done> Total ETA: <utility run total remaining time>".

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h        |  24 +++++++++
 lmr/margin.c     |  13 +++++
 lmr/margin_log.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 lmr/margin_log.c

diff --git a/lmr/lmr.h b/lmr/lmr.h
index fa627a3..c3a5039 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -181,4 +181,28 @@ struct margin_results *margin_test_link(struct margin_link *link, struct margin_
 
 void margin_free_results(struct margin_results *results, u8 results_n);
 
+/* margin_log */
+
+extern bool margin_global_logging;
+extern bool margin_print_domain;
+
+void margin_log(char *format, ...);
+
+/* b:d.f -> b:d.f */
+void margin_log_bdfs(struct pci_dev *down_port, struct pci_dev *up_port);
+
+/* Print Link header (bdfs, width, speed) */
+void margin_log_link(struct margin_link *link);
+
+void margin_log_params(struct margin_params *params);
+
+/* Print receiver number */
+void margin_log_recvn(struct margin_recv *recv);
+
+/* Print full info from Receiver struct */
+void margin_log_receiver(struct margin_recv *recv);
+
+/* Margining in progress log */
+void margin_log_margining(struct margin_lanes_data arg);
+
 #endif
diff --git a/lmr/margin.c b/lmr/margin.c
index 57bef88..1f1fa2f 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -256,6 +256,7 @@ margin_test_lanes(struct margin_lanes_data arg)
         }
 
       arg.steps_lane_done = steps_done;
+      margin_log_margining(arg);
     }
 
   for (int i = 0; i < arg.lanes_n; i++)
@@ -286,9 +287,11 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
 
   results->recvn = recvn;
   results->lanes_n = lanes_n;
+  margin_log_recvn(&recv);
 
   if (!margin_check_ready_bit(dev->dev))
     {
+      margin_log("\nMargining Ready bit is Clear.\n");
       results->test_status = MARGIN_TEST_READY_BIT;
       return false;
     }
@@ -298,6 +301,7 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
       recv.lane_reversal = true;
       if (!read_params_internal(dev, recvn, recv.lane_reversal, &params))
         {
+          margin_log("\nError during caps reading.\n");
           results->test_status = MARGIN_TEST_CAPS;
           return false;
         }
@@ -315,6 +319,8 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
   results->link_speed = dev->link_speed;
   results->test_status = MARGIN_TEST_OK;
 
+  margin_log_receiver(&recv);
+
   results->lanes = xmalloc(sizeof(struct margin_res_lane) * lanes_n);
   for (int i = 0; i < lanes_n; i++)
     {
@@ -324,6 +330,8 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
 
   if (args->run_margin)
     {
+      if (args->verbosity > 0)
+        margin_log("\n");
       struct margin_lanes_data lanes_data
         = { .recv = &recv, .verbosity = args->verbosity, .steps_utility = args->steps_utility };
 
@@ -363,6 +371,8 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
             }
           lanes_done += use_lanes;
         }
+      if (args->verbosity > 0)
+        margin_log("\n");
       if (recv.lane_reversal)
         {
           for (int i = 0; i < lanes_n; i++)
@@ -504,11 +514,14 @@ margin_test_link(struct margin_link *link, struct margin_args *args, u8 *recvs_n
   u8 receivers_n = status ? args->recvs_n : 1;
   u8 *receivers = args->recvs;
 
+  margin_log_link(link);
+
   struct margin_results *results = xmalloc(sizeof(*results) * receivers_n);
 
   if (!status)
     {
       results[0].test_status = MARGIN_TEST_ASPM;
+      margin_log("\nCouldn't disable ASPM on the given Link.\n");
     }
 
   if (status)
diff --git a/lmr/margin_log.c b/lmr/margin_log.c
new file mode 100644
index 0000000..6833d1a
--- /dev/null
+++ b/lmr/margin_log.c
@@ -0,0 +1,135 @@
+/*
+ *	The PCI Utilities -- Log margining process
+ *
+ *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL v2+.
+ *
+ *	SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdarg.h>
+#include <stdio.h>
+
+#include "lmr.h"
+
+bool margin_global_logging = false;
+bool margin_print_domain = true;
+
+void
+margin_log(char *format, ...)
+{
+  va_list arg;
+  va_start(arg, format);
+  if (margin_global_logging)
+    vprintf(format, arg);
+  va_end(arg);
+}
+
+void
+margin_log_bdfs(struct pci_dev *down, struct pci_dev *up)
+{
+  if (margin_print_domain)
+    margin_log("%x:%x:%x.%x -> %x:%x:%x.%x", down->domain, down->bus, down->dev, down->func,
+               up->domain, up->bus, up->dev, up->func);
+  else
+    margin_log("%x:%x.%x -> %x:%x.%x", down->bus, down->dev, down->func, up->bus, up->dev,
+               up->func);
+}
+
+void
+margin_log_link(struct margin_link *link)
+{
+  margin_log("Link ");
+  margin_log_bdfs(link->down_port.dev, link->up_port.dev);
+  margin_log("\nNegotiated Link Width: %d\n", link->down_port.width);
+  margin_log("Link Speed: %d.0 GT/s = Gen %d\n", (link->down_port.link_speed - 3) * 16,
+             link->down_port.link_speed);
+  margin_log("Available receivers: ");
+  int receivers_n = 2 + 2 * link->down_port.retimers_n;
+  for (int i = 1; i < receivers_n; i++)
+    margin_log("Rx(%X) - %d, ", 10 + i - 1, i);
+  margin_log("Rx(F) - 6\n");
+}
+
+void
+margin_log_params(struct margin_params *params)
+{
+  margin_log("Independent Error Sampler: %d\n", params->ind_error_sampler);
+  margin_log("Sample Reporting Method: %d\n", params->sample_report_method);
+  margin_log("Independent Left and Right Timing Margining: %d\n", params->ind_left_right_tim);
+  margin_log("Voltage Margining Supported: %d\n", params->volt_support);
+  margin_log("Independent Up and Down Voltage Margining: %d\n", params->ind_up_down_volt);
+  margin_log("Number of Timing Steps: %d\n", params->timing_steps);
+  margin_log("Number of Voltage Steps: %d\n", params->volt_steps);
+  margin_log("Max Timing Offset: %d\n", params->timing_offset);
+  margin_log("Max Voltage Offset: %d\n", params->volt_offset);
+  margin_log("Max Lanes: %d\n", params->max_lanes);
+}
+
+void
+margin_log_recvn(struct margin_recv *recv)
+{
+  margin_log("\nReceiver = Rx(%X)\n", 10 + recv->recvn - 1);
+}
+
+void
+margin_log_receiver(struct margin_recv *recv)
+{
+  margin_log("\nError Count Limit = %d\n", recv->error_limit);
+  margin_log("Parallel Lanes: %d\n\n", recv->parallel_lanes);
+
+  margin_log_params(recv->params);
+
+  if (recv->lane_reversal)
+    {
+      margin_log("\nWarning: device uses Lane Reversal.\n");
+      margin_log("However, utility uses logical lane numbers in arguments and for logging.\n");
+    }
+}
+
+void
+margin_log_margining(struct margin_lanes_data arg)
+{
+  char *ind_dirs[] = { "Up", "Down", "Left", "Right" };
+  char *non_ind_dirs[] = { "Voltage", "", "Timing" };
+
+  if (arg.verbosity > 0)
+    {
+      margin_log("\033[2K\rMargining - ");
+      if (arg.ind)
+        margin_log("%s", ind_dirs[arg.dir]);
+      else
+        margin_log("%s", non_ind_dirs[arg.dir]);
+
+      u8 lanes_counter = 0;
+      margin_log(" - Lanes ");
+      margin_log("[%d", arg.lanes_numbers[0]);
+      for (int i = 1; i < arg.lanes_n; i++)
+        {
+          if (arg.lanes_numbers[i] - 1 == arg.lanes_numbers[i - 1])
+            {
+              lanes_counter++;
+              if (lanes_counter == 1)
+                margin_log("-");
+              if (i + 1 == arg.lanes_n)
+                margin_log("%d", arg.lanes_numbers[i]);
+            }
+          else
+            {
+              if (lanes_counter > 0)
+                margin_log("%d", arg.lanes_numbers[i - 1]);
+              margin_log(",%d", arg.lanes_numbers[i]);
+              lanes_counter = 0;
+            }
+        }
+      margin_log("]");
+
+      u64 lane_eta_s = (arg.steps_lane_total - arg.steps_lane_done) * MARGIN_STEP_MS / 1000;
+      u64 total_eta_s = *arg.steps_utility * MARGIN_STEP_MS / 1000 + lane_eta_s;
+      margin_log(" - ETA: %3ds Steps: %3d Total ETA: %3dm %2ds", lane_eta_s, arg.steps_lane_done,
+                 total_eta_s / 60, total_eta_s % 60);
+
+      fflush(stdout);
+    }
+}
-- 
2.34.1


