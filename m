Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A6B1BF231
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgD3IHM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 04:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726910AbgD3IGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:06:49 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47D72186A;
        Thu, 30 Apr 2020 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234008;
        bh=kwMHrQRCUR0Xnjbf55cLJqGOENIDvbYB5y5ST/WRl6w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cn1xEq0YyV3o+vE/Xuar5Hm8tFbZ5uBt7y+LbKe1qe6T9tn95ytJUULutb3jxGAEm
         CVnVs+VQNxhGdMf8OeDZFH9ozwQoJS6m2W37Ly3vsP+QHNE1joV2Ja5bX8YWuEXjKs
         M7zDutva9fee7ChAlYVG33bcbpSm2be/Nn372Xgs=
Received: by pali.im (Postfix)
        id DF46B7AD; Thu, 30 Apr 2020 10:06:46 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 07/12] PCI: aardvark: Add PHY support
Date:   Thu, 30 Apr 2020 10:06:20 +0200
Message-Id: <20200430080625.26070-8-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
References: <20200430080625.26070-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

With recent proposed changes for U-Boot it is possible that bootloader
won't initialize the PHY for this controller (currently the PHY is
initialized regardless whether PCI is used in U-Boot, but with these
proposed changes the PHY is initialized only on request).

Since the mvebu-a3700-comphy driver by Miquèl Raynal supports enabling
PCIe PHY, and since Linux' functionality should be independent on what
bootloader did, add code for enabling generic PHY if found in device OF
node.

The mvebu-a3700-comphy driver does PHY powering via SMC calls to ARM
Trusted Firmware. The corresponding code in ARM Trusted Firmware skips
one register write which U-Boot does not: step 7 ("Enable TX"), see [1].
Instead ARM Trusted Firmware expects PCIe driver to do this step,
probably because the register is in PCIe controller address space,
instead of PHY address space. We therefore add this step into the
advk_pcie_setup_hw function.

[1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/tree/drivers/marvell/comphy/phy-comphy-3700.c?h=v2.3-rc2#n836

Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Miquèl Raynal <miquel.raynal@bootlin.com>
---
 drivers/pci/controller/pci-aardvark.c | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8332c71d69fa..053ae6c19a3d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -16,6 +16,7 @@
 #include <linux/kernel.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/msi.h>
 #include <linux/of_address.h>
@@ -104,6 +105,8 @@
 #define     PCIE_CORE_CTRL2_STRICT_ORDER_ENABLE	BIT(5)
 #define     PCIE_CORE_CTRL2_OB_WIN_ENABLE	BIT(6)
 #define     PCIE_CORE_CTRL2_MSI_ENABLE		BIT(10)
+#define PCIE_CORE_REF_CLK_REG			(CONTROL_BASE_ADDR + 0x14)
+#define     PCIE_CORE_REF_CLK_TX_ENABLE		BIT(1)
 #define PCIE_MSG_LOG_REG			(CONTROL_BASE_ADDR + 0x30)
 #define PCIE_ISR0_REG				(CONTROL_BASE_ADDR + 0x40)
 #define PCIE_MSG_PM_PME_MASK			BIT(7)
@@ -207,6 +210,7 @@ struct advk_pcie {
 	int link_gen;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
+	struct phy *phy;
 };
 
 static inline void advk_writel(struct advk_pcie *pcie, u32 val, u64 reg)
@@ -358,6 +362,11 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 
 	advk_pcie_issue_perst(pcie);
 
+	/* Enable TX */
+	reg = advk_readl(pcie, PCIE_CORE_REF_CLK_REG);
+	reg |= PCIE_CORE_REF_CLK_TX_ENABLE;
+	advk_writel(pcie, reg, PCIE_CORE_REF_CLK_REG);
+
 	/* Set to Direct mode */
 	reg = advk_readl(pcie, CTRL_CONFIG_REG);
 	reg &= ~(CTRL_MODE_MASK << CTRL_MODE_SHIFT);
@@ -1041,6 +1050,62 @@ static irqreturn_t advk_pcie_irq_handler(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void __maybe_unused advk_pcie_disable_phy(struct advk_pcie *pcie)
+{
+	phy_power_off(pcie->phy);
+	phy_exit(pcie->phy);
+}
+
+static int advk_pcie_enable_phy(struct advk_pcie *pcie)
+{
+	int ret;
+
+	if (!pcie->phy)
+		return 0;
+
+	ret = phy_init(pcie->phy);
+	if (ret)
+		return ret;
+
+	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
+	if (ret) {
+		phy_exit(pcie->phy);
+		return ret;
+	}
+
+	ret = phy_power_on(pcie->phy);
+	if (ret) {
+		phy_exit(pcie->phy);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int advk_pcie_setup_phy(struct advk_pcie *pcie)
+{
+	struct device *dev = &pcie->pdev->dev;
+	struct device_node *node = dev->of_node;
+	int ret = 0;
+
+	pcie->phy = devm_of_phy_get(dev, node, NULL);
+	if (IS_ERR(pcie->phy) && (PTR_ERR(pcie->phy) == -EPROBE_DEFER))
+		return PTR_ERR(pcie->phy);
+
+	/* Old bindings miss the PHY handle */
+	if (IS_ERR(pcie->phy)) {
+		dev_warn(dev, "PHY unavailable (%ld)\n", PTR_ERR(pcie->phy));
+		pcie->phy = NULL;
+		return 0;
+	}
+
+	ret = advk_pcie_enable_phy(pcie);
+	if (ret)
+		dev_err(dev, "Failed to initialize PHY (%d)\n", ret);
+
+	return ret;
+}
+
 static int advk_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1100,6 +1165,10 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	else
 		pcie->link_gen = ret;
 
+	ret = advk_pcie_setup_phy(pcie);
+	if (ret)
+		return ret;
+
 	advk_pcie_setup_hw(pcie);
 
 	advk_sw_pci_bridge_init(pcie);
-- 
2.20.1

