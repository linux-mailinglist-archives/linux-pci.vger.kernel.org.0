Return-Path: <linux-pci+bounces-8428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4A28FFB4D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 07:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32C91C24E22
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 05:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A681CAAD;
	Fri,  7 Jun 2024 05:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1HxqtJ7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD2B1CAB5;
	Fri,  7 Jun 2024 05:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717738205; cv=none; b=EZAMlpSXHKcj8soOb/VNSchJ+9EVinDff8jbMEfD8FLYxONYEyZWZBgh/BjbhOv7WxHU1NUn3bGyyOmVKau+tMVuGwN5Y1txuLzUElBRsITS08Wv7X+tKTUej/2Aun3X4F/KjwxjzrHJQg+lqXDYLm5jkCKNsrc3NMaQBTjnxoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717738205; c=relaxed/simple;
	bh=JNsYg7IgY/rGtWW1IdUtrLdC0SGymdQEPNHvabe0qBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpmwjm4WYwH+zfDFmcA8spP+GZOu7WoCfQszmPHjDlQBvvR4j3lHKm/mZFsdTVx2qTi4xdqZZaJQ4w1ZA/eVmmS5zulwECyMrZJpLnk6ouO1GtEhTgAsONH32Uxj/w2Xx/lLQRMmSyU6ApLVwcyEgMumB2xYByUPYeXGuQ/2MWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1HxqtJ7; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-48bdcecf6efso620958137.3;
        Thu, 06 Jun 2024 22:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717738202; x=1718343002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4dokQkRuIX28srFwm2T3xaISBHBgBdWh4n8GgTWxnE=;
        b=c1HxqtJ77qyqIkSML21sCQKuwu8GbhudCHPAhH85SJKlb9wdr8SFjfUAHdZzQv4hHY
         JgeERqx3wl55iLRETzoRoNaxov1PJqpBxEtazY+awz9U7dDSlLc+qOjI5qV81eWvHMib
         XZ6Q/kroODCiE3H9aXrB7l0NLg5QzR1kT+CY1lhafsYBPOTIG8qSfF1uqBsgtaJk6qSj
         B8l+duvTp4mPlQ4K+BziizUFrwEwF5qqPCWC2UFMbuqglsvACPDKCx3VV3ThpBB53W4l
         qUFJcHINYTn2zLcmJeRtIuCV/U8lcWCQLICkkjWVBkl4yriYSkcOjU+nDDtaSjQrw5jm
         uLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717738202; x=1718343002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4dokQkRuIX28srFwm2T3xaISBHBgBdWh4n8GgTWxnE=;
        b=beDkOjdcyYo7dnjhs8eAgI5iU6/Jgls3Z0wEh6DtMuNBPmpsJQggg2ZG0B62kEVrst
         YvXnzTCysqiRRhs+N6KzZbaDADUx99YuUypoJKGoWVxfJPyS6jidMxu+bjF2M+2ISAbR
         C6TiXCrc9JDrq1BCtpMt0sn9u/zGQdlDBcPb2aSyCYPNXsJ7cKsbQwJtK/YpE90sGYz5
         koodAtxbPghfVWCUqqne60POrJs6Fuvk62JI20sn42uwU0gRmBmpeE2LiX8esANqYDSB
         LpNj5+1YxetJDzhQ9L7uHivApzSy00+VgRmpAGKMMIT0r9QN+YXACCculvRQ4chAsb0h
         YM3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVK+0aTOwI1Kqp/SAhLLE1TTLqJKfz68KO6jm8jGTcTRgMO75KW5gBqUD4UVmw1MvjCby5XNbVaoPOJago78xPLNZvjfUFlsSfyhK6+jtsCeONwtDnB2kl6u1rtbK7LEaQ/tt87HRZ0
X-Gm-Message-State: AOJu0YypmqzhczG4ZGDYb+OtnG6xl4DkcV06aaqfZxkxhS2E8G6IgRh9
	ZsR1slklE3PjpDGZQ1ht2vhTWikCIYRFJd8mLUASFZveMicEnSgq1uvXcStnIbK8JJxEGZHVvBQ
	DUmTOeJ1ENhiZ5O7CCWXNhW3tuI8=
X-Google-Smtp-Source: AGHT+IHX0st7rknp+WdI2lIpnKYcXMs5BTOOEXlhPEVIa4If6gQMRsX78xwjT4hMwvv6UXDOlQ2zY/8ZXqbruhDi4SE=
X-Received: by 2002:a05:6102:2135:b0:48b:f61b:75ac with SMTP id
 ada2fe7eead31-48c275519afmr1358365137.11.1717738202016; Thu, 06 Jun 2024
 22:30:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522101142.559733-1-alistair.francis@wdc.com>
 <20240522101142.559733-3-alistair.francis@wdc.com> <20240523122448.0000799f@Huawei.com>
In-Reply-To: <20240523122448.0000799f@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 7 Jun 2024 15:29:35 +1000
Message-ID: <CAKmqyKOorOx71y5T-O6HcZWP-CpU=9=0QkRUq5VLa+FqZpaEOA@mail.gmail.com>
Subject: Re: [PATCH v10 3/4] PCI/DOE: Expose the DOE features via sysfs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de, 
	alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
	gregkh@linuxfoundation.org, logang@deltatee.com, linux-kernel@vger.kernel.org, 
	chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 9:24=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 22 May 2024 20:11:41 +1000
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
> > As the DOE Discovery feature must always be supported we treat it as a
> > special named attribute case. This allows the usual PCI attribute_group
> > handling to correctly create the doe_features directory when registerin=
g
> > pci_doe_sysfs_group (otherwise it doesn't and sysfs_add_file_to_group()
> > will seg fault).
> >
> > After this patch is supported you can see something like this when
> > attaching a DOE device
> >
> > $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> > 0001:01        0001:02        doe_discovery
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> What happens if multiple DOE which support the same protocol?
> (IIRC that's allowed).  You probably need to paper over repeat
> sysfs attributes and make sure they don't get double freed etc.

Fair point. I changed pci_doe_sysfs_feature_populate() to not fall
over if the entry already exists, we just skip adding it.

pci_doe_sysfs_feature_remove() should already handle double entries
with the attrs[i].show check.

>
> Otherwise some minor things inline.
>
> Jonathan
>
>
> > ---
> > v10:
> >  - Rebase to use DEFINE_SYSFS_GROUP_VISIBLE and remove
> >    special setup function
> > v9:
> >  - Add a teardown function
> >  - Rename functions to be clearer
> >  - Tidy up the commit message
> >  - Remove #ifdef from header
> > v8:
> >  - Inlucde an example in the docs
> >  - Fixup removing a file that wasn't added
> >  - Remove a blank line
> > v7:
> >  - Fixup the #ifdefs to keep the test robot happy
> > v6:
> >  - Use "feature" instead of protocol
> >  - Don't use any devm_* functions
> >  - Add two more patches to the series
> > v5:
> >  - Return the file name as the file contents
> >  - Code cleanups and simplifications
> > v4:
> >  - Fixup typos in the documentation
> >  - Make it clear that the file names contain the information
> >  - Small code cleanups
> >  - Remove most #ifdefs
> >  - Remove extra NULL assignment
> > v3:
> >  - Expose each DOE feature as a separate file
> > v2:
> >  - Add documentation
> >  - Code cleanups
> >
> >  Documentation/ABI/testing/sysfs-bus-pci |  28 ++++
> >  drivers/pci/doe.c                       | 175 ++++++++++++++++++++++++
> >  drivers/pci/pci-sysfs.c                 |  13 ++
> >  drivers/pci/pci.h                       |  10 ++
> >  4 files changed, 226 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/AB=
I/testing/sysfs-bus-pci
> > index ecf47559f495..65a3238ab701 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-pci
> > +++ b/Documentation/ABI/testing/sysfs-bus-pci
> > @@ -500,3 +500,31 @@ Description:
> >               console drivers from the device.  Raw users of pci-sysfs
> >               resourceN attributes must be terminated prior to resizing=
.
> >               Success of the resizing operation is not guaranteed.
> > +
> > +What:                /sys/bus/pci/devices/.../doe_features
> > +Date:                May 2024
> > +Contact:     Linux PCI developers <linux-pci@vger.kernel.org>
> > +Description:
> > +             This directory contains a list of the supported
> > +             Data Object Exchange (DOE) features. The features are
> > +             the file name. The contents of each file is the raw vendo=
r id and
> > +             data object feature values.
> > +
> > +             The value comes from the device and specifies the vendor =
and
> > +             data object type supported. The lower (RHS of the colon) =
is
> > +             the data object type in hex. The upper (LHS of the colon)
> > +             is the vendor ID.
> > +
> > +             As all DOE devices must support the DOE discovery protoco=
l, if
> > +             DOE is supported you will at least see the doe_discovery =
file, with
> > +             this contents
> > +
> > +             # cat doe_features/doe_discovery
> > +             0001:00
> > +
> > +             If the device supports other protocols you will see other=
 files
> > +             as well. For example is CMA/SPDM and secure CMA/SPDM are =
supported
> > +             the doe_features directory will look like this
> > +
> > +             # ls doe_features
> > +             0001:01        0001:02        doe_discovery
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index defc4be81bd4..7a20a257df5a 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
> > @@ -47,6 +47,7 @@
> >   * @wq: Wait queue for work item
> >   * @work_queue: Queue of pci_doe_work items
> >   * @flags: Bit array of PCI_DOE_FLAG_* flags
> > + * @sysfs_attrs: Array of sysfs device attributes
> >   */
> >  struct pci_doe_mb {
> >       struct pci_dev *pdev;
> > @@ -56,6 +57,10 @@ struct pci_doe_mb {
> >       wait_queue_head_t wq;
> >       struct workqueue_struct *work_queue;
> >       unsigned long flags;
> > +
> > +#ifdef CONFIG_SYSFS
> > +     struct device_attribute *sysfs_attrs;
> > +#endif
> >  };
> >
> >  struct pci_doe_feature {
> > @@ -92,6 +97,176 @@ struct pci_doe_task {
> >       struct pci_doe_mb *doe_mb;
> >  };
> >
> > +#ifdef CONFIG_SYSFS
> > +static ssize_t doe_discovery_show(struct device *dev,
> > +                               struct device_attribute *attr,
> > +                               char *buf)
> > +{
> > +     return sysfs_emit(buf, "0001:00\n");
> > +}
> > +DEVICE_ATTR_RO(doe_discovery);
> > +
> > +static struct attribute *pci_doe_sysfs_feature_attrs[] =3D {
> > +     &dev_attr_doe_discovery.attr,
> > +     NULL,
>
> No comma needed on the null terminator as we'll never add anything after
> it.
>
> > +};
> > +
> > +static umode_t pci_doe_sysfs_attr_visible(struct kobject *kobj,
> > +                                       struct attribute *a, int n)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index, j;
> > +     unsigned long vid, type;
> > +     void *entry;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             xa_for_each(&doe_mb->feats, j, entry) {
> > +                     vid =3D xa_to_value(entry) >> 8;
> > +                     type =3D xa_to_value(entry) & 0xFF;
> > +
> > +                     if (vid =3D=3D 0x01 && type =3D=3D 0x00) {
> > +                             /* This is the DOE discovery protocol
> local comment syntax is the
>                                 /*
>                                  * This is the
> form so stick to that.
>
>
> Shouldn't this also return a->mode for any case where the particular attr=
ibute
> matches?  I guess is_visible() isn't called for late registered sysfs att=
ributes
> though I think it probably should be!

The is_visible is only called for the original doe_features attribute,
I will update the names of the functions to make this clear.

>
> > +                              * Every DOE instance must support this, =
so we
> > +                              * give it a useful name.
> > +                              */
> > +                             return a->mode;
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static bool pci_doe_sysfs_group_visible(struct kobject *kobj)
> > +{
> > +     struct pci_dev *pdev =3D to_pci_dev(kobj_to_dev(kobj));
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index, j;
> > +     void *entry;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             xa_for_each(&doe_mb->feats, j, entry)
> Is this simpler as
>                 if (!xa_empty(&doe_mb->feats))
>                         return true;

Fine with me

>
> > +                     return true;
> > +     }
> > +
> > +     return false;
> > +}
> > +DEFINE_SYSFS_GROUP_VISIBLE(pci_doe_sysfs)
> > +
> > +const struct attribute_group pci_doe_sysfs_group =3D {
> > +     .name       =3D "doe_features",
> > +     .attrs      =3D pci_doe_sysfs_feature_attrs,
> > +     .is_visible =3D SYSFS_GROUP_VISIBLE(pci_doe_sysfs),
> > +};
> > +
> > +static ssize_t pci_doe_sysfs_feature_show(struct device *dev,
> > +                                       struct device_attribute *attr,
> > +                                       char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", attr->attr.name);
> > +}
> > +
> > +static void pci_doe_sysfs_feature_remove(struct pci_dev *pdev,
> > +                                      struct pci_doe_mb *doe_mb)
> > +{
> > +     struct device_attribute *attrs =3D doe_mb->sysfs_attrs;
> > +     struct device *dev =3D &pdev->dev;
> > +     unsigned long i;
> > +     void *entry;
> > +
> > +     if (!attrs)
> > +             return;
> > +
> > +     doe_mb->sysfs_attrs =3D NULL;
> > +     xa_for_each(&doe_mb->feats, i, entry) {
>
> I'm not particularly keen on using an index over the xa
> just to get the number of elements for the loop limit.
> Maybe just store that when you allocate attrs?

Is that really any better? Then we have another value to keep track
of. Plus this gets trickier if we skip a duplicate entry.

>
> > +             if (attrs[i].show)
> > +                     sysfs_remove_file_from_group(&dev->kobj, &attrs[i=
].attr,
> > +                                                  pci_doe_sysfs_group.=
name);
> > +             kfree(attrs[i].attr.name);
> > +     }
> > +     kfree(attrs);
> > +}
> > +
> > +static int pci_doe_sysfs_feature_populate(struct pci_dev *pdev,
> > +                                       struct pci_doe_mb *doe_mb)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct device_attribute *attrs;
> > +     unsigned long num_features =3D 0;
> > +     unsigned long vid, type;
> > +     unsigned long i;
> > +     void *entry;
> > +     int ret;
> > +
> > +     xa_for_each(&doe_mb->feats, i, entry)
> > +             num_features++;
> > +
> > +     attrs =3D kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> > +     if (!attrs)
> > +             return -ENOMEM;
> > +
> > +     doe_mb->sysfs_attrs =3D attrs;
> > +     xa_for_each(&doe_mb->feats, i, entry) {
> > +             sysfs_attr_init(&attrs[i].attr);
> > +             vid =3D xa_to_value(entry) >> 8;
> > +             type =3D xa_to_value(entry) & 0xFF;
> > +
> > +             if (vid =3D=3D 0x01 && type =3D=3D 0x00) {
> > +                     // DOE Discovery, manually displayed by `dev_attr=
_doe_discovery`
>
> /* */ syntax.
>
> > +                     continue;
> > +             }
> > +
> > +             attrs[i].attr.name =3D kasprintf(GFP_KERNEL,
> > +                                            "%04lx:%02lx", vid, type);
> > +             if (!attrs[i].attr.name) {
> > +                     ret =3D -ENOMEM;
> > +                     goto fail;
> > +             }
> > +
> > +             attrs[i].attr.mode =3D 0444;
> > +             attrs[i].show =3D pci_doe_sysfs_feature_show;
> > +
> > +             ret =3D sysfs_add_file_to_group(&dev->kobj, &attrs[i].att=
r,
> > +                                           pci_doe_sysfs_group.name);
> > +             if (ret) {
> > +                     attrs[i].show =3D NULL;
> > +                     goto fail;
>
> Repeated DOE 'features' on different DOE instances may cause this to fail=
.

We just skip that case then

Alistair

>
>
> > +             }
> > +     }
> > +
> > +     return 0;
> > +
> > +fail:
> > +     pci_doe_sysfs_feature_remove(pdev, doe_mb);
> > +     return ret;
> > +}
>
> >  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeo=
ut)
> >  {
> >       if (wait_event_timeout(doe_mb->wq,
> > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > index 40cfa716392f..b5db191cb29f 100644
> > --- a/drivers/pci/pci-sysfs.c
> > +++ b/drivers/pci/pci-sysfs.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/sched.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <linux/stat.h>
> >  #include <linux/export.h>
> >  #include <linux/topology.h>
> > @@ -1143,6 +1144,9 @@ static void pci_remove_resource_files(struct pci_=
dev *pdev)
> >  {
> >       int i;
> >
> > +     if (IS_ENABLED(CONFIG_PCI_DOE))
> > +             pci_doe_sysfs_teardown(pdev);
> > +
> >       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> >               struct bin_attribute *res_attr;
> >
> > @@ -1227,6 +1231,12 @@ static int pci_create_resource_files(struct pci_=
dev *pdev)
> >       int i;
> >       int retval;
> >
> > +     if (IS_ENABLED(CONFIG_PCI_DOE)) {
> > +             retval =3D pci_doe_sysfs_init(pdev);
> > +             if (retval)
> > +                     return retval;
> > +     }
> > +
> >       /* Expose the PCI resources from this device as files */
> >       for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> >
> > @@ -1661,6 +1671,9 @@ const struct attribute_group *pci_dev_attr_groups=
[] =3D {
> >  #endif
> >  #ifdef CONFIG_PCIEASPM
> >       &aspm_ctrl_attr_group,
> > +#endif
> > +#ifdef CONFIG_PCI_DOE
> > +     &pci_doe_sysfs_group,
> >  #endif
> >       NULL,
> >  };
>
>

