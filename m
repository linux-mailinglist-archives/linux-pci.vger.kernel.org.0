Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950AD3957AE
	for <lists+linux-pci@lfdr.de>; Mon, 31 May 2021 10:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhEaJBf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 May 2021 05:01:35 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54289 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229646AbhEaJBc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 May 2021 05:01:32 -0400
Received: from [77.244.183.192] (port=63376 helo=melee.fritz.box)
        by hostingweb31.netsons.net with esmtpa (Exim 4.94.2)
        (envelope-from <luca@lucaceresoli.net>)
        id 1lndm3-0005h2-Sa; Mon, 31 May 2021 10:59:51 +0200
From:   Luca Ceresoli <luca@lucaceresoli.net>
To:     linux-pci@vger.kernel.org
Cc:     Luca Ceresoli <luca@lucaceresoli.net>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v2 2/4] PCI: dra7xx: Make it a kernel module
Date:   Mon, 31 May 2021 10:59:32 +0200
Message-Id: <20210531085934.2662457-3-luca@lucaceresoli.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531085934.2662457-1-luca@lucaceresoli.net>
References: <20210531085934.2662457-1-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable building the driver as a loadable kernel module.

Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>

---

Changes v1 -> v2:
 - Update commit subject (Bjorn)
 - Update commit message body (Rob)
 - Add MODULE_DEVICE_TABLE() for autoloading (Rob)
---
 drivers/pci/controller/dwc/Kconfig      | 6 +++---
 drivers/pci/controller/dwc/pci-dra7xx.c | 8 +++++++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 423d35872ce4..775ad590966e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -17,10 +17,10 @@ config PCIE_DW_EP
 	select PCIE_DW
 
 config PCI_DRA7XX
-	bool
+	tristate
 
 config PCI_DRA7XX_HOST
-	bool "TI DRA7xx PCIe controller Host Mode"
+	tristate "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on OF && HAS_IOMEM && TI_PIPE3
@@ -36,7 +36,7 @@ config PCI_DRA7XX_HOST
 	  This uses the DesignWare core.
 
 config PCI_DRA7XX_EP
-	bool "TI DRA7xx PCIe controller Endpoint Mode"
+	tristate "TI DRA7xx PCIe controller Endpoint Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	depends on OF && HAS_IOMEM && TI_PIPE3
diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 6457695df00c..9fcadd7dd943 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -15,6 +15,7 @@
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
@@ -611,6 +612,7 @@ static const struct of_device_id of_dra7xx_pcie_match[] = {
 	},
 	{},
 };
+MODULE_DEVICE_TABLE(of, of_dra7xx_pcie_match);
 
 /*
  * dra7xx_pcie_unaligned_memaccess: workaround for AM572x/AM571x Errata i870
@@ -949,4 +951,8 @@ static struct platform_driver dra7xx_pcie_driver = {
 	},
 	.shutdown = dra7xx_pcie_shutdown,
 };
-builtin_platform_driver(dra7xx_pcie_driver);
+module_platform_driver(dra7xx_pcie_driver);
+
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
+MODULE_DESCRIPTION("PCIe controller driver for TI DRA7xx SoCs");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

