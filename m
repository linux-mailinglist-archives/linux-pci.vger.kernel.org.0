Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6485320B63
	for <lists+linux-pci@lfdr.de>; Sun, 21 Feb 2021 16:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhBUPbt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Feb 2021 10:31:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229966AbhBUPbn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 21 Feb 2021 10:31:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AAE8C64EF1;
        Sun, 21 Feb 2021 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613921461;
        bh=V+ea5VI7AFf7MZSJ6myBaIIU0mO2KsDTqal5qxfy7vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5IxCWkRJPqCNfZfYRJvOkfbfhghmV1EH64FRUdUL/1i4HVmUQyvIhH3r6t32cTiJ
         Um6YpXRZ50hdpg+Y46BdJ7tHSUclw+k7lIdrzXtXmZhMa2Fe3SMU1520Phmmk+plEW
         Z8Gj/Dl+VKs1gcvtkljecDJXQJ5dnpYHU/l4QjvlJGjgHVT2moultd6Fob0tlOm+me
         DMllFcTYQkgeZE4lpoPBJCH/KHVlV4DRuCmGA+gImynNMG4a2p5VC/5sruZWnIsHXL
         Vl3H+IEUFhekPsQ3hndQP2vxzKV6lF69eTYwf8DlOFzhBey5op8F4kKVMW2EVAXxiv
         fFcXWWz9kviyw==
Date:   Sun, 21 Feb 2021 17:30:57 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Don Dutile <ddutile@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH mlx5-next v6 1/4] PCI: Add sysfs callback to allow MSI-X
 table size change of SR-IOV VFs
Message-ID: <YDJ8sXRXcvGXVfL/@unreal>
References: <YC90wkwk/CdgcYY6@kroah.com>
 <20210220190600.GA1260870@bjorn-Precision-5520>
 <YDJZeWoLna8kQk5L@kroah.com>
 <YDJmRp5V+TnEQUIV@unreal>
 <YDJ1zOpd6xawfSwo@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDJ1zOpd6xawfSwo@kroah.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 21, 2021 at 04:01:32PM +0100, Greg Kroah-Hartman wrote:
> On Sun, Feb 21, 2021 at 03:55:18PM +0200, Leon Romanovsky wrote:
> > On Sun, Feb 21, 2021 at 02:00:41PM +0100, Greg Kroah-Hartman wrote:
> > > On Sat, Feb 20, 2021 at 01:06:00PM -0600, Bjorn Helgaas wrote:
> > > > On Fri, Feb 19, 2021 at 09:20:18AM +0100, Greg Kroah-Hartman wrote:
> > > >
> > > > > Ok, can you step back and try to explain what problem you are trying to
> > > > > solve first, before getting bogged down in odd details?  I find it
> > > > > highly unlikely that this is something "unique", but I could be wrong as
> > > > > I do not understand what you are wanting to do here at all.
> > > >
> > > > We want to add two new sysfs files:
> > > >
> > > >   sriov_vf_total_msix, for PF devices
> > > >   sriov_vf_msix_count, for VF devices associated with the PF
> > > >
> > > > AFAICT it is *acceptable* if they are both present always.  But it
> > > > would be *ideal* if they were only present when a driver that
> > > > implements the ->sriov_get_vf_total_msix() callback is bound to the
> > > > PF.
> > >
> > > Ok, so in the pci bus probe function, if the driver that successfully
> > > binds to the device is of this type, then create the sysfs files.
> > >
> > > The driver core will properly emit a KOBJ_BIND message when the driver
> > > is bound to the device, so userspace knows it is now safe to rescan the
> > > device to see any new attributes.
> > >
> > > Here's some horrible pseudo-patch for where this probably should be
> > > done:
> > >
> > >
> > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > index ec44a79e951a..5a854a5e3977 100644
> > > --- a/drivers/pci/pci-driver.c
> > > +++ b/drivers/pci/pci-driver.c
> > > @@ -307,8 +307,14 @@ static long local_pci_probe(void *_ddi)
> > >  	pm_runtime_get_sync(dev);
> > >  	pci_dev->driver = pci_drv;
> > >  	rc = pci_drv->probe(pci_dev, ddi->id);
> > > -	if (!rc)
> > > +	if (!rc) {
> > > +		/* If PF or FV driver was bound, let's add some more sysfs files */
> > > +		if (pci_drv->is_pf)
> > > +			device_add_groups(pci_dev->dev, pf_groups);
> > > +		if (pci_drv->is_fv)
> > > +			device_add_groups(pci_dev->dev, fv_groups);
> > >  		return rc;
> > > +	}
> > >  	if (rc < 0) {
> > >  		pci_dev->driver = NULL;
> > >  		pm_runtime_put_sync(dev);
> > >
> > >
> > >
> > >
> > > Add some proper error handling if device_add_groups() fails, and then do
> > > the same thing to remove the sysfs files when the device is unbound from
> > > the driver, and you should be good to go.
> > >
> > > Or is this what you all are talking about already and I'm just totally
> > > confused?
> >
> > There are two different things here. First we need to add sysfs files
> > for VF as the event of PF driver bind, not for the VF binds.
> >
> > In your pseudo code, it will look:
> >   	rc = pci_drv->probe(pci_dev, ddi->id);
> >  -	if (!rc)
> >  +	if (!rc) {
> >  +		/* If PF or FV driver was bound, let's add some more sysfs files */
> >  +		if (pci_drv->is_pf) {
> >  +                      int i = 0;
> >  +			device_add_groups(pci_dev->dev, pf_groups);
> >  +                      for (i; i < pci_dev->totalVF; i++) {
> >  +                              struct pci_device vf_dev = find_vf_device(pci_dev, i);
> >  +
> >  +				device_add_groups(vf_dev->dev, fv_groups);
>
> Hahaha, no.
>
> You are randomly adding new sysfs files to a _DIFFERENT_ device than the
> one that is currently undergoing the probe() call?  That's crazy.  And
> will break userspace.

It is more complex than _DIFFERENT_ device, we are talking about SR-IOV
capable devices and their VFs which are created by connected PF function.

And VF MUST not be probed, we are checking it and protecting this flow.
To summarize: PF must be bound to the driver, VF mustn't.

>
> Why would you want that?  The device should ONLY change when the device
> that controls it has a driver bound/unbound to it, that should NEVER
> cause random other devices on the bus to change state or sysfs files.

Greg, I don't know if you are familiar with SR-IOV concepts which I
explained before, but we are not talking about random devices. The PF device
owns VFs, it is visible in the bus with different symlinks and even PF driver
iterates over those VFs during its probe.

The PF driver is the one who starts and stops those VF devices.

>
> >  +                      }
> >  +              }
> >   		return rc;
> >
> > Second, the code proposed by me does that but with driver callback that
> > PF calls during init/uninit.
>
> That works too, but really, why not just have the pci core do it for
> you?  That way you do not have to go and modify each and every PCI
> driver to get this type of support.  PCI core things belong in the PCI
> core, not in each individual driver.

There are not many drivers which are supporting this specific configuration
flow. It needs to be SR-IOV capable device, with ability to overwrite
specific PCI default through PF device for its VF devices. For now, we
are talking about one device in the market and I can imagine that extra 2-3
vendors in the world will support this flow.

During review, I was requested to create API that controls those sysfs
for specific devices that explicitly acknowledge support.

Greg, please take a look on the cover letter and Documentation.
https://lore.kernel.org/linux-rdma/20210216203726.GH4247@nvidia.com/T/#m899d883c8a10d95959ac0cd2833762f93729b8ef

Thanks

>
> thanks,
>
> greg k-h
