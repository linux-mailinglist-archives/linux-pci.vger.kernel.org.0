Return-Path: <linux-pci+bounces-43495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C9ACD4CF8
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 07:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51D1A3009830
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 06:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37B71A9F87;
	Mon, 22 Dec 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiKiI1QZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3303277AF;
	Mon, 22 Dec 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766385752; cv=none; b=S4pQWLCEzEJwxSwvulvKQLtexT3dXg6VQdBlZ6NtX6BN1liS9vRDWmH3jQwZrbOYHT8HJA+TzCQ67CcwN8wsS2ekqJHEi4S83k9V5Tzb4SON/QcnvmYZt/QvlF68KJg4x+5+FGcuUgqOjX32Ogc6JMXmTmnDWhk0+WYQp7jeOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766385752; c=relaxed/simple;
	bh=e0/niKpB0Lap+DhZVLSOS8gW0I1Z3rhogP6i1jO9zTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cR9GBWWcidQ+auam7FKkeo7R4VRm3RIpweGey+jcYw8nKQDASNxnYDhkmqIvGrjeYDjyCqgBBqBlFntbM2h88EkJ77xd3P9isahOp43XdZykrrUNKnAT37gyX9kgDb4MSxlJq6aDLvFJkITTZi5kUSJUINU8ew2XNUimafuNfzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiKiI1QZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4245CC4CEF1;
	Mon, 22 Dec 2025 06:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766385752;
	bh=e0/niKpB0Lap+DhZVLSOS8gW0I1Z3rhogP6i1jO9zTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiKiI1QZedlTbBXaF79j9zJC0VpwLwRc60fYkZOew0t058sp5hxbAwWFBMN7P18fJ
	 5UgFA5hVqEzll+yqsmP7o1yUOphIP7fyH3KgpgI59Z0Z4xLyFgtM5J2TBuJ6Osu1TN
	 WxMpjgUYuPt38ulUr7MBhs82+JnrCuMISoE2qV595ks+C1+vOsZyvjsaa8Kg7Nn1gD
	 Iho77d4XX0owKf6Z+CTo8WR8mTuj+MrLW4nseWQp//4gCyqN4fnk1cW6m/NUfDerlt
	 A9VPWordUXl6ZIxjwFQB73sd/HawNekacQFA+mQXm7uM3zAWb1KkM/dk+pf3QaE6IF
	 Xm5eBn07ing4Q==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2 2/6] Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ"
Date: Mon, 22 Dec 2025 07:42:09 +0100
Message-ID: <20251222064207.3246632-10-cassel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251222064207.3246632-8-cassel@kernel.org>
References: <20251222064207.3246632-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6396; i=cassel@kernel.org; h=from:subject; bh=e0/niKpB0Lap+DhZVLSOS8gW0I1Z3rhogP6i1jO9zTU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI9XrgJvNo3WXzeSeaJMZf/XgxjO7/si/D9rbtjHwg8n 1xZxBH8vKOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATuTSZ4X+ileWW5E+93Pm7 131a92jOxoXcs9jnS1UfvHqqfcXihqWiDP9s9pyotTOYLie/Tq3p3/q9a47+kzWf/Xhv9P/FMbZ b09IYAQ==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This reverts commit 0e0b45ab5d770a748487ba0ae8f77d1fb0f0de3e.

While this fake hotplugging was a nice idea, it has shown that this feature
does not handle PCIe switches correctly:
pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46

During the initial scan, PCI core doesn't see the switch and since the Root
Port is not hot plug capable, the secondary bus number gets assigned as the
subordinate bus number. This means, the PCI core assumes that only one bus
will appear behind the Root Port since the Root Port is not hot plug
capable.

This works perfectly fine for PCIe endpoints connected to the Root Port,
since they don't extend the bus. However, if a PCIe switch is connected,
then there is a problem when the downstream busses starts showing up and
the PCI core doesn't extend the subordinate bus number after initial scan
during boot.

The long term plan is to migrate this driver to the pwrctrl framework,
once it adds proper support for powering up and enumerating PCIe switches.

Cc: stable@vger.kernel.org
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Tested-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 59 +------------------
 1 file changed, 3 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index ca808d8f7975..352f513ebf03 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -508,34 +508,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.get_ltssm = rockchip_pcie_get_ltssm,
 };
 
-static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
-{
-	struct rockchip_pcie *rockchip = arg;
-	struct dw_pcie *pci = &rockchip->pci;
-	struct dw_pcie_rp *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	u32 reg;
-
-	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
-	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
-
-	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_reg(rockchip));
-
-	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
-		if (rockchip_pcie_link_up(pci)) {
-			msleep(PCIE_RESET_CONFIG_WAIT_MS);
-			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
-			/* Rescan the bus to enumerate endpoint devices */
-			pci_lock_rescan_remove();
-			pci_rescan_bus(pp->bridge->bus);
-			pci_unlock_rescan_remove();
-		}
-	}
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
@@ -568,29 +540,14 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int rockchip_pcie_configure_rc(struct platform_device *pdev,
-				      struct rockchip_pcie *rockchip)
+static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 {
-	struct device *dev = &pdev->dev;
 	struct dw_pcie_rp *pp;
-	int irq, ret;
 	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
 		return -ENODEV;
 
-	irq = platform_get_irq_byname(pdev, "sys");
-	if (irq < 0)
-		return irq;
-
-	ret = devm_request_threaded_irq(dev, irq, NULL,
-					rockchip_pcie_rc_sys_irq_thread,
-					IRQF_ONESHOT, "pcie-sys-rc", rockchip);
-	if (ret) {
-		dev_err(dev, "failed to request PCIe sys IRQ\n");
-		return ret;
-	}
-
 	/* LTSSM enable control mode */
 	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
@@ -602,17 +559,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
 
-	ret = dw_pcie_host_init(pp);
-	if (ret) {
-		dev_err(dev, "failed to initialize host\n");
-		return ret;
-	}
-
-	/* unmask DLL up/down indicator */
-	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
-
-	return ret;
+	return dw_pcie_host_init(pp);
 }
 
 static int rockchip_pcie_configure_ep(struct platform_device *pdev,
@@ -731,7 +678,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
-		ret = rockchip_pcie_configure_rc(pdev, rockchip);
+		ret = rockchip_pcie_configure_rc(rockchip);
 		if (ret)
 			goto deinit_clk;
 		break;
-- 
2.52.0


