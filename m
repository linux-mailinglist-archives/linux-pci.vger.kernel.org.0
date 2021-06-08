Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5FB39F73B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 15:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFHNEB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 09:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232625AbhFHNEB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Jun 2021 09:04:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 816AB611BD;
        Tue,  8 Jun 2021 13:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623157328;
        bh=/qqF3THMqWF32YT8DCQH3cisMf+WDQmTcZbCoIC4nJA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dfkOTPxSgVnmWKuLn9rrdxDZE8MW1APbObkbmcvtGI3A0w9F6BpaSug72HcVNRqea
         SQwTZrW1lFR7NxoRIojleEyWONumrM1MUiW7iYZIBPjI3B9DQ1mApL8PO6SRrvt65n
         l40VsKbYlrMKB9oRHqRlUHHfcASz4aHCyB/G3vGNwq/y1cH7wlsWeO3Gc/OWXJ67+H
         XeE00xP3wmKkZPuOn/pBkohk27wzDbN+rBSaBDGUniVSK30z8RjOmCoehIGHMYVXLh
         e8fedgErpPNakajCFXIfNXXJJXkfrVxy8Qdm1E/9h8HW1s47gg0l3OJdvl95RJdjk5
         vyQqMedBPtg4Q==
Date:   Tue, 8 Jun 2021 08:02:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <20210608130207.GA2597738@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4aecc0f0-692c-026b-f1dd-0a03ccf4312b@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 08, 2021 at 08:44:49AM +0100, Jon Hunter wrote:
> On 08/06/2021 00:50, Bjorn Helgaas wrote:
> 
> ...
> 
> > My understanding is that we want pcie-tegra194.c to be:
> > 
> >   - Built into the kernel when CONFIG_PCIE_TEGRA194=m or =y and
> >     CONFIG_ACPI=y and CONFIG_PCI_QUIRKS=y.  If we're using the ACPI
> >     pci_root.c driver, we must have the MCFG quirk built-in, and this
> >     case worked as I expected (this is on x86):
> > 
> >       $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
> >       CONFIG_ACPI=y
> >       CONFIG_PCI_QUIRKS=y
> >       CONFIG_PCIE_TEGRA194=y
> >       CONFIG_PCIE_TEGRA194_HOST=m
> >       CONFIG_PCIE_TEGRA194_EP=y
> > 
> >       $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
> >       $ make drivers/pci/controller/dwc/
> > 	...
> > 	CC      drivers/pci/controller/dwc/pcie-tegra194.o
> > 	AR      drivers/pci/controller/dwc/built-in.a
> > 
> >   - Built as a module when CONFIG_PCIE_TEGRA194=m and CONFIG_ACPI is
> >     not set.  In this case, we're not using the ACPI pci_root.c
> >     driver, and we don't need the MCFG quirk built-in, so it should be
> >     OK to build a module, and IIUC this patch is supposed to *allow*
> >     that.  But in my testing, it did *not* build a module.  Am I
> >     missing something?
> > 
> >       $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
> >       # CONFIG_ACPI is not set
> >       # CONFIG_PCI_QUIRKS is not set
> >       CONFIG_PCIE_TEGRA194=y
> >       CONFIG_PCIE_TEGRA194_HOST=m
> >       CONFIG_PCIE_TEGRA194_EP=y
> 
> The problem appears to be that you still have CONFIG_PCIE_TEGRA194=y and
> CONFIG_PCIE_TEGRA194_EP=y above. If I have ...

Huh.  I can't set CONFIG_PCIE_TEGRA194 directly; it's only selectable
by PCIE_TEGRA194_HOST and PCIE_TEGRA194_EP.  PCIE_TEGRA194 is
tristate, but apparently kconfig sets it to the most restrictive,
which I guess makes sense.

So I would expect the shared infrastructure to be built-in if either
driver is built-in, but it's somewhat confusing that
CONFIG_PCIE_TEGRA194_HOST=m results in a builtin driver.  If I can set
CONFIG_PCIE_TEGRA194_HOST and CONFIG_PCIE_TEGRA194_EP independently,
it seems like they should *be* independent.

What is the purpose of PCIE_TEGRA194_EP (added by c57247f940e8 ("PCI:
tegra: Add support for PCIe endpoint mode in Tegra194") [1])?  I don't
see any reference to it in a makefile or a source file.

It looks like one can build a single driver that works in either host
or endpoint mode, depending on whether a DT node matches
"nvidia,tegra194-pcie" or "nvidia,tegra194-pcie-ep".

So I think PCIE_TEGRA194_EP is superfluous and should be removed and
you should have a single tristate Kconfig option.

Tangentially related, this cast in tegra_pcie_dw_probe() looks
unnecessary:

  pcie->mode = (enum dw_pcie_device_mode)data->mode;

Looks like it was copied from similar code in dra7xx_pcie_probe(),
artpec6_pcie_probe(), and dw_plat_pcie_probe(), which are all littered
with similar unnecessary casts.  But that should be solved separately
from the Kconfig question.

[1] https://git.kernel.org/linus/c57247f940e8

> $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
> # CONFIG_ACPI is not set
> CONFIG_PCI_QUIRKS=y
> CONFIG_PCIE_TEGRA194=m
> CONFIG_PCIE_TEGRA194_HOST=m
> # CONFIG_PCIE_TEGRA194_EP is not set
> 
> 
> > 
> >       $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
> >       $ make drivers/pci/controller/dwc/
> > 	...
> > 	CC      drivers/pci/controller/dwc/pcie-tegra194.o
> > 	AR      drivers/pci/controller/dwc/built-in.a
> 
> Then I see ...
> 
> $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
> $ make drivers/pci/controller/dwc/
>   ...
>   CC [M]  drivers/pci/controller/dwc/pcie-tegra194.o
> 
> Cheers
> Jon
> 
> -- 
> nvpublic
