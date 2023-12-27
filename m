Return-Path: <linux-pci+bounces-1423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF781EDE0
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378BC1C21616
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ECA28DAF;
	Wed, 27 Dec 2023 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="FaBpZNlf";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ZHuvVNFI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB6C24B2F
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com DE4F7C000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670373; bh=CcF98B8RDvfXdgFqkGZKx6NB2ZRea34z09tQdPsmn/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=FaBpZNlfj4qxqu65a6o3degW4NBCd1c2gAM4DydYY3pkRFeM26l+0dwTzcgDMt4vO
	 iib0K5AJtLtc5cpGWKDHW2OQKy9wh+JvLHJbx9nde5fFn7zNXDk2U6AfJoATD9mYqc
	 OQpRWLdcbo8rirAA08xxyUXVRAtxso7ndm1alRKiA/au9x70/vD8kS3WJplxAu/sfT
	 NsKexJPLrHy9Aa74Hs7KtNhIMVmVlRZva+ORpiy1r03Fv0Ndd7sMIxiRlt/63TuG62
	 HVvssGzXtKcNCcAbeJRtEQreZWGtohMtsCvWCuGsqRZUw3JjKOn38RpohHt1tShJnV
	 TmFudeJ4Od+og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670373; bh=CcF98B8RDvfXdgFqkGZKx6NB2ZRea34z09tQdPsmn/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ZHuvVNFI7qiB+n3+zhWcgko7+H14kf6/7RyOcxDCVIkrNzCjbhIRPpAIkwXb6RSKg
	 +5cxO1dXTSPyOR1j3FI01cxMJyANnT2R1aMVbOMR3C8ePQUU20eFM2WGPhU1xyv94P
	 g9ASzdxfbNIWP9ck4VW/7eJBxgQryxLwVfp7RIkLABRuLzQTP0zcTsB/Dv4tWK3070
	 oncNsaLsG22ACky91NGwSyOZKFT8tirvu0sW2k9aG1uOTTs02I0wf+tdra7LWUSw0d
	 q5cSgl3QloaWCc6HtIJ8izLBWXXv8BjsxQ9Z08AX8RjKxxPTOr59QDMXVQXiPuq3/G
	 k7+Vc7Yn0Pdiw==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 08/15] pciutils-pcilmr: Add function for default margining results log
Date: Wed, 27 Dec 2023 14:44:57 +0500
Message-ID: <20231227094504.32257-9-n.proshkin@yadro.com>
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

Lanes are rated according to the minimum/recommended values.
The minimum values are taken from PCIe Base Spec Rev 5.0 section 8.4.4.
30% UI recommended value for timing is taken from NVIDIA presentation
"PCIe 4.0 Mass Electrical Margins Data Collection".

Receiver lanes are called 'Weird' if all results of all receiver lanes
are equal to the spec minimum value.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h            |   8 +++
 lmr/margin_results.c | 159 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)
 create mode 100644 lmr/margin_results.c

diff --git a/lmr/lmr.h b/lmr/lmr.h
index c3a5039..d35b8ae 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -17,6 +17,10 @@
 
 #define MARGIN_STEP_MS 1000
 
+#define MARGIN_TIM_MIN       20
+#define MARGIN_TIM_RECOMMEND 30
+#define MARGIN_VOLT_MIN      50
+
 /* PCI Device wrapper for margining functions */
 struct margin_dev {
   struct pci_dev *dev;
@@ -205,4 +209,8 @@ void margin_log_receiver(struct margin_recv *recv);
 /* Margining in progress log */
 void margin_log_margining(struct margin_lanes_data arg);
 
+/* margin_results */
+
+void margin_results_print_brief(struct margin_results *results, u8 recvs_n);
+
 #endif
diff --git a/lmr/margin_results.c b/lmr/margin_results.c
new file mode 100644
index 0000000..5ee065d
--- /dev/null
+++ b/lmr/margin_results.c
@@ -0,0 +1,159 @@
+/*
+ *	The PCI Utilities -- Display/save margining results
+ *
+ *	Copyright (c) 2023 KNS Group LLC (YADRO)
+ *
+ *	Can be freely distributed and used under the terms of the GNU GPL v2+.
+ *
+ *	SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+
+#include "lmr.h"
+
+enum lane_rating {
+  BAD = 0,
+  OKAY,
+  PERFECT,
+  WEIRD,
+  INIT,
+};
+
+static char *const grades[] = { "Bad", "Okay", "Perfect", "Weird" };
+static char *const sts_strings[] = { "NAK", "LIM", "THR" };
+static const double ui[] = { 62.5 / 100, 31.25 / 100 };
+
+static enum lane_rating
+rate_lane(double value, double min, double recommended, enum lane_rating cur_rate)
+{
+  enum lane_rating res = PERFECT;
+  if (value < recommended)
+    res = OKAY;
+  if (value < min)
+    res = BAD;
+  if (cur_rate == INIT)
+    return res;
+  if (res < cur_rate)
+    return res;
+  else
+    return cur_rate;
+}
+
+static bool
+check_recv_weird(struct margin_results *results, double tim_min, double volt_min)
+{
+  bool result = true;
+
+  struct margin_res_lane *lane;
+  for (int i = 0; i < results->lanes_n && result; i++)
+    {
+      lane = &(results->lanes[i]);
+      if (lane->steps[TIM_LEFT] * results->tim_coef != tim_min)
+        result = false;
+      if (results->params.ind_left_right_tim
+          && lane->steps[TIM_RIGHT] * results->tim_coef != tim_min)
+        result = false;
+      if (results->params.volt_support)
+        {
+          if (lane->steps[VOLT_UP] * results->volt_coef != volt_min)
+            result = false;
+          if (results->params.ind_up_down_volt
+              && lane->steps[VOLT_DOWN] * results->volt_coef != volt_min)
+            result = false;
+        }
+    }
+  return result;
+}
+
+void
+margin_results_print_brief(struct margin_results *results, u8 recvs_n)
+{
+  struct margin_res_lane *lane;
+  struct margin_results *res;
+  struct margin_params params;
+
+  enum lane_rating lane_rating;
+
+  u8 link_speed;
+
+  char *no_test_msgs[] = { "",
+                           "Margining Ready bit is Clear",
+                           "Error during caps reading",
+                           "Margining prerequisites are not satisfied (16/32 GT/s, D0)",
+                           "Invalid lanes specified with arguments",
+                           "Invalid receivers specified with arguments",
+                           "Couldn't disable ASPM" };
+
+  for (int i = 0; i < recvs_n; i++)
+    {
+      res = &(results[i]);
+      params = res->params;
+      link_speed = res->link_speed - 4;
+
+      if (res->test_status != MARGIN_TEST_OK)
+        {
+          if (res->test_status < MARGIN_TEST_PREREQS)
+            printf("Rx(%X) -", 10 + res->recvn - 1);
+          printf(" Couldn't run test (%s)\n\n", no_test_msgs[res->test_status]);
+          continue;
+        }
+
+      if (res->lane_reversal)
+        printf("Rx(%X) - Lane Reversal\n", 10 + res->recvn - 1);
+
+      if (check_recv_weird(res, MARGIN_TIM_MIN, MARGIN_VOLT_MIN))
+        lane_rating = WEIRD;
+      else
+        lane_rating = INIT;
+
+      for (u8 j = 0; j < res->lanes_n; j++)
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
+          printf("Rx(%X) Lane %2d - %s\t", 10 + res->recvn - 1, lane->lane, grades[lane_rating]);
+          if (params.ind_left_right_tim)
+            printf("L %4.1f%% UI - %5.2fps - %2dst %s, R %4.1f%% UI - %5.2fps - %2dst %s", left_ui,
+                   left_ui * ui[link_speed], lane->steps[TIM_LEFT],
+                   sts_strings[lane->statuses[TIM_LEFT]], right_ui, right_ui * ui[link_speed],
+                   lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
+          else
+            printf("T %4.1f%% UI - %5.2fps - %2dst %s", left_ui, left_ui * ui[link_speed],
+                   lane->steps[TIM_LEFT], sts_strings[lane->statuses[TIM_LEFT]]);
+          if (params.volt_support)
+            {
+              if (params.ind_up_down_volt)
+                printf(", U %5.1f mV - %3dst %s, D %5.1f mV - %3dst %s", up_volt,
+                       lane->steps[VOLT_UP], sts_strings[lane->statuses[VOLT_UP]], down_volt,
+                       lane->steps[VOLT_DOWN], sts_strings[lane->statuses[VOLT_DOWN]]);
+              else
+                printf(", V %5.1f mV - %3dst %s", up_volt, lane->steps[VOLT_UP],
+                       sts_strings[lane->statuses[VOLT_UP]]);
+            }
+          printf("\n");
+        }
+      printf("\n");
+    }
+}
-- 
2.34.1


