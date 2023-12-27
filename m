Return-Path: <linux-pci+bounces-1428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432A81EDE5
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B361C2175C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390A2288B6;
	Wed, 27 Dec 2023 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="lQfoeny2";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="TTf9/Rdz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F1624B3C
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com D0FD0C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670380; bh=7q54cSreJ48wFoWwiSu6CwGJIg4nfa1QOd46uDlpZq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=lQfoeny2OhiTrSwaMTWdUcNAi5ROkXKgpbY8nc/RhY1AwXGRzM/PgeSf3qxaTNPxv
	 1pX104zMpcGnfqqjKdMMj/a+r5EP6Dskt9boj6B5+rvKYzlzgvr/H33kJaXRUM0qXs
	 WFip1OViTr1zGvIWiPLveKNCgU2sBveUJ9jatCJpHsx/j4wMwbNFBMTScd5wrQo+xJ
	 CtLXBQZP0GrJQFzosyvZU849HUiIsVaq9Foj8+hhiBVxEUTTGnIBpdAoGRqOjc/hPV
	 TPdyr4wzVU/t/dQqGVW3E1KuBnfzH0yuBmrSW1gH+AsF99xYPdmTp1EhwhXAhVN9nP
	 qXhUKjREoKFxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670380; bh=7q54cSreJ48wFoWwiSu6CwGJIg4nfa1QOd46uDlpZq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=TTf9/RdzWav+BEh3FvIW3kKT1EAKOaYCoSKbRXiP6yPUA8OerCewaw+FyGpVpQsbQ
	 a+mehZoLvJGTy4INOqCkyVt4CCs+2Z0aOG8icfwIQoLS8DsQXdf4BbCzE45Qs3Awcw
	 wY3kPOVSqSFMn5qzWAGrZredyj0oz6e8gw3OBXbUHBZ5+O3EX94TDaYulPIIu+//Ia
	 K3zOyC9CtcVCuDBVqI0WkE4hZ5BY9Fsdpah1ly+c/MPZ3n6d/Fqj/wVKNQr4Plo7th
	 ASHSRdjANWOUINvjbOjS3Y1EdLXROx/XbYBPvCn7iRrtOOZ+WOOJ2DH+8gEWsV4pr2
	 IVWDmkkfQ8tWA==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 13/15] pciutils-pcilmr: Add option to save margining results in csv form
Date: Wed, 27 Dec 2023 14:45:02 +0500
Message-ID: <20231227094504.32257-14-n.proshkin@yadro.com>
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

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h            |   3 ++
 lmr/margin_results.c | 111 +++++++++++++++++++++++++++++++++++++++++++
 pcilmr.c             |  18 ++++++-
 3 files changed, 130 insertions(+), 2 deletions(-)

diff --git a/lmr/lmr.h b/lmr/lmr.h
index bb188fc..c9dcd69 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -219,4 +219,7 @@ void margin_log_hw_quirks(struct margin_recv *recv);
 
 void margin_results_print_brief(struct margin_results *results, u8 recvs_n);
 
+void margin_results_save_csv(struct margin_results *results, u8 recvs_n, char *dir,
+                             struct pci_dev *up_port);
+
 #endif
diff --git a/lmr/margin_results.c b/lmr/margin_results.c
index 5ee065d..aca3ab7 100644
--- a/lmr/margin_results.c
+++ b/lmr/margin_results.c
@@ -157,3 +157,114 @@ margin_results_print_brief(struct margin_results *results, u8 recvs_n)
       printf("\n");
     }
 }
+
+void
+margin_results_save_csv(struct margin_results *results, u8 recvs_n, char *dir,
+                        struct pci_dev *up_port)
+{
+  char timestamp[64];
+  time_t tim = time(NULL);
+  strftime(timestamp, sizeof(timestamp), "%FT%H.%M.%S", gmtime(&tim));
+
+  size_t pathlen = strlen(dir) + 128;
+  char *path = xmalloc(pathlen);
+  FILE *csv;
+
+  struct margin_res_lane *lane;
+  struct margin_results *res;
+  struct margin_params params;
+
+  enum lane_rating lane_rating;
+  u8 link_speed;
+
+  for (int i = 0; i < recvs_n; i++)
+    {
+      res = &(results[i]);
+      params = res->params;
+      link_speed = res->link_speed - 4;
+
+      if (res->test_status != MARGIN_TEST_OK)
+        continue;
+      snprintf(path, pathlen, "%s/lmr_%0*x.%02x.%02x.%x_Rx%X_%s.csv", dir,
+               up_port->domain_16 == 0xffff ? 8 : 4, up_port->domain, up_port->bus, up_port->dev,
+               up_port->func, 10 + res->recvn - 1, timestamp);
+      csv = fopen(path, "w");
+      if (!csv)
+        die("Error while saving %s\n", path);
+
+      fprintf(csv, "Lane,Lane Status,Left %% UI,Left ps,Left Steps,Left Status,"
+                   "Right %% UI,Right ps,Right Steps,Right Status,"
+                   "Time %% UI,Time ps,Time Steps,Time Status,"
+                   "Up mV,Up Steps,Up Status,Down mV,Down Steps,Down Status,"
+                   "Voltage mV,Voltage Steps,Voltage Status\n");
+
+      if (check_recv_weird(res, MARGIN_TIM_MIN, MARGIN_VOLT_MIN))
+        lane_rating = WEIRD;
+      else
+        lane_rating = INIT;
+
+      for (int j = 0; j < res->lanes_n; j++)
+        {
+          lane = &(res->lanes[j]);
+          double left_ui = lane->steps[TIM_LEFT] * res->tim_coef;
+          double right_ui = lane->steps[TIM_RIGHT] * res->tim_coef;
+          double up_volt = lane->steps[VOLT_UP] * res->volt_coef;
+          double down_volt = lane->steps[VOLT_DOWN] * res->volt_coef;
+
+          if (lane_rating != WEIRD)
+            {
+              lane_rating = rate_lane(left_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, INIT);
+              if (params.ind_left_right_tim)
+                lane_rating
+                  = rate_lane(right_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, lane_rating);
+              if (params.volt_support)
+                {
+                  lane_rating = rate_lane(up_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
+                  if (params.ind_up_down_volt)
+                    lane_rating
+                      = rate_lane(down_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
+                }
+            }
+
+          fprintf(csv, "%d,%s,", lane->lane, grades[lane_rating]);
+          if (params.ind_left_right_tim)
+            {
+              fprintf(csv, "%f,%f,%d,%s,%f,%f,%d,%s,NA,NA,NA,NA,", left_ui,
+                      left_ui * ui[link_speed], lane->steps[TIM_LEFT],
+                      sts_strings[lane->statuses[TIM_LEFT]], right_ui, right_ui * ui[link_speed],
+                      lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
+            }
+          else
+            {
+              for (int k = 0; k < 8; k++)
+                fprintf(csv, "NA,");
+              fprintf(csv, "%f,%f,%d,%s,", left_ui, left_ui * ui[link_speed], lane->steps[TIM_LEFT],
+                      sts_strings[lane->statuses[TIM_LEFT]]);
+            }
+          if (params.volt_support)
+            {
+              if (params.ind_up_down_volt)
+                {
+                  fprintf(csv, "%f,%d,%s,%f,%d,%s,NA,NA,NA\n", up_volt, lane->steps[VOLT_UP],
+                          sts_strings[lane->statuses[VOLT_UP]], down_volt, lane->steps[VOLT_DOWN],
+                          sts_strings[lane->statuses[VOLT_DOWN]]);
+                }
+              else
+                {
+                  for (int k = 0; k < 6; k++)
+                    fprintf(csv, "NA,");
+                  fprintf(csv, "%f,%d,%s\n", up_volt, lane->steps[VOLT_UP],
+                          sts_strings[lane->statuses[VOLT_UP]]);
+                }
+            }
+          else
+            {
+              for (int k = 0; k < 8; k++)
+                fprintf(csv, "NA,");
+              fprintf(csv, "NA\n");
+            }
+        }
+      fclose(csv);
+    }
+  free(path);
+}
diff --git a/pcilmr.c b/pcilmr.c
index 43e791d..eb5d947 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -52,7 +52,12 @@ static const char usage_msg[]
     "-v <steps>\t\tSpecify maximum number of steps for Voltage Margining.\n"
     "Use only one of -T/-t options at the same time (same for -V/-v).\n"
     "Without these options utility will use MaxSteps from Device\n"
-    "capabilities as test limit.\n\n";
+    "capabilities as test limit.\n\n"
+    "Margining Log settings:\n"
+    "-o <directory>\t\tSave margining results in csv form into the\n"
+    "\t\t\tspecified directory. Utility will generate file with the\n"
+    "\t\t\tname in form of 'lmr_<downstream component>_Rx#_<timestamp>.csv'\n"
+    "\t\t\tfor each successfully tested receiver.\n";
 
 static struct pci_dev *
 dev_for_filter(struct pci_access *pacc, char *filter)
@@ -197,6 +202,9 @@ main(int argc, char **argv)
 
   bool run_margin = true;
 
+  char *dir_for_csv = NULL;
+  bool save_csv = false;
+
   u64 total_steps = 0;
 
   pacc = pci_alloc();
@@ -246,7 +254,7 @@ main(int argc, char **argv)
         break;
     }
 
-  while ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VT")) != -1)
+  while ((c = getopt(argc, argv, ":r:e:l:cp:t:v:VTo:")) != -1)
     {
       switch (c)
         {
@@ -277,6 +285,10 @@ main(int argc, char **argv)
           case 'r':
             recvs_n = parse_csv_arg(optarg, recvs_arg);
             break;
+          case 'o':
+            dir_for_csv = optarg;
+            save_csv = true;
+            break;
           default:
             die("Invalid arguments\n\n%s", usage_msg);
         }
@@ -449,6 +461,8 @@ main(int argc, char **argv)
           margin_log_bdfs(down_ports[i], up_ports[i]);
           printf(":\n\n");
           margin_results_print_brief(results[i], results_n[i]);
+          if (save_csv)
+            margin_results_save_csv(results[i], results_n[i], dir_for_csv, up_ports[i]);
           printf("\n");
         }
     }
-- 
2.34.1


