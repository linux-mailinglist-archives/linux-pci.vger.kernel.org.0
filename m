Return-Path: <linux-pci+bounces-662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19789809F43
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 10:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46101F2189C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 09:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED17612B89;
	Fri,  8 Dec 2023 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="FL5Lv0bW";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="i8hxbAOM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935611731
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 01:26:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 45B41C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1702027159; bh=d6ukGsW2xVNmO3qJw9x+RgYelgSmQcsNU+qJNZKnTPA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=FL5Lv0bW4xGrswmMP1mJQopeQz8RHIVNyM1WOmL6ghkgllkYEh2uO88tAwSy3G2z8
	 1ZGjoIrMzAggZnuwPoeirp7+/ruiIuwS3nbuZbi/FhRPxn5B20/kuPqq99dRSEiHtH
	 M2rttd5igidSRk/z9a/0QYD8jwR+QvnVDJ3sXZtSC7jQ90zifT6oq1lP78AAINaIfK
	 DD6XEWKk1cyR/uhC5fIBQK+7mkaz+kvy1o0KLgeI7sZwc53Njot06Jss7aCwGf2njq
	 bATwAeqM21BsXSUylJSs5VAnhUXoJngIpEr8xZIIKfkYugnjPhyplgeuLBgP/J4f3y
	 0Ij84TCV6JNsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1702027159; bh=d6ukGsW2xVNmO3qJw9x+RgYelgSmQcsNU+qJNZKnTPA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=i8hxbAOMjkDg4DPKstEwj636Qrf8uXIhO9UJjJ/J1QDRXEPiiCTsaLiM8FCl4dNzS
	 HkVoikXF5cUlj8nk2qIpyAvHGfl7nHf1RXdtjTjt+OwKRszscZblQQ5NBlAmC6LGci
	 zWTBdZGlZyLDcIwuF3oR3uZTkDer9C3FWxMD/HpKVTq+4V2oy9RJYF7ZPIFQ2VyRzK
	 P7JF9NaKX87S+gGaLhEOOW7BOTD/x3HL+3wBttc/j0KRyFHXAuvpB43AsWoMdxsGO+
	 8uWKB1QpwTf6K1Q+fg1e7+CmQk702clVUwRF7ZmFllgI72VFr8UwE38DQF+3jTMDtW
	 c88cB7uF5fdWQ==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH 14/15] pciutils-pcilmr: Add handling of situations when device reports its MaxOffset values equal to 0
Date: Fri, 8 Dec 2023 12:17:33 +0300
Message-ID: <20231208091734.12225-15-n.proshkin@yadro.com>
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

According to spec, for the MaxTimingOffset and MaxVoltageOffset parameters
'A 0 value may be reported if the vendor chooses not to report the offset'.

Use max possible Offset value in such situations and report to the user.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr_lib/margin.c         |  9 +++++++--
 lmr_lib/margin.h         |  3 +++
 lmr_lib/margin_log.c     | 11 +++++++++++
 lmr_lib/margin_results.c | 12 ++++++++++++
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/lmr_lib/margin.c b/lmr_lib/margin.c
index ac20e82..cb9a9da 100644
--- a/lmr_lib/margin.c
+++ b/lmr_lib/margin.c
@@ -271,8 +271,13 @@ bool margin_receiver(struct margin_recv *recv, struct margin_args *args, struct
       recv->parallel_lanes = recv->max_lanes + 1;
     margin_apply_hw_quirks(recv);
 
-    results->tim_coef = (double)recv->timing_offset / (double)recv->timing_steps;
-    results->volt_coef = (double)recv->volt_offset / (double)recv->volt_steps * 10.0;
+    results->tim_off_reported = recv->timing_offset != 0;
+    results->volt_off_reported = recv->volt_offset != 0;
+    double tim_offset = results->tim_off_reported ? (double)recv->timing_offset : 50.0;
+    double volt_offset = results->volt_off_reported ? (double)recv->volt_offset : 50.0;
+
+    results->tim_coef = tim_offset / (double)recv->timing_steps;
+    results->volt_coef = volt_offset / (double)recv->volt_steps * 10.0;
 
     results->ind_left_right_tim = recv->ind_left_right_tim;
     results->volt_support = recv->volt_support;
diff --git a/lmr_lib/margin.h b/lmr_lib/margin.h
index 8f3506b..8f82f30 100644
--- a/lmr_lib/margin.h
+++ b/lmr_lib/margin.h
@@ -129,6 +129,9 @@ struct margin_results {
   double tim_coef;
   double volt_coef;
 
+  bool tim_off_reported;
+  bool volt_off_reported;
+
   uint8_t lanes_n;
   struct margin_res_lane *lanes;
 };
diff --git a/lmr_lib/margin_log.c b/lmr_lib/margin_log.c
index e57bd79..83652f1 100644
--- a/lmr_lib/margin_log.c
+++ b/lmr_lib/margin_log.c
@@ -49,6 +49,17 @@ void margin_log_print_caps(struct margin_recv *recv)
     margin_log("\nWarning: device uses Lane Reversal.\n");
     margin_log("However, utility uses logical lane numbers in arguments and for logging.\n");
   }
+
+  if (recv->timing_offset == 0)
+  {
+    margin_log("\nWarning: Vendor chose not to report the Max Timing Offset.\n"
+               "Utility will use its max possible value - 50 (50%% UI).\n");
+  }
+  if (recv->volt_support && recv->volt_offset == 0)
+  {
+    margin_log("\nWarning: Vendor chose not to report the Max Voltage Offset.\n"
+               "Utility will use its max possible value - 50 (500 mV).\n");
+  }
 }
 
 void margin_log_link(struct margin_dev *down, struct margin_dev *up)
diff --git a/lmr_lib/margin_results.c b/lmr_lib/margin_results.c
index cc6132f..656f1fe 100644
--- a/lmr_lib/margin_results.c
+++ b/lmr_lib/margin_results.c
@@ -87,6 +87,18 @@ void margin_results_print_brief(struct margin_results *results, uint8_t recvs_n)
 
     if (recv->lane_reversal)
       printf("Rx(%X) - Lane Reversal\n", 10 + recv->recvn - 1);
+
+    if (!recv->tim_off_reported)
+      printf("Rx(%X) - Attention: Vendor chose not to report the Max Timing Offset.\n"
+             "Utility used its max possible value (50%% UI) for calculations of %% UI and ps.\n"
+             "Keep in mind that for timing results of this receiver only steps values are reliable.\n\n",
+             10 + recv->recvn - 1);
+    if (recv->volt_support && !recv->volt_off_reported)
+      printf("Rx(%X) - Attention: Vendor chose not to report the Max Voltage Offset.\n"
+             "Utility used its max possible value (500 mV) for calculations of mV.\n"
+             "Keep in mind that for voltage results of this receiver only steps values are reliable.\n\n",
+             10 + recv->recvn - 1);
+
     if (check_recv_weird(recv, MARGIN_TIM_MIN, MARGIN_VOLT_MIN))
       lane_rating = WEIRD;
     else
-- 
2.34.1


