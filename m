Return-Path: <linux-pci+bounces-24646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA95A6EDA4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA77C3AFC40
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D7E2561BF;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTZpXHQW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F61255E3D;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898396; cv=none; b=Jyiiz7h3g1aGwLlbuW3KAZTjf7OD3Vp4W8iMl0ZjZr9Y8/0uznz85i1e6CMpmR3NZhiZ6FT2zDa7cDuHMqPO1ijO4pdlGG+QHFZ+TZUyLGH88uRM5E2jayAdMjzqgjuI1CpSC9PlbgWCBxEehEbtQgonyihdVySGhUxOJNfCLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898396; c=relaxed/simple;
	bh=AUDVcWx/fSZsojOnLSFNfxIu2BR40276Vy/2x9iqJro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hTkfk5JJwg8Ky9/IeBTmg8Y2e5L5ilk4v95tABcWGhFdWw0QohL/ZNgs24ltP0iez1mK+98lEOJ8uWkE5GO2kK72Q6fB/DpVw3OLh+uAbE1fCHsZ0FOH2+Qnp/WLbq5JME2u7zown8tSkzaBvFHL/XW6S4gDIFGJYBhCqy+nXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTZpXHQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116E8C4AF0D;
	Tue, 25 Mar 2025 10:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742898396;
	bh=AUDVcWx/fSZsojOnLSFNfxIu2BR40276Vy/2x9iqJro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lTZpXHQWWR6Jj0HkjogvVaGMumYVPEANoMQJ8rDaw29OxYbHoz2LTSHF7AXPrSPIN
	 zOxfbyyCeASl5gDeXVq2Hs2GfgkOZDnK4SwhAe5emW6FBJMEaPJ7J9+qteEEUpIzb3
	 whteSInwuy8f/PHOMMl7CoxRt808xxqotyrOdKDIU3ydKfuSnSQBleOyyOo93437F3
	 zbREmulCyzdK733RMq4hi3UdCehxN9b1+wjR0gnYyd3d6hezh07170Z9hKlx1k9Bax
	 C7LPBsE5jDAQv6dwKBvhR8i/ZQY9A2zd667d6Lb2ri4jsnEArQ7VsNo+HEwIAlT49X
	 Udu0aR+nypj0A==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tx1UQ-00GsRS-8Q;
	Tue, 25 Mar 2025 10:26:34 +0000
From: Marc Zyngier <maz@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: [PATCH v2 09/13] PCI: apple: Move port PHY registers to their own reg items
Date: Tue, 25 Mar 2025 10:26:06 +0000
Message-Id: <20250325102610.2073863-10-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

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
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 55 +++++++++++++++++++----------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 23d9f62bd2ad4..94c49611b74df 100644
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
@@ -146,6 +150,7 @@ struct apple_pcie_port {
 	struct apple_pcie	*pcie;
 	struct device_node	*np;
 	void __iomem		*base;
+	void __iomem		*phy;
 	struct irq_domain	*domain;
 	struct list_head	entry;
 	unsigned long		*sid_map;
@@ -476,26 +481,26 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
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
@@ -515,6 +520,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	struct platform_device *platform = to_platform_device(pcie->dev);
 	struct apple_pcie_port *port;
 	struct gpio_desc *reset;
+	struct resource *res;
+	char name[16];
 	u32 stat, idx;
 	int ret, i;
 
@@ -542,10 +549,22 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 
 	raw_spin_lock_init(&port->lock);
 
-	port->base = devm_platform_ioremap_resource(platform, port->idx + 2);
+	snprintf(name, sizeof(name), "port%d", port->idx);
+	res = platform_get_resource_byname(platform, IORESOURCE_MEM, name);
+	if (!res)
+		res = platform_get_resource(platform, IORESOURCE_MEM, port->idx + 2);
+
+	port->base = devm_ioremap_resource(&platform->dev, res);
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
2.39.2


