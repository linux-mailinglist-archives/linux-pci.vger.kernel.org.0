Return-Path: <linux-pci+bounces-9831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7102B9286CA
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 12:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 268C5285559
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 10:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A53148304;
	Fri,  5 Jul 2024 10:30:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D911474A5;
	Fri,  5 Jul 2024 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720175401; cv=none; b=k9EQoUsRbm1m73/COYhWypRLAArTVk9nGnlzQ+WInZ724ilJT9WueyxBQ7pzj95EJKlxf42Geqq80Jra1KSq1R0JWQf0Z6U2hnE/Bf7vXEo5Cy+G5tZIk3GCA4pxAnfFSzHI58PNO2zDgTvKYcP8sZ7l0uC3xaeAgZAdXB/cGnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720175401; c=relaxed/simple;
	bh=yFFmze1H5Kfxuphzf+WxW76hJgBDs2OHBU71tQurbfk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZEZDu1MDUGHx1kPwlvUN1Si4Ky4twcj+s28qqIvLR7ZfLolcLWzmIxQFTAxrMq2R0feEUYsJUgWnf6W+U//e2bGpldTEer8aVlZOseOsuuA24Kp4qvApiAH90qVXHSVRl23CAYrOtJkI6LKthc10O0dNJPSRgGfnQ9o3zh+ibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFqVj1gSPz67kSy;
	Fri,  5 Jul 2024 18:28:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 09DEE140B2A;
	Fri,  5 Jul 2024 18:29:55 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 11:29:54 +0100
Date: Fri, 5 Jul 2024 11:29:53 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20240705112953.00007303@Huawei.com>
In-Reply-To: <CAKmqyKPEX632ywm5DiKvVZU=hr-yHNBJ=tcN2DasKpfWdykgZg@mail.gmail.com>
References: <20240702060418.387500-1-alistair.francis@wdc.com>
	<20240702060418.387500-3-alistair.francis@wdc.com>
	<20240702145806.0000669b@Huawei.com>
	<CAKmqyKPEX632ywm5DiKvVZU=hr-yHNBJ=tcN2DasKpfWdykgZg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 5 Jul 2024 11:24:25 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> On Tue, Jul 2, 2024 at 11:58=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue,  2 Jul 2024 16:04:17 +1000
> > Alistair Francis <alistair23@gmail.com> wrote:
> > =20
> > > The PCIe 6 specification added support for the Data Object
> > > Exchange (DOE).
> > > When DOE is supported the DOE Discovery Feature must be implemented p=
er
> > > PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> > > information about the other DOE features supported by the device.
> > >
> > > The kernel is already querying the DOE features supported and cacheing
> > > the values. Expose the values in sysfs to allow user space to
> > > determine which DOE features are supported by the PCIe device.
> > >
> > > By exposing the information to userspace tools like lspci can relay t=
he
> > > information to users. By listing all of the supported features we can
> > > allow userspace to parse the list, which might include
> > > vendor specific features as well as yet to be supported features.
> > >
> > > After this patch is supported you can see something like this when
> > > attaching a DOE device
> > >
> > > $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> > > 0001:00        0001:01        0001:02
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > > v13:
> > >  - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
> > >      - As discussed in https://lore.kernel.org/all/20231019165829.GA1=
381099@bhelgaas/
> > >        we can just modify pci_doe_sysfs_group at the DOE init and let=
 =20
> >
> > Can't do that as it is global so you expose the same DOE features for
> > all DOEs.
> >
> > Also, I think that this is only processing features on last doe_mb found
> > for a given device. Fix that and the duplicates problem resurfaces.
> >
> > =20
> > >        device_add() handle the sysfs attributes. =20
> >
> > =20
> > > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > > index defc4be81bd4..e7b702afce88 100644
> > > --- a/drivers/pci/doe.c
> > > +++ b/drivers/pci/doe.c =20
> > =20
> > > +
> > >  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long tim=
eout)
> > >  {
> > >       if (wait_event_timeout(doe_mb->wq,
> > > @@ -687,6 +747,12 @@ void pci_doe_init(struct pci_dev *pdev)
> > >  {
> > >       struct pci_doe_mb *doe_mb;
> > >       u16 offset =3D 0;
> > > +     struct attribute **sysfs_attrs;
> > > +     struct device_attribute *attrs;
> > > +     unsigned long num_features =3D 0;
> > > +     unsigned long i;
> > > +     unsigned long vid, type;
> > > +     void *entry;
> > >       int rc;
> > >
> > >       xa_init(&pdev->doe_mbs);
> > > @@ -707,6 +773,45 @@ void pci_doe_init(struct pci_dev *pdev)
> > >                       pci_doe_destroy_mb(doe_mb);
> > >               }
> > >       } =20
> >
> > The above is looping over multiple DOEs but this just considers last on=
e.
> > That doesn't look right... =20
>=20
> Yeah... That isn't
>=20
> >
> > I think this needs to be in the loop and having done that
> > the duplicate handing may be an issue.  I'm not sure what happens
> > in that path with a presupplied set of attributes.
> > =20
> > > +
> > > +     if (doe_mb) {
> > > +             xa_for_each(&doe_mb->feats, i, entry)
> > > +                     num_features++;
> > > +
> > > +             sysfs_attrs =3D kcalloc(num_features + 1, sizeof(*sysfs=
_attrs), GFP_KERNEL);
> > > +             if (!sysfs_attrs)
> > > +                     return;
> > > +
> > > +             attrs =3D kcalloc(num_features, sizeof(*attrs), GFP_KER=
NEL);
> > > +             if (!attrs) {
> > > +                     kfree(sysfs_attrs);
> > > +                     return;
> > > +             }
> > > +
> > > +             doe_mb->device_attrs =3D attrs;
> > > +             doe_mb->sysfs_attrs =3D sysfs_attrs;
> > > +
> > > +             xa_for_each(&doe_mb->feats, i, entry) {
> > > +                     sysfs_attr_init(&attrs[i].attr);
> > > +
> > > +                     vid =3D xa_to_value(entry) >> 8;
> > > +                     type =3D xa_to_value(entry) & 0xFF;
> > > +
> > > +                     attrs[i].attr.name =3D kasprintf(GFP_KERNEL, "%=
04lx:%02lx", vid, type);
> > > +                     if (!attrs[i].attr.name) {
> > > +                             pci_doe_sysfs_feature_remove(pdev, doe_=
mb);
> > > +                             return;
> > > +                     }
> > > +                     attrs[i].attr.mode =3D 0444;
> > > +                     attrs[i].show =3D pci_doe_sysfs_feature_show;
> > > +
> > > +                     sysfs_attrs[i] =3D &attrs[i].attr;
> > > +             }
> > > +
> > > +             sysfs_attrs[num_features] =3D NULL;
> > > +
> > > +             pci_doe_sysfs_group.attrs =3D sysfs_attrs; =20
> > Hmm. Isn't this global?  What if you have multiple devices. =20
>=20
> Any input from a PCI maintainer here?
>=20
> There are basically two approaches.
>=20
>  1. We can have a pci_doe_sysfs_init() function that is called where
> we dynamically add the entries, like in v12
>  2. We can go down the dev->groups and device_add() path, like this
> patch and discussed at
> https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
>=20
> For the second we will have to create a global pci_doe_sysfs_group
> that contains all possible DOE entries on the system and then have the
> show functions determine if they should be displayed for that device.
>=20
> Everytime we call pci_doe_init() we can check for any missing entries
> in pci_doe_sysfs_group.attrs and then realloc
> pci_doe_sysfs_group.attrs to add them.=20
> Untested, but that should work
> even for hot-plugged devices. pci_doe_sysfs_group.attrs would just
> grow forever though as I don't think we have an easy way to deallocate
> anything as we aren't sure if we are the only entry.

I think this needs to be per device, not global and you'll have to manually
do the group visibility magic rather than using the macros.

>=20
> Thoughts?
>=20
> Alistair


