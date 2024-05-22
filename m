Return-Path: <linux-pci+bounces-7757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230BE8CC4BE
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F211C213AF
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B77A3716D;
	Wed, 22 May 2024 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="pDCZ+ehd";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="xtoeb8KR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E54F1F17B
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394479; cv=none; b=l7WzfpIto48eRpmOK4RWrpYkx9eFoxRuOLtY/W5tOoI+olPnlUZipuHhxwy8/sHIjIECfv2d1hQLojAA0QfgFxmVERaGVI2qLOo0Q8hvrdftzR1/K/EtrXYyxEYErHYnc+uqjL+/9cdb6McQ4l02oyk1PkjydKjnMFe76GfxtF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394479; c=relaxed/simple;
	bh=60Rw+fe2C49j7CQRYjAe7D73tZELduOGgmas1ZN+/vQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FltrZrmU5CMP2G/lzyOvlr3VkRuldjeWlcw4wLJIu2gqOL6YEymh482L4oN5DuLGHJOk/b1LmyVIU5VK6JK0NImIwNzq6YWrKOojuZOukuz31BAVghU91fBOBLBLOs/rmF90WcIxIKu+C2nFi8xgVJxEmX9znowfu2QQZ9STnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=pDCZ+ehd; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=xtoeb8KR; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 7A865C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394048; bh=v3eVbveUtchmcH6oeQST2ELhKIr74aeJZvKsCaqUOsA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=pDCZ+ehd6unegF2K9cgZY6P8YL/QdpQ9bg6OeHDKJJ1SMud7/pOFKXh5iX+sKKwym
	 nYxjdgBcD6JCyEsMEpCyQGttsa4Vjq3tAxw/WQGwVU6yLiWYeoWB7S5xeEpD0UICYV
	 sp5bcw/RyBEOUuExWFVI7yBZj2zN5WDNnt9tJqN1qWyw0jF5FRSWkFj9TzBXjuYug3
	 OTFuQ4hr2+lEDwra9+yIE6hg4SJgl3mVDcFcBeEiRyLNFrYy2WAbQYXD0ElXEIEcbU
	 PPdaQ+zGvFG8LWD/+IQySD34BEO+gBpgZEL9skL053Xn3TLkvfjAICOEehI2g3FL+A
	 2qvNJSj9rve6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394048; bh=v3eVbveUtchmcH6oeQST2ELhKIr74aeJZvKsCaqUOsA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=xtoeb8KRjD/1INX3xu0r/QbAQIoWrM7kWiJWivtLWEDUf0OiffwYk5inOdyA7KuQt
	 y2JWWAKtMfvxl6KLYOekBW+jbyfuW0UqKdqPn/YhH4OjEK5DdFzi67F79/q12EIw2x
	 omwodmlRiIEQfH9Njzg+1QZlEWXjHX4XGDnQhWNhEKk+5T77uCeAqNJWaROdQ6WgTL
	 MpGK7UygSW6HVKKBRxZdiqUg31Sx079Eud0iGd/3sS90gAnn/SfPRhqV6LIMHPfzz4
	 TOEF3+4G+gzazpLrwmAb2k+TBko/NBtz0vZTbYJegCywEb6ozMI6QoLHOUk9HZDEey
	 mwrR1+aHnObCA==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils 2/6] pcilmr: Move most of pcilmr arguments parsing logic to the separate file
Date: Wed, 22 May 2024 19:06:30 +0300
Message-ID: <20240522160634.29831-3-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240522160634.29831-1-n.proshkin@yadro.com>
References: <20240522160634.29831-1-n.proshkin@yadro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-08.corp.yadro.com (172.17.11.58) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Also change arguments parsing logic: now link parameters (selected lane
numbers, timing or voltage steps, etc) need to be specified after link port
and will affect only this link margining (previously, one option was
applied to all links).

See updated man for syntax and example.

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 Makefile             |   2 +-
 lmr/lmr.h            |  50 ++++---
 lmr/margin.c         |  32 +++--
 lmr/margin_args.c    | 263 +++++++++++++++++++++++++++++++++++
 lmr/margin_hw.c      |   3 +
 lmr/margin_log.c     |  13 +-
 lmr/margin_results.c |  14 +-
 pcilmr.c             | 323 ++++++-------------------------------------
 8 files changed, 379 insertions(+), 321 deletions(-)
 create mode 100644 lmr/margin_args.c

diff --git a/Makefile b/Makefile
index be23593..abb5cb4 100644
--- a/Makefile
+++ b/Makefile
@@ -67,7 +67,7 @@ PCIINC_INS=lib/config.h lib/header.h lib/pci.h lib/types.h
 
 UTILINC=pciutils.h bitops.h $(PCIINC)
 
-LMR=margin_hw.o margin.o margin_log.o margin_results.o
+LMR=margin_hw.o margin.o margin_log.o margin_results.o margin_args.o
 LMROBJS=$(addprefix lmr/,$(LMR))
 LMRINC=lmr/lmr.h $(UTILINC)
 
diff --git a/lmr/lmr.h b/lmr/lmr.h
index 6cac3d4..71480f0 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -39,11 +39,6 @@ struct margin_dev {
   bool hawd; // Hardware Autonomous Width Disable
 };
 
-struct margin_link {
-  struct margin_dev down_port;
-  struct margin_dev up_port;
-};
-
 /* Specification Revision 5.0 Table 8-11 */
 struct margin_params {
   bool ind_error_sampler;
@@ -115,20 +110,33 @@ struct margin_results {
 };
 
 /* pcilmr arguments */
-struct margin_args {
+
+// Common args
+struct margin_com_args {
+  u8 error_limit;    // [0; 63]
+  bool run_margin;   // Or print params only
+  u8 verbosity;      // 0 - basic;
+                     // 1 - add info about remaining time and lanes in progress during margining
+  u64 steps_utility; // For ETA logging
+  bool save_csv;
+  char *dir_for_csv;
+};
+
+struct margin_link_args {
+  struct margin_com_args *common;
   u8 steps_t;        // 0 == use NumTimingSteps
   u8 steps_v;        // 0 == use NumVoltageSteps
   u8 parallel_lanes; // [1; MaxLanes + 1]
-  u8 error_limit;    // [0; 63]
   u8 recvs[6];       // Receivers Numbers
   u8 recvs_n;        // 0 == margin all available receivers
   u8 lanes[32];      // Lanes to Margin
   u8 lanes_n;        // 0 == margin all available lanes
-  bool run_margin;   // Or print params only
-  u8 verbosity;      // 0 - basic;
-                     // 1 - add info about remaining time and lanes in progress during margining
+};
 
-  u64 *steps_utility; // For ETA logging
+struct margin_link {
+  struct margin_dev down_port;
+  struct margin_dev up_port;
+  struct margin_link_args args;
 };
 
 /* Receiver structure */
@@ -159,6 +167,15 @@ struct margin_lanes_data {
   u8 verbosity;
 };
 
+/* margin_args */
+
+enum margin_mode { MARGIN, FULL, SCAN };
+
+extern const char *usage;
+
+struct margin_link *margin_parse_util_args(struct pci_access *pacc, int argc, char **argv,
+                                           enum margin_mode mode, u8 *links_n);
+
 /* margin_hw */
 
 bool margin_port_is_down(struct pci_dev *dev);
@@ -189,12 +206,11 @@ void margin_restore_link(struct margin_link *link);
 bool margin_read_params(struct pci_access *pacc, struct pci_dev *dev, u8 recvn,
                         struct margin_params *params);
 
-enum margin_test_status margin_process_args(struct margin_dev *dev, struct margin_args *args);
+enum margin_test_status margin_process_args(struct margin_link *link);
 
-/* Awaits that args are prepared through process_args.
+/* Awaits that links are prepared through process_args.
    Returns number of margined Receivers through recvs_n */
-struct margin_results *margin_test_link(struct margin_link *link, struct margin_args *args,
-                                        u8 *recvs_n);
+struct margin_results *margin_test_link(struct margin_link *link, u8 *recvs_n);
 
 void margin_free_results(struct margin_results *results, u8 results_n);
 
@@ -207,6 +223,7 @@ void margin_log(char *format, ...);
 
 /* b:d.f -> b:d.f */
 void margin_log_bdfs(struct pci_dev *down_port, struct pci_dev *up_port);
+void margin_gen_bdfs(struct pci_dev *down_port, struct pci_dev *up_port, char *dest, size_t maxlen);
 
 /* Print Link header (bdfs, width, speed) */
 void margin_log_link(struct margin_link *link);
@@ -228,7 +245,6 @@ void margin_log_hw_quirks(struct margin_recv *recv);
 
 void margin_results_print_brief(struct margin_results *results, u8 recvs_n);
 
-void margin_results_save_csv(struct margin_results *results, u8 recvs_n, char *dir,
-                             struct pci_dev *up_port);
+void margin_results_save_csv(struct margin_results *results, u8 recvs_n, struct margin_link *link);
 
 #endif
diff --git a/lmr/margin.c b/lmr/margin.c
index e3758df..e2ea300 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -1,7 +1,7 @@
 /*
  *	The PCI Utilities -- Obtain the margin information of the Link
  *
- *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *	Copyright (c) 2023-2024 KNS Group LLC (YADRO)
  *
  *	Can be freely distributed and used under the terms of the GNU GPL v2+.
  *
@@ -300,7 +300,7 @@ margin_test_lanes(struct margin_lanes_data arg)
 
 /* Awaits that Receiver is prepared through prep_dev function */
 static bool
-margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
+margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_link_args *args,
                      struct margin_results *results)
 {
   u8 *lanes_to_margin = args->lanes;
@@ -312,7 +312,7 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
                               .lane_reversal = false,
                               .params = &params,
                               .parallel_lanes = args->parallel_lanes ? args->parallel_lanes : 1,
-                              .error_limit = args->error_limit };
+                              .error_limit = args->common->error_limit };
 
   results->recvn = recvn;
   results->lanes_n = lanes_n;
@@ -364,12 +364,13 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
         = recv.lane_reversal ? dev->width - lanes_to_margin[i] - 1 : lanes_to_margin[i];
     }
 
-  if (args->run_margin)
+  if (args->common->run_margin)
     {
-      if (args->verbosity > 0)
+      if (args->common->verbosity > 0)
         margin_log("\n");
-      struct margin_lanes_data lanes_data
-        = { .recv = &recv, .verbosity = args->verbosity, .steps_utility = args->steps_utility };
+      struct margin_lanes_data lanes_data = { .recv = &recv,
+                                              .verbosity = args->common->verbosity,
+                                              .steps_utility = &args->common->steps_utility };
 
       enum margin_dir dir[] = { TIM_LEFT, TIM_RIGHT, VOLT_UP, VOLT_DOWN };
 
@@ -399,15 +400,15 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
               lanes_data.ind = timing ? params.ind_left_right_tim : params.ind_up_down_volt;
               lanes_data.dir = dir[i];
               lanes_data.steps_lane_total = timing ? steps_t : steps_v;
-              if (*args->steps_utility >= lanes_data.steps_lane_total)
-                *args->steps_utility -= lanes_data.steps_lane_total;
+              if (args->common->steps_utility >= lanes_data.steps_lane_total)
+                args->common->steps_utility -= lanes_data.steps_lane_total;
               else
-                *args->steps_utility = 0;
+                args->common->steps_utility = 0;
               margin_test_lanes(lanes_data);
             }
           lanes_done += use_lanes;
         }
-      if (args->verbosity > 0)
+      if (args->common->verbosity > 0)
         margin_log("\n");
       if (recv.lane_reversal)
         {
@@ -476,8 +477,11 @@ margin_read_params(struct pci_access *pacc, struct pci_dev *dev, u8 recvn,
 }
 
 enum margin_test_status
-margin_process_args(struct margin_dev *dev, struct margin_args *args)
+margin_process_args(struct margin_link *link)
 {
+  struct margin_dev *dev = &link->down_port;
+  struct margin_link_args *args = &link->args;
+
   u8 receivers_n = 2 + 2 * dev->retimers_n;
 
   if (!args->recvs_n)
@@ -520,8 +524,10 @@ margin_process_args(struct margin_dev *dev, struct margin_args *args)
 }
 
 struct margin_results *
-margin_test_link(struct margin_link *link, struct margin_args *args, u8 *recvs_n)
+margin_test_link(struct margin_link *link, u8 *recvs_n)
 {
+  struct margin_link_args *args = &link->args;
+
   bool status = margin_prep_link(link);
 
   u8 receivers_n = status ? args->recvs_n : 1;
diff --git a/lmr/margin_args.c b/lmr/margin_args.c
new file mode 100644
index 0000000..c2d2e79
--- /dev/null
+++ b/lmr/margin_args.c
@@ -0,0 +1,263 @@
+/*
+ *	The PCI Utilities -- Parse pcilmr utility arguments
+ *
+ *	Copyright (c) 2024 KNS Group LLC (YADRO)
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL v2+.
+ *
+ *	SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "lmr.h"
+
+const char* usage
+  = "! Utility requires preliminary preparation of the system. Refer to the pcilmr man page !\n\n"
+    "Usage:\n"
+    "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
+    "pcilmr --full [<margining options>]\n"
+    "pcilmr --scan\n\n"
+    "Device Specifier:\n"
+    "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
+    "Modes:\n"
+    "--margin\t\tMargin selected Links\n"
+    "--full\t\t\tMargin all ready for testing Links in the system (one by one)\n"
+    "--scan\t\t\tScan for Links available for margining\n\n"
+    "Margining options:\n\n"
+    "Margining Test settings:\n"
+    "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
+    "-l <lane>[,<lane>...]\tSpecify lanes for margining. Default: all link lanes.\n"
+    "\t\t\tRemember that Device may use Lane Reversal for Lane numbering.\n"
+    "\t\t\tHowever, utility uses logical lane numbers in arguments and for logging.\n"
+    "\t\t\tUtility will automatically determine Lane Reversal and tune its calls.\n"
+    "-e <errors>\t\tSpecify Error Count Limit for margining. Default: 4.\n"
+    "-r <recvn>[,<recvn>...]\tSpecify Receivers to select margining targets.\n"
+    "\t\t\tDefault: all available Receivers (including Retimers).\n"
+    "-p <parallel_lanes>\tSpecify number of lanes to margin simultaneously.\n"
+    "\t\t\tDefault: 1.\n"
+    "\t\t\tAccording to spec it's possible for Receiver to margin up\n"
+    "\t\t\tto MaxLanes + 1 lanes simultaneously, but usually this works\n"
+    "\t\t\tbad, so this option is for experiments mostly.\n"
+    "-T\t\t\tTime Margining will continue until the Error Count is no more\n"
+    "\t\t\tthan an Error Count Limit. Use this option to find Link limit.\n"
+    "-V\t\t\tSame as -T option, but for Voltage.\n"
+    "-t <steps>\t\tSpecify maximum number of steps for Time Margining.\n"
+    "-v <steps>\t\tSpecify maximum number of steps for Voltage Margining.\n"
+    "Use only one of -T/-t options at the same time (same for -V/-v).\n"
+    "Without these options utility will use MaxSteps from Device\n"
+    "capabilities as test limit.\n\n"
+    "Margining Log settings:\n"
+    "-o <directory>\t\tSave margining results in csv form into the\n"
+    "\t\t\tspecified directory. Utility will generate file with the\n"
+    "\t\t\tname in form of 'lmr_<downstream component>_Rx#_<timestamp>.csv'\n"
+    "\t\t\tfor each successfully tested receiver.\n";
+
+static struct pci_dev *
+dev_for_filter(struct pci_access *pacc, char *filter)
+{
+  struct pci_filter pci_filter;
+  pci_filter_init(pacc, &pci_filter);
+  if (pci_filter_parse_slot(&pci_filter, filter))
+    die("Invalid device ID: %s\n", filter);
+
+  if (pci_filter.bus == -1 || pci_filter.slot == -1 || pci_filter.func == -1)
+    die("Invalid device ID: %s\n", filter);
+
+  if (pci_filter.domain == -1)
+    pci_filter.domain = 0;
+
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
+    {
+      if (pci_filter_match(&pci_filter, p))
+        return p;
+    }
+
+  die("No such PCI device: %s or you don't have enough privileges.\n", filter);
+}
+
+static u8
+parse_csv_arg(char *arg, u8 *vals)
+{
+  u8 cnt = 0;
+  char *token = strtok(arg, ",");
+  while (token)
+    {
+      vals[cnt] = atoi(token);
+      cnt++;
+      token = strtok(NULL, ",");
+    }
+  return cnt;
+}
+
+static u8
+find_ready_links(struct pci_access *pacc, struct margin_link *links, bool cnt_only)
+{
+  u8 cnt = 0;
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
+    {
+      if (pci_find_cap(p, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED) && margin_port_is_down(p))
+        {
+          struct pci_dev *down = NULL;
+          struct pci_dev *up = NULL;
+          margin_find_pair(pacc, p, &down, &up);
+
+          if (down && margin_verify_link(down, up)
+              && (margin_check_ready_bit(down) || margin_check_ready_bit(up)))
+            {
+              if (!cnt_only)
+                margin_fill_link(down, up, &(links[cnt]));
+              cnt++;
+            }
+        }
+    }
+  return cnt;
+}
+
+static void
+init_link_args(struct margin_link_args *link_args, struct margin_com_args *com_args)
+{
+  memset(link_args, 0, sizeof(*link_args));
+  link_args->common = com_args;
+  link_args->parallel_lanes = 1;
+}
+
+static void
+parse_dev_args(int argc, char **argv, struct margin_link_args *args, u8 link_speed)
+{
+  if (argc == optind)
+    return;
+  int c;
+  while ((c = getopt(argc, argv, "+r:l:p:t:v:VT")) != -1)
+    {
+      switch (c)
+        {
+          case 't':
+            args->steps_t = atoi(optarg);
+            break;
+          case 'T':
+            args->steps_t = 63;
+            break;
+          case 'v':
+            args->steps_v = atoi(optarg);
+            break;
+          case 'V':
+            args->steps_v = 127;
+            break;
+          case 'p':
+            args->parallel_lanes = atoi(optarg);
+            break;
+          case 'l':
+            args->lanes_n = parse_csv_arg(optarg, args->lanes);
+            break;
+          case 'r':
+            args->recvs_n = parse_csv_arg(optarg, args->recvs);
+            break;
+          case '?':
+            die("Invalid arguments\n\n%s", usage);
+            break;
+          default:
+            return;
+        }
+    }
+}
+
+struct margin_link *
+margin_parse_util_args(struct pci_access *pacc, int argc, char **argv, enum margin_mode mode,
+                       u8 *links_n)
+{
+  struct margin_com_args *com_args = xmalloc(sizeof(*com_args));
+  com_args->error_limit = 4;
+  com_args->run_margin = true;
+  com_args->verbosity = 1;
+  com_args->steps_utility = 0;
+  com_args->dir_for_csv = NULL;
+  com_args->save_csv = false;
+
+  int c;
+  while ((c = getopt(argc, argv, "+e:co:")) != -1)
+    {
+      switch (c)
+        {
+          case 'c':
+            com_args->run_margin = false;
+            break;
+          case 'e':
+            com_args->error_limit = atoi(optarg);
+            break;
+          case 'o':
+            com_args->dir_for_csv = optarg;
+            com_args->save_csv = true;
+            break;
+          default:
+            die("Invalid arguments\n\n%s", usage);
+        }
+    }
+
+  bool status = true;
+  if (mode == FULL && optind != argc)
+    status = false;
+  if (mode == MARGIN && optind == argc)
+    status = false;
+  if (!status && argc > 1)
+    die("Invalid arguments\n\n%s", usage);
+  if (!status)
+    {
+      printf("%s", usage);
+      exit(0);
+    }
+
+  u8 ports_n = 0;
+  struct margin_link *links = NULL;
+  char err[128];
+
+  if (mode == FULL)
+    {
+      ports_n = find_ready_links(pacc, NULL, true);
+      if (ports_n == 0)
+        die("Links not found or you don't have enough privileges.\n");
+      else
+        {
+          links = xmalloc(ports_n * sizeof(*links));
+          find_ready_links(pacc, links, false);
+          for (int i = 0; i < ports_n; i++)
+            init_link_args(&(links[i].args), com_args);
+        }
+    }
+  else if (mode == MARGIN)
+    {
+      while (optind != argc)
+        {
+          struct pci_dev *dev = dev_for_filter(pacc, argv[optind]);
+          optind++;
+          links = xrealloc(links, (ports_n + 1) * sizeof(*links));
+          struct pci_dev *down;
+          struct pci_dev *up;
+          if (!margin_find_pair(pacc, dev, &down, &up))
+            die("Cannot find pair for the specified device: %s\n", argv[optind]);
+          struct pci_cap *cap = pci_find_cap(down, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
+          if (!cap)
+            die("Looks like you don't have enough privileges to access "
+                "Device Configuration Space.\nTry to run utility as root.\n");
+          if (!margin_fill_link(down, up, &(links[ports_n])))
+            {
+              margin_gen_bdfs(down, up, err, sizeof(err));
+              die("Link %s is not ready for margining.\n"
+                  "Link data rate must be 16 GT/s or 32 GT/s.\n"
+                  "Downstream Component must be at D0 PM state.\n",
+                  err);
+            }
+          init_link_args(&(links[ports_n].args), com_args);
+          parse_dev_args(argc, argv, &(links[ports_n].args),
+                         links[ports_n].down_port.link_speed - 4);
+          ports_n++;
+        }
+    }
+  else
+    die("Bug in the args parsing!\n");
+
+  *links_n = ports_n;
+  return links;
+}
diff --git a/lmr/margin_hw.c b/lmr/margin_hw.c
index 43fa1bd..2585ca1 100644
--- a/lmr/margin_hw.c
+++ b/lmr/margin_hw.c
@@ -8,6 +8,8 @@
  *	SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include <memory.h>
+
 #include "lmr.h"
 
 static u16 special_hw[][4] =
@@ -125,6 +127,7 @@ fill_dev_wrapper(struct pci_dev *dev)
 bool
 margin_fill_link(struct pci_dev *down_port, struct pci_dev *up_port, struct margin_link *wrappers)
 {
+  memset(wrappers, 0, sizeof(*wrappers));
   if (!margin_verify_link(down_port, up_port))
     return false;
   wrappers->down_port = fill_dev_wrapper(down_port);
diff --git a/lmr/margin_log.c b/lmr/margin_log.c
index b3c4bd5..6fa4f09 100644
--- a/lmr/margin_log.c
+++ b/lmr/margin_log.c
@@ -1,7 +1,7 @@
 /*
  *	The PCI Utilities -- Log margining process
  *
- *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *	Copyright (c) 2023-2024 KNS Group LLC (YADRO)
  *
  *	Can be freely distributed and used under the terms of the GNU GPL v2+.
  *
@@ -37,6 +37,17 @@ margin_log_bdfs(struct pci_dev *down, struct pci_dev *up)
                up->func);
 }
 
+void
+margin_gen_bdfs(struct pci_dev *down, struct pci_dev *up, char *dest, size_t maxlen)
+{
+  if (margin_print_domain)
+    snprintf(dest, maxlen, "%x:%x:%x.%x -> %x:%x:%x.%x", down->domain, down->bus, down->dev,
+             down->func, up->domain, up->bus, up->dev, up->func);
+  else
+    snprintf(dest, maxlen, "%x:%x.%x -> %x:%x.%x", down->bus, down->dev, down->func, up->bus,
+             up->dev, up->func);
+}
+
 void
 margin_log_link(struct margin_link *link)
 {
diff --git a/lmr/margin_results.c b/lmr/margin_results.c
index 4d28f04..b320e90 100644
--- a/lmr/margin_results.c
+++ b/lmr/margin_results.c
@@ -1,7 +1,7 @@
 /*
  *	The PCI Utilities -- Display/save margining results
  *
- *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *	Copyright (c) 2023-2024 KNS Group LLC (YADRO)
  *
  *	Can be freely distributed and used under the terms of the GNU GPL v2+.
  *
@@ -172,13 +172,13 @@ margin_results_print_brief(struct margin_results *results, u8 recvs_n)
 }
 
 void
-margin_results_save_csv(struct margin_results *results, u8 recvs_n, char *dir,
-                        struct pci_dev *up_port)
+margin_results_save_csv(struct margin_results *results, u8 recvs_n, struct margin_link *link)
 {
   char timestamp[64];
   time_t tim = time(NULL);
   strftime(timestamp, sizeof(timestamp), "%Y-%m-%dT%H:%M:%S", gmtime(&tim));
 
+  char *dir = link->args.common->dir_for_csv;
   size_t pathlen = strlen(dir) + 128;
   char *path = xmalloc(pathlen);
   FILE *csv;
@@ -190,6 +190,8 @@ margin_results_save_csv(struct margin_results *results, u8 recvs_n, char *dir,
   enum lane_rating lane_rating;
   u8 link_speed;
 
+  struct pci_dev *port;
+
   for (int i = 0; i < recvs_n; i++)
     {
       res = &(results[i]);
@@ -198,9 +200,11 @@ margin_results_save_csv(struct margin_results *results, u8 recvs_n, char *dir,
 
       if (res->test_status != MARGIN_TEST_OK)
         continue;
+
+      port = res->recvn == 6 ? link->up_port.dev : link->down_port.dev;
       snprintf(path, pathlen, "%s/lmr_%0*x.%02x.%02x.%x_Rx%X_%s.csv", dir,
-               up_port->domain_16 == 0xffff ? 8 : 4, up_port->domain, up_port->bus, up_port->dev,
-               up_port->func, 10 + res->recvn - 1, timestamp);
+               port->domain_16 == 0xffff ? 8 : 4, port->domain, port->bus, port->dev,
+               port->func, 10 + res->recvn - 1, timestamp);
       csv = fopen(path, "w");
       if (!csv)
         die("Error while saving %s\n", path);
diff --git a/pcilmr.c b/pcilmr.c
index 345ce7a..f1ef140 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -11,92 +11,11 @@
 #include <memory.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <string.h>
 
 #include "lmr/lmr.h"
 
 const char program_name[] = "pcilmr";
 
-enum mode { MARGIN, FULL, SCAN };
-
-static const char usage_msg[]
-  = "! Utility requires preliminary preparation of the system. Refer to the pcilmr man page !\n\n"
-    "Usage:\n"
-    "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
-    "pcilmr --full [<margining options>]\n"
-    "pcilmr --scan\n\n"
-    "Device Specifier:\n"
-    "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
-    "Modes:\n"
-    "--margin\t\tMargin selected Links\n"
-    "--full\t\t\tMargin all ready for testing Links in the system (one by one)\n"
-    "--scan\t\t\tScan for Links available for margining\n\n"
-    "Margining options:\n\n"
-    "Margining Test settings:\n"
-    "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
-    "-l <lane>[,<lane>...]\tSpecify lanes for margining. Default: all link lanes.\n"
-    "\t\t\tRemember that Device may use Lane Reversal for Lane numbering.\n"
-    "\t\t\tHowever, utility uses logical lane numbers in arguments and for logging.\n"
-    "\t\t\tUtility will automatically determine Lane Reversal and tune its calls.\n"
-    "-e <errors>\t\tSpecify Error Count Limit for margining. Default: 4.\n"
-    "-r <recvn>[,<recvn>...]\tSpecify Receivers to select margining targets.\n"
-    "\t\t\tDefault: all available Receivers (including Retimers).\n"
-    "-p <parallel_lanes>\tSpecify number of lanes to margin simultaneously.\n"
-    "\t\t\tDefault: 1.\n"
-    "\t\t\tAccording to spec it's possible for Receiver to margin up\n"
-    "\t\t\tto MaxLanes + 1 lanes simultaneously, but usually this works\n"
-    "\t\t\tbad, so this option is for experiments mostly.\n"
-    "-T\t\t\tTime Margining will continue until the Error Count is no more\n"
-    "\t\t\tthan an Error Count Limit. Use this option to find Link limit.\n"
-    "-V\t\t\tSame as -T option, but for Voltage.\n"
-    "-t <steps>\t\tSpecify maximum number of steps for Time Margining.\n"
-    "-v <steps>\t\tSpecify maximum number of steps for Voltage Margining.\n"
-    "Use only one of -T/-t options at the same time (same for -V/-v).\n"
-    "Without these options utility will use MaxSteps from Device\n"
-    "capabilities as test limit.\n\n"
-    "Margining Log settings:\n"
-    "-o <directory>\t\tSave margining results in csv form into the\n"
-    "\t\t\tspecified directory. Utility will generate file with the\n"
-    "\t\t\tname in form of 'lmr_<downstream component>_Rx#_<timestamp>.csv'\n"
-    "\t\t\tfor each successfully tested receiver.\n";
-
-static struct pci_dev *
-dev_for_filter(struct pci_access *pacc, char *filter)
-{
-  struct pci_filter pci_filter;
-  pci_filter_init(pacc, &pci_filter);
-  if (pci_filter_parse_slot(&pci_filter, filter))
-    die("Invalid device ID: %s\n", filter);
-
-  if (pci_filter.bus == -1 || pci_filter.slot == -1 || pci_filter.func == -1)
-    die("Invalid device ID: %s\n", filter);
-
-  if (pci_filter.domain == -1)
-    pci_filter.domain = 0;
-
-  for (struct pci_dev *p = pacc->devices; p; p = p->next)
-    {
-      if (pci_filter_match(&pci_filter, p))
-        return p;
-    }
-
-  die("No such PCI device: %s or you don't have enough privileges.\n", filter);
-}
-
-static u8
-parse_csv_arg(char *arg, u8 *vals)
-{
-  u8 cnt = 0;
-  char *token = strtok(arg, ",");
-  while (token)
-    {
-      vals[cnt] = atoi(token);
-      cnt++;
-      token = strtok(NULL, ",");
-    }
-  return cnt;
-}
-
 static void
 scan_links(struct pci_access *pacc, bool only_ready)
 {
@@ -129,72 +48,21 @@ scan_links(struct pci_access *pacc, bool only_ready)
   exit(0);
 }
 
-static u8
-find_ready_links(struct pci_access *pacc, struct pci_dev **down_ports, struct pci_dev **up_ports,
-                 bool cnt_only)
-{
-  u8 cnt = 0;
-  for (struct pci_dev *p = pacc->devices; p; p = p->next)
-    {
-      if (pci_find_cap(p, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED) && margin_port_is_down(p))
-        {
-          struct pci_dev *down = NULL;
-          struct pci_dev *up = NULL;
-          margin_find_pair(pacc, p, &down, &up);
-
-          if (down && margin_verify_link(down, up)
-              && (margin_check_ready_bit(down) || margin_check_ready_bit(up)))
-            {
-              if (!cnt_only)
-                {
-                  up_ports[cnt] = up;
-                  down_ports[cnt] = down;
-                }
-              cnt++;
-            }
-        }
-    }
-  return cnt;
-}
-
 int
 main(int argc, char **argv)
 {
   struct pci_access *pacc;
 
-  struct pci_dev **up_ports;
-  struct pci_dev **down_ports;
-  u8 ports_n = 0;
-
+  u8 links_n = 0;
   struct margin_link *links;
   bool *checks_status_ports;
 
-  bool status = true;
-  enum mode mode;
+  enum margin_mode mode;
 
   /* each link has several receivers -> several results */
   struct margin_results **results;
   u8 *results_n;
 
-  struct margin_args *args;
-
-  u8 steps_t_arg = 0;
-  u8 steps_v_arg = 0;
-  u8 parallel_lanes_arg = 1;
-  u8 error_limit = 4;
-  u8 lanes_arg[32];
-  u8 recvs_arg[6];
-
-  u8 lanes_n = 0;
-  u8 recvs_n = 0;
-
-  bool run_margin = true;
-
-  char *dir_for_csv = NULL;
-  bool save_csv = false;
-
-  u64 total_steps = 0;
-
   pacc = pci_alloc();
   pci_init(pacc);
   pci_scan_bus(pacc);
@@ -217,8 +85,9 @@ main(int argc, char **argv)
         { .name = "full", .has_arg = no_argument, .flag = NULL, .val = 2 },
         { 0, 0, 0, 0 } };
 
+  opterr = 0;
   int c;
-  c = getopt_long(argc, argv, ":", long_options, NULL);
+  c = getopt_long(argc, argv, "+", long_options, NULL);
 
   switch (c)
     {
@@ -231,7 +100,8 @@ main(int argc, char **argv)
         mode = SCAN;
         if (optind == argc)
           scan_links(pacc, false);
-        optind--;
+        else
+          die("Invalid arguments\n\n%s", usage);
         break;
       case 2:
         mode = FULL;
@@ -242,128 +112,20 @@ main(int argc, char **argv)
         break;
     }
 
-  while ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VTo:")) != -1)
-    {
-      switch (c)
-        {
-          case 't':
-            steps_t_arg = atoi(optarg);
-            break;
-          case 'T':
-            steps_t_arg = 63;
-            break;
-          case 'v':
-            steps_v_arg = atoi(optarg);
-            break;
-          case 'V':
-            steps_v_arg = 127;
-            break;
-          case 'p':
-            parallel_lanes_arg = atoi(optarg);
-            break;
-          case 'c':
-            run_margin = false;
-            break;
-          case 'l':
-            lanes_n = parse_csv_arg(optarg, lanes_arg);
-            break;
-          case 'e':
-            error_limit = atoi(optarg);
-            break;
-          case 'r':
-            recvs_n = parse_csv_arg(optarg, recvs_arg);
-            break;
-          case 'o':
-            dir_for_csv = optarg;
-            save_csv = true;
-            break;
-          default:
-            die("Invalid arguments\n\n%s", usage_msg);
-        }
-    }
-
-  if (mode == FULL && optind != argc)
-    status = false;
-  if (mode == MARGIN && optind == argc)
-    status = false;
-  if (!status && argc > 1)
-    die("Invalid arguments\n\n%s", usage_msg);
-  if (!status)
-    {
-      printf("%s", usage_msg);
-      exit(0);
-    }
-
-  if (mode == FULL)
-    {
-      ports_n = find_ready_links(pacc, NULL, NULL, true);
-      if (ports_n == 0)
-        {
-          die("Links not found or you don't have enough privileges.\n");
-        }
-      else
-        {
-          up_ports = xmalloc(ports_n * sizeof(*up_ports));
-          down_ports = xmalloc(ports_n * sizeof(*down_ports));
-          find_ready_links(pacc, down_ports, up_ports, false);
-        }
-    }
-  else if (mode == MARGIN)
-    {
-      ports_n = argc - optind;
-      up_ports = xmalloc(ports_n * sizeof(*up_ports));
-      down_ports = xmalloc(ports_n * sizeof(*down_ports));
-
-      u8 cnt = 0;
-      while (optind != argc)
-        {
-          struct pci_dev *dev = dev_for_filter(pacc, argv[optind]);
-          if (!margin_find_pair(pacc, dev, &(down_ports[cnt]), &(up_ports[cnt])))
-            die("Cannot find pair for the specified device: %s\n", argv[optind]);
-          cnt++;
-          optind++;
-        }
-    }
-  else
-    die("Bug in the args parsing!\n");
+  opterr = 1;
 
-  if (!pci_find_cap(up_ports[0], PCI_CAP_ID_EXP, PCI_CAP_NORMAL))
-    die("Looks like you don't have enough privileges to access "
-        "Device Configuration Space.\nTry to run utility as root.\n");
+  links = margin_parse_util_args(pacc, argc, argv, mode, &links_n);
+  struct margin_com_args *com_args = links[0].args.common;
 
-  results = xmalloc(ports_n * sizeof(*results));
-  results_n = xmalloc(ports_n * sizeof(*results_n));
-  links = xmalloc(ports_n * sizeof(*links));
-  checks_status_ports = xmalloc(ports_n * sizeof(*checks_status_ports));
-  args = xmalloc(ports_n * sizeof(*args));
+  results = xmalloc(links_n * sizeof(*results));
+  results_n = xmalloc(links_n * sizeof(*results_n));
+  checks_status_ports = xmalloc(links_n * sizeof(*checks_status_ports));
 
-  for (int i = 0; i < ports_n; i++)
+  for (int i = 0; i < links_n; i++)
     {
-      args[i].error_limit = error_limit;
-      args[i].parallel_lanes = parallel_lanes_arg;
-      args[i].run_margin = run_margin;
-      args[i].verbosity = 1;
-      args[i].steps_t = steps_t_arg;
-      args[i].steps_v = steps_v_arg;
-      for (int j = 0; j < recvs_n; j++)
-        args[i].recvs[j] = recvs_arg[j];
-      args[i].recvs_n = recvs_n;
-      for (int j = 0; j < lanes_n; j++)
-        args[i].lanes[j] = lanes_arg[j];
-      args[i].lanes_n = lanes_n;
-      args[i].steps_utility = &total_steps;
-
       enum margin_test_status args_status;
 
-      if (!margin_fill_link(down_ports[i], up_ports[i], &links[i]))
-        {
-          checks_status_ports[i] = false;
-          results[i] = xmalloc(sizeof(*results[i]));
-          results[i]->test_status = MARGIN_TEST_PREREQS;
-          continue;
-        }
-
-      if ((args_status = margin_process_args(&links[i].down_port, &args[i])) != MARGIN_TEST_OK)
+      if ((args_status = margin_process_args(&links[i])) != MARGIN_TEST_OK)
         {
           checks_status_ports[i] = false;
           results[i] = xmalloc(sizeof(*results[i]));
@@ -373,49 +135,44 @@ main(int argc, char **argv)
 
       checks_status_ports[i] = true;
       struct margin_params params;
+      struct margin_link_args *link_args = &links[i].args;
 
-      for (int j = 0; j < args[i].recvs_n; j++)
+      for (int j = 0; j < link_args->recvs_n; j++)
         {
-          if (margin_read_params(pacc, args[i].recvs[j] == 6 ? up_ports[i] : down_ports[i],
-                                 args[i].recvs[j], &params))
+          if (margin_read_params(
+                pacc, link_args->recvs[j] == 6 ? links[i].up_port.dev : links[i].down_port.dev,
+                link_args->recvs[j], &params))
             {
-              u8 steps_t = steps_t_arg ? steps_t_arg : params.timing_steps;
-              u8 steps_v = steps_v_arg ? steps_v_arg : params.volt_steps;
-              u8 parallel_recv = parallel_lanes_arg > params.max_lanes + 1 ? params.max_lanes + 1 :
-                                                                             parallel_lanes_arg;
+              u8 steps_t = link_args->steps_t ? link_args->steps_t : params.timing_steps;
+              u8 steps_v = link_args->steps_v ? link_args->steps_v : params.volt_steps;
+              u8 parallel_recv = link_args->parallel_lanes > params.max_lanes + 1 ?
+                                   params.max_lanes + 1 :
+                                   link_args->parallel_lanes;
 
               u8 step_multiplier
-                = args[i].lanes_n / parallel_recv + ((args[i].lanes_n % parallel_recv) > 0);
+                = link_args->lanes_n / parallel_recv + ((link_args->lanes_n % parallel_recv) > 0);
 
-              total_steps += steps_t * step_multiplier;
+              com_args->steps_utility += steps_t * step_multiplier;
               if (params.ind_left_right_tim)
-                total_steps += steps_t * step_multiplier;
+                com_args->steps_utility += steps_t * step_multiplier;
               if (params.volt_support)
                 {
-                  total_steps += steps_v * step_multiplier;
+                  com_args->steps_utility += steps_v * step_multiplier;
                   if (params.ind_up_down_volt)
-                    total_steps += steps_v * step_multiplier;
+                    com_args->steps_utility += steps_v * step_multiplier;
                 }
             }
         }
     }
 
-  for (int i = 0; i < ports_n; i++)
+  for (int i = 0; i < links_n; i++)
     {
       if (checks_status_ports[i])
-        results[i] = margin_test_link(&links[i], &args[i], &results_n[i]);
+        results[i] = margin_test_link(&links[i], &results_n[i]);
       else
         {
           results_n[i] = 1;
-          if (results[i]->test_status == MARGIN_TEST_PREREQS)
-            {
-              printf("Link ");
-              margin_log_bdfs(down_ports[i], up_ports[i]);
-              printf(" is not ready for margining.\n"
-                     "Link data rate must be 16 GT/s or 32 GT/s.\n"
-                     "Downstream Component must be at D0 PM state.\n");
-            }
-          else if (results[i]->test_status == MARGIN_TEST_ARGS_RECVS)
+          if (results[i]->test_status == MARGIN_TEST_ARGS_RECVS)
             {
               margin_log_link(&links[i]);
               printf("\nInvalid RecNums specified.\n");
@@ -429,7 +186,7 @@ main(int argc, char **argv)
       printf("\n----\n\n");
     }
 
-  if (run_margin)
+  if (com_args->run_margin)
     {
       printf("Results:\n");
       printf("\nPass/fail criteria:\nTiming:\n");
@@ -442,27 +199,25 @@ main(int argc, char **argv)
       printf("THR -\tThe set (using the utility options) \n\tstep threshold has been reached\n\n");
       printf("Notations:\nst - steps\n\n");
 
-      for (int i = 0; i < ports_n; i++)
+      for (int i = 0; i < links_n; i++)
         {
           printf("Link ");
-          margin_log_bdfs(down_ports[i], up_ports[i]);
+          margin_log_bdfs(links[i].down_port.dev, links[i].up_port.dev);
           printf(":\n\n");
           margin_results_print_brief(results[i], results_n[i]);
-          if (save_csv)
-            margin_results_save_csv(results[i], results_n[i], dir_for_csv, up_ports[i]);
+          if (com_args->save_csv)
+            margin_results_save_csv(results[i], results_n[i], &links[i]);
           printf("\n");
         }
     }
 
-  for (int i = 0; i < ports_n; i++)
+  for (int i = 0; i < links_n; i++)
     margin_free_results(results[i], results_n[i]);
   free(results_n);
   free(results);
-  free(up_ports);
-  free(down_ports);
+  free(com_args);
   free(links);
   free(checks_status_ports);
-  free(args);
 
   pci_cleanup(pacc);
   return 0;
-- 
2.34.1


