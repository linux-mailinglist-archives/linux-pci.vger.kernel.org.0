Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407FF3ECD14
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhHPDRm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:17:42 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45212 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S232628AbhHPDRm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:17:42 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] PCI: apple: Set up reference clocks when probing
Date:   Sun, 15 Aug 2021 23:16:18 -0400
Message-Id: <20210816031621.240268-4-alyssa@rosenzweig.io>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210816031621.240268-1-alyssa@rosenzweig.io>
References: <20210816031621.240268-1-alyssa@rosenzweig.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Apple's PCIe controller requires clocks to be configured in order to
bring up the hardware. Add the register pokes required to do so. Adapted
from Corellium's driver via Mark Kettenis's U-Boot patches.

Co-developed-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Stan Skowronek <stan@corellium.com>
Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 drivers/pci/controller/pcie-apple.c | 47 +++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a1efcc3373ea..4ab767cf841b 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -126,6 +126,47 @@ static inline void rmwl(u32 clr, u32 set, void __iomem *addr)
 	writel_relaxed((readl_relaxed(addr) & ~clr) | set, addr);
 }
 
+static int apple_pcie_setup_refclk(void __iomem *rc,
+				   void __iomem *port,
+				   unsigned int idx)
+{
+	u32 stat;
+	int res;
+
+	res = readl_relaxed_poll_timeout(rc + CORE_RC_PHYIF_STAT, stat,
+					 stat & CORE_RC_PHYIF_STAT_REFCLK,
+					 100, 50000);
+	if (res < 0)
+		return res;
+
+	rmwl(0, CORE_LANE_CTL_CFGACC, rc + CORE_LANE_CTL(idx));
+	rmwl(0, CORE_LANE_CFG_REFCLK0REQ, rc + CORE_LANE_CFG(idx));
+
+	res = readl_relaxed_poll_timeout(rc + CORE_LANE_CFG(idx), stat,
+					 stat & CORE_LANE_CFG_REFCLK0ACK,
+					 100, 50000);
+	if (res < 0)
+		return res;
+
+	rmwl(0, CORE_LANE_CFG_REFCLK1, rc + CORE_LANE_CFG(idx));
+	res = readl_relaxed_poll_timeout(rc + CORE_LANE_CFG(idx), stat,
+					 stat & CORE_LANE_CFG_REFCLK1,
+					 100, 50000);
+
+	if (res < 0)
+		return res;
+
+	rmwl(CORE_LANE_CTL_CFGACC, 0, rc + CORE_LANE_CTL(idx));
+
+	/* Flush writes before enabling the clocks */
+	dma_wmb();
+
+	rmwl(0, CORE_LANE_CFG_REFCLKEN, rc + CORE_LANE_CFG(idx));
+	rmwl(0, PORT_REFCLK_EN, port + PORT_REFCLK);
+
+	return 0;
+}
+
 static int apple_pcie_setup_port(struct apple_pcie *pcie,
 				 struct gpio_desc *reset,
 				 unsigned int i)
@@ -144,6 +185,12 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	if (readl_relaxed(port + PORT_LINKSTS) & PORT_LINKSTS_UP)
 		return 0;
 
+	rmwl(0, PORT_APPCLK_EN, port + PORT_APPCLK);
+
+	ret = apple_pcie_setup_refclk(pcie->rc, port, i);
+	if (ret < 0)
+		return ret;
+
 	rmwl(0, PORT_PERST_OFF, port + PORT_PERST);
 	gpiod_set_value(reset, 1);
 
-- 
2.30.2

