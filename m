Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FCA6E6B48
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjDRRoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjDRRoC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:44:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3169EEA;
        Tue, 18 Apr 2023 10:43:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09AEF63774;
        Tue, 18 Apr 2023 17:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A657C4339C;
        Tue, 18 Apr 2023 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839838;
        bh=VFe7w/vnycRWYHKPu1DTbqCJhhPF6tfQJVe3yM8cJOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ye4zKqDaO8mzIT7AVAh/i5g/N8+rFaU//8YDTfHrwD3DZ/tqvreG5KBM7FXmujkHq
         W3tAojyDM/87MIrgo80L5cqnybn1/VxHDfD4cw9H0XH4AUqZJoUGcnO4MBPgCMiY9w
         xWMWcbdGVCRDrgSr7o7rrieiAcUaPmct2EalbzhhTRYayU8MPWogIcEeQgw4N7IFcP
         8kQ7g4wWorCSMhE/6WwwlOw1K7I15VO6bHGikvYZ4m4EeWyEUqqWLDBQZG32pHkExD
         kWHC+wU7zbdhIMD+M24/FX/0oKNpFskqpGmN55cWyFjsJseCiNVUO3FBg/3WKkdVNM
         PYfMInHSH05+g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/7] PCI: dwc: Sort Kconfig entries by vendor
Date:   Tue, 18 Apr 2023 12:43:35 -0500
Message-Id: <20230418174336.145585-7-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230418174336.145585-1-helgaas@kernel.org>
References: <20230418174336.145585-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Sort Kconfig entries by vendor so they appear in alphabetical order in
menuconfig.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/Kconfig | 406 ++++++++++++++---------------
 1 file changed, 203 insertions(+), 203 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 4c44ad9f8f2b..ab96da43e0c2 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -14,82 +14,61 @@ config PCIE_DW_EP
 	bool
 	select PCIE_DW
 
-config PCI_DRA7XX
-	tristate
-
-config PCI_DRA7XX_HOST
-	tristate "TI DRA7xx PCIe controller (host mode)"
-	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
+config PCIE_AL
+	bool "Amazon Annapurna Labs PCIe controller"
+	depends on OF && (ARM64 || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
-	select PCI_DRA7XX
-	default y if SOC_DRA7XX
+	select PCI_ECAM
 	help
-	  Enables support for the PCIe controller in the DRA7xx SoC to work in
-	  host mode. There are two instances of PCIe controller in DRA7xx.
-	  This controller can work either as EP or RC. In order to enable
-	  host-specific features PCI_DRA7XX_HOST must be selected and in order
-	  to enable device-specific features PCI_DRA7XX_EP must be selected.
-	  This uses the DesignWare core.
+	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
+	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
+	  core plus Annapurna Labs proprietary hardware wrappers. This is
+	  required only for DT-based platforms. ACPI platforms with the
+	  Annapurna Labs PCIe controller don't need to enable this.
 
-config PCI_DRA7XX_EP
-	tristate "TI DRA7xx PCIe controller (endpoint mode)"
-	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
-	depends on PCI_ENDPOINT
-	select PCIE_DW_EP
-	select PCI_DRA7XX
+config PCI_MESON
+	tristate "Amlogic Meson PCIe controller"
+	default m if ARCH_MESON
+	depends on PCI_MSI
+	select PCIE_DW_HOST
 	help
-	  Enables support for the PCIe controller in the DRA7xx SoC to work in
-	  endpoint mode. There are two instances of PCIe controller in DRA7xx.
-	  This controller can work either as EP or RC. In order to enable
-	  host-specific features PCI_DRA7XX_HOST must be selected and in order
-	  to enable device-specific features PCI_DRA7XX_EP must be selected.
-	  This uses the DesignWare core.
+	  Say Y here if you want to enable PCI controller support on Amlogic
+	  SoCs. The PCI controller on Amlogic is based on DesignWare hardware
+	  and therefore the driver re-uses the DesignWare core functions to
+	  implement the driver.
 
-config PCIE_DW_PLAT
+config PCIE_ARTPEC6
 	bool
 
-config PCIE_DW_PLAT_HOST
-	bool "Platform bus based DesignWare PCIe controller (host mode)"
+config PCIE_ARTPEC6_HOST
+	bool "Axis ARTPEC-6 PCIe controller (host mode)"
+	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
-	select PCIE_DW_PLAT
+	select PCIE_ARTPEC6
 	help
-	  Enables support for the PCIe controller in the Designware IP to
-	  work in host mode. There are two instances of PCIe controller in
-	  Designware IP.
-	  This controller can work either as EP or RC. In order to enable
-	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
-	  order to enable device-specific features PCI_DW_PLAT_EP must be
-	  selected.
+	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
+	  host mode. This uses the DesignWare core.
 
-config PCIE_DW_PLAT_EP
-	bool "Platform bus based DesignWare PCIe controller (endpoint mode)"
-	depends on PCI && PCI_MSI
+config PCIE_ARTPEC6_EP
+	bool "Axis ARTPEC-6 PCIe controller (endpoint mode)"
+	depends on MACH_ARTPEC6 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
-	select PCIE_DW_PLAT
+	select PCIE_ARTPEC6
 	help
-	  Enables support for the PCIe controller in the Designware IP to
-	  work in endpoint mode. There are two instances of PCIe controller
-	  in Designware IP.
-	  This controller can work either as EP or RC. In order to enable
-	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
-	  order to enable device-specific features PCI_DW_PLAT_EP must be
-	  selected.
+	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
+	  endpoint mode. This uses the DesignWare core.
 
-config PCI_EXYNOS
-	tristate "Samsung Exynos PCIe controller"
-	depends on ARCH_EXYNOS || COMPILE_TEST
+config PCIE_BT1
+	tristate "Baikal-T1 PCIe controller"
+	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
-	  Enables support for the PCIe controller in the Samsung Exynos SoCs
-	  to work in host mode. The PCI controller is based on the DesignWare
-	  hardware and therefore the driver re-uses the DesignWare core
-	  functions to implement the driver.
+	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
+	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
 
 config PCI_IMX6
 	bool
@@ -118,41 +97,6 @@ config PCI_IMX6_EP
 	  on DesignWare hardware and therefore the driver re-uses the
 	  DesignWare core functions to implement the driver.
 
-config PCIE_SPEAR13XX
-	bool "STMicroelectronics SPEAr PCIe controller"
-	depends on ARCH_SPEAR13XX || COMPILE_TEST
-	depends on PCI_MSI
-	select PCIE_DW_HOST
-	help
-	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
-
-config PCI_KEYSTONE
-	bool
-
-config PCI_KEYSTONE_HOST
-	bool "TI Keystone PCIe controller (host mode)"
-	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
-	depends on PCI_MSI
-	select PCIE_DW_HOST
-	select PCI_KEYSTONE
-	help
-	  Enables support for the PCIe controller in the Keystone SoC to
-	  work in host mode. The PCI controller on Keystone is based on
-	  DesignWare hardware and therefore the driver re-uses the
-	  DesignWare core functions to implement the driver.
-
-config PCI_KEYSTONE_EP
-	bool "TI Keystone PCIe controller (endpoint mode)"
-	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
-	depends on PCI_ENDPOINT
-	select PCIE_DW_EP
-	select PCI_KEYSTONE
-	help
-	  Enables support for the PCIe controller in the Keystone SoC to
-	  work in endpoint mode. The PCI controller on Keystone is based
-	  on DesignWare hardware and therefore the driver re-uses the
-	  DesignWare core functions to implement the driver.
-
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller (host mode)"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
@@ -188,80 +132,23 @@ config PCI_HISI
 	  Say Y here if you want PCIe controller support on HiSilicon
 	  Hip05 and Hip06 SoCs
 
-config PCIE_QCOM
-	bool "Qualcomm PCIe controller (host mode)"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+config PCIE_KIRIN
+	depends on OF && (ARM64 || COMPILE_TEST)
+	tristate "HiSilicon Kirin PCIe controller"
 	depends on PCI_MSI
 	select PCIE_DW_HOST
-	select CRC8
+	select REGMAP_MMIO
 	help
-	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
-	  PCIe controller uses the DesignWare core plus Qualcomm-specific
-	  hardware wrappers.
+	  Say Y here if you want PCIe controller support
+	  on HiSilicon Kirin series SoCs.
 
-config PCIE_QCOM_EP
-	tristate "Qualcomm PCIe controller (endpoint mode)"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
-	depends on PCI_ENDPOINT
-	select PCIE_DW_EP
-	help
-	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
-	  to work in endpoint mode. The PCIe controller uses the DesignWare core
-	  plus Qualcomm-specific hardware wrappers.
-
-config PCIE_ARMADA_8K
-	bool "Marvell Armada-8K PCIe controller"
-	depends on ARCH_MVEBU || COMPILE_TEST
+config PCIE_HISI_STB
+	bool "HiSilicon STB PCIe controller"
+	depends on ARCH_HISI || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
-	  Say Y here if you want to enable PCIe controller support on
-	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
-	  DesignWare hardware and therefore the driver re-uses the
-	  DesignWare core functions to implement the driver.
-
-config PCIE_ARTPEC6
-	bool
-
-config PCIE_ARTPEC6_HOST
-	bool "Axis ARTPEC-6 PCIe controller (host mode)"
-	depends on MACH_ARTPEC6 || COMPILE_TEST
-	depends on PCI_MSI
-	select PCIE_DW_HOST
-	select PCIE_ARTPEC6
-	help
-	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
-	  host mode. This uses the DesignWare core.
-
-config PCIE_ARTPEC6_EP
-	bool "Axis ARTPEC-6 PCIe controller (endpoint mode)"
-	depends on MACH_ARTPEC6 || COMPILE_TEST
-	depends on PCI_ENDPOINT
-	select PCIE_DW_EP
-	select PCIE_ARTPEC6
-	help
-	  Enables support for the PCIe controller in the ARTPEC-6 SoC to work in
-	  endpoint mode. This uses the DesignWare core.
-
-config PCIE_BT1
-	tristate "Baikal-T1 PCIe controller"
-	depends on MIPS_BAIKAL_T1 || COMPILE_TEST
-	depends on PCI_MSI
-	select PCIE_DW_HOST
-	help
-	  Enables support for the PCIe controller in the Baikal-T1 SoC to work
-	  in host mode. It's based on the Synopsys DWC PCIe v4.60a IP-core.
-
-config PCIE_ROCKCHIP_DW_HOST
-	bool "Rockchip DesignWare PCIe controller"
-	select PCIE_DW
-	select PCIE_DW_HOST
-	depends on PCI_MSI
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
-	help
-	  Enables support for the DesignWare PCIe controller in the
-	  Rockchip SoC except RK3399.
+	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
 
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe controller "
@@ -302,34 +189,16 @@ config PCIE_KEEMBAY_EP
 	  The PCIe controller is based on DesignWare Hardware and uses
 	  DesignWare core functions.
 
-config PCIE_KIRIN
-	depends on OF && (ARM64 || COMPILE_TEST)
-	tristate "HiSilicon Kirin PCIe controller"
-	depends on PCI_MSI
-	select PCIE_DW_HOST
-	select REGMAP_MMIO
-	help
-	  Say Y here if you want PCIe controller support
-	  on HiSilicon Kirin series SoCs.
-
-config PCIE_HISI_STB
-	bool "HiSilicon STB PCIe controller"
-	depends on ARCH_HISI || COMPILE_TEST
+config PCIE_ARMADA_8K
+	bool "Marvell Armada-8K PCIe controller"
+	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
-	  Say Y here if you want PCIe controller support on HiSilicon STB SoCs
-
-config PCI_MESON
-	tristate "Amlogic Meson PCIe controller"
-	default m if ARCH_MESON
-	depends on PCI_MSI
-	select PCIE_DW_HOST
-	help
-	  Say Y here if you want to enable PCI controller support on Amlogic
-	  SoCs. The PCI controller on Amlogic is based on DesignWare hardware
-	  and therefore the driver re-uses the DesignWare core functions to
-	  implement the driver.
+	  Say Y here if you want to enable PCIe controller support on
+	  Armada-8K SoCs. The PCIe controller on Armada-8K is based on
+	  DesignWare hardware and therefore the driver re-uses the
+	  DesignWare core functions to implement the driver.
 
 config PCIE_TEGRA194
 	tristate
@@ -364,14 +233,89 @@ config PCIE_TEGRA194_EP
 	  in order to enable device-specific features PCIE_TEGRA194_EP must be
 	  selected. This uses the DesignWare core.
 
-config PCIE_VISCONTI_HOST
-	bool "Toshiba Visconti PCIe controller"
-	depends on ARCH_VISCONTI || COMPILE_TEST
+config PCIE_DW_PLAT
+	bool
+
+config PCIE_DW_PLAT_HOST
+	bool "Platform bus based DesignWare PCIe controller (host mode)"
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	select PCIE_DW_PLAT
+	help
+	  Enables support for the PCIe controller in the Designware IP to
+	  work in host mode. There are two instances of PCIe controller in
+	  Designware IP.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
+	  order to enable device-specific features PCI_DW_PLAT_EP must be
+	  selected.
+
+config PCIE_DW_PLAT_EP
+	bool "Platform bus based DesignWare PCIe controller (endpoint mode)"
+	depends on PCI && PCI_MSI
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCIE_DW_PLAT
+	help
+	  Enables support for the PCIe controller in the Designware IP to
+	  work in endpoint mode. There are two instances of PCIe controller
+	  in Designware IP.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCIE_DW_PLAT_HOST must be selected and in
+	  order to enable device-specific features PCI_DW_PLAT_EP must be
+	  selected.
+
+config PCIE_QCOM
+	bool "Qualcomm PCIe controller (host mode)"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	select CRC8
+	help
+	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
+	  PCIe controller uses the DesignWare core plus Qualcomm-specific
+	  hardware wrappers.
+
+config PCIE_QCOM_EP
+	tristate "Qualcomm PCIe controller (endpoint mode)"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
+	  to work in endpoint mode. The PCIe controller uses the DesignWare core
+	  plus Qualcomm-specific hardware wrappers.
+
+config PCIE_ROCKCHIP_DW_HOST
+	bool "Rockchip DesignWare PCIe controller"
+	select PCIE_DW
+	select PCIE_DW_HOST
+	depends on PCI_MSI
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on OF
+	help
+	  Enables support for the DesignWare PCIe controller in the
+	  Rockchip SoC except RK3399.
+
+config PCI_EXYNOS
+	tristate "Samsung Exynos PCIe controller"
+	depends on ARCH_EXYNOS || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	help
-	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
-	  This driver supports TMPV7708 SoC.
+	  Enables support for the PCIe controller in the Samsung Exynos SoCs
+	  to work in host mode. The PCI controller is based on the DesignWare
+	  hardware and therefore the driver re-uses the DesignWare core
+	  functions to implement the driver.
+
+config PCIE_FU740
+	bool "SiFive FU740 PCIe controller"
+	depends on PCI_MSI
+	depends on SOC_SIFIVE || COMPILE_TEST
+	select PCIE_DW_HOST
+	help
+	  Say Y here if you want PCIe controller support for the SiFive
+	  FU740.
 
 config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe controller (host mode)"
@@ -393,26 +337,82 @@ config PCIE_UNIPHIER_EP
 	  Say Y here if you want PCIe endpoint controller support on
 	  UniPhier SoCs. This driver supports Pro5 SoC.
 
-config PCIE_AL
-	bool "Amazon Annapurna Labs PCIe controller"
-	depends on OF && (ARM64 || COMPILE_TEST)
+config PCIE_SPEAR13XX
+	bool "STMicroelectronics SPEAr PCIe controller"
+	depends on ARCH_SPEAR13XX || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
-	select PCI_ECAM
 	help
-	  Say Y here to enable support of the Amazon's Annapurna Labs PCIe
-	  controller IP on Amazon SoCs. The PCIe controller uses the DesignWare
-	  core plus Annapurna Labs proprietary hardware wrappers. This is
-	  required only for DT-based platforms. ACPI platforms with the
-	  Annapurna Labs PCIe controller don't need to enable this.
+	  Say Y here if you want PCIe support on SPEAr13XX SoCs.
 
-config PCIE_FU740
-	bool "SiFive FU740 PCIe controller"
+config PCI_DRA7XX
+	tristate
+
+config PCI_DRA7XX_HOST
+	tristate "TI DRA7xx PCIe controller (host mode)"
+	depends on SOC_DRA7XX || COMPILE_TEST
+	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	select PCI_DRA7XX
+	default y if SOC_DRA7XX
+	help
+	  Enables support for the PCIe controller in the DRA7xx SoC to work in
+	  host mode. There are two instances of PCIe controller in DRA7xx.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCI_DRA7XX_HOST must be selected and in order
+	  to enable device-specific features PCI_DRA7XX_EP must be selected.
+	  This uses the DesignWare core.
+
+config PCI_DRA7XX_EP
+	tristate "TI DRA7xx PCIe controller (endpoint mode)"
+	depends on SOC_DRA7XX || COMPILE_TEST
+	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCI_DRA7XX
+	help
+	  Enables support for the PCIe controller in the DRA7xx SoC to work in
+	  endpoint mode. There are two instances of PCIe controller in DRA7xx.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCI_DRA7XX_HOST must be selected and in order
+	  to enable device-specific features PCI_DRA7XX_EP must be selected.
+	  This uses the DesignWare core.
+
+config PCI_KEYSTONE
+	bool
+
+config PCI_KEYSTONE_HOST
+	bool "TI Keystone PCIe controller (host mode)"
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	depends on PCI_MSI
+	select PCIE_DW_HOST
+	select PCI_KEYSTONE
+	help
+	  Enables support for the PCIe controller in the Keystone SoC to
+	  work in host mode. The PCI controller on Keystone is based on
+	  DesignWare hardware and therefore the driver re-uses the
+	  DesignWare core functions to implement the driver.
+
+config PCI_KEYSTONE_EP
+	bool "TI Keystone PCIe controller (endpoint mode)"
+	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCI_KEYSTONE
+	help
+	  Enables support for the PCIe controller in the Keystone SoC to
+	  work in endpoint mode. The PCI controller on Keystone is based
+	  on DesignWare hardware and therefore the driver re-uses the
+	  DesignWare core functions to implement the driver.
+
+config PCIE_VISCONTI_HOST
+	bool "Toshiba Visconti PCIe controller"
+	depends on ARCH_VISCONTI || COMPILE_TEST
 	depends on PCI_MSI
-	depends on SOC_SIFIVE || COMPILE_TEST
 	select PCIE_DW_HOST
 	help
-	  Say Y here if you want PCIe controller support for the SiFive
-	  FU740.
+	  Say Y here if you want PCIe controller support on Toshiba Visconti SoC.
+	  This driver supports TMPV7708 SoC.
 
 endmenu
-- 
2.25.1

