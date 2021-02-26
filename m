Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B691D32673C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Feb 2021 20:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhBZTJq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Feb 2021 14:09:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhBZTJo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Feb 2021 14:09:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 989AF64F2A;
        Fri, 26 Feb 2021 19:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614366543;
        bh=ZSQ34l1waOTYsT+MmAXk4yDmb+QfPtxxcwpQI7RmsN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQy8Vxcx6b3Q6gY1bxJ7OfbUEck3Ni9ZHrYrdmwpKufrPPniJZl8gXSKkxxJk3d+v
         0mjdMrRlggs2t+nBgHScIbWBFA/vzV55ZzyU02/d2Qsn1+lwIpLEd0N6JIfews3sgr
         /xnMvUf0Gwr390D+mTMTwiLTc5B3pwkaxmwJIE4nNxb3MlZF6eLzzv8Z2uTgW1hgz0
         jBbknx8Kly+AoThftqshe4YzN5/8HQr+3gJh/REeRW/x9qDbWjf3M+sUc3yoIMXaHa
         z7qGuzmv6971ONnsmUrvXeZpNEWLc+OEF3TYcVkjoe3w1f35oE/DXZ+j1/yrphDk2F
         ybeSsYGX6zc7g==
Date:   Fri, 26 Feb 2021 20:08:57 +0100
From:   Robert Richter <rric@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: controller: avoid building empty drivers
Message-ID: <YDlHSYxayqq5WMt0@rric.localdomain>
References: <20210225143727.3912204-1-arnd@kernel.org>
 <20210225143727.3912204-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225143727.3912204-2-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25.02.21 15:37:10, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are harmless warnings when compile testing the kernel with
> CONFIG_TRIM_UNUSED_KSYMS:
> 
> drivers/pci/controller/dwc/pcie-al.o: no symbols
> drivers/pci/controller/pci-thunder-ecam.o: no symbols
> drivers/pci/controller/pci-thunder-pem.o: no symbols
> 
> The problem here is that the host drivers get built even when the
> configuration symbols are all disabled, as they pretend to not be drivers
> but are silently enabled because of the promise that ACPI based systems
> need no drivers.
> 
> Add back the normal symbols to have these drivers built, and change the
> logic to otherwise only build them when both CONFIG_PCI_QUIRKS and
> CONFIG_ACPI are enabled.
> 
> As a side-effect, this enables compile-testing the drivers on other
> architectures, which in turn needs the acpi_get_rc_resources()
> function to be defined.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/pci/controller/Makefile     | 7 ++++++-
>  drivers/pci/controller/dwc/Makefile | 7 ++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
> index e4559f2182f2..6d24a163033f 100644
> --- a/drivers/pci/controller/Makefile
> +++ b/drivers/pci/controller/Makefile
> @@ -11,10 +11,13 @@ obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
>  obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
>  obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
> +obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
> +obj-$(CONFIG_PCI_HOST_THUNDER_PEM) += pci-thunder-pem.o
>  obj-$(CONFIG_PCIE_XILINX) += pcie-xilinx.o
>  obj-$(CONFIG_PCIE_XILINX_NWL) += pcie-xilinx-nwl.o
>  obj-$(CONFIG_PCIE_XILINX_CPM) += pcie-xilinx-cpm.o
>  obj-$(CONFIG_PCI_V3_SEMI) += pci-v3-semi.o
> +obj-$(CONFIG_PCI_XGENE) += pci-xgene.o
>  obj-$(CONFIG_PCI_XGENE_MSI) += pci-xgene-msi.o
>  obj-$(CONFIG_PCI_VERSATILE) += pci-versatile.o
>  obj-$(CONFIG_PCIE_IPROC) += pcie-iproc.o
> @@ -47,8 +50,10 @@ obj-y				+= mobiveil/
>  # ARM64 and use internal ifdefs to only build the pieces we need
>  # depending on whether ACPI, the DT driver, or both are enabled.
>  
> -ifdef CONFIG_PCI
> +ifdef CONFIG_ACPI
> +ifdef CONFIG_PCI_QUIRKS
>  obj-$(CONFIG_ARM64) += pci-thunder-ecam.o
>  obj-$(CONFIG_ARM64) += pci-thunder-pem.o
>  obj-$(CONFIG_ARM64) += pci-xgene.o
>  endif
> +endif

A possible double inclusion isn't really nice here, but it should work
that way.

Also, the menu entry for the driver is in fact only for the OF case,
as it is always included for ACPI even if the option is disabled (and
thus the choice is useless). But this is unrelated to this patch.

Anyway:

Reviewed-by: Robert Richter <rric@kernel.org>

> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index a751553fa0db..ba7c42f6df6f 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -31,7 +31,12 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
>  # ARM64 and use internal ifdefs to only build the pieces we need
>  # depending on whether ACPI, the DT driver, or both are enabled.
>  
> -ifdef CONFIG_PCI
> +obj-$(CONFIG_PCIE_AL) += pcie-al.o
> +obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
> +
> +ifdef CONFIG_ACPI
> +ifdef CONFIG_PCI_QUIRKS
>  obj-$(CONFIG_ARM64) += pcie-al.o
>  obj-$(CONFIG_ARM64) += pcie-hisi.o
>  endif
> +endif
> -- 
> 2.29.2
> 
