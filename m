Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270423464C0
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 17:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233205AbhCWQQD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 12:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233163AbhCWQPp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 12:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616516145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMXOr9cqKamxuKoAg/D1bTKRo0SAKBVJ3Gkwela4hHg=;
        b=DZemtJ04cj+kHKFNGKGbU08e6ZfGmGrTj9iX3zhwY6G1HB707vFpRsCqgyuXiUZBDTN/9b
        8msWuvPa7SIrxL059enNxgfAXfzDmbphy5dpTQ2HFt0IMw3K7AvtZbkXwJ1U9IM1DiFUvR
        geSwzhzweZ8oshoEwV9IFyOWyoF6Ed4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-B33VMCFuPSOcktSBz75x_w-1; Tue, 23 Mar 2021 12:15:40 -0400
X-MC-Unique: B33VMCFuPSOcktSBz75x_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F1D107ACCA;
        Tue, 23 Mar 2021 16:15:39 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B187660BE5;
        Tue, 23 Mar 2021 16:15:38 +0000 (UTC)
Date:   Tue, 23 Mar 2021 10:15:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     bhelgaas@google.com, pali@kernel.org, raphael.norwitz@nutanix.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210323101538.0f683e53@omen.home.shazbot.org>
In-Reply-To: <20210323100625.0021a943@omen.home.shazbot.org>
References: <20210317190206.zrtzwgskxdogl7dz@pali>
        <20210317131536.38f398b0@omen.home.shazbot.org>
        <20210317192424.kpfybcrsen3ivr4f@pali>
        <20210317133245.7d95909c@omen.home.shazbot.org>
        <20210317194024.nkzrbbvi6utoznze@pali>
        <20210317140020.4375ba76@omen.home.shazbot.org>
        <20210317201346.v6t4rde6nzmt7fwr@pali>
        <20210318143155.4vuf3izuzihiujaa@archlinux>
        <20210323143419.syqf4dg7wcxorcmk@pali>
        <20210323084438.37bfcc8e@omen.home.shazbot.org>
        <20210323153221.n2pwjixqen6hx26h@archlinux>
        <20210323100625.0021a943@omen.home.shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Mar 2021 10:06:25 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 23 Mar 2021 21:02:21 +0530
> Amey Narkhede <ameynarkhede03@gmail.com> wrote:
>=20
> > On 21/03/23 08:44AM, Alex Williamson wrote: =20
> > > On Tue, 23 Mar 2021 15:34:19 +0100
> > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > >   =20
> > > > On Thursday 18 March 2021 20:01:55 Amey Narkhede wrote:   =20
> > > > > On 21/03/17 09:13PM, Pali Roh=C3=A1r wrote:   =20
> > > > > > On Wednesday 17 March 2021 14:00:20 Alex Williamson wrote:   =20
> > > > > > > On Wed, 17 Mar 2021 20:40:24 +0100
> > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > >   =20
> > > > > > > > On Wednesday 17 March 2021 13:32:45 Alex Williamson wrote: =
  =20
> > > > > > > > > On Wed, 17 Mar 2021 20:24:24 +0100
> > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > >   =20
> > > > > > > > > > On Wednesday 17 March 2021 13:15:36 Alex Williamson wro=
te:   =20
> > > > > > > > > > > On Wed, 17 Mar 2021 20:02:06 +0100
> > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > >   =20
> > > > > > > > > > > > On Monday 15 March 2021 09:03:39 Alex Williamson wr=
ote:   =20
> > > > > > > > > > > > > On Mon, 15 Mar 2021 15:52:38 +0100
> > > > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > > > >   =20
> > > > > > > > > > > > > > On Monday 15 March 2021 08:34:09 Alex Williamso=
n wrote:   =20
> > > > > > > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > > > > > >   =20
> > > > > > > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkh=
ede wrote:   =20
> > > > > > > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) =
and secondary bus
> > > > > > > > > > > > > > > > > reset(pci_parent_bus_reset) which I think=
 are hot reset and
> > > > > > > > > > > > > > > > > warm reset respectively.   =20
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > No. PCI secondary bus reset =3D PCIe Hot Re=
set. Slot reset is just another
> > > > > > > > > > > > > > > > type of reset, which is currently implement=
ed only for PCIe hot plug
> > > > > > > > > > > > > > > > bridges and for PowerPC PowerNV platform an=
d it just call PCI secondary
> > > > > > > > > > > > > > > > bus reset with some other hook. PCIe Warm R=
eset does not have API in
> > > > > > > > > > > > > > > > kernel and therefore drivers do not export =
this type of reset via any
> > > > > > > > > > > > > > > > kernel function (yet).   =20
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Warm reset is beyond the scope of this series=
, but could be implemented
> > > > > > > > > > > > > > > in a compatible way to fit within the pci_res=
et_fn_methods[] array
> > > > > > > > > > > > > > > defined here.   =20
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Ok!
> > > > > > > > > > > > > >   =20
> > > > > > > > > > > > > > > Note that with this series the resets availab=
le through
> > > > > > > > > > > > > > > pci_reset_function() and the per device reset=
 attribute is sysfs remain
> > > > > > > > > > > > > > > exactly the same as they are currently.  The =
bus and slot reset
> > > > > > > > > > > > > > > methods used here are limited to devices wher=
e only a single function is
> > > > > > > > > > > > > > > affected by the reset, therefore it is not li=
ke the patch you proposed
> > > > > > > > > > > > > > > which performed a reset irrespective of the d=
ownstream devices.  This
> > > > > > > > > > > > > > > series only enables selection of the existing=
 methods.  Thanks,
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Alex
> > > > > > > > > > > > > > >   =20
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But with this patch series, there is still an i=
ssue with PCI secondary
> > > > > > > > > > > > > > bus reset mechanism as exported sysfs attribute=
 does not do that
> > > > > > > > > > > > > > remove-reset-rescan procedure. As discussed in =
other thread, this reset
> > > > > > > > > > > > > > let device in unconfigured / broken state.   =20
> > > > > > > > > > > > >
> > > > > > > > > > > > > No, there's not:
> > > > > > > > > > > > >
> > > > > > > > > > > > > int pci_reset_function(struct pci_dev *dev)
> > > > > > > > > > > > > {
> > > > > > > > > > > > >         int rc;
> > > > > > > > > > > > >
> > > > > > > > > > > > >         if (!dev->reset_fn)
> > > > > > > > > > > > >                 return -ENOTTY;
> > > > > > > > > > > > >
> > > > > > > > > > > > >         pci_dev_lock(dev);   =20
> > > > > > > > > > > > > >>>     pci_dev_save_and_disable(dev);   =20
> > > > > > > > > > > > >
> > > > > > > > > > > > >         rc =3D __pci_reset_function_locked(dev);
> > > > > > > > > > > > >   =20
> > > > > > > > > > > > > >>>     pci_dev_restore(dev);   =20
> > > > > > > > > > > > >         pci_dev_unlock(dev);
> > > > > > > > > > > > >
> > > > > > > > > > > > >         return rc;
> > > > > > > > > > > > > }
> > > > > > > > > > > > >
> > > > > > > > > > > > > The remove/re-scan was discussed primarily becaus=
e your patch performed
> > > > > > > > > > > > > a bus reset regardless of what devices were affec=
ted by that reset and
> > > > > > > > > > > > > it's difficult to manage the scope where multiple=
 devices are affected.
> > > > > > > > > > > > > Here, the bus and slot reset functions will fail =
unless the scope is
> > > > > > > > > > > > > limited to the single device triggering this rese=
t.  Thanks,
> > > > > > > > > > > > >
> > > > > > > > > > > > > Alex
> > > > > > > > > > > > >   =20
> > > > > > > > > > > >
> > > > > > > > > > > > I was thinking a bit more about it and I'm really s=
ure how it would
> > > > > > > > > > > > behave with hotplugging PCIe bridge.
> > > > > > > > > > > >
> > > > > > > > > > > > On aardvark PCIe controller I have already tested t=
hat secondary bus
> > > > > > > > > > > > reset bit is triggering Hot Reset event and then al=
so Link Down event.
> > > > > > > > > > > > These events are not handled by aardvark driver yet=
 (needs to
> > > > > > > > > > > > implemented into kernel's emulated root bridge code=
).
> > > > > > > > > > > >
> > > > > > > > > > > > But I'm not sure how it would behave on real HW PCI=
e hotplugging bridge.
> > > > > > > > > > > > Kernel has already code which removes PCIe device i=
f it changes presence
> > > > > > > > > > > > bit (and inform via interrupt). And Link Down event=
 triggers this
> > > > > > > > > > > > change.   =20
> > > > > > > > > > >
> > > > > > > > > > > This is the difference between slot and bus resets, t=
he slot reset is
> > > > > > > > > > > implemented by the hotplug controller and disables pr=
esence detection
> > > > > > > > > > > around the bus reset.  Thanks,   =20
> > > > > > > > > >
> > > > > > > > > > Yes, but I'm talking about bus reset, not about slot re=
set.
> > > > > > > > > >
> > > > > > > > > > I mean: to use bus reset via sysfs on hardware which su=
pports slots and
> > > > > > > > > > hotplugging.
> > > > > > > > > >
> > > > > > > > > > And if I'm reading code correctly, this combination is =
allowed, right?
> > > > > > > > > > Via these new patches it is possible to disable slot re=
set and enable
> > > > > > > > > > bus reset.   =20
> > > > > > > > >
> > > > > > > > > That's true, a slot reset is simply a bus reset wrapped a=
round code
> > > > > > > > > that prevents the device from getting ejected.   =20
> > > > > > > >
> > > > > > > > Yes, this makes slot reset "safe". But bus reset is "unsafe=
".
> > > > > > > >   =20
> > > > > > > > > Maybe it would make
> > > > > > > > > sense to combine the two as far as this interface is conc=
erned, ie. a
> > > > > > > > > single "bus" reset method that will always use slot reset=
 when
> > > > > > > > > available.  Thanks,   =20
> > > > > > > >
> > > > > > > > That should work when slot reset is available.
> > > > > > > >
> > > > > > > > Other option is that mentioned remove-reset-rescan procedur=
e.   =20
> > > > > > >
> > > > > > > That's not something we can introduce to the pci_reset_functi=
on() path
> > > > > > > without a fair bit of collateral in using it through vfio-pci.
> > > > > > >   =20
> > > > > > > > But quick search in drivers/pci/hotplug/ results that not a=
ll hotplug
> > > > > > > > drivers implement reset_slot method.
> > > > > > > >
> > > > > > > > So there is a possible issue with hotplug driver which may =
eject device
> > > > > > > > during bus reset (because e.g. slot reset is not implemente=
d)?   =20
> > > > > > >
> > > > > > > People aren't reporting it, so maybe those controllers aren't=
 being
> > > > > > > used for this use case.  Or maybe introducing this patch will=
 make
> > > > > > > these reset methods more readily accessible for testing.  We =
can fix or
> > > > > > > blacklist those controllers for bus reset when reports come i=
n.  Thanks,   =20
> > > > > >
> > > > > > Ok! I do not know neither if those controllers are used, but lo=
oks like
> > > > > > that there are still changes in hotplug code.
> > > > > >
> > > > > > So I guess with these patches people can test it and report iss=
ues when
> > > > > > such thing happen.   =20
> > > > > So after a bit research as I understood we need to group slot
> > > > > and bus reset together in a single category of reset methods and
> > > > > then implicitly use slot reset if it is available when bus reset =
is
> > > > > enabled by the user.
> > > > > Is that right?   =20
> > > >
> > > > Yes, I understand it in same way. Just I do not know which name to
> > > > choose for this reset category. In PCI spec it is called Secondary =
Bus
> > > > Reset (as it resets whole bus with all devices; but we allow this r=
eset
> > > > in this patch series only if on the bus is connected exactly one de=
vice).
> > > > In PCIe spec it is called Hot Reset. And if kernel detects Slot sup=
port
> > > > then kernel currently calls it Slot reset. But it is still same thi=
ng.
> > > > Any opinion? I think that we could call it Hot Reset as this patch
> > > > series exports it only for single device (so calling it _bus_ is no=
t the
> > > > best match).   =20
> > >
> > > A similar abstraction where our scope is not limited to a single
> > > function calls this a bus reset:
> > >
> > > int pci_reset_bus(struct pci_dev *pdev)
> > > {
> > >         return (!pci_probe_reset_slot(pdev->slot)) ?
> > >             __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
> > > }
> > >
> > > Thanks,
> > > Alex
> > >   =20
> > I was going to use similar function
> >=20
> > int pci_bus_reset(struct pci_dev *dev, int probe)
> > {
> >        return pci_dev_reset_slot_function(dev, probe) ?
> >                pci_parent_bus_reset(dev, probe) : 0;
> >=20
> > } =20
>=20
> I think via the sysfs attribute we can simply call this "bus" reset,
> but internally having both pci_reset_bus() and pci_bus_reset() would be
> really confusing.  We're doing the same thing as pci_bus_reset() but
> with a different scope, so I'd probably suggest
> pci_bus_reset_function().

I'm already confusing them, s/bus_reset/reset_bus/ in the last sentence
above.  Thanks,

Alex

>=20
> Also, the above ternary form isn't true to the original, only -ENOTTY
> allows fall-through, so something more like:
>=20
> int pci_reset_bus_function(struct pci_dev *dev, int probe)
> {
> 	int rc =3D pci_dev_reset_slot_function(dev, probe);
>=20
> 	return (rc =3D=3D -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;
> }
>=20
> Thanks,
> Alex
>=20

