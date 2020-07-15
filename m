Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43E220F23
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgGOO0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 10:26:02 -0400
Received: from mail.nic.cz ([217.31.204.67]:34916 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728142AbgGOO0A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 10:26:00 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 9B2D6140A60;
        Wed, 15 Jul 2020 16:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594823158; bh=HGzVBMJNvnfwKhKQhtGT6vLn/Of8aFHOs4tiRb2T8p4=;
        h=From:To:Date;
        b=rWrgS2NVc+Tk0wMGetcQrSYqhVs0AvL4XWhfOb0Mzz/jUHuByiFGrmmtelaLpLaJ0
         3Y57YyImilrUDUUf8P1ceKFqNLT910MKmaMqVBvT/4Qn22v9O5oztY09A4pg1nxUUE
         rP5naHcy2SjuQ0gmxy9CqeMxftWuNYMv+yJ2qNBQ=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 4/5] PCI: aardvark: Implement driver 'remove' function and allow to build it as module
Date:   Wed, 15 Jul 2020 16:25:56 +0200
Message-Id: <20200715142557.17115-5-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715142557.17115-1-marek.behun@nic.cz>
References: <20200715142557.17115-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Providing driver's 'remove' function allows kernel to bind and unbind devices
from aardvark driver. It also allows to build aardvark driver as a module.

Compiling aardvark as a module simplifies development and debugging of
this driver as it can be reloaded at runtime without the need to reboot
to new kernel.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pci-aardvark.c | 25 ++++++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index adddf21fa381..f9da5ff2c517 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -12,7 +12,7 @@ config PCI_MVEBU
 	select PCI_BRIDGE_EMUL
 
 config PCI_AARDVARK
-	bool "Aardvark PCIe controller"
+	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index d5f58684d962..0a5aa6d77f5d 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -14,6 +14,7 @@
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/phy/phy.h>
@@ -1114,6 +1115,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
+	platform_set_drvdata(pdev, pcie);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pcie->base = devm_ioremap_resource(dev, res);
@@ -1204,18 +1206,35 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int advk_pcie_remove(struct platform_device *pdev)
+{
+	struct advk_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+
+	advk_pcie_remove_msi_irq_domain(pcie);
+	advk_pcie_remove_irq_domain(pcie);
+
+	return 0;
+}
+
 static const struct of_device_id advk_pcie_of_match_table[] = {
 	{ .compatible = "marvell,armada-3700-pcie", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, advk_pcie_of_match_table);
 
 static struct platform_driver advk_pcie_driver = {
 	.driver = {
 		.name = "advk-pcie",
 		.of_match_table = advk_pcie_of_match_table,
-		/* Driver unloading/unbinding currently not supported */
-		.suppress_bind_attrs = true,
 	},
 	.probe = advk_pcie_probe,
+	.remove = advk_pcie_remove,
 };
-builtin_platform_driver(advk_pcie_driver);
+module_platform_driver(advk_pcie_driver);
+
+MODULE_DESCRIPTION("Aardvark PCIe controller");
+MODULE_LICENSE("GPL v2");
-- 
2.26.2

