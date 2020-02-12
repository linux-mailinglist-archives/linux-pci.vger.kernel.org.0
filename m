Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7127C15AAC6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 15:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBLONZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 09:13:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbgBLONZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 09:13:25 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 651A420714;
        Wed, 12 Feb 2020 14:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581516803;
        bh=QyVT0EeUZiuKJNmhr/5ehasumDuQWko+G+LszY7bdr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ssH/IXQzLlrskEEatQbhADtKWxwNNeAatGkq85XYowJYAoJCZE8rp0fDIY3wbE94C
         lH+gVuM9XsRiDSAiO6Y4z+afMZuHoDq0OGNwUtXKwcJEoQO2GWZX3Kr21+ZapljHsw
         U7Adm1VxoV5LopJB5QYHcerskMOJFd/eB0Foq9VE=
Date:   Wed, 12 Feb 2020 08:13:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>, "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 16/26] PCI: Ignore PCIBIOS_MIN_MEM
Message-ID: <20200212141322.GA129877@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e37cfad84e85126c7a16323a1f26e9968ae67650.camel@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 12, 2020 at 12:16:55PM +0000, Sergei Miroshnichenko wrote:
> On Wed, 2020-02-05 at 10:32 -0600, Bjorn Helgaas wrote:
> > On Wed, Feb 05, 2020 at 01:04:06PM +0000, Sergei Miroshnichenko
> > wrote:
> > > On Fri, 2020-01-31 at 14:27 -0600, Bjorn Helgaas wrote:
> > > > On Fri, Jan 31, 2020 at 06:19:48PM +0000, Sergei Miroshnichenko
> > > > wrote:
> > > > > On Thu, 2020-01-30 at 17:52 -0600, Bjorn Helgaas wrote:
> > > > > > On Wed, Jan 29, 2020 at 06:29:27PM +0300, Sergei
> > > > > > Miroshnichenko
> > > > > > wrote:
> > > > > > > BARs and bridge windows are only allowed to be assigned to
> > > > > > > their parent bus's bridge windows, going up to the root
> > > > > > > complex's resources.  So additional limitations on BAR
> > > > > > > address are not needed, and the PCIBIOS_MIN_MEM can be
> > > > > > > ignored.
> > > > > > 
> > > > > > This is theoretically true, but I don't think we have
> > > > > > reliable
> > > > > > information about the host bridge windows in all cases, so
> > > > > > PCIBIOS_MIN_MEM/_IO is something of an approximation.
> > > > > > 
> > > > > > > Besides, the value of PCIBIOS_MIN_MEM reported by the BIOS
> > > > > > > 1.3 on Supermicro H11SSL-i via e820__setup_pci_gap():
> > > > > > > 
> > > > > > >   [mem 0xebff1000-0xfe9fffff] available for PCI devices
> > > > > > > 
> > > > > > > is only suitable for a single RC out of four:
> > > > > > > 
> > > > > > >   pci_bus 0000:00: root bus resource [mem 0xec000000-
> > > > > > > 0xefffffff
> > > > > > > window]
> > > > > > >   pci_bus 0000:20: root bus resource [mem 0xeb800000-
> > > > > > > 0xebefffff
> > > > > > > window]
> > > > > > >   pci_bus 0000:40: root bus resource [mem 0xeb200000-
> > > > > > > 0xeb5fffff
> > > > > > > window]
> > > > > > >   pci_bus 0000:60: root bus resource [mem 0xe8b00000-
> > > > > > > 0xeaffffff
> > > > > > > window]
> > > > > > > 
> > > > > > > , which makes the AMD EPYC 7251 unable to boot with this
> > > > > > > movable BARs patchset.
> > > > > > 
> > > > > > Something's wrong if this system booted before this patch
> > > > > > set but not after.  We shouldn't be doing *anything* with
> > > > > > the BARs until we need to, i.e., until we hot-add a device
> > > > > > where we have to move things to find space for it.
> > > > > 
> > > > > The one breaking boot on this system initially was 17/26 of
> > > > > this patchset: "PCI: hotplug: Ignore the MEM BAR offsets
> > > > > from BIOS/bootloader"
> > > > 
> > > > I don't think that patch is a good idea.  I think we should
> > > > read the current BARs and windows at boot-time and leave them
> > > > alone unless we *must* change them.  I don't think we should
> > > > change things preemptively to make future hotplug events
> > > > easier.
> > > > 
> > > > > Before it the kernel just took BARs pre-assigned by BIOS. In
> > > > > the same time, the same BIOS reports 0xebff1000-0xfe9fffff
> > > > > as available for PCI devices, but the real root bridge
> > > > > windows are 0xe8b00000-0xefffffff in total (and also 64-bit
> > > > > windows) - which are also reported by the same BIOS. So the
> > > > > kernel was only able to handle the 0xec000000- 0xefffffff
> > > > > root bus.
> > > > > 
> > > > > With that patch reverted the kernel was able to boot, but
> > > > > unable to rescan - to reassign BARs actually.
> > > > > 
> > > > > > (And we don't want a bisection hole where this system can't
> > > > > > boot until this patch is applied, but I assume that's
> > > > > > obvious.)
> > > > > > 
> > > > > > > Signed-off-by: Sergei Miroshnichenko <
> > > > > > > s.miroshnichenko@yadro.com>
> > > > > > > ---
> > > > > > >  drivers/pci/setup-res.c | 5 +++--
> > > > > > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-
> > > > > > > res.c
> > > > > > > index a7d81816d1ea..4043aab021dd 100644
> > > > > > > --- a/drivers/pci/setup-res.c
> > > > > > > +++ b/drivers/pci/setup-res.c
> > > > > > > @@ -246,12 +246,13 @@ static int
> > > > > > > __pci_assign_resource(struct
> > > > > > > pci_bus *bus, struct pci_dev *dev,
> > > > > > >  		int resno, resource_size_t size,
> > > > > > > resource_size_t align)
> > > > > > >  {
> > > > > > >  	struct resource *res = dev->resource + resno;
> > > > > > > -	resource_size_t min;
> > > > > > > +	resource_size_t min = 0;
> > > > > > >  	int ret;
> > > > > > >  	resource_size_t start = (resource_size_t)-1;
> > > > > > >  	resource_size_t end = 0;
> > > > > > >  
> > > > > > > -	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO :
> > > > > > > PCIBIOS_MIN_MEM;
> > > > > > > +	if (!pci_can_move_bars)
> > > > > > > +		min = (res->flags & IORESOURCE_IO) ?
> > > > > > > PCIBIOS_MIN_IO :
> > > > > > > PCIBIOS_MIN_MEM;
> > > > > > 
> > > > > > I don't understand the connection here.  PCIBIOS_MIN_MEM and
> > > > > > PCIBIOS_MIN_IO are basically ways to say "we can't put PCI
> > > > > > resources below this address".
> > > > > > 
> > > > > > On ACPI systems, the devices in the ACPI namespace are
> > > > > > supposed to tell the OS what resources they use, and
> > > > > > obviously
> > > > > > the OS should not assign those resources to anything
> > > > > > else.  If
> > > > > > Linux handled all those ACPI resources correctly and in the
> > > > > > absence of firmware defects, we shouldn't need
> > > > > > PCIBIOS_MIN_MEM/_IO at all.  But neither of those is
> > > > > > currently
> > > > > > true.
> > > > > > 
> > > > > > It's true that we should be smarter about
> > > > > > PCIBIOS_MIN_MEM/_IO,
> > > > > > but I don't think that has anything to do with whether we
> > > > > > support *moving* BARs.  We have to avoid the address space
> > > > > > that's already in use in *all* cases.
> > > > > 
> > > > > This is connected to the approach of this feature: releasing,
> > > > > recalculating and reassigning the BARs and bridge windows. If
> > > > > movable BARs are disabled, this bug doesn't reproduce. And the
> > > > > bug doesn't let the system boot when BARs are allowed to move.
> > > > > That's why I've tied these together.
> > > > 
> > > > My point is just that logically this has nothing to do with
> > > > movable BARs.
> > > > 
> > > > > This line setting the "min" to PCIBIOS_MIN_* is there untouched
> > > > > since the first kernel git commit in 2005 - could it be that
> > > > > all
> > > > > systems are just fine now, having their root bridge windows set
> > > > > up correctly?
> > > > 
> > > > I don't understand the question, sorry.
> > > 
> > > I mean, every BAR assigned here can't reside outside of a host
> > > IO/MEM bridge window, which is a bus->resource[n] set up by the
> > > platform code, and their .start fields are seemed to be duplicated
> > > by the PCIBIOS_MIN_* values - from the platform code as well. But
> > > the .start fields are seem to be correct (aren't they?), and the
> > > PCIBIOS_MIN_* values are sometimes definitely not.
> > > 
> > > What can be a reliable test to check if PCIBIOS_MIN_* are safe to
> > > ignore unconditionally? Could it be a separate flag instead of the
> > > pci_can_move_bars here?
> > > 
> > > Would it be fine for a start to ignore the PCIBIOS_MIN_* if it lies
> > > completely outside of host bridge windows? So at least AMD EPYC can
> > > obtain its hotplug power.
> > 
> > PCIBIOS_MIN_* has a long history and it touches every arch, so you'd
> > have to make sure this is safe for all of them.
> 
> Right, I should rework this change and make it x86-specific - the
> only platform where I've encountered this issue (invalid
> PCIBIOS_MIN_MEM from the e820 memory map, preventing hotplug).
> 
> > On x86, PCIBIOS_MIN_MEM is computed from the e820 memory map and
> > is basically a guess because the e820 map is only incidentally
> > related to ACPI device resource usage.  I could imagine making the
> > x86 computation smarter by looking at the PNP0A03/PNP0A08 _CRS
> > information.
> 
> Would it be acceptable to set PCIBIOS_MIN_MEM to zero for x86 in
> arch/x86/include/asm/pci.h ? I've debugged PCs in my possession, and
> I see there every ACPI_RESOURCE_TYPE_ADDRESS* and
> ACPI_RESOURCE_TYPE_FIXED_MEMORY* resource extracted from the ACPI
> are eventually represented in /proc/iomem and /proc/ioports, so the
> kernel can't put device BARs in these reserved address ranges.

I think setting PCIBIOS_MIN_MEM to zero for all of x86 would be too
hard to validate.  On x86, PCIBIOS_MIN_MEM is actually a variable
(pci_mem_start), so you could adjust that as we process host bridge
_CRS methods, e.g., if you find an aperture that starts below
pci_mem_start, update pci_mem_start to the beginning of the aperture.

> > > > > > >  	if (pci_can_move_bars && dev->subordinate && resno >=
> > > > > > > PCI_BRIDGE_RESOURCES) {
> > > > > > >  		struct pci_bus *child_bus = dev->subordinate;
> > > > > > > -- 
> > > > > > > 2.24.1
> > > > > > > 
