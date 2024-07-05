Return-Path: <linux-pci+bounces-9824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D7E927FBE
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 03:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1471B20EF3
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 01:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC67EAC5;
	Fri,  5 Jul 2024 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaDZlbp+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F045033DD;
	Fri,  5 Jul 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142694; cv=none; b=o+Bz37lnIdk9qSfTbxJ2DdIle4PcO+T4bc29BsjSKq5lsUxRs+msi14qAoi5MF8lqy/xHqTksouxUd6SDb7Hss/CN+qniDr4pRCSPujUMu8cLyHGRkwcJYbRM3sCSFW1ZC5DSSRToRMQwiyr7oRjZIM5BaHBaIE7NZOKkprRu1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142694; c=relaxed/simple;
	bh=Fgj8tbj91yyhS/Vj4oRJpCZVDxl3ws8xvqFaTEtx97A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKrFZP1jEcWZPoV7fYAQeXWcnTbbw0eTE/tgk7kfgSglxY6pFb1nnWKjTXQHP62zVk2twsG6laHuSaZqVawvXE8n0+SBVj6kL/W3v/EEvl14teS6DqjrTDp1cNNvhwvPyoLdSz/hLt521AqhQFPBKhnstmuJHm8ZuPeFcWyt4xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaDZlbp+; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4f2ea4d80d6so396562e0c.2;
        Thu, 04 Jul 2024 18:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720142692; x=1720747492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TCgQDZcwng8bXM5BPYmuZDEk5bETYHoKH5imxDkoNw=;
        b=kaDZlbp+oKANSrOw6kPz454eYKeG+PmNZQbgvXNtIoKJVeNc7ShFapguZsgrl+UlLH
         jEEEz2lfrflF/WSADDtCY78oN0icEO04AimktHYUbHrcqQn+EwChMNpF6tcW3M85X3KZ
         uMVJlqpbwJfmzX5x+Sxi5ydI6QDiikxFO+GDNpCzKuCWmnM94x5712JDLgu1iMYwi+XT
         v4XDsaEAudByuCISnCILCz8pUfIr97FJZilUbs40t7PhJLBI2cAMwcJZkj4ZhXAcef97
         WXA8xJmpyNT2h32b/D2+F2qG34ud7U/u0uCfPl/tZZw54uQiXx7G6xulD3dNQf9O5FBn
         +FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142692; x=1720747492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TCgQDZcwng8bXM5BPYmuZDEk5bETYHoKH5imxDkoNw=;
        b=nAKGgca3rbwr7p06qTM/4DZydetFxG5u1JuzPIl+w/NIyYLsRUtWdiwZpDTrKPyIZC
         EGLakj3GroOj2wTAZLN5QIxOx4pStuqlPp9ZJabgeswYwIiTyJhP3e8dhwCYoKZN9N8u
         QHcAq7swCuYp2T6g3XpsxlrVaK7WLlkJTLB2/wDw/0yZryfedlCyiAAZ0BeWQgN+WBmU
         NqWGsvCIPdsieO6OF967zH4c9SI45MZ1IaZ57tb7y3XmY5NuXfYAKheT0O1GF/LMdcWV
         OGp/drjBPEEU3Nmo+4S05fBWc2DNPm7fAdGwKIqU1wIeDpKdY+oID/NQ/DWCHrnY+q3a
         d93A==
X-Forwarded-Encrypted: i=1; AJvYcCUGJq1cathPtfQWoTVCx9my3QkNqeql9LGOG6/ZYHIXZFHlgyejfb2CnR6E20RiibKNvKt2oRLN0KObMqV4UU8O4shtz+hDy9pU9S99+aQvzrKVnzYwgF9lNAOuJjrCuUOUT44dZr4I
X-Gm-Message-State: AOJu0Yz1I8dHdIUaCAJ54dkFGhdxCim2uhMe/P1t6wSBFT3eZqOMRwfH
	gcrCE+hRZnOYw0pnu8A3ev9iePTOf9SK8QmZybFt0p7lC8M8+wigiSTc26DHl8aY3gX3uWAqrZd
	lBtKJyMXHuRfEQfiDVkvVmgXEw3M34saL
X-Google-Smtp-Source: AGHT+IG2WtReVuVppXAmKVRmFBS9mPu9FFYDWdrZ1dEdPQ+YNP8wCPhUls6aSK2NWBqqZqqHRHZB8s7kL0xSK1yk/m4=
X-Received: by 2002:a05:6122:1b10:b0:4ea:edfb:8d89 with SMTP id
 71dfb90a1353d-4f2f3f518b5mr3181388e0c.12.1720142691734; Thu, 04 Jul 2024
 18:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702060418.387500-1-alistair.francis@wdc.com>
 <20240702060418.387500-3-alistair.francis@wdc.com> <20240702145806.0000669b@Huawei.com>
In-Reply-To: <20240702145806.0000669b@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 5 Jul 2024 11:24:25 +1000
Message-ID: <CAKmqyKPEX632ywm5DiKvVZU=hr-yHNBJ=tcN2DasKpfWdykgZg@mail.gmail.com>
Subject: Re: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de, 
	alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
	gregkh@linuxfoundation.org, logang@deltatee.com, linux-kernel@vger.kernel.org, 
	chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 11:58=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue,  2 Jul 2024 16:04:17 +1000
> Alistair Francis <alistair23@gmail.com> wrote:
>
> > The PCIe 6 specification added support for the Data Object
> > Exchange (DOE).
> > When DOE is supported the DOE Discovery Feature must be implemented per
> > PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> > information about the other DOE features supported by the device.
> >
> > The kernel is already querying the DOE features supported and cacheing
> > the values. Expose the values in sysfs to allow user space to
> > determine which DOE features are supported by the PCIe device.
> >
> > By exposing the information to userspace tools like lspci can relay the
> > information to users. By listing all of the supported features we can
> > allow userspace to parse the list, which might include
> > vendor specific features as well as yet to be supported features.
> >
> > After this patch is supported you can see something like this when
> > attaching a DOE device
> >
> > $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> > 0001:00        0001:01        0001:02
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v13:
> >  - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
> >      - As discussed in https://lore.kernel.org/all/20231019165829.GA138=
1099@bhelgaas/
> >        we can just modify pci_doe_sysfs_group at the DOE init and let
>
> Can't do that as it is global so you expose the same DOE features for
> all DOEs.
>
> Also, I think that this is only processing features on last doe_mb found
> for a given device. Fix that and the duplicates problem resurfaces.
>
>
> >        device_add() handle the sysfs attributes.
>
>
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index defc4be81bd4..e7b702afce88 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
>
> > +
> >  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeo=
ut)
> >  {
> >       if (wait_event_timeout(doe_mb->wq,
> > @@ -687,6 +747,12 @@ void pci_doe_init(struct pci_dev *pdev)
> >  {
> >       struct pci_doe_mb *doe_mb;
> >       u16 offset =3D 0;
> > +     struct attribute **sysfs_attrs;
> > +     struct device_attribute *attrs;
> > +     unsigned long num_features =3D 0;
> > +     unsigned long i;
> > +     unsigned long vid, type;
> > +     void *entry;
> >       int rc;
> >
> >       xa_init(&pdev->doe_mbs);
> > @@ -707,6 +773,45 @@ void pci_doe_init(struct pci_dev *pdev)
> >                       pci_doe_destroy_mb(doe_mb);
> >               }
> >       }
>
> The above is looping over multiple DOEs but this just considers last one.
> That doesn't look right...

Yeah... That isn't

>
> I think this needs to be in the loop and having done that
> the duplicate handing may be an issue.  I'm not sure what happens
> in that path with a presupplied set of attributes.
>
> > +
> > +     if (doe_mb) {
> > +             xa_for_each(&doe_mb->feats, i, entry)
> > +                     num_features++;
> > +
> > +             sysfs_attrs =3D kcalloc(num_features + 1, sizeof(*sysfs_a=
ttrs), GFP_KERNEL);
> > +             if (!sysfs_attrs)
> > +                     return;
> > +
> > +             attrs =3D kcalloc(num_features, sizeof(*attrs), GFP_KERNE=
L);
> > +             if (!attrs) {
> > +                     kfree(sysfs_attrs);
> > +                     return;
> > +             }
> > +
> > +             doe_mb->device_attrs =3D attrs;
> > +             doe_mb->sysfs_attrs =3D sysfs_attrs;
> > +
> > +             xa_for_each(&doe_mb->feats, i, entry) {
> > +                     sysfs_attr_init(&attrs[i].attr);
> > +
> > +                     vid =3D xa_to_value(entry) >> 8;
> > +                     type =3D xa_to_value(entry) & 0xFF;
> > +
> > +                     attrs[i].attr.name =3D kasprintf(GFP_KERNEL, "%04=
lx:%02lx", vid, type);
> > +                     if (!attrs[i].attr.name) {
> > +                             pci_doe_sysfs_feature_remove(pdev, doe_mb=
);
> > +                             return;
> > +                     }
> > +                     attrs[i].attr.mode =3D 0444;
> > +                     attrs[i].show =3D pci_doe_sysfs_feature_show;
> > +
> > +                     sysfs_attrs[i] =3D &attrs[i].attr;
> > +             }
> > +
> > +             sysfs_attrs[num_features] =3D NULL;
> > +
> > +             pci_doe_sysfs_group.attrs =3D sysfs_attrs;
> Hmm. Isn't this global?  What if you have multiple devices.

Any input from a PCI maintainer here?

There are basically two approaches.

 1. We can have a pci_doe_sysfs_init() function that is called where
we dynamically add the entries, like in v12
 2. We can go down the dev->groups and device_add() path, like this
patch and discussed at
https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/

For the second we will have to create a global pci_doe_sysfs_group
that contains all possible DOE entries on the system and then have the
show functions determine if they should be displayed for that device.

Everytime we call pci_doe_init() we can check for any missing entries
in pci_doe_sysfs_group.attrs and then realloc
pci_doe_sysfs_group.attrs to add them. Untested, but that should work
even for hot-plugged devices. pci_doe_sysfs_group.attrs would just
grow forever though as I don't think we have an easy way to deallocate
anything as we aren't sure if we are the only entry.

Thoughts?

Alistair

