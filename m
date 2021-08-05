Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA10F3E1614
	for <lists+linux-pci@lfdr.de>; Thu,  5 Aug 2021 15:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbhHENwz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Aug 2021 09:52:55 -0400
Received: from foss.arm.com ([217.140.110.172]:46306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233033AbhHENwz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 09:52:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBCAF31B;
        Thu,  5 Aug 2021 06:52:40 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BB6C3F40C;
        Thu,  5 Aug 2021 06:52:39 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:52:34 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/2] PCI: dwc: Clean up Kconfig dependencies
 (PCIE_DW_HOST)
Message-ID: <20210805135234.GA22410@lpieralisi>
References: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623140103.47818-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 23, 2021 at 05:01:02PM +0300, Andy Shevchenko wrote:
> First of all, the "depends on" is no-op in the selectable options.
> Second, no need to repeat menu dependencies (PCI).

I believe you need to rewrite the commit log in a more descriptive
way - as it is it is not very descriptive.

Define which specific "depends on" you are referring to.

I appreciate the intent and I believe the patch is sound.

> Clean up the users of PCIE_DW_HOST and introduce idiom
> 
> 	depends on PCI_MSI_IRQ_DOMAIN
> 	select PCIE_DW_HOST
> 
> for all of them.

"All of them" ? We need something more explicit for this log
to be useful, it took me a while to understand the end result
you are achieving.

Thanks,
Lorenzo

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pci/controller/dwc/Kconfig | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 423d35872ce4..9bfd41eadd5e 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -8,7 +8,6 @@ config PCIE_DW
>  
>  config PCIE_DW_HOST
>  	bool
> -	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW
>  
>  config PCIE_DW_EP
> @@ -22,8 +21,8 @@ config PCI_DRA7XX
>  config PCI_DRA7XX_HOST
>  	bool "TI DRA7xx PCIe controller Host Mode"
>  	depends on SOC_DRA7XX || COMPILE_TEST
> -	depends on PCI_MSI_IRQ_DOMAIN
>  	depends on OF && HAS_IOMEM && TI_PIPE3
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCI_DRA7XX
>  	default y if SOC_DRA7XX
> @@ -55,7 +54,7 @@ config PCIE_DW_PLAT
>  
>  config PCIE_DW_PLAT_HOST
>  	bool "Platform bus based DesignWare PCIe Controller - Host mode"
> -	depends on PCI && PCI_MSI_IRQ_DOMAIN
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	select PCIE_DW_PLAT
>  	help
> @@ -138,8 +137,8 @@ config PCI_LAYERSCAPE
>  	bool "Freescale Layerscape PCIe controller - Host mode"
>  	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
> -	select MFD_SYSCON
>  	select PCIE_DW_HOST
> +	select MFD_SYSCON
>  	help
>  	  Say Y here if you want to enable PCIe controller support on Layerscape
>  	  SoCs to work in Host mode.
> @@ -244,8 +243,8 @@ config PCIE_HISI_STB
>  
>  config PCI_MESON
>  	tristate "MESON PCIe controller"
> -	depends on PCI_MSI_IRQ_DOMAIN
>  	default m if ARCH_MESON
> +	depends on PCI_MSI_IRQ_DOMAIN
>  	select PCIE_DW_HOST
>  	help
>  	  Say Y here if you want to enable PCI controller support on Amlogic
> -- 
> 2.30.2
> 
