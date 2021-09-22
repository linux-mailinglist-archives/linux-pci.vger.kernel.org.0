Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58E541521A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 22:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhIVU5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 16:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237910AbhIVU45 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 16:56:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECDEF61214;
        Wed, 22 Sep 2021 20:55:20 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=wait-a-minute.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mT9Gx-00CP8z-B3; Wed, 22 Sep 2021 21:55:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: [PATCH v4 05/10] PCI: apple: Set up reference clocks when probing
Date:   Wed, 22 Sep 2021 21:54:53 +0100
Message-Id: <20210922205458.358517-6-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210922205458.358517-1-maz@kernel.org>
References: <20210922205458.358517-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com, kettenis@openbsd.org, sven@svenpeter.dev, marcan@marcan.st, Robin.Murphy@arm.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Apple's PCIe controller requires clocks to be configured in order to
bring up the hardware. Add the register pokes required to do so.

Adapted from Corellium's driver via Mark Kettenis's U-Boot patches.

Co-developed-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 2479a4168439..2620fd9d0ab1 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -132,6 +132,48 @@ static void rmw_set(u32 set, void __iomem *addr)
 	writel_relaxed(readl_relaxed(addr) | set, addr);
 }
 
+static void rmw_clear(u32 clr, void __iomem *addr)
+{
+	writel_relaxed(readl_relaxed(addr) & ~clr, addr);
+}
+
+static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
+				   struct apple_pcie_port *port)
+{
+	u32 stat;
+	int res;
+
+	res = readl_relaxed_poll_timeout(pcie->base + CORE_RC_PHYIF_STAT, stat,
+					 stat & CORE_RC_PHYIF_STAT_REFCLK,
+					 100, 50000);
+	if (res < 0)
+		return res;
+
+	rmw_set(CORE_LANE_CTL_CFGACC, pcie->base + CORE_LANE_CTL(port->idx));
+	rmw_set(CORE_LANE_CFG_REFCLK0REQ, pcie->base + CORE_LANE_CFG(port->idx));
+
+	res = readl_relaxed_poll_timeout(pcie->base + CORE_LANE_CFG(port->idx),
+					 stat, stat & CORE_LANE_CFG_REFCLK0ACK,
+					 100, 50000);
+	if (res < 0)
+		return res;
+
+	rmw_set(CORE_LANE_CFG_REFCLK1, pcie->base + CORE_LANE_CFG(port->idx));
+	res = readl_relaxed_poll_timeout(pcie->base + CORE_LANE_CFG(port->idx),
+					 stat, stat & CORE_LANE_CFG_REFCLK1,
+					 100, 50000);
+
+	if (res < 0)
+		return res;
+
+	rmw_clear(CORE_LANE_CTL_CFGACC, pcie->base + CORE_LANE_CTL(port->idx));
+
+	rmw_set(CORE_LANE_CFG_REFCLKEN, pcie->base + CORE_LANE_CFG(port->idx));
+	rmw_set(PORT_REFCLK_EN, port->base + PORT_REFCLK);
+
+	return 0;
+}
+
 static int apple_pcie_setup_port(struct apple_pcie *pcie,
 				 struct device_node *np)
 {
@@ -165,6 +207,10 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 
 	rmw_set(PORT_APPCLK_EN, port + PORT_APPCLK);
 
+	ret = apple_pcie_setup_refclk(pcie, port);
+	if (ret < 0)
+		return ret;
+
 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
 	gpiod_set_value(reset, 1);
 
-- 
2.30.2

