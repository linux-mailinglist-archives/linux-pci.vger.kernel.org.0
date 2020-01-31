Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 727FB14F2DF
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 20:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgAaTj1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 14:39:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgAaTj1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 14:39:27 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1739620707;
        Fri, 31 Jan 2020 19:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580499566;
        bh=r+qqVhg9BDTcP+D9jMAQm2PBy4mkfc00hx8LOCNYJdw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=yVwM9Y5okN4jrt2ahdjwtmqOAlNyLi4PPZyY1148exKvm+thE+nAtsqa0Q0zRRpnl
         1oFxt5SUt/L/isbaK+ovJeblvamcE9Go/GlVnNCgbMGjpmrPCq1Xb/UOIAHlLd115Y
         1rgHZUF/iGM5Xfg1B/cjcJCuv+y3OB7730ka+UMk=
Date:   Fri, 31 Jan 2020 13:39:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 20/26] PNP: Don't reserve BARs for PCI when enabled
 movable BARs
Message-ID: <20200131193924.GA57721@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d744d743a8a2512ebcd31818cdc76400cfd0086e.camel@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 31, 2020 at 03:48:48PM +0000, Sergei Miroshnichenko wrote:
> Hello Bjorn,
> 
> On Thu, 2020-01-30 at 15:14 -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 29, 2020 at 06:29:31PM +0300, Sergei Miroshnichenko
> > wrote:
> > > When the Movable BARs feature is supported, the PCI subsystem is
> > > able to
> > > distribute existing BARs and allocate the new ones itself, without
> > > need to
> > > reserve gaps by BIOS.
> > > 
> > > CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
> > > ---
> > >  drivers/pnp/system.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/pnp/system.c b/drivers/pnp/system.c
> > > index 6950503741eb..16cd260a609d 100644
> > > --- a/drivers/pnp/system.c
> > > +++ b/drivers/pnp/system.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/device.h>
> > >  #include <linux/init.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/pci.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/ioport.h>
> > >  
> > > @@ -58,6 +59,11 @@ static void reserve_resources_of_dev(struct
> > > pnp_dev *dev)
> > >  	struct resource *res;
> > >  	int i;
> > >  
> > > +#ifdef CONFIG_PCI
> > > +	if (pci_can_move_bars)
> > > +		return;
> > > +#endif
> > 
> > I don't understand this.  The reason this function exists is so we
> > keep track of the resources consumed by PNP devices and we can keep
> > from assigning those resources to other things like PCI devices.
> > 
> > Admittedly we currently only do this for PNP0C01 and PNP0C02 devices,
> > but we really should do it for all PNP devices.
> > 
> > Why does Movable BARs mean that we no longer need this
> > information?  The whole point is that this information is needed
> > *during* PCI resource allocation, so I don't understand the idea
> > that "because the PCI subsystem is able to distribute existing
> > BARs and allocate the new ones itself", we don't need to know
> > about PNP resources to avoid.
> 
> Oh. I've made this patch in assumption that non-PCI PNP devices should
> not reside in the PCI address space, and PCI PNP devices behave like
> usual PCI devices - with BARs handled by the common PCI subsystem.

I don't think we can rely on that assumption.  I think all we should
assume is that address space described by _CRS of any PNP device is
unavailable for use by other devices (except for bridge windows, of
course).

> Do I understand correctly after digging a bit into drivers/pnp, that
> some of these resources are some kind of "invisible" BARs, which are
> used by drivers, but the PCI subsystem can't "see" them, so that's why
> the PNP reserves them?

ACPI/PNP _CRS is sort of a generalized BAR idea for devices that don't
have a native configuration protocol.  E.g., PCI has config space that
supports both enumeration and resource configuration (BARs).  There
may be other buses that have similar ideas and don't need PNP devices.

Generally, ACPI describes devices that can't be enumerated and
configured via native means.

> In this case I need just to discard this patch and to modify the
> pci_bus_release_root_bridge_resources() added in patch 06/26 - remove
> the pci_bus_for_each_resource(root_bus, r, i) block there, which
> releases such non-BAR resourses. I've just checked that it works, so
> the next version - v8 - of this patchset will be a bit lighter. Thank
> you for pointing that out!
> 
> Best regards,
> Serge
> 
> 
> > >  	for (i = 0; (res = pnp_get_resource(dev, IORESOURCE_IO, i));
> > > i++) {
> > >  		if (res->flags & IORESOURCE_DISABLED)
> > >  			continue;
> > > -- 
> > > 2.24.1
> > > 
