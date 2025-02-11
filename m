Return-Path: <linux-pci+bounces-21216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ECDA3161E
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8097A0766
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC77265CAB;
	Tue, 11 Feb 2025 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="anqR4Pu7"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCF1264FB0
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303697; cv=none; b=A/Q+2L1+rGPAzCEg3oidja671toKi6opCLp85f/qaN4/Vw06izrbOrCuHCkhAKGtFzmYl6xB24AvTevtRAy5z3uqaIGdVUNem0OooYjtmZEZoG/eihG+c3dGDqXYbU4vTw6tEw5j7hA0b5s74R3c3WZ2JJ3D/ksrthlFqx+s+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303697; c=relaxed/simple;
	bh=/4aY8e4/EKwBSViCWWmVA8tLgFhQVwQ316OFmbEHQ60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i5/ApWipkA77LhnB+QamRG0PDAyM6qE2av7J2sjaSVDmmvcS7oDSUH2iyJwi1OemxfKUOQi9TbcAbJ0H4EahswjLokh0vpPQUpShIbUdhM2rmP5VtazET25396/Q1LZuc/IqGcfrenvpJbGj90QYS1ySUvN4fDPmadSK422oFDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=anqR4Pu7; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Hn9eo3mxMwP4PHVPqNLPOJKyU8EeYRHxTKZoXnCY/s=;
	b=anqR4Pu7xBGTHCgc47nmaM24QW1F2Hjf0dSUtRWszaMtJNJyIhDaplvItl2K4CzN2GvsXd
	LfWsV03wWFz39eoJZeJY5kJLyA5Q5wwpbmASPjuu3PxpSjlhUtIZY1MroOa/8Sg969Idxp
	KSWMEAzRM/XKNF9h5xOLRQchUVIpgG0pWyvgfsaJJ7CD0P98idnU7BwEcuILbha0buTl+L
	D//7o736krUM/9b1H7c6Y7ATFUXJmcx321hYvyP1X7x0WFewr3Lo6xYCgNk+z8V4aXKXHs
	maZnjkdl3M6PePzcrBr9W/WzIVOBgQEJICsgUVv6Vorlb8Y4cvSDQmqRTBv9MA==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 14:54:32 -0500
Subject: [PATCH 7/7] PCI: apple: Add T602x PCIe support
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pcie-t6-v1-7-b60e6d2501bb@rosenzweig.io>
References: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
In-Reply-To: <20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Kettenis <kettenis@openbsd.org>, 
 Marc Zyngier <maz@kernel.org>, Stan Skowronek <stan@corellium.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Developer-Signature: v=1; a=openpgp-sha256; l=9798; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=iFWGB/VvFeLzLyS+KG8D2A435AlKV4YFBa+MItwwa6Q=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r22VdvMG95oRYpc0a3Y+hfrFPR4A8pH3KLr
 qRWrDjxCrCJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9gAKCRD+/lBaCvVY
 DZh3D/4l1pDvAfKmIk7/pSKwwZWYyq//39IbbNPtbdA4C9xFF0xX2BemF0eboTU/Oxu0rDo35wJ
 kwewSoizjtiZ05RUcNCrMseffi8gJn2LKfJxWPKasSfILP2WZ8OE16f5J/QUOHNW/HQJ8SCaH7B
 AZblR3lj/vG9Udc33jhKcElKYvDQh2D9E7yM0khFQDoJ6u+ltnslAIqRqwNC67TegydqV6zi0TC
 ET/OPGZ2WafXFsiYEVHZK2xeV71mNdJjetKXXniZcEIZe2aQeot2L466D00RdbLUl5LBUhGuVmF
 4GaCjUJVOpxRZqaLXUJxp++UKghvAh7AL20DG1RC+UsqHXRvi2Rji8JPH2244jYysdzbrshCXc/
 KK/ebqG2Cu3dAFStQTvXEx88z2zhTKn5VNkv8ed2tWj4sA1jgXo9subxoIBx7WqNTe+OrG7DQB1
 ed5DzNfS9cp8xPN1r+qP1M4wbvgJe9Vp+cBgsAa6MTVGLOsSbu7NN2ydnRoKLzzpGDSfoBraV/f
 UhW+55q39Fi+1oxg0jkY2T5DNHnswFE7cPVi4Myf8HjrcJFFZhcxaYK1yRKzc+EEwtCIBgTp2W3
 BcsUbIx8Qsu1SHAY0H90vDN83Aq09Sl5KXKoZeI1sqW2sGkFC7jRVCl0eJ3mgAywvSyvINvHYv6
 eswFtJqRXmShJbA==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Hector Martin <marcan@marcan.st>

This version of the hardware moved around a bunch of registers, so we
drop the old compatible for these and introduce register offset
structures to handle the differences.

Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 125 ++++++++++++++++++++++++++++++------
 1 file changed, 105 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 7f4839fb0a5b15a9ca87337f53c14a1ce08301fc..7c598334427cb56ca066890ac61143ae1d3ed744 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -26,6 +26,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/msi.h>
+#include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/pci-ecam.h>
 
@@ -104,7 +105,7 @@
 #define   PORT_REFCLK_CGDIS		BIT(8)
 #define PORT_PERST			0x00814
 #define   PORT_PERST_OFF		BIT(0)
-#define PORT_RID2SID(i16)		(0x00828 + 4 * (i16))
+#define PORT_RID2SID			0x00828
 #define   PORT_RID2SID_VALID		BIT(31)
 #define   PORT_RID2SID_SID_SHIFT	16
 #define   PORT_RID2SID_BUS_SHIFT	8
@@ -122,7 +123,7 @@
 #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
 #define PORT_PREFMEM_ENABLE		0x00994
 
-#define MAX_RID2SID			64
+#define MAX_RID2SID			512
 
 /*
  * The doorbell address is set to 0xfffff000, which by convention
@@ -133,6 +134,57 @@
  */
 #define DOORBELL_ADDR		CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR
 
+struct reg_info {
+	u32 phy_lane_ctl;
+	u32 port_msiaddr;
+	u32 port_msiaddr_hi;
+	u32 port_refclk;
+	u32 port_perst;
+	u32 port_rid2sid;
+	u32 port_msimap;
+	u32 max_rid2sid;
+	u32 max_msimap;
+};
+
+const struct reg_info t8103_hw = {
+	.phy_lane_ctl = PHY_LANE_CTL,
+	.port_msiaddr = PORT_MSIADDR,
+	.port_msiaddr_hi = 0,
+	.port_refclk = PORT_REFCLK,
+	.port_perst = PORT_PERST,
+	.port_rid2sid = PORT_RID2SID,
+	.port_msimap = 0,
+	.max_rid2sid = 64,
+	.max_msimap = 0,
+};
+
+#define PORT_T602X_MSIADDR		0x016c
+#define PORT_T602X_MSIADDR_HI		0x0170
+#define PORT_T602X_PERST		0x082c
+#define PORT_T602X_RID2SID		0x3000
+#define PORT_T602X_MSIMAP		0x3800
+
+#define PORT_MSIMAP_ENABLE		BIT(31)
+#define PORT_MSIMAP_TARGET		GENMASK(7, 0)
+
+const struct reg_info t602x_hw = {
+	.phy_lane_ctl = 0,
+	.port_msiaddr = PORT_T602X_MSIADDR,
+	.port_msiaddr_hi = PORT_T602X_MSIADDR_HI,
+	.port_refclk = 0,
+	.port_perst = PORT_T602X_PERST,
+	.port_rid2sid = PORT_T602X_RID2SID,
+	.port_msimap = PORT_T602X_MSIMAP,
+	.max_rid2sid = 512, /* 16 on t602x, guess for autodetect on future HW */
+	.max_msimap = 512, /* 96 on t602x, guess for autodetect on future HW */
+};
+
+static const struct of_device_id apple_pcie_of_match_hw[] = {
+	{ .compatible = "apple,t6020-pcie", .data = &t602x_hw },
+	{ .compatible = "apple,pcie", .data = &t8103_hw },
+	{ }
+};
+
 struct apple_pcie {
 	struct mutex		lock;
 	struct device		*dev;
@@ -143,6 +195,7 @@ struct apple_pcie {
 	struct completion	event;
 	struct irq_fwspec	fwspec;
 	u32			nvecs;
+	const struct reg_info	*hw;
 };
 
 struct apple_pcie_port {
@@ -266,14 +319,14 @@ static void apple_port_irq_mask(struct irq_data *data)
 {
 	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
 
-	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKSET);
+	rmw_set(BIT(data->hwirq), port->base + PORT_INTMSK);
 }
 
 static void apple_port_irq_unmask(struct irq_data *data)
 {
 	struct apple_pcie_port *port = irq_data_get_irq_chip_data(data);
 
-	writel_relaxed(BIT(data->hwirq), port->base + PORT_INTMSKCLR);
+	rmw_clear(BIT(data->hwirq), port->base + PORT_INTMSK);
 }
 
 static bool hwirq_is_intx(unsigned int hwirq)
@@ -377,6 +430,7 @@ static void apple_port_irq_handler(struct irq_desc *desc)
 static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 {
 	struct fwnode_handle *fwnode = &port->np->fwnode;
+	struct apple_pcie *pcie = port->pcie;
 	unsigned int irq;
 
 	/* FIXME: consider moving each interrupt under each port */
@@ -392,19 +446,35 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
 		return -ENOMEM;
 
 	/* Disable all interrupts */
-	writel_relaxed(~0, port->base + PORT_INTMSKSET);
+	writel_relaxed(~0, port->base + PORT_INTMSK);
 	writel_relaxed(~0, port->base + PORT_INTSTAT);
+	writel_relaxed(~0, port->base + PORT_LINKCMDSTS);
 
 	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
 
 	/* Configure MSI base address */
 	BUILD_BUG_ON(upper_32_bits(DOORBELL_ADDR));
-	writel_relaxed(lower_32_bits(DOORBELL_ADDR), port->base + PORT_MSIADDR);
+	writel_relaxed(lower_32_bits(DOORBELL_ADDR),
+		       port->base + pcie->hw->port_msiaddr);
+	if (pcie->hw->port_msiaddr_hi)
+		writel_relaxed(0, port->base + pcie->hw->port_msiaddr_hi);
 
 	/* Enable MSIs, shared between all ports */
-	writel_relaxed(0, port->base + PORT_MSIBASE);
-	writel_relaxed((ilog2(port->pcie->nvecs) << PORT_MSICFG_L2MSINUM_SHIFT) |
-		       PORT_MSICFG_EN, port->base + PORT_MSICFG);
+	if (pcie->hw->port_msimap) {
+		int i;
+
+		for (i = 0; i < pcie->nvecs; i++) {
+			writel_relaxed(FIELD_PREP(PORT_MSIMAP_TARGET, i) |
+				       PORT_MSIMAP_ENABLE,
+				       port->base + pcie->hw->port_msimap + 4 * i);
+		}
+
+		writel_relaxed(PORT_MSICFG_EN, port->base + PORT_MSICFG);
+	} else {
+		writel_relaxed(0, port->base + PORT_MSIBASE);
+		writel_relaxed((ilog2(pcie->nvecs) << PORT_MSICFG_L2MSINUM_SHIFT) |
+			PORT_MSICFG_EN, port->base + PORT_MSICFG);
+	}
 
 	return 0;
 }
@@ -472,7 +542,9 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	u32 stat;
 	int res;
 
-	rmw_set(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
+	if (pcie->hw->phy_lane_ctl)
+		rmw_set(PHY_LANE_CTL_CFGACC, port->phy + pcie->hw->phy_lane_ctl);
+
 	rmw_set(PHY_LANE_CFG_REFCLK0REQ, port->phy + PHY_LANE_CFG);
 
 	res = readl_relaxed_poll_timeout(port->phy + PHY_LANE_CFG,
@@ -489,10 +561,13 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	if (res < 0)
 		return res;
 
-	rmw_clear(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
+	if (pcie->hw->phy_lane_ctl)
+		rmw_clear(PHY_LANE_CTL_CFGACC, port->phy + pcie->hw->phy_lane_ctl);
 
 	rmw_set(PHY_LANE_CFG_REFCLKEN, port->phy + PHY_LANE_CFG);
-	rmw_set(PORT_REFCLK_EN, port->base + PORT_REFCLK);
+
+	if (pcie->hw->port_refclk)
+		rmw_set(PORT_REFCLK_EN, port->base + pcie->hw->port_refclk);
 
 	return 0;
 }
@@ -500,9 +575,9 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 static u32 apple_pcie_rid2sid_write(struct apple_pcie_port *port,
 				    int idx, u32 val)
 {
-	writel_relaxed(val, port->base + PORT_RID2SID(idx));
+	writel_relaxed(val, port->base + port->pcie->hw->port_rid2sid + 4 * idx);
 	/* Read back to ensure completion of the write */
-	return readl_relaxed(port->base + PORT_RID2SID(idx));
+	return readl_relaxed(port->base + port->pcie->hw->port_rid2sid + 4 * idx);
 }
 
 static int apple_pcie_setup_port(struct apple_pcie *pcie,
@@ -563,7 +638,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	usleep_range(100, 200);
 
 	/* Deassert PERST# */
-	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
+	rmw_set(PORT_PERST_OFF, port->base + pcie->hw->port_perst);
 	gpiod_set_value_cansleep(reset, 0);
 
 	/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
@@ -576,15 +651,12 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 		return ret;
 	}
 
-	rmw_clear(PORT_REFCLK_CGDIS, port->base + PORT_REFCLK);
-	rmw_clear(PORT_APPCLK_CGDIS, port->base + PORT_APPCLK);
-
 	ret = apple_pcie_port_setup_irq(port);
 	if (ret)
 		return ret;
 
 	/* Reset all RID/SID mappings, and check for RAZ/WI registers */
-	for (i = 0; i < MAX_RID2SID; i++) {
+	for (i = 0; i < pcie->hw->max_rid2sid; i++) {
 		if (apple_pcie_rid2sid_write(port, i, 0xbad1d) != 0xbad1d)
 			break;
 		apple_pcie_rid2sid_write(port, i, 0);
@@ -608,6 +680,12 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	if (!wait_for_completion_timeout(&pcie->event, HZ / 10))
 		dev_warn(pcie->dev, "%pOF link didn't come up\n", np);
 
+	if (pcie->hw->port_refclk)
+		rmw_clear(PORT_REFCLK_CGDIS, port->base + PORT_REFCLK);
+	else
+		rmw_set(PHY_LANE_CFG_REFCLKCGEN, port->phy + PHY_LANE_CFG);
+	rmw_clear(PORT_APPCLK_CGDIS, port->base + PORT_APPCLK);
+
 	return 0;
 }
 
@@ -732,7 +810,7 @@ static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci
 	for_each_set_bit(idx, port->sid_map, port->sid_map_sz) {
 		u32 val;
 
-		val = readl_relaxed(port->base + PORT_RID2SID(idx));
+		val = readl_relaxed(port->base + port->pcie->hw->port_rid2sid + 4 * idx);
 		if ((val & 0xffff) == rid) {
 			apple_pcie_rid2sid_write(port, idx, 0);
 			bitmap_release_region(port->sid_map, idx, 0);
@@ -750,13 +828,19 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	struct platform_device *platform = to_platform_device(dev);
 	struct device_node *of_port;
 	struct apple_pcie *pcie;
+	const struct of_device_id *match;
 	int ret;
 
+	match = of_match_device(apple_pcie_of_match_hw, dev);
+	if (!match)
+		return -ENODEV;
+
 	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
 	if (!pcie)
 		return -ENOMEM;
 
 	pcie->dev = dev;
+	pcie->hw = match->data;
 
 	mutex_init(&pcie->lock);
 
@@ -795,6 +879,7 @@ static const struct pci_ecam_ops apple_pcie_cfg_ecam_ops = {
 };
 
 static const struct of_device_id apple_pcie_of_match[] = {
+	{ .compatible = "apple,t6020-pcie", .data = &apple_pcie_cfg_ecam_ops },
 	{ .compatible = "apple,pcie", .data = &apple_pcie_cfg_ecam_ops },
 	{ }
 };

-- 
2.48.1


