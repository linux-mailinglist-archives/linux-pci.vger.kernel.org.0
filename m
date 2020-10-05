Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA49284250
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 23:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJEV6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 17:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:44556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgJEV6U (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 17:58:20 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E37C42068E;
        Mon,  5 Oct 2020 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601935099;
        bh=vSfCc3VGzgAkGYGH4VoWVDFDyZnqi7f7RPcG6Siacfk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=x1otGtNCSn1jZhhBtotXZwn666+5wf5LTpsyYNmxaPFx29P0ir562jUirJ2wMKamW
         o2orrHxD+0fUgb0qwNsi/RDEzfJy1kykEueOXin4dek2/aO+K1b3/TwgQSs19opGdd
         SHh/aR/EtLKlQH7vz+TOXGzf1+2JVK+YHCJedMJU=
Date:   Mon, 5 Oct 2020 16:58:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH 1/2] PCI: dwc: armada-8k driver needs OF support
Message-ID: <20201005215817.GA3063223@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201001111729.GA6420@e121166-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 12:17:30PM +0100, Lorenzo Pieralisi wrote:
> On Thu, Oct 01, 2020 at 09:42:43AM +0200, Thomas Petazzoni wrote:
> > Fixes the following build warning when CONFIG_OF is disabled:
> > 
> > drivers/pci/controller/dwc/pcie-armada8k.c:344:34: warning: ‘armada8k_pcie_of_match’ defined but not used [-Wunused-const-variable=]
> >   344 | static const struct of_device_id armada8k_pcie_of_match[] = {
> >       |                                  ^~~~~~~~~~~~~~~~~~~~~~
> > 
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > ---
> >  drivers/pci/controller/dwc/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Merged both patches into pci/dwc, thanks.

Can we do something like the following instead?  Untested other than
building for x86 64-bit.  It's a little bit of a mix of of_match_ptr()
changes, a gpio/consumer.h change, and a bunch of Kconfig changes.  I
didn't bother to sort or split them apart.

Also handy for historians to include the

  $ make W=1 drivers/pci/controller/dwc/pcie-armada8k.o

that generated the warning.


diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index f18c3725ef80..c74581b0e4ec 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -8,13 +8,11 @@ config PCI_MVEBU
 	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
 	depends on MVEBU_MBUS
 	depends on ARM
-	depends on OF
 	select PCI_BRIDGE_EMUL
 
 config PCI_AARDVARK
 	bool "Aardvark PCIe controller"
 	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCI_BRIDGE_EMUL
 	help
@@ -34,7 +32,6 @@ config PCIE_XILINX_NWL
 
 config PCI_FTPCI100
 	bool "Faraday Technology FTPCI100 PCI controller"
-	depends on OF
 	default ARCH_GEMINI
 
 config PCI_TEGRA
@@ -85,7 +82,6 @@ config PCI_HOST_COMMON
 
 config PCI_HOST_GENERIC
 	tristate "Generic PCI host controller"
-	depends on OF
 	select PCI_HOST_COMMON
 	select IRQ_DOMAIN
 	help
@@ -94,7 +90,6 @@ config PCI_HOST_GENERIC
 
 config PCIE_XILINX
 	bool "Xilinx AXI PCIe host bridge support"
-	depends on OF || COMPILE_TEST
 	help
 	  Say 'Y' here if you want kernel to support the Xilinx AXI PCIe
 	  Host Bridge driver.
@@ -110,7 +105,7 @@ config PCIE_XILINX_CPM
 config PCI_XGENE
 	bool "X-Gene PCIe controller"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on ACPI && PCI_QUIRKS
 	help
 	  Say Y here if you want internal PCI support on APM X-Gene SoC.
 	  There are 5 internal PCIe ports available. Each port is GEN3 capable
@@ -127,7 +122,6 @@ config PCI_XGENE_MSI
 
 config PCI_V3_SEMI
 	bool "V3 Semiconductor PCI controller"
-	depends on OF
 	depends on ARM || COMPILE_TEST
 	default ARCH_INTEGRATOR_AP
 
@@ -145,7 +139,6 @@ config PCIE_IPROC
 config PCIE_IPROC_PLATFORM
 	tristate "Broadcom iProc PCIe platform bus driver"
 	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
-	depends on OF
 	select PCIE_IPROC
 	default ARCH_BCM_IPROC
 	help
@@ -189,7 +182,7 @@ config PCIE_ALTERA_MSI
 config PCI_HOST_THUNDER_PEM
 	bool "Cavium Thunder PCIe controller to off-chip devices"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on ACPI && PCI_QUIRKS
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
@@ -197,7 +190,7 @@ config PCI_HOST_THUNDER_PEM
 config PCI_HOST_THUNDER_ECAM
 	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
 	depends on ARM64 || COMPILE_TEST
-	depends on OF || (ACPI && PCI_QUIRKS)
+	depends on ACPI && PCI_QUIRKS
 	select PCI_HOST_COMMON
 	help
 	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
@@ -209,7 +202,6 @@ config PCIE_ROCKCHIP
 config PCIE_ROCKCHIP_HOST
 	tristate "Rockchip PCIe host controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -221,7 +213,6 @@ config PCIE_ROCKCHIP_HOST
 config PCIE_ROCKCHIP_EP
 	bool "Rockchip PCIe endpoint controller"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on OF
 	depends on PCI_ENDPOINT
 	select MFD_SYSCON
 	select PCIE_ROCKCHIP
@@ -233,7 +224,6 @@ config PCIE_ROCKCHIP_EP
 config PCIE_MEDIATEK
 	tristate "MediaTek PCIe controller"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here if you want to enable PCIe controller support on
@@ -241,7 +231,7 @@ config PCIE_MEDIATEK
 
 config PCIE_TANGO_SMP8759
 	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
-	depends on ARCH_TANGO && PCI_MSI && OF
+	depends on ARCH_TANGO && PCI_MSI
 	depends on BROKEN
 	select PCI_HOST_COMMON
 	help
@@ -271,7 +261,6 @@ config VMD
 config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
 	depends on ARCH_BCM2835 || COMPILE_TEST
-	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	help
 	  Say Y here to enable PCIe host controller support for
@@ -287,7 +276,6 @@ config PCI_HYPERV_INTERFACE
 config PCI_LOONGSON
 	bool "LOONGSON PCI Controller"
 	depends on MACH_LOONGSON64 || COMPILE_TEST
-	depends on OF
 	depends on PCI_QUIRKS
 	default MACH_LOONGSON64
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
index 044a3761c44f..ab55cd76680e 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -23,7 +23,7 @@ config PCI_DRA7XX_HOST
 	bool "TI DRA7xx PCIe controller Host Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_HOST
 	select PCI_DRA7XX
 	default y if SOC_DRA7XX
@@ -39,7 +39,7 @@ config PCI_DRA7XX_EP
 	bool "TI DRA7xx PCIe controller Endpoint Mode"
 	depends on SOC_DRA7XX || COMPILE_TEST
 	depends on PCI_ENDPOINT
-	depends on OF && HAS_IOMEM && TI_PIPE3
+	depends on HAS_IOMEM && TI_PIPE3
 	select PCIE_DW_EP
 	select PCI_DRA7XX
 	help
@@ -131,7 +131,7 @@ config PCI_KEYSTONE_EP
 
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller - Host mode"
-	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_DW_HOST
@@ -144,7 +144,7 @@ config PCI_LAYERSCAPE
 
 config PCI_LAYERSCAPE_EP
 	bool "Freescale Layerscape PCIe controller - Endpoint mode"
-	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -155,7 +155,7 @@ config PCI_LAYERSCAPE_EP
 	  controller works in RC mode.
 
 config PCI_HISI
-	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on ARM64 || COMPILE_TEST
 	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
@@ -166,7 +166,7 @@ config PCI_HISI
 
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller"
-	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	depends on ARCH_QCOM || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -210,7 +210,7 @@ config PCIE_ARTPEC6_EP
 
 config PCIE_INTEL_GW
 	bool "Intel Gateway PCIe host controller support"
-	depends on OF && (X86 || COMPILE_TEST)
+	depends on X86 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -220,7 +220,7 @@ config PCIE_INTEL_GW
 	  hardware wrappers.
 
 config PCIE_KIRIN
-	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on ARM64 || COMPILE_TEST
 	bool "HiSilicon Kirin series SoCs PCIe controllers"
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
@@ -282,7 +282,7 @@ config PCIE_TEGRA194_EP
 config PCIE_UNIPHIER
 	bool "Socionext UniPhier PCIe host controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
@@ -292,7 +292,7 @@ config PCIE_UNIPHIER
 config PCIE_UNIPHIER_EP
 	bool "Socionext UniPhier PCIe endpoint controllers"
 	depends on ARCH_UNIPHIER || COMPILE_TEST
-	depends on OF && HAS_IOMEM
+	depends on HAS_IOMEM
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
 	help
@@ -301,7 +301,7 @@ config PCIE_UNIPHIER_EP
 
 config PCIE_AL
 	bool "Amazon Annapurna Labs PCIe controller"
-	depends on OF && (ARM64 || COMPILE_TEST)
+	depends on ARM64 || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
 	help
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 13901f359a41..f02dcbab0041 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -350,7 +350,7 @@ static struct platform_driver armada8k_pcie_driver = {
 	.probe		= armada8k_pcie_probe,
 	.driver = {
 		.name	= "armada8k-pcie",
-		.of_match_table = of_match_ptr(armada8k_pcie_of_match),
+		.of_match_table = armada8k_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 62846562da0b..b2ef8ffde79e 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -303,7 +303,7 @@ static struct platform_driver spear13xx_pcie_driver = {
 	.probe		= spear13xx_pcie_probe,
 	.driver = {
 		.name	= "spear-pcie",
-		.of_match_table = of_match_ptr(spear13xx_pcie_of_match),
+		.of_match_table = spear13xx_pcie_of_match,
 		.suppress_bind_attrs = true,
 	},
 };
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
index a62d247018cf..c6529955bc56 100644
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
@@ -25,7 +24,7 @@ config PCIE_MOBIVEIL_PLAT
 config PCIE_LAYERSCAPE_GEN4
 	bool "Freescale Layerscape PCIe Gen4 controller"
 	depends on PCI
-	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
+	depends on ARM64 || ARCH_LAYERSCAPE
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_MOBIVEIL_HOST
 	help
diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 1559f79e63b6..1c5f2fd47c51 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
index da3cd216da00..9a50698abffd 100644
--- a/drivers/pci/controller/pci-ftpci100.c
+++ b/drivers/pci/controller/pci-ftpci100.c
@@ -566,7 +566,7 @@ static const struct of_device_id faraday_pci_of_match[] = {
 static struct platform_driver faraday_pci_driver = {
 	.driver = {
 		.name = "ftpci100",
-		.of_match_table = of_match_ptr(faraday_pci_of_match),
+		.of_match_table = faraday_pci_of_match,
 		.suppress_bind_attrs = true,
 	},
 	.probe  = faraday_pci_probe,
diff --git a/drivers/pci/controller/pci-v3-semi.c b/drivers/pci/controller/pci-v3-semi.c
index 1f54334f09f7..c91dec10440f 100644
--- a/drivers/pci/controller/pci-v3-semi.c
+++ b/drivers/pci/controller/pci-v3-semi.c
@@ -903,7 +903,7 @@ static const struct of_device_id v3_pci_of_match[] = {
 static struct platform_driver v3_pci_driver = {
 	.driver = {
 		.name = "pci-v3-semi",
-		.of_match_table = of_match_ptr(v3_pci_of_match),
+		.of_match_table = v3_pci_of_match,
 		.suppress_bind_attrs = true,
 	},
 	.probe  = v3_pci_probe,
