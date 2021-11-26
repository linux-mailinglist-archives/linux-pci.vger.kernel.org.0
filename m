Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4AD45F053
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 16:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377922AbhKZPJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 10:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346753AbhKZPHq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 10:07:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C866C0613B4;
        Fri, 26 Nov 2021 06:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94BACB827EB;
        Fri, 26 Nov 2021 14:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA1EC004E1;
        Fri, 26 Nov 2021 14:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637937832;
        bh=eHdxVaxHiuruMF/9Td8JoiWopFdjBhE0ZD897U8weQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z4wHuKmwrcGSBJwwGzCOqIi/9n7zgCfT0+vucq/Kwv1xcEtrkCshvG+dC+L+9OS6J
         KOA85PW+J0owUGdn7LFHypacJ3SrM8WNBk5WGqG9ZdkUgeE3ZBcHsImgpcKhjYAzAK
         OWGt+LR3HDKKu+uWpjEBCIvslfML7v4flRvP/yy+jJajPkpjYA5Clt5au1gTV1GGCN
         iLU3lS2qPABXmWbkuqaP6OTJaUh5aQWWWHismcJb0KDzCzyhsHL+hjlKRhHZ/JpOoT
         ICxtPjI87aOuXpr0Biw3MrwT6zZo/HLZiiGfIyIDa8Of8zgPBbXae2EQzLlK08ytn3
         DsUJDpVqu8/tA==
Received: by pali.im (Postfix)
        id 8C608EF6; Fri, 26 Nov 2021 15:43:49 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: mvebu: Add support for compiling driver as module
Date:   Fri, 26 Nov 2021 15:43:07 +0100
Message-Id: <20211126144307.7568-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126144307.7568-1-pali@kernel.org>
References: <20211126144307.7568-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now when driver uses devm_pci_remap_iospace() function, it is possible
implement ->remove() callback for unbinding device from driver.

Implement mvebu_pcie_remove() callback with proper cleanup phase, drop
driver's suppress_bind_attrs flag and switch type of CONFIG_PCI_MVEBU
option from bool to tristate.

This allows to compile pci-mvebu.c driver as loadable module pci-mvebu.ko
with ability to unload it.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/controller/Kconfig     |  2 +-
 drivers/pci/controller/pci-mvebu.c | 91 +++++++++++++++++++++++++-----
 2 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 93b141110537..67189bcd5d89 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -4,7 +4,7 @@ menu "PCI controller drivers"
 	depends on PCI
 
 config PCI_MVEBU
-	bool "Marvell EBU PCIe controller"
+	tristate "Marvell EBU PCIe controller"
 	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
 	depends on MVEBU_MBUS
 	depends on ARM
diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index f2180e4630a1..f43492695f94 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -145,22 +146,13 @@ static void mvebu_pcie_set_local_dev_nr(struct mvebu_pcie_port *port, int nr)
 	mvebu_writel(port, stat, PCIE_STAT_OFF);
 }
 
-/*
- * Setup PCIE BARs and Address Decode Wins:
- * BAR[0] -> internal registers (needed for MSI)
- * BAR[1] -> covers all DRAM banks
- * BAR[2] -> Disabled
- * WIN[0-3] -> DRAM bank[0-3]
- */
-static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
+static void mvebu_pcie_disable_wins(struct mvebu_pcie_port *port)
 {
-	const struct mbus_dram_target_info *dram;
-	u32 size;
 	int i;
 
-	dram = mv_mbus_dram_info();
+	mvebu_writel(port, 0, PCIE_BAR_LO_OFF(0));
+	mvebu_writel(port, 0, PCIE_BAR_HI_OFF(0));
 
-	/* First, disable and clear BARs and windows. */
 	for (i = 1; i < 3; i++) {
 		mvebu_writel(port, 0, PCIE_BAR_CTRL_OFF(i));
 		mvebu_writel(port, 0, PCIE_BAR_LO_OFF(i));
@@ -176,6 +168,25 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
 	mvebu_writel(port, 0, PCIE_WIN5_CTRL_OFF);
 	mvebu_writel(port, 0, PCIE_WIN5_BASE_OFF);
 	mvebu_writel(port, 0, PCIE_WIN5_REMAP_OFF);
+}
+
+/*
+ * Setup PCIE BARs and Address Decode Wins:
+ * BAR[0] -> internal registers (needed for MSI)
+ * BAR[1] -> covers all DRAM banks
+ * BAR[2] -> Disabled
+ * WIN[0-3] -> DRAM bank[0-3]
+ */
+static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
+{
+	const struct mbus_dram_target_info *dram;
+	u32 size;
+	int i;
+
+	dram = mv_mbus_dram_info();
+
+	/* First, disable and clear BARs and windows. */
+	mvebu_pcie_disable_wins(port);
 
 	/* Setup windows for DDR banks.  Count total DDR size on the fly. */
 	size = 0;
@@ -1082,6 +1093,52 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
 	return pci_host_probe(bridge);
 }
 
+static int mvebu_pcie_remove(struct platform_device *pdev)
+{
+	struct mvebu_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	u32 cmd;
+	int i;
+
+	/* Remove PCI bus with all devices. */
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
+
+	for (i = 0; i < pcie->nports; i++) {
+		struct mvebu_pcie_port *port = &pcie->ports[i];
+
+		if (!port->base)
+			continue;
+
+		/* Disable Root Bridge I/O space, memory space and bus mastering. */
+		cmd = mvebu_readl(port, PCIE_CMD_OFF);
+		cmd &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
+		mvebu_writel(port, cmd, PCIE_CMD_OFF);
+
+		/* Mask all interrupt sources. */
+		mvebu_writel(port, 0, PCIE_MASK_OFF);
+
+		/* Free config space for emulated root bridge. */
+		pci_bridge_emul_cleanup(&port->bridge);
+
+		/* Disable and clear BARs and windows. */
+		mvebu_pcie_disable_wins(port);
+
+		/* Delete PCIe IO and MEM windows. */
+		if (port->iowin.size)
+			mvebu_pcie_del_windows(port, port->iowin.base, port->iowin.size);
+		if (port->memwin.size)
+			mvebu_pcie_del_windows(port, port->memwin.base, port->memwin.size);
+
+		/* Power down card and disable clocks. Must be the last step. */
+		mvebu_pcie_powerdown(port);
+	}
+
+	return 0;
+}
+
 static const struct of_device_id mvebu_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-xp-pcie", },
 	{ .compatible = "marvell,armada-370-pcie", },
@@ -1098,10 +1155,14 @@ static struct platform_driver mvebu_pcie_driver = {
 	.driver = {
 		.name = "mvebu-pcie",
 		.of_match_table = mvebu_pcie_of_match_table,
-		/* driver unloading/unbinding currently not supported */
-		.suppress_bind_attrs = true,
 		.pm = &mvebu_pcie_pm_ops,
 	},
 	.probe = mvebu_pcie_probe,
+	.remove = mvebu_pcie_remove,
 };
-builtin_platform_driver(mvebu_pcie_driver);
+module_platform_driver(mvebu_pcie_driver);
+
+MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@bootlin.com>");
+MODULE_AUTHOR("Pali Rohár <pali@kernel.org>");
+MODULE_DESCRIPTION("Marvell EBU PCIe controller");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

