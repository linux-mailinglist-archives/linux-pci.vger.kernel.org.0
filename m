Return-Path: <linux-pci+bounces-25624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC6A84128
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 12:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6658C3B534D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1442127E1A1;
	Thu, 10 Apr 2025 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L4BIy32T"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D64256C75;
	Thu, 10 Apr 2025 10:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744281929; cv=none; b=DjnHQFLF/6xy0cZHxuf052XbLgJ9f6Z2+SXcaKeg6KKpQOwXvjcm7YUqetP2HqtXCOPnJpUfVOjuo3rZIe/GMY25A+r3F3nt4rNG5ErFyrgPj6VXBfbTvaoVWjtYRyBTUPGJzegSHm+1YHn9x4V1RVwS9sEn1bRbzlGayYiVMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744281929; c=relaxed/simple;
	bh=UVI0WemhrJIJJAw/K5tiecV3b2m3m1TgcgpdKp/Z4LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSmwpCiAvYAkMudSQQt8wZ/2N4BKUYt+oprF5FTV7y05bTKXTA3ZKpQxJ4/gcneDA2xsHVyaKsYTi7DJ/gXutjNQNYV4jDmRbpyOTf/6ELQoRzsyOi/HEWv03PriF0tNxxZnEqXUquLtdfWbmIZ+6/8bsX1LFdkJLJb3qPXVfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=L4BIy32T; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAiqT71113498
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 05:44:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744281892;
	bh=dqftKNKxx5ydl41p6D6qtfUbybxxG2CAHEr50Cw4Dog=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=L4BIy32TOYbi379cB/6qCdZO65sLIq03yLnQwdfEha+OuBo+Vido5mRgU9DJsk/ST
	 K94TZE0XfaXZJRyovAkEfdOhXcm4rc+8v3LwTFGfSmfELPCwIXcvg/1AHgre0odfWZ
	 wvhxb65RaBggfxBJ4p4b5kaNQMsGQ53+jEpIiDkM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53AAiqoi067445
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Apr 2025 05:44:52 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Apr 2025 05:44:52 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Apr 2025 05:44:52 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.72.113])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53AAiRff029210;
	Thu, 10 Apr 2025 05:44:47 -0500
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
Subject: [PATCH v3 4/4] PCI: j721e: Add support to build as a loadable module
Date: Thu, 10 Apr 2025 16:14:26 +0530
Message-ID: <20250410104426.463453-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250410104426.463453-1-s-vadapalli@ti.com>
References: <20250410104426.463453-1-s-vadapalli@ti.com>
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

v2 of this patch is at:
https://lore.kernel.org/r/20250330083914.529222-5-s-vadapalli@ti.com/
Change since v2:
- Dropped a delay before PERST assertion in the driver's remove callback
  based on Mani's feedback at:
  https://lore.kernel.org/r/zsxnx7biwogov5dw5yiafkgk6tsrtspac75bjbrca5uevweaim@ly67hwfyk7qh/

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
index ef1cfdae33bb..51b09f70000c 100644
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
+		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
 
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


