Return-Path: <linux-pci+bounces-25766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D17A87545
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C143188CE11
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C011487E1;
	Mon, 14 Apr 2025 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="JjQO4ABu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3270.qiye.163.com (mail-m3270.qiye.163.com [220.197.32.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D314634
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 01:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744594074; cv=none; b=OIq7ulgMNR2r9xB5BN1ZY1eSeXFTSNnQ2GHY5xgRXBpwhDubcmbDVZ9BtVlMjVw1+GMKT1SsgpFFUvneqWJJn79LRRZuGexy4CitQeKSchVqdx7bTrSP2mI1NyqxL3Q3DmG974mwy1UH7KdpZJpz98pS+BFCgyJcJ66lO4be1ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744594074; c=relaxed/simple;
	bh=LwrvfECXf5DldpSjeB1/XI+QYI1b9kadOyc0YBLF01o=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ua/tYUzLE6YXCQ14rEoxnII52/FaULOiGh4egFHSvxV1gfuHyeaqvvjffbJISH6X/PaBTSX3GplViLpu8q5PR5w/tJtl8/anL5IjFvxMgJP6JVPhRMUMPdoevkeXu+IeNGpJOrcTH6TR+qu17q/If9xTVwYKKO+v+mMKNHIzLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=JjQO4ABu; arc=none smtp.client-ip=220.197.32.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 11ba07f80;
	Mon, 14 Apr 2025 09:27:41 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/2] PCI: dw-rockchip: Enable L0S capability
Date: Mon, 14 Apr 2025 09:27:31 +0800
Message-Id: <1744594051-209255-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU4YSFYfS0lDGEweGhgYGU1WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9631e8c83109cckunm11ba07f80
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mkk6ERw6FjJWMC4vTigNQw8J
	FkxPCx5VSlVKTE9PTkJPS01JT0pIVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhJSEM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=JjQO4ABunhJdKRnzLJ4GefumjA2BsuJwEd/MgJdR08IcrhX0iGiQXDWtKnF8yRBczCq6oAUFdcRHzWbAglTGLZ70wJdUjhJvflquK/ulQ2y5E2tMRr1v2XjAv/LoJr+kSBACfQcJxAjVtNAOxAtXt26jgQnR7df7xEUpSFIHjJ0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=OxdNaXCyAeYXEowqe4VRE8Max3v8FCj6DS4Psx2YHb4=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

L0S capability isn't enabled on all SoCs by default, so enabling it
in order to make ASPM L0S work on Rockchip platforms. We have been
testing it for quite a long time and found the default FTS number
provided by DWC core doesn't work stable and make LTSSM switch between
L0S and Recovery, leading to long exit latency, even fail to link sometimes.
So override it to the max 255 which seems work fine under test for both PHYs
used by Rockchip platforms.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
Changes in v3:
- Add rockchip_pcie_enable_l0s() and called from .init()

Changes in v2:
- Move n_fts to probe function
- rewrite the commit message

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 21dc99c..922aff0 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -182,6 +182,21 @@ static int rockchip_pcie_link_up(struct dw_pcie *pci)
 	return 0;
 }
 
+static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
+{
+	u32 cap, lnkcap;
+
+	/* Enable L0S capability for all SoCs */
+	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	if (cap) {
+		lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+		lnkcap |= PCI_EXP_LNKCAP_ASPM_L0S;
+		dw_pcie_dbi_ro_wr_en(pci);
+		dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+		dw_pcie_dbi_ro_wr_dis(pci);
+	}
+}
+
 static int rockchip_pcie_start_link(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
@@ -231,6 +246,8 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
+	rockchip_pcie_enable_l0s(pci);
+
 	return 0;
 }
 
@@ -271,6 +288,8 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
+	rockchip_pcie_enable_l0s(pci);
+
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
 };
@@ -598,6 +617,9 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 	rockchip->pci.dev = dev;
 	rockchip->pci.ops = &dw_pcie_ops;
 	rockchip->data = data;
+	/* Default fts number(210) is broken, override it to 255 */
+	rockchip->pci.n_fts[0] = 255; /* Gen1 */
+	rockchip->pci.n_fts[1] = 255; /* Gen2+ */
 
 	ret = rockchip_pcie_resource_get(pdev, rockchip);
 	if (ret)
-- 
2.7.4


