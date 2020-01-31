Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC99414F324
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 21:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgAaU10 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 15:27:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:34946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgAaU1Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 15:27:25 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE5C5206D5;
        Fri, 31 Jan 2020 20:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580502444;
        bh=wu8DF6hAx3lxIy1QdD2AOCF3wW69S1Hfe/sW6YzbHfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kTk2nmmseK0tqbrOBVA884axct/OdRJuejU0Wpz1+Vu5MhyOk5WKcNXGZZL8ASWVO
         OmoAq0rdT4TYlv98mU/6Ja8K9VQQIEfhTK4X9CvZPXU+qiC6R7LjxwsbQ4CYyUodqH
         3B1nnhP5+9nxOWNnd+FAhXbpucMUiGBgDVxqMdFI=
Date:   Fri, 31 Jan 2020 14:27:22 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>, "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 16/26] PCI: Ignore PCIBIOS_MIN_MEM
Message-ID: <20200131202722.GA88769@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3d10ec4adea2b91c38c2c53a66632fefc2a6e46.camel@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 06:19:48PM +0000, Sergei Miroshnichenko wrote:
> On Thu, 2020-01-30 at 17:52 -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 29, 2020 at 06:29:27PM +0300, Sergei Miroshnichenko
> > wrote:
> > > BARs and bridge windows are only allowed to be assigned to their
> > > parent bus's bridge windows, going up to the root complex's
> > > resources.
> > > So additional limitations on BAR address are not needed, and the
> > > PCIBIOS_MIN_MEM can be ignored.
> > 
> > This is theoretically true, but I don't think we have reliable
> > information about the host bridge windows in all cases, so
> > PCIBIOS_MIN_MEM/_IO is something of an approximation.
> > 
> > > Besides, the value of PCIBIOS_MIN_MEM reported by the BIOS 1.3 on
> > > Supermicro H11SSL-i via e820__setup_pci_gap():
> > > 
> > >   [mem 0xebff1000-0xfe9fffff] available for PCI devices
> > > 
> > > is only suitable for a single RC out of four:
> > > 
> > >   pci_bus 0000:00: root bus resource [mem 0xec000000-0xefffffff
> > > window]
> > >   pci_bus 0000:20: root bus resource [mem 0xeb800000-0xebefffff
> > > window]
> > >   pci_bus 0000:40: root bus resource [mem 0xeb200000-0xeb5fffff
> > > window]
> > >   pci_bus 0000:60: root bus resource [mem 0xe8b00000-0xeaffffff
> > > window]
> > > 
> > > , which makes the AMD EPYC 7251 unable to boot with this movable
> > > BARs
> > > patchset.
> > 
> > Something's wrong if this system booted before this patch set but not
> > after.  We shouldn't be doing *anything* with the BARs until we need
> > to, i.e., until we hot-add a device where we have to move things to
> > find space for it.
> 
> The one breaking boot on this system initially was 17/26 of this
> patchset: "PCI: hotplug: Ignore the MEM BAR offsets from
> BIOS/bootloader"

I don't think that patch is a good idea.  I think we should read the
current BARs and windows at boot-time and leave them alone unless we
*must* change them.  I don't think we should change things
preemptively to make future hotplug events easier.

> Before it the kernel just took BARs pre-assigned by BIOS. In the same
> time, the same BIOS reports 0xebff1000-0xfe9fffff as available for PCI
> devices, but the real root bridge windows are 0xe8b00000-0xefffffff in
> total (and also 64-bit windows) - which are also reported by the same
> BIOS. So the kernel was only able to handle the 0xec000000-0xefffffff
> root bus.
> 
> With that patch reverted the kernel was able to boot, but unable to
> rescan - to reassign BARs actually.
> 
> > (And we don't want a bisection hole where this system can't boot
> > until
> > this patch is applied, but I assume that's obvious.)
> > 
> > > Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
> > > ---
> > >  drivers/pci/setup-res.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > > index a7d81816d1ea..4043aab021dd 100644
> > > --- a/drivers/pci/setup-res.c
> > > +++ b/drivers/pci/setup-res.c
> > > @@ -246,12 +246,13 @@ static int __pci_assign_resource(struct
> > > pci_bus *bus, struct pci_dev *dev,
> > >  		int resno, resource_size_t size, resource_size_t align)
> > >  {
> > >  	struct resource *res = dev->resource + resno;
> > > -	resource_size_t min;
> > > +	resource_size_t min = 0;
> > >  	int ret;
> > >  	resource_size_t start = (resource_size_t)-1;
> > >  	resource_size_t end = 0;
> > >  
> > > -	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO :
> > > PCIBIOS_MIN_MEM;
> > > +	if (!pci_can_move_bars)
> > > +		min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO :
> > > PCIBIOS_MIN_MEM;
> > 
> > I don't understand the connection here.  PCIBIOS_MIN_MEM and
> > PCIBIOS_MIN_IO are basically ways to say "we can't put PCI resources
> > below this address".
> > 
> > On ACPI systems, the devices in the ACPI namespace are supposed to
> > tell the OS what resources they use, and obviously the OS should not
> > assign those resources to anything else.  If Linux handled all those
> > ACPI resources correctly and in the absence of firmware defects, we
> > shouldn't need PCIBIOS_MIN_MEM/_IO at all.  But neither of those is
> > currently true.
> > 
> > It's true that we should be smarter about PCIBIOS_MIN_MEM/_IO, but I
> > don't think that has anything to do with whether we support *moving*
> > BARs.  We have to avoid the address space that's already in use in
> > *all* cases.
> 
> This is connected to the approach of this feature: releasing,
> recalculating and reassigning the BARs and bridge windows. If movable
> BARs are disabled, this bug doesn't reproduce. And the bug doesn't let
> the system boot when BARs are allowed to move. That's why I've tied
> these together.

My point is just that logically this has nothing to do with movable
BARs.

> This line setting the "min" to PCIBIOS_MIN_* is there untouched since
> the first kernel git commit in 2005 - could it be that all systems are
> just fine now, having their root bridge windows set up correctly?

I don't understand the question, sorry.

> > >  	if (pci_can_move_bars && dev->subordinate && resno >=
> > > PCI_BRIDGE_RESOURCES) {
> > >  		struct pci_bus *child_bus = dev->subordinate;
> > > -- 
> > > 2.24.1
> > > 
