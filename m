Return-Path: <linux-pci+bounces-38859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D816BF51BE
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B652F46510B
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659572868BD;
	Tue, 21 Oct 2025 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="SXFzxmVq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15588.qiye.163.com (mail-m15588.qiye.163.com [101.71.155.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CD728727A
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032962; cv=none; b=CcR84idPNWotqduyJnBq239sm3M18zDO+96HLsXknIdoao22fZ8iGlzzs23uifKGHDRiMan+hP5XVUcCmFROGznlQPhwHTCr4c7PwlVi2onpqQduxyRlqia1hmkPOzqxnLdcVr63uYpORlPGptzSkjfywP5u42oAkqaq+FZH9pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032962; c=relaxed/simple;
	bh=wrETqwA9WJXyBqgDUUXZckYz2XwVEULynqrCAu9bPSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YoqHiQ6n2JeeeSb4m/3j1nkwiPwI/18Xg3ngfJLKQRzRBu5i8o4T8LgLBAxAY7dmaimyVwGUvOqFcjlYnxJbXR9oR48/SETN3VFtpWUFtbuHX/seYKUo7RCaJEeiZvX3hcbbXlAbKy4/9s92cfZK0h3S02IZmz0PSHcXIoC/p18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=SXFzxmVq; arc=none smtp.client-ip=101.71.155.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26a1f52ee;
	Tue, 21 Oct 2025 15:49:14 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Heiko Stuebner <heiko@sntech.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/4] PCI: dw-rockchip: Add L1sub support
Date: Tue, 21 Oct 2025 15:48:26 +0800
Message-Id: <1761032907-154829-4-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
References: <1761032907-154829-1-git-send-email-shawn.lin@rock-chips.com>
X-HM-Tid: 0a9a05be63b709cckunm38953c58648233
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUhPQ1YfSUNNSUtJSEIYQkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=SXFzxmVqMHQUidNCXWI/i5+1KodnEaDH1gECnDh+LeFFQOacF6WgIizYXeCDqEqyNZloTgng23KfPRqWMbWPQ80/WWUG9urQMBgv75tjB0ZFc4DY3/Ru/hHCuVjB9RiSPySETYbV36eZcYveU+sccoASfxkFUVSUJddLDB0d0ok=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8p+P7sgYlFmGDCAraLMtjxy7LG8Kgxou20xrYiE6tSo=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER reg
to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 87dd2dd188b4..8a52ff73ec46 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -62,6 +62,12 @@
 /* Interrupt Mask Register Related to Miscellaneous Operation */
 #define PCIE_CLIENT_INTR_MASK_MISC	0x24
 
+/* Power Management Control Register */
+#define PCIE_CLIENT_POWER		0x2c
+#define  PCIE_CLKREQ_READY		0x10001
+#define  PCIE_CLKREQ_NOT_READY		0x10000
+#define  PCIE_CLKREQ_PULL_DOWN		0x30001000
+
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
 #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
@@ -84,6 +90,7 @@ struct rockchip_pcie {
 	struct gpio_desc *rst_gpio;
 	struct irq_domain *irq_domain;
 	const struct rockchip_pcie_of_data *data;
+	bool supports_clkreq;
 };
 
 struct rockchip_pcie_of_data {
@@ -199,15 +206,21 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
 
-/*
- * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
- * needed to support L1 substates. Currently, not a single rockchip platform
- * performs these steps, so disable L1 substates until there is proper support.
- */
-static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
+static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
 {
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
 	u32 cap, l1subcap;
 
+	/* Enable L1 substates if CLKREQ# is properly connected */
+	if (rockchip->supports_clkreq) {
+		/* Ready to have reference clock removed */
+		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER);
+		return;
+	}
+
+	/* Otherwise, pull down CLKREQ# and disable L1 substates */
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
+				 PCIE_CLIENT_POWER);
 	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
 	if (cap) {
 		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
@@ -282,7 +295,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
-	rockchip_pcie_disable_l1sub(pci);
+	rockchip_pcie_enable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 
 	return 0;
@@ -320,7 +333,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
-	rockchip_pcie_disable_l1sub(pci);
+	rockchip_pcie_enable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
 
@@ -432,6 +445,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
 		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
 				     "failed to get reset lines\n");
 
+	rockchip->supports_clkreq = of_pci_clkreq_present(pdev->dev.of_node);
+
 	return 0;
 }
 
-- 
2.43.0


