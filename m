Return-Path: <linux-pci+bounces-658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C6809F3F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C850A1F21831
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4CC125DD;
	Fri,  8 Dec 2023 09:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="b3+1lLd0";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="eDl+8M0k"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502C51723
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 8CBEFC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027154; bh=NBsL3gbmdanLz8+vb3lTWwIl5Vnf1pCPSxGsZJBN9iw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=b3+1lLd0pOUnQJ0BUkE2CrQawnKf/7U+bsMImirCUp51yXPrn+J0QT+8cOrZN/MOH
	 lbd/v53zTJ1r74WwW5MCqqYdoqVJJmAnacdisr/0W8pP4N4b15Trr/t+hXJ+bk5dpO
	 qOGsa8a6mbb3IHSwdbqSw0EZf8j4PgoMNi2wfILVFAGPXC7e8HquIAw69PVWxcfba7
	 SIZglfIB5cujfbn/wVpyNilK5XZyJg+evqAyNrBC4HJI1qw+eTDUsvMg1sz9lopgjA
	 KYEqbjWSdPCQZ0xsnvT24ewiJS7Mo21bqmp9XE+9zEygNgR7rQ6v+W+2Hx+211DcJL
	 qXr4vP2JZ7MNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027154; bh=NBsL3gbmdanLz8+vb3lTWwIl5Vnf1pCPSxGsZJBN9iw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=eDl+8M0kJgi9ZWf99Goeca5WcD5aYpcTnl1Ktzlsv8PYheSq/u6vg631n8QiRyJUG
	 jj940hmxRsNiMa744Pe7YGJkqSgHGzrj+/ioY0TjPjqXEx9Lz+UBXj8hOHXB734kEV
	 NMOuYGDb1RXzIRDPV/L+sZXVDb3z00RFOW79g5IkAPHsci+ewxouFdpuOFMy5dE3eu
	 7UiWnDBnGd+iyO9a7pWFhYVDlwPiRkD1Ygk2C2y1uNz+SwGPjH0eZAm84EoMdNuIG6
	 wkIiw5Ab7U4YAUNpNgQO9s9cEd5QqdTYlofJ0bZJ6b9vg5wjWKx104eHd3R9/afABD
	 C/8ywsqZvtlCw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 11/15] pciutils-pcilmr: Add the ability to pass multiple links to the utility
Date: Fri, 8 Dec 2023 12:17:30 +0300
Message-ID: <20231208091734.12225-12-n.proshkin@yadro.com>
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

* Add support for different utility modes;
* Make the default (now --margin) mode capable to accept several
  components and run test for all of them;
* Add --full mode for sequential start of the test on all ready links
  in the system;
* The complication of the main function is due to the need to pre-read the
  parameters of the devices before starting the tests in order to calculate
  Total ETA of the utility.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 pcilmr.c | 316 +++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 235 insertions(+), 81 deletions(-)

diff --git a/pcilmr.c b/pcilmr.c
index bbab276..ed37a05 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -7,12 +7,21 @@
 #include "lmr_lib/margin_results.h"
 #include "lmr_lib/margin_log.h"
 
+enum mode {
+  MARGIN,
+  FULL
+};
+
 static void usage(void)
 {
   printf("Usage:\n"
-         "pcilmr [<margining options>] <downstream component>\n\n"
+         "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
+         "pcilmr --full [<margining options>]\n\n"
          "Device Specifier:\n"
          "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
+         "Modes:\n"
+         "--margin\t\tMargin selected Links\n"
+         "--full\t\t\tMargin all ready for testing Links in the system (one by one)\n"
          "Margining options:\n\n"
          "Margining Test settings:\n"
          "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
@@ -97,27 +106,58 @@ static uint8_t parse_csv_arg(char *arg, uint8_t *lanes)
   return cnt;
 }
 
+static uint8_t find_ready_links(struct pci_access *pacc, struct pci_dev **down_ports, 
+                                struct pci_dev **up_ports, bool cnt_only)
+{
+  uint8_t cnt = 0;
+  for (struct pci_dev *up = pacc->devices; up; up = up->next)
+  {
+    if (pci_find_cap(up, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED))
+    {
+      struct pci_dev *down = find_down_port_for_up(pacc, up);
+
+      if (down && margin_verify_link(down, up) &&
+          (margin_check_ready_bit(down) || margin_check_ready_bit(up)))
+      {
+        if (!cnt_only)
+        {
+          up_ports[cnt] = up;
+          down_ports[cnt] = down;
+        }
+        cnt++;
+      }
+    }
+  }
+  return cnt;
+}
+
 int main(int argc, char **argv)
 {
   struct pci_access *pacc;
 
-  struct pci_dev *up_port;
-  struct pci_dev *down_port;
+  struct pci_dev **up_ports;
+  struct pci_dev **down_ports;
+  uint8_t ports_n = 0;
 
-  struct margin_dev wrapper_up;
-  struct margin_dev wrapper_down;
+  struct margin_dev *wrappers_up;
+  struct margin_dev *wrappers_down;
+  bool *checks_status_ports;
 
   bool status = true;
+  enum mode mode;
 
-  struct margin_results *results;
-  uint8_t results_n;
+  /*each link has several receivers -> several results*/
+  struct margin_results **results;
+  uint8_t *results_n;
 
-  struct margin_args args;
+  struct margin_args *args;
 
   int8_t steps_t_arg = -1;
   int8_t steps_v_arg = -1;
   int8_t parallel_lanes_arg = 1;
   uint8_t error_limit = 4;
+  uint8_t lanes_arg[32];
+  uint8_t recvs_arg[6];
 
   int8_t lanes_n = -1;
   int8_t recvs_n = -1;
@@ -142,7 +182,29 @@ int main(int argc, char **argv)
 
   margin_global_logging = true;
 
+  struct option long_options[] = {
+      {.name = "margin", .has_arg = no_argument, .flag = NULL, .val = 0},
+      {.name = "full", .has_arg = no_argument, .flag = NULL, .val = 1},
+      {0, 0, 0, 0}};
+
   int c;
+  c = getopt_long(argc, argv, ":", long_options, NULL);
+
+  switch (c)
+  {
+  case -1: /*no options (strings like component are possible)*/
+    /* FALLTHROUGH */
+  case 0:
+    mode = MARGIN;
+    break;
+  case 1:
+    mode = FULL;
+    break;
+  default: /*unknown option symbol*/
+    mode = MARGIN;
+    optind--;
+    break;
+  }
 
   while (status && ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VT")) != -1))
   {
@@ -167,13 +229,13 @@ int main(int argc, char **argv)
       run_margin = false;
       break;
     case 'l':
-      lanes_n = parse_csv_arg(optarg, args.lanes);
+      lanes_n = parse_csv_arg(optarg, lanes_arg);
       break;
     case 'e':
       error_limit = atoi(optarg);
       break;
     case 'r':
-      recvs_n = parse_csv_arg(optarg, args.recvs);
+      recvs_n = parse_csv_arg(optarg, recvs_arg);
       break;
     default:
       printf("Invalid arguments\n");
@@ -184,7 +246,9 @@ int main(int argc, char **argv)
 
   if (status)
   {
-    if (optind != argc - 1)
+    if (mode == FULL && optind != argc)
+      status = false;
+    if (mode == MARGIN && optind == argc)
       status = false;
     if (!status && argc > 1)
       printf("Invalid arguments\n");
@@ -194,25 +258,58 @@ int main(int argc, char **argv)
 
   if (status)
   {
-    if ((up_port = dev_for_filter(pacc, argv[argc - 1])) == NULL)
+    if (mode == FULL)
     {
-      status = false;
+      ports_n = find_ready_links(pacc, NULL, NULL, true);
+      if (ports_n == 0)
+      {
+        printf("Links not found or you don't have enough privileges.\n");
+        status = false;
+      }
+      else
+      {
+        up_ports = malloc(ports_n * sizeof(*up_ports));
+        down_ports = malloc(ports_n * sizeof(*down_ports));
+        find_ready_links(pacc, down_ports, up_ports, false);
+      }
     }
-  }
+    else if (mode == MARGIN)
+    {
+      ports_n = argc - optind;
+      up_ports = malloc(ports_n * sizeof(*up_ports));
+      down_ports = malloc(ports_n * sizeof(*down_ports));
 
-  if (status)
-  {
-    down_port = find_down_port_for_up(pacc, up_port);
-    status = down_port != NULL;
-    if (!status)
-      printf("Cannot find Upstream Component for the specified device\n");
+      uint8_t cnt = 0;
+      while (optind != argc && status)
+      {
+        status = false;
+        if ((up_ports[cnt] = dev_for_filter(pacc, argv[optind])) == NULL)
+          break;
+        down_ports[cnt] = find_down_port_for_up(pacc, up_ports[cnt]);
+        status = down_ports[cnt] != NULL;
+        if (!status)
+          printf("Cannot find Upstream Component for the specified device\n");
+        cnt++;
+        optind++;
+      }
+
+      if (!status)
+      {
+        free(up_ports);
+        free(down_ports);
+      }
+    }
+    else
+      status = false;
   }
 
   if (status)
   {
-    if (!pci_find_cap(up_port, PCI_CAP_ID_EXP, PCI_CAP_NORMAL))
+    if (!pci_find_cap(up_ports[0], PCI_CAP_ID_EXP, PCI_CAP_NORMAL))
     {
       status = false;
+      free(up_ports);
+      free(down_ports);
       printf("Looks like you don't have enough privileges to access "
              "Device Configuration Space.\nTry to run utility as root.\n");
     }
@@ -220,75 +317,86 @@ int main(int argc, char **argv)
 
   if (status)
   {
-    if (!margin_verify_link(down_port, up_port))
-    {
-      printf("Link ");
-      margin_log_bdfs(down_port, up_port);
-      printf(" is not ready for margining.\n"
-             "Link must be at Gen 4/5 speed.\n"
-             "Downstream Component must be at D0 PM state.\n");
-      status = false;
-    }
-    else
-    {
-      wrapper_down = margin_fill_wrapper(down_port);
-      wrapper_up = margin_fill_wrapper(up_port);
-    }
+    results = malloc(ports_n * sizeof(*results));
+    results_n = malloc(ports_n * sizeof(*results_n));
+    wrappers_up = malloc(ports_n * sizeof(*wrappers_up));
+    wrappers_down = malloc(ports_n * sizeof(*wrappers_down));
+    checks_status_ports = malloc(ports_n * sizeof(*checks_status_ports));
+    args = malloc(ports_n * sizeof(*args));
   }
 
   if (status)
   {
-    args.error_limit = error_limit;
-    args.lanes_n = lanes_n;
-    args.recvs_n = recvs_n;
-    args.steps_t = steps_t_arg;
-    args.steps_v = steps_v_arg;
-    args.parallel_lanes = parallel_lanes_arg;
-    args.run_margin = run_margin;
-    args.verbosity = 1;
-    args.steps_margin_remaining = &total_steps;
-
-    enum margin_test_status args_status;
-
-    if ((args_status = margin_process_args(&wrapper_down, &args)) != MARGIN_TEST_OK)
+    for (uint8_t i = 0; i < ports_n; i++)
     {
-      status = false;
-      margin_log_link(&wrapper_down, &wrapper_up);
-      if (args_status == MARGIN_TEST_ARGS_RECVS)
+      args[i].error_limit = error_limit;
+      args[i].parallel_lanes = parallel_lanes_arg;
+      args[i].run_margin = run_margin;
+      args[i].verbosity = 1;
+      args[i].steps_t = steps_t_arg;
+      args[i].steps_v = steps_v_arg;
+      for (uint8_t j = 0; j < recvs_n; j++)
+        args[i].recvs[j] = recvs_arg[j];
+      args[i].recvs_n = recvs_n;
+      for (uint8_t j = 0; j < lanes_n; j++)
+        args[i].lanes[j] = lanes_arg[j];
+      args[i].lanes_n = lanes_n;
+      args[i].steps_margin_remaining = &total_steps;
+
+      bool local_status = true;
+      enum margin_test_status args_status;
+
+      if (!margin_verify_link(down_ports[i], up_ports[i]))
       {
-        margin_log("\nInvalid RecNums specified.\n");
+        local_status = false;
+        checks_status_ports[i] = false;
+        results[i] = malloc(sizeof(*results[i]));
+        results[i]->test_status = MARGIN_TEST_PREREQS;
       }
-      else if (args_status == MARGIN_TEST_ARGS_LANES)
+      else
       {
-        margin_log("\nInvalid lanes specified.\n");
+        wrappers_down[i] = margin_fill_wrapper(down_ports[i]);
+        wrappers_up[i] = margin_fill_wrapper(up_ports[i]);
       }
-    }
-  }
-
-  if (status)
-  {
-    struct margin_recv caps;
 
-    for (uint8_t i = 0; i < args.recvs_n; i++)
-    {
-      if (margin_read_params_standalone(pacc,
-                                        args.recvs[i] == 6 ? up_port : down_port,
-                                        args.recvs[i], &caps))
+      if (local_status)
       {
-        uint8_t steps_t = steps_t_arg == -1 ? caps.timing_steps : steps_t_arg;
-        uint8_t steps_v = steps_v_arg == -1 ? caps.volt_steps : steps_v_arg;
-        uint8_t parallel_recv = parallel_lanes_arg > caps.max_lanes + 1 ? caps.max_lanes + 1 : parallel_lanes_arg;
+        if ((args_status = margin_process_args(wrappers_down + i, args + i)) != MARGIN_TEST_OK)
+        {
+          local_status = false;
+          results[i] = malloc(sizeof(*results[i]));
+          results[i]->test_status = args_status;
+          checks_status_ports[i] = false;
+        }
+      }
 
-        uint8_t step_multiplier = args.lanes_n / parallel_recv + ((args.lanes_n % parallel_recv) > 0);
+      if (local_status)
+      {
+        checks_status_ports[i] = true;
+        struct margin_recv caps;
 
-        total_steps += steps_t * step_multiplier;
-        if (caps.ind_left_right_tim)
-          total_steps += steps_t * step_multiplier;
-        if (caps.volt_support)
+        for (uint8_t j = 0; j < args[i].recvs_n; j++)
         {
-          total_steps += steps_v * step_multiplier;
-          if (caps.ind_up_down_volt)
-            total_steps += steps_v * step_multiplier;
+          if (margin_read_params_standalone(pacc,
+                                            args[i].recvs[j] == 6 ? up_ports[i] : down_ports[i], 
+                                            args[i].recvs[j], &caps))
+          {
+            uint8_t steps_t = steps_t_arg == -1 ? caps.timing_steps : steps_t_arg;
+            uint8_t steps_v = steps_v_arg == -1 ? caps.volt_steps : steps_v_arg;
+            uint8_t parallel_recv = parallel_lanes_arg > caps.max_lanes + 1 ? caps.max_lanes + 1 : parallel_lanes_arg;
+
+            uint8_t step_multiplier = args[i].lanes_n / parallel_recv + ((args[i].lanes_n % parallel_recv) > 0);
+
+            total_steps += steps_t * step_multiplier;
+            if (caps.ind_left_right_tim)
+              total_steps += steps_t * step_multiplier;
+            if (caps.volt_support)
+            {
+              total_steps += steps_v * step_multiplier;
+              if (caps.ind_up_down_volt)
+                total_steps += steps_v * step_multiplier;
+            }
+          }
         }
       }
     }
@@ -296,13 +404,41 @@ int main(int argc, char **argv)
 
   if (status)
   {
-    results = margin_link(&wrapper_down, &wrapper_up, &args, &results_n);
-    status = (results != NULL);
+    for (uint8_t i = 0; i < ports_n; i++)
+    {
+      if (checks_status_ports[i])
+      {
+        results[i] = margin_link(wrappers_down + i, wrappers_up + i, args + i, results_n + i);
+      }
+      else
+      {
+        results_n[i] = 1;
+        if (results[i]->test_status == MARGIN_TEST_PREREQS)
+        {
+          printf("Link ");
+          margin_log_bdfs(down_ports[i], up_ports[i]);
+          printf(" is not ready for margining.\n"
+                 "Link must be at Gen 4/5 speed.\n"
+                 "Downstream Component must be at D0 PM state.\n");
+        }
+        else if (results[i]->test_status == MARGIN_TEST_ARGS_RECVS)
+        {
+          margin_log_link(wrappers_down + i, wrappers_up + i);
+          printf("\nInvalid RecNums specified.\n");
+        }
+        else if (results[i]->test_status == MARGIN_TEST_ARGS_LANES)
+        {
+          margin_log_link(wrappers_down + i, wrappers_up + i);
+          printf("\nInvalid lanes specified.\n");
+        }
+      }
+      printf("\n----\n\n");
+    }
   }
 
   if (status && run_margin)
   {
-    printf("\nResults:\n");
+    printf("Results:\n");
     printf("\nPass/fail criteria:\nTiming:\n");
     printf("Minimum Offset (spec): %d %% UI\nRecommended Offset: %d %% UI\n", MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND);
     printf("\nVoltage:\nMinimum Offset (spec): %d mV\n\n", MARGIN_VOLT_MIN);
@@ -311,11 +447,29 @@ int main(int argc, char **argv)
     printf("THR -\tThe set (using the utility options) \n\tstep threshold has been reached\n\n");
     printf("Notations:\nst - steps\n\n");
 
-    margin_results_print_brief(results, results_n);
+    for (uint8_t i = 0; i < ports_n; i++)
+    {
+      printf("Link ");
+      margin_log_bdfs(down_ports[i], up_ports[i]);
+      printf(":\n\n");
+      margin_results_print_brief(results[i], results_n[i]);
+      printf("\n");
+    }
   }
 
   if (status)
-    margin_free_results(results, results_n);
+  {
+    for (uint8_t i = 0; i < ports_n; i++)
+      margin_free_results(results[i], results_n[i]);
+    free(results_n);
+    free(results);
+    free(up_ports);
+    free(down_ports);
+    free(wrappers_up);
+    free(wrappers_down);
+    free(checks_status_ports);
+    free(args);
+  }
 
   pci_cleanup(pacc);
   return 0;
-- 
2.34.1


