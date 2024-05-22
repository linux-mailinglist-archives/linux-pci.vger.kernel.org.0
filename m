Return-Path: <linux-pci+bounces-7753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 181F78CC4A5
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 18:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B5A228320B
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C69024B2A;
	Wed, 22 May 2024 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="GB0uvdVQ";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="xQr9SDC6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E21E517
	for <linux-pci@vger.kernel.org>; Wed, 22 May 2024 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394119; cv=none; b=b4Bld1CQxCutNkgYWJFlNzoeKaTLDY09xnNOHUZmrbyr03aSX+72D7f0cSmqScv0MaWgjjb8U117NxKwSKqpxLNhX6rEUIqgAcy7ESyWPof1ho3Nn7FqQlSO7DshPOne0wEWYMl03E5Bo3xg7yq2F3zCUlX0aN7Y2xATdMnQEDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394119; c=relaxed/simple;
	bh=umnt3XSDlUzNgS0WguWp5Fbj2FWoMCEvEWWIyaJNhrE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bvG4hMDzsASctnuP97gB9tmyW4mJd7d5YFCrs3kfkn2zWdCEohSOX2LoVEX2QIjhIb9CZbpnsdmPTJYy7A/ZTBWgLaLwZRVYsktjAXw2b1gz9fC/haR9ner0+DnD0JLF5KPlGQtZ5MHbkKzoQ9DiPZuaeNarwhil4gR4zcg/ZV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=GB0uvdVQ; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=xQr9SDC6; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 77EF4C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716394115; bh=9jAd/2vaDoZODrJMIjtCRAoZu+ws3Ap6s05qRYDaIO8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=GB0uvdVQ4Tfc7UU98ot8xSyVmBxbg7EJGwK/nHbgVksxwu63EzKTmJm2qMvYYa5sx
	 FInLSMQlzouUrK5TMQgwPb97nArsCHERQBH/KkC8NH/bYKra++7kt9tdUtCxIJ4SoJ
	 RYr/zc7uuBh7aX0x/Yv/KEuSxwDbzbXDJY754C/Mx5yQV5UiXpzOGBjaTSQn7C9uFY
	 FWylzduOfCCxD+GjCCf3zokVJXGSzCDaz6Jm6u6Q3BF0Qk1szENWO432TfO2948gI4
	 rKgSGD4bcRwV+o1wyZrFwbcHqeen/EAk9xLH/ITj5I719eGqwx/xaBEJhIF/9H+Epi
	 514QtsBeJZw4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716394115; bh=9jAd/2vaDoZODrJMIjtCRAoZu+ws3Ap6s05qRYDaIO8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=xQr9SDC6/CzXc1UMYIQqmh5sLRqCJkP0fazmkw2zybuQTCf86SPoq+0us0+Qvw16y
	 9nxkrusisXfyiq4i7gjGfyFaHr0RydBbgJf9Js9HDQaG0I/mQfZIBb6ad7eTb/JrCY
	 GXphpcRFxTYybv045uL/BglSDWwnLnRTI4IFJcZeF0EOs7iT54Azyzu5lLzS7umaej
	 Pl9La550G29sVZ5ZZFwmIH/pbjjXWB8EjbPIvLoMqlb+PpgUVf0C9tUTZFoFX4RIHI
	 VpA88RO8Xz6s21vBWRW0uG4AbPhNoWZOgytaRY92wOtxtDxg5Pz/z/+7IdhyAikKXP
	 yzQmWgDHTJRew==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils] pcilmr: Fix margining for ports with Lane reversal
Date: Wed, 22 May 2024 19:08:19 +0300
Message-ID: <20240522160819.30208-1-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 S-Exch-02.corp.yadro.com (10.78.5.239)

Current implementation interacts only with first Negotiated Link Width
lanes even when Maximum Link Width for the port is bigger than that and
Lane reversal is used. Utility in such situation may try to margin lane
which is not used right now and erroneously fail with
'Error during caps reading' message. Fix that behaviour.

Signed-off-by: Nikita Proshkin <n.proshkin@yadro.com>
---
 lmr/lmr.h        |  5 +++--
 lmr/margin.c     |  8 ++++----
 lmr/margin_hw.c  | 20 +++++++++++---------
 lmr/margin_log.c |  2 +-
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/lmr/lmr.h b/lmr/lmr.h
index 7375c33..2e5da7c 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -27,7 +27,8 @@ enum margin_hw { MARGIN_HW_DEFAULT, MARGIN_ICE_LAKE_RC };
 struct margin_dev {
   struct pci_dev *dev;
   int lmr_cap_addr;
-  u8 width;
+  u8 neg_width;
+  u8 max_width;
   u8 retimers_n;
   u8 link_speed;
 
@@ -202,7 +203,7 @@ void margin_log(char *format, ...);
 /* b:d.f -> b:d.f */
 void margin_log_bdfs(struct pci_dev *down_port, struct pci_dev *up_port);
 
-/* Print Link header (bdfs, width, speed) */
+/* Print Link header (bdfs, neg_width, speed) */
 void margin_log_link(struct margin_link *link);
 
 void margin_log_params(struct margin_params *params);
diff --git a/lmr/margin.c b/lmr/margin.c
index a8c6571..a432f68 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -161,7 +161,7 @@ read_params_internal(struct margin_dev *dev, u8 recvn, bool lane_reversal,
                      struct margin_params *params)
 {
   margin_cmd resp;
-  u8 lane = lane_reversal ? dev->width - 1 : 0;
+  u8 lane = lane_reversal ? dev->max_width - 1 : 0;
   margin_set_cmd(dev, lane, NO_COMMAND);
   bool status = margin_report_cmd(dev, lane, REPORT_CAPS(recvn), &resp);
   if (status)
@@ -361,7 +361,7 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_args *args,
   for (int i = 0; i < lanes_n; i++)
     {
       results->lanes[i].lane
-        = recv.lane_reversal ? dev->width - lanes_to_margin[i] - 1 : lanes_to_margin[i];
+        = recv.lane_reversal ? dev->max_width - lanes_to_margin[i] - 1 : lanes_to_margin[i];
     }
 
   if (args->run_margin)
@@ -524,7 +524,7 @@ margin_process_args(struct margin_dev *dev, struct margin_args *args)
 
   if (!args->lanes_n)
     {
-      args->lanes_n = dev->width;
+      args->lanes_n = dev->neg_width;
       for (int i = 0; i < args->lanes_n; i++)
         args->lanes[i] = i;
     }
@@ -532,7 +532,7 @@ margin_process_args(struct margin_dev *dev, struct margin_args *args)
     {
       for (int i = 0; i < args->lanes_n; i++)
         {
-          if (args->lanes[i] >= dev->width)
+          if (args->lanes[i] >= dev->neg_width)
             {
               return MARGIN_TEST_ARGS_LANES;
             }
diff --git a/lmr/margin_hw.c b/lmr/margin_hw.c
index fc427c8..9ef8f1a 100644
--- a/lmr/margin_hw.c
+++ b/lmr/margin_hw.c
@@ -70,15 +70,17 @@ static struct margin_dev
 fill_dev_wrapper(struct pci_dev *dev)
 {
   struct pci_cap *cap = pci_find_cap(dev, PCI_CAP_ID_EXP, PCI_CAP_NORMAL);
-  struct margin_dev res
-    = { .dev = dev,
-        .lmr_cap_addr = pci_find_cap(dev, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED)->addr,
-        .width = GET_REG_MASK(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA), PCI_EXP_LNKSTA_WIDTH),
-        .retimers_n
-        = (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_RETIMER))
-          + (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_2RETIMERS)),
-        .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED),
-        .hw = detect_unique_hw(dev) };
+  struct margin_dev res = {
+    .dev = dev,
+    .lmr_cap_addr = pci_find_cap(dev, PCI_EXT_CAP_ID_LMR, PCI_CAP_EXTENDED)->addr,
+    .neg_width = GET_REG_MASK(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA), PCI_EXP_LNKSTA_WIDTH),
+    .max_width = GET_REG_MASK(pci_read_long(dev, cap->addr + PCI_EXP_LNKCAP), PCI_EXP_LNKCAP_WIDTH),
+    .retimers_n
+    = (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_RETIMER))
+      + (!!(pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA2) & PCI_EXP_LINKSTA2_2RETIMERS)),
+    .link_speed = (pci_read_word(dev, cap->addr + PCI_EXP_LNKSTA) & PCI_EXP_LNKSTA_SPEED),
+    .hw = detect_unique_hw(dev)
+  };
   return res;
 }
 
diff --git a/lmr/margin_log.c b/lmr/margin_log.c
index b3c4bd5..b03d2b8 100644
--- a/lmr/margin_log.c
+++ b/lmr/margin_log.c
@@ -42,7 +42,7 @@ margin_log_link(struct margin_link *link)
 {
   margin_log("Link ");
   margin_log_bdfs(link->down_port.dev, link->up_port.dev);
-  margin_log("\nNegotiated Link Width: %d\n", link->down_port.width);
+  margin_log("\nNegotiated Link Width: %d\n", link->down_port.neg_width);
   margin_log("Link Speed: %d.0 GT/s = Gen %d\n", (link->down_port.link_speed - 3) * 16,
              link->down_port.link_speed);
   margin_log("Available receivers: ");
-- 
2.34.1


