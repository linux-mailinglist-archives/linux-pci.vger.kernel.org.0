Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CE83A1AC9
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 18:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFIQUj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 12:20:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhFIQUj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 9 Jun 2021 12:20:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 373A7611AE;
        Wed,  9 Jun 2021 16:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623255524;
        bh=BjlU8gKXTImqvRzch3ZWrjTYIXyugwh0tiubtJ5SERM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=boFY8IEhHmjVbyy+tyVmRztkDek345WwZplLGeUTDJbMLi7gCg2iIPatcrkAWJ6xM
         6ng6LicV91wilpfij4xgl3HFpkHEsrDwhZkqDBI4B1BUWX3KHRAUSPeaAh4Zi5zPst
         JGW7JD5FHorWCpGX7Ngz4Ea6HLt4KGXBXi878eKIBjYR4anD74vTjdR4Y1bQzzf+QO
         7XV1cfiNzta7Dk/C6Q11CPKspxIbr7NynsZGHW6lX3tEkjSZigqAxI+G+Gi62D9/r0
         gQnNy47Ltvv1hScP8266UokfXmsVQU5tOVdLNBK0HElG7cHcIhHndHusbS82LzQv+P
         ntE0oI8q3gSag==
Date:   Wed, 9 Jun 2021 11:18:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <20210609161842.GA2641672@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <303946c4-29a1-4f5b-6a4c-be451ece20fe@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 09:11:27PM +0100, Jon Hunter wrote:
> On 08/06/2021 19:34, Vidya Sagar wrote:
> 
> ...
> 
> >>> What is the purpose of PCIE_TEGRA194_EP (added by c57247f940e8 ("PCI:
> >>> tegra: Add support for PCIe endpoint mode in Tegra194") [1])?  I don't
> >>> see any reference to it in a makefile or a source file.
> >>>
> >>> It looks like one can build a single driver that works in either host
> >>> or endpoint mode, depending on whether a DT node matches
> >>> "nvidia,tegra194-pcie" or "nvidia,tegra194-pcie-ep".
> >>>
> >>> So I think PCIE_TEGRA194_EP is superfluous and should be removed and
> >>> you should have a single tristate Kconfig option.
> >>
> >> This is a good point.
> >>
> >> Sagar, any reason for this?
> > Although it is the same driver that works for both HOST mode and EP
> > mode, PCIE_TEGRA194_EP depends on PCI_ENDPOINT whereas the
> > PCIE_TEGRA194_HOST mode doesn't. Similarly the PCIE_TEGRA194_HOST mode
> > depends on PCI_MSI_IRQ_DOMAIN which PCIE_TEGRA194_EP doesn't depend on.
> > It is possible to have end point mode support disabled (at sub-system
> > level) in the system yet pcie-tegra194 can be compiled for the host mode
> > vice-a-versa for the endpoint mode.
> > Hence, appropriate config HOST/EP needs to be selected to make sure that
> > the rest of the dependencies are enabled in the system.
> > Hope I'm able to give the rationale correctly here.
> 
> Yes but should we combine them like this ...
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 423d35872ce4..206455a9b70d 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -254,15 +254,12 @@ config PCI_MESON
>           implement the driver.
>  
>  config PCIE_TEGRA194
> -       tristate
> -
> -config PCIE_TEGRA194_HOST
> -       tristate "NVIDIA Tegra194 (and later) PCIe controller - Host Mode"
> +       tristate "NVIDIA Tegra194 (and later) PCIe controller"
>         depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> -       depends on PCI_MSI_IRQ_DOMAIN
> -       select PCIE_DW_HOST
> +       depends on PCI_MSI_IRQ_DOMAIN || PCI_ENDPOINT
> +       select PCIE_DW_HOST if PCI_MSI_IRQ_DOMAIN
> +       select PCIE_DW_EP if PCI_ENDPOINT
>         select PHY_TEGRA194_P2U
> -       select PCIE_TEGRA194
>         help
>           Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
>           work in host mode. There are two instances of PCIe controllers in
> @@ -271,21 +268,6 @@ config PCIE_TEGRA194_HOST
>           in order to enable device-specific features PCIE_TEGRA194_EP must be
>           selected. This uses the DesignWare core.
>  
> -config PCIE_TEGRA194_EP
> -       tristate "NVIDIA Tegra194 (and later) PCIe controller - Endpoint Mode"
> -       depends on ARCH_TEGRA_194_SOC || COMPILE_TEST
> -       depends on PCI_ENDPOINT
> -       select PCIE_DW_EP
> -       select PHY_TEGRA194_P2U
> -       select PCIE_TEGRA194
> -       help
> -         Enables support for the PCIe controller in the NVIDIA Tegra194 SoC to
> -         work in endpoint mode. There are two instances of PCIe controllers in
> -         Tegra194. This controller can work either as EP or RC. In order to
> -         enable host-specific features PCIE_TEGRA194_HOST must be selected and
> -         in order to enable device-specific features PCIE_TEGRA194_EP must be
> -         selected. This uses the DesignWare core.

I'm not a Kconfig expert, but I really like that solution, as long as
it addresses Vidya's concerns about RP/EP dependencies.

Looks like the Kconfig help text should be updated to remove the
other PCIE_TEGRA194_EP reference?  Maybe it should include a clue
about how the connections to host/endpoint support, e.g., "includes
endpoint support if PCI_ENDPOINT is enabled"?

> Furthermore, I wonder if we should just move the code
> that is required for ACPI into it's own file like
> drivers/pci/controller/dwc/pcie-tegra194-acpi.c?

That might simplify things.  I think the reason we started with things
in one file is because for some drivers there's a lot of shared stuff
(#defines, register accessors) between the quirk and the native host
driver.  Either you have to put it all in one file, or you have to add
a shared .h file and make some of that stuff non-static.

Bjorn
