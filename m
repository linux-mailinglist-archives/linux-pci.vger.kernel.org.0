Return-Path: <linux-pci+bounces-663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50D809F44
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7133281816
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935AF125BF;
	Fri,  8 Dec 2023 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="kDzMAHpl";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="AmTq+fC6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A451735
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com F0038C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027150; bh=4OeTuXw8JJ5T+fGK4f2RemmfAw8cEwm0Qy2PQD//afE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=kDzMAHplFv1WLP0X88RfOTV1K6B6SB7mvRlbJy3rGJVJE+MzwEoIlpSMUeEbGUnq4
	 arqinNEGPTNDlHyuudxjX4hTFNywPGvKFCGAmGcoCSkuRukIxub89UdNSu+du3GcrJ
	 i2Dum6KdEArHkE/oMQYS27160fLYxBgUt6wnF7ReBz8oSPsj+DiHQWIijvz7MD+lLD
	 LE2EHbyxrb5WsvEr3LGpwr/IR+2U5567UWi1BK9B0ncrtbbFs4NiMObZVZ40z/0x+t
	 uC5UMbcAlAYhoVy7NT83dgcJ4fIN84Tedoez2Jyob0GX04cbn9UO2z5zJzxNe1G61o
	 Xz1ajwlLv3iWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027150; bh=4OeTuXw8JJ5T+fGK4f2RemmfAw8cEwm0Qy2PQD//afE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=AmTq+fC6D/QjpMsNwBD9mOJfNxFjrgcnbwTh4Y9ha24I3u4lbejiwbpSmZejZnure
	 F8GibqWLSLesJ8UuEQcN423Mxo9SiXea3hhtXb7EH1nDOcieTsA5F96usuvz3+dv78
	 VntdH7xzMDrl+9xNiTzMjnEEKuZfx9skWEVdPfJnw6/xiUFh0sC3JLcT9BhrMACG2D
	 TcNzC7kogQxTiePGskcjeJMSJkixJh24tZ+bnoc97onM3R9yPpCt08TuSKgmebsPWu
	 TCUXf6I3SyFKAzvMhuzKLOkkvu85yqDWTU4MAunWaE41y9VOOjDN3REvWbn0NnXcsO
	 qIOeKSoqX+vzg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 08/15] pciutils-pcilmr: Add function for default margining results log
Date: Fri, 8 Dec 2023 12:17:27 +0300
Message-ID: <20231208091734.12225-9-n.proshkin@yadro.com>
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

Lanes are rated according to the minimum/recommended values.
The minimum values are taken from the specification (Lane Margining at
the Receiver - Electrical Requirements).
30% UI recommended value for timing is taken from NVIDIA presentation
"PCIe 4.0 Mass Electrical Margins Data Collection".

Receiver lanes are called 'Weird' if all results of all receiver lanes
are equal to the spec minimum value.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr_lib/Makefile         |   2 +-
 lmr_lib/margin_results.c | 135 +++++++++++++++++++++++++++++++++++++++
 lmr_lib/margin_results.h |  13 ++++
 3 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 lmr_lib/margin_results.c
 create mode 100644 lmr_lib/margin_results.h

diff --git a/lmr_lib/Makefile b/lmr_lib/Makefile
index a0eefd6..193e164 100644
--- a/lmr_lib/Makefile
+++ b/lmr_lib/Makefile
@@ -1,4 +1,4 @@
-OBJS=margin_hw margin margin_log
+OBJS=margin_hw margin margin_log margin_results
 INCL=$(addsuffix .h,$(OBJS)) $(addprefix ../,$(PCIINC))
 
 $(addsuffix .o, $(OBJS)): %.o: %.c $(INCL)
diff --git a/lmr_lib/margin_results.c b/lmr_lib/margin_results.c
new file mode 100644
index 0000000..61f483a
--- /dev/null
+++ b/lmr_lib/margin_results.c
@@ -0,0 +1,135 @@
+#include <stdlib.h>
+#include <stdio.h>
+
+#include "margin_results.h"
+
+enum lane_rating {
+  BAD = 0,
+  OKAY,
+  PERFECT,
+  WEIRD,
+  INIT,
+};
+
+static char *const grades[] = {"Bad", "Okay", "Perfect", "Weird"};
+static char *const sts_strings[] = {"NAK", "LIM", "THR"};
+static const double ui[] = {62.5 / 100, 31.25 / 100};
+
+static enum lane_rating rate_lane(double value, double min, double recommended, enum lane_rating cur_rate)
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
+static bool check_recv_weird(struct margin_results *results, double tim_min, double volt_min)
+{
+  bool result = true;
+
+  struct margin_res_lane *lane;
+  for (uint8_t i = 0; i < results->lanes_n && result; i++)
+  {
+    lane = &(results->lanes[i]);
+    if (lane->steps[TIM_LEFT] * results->tim_coef != tim_min)
+      result = false;
+    if (results->ind_left_right_tim && lane->steps[TIM_RIGHT] * results->tim_coef != tim_min)
+      result = false;
+    if (results->volt_support)
+    {
+      if (lane->steps[VOLT_UP] * results->volt_coef != volt_min)
+        result = false;
+      if (results->ind_up_down_volt && lane->steps[VOLT_DOWN] * results->volt_coef != volt_min)
+        result = false;
+    }
+  }
+  return result;
+}
+
+void margin_results_print_brief(struct margin_results *results, uint8_t recvs_n)
+{
+  struct margin_res_lane *lane;
+  struct margin_results *recv;
+
+  enum lane_rating lane_rating;
+
+  uint8_t link_speed;
+
+  char *no_test_msgs[] = {
+      "", "Margining Ready bit is Clear",
+      "Error during caps reading",
+      "Margining prerequisites are not satisfied (Gen 4/5, D0)",
+      "Invalid lanes specified with arguments",
+      "Invalid receivers specified with arguments",
+      "Couldn't disable ASPM"};
+
+  for (uint8_t i = 0; i < recvs_n; i++)
+  {
+    recv = &(results[i]);
+    link_speed = recv->link_speed - 4;
+
+    if (recv->test_status != MARGIN_TEST_OK)
+    {
+      if (recv->test_status < MARGIN_TEST_PREREQS)
+        printf("Rx(%X) -", 10 + recv->recvn - 1);
+      printf(" Couldn't run test (%s)\n\n", no_test_msgs[recv->test_status]);
+      continue;
+    }
+
+    if (recv->lane_reversal)
+      printf("Rx(%X) - Lane Reversal\n", 10 + recv->recvn - 1);
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
+      printf("Rx(%X) Lane %2d - %s\t", 10 + recv->recvn - 1, lane->lane, grades[lane_rating]);
+      if (recv->ind_left_right_tim)
+        printf("L %4.1f%% UI - %5.2fps - %2dst %s, R %4.1f%% UI - %5.2fps - %2dst %s", left_ui,
+               left_ui * ui[link_speed], lane->steps[TIM_LEFT], sts_strings[lane->statuses[TIM_LEFT]], right_ui,
+               right_ui * ui[link_speed], lane->steps[TIM_RIGHT], sts_strings[lane->statuses[TIM_RIGHT]]);
+      else
+        printf("T %4.1f%% UI - %5.2fps - %2dst %s", left_ui, left_ui * ui[link_speed],
+               lane->steps[TIM_LEFT], sts_strings[lane->statuses[TIM_LEFT]]);
+      if (recv->volt_support)
+      {
+        if (recv->ind_up_down_volt)
+          printf(", U %5.1f mV - %3dst %s, D %5.1f mV - %3dst %s", up_volt,
+                 lane->steps[VOLT_UP], sts_strings[lane->statuses[VOLT_UP]],
+                 down_volt, lane->steps[VOLT_DOWN], sts_strings[lane->statuses[VOLT_DOWN]]);
+        else
+          printf(", V %5.1f mV - %3dst %s", up_volt, lane->steps[VOLT_UP], sts_strings[lane->statuses[VOLT_UP]]);
+      }
+      printf("\n");
+    }
+    printf("\n");
+  }
+}
diff --git a/lmr_lib/margin_results.h b/lmr_lib/margin_results.h
new file mode 100644
index 0000000..ab6ddb0
--- /dev/null
+++ b/lmr_lib/margin_results.h
@@ -0,0 +1,13 @@
+#ifndef _MARGIN_RESULTS_H
+#define _MARGIN_RESULTS_H
+
+#include "margin.h"
+
+#define MARGIN_TIM_MIN 20
+#define MARGIN_TIM_RECOMMEND 30
+
+#define MARGIN_VOLT_MIN 50
+
+void margin_results_print_brief(struct margin_results *results, uint8_t recvs_n);
+
+#endif
-- 
2.34.1


