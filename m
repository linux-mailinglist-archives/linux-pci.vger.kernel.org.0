Return-Path: <linux-pci+bounces-667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E74809F47
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E0391C20A06
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1C112B6C;
	Fri,  8 Dec 2023 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="C7ljy2b4";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="QNLRVEbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D3171C
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 2EF99C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027148; bh=bqrm/UmwxjZYPh3bgMcf/Aak6otL+spZABkNgkh/was=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=C7ljy2b4MGI2AwIum+xIdDnlurrVO/1wWPWCsxASgZac1ApAzMqH2dVtz+phIP34s
	 IHnQOLj53nH2JlEbdKNAI97nx8TqeII3WFdiJ+cdTARQ6U79CoMU28DLXcGsCaV2ek
	 cQzYKDcpcjLNINAo8SHA7FRT9ZlF8JYWu5AhETxBleES54Jusx/9TFBmlnUNcYpJVu
	 WL7XjqLY0GIKjFYP+WdRO1x0bzUBLJRgcSibtrNjAfIoyKxwid8sSgGDW60bjtq/GL
	 s8egFXi6Un15MUl8yt8w7uqfRfnKGx68QDwoubtibqQxEBktAzY3ZBj+eAkrGM2g0k
	 ff0+7NSxj2Pqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027148; bh=bqrm/UmwxjZYPh3bgMcf/Aak6otL+spZABkNgkh/was=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=QNLRVEbd24uDnZI2U4nY5quIa1X5Rq+GuaZvegEubhhUmf+285KREOC0QHmRn5JLw
	 eRFDyVSBBqDK7nJg7VyYQqAijtSXc/Sm0b7e3ZzFE+fzkG9gRSEaxrrinQI8UdgGkX
	 +fdLJiObCUb+hcwxQZI6pYk4no4H60qpC3AAp6o56dMSIrUwRGXJLLeNvItVXSqHhn
	 0KUKXZuG3F3FX2Ef/b1cJfwdJ0jYa7QzpPaFIs0pzTEgbkCajaTvgrcPvzfOkrSHYE
	 8iWQOE3QNC+XJPnjetXqnjIgFkdkzspzpselXZKkz1D2R+LenRw1doagGv0aCdVNWB
	 kU1OSqu62dyiQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 06/15] pciutils-pcilmr: Add logging functions for margining
Date: Fri, 8 Dec 2023 12:17:25 +0300
Message-ID: <20231208091734.12225-7-n.proshkin@yadro.com>
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
 lmr_lib/Makefile     |   2 +-
 lmr_lib/margin.c     |  12 +++++
 lmr_lib/margin_log.c | 115 +++++++++++++++++++++++++++++++++++++++++++
 lmr_lib/margin_log.h |  21 ++++++++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 lmr_lib/margin_log.c
 create mode 100644 lmr_lib/margin_log.h

diff --git a/lmr_lib/Makefile b/lmr_lib/Makefile
index 2003a67..a0eefd6 100644
--- a/lmr_lib/Makefile
+++ b/lmr_lib/Makefile
@@ -1,4 +1,4 @@
-OBJS=margin_hw margin
+OBJS=margin_hw margin margin_log
 INCL=$(addsuffix .h,$(OBJS)) $(addprefix ../,$(PCIINC))
 
 $(addsuffix .o, $(OBJS)): %.o: %.c $(INCL)
diff --git a/lmr_lib/margin.c b/lmr_lib/margin.c
index 9d25973..38a80bf 100644
--- a/lmr_lib/margin.c
+++ b/lmr_lib/margin.c
@@ -4,6 +4,7 @@
 #include <malloc.h>
 
 #include "margin.h"
+#include "margin_log.h"
 
 #define MARG_LANE_CTRL(lmr_cap_addr, lane) ((lmr_cap_addr) + 8 + 4 * (lane))
 #define MARG_LANE_STATUS(lmr_cap_addr, lane) ((lmr_cap_addr) + 10 + 4 * (lane))
@@ -196,6 +197,7 @@ void margin_lanes(struct margin_lanes_data arg)
     }
 
     arg.steps_lane_done = steps_done;
+    margin_log_margining(arg);
   }
 
   for (uint8_t i = 0; i < arg.lanes_n; i++)
@@ -219,9 +221,11 @@ bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct
   recv->error_limit = args->error_limit;
   recv->parallel_lanes = (args->parallel_lanes < 0 ? 1 : args->parallel_lanes);
   results->lanes_n = lanes_n;
+  margin_log_receiver(recv);
 
   if (!margin_check_ready_bit(recv->dev->dev))
   {
+    margin_log("\nMargining Ready bit is Clear.\n");
     results->test_status = MARGIN_TEST_READY_BIT;
     status = false;
   }
@@ -234,6 +238,7 @@ bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct
       recv->lane_reversal = true;
       if (!margin_read_params(recv))
       {
+        margin_log("\nError during caps reading.\n");
         results->test_status = MARGIN_TEST_CAPS;
         status = false;
       }
@@ -255,6 +260,8 @@ bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct
     results->link_speed = recv->dev->link_speed;
     results->test_status = MARGIN_TEST_OK;
 
+    margin_log_print_caps(recv);
+
     results->lanes = malloc(sizeof(struct margin_res_lane) * lanes_n);
     for (uint8_t i = 0; i < lanes_n; i++)
     {
@@ -263,6 +270,7 @@ bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct
 
     if (args->run_margin)
     {
+      if (args->verbosity > 0) margin_log("\n");
       struct margin_lanes_data margin_lanes_data = {.recv = recv,
                                                     .verbosity = args->verbosity,
                                                     .steps_margin_remaining = args->steps_margin_remaining};
@@ -302,6 +310,7 @@ bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct
         }
         lanes_done += use_lanes;
       }
+      if (args->verbosity > 0) margin_log("\n");
       if (recv->lane_reversal)
       {
         for (uint8_t i = 0; i < lanes_n; i++)
@@ -368,12 +377,15 @@ struct margin_results *margin_link(struct margin_dev *down_port, struct margin_d
   uint8_t receivers_n = status ? args->recvs_n : 1;
   uint8_t *receivers = args->recvs;
 
+  margin_log_link(down_port, up_port);
+
   struct margin_results *results = malloc(sizeof(*results) * receivers_n);
   struct margin_recv receiver;
 
   if (!status)
   {
     results[0].test_status = MARGIN_TEST_ASPM;
+    margin_log("\nCouldn't disable ASPM on the given Link.\n");
   }
 
   if (status)
diff --git a/lmr_lib/margin_log.c b/lmr_lib/margin_log.c
new file mode 100644
index 0000000..d32136a
--- /dev/null
+++ b/lmr_lib/margin_log.c
@@ -0,0 +1,115 @@
+#include <stdio.h>
+#include <stdarg.h>
+
+#include "margin_log.h"
+
+bool margin_global_logging = false;
+bool margin_print_domain = true;
+
+void margin_log(char *format, ...)
+{
+  va_list arg;
+  va_start(arg, format);
+  if (margin_global_logging)
+    vprintf(format, arg);
+  va_end(arg);
+}
+
+void margin_log_bdfs(struct pci_dev *down, struct pci_dev *up)
+{
+  if (margin_print_domain)
+  {
+    margin_log("%x:%x:%x.%x -> %x:%x:%x.%x", down->domain, down->bus, down->dev,
+               down->func, up->domain, up->bus, up->dev, up->func);
+  }
+  else
+  {
+    margin_log("%x:%x.%x -> %x:%x.%x", down->bus, down->dev,
+               down->func, up->bus, up->dev, up->func);
+  }
+}
+
+void margin_log_print_caps(struct margin_recv *recv)
+{
+  margin_log("\nError Count Limit = %d\n", recv->error_limit);
+  margin_log("Parallel Lanes: %d\n", recv->parallel_lanes);
+  margin_log("\nIndependent Error Sampler: %d\n", recv->ind_error_sampler);
+  margin_log("Sample Reporting Method: %d\n", recv->sample_report_method);
+  margin_log("Independent Left and Right Timing Margining: %d\n", recv->ind_left_right_tim);
+  margin_log("Voltage Margining Supported: %d\n", recv->volt_support);
+  margin_log("Independent Up and Down Voltage Margining: %d\n", recv->ind_up_down_volt);
+  margin_log("Number of Timing Steps: %d\n", recv->timing_steps);
+  margin_log("Number of Voltage Steps: %d\n", recv->volt_steps);
+  margin_log("Max Timing Offset: %d\n", recv->timing_offset);
+  margin_log("Max Voltage Offset: %d\n", recv->volt_offset);
+  margin_log("Max Lanes: %d\n", recv->max_lanes);
+
+  if (recv->lane_reversal)
+  {
+    margin_log("\nWarning: device uses Lane Reversal.\n");
+    margin_log("However, utility uses logical lane numbers in arguments and for logging.\n");
+  }
+}
+
+void margin_log_link(struct margin_dev *down, struct margin_dev *up)
+{
+  margin_log("Link ");
+  margin_log_bdfs(down->dev, up->dev);
+  margin_log("\nNegotiated Link Width: %d\n", down->width);
+  margin_log("Link Speed: %d.0 GT/s = Gen %d\n", (down->link_speed - 3) * 16, down->link_speed);
+  margin_log("Available receivers: ");
+  uint8_t receivers_n = 2 + 2 * down->retimers_n;
+  for (uint8_t i = 1; i < receivers_n; i++)
+    margin_log("Rx(%X) - %d, ", 10 + i - 1, i);
+  margin_log("Rx(F) - 6\n");
+}
+
+void margin_log_receiver(struct margin_recv *recv)
+{
+  margin_log("\nReceiver = Rx(%X)\n", 10 + recv->recvn - 1);
+}
+
+void margin_log_margining(struct margin_lanes_data arg)
+{
+  char *ind_dirs[] = {"Up", "Down", "Left", "Right"};
+  char *non_ind_dirs[] = {"Voltage", "", "Timing"};
+
+  if (arg.verbosity > 0)
+  {
+    margin_log("\033[2K\rMargining - ");
+    if (arg.ind)
+      margin_log("%s", ind_dirs[arg.dir]);
+    else
+      margin_log("%s", non_ind_dirs[arg.dir]);
+
+    uint8_t lanes_counter = 0;
+    margin_log(" - Lanes ");
+    margin_log("[%d", arg.lanes_numbers[0]);
+    for (uint8_t i = 1; i < arg.lanes_n; i++)
+    {
+      if (arg.lanes_numbers[i] - 1 == arg.lanes_numbers[i - 1])
+      {
+        lanes_counter++;
+        if (lanes_counter == 1)
+          margin_log("-");
+        if (i + 1 == arg.lanes_n)
+          margin_log("%d", arg.lanes_numbers[i]);
+      }
+      else
+      {
+        if (lanes_counter > 0)
+          margin_log("%d", arg.lanes_numbers[i - 1]);
+        margin_log(",%d", arg.lanes_numbers[i]);
+        lanes_counter = 0;
+      }
+    }
+    margin_log("]");
+
+    uint64_t lane_eta_s = (arg.steps_lane_total - arg.steps_lane_done) * MARGIN_STEP_MS / 1000;
+    uint64_t total_eta_s = *arg.steps_margin_remaining * MARGIN_STEP_MS / 1000 + lane_eta_s;
+    margin_log(" - ETA: %3ds Steps: %3d Total ETA: %3dm %2ds",
+               lane_eta_s, arg.steps_lane_done, total_eta_s / 60, total_eta_s % 60);
+
+    fflush(stdout);
+  }
+}
diff --git a/lmr_lib/margin_log.h b/lmr_lib/margin_log.h
new file mode 100644
index 0000000..c1f89e1
--- /dev/null
+++ b/lmr_lib/margin_log.h
@@ -0,0 +1,21 @@
+#ifndef _MARGIN_LOG_H
+#define _MARGIN_LOG_H
+
+#include "margin.h"
+
+extern bool margin_global_logging;
+extern bool margin_print_domain;
+
+void margin_log(char *format, ...);
+
+void margin_log_bdfs(struct pci_dev *down, struct pci_dev *up);
+
+void margin_log_print_caps(struct margin_recv *recv);
+
+void margin_log_link(struct margin_dev *down, struct margin_dev *up);
+
+void margin_log_receiver(struct margin_recv *recv);
+
+void margin_log_margining(struct margin_lanes_data arg);
+
+#endif
-- 
2.34.1


