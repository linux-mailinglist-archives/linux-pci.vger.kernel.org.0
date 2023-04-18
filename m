Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1C6E6B46
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjDRRoB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjDRRn6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:43:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD47AF12;
        Tue, 18 Apr 2023 10:43:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65B3C60A53;
        Tue, 18 Apr 2023 17:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975E6C433EF;
        Tue, 18 Apr 2023 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839834;
        bh=Q16TXJlROwqfBaCXwZNvd7ldzvHDAQ0Wt0AqOFPTsWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IVgo/kKhTDiLxtreZY8GepydatRvirUF4sZhNd/I+oV3cYbG9s05xoKr8xU61c8TW
         3xzGLJXli9sJCGjw99v13tefIbgzzbH0Xpn87sKDwnO3k+M4WbZgwIyrxq5f4Ux+8q
         Jji4Ij+YrSzZ8v0uYebc9e1NmQrDe6EdNUPVRaQDlDwpFHHlJpmlGhFeb0Pbk4nP8p
         LUgMVztuL5GTVbcqGV6J2njj8sAnY0LVx9L+VEVLyd7P3Vl7SQKjttWx7lG0zyONsF
         bOFAUj5lRcGZQO2l5VJH+SL1d8QaitsuTiWruOHoR4lQLETOhBmssz9Wusk28pZCKA
         X90oa6RrFlY+g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/7] PCI: Use consistent controller Kconfig menu entry language
Date:   Tue, 18 Apr 2023 12:43:33 -0500
Message-Id: <20230418174336.145585-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418174336.145585-1-helgaas@kernel.org>
References: <20230418174336.145585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use "PCIe controller" consistently instead of "host bridge", "bus driver",
etc.  Annotate with "(host mode)" or "(endpoint mode)" as needed.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/Kconfig          | 22 +++++-----
 drivers/pci/controller/cadence/Kconfig  | 10 ++---
 drivers/pci/controller/dwc/Kconfig      | 54 ++++++++++++-------------
 drivers/pci/controller/mobiveil/Kconfig |  4 +-
 4 files changed, 45 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 5875587d8b59..7690cc7bbd3f 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -69,7 +69,7 @@ config PCI_RCAR_GEN2
 	  built-in EHCI/OHCI host controller present on each one.
 
 config PCIE_RCAR_HOST
-	bool "Renesas R-Car PCIe host controller"
+	bool "Renesas R-Car PCIe controller (host mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_MSI
 	help
@@ -77,7 +77,7 @@ config PCIE_RCAR_HOST
 	  mode.
 
 config PCIE_RCAR_EP
-	bool "Renesas R-Car PCIe endpoint controller"
+	bool "Renesas R-Car PCIe controller (endpoint mode)"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	help
@@ -98,7 +98,7 @@ config PCI_HOST_GENERIC
 	  controller, such as the one emulated by kvmtool.
 
 config PCIE_XILINX
-	bool "Xilinx AXI PCIe host bridge support"
+	bool "Xilinx AXI PCIe controller"
 	depends on OF || COMPILE_TEST
 	depends on PCI_MSI
 	help
@@ -106,7 +106,7 @@ config PCIE_XILINX
 	  Host Bridge driver.
 
 config PCIE_XILINX_CPM
-	bool "Xilinx Versal CPM host bridge support"
+	bool "Xilinx Versal CPM PCI controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
 	select PCI_HOST_COMMON
 	help
@@ -159,7 +159,7 @@ config PCIE_IPROC_PLATFORM
 	  through the generic platform bus interface
 
 config PCIE_IPROC_BCMA
-	tristate "Broadcom iProc PCIe BCMA bus driver"
+	tristate "Broadcom iProc BCMA PCIe controller"
 	depends on ARM && (ARCH_BCM_IPROC || COMPILE_TEST)
 	select PCIE_IPROC
 	select BCMA
@@ -213,7 +213,7 @@ config PCIE_ROCKCHIP
 	depends on PCI
 
 config PCIE_ROCKCHIP_HOST
-	tristate "Rockchip PCIe host controller"
+	tristate "Rockchip PCIe controller (host mode)"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI
@@ -225,7 +225,7 @@ config PCIE_ROCKCHIP_HOST
 	  4 slots.
 
 config PCIE_ROCKCHIP_EP
-	bool "Rockchip PCIe endpoint controller"
+	bool "Rockchip PCIe controller (endpoint mode)"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
 	depends on OF
 	depends on PCI_ENDPOINT
@@ -274,7 +274,7 @@ config VMD
 	  module will be called vmd.
 
 config PCIE_BRCMSTB
-	tristate "Broadcom Brcmstb PCIe host controller"
+	tristate "Broadcom Brcmstb PCIe controller"
 	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
 		   BMIPS_GENERIC || COMPILE_TEST
 	depends on OF
@@ -293,7 +293,7 @@ config PCI_HYPERV_INTERFACE
 	  driver.
 
 config PCI_LOONGSON
-	bool "LOONGSON PCI Controller"
+	bool "LOONGSON PCIe controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
 	depends on OF || ACPI
 	depends on PCI_QUIRKS
@@ -303,7 +303,7 @@ config PCI_LOONGSON
 	  Loongson systems.
 
 config PCIE_MICROCHIP_HOST
-	bool "Microchip AXI PCIe host bridge support"
+	bool "Microchip AXI PCIe controller"
 	depends on PCI_MSI && OF
 	select PCI_HOST_COMMON
 	help
@@ -336,7 +336,7 @@ config PCIE_APPLE
 	  If unsure, say Y if you have an Apple Silicon system.
 
 config PCIE_MT7621
-	tristate "MediaTek MT7621 PCIe Controller"
+	tristate "MediaTek MT7621 PCIe controller"
 	depends on SOC_MT7621 || COMPILE_TEST
 	select PHY_MT7621_PCI
 	default SOC_MT7621
diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 5d30564190e1..291d12711363 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-menu "Cadence PCIe controllers support"
+menu "Cadence-based PCIe controllers"
 	depends on PCI
 
 config PCIE_CADENCE
@@ -22,7 +22,7 @@ config PCIE_CADENCE_PLAT
 	bool
 
 config PCIE_CADENCE_PLAT_HOST
-	bool "Cadence PCIe platform host controller"
+	bool "Cadence platform PCIe controller (host mode)"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
@@ -32,7 +32,7 @@ config PCIE_CADENCE_PLAT_HOST
 	  vendors SoCs.
 
 config PCIE_CADENCE_PLAT_EP
-	bool "Cadence PCIe platform endpoint controller"
+	bool "Cadence platform PCIe controller (endpoint mode)"
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
@@ -46,7 +46,7 @@ config PCI_J721E
 	bool
 
 config PCI_J721E_HOST
-	bool "TI J721E PCIe platform host controller"
+	bool "TI J721E PCIe controller (host mode)"
 	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCI_J721E
@@ -56,7 +56,7 @@ config PCI_J721E_HOST
 	  core.
 
 config PCI_J721E_EP
-	bool "TI J721E PCIe platform endpoint controller"
+	bool "TI J721E PCIe controller (endpoint mode)"
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 617fcc7563ae..4c44ad9f8f2b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-menu "DesignWare PCI Core Support"
+menu "DesignWare-based PCIe controllers"
 	depends on PCI
 
 config PCIE_DW
@@ -18,7 +18,7 @@ config PCI_DRA7XX
 	tristate
 
 config PCI_DRA7XX_HOST
-	tristate "TI DRA7xx PCIe controller Host Mode"
+	tristate "TI DRA7xx PCIe controller (host mode)"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	depends on PCI_MSI
@@ -34,7 +34,7 @@ config PCI_DRA7XX_HOST
 	  This uses the DesignWare core.
 
 config PCI_DRA7XX_EP
-	tristate "TI DRA7xx PCIe controller Endpoint Mode"
+	tristate "TI DRA7xx PCIe controller (endpoint mode)"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on OF && HAS_IOMEM && TI_PIPE3
 	depends on PCI_ENDPOINT
@@ -52,7 +52,7 @@ config PCIE_DW_PLAT
 	bool
 
 config PCIE_DW_PLAT_HOST
-	bool "Platform bus based DesignWare PCIe Controller - Host mode"
+	bool "Platform bus based DesignWare PCIe controller (host mode)"
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCIE_DW_PLAT
@@ -66,7 +66,7 @@ config PCIE_DW_PLAT_HOST
 	  selected.
 
 config PCIE_DW_PLAT_EP
-	bool "Platform bus based DesignWare PCIe Controller - Endpoint mode"
+	bool "Platform bus based DesignWare PCIe controller (endpoint mode)"
 	depends on PCI && PCI_MSI
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
@@ -95,7 +95,7 @@ config PCI_IMX6
 	bool
 
 config PCI_IMX6_HOST
-	bool "Freescale i.MX6/7/8 PCIe controller host mode"
+	bool "Freescale i.MX6/7/8 PCIe controller (host mode)"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -107,7 +107,7 @@ config PCI_IMX6_HOST
 	  DesignWare core functions to implement the driver.
 
 config PCI_IMX6_EP
-	bool "Freescale i.MX6/7/8 PCIe controller endpoint mode"
+	bool "Freescale i.MX6/7/8 PCIe controller (endpoint mode)"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
@@ -130,7 +130,7 @@ config PCI_KEYSTONE
 	bool
 
 config PCI_KEYSTONE_HOST
-	bool "PCI Keystone Host Mode"
+	bool "TI Keystone PCIe controller (host mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -142,7 +142,7 @@ config PCI_KEYSTONE_HOST
 	  DesignWare core functions to implement the driver.
 
 config PCI_KEYSTONE_EP
-	bool "PCI Keystone Endpoint Mode"
+	bool "TI Keystone PCIe controller (endpoint mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
@@ -154,7 +154,7 @@ config PCI_KEYSTONE_EP
 	  DesignWare core functions to implement the driver.
 
 config PCI_LAYERSCAPE
-	bool "Freescale Layerscape PCIe controller - Host mode"
+	bool "Freescale Layerscape PCIe controller (host mode)"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -167,7 +167,7 @@ config PCI_LAYERSCAPE
 	  controller works in RC mode.
 
 config PCI_LAYERSCAPE_EP
-	bool "Freescale Layerscape PCIe controller - Endpoint mode"
+	bool "Freescale Layerscape PCIe controller (endpoint mode)"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
@@ -180,7 +180,7 @@ config PCI_LAYERSCAPE_EP
 
 config PCI_HISI
 	depends on OF && (ARM64 || COMPILE_TEST)
-	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controller"
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select PCI_HOST_COMMON
@@ -189,7 +189,7 @@ config PCI_HISI
 	  Hip05 and Hip06 SoCs
 
 config PCIE_QCOM
-	bool "Qualcomm PCIe controller"
+	bool "Qualcomm PCIe controller (host mode)"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -200,7 +200,7 @@ config PCIE_QCOM
 	  hardware wrappers.
 
 config PCIE_QCOM_EP
-	tristate "Qualcomm PCIe controller - Endpoint mode"
+	tristate "Qualcomm PCIe controller (endpoint mode)"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
@@ -224,7 +224,7 @@ config PCIE_ARTPEC6
 	bool
 
 config PCIE_ARTPEC6_HOST
-	bool "Axis ARTPEC-6 PCIe controller Host Mode"
+	bool "Axis ARTPEC-6 PCIe controller (host mode)"
 	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -234,7 +234,7 @@ config PCIE_ARTPEC6_HOST
 	  host mode. This uses the DesignWare core.
 
 config PCIE_ARTPEC6_EP
-	bool "Axis ARTPEC-6 PCIe controller Endpoint Mode"
+	bool "Axis ARTPEC-6 PCIe controller (endpoint mode)"
 	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
@@ -264,7 +264,7 @@ config PCIE_ROCKCHIP_DW_HOST
 	  Rockchip SoC except RK3399.
 
 config PCIE_INTEL_GW
-	bool "Intel Gateway PCIe host controller support"
+	bool "Intel Gateway PCIe controller "
 	depends on OF && (X86 || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -278,7 +278,7 @@ config PCIE_KEEMBAY
 	bool
 
 config PCIE_KEEMBAY_HOST
-	bool "Intel Keem Bay PCIe controller - Host mode"
+	bool "Intel Keem Bay PCIe controller (host mode)"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -290,7 +290,7 @@ config PCIE_KEEMBAY_HOST
 	  DesignWare core functions.
 
 config PCIE_KEEMBAY_EP
-	bool "Intel Keem Bay PCIe controller - Endpoint mode"
+	bool "Intel Keem Bay PCIe controller (endpoint mode)"
 	depends on ARCH_KEEMBAY || COMPILE_TEST
 	depends on PCI_MSI
 	depends on PCI_ENDPOINT
@@ -304,7 +304,7 @@ config PCIE_KEEMBAY_EP
 
 config PCIE_KIRIN
 	depends on OF && (ARM64 || COMPILE_TEST)
-	tristate "HiSilicon Kirin series SoCs PCIe controllers"
+	tristate "HiSilicon Kirin PCIe controller"
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select REGMAP_MMIO
@@ -313,7 +313,7 @@ config PCIE_KIRIN
 	  on HiSilicon Kirin series SoCs.
 
 config PCIE_HISI_STB
-	bool "HiSilicon STB SoCs PCIe controllers"
+	bool "HiSilicon STB PCIe controller"
 	depends on ARCH_HISI || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -335,7 +335,7 @@ config PCIE_TEGRA194
 	tristate
 
 config PCIE_TEGRA194_HOST
-	tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
+	tristate "NVIDIA Tegra194 (and later) PCIe controller (host mode)"
 	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -350,7 +350,7 @@ config PCIE_TEGRA194_HOST
 	  selected. This uses the DesignWare core.
 
 config PCIE_TEGRA194_EP
-	tristate "NVIDIA Tegra194 (and later) PCIe controller - Endpoint Mode"
+	tristate "NVIDIA Tegra194 (and later) PCIe controller (endpoint mode)"
 	depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
@@ -365,7 +365,7 @@ config PCIE_TEGRA194_EP
 	  selected. This uses the DesignWare core.
 
 config PCIE_VISCONTI_HOST
-	bool "Toshiba Visconti PCIe controllers"
+	bool "Toshiba Visconti PCIe controller"
 	depends on ARCH_VISCONTI || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -374,7 +374,7 @@ config PCIE_VISCONTI_HOST
 	  This driver supports TMPV7708 SoC.
 
 config PCIE_UNIPHIER
-	bool "Socionext UniPhier PCIe host controllers"
+	bool "Socionext UniPhier PCIe controller (host mode)"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	depends on PCI_MSI
@@ -384,7 +384,7 @@ config PCIE_UNIPHIER
 	  This driver supports LD20 and PXs3 SoCs.
 
 config PCIE_UNIPHIER_EP
-	bool "Socionext UniPhier PCIe endpoint controllers"
+	bool "Socionext UniPhier PCIe controller (endpoint mode)"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	depends on PCI_ENDPOINT
@@ -407,7 +407,7 @@ config PCIE_AL
 	  Annapurna Labs PCIe controller don't need to enable this.
 
 config PCIE_FU740
-	bool "SiFive FU740 PCIe host controller"
+	bool "SiFive FU740 PCIe controller"
 	depends on PCI_MSI
 	depends on SOC_SIFIVE || COMPILE_TEST
 	select PCIE_DW_HOST
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index 1d7a07ba9ccd..bc9c624cf619 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-menu "Mobiveil PCIe Core Support"
+menu "Mobiveil-based PCIe controllers"
 	depends on PCI
 
 config PCIE_MOBIVEIL
@@ -23,7 +23,7 @@ config PCIE_MOBIVEIL_PLAT
 	  for address translation and it is a PCIe Gen4 IP.
 
 config PCIE_LAYERSCAPE_GEN4
-	bool "Freescale Layerscape PCIe Gen4 controller"
+	bool "Freescale Layerscape Gen4 PCIe controller"
 	depends on ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_MOBIVEIL_HOST
-- 
2.25.1

