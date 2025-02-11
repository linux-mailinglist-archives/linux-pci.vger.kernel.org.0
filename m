Return-Path: <linux-pci+bounces-21213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506EA31614
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 20:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9EE01643EC
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66672641E6;
	Tue, 11 Feb 2025 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="WAV47Fv5"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8B2641C3
	for <linux-pci@vger.kernel.org>; Tue, 11 Feb 2025 19:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303688; cv=none; b=om5PwjYAT63f+OdgjfWxdtrVm778CRxpeU4Qz3ZE64YayIvITvhsqEWWzE09pdTgxFOq4XXPu98meYiv5dUtVD5KETHbwOVWXyqsZaqRRhB2N9lxfs2Rv4fAo3gTMr8pRc0Zqt2F6TtS94KPbZKwiG16W1YjH4SL3K1CLEm4HxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303688; c=relaxed/simple;
	bh=evSzVy4TRIqrGWVSEbIbvZOoeJKoVhbPp7EMTz7edvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XvN6CV3u/F4qSkGstUz+6/Bb0oWMrz7xOWIuSGi0zm9iP7xOzKHhb58ZN7U2c2t0mjkADH86qgEMlAz/IKIW9UK87gVBtMgBkKPFkPcymjGGLbSKU6tuRLttADiwMgrKwvzhJYPwfAQUkB+QsNkvQajdcaEjWY7jL0LaQYO32f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=WAV47Fv5; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739303684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pj4w2leCnY/nj4Xl2+RPpzvbfj+hrlWDBqoX2zhbX4Y=;
	b=WAV47Fv5coixIPh40DlrjI71Eq2UE+VFWRb6xZwNZtFAD1xQYEM1YywP237pxCdsgS93un
	JkOD5klQGvgNks1BaiVC1Jp8vEoHQonyzzb/cOv5ziiw3zuJvfaVu3Y9bpnu/+85zmu8Yo
	A4PxdAgNSTfQurQHGeOGPCMYg9WdZ4nvVLaQHYNk85hW41vlMf7Ok0MaKWMmyfXsfBSd43
	t2iuJAKQp7WUI/D3MTHjzyKrCedBNMGILmWavt96sgWQd1pEWeLFc9Hj7yRWLpndDPwZjQ
	BrZhr7rC87/XYNbFbZrS8NU17dFORc9USZYHKnNJJ+CD4pR1VqGSw4h3I6igTg==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Tue, 11 Feb 2025 14:54:29 -0500
Subject: [PATCH 4/7] PCI: apple: Move port PHY registers to their own reg
 items
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-pcie-t6-v1-4-b60e6d2501bb@rosenzweig.io>
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
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Janne Grunau <j@jannau.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5194; i=alyssa@rosenzweig.io;
 h=from:subject:message-id; bh=c4UQnZ1yNlclQoJA6wxg/GcH8AshzfypyEZtc8NzpfA=;
 b=owEBbQKS/ZANAwAIAf7+UFoK9VgNAcsmYgBnq6r28yiuwKDywRkuV4aqnNe+dXu92ZsWlKTPV
 s6mWRrrVkqJAjMEAAEIAB0WIQRDXuCbsK8A0B2q9jj+/lBaCvVYDQUCZ6uq9gAKCRD+/lBaCvVY
 DVVnEACeJNc9vIWHJBSk0ckG+ZbgcKCacOEMIvWjDMQ6lAQFlSky2E1m1vfg8Zj6rEg0bVuW+Gm
 MTgqZ+D5kXP81x1f1npaL7un3sQFAXo6bk2e/lY9u9bnnkrRZ4wVbReZvDX3TO0wrYSLeBku3fz
 v3vzc5MfRe8kKPOH1Ovhhf/sC6bnPqHoW8CkeaVGNq/+hItn+A5lto1kegEmGnLc4/EInaj3ngE
 HredW4OIJPQh6uobM3fsOIx3IGbZhrCkgZ/tG1LB5tTVfPwLv75WFP0oX4rv6CD9Li152t4uaGt
 A395PMZ/VAPB2bqlX9w2eaPnC/NF05xReZRt0AmqzgtT1LRaH2jmWSGKm/jtxWfvKjHMWmue3rs
 JsDCwPp5x8jLnkpDLfjYMX13xB/Ockv4Gdiq//YTIMssmM1UFgmqqzAfsPcMZUpBTH8dDqIYnoI
 jENd9oafevAryp1zy/vOVoRpotyM1qG+DZs4qVIGqyzbhtbZtHAHN9VMYzs2uzYp3F7csVkbF9h
 HeUklORh5bRQXwoCUW31DbdLqRV2nWYruQcK75gjPprDElzbfoIJLW1ha/dYs4btKRpU7+V72iP
 vOdNLksJxugD40vStmwGFF8IBMxleIPnFqwwo4+F/Egb4XNlEgVNhFqgvuwPMN/+gN/KMBODfDM
 OgnIfSHt+eKc4LA==
X-Developer-Key: i=alyssa@rosenzweig.io; a=openpgp;
 fpr=435EE09BB0AF00D01DAAF638FEFE505A0AF5580D
X-Migadu-Flow: FLOW_OUT

From: Hector Martin <marcan@marcan.st>

T602x PCIe cores move these registers around. Instead of hardcoding in
another offset, let's move them into their own reg entries. This matches
what Apple does on macOS device trees too.

Maintains backwards compatibility with old DTs by using the old offsets.

Note that we open code devm_platform_ioremap_resource_byname() to avoid
error messages on older platforms with missing resources in the pcie
node. ("pcie-apple 590000000.pcie: invalid resource (null)" on probe)

Co-developed-by: Janne Grunau <j@jannau.net>
Signed-off-by: Janne Grunau <j@jannau.net>
Signed-off-by: Hector Martin <marcan@marcan.st>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 55 +++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 958cf459d4c64dffa1f993e57b7a58cfb2199b8f..806eeb911bbd4f1ae5832b34f775fa18c866670b 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -39,14 +39,18 @@
 #define   CORE_RC_STAT_READY		BIT(0)
 #define CORE_FABRIC_STAT		0x04000
 #define   CORE_FABRIC_STAT_MASK		0x001F001F
-#define CORE_LANE_CFG(port)		(0x84000 + 0x4000 * (port))
-#define   CORE_LANE_CFG_REFCLK0REQ	BIT(0)
-#define   CORE_LANE_CFG_REFCLK1REQ	BIT(1)
-#define   CORE_LANE_CFG_REFCLK0ACK	BIT(2)
-#define   CORE_LANE_CFG_REFCLK1ACK	BIT(3)
-#define   CORE_LANE_CFG_REFCLKEN	(BIT(9) | BIT(10))
-#define CORE_LANE_CTL(port)		(0x84004 + 0x4000 * (port))
-#define   CORE_LANE_CTL_CFGACC		BIT(15)
+
+#define CORE_PHY_DEFAULT_BASE(port)	(0x84000 + 0x4000 * (port))
+
+#define PHY_LANE_CFG			0x00000
+#define   PHY_LANE_CFG_REFCLK0REQ	BIT(0)
+#define   PHY_LANE_CFG_REFCLK1REQ	BIT(1)
+#define   PHY_LANE_CFG_REFCLK0ACK	BIT(2)
+#define   PHY_LANE_CFG_REFCLK1ACK	BIT(3)
+#define   PHY_LANE_CFG_REFCLKEN		(BIT(9) | BIT(10))
+#define   PHY_LANE_CFG_REFCLKCGEN	(BIT(30) | BIT(31))
+#define PHY_LANE_CTL			0x00004
+#define   PHY_LANE_CTL_CFGACC		BIT(15)
 
 #define PORT_LTSSMCTL			0x00080
 #define   PORT_LTSSMCTL_START		BIT(0)
@@ -145,6 +149,7 @@ struct apple_pcie_port {
 	struct apple_pcie	*pcie;
 	struct device_node	*np;
 	void __iomem		*base;
+	void __iomem		*phy;
 	struct irq_domain	*domain;
 	struct list_head	entry;
 	DECLARE_BITMAP(sid_map, MAX_RID2SID);
@@ -473,26 +478,26 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
 	if (res < 0)
 		return res;
 
-	rmw_set(CORE_LANE_CTL_CFGACC, pcie->base + CORE_LANE_CTL(port->idx));
-	rmw_set(CORE_LANE_CFG_REFCLK0REQ, pcie->base + CORE_LANE_CFG(port->idx));
+	rmw_set(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
+	rmw_set(PHY_LANE_CFG_REFCLK0REQ, port->phy + PHY_LANE_CFG);
 
-	res = readl_relaxed_poll_timeout(pcie->base + CORE_LANE_CFG(port->idx),
-					 stat, stat & CORE_LANE_CFG_REFCLK0ACK,
+	res = readl_relaxed_poll_timeout(port->phy + PHY_LANE_CFG,
+					 stat, stat & PHY_LANE_CFG_REFCLK0ACK,
 					 100, 50000);
 	if (res < 0)
 		return res;
 
-	rmw_set(CORE_LANE_CFG_REFCLK1REQ, pcie->base + CORE_LANE_CFG(port->idx));
-	res = readl_relaxed_poll_timeout(pcie->base + CORE_LANE_CFG(port->idx),
-					 stat, stat & CORE_LANE_CFG_REFCLK1ACK,
+	rmw_set(PHY_LANE_CFG_REFCLK1REQ, port->phy + PHY_LANE_CFG);
+	res = readl_relaxed_poll_timeout(port->phy + PHY_LANE_CFG,
+					 stat, stat & PHY_LANE_CFG_REFCLK1ACK,
 					 100, 50000);
 
 	if (res < 0)
 		return res;
 
-	rmw_clear(CORE_LANE_CTL_CFGACC, pcie->base + CORE_LANE_CTL(port->idx));
+	rmw_clear(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
 
-	rmw_set(CORE_LANE_CFG_REFCLKEN, pcie->base + CORE_LANE_CFG(port->idx));
+	rmw_set(PHY_LANE_CFG_REFCLKEN, port->phy + PHY_LANE_CFG);
 	rmw_set(PORT_REFCLK_EN, port->base + PORT_REFCLK);
 
 	return 0;
@@ -512,8 +517,10 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	struct platform_device *platform = to_platform_device(pcie->dev);
 	struct apple_pcie_port *port;
 	struct gpio_desc *reset;
+	struct resource *res;
 	u32 stat, idx;
 	int ret, i;
+	char name[16];
 
 	reset = devm_fwnode_gpiod_get(pcie->dev, of_fwnode_handle(np), "reset",
 				      GPIOD_OUT_LOW, "PERST#");
@@ -533,10 +540,22 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	port->pcie = pcie;
 	port->np = np;
 
-	port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
+	snprintf(name, sizeof(name), "port%d", port->idx);
+	res = platform_get_resource_byname(platform, IORESOURCE_MEM, name);
+	if (res)
+		port->base = devm_ioremap_resource(&platform->dev, res);
+	else
+		port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
 	if (IS_ERR(port->base))
 		return PTR_ERR(port->base);
 
+	snprintf(name, sizeof(name), "phy%d", port->idx);
+	res = platform_get_resource_byname(platform, IORESOURCE_MEM, name);
+	if (res)
+		port->phy = devm_ioremap_resource(&platform->dev, res);
+	else
+		port->phy = pcie->base + CORE_PHY_DEFAULT_BASE(port->idx);
+
 	rmw_set(PORT_APPCLK_EN, port->base + PORT_APPCLK);
 
 	/* Assert PERST# before setting up the clock */

-- 
2.48.1


