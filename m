Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FD76E6B4A
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 19:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjDRRoD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 13:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjDRRoA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 13:44:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F34BBB5;
        Tue, 18 Apr 2023 10:43:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50CA363777;
        Tue, 18 Apr 2023 17:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E6AC4339C;
        Tue, 18 Apr 2023 17:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681839836;
        bh=AL3+SyTTFCGKDjWw5td9YZ2QKfBI0GTdJPgM4AiAhe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAT2gw1Tw2FDwQKJRtKhP2QuKhZEZDORi5PZa6kKxzEqCrB3ljiU3FdGz2BmAod8W
         /R5OGZyEhdpRtwhpTEPNoCUrzjkGA+E1lIYG2z1Qm+WvzvnDvOOjgBIpl59Jdjw3lN
         VfEHH0iON+Rr93MQfGoDrpclF3bWSvNirIZhYRnJL0tjMDgINuKtuGeHmBtAhcfxGe
         0Jn7EggHHVG4cUjuGifgMvR9FH6myR3nwPx6HD4/CCkegCZ+hZoSQaSY/D5f9pTX6m
         nAB2KifRYjpUqWW895aJo7HV626CPcgzQeBwif3qBcP+RMFodkFMrLbWk4VbDg98HZ
         oI8skUATWZrvw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5/7] PCI: Sort controller Kconfig entries by vendor
Date:   Tue, 18 Apr 2023 12:43:34 -0500
Message-Id: <20230418174336.145585-6-helgaas@kernel.org>
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
 drivers/pci/controller/Kconfig | 456 ++++++++++++++++-----------------
 1 file changed, 228 insertions(+), 228 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 7690cc7bbd3f..c52ca0c9550d 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -3,19 +3,6 @@
 menu "PCI controller drivers"
 	depends on PCI
 
-config PCI_MVEBU
-	tristate "Marvell EBU PCIe controller"
-	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
-	depends on MVEBU_MBUS
-	depends on ARM
-	depends on OF
-	depends on BROKEN
-	select PCI_BRIDGE_EMUL
-	help
-	 Add support for Marvell EBU PCIe controller. This PCIe controller
-	 is used on 32-bit Marvell ARM SoCs: Dove, Kirkwood, Armada 370,
-	 Armada XP, Armada 375, Armada 38x and Armada 39x.
-
 config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
@@ -27,120 +14,54 @@ config PCI_AARDVARK
 	 controller is part of the South Bridge of the Marvel Armada
 	 3700 SoC.
 
-config PCIE_XILINX_NWL
-	bool "Xilinx NWL PCIe controller"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
+config PCIE_ALTERA
+	tristate "Altera PCIe controller"
+	depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
+	help
+	  Say Y here if you want to enable PCIe controller support on Altera
+	  FPGA.
+
+config PCIE_ALTERA_MSI
+	tristate "Altera PCIe MSI feature"
+	depends on PCIE_ALTERA
 	depends on PCI_MSI
 	help
-	 Say 'Y' here if you want kernel support for Xilinx
-	 NWL PCIe controller. The controller can act as Root Port
-	 or End Point. The current option selection will only
-	 support root port enabling.
+	  Say Y here if you want PCIe MSI support for the Altera FPGA.
+	  This MSI driver supports Altera MSI to GIC controller IP.
 
-config PCI_FTPCI100
-	bool "Faraday Technology FTPCI100 PCI controller"
+config PCIE_APPLE_MSI_DOORBELL_ADDR
+	hex
+	default 0xfffff000
+	depends on PCIE_APPLE
+
+config PCIE_APPLE
+	tristate "Apple PCIe controller"
+	depends on ARCH_APPLE || COMPILE_TEST
 	depends on OF
-	default ARCH_GEMINI
-
-config PCI_IXP4XX
-	bool "Intel IXP4xx PCI controller"
-	depends on ARM && OF
-	depends on ARCH_IXP4XX || COMPILE_TEST
-	default ARCH_IXP4XX
-	help
-	  Say Y here if you want support for the PCI host controller found
-	  in the Intel IXP4xx XScale-based network processor SoC.
-
-config PCI_TEGRA
-	bool "NVIDIA Tegra PCIe controller"
-	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on PCI_MSI
-	help
-	  Say Y here if you want support for the PCIe host controller found
-	  on NVIDIA Tegra SoCs.
-
-config PCI_RCAR_GEN2
-	bool "Renesas R-Car Gen2 Internal PCI controller"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on ARM
-	help
-	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
-	  There are 3 internal PCI controllers available with a single
-	  built-in EHCI/OHCI host controller present on each one.
-
-config PCIE_RCAR_HOST
-	bool "Renesas R-Car PCIe controller (host mode)"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on PCI_MSI
-	help
-	  Say Y here if you want PCIe controller support on R-Car SoCs in host
-	  mode.
-
-config PCIE_RCAR_EP
-	bool "Renesas R-Car PCIe controller (endpoint mode)"
-	depends on ARCH_RENESAS || COMPILE_TEST
-	depends on PCI_ENDPOINT
-	help
-	  Say Y here if you want PCIe controller support on R-Car SoCs in
-	  endpoint mode.
-
-config PCI_HOST_COMMON
-	tristate
-	select PCI_ECAM
-
-config PCI_HOST_GENERIC
-	tristate "Generic PCI host controller"
-	depends on OF
-	select PCI_HOST_COMMON
-	select IRQ_DOMAIN
-	help
-	  Say Y here if you want to support a simple generic PCI host
-	  controller, such as the one emulated by kvmtool.
-
-config PCIE_XILINX
-	bool "Xilinx AXI PCIe controller"
-	depends on OF || COMPILE_TEST
-	depends on PCI_MSI
-	help
-	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
-	  Host Bridge driver.
-
-config PCIE_XILINX_CPM
-	bool "Xilinx Versal CPM PCI controller"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
 	select PCI_HOST_COMMON
 	help
-	  Say 'Y' here if you want kernel support for the
-	  Xilinx Versal CPM host bridge.
+	  Say Y here if you want to enable PCIe controller support on Apple
+	  system-on-chips, like the Apple M1. This is required for the USB
+	  type-A ports, Ethernet, Wi-Fi, and Bluetooth.
 
-config PCI_XGENE
-	bool "X-Gene PCIe controller"
-	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
-	help
-	  Say Y here if you want internal PCI support on APM X-Gene SoC.
-	  There are 5 internal PCIe ports available. Each port is GEN3 capable
-	  and have varied lanes from x1 to x8.
-
-config PCI_XGENE_MSI
-	bool "X-Gene v1 PCIe MSI feature"
-	depends on PCI_XGENE
-	depends on PCI_MSI
-	default y
-	help
-	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
-	  This MSI driver supports 5 PCIe ports on the APM X-Gene v1 SoC.
-
-config PCI_V3_SEMI
-	bool "V3 Semiconductor PCI controller"
-	depends on OF
-	depends on ARM || COMPILE_TEST
-	default ARCH_INTEGRATOR_AP
+	  If unsure, say Y if you have an Apple Silicon system.
 
 config PCI_VERSATILE
 	bool "ARM Versatile PB PCI controller"
 	depends on ARCH_VERSATILE || COMPILE_TEST
 
+config PCIE_BRCMSTB
+	tristate "Broadcom Brcmstb PCIe controller"
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
+		   BMIPS_GENERIC || COMPILE_TEST
+	depends on OF
+	depends on PCI_MSI
+	default ARCH_BRCMSTB || BMIPS_GENERIC
+	help
+	  Say Y here to enable PCIe host controller support for
+	  Broadcom STB based SoCs, like the Raspberry Pi 4.
+
 config PCIE_IPROC
 	tristate
 	help
@@ -177,21 +98,6 @@ config PCIE_IPROC_MSI
 	  Say Y here if you want to enable MSI support for Broadcom's iProc
 	  PCIe controller
 
-config PCIE_ALTERA
-	tristate "Altera PCIe controller"
-	depends on ARM || NIOS2 || ARM64 || COMPILE_TEST
-	help
-	  Say Y here if you want to enable PCIe controller support on Altera
-	  FPGA.
-
-config PCIE_ALTERA_MSI
-	tristate "Altera PCIe MSI feature"
-	depends on PCIE_ALTERA
-	depends on PCI_MSI
-	help
-	  Say Y here if you want PCIe MSI support for the Altera FPGA.
-	  This MSI driver supports Altera MSI to GIC controller IP.
-
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
 	depends on ARM64 || COMPILE_TEST
@@ -208,6 +114,157 @@ config PCI_HOST_THUNDER_ECAM
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
 
+config PCI_FTPCI100
+	bool "Faraday Technology FTPCI100 PCI controller"
+	depends on OF
+	default ARCH_GEMINI
+
+config PCI_HOST_COMMON
+	tristate
+	select PCI_ECAM
+
+config PCI_HOST_GENERIC
+	tristate "Generic PCI host controller"
+	depends on OF
+	select PCI_HOST_COMMON
+	select IRQ_DOMAIN
+	help
+	  Say Y here if you want to support a simple generic PCI host
+	  controller, such as the one emulated by kvmtool.
+
+config PCIE_HISI_ERR
+	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
+	bool "HiSilicon HIP PCIe controller error handling driver"
+	help
+	  Say Y here if you want error handling support
+	  for the PCIe controller's errors on HiSilicon HIP SoCs
+
+config PCI_IXP4XX
+	bool "Intel IXP4xx PCI controller"
+	depends on ARM && OF
+	depends on ARCH_IXP4XX || COMPILE_TEST
+	default ARCH_IXP4XX
+	help
+	  Say Y here if you want support for the PCI host controller found
+	  in the Intel IXP4xx XScale-based network processor SoC.
+
+config VMD
+	depends on PCI_MSI && X86_64 && !UML
+	tristate "Intel Volume Management Device Driver"
+	help
+	  Adds support for the Intel Volume Management Device (VMD). VMD is a
+	  secondary PCI host bridge that allows PCI Express root ports,
+	  and devices attached to them, to be removed from the default
+	  PCI domain and placed within the VMD domain. This provides
+	  more bus resources than are otherwise possible with a
+	  single domain. If you know your system provides one of these and
+	  has devices attached to it, say Y; if you are not sure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called vmd.
+
+config PCI_LOONGSON
+	bool "LOONGSON PCIe controller"
+	depends on MACH_LOONGSON64 || COMPILE_TEST
+	depends on OF || ACPI
+	depends on PCI_QUIRKS
+	default MACH_LOONGSON64
+	help
+	  Say Y here if you want to enable PCI controller support on
+	  Loongson systems.
+
+config PCI_MVEBU
+	tristate "Marvell EBU PCIe controller"
+	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
+	depends on MVEBU_MBUS
+	depends on ARM
+	depends on OF
+	depends on BROKEN
+	select PCI_BRIDGE_EMUL
+	help
+	 Add support for Marvell EBU PCIe controller. This PCIe controller
+	 is used on 32-bit Marvell ARM SoCs: Dove, Kirkwood, Armada 370,
+	 Armada XP, Armada 375, Armada 38x and Armada 39x.
+
+config PCIE_MEDIATEK
+	tristate "MediaTek PCIe controller"
+	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
+	depends on OF
+	depends on PCI_MSI
+	help
+	  Say Y here if you want to enable PCIe controller support on
+	  MediaTek SoCs.
+
+config PCIE_MEDIATEK_GEN3
+	tristate "MediaTek Gen3 PCIe controller"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on PCI_MSI
+	help
+	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
+	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
+	  and support up to 256 MSI interrupt numbers for
+	  multi-function devices.
+
+	  Say Y here if you want to enable Gen3 PCIe controller support on
+	  MediaTek SoCs.
+
+config PCIE_MT7621
+	tristate "MediaTek MT7621 PCIe controller"
+	depends on SOC_MT7621 || COMPILE_TEST
+	select PHY_MT7621_PCI
+	default SOC_MT7621
+	help
+	  This selects a driver for the MediaTek MT7621 PCIe Controller.
+
+config PCIE_MICROCHIP_HOST
+	bool "Microchip AXI PCIe controller"
+	depends on PCI_MSI && OF
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want kernel to support the Microchip AXI PCIe
+	  Host Bridge driver.
+
+config PCI_HYPERV_INTERFACE
+	tristate "Microsoft Hyper-V PCI Interface"
+	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
+	help
+	  The Hyper-V PCI Interface is a helper driver that allows other
+	  drivers to have a common interface with the Hyper-V PCI frontend
+	  driver.
+
+config PCI_TEGRA
+	bool "NVIDIA Tegra PCIe controller"
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on PCI_MSI
+	help
+	  Say Y here if you want support for the PCIe host controller found
+	  on NVIDIA Tegra SoCs.
+
+config PCIE_RCAR_HOST
+	bool "Renesas R-Car PCIe controller (host mode)"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_MSI
+	help
+	  Say Y here if you want PCIe controller support on R-Car SoCs in host
+	  mode.
+
+config PCIE_RCAR_EP
+	bool "Renesas R-Car PCIe controller (endpoint mode)"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	help
+	  Say Y here if you want PCIe controller support on R-Car SoCs in
+	  endpoint mode.
+
+config PCI_RCAR_GEN2
+	bool "Renesas R-Car Gen2 Internal PCI controller"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARM
+	help
+	  Say Y here if you want internal PCI support on R-Car Gen2 SoC.
+	  There are 3 internal PCI controllers available with a single
+	  built-in EHCI/OHCI host controller present on each one.
+
 config PCIE_ROCKCHIP
 	bool
 	depends on PCI
@@ -236,114 +293,57 @@ config PCIE_ROCKCHIP_EP
 	  endpoint mode on Rockchip SoC. There is 1 internal PCIe port
 	  available to support GEN2 with 4 slots.
 
-config PCIE_MEDIATEK
-	tristate "MediaTek PCIe controller"
-	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
+config PCI_V3_SEMI
+	bool "V3 Semiconductor PCI controller"
 	depends on OF
+	depends on ARM || COMPILE_TEST
+	default ARCH_INTEGRATOR_AP
+
+config PCI_XGENE
+	bool "X-Gene PCIe controller"
+	depends on ARM64 || COMPILE_TEST
+	depends on OF || (ACPI && PCI_QUIRKS)
+	help
+	  Say Y here if you want internal PCI support on APM X-Gene SoC.
+	  There are 5 internal PCIe ports available. Each port is GEN3 capable
+	  and have varied lanes from x1 to x8.
+
+config PCI_XGENE_MSI
+	bool "X-Gene v1 PCIe MSI feature"
+	depends on PCI_XGENE
+	depends on PCI_MSI
+	default y
+	help
+	  Say Y here if you want PCIe MSI support for the APM X-Gene v1 SoC.
+	  This MSI driver supports 5 PCIe ports on the APM X-Gene v1 SoC.
+
+config PCIE_XILINX
+	bool "Xilinx AXI PCIe controller"
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI
 	help
-	  Say Y here if you want to enable PCIe controller support on
-	  MediaTek SoCs.
-
-config PCIE_MEDIATEK_GEN3
-	tristate "MediaTek Gen3 PCIe controller"
-	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on PCI_MSI
-	help
-	  Adds support for PCIe Gen3 MAC controller for MediaTek SoCs.
-	  This PCIe controller is compatible with Gen3, Gen2 and Gen1 speed,
-	  and support up to 256 MSI interrupt numbers for
-	  multi-function devices.
-
-	  Say Y here if you want to enable Gen3 PCIe controller support on
-	  MediaTek SoCs.
-
-config VMD
-	depends on PCI_MSI && X86_64 && !UML
-	tristate "Intel Volume Management Device Driver"
-	help
-	  Adds support for the Intel Volume Management Device (VMD). VMD is a
-	  secondary PCI host bridge that allows PCI Express root ports,
-	  and devices attached to them, to be removed from the default
-	  PCI domain and placed within the VMD domain. This provides
-	  more bus resources than are otherwise possible with a
-	  single domain. If you know your system provides one of these and
-	  has devices attached to it, say Y; if you are not sure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called vmd.
-
-config PCIE_BRCMSTB
-	tristate "Broadcom Brcmstb PCIe controller"
-	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
-		   BMIPS_GENERIC || COMPILE_TEST
-	depends on OF
-	depends on PCI_MSI
-	default ARCH_BRCMSTB || BMIPS_GENERIC
-	help
-	  Say Y here to enable PCIe host controller support for
-	  Broadcom STB based SoCs, like the Raspberry Pi 4.
-
-config PCI_HYPERV_INTERFACE
-	tristate "Microsoft Hyper-V PCI Interface"
-	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
-	help
-	  The Hyper-V PCI Interface is a helper driver that allows other
-	  drivers to have a common interface with the Hyper-V PCI frontend
-	  driver.
-
-config PCI_LOONGSON
-	bool "LOONGSON PCIe controller"
-	depends on MACH_LOONGSON64 || COMPILE_TEST
-	depends on OF || ACPI
-	depends on PCI_QUIRKS
-	default MACH_LOONGSON64
-	help
-	  Say Y here if you want to enable PCI controller support on
-	  Loongson systems.
-
-config PCIE_MICROCHIP_HOST
-	bool "Microchip AXI PCIe controller"
-	depends on PCI_MSI && OF
-	select PCI_HOST_COMMON
-	help
-	  Say Y here if you want kernel to support the Microchip AXI PCIe
+	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
 
-config PCIE_HISI_ERR
-	depends on ACPI_APEI_GHES && (ARM64 || COMPILE_TEST)
-	bool "HiSilicon HIP PCIe controller error handling driver"
-	help
-	  Say Y here if you want error handling support
-	  for the PCIe controller's errors on HiSilicon HIP SoCs
-
-config PCIE_APPLE_MSI_DOORBELL_ADDR
-	hex
-	default 0xfffff000
-	depends on PCIE_APPLE
-
-config PCIE_APPLE
-	tristate "Apple PCIe controller"
-	depends on ARCH_APPLE || COMPILE_TEST
-	depends on OF
+config PCIE_XILINX_NWL
+	bool "Xilinx NWL PCIe controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
 	depends on PCI_MSI
+	help
+	 Say 'Y' here if you want kernel support for Xilinx
+	 NWL PCIe controller. The controller can act as Root Port
+	 or End Point. The current option selection will only
+	 support root port enabling.
+
+config PCIE_XILINX_CPM
+	bool "Xilinx Versal CPM PCI controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
 	select PCI_HOST_COMMON
 	help
-	  Say Y here if you want to enable PCIe controller support on Apple
-	  system-on-chips, like the Apple M1. This is required for the USB
-	  type-A ports, Ethernet, Wi-Fi, and Bluetooth.
-
-	  If unsure, say Y if you have an Apple Silicon system.
-
-config PCIE_MT7621
-	tristate "MediaTek MT7621 PCIe controller"
-	depends on SOC_MT7621 || COMPILE_TEST
-	select PHY_MT7621_PCI
-	default SOC_MT7621
-	help
-	  This selects a driver for the MediaTek MT7621 PCIe Controller.
+	  Say 'Y' here if you want kernel support for the
+	  Xilinx Versal CPM host bridge.
 
+source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
-source "drivers/pci/controller/cadence/Kconfig"
 endmenu
-- 
2.25.1

