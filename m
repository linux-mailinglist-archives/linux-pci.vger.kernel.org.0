Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05339155E25
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2020 19:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGSeb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 13:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgBGSeb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 13:34:31 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F1F21741;
        Fri,  7 Feb 2020 18:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581100469;
        bh=libXU65pNP8/1uKtcU86ivD8VEEONROD8d6rJbRNhtA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kkEP5U6AQRLBg1mKRwV4gvGpZbC5zOXcCmN4X/iIeig8nUF6NouhAcCVRCYzJMAmy
         o+zltr9AKrBZufQ+9nt4K0LX9ex3YfPOQujq8UHQTAqPwPTwwLSM0cfQ5bkttz+xn+
         B0Mel13psrJG1bWFZTvzqHeaLj+jXOXXlX+Jix4E=
Date:   Fri, 7 Feb 2020 12:34:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>, bjorn@helgaas.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200207183427.GA40158@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207165141.GA2608843@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 07, 2020 at 05:51:41PM +0100, Thierry Reding wrote:
> On Fri, Feb 07, 2020 at 08:50:01AM -0600, Bjorn Helgaas wrote:
> > On Thu, Feb 06, 2020 at 05:46:39PM +0100, Thierry Reding wrote:
> > > On Thu, Jan 23, 2020 at 10:49:41AM +0000, Lorenzo Pieralisi wrote:
> > > > On Tue, Jan 21, 2020 at 02:44:35PM +0100, Thierry Reding wrote:
> > > > > On Mon, Jan 20, 2020 at 03:18:49PM +0000, Lorenzo Pieralisi wrote:
> > > > > > On Mon, Jan 20, 2020 at 12:10:42PM +0100, Thierry Reding wrote:
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > > > Currently the BSP has the kernel booting through Device
> > > > > > > > > Tree mechanism and there is a plan to support UEFI based
> > > > > > > > > boot as well in the future software releases for which
> > > > > > > > > we need this quirky way of handling ECAM.  Tegra194 is
> > > > > > > > > going to be the only and last chip with this issue and
> > > > > > > > > next chip in line in Tegra SoC series will be fully
> > > > > > > > > compliant with ECAM.
> > > > > > > > 
> > > > > > > > ACPI on ARM64 works on a standard subset of systems,
> > > > > > > > defined by the ARM SBSA:
> > > > > > > > 
> > > > > > > > http://infocenter.arm.com/help/topic/com.arm.doc.den0029c/Server_Base_System_Architecture_v6_0_ARM_DEN_0029C_SBSA_6_0.pdf
> > > > > > > 
> > > > > > > I don't understand what you're saying here. Are you saying
> > > > > > > that you want to prevent vendors from upstreaming code that
> > > > > > > they need to support their ACPI based platforms? I
> > > > > > > understand that the lack of support for proper ECAM means
> > > > > > > that a platform will not be SBSA compatible, but I wasn't
> > > > > > > aware that lack of SBSA compatibility meant that a platform
> > > > > > > would be prohibited from implementing ACPI support in an
> > > > > > > upstream kernel.
> > 
> > "Vendors upstreaming code to support ACPI-based platforms" is a
> > concept that really doesn't fit in the ACPI model.  More below.
> > 
> > > > > > ACPI on ARM64 requires a set of HW components described in the
> > > > > > SBSA.
> > > > > > 
> > > > > > If those HW requirements are not fulfilled you can't bootstrap
> > > > > > an ARM64 system with ACPI - it is as simple as that.
> > > > > 
> > > > > That's an odd statement. We do in fact have an ARM64 system that
> > > > > doesn't fulfill the ECAM requirement and yet it successfully
> > > > > boots with ACPI.
> > > > 
> > > > I know very well (but that's not a reason to break the PCIe
> > > > specification).
> > > > 
> > > > Still, the mistake you are making is thinking that ACPI compliancy
> > > > stops at the MCFG quirk. Adding another quirk to the MCFG list
> > > > will make PCI enumerates but there is more to that, eg MSI/IOMMU
> > > > and that's just an example.
> > > > 
> > > > There are platforms in that MCFG list that eg can't do MSI which
> > > > basically means they are useless - you look at it as yet another
> > > > hook into MCFG, I look at it with history in mind and from an ACPI
> > > > ARM64 maintainership perspective.
> > > > 
> > > > So first thing to do is to post full support for this host
> > > > controller inclusive of MSI/INTx (which AFAICS is another piece of
> > > > HW that is not SBSA compliant since DWC uses a funnel to trigger
> > > > MSIs) and IOMMU, then we will see how to proceed.
> > > > 
> > > > Look at this (and again, that's just an example but AFAICS it
> > > > applies to this host bridge as well):
> > > > 
> > > > https://lore.kernel.org/linux-pci/VE1PR04MB67029FB127DBF4A725CB9698904E0@VE1PR04MB6702.eurprd04.prod.outlook.com
> > > 
> > > So it turns out we indeed have the same issue with MSIs since
> > > Tegra194 uses the same DesignWare controller that others do (looks
> > > like at least HiSilicon and Annapurna Labs are in the same boat).
> > > That said, most drivers fallback to legacy interrupts and that works
> > > fine. Agreed that it isn't ideal, but it's about as good as it's
> > > going to get on this hardware.
> > > 
> > > > > > It is not even appropriate to discuss this on a Linux mailing
> > > > > > list anymore since it is HW requirements and it has been
> > > > > > public information since ACPI on ARM64 was first enabled.
> > > > > 
> > > > > Erm... we're discussing Linux patches. Why would it be
> > > > > inappropriate to discuss them on a Linux mailing list?
> > > > 
> > > > I am not discussing Linux patches at all - I am telling you that
> > > > the DWC host controller is not a) PCIe spec compliant b) SBSA
> > > > compliant and there is nothing to review from a Linux kernel code
> > > > perspective.
> > > > 
> > > > This is just another quirk to enumerate with ACPI a non-compliant
> > > > system, if Bjorn is willing to take it go for it.
> > > 
> > > Yeah, I'd like to hear Bjorn's opinion on this. I understand that
> > > this is far from an ideal situation and I'd much prefer that this
> > > chip was compliant. But for historical reasons it isn't. This chip
> > > was designed before SBSA became the quasi standard. Tegra194 also
> > > isn't a server chip to begin with, so SBSA compliance would likely
> > > not have been the main objective.
> > > 
> > > > > > > > These patches will have to be carried out of tree, the
> > > > > > > > MCFG quirk mechanism (merged as Bjorn said more than three
> > > > > > > > years ago) was supposed to be a temporary plaster to
> > > > > > > > bootstrap server platforms with teething issues, the aim
> > > > > > > > is to remove it eventually not to add more code to it
> > > > > > > > indefinitely.
> > > > > > > 
> > > > > > > Now, I fully agree that quirks are suboptimal and we'd all
> > > > > > > prefer if we didn't have to deal with them. Unfortunately
> > > > > > > the reality is that mistakes happen and hardware doesn't
> > > > > > > always work the way we want it to.  There's plenty of other
> > > > > > > quirk mechanisms in the kernel, and frankly this one isn't
> > > > > > > really that bad in comparison.
> > > > > > 
> > > > > > Because you don't have to maintain it ;) - I think I said what
> > > > > > I had to say about the MCFG mechanism in the past - it has
> > > > > > been three years and counting - it is time to remove it rather
> > > > > > that adding to it.
> > > > > 
> > > > > What makes you think you can simply remove this without breaking
> > > > > support for all of the devices that currently rely on the
> > > > > quirks?
> > > > 
> > > > Don't you think I know ? I said "eventually" for a reason, read
> > > > what I write.
> > > 
> > > I read what you wrote. My point is that even "eventually" things are
> > > going to break if you just rip out the quirks.
> > 
> > I doubt we'll actually remove quirks; I suspect Lorenzo meant that in
> > future hardware we should be removing the *need* for the quirks.  They
> > are annoyances and they do make maintenance more difficult, but in
> > general I don't think we should remove things that are being used.
> 
> I fully agree that we should learn from this and make sure that future
> chips move closer towards SBSA compatibility so that these kinds of
> quirks will not need to be added indefinitely.
> 
> However, there's always going to be transition periods where chips are
> not as compliant as we want them to be. This can be timing related, as
> well as target related. For example, Tegra194 was designed while the
> details of the SBSA were still being worked out, so it can't be expected
> to be fully compliant. At the same time, Tegra194 is not a server chip,
> so even if SBSA had been finalized prior to its design, compliance may
> not have been a consideration.

I don't pay attention to SBSA because I don't work in that space.
But AFAICT Tegra194 and most or all of the other arm64 PCIe host
controllers are not compliant with even PCIe with respect to ECAM.
They all seem to handle config space differently for the root port
than for downstream devices, and I don't think the spec allows that.

> I guess this wouldn't have been much of an issue if circumstances hadn't
> changed in the past few years and users didn't start to want ACPI even
> on non-server systems.
> 
> > > > > > > > So I am afraid but this quirk (and any other coming our
> > > > > > > > way) will not be merged in an upstream kernel anymore -
> > > > > > > > for any queries please put Nvidia in touch.
> > > > > > > 
> > > > > > > Again, I don't understand what you're trying to achieve
> > > > > > > here. You seem to be saying that we categorically can't
> > > > > > > support this hardware because it isn't fully SBSA
> > > > > > > compatible.
> > > > > > 
> > > > > > I am not trying to achieve anything - I am just stating public
> > > > > > information - let me repeat it again for interested readers:
> > > > > > to bootstrap an ARM64 system with ACPI the platform HW design
> > > > > > must follow the SBSA guidelines.
> > > > > 
> > > > > Can you clarify for me where I can find this public information?
> > > > > What I've been able to find suggests that that SBSA-compliant
> > > > > systems would typically run ACPI, but I can't find anything
> > > > > about SBSA compliance being a prerequisite for booting a system
> > > > > with ACPI.
> > > > 
> > > > https://developer.arm.com/architectures/platform-design/server-systems
> > > > 
> > > > Read: SBSA/SBBR
> > > > 
> > > > /Documentation/arm64/arm-acpi.rst
> > > > 
> > > > > I can understand why someone might *wish* for that to always be
> > > > > true, but it seems to be a bit far removed from reality.
> > > > 
> > > > It is reality and it is not a *wish*, Nvidia will comply - even if
> > > > *eventually* we end up merging this code.
> > > 
> > > I already said that we reported these findings to the hardware team
> > > and this is hopefully going to allow us to be SBSA compliant in
> > > future chips. However, it's too late for Tegra194 and we can't
> > > retroactively fix it.
> > > 
> > > > > > > Do you have any alternative suggestions on how we can
> > > > > > > support this in an upstream kernel?
> > > > > > 
> > > > > > Booting with a device tree ?
> > > > > 
> > > > > We can already do that, but should that prevent us from making
> > > > > UEFI and ACPI an alternative boot mechanism?
> > > > 
> > > > Why do you need ACPI support ? What for ?
> > > 
> > > Customers have requested it and they want to be able to use an
> > > upstream kernel.
> > > 
> > > > > > > We realized a while ago that we cannot achieve proper ECAM
> > > > > > > on Tegra194 because of some issues with the hardware and
> > > > > > > we've provided this as feedback to the hardware engineers.
> > > > > > > As a result, the next generation of Tegra should no longer
> > > > > > > suffer from these issues.
> > > > > > 
> > > > > > We will bootstrap next generation Tegra with ACPI then, there
> > > > > > are SBSA tests available for compliancy - again, that's a
> > > > > > matter for Nvidia and Arm to settle, not a mailing list
> > > > > > discussion.
> > > > > 
> > > > > I don't understand why you keep insisting on this. The mailing
> > > > > lists are where kernel patches are discussed, are they not?
> > > > 
> > > > See above.
> > > > 
> > > > > > > As for Tegra194, that chip taped out two years ago and it
> > > > > > > isn't possible to make it fully ECAM compliant other than by
> > > > > > > revising the chip, which, frankly, isn't going to happen.
> > > > > > > 
> > > > > > > So I see two options here: either we find a way of dealing
> > > > > > > with this, by either merging this quirk or finding an
> > > > > > > alternative solution, or we make the decision that some
> > > > > > > hardware just can't be supported.
> > > > > > > 
> > > > > > > The former is fairly common, whereas I've never heard of the
> > > > > > > latter.
> > > > > > 
> > > > > > What does this mean ? Should I wreck the upstream kernel to
> > > > > > make it boot with ACPI on *any* ARM64 platform out there then
> > > > > > ?
> > > > > 
> > > > > Heh... you must have a very low opinion of the upstream kernel
> > > > > if you think merging these 100 lines of code is going to wreck
> > > > > it.
> > > > 
> > > > I have a very high opinion of the upstream kernel and that's why
> > > > as I said above I think in terms of overall ACPI ARM64
> > > > maintainership rather than a platform quirk to get ACPI PCI
> > > > enumeration going.
> > > 
> > > From a maintenance point of view things aren't going to change much
> > > just because we add these additional quirks. These are for the same
> > > IP that's already supported by other quirks for other platforms and
> > > the code lives entirely in the DesignWare driver, so I don't see how
> > > this negatively impacts maintainability of the kernel.
> > > 
> > > > > And if you look at the patch, the bulk (95/109 lines) is
> > > > > actually in the Tegra194 PCIe driver and only 14/109 lines are
> > > > > added to the MCFG quirks.  That's hardly the kind of change
> > > > > that's going to wreck the kernel.
> > > > 
> > > > See above, show us the rest of the story.
> > > 
> > > Like I said, not much we can do about MSI support without more
> > > driver- specific code. But since we can fallback to legacy
> > > interrupts, things end up working fine.
> > > 
> > > Again, I fully realize that this isn't ideal and I'd rather prefer
> > > we didn't have to add this. But I'm also realistic and understand
> > > that hardware designs aren't always perfect, no matter how much we
> > > want them to be. The best we can do is take the lessons learned and
> > > try to make the next chip better.
> > > 
> > > > > > My stance is clear above and the ACPI PCI programming model -
> > > > > > inclusive of firmware - has been there since ACPI was
> > > > > > deployed, if ACPI support is required HW must comply, either
> > > > > > that or it is out of tree patches and I can't be blamed for
> > > > > > that.
> > > > > 
> > > > > Looking at the existing quirks table, there's evidently a number
> > > > > of people that didn't get the memo. The issue seems to be fairly
> > > > > common, yet for some reason you're singling out Tegra194.
> > > > 
> > > > The issue is not very common at all. I said it before and I repeat
> > > > it again: those MCFG quirks were merged more than three years ago
> > > > to help bootstrap ACPI ARM64 ecosystem on early HW and ACPI for
> > > > ARM64 is meant for server (SBSA/SBBR compliant) systems, for other
> > > > platforms DT is the firmware of choice, ACPI on those does not
> > > > work well (and *I* will have to work around it).
> > > 
> > > Like I said, Tegra194 is not a server chip. But it turns out that
> > > people want to use ACPI on non-server systems as well. The website
> > > that you linked to above:
> > > 
> > > 	https://developer.arm.com/architectures/platform-design/server-systems
> > > 
> > > even says that SBSA is being extended to other segments. So, again,
> > > this means that we either have to say, collectively, that we don't
> > > want to support ACPI on ARM64 except on systems that are fully SBSA
> > > compliant or we have to find a way to make things work. I'm not sure
> > > we really want the first option and the quirk is a good compromise
> > > to get us the second option.
> > > 
> > > > I am not singling out anybody, read the mailing lists and you will
> > > > realize. You asked for this patch to be reviewed, I told you what
> > > > my thoughts are and this patch implications - you want to go
> > > > ahead, ask Bjorn to merge it but at least we do it with the
> > > > broader consequences in mind.
> > > 
> > > You seemed to be categorically rejecting this patch only because the
> > > system wasn't fully SBSA compliant. Given that other, non-SBSA
> > > compliant devices are currently supported, it certainly seemed like
> > > you were singling out.
> > > 
> > > Anyway, like you said, it's ultimately up to Bjorn to take this or
> > > not, so it's not productive to go back and forth on this between the
> > > two of us.
> > > 
> > > Perhaps a more productive way to go forward would be to look at what
> > > you had in mind in terms of a deprecation plan for the MCFG quirks.
> > > One idea that came up as we were discussing this internally was to
> > > move the quirk code into the DesignWare driver. That is, instead of
> > > having this code live in the ACPI code and referencing the
> > > DesignWare code, it'd be the DesignWare driver itself that would
> > > initialize PCI. This would have the added benefit that MSIs could be
> > > used, since the DesignWare driver does have the means of decoding
> > > which MSI occurred. The same code that is used to do this when
> > > booting from DT could be reused when booting from ACPI.
> > 
> > I think the idea of moving this code around misses the fundamental
> > point that bringing up a new system with ACPI should require *zero*
> > kernel changes.  It's not a question of where in the kernel quirks
> > live; it's simply that no drivers (DesignWare or other), no quirks,
> > no config changes, no new code at all should be required.
> > 
> > One should be able to take a RHEL/SUSE/Ubuntu/etc CD released years
> > ago and boot it on hardware designed today.  If that CD doesn't boot,
> > the starting assumption is that the OEM needs to fix the hardware or
> > firmware.  This is standard operating procedure in the x86 world, and
> > it's essential if we want to participate in the upstream and distro
> > world.
> 
> But that's impossible. A CD released years ago wouldn't have had any of
> the drivers to enable hardware support for hardware that didn't exist at
> the time.

I'm not talking about new hardware that requires new drivers.  I'm
talking about *booting* and being usable.

It's clearly possible to boot old CDs on new x86 hardware.  Obviously
it won't have support for new endpoints, and it won't have support for
the latest DPC/EDR functionality, but it will at least boot and all
the basic functionality that *was* supported on old hardware will
still work.  In particular, it will enumerate all PCI devices and if
you plug in an old NIC, USB, SATA, etc device, it will work, so you
can bootstrap your way to install new drivers and new kernels.

> I suspect that you may even be able to boot an old kernel on a Tegra194
> with ACPI support and everything that has a standard driver may work.

This conversation is happening because PCI host bridges have a
standard driver ACPI, but Tegra194 *doesn't* work with it, so even if
you plug in an old e100 NIC, it's not going to work because the old
kernel can't enumerate any PCI devices.

> However, there's a lot of hardware for which standard ACPI drivers
> simply don't exist, so there's always going to be code that needs to be
> upstreamed in order to fully make use of new hardware.

Of course.  But we are talking specifically about a PCI host bridge,
which *does* have a standard ACPI driver.  It should work without
upstreaming any new code.
