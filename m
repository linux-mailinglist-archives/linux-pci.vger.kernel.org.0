Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5040563D80F
	for <lists+linux-pci@lfdr.de>; Wed, 30 Nov 2022 15:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiK3O3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Nov 2022 09:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiK3O3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Nov 2022 09:29:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14D454B07;
        Wed, 30 Nov 2022 06:29:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A275B81B41;
        Wed, 30 Nov 2022 14:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0582AC433C1;
        Wed, 30 Nov 2022 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669818567;
        bh=RziCBqCUV5tPNAGWyWkSe0uBA5GZb2y9QL8JDIF5ssc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=haVYBk0WDzVB/3EblOyY86oclxQZHdX0/NVD6i8cep0/pv/DEM0J09cA4FRHpbq97
         dSaCu3i27Sn7bqPt9KoFShDihR+L2Y4IdkyDm5lSZO9sKHk9UddGf5VOoOdAS0w51u
         oODTBSejcOJseHTAxQByc9vYw21RMcSIJ+AWManY/oxiZm6wJODqao5Gtsg2AA+Oad
         +6pntq/cTrwMNNOA8IYTlpOgZUCQgkWA+wwZRcZ02MOmU5VD0CydWXkIkti5Cbg8V1
         a27EXF/dDRL/cCVAcXmCWPxr9zN2Ovmgvsy5JOFLdCJVLWN+QxB1cMrqcjrVfyQABG
         fIQD/L5oyB41w==
Date:   Wed, 30 Nov 2022 08:29:25 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 2/2] PCI: Allow building CONFIG_OF drivers with
 COMPILE_TEST
Message-ID: <20221130142925.GA809356@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116205100.1136224-3-helgaas@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jean]

On Wed, Nov 16, 2022 at 02:51:00PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Many drivers depend on OF interfaces, so they won't be functional if
> CONFIG_OF is not set.  But OF provides stub functions in that case, so make
> them buildable if CONFIG_COMPILE_TEST is set.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

After wasting all your time on this, I think this patch is a bad idea
and I should drop it.

Jean pointed out at [1] that after 0166dc11be91 ("of: make CONFIG_OF
user selectable"), we can enable CONFIG_OF on any architecture
regardless of whether it *needs* OF, and doing so yields better
compile testing than simply using COMPILE_TEST to build without
CONFIG_OF.

Thank you very much, Jean, for pointing this out!

[1] https://lore.kernel.org/r/20221124142441.3a230524@endymion.delvare

> ---
>  drivers/pci/controller/Kconfig          | 34 +++++++++++----------
>  drivers/pci/controller/cadence/Kconfig  | 12 ++++----
>  drivers/pci/controller/dwc/Kconfig      | 40 ++++++++++++++++---------
>  drivers/pci/controller/mobiveil/Kconfig |  2 +-
>  4 files changed, 51 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index bfd9bac37e24..a62e9fbb69ca 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -8,7 +8,7 @@ config PCI_MVEBU
>  	depends on ARCH_MVEBU || ARCH_DOVE || COMPILE_TEST
>  	depends on MVEBU_MBUS
>  	depends on ARM
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select PCI_BRIDGE_EMUL
>  	help
>  	 Add support for Marvell EBU PCIe controller. This PCIe controller
> @@ -18,7 +18,7 @@ config PCI_MVEBU
>  config PCI_AARDVARK
>  	tristate "Aardvark PCIe controller"
>  	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCI_BRIDGE_EMUL
>  	help
> @@ -38,13 +38,14 @@ config PCIE_XILINX_NWL
>  
>  config PCI_FTPCI100
>  	bool "Faraday Technology FTPCI100 PCI controller"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	default ARCH_GEMINI
>  
>  config PCI_IXP4XX
>  	bool "Intel IXP4xx PCI controller"
> -	depends on ARM && OF
> +	depends on ARM
>  	depends on ARCH_IXP4XX || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	default ARCH_IXP4XX
>  	help
>  	  Say Y here if you want support for the PCI host controller found
> @@ -89,7 +90,7 @@ config PCI_HOST_COMMON
>  
>  config PCI_HOST_GENERIC
>  	tristate "Generic PCI host controller"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select PCI_HOST_COMMON
>  	select IRQ_DOMAIN
>  	help
> @@ -115,7 +116,7 @@ config PCIE_XILINX_CPM
>  config PCI_XGENE
>  	bool "X-Gene PCIe controller"
>  	depends on ARM64 || COMPILE_TEST
> -	depends on OF || (ACPI && PCI_QUIRKS)
> +	depends on (OF || COMPILE_TEST) || (ACPI && PCI_QUIRKS)
>  	help
>  	  Say Y here if you want internal PCI support on APM X-Gene SoC.
>  	  There are 5 internal PCIe ports available. Each port is GEN3 capable
> @@ -132,7 +133,7 @@ config PCI_XGENE_MSI
>  
>  config PCI_V3_SEMI
>  	bool "V3 Semiconductor PCI controller"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on ARM || COMPILE_TEST
>  	default ARCH_INTEGRATOR_AP
>  
> @@ -150,7 +151,7 @@ config PCIE_IPROC
>  config PCIE_IPROC_PLATFORM
>  	tristate "Broadcom iProc PCIe platform bus driver"
>  	depends on ARCH_BCM_IPROC || (ARM && COMPILE_TEST)
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select PCIE_IPROC
>  	default ARCH_BCM_IPROC
>  	help
> @@ -194,7 +195,7 @@ config PCIE_ALTERA_MSI
>  config PCI_HOST_THUNDER_PEM
>  	bool "Cavium Thunder PCIe controller to off-chip devices"
>  	depends on ARM64 || COMPILE_TEST
> -	depends on OF || (ACPI && PCI_QUIRKS)
> +	depends on (OF || COMPILE_TEST) || (ACPI && PCI_QUIRKS)
>  	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want PCIe support for CN88XX Cavium Thunder SoCs.
> @@ -202,7 +203,7 @@ config PCI_HOST_THUNDER_PEM
>  config PCI_HOST_THUNDER_ECAM
>  	bool "Cavium Thunder ECAM controller to on-chip devices on pass-1.x silicon"
>  	depends on ARM64 || COMPILE_TEST
> -	depends on OF || (ACPI && PCI_QUIRKS)
> +	depends on (OF || COMPILE_TEST) || (ACPI && PCI_QUIRKS)
>  	select PCI_HOST_COMMON
>  	help
>  	  Say Y here if you want ECAM support for CN88XX-Pass-1.x Cavium Thunder SoCs.
> @@ -214,7 +215,7 @@ config PCIE_ROCKCHIP
>  config PCIE_ROCKCHIP_HOST
>  	tristate "Rockchip PCIe host controller"
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select MFD_SYSCON
>  	select PCIE_ROCKCHIP
> @@ -226,7 +227,7 @@ config PCIE_ROCKCHIP_HOST
>  config PCIE_ROCKCHIP_EP
>  	bool "Rockchip PCIe endpoint controller"
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select MFD_SYSCON
>  	select PCIE_ROCKCHIP
> @@ -238,7 +239,7 @@ config PCIE_ROCKCHIP_EP
>  config PCIE_MEDIATEK
>  	tristate "MediaTek PCIe controller"
>  	depends on ARCH_AIROHA || ARCH_MEDIATEK || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	help
>  	  Say Y here if you want to enable PCIe controller support on
> @@ -276,7 +277,7 @@ config PCIE_BRCMSTB
>  	tristate "Broadcom Brcmstb PCIe host controller"
>  	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCMBCA || \
>  		   BMIPS_GENERIC || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	default ARCH_BRCMSTB || BMIPS_GENERIC
>  	help
> @@ -302,7 +303,8 @@ config PCI_LOONGSON
>  
>  config PCIE_MICROCHIP_HOST
>  	bool "Microchip AXI PCIe host bridge support"
> -	depends on PCI_MSI && OF
> +	depends on OF || COMPILE_TEST
> +	depends on PCI_MSI
>  	select PCI_MSI_IRQ_DOMAIN
>  	select GENERIC_MSI_IRQ_DOMAIN
>  	select PCI_HOST_COMMON
> @@ -325,7 +327,7 @@ config PCIE_APPLE_MSI_DOORBELL_ADDR
>  config PCIE_APPLE
>  	tristate "Apple PCIe controller"
>  	depends on ARCH_APPLE || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCI_HOST_COMMON
>  	help
> diff --git a/drivers/pci/controller/cadence/Kconfig b/drivers/pci/controller/cadence/Kconfig
> index 5d30564190e1..44f18b88817f 100644
> --- a/drivers/pci/controller/cadence/Kconfig
> +++ b/drivers/pci/controller/cadence/Kconfig
> @@ -8,13 +8,13 @@ config PCIE_CADENCE
>  
>  config PCIE_CADENCE_HOST
>  	bool
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select IRQ_DOMAIN
>  	select PCIE_CADENCE
>  
>  config PCIE_CADENCE_EP
>  	bool
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_CADENCE
>  
> @@ -23,7 +23,7 @@ config PCIE_CADENCE_PLAT
>  
>  config PCIE_CADENCE_PLAT_HOST
>  	bool "Cadence PCIe platform host controller"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select PCIE_CADENCE_HOST
>  	select PCIE_CADENCE_PLAT
>  	help
> @@ -33,7 +33,7 @@ config PCIE_CADENCE_PLAT_HOST
>  
>  config PCIE_CADENCE_PLAT_EP
>  	bool "Cadence PCIe platform endpoint controller"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_CADENCE_EP
>  	select PCIE_CADENCE_PLAT
> @@ -47,7 +47,7 @@ config PCI_J721E
>  
>  config PCI_J721E_HOST
>  	bool "TI J721E PCIe platform host controller"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	select PCIE_CADENCE_HOST
>  	select PCI_J721E
>  	help
> @@ -57,7 +57,7 @@ config PCI_J721E_HOST
>  
>  config PCI_J721E_EP
>  	bool "TI J721E PCIe platform endpoint controller"
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_CADENCE_EP
>  	select PCI_J721E
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 62ce3abf0f19..aa0a2fcd41f1 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -20,7 +20,8 @@ config PCI_DRA7XX
>  config PCI_DRA7XX_HOST
>  	tristate "TI DRA7xx PCIe controller Host Mode"
>  	depends on SOC_DRA7XX || COMPILE_TEST
> -	depends on OF && HAS_IOMEM && TI_PIPE3
> +	depends on OF || COMPILE_TEST
> +	depends on HAS_IOMEM && TI_PIPE3
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCI_DRA7XX
> @@ -36,7 +37,8 @@ config PCI_DRA7XX_HOST
>  config PCI_DRA7XX_EP
>  	tristate "TI DRA7xx PCIe controller Endpoint Mode"
>  	depends on SOC_DRA7XX || COMPILE_TEST
> -	depends on OF && HAS_IOMEM && TI_PIPE3
> +	depends on OF || COMPILE_TEST
> +	depends on HAS_IOMEM && TI_PIPE3
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	select PCI_DRA7XX
> @@ -134,7 +136,8 @@ config PCI_KEYSTONE_EP
>  
>  config PCI_LAYERSCAPE
>  	bool "Freescale Layerscape PCIe controller - Host mode"
> -	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
> +	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select MFD_SYSCON
> @@ -147,7 +150,8 @@ config PCI_LAYERSCAPE
>  
>  config PCI_LAYERSCAPE_EP
>  	bool "Freescale Layerscape PCIe controller - Endpoint mode"
> -	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
> +	depends on ARM || ARCH_LAYERSCAPE || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	help
> @@ -158,8 +162,9 @@ config PCI_LAYERSCAPE_EP
>  	  controller works in RC mode.
>  
>  config PCI_HISI
> -	depends on OF && (ARM64 || COMPILE_TEST)
>  	bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCI_HOST_COMMON
> @@ -169,7 +174,8 @@ config PCI_HISI
>  
>  config PCIE_QCOM
>  	bool "Qualcomm PCIe controller"
> -	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select CRC8
> @@ -180,7 +186,8 @@ config PCIE_QCOM
>  
>  config PCIE_QCOM_EP
>  	tristate "Qualcomm PCIe controller - Endpoint mode"
> -	depends on OF && (ARCH_QCOM || COMPILE_TEST)
> +	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	help
> @@ -226,16 +233,17 @@ config PCIE_ROCKCHIP_DW_HOST
>  	bool "Rockchip DesignWare PCIe controller"
>  	select PCIE_DW
>  	select PCIE_DW_HOST
> -	depends on PCI_MSI_IRQ_DOMAIN
>  	depends on ARCH_ROCKCHIP || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	help
>  	  Enables support for the DesignWare PCIe controller in the
>  	  Rockchip SoC except RK3399.
>  
>  config PCIE_INTEL_GW
>  	bool "Intel Gateway PCIe host controller support"
> -	depends on OF && (X86 || COMPILE_TEST)
> +	depends on X86 || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	help
> @@ -273,8 +281,9 @@ config PCIE_KEEMBAY_EP
>  	  DesignWare core functions.
>  
>  config PCIE_KIRIN
> -	depends on OF && (ARM64 || COMPILE_TEST)
>  	tristate "HiSilicon Kirin series SoCs PCIe controllers"
> +	depends on ARM64 || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	help
> @@ -345,7 +354,8 @@ config PCIE_VISCONTI_HOST
>  config PCIE_UNIPHIER
>  	bool "Socionext UniPhier PCIe host controllers"
>  	depends on ARCH_UNIPHIER || COMPILE_TEST
> -	depends on OF && HAS_IOMEM
> +	depends on OF || COMPILE_TEST
> +	depends on HAS_IOMEM
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	help
> @@ -355,7 +365,8 @@ config PCIE_UNIPHIER
>  config PCIE_UNIPHIER_EP
>  	bool "Socionext UniPhier PCIe endpoint controllers"
>  	depends on ARCH_UNIPHIER || COMPILE_TEST
> -	depends on OF && HAS_IOMEM
> +	depends on OF || COMPILE_TEST
> +	depends on HAS_IOMEM
>  	depends on PCI_ENDPOINT
>  	select PCIE_DW_EP
>  	help
> @@ -364,7 +375,8 @@ config PCIE_UNIPHIER_EP
>  
>  config PCIE_AL
>  	bool "Amazon Annapurna Labs PCIe controller"
> -	depends on OF && (ARM64 || COMPILE_TEST)
> +	depends on ARM64 || COMPILE_TEST
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCI_ECAM
> diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
> index e4643fb94e78..24ea35927185 100644
> --- a/drivers/pci/controller/mobiveil/Kconfig
> +++ b/drivers/pci/controller/mobiveil/Kconfig
> @@ -14,7 +14,7 @@ config PCIE_MOBIVEIL_HOST
>  config PCIE_MOBIVEIL_PLAT
>  	bool "Mobiveil AXI PCIe controller"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
> -	depends on OF
> +	depends on OF || COMPILE_TEST
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_MOBIVEIL_HOST
>  	help
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
