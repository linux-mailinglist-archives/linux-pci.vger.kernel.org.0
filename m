Return-Path: <linux-pci+bounces-26093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5D4A91CAE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 14:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454A9444103
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC21247298;
	Thu, 17 Apr 2025 12:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="StPjh+hX"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6783424BBE0;
	Thu, 17 Apr 2025 12:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893899; cv=none; b=lT/UfYdUDQ+rAeIBkEhRcYB6dsHSdDNPSRQSQcWqG/dy6i7dK7OFPe1Zt27ZEGDQJPCa1SB/nUa4fLYlnXCE4DeKfUMEKtW4uUyHnQdmY48AZr+zmXB5DbKJ+I1QbLJfTpOyP0BxVZwCSS9ezlkQYBPQTc0lRcqP3SfWEChSZw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893899; c=relaxed/simple;
	bh=9Nbb4YPHosWOsW0a1OW2TNBQJ63eKsRN1ZLANFh/wqI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9rjMbFSR384xIY7R/sava7qj1VAdfuh8Do+EYQN3NPvq7rTaGr2k+v7xi/5bWtwv0GavhQvfV9ULHBnb7qFx2KI8a7hGOizaQalWhy+JrwfNAfo+QtITQZpkN0fSkexNtq2oO9hl0bVeWNlMlFrwXDfHxqIsx8Ylh7wD1/QQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=StPjh+hX; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCiYrE693912
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Apr 2025 07:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744893874;
	bh=6QwmiXYtdXkY7XEVleeAYjYv8cWgU96/EzVkuZEZzKU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=StPjh+hXsJ9g5LMJn+a2ndKbUGMRM1tB+6f6lKRCofHWgoQlkE597gNltQzR2ZjOF
	 K/7tv1xqMleQXtSd7cY0JlLmMSCFiaeQanmByITxUTRO50ZxoOyWuJrGWwJ4U1mjsQ
	 kLu6Qr0h1/LSJQBqA02naCXX8RU6r+BOQrAkKIfw=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53HCiYNG065173
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 17 Apr 2025 07:44:34 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Apr 2025 07:44:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Apr 2025 07:44:34 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53HCi9XF048918;
	Thu, 17 Apr 2025 07:44:29 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <vigneshr@ti.com>, <kishon@kernel.org>,
        <18255117159@163.com>, <cassel@kernel.org>,
        <wojciech.jasko-EXT@continental-corporation.com>,
        <thomas.richard@bootlin.com>, <bwawrzyn@cisco.com>
CC: <linux-pci@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 4/4] PCI: j721e: Add support to build as a loadable module
Date: Thu, 17 Apr 2025 18:14:08 +0530
Message-ID: <20250417124408.2752248-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417124408.2752248-1-s-vadapalli@ti.com>
References: <20250417124408.2752248-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The 'pci-j721e.c' driver is the application/glue/wrapper driver for the
Cadence PCIe Controllers on TI SoCs. Implement support for building it as a
loadable module.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3 patch is at:
https://lore.kernel.org/r/20250410104426.463453-5-s-vadapalli@ti.com/
Changes since v3:
- In the fourth patch of this series, the polarity for PERST# assert in
  the driver's .remove callback has been fixed based on Mani's feedback at
  https://lore.kernel.org/r/6bi5gul3sqvycmkf6cwokkvownjffaf2tkonjlefo2d7cautwx@uhfexzgz3okp/

Regards,
Siddharth.

 drivers/pci/controller/cadence/Kconfig     |  6 ++---
 drivers/pci/controller/cadence/pci-j721e.c | 31 +++++++++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 82b58096eea0..72d7d264d6c3 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -43,10 +43,10 @@ config PCIE_CADENCE_PLAT_EP
 	  different vendors SoCs.
 
 config PCI_J721E
-	bool
+	tristate
 
 config PCI_J721E_HOST
-	bool "TI J721E PCIe controller (host mode)"
+	tristate "TI J721E PCIe controller (host mode)"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
 	select PCIE_CADENCE_HOST
@@ -57,7 +57,7 @@ config PCI_J721E_HOST
 	  core.
 
 config PCI_J721E_EP
-	bool "TI J721E PCIe controller (endpoint mode)"
+	tristate "TI J721E PCIe controller (endpoint mode)"
 	depends on ARCH_K3 || COMPILE_TEST
 	depends on OF
 	depends on PCI_ENDPOINT
diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index ef1cfdae33bb..8a73a4d382d1 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -27,6 +28,7 @@
 #define cdns_pcie_to_rc(p) container_of(p, struct cdns_pcie_rc, pcie)
 
 #define ENABLE_REG_SYS_2	0x108
+#define ENABLE_CLR_REG_SYS_2	0x308
 #define STATUS_REG_SYS_2	0x508
 #define STATUS_CLR_REG_SYS_2	0x708
 #define LINK_DOWN		BIT(1)
@@ -116,6 +118,15 @@ static irqreturn_t j721e_pcie_link_irq_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+static void j721e_pcie_disable_link_irq(struct j721e_pcie *pcie)
+{
+	u32 reg;
+
+	reg = j721e_pcie_intd_readl(pcie, ENABLE_CLR_REG_SYS_2);
+	reg |= pcie->linkdown_irq_regfield;
+	j721e_pcie_intd_writel(pcie, ENABLE_CLR_REG_SYS_2, reg);
+}
+
 static void j721e_pcie_config_link_irq(struct j721e_pcie *pcie)
 {
 	u32 reg;
@@ -633,9 +644,23 @@ static void j721e_pcie_remove(struct platform_device *pdev)
 	struct j721e_pcie *pcie = platform_get_drvdata(pdev);
 	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
 	struct device *dev = &pdev->dev;
+	struct cdns_pcie_ep *ep;
+	struct cdns_pcie_rc *rc;
+
+	if (pcie->mode == PCI_MODE_RC) {
+		rc = container_of(cdns_pcie, struct cdns_pcie_rc, pcie);
+		cdns_pcie_host_disable(rc);
+	} else {
+		ep = container_of(cdns_pcie, struct cdns_pcie_ep, pcie);
+		cdns_pcie_ep_disable(ep);
+	}
+
+	if (pcie->reset_gpio)
+		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
 
 	clk_disable_unprepare(pcie->refclk);
 	cdns_pcie_disable_phy(cdns_pcie);
+	j721e_pcie_disable_link_irq(pcie);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 }
@@ -730,4 +755,8 @@ static struct platform_driver j721e_pcie_driver = {
 		.pm	= pm_sleep_ptr(&j721e_pcie_pm_ops),
 	},
 };
-builtin_platform_driver(j721e_pcie_driver);
+module_platform_driver(j721e_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe controller driver for TI's J721E and related SoCs");
+MODULE_AUTHOR("Kishon Vijay Abraham I <kishon@ti.com>");
-- 
2.34.1


