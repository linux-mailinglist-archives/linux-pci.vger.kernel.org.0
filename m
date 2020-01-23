Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3326B1465FA
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 11:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgAWKtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 05:49:49 -0500
Received: from foss.arm.com ([217.140.110.172]:37642 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgAWKtt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Jan 2020 05:49:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E508A31B;
        Thu, 23 Jan 2020 02:49:47 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E97AC3F6C4;
        Thu, 23 Jan 2020 02:49:45 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:49:41 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vidya Sagar <vidyas@nvidia.com>, bjorn@helgaas.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>, treding@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add MCFG quirks for Tegra194 host controllers
Message-ID: <20200123104941.GA7179@e121166-lin.cambridge.arm.com>
References: <20200103174935.5612-1-vidyas@nvidia.com>
 <CABhMZUUHGEEhsJ-+foSsodqtKXyX5ZNPkGgv_VzXz=Qv+NVcUA@mail.gmail.com>
 <9a767725-9671-6402-4e1c-a648f5a7860b@nvidia.com>
 <20200117121736.GA7072@e121166-lin.cambridge.arm.com>
 <20200120111042.GA203160@ulmo>
 <20200120151849.GA24402@e121166-lin.cambridge.arm.com>
 <20200121134435.GC899558@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121134435.GC899558@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 21, 2020 at 02:44:35PM +0100, Thierry Reding wrote:
> On Mon, Jan 20, 2020 at 03:18:49PM +0000, Lorenzo Pieralisi wrote:
> > On Mon, Jan 20, 2020 at 12:10:42PM +0100, Thierry Reding wrote:
> > 
> > [...]
> > 
> > > > > Currently the BSP has the kernel booting through Device Tree mechanism
> > > > > and there is a plan to support UEFI based boot as well in the future software
> > > > > releases for which we need this quirky way of handling ECAM.
> > > > > Tegra194 is going to be the only and last chip with this issue and next chip
> > > > > in line in Tegra SoC series will be fully compliant with ECAM.
> > > > 
> > > > ACPI on ARM64 works on a standard subset of systems, defined by the
> > > > ARM SBSA:
> > > > 
> > > > http://infocenter.arm.com/help/topic/com.arm.doc.den0029c/Server_Base_System_Architecture_v6_0_ARM_DEN_0029C_SBSA_6_0.pdf
> > > 
> > > I don't understand what you're saying here. Are you saying that you want
> > > to prevent vendors from upstreaming code that they need to support their
> > > ACPI based platforms? I understand that the lack of support for proper
> > > ECAM means that a platform will not be SBSA compatible, but I wasn't
> > > aware that lack of SBSA compatibility meant that a platform would be
> > > prohibited from implementing ACPI support in an upstream kernel.
> > 
> > ACPI on ARM64 requires a set of HW components described in the SBSA.
> > 
> > If those HW requirements are not fulfilled you can't bootstrap an ARM64
> > system with ACPI - it is as simple as that.
> 
> That's an odd statement. We do in fact have an ARM64 system that doesn't
> fulfill the ECAM requirement and yet it successfully boots with ACPI.

I know very well (but that's not a reason to break the PCIe
specification).

Still, the mistake you are making is thinking that ACPI compliancy
stops at the MCFG quirk. Adding another quirk to the MCFG list will make
PCI enumerates but there is more to that, eg MSI/IOMMU and that's
just an example.

There are platforms in that MCFG list that eg can't do MSI which
basically means they are useless - you look at it as yet another hook
into MCFG, I look at it with history in mind and from an ACPI ARM64
maintainership perspective.

So first thing to do is to post full support for this host controller
inclusive of MSI/INTx (which AFAICS is another piece of HW that is
not SBSA compliant since DWC uses a funnel to trigger MSIs) and
IOMMU, then we will see how to proceed.

Look at this (and again, that's just an example but AFAICS it applies to
this host bridge as well):

https://lore.kernel.org/linux-pci/VE1PR04MB67029FB127DBF4A725CB9698904E0@VE1PR04MB6702.eurprd04.prod.outlook.com

> >                                             It is not even appropriate
> > to discuss this on a Linux mailing list anymore since it is HW
> > requirements and it has been public information since ACPI on ARM64 was
> > first enabled.
> 
> Erm... we're discussing Linux patches. Why would it be inappropriate to
> discuss them on a Linux mailing list?

I am not discussing Linux patches at all - I am telling you that the
DWC host controller is not a) PCIe spec compliant b) SBSA compliant
and there is nothing to review from a Linux kernel code perspective.

This is just another quirk to enumerate with ACPI a non-compliant
system, if Bjorn is willing to take it go for it.

> > > > These patches will have to be carried out of tree, the MCFG quirk
> > > > mechanism (merged as Bjorn said more than three years ago) was supposed
> > > > to be a temporary plaster to bootstrap server platforms with teething
> > > > issues, the aim is to remove it eventually not to add more code to it
> > > > indefinitely.
> > > 
> > > Now, I fully agree that quirks are suboptimal and we'd all prefer if we
> > > didn't have to deal with them. Unfortunately the reality is that
> > > mistakes happen and hardware doesn't always work the way we want it to.
> > > There's plenty of other quirk mechanisms in the kernel, and frankly this
> > > one isn't really that bad in comparison.
> > 
> > Because you don't have to maintain it ;) - I think I said what I had to
> > say about the MCFG mechanism in the past - it has been three years
> > and counting - it is time to remove it rather that adding to it.
> 
> What makes you think you can simply remove this without breaking support
> for all of the devices that currently rely on the quirks?

Don't you think I know ? I said "eventually" for a reason, read what
I write.

> > > > So I am afraid but this quirk (and any other coming our way) will not be
> > > > merged in an upstream kernel anymore - for any queries please put Nvidia
> > > > in touch.
> > > 
> > > Again, I don't understand what you're trying to achieve here. You seem
> > > to be saying that we categorically can't support this hardware because
> > > it isn't fully SBSA compatible.
> > 
> > I am not trying to achieve anything - I am just stating public
> > information - let me repeat it again for interested readers: to
> > bootstrap an ARM64 system with ACPI the platform HW design must follow
> > the SBSA guidelines.
> 
> Can you clarify for me where I can find this public information? What
> I've been able to find suggests that that SBSA-compliant systems would
> typically run ACPI, but I can't find anything about SBSA compliance
> being a prerequisite for booting a system with ACPI.

https://developer.arm.com/architectures/platform-design/server-systems

Read: SBSA/SBBR

/Documentation/arm64/arm-acpi.rst

> I can understand why someone might *wish* for that to always be true,
> but it seems to be a bit far removed from reality.

It is reality and it is not a *wish*, Nvidia will comply - even if
*eventually* we end up merging this code.

> > > Do you have any alternative suggestions on how we can support this in an
> > > upstream kernel?
> > 
> > Booting with a device tree ?
> 
> We can already do that, but should that prevent us from making UEFI and
> ACPI an alternative boot mechanism?

Why do you need ACPI support ? What for ?

> > > We realized a while ago that we cannot achieve proper ECAM on Tegra194
> > > because of some issues with the hardware and we've provided this as
> > > feedback to the hardware engineers. As a result, the next generation of
> > > Tegra should no longer suffer from these issues.
> > 
> > We will bootstrap next generation Tegra with ACPI then, there are
> > SBSA tests available for compliancy - again, that's a matter for
> > Nvidia and Arm to settle, not a mailing list discussion.
> 
> I don't understand why you keep insisting on this. The mailing lists are
> where kernel patches are discussed, are they not?

See above.

> > > As for Tegra194, that chip taped out two years ago and it isn't possible
> > > to make it fully ECAM compliant other than by revising the chip, which,
> > > frankly, isn't going to happen.
> > > 
> > > So I see two options here: either we find a way of dealing with this, by
> > > either merging this quirk or finding an alternative solution, or we make
> > > the decision that some hardware just can't be supported.
> > > 
> > > The former is fairly common, whereas I've never heard of the latter.
> > 
> > What does this mean ? Should I wreck the upstream kernel to make it boot
> > with ACPI on *any* ARM64 platform out there then ?
> 
> Heh... you must have a very low opinion of the upstream kernel if you
> think merging these 100 lines of code is going to wreck it.

I have a very high opinion of the upstream kernel and that's why
as I said above I think in terms of overall ACPI ARM64 maintainership
rather than a platform quirk to get ACPI PCI enumeration going.

> And if you look at the patch, the bulk (95/109 lines) is actually in the
> Tegra194 PCIe driver and only 14/109 lines are added to the MCFG quirks.
> That's hardly the kind of change that's going to wreck the kernel.

See above, show us the rest of the story.

> > My stance is clear above and the ACPI PCI programming model - inclusive
> > of firmware - has been there since ACPI was deployed, if ACPI support
> > is required HW must comply, either that or it is out of tree patches
> > and I can't be blamed for that.
> 
> Looking at the existing quirks table, there's evidently a number of
> people that didn't get the memo. The issue seems to be fairly common,
> yet for some reason you're singling out Tegra194.

The issue is not very common at all. I said it before and I repeat it
again: those MCFG quirks were merged more than three years ago to help
bootstrap ACPI ARM64 ecosystem on early HW and ACPI for ARM64 is meant
for server (SBSA/SBBR compliant) systems, for other platforms DT is the
firmware of choice, ACPI on those does not work well (and *I* will have
to work around it).

I am not singling out anybody, read the mailing lists and you will
realize. You asked for this patch to be reviewed, I told you what
my thoughts are and this patch implications - you want to go ahead,
ask Bjorn to merge it but at least we do it with the broader
consequences in mind.

Lorenzo
