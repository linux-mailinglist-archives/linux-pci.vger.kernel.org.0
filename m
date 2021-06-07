Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A3239EA6A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 01:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhFGXwa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 19:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230330AbhFGXwa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Jun 2021 19:52:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E627B60E0B;
        Mon,  7 Jun 2021 23:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623109838;
        bh=zyZ+p1WGiJIHDLYNnGYHUCtowoPUjC3u0lfCydw2Q20=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Hz2LEFUK4nc9Y6c9I89/J4eO1n21aDGaezWI/ciCsEneH5rvV7nEALDO8GLw6/yiD
         xpe5ESQvkbL2UraF+hibV3FNXCrP99lwNjEgtbn+rhFAIoFvJKjkoHF1l5QrMPbZZv
         bCldXYD+/8KyaYPpP/wKsmMpcfKWWHxDfOQStlT85WcpNuRh6ICDItR67g74L17+nN
         TptdGdAcNGGSE9PFEuVPID8II1CAnfoApb0TKQrCLeDC75/3ITGIR/9QAXckYoN40J
         UwdvBAXtLCD+ekLmJSwnNaZGc3KA4bYGRusyB9PpGVGIP/6cmlshIqfjICyniHq8ZC
         tuLemMltF4VuQ==
Date:   Mon, 7 Jun 2021 18:50:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH V2] PCI: tegra: Fix building Tegra194 PCIe driver
Message-ID: <20210607235036.GA2549845@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a3f39a47-8dff-a4b0-a529-0f17f42114f3@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, May 21, 2021 at 02:11:15PM +0100, Jon Hunter wrote:
> 
> On 20/05/2021 23:19, Bjorn Helgaas wrote:
> > On Thu, May 20, 2021 at 10:01:23AM +0100, Jon Hunter wrote:
> >> Commit 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> >> errata") caused a few build regressions for the Tegra194 PCIe driver
> >> which are:
> >>
> >> 1. The Tegra194 PCIe driver can no longer be built as a module. This
> >>    was caused by removing the Makefile entry to build the pcie-tegra.c
> >>    based upon the CONFIG_PCIE_TEGRA194 option. Therefore, restore this
> >>    so that we can build the driver as a module if ACPI support is not
> >>    enabled in the kernel.
> > 
> > I'm not sure what "if ACPI support is not enabled in the kernel" is
> > telling me.  Does it mean that we can only build tegra194 as a module
> > if ACPI is not enabled?  I don't think so (at least, I don't think
> > Kconfig enforces that).
> 
> If ACPI is enabled, then we will build the driver into the kernel. If we
> have ...
> 
>  CONFIG_ACPI=y
>  CONFIG_PCIE_TEGRA194=m
> 
> FWICS the pcie-tegra194.c driver is builtin to the kernel.

My understanding is that we want pcie-tegra194.c to be:

  - Built into the kernel when CONFIG_PCIE_TEGRA194=m or =y and
    CONFIG_ACPI=y and CONFIG_PCI_QUIRKS=y.  If we're using the ACPI
    pci_root.c driver, we must have the MCFG quirk built-in, and this
    case worked as I expected (this is on x86):

      $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
      CONFIG_ACPI=y
      CONFIG_PCI_QUIRKS=y
      CONFIG_PCIE_TEGRA194=y
      CONFIG_PCIE_TEGRA194_HOST=m
      CONFIG_PCIE_TEGRA194_EP=y

      $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
      $ make drivers/pci/controller/dwc/
	...
	CC      drivers/pci/controller/dwc/pcie-tegra194.o
	AR      drivers/pci/controller/dwc/built-in.a

  - Built as a module when CONFIG_PCIE_TEGRA194=m and CONFIG_ACPI is
    not set.  In this case, we're not using the ACPI pci_root.c
    driver, and we don't need the MCFG quirk built-in, so it should be
    OK to build a module, and IIUC this patch is supposed to *allow*
    that.  But in my testing, it did *not* build a module.  Am I
    missing something?

      $ grep -E "CONFIG_(ACPI\>|PCI_QUIRKS|PCIE_TEGRA194)" .config
      # CONFIG_ACPI is not set
      # CONFIG_PCI_QUIRKS is not set
      CONFIG_PCIE_TEGRA194=y
      CONFIG_PCIE_TEGRA194_HOST=m
      CONFIG_PCIE_TEGRA194_EP=y

      $ rm drivers/pci/controller/dwc/pcie-tegra194.*o
      $ make drivers/pci/controller/dwc/
	...
	CC      drivers/pci/controller/dwc/pcie-tegra194.o
	AR      drivers/pci/controller/dwc/built-in.a

This was all done with V3 of the patch, but I'm responding to V2 to
continue the conversation there since I don't think this part changed.

> 	> Should the "if ACPI support is not enabled ..." part just be dropped?
> > 
> > I assume it should be possible to build the kernel with ACPI enabled
> > and with pcie-tegra194 as a module?
> 
> Per the above that does not appear to be possible.
> 
> >> 2. If CONFIG_PCIE_TEGRA194 is configured to build the driver as a
> >>    module, at the same time that CONFIG_ACPI and CONFIG_PCI_QUIRKS are
> >>    selected to build the driver into the kernel, then the necessary
> >>    functions in the driver to probe and remove the device when booting
> >>    with device-tree and not compiled into to the driver. This prevents
> >>    the PCIe devices being probed when booting with device-tree. Fix this
> >>    by using the IS_ENABLED() macro.
> > 
> > The #ifdef vs IS_ENABLED() difference is kind of subtle and I have to
> > figure it out every time.  Maybe something like this?
> > 
> >   7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM
> >   errata") added "#ifdef CONFIG_PCIE_TEGRA194" around the native
> >   driver.
> > 
> >   But if we set CONFIG_PCIE_TEGRA194=m to build the driver as a
> >   module, autoconf.h contains "#define CONFIG_PCIE_TEGRA194_MODULE 1"
> >   (not "#define CONFIG_PCIE_TEGRA194 1"), so the #ifdef excludes the
> >   driver.
> > 
> >   Instead, use "IS_ENABLED(CONFIG_PCIE_TEGRA194)", which checks for
> >   either CONFIG_PCIE_TEGRA194 or CONFIG_PCIE_TEGRA194_MODULE.
> 
> OK sounds good. Thanks
> 
> >> 3. The below build warnings to be seen with particular kernel
> >>    configurations. Fix these by adding the necessary guards around these
> >>    variable definitions.
> >>
> >>   drivers/pci/controller/dwc/pcie-tegra194.c:259:18: warning:
> >>   	‘event_cntr_data_offset’ defined but not used [-Wunused-const-variable=]
> >>   drivers/pci/controller/dwc/pcie-tegra194.c:250:18: warning:
> >>   	‘event_cntr_ctrl_offset’ defined but not used [-Wunused-const-variable=]
> >>   drivers/pci/controller/dwc/pcie-tegra194.c:243:27: warning:
> >>   	‘pcie_gen_freq’ defined but not used [-Wunused-const-variable=]
> >>
> >> Fixes: 7f100744749e ("PCI: tegra: Add Tegra194 MCFG quirks for ECAM errata")
> >> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > 
> > This is a candidate for v5.13, since we merged 7f100744749e for
> > v5.13-rc1.
> 
> Yes we need to fix for v5.13.
> 
> >> ---
> >>  drivers/pci/controller/dwc/Makefile        | 1 +
> >>  drivers/pci/controller/dwc/pcie-tegra194.c | 6 +++++-
> >>  2 files changed, 6 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> >> index eca805c1a023..f0d1e2d8c022 100644
> >> --- a/drivers/pci/controller/dwc/Makefile
> >> +++ b/drivers/pci/controller/dwc/Makefile
> >> @@ -32,6 +32,7 @@ obj-$(CONFIG_PCIE_UNIPHIER_EP) += pcie-uniphier-ep.o
> >>  # depending on whether ACPI, the DT driver, or both are enabled.
> >>  
> >>  obj-$(CONFIG_PCIE_AL) += pcie-al.o
> >> +obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
> >>  obj-$(CONFIG_PCI_HISI) += pcie-hisi.o
> > 
> > It sounds like the interesting case is this:
> > 
> >   CONFIG_ARM64=y
> >   CONFIG_ACPI=y
> >   CONFIG_PCI_QUIRKS=y
> >   CONFIG_PCIE_TEGRA194=m
> > 
> > I don't know how this works in this case:
> > 
> >   obj-$(CONFIG_PCIE_TEGRA194) += pcie-tegra194.o
> >   obj-$(CONFIG_ARM64) += pcie-tegra194.o
> > 
> > We want tegra194_acpi_init() and the rest of the ECAM quirk to be
> > compiled into the static kernel.  And we want tegra_pcie_dw_probe(),
> > tegra_pcie_dw_remove(), etc, compiled into a module.
> > 
> > Does kbuild really compile pcie-tegra194.c twice?  And if so, it's not
> > a problem that both the static kernel and the module contain a
> > tegra194_pcie_ops symbol?
> 
> FWICT it does not compile it twice and I only see it builtin. We the
> above I don't see any module generated.
> 
> >>  ifdef CONFIG_ACPI
> >> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> index b19775ab134e..ae70e53a7826 100644
> >> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> >> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> >> @@ -240,13 +240,16 @@
> >>  #define EP_STATE_DISABLED	0
> >>  #define EP_STATE_ENABLED	1
> >>  
> >> +#if IS_ENABLED(CONFIG_PCIE_TEGRA194)
> >>  static const unsigned int pcie_gen_freq[] = {
> >>  	GEN1_CORE_CLK_FREQ,
> >>  	GEN2_CORE_CLK_FREQ,
> >>  	GEN3_CORE_CLK_FREQ,
> >>  	GEN4_CORE_CLK_FREQ
> >>  };
> >> +#endif
> > 
> > This makes the minimal patch, but as Krzysztof suggests, I would
> > prefer to move the whole struct so it's just inside the
> > CONFIG_PCIE_TEGRA194 #ifdef.
> 
> OK, will do.
> 
> >> +#if defined(CONFIG_PCIEASPM)
> >>  static const u32 event_cntr_ctrl_offset[] = {
> >>  	0x1d8,
> >>  	0x1a8,
> >> @@ -264,6 +267,7 @@ static const u32 event_cntr_data_offset[] = {
> >>  	0x1c8,
> >>  	0x1dc
> >>  };
> >> +#endif
> > 
> > Similar for the CONFIG_PCIEASPM #ifdef.
> 
> OK.
> 
> Thanks
> Jon
> 
> -- 
> nvpublic
