Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA162CB74
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 21:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbiKPUvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 15:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbiKPUvT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 15:51:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C3C64A0E;
        Wed, 16 Nov 2022 12:51:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7AE6CE1C92;
        Wed, 16 Nov 2022 20:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFEFC433C1;
        Wed, 16 Nov 2022 20:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668631870;
        bh=qXGP3+HUll9sYGVoqW9SbxWwprBgMJaK9akTX5TqlWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VEdMInGdltCHg3+XMzCTtLxc+3Pqsvayf/+HV+JoCSxtRlfvsdeHbbMEg44QcNmfK
         thhCbsC1c0Gn7tJTBxNH5vVAAh1DbJoVsNqk/QoxG7ZN7f7PrCBxrUl7IZyUh9slWp
         Z3WQicqGjJIBZpnsLhLNvlE9V0wl43lUrShkd+E4plPpRzws4E8r6KTZ/3CCG2uTHU
         ERpxeT+ruuPw+JHl1fkZhqBFYdGunERaVZklIlMVynaEEEA+rHyUNOoHrAph7HUFW3
         TJ1G3W5RsthcY50UsbQ92jg0P0/Z5487o0znTwke/VjrxBsxhDbxiRHcqXf/johoLl
         /z8l/exoObz+A==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2 2/2] PCI: Allow building CONFIG_OF drivers with COMPILE_TEST
Date:   Wed, 16 Nov 2022 14:51:00 -0600
Message-Id: <20221116205100.1136224-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221116205100.1136224-1-helgaas@kernel.org>
References: <20221116205100.1136224-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Many drivers depend on OF interfaces, so they won't be functional if
CONFIG_OF is not set.  But OF provides stub functions in that case, so make
them buildable if CONFIG_COMPILE_TEST is set.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/Kconfig          | 34 +++++++++++----------
 drivers/pci/controller/cadence/Kconfig  | 12 ++++----
 drivers/pci/controller/dwc/Kconfig      | 40 ++++++++++++++++---------
 drivers/pci/controller/mobiveil/Kconfig |  2 +-
 4 files changed, 51 insertions(+), 37 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index bfd9bac37e24..a62e9fbb69ca 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -8,7 +8,7 @@ config PCI_MVEBU
 	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
 	depends on MVEBU_MBUS
 	depends on ARM
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Marvell EBU PCIe controller. This PCIe controller
@@ -18,7 +18,7 @@ config PCI_MVEBU
 config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_BRIDGE_EMUL
 	help
@@ -38,13 +38,14 @@ config PCIE_XILINX_NWL
 
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	default ARCH_GEMINI
 
 config PCI_IXP4XX
 	bool "Intel IXP4xx PCI controller"
-	depends on ARM && OF
+	depends on ARM
 	depends on ARCH_IXP4XX || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	default ARCH_IXP4XX
 	help
 	  Say Y here if you want support for the PCI host controller found
@@ -89,7 +90,7 @@ config PCI_HOST_COMMON
 
 config PCI_HOST_GENERIC
 	tristate "Generic PCI host controller"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
 	help
@@ -115,7 +116,7 @@ config PCIE_XILINX_CPM
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on (OF || COMPILE_TEST) || (ACPI && PCI_QUIRKS)
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
@@ -132,7 +133,7 @@ config PCI_XGENE_MSI
 
 config PCI_V3_SEMI
 	bool "V3 Semiconductor PCI controller"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on ARM || COMPILE_TEST
 	default ARCH_INTEGRATOR_AP
 
@@ -150,7 +151,7 @@ config PCIE_IPROC
 config PCIE_IPROC_PLATFORM
 	tristate "Broadcom iProc PCIe platform bus driver"
 	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select PCIE_IPROC
 	default ARCH_BCM_IPROC
 	help
@@ -194,7 +195,7 @@ config PCIE_ALTERA_MSI
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on (OF || COMPILE_TEST) || (ACPI && PCI_QUIRKS)
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
@@ -202,7 +203,7 @@ config PCI_HOST_THUNDER_PEM
 config PCI_HOST_THUNDER_ECAM
 	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on (OF || COMPILE_TEST) || (ACPI && PCI_QUIRKS)
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
@@ -214,7 +215,7 @@ config PCIE_ROCKCHIP
 config PCIE_ROCKCHIP_HOST
 	tristate "Rockchip PCIe host controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -226,7 +227,7 @@ config PCIE_ROCKCHIP_HOST
 config PCIE_ROCKCHIP_EP
 	bool "Rockchip PCIe endpoint controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -238,7 +239,7 @@ config PCIE_ROCKCHIP_EP
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -276,7 +277,7 @@ config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
 	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
 		   BMIPS_GENERIC || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
@@ -302,7 +303,8 @@ config PCI_LOONGSON
 
 config PCIE_MICROCHIP_HOST
 	bool "Microchip AXI PCIe host bridge support"
-	depends on PCI_MSI && OF
+	depends on OF || COMPILE_TEST
+	depends on PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 	select GENERIC_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
@@ -325,7 +327,7 @@ config PCIE_APPLE_MSI_DOORBELL_ADDR
 config PCIE_APPLE
 	tristate "Apple PCIe controller"
 	depends on ARCH_APPLE || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
 	help
diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 5d30564190e1..44f18b88817f 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -8,13 +8,13 @@ config PCIE_CADENCE
 
 config PCIE_CADENCE_HOST
 	bool
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select IRQ_DOMAIN
 	select PCIE_CADENCE
 
 config PCIE_CADENCE_EP
 	bool
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
 
@@ -23,7 +23,7 @@ config PCIE_CADENCE_PLAT
 
 config PCIE_CADENCE_PLAT_HOST
 	bool "Cadence PCIe platform host controller"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
 	help
@@ -33,7 +33,7 @@ config PCIE_CADENCE_PLAT_HOST
 
 config PCIE_CADENCE_PLAT_EP
 	bool "Cadence PCIe platform endpoint controller"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
 	select PCIE_CADENCE_PLAT
@@ -47,7 +47,7 @@ config PCI_J721E
 
 config PCI_J721E_HOST
 	bool "TI J721E PCIe platform host controller"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	select PCIE_CADENCE_HOST
 	select PCI_J721E
 	help
@@ -57,7 +57,7 @@ config PCI_J721E_HOST
 
 config PCI_J721E_EP
 	bool "TI J721E PCIe platform endpoint controller"
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
 	select PCI_J721E
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..aa0a2fcd41f1 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -20,7 +20,8 @@ config PCI_DRA7XX
 config PCI_DRA7XX_HOST
 	tristate "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM && TI_PIPE3
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
@@ -36,7 +37,8 @@ config PCI_DRA7XX_HOST
 config PCI_DRA7XX_EP
 	tristate "TI DRA7xx PCIe controller Endpoint Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM && TI_PIPE3
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCI_DRA7XX
@@ -134,7 +136,8 @@ config PCI_KEYSTONE_EP
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller - Host mode"
-	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select MFD_SYSCON
@@ -147,7 +150,8 @@ config PCI_LAYERSCAPE
 
 config PCI_LAYERSCAPE_EP
 	bool "Freescale Layerscape PCIe controller - Endpoint mode"
-	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -158,8 +162,9 @@ config PCI_LAYERSCAPE_EP
 	  controller works in RC mode.
 
 config PCI_HISI
-	depends on OF && (ARM64 || COMPILE_TEST)
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
+	depends on ARM64 || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_HOST_COMMON
@@ -169,7 +174,8 @@ config PCI_HISI
 
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select CRC8
@@ -180,7 +186,8 @@ config PCIE_QCOM
 
 config PCIE_QCOM_EP
 	tristate "Qualcomm PCIe controller - Endpoint mode"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -226,16 +233,17 @@ config PCIE_ROCKCHIP_DW_HOST
 	bool "Rockchip DesignWare PCIe controller"
 	select PCIE_DW
 	select PCIE_DW_HOST
-	depends on PCI_MSI_IRQ_DOMAIN
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
+	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Enables support for the DesignWare PCIe controller in the
 	  Rockchip SoC except RK3399.
 
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
-	depends on OF && (X86 || COMPILE_TEST)
+	depends on X86 || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -273,8 +281,9 @@ config PCIE_KEEMBAY_EP
 	  DesignWare core functions.
 
 config PCIE_KIRIN
-	depends on OF && (ARM64 || COMPILE_TEST)
 	tristate "HiSilicon Kirin series SoCs PCIe controllers"
+	depends on ARM64 || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -345,7 +354,8 @@ config PCIE_VISCONTI_HOST
 config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe host controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -355,7 +365,8 @@ config PCIE_UNIPHIER
 config PCIE_UNIPHIER_EP
 	bool "Socionext UniPhier PCIe endpoint controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -364,7 +375,8 @@ config PCIE_UNIPHIER_EP
 
 config PCIE_AL
 	bool "Amazon Annapurna Labs PCIe controller"
-	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on ARM64 || COMPILE_TEST
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_ECAM
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index e4643fb94e78..24ea35927185 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -14,7 +14,7 @@ config PCIE_MOBIVEIL_HOST
 config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
-	depends on OF
+	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_MOBIVEIL_HOST
 	help
-- 
2.25.1

