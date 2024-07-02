Return-Path: <linux-pci+bounces-9551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B391EEAF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 07:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4D4B21742
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 05:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CF149621;
	Tue,  2 Jul 2024 05:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mklgCt2x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F75374C6;
	Tue,  2 Jul 2024 05:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719899992; cv=none; b=beF2pRJdHAv3STw8vvTAvZUws/hzFLn+hkOt7Zlr1E2rfAwdp/gsp7QCC8OAxHcTej6axM1eRzFczj8dlMijubmrkEjox2qTTRRpoyJXSaX7e8nbqzsTyhNIdice+ZhudS6bdhgWKHxHH7+dPobjeUO5RU+vaf+oEFxtto8sVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719899992; c=relaxed/simple;
	bh=WwZQ9+CI8V/K3pwYtNCgVlG6FppDRsL1hckrMX0QhhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XqrQvOqBPo03Wd0Ly5wBjwNLB8XjrQfVr9TfqhcNEGAdCOnm+EUN8Fgug/dzOaQsN8u6tVlFURNaxne5nE8RA3sXsfhYO+rav9JyNpu74Ib6MDr9DTON7Ew5gsbQ8VctGVzRUWFczXesR+r2+DZjut8izIDu1sj8fwdz1bwDLz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mklgCt2x; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4ef662a4725so1677497e0c.0;
        Mon, 01 Jul 2024 22:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719899989; x=1720504789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC2h0CHYsZZaUAzCk04zWux1R2sWmKldSedDZlcr5aQ=;
        b=mklgCt2xlZeQ7gjCASc39kyFu74gvA7RFRy4KVJJYIUkkvP6HpfWHlJIs0a2606C19
         KaDzUPfGGFlbSzQPFMGbiV+XYRVysKkmGUvL/Yu97Uk1uz74HbKB0mcrXJpMOIj6M191
         k0W7iixXUzMvlf3tCCRVy1ClXG/w/rD3pxs+Fhgfx2ohSzvxv8mfkNyxymus49hEPkSU
         SUXOfiBK6uE7VlaM+Q9vUB3N2GRDSDvvrFP1cvLc2F/InVi27HLpoVzrp+2sT3EKXYsf
         cx2UfmJWd79VsFxh1gqphjCIhG2r/yjlDHIsCL12RL25Uke9CfHeR8ezQvYSodU0gxG6
         L68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719899989; x=1720504789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC2h0CHYsZZaUAzCk04zWux1R2sWmKldSedDZlcr5aQ=;
        b=s01a1XODhsUjaJSfUGqXq+rM1oEHoR/6AYOOangRrg/WkAr1ImGrnD2VBu8iMJekGU
         wCAO6CkOixAdwUjWEQMrkDj+Xf4ROQgd86dfUT7G36fVe2xfGK9FMZ8xgyAx4l8mzZoE
         6jH0FwQ/D7KovvZlrtWC7Hzl92OCQp0ehC8etQNhug7wzuVnzZ1V0FvY25NMZX102FIV
         pdHbudvKzdHaRKnz8XyY5V/4LtfFEnAALzu9zvhUDsFfCTjJqmDP0nRJ5L1HCg/V08G+
         z6zOXoBMuOkHrDBLKISRDxYCqXSFVd6XHXm8K1dFFztWDuUZrwimfvjuVVEJ451qktLV
         LvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEMnv8hYkcI4HIVfwYL1Olq45DfvPRi3voSItglOKRNYET8gXBLmRjb4WiBm/9woklGXxNoJYslJ/izXPpTkSpBLF1TQ9/minSN3VBJ0LzUJ33nB+v/6O1mvQmYJDzyVF6NYGQSfM7
X-Gm-Message-State: AOJu0Yw3ntl/lElhmVMdtvuYkj9bWaq9wsSvVtYmm22y3RPm/Xzl4YGJ
	6PrXR9OJ3nHdbrL0wO+JpI2nZlWXRt1JC0h3V+9II4CyQiyV9jM2duLNUCRwFCXK2MFQP5+J2b7
	OzNcAv7HOOCy1Pmg/Ns1HsY1IxXTp5IG4
X-Google-Smtp-Source: AGHT+IF5a5OjIzyaJocMTBPTWgNa0DegmthX+97mHhYb4JNjZcLM20NDrHPJLpcN5xTagUJ+OwTuyt1O2PyEbnKEHao=
X-Received: by 2002:a05:6122:6085:b0:4ef:27e0:3f8c with SMTP id
 71dfb90a1353d-4f2a5561996mr9305501e0c.0.1719899988648; Mon, 01 Jul 2024
 22:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626045926.680380-1-alistair.francis@wdc.com>
 <20240626045926.680380-3-alistair.francis@wdc.com> <20240701122721.0000034d@Huawei.com>
In-Reply-To: <20240701122721.0000034d@Huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 2 Jul 2024 15:59:21 +1000
Message-ID: <CAKmqyKP9_TukgkMFScuXYJP9bfJ-NVCgYqhbNPPv8ZgsbX560Q@mail.gmail.com>
Subject: Re: [PATCH v12 3/4] PCI/DOE: Expose the DOE features via sysfs
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, lukas@wunner.de, 
	alex.williamson@redhat.com, christian.koenig@amd.com, kch@nvidia.com, 
	gregkh@linuxfoundation.org, logang@deltatee.com, linux-kernel@vger.kernel.org, 
	chaitanyak@nvidia.com, rdunlap@infradead.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 9:27=E2=80=AFPM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 26 Jun 2024 14:59:25 +1000
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
> Hi Alistair,
>
> I think I missed an error path issue in earlier reviews.
>
> Suggestion for minimal fix inline. If that is fine feel
> free to add
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> > diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> > index defc4be81bd4..580370dc71ee 100644
> > --- a/drivers/pci/doe.c
> > +++ b/drivers/pci/doe.c
>
>
> > +
> > +int pci_doe_sysfs_init(struct pci_dev *pdev)
> > +{
> > +     struct pci_doe_mb *doe_mb;
> > +     unsigned long index;
> > +     int ret;
> > +
> > +     xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> > +             ret =3D pci_doe_sysfs_feature_populate(pdev, doe_mb);
>
> This doesn't feel quite right.  If we wait after a doe_mb features
> set succeeds and then an error occurs this code doesn't cleanup and...
>
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +#endif
> > +
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
>
> ... this doesn't call pci_remove_resource_files() unlike te
> other error path in this function which does.
>
> I think just calling that here would be sufficient and inline
> with how error cleanup works for the rest of this code.
> Personally I prefer driving for a function to have no side effects
> but such is life.

Thanks. While looking at this I realised we can actually drop
pci_doe_sysfs_init() entirely (with a few other changes). So I have
done that in v13.

Alistair

>
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

