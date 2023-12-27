Return-Path: <linux-pci+bounces-1429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB0481EDE6
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCF81C2239E
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344AF24B2F;
	Wed, 27 Dec 2023 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="wPU8GMx1";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="uGLdwg8X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF142869B
	for <linux-pci@vger.kernel.org>; Wed, 27 Dec 2023 09:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com ECFAAC000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1703670383; bh=fawPkXjGzoh/XKSOhgqVt8rUb5W7gXYgFRqlnvPfLL8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=wPU8GMx1ShhCiOKpKXoj3GAPIMXgXBkJafBxcKfIeCPPGdGf5pRtqlBaJp/PrRHw3
	 sCuL8SbNnncB3FxaJeWHR/PLaUuaJh74kPNv8UNJS+4Nz1gXZ7LApHEH27aRMsl6NB
	 h+QoVBgwTNptiVJYkLxSiUrJMGkZMqScCNovjw+1q6NdkyuF+CV0+b0XdVeTKfTXAM
	 eBRQUCiz9jT4hGK+fvAHprj6t6X4mugzF0fTHrg07TNnknBy7DtpLiTae8fpAjTfFH
	 pcf6OTY01TudqKRkbaYPz3MAdHiK5PFoZ4b1ga0FOV0iL/dzWfqU4ywCoUBIMLlYOt
	 Z2rbIWmR3m4Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1703670383; bh=fawPkXjGzoh/XKSOhgqVt8rUb5W7gXYgFRqlnvPfLL8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=uGLdwg8X4KP+uwAOuAQkAIkisaCWXOZ8sMJ+yw32+cTvInEtuIB6h7TKJyVbwFK0i
	 d2VkXCpQDXrQqX12inh2fsyDVtnfHoZh8K1khUTAJgw+9Ivlm7aP10+mtN8MJXjPoK
	 S6M+or3ZjnGQEeQCWCkwocwvgq7LdUjNqQb2iU90zHey/ZcWUI0GsYAKTc+GJrmasU
	 EsEDNlDBltkXDVZeREnu9QocHRN9rMJiRps+4ZVGijPCD1vc8YEKp8sxONPKThS1GP
	 YRvoEAbpU+HuwFphQo/rhnxdanIUayNUJJfkREgisJE9f+2y0gF/379BlRsuFofw5u
	 pVDLY0Ryug+Jg==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Bjorn Helgaas <helgaas@kernel.org>, Sergei
 Miroshnichenko <s.miroshnichenko@yadro.com>, Nikita Proshkin
	<n.proshkin@yadro.com>
Subject: [PATCH v2 14/15] pciutils-pcilmr: Add handling of situations when device reports its MaxOffset values equal to 0
Date: Wed, 27 Dec 2023 14:45:03 +0500
Message-ID: <20231227094504.32257-15-n.proshkin@yadro.com>
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

According to spec, for the MaxTimingOffset and MaxVoltageOffset parameters
'A 0 value may be reported if the vendor chooses not to report the offset'.

Use max possible Offset value in such situations and report to the user.

Reviewed-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h            |  3 +++
 lmr/margin.c         |  9 +++++++--
 lmr/margin_log.c     |  7 +++++++
 lmr/margin_results.c | 13 +++++++++++++
 4 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/lmr/lmr.h b/lmr/lmr.h
index c9dcd69..7375c33 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -107,6 +107,9 @@ struct margin_results {
   double tim_coef;
   double volt_coef;
 
+  bool tim_off_reported;
+  bool volt_off_reported;
+
   u8 lanes_n;
   struct margin_res_lane *lanes;
 };
diff --git a/lmr/margin.c b/lmr/margin.c
index cc142fa..0b14747 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -328,8 +328,13 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
   margin_apply_hw_quirks(&recv);
   margin_log_hw_quirks(&recv);
 
-  results->tim_coef = (double)params.timing_offset / (double)params.timing_steps;
-  results->volt_coef = (double)params.volt_offset / (double)params.volt_steps * 10.0;
+  results->tim_off_reported = params.timing_offset != 0;
+  results->volt_off_reported = params.volt_offset != 0;
+  double tim_offset = results->tim_off_reported ? (double)params.timing_offset : 50.0;
+  double volt_offset = results->volt_off_reported ? (double)params.volt_offset : 50.0;
+
+  results->tim_coef = tim_offset / (double)params.timing_steps;
+  results->volt_coef = volt_offset / (double)params.volt_steps * 10.0;
 
   results->lane_reversal = recv.lane_reversal;
   results->link_speed = dev->link_speed;
diff --git a/lmr/margin_log.c b/lmr/margin_log.c
index a93e07b..b3c4bd5 100644
--- a/lmr/margin_log.c
+++ b/lmr/margin_log.c
@@ -86,6 +86,13 @@ margin_log_receiver(struct margin_recv *recv)
       margin_log("\nWarning: device uses Lane Reversal.\n");
       margin_log("However, utility uses logical lane numbers in arguments and for logging.\n");
     }
+
+  if (recv->params->timing_offset == 0)
+    margin_log("\nWarning: Vendor chose not to report the Max Timing Offset.\n"
+               "Utility will use its max possible value - 50 (50%% UI).\n");
+  if (recv->params->volt_support && recv->params->volt_offset == 0)
+    margin_log("\nWarning: Vendor chose not to report the Max Voltage Offset.\n"
+               "Utility will use its max possible value - 50 (500 mV).\n");
 }
 
 void
diff --git a/lmr/margin_results.c b/lmr/margin_results.c
index aca3ab7..6d6ed29 100644
--- a/lmr/margin_results.c
+++ b/lmr/margin_results.c
@@ -105,6 +105,19 @@ margin_results_print_brief(struct margin_results *results, u8 recvs_n)
       if (res->lane_reversal)
         printf("Rx(%X) - Lane Reversal\n", 10 + res->recvn - 1);
 
+      if (!res->tim_off_reported)
+        printf("Rx(%X) - Attention: Vendor chose not to report the Max Timing Offset.\n"
+               "Utility used its max possible value (50%% UI) for calculations of %% UI and ps.\n"
+               "Keep in mind that for timing results of this receiver only steps values are "
+               "reliable.\n\n",
+               10 + res->recvn - 1);
+      if (params.volt_support && !res->volt_off_reported)
+        printf("Rx(%X) - Attention: Vendor chose not to report the Max Voltage Offset.\n"
+               "Utility used its max possible value (500 mV) for calculations of mV.\n"
+               "Keep in mind that for voltage results of this receiver only steps values are "
+               "reliable.\n\n",
+               10 + res->recvn - 1);
+
       if (check_recv_weird(res, MARGIN_TIM_MIN, MARGIN_VOLT_MIN))
         lane_rating = WEIRD;
       else
-- 
2.34.1


