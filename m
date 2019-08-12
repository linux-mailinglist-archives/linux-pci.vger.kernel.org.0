Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1EB89AC6
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 12:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfHLKGJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 06:06:09 -0400
Received: from foss.arm.com ([217.140.110.172]:47322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727409AbfHLKGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 06:06:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13F0115A2;
        Mon, 12 Aug 2019 03:06:08 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98CE53F718;
        Mon, 12 Aug 2019 03:06:05 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:06:00 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, shawn.lin@rock-chips.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv3 2/2] PCI: layerscape: Add CONFIG_PCI_LAYERSCAPE_EP to
 build EP/RC separately
Message-ID: <20190812100600.GA20861@e121166-lin.cambridge.arm.com>
References: <20190628013826.4705-1-xiaowei.bao@nxp.com>
 <20190628013826.4705-2-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628013826.4705-2-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 28, 2019 at 09:38:26AM +0800, Xiaowei Bao wrote:
> Add CONFIG_PCI_LAYERSCAPE_EP to build EP/RC separately.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - No change.
> v3:
>  - modify the commit message.
> 
>  drivers/pci/controller/dwc/Kconfig  |   20 ++++++++++++++++++--
>  drivers/pci/controller/dwc/Makefile |    3 ++-
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index a6ce1ee..a41ccf5 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -131,13 +131,29 @@ config PCI_KEYSTONE_EP
>  	  DesignWare core functions to implement the driver.
>  
>  config PCI_LAYERSCAPE
> -	bool "Freescale Layerscape PCIe controller"
> +	bool "Freescale Layerscape PCIe controller - Host mode"
>  	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
>  	depends on PCI_MSI_IRQ_DOMAIN
>  	select MFD_SYSCON
>  	select PCIE_DW_HOST
>  	help
> -	  Say Y here if you want PCIe controller support on Layerscape SoCs.
> +	  Say Y here if you want to enable PCIe controller support on Layerscape
> +	  SoCs to work in Host mode.
> +	  This controller can work either as EP or RC. The RCW[HOST_AGT_PEX]

What's "The RCW" ? This entry should explain why a kernel configuration
should enable it.

Lorenzo

> +	  determines which PCIe controller works in EP mode and which PCIe
> +	  controller works in RC mode.
> +
> +config PCI_LAYERSCAPE_EP
> +	bool "Freescale Layerscape PCIe controller - Endpoint mode"
> +	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
> +	depends on PCI_ENDPOINT
> +	select PCIE_DW_EP
> +	help
> +	  Say Y here if you want to enable PCIe controller support on Layerscape
> +	  SoCs to work in Endpoint mode.
> +	  This controller can work either as EP or RC. The RCW[HOST_AGT_PEX]
> +	  determines which PCIe controller works in EP mode and which PCIe
> +	  controller works in RC mode.
>  
>  config PCI_HISI
>  	depends on OF && (ARM64 || COMPILE_TEST)
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index b085dfd..824fde7 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -8,7 +8,8 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> -obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o pci-layerscape-ep.o
> +obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> +obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> -- 
> 1.7.1
> 
