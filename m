Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255161E88CD
	for <lists+linux-pci@lfdr.de>; Fri, 29 May 2020 22:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgE2UVj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 May 2020 16:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgE2UVi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 29 May 2020 16:21:38 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EF2D2067B;
        Fri, 29 May 2020 20:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590783697;
        bh=u/xAgf1SoAZEU7/fzVHpgObK98fuyG1PH8KttS3yQzI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0SMY3R16bOLuO6gPIR28Kp1YYk6vVkRuqy/YcDAmT9bL5U+v6lA3QMixwePtm3ioB
         hh7v06dELr89s0AmG42S0RwMRkj4nZY0qOIQ+AcX92WHzvSyTjs/0TmMV9zvGxHPkb
         qYfuzjiRoShC/cHDes+g/gE73NDJSTK1pys4KMhU=
Date:   Fri, 29 May 2020 15:21:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Lost PCIe PME after a914ff2d78ce ("PCI/ASPM: Don't select
 CONFIG_PCIEASPM by default")
Message-ID: <20200529202135.GA461617@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdc33be8-1db6-b147-cbc4-90fa0dc3d999@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Matthew]

On Fri, May 29, 2020 at 10:09:08PM +0200, Heiner Kallweit wrote:
> On 29.05.2020 21:40, Heiner Kallweit wrote:
> > On 29.05.2020 21:21, Bjorn Helgaas wrote:
> >> On Fri, May 29, 2020 at 08:50:46PM +0200, Heiner Kallweit wrote:
> >>> On 28.05.2020 23:44, Heiner Kallweit wrote:
> >>>> For whatever reason with this change (and losing ASPM control) I also
> >>>> loose the PCIe PME interrupts. This prevents my network card from
> >>>> resuming from runtime-suspend.
> >>>> Reverting the change brings back ASPM control and the PCIe PME irq's.
> >>>>
> >>>> Affected system is a Zotac MiniPC with a N3450 CPU:
> >>>> PCI bridge: Intel Corporation Celeron N3350/Pentium N4200/Atom E3900 Series PCI Express Port A #1 (rev fb)
> >>>>
> >>> I checked a little bit further and w/o ASPM control the root ports
> >>> don't have the PME service bit set in their capabilities.
> >>> Not sure whether this is a chipset bug or whether there's a better
> >>> explanation. However more chipsets may have such a behavior.
> >>
> >> Hmm.  Is the difference simply changing the PCIEASPM config symbol, or
> >> are you booting with command-line arguments like "pcie_aspm=off"?
> >>
> > Only difference is the config symbol. My command line is plain and simple:
> > 
> > Command line: initrd=\intel-ucode.img initrd=\initramfs-linux.img root=/dev/sda2 rw
> > 
> >> What's the specific PME bit that changes in the root ports?  Can you
> >> collect the "sudo lspci -vvxxxx" output with and without ASPM?
> >>
> >> The capability bits are generally read-only as far as the PCI spec is
> >> concerned, but devices have implementation-specific knobs that the
> >> BIOS may use to change things.  Without CONFIG_PCIEASPM, Linux will
> >> not request control of LTR, and that could cause the BIOS to change
> >> something.  You should be able to see the LTR control difference in
> >> the dmesg logging about _OSC.
> >>
> >>> W/o the "default y" for ASPM control we also have the situation now
> >>> that the config option description says "When in doubt, say Y."
> >>> but it takes the EXPERT mode to enable it. This seems to be a little
> >>> bit inconsistent.
> >>
> >> We should probably remove the "if EXPERT" from the PCIEASPM kconfig.
> >> But I would expect PME to work correctly regardless of PCIEASPM, so
> >> removing "if EXPERT" doesn't solve the underlying problem.
> >>
> >> Rafael, does this ring any bells for you?  I don't remember a
> >> connection between PME and ASPM, but maybe there is one.
> >>
> >>> To cut a long story short:
> >>> At least on some systems this change has unwanted side effects.
> > 
> > lspci output w/ and w/o ASPM is attached incl. a diff.
> > Here comes the _OSC difference.
> > 
> > w/o ASPM
> > 
> > [    0.386063] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
> > [    0.386918] acpi PNP0A08:00: _OSC: not requesting OS control; OS requires [ExtendedConfig ASPM ClockPM MSI]
> > 
> > w/ ASPM
> > [    0.388141] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> > [    0.393648] acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability LTR]
> > 
> > It's at least interesting that w/o ASPM OS doesn't control PME and AER.
> > 
> 
> This was the right entry point, also w/o ASPM control OS states to ACPI that it
> needs ASPM and ClockPM. The following patch fixes the PME issue for me.
> See also the _OSC part below.
> 
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 9e235c1a7..8df1fa728 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -38,10 +38,15 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PCIEASPM
>  #define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
>  				| OSC_PCI_ASPM_SUPPORT \
>  				| OSC_PCI_CLOCK_PM_SUPPORT \
>  				| OSC_PCI_MSI_SUPPORT)
> +#else
> +#define ACPI_PCIE_REQ_SUPPORT (OSC_PCI_EXT_CONFIG_SUPPORT \
> +				| OSC_PCI_MSI_SUPPORT)
> +#endif

Yeah, that makes sense.  I can't remember the details, but I'm pretty
sure there's a reason why we ask for the whole set of things.  Seems
like it solved some problem.  I think Matthew Garrett might have been
involved in that.
