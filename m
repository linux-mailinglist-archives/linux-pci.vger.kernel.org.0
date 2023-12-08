Return-Path: <linux-pci+bounces-666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30E809F48
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843D61F21873
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F3A12B61;
	Fri,  8 Dec 2023 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="c0i5pr44";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="vWyzQjVg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93297172E
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 4F8C3C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027164; bh=TDXUaAD4I2Gu4wkb3jz18stslWeLsm+pvV8uzltOp70=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=c0i5pr44OdKpy26pFlD8Cr4GNUMvj8DZn9pwswjNDpxIoBl6RVzL9bxB56RaD/PMc
	 Odp+ol8MhToHPV/cAmUlIihPzthYMApwekMJISYftdiXiRjhYsd2+1M5tELItcPFsz
	 3oC10VRzEBH+9e22mI1ExU2+WYREmtiLN/T7ny7hlXL3eQ4OwJMPsNft48dBQfeDqv
	 MCiCEOlE4GlNbK9gcLY0SJ1r9sUFPWXjOQxO4i3bR51wtssuollmNc+XED1kMscVtw
	 DU1f4o8p8nXgCFRC/r9Ef1Sj+iTTW3xs68ARvLn0vVKs21IrCy5BVIZkXtwaR3UsdZ
	 Jc5Wd9QVOFteg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027164; bh=TDXUaAD4I2Gu4wkb3jz18stslWeLsm+pvV8uzltOp70=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=vWyzQjVgq0It6Y6vTkSceAR4tWaLsRsUuOVOY3y+VX7fLv8kY1QuDp06c/hynp8CN
	 x+33UJM7+ANSs12RjA8NlutI+xoIS5WiD/XuaeeMB8nvYYK1aZ7WcdeuiCNk41Jbmq
	 rp9eNeFgndSRgTbjAnCMOm2eOH97TUsheuPGGj8G61MDBB5nI/uzJ6fHeatlwQMG91
	 ijLsP5px+yNYh1ryQibKrxaQS8W9nhVyfOv+dSQE2KLuRIGnLZOozQW5BTHt7xyxDd
	 QE0WhGMImrw2M0UZhHsUFy5piJlf/hk50BSrzsfikHOuoCNe7JHfN4xEHiC/lFRyn4
	 hUp/70qx1D/ng==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 09/15] pciutils-pcilmr: Add utility main function
Date: Fri, 8 Dec 2023 12:17:28 +0300
Message-ID: <20231208091734.12225-10-n.proshkin@yadro.com>
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

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 Makefile |   8 +-
 pcilmr.c | 322 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 328 insertions(+), 2 deletions(-)
 create mode 100644 pcilmr.c

diff --git a/Makefile b/Makefile
index bd636bd..efec2da 100644
--- a/Makefile
+++ b/Makefile
@@ -67,7 +67,7 @@ PCIINC_INS=lib/config.h lib/header.h lib/pci.h lib/types.h
 
 export
 
-all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) lmr_lib/liblmr.a
+all: lib/$(PCIIMPLIB) lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lspci.8 setpci.8 pcilib.7 pci.ids.5 update-pciids update-pciids.8 $(PCI_IDS) lmr_lib/liblmr.a pcilmr
 
 lib/$(PCIIMPLIB): $(PCIINC) force
 	$(MAKE) -C lib all
@@ -113,6 +113,10 @@ update-pciids: update-pciids.sh
 example$(EXEEXT): example.o lib/$(PCIIMPLIB)
 example.o: example.c $(PCIINC)
 
+PCILMRINC=margin.h margin_results.h margin_log.h
+pcilmr: pcilmr.o lib/$(PCIIMPLIB) lmr_lib/liblmr.a
+pcilmr.o: pcilmr.c $(addprefix lmr_lib/,$(PCILMRINC)) $(PCIINC)
+
 %$(EXEEXT): %.o
 	$(CC) $(LDFLAGS) $(TARGET_ARCH) $^ $(LDLIBS) -o $@
 
@@ -144,7 +148,7 @@ TAGS:
 
 clean:
 	rm -f `find . -name "*~" -o -name "*.[oa]" -o -name "\#*\#" -o -name TAGS -o -name core -o -name "*.orig"`
-	rm -f update-pciids lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lib/config.* *.[578] pci.ids.gz lib/*.pc lib/*.so lib/*.so.* lib/*.dll lib/*.def lib/dllrsrc.rc *-rsrc.rc tags
+	rm -f update-pciids lspci$(EXEEXT) setpci$(EXEEXT) example$(EXEEXT) lib/config.* *.[578] pci.ids.gz lib/*.pc lib/*.so lib/*.so.* lib/*.dll lib/*.def lib/dllrsrc.rc *-rsrc.rc tags pcilmr
 	rm -rf maint/dist
 
 distclean: clean
diff --git a/pcilmr.c b/pcilmr.c
new file mode 100644
index 0000000..bbab276
--- /dev/null
+++ b/pcilmr.c
@@ -0,0 +1,322 @@
+#include <memory.h>
+#include <getopt.h>
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "lmr_lib/margin.h"
+#include "lmr_lib/margin_results.h"
+#include "lmr_lib/margin_log.h"
+
+static void usage(void)
+{
+  printf("Usage:\n"
+         "pcilmr [<margining options>] <downstream component>\n\n"
+         "Device Specifier:\n"
+         "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
+         "Margining options:\n\n"
+         "Margining Test settings:\n"
+         "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
+         "-l <lane>[,<lane>...]\tSpecify lanes for margining. Default: all link lanes.\n"
+         "\t\t\tRemember that Device may use Lane Reversal for Lane numbering.\n"
+         "\t\t\tHowever, utility uses logical lane numbers in arguments and for logging.\n"
+         "\t\t\tUtility will automatically determine Lane Reversal and tune its calls.\n"
+         "-e <errors>\t\tSpecify Error Count Limit for margining. Default: 4.\n"
+         "-r <recvn>[,<recvn>...]\tSpecify Receivers to select margining targets.\n"
+         "\t\t\tDefault: all available Receivers (including Retimers).\n"
+         "-p <parallel_lanes>\tSpecify number of lanes to margin simultaneously.\n"
+         "\t\t\tDefault: 1.\n"
+         "\t\t\tAccording to spec it's possible for Receiver to margin up\n"
+         "\t\t\tto MaxLanes + 1 lanes simultaneously, but usually this works\n"
+         "\t\t\tbad, so this option is for experiments mostly.\n"
+         "-T\t\t\tTime Margining will continue until the Error Count is no more\n"
+         "\t\t\tthan an Error Count Limit. Use this option to find Link limit.\n"
+         "-V\t\t\tSame as -T option, but for Voltage.\n"
+         "-t <steps>\t\tSpecify maximum number of steps for Time Margining.\n"
+         "-v <steps>\t\tSpecify maximum number of steps for Voltage Margining.\n"
+         "Use only one of -T/-t options at the same time (same for -V/-v).\n"
+         "Without these options utility will use MaxSteps from Device\n"
+         "capabilities as test limit.\n\n");
+}
+
+static struct pci_dev *dev_for_filter(struct pci_access *pacc, char *filter)
+{
+  struct pci_filter pci_filter;
+  char dev[17];
+  strncpy(dev, filter, 16);
+  pci_filter_init(pacc, &pci_filter);
+  if (pci_filter_parse_slot(&pci_filter, dev))
+  {
+    printf("Invalid device ID: %s\n", filter);
+    return NULL;
+  }
+
+  if (pci_filter.bus == -1 || pci_filter.slot == -1 || pci_filter.func == -1)
+  {
+    printf("Invalid device ID: %s\n", filter);
+    return NULL;
+  }
+
+  if (pci_filter.domain == -1)
+    pci_filter.domain = 0;
+
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
+  {
+    if (pci_filter_match(&pci_filter, p))
+    {
+      return p;
+    }
+  }
+  printf("No such PCI device: %s or you don't have enough privileges.\n", filter);
+  return NULL;
+}
+
+static struct pci_dev *find_down_port_for_up(struct pci_access *pacc, struct pci_dev *up)
+{
+  struct pci_dev *down = NULL;
+  for (struct pci_dev *p = pacc->devices; p; p = p->next)
+  {
+    if (pci_read_byte(p, PCI_SECONDARY_BUS) == up->bus && up->domain == p->domain)
+    {
+      down = p;
+      break;
+    }
+  }
+  return down;
+}
+
+static uint8_t parse_csv_arg(char *arg, uint8_t *lanes)
+{
+  uint8_t cnt = 0;
+  char *token = strtok(arg, ",");
+  while (token)
+  {
+    lanes[cnt] = atoi(token);
+    cnt++;
+    token = strtok(NULL, ",");
+  }
+  return cnt;
+}
+
+int main(int argc, char **argv)
+{
+  struct pci_access *pacc;
+
+  struct pci_dev *up_port;
+  struct pci_dev *down_port;
+
+  struct margin_dev wrapper_up;
+  struct margin_dev wrapper_down;
+
+  bool status = true;
+
+  struct margin_results *results;
+  uint8_t results_n;
+
+  struct margin_args args;
+
+  int8_t steps_t_arg = -1;
+  int8_t steps_v_arg = -1;
+  int8_t parallel_lanes_arg = 1;
+  uint8_t error_limit = 4;
+
+  int8_t lanes_n = -1;
+  int8_t recvs_n = -1;
+
+  bool run_margin = true;
+
+  uint64_t total_steps = 0;
+
+  pacc = pci_alloc();
+  pci_init(pacc);
+  pci_scan_bus(pacc);
+
+  margin_print_domain = false;
+  for (struct pci_dev *dev = pacc->devices; dev; dev = dev->next)
+  {
+    if (dev->domain != 0)
+    {
+      margin_print_domain = true;
+      break;
+    }
+  }
+
+  margin_global_logging = true;
+
+  int c;
+
+  while (status && ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VT")) != -1))
+  {
+    switch (c)
+    {
+    case 't':
+      steps_t_arg = atoi(optarg);
+      break;
+    case 'T':
+      steps_t_arg = 63;
+      break;
+    case 'v':
+      steps_v_arg = atoi(optarg);
+      break;
+    case 'V':
+      steps_v_arg = 127;
+      break;
+    case 'p':
+      parallel_lanes_arg = atoi(optarg);
+      break;
+    case 'c':
+      run_margin = false;
+      break;
+    case 'l':
+      lanes_n = parse_csv_arg(optarg, args.lanes);
+      break;
+    case 'e':
+      error_limit = atoi(optarg);
+      break;
+    case 'r':
+      recvs_n = parse_csv_arg(optarg, args.recvs);
+      break;
+    default:
+      printf("Invalid arguments\n");
+      status = false;
+      usage();
+    }
+  }
+
+  if (status)
+  {
+    if (optind != argc - 1)
+      status = false;
+    if (!status && argc > 1)
+      printf("Invalid arguments\n");
+    if (!status)
+      usage();
+  }
+
+  if (status)
+  {
+    if ((up_port = dev_for_filter(pacc, argv[argc - 1])) == NULL)
+    {
+      status = false;
+    }
+  }
+
+  if (status)
+  {
+    down_port = find_down_port_for_up(pacc, up_port);
+    status = down_port != NULL;
+    if (!status)
+      printf("Cannot find Upstream Component for the specified device\n");
+  }
+
+  if (status)
+  {
+    if (!pci_find_cap(up_port, PCI_CAP_ID_EXP, PCI_CAP_NORMAL))
+    {
+      status = false;
+      printf("Looks like you don't have enough privileges to access "
+             "Device Configuration Space.\nTry to run utility as root.\n");
+    }
+  }
+
+  if (status)
+  {
+    if (!margin_verify_link(down_port, up_port))
+    {
+      printf("Link ");
+      margin_log_bdfs(down_port, up_port);
+      printf(" is not ready for margining.\n"
+             "Link must be at Gen 4/5 speed.\n"
+             "Downstream Component must be at D0 PM state.\n");
+      status = false;
+    }
+    else
+    {
+      wrapper_down = margin_fill_wrapper(down_port);
+      wrapper_up = margin_fill_wrapper(up_port);
+    }
+  }
+
+  if (status)
+  {
+    args.error_limit = error_limit;
+    args.lanes_n = lanes_n;
+    args.recvs_n = recvs_n;
+    args.steps_t = steps_t_arg;
+    args.steps_v = steps_v_arg;
+    args.parallel_lanes = parallel_lanes_arg;
+    args.run_margin = run_margin;
+    args.verbosity = 1;
+    args.steps_margin_remaining = &total_steps;
+
+    enum margin_test_status args_status;
+
+    if ((args_status = margin_process_args(&wrapper_down, &args)) != MARGIN_TEST_OK)
+    {
+      status = false;
+      margin_log_link(&wrapper_down, &wrapper_up);
+      if (args_status == MARGIN_TEST_ARGS_RECVS)
+      {
+        margin_log("\nInvalid RecNums specified.\n");
+      }
+      else if (args_status == MARGIN_TEST_ARGS_LANES)
+      {
+        margin_log("\nInvalid lanes specified.\n");
+      }
+    }
+  }
+
+  if (status)
+  {
+    struct margin_recv caps;
+
+    for (uint8_t i = 0; i < args.recvs_n; i++)
+    {
+      if (margin_read_params_standalone(pacc,
+                                        args.recvs[i] == 6 ? up_port : down_port,
+                                        args.recvs[i], &caps))
+      {
+        uint8_t steps_t = steps_t_arg == -1 ? caps.timing_steps : steps_t_arg;
+        uint8_t steps_v = steps_v_arg == -1 ? caps.volt_steps : steps_v_arg;
+        uint8_t parallel_recv = parallel_lanes_arg > caps.max_lanes + 1 ? caps.max_lanes + 1 : parallel_lanes_arg;
+
+        uint8_t step_multiplier = args.lanes_n / parallel_recv + ((args.lanes_n % parallel_recv) > 0);
+
+        total_steps += steps_t * step_multiplier;
+        if (caps.ind_left_right_tim)
+          total_steps += steps_t * step_multiplier;
+        if (caps.volt_support)
+        {
+          total_steps += steps_v * step_multiplier;
+          if (caps.ind_up_down_volt)
+            total_steps += steps_v * step_multiplier;
+        }
+      }
+    }
+  }
+
+  if (status)
+  {
+    results = margin_link(&wrapper_down, &wrapper_up, &args, &results_n);
+    status = (results != NULL);
+  }
+
+  if (status && run_margin)
+  {
+    printf("\nResults:\n");
+    printf("\nPass/fail criteria:\nTiming:\n");
+    printf("Minimum Offset (spec): %d %% UI\nRecommended Offset: %d %% UI\n", MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND);
+    printf("\nVoltage:\nMinimum Offset (spec): %d mV\n\n", MARGIN_VOLT_MIN);
+    printf("Margining statuses:\nLIM -\tErrorCount exceeded Error Count Limit (found device limit)\n");
+    printf("NAK -\tDevice didn't execute last command, \n\tso result may be less reliable\n");
+    printf("THR -\tThe set (using the utility options) \n\tstep threshold has been reached\n\n");
+    printf("Notations:\nst - steps\n\n");
+
+    margin_results_print_brief(results, results_n);
+  }
+
+  if (status)
+    margin_free_results(results, results_n);
+
+  pci_cleanup(pacc);
+  return 0;
+}
-- 
2.34.1


