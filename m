Return-Path: <linux-pci+bounces-17420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8710F9DAA29
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 15:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B1FB225C9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D3F1DFD1;
	Wed, 27 Nov 2024 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koXTkGJx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067CB652
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 14:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719048; cv=none; b=MDG21AicQAAPcl5nLUPlR3NUex7WZ8amgwRtyLiAKOgkue/m75LSTUF6JAohVNtnMjW+VE6b4pZ96gGqHx4lDNdfBKTRl8uBQzr9Fy4rqxCAcbdceQzvFgin0OjI9YTBYE4ZAXallKPfid5V4OSPGkn+hOrZHXe5l/b003ZFMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719048; c=relaxed/simple;
	bh=vMGke052xOGWISHZqol1znn3ywuvASsby7izzn1gJj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ew0Vk5rjZCthQStl2GJHc/qW/FcnC0FRatlHQMRG1WZXKIVwbXazDoxMDsaJDDH9k5mF2ed3EiM7McnVqt17o00qx4vPzrKi17/w5lhR9pKHMylydbslJIKiLYoNIg6rRdJCLykeXeXquFSVpUBpuDzhyDzjE9XPLtSRhae2bX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koXTkGJx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCE5C4CECC;
	Wed, 27 Nov 2024 14:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732719047;
	bh=vMGke052xOGWISHZqol1znn3ywuvASsby7izzn1gJj4=;
	h=From:To:Cc:Subject:Date:From;
	b=koXTkGJxo3isEtRCFjiNXReam61Dfgp4KJGbAV4Knp3yf91fFXntIdFlbR1caP5Rx
	 z1lvZUdleK4nnMm/Y2zdpnL41Rc2KgqHHS1Ry+ixvdJjuFpPXZIdiRbNHxc1kWPdPE
	 uVOVpJHaeBiPfq/chohoktmq2ZVahWAKmhoI44080ZCOR5munZh5/YOycccAyXGNgQ
	 yPjnmTu/W76z7wNY20DoEFFEiz0ZMY3Qz2bSsmTOOR5mRlqhAUIeBwr0OM8u48/V3G
	 GmBn92n92XcruqXX+DdYznE1w79jtKATbOB6QsDkzN3K0KlBzy84LKzIZ8apmJD/W6
	 IsR03drAzZARA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: dw-rockchip: Enumerate endpoints based on dll_link_up irq in the combined sys irq
Date: Wed, 27 Nov 2024 15:50:42 +0100
Message-ID: <20241127145041.3531400-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4690; i=cassel@kernel.org; h=from:subject; bh=vMGke052xOGWISHZqol1znn3ywuvASsby7izzn1gJj4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdDQ92/Tihn5LVvuBOXsO9P3vXHsueIFTyNtrReKcvl 04wO6t9RykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACaSdpKR4VpYtjB/4yNj6Zkn U1oCxbY3zFOuW5Ys6eH00mU/h3jdCkaGj7x5bx/GH5Y+dbB/c7W22IXlOiyZWT27HbhrI6a8Fbr GCQA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Most boards using the pcie-dw-rockchip PCIe controller lack standard
hotplug support.

Thus, when an endpoint is attached to the SoC, users have to rescan the bus
manually to enumerate the device. This can be avoided by using the
'dll_link_up' interrupt in the combined system interrupt 'sys'.

Once the 'dll_link_up' irq is received, the bus underneath the host bridge
is scanned to enumerate PCIe endpoint devices.

This commit implements the same functionality that was implemented in the
DWC based pcie-qcom driver in commit 4581403f6792 ("PCI: qcom: Enumerate
endpoints based on Link up event in 'global_irq' interrupt").

The Root Complex specific device tree binding for pcie-dw-rockchip already
has the 'sys' interrupt marked as required, so there is no need to update
the device tree binding. This also means that we can request the 'sys' IRQ
unconditionally.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 62 +++++++++++++++++--
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 1170e1107508..ce4b511bff9b 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -389,6 +389,34 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.stop_link = rockchip_pcie_stop_link,
 };
 
+static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
+{
+	struct rockchip_pcie *rockchip = arg;
+	struct dw_pcie *pci = &rockchip->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct device *dev = pci->dev;
+	u32 reg, val;
+
+	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
+	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
+
+	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+
+	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
+		val = rockchip_pcie_get_ltssm(rockchip);
+		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
+			dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
+			/* Rescan the bus to enumerate endpoint devices */
+			pci_lock_rescan_remove();
+			pci_rescan_bus(pp->bridge->bus);
+			pci_unlock_rescan_remove();
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 {
 	struct rockchip_pcie *rockchip = arg;
@@ -418,14 +446,31 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
+static int rockchip_pcie_configure_rc(struct platform_device *pdev,
+				      struct rockchip_pcie *rockchip)
 {
+	struct device *dev = &pdev->dev;
 	struct dw_pcie_rp *pp;
+	int irq, ret;
 	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
 		return -ENODEV;
 
+	irq = platform_get_irq_byname(pdev, "sys");
+	if (irq < 0) {
+		dev_err(dev, "missing sys IRQ resource\n");
+		return irq;
+	}
+
+	ret = devm_request_threaded_irq(dev, irq, NULL,
+					rockchip_pcie_rc_sys_irq_thread,
+					IRQF_ONESHOT, "pcie-sys-rc", rockchip);
+	if (ret) {
+		dev_err(dev, "failed to request PCIe sys IRQ\n");
+		return ret;
+	}
+
 	/* LTSSM enable control mode */
 	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
@@ -436,7 +481,16 @@ static int rockchip_pcie_configure_rc(struct rockchip_pcie *rockchip)
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
 
-	return dw_pcie_host_init(pp);
+	ret = dw_pcie_host_init(pp);
+	if (ret) {
+		dev_err(dev, "failed to initialize host\n");
+		return ret;
+	}
+
+	/* unmask DLL up/down indicator */
+	rockchip_pcie_writel_apb(rockchip, 0x20000, PCIE_CLIENT_INTR_MASK_MISC);
+
+	return ret;
 }
 
 static int rockchip_pcie_configure_ep(struct platform_device *pdev,
@@ -457,7 +511,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 
 	ret = devm_request_threaded_irq(dev, irq, NULL,
 					rockchip_pcie_ep_sys_irq_thread,
-					IRQF_ONESHOT, "pcie-sys", rockchip);
+					IRQF_ONESHOT, "pcie-sys-ep", rockchip);
 	if (ret) {
 		dev_err(dev, "failed to request PCIe sys IRQ\n");
 		return ret;
@@ -553,7 +607,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
 
 	switch (data->mode) {
 	case DW_PCIE_RC_TYPE:
-		ret = rockchip_pcie_configure_rc(rockchip);
+		ret = rockchip_pcie_configure_rc(pdev, rockchip);
 		if (ret)
 			goto deinit_clk;
 		break;
-- 
2.47.0


