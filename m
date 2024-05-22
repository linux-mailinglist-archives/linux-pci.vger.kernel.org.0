Return-Path: <linux-pci+bounces-7749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7328CC4A0
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DFB71F227D7
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D2320DF4;
	Wed, 22 May 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="wX+aRzLB";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="BvgoTXcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A1139B
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394065; cv=none; b=hbBiFA5V2UP42NjFDrtfbRxqlg9g7ISMvlhDpDs76z37JALH4Ju9c4Wdk16466owkkCVqnd0PugdLGd8tGq6LCOeckALzbw1DisJoo2k9TA1CqOpvahmyRsqI18rrGaGVs2yAS2JaZEeyeE1OUW/cRhnPPYDhTylDxT1k8NIYoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394065; c=relaxed/simple;
	bh=zRqEYzsq7wwyUBXmBzdQU3HgcWQgErIpIWR3sDLINCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jx3Hc2ItoULYPq4mpcSvIrv+yhmZyIREqIMmW7+BraoTULKPG1pyMdxsw1KLzctybVZdhwyiLI63JZbl7fLUzfrVT2/pxJ92si8RWb4HWfw0DWJQcB5yYDxdKwMX5VjOLTw9JNNnG6uYXv6F3iWORD4taGtABHqHbA5sWm0OpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=wX+aRzLB; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=BvgoTXcu; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 45E2CC0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394057; bh=+AyhGU3zrpsZkij0GMgpKz2Yen84USPT0xHPLckaPwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=wX+aRzLBxj5ipQY4Jhs3bwmfcMPjLAdpY82qjR1tLinLnu92Syd4xdo1ufPH+n7UG
	 PrJ58sIB1KSjM/Pzp5WLvVHuaSqoGwWTjwabSV2EDEJeezCJc1dRy7r0H3det53PPX
	 x9F/s+f7nvPh+IfxabumIrbhugwjUBFA5HinKlSKYFIihUWk4RJKdQAxoKFxQY+p6i
	 5uNdzrxiVH/D4ssT67VDADI1aVK/aoLRsiwpbauhg32NH0UEcJtzMKICitmElvNMUm
	 tyhDFN26tTxZX5cYfwzUTaML6RzwXwp3Nlbu6wS9NlrFPLir2v+NWF0rKo9/wqtLMh
	 42O9dCdQRHeJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394057; bh=+AyhGU3zrpsZkij0GMgpKz2Yen84USPT0xHPLckaPwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BvgoTXcuHle2w+rfYqXQxD21hoUEahV75Zr2zednuqhaj0ninRLix1Hsmv2hJPyZ2
	 5Xjur4wGeHakjJfMfNm2DSc1TRZiYE1dLO2r1rMVLCQAb/dxTt4x+hRUYYfW+0y1pi
	 4kcZ5Iv18kcUbhpyrmGY8QySWe4xpzWjhD+PmZdwkHQpJup9M16X7p9jK5x5hEbsTB
	 oPSWHP8eZWuYiUXENCn+PNGrQnslbkoEzkIU2PKkUSE6pCL2Pn/uDLfExtDgXOdOnt
	 re3+jA0jqBe8gXcSCuYx+89mlZCRP9aSej6h025XelQ75TY8xcA64tW+HJiH4c2d2Z
	 zQBz9IJwFe0YA==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils 3/6] pcilmr: Add new grading option
Date: Wed, 22 May 2024 19:06:31 +0300
Message-ID: <20240522160634.29831-4-n.proshkin@yadro.com>
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

Original version of the utility used values from the Table 8-11 of the
PCIe Base Spec Rev 5.0 to evaluate lanes. But it seems that these values
relate only to the margining equipment and are not relevant to evaluating
the quality of connections.

The PCIe Base Spec Rev 5.0 sets the minimum values for the eye in the
section 8.4.2. Change default grading values in the utility according to
this section.

The specification uses the values of the full width and height of the eye,
so add these values to the output of the utility.

In addition, manufacturers can provide criteria for their devices that
differ from the standard ones. Usually this information falls under the
NDA, so add an option to the utility that will allow the user to set
necessary criteria for evaluating the quality of lanes.

Implement the following syntax for the -g(rading) option:
-g 1t=15ps,f | -g 6v=20

Use passed per link receiver criteria for the eye width (timing - t) or
height (voltage - v) in the utility results.

Additional flag f is for situations when port doesn't support two side
independent margining. In such cases by default calculate EW or EH as a
double one side result. User can add f flag for -g option to tell the
utility that the result in one direction is actually the measurement of
the full eye (for example, Ice Lake RC ports work in this way) and it does
not need to be multiplied.

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h            |  35 ++++-
 lmr/margin_args.c    |  60 ++++++++-
 lmr/margin_results.c | 312 ++++++++++++++++++++++++++++---------------
 pcilmr.c             |   6 +-
 4 files changed, 290 insertions(+), 123 deletions(-)

diff --git a/lmr/lmr.h b/lmr/lmr.h
index 71480f0..da40bfe 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -17,12 +17,11 @@
 
 #define MARGIN_STEP_MS 1000
 
-#define MARGIN_TIM_MIN       20
-#define MARGIN_TIM_RECOMMEND 30
-#define MARGIN_VOLT_MIN      50
-
 enum margin_hw { MARGIN_HW_DEFAULT, MARGIN_ICE_LAKE_RC };
 
+// in ps
+static const double margin_ui[] = { 62.5, 31.25 };
+
 /* PCI Device wrapper for margining functions */
 struct margin_dev {
   struct pci_dev *dev;
@@ -122,6 +121,15 @@ struct margin_com_args {
   char *dir_for_csv;
 };
 
+struct margin_recv_args {
+  // Grading options
+  struct {
+    bool valid;
+    double criteria; // in ps/mV
+    bool one_side_is_whole;
+  } t, v;
+};
+
 struct margin_link_args {
   struct margin_com_args *common;
   u8 steps_t;        // 0 == use NumTimingSteps
@@ -129,8 +137,9 @@ struct margin_link_args {
   u8 parallel_lanes; // [1; MaxLanes + 1]
   u8 recvs[6];       // Receivers Numbers
   u8 recvs_n;        // 0 == margin all available receivers
-  u8 lanes[32];      // Lanes to Margin
-  u8 lanes_n;        // 0 == margin all available lanes
+  struct margin_recv_args recv_args[6];
+  u8 lanes[32]; // Lanes to Margin
+  u8 lanes_n;   // 0 == margin all available lanes
 };
 
 struct margin_link {
@@ -243,7 +252,19 @@ void margin_log_hw_quirks(struct margin_recv *recv);
 
 /* margin_results */
 
-void margin_results_print_brief(struct margin_results *results, u8 recvs_n);
+// Min values are taken from PCIe Base Spec Rev. 5.0 Section 8.4.2.
+// Rec values are based on PCIe Arch PHY Test Spec Rev 5.0
+// (Transmitter Electrical Compliance)
+
+// values in ps
+static const double margin_ew_min[] = { 18.75, 9.375 };
+static const double margin_ew_rec[] = { 23.75, 10.1565 };
+
+static const double margin_eh_min[] = { 15, 15 };
+static const double margin_eh_rec[] = { 21, 19.75 };
+
+void margin_results_print_brief(struct margin_results *results, u8 recvs_n,
+                                struct margin_link_args *args);
 
 void margin_results_save_csv(struct margin_results *results, u8 recvs_n, struct margin_link *link);
 
diff --git a/lmr/margin_args.c b/lmr/margin_args.c
index c2d2e79..484c58f 100644
--- a/lmr/margin_args.c
+++ b/lmr/margin_args.c
@@ -14,7 +14,7 @@
 
 #include "lmr.h"
 
-const char* usage
+const char *usage
   = "! Utility requires preliminary preparation of the system. Refer to the pcilmr man page !\n\n"
     "Usage:\n"
     "pcilmr [--margin] [<margining options>] <downstream component> ...\n"
@@ -130,7 +130,7 @@ parse_dev_args(int argc, char **argv, struct margin_link_args *args, u8 link_spe
   if (argc == optind)
     return;
   int c;
-  while ((c = getopt(argc, argv, "+r:l:p:t:v:VT")) != -1)
+  while ((c = getopt(argc, argv, "+r:l:p:t:v:VTg:")) != -1)
     {
       switch (c)
         {
@@ -155,6 +155,60 @@ parse_dev_args(int argc, char **argv, struct margin_link_args *args, u8 link_spe
           case 'r':
             args->recvs_n = parse_csv_arg(optarg, args->recvs);
             break;
+            case 'g': {
+              char recv[2] = { 0 };
+              char dir[2] = { 0 };
+              char unit[4] = { 0 };
+              float criteria = 0.0;
+              char eye[2] = { 0 };
+              int cons[3] = { 0 };
+
+              int ret = sscanf(optarg, "%1[1-6]%1[tv]=%f%n%3[%,ps]%n%1[f]%n", recv, dir, &criteria,
+                               &cons[0], unit, &cons[1], eye, &cons[2]);
+              if (ret < 3)
+                {
+                  ret = sscanf(optarg, "%1[1-6]%1[tv]=%1[f]%n,%f%n%2[ps%]%n", recv, dir, eye,
+                               &cons[0], &criteria, &cons[1], unit, &cons[2]);
+                  if (ret < 3)
+                    die("Invalid arguments\n\n%s", usage);
+                }
+
+              int consumed = 0;
+              for (int i = 0; i < 3; i++)
+                if (cons[i] > consumed)
+                  consumed = cons[i];
+              if ((size_t)consumed != strlen(optarg))
+                die("Invalid arguments\n\n%s", usage);
+              if (criteria < 0)
+                die("Invalid arguments\n\n%s", usage);
+              if (strstr(unit, ",") && eye[0] == 0)
+                die("Invalid arguments\n\n%s", usage);
+
+              u8 recv_n = recv[0] - '0' - 1;
+              if (dir[0] == 'v')
+                {
+                  if (unit[0] != ',' && unit[0] != 0)
+                    die("Invalid arguments\n\n%s", usage);
+                  args->recv_args[recv_n].v.valid = true;
+                  args->recv_args[recv_n].v.criteria = criteria;
+                  if (eye[0] != 0)
+                    args->recv_args[recv_n].v.one_side_is_whole = true;
+                }
+              else
+                {
+                  if (unit[0] == '%')
+                    criteria = criteria / 100.0 * margin_ui[link_speed];
+                  else if (unit[0] != 0 && (unit[0] != 'p' || unit[1] != 's'))
+                    die("Invalid arguments\n\n%s", usage);
+                  else if (unit[0] == 0 && criteria != 0)
+                    die("Invalid arguments\n\n%s", usage);
+                  args->recv_args[recv_n].t.valid = true;
+                  args->recv_args[recv_n].t.criteria = criteria;
+                  if (eye[0] != 0)
+                    args->recv_args[recv_n].t.one_side_is_whole = true;
+                }
+              break;
+            }
           case '?':
             die("Invalid arguments\n\n%s", usage);
             break;
@@ -236,7 +290,7 @@ margin_parse_util_args(struct pci_access *pacc, int argc, char **argv, enum marg
           struct pci_dev *down;
           struct pci_dev *up;
           if (!margin_find_pair(pacc, dev, &down, &up))
-            die("Cannot find pair for the specified device: %s\n", argv[optind]);
+            die("Cannot find pair for the specified device: %s\n", argv[optind - 1]);
           struct pci_cap *cap = pci_find_cap(down, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
           if (!cap)
             die("Looks like you don't have enough privileges to access "
diff --git a/lmr/margin_results.c b/lmr/margin_results.c
index b320e90..b0c5c26 100644
--- a/lmr/margin_results.c
+++ b/lmr/margin_results.c
@@ -16,25 +16,23 @@
 #include "lmr.h"
 
 enum lane_rating {
-  BAD = 0,
-  OKAY,
+  FAIL = 0,
+  PASS,
   PERFECT,
-  WEIRD,
   INIT,
 };
 
-static char *const grades[] = { "Bad", "Okay", "Perfect", "Weird" };
+static char *const grades[] = { "Fail", "Pass", "Perfect" };
 static char *const sts_strings[] = { "NAK", "LIM", "THR" };
-static const double ui[] = { 62.5 / 100, 31.25 / 100 };
 
 static enum lane_rating
 rate_lane(double value, double min, double recommended, enum lane_rating cur_rate)
 {
   enum lane_rating res = PERFECT;
   if (value < recommended)
-    res = OKAY;
+    res = PASS;
   if (value < min)
-    res = BAD;
+    res = FAIL;
   if (cur_rate == INIT)
     return res;
   if (res < cur_rate)
@@ -43,34 +41,9 @@ rate_lane(double value, double min, double recommended, enum lane_rating cur_rat
     return cur_rate;
 }
 
-static bool
-check_recv_weird(struct margin_results *results, double tim_min, double volt_min)
-{
-  bool result = true;
-
-  struct margin_res_lane *lane;
-  for (int i = 0; i < results->lanes_n && result; i++)
-    {
-      lane = &(results->lanes[i]);
-      if (lane->steps[TIM_LEFT] * results->tim_coef != tim_min)
-        result = false;
-      if (results->params.ind_left_right_tim
-          && lane->steps[TIM_RIGHT] * results->tim_coef != tim_min)
-        result = false;
-      if (results->params.volt_support)
-        {
-          if (lane->steps[VOLT_UP] * results->volt_coef != volt_min)
-            result = false;
-          if (results->params.ind_up_down_volt
-              && lane->steps[VOLT_DOWN] * results->volt_coef != volt_min)
-            result = false;
-        }
-    }
-  return result;
-}
-
 void
-margin_results_print_brief(struct margin_results *results, u8 recvs_n)
+margin_results_print_brief(struct margin_results *results, u8 recvs_n,
+                           struct margin_link_args *args)
 {
   struct margin_res_lane *lane;
   struct margin_results *res;
@@ -80,6 +53,14 @@ margin_results_print_brief(struct margin_results *results, u8 recvs_n)
 
   u8 link_speed;
 
+  struct margin_recv_args grade_args;
+  bool spec_ref_only;
+
+  double ew_min;
+  double ew_rec;
+  double eh_min;
+  double eh_rec;
+
   char *no_test_msgs[] = { "",
                            "Margining Ready bit is Clear",
                            "Error during caps reading",
@@ -102,6 +83,67 @@ margin_results_print_brief(struct margin_results *results, u8 recvs_n)
           continue;
         }
 
+      spec_ref_only = true;
+      grade_args = args->recv_args[res->recvn - 1];
+      if (grade_args.t.criteria != 0)
+        {
+          spec_ref_only = false;
+          ew_min = grade_args.t.criteria;
+          ew_rec = grade_args.t.criteria;
+        }
+      else
+        {
+          ew_min = margin_ew_min[link_speed];
+          ew_rec = margin_ew_rec[link_speed];
+        }
+
+      if (grade_args.v.criteria != 0)
+        {
+          spec_ref_only = false;
+          eh_min = grade_args.v.criteria;
+          eh_rec = grade_args.v.criteria;
+        }
+      else
+        {
+          eh_min = margin_eh_min[link_speed];
+          eh_rec = margin_eh_rec[link_speed];
+        }
+
+      printf("Rx(%X) - Grading criteria:\n", 10 + res->recvn - 1);
+      if (spec_ref_only)
+        {
+          printf("\tUsing spec only:\n");
+          printf("\tEW: minimum - %.2f ps; recommended - %.2f ps\n", ew_min, ew_rec);
+          printf("\tEH: minimum - %.2f mV; recommended - %.2f mV\n\n", eh_min, eh_rec);
+        }
+      else
+        {
+          printf("\tEW: pass - %.2f ps\n", ew_min);
+          printf("\tEH: pass - %.2f mV\n\n", eh_min);
+        }
+
+      if (!params.ind_left_right_tim)
+        {
+          printf("Rx(%X) - EW: independent left/right timing margin is not supported:\n",
+                 10 + res->recvn - 1);
+          if (grade_args.t.one_side_is_whole)
+            printf("\tmanual setting - the entire margin across the eye "
+                   "is what is reported by one side margining\n\n");
+          else
+            printf("\tdefault - calculating EW as double one side result\n\n");
+        }
+
+      if (params.volt_support && !params.ind_up_down_volt)
+        {
+          printf("Rx(%X) - EH: independent up and down voltage margining is not supported:\n",
+                 10 + res->recvn - 1);
+          if (grade_args.v.one_side_is_whole)
+            printf("\tmanual setting - the entire margin across the eye "
+                   "is what is reported by one side margining\n\n");
+          else
+            printf("\tdefault - calculating EH as double one side result\n\n");
+        }
+
       if (res->lane_reversal)
         printf("Rx(%X) - Lane Reversal\n", 10 + res->recvn - 1);
 
@@ -118,51 +160,60 @@ margin_results_print_brief(struct margin_results *results, u8 recvs_n)
                "reliable.\n\n",
                10 + res->recvn - 1);
 
-      if (check_recv_weird(res, MARGIN_TIM_MIN, MARGIN_VOLT_MIN))
-        lane_rating = WEIRD;
-      else
-        lane_rating = INIT;
-
-      for (u8 j = 0; j < res->lanes_n; j++)
+      for (int j = 0; j < res->lanes_n; j++)
         {
+          if (spec_ref_only)
+            lane_rating = INIT;
+          else
+            lane_rating = PASS;
+
           lane = &(res->lanes[j]);
-          double left_ui = lane->steps[TIM_LEFT] * res->tim_coef;
-          double right_ui = lane->steps[TIM_RIGHT] * res->tim_coef;
+          double left_ps = lane->steps[TIM_LEFT] * res->tim_coef / 100.0 * margin_ui[link_speed];
+          double right_ps = lane->steps[TIM_RIGHT] * res->tim_coef / 100.0 * margin_ui[link_speed];
           double up_volt = lane->steps[VOLT_UP] * res->volt_coef;
           double down_volt = lane->steps[VOLT_DOWN] * res->volt_coef;
 
-          if (lane_rating != WEIRD)
+          double ew = left_ps;
+          if (params.ind_left_right_tim)
+            ew += right_ps;
+          else if (!grade_args.t.one_side_is_whole)
+            ew *= 2.0;
+
+          double eh = 0.0;
+          if (params.volt_support)
             {
-              lane_rating = rate_lane(left_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, INIT);
-              if (params.ind_left_right_tim)
-                lane_rating
-                  = rate_lane(right_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, lane_rating);
-              if (params.volt_support)
-                {
-                  lane_rating = rate_lane(up_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
-                  if (params.ind_up_down_volt)
-                    lane_rating
-                      = rate_lane(down_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
-                }
+              eh += up_volt;
+              if (params.ind_up_down_volt)
+                eh += down_volt;
+              else if (!grade_args.v.one_side_is_whole)
+                eh *= 2.0;
             }
 
-          printf("Rx(%X) Lane %2d - %s\t", 10 + res->recvn - 1, lane->lane, grades[lane_rating]);
+          lane_rating = rate_lane(ew, ew_min, ew_rec, lane_rating);
+          if (params.volt_support)
+            lane_rating = rate_lane(eh, eh_min, eh_rec, lane_rating);
+
+          printf("Rx(%X) Lane %2d: %s\t (W %4.1f%% UI - %5.2fps", 10 + res->recvn - 1, lane->lane,
+                 grades[lane_rating], ew / margin_ui[link_speed] * 100.0, ew);
+          if (params.volt_support)
+            printf(", H %5.1f mV", eh);
           if (params.ind_left_right_tim)
-            printf("L %4.1f%% UI - %5.2fps - %2dst %s, R %4.1f%% UI - %5.2fps - %2dst %s", left_ui,
-                   left_ui * ui[link_speed], lane->steps[TIM_LEFT],
-                   sts_strings[lane->statuses[TIM_LEFT]], right_ui, right_ui * ui[link_speed],
-                   lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
+            printf(")  (L %4.1f%% UI - %5.2fps - %2dst %s)  (R %4.1f%% UI - %5.2fps - %2dst %s)",
+                   left_ps / margin_ui[link_speed] * 100.0, left_ps, lane->steps[TIM_LEFT],
+                   sts_strings[lane->statuses[TIM_LEFT]], right_ps / margin_ui[link_speed] * 100.0,
+                   right_ps, lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
           else
-            printf("T %4.1f%% UI - %5.2fps - %2dst %s", left_ui, left_ui * ui[link_speed],
-                   lane->steps[TIM_LEFT], sts_strings[lane->statuses[TIM_LEFT]]);
+            printf(")  (T %4.1f%% UI - %5.2fps - %2dst %s)",
+                   left_ps / margin_ui[link_speed] * 100.0, left_ps, lane->steps[TIM_LEFT],
+                   sts_strings[lane->statuses[TIM_LEFT]]);
           if (params.volt_support)
             {
               if (params.ind_up_down_volt)
-                printf(", U %5.1f mV - %3dst %s, D %5.1f mV - %3dst %s", up_volt,
+                printf("  (U %5.1f mV - %3dst %s)  (D %5.1f mV - %3dst %s)", up_volt,
                        lane->steps[VOLT_UP], sts_strings[lane->statuses[VOLT_UP]], down_volt,
                        lane->steps[VOLT_DOWN], sts_strings[lane->statuses[VOLT_DOWN]]);
               else
-                printf(", V %5.1f mV - %3dst %s", up_volt, lane->steps[VOLT_UP],
+                printf("  (V %5.1f mV - %3dst %s)", up_volt, lane->steps[VOLT_UP],
                        sts_strings[lane->statuses[VOLT_UP]]);
             }
           printf("\n");
@@ -190,6 +241,14 @@ margin_results_save_csv(struct margin_results *results, u8 recvs_n, struct margi
   enum lane_rating lane_rating;
   u8 link_speed;
 
+  struct margin_recv_args grade_args;
+  bool spec_ref_only;
+
+  double ew_min;
+  double ew_rec;
+  double eh_min;
+  double eh_rec;
+
   struct pci_dev *port;
 
   for (int i = 0; i < recvs_n; i++)
@@ -203,80 +262,117 @@ margin_results_save_csv(struct margin_results *results, u8 recvs_n, struct margi
 
       port = res->recvn == 6 ? link->up_port.dev : link->down_port.dev;
       snprintf(path, pathlen, "%s/lmr_%0*x.%02x.%02x.%x_Rx%X_%s.csv", dir,
-               port->domain_16 == 0xffff ? 8 : 4, port->domain, port->bus, port->dev,
-               port->func, 10 + res->recvn - 1, timestamp);
+               port->domain_16 == 0xffff ? 8 : 4, port->domain, port->bus, port->dev, port->func,
+               10 + res->recvn - 1, timestamp);
       csv = fopen(path, "w");
       if (!csv)
         die("Error while saving %s\n", path);
 
-      fprintf(csv, "Lane,Lane Status,Left %% UI,Left ps,Left Steps,Left Status,"
-                   "Right %% UI,Right ps,Right Steps,Right Status,"
-                   "Time %% UI,Time ps,Time Steps,Time Status,"
-                   "Up mV,Up Steps,Up Status,Down mV,Down Steps,Down Status,"
-                   "Voltage mV,Voltage Steps,Voltage Status\n");
+      fprintf(csv, "Lane,EW Min,EW Rec,EW,EH Min,EH Rec,EH,Lane Status,Left %% UI,Left "
+                   "ps,Left Steps,Left Status,Right %% UI,Right ps,Right Steps,Right Status,Up "
+                   "mV,Up Steps,Up Status,Down mV,Down Steps,Down Status\n");
 
-      if (check_recv_weird(res, MARGIN_TIM_MIN, MARGIN_VOLT_MIN))
-        lane_rating = WEIRD;
+      spec_ref_only = true;
+      grade_args = link->args.recv_args[res->recvn - 1];
+      if (grade_args.t.criteria != 0)
+        {
+          spec_ref_only = false;
+          ew_min = grade_args.t.criteria;
+          ew_rec = grade_args.t.criteria;
+        }
+      else
+        {
+          ew_min = margin_ew_min[link_speed];
+          ew_rec = margin_ew_rec[link_speed];
+        }
+      if (grade_args.v.criteria != 0)
+        {
+          spec_ref_only = false;
+          eh_min = grade_args.v.criteria;
+          eh_rec = grade_args.v.criteria;
+        }
       else
-        lane_rating = INIT;
+        {
+          eh_min = margin_eh_min[link_speed];
+          eh_rec = margin_eh_rec[link_speed];
+        }
 
       for (int j = 0; j < res->lanes_n; j++)
         {
+          if (spec_ref_only)
+            lane_rating = INIT;
+          else
+            lane_rating = PASS;
+
           lane = &(res->lanes[j]);
-          double left_ui = lane->steps[TIM_LEFT] * res->tim_coef;
-          double right_ui = lane->steps[TIM_RIGHT] * res->tim_coef;
+          double left_ps = lane->steps[TIM_LEFT] * res->tim_coef / 100.0 * margin_ui[link_speed];
+          double right_ps = lane->steps[TIM_RIGHT] * res->tim_coef / 100.0 * margin_ui[link_speed];
           double up_volt = lane->steps[VOLT_UP] * res->volt_coef;
           double down_volt = lane->steps[VOLT_DOWN] * res->volt_coef;
 
-          if (lane_rating != WEIRD)
+          double ew = left_ps;
+          if (params.ind_left_right_tim)
+            ew += right_ps;
+          else if (!grade_args.t.one_side_is_whole)
+            ew *= 2.0;
+
+          double eh = 0.0;
+          if (params.volt_support)
             {
-              lane_rating = rate_lane(left_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, INIT);
-              if (params.ind_left_right_tim)
-                lane_rating
-                  = rate_lane(right_ui, MARGIN_TIM_MIN, MARGIN_TIM_RECOMMEND, lane_rating);
-              if (params.volt_support)
-                {
-                  lane_rating = rate_lane(up_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
-                  if (params.ind_up_down_volt)
-                    lane_rating
-                      = rate_lane(down_volt, MARGIN_VOLT_MIN, MARGIN_VOLT_MIN, lane_rating);
-                }
+              eh += up_volt;
+              if (params.ind_up_down_volt)
+                eh += down_volt;
+              else if (!grade_args.v.one_side_is_whole)
+                eh *= 2.0;
             }
 
-          fprintf(csv, "%d,%s,", lane->lane, grades[lane_rating]);
-          if (params.ind_left_right_tim)
+          lane_rating = rate_lane(ew, ew_min, ew_rec, lane_rating);
+          if (params.volt_support)
+            lane_rating = rate_lane(eh, eh_min, eh_rec, lane_rating);
+
+          fprintf(csv, "%d,%f,", lane->lane, ew_min);
+          if (spec_ref_only)
+            fprintf(csv, "%f,", ew_rec);
+          else
+            fprintf(csv, "NA,");
+          fprintf(csv, "%f,", ew);
+          if (params.volt_support)
             {
-              fprintf(csv, "%f,%f,%d,%s,%f,%f,%d,%s,NA,NA,NA,NA,", left_ui,
-                      left_ui * ui[link_speed], lane->steps[TIM_LEFT],
-                      sts_strings[lane->statuses[TIM_LEFT]], right_ui, right_ui * ui[link_speed],
-                      lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
+              fprintf(csv, "%f,", eh_min);
+              if (spec_ref_only)
+                fprintf(csv, "%f,", eh_rec);
+              else
+                fprintf(csv, "NA,");
+              fprintf(csv, "%f,", eh);
             }
+          else
+            fprintf(csv, "NA,NA,NA,");
+          fprintf(csv, "%s,", grades[lane_rating]);
+
+          fprintf(csv, "%f,%f,%d,%s,", left_ps * 100.0 / margin_ui[link_speed], left_ps,
+                  lane->steps[TIM_LEFT], sts_strings[lane->statuses[TIM_LEFT]]);
+
+          if (params.ind_left_right_tim)
+            fprintf(csv, "%f,%f,%d,%s,", right_ps * 100.0 / margin_ui[link_speed], right_ps,
+                    lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
           else
             {
-              for (int k = 0; k < 8; k++)
+              for (int k = 0; k < 4; k++)
                 fprintf(csv, "NA,");
-              fprintf(csv, "%f,%f,%d,%s,", left_ui, left_ui * ui[link_speed], lane->steps[TIM_LEFT],
-                      sts_strings[lane->statuses[TIM_LEFT]]);
             }
           if (params.volt_support)
             {
+              fprintf(csv, "%f,%d,%s,", up_volt, lane->steps[VOLT_UP],
+                      sts_strings[lane->statuses[VOLT_UP]]);
               if (params.ind_up_down_volt)
-                {
-                  fprintf(csv, "%f,%d,%s,%f,%d,%s,NA,NA,NA\n", up_volt, lane->steps[VOLT_UP],
-                          sts_strings[lane->statuses[VOLT_UP]], down_volt, lane->steps[VOLT_DOWN],
-                          sts_strings[lane->statuses[VOLT_DOWN]]);
-                }
+                fprintf(csv, "%f,%d,%s\n", down_volt, lane->steps[VOLT_DOWN],
+                        sts_strings[lane->statuses[VOLT_DOWN]]);
               else
-                {
-                  for (int k = 0; k < 6; k++)
-                    fprintf(csv, "NA,");
-                  fprintf(csv, "%f,%d,%s\n", up_volt, lane->steps[VOLT_UP],
-                          sts_strings[lane->statuses[VOLT_UP]]);
-                }
+                fprintf(csv, "NA,NA,NA\n");
             }
           else
             {
-              for (int k = 0; k < 8; k++)
+              for (int k = 0; k < 5; k++)
                 fprintf(csv, "NA,");
               fprintf(csv, "NA\n");
             }
diff --git a/pcilmr.c b/pcilmr.c
index f1ef140..accee44 100644
--- a/pcilmr.c
+++ b/pcilmr.c
@@ -189,10 +189,6 @@ main(int argc, char **argv)
   if (com_args->run_margin)
     {
       printf("Results:\n");
-      printf("\nPass/fail criteria:\nTiming:\n");
-      printf("Minimum Offset (spec): %d %% UI\nRecommended Offset: %d %% UI\n", MARGIN_TIM_MIN,
-             MARGIN_TIM_RECOMMEND);
-      printf("\nVoltage:\nMinimum Offset (spec): %d mV\n\n", MARGIN_VOLT_MIN);
       printf(
         "Margining statuses:\nLIM -\tErrorCount exceeded Error Count Limit (found device limit)\n");
       printf("NAK -\tDevice didn't execute last command, \n\tso result may be less reliable\n");
@@ -204,7 +200,7 @@ main(int argc, char **argv)
           printf("Link ");
           margin_log_bdfs(links[i].down_port.dev, links[i].up_port.dev);
           printf(":\n\n");
-          margin_results_print_brief(results[i], results_n[i]);
+          margin_results_print_brief(results[i], results_n[i], &links[i].args);
           if (com_args->save_csv)
             margin_results_save_csv(results[i], results_n[i], &links[i]);
           printf("\n");
-- 
2.34.1


