Return-Path: <linux-pci+bounces-659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3272A809F41
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F2EB20B57
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E166F125A7;
	Fri,  8 Dec 2023 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="PeQ/2WHv";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="x+3vXHPr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0456A1716
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 90D8BC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027157; bh=mqPNV8KHqX8HHzuSTzohXXY5WQ7EG2t0sitk6v32BQM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PeQ/2WHvzywWw7gT+g7I6S7VupRvSqd38EJIRko7YjtTeBRIaITXVFNzkOzpCDmhz
	 3zbR9E9RhUOaSl/bJ9L/KCJ5d18If/kDHf4v3ski+CgTDCFSXCXgAsR6jLqD4V4H+c
	 4lTTEdHfpALI++Gf7Xclj3lGp395fIIPKsqRXlwDmTAUDl69bQBKTUxIEN0UVjlFJC
	 f6M43FkJKYc+lne+pF2S5EfecqNCPl26QhPt2ghiSHv9zLRBHSIBL/jUt+aPzSVbNI
	 G/rw9XijWSYuZmrBY74764BF0jn4qiVQUoKUrHkuO8jYOoXvlNsrdfLmipG2KBy62H
	 TRlGBLwRAEy4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027157; bh=mqPNV8KHqX8HHzuSTzohXXY5WQ7EG2t0sitk6v32BQM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=x+3vXHPrpU5cHTs+GaMFA0OEDNj61B6JB/jzCJegeb/7Yy8EP+lN3WqykCaEAS2Kl
	 rOySNXtooR/8jAWQxNX0NUESst/DDZ486jOIytzd1t+AcPlqSQcDmzpSOLTELUpdG4
	 GoZYDkQVCbTKSJx3e4xoIQ2GO/9kvYzFjUrSBTEBrYdENlJegDRN8m7iwenjqApK+W
	 e7jIEFkrhBhJafAnRs5B8PnyI4DhBlb1IaNAyxWIHbCli30YbOIVSZ1LCApwNZyZpA
	 DfimhKGp7+3W6+hCy/Jk0+L8GnQcfLAqWSebOd5c2TlP1VuunU3MWWNS4efkMMOkMX
	 R5MCjUN+2dQCg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 13/15] pciutils-pcilmr: Add option to save margining results in csv form
Date: Fri, 8 Dec 2023 12:17:32 +0300
Message-ID: <20231208091734.12225-14-n.proshkin@yadro.com>
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
 lmr_lib/margin_results.c | 108 +++++++++++++++++++++++++++++++++++++++
 lmr_lib/margin_results.h |   2 +
 pcilmr.c                 |  18 ++++++-
 3 files changed, 126 insertions(+), 2 deletions(-)

diff --git a/lmr_lib/margin_results.c b/lmr_lib/margin_results.c
index 61f483a..cc6132f 100644
--- a/lmr_lib/margin_results.c
+++ b/lmr_lib/margin_results.c
@@ -1,5 +1,7 @@
 #include <stdlib.h>
 #include <stdio.h>
+#include <time.h>
+#include <string.h>
 
 #include "margin_results.h"
 
@@ -133,3 +135,109 @@ void margin_results_print_brief(struct margin_results *results, uint8_t recvs_n)
     printf("\n");
   }
 }
+
+void margin_results_save_csv(struct margin_results *results, uint8_t recvs_n, char *dir, struct pci_dev *up_dev)
+{
+  char timestamp[64];
+  time_t tim = time(NULL);
+  strftime(timestamp, 64, "%FT%H.%M.%S", gmtime(&tim));
+
+  char *path = (char *)malloc((strlen(dir) + 128) * sizeof(*path));
+  FILE *csv;
+
+  struct margin_res_lane *lane;
+  struct margin_results *recv;
+  enum lane_rating lane_rating;
+  uint8_t link_speed;
+
+  for (uint8_t i = 0; i < recvs_n; i++)
+  {
+    recv = &(results[i]);
+    link_speed = recv->link_speed - 4;
+
+    if (recv->test_status != MARGIN_TEST_OK)
+      continue;
+    sprintf(path, "%s/lmr_%0*x.%02x.%02x.%x_Rx%X_%s.csv", dir,
+            up_dev->domain_16 == 0xffff ? 8 : 4,
+            up_dev->domain, up_dev->bus, up_dev->dev,
+            up_dev->func, 10 + recv->recvn - 1, timestamp);
+    csv = fopen(path, "w");
+    if (!csv)
+    {
+      printf("Error while saving %s\n", path);
+      free(path);
+      return;
+    }
+
+    fprintf(csv, "Lane,Lane Status,Left %% UI,Left ps,Left Steps,Left Status,"
+                 "Right %% UI,Right ps,Right Steps,Right Status,"
+                 "Time %% UI,Time ps,Time Steps,Time Status,"
+                 "Up mV,Up Steps,Up Status,Down mV,Down Steps,Down Status,"
+                 "Voltage mV,Voltage Steps,Voltage Status\n");
+
+    if (check_recv_weird(recv, MARGIN_TIM_MIN, MARGIN_VOLT_MIN))
+      lane_rating = WEIRD;
+    else
+      lane_rating = INIT;
+
+    for (uint8_t j = 0; j < recv->lanes_n; j++)
+    {
+      lane = &(recv->lanes[j]);
+      double left_ui = lane->steps[TIM_LEFT] * recv->tim_coef;
+      double right_ui = lane->steps[TIM_RIGHT] * recv->tim_coef;
+      double up_volt = lane->steps[VOLT_UP] * recv->volt_coef;
+      double down_volt = lane->steps[VOLT_DOWN] * recv->volt_coef;
+
+      if (lane_rating != WEIRD)
+      {
+        lane_rating = rate_lane(left_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, INIT);
+        if (recv->ind_left_right_tim)
+          lane_rating = rate_lane(right_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, lane_rating);
+        if (recv->volt_support)
+        {
+          lane_rating = rate_lane(up_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
+          if (recv->ind_up_down_volt)
+            lane_rating = rate_lane(down_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
+        }
+      }
+
+      fprintf(csv, "%d,%s,", lane->lane, grades[lane_rating]);
+      if (recv->ind_left_right_tim)
+      {
+        fprintf(csv, "%f,%f,%d,%s,%f,%f,%d,%s,NA,NA,NA,NA,",
+                left_ui, left_ui * ui[link_speed], lane->steps[TIM_LEFT], sts_strings[lane->statuses[TIM_LEFT]],
+                right_ui, right_ui * ui[link_speed], lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
+      }
+      else
+      {
+        for (uint8_t k = 0; k < 8; k++)
+          fprintf(csv, "NA,");
+        fprintf(csv, "%f,%f,%d,%s,", left_ui, left_ui * ui[link_speed],
+                lane->steps[TIM_LEFT], sts_strings[lane->statuses[TIM_LEFT]]);
+      }
+      if (recv->volt_support)
+      {
+        if (recv->ind_up_down_volt)
+        {
+          fprintf(csv, "%f,%d,%s,%f,%d,%s,NA,NA,NA\n",
+                  up_volt, lane->steps[VOLT_UP], sts_strings[lane->statuses[VOLT_UP]],
+                  down_volt, lane->steps[VOLT_DOWN], sts_strings[lane->statuses[VOLT_DOWN]]);
+        }
+        else
+        {
+          for (uint8_t k = 0; k < 6; k++)
+            fprintf(csv, "NA,");
+          fprintf(csv, "%f,%d,%s\n", up_volt, lane->steps[VOLT_UP], sts_strings[lane->statuses[VOLT_UP]]);
+        }
+      }
+      else
+      {
+        for (uint8_t k = 0; k < 8; k++)
+          fprintf(csv, "NA,");
+        fprintf(csv, "NA\n");
+      }
+    }
+    fclose(csv);
+  }
+  free(path);
+}
diff --git a/lmr_lib/margin_results.h b/lmr_lib/margin_results.h
index ab6ddb0..69847cb 100644
--- a/lmr_lib/margin_results.h
+++ b/lmr_lib/margin_results.h
@@ -10,4 +10,6 @@
 
 void margin_results_print_brief(struct margin_results *results, uint8_t recvs_n);
 
+void margin_results_save_csv(struct margin_results *results, uint8_t recvs_n, char *dir, struct pci_dev *up_dev);
+
 #endif
diff --git a/pcilmr.c b/pcilmr.c
index 46b9f24..3da28e5 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -47,7 +47,12 @@ static void usage(void)
          "-v <steps>\t\tSpecify maximum number of steps for Voltage Margining.\n"
          "Use only one of -T/-t options at the same time (same for -V/-v).\n"
          "Without these options utility will use MaxSteps from Device\n"
-         "capabilities as test limit.\n\n");
+         "capabilities as test limit.\n\n"
+         "Margining Log settings:\n"
+         "-o <directory>\t\tSave margining results in csv form into the\n"
+         "\t\t\tspecified directory. Utility will generate file with the\n"
+         "\t\t\tname in form of 'lmr_<downstream component>_Rx#_<timestamp>.csv'\n"
+         "\t\t\tfor each successfully tested receiver.\n");
 }
 
 static struct pci_dev *dev_for_filter(struct pci_access *pacc, char *filter)
@@ -198,6 +203,9 @@ int main(int argc, char **argv)
 
   bool run_margin = true;
 
+  char *dir_for_csv = NULL;
+  bool save_csv = false;
+
   uint64_t total_steps = 0;
 
   pacc = pci_alloc();
@@ -247,7 +255,7 @@ int main(int argc, char **argv)
     break;
   }
 
-  while (status && ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VT")) != -1))
+  while (status && ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VTo:")) != -1))
   {
     switch (c)
     {
@@ -278,6 +286,10 @@ int main(int argc, char **argv)
     case 'r':
       recvs_n = parse_csv_arg(optarg, recvs_arg);
       break;
+    case 'o':
+      dir_for_csv = optarg;
+      save_csv = true;
+      break;
     default:
       printf("Invalid arguments\n");
       status = false;
@@ -494,6 +506,8 @@ int main(int argc, char **argv)
       margin_log_bdfs(down_ports[i], up_ports[i]);
       printf(":\n\n");
       margin_results_print_brief(results[i], results_n[i]);
+      if (save_csv)
+        margin_results_save_csv(results[i], results_n[i], dir_for_csv, up_ports[i]);
       printf("\n");
     }
   }
-- 
2.34.1


