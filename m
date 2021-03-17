Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038B633F9A4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhCQUAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 16:00:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57049 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233264AbhCQUAZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 16:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616011225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbdHn9kRPm0gCl35CNyVLw2Hha448MfQSJpb/HnKTLs=;
        b=g1k+wyZh5XY6M+EiawgO7vVpHlw+VVCtRK218GBfwyljxXV101FK9bkZVBtIgTECx1ma8T
        OxUnu+OnFAWIJQx0hxwZAOaeDscEXPpRgO2l8W9SVEBlyVnWTmZg/N7wCNN79PvfsDUtrh
        UbH5VcqNYn6784ksdAiOhoZelNpjhes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-9VMxkENGOfSZJVXN_MuW0A-1; Wed, 17 Mar 2021 16:00:23 -0400
X-MC-Unique: 9VMxkENGOfSZJVXN_MuW0A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7462107ACCA;
        Wed, 17 Mar 2021 20:00:21 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 492065D9C0;
        Wed, 17 Mar 2021 20:00:21 +0000 (UTC)
Date:   Wed, 17 Mar 2021 14:00:20 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210317140020.4375ba76@omen.home.shazbot.org>
In-Reply-To: <20210317194024.nkzrbbvi6utoznze@pali>
References: <20210314235545.girtrazsdxtrqo2q@pali>
        <20210315134323.llz2o7yhezwgealp@archlinux>
        <20210315135226.avwmnhkfsgof6ihw@pali>
        <20210315083409.08b1359b@x1.home.shazbot.org>
        <20210315145238.6sg5deblr2z2pupu@pali>
        <20210315090339.54546e91@x1.home.shazbot.org>
        <20210317190206.zrtzwgskxdogl7dz@pali>
        <20210317131536.38f398b0@omen.home.shazbot.org>
        <20210317192424.kpfybcrsen3ivr4f@pali>
        <20210317133245.7d95909c@omen.home.shazbot.org>
        <20210317194024.nkzrbbvi6utoznze@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Mar 2021 20:40:24 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Wednesday 17 March 2021 13:32:45 Alex Williamson wrote:
> > On Wed, 17 Mar 2021 20:24:24 +0100
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > On Wednesday 17 March 2021 13:15:36 Alex Williamson wrote: =20
> > > > On Wed, 17 Mar 2021 20:02:06 +0100
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >    =20
> > > > > On Monday 15 March 2021 09:03:39 Alex Williamson wrote:   =20
> > > > > > On Mon, 15 Mar 2021 15:52:38 +0100
> > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > >      =20
> > > > > > > On Monday 15 March 2021 08:34:09 Alex Williamson wrote:     =
=20
> > > > > > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > > > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > > > > > >        =20
> > > > > > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:    =
   =20
> > > > > > > > > > slot reset (pci_dev_reset_slot_function) and secondary =
bus
> > > > > > > > > > reset(pci_parent_bus_reset) which I think are hot reset=
 and
> > > > > > > > > > warm reset respectively.         =20
> > > > > > > > >=20
> > > > > > > > > No. PCI secondary bus reset =3D PCIe Hot Reset. Slot rese=
t is just another
> > > > > > > > > type of reset, which is currently implemented only for PC=
Ie hot plug
> > > > > > > > > bridges and for PowerPC PowerNV platform and it just call=
 PCI secondary
> > > > > > > > > bus reset with some other hook. PCIe Warm Reset does not =
have API in
> > > > > > > > > kernel and therefore drivers do not export this type of r=
eset via any
> > > > > > > > > kernel function (yet).       =20
> > > > > > > >=20
> > > > > > > > Warm reset is beyond the scope of this series, but could be=
 implemented
> > > > > > > > in a compatible way to fit within the pci_reset_fn_methods[=
] array
> > > > > > > > defined here.       =20
> > > > > > >=20
> > > > > > > Ok!
> > > > > > >      =20
> > > > > > > > Note that with this series the resets available through
> > > > > > > > pci_reset_function() and the per device reset attribute is =
sysfs remain
> > > > > > > > exactly the same as they are currently.  The bus and slot r=
eset
> > > > > > > > methods used here are limited to devices where only a singl=
e function is
> > > > > > > > affected by the reset, therefore it is not like the patch y=
ou proposed
> > > > > > > > which performed a reset irrespective of the downstream devi=
ces.  This
> > > > > > > > series only enables selection of the existing methods.  Tha=
nks,
> > > > > > > >=20
> > > > > > > > Alex
> > > > > > > >        =20
> > > > > > >=20
> > > > > > > But with this patch series, there is still an issue with PCI =
secondary
> > > > > > > bus reset mechanism as exported sysfs attribute does not do t=
hat
> > > > > > > remove-reset-rescan procedure. As discussed in other thread, =
this reset
> > > > > > > let device in unconfigured / broken state.     =20
> > > > > >=20
> > > > > > No, there's not:
> > > > > >=20
> > > > > > int pci_reset_function(struct pci_dev *dev)
> > > > > > {
> > > > > >         int rc;
> > > > > >=20
> > > > > >         if (!dev->reset_fn)
> > > > > >                 return -ENOTTY;
> > > > > >=20
> > > > > >         pci_dev_lock(dev);     =20
> > > > > > >>>     pci_dev_save_and_disable(dev);     =20
> > > > > >=20
> > > > > >         rc =3D __pci_reset_function_locked(dev);
> > > > > >      =20
> > > > > > >>>     pci_dev_restore(dev);     =20
> > > > > >         pci_dev_unlock(dev);
> > > > > >=20
> > > > > >         return rc;
> > > > > > }
> > > > > >=20
> > > > > > The remove/re-scan was discussed primarily because your patch p=
erformed
> > > > > > a bus reset regardless of what devices were affected by that re=
set and
> > > > > > it's difficult to manage the scope where multiple devices are a=
ffected.
> > > > > > Here, the bus and slot reset functions will fail unless the sco=
pe is
> > > > > > limited to the single device triggering this reset.  Thanks,
> > > > > >=20
> > > > > > Alex
> > > > > >      =20
> > > > >=20
> > > > > I was thinking a bit more about it and I'm really sure how it wou=
ld
> > > > > behave with hotplugging PCIe bridge.
> > > > >=20
> > > > > On aardvark PCIe controller I have already tested that secondary =
bus
> > > > > reset bit is triggering Hot Reset event and then also Link Down e=
vent.
> > > > > These events are not handled by aardvark driver yet (needs to
> > > > > implemented into kernel's emulated root bridge code).
> > > > >=20
> > > > > But I'm not sure how it would behave on real HW PCIe hotplugging =
bridge.
> > > > > Kernel has already code which removes PCIe device if it changes p=
resence
> > > > > bit (and inform via interrupt). And Link Down event triggers this
> > > > > change.   =20
> > > >=20
> > > > This is the difference between slot and bus resets, the slot reset =
is
> > > > implemented by the hotplug controller and disables presence detecti=
on
> > > > around the bus reset.  Thanks,   =20
> > >=20
> > > Yes, but I'm talking about bus reset, not about slot reset.
> > >=20
> > > I mean: to use bus reset via sysfs on hardware which supports slots a=
nd
> > > hotplugging.
> > >=20
> > > And if I'm reading code correctly, this combination is allowed, right?
> > > Via these new patches it is possible to disable slot reset and enable
> > > bus reset. =20
> >=20
> > That's true, a slot reset is simply a bus reset wrapped around code
> > that prevents the device from getting ejected. =20
>=20
> Yes, this makes slot reset "safe". But bus reset is "unsafe".
>=20
> > Maybe it would make
> > sense to combine the two as far as this interface is concerned, ie. a
> > single "bus" reset method that will always use slot reset when
> > available.  Thanks, =20
>=20
> That should work when slot reset is available.
>=20
> Other option is that mentioned remove-reset-rescan procedure.

That's not something we can introduce to the pci_reset_function() path
without a fair bit of collateral in using it through vfio-pci.

> But quick search in drivers/pci/hotplug/ results that not all hotplug
> drivers implement reset_slot method.
>=20
> So there is a possible issue with hotplug driver which may eject device
> during bus reset (because e.g. slot reset is not implemented)?

People aren't reporting it, so maybe those controllers aren't being
used for this use case.  Or maybe introducing this patch will make
these reset methods more readily accessible for testing.  We can fix or
blacklist those controllers for bus reset when reports come in.  Thanks,

Alex

