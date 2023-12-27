Return-Path: <linux-pci+bounces-1426-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F0C81EDE3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0CC1283865
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7A2C680;
	Wed, 27 Dec 2023 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="FFYNcvll";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="MF2hTNGI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177AA2C6A2
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 80AACC000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670378; bh=f9HOiVP1j/am+NoHSSBRYmNnX6zSQKYjaB2+zJLZ7QE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=FFYNcvllV1ZIOasw6TwIGyL+SH/phvu612TqckWyc89nMgD8DzmK5NmEg+gTwFInt
	 xhXoHCJUc9HwNjo3VKGNSFf7HEX1rDmqHCBO3cHSPI4nGLEDBRBsc2aPedjW+E6ujW
	 eqNpZRpZhLWl6JDgt13koslDAKpTHKFQB9SIpBVPPklN/urIyFS7wDNv2vWEc5at/e
	 ibq9+Kzl0cO1MxdnCrAJMFSEQoTa6AUcUrhhWJTvLS+CzT4KNhz3JMpXAOoXM/jiTy
	 RHygSroHFvQ1rHmoHvT0mIgd7SadlZGLvi2EhuHpcPTtDXAKkDcMDC//yhiFBfjprf
	 s+A/IxOtSCT6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670378; bh=f9HOiVP1j/am+NoHSSBRYmNnX6zSQKYjaB2+zJLZ7QE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=MF2hTNGITSKCTwWZs7w1oH3p2nQZcaeEqHOcjSuO5MaBGCny7iXx/54kGTT0jA683
	 bsISOci8eiwvuI5YXdVK+Ui2CaRTxZdzUZFP9Yy7ecQgH4fLwNANkGU3fUoWUjoiTX
	 2K1zyR+yubq+b6kR5rsPFdKoJbp6+VkjHM6lNolCLqypN4wKquZfPR0d2dmPQv0DjG
	 8R3uSilIsFyDdWLt4F/IByGtU9N429Tg6RrEAV5Ekj6lPc7Rn2UiWFQenwUrl3omnt
	 eL9k3P9eVZ5RM1WTWGFNR2TN6Wt6rh8zMluIbEKjS+tJX0AROSyAW19gZI9esMRWSP
	 WoRVPWv/XJNLQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 11/15] pciutils-pcilmr: Add the ability to pass multiple links to the utility
Date: Wed, 27 Dec 2023 14:45:00 +0500
Message-ID: <20231227094504.32257-12-n.proshkin@yadro.com>
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
 pcilmr.c | 243 ++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 189 insertions(+), 54 deletions(-)

diff --git a/pcilmr.c b/pcilmr.c
index 3634c97..3c2f250 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -17,11 +17,17 @@
 
 const char program_name[] = "pcilmr";
 
+enum mode { MARGIN, FULL };
+
 static const char usage_msg[]
   = "Usage:\n"
-    "pcilmr [<margining options>] <downstream component>\n\n"
+    "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
+    "pcilmr --full [<margining options>]\n"
     "Device Specifier:\n"
     "<device/component>:\t[<domain>:]<bus>:<dev>.<func>\n\n"
+    "Modes:\n"
+    "--margin\t\tMargin selected Links\n"
+    "--full\t\t\tMargin all ready for testing Links in the system (one by one)\n"
     "Margining options:\n\n"
     "Margining Test settings:\n"
     "-c\t\t\tPrint Device Lane Margining Capabilities only. Do not run margining.\n"
@@ -100,27 +106,59 @@ parse_csv_arg(char *arg, u8 *vals)
   return cnt;
 }
 
+static u8
+find_ready_links(struct pci_access *pacc, struct pci_dev **down_ports, struct pci_dev **up_ports,
+                 bool cnt_only)
+{
+  u8 cnt = 0;
+  for (struct pci_dev *up = pacc->devices; up; up = up->next)
+    {
+      if (pci_find_cap(up, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED))
+        {
+          struct pci_dev *down = find_down_port_for_up(pacc, up);
+
+          if (down && margin_verify_link(down, up)
+              && (margin_check_ready_bit(down) || margin_check_ready_bit(up)))
+            {
+              if (!cnt_only)
+                {
+                  up_ports[cnt] = up;
+                  down_ports[cnt] = down;
+                }
+              cnt++;
+            }
+        }
+    }
+  return cnt;
+}
+
 int
 main(int argc, char **argv)
 {
   struct pci_access *pacc;
 
-  struct pci_dev *up_port;
-  struct pci_dev *down_port;
+  struct pci_dev **up_ports;
+  struct pci_dev **down_ports;
+  u8 ports_n = 0;
 
-  struct margin_link link;
+  struct margin_link *links;
+  bool *checks_status_ports;
 
   bool status = true;
+  enum mode mode;
 
-  struct margin_results *results;
-  u8 results_n;
+  /* each link has several receivers -> several results */
+  struct margin_results **results;
+  u8 *results_n;
 
-  struct margin_args args;
+  struct margin_args *args;
 
   u8 steps_t_arg = 0;
   u8 steps_v_arg = 0;
   u8 parallel_lanes_arg = 1;
   u8 error_limit = 4;
+  u8 lanes_arg[32];
+  u8 recvs_arg[6];
 
   u8 lanes_n = 0;
   u8 recvs_n = 0;
@@ -145,7 +183,29 @@ main(int argc, char **argv)
 
   margin_global_logging = true;
 
+  struct option long_options[]
+    = { { .name = "margin", .has_arg = no_argument, .flag = NULL, .val = 0 },
+        { .name = "full", .has_arg = no_argument, .flag = NULL, .val = 1 },
+        { 0, 0, 0, 0 } };
+
   int c;
+  c = getopt_long(argc, argv, ":", long_options, NULL);
+
+  switch (c)
+    {
+      case -1: /* no options (strings like component are possible) */
+        /* FALLTHROUGH */
+      case 0:
+        mode = MARGIN;
+        break;
+      case 1:
+        mode = FULL;
+        break;
+      default: /* unknown option symbol */
+        mode = MARGIN;
+        optind--;
+        break;
+    }
 
   while ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VT")) != -1)
     {
@@ -170,20 +230,22 @@ main(int argc, char **argv)
             run_margin = false;
             break;
           case 'l':
-            lanes_n = parse_csv_arg(optarg, args.lanes);
+            lanes_n = parse_csv_arg(optarg, lanes_arg);
             break;
           case 'e':
             error_limit = atoi(optarg);
             break;
           case 'r':
-            recvs_n = parse_csv_arg(optarg, args.recvs);
+            recvs_n = parse_csv_arg(optarg, recvs_arg);
             break;
           default:
             die("Invalid arguments\n\n%s", usage_msg);
         }
     }
 
-  if (optind != argc - 1)
+  if (mode == FULL && optind != argc)
+    status = false;
+  if (mode == MARGIN && optind == argc)
     status = false;
   if (!status && argc > 1)
     die("Invalid arguments\n\n%s", usage_msg);
@@ -193,59 +255,91 @@ main(int argc, char **argv)
       exit(0);
     }
 
-  up_port = dev_for_filter(pacc, argv[argc - 1]);
+  if (mode == FULL)
+    {
+      ports_n = find_ready_links(pacc, NULL, NULL, true);
+      if (ports_n == 0)
+        {
+          die("Links not found or you don't have enough privileges.\n");
+        }
+      else
+        {
+          up_ports = xmalloc(ports_n * sizeof(*up_ports));
+          down_ports = xmalloc(ports_n * sizeof(*down_ports));
+          find_ready_links(pacc, down_ports, up_ports, false);
+        }
+    }
+  else if (mode == MARGIN)
+    {
+      ports_n = argc - optind;
+      up_ports = xmalloc(ports_n * sizeof(*up_ports));
+      down_ports = xmalloc(ports_n * sizeof(*down_ports));
 
-  down_port = find_down_port_for_up(pacc, up_port);
-  if (!down_port)
-    die("Cannot find Upstream Component for the specified device: %s\n", argv[argc - 1]);
+      u8 cnt = 0;
+      while (optind != argc)
+        {
+          up_ports[cnt] = dev_for_filter(pacc, argv[optind]);
+          down_ports[cnt] = find_down_port_for_up(pacc, up_ports[cnt]);
+          if (!down_ports[cnt])
+            die("Cannot find Upstream Component for the specified device: %s\n", argv[optind]);
+          cnt++;
+          optind++;
+        }
+    }
+  else
+    die("Bug in the args parsing!\n");
 
-  if (!pci_find_cap(up_port, PCI_CAP_ID_EXP, PCI_CAP_NORMAL))
+  if (!pci_find_cap(up_ports[0], PCI_CAP_ID_EXP, PCI_CAP_NORMAL))
     die("Looks like you don't have enough privileges to access "
         "Device Configuration Space.\nTry to run utility as root.\n");
 
-  if (!margin_fill_link(down_port, up_port, &link))
-    {
-      printf("Link ");
-      margin_log_bdfs(down_port, up_port);
-      printf(" is not ready for margining.\n"
-             "Link data rate must be 16 GT/s or 32 GT/s.\n"
-             "Downstream Component must be at D0 PM state.\n");
-      status = false;
-    }
+  results = xmalloc(ports_n * sizeof(*results));
+  results_n = xmalloc(ports_n * sizeof(*results_n));
+  links = xmalloc(ports_n * sizeof(*links));
+  checks_status_ports = xmalloc(ports_n * sizeof(*checks_status_ports));
+  args = xmalloc(ports_n * sizeof(*args));
 
-  if (status)
+  for (int i = 0; i < ports_n; i++)
     {
-      args.error_limit = error_limit;
-      args.lanes_n = lanes_n;
-      args.recvs_n = recvs_n;
-      args.steps_t = steps_t_arg;
-      args.steps_v = steps_v_arg;
-      args.parallel_lanes = parallel_lanes_arg;
-      args.run_margin = run_margin;
-      args.verbosity = 1;
-      args.steps_utility = &total_steps;
+      args[i].error_limit = error_limit;
+      args[i].parallel_lanes = parallel_lanes_arg;
+      args[i].run_margin = run_margin;
+      args[i].verbosity = 1;
+      args[i].steps_t = steps_t_arg;
+      args[i].steps_v = steps_v_arg;
+      for (int j = 0; j < recvs_n; j++)
+        args[i].recvs[j] = recvs_arg[j];
+      args[i].recvs_n = recvs_n;
+      for (int j = 0; j < lanes_n; j++)
+        args[i].lanes[j] = lanes_arg[j];
+      args[i].lanes_n = lanes_n;
+      args[i].steps_utility = &total_steps;
 
       enum margin_test_status args_status;
 
-      if ((args_status = margin_process_args(&link.down_port, &args)) != MARGIN_TEST_OK)
+      if (!margin_fill_link(down_ports[i], up_ports[i], &links[i]))
         {
-          status = false;
-          margin_log_link(&link);
-          if (args_status == MARGIN_TEST_ARGS_RECVS)
-            margin_log("\nInvalid RecNums specified.\n");
-          else if (args_status == MARGIN_TEST_ARGS_LANES)
-            margin_log("\nInvalid lanes specified.\n");
+          checks_status_ports[i] = false;
+          results[i] = xmalloc(sizeof(*results[i]));
+          results[i]->test_status = MARGIN_TEST_PREREQS;
+          continue;
         }
-    }
 
-  if (status)
-    {
+      if ((args_status = margin_process_args(&links[i].down_port, &args[i])) != MARGIN_TEST_OK)
+        {
+          checks_status_ports[i] = false;
+          results[i] = xmalloc(sizeof(*results[i]));
+          results[i]->test_status = args_status;
+          continue;
+        }
+
+      checks_status_ports[i] = true;
       struct margin_params params;
 
-      for (int i = 0; i < args.recvs_n; i++)
+      for (int j = 0; j < args[i].recvs_n; j++)
         {
-          if (margin_read_params(pacc, args.recvs[i] == 6 ? up_port : down_port, args.recvs[i],
-                                 &params))
+          if (margin_read_params(pacc, args[i].recvs[j] == 6 ? up_ports[i] : down_ports[i],
+                                 args[i].recvs[j], &params))
             {
               u8 steps_t = steps_t_arg ? steps_t_arg : params.timing_steps;
               u8 steps_v = steps_v_arg ? steps_v_arg : params.volt_steps;
@@ -253,7 +347,7 @@ main(int argc, char **argv)
                                                                              parallel_lanes_arg;
 
               u8 step_multiplier
-                = args.lanes_n / parallel_recv + ((args.lanes_n % parallel_recv) > 0);
+                = args[i].lanes_n / parallel_recv + ((args[i].lanes_n % parallel_recv) > 0);
 
               total_steps += steps_t * step_multiplier;
               if (params.ind_left_right_tim)
@@ -266,13 +360,40 @@ main(int argc, char **argv)
                 }
             }
         }
+    }
 
-      results = margin_test_link(&link, &args, &results_n);
+  for (int i = 0; i < ports_n; i++)
+    {
+      if (checks_status_ports[i])
+        results[i] = margin_test_link(&links[i], &args[i], &results_n[i]);
+      else
+        {
+          results_n[i] = 1;
+          if (results[i]->test_status == MARGIN_TEST_PREREQS)
+            {
+              printf("Link ");
+              margin_log_bdfs(down_ports[i], up_ports[i]);
+              printf(" is not ready for margining.\n"
+                     "Link data rate must be 16 GT/s or 32 GT/s.\n"
+                     "Downstream Component must be at D0 PM state.\n");
+            }
+          else if (results[i]->test_status == MARGIN_TEST_ARGS_RECVS)
+            {
+              margin_log_link(&links[i]);
+              printf("\nInvalid RecNums specified.\n");
+            }
+          else if (results[i]->test_status == MARGIN_TEST_ARGS_LANES)
+            {
+              margin_log_link(&links[i]);
+              printf("\nInvalid lanes specified.\n");
+            }
+        }
+      printf("\n----\n\n");
     }
 
-  if (status && run_margin)
+  if (run_margin)
     {
-      printf("\nResults:\n");
+      printf("Results:\n");
       printf("\nPass/fail criteria:\nTiming:\n");
       printf("Minimum Offset (spec): %d %% UI\nRecommended Offset: %d %% UI\n", MARGIN_TIM_MIN,
              MARGIN_TIM_RECOMMEND);
@@ -283,11 +404,25 @@ main(int argc, char **argv)
       printf("THR -\tThe set (using the utility options) \n\tstep threshold has been reached\n\n");
       printf("Notations:\nst - steps\n\n");
 
-      margin_results_print_brief(results, results_n);
+      for (int i = 0; i < ports_n; i++)
+        {
+          printf("Link ");
+          margin_log_bdfs(down_ports[i], up_ports[i]);
+          printf(":\n\n");
+          margin_results_print_brief(results[i], results_n[i]);
+          printf("\n");
+        }
     }
 
-  if (status)
-    margin_free_results(results, results_n);
+  for (int i = 0; i < ports_n; i++)
+    margin_free_results(results[i], results_n[i]);
+  free(results_n);
+  free(results);
+  free(up_ports);
+  free(down_ports);
+  free(links);
+  free(checks_status_ports);
+  free(args);
 
   pci_cleanup(pacc);
   return 0;
-- 
2.34.1


