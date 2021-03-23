Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB8834646C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 17:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCWQG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 12:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34529 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233080AbhCWQGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 12:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616515591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCppzRt5yVFQRFuyWqBhrRYjU8pyziGBcX03eT5KikY=;
        b=XRE7Y2sUeOgPC7Vm6dZPx95Jyrthn3+1WYdrQcHI70s+4/SgqAhdg+ukGQXdBQhE1XZwpi
        ZZqlH2NRiz/URmlYyXaeLrJ3/vxXLFGWmL8/xA9l26AFRgJb6GZS39hQltUavNNVU1AMEt
        15YJ4lfsuyuiBJHxB7E7wO37E4YeSHM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-7QUfYVdmOHSddyrvPAl3Lg-1; Tue, 23 Mar 2021 12:06:28 -0400
X-MC-Unique: 7QUfYVdmOHSddyrvPAl3Lg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D827F801817;
        Tue, 23 Mar 2021 16:06:26 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 650255D9C0;
        Tue, 23 Mar 2021 16:06:26 +0000 (UTC)
Date:   Tue, 23 Mar 2021 10:06:25 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     bhelgaas@google.com, pali@kernel.org, raphael.norwitz@nutanix.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210323100625.0021a943@omen.home.shazbot.org>
In-Reply-To: <20210323153221.n2pwjixqen6hx26h@archlinux>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Mar 2021 21:02:21 +0530
Amey Narkhede <ameynarkhede03@gmail.com> wrote:

> On 21/03/23 08:44AM, Alex Williamson wrote:
> > On Tue, 23 Mar 2021 15:34:19 +0100
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > =20
> > > On Thursday 18 March 2021 20:01:55 Amey Narkhede wrote: =20
> > > > On 21/03/17 09:13PM, Pali Roh=C3=A1r wrote: =20
> > > > > On Wednesday 17 March 2021 14:00:20 Alex Williamson wrote: =20
> > > > > > On Wed, 17 Mar 2021 20:40:24 +0100
> > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > =20
> > > > > > > On Wednesday 17 March 2021 13:32:45 Alex Williamson wrote: =20
> > > > > > > > On Wed, 17 Mar 2021 20:24:24 +0100
> > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > =20
> > > > > > > > > On Wednesday 17 March 2021 13:15:36 Alex Williamson wrote=
: =20
> > > > > > > > > > On Wed, 17 Mar 2021 20:02:06 +0100
> > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > =20
> > > > > > > > > > > On Monday 15 March 2021 09:03:39 Alex Williamson wrot=
e: =20
> > > > > > > > > > > > On Mon, 15 Mar 2021 15:52:38 +0100
> > > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > > > =20
> > > > > > > > > > > > > On Monday 15 March 2021 08:34:09 Alex Williamson =
wrote: =20
> > > > > > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > > > > > =20
> > > > > > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhed=
e wrote: =20
> > > > > > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) an=
d secondary bus
> > > > > > > > > > > > > > > > reset(pci_parent_bus_reset) which I think a=
re hot reset and
> > > > > > > > > > > > > > > > warm reset respectively. =20
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > No. PCI secondary bus reset =3D PCIe Hot Rese=
t. Slot reset is just another
> > > > > > > > > > > > > > > type of reset, which is currently implemented=
 only for PCIe hot plug
> > > > > > > > > > > > > > > bridges and for PowerPC PowerNV platform and =
it just call PCI secondary
> > > > > > > > > > > > > > > bus reset with some other hook. PCIe Warm Res=
et does not have API in
> > > > > > > > > > > > > > > kernel and therefore drivers do not export th=
is type of reset via any
> > > > > > > > > > > > > > > kernel function (yet). =20
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Warm reset is beyond the scope of this series, =
but could be implemented
> > > > > > > > > > > > > > in a compatible way to fit within the pci_reset=
_fn_methods[] array
> > > > > > > > > > > > > > defined here. =20
> > > > > > > > > > > > >
> > > > > > > > > > > > > Ok!
> > > > > > > > > > > > > =20
> > > > > > > > > > > > > > Note that with this series the resets available=
 through
> > > > > > > > > > > > > > pci_reset_function() and the per device reset a=
ttribute is sysfs remain
> > > > > > > > > > > > > > exactly the same as they are currently.  The bu=
s and slot reset
> > > > > > > > > > > > > > methods used here are limited to devices where =
only a single function is
> > > > > > > > > > > > > > affected by the reset, therefore it is not like=
 the patch you proposed
> > > > > > > > > > > > > > which performed a reset irrespective of the dow=
nstream devices.  This
> > > > > > > > > > > > > > series only enables selection of the existing m=
ethods.  Thanks,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Alex
> > > > > > > > > > > > > > =20
> > > > > > > > > > > > >
> > > > > > > > > > > > > But with this patch series, there is still an iss=
ue with PCI secondary
> > > > > > > > > > > > > bus reset mechanism as exported sysfs attribute d=
oes not do that
> > > > > > > > > > > > > remove-reset-rescan procedure. As discussed in ot=
her thread, this reset
> > > > > > > > > > > > > let device in unconfigured / broken state. =20
> > > > > > > > > > > >
> > > > > > > > > > > > No, there's not:
> > > > > > > > > > > >
> > > > > > > > > > > > int pci_reset_function(struct pci_dev *dev)
> > > > > > > > > > > > {
> > > > > > > > > > > >         int rc;
> > > > > > > > > > > >
> > > > > > > > > > > >         if (!dev->reset_fn)
> > > > > > > > > > > >                 return -ENOTTY;
> > > > > > > > > > > >
> > > > > > > > > > > >         pci_dev_lock(dev); =20
> > > > > > > > > > > > >>>     pci_dev_save_and_disable(dev); =20
> > > > > > > > > > > >
> > > > > > > > > > > >         rc =3D __pci_reset_function_locked(dev);
> > > > > > > > > > > > =20
> > > > > > > > > > > > >>>     pci_dev_restore(dev); =20
> > > > > > > > > > > >         pci_dev_unlock(dev);
> > > > > > > > > > > >
> > > > > > > > > > > >         return rc;
> > > > > > > > > > > > }
> > > > > > > > > > > >
> > > > > > > > > > > > The remove/re-scan was discussed primarily because =
your patch performed
> > > > > > > > > > > > a bus reset regardless of what devices were affecte=
d by that reset and
> > > > > > > > > > > > it's difficult to manage the scope where multiple d=
evices are affected.
> > > > > > > > > > > > Here, the bus and slot reset functions will fail un=
less the scope is
> > > > > > > > > > > > limited to the single device triggering this reset.=
  Thanks,
> > > > > > > > > > > >
> > > > > > > > > > > > Alex
> > > > > > > > > > > > =20
> > > > > > > > > > >
> > > > > > > > > > > I was thinking a bit more about it and I'm really sur=
e how it would
> > > > > > > > > > > behave with hotplugging PCIe bridge.
> > > > > > > > > > >
> > > > > > > > > > > On aardvark PCIe controller I have already tested tha=
t secondary bus
> > > > > > > > > > > reset bit is triggering Hot Reset event and then also=
 Link Down event.
> > > > > > > > > > > These events are not handled by aardvark driver yet (=
needs to
> > > > > > > > > > > implemented into kernel's emulated root bridge code).
> > > > > > > > > > >
> > > > > > > > > > > But I'm not sure how it would behave on real HW PCIe =
hotplugging bridge.
> > > > > > > > > > > Kernel has already code which removes PCIe device if =
it changes presence
> > > > > > > > > > > bit (and inform via interrupt). And Link Down event t=
riggers this
> > > > > > > > > > > change. =20
> > > > > > > > > >
> > > > > > > > > > This is the difference between slot and bus resets, the=
 slot reset is
> > > > > > > > > > implemented by the hotplug controller and disables pres=
ence detection
> > > > > > > > > > around the bus reset.  Thanks, =20
> > > > > > > > >
> > > > > > > > > Yes, but I'm talking about bus reset, not about slot rese=
t.
> > > > > > > > >
> > > > > > > > > I mean: to use bus reset via sysfs on hardware which supp=
orts slots and
> > > > > > > > > hotplugging.
> > > > > > > > >
> > > > > > > > > And if I'm reading code correctly, this combination is al=
lowed, right?
> > > > > > > > > Via these new patches it is possible to disable slot rese=
t and enable
> > > > > > > > > bus reset. =20
> > > > > > > >
> > > > > > > > That's true, a slot reset is simply a bus reset wrapped aro=
und code
> > > > > > > > that prevents the device from getting ejected. =20
> > > > > > >
> > > > > > > Yes, this makes slot reset "safe". But bus reset is "unsafe".
> > > > > > > =20
> > > > > > > > Maybe it would make
> > > > > > > > sense to combine the two as far as this interface is concer=
ned, ie. a
> > > > > > > > single "bus" reset method that will always use slot reset w=
hen
> > > > > > > > available.  Thanks, =20
> > > > > > >
> > > > > > > That should work when slot reset is available.
> > > > > > >
> > > > > > > Other option is that mentioned remove-reset-rescan procedure.=
 =20
> > > > > >
> > > > > > That's not something we can introduce to the pci_reset_function=
() path
> > > > > > without a fair bit of collateral in using it through vfio-pci.
> > > > > > =20
> > > > > > > But quick search in drivers/pci/hotplug/ results that not all=
 hotplug
> > > > > > > drivers implement reset_slot method.
> > > > > > >
> > > > > > > So there is a possible issue with hotplug driver which may ej=
ect device
> > > > > > > during bus reset (because e.g. slot reset is not implemented)=
? =20
> > > > > >
> > > > > > People aren't reporting it, so maybe those controllers aren't b=
eing
> > > > > > used for this use case.  Or maybe introducing this patch will m=
ake
> > > > > > these reset methods more readily accessible for testing.  We ca=
n fix or
> > > > > > blacklist those controllers for bus reset when reports come in.=
  Thanks, =20
> > > > >
> > > > > Ok! I do not know neither if those controllers are used, but look=
s like
> > > > > that there are still changes in hotplug code.
> > > > >
> > > > > So I guess with these patches people can test it and report issue=
s when
> > > > > such thing happen. =20
> > > > So after a bit research as I understood we need to group slot
> > > > and bus reset together in a single category of reset methods and
> > > > then implicitly use slot reset if it is available when bus reset is
> > > > enabled by the user.
> > > > Is that right? =20
> > >
> > > Yes, I understand it in same way. Just I do not know which name to
> > > choose for this reset category. In PCI spec it is called Secondary Bus
> > > Reset (as it resets whole bus with all devices; but we allow this res=
et
> > > in this patch series only if on the bus is connected exactly one devi=
ce).
> > > In PCIe spec it is called Hot Reset. And if kernel detects Slot suppo=
rt
> > > then kernel currently calls it Slot reset. But it is still same thing.
> > > Any opinion? I think that we could call it Hot Reset as this patch
> > > series exports it only for single device (so calling it _bus_ is not =
the
> > > best match). =20
> >
> > A similar abstraction where our scope is not limited to a single
> > function calls this a bus reset:
> >
> > int pci_reset_bus(struct pci_dev *pdev)
> > {
> >         return (!pci_probe_reset_slot(pdev->slot)) ?
> >             __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
> > }
> >
> > Thanks,
> > Alex
> > =20
> I was going to use similar function
>=20
> int pci_bus_reset(struct pci_dev *dev, int probe)
> {
>        return pci_dev_reset_slot_function(dev, probe) ?
>                pci_parent_bus_reset(dev, probe) : 0;
>=20
> }

I think via the sysfs attribute we can simply call this "bus" reset,
but internally having both pci_reset_bus() and pci_bus_reset() would be
really confusing.  We're doing the same thing as pci_bus_reset() but
with a different scope, so I'd probably suggest
pci_bus_reset_function().

Also, the above ternary form isn't true to the original, only -ENOTTY
allows fall-through, so something more like:

int pci_reset_bus_function(struct pci_dev *dev, int probe)
{
	int rc =3D pci_dev_reset_slot_function(dev, probe);

	return (rc =3D=3D -ENOTTY) ? pci_parent_bus_reset(dev, probe) : rc;
}

Thanks,
Alex

