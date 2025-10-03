Return-Path: <linux-pci+bounces-37513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93511BB6031
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 08:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182A93C8A90
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 06:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB291E7C18;
	Fri,  3 Oct 2025 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcXDqLjU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66368207A32
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759474648; cv=none; b=sVL2v6vn/91GrcRNofk0pTVPSgXyhxyqOQnpThvRUZkLa11qh1T2a0SXG7VYhuey5alxHIy/dKfJqLchGdJPF7qhl7GZLiVz4h57OV+/JIh9Cdd73DWFOrW3wln2o6uz4uEkDSID5gFyE7DFI7CI+IMYSLLfh7xkyRnkrcV7e8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759474648; c=relaxed/simple;
	bh=fUxhhZuxHTeQZe4n3yRVM24i+AbXQqekFzB2rWLhF2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L45nFJLwwB3vTyrVfx2MhG/vFfdXY1t/K8ADQBqa2vVEfQyhJSo3OxiQn+Lg9KkaP+IXU6YlC6romoH41ZcVYqtd4Ph3Elj1j1JcvcQvKyEqToE515xWrCvsk1mE87j9o8JTFENAKJgKgxqrb1flPMTRm9oNGd2kbR5jUGuDcpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcXDqLjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204BDC19422
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759474648;
	bh=fUxhhZuxHTeQZe4n3yRVM24i+AbXQqekFzB2rWLhF2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WcXDqLjUAxW9aJ8J1Fr7/K93wm4B1CrGjJ7laOtuUBfeXt8K53Wg3C2fG6PzroIP3
	 Xpii+0nDSwPZYQZ58Yj/fOBlVS99CSJPGIc+XWIwrM4dIno1KPu/kcqAJ3WwSz2+n8
	 Pvy96T8v9K/04txVCRlukMRs5Kw95Qh8JO3ITqu3RZj7fjnBxo6/57sU+eQiecFP5m
	 NXSw4AG7Qhsen1/1mOhCRHgitDYTdjBUjRW+j931/kvnTWvAZdlhlZqgGKoWsQC9Ux
	 Czn+L3aTJY6inXqGUufjo0QVyMqga5P/CZPcVjCcT1pqEzkvVLSw/BJ9o9jMbWgeyI
	 kBgeSqZpZnElw==
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63b710f276fso2015338d50.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 23:57:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5OdsulUTKj0IcCpA45p5F4ZxEvicMrxYydC9AdppwIynzIZvrNRbnDbzXe6DZy4Mg+2n3wbL1r74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwCyE9576f5gESKO3R1WoG4wd20iP4rf+AxJC2BMEo2aRYGHZb
	Y2QvULPVM14CzrXtsFzDO9FY6g2STyKvf3bAycRYrFT96hdvq/oiV+mL5HjEEcFX6JF9ZLADvGO
	dcHKWgA4S/G3q/WZpjjJUgWzx3hEGNVx3usjfBt+J+w==
X-Google-Smtp-Source: AGHT+IHAcvp3AV6ZkLWCs8uNryHo9WpMGW+8SQCH8Y4qaZaLXySFnaEYU9GQM7vOpJVsuZv6b9VYGksxjKAhL2y4whg=
X-Received: by 2002:a05:690e:4366:b0:635:4ed0:5713 with SMTP id
 956f58d0204a3-63b9a129d2dmr1544994d50.45.1759474647063; Thu, 02 Oct 2025
 23:57:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org> <2025093023-frantic-sediment-9849@gregkh>
In-Reply-To: <2025093023-frantic-sediment-9849@gregkh>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 2 Oct 2025 23:57:16 -0700
X-Gmail-Original-Message-ID: <CACePvbVs8haJQSNjpfc35GYZB5Bk7svLup4ddJwq40bNz8a8Vw@mail.gmail.com>
X-Gm-Features: AS18NWBb4ItL6LhjsT2yraNTvi_vMn-Xeg0A_iQbOuOlf2zflr2dCdhYxAX4JJ4
Message-ID: <CACePvbVs8haJQSNjpfc35GYZB5Bk7svLup4ddJwq40bNz8a8Vw@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 8:30=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Sep 16, 2025 at 12:45:10AM -0700, Chris Li wrote:
> >  #define pr_fmt(fmt) "PCI liveupdate: " fmt
> > +#define dev_fmt(fmt) "PCI liveupdate: " fmt
>
> Please no.  Use the default dev_ formatting so that people can correct
> track the devices spitting out messages here.

Ack. I received another feedback request to add this private dev_fmt
prefix. I can remove that.

>
> > +#include <linux/types.h>
> >  #include <linux/liveupdate.h>
> > +#include "pci.h"
> >
> >  #define PCI_SUBSYSTEM_NAME "pci"
>
> I still don't know why this is needed, why?

Oh, this is requested by the LUO subsystem registration interface.
Pasha can comment more on the LUO subsystem API design. Each subsystem
will use a name to do the subsystem registration and lookup.

https://lore.kernel.org/linux-mm/20250929010321.3462457-10-pasha.tatashin@s=
oleen.com/

>
> >
> > +static void stack_push_buses(struct list_head *stack, struct list_head=
 *buses)
> > +{
> > +     struct pci_bus *bus;
> > +
> > +     list_for_each_entry(bus, buses, node)
> > +             list_move_tail(&bus->dev.lu.lu_next, stack);
> > +}
> > +
> > +static void liveupdate_add_dev(struct device *dev, struct list_head *h=
ead)
> > +{
> > +     dev_info(dev, "collect liveupdate device: flags %x\n", dev->lu.fl=
ags);
>
> Debugging code can go away please.

I was considering this as part of the standard kernel print out for
dmesg logging purposes, more than debugging. This is only triggered
when a liveupdate device is requested. A very small handful of the PCI
devices will be liveupdate. The same set of devices will expect to be
restored at the new kernel kexec. If the set of devices mismatch, that
is a bug. If it is not in the dmesg, it is very hard to find out the
set of devices was mismatched.

I consider it similar to when booting up the kernel some storage
driver will report founding storage device "/dev/sda" etc. Those are
not debugging prints.

Please let me know if that is not justifiable or there is another
mechanism to do the above logging.

> > +     list_move_tail(&dev->lu.lu_next, head);
> > +}
> > +
> > +static int collect_bus_devices_reverse(struct pci_bus *bus, struct lis=
t_head *head)
> > +{
> > +     struct pci_dev *pdev;
> > +     int count =3D 0;
> > +
> > +     list_for_each_entry_reverse(pdev, &bus->devices, bus_list) {
>
> Why are you allowed to walk the pci bus list here?  Shouldn't there be
> some type of core function to do that?

Core function you mean the device core? This is the PCI liveupdate
core function.

>
> And why in reverse?

Very good question. Reverse is to allow the later created device to
mark the earlier created device as dependent. For example, the VF can
mark the PF as a dependent device.

> > +             if (pdev->dev.lu.flags & LU_BUSMASTER &&  pdev->dev.paren=
t)
> > +                     pdev->dev.parent->lu.flags |=3D LU_BUSMASTER_BRID=
GE;
> > +             if (pdev->dev.lu.flags) {
> > +                     liveupdate_add_dev(&pdev->dev, head);
> > +                     count++;
>
> No locking?

Locking in the parent calling function.

>
> > +             }
> > +     }
> > +     return count;
>
> What prevents this value from changing right after you return it?

The liveupdate device collection is static per prepare() call back.
Each PCI device will need to go through the same set of callbacks:
prepare(), freeze() and after kexec, finish(). It will be a bug if
some device calls freeze() without prepare(). For each liveupdate
session, the number of devices partiticate liveupdate is fixed. e.g.
if a new VM tries to add another GPU device into the liveupdate set
after the prepare stage, it is not allowed. This list of liveupdate
devices will remain fixed during the liveupdate session.

Please see Pasha's LUO V4 patch for more detail of the LUO state and
callback when transitioning the state.
https://lore.kernel.org/linux-mm/20250929010321.3462457-1-pasha.tatashin@so=
leen.com/

> > +}
> > +
> > +static int build_liveupdate_devices(struct list_head *head)
> > +{
> > +     LIST_HEAD(bus_stack);
> > +     int count =3D 0;
> > +
> > +     stack_push_buses(&bus_stack, &pci_root_buses);
> > +
> > +     while (!list_empty(&bus_stack)) {
> > +             struct device *busdev;
> > +             struct pci_bus *bus;
> > +
> > +             busdev =3D list_last_entry(&bus_stack, struct device, lu.=
lu_next);
> > +             bus =3D to_pci_bus(busdev);
> > +             if (!busdev->lu.visited && !list_empty(&bus->children)) {
> > +                     stack_push_buses(&bus_stack, &bus->children);
> > +                     busdev->lu.visited =3D 1;
> > +                     continue;
> > +             }
> > +
> > +             count +=3D collect_bus_devices_reverse(bus, head);
> > +             busdev->lu.visited =3D 0;
> > +             list_del_init(&busdev->lu.lu_next);
> > +     }
> > +     return count;
>
> A comment here about what you are trying to do with walking the list of

This is the postraversal of the PCI bus. Make sure to visit the child
bus before the parent bus, so that the child bus can mark the parent
bus as dependent. e.g. If we want to preserve the bus master bit on a
leaf node PCI device, all the parent bridge up to the root bridge will
need to preserve the bus master bit as well. Otherwise the device will
not be able to DMA if the parent bridge does not have a busmaster.

> devices.  Somehow.  Are you sure that's right?  It feels backwards, and

I am confident this is right. This liveupdate device list collection
is the core value of the LUO/PCI series. This way it only needs to
walk the tree just once. Rather than the two passes, first pass marks
the parent recursively to the root, then the second pass to walk the
tree to collect the bus/device that is marked.

Let me know if you think that is a bug somewhere. This code has been
running in our internal liveupdate kernel for vfio and DMA liveupdate
for over a month now.

> the lack of any locking makes me very nervous.  How is this integrating
> into the normal driver model lists?

It does not integrate in the normal driver model lists. It is a new
list. Because the list needs to be fixed in a liveupdate session, it
is simpler to use a new list than walking the existing driver model
list to find out which device has the liveupdate flags. Because the VM
can add a GPU then remove the GPU before reaching to the kernel
liveupdate kexec, that also impacts the depended device (bridge/PF).
The liveupdate requested devices set is dynamic before prepare().
Creating a new list in prepare() is simpler.

> > +}
> > +
> > +static void cleanup_liveupdate_devices(struct list_head *head)
> > +{
> > +     struct device *d, *n;
> > +
> > +     list_for_each_entry_safe(d, n, head, lu.lu_next) {
> > +             d->lu.flags &=3D ~LU_DEPENDED;
> > +             list_del_init(&d->lu.lu_next);
> > +     }
> > +}
>
> What does "cleanup" mean?

Cleanup means removing the dependent device flags, which is derivative
from the requested PCI devices. The devices are also removed from the
liveupdate device list because it is not in the liveupdate session any
more.

This clean up happens when transition from the "finish" to "normal"
state due to finish(), or from "prepare" to "normal" due to cancel().
>
> > +
> >  static int pci_liveupdate_prepare(void *arg, u64 *data)
> >  {
> > +     LIST_HEAD(requested_devices);
> > +
> >       pr_info("prepare data[%llx]\n", *data);
>
> Addresses written to the kernel log?

Ack, my bad. Will fix that, as point out by Jason as well.
>
> > +
> > +     pci_lock_rescan_remove();
> > +     down_write(&pci_bus_sem);
> > +
> > +     build_liveupdate_devices(&requested_devices);
>
> Ah, you lock here.  Document the heck out of this and put the proper

In this function or in build_liveupdate_devices() as well?

> build macros in there so we know what is going on.

build macros you mean the assert some lock was held that kind of the macro?
Let me know if you have other types of build macros in mind.

>
> > +     cleanup_liveupdate_devices(&requested_devices);
> > +
> > +     up_write(&pci_bus_sem);
>
> Why is it a write?  You aren't modifying the list, are you?

I am modifying the requested_devices list but not the normal PCI
device driver model list. I think I can change to up_read().

>
> > +     pci_unlock_rescan_remove();
> >       return 0;
> >  }
> >
> > diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> > index e8318fd5f6ed537a1b236a3a0f054161d5710abd..0e9ef387182856771d85718=
1d88f376632b46f0d 100644
> > --- a/drivers/pci/pcie/portdrv.c
> > +++ b/drivers/pci/pcie/portdrv.c
> > @@ -304,6 +304,7 @@ static int pcie_device_init(struct pci_dev *pdev, i=
nt service, int irq)
> >       device =3D &pcie->device;
> >       device->bus =3D &pcie_port_bus_type;
> >       device->release =3D release_pcie_device;  /* callback to free pci=
e dev */
> > +     dev_liveupdate_init(device);
>
> Why here?

Because the device is just allocated. I need to initialize the
device->lu.list pointers. Otherwise list debug will complain of NULL
pointers when added to the liveupdate device list.

>
> >       dev_set_name(device, "%s:pcie%03x",
> >                    pci_name(pdev),
> >                    get_descriptor_id(pci_pcie_type(pdev), service));
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 4b8693ec9e4c67fc1655e0057b3b96b4098e6630..dddd7ebc03d1a6e6ee456e0=
bf02ab9833a819509 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -614,6 +614,7 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus=
 *parent)
> >       INIT_LIST_HEAD(&b->devices);
> >       INIT_LIST_HEAD(&b->slots);
> >       INIT_LIST_HEAD(&b->resources);
> > +     dev_liveupdate_init(&b->dev);
>
> Same, why here?  Shouldn't the driver core be doing this all for you
> automatically?  Are you going to make each bus do this manually?

No, the PCI enumeration happened way before the driver core was
registering the device. We already need to add the device to the
liveupdate device list during the PCI enumeration. That is before the
driver is bound and probed.

Yes, it needs to happen when the bus is allocated and initialized.
Earlier than driver init.

> >       b->max_bus_speed =3D PCI_SPEED_UNKNOWN;
> >       b->cur_bus_speed =3D PCI_SPEED_UNKNOWN;
> >  #ifdef CONFIG_PCI_DOMAINS_GENERIC
> > @@ -1985,6 +1986,7 @@ int pci_setup_device(struct pci_dev *dev)
> >       dev->sysdata =3D dev->bus->sysdata;
> >       dev->dev.parent =3D dev->bus->bridge;
> >       dev->dev.bus =3D &pci_bus_type;
> > +     dev_liveupdate_init(&dev->dev);
>
> Looks like you are :(

Yes, I need it initialized earlier. Suggestions are welcome. I haven't
found a way to insert the dev_liveupdate_init() into some device init
function. The existing device init function was called too late.

> Do it in one place please.

Which place? If there is such a function called by all different
flavors of device and initialized early enough, I am happy to move
there. There is none as far as I can tell.

> >       dev->hdr_type =3D hdr_type & 0x7f;
> >       dev->multifunction =3D !!(hdr_type & 0x80);
> >       dev->error_state =3D pci_channel_io_normal;
> > @@ -3184,7 +3186,7 @@ struct pci_bus *pci_create_root_bus(struct device=
 *parent, int bus,
> >               return NULL;
> >
> >       bridge->dev.parent =3D parent;
> > -
> > +     dev_liveupdate_init(&bridge->dev);
>
> Again, one place.

Any suggestions where to move to.  dev_liveupdate_init() is the one
place to perform the work. Just need to have multiple entrances. I
can't find an alternative yet.

> >       list_splice_init(resources, &bridge->windows);
> >       bridge->sysdata =3D sysdata;
> >       bridge->busnr =3D bus;
> > diff --git a/include/linux/dev_liveupdate.h b/include/linux/dev_liveupd=
ate.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..72297cba08a999e89f7bc09=
97dabdbe14e0aa12c
> > --- /dev/null
> > +++ b/include/linux/dev_liveupdate.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +
> > +/*
> > + * Copyright (c) 2025, Google LLC.
> > + * Pasha Tatashin <pasha.tatashin@soleen.com>
> > + * Chris Li <chrisl@kernel.org>
> > + */
> > +#ifndef _LINUX_DEV_LIVEUPDATE_H
> > +#define _LINUX_DEV_LIVEUPDATE_H
> > +
> > +#include <linux/liveupdate.h>
> > +
> > +#ifdef CONFIG_LIVEUPDATE
> > +
> > +enum liveupdate_flag {
> > +     LU_BUSMASTER =3D 1 << 0,
> > +     LU_BUSMASTER_BRIDGE =3D 2 << 0,
>
> BIT() please.

Ack. Will do.

>
> > +};
> > +
> > +#define      LU_REQUESTED    (LU_BUSMASTER)
> > +#define      LU_DEPENDED     (LU_BUSMASTER_BRIDGE)
>
> Why 2 names for the same thing?

 LU_DEPENDED is for all dependent devices, the derivatives device gets
pulled into the liveupdate device set. When a liveupdate session gets
canceled. Those derivatives device sets need to be cleaned up. There
will be more liveupdate feature flags (e.g. LU_DMA, LU_SRIOV) added to
the requested and dependent flags.  These two are the aggregate flags
for all requested features and dependent features.

> > +
> > +/**
> > + * struct dev_liveupdate - Device state for live update operations
> > + * @lu_next: List head for linking the device into live update
> > + *           related lists (e.g., a list of devices participating
> > + *           in a live update sequence).
> > + * @flags:   Indicate what liveupdate feature does the device
> > + *           participtate.
> > + * @visited: Only used by the bus devices when travese the PCI buses
> > + *           to build the liveupdate devices list. Set if the child
> > + *           buses have been pushed into the pending stack.
> > + *
> > + * This structure holds the state information required for performing
> > + * live update operations on a device. It is embedded within a struct =
device.
> > + */
> > +struct dev_liveupdate {
> > +     struct list_head lu_next;
>
> Another list?

Yes, as explained earlier, a fixed list for the liveupdate session.

>
> > +     enum liveupdate_flag flags;
> > +     bool visited:1;
>
> You shouldn't need this, you "know" you only touch one device at a time
> when walking a bus, don't try to manually keep track of it on your own.

No, I do need this due to the postravesal visit of the bus. I need to
know if this is the first time I visit this bus, if it is, walk its
children bus first. Else means the second time you visit this bus, all
the children bus has been visited, now add this bus to the liveupdate
list if it has non zero liveupdate flags.

I can do recursive bus walking without using additional bits to
indicate if this is the first time I visit the bus. But recursive tree
walking in the kernel is considered bad due to the stack usage.

> And again, why is the pci core doing this, the driver core should be
> doing all of this, PLEASE do not bury driver-model-core-changes down in

The driver core does not have the knowledge of doing this, e.g. the PF
and VF relationship. The reason liveupdate struct was added to the
device struct is because device struct is embedded in pci_dev,
pci_host_bridge, pci_bus. That is the three structs I care about for
the liveupdate.

The alternative is adding livedupate struct in the above three structs
separately without touching device struct. The patch will be bigger if
possible. I recall having some problem due to the bus->bridge being a
device struct rather than pci_dev or pci_host_bridge. I can try that
again if you think that is better.

> a "PCI" patch.  That will make the driver core maintainers very grumpy
> when they run across stuff like this (as it did here...)

Driver core I assume you mean the core around "struct device". As I
explained earlier, it needs PCI special knowledge outside of the
common driver core. Suggestion welcome how to unset you less :-)

> > +};
> > +
> > +#endif /* CONFIG_LIVEUPDATE */
> > +#endif /* _LINUX_DEV_LIVEUPDATE_H */
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 4940db137fffff4ceacf819b32433a0f4898b125..e0b35c723239f1254a3b615=
2f433e0412cd3fb34 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -21,6 +21,7 @@
> >  #include <linux/lockdep.h>
> >  #include <linux/compiler.h>
> >  #include <linux/types.h>
> > +#include <linux/dev_liveupdate.h>
>
> Look, driver core changes.  Please do this all in stuff that is NOT for
> just PCI.

But I only have PCI devices that are supported. Should I also consider
having an entry point in the device and then PCI as one of the
register device subsystems knows about livedupate and get called that
way?

Another way is just move livedupate all into PCI related struct only.

> >  #include <linux/mutex.h>
> >  #include <linux/pm.h>
> >  #include <linux/atomic.h>
> > @@ -508,6 +509,7 @@ struct device_physical_location {
> >   * @pm_domain:       Provide callbacks that are executed during system=
 suspend,
> >   *           hibernation, system resume and during runtime PM transiti=
ons
> >   *           along with subsystem-level and driver-level callbacks.
> > + * @lu:              Live update state.
>
> You have more letters, please use them.  "lu" is too short.
>
> >   * @em_pd:   device's energy model performance domain
> >   * @pins:    For device pin management.
> >   *           See Documentation/driver-api/pin-control.rst for details.
> > @@ -603,6 +605,10 @@ struct device {
> >       struct dev_pm_info      power;
> >       struct dev_pm_domain    *pm_domain;
> >
> > +#ifdef CONFIG_LIVEUPDATE
> > +     struct dev_liveupdate   lu;
> > +#endif
>
> Why not a pointer?

To avoid allocating additional memory failure during the repaire()
callback try to set a dependent device as liveupdate. Actually now
prepare() can be cancelled. I can make this as a pointer and
dynamically allocate the lu struct as well if that is prefered.

>
> > +
> >  #ifdef CONFIG_ENERGY_MODEL
> >       struct em_perf_domain   *em_pd;
> >  #endif
> > @@ -1168,4 +1174,13 @@ void device_link_wait_removal(void);
> >  #define MODULE_ALIAS_CHARDEV_MAJOR(major) \
> >       MODULE_ALIAS("char-major-" __stringify(major) "-*")
> >
> > +#ifdef CONFIG_LIVEUPDATE
> > +static inline void dev_liveupdate_init(struct device *dev)
> > +{
> > +     INIT_LIST_HEAD(&dev->lu.lu_next);
>
> Why does this have to be in device.h?  The driver core should do this
> for you (as I say above).

I need a more specific pointer which driver core function can do for
me. PCI device enumeration happens pretty early, that is before
registering the device.

Thanks for the long detailed feedback. I am still working on my way to
catch up on my email.

Chris

