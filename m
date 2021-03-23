Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C80FE3461B3
	for <lists+linux-pci@lfdr.de>; Tue, 23 Mar 2021 15:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhCWOpN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Mar 2021 10:45:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232236AbhCWOon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Mar 2021 10:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616510682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ooq+adN18I5oYJFvZHF/vFEW7YJYjplPqj9WCbOhafQ=;
        b=d/JCt/XR+VTvL/PmTaEotWZPxBl0kJhporb6lf0rj22odQVUTk+bnm5/5liTcCXTkKoirW
        hQhCRbrtQkV7Iq+DJoVU7E5AVGRnXkfgB8g1PGG7fk1fo1LX4oFWIBpgiholgM5W4ZPyDA
        j7erw54VuWUhYGR5ejQXAHA0u88QfF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-bwVVlytLND2WKcBV0ks0zQ-1; Tue, 23 Mar 2021 10:44:40 -0400
X-MC-Unique: bwVVlytLND2WKcBV0ks0zQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0177F83DD21;
        Tue, 23 Mar 2021 14:44:39 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-120.phx2.redhat.com [10.3.112.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8912D5D6AD;
        Tue, 23 Mar 2021 14:44:38 +0000 (UTC)
Date:   Tue, 23 Mar 2021 08:44:38 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210323084438.37bfcc8e@omen.home.shazbot.org>
In-Reply-To: <20210323143419.syqf4dg7wcxorcmk@pali>
References: <20210315145238.6sg5deblr2z2pupu@pali>
        <20210315090339.54546e91@x1.home.shazbot.org>
        <20210317190206.zrtzwgskxdogl7dz@pali>
        <20210317131536.38f398b0@omen.home.shazbot.org>
        <20210317192424.kpfybcrsen3ivr4f@pali>
        <20210317133245.7d95909c@omen.home.shazbot.org>
        <20210317194024.nkzrbbvi6utoznze@pali>
        <20210317140020.4375ba76@omen.home.shazbot.org>
        <20210317201346.v6t4rde6nzmt7fwr@pali>
        <20210318143155.4vuf3izuzihiujaa@archlinux>
        <20210323143419.syqf4dg7wcxorcmk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 Mar 2021 15:34:19 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Thursday 18 March 2021 20:01:55 Amey Narkhede wrote:
> > On 21/03/17 09:13PM, Pali Roh=C3=A1r wrote: =20
> > > On Wednesday 17 March 2021 14:00:20 Alex Williamson wrote: =20
> > > > On Wed, 17 Mar 2021 20:40:24 +0100
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > =20
> > > > > On Wednesday 17 March 2021 13:32:45 Alex Williamson wrote: =20
> > > > > > On Wed, 17 Mar 2021 20:24:24 +0100
> > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > =20
> > > > > > > On Wednesday 17 March 2021 13:15:36 Alex Williamson wrote: =20
> > > > > > > > On Wed, 17 Mar 2021 20:02:06 +0100
> > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > =20
> > > > > > > > > On Monday 15 March 2021 09:03:39 Alex Williamson wrote: =
=20
> > > > > > > > > > On Mon, 15 Mar 2021 15:52:38 +0100
> > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > =20
> > > > > > > > > > > On Monday 15 March 2021 08:34:09 Alex Williamson wrot=
e: =20
> > > > > > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > > > > > > =20
> > > > > > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wr=
ote: =20
> > > > > > > > > > > > > > slot reset (pci_dev_reset_slot_function) and se=
condary bus
> > > > > > > > > > > > > > reset(pci_parent_bus_reset) which I think are h=
ot reset and
> > > > > > > > > > > > > > warm reset respectively. =20
> > > > > > > > > > > > >
> > > > > > > > > > > > > No. PCI secondary bus reset =3D PCIe Hot Reset. S=
lot reset is just another
> > > > > > > > > > > > > type of reset, which is currently implemented onl=
y for PCIe hot plug
> > > > > > > > > > > > > bridges and for PowerPC PowerNV platform and it j=
ust call PCI secondary
> > > > > > > > > > > > > bus reset with some other hook. PCIe Warm Reset d=
oes not have API in
> > > > > > > > > > > > > kernel and therefore drivers do not export this t=
ype of reset via any
> > > > > > > > > > > > > kernel function (yet). =20
> > > > > > > > > > > >
> > > > > > > > > > > > Warm reset is beyond the scope of this series, but =
could be implemented
> > > > > > > > > > > > in a compatible way to fit within the pci_reset_fn_=
methods[] array
> > > > > > > > > > > > defined here. =20
> > > > > > > > > > >
> > > > > > > > > > > Ok!
> > > > > > > > > > > =20
> > > > > > > > > > > > Note that with this series the resets available thr=
ough
> > > > > > > > > > > > pci_reset_function() and the per device reset attri=
bute is sysfs remain
> > > > > > > > > > > > exactly the same as they are currently.  The bus an=
d slot reset
> > > > > > > > > > > > methods used here are limited to devices where only=
 a single function is
> > > > > > > > > > > > affected by the reset, therefore it is not like the=
 patch you proposed
> > > > > > > > > > > > which performed a reset irrespective of the downstr=
eam devices.  This
> > > > > > > > > > > > series only enables selection of the existing metho=
ds.  Thanks,
> > > > > > > > > > > >
> > > > > > > > > > > > Alex
> > > > > > > > > > > > =20
> > > > > > > > > > >
> > > > > > > > > > > But with this patch series, there is still an issue w=
ith PCI secondary
> > > > > > > > > > > bus reset mechanism as exported sysfs attribute does =
not do that
> > > > > > > > > > > remove-reset-rescan procedure. As discussed in other =
thread, this reset
> > > > > > > > > > > let device in unconfigured / broken state. =20
> > > > > > > > > >
> > > > > > > > > > No, there's not:
> > > > > > > > > >
> > > > > > > > > > int pci_reset_function(struct pci_dev *dev)
> > > > > > > > > > {
> > > > > > > > > >         int rc;
> > > > > > > > > >
> > > > > > > > > >         if (!dev->reset_fn)
> > > > > > > > > >                 return -ENOTTY;
> > > > > > > > > >
> > > > > > > > > >         pci_dev_lock(dev); =20
> > > > > > > > > > >>>     pci_dev_save_and_disable(dev); =20
> > > > > > > > > >
> > > > > > > > > >         rc =3D __pci_reset_function_locked(dev);
> > > > > > > > > > =20
> > > > > > > > > > >>>     pci_dev_restore(dev); =20
> > > > > > > > > >         pci_dev_unlock(dev);
> > > > > > > > > >
> > > > > > > > > >         return rc;
> > > > > > > > > > }
> > > > > > > > > >
> > > > > > > > > > The remove/re-scan was discussed primarily because your=
 patch performed
> > > > > > > > > > a bus reset regardless of what devices were affected by=
 that reset and
> > > > > > > > > > it's difficult to manage the scope where multiple devic=
es are affected.
> > > > > > > > > > Here, the bus and slot reset functions will fail unless=
 the scope is
> > > > > > > > > > limited to the single device triggering this reset.  Th=
anks,
> > > > > > > > > >
> > > > > > > > > > Alex
> > > > > > > > > > =20
> > > > > > > > >
> > > > > > > > > I was thinking a bit more about it and I'm really sure ho=
w it would
> > > > > > > > > behave with hotplugging PCIe bridge.
> > > > > > > > >
> > > > > > > > > On aardvark PCIe controller I have already tested that se=
condary bus
> > > > > > > > > reset bit is triggering Hot Reset event and then also Lin=
k Down event.
> > > > > > > > > These events are not handled by aardvark driver yet (need=
s to
> > > > > > > > > implemented into kernel's emulated root bridge code).
> > > > > > > > >
> > > > > > > > > But I'm not sure how it would behave on real HW PCIe hotp=
lugging bridge.
> > > > > > > > > Kernel has already code which removes PCIe device if it c=
hanges presence
> > > > > > > > > bit (and inform via interrupt). And Link Down event trigg=
ers this
> > > > > > > > > change. =20
> > > > > > > >
> > > > > > > > This is the difference between slot and bus resets, the slo=
t reset is
> > > > > > > > implemented by the hotplug controller and disables presence=
 detection
> > > > > > > > around the bus reset.  Thanks, =20
> > > > > > >
> > > > > > > Yes, but I'm talking about bus reset, not about slot reset.
> > > > > > >
> > > > > > > I mean: to use bus reset via sysfs on hardware which supports=
 slots and
> > > > > > > hotplugging.
> > > > > > >
> > > > > > > And if I'm reading code correctly, this combination is allowe=
d, right?
> > > > > > > Via these new patches it is possible to disable slot reset an=
d enable
> > > > > > > bus reset. =20
> > > > > >
> > > > > > That's true, a slot reset is simply a bus reset wrapped around =
code
> > > > > > that prevents the device from getting ejected. =20
> > > > >
> > > > > Yes, this makes slot reset "safe". But bus reset is "unsafe".
> > > > > =20
> > > > > > Maybe it would make
> > > > > > sense to combine the two as far as this interface is concerned,=
 ie. a
> > > > > > single "bus" reset method that will always use slot reset when
> > > > > > available.  Thanks, =20
> > > > >
> > > > > That should work when slot reset is available.
> > > > >
> > > > > Other option is that mentioned remove-reset-rescan procedure. =20
> > > >
> > > > That's not something we can introduce to the pci_reset_function() p=
ath
> > > > without a fair bit of collateral in using it through vfio-pci.
> > > > =20
> > > > > But quick search in drivers/pci/hotplug/ results that not all hot=
plug
> > > > > drivers implement reset_slot method.
> > > > >
> > > > > So there is a possible issue with hotplug driver which may eject =
device
> > > > > during bus reset (because e.g. slot reset is not implemented)? =20
> > > >
> > > > People aren't reporting it, so maybe those controllers aren't being
> > > > used for this use case.  Or maybe introducing this patch will make
> > > > these reset methods more readily accessible for testing.  We can fi=
x or
> > > > blacklist those controllers for bus reset when reports come in.  Th=
anks, =20
> > >
> > > Ok! I do not know neither if those controllers are used, but looks li=
ke
> > > that there are still changes in hotplug code.
> > >
> > > So I guess with these patches people can test it and report issues wh=
en
> > > such thing happen. =20
> > So after a bit research as I understood we need to group slot
> > and bus reset together in a single category of reset methods and
> > then implicitly use slot reset if it is available when bus reset is
> > enabled by the user.
> > Is that right? =20
>=20
> Yes, I understand it in same way. Just I do not know which name to
> choose for this reset category. In PCI spec it is called Secondary Bus
> Reset (as it resets whole bus with all devices; but we allow this reset
> in this patch series only if on the bus is connected exactly one device).
> In PCIe spec it is called Hot Reset. And if kernel detects Slot support
> then kernel currently calls it Slot reset. But it is still same thing.
> Any opinion? I think that we could call it Hot Reset as this patch
> series exports it only for single device (so calling it _bus_ is not the
> best match).

A similar abstraction where our scope is not limited to a single
function calls this a bus reset:

int pci_reset_bus(struct pci_dev *pdev)
{
        return (!pci_probe_reset_slot(pdev->slot)) ?
            __pci_reset_slot(pdev->slot) : __pci_reset_bus(pdev->bus);
}

Thanks,
Alex

