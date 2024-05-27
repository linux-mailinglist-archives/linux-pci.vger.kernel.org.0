Return-Path: <linux-pci+bounces-7858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12988D060B
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 17:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C89B41C20834
	for <lists+linux-pci@lfdr.de>; Mon, 27 May 2024 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D33C17E8E8;
	Mon, 27 May 2024 15:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="LnAdn2Vg";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="auVf7NRp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D61EB3E
	for <linux-pci@vger.kernel.org>; Mon, 27 May 2024 15:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823416; cv=none; b=ASZemAEE2QdHuNemkITT30rB5koUzmoT4j1Ro/YF5tMsvdG9UX5cKkoKzz6fAEBUbTYQtlMyNbPjrO1LzNk91+g5iXEthZdufooCGgFTYBuvRkOvTinKSWY2kGAMYvLX6Q4rb6gpnyKErccXmg5KD06vG0p95ebOtylP1XmEEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823416; c=relaxed/simple;
	bh=QK/HzbPMoUP+VEeLB5axEF713Im5/pscaUT5lEFOez0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMgtGa3IdM+gFniJYAzbRWJ9YTjgZcIJszdQ/TZY+qJpD4qZAn8lP6Z2TYvTv9x4DxPerRh979pukBMHnYa5gCWd8uWq8oRyUJydW1i7awMgm5ulMwc0kPXOw3+cE5Q++7djLJFWG8tdSRc8fTJYunsARDPgexznIfG+LBQzQrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=LnAdn2Vg; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=auVf7NRp; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 4C644C0010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1716823403; bh=k3dCAVjVsQUP+TKbxCRzvllaKPxalnrHRipAElDQaiQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LnAdn2VgEoTP+/84EyzyhKasUoaZIVPOIeAyVMyR/2yzBnKlpKJcqroHHWYCSOlh2
	 tuiUQnxhzrVaDtDYu2xBZRBONlE/HkjK0mBYB6ho2vYwy7fp9t1TCiyrZVL/hl4luS
	 ydqEzYhNjA5jt2T77uG3RjbcopvblvAMd8SnL4PcfWUVf081UFwVfb965Um7iRxcwi
	 nGa92/UKpyTJOwmVlJms7y116AKyok56wdgdfP2zdUMGS+erl1PyEjuUXSNAT6kz4j
	 aZBeh7S6QAMe6FSsSFUehZXuIWqOIJ+6Xts0hndUM6HHnU9G1RwWEDWJe32IRJCNe2
	 zlDzorbR/98vA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1716823403; bh=k3dCAVjVsQUP+TKbxCRzvllaKPxalnrHRipAElDQaiQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=auVf7NRpcbzPbE5mTAOnBga9jT0FM26Xeho5dq0vgcmp1ZOlgQI+sziEPd764/+6h
	 wFPK6J0aYBSdIuP6fAPWFnCntEdbHEdjWgTxwhPYXwfyas244FoG5Pf/4ZTBit1d5Q
	 /LXssllFGczGZcqbyFtqNAvGGXpOhEvMkTbI/LwytsgHZT+pPH+LfwUoJdvx68EPd6
	 dAmsc9r7ZTMrJ16XRdMIDlaChace2515vAt3awUwrEMgw0H+dPxBqhSdFixAF4yLK6
	 lj0xobAA74TD1dPXu+cUKjfPidx0whPFS78qqSimKPx9I695t7atCL9LN1hWyIYRVS
	 11oCumY39qE/g==
From: Nikita Proshkin <n.proshkin@yadro.com>
To: <linux-pci@vger.kernel.org>, Martin Mares <mj@ucw.cz>
CC: <linux@yadro.com>, Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
	Nikita Proshkin <n.proshkin@yadro.com>
Subject: [PATCH pciutils v2 rediff] pcilmr: Fix margining for ports with Lane reversal
Date: Mon, 27 May 2024 18:22:55 +0300
Message-ID: <20240527152255.35571-1-n.proshkin@yadro.com>
X-Mailer: git-send-email 2.34.1
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
index f070309..98df17a 100644
--- a/lmr/lmr.h
+++ b/lmr/lmr.h
@@ -24,7 +24,8 @@ static const double margin_ui[] = { 62.5, 31.25 };
 struct margin_dev {
   struct pci_dev *dev;
   int lmr_cap_addr;
-  u8 width;
+  u8 neg_width;
+  u8 max_width;
   u8 retimers_n;
   u8 link_speed;
 
@@ -234,7 +235,7 @@ void margin_log(char *format, ...);
 void margin_log_bdfs(struct pci_dev *down_port, struct pci_dev *up_port);
 void margin_gen_bdfs(struct pci_dev *down_port, struct pci_dev *up_port, char *dest, size_t maxlen);
 
-/* Print Link header (bdfs, width, speed) */
+/* Print Link header (bdfs, neg_width, speed) */
 void margin_log_link(struct margin_link *link);
 
 void margin_log_params(struct margin_params *params);
diff --git a/lmr/margin.c b/lmr/margin.c
index d05bb59..4d68031 100644
--- a/lmr/margin.c
+++ b/lmr/margin.c
@@ -165,7 +165,7 @@ read_params_internal(struct margin_dev *dev, u8 recvn, bool lane_reversal,
                      struct margin_params *params)
 {
   margin_cmd resp;
-  u8 lane = lane_reversal ? dev->width - 1 : 0;
+  u8 lane = lane_reversal ? dev->max_width - 1 : 0;
   margin_set_cmd(dev, lane, NO_COMMAND);
   bool status = margin_report_cmd(dev, lane, REPORT_CAPS(recvn), &resp);
   if (status)
@@ -366,7 +366,7 @@ margin_test_receiver(struct margin_dev *dev, u8 recvn, struct margin_link_args *
   for (int i = 0; i < lanes_n; i++)
     {
       results->lanes[i].lane
-        = recv.lane_reversal ? dev->width - lanes_to_margin[i] - 1 : lanes_to_margin[i];
+        = recv.lane_reversal ? dev->max_width - lanes_to_margin[i] - 1 : lanes_to_margin[i];
     }
 
   if (args->common->run_margin)
@@ -510,7 +510,7 @@ margin_process_args(struct margin_link *link)
 
   if (!args->lanes_n)
     {
-      args->lanes_n = dev->width;
+      args->lanes_n = dev->neg_width;
       for (int i = 0; i < args->lanes_n; i++)
         args->lanes[i] = i;
     }
@@ -518,7 +518,7 @@ margin_process_args(struct margin_link *link)
     {
       for (int i = 0; i < args->lanes_n; i++)
         {
-          if (args->lanes[i] >= dev->width)
+          if (args->lanes[i] >= dev->neg_width)
             {
               return MARGIN_TEST_ARGS_LANES;
             }
diff --git a/lmr/margin_hw.c b/lmr/margin_hw.c
index 2585ca1..c376549 100644
--- a/lmr/margin_hw.c
+++ b/lmr/margin_hw.c
@@ -112,15 +112,17 @@ static struct margin_dev
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
index 60c135d..2cb01c8 100644
--- a/lmr/margin_log.c
+++ b/lmr/margin_log.c
@@ -53,7 +53,7 @@ margin_log_link(struct margin_link *link)
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


