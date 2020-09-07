Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569525F936
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgIGLUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 07:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728714AbgIGLUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FAF2176B;
        Mon,  7 Sep 2020 11:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599477064;
        bh=Sp+B9glHEiQL9X5ESJUoG443QwUdRzr0XJbD8+1OOWI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=wH7FszL4wDQpZXuWAP4ZftBal/8epDpNckFZFwQjEGu7A2aLrC7ykI1tEixDrrMz2
         R+mNr3RQpNrFFoIATWWqFPkOrCFwz/PlQZOy7y+smPo0v+Bv6uoDRxb0BbpRQNd0/Y
         cWGnGQFF5KoRuEZ001UFvQ7+O5eH3PsA4KWsUNOk=
Received: by pali.im (Postfix)
        id B15D5814; Mon,  7 Sep 2020 13:11:02 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v3 4/5] PCI: aardvark: Implement driver 'remove' function and allow to build it as module
Date:   Mon,  7 Sep 2020 13:10:37 +0200
Message-Id: <20200907111038.5811-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907111038.5811-1-pali@kernel.org>
References: <20200907111038.5811-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Providing driver's 'remove' function allows kernel to bind and unbind devices
from aardvark driver. It also allows to build aardvark driver as a module.

Compiling aardvark as a module simplifies development and debugging of
this driver as it can be reloaded at runtime without the need to reboot
to new kernel.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pci-aardvark.c | 27 ++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index f18c3725ef80..a7aa22512a92 100644
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
index 2e2e2a2ff51d..b16822e344ab 100644
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
@@ -1121,6 +1122,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
 
 	pcie = pci_host_bridge_priv(bridge);
 	pcie->pdev = pdev;
+	platform_set_drvdata(pdev, pcie);
 
 	pcie->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pcie->base))
@@ -1198,18 +1200,37 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int advk_pcie_remove(struct platform_device *pdev)
+{
+	struct advk_pcie *pcie = platform_get_drvdata(pdev);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+
+	pci_lock_rescan_remove();
+	pci_stop_root_bus(bridge->bus);
+	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
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
2.20.1

