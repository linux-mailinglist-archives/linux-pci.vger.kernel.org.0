Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA9D33F8EF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 20:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhCQTPq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 15:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233114AbhCQTPl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 15:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616008541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yM4xDSHA3fcLaInO4o7SmhXwjEm2lW0qS1nkTCy7yqM=;
        b=aSdgxAcZxnrDcuu4uLVU8dUEMNZDqiK/sAO/g9OqSqz4Inj/lJ0CmmdDaO5lVn2ry98/iG
        SrHZV4ULWIYgpsapPHIyjxusWXSzL7xDOef1N4hKUAWpuN0wQF2SSyR79chAw/nQvh44Zc
        l8hdyOUWWHm6ZYfdgwhpcSqD5v9fV68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-CrHOvYEUNOO1WITzJ9RoDg-1; Wed, 17 Mar 2021 15:15:39 -0400
X-MC-Unique: CrHOvYEUNOO1WITzJ9RoDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 995C081620;
        Wed, 17 Mar 2021 19:15:37 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com [10.3.112.255])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BF6A648A2;
        Wed, 17 Mar 2021 19:15:37 +0000 (UTC)
Date:   Wed, 17 Mar 2021 13:15:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>, bhelgaas@google.com,
        raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/4] PCI/sysfs: Allow userspace to query and set device
 reset mechanism
Message-ID: <20210317131536.38f398b0@omen.home.shazbot.org>
In-Reply-To: <20210317190206.zrtzwgskxdogl7dz@pali>
References: <20210312173452.3855-1-ameynarkhede03@gmail.com>
        <20210312173452.3855-5-ameynarkhede03@gmail.com>
        <20210314235545.girtrazsdxtrqo2q@pali>
        <20210315134323.llz2o7yhezwgealp@archlinux>
        <20210315135226.avwmnhkfsgof6ihw@pali>
        <20210315083409.08b1359b@x1.home.shazbot.org>
        <20210315145238.6sg5deblr2z2pupu@pali>
        <20210315090339.54546e91@x1.home.shazbot.org>
        <20210317190206.zrtzwgskxdogl7dz@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 17 Mar 2021 20:02:06 +0100
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Monday 15 March 2021 09:03:39 Alex Williamson wrote:
> > On Mon, 15 Mar 2021 15:52:38 +0100
> > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> >  =20
> > > On Monday 15 March 2021 08:34:09 Alex Williamson wrote: =20
> > > > On Mon, 15 Mar 2021 14:52:26 +0100
> > > > Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > > >    =20
> > > > > On Monday 15 March 2021 19:13:23 Amey Narkhede wrote:   =20
> > > > > > slot reset (pci_dev_reset_slot_function) and secondary bus
> > > > > > reset(pci_parent_bus_reset) which I think are hot reset and
> > > > > > warm reset respectively.     =20
> > > > >=20
> > > > > No. PCI secondary bus reset =3D PCIe Hot Reset. Slot reset is jus=
t another
> > > > > type of reset, which is currently implemented only for PCIe hot p=
lug
> > > > > bridges and for PowerPC PowerNV platform and it just call PCI sec=
ondary
> > > > > bus reset with some other hook. PCIe Warm Reset does not have API=
 in
> > > > > kernel and therefore drivers do not export this type of reset via=
 any
> > > > > kernel function (yet).   =20
> > > >=20
> > > > Warm reset is beyond the scope of this series, but could be impleme=
nted
> > > > in a compatible way to fit within the pci_reset_fn_methods[] array
> > > > defined here.   =20
> > >=20
> > > Ok!
> > >  =20
> > > > Note that with this series the resets available through
> > > > pci_reset_function() and the per device reset attribute is sysfs re=
main
> > > > exactly the same as they are currently.  The bus and slot reset
> > > > methods used here are limited to devices where only a single functi=
on is
> > > > affected by the reset, therefore it is not like the patch you propo=
sed
> > > > which performed a reset irrespective of the downstream devices.  Th=
is
> > > > series only enables selection of the existing methods.  Thanks,
> > > >=20
> > > > Alex
> > > >    =20
> > >=20
> > > But with this patch series, there is still an issue with PCI secondary
> > > bus reset mechanism as exported sysfs attribute does not do that
> > > remove-reset-rescan procedure. As discussed in other thread, this res=
et
> > > let device in unconfigured / broken state. =20
> >=20
> > No, there's not:
> >=20
> > int pci_reset_function(struct pci_dev *dev)
> > {
> >         int rc;
> >=20
> >         if (!dev->reset_fn)
> >                 return -ENOTTY;
> >=20
> >         pci_dev_lock(dev); =20
> > >>>     pci_dev_save_and_disable(dev); =20
> >=20
> >         rc =3D __pci_reset_function_locked(dev);
> >  =20
> > >>>     pci_dev_restore(dev); =20
> >         pci_dev_unlock(dev);
> >=20
> >         return rc;
> > }
> >=20
> > The remove/re-scan was discussed primarily because your patch performed
> > a bus reset regardless of what devices were affected by that reset and
> > it's difficult to manage the scope where multiple devices are affected.
> > Here, the bus and slot reset functions will fail unless the scope is
> > limited to the single device triggering this reset.  Thanks,
> >=20
> > Alex
> >  =20
>=20
> I was thinking a bit more about it and I'm really sure how it would
> behave with hotplugging PCIe bridge.
>=20
> On aardvark PCIe controller I have already tested that secondary bus
> reset bit is triggering Hot Reset event and then also Link Down event.
> These events are not handled by aardvark driver yet (needs to
> implemented into kernel's emulated root bridge code).
>=20
> But I'm not sure how it would behave on real HW PCIe hotplugging bridge.
> Kernel has already code which removes PCIe device if it changes presence
> bit (and inform via interrupt). And Link Down event triggers this
> change.

This is the difference between slot and bus resets, the slot reset is
implemented by the hotplug controller and disables presence detection
around the bus reset.  Thanks,

Alex

