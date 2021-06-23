Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323883B1BDC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 16:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhFWODS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 10:03:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:15727 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230243AbhFWODR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 10:03:17 -0400
IronPort-SDR: H2M+72MxRinRq40EI8h9f4pnlftS70aRVI5Iz+1yNWKxk/pE8mrnF5qh36YpDypFrh/mnUBK5y
 Y1gnBzUp4zqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="271110849"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="271110849"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 07:00:44 -0700
IronPort-SDR: 6xwqlUFRbbHU2jQZMKJJKgO2UjcIHWZyp1zUtBrt+OaZGcn16NhDm46V8gYSdOvEmso1D18SeL
 NUmkWBkFJI1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="406317296"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2021 07:00:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4FA2F103; Wed, 23 Jun 2021 17:01:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] PCI: dwc: Clean up Kconfig dependencies (PCIE_DW_HOST)
Date:   Wed, 23 Jun 2021 17:01:02 +0300
Message-Id: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

First of all, the "depends on" is no-op in the selectable options.
Second, no need to repeat menu dependencies (PCI).

Clean up the users of PCIE_DW_HOST and introduce idiom

	depends on PCI_MSI_IRQ_DOMAIN
	select PCIE_DW_HOST

for all of them.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/dwc/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 423d35872ce4..9bfd41eadd5e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -8,7 +8,6 @@ config PCIE_DW
 
 config PCIE_DW_HOST
 	bool
-	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW
 
 config PCIE_DW_EP
@@ -22,8 +21,8 @@ config PCI_DRA7XX
 config PCI_DRA7XX_HOST
 	bool "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on PCI_MSI_IRQ_DOMAIN
 	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
 	default y if SOC_DRA7XX
@@ -55,7 +54,7 @@ config PCIE_DW_PLAT
 
 config PCIE_DW_PLAT_HOST
 	bool "Platform bus based DesignWare PCIe Controller - Host mode"
-	depends on PCI && PCI_MSI_IRQ_DOMAIN
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCIE_DW_PLAT
 	help
@@ -138,8 +137,8 @@ config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller - Host mode"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
-	select MFD_SYSCON
 	select PCIE_DW_HOST
+	select MFD_SYSCON
 	help
 	  Say Y here if you want to enable PCIe controller support on Layerscape
 	  SoCs to work in Host mode.
@@ -244,8 +243,8 @@ config PCIE_HISI_STB
 
 config PCI_MESON
 	tristate "MESON PCIe controller"
-	depends on PCI_MSI_IRQ_DOMAIN
 	default m if ARCH_MESON
+	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCI controller support on Amlogic
-- 
2.30.2

