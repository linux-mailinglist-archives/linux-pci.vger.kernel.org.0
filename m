Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A2D60D466
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiJYTN4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 15:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232573AbiJYTNv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 15:13:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D607AD57E7;
        Tue, 25 Oct 2022 12:13:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66CD861AF3;
        Tue, 25 Oct 2022 19:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996EEC433D7;
        Tue, 25 Oct 2022 19:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666725229;
        bh=lDtjHINXdOVHEiGbtJUekTFRV0t1UZw87SjDZ44Dw3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nl5xCBURWErm2YeL3mfdtFQ5GmYWVyYuTIb/iFs660W4NbySMubUyMAQ3egDXzHV/
         +oHf1yYuBeZre+kkVXgEMXbPZdn1UErRWrLehTlNdeZjtmoYYwkSm0nA3nsRcXXkcA
         2mlfio9bx92E00QoqNZOygjOs7TNMPBPF6fRlAbJ2F1TJ8r08FueA3elJf1xVV664K
         yoBIp1SuWTbHSpGpL+gonFrbsj+5M9VXtClCiX8WJb/cDmGx2fRV2YiI8j46fJR3Ox
         +nx2tFPeEZHNTJiXNBTdXSnMdFUoDvthX1+T6P6qigL2ynb03/AeeJYQVFBC8Zx7qo
         fSWSr1gS3YXYg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/2] PCI: Drop controller CONFIG_OF dependencies
Date:   Tue, 25 Oct 2022 14:13:39 -0500
Message-Id: <20221025191339.667614-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221025191339.667614-1-helgaas@kernel.org>
References: <20221025191339.667614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Many drivers depend on OF interfaces, so they won't be functional if
CONFIG_OF is not set.  But OF provides stub functions in that case, so drop
the OF dependencies so we can at least compile-test the drivers.

This means we can compile-test the following drivers even without CONFIG_OF
enabled (many still require either CONFIG_COMPILE_TEST or the relevant
arch):

  aardvark
  al
  apple
  brcmstb
  cadence-host
  cadence-platform-host
  cadence-ep
  dra7xx-host
  dra7xx-ep
  dw-rockchip
  ftpci100
  hisi
  intel-gw
  ixp4xx
  j721e-host
  j721e-ep
  kirin
  layerscape-host
  layerscape-ep
  mediatek
  microchip-host
  mobiveil
  mvebu
  qcom-host
  qcom-ep
  rockchip-host
  rockchip-ep
  rockchip-dwc
  pci-host-generic
  uniphier-host
  uniphier-ep
  v3-semi
  xilinx

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/Kconfig          | 15 ++-------------
 drivers/pci/controller/cadence/Kconfig  |  6 ------
 drivers/pci/controller/dwc/Kconfig      | 25 ++++++++++++-------------
 drivers/pci/controller/mobiveil/Kconfig |  1 -
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index bfd9bac37e24..76806dc52d1b 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -8,7 +8,6 @@ config PCI_MVEBU
 	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
 	depends on MVEBU_MBUS
 	depends on ARM
-	depends on OF
 	select PCI_BRIDGE_EMUL
 	help
 	 Add support for Marvell EBU PCIe controller. This PCIe controller
@@ -18,7 +17,6 @@ config PCI_MVEBU
 config PCI_AARDVARK
 	tristate "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_BRIDGE_EMUL
 	help
@@ -38,13 +36,12 @@ config PCIE_XILINX_NWL
 
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
-	depends on OF
 	default ARCH_GEMINI
 
 config PCI_IXP4XX
 	bool "Intel IXP4xx PCI controller"
-	depends on ARM && OF
 	depends on ARCH_IXP4XX || COMPILE_TEST
+	depends on ARM
 	default ARCH_IXP4XX
 	help
 	  Say Y here if you want support for the PCI host controller found
@@ -89,7 +86,6 @@ config PCI_HOST_COMMON
 
 config PCI_HOST_GENERIC
 	tristate "Generic PCI host controller"
-	depends on OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
 	help
@@ -98,7 +94,6 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on OF || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
@@ -132,7 +127,6 @@ config PCI_XGENE_MSI
 
 config PCI_V3_SEMI
 	bool "V3 Semiconductor PCI controller"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	default ARCH_INTEGRATOR_AP
 
@@ -214,7 +208,6 @@ config PCIE_ROCKCHIP
 config PCIE_ROCKCHIP_HOST
 	tristate "Rockchip PCIe host controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -226,7 +219,6 @@ config PCIE_ROCKCHIP_HOST
 config PCIE_ROCKCHIP_EP
 	bool "Rockchip PCIe endpoint controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
 	depends on PCI_ENDPOINT
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -238,7 +230,6 @@ config PCIE_ROCKCHIP_EP
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -276,7 +267,6 @@ config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
 	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
 		   BMIPS_GENERIC || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	help
@@ -302,7 +292,7 @@ config PCI_LOONGSON
 
 config PCIE_MICROCHIP_HOST
 	bool "Microchip AXI PCIe host bridge support"
-	depends on PCI_MSI && OF
+	depends on PCI_MSI
 	select PCI_MSI_IRQ_DOMAIN
 	select GENERIC_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
@@ -325,7 +315,6 @@ config PCIE_APPLE_MSI_DOORBELL_ADDR
 config PCIE_APPLE
 	tristate "Apple PCIe controller"
 	depends on ARCH_APPLE || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_HOST_COMMON
 	help
diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
index 5d30564190e1..cb3b19f801a2 100644
--- a/drivers/pci/controller/cadence/Kconfig
+++ b/drivers/pci/controller/cadence/Kconfig
@@ -8,13 +8,11 @@ config PCIE_CADENCE
 
 config PCIE_CADENCE_HOST
 	bool
-	depends on OF
 	select IRQ_DOMAIN
 	select PCIE_CADENCE
 
 config PCIE_CADENCE_EP
 	bool
-	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
 
@@ -23,7 +21,6 @@ config PCIE_CADENCE_PLAT
 
 config PCIE_CADENCE_PLAT_HOST
 	bool "Cadence PCIe platform host controller"
-	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCIE_CADENCE_PLAT
 	help
@@ -33,7 +30,6 @@ config PCIE_CADENCE_PLAT_HOST
 
 config PCIE_CADENCE_PLAT_EP
 	bool "Cadence PCIe platform endpoint controller"
-	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
 	select PCIE_CADENCE_PLAT
@@ -47,7 +43,6 @@ config PCI_J721E
 
 config PCI_J721E_HOST
 	bool "TI J721E PCIe platform host controller"
-	depends on OF
 	select PCIE_CADENCE_HOST
 	select PCI_J721E
 	help
@@ -57,7 +52,6 @@ config PCI_J721E_HOST
 
 config PCI_J721E_EP
 	bool "TI J721E PCIe platform endpoint controller"
-	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE_EP
 	select PCI_J721E
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..627006ac2cc0 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -20,7 +20,7 @@ config PCI_DRA7XX
 config PCI_DRA7XX_HOST
 	tristate "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on HAS_IOMEM && TI_PIPE3
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
@@ -36,7 +36,7 @@ config PCI_DRA7XX_HOST
 config PCI_DRA7XX_EP
 	tristate "TI DRA7xx PCIe controller Endpoint Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on HAS_IOMEM && TI_PIPE3
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	select PCI_DRA7XX
@@ -134,7 +134,7 @@ config PCI_KEYSTONE_EP
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller - Host mode"
-	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select MFD_SYSCON
@@ -147,7 +147,7 @@ config PCI_LAYERSCAPE
 
 config PCI_LAYERSCAPE_EP
 	bool "Freescale Layerscape PCIe controller - Endpoint mode"
-	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -158,7 +158,7 @@ config PCI_LAYERSCAPE_EP
 	  controller works in RC mode.
 
 config PCI_HISI
-	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on ARM64 || COMPILE_TEST
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
@@ -169,7 +169,7 @@ config PCI_HISI
 
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select CRC8
@@ -180,7 +180,7 @@ config PCIE_QCOM
 
 config PCIE_QCOM_EP
 	tristate "Qualcomm PCIe controller - Endpoint mode"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -228,14 +228,13 @@ config PCIE_ROCKCHIP_DW_HOST
 	select PCIE_DW_HOST
 	depends on PCI_MSI_IRQ_DOMAIN
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
 	help
 	  Enables support for the DesignWare PCIe controller in the
 	  Rockchip SoC except RK3399.
 
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
-	depends on OF && (X86 || COMPILE_TEST)
+	depends on X86 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -273,7 +272,7 @@ config PCIE_KEEMBAY_EP
 	  DesignWare core functions.
 
 config PCIE_KIRIN
-	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on ARM64 || COMPILE_TEST
 	tristate "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
@@ -345,7 +344,7 @@ config PCIE_VISCONTI_HOST
 config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe host controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -355,7 +354,7 @@ config PCIE_UNIPHIER
 config PCIE_UNIPHIER_EP
 	bool "Socionext UniPhier PCIe endpoint controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -364,7 +363,7 @@ config PCIE_UNIPHIER_EP
 
 config PCIE_AL
 	bool "Amazon Annapurna Labs PCIe controller"
-	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on ARM64 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	select PCI_ECAM
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index e4643fb94e78..10f32dd123f6 100644
--- a/drivers/pci/controller/mobiveil/Kconfig
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -14,7 +14,6 @@ config PCIE_MOBIVEIL_HOST
 config PCIE_MOBIVEIL_PLAT
 	bool "Mobiveil AXI PCIe controller"
 	depends on ARCH_ZYNQMP || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_MOBIVEIL_HOST
 	help
-- 
2.25.1

