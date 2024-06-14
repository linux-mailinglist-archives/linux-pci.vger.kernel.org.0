Return-Path: <linux-pci+bounces-8844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CA9908EFC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 17:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DEB1C251CE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 15:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0BD157A47;
	Fri, 14 Jun 2024 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FeRGtowc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117C15FCE9
	for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718379434; cv=none; b=kv3QNNv8ITppaDqoqLZLzuCcmk6YLhpYhS1XaEef2COqWlP0p5/RZpaFY9VUQarWbXBjZdRzIWmJL5ALBCdkV8zqK6U8OHFUMv6db48p7kZEMQ+DfX9Q7ZY8uyVWhDkwaw2r5CiZ2RH7aUJnYIUariA5uqSs4dLaDGT8xAa45Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718379434; c=relaxed/simple;
	bh=oOIDmTsxxZFCgDee1p1u3HZ9J8ZCGTSBqDR07CPnvr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGN/wG+0A/y0OTRRlA/eL4Hyh3IHDxvjZwtexUsRskCV71kD54BAXV0FtPvxXhVMuRV8LnmvJXfWXDeNoyTFB3JmQVDhAw0IOH6OUoZjeRDYldKYqXS0V42X3naWMQBNGvosFBcS7rj43ANyzQEAd/u0sIZnXLd3sKP/tvRKB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FeRGtowc; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6fa0edb64bdso1173101a34.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Jun 2024 08:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718379431; x=1718984231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p2UJf8JlqEdgLOTYOlR4OHMIJ6uTkUhgge3LUhmKOqw=;
        b=FeRGtowc1BHzoS2MbSTtHR89kEbZZC06t1la10ETWiHU65VVyI8o2C/vmexSE4Xl+a
         by3+5CD9O7CBZqxcxncmgQsBSL6+sncvk+mXvqeF3hQrG/br2ci6sH0F3pXq//oOk8O8
         7M0lQwAWf7yDMBCd50KK1KOPVAI8U+YM9PHE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718379431; x=1718984231;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2UJf8JlqEdgLOTYOlR4OHMIJ6uTkUhgge3LUhmKOqw=;
        b=ROve4F8r+MBv93+r+EcXCCtW1nLRY3fbEk9CM6jXANqmcXsEfG+0OIySHIJ7x9EQtx
         sGgdoyU6CpxTURvnX5NDwwu8u8aDsBIzW/VHPNubxFFwicQ5h5hTLQSdr4C5XedHEQcr
         VN+cRhT/oHOMyB4dhR9Mk9O/+WfMKkngPbrWmMi5+UBdh/ISVWh3JNTCVOyYMJQW8Iu6
         yEqHemmm5C/if9KKVBreBpHxi/m06SJdKb+PDQVJvkWv3c9DD/N4kyovOmPaD8x+iP6F
         gJTWQowqS6gRNZmb5HupksfUSN1/w3DS+ysxeY6jo/InxzplC0kyyVzu8U3GFNHSk5kO
         mY0g==
X-Forwarded-Encrypted: i=1; AJvYcCV2PcAeC+Q2GvpzuI0xI5WYdRodN4UMxVWdmNqxrzhdrl6TqMoZ/1MQV8NbuVvkkZU0/aw5XYaS2ux9aKyv6/fKuvI57VtD2Mad
X-Gm-Message-State: AOJu0YyBaFhNwQhDo5LxreoF2NVe5hRXgQPY4LhV4xi9iwWSSuErDJ4L
	qfPP4n9xFjZkpuLJYLdSza3pr+Zz2HPPLOs9LQzWQx6ryGqh78RN7+skydzUvBDeRIQbGWqiORu
	nlXko5NOeAjhdiLvTF/ISVwVQx6UEUL5iYEZsJjkCd5q3lz2ct8FNWh0BkOVMBq+TcTc5twoYGg
	EfIuQa+QOOzKFb0aX/CrPNlQ==
X-Google-Smtp-Source: AGHT+IF7hESzpnWfn+4LrDExfCF4jPILE5cJBjHEHPPlCYv14WqfP62MjItXObehclVsnJ/sDEnj85UlGuL38DKMrss=
X-Received: by 2002:a05:6870:b61f:b0:254:a613:1907 with SMTP id
 586e51a60fabf-25842b80cfemr2976501fac.56.1718379430171; Fri, 14 Jun 2024
 08:37:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <1718191656-32714-2-git-send-email-shivasharan.srikanteshwara@broadcom.com> <20240613134003.00003a38@Huawei.com>
In-Reply-To: <20240613134003.00003a38@Huawei.com>
From: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Date: Fri, 14 Jun 2024 09:36:58 -0600
Message-ID: <CADbZ7FoEY=ss_LZaozkBaAifHbMm4egJ=shoU7HwtrjAM-VtpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] switch_discovery: Add new module to discover inter
 switch links between PCI-to-PCI bridges
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, linux-kernel@vger.kernel.org, 
	sathya.prakash@broadcom.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000964fb8061adb63c4"

--000000000000964fb8061adb63c4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan and others,

Thanks for the feedback.

> It think the functionality is useful in general.
>
> Not sure that's an appropriate location though.  I'd rather
> see something in in each of the USP devices that references
> to others they share with.

Yes, we did think of using /sys/bus/pci/devices/, but that would of
course mean changing the PCIe driver ( as you too noted later), and we
were not sure if that would be acceptable to the community.
There is also an issue with race condition during discovery, more on that b=
elow.

> I also don't think we actually care
> if these are virtual or real inter switch links (which are hidden
> from the host anyway I think?)

Yes, correct. The discovery of whether the switches are connected will
be different for Virtual Switch and physical Inter switch link, but
the sysfs entries will be identical, and applications/consumers need
not care.

>>We may want a way to discover the bandwidth though.

Agreed, that would be a good enhancement, but will need more vendor
specific discovery, I think. But that is very useful, I agree and we
can take that later once this set of patches are approved

> I'm not sure if a bus walk and search is the right way to do this.
>
> I need to think on this more, but options that occur are:
> 1) Do it in the PCI core (so without a driver binding).
>    /sys/bus/pci/devices/0000:0c:00.0/isl/0000:12:00.0 -> ../../../0000:12=
:00.0
>    Controversial perhaps because PCIe provides no 'standard' way to disco=
ver
>    this but it it is slim enough, maybe?
>
> 2) Do it in portdrv as that will currently bind to the USP anyway.
>

One issue with using the PCI core and/or portdrv is that when those
drivers load, they will discover devices one by one, and when a given
device tries to find its connected peers, it may not be able to do so,
because its peers might not have been discovered yet.
We solved that problem by having a "refresh_link" sysfs entry, and
when that entry is triggered, we rediscover all the p2p switch links.
If we move the code to PCI core/portdev, then we shall probably need a
"refresh" under each device node, and when that is triggered, we shall
need to discover the links for that device. But still we shall still
need to do the bus walk, as we shall still need to find the peer
devices and check whether they are connected to the given device.
So, basically, what I am saying is, something like this:

/sys/bus/pci/devices/0000:0c:00.0/isl/refresh_link
/sys/bus/pci/devices/0000:0c:00.0/isl/0000:12:00.0 -> ../../../0000:12:00.0

Will that be acceptable? If so, we shall incorporate that change in
the next patch.
We shall also incorporate the rest of your feedback.

sincerely,
Sumanesh





On Thu, Jun 13, 2024 at 6:40=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Wed, 12 Jun 2024 04:27:35 -0700
> Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:
>
> > This kernel module discovers the virtual inter-switch P2P links present
> > between two PCI-to-PCI bridges that allows an optimal data path for dat=
a
> > movement. The module creates sysfs entries for upstream PCI-to-PCI
> > bridges which supports the inter switch P2P links as below:
> >
> >                              Host root bridge
> >                 ---------------------------------------
> >                 |                                     |
> >   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> > (af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
> >                 |                                     |
> >                GPU1                                  GPU2
> >             (b0:00.0)                             (8e:00.0)
> >                                SERVER 1
> >
> > /sys/kernel/pci_switch_link/virtual_switch_links
> > =E2=94=9C=E2=94=80=E2=94=80 0000:8b:00.0
> > =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0 -> ../0000:ad:00.0
> > =E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0
> >     =E2=94=94=E2=94=80=E2=94=80 0000:8b:00.0 -> ../0000:8b:00.0
>
> It think the functionality is useful in general.
>
> Not sure that's an appropriate location though.  I'd rather
> see something in in each of the USP devices that references
> to others they share with.  I also don't think we actually care
> if these are virtual or real inter switch links (which are hidden
> from the host anyway I think?)  The discovery means might be different
> in those case (large 'switch' made up of multiple connected smaller
> switches).  We may want a way to discover the bandwidth though.
>
>
> Needs a formal sysfs doc under
> Documentation/ABI/testing/sysfs*  (not totally sure where for this
> interface, but I think that location will change anyway)
>
> The comments below are mostly superficial. I need to think a bit
> more on how this might fit better with the linux driver model
> as I really don't like magic things that cross many devices.
>
> >
> > Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > ---
> >  .../driver-api/pci/switch_discovery.rst       |  52 +++
> >  MAINTAINERS                                   |  13 +
> >  drivers/pci/switch/Kconfig                    |   9 +
> >  drivers/pci/switch/Makefile                   |   1 +
> >  drivers/pci/switch/switch_discovery.c         | 375 ++++++++++++++++++
> >  drivers/pci/switch/switch_discovery.h         |  44 ++
> >  6 files changed, 494 insertions(+)
> >  create mode 100644 Documentation/driver-api/pci/switch_discovery.rst
> >  create mode 100644 drivers/pci/switch/switch_discovery.c
> >  create mode 100644 drivers/pci/switch/switch_discovery.h
> >
> > diff --git a/Documentation/driver-api/pci/switch_discovery.rst b/Docume=
ntation/driver-api/pci/switch_discovery.rst
> > new file mode 100644
> > index 000000000000..7c1476260e5e
> > --- /dev/null
> > +++ b/Documentation/driver-api/pci/switch_discovery.rst
> > @@ -0,0 +1,52 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Linux PCI Switch discovery module
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Modern PCI switches support inter switch Peer-to-Peer(P2P) data transf=
er
> > +without using host resources. For example, Broadcom(PLX) PCIe Switches=
 have a
> > +capability where a single physical switch can be divided up into multi=
ple
> > +virtual switches at SOD. PCIe switch discovery module detects the virt=
ual links
> > +between the switches that belong to the same physical switch.
> > +This allows user space applications to discover these virtual links th=
at belong
> > +to the same physical switch and configure optimized data paths.
> > +
> > +Userspace Interface
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The module exposes sysfs entries for user space applications like MPI,=
 NCCL,
> > +UCC, RCCL, HCCL, etc to discover the virtual switch links.
> > +
> > +Consider the below topology
> > +
> > +                             Host root bridge
> > +                ---------------------------------------
> > +                |                                     |
> > +  NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> > +(af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0=
)
> > +                |                                     |
> > +               GPU1                                  GPU2
> > +            (b0:00.0)                             (8e:00.0)
> > +                               SERVER 1
> > +
> > +The simple topology above shows SERVER1, has Switch1 and Switch2 which=
 are
> > +virtual switches that belong to the same physical switch that support
> > +Inter switch P2P.
> > +Switch1 and Switch2 have a GPU and NIC each connected.
> > +The module will detect the virtual P2P link existing between the two s=
witches
> > +and create the sysfs entries as below.
> > +
> > +/sys/kernel/pci_switch_link/virtual_switch_links
> > +=E2=94=9C=E2=94=80=E2=94=80 0000:8b:00.0
> > +=E2=94=82   =E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0 -> ../0000:ad:00.=
0
> > +=E2=94=94=E2=94=80=E2=94=80 0000:ad:00.0
> > +    =E2=94=94=E2=94=80=E2=94=80 0000:8b:00.0 -> ../0000:8b:00.0
> > +
> > +The HPC/AI libraries that analyze the topology can decide the optimal =
data
> > +path like: NIC1->GPU1->GPU2->NIC1 which would have otherwise take a
> > +non-optimal path like NIC1->GPU1->GPU2->GPU1->NIC1.
> > +
> > +Enable P2P DMA to discover virtual links
> > +----------------------------------------
> > +The module also enhances :c:func:`pci_p2pdma_distance()` to determine =
a virtual
> > +link between the upstream PCI-to-PCI bridges of the devices and detect=
 optimal
> > +path for applications using P2P DMA API.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 823387766a0c..b1bf3533ea6f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -17359,6 +17359,19 @@ F:   Documentation/driver-api/pci/p2pdma.rst
> >  F:   drivers/pci/p2pdma.c
> >  F:   include/linux/pci-p2pdma.h
> >
> > +PCI SWITCH DISCOVERY
> > +M:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > +M:   Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > +L:   linux-pci@vger.kernel.org
> > +S:   Maintained
> > +Q:   https://patchwork.kernel.org/project/linux-pci/list/
> > +B:   https://bugzilla.kernel.org
> > +C:   irc://irc.oftc.net/linux-pci
> > +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > +F:   Documentation/driver-api/pci/switch_discovery.rst
> > +F:   drivers/pci/switch/switch_discovery.c
> > +F:   drivers/pci/switch/switch_discovery.h
> > +
> >  PCI SUBSYSTEM
> >  M:   Bjorn Helgaas <bhelgaas@google.com>
> >  L:   linux-pci@vger.kernel.org
> > diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
> > index d370f4ce0492..fb4410153950 100644
> > --- a/drivers/pci/switch/Kconfig
> > +++ b/drivers/pci/switch/Kconfig
> > @@ -12,4 +12,13 @@ config PCI_SW_SWITCHTEC
> >        devices. See <file:Documentation/driver-api/switchtec.rst> for m=
ore
> >        information.
> >
> > +config PCI_SW_DISCOVERY
> > +     depends on PCI
> > +     tristate "PCI Switch discovery module"
> > +     help
> > +      This kernel module discovers the PCI-to-PCI bridges of PCIe swit=
ches
> > +      and forms the virtual switch links if the bridges belong to the =
same
> > +      Physical switch. The switch links help to identify shorter dista=
nces
> > +      for P2P configurations.
> > +
> >  endmenu
> > diff --git a/drivers/pci/switch/Makefile b/drivers/pci/switch/Makefile
> > index acd56d3b4a35..a3584b5146af 100644
> > --- a/drivers/pci/switch/Makefile
> > +++ b/drivers/pci/switch/Makefile
> > @@ -1,2 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_PCI_SW_SWITCHTEC) +=3D switchtec.o
> > +obj-$(CONFIG_PCI_SW_DISCOVERY) +=3D switch_discovery.o
> > diff --git a/drivers/pci/switch/switch_discovery.c b/drivers/pci/switch=
/switch_discovery.c
> > new file mode 100644
> > index 000000000000..a427d3885b1f
> > --- /dev/null
> > +++ b/drivers/pci/switch/switch_discovery.c
> > @@ -0,0 +1,375 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + *  PCI Switch Discovery module
> > + *
> > + *  Copyright (c) 2024  Broadcom Inc.
> > + *
> > + *  Authors: Broadcom Inc.
> > + *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > + *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/slab.h>
> > +#include <linux/rwsem.h>
> > +#include <linux/pci.h>
> > +#include <linux/vmalloc.h>
>
> Pick an ordering scheme for headers. Can't remember which PCI uses
> but alphabetical is always a good starting point unless there is
> a local standard.
>
> > +#include "switch_discovery.h"
> > +
> > +static DECLARE_RWSEM(sw_disc_rwlock);
> > +static struct kobject *sw_disc_kobj, *sw_link_kobj;
> > +static struct kobject *sw_kobj[SWD_MAX_VIRT_SWITCH];
> Why can't this be dynamically sized?  Use a list.
>
> > +static DECLARE_BITMAP(swdata_valid, SWD_MAX_VIRT_SWITCH);
> > +
> > +static struct switch_data *swdata;
> > +
> > +static int sw_disc_probe(void);
> > +static int sw_disc_create_sysfs_files(void);
> > +static bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *seria=
l_num);
>
> Can you reorder the code to avoid the need for these forwards definitions=
?
>
> > +
> > +static inline bool sw_disc_is_supported_pdev(struct pci_dev *pdev)
> > +{
> > +     if ((pdev->vendor =3D=3D PCI_VENDOR_ID_LSI) &&
> > +        ((pdev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_HLC) ||
> > +         (pdev->device =3D=3D PCI_DEVICE_ID_BRCM_PEX_89000_LLC)))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> > +static ssize_t sw_disc_show(struct kobject *kobj,
> > +                     struct kobj_attribute *attr,
> > +                     char *buf)
> > +{
> > +     int retval;
> > +
> > +     down_write(&sw_disc_rwlock);
> > +     retval =3D sw_disc_probe();
> > +     if (!retval) {
> > +             pr_debug("No new switch found\n");
> > +             goto exit_success;
> > +     }
> > +
> > +     retval =3D sw_disc_create_sysfs_files();
> > +     if (retval < 0) {
> > +             pr_err("Failed to create the sysfs entries, retval %d\n",
> > +                    retval);
> > +     }
> > +
> > +exit_success:
> > +     up_write(&sw_disc_rwlock);
> > +     return sysfs_emit(buf, SWD_SCAN_DONE);
> Don't have side effects on a read.  Write 1 to the file to scan and when
> it is done, return len;
>
> > +}
> > +
> > +/* This function probes the PCIe devices for virtual links */
>
> I'm not sure if a bus walk and search is the right way to do this.
>
> I need to think on this more, but options that occur are:
> 1) Do it in the PCI core (so without a driver binding).
>    /sys/bus/pci/devices/0000:0c:00.0/isl/0000:12:00.0 -> ../../../0000:12=
:00.0
>    Controversial perhaps because PCIe provides no 'standard' way to disco=
ver
>    this but it it is slim enough, maybe?
>
> 2) Do it in portdrv as that will currently bind to the USP anyway.
>
> There are other discussions on going on refactoring the pcie portdrv
> and this usecase might well fit in there.  Doesn't seem very invasive
> to add this.
>
> > +static int sw_disc_probe(void)
> > +{
> > +     int i, bit;
> > +     struct pci_dev *pdev =3D NULL;
> > +     int topology_changed =3D 0;
> > +     DECLARE_BITMAP(sw_found_map, SWD_MAX_VIRT_SWITCH);
>
> As above, I'd use a list of found virtual switches then removal
> is dropping an entry from middle of that list.
> Probe finds what is there and moves things to a new temporary list.
> Delete anything left on the old list.
>
> > +
> > +     while ((pdev =3D pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) !=
=3D NULL) {
>
> Not using the port class code?  Feels like every switch will if this isn'=
t
> in a different function? (I've been assuming it is vsec on the USP functi=
on)
>
> > +             int sw_found;
> > +
> > +             /* Currently this function only traverses Broadcom
> > +              * PEX switches and determines the virtual SW links.
> > +              * Other Switch vendors can add their specific logic
> > +              * determine the virtual links.
> > +              */
>
> I'd move this comment to the supported query. As you observe, it is
> general in principle.
>
> > +             if (!sw_disc_is_supported_pdev(pdev))
>
> It's not really about discovering switches. So I'd call it
> sw_might_be_virtual_switch() or something like that.
>
> I'm sure we'll eventually have to handle multiple physical switches
> with a real interswitchlink at some point, but that can be addressed
> separately.
>
>
> > +                     continue;
> > +
> > +             sw_found =3D -1;
>
> int sw_found =3D -1; above
>
> > +
> > +             for_each_set_bit(bit, swdata_valid, SWD_MAX_VIRT_SWITCH) =
{
> > +                     if (swdata[bit].devfn =3D=3D pdev->devfn &&
> > +                         swdata[bit].bus =3D=3D pdev->bus) {
>
> Can we use an xarray or similar to do this lookup?
>
> > +                             sw_found =3D bit;
> > +                             set_bit(sw_found, sw_found_map);
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             if (sw_found !=3D -1)
> > +                     continue;
> > +
> > +             for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++)
> > +                     if (!swdata[i].bus)
> > +                             break;
> > +
> > +             if (i >=3D SWD_MAX_VIRT_SWITCH) {
> > +                     pr_err("Max switch exceeded\n");
> > +                     break;
> > +             }
> > +
> > +             sw_found =3D i;
> > +
> > +             if (!brcm_sw_is_p2p_supported(pdev, (char *)&swdata[sw_fo=
und].serial_num))
> > +                     continue;
> > +
> > +             /* Found a new switch which supports P2P */
> > +             swdata[sw_found].devfn =3D pdev->devfn;
> > +             swdata[sw_found].bus =3D pdev->bus;
> > +
> > +             topology_changed =3D 1;
> > +             set_bit(sw_found, sw_found_map);
> > +             set_bit(sw_found, swdata_valid);
> > +     }
> > +
> > +     /* handle device removal */
> > +     for_each_clear_bit(bit, sw_found_map, SWD_MAX_VIRT_SWITCH) {
> > +             if (test_bit(bit, swdata_valid)) {
> > +                     memset(&swdata[bit], 0, sizeof(swdata[i]));
> > +                     clear_bit(bit, swdata_valid);
> > +                     topology_changed =3D 1;
> > +             }
> > +     }
> > +
> > +     return topology_changed;
> > +}
> > +
> > +/* Check the various config space registers of the Broadcom PCI device=
 and
> > + * return true if the device supports inter switch P2P.
> > + * If P2P is supported, return the device serial number back to
> > + * caller.
> > + */
> > +bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_num)
> > +{
> > +     int base;
> > +     u32 cap_data1, cap_data2;
> > +     u16 vsec;
> > +     u32 vsec_data;
> > +
> > +     base =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
> > +     if (!base) {
> > +             pr_debug("Failed to get extended capability bus %x devfn =
%x\n",
> > +                      pdev->bus->number, pdev->devfn);
> > +             return false;
> > +     }
>
> I'd just call pci_get_dsn()   If it doesn't return 0 the cap is there
> and we get the value and just use it.
>
>
> > +
> > +     vsec =3D pci_find_vsec_capability(pdev, PCI_VENDOR_ID_LSI, 1);
> > +     if (!vsec) {
> > +             pr_debug("Failed to get VSEC bus %x devfn %x\n",
> > +                      pdev->bus->number, pdev->devfn);
> > +             return false;
> > +     }
> > +
> > +     if (pci_pcie_type(pdev) !=3D PCI_EXP_TYPE_UPSTREAM)
> > +             return false;
>
> I'd do this first.  Will apply to a lot of matches and this
> is much cheaper than finding capabilities.
>
> > +
> > +     pci_read_config_dword(pdev, base + 8, &cap_data1);
> > +     pci_read_config_dword(pdev, base + 4, &cap_data2);
> > +
> > +     pci_read_config_dword(pdev, vsec + 12, &vsec_data);
>
> Use a define for that vsec offset that gives some indication
> of it's purpose in the LSI VSEC.
>
> > +
> > +     pr_debug("Found Broadcom device bus 0x%x devfn 0x%x "
> > +              "Serial Number: 0x%x 0x%x, VSEC 0x%x\n",
> > +              pdev->bus->number, pdev->devfn,
> > +              cap_data1, cap_data2, vsec_data);
> > +
> > +     if (!SECURE_PART(cap_data1))
> > +             return false;
> FIELD_GET()
>
> > +
> > +     if (!(P2PMASK(vsec_data) & INTER_SWITCH_LINK))
>
> FIELD_GET() for the relevant bits in each.
>
> > +             return false;
> > +
> > +     if (serial_num)
> > +             snprintf(serial_num, SWD_MAX_CHAR, "%x%x", cap_data1, cap=
_data2);
> Just use the u64.
> > +
> > +     return true;
> > +}
> > +
> > +static int sw_disc_create_sysfs_files(void)
> > +{
> > +     int i, j, retval;
> > +
> > +     for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> > +             if (sw_kobj[i]) {
> > +                     kobject_put(sw_kobj[i]);
> > +                     sw_kobj[i] =3D NULL;
> If you are freeing kobjects in a creation path something went wrong.
> Don't do this - if it makes sense free them before calling this create fu=
nction.
>
> > +             }
> > +     }
> > +
> > +     if (sw_link_kobj) {
> > +             kobject_put(sw_link_kobj);
> > +             sw_link_kobj =3D NULL;
> > +     }
> > +
> > +     sw_link_kobj =3D kobject_create_and_add(SWD_LINK_DIR_STRING, sw_d=
isc_kobj);
>
> Don't use defines for file names. We want to see them inline as
> much more readable!
>
> > +     if (!sw_link_kobj) {
> > +             pr_err("Failed to create pci link object\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> > +             int segment, bus, device, function;
> > +             char bdf_i[SWD_MAX_CHAR];
>
> No obvious reason why this is the same length as serial numbers?
> Use an appropriate define for each.  We print the bdf in
> various places, maybe there is already a suitable define and if
> not perhaps worth adding one.
>
> > +
> > +             if (!test_bit(i, swdata_valid))
> > +                     continue;
> > +
> > +             segment =3D pci_domain_nr(swdata[i].bus);
> > +             bus =3D swdata[i].bus->number;
> > +             device =3D pci_ari_enabled(swdata[i].bus) ?
> > +                             0 : PCI_SLOT(swdata[i].devfn);
> > +             function =3D pci_ari_enabled(swdata[i].bus) ?
> > +                             swdata[i].devfn : PCI_FUNC(swdata[i].devf=
n);
> > +             sprintf(bdf_i, "%04x:%02x:%02x.%x",
> > +                     segment, bus, device, function);
> > +
> > +             for (j =3D i + 1; j < SWD_MAX_VIRT_SWITCH; j++) {
> > +                     char bdf_j[SWD_MAX_CHAR];
> > +
> > +                     if (!test_bit(j, swdata_valid))
> > +                             continue;
> > +                     segment =3D pci_domain_nr(swdata[j].bus);
> > +                     bus =3D swdata[j].bus->number;
> > +                     device =3D pci_ari_enabled(swdata[j].bus) ?
> > +                                     0 : PCI_SLOT(swdata[j].devfn);
> > +                     function =3D pci_ari_enabled(swdata[j].bus) ?
> > +                                     swdata[j].devfn : PCI_FUNC(swdata=
[j].devfn);
> > +                     sprintf(bdf_j, "%04x:%02x:%02x.%x",
> > +                             segment, bus, device, function);
> > +
> > +                     if (strcmp(swdata[i].serial_num, swdata[j].serial=
_num) =3D=3D 0) {
> > +                             if (!sw_kobj[i]) {
> > +                                     sw_kobj[i] =3D kobject_create_and=
_add(bdf_i,
> > +                                                                      =
   sw_link_kobj);
> > +                                     if (!sw_kobj[i]) {
> > +                                             pr_err("Failed to create =
sysfs entry for switch %s\n",
> > +                                                    bdf_i);
> > +                                     }
> > +                             }
> > +
> > +                             if (!sw_kobj[j]) {
> > +                                     sw_kobj[j] =3D kobject_create_and=
_add(bdf_j,
> > +                                                                      =
   sw_link_kobj);
> > +                                     if (!sw_kobj[j]) {
> > +                                             pr_err("Failed to create =
sysfs entry for switch %s\n",
> > +                                                    bdf_j);
> > +                                     }
> > +                             }
> > +
> > +                             retval =3D sysfs_create_link(sw_kobj[i], =
sw_kobj[j], bdf_j);
> > +                             if (retval)
> > +                                     pr_err("Error creating symlink %s=
 and %s\n",
> > +                                            bdf_i, bdf_j);
> > +
> > +                             retval =3D sysfs_create_link(sw_kobj[j], =
sw_kobj[i], bdf_i);
> > +                             if (retval)
> > +                                     pr_err("Error creating symlink %s=
 and %s\n",
> > +                                            bdf_j, bdf_i);
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Check if the two pci devices have virtual P2P link available.
> > + * This function is used by the p2pdma to determine virtual
> > + * links between the PCI-to-PCI bridges
> > + */
> > +bool sw_disc_check_virtual_link(struct pci_dev *a,
> > +                              struct pci_dev *b)
> No need to wrrap line.
>
> > +{
> > +     char serial_num_a[SWD_MAX_CHAR], serial_num_b[SWD_MAX_CHAR];
> > +
> > +     /*
> > +      * Check if the PCIe devices support Virtual P2P links
> > +      */
>
> Single line comment
>         /* Check if the PCIe devices support Virtual P2P links */
>
> > +     if (!sw_disc_is_supported_pdev(a))
> > +             return false;
> > +
> > +     if (!sw_disc_is_supported_pdev(b))
> > +             return false;
> > +
> > +     if (brcm_sw_is_p2p_supported(a, serial_num_a) &&
> > +         brcm_sw_is_p2p_supported(b, serial_num_b))
> > +             if (!strcmp(serial_num_a, serial_num_b))
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +EXPORT_SYMBOL_GPL(sw_disc_check_virtual_link);
> > +
> > +static struct kobj_attribute sw_disc_attribute =3D
> > +     __ATTR(SWD_FILE_NAME_STRING, 0444, sw_disc_show, NULL);
>
> As below. Use string directly for file names, don't hide it behind
> a define.
>
> > +
> > +// Create attribute group
> Drop comment + if it was here /* */
>
> > +static struct attribute *attrs[] =3D {
> > +     &sw_disc_attribute.attr,
> > +     NULL,
> No comma on NULL terminators as we won't add anything after them.
>
> > +};
> > +
> > +static struct attribute_group attr_group =3D {
> > +     .attrs =3D attrs,
> > +};
> > +
> > +static int __init sw_discovery_init(void)
> > +{
> > +     int i, retval;
> > +
> > +     for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++)
> > +             sw_kobj[i] =3D NULL;
> > +
> > +     // Create "sw_disc" kobject
>
> Drop any 'obvious' comments.
>
> > +     sw_disc_kobj =3D kobject_create_and_add(SWD_DIR_STRING, kernel_ko=
bj);
> > +     if (!sw_disc_kobj) {
> > +             pr_err("Failed to create sw_disc_kobj\n");
> > +             return -ENOMEM;
> > +     }
> > +
> > +     retval =3D sysfs_create_group(sw_disc_kobj, &attr_group);
> > +     if (retval) {
> > +             pr_err("Cannot register sysfs attribute group\n");
> > +             kobject_put(sw_disc_kobj);
> return an error.
> > +     }
> > +
> > +     swdata =3D kzalloc(sizeof(swdata) * SWD_MAX_VIRT_SWITCH, GFP_KERN=
EL);
> > +     if (!swdata) {
> > +             sysfs_remove_group(sw_disc_kobj, &attr_group);
> > +             kobject_put(sw_disc_kobj);
> return an error.
> > +             return 0;
> > +     }
> > +
> > +     pr_info("Loading PCIe switch discovery module, version %s\n",
> > +             SWITCH_DISC_VERSION);
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit sw_discovery_exit(void)
> > +{
> > +     int i;
> > +
> > +     if (!swdata)
> I'm fairly sure that if you return an error in failure above (which shoul=
dn't
> fail anyway) you won't need this protection as for exit() to be called in=
it()
> must have succeeded and the data must have been allocated.
>
> > +             kfree(swdata);
> > +
> > +     for (i =3D 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> > +             if (sw_kobj[i])
> > +                     kobject_put(sw_kobj[i]);
> > +     }
> > +
> > +     // Remove kobject
>
> /* Remove kobject */ but that's pretty obvious anyway so better to just d=
rop the
> comment.
>
>
> > +     if (sw_link_kobj)
> > +             kobject_put(sw_link_kobj);
> > +
> > +     sysfs_remove_group(sw_disc_kobj, &attr_group);
> > +     kobject_put(sw_disc_kobj);
> > +}
> > +
> > +module_init(sw_discovery_init);
> > +module_exit(sw_discovery_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Broadcom Inc.");
> > +MODULE_VERSION(SWITCH_DISC_VERSION);
> > +MODULE_DESCRIPTION("PCIe Switch Discovery Module");
> > diff --git a/drivers/pci/switch/switch_discovery.h b/drivers/pci/switch=
/switch_discovery.h
> > new file mode 100644
> > index 000000000000..b84f5d2e29ac
> > --- /dev/null
> > +++ b/drivers/pci/switch/switch_discovery.h
> > @@ -0,0 +1,44 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + *  PCI Switch Discovery module
> > + *
> > + *  Copyright (c) 2024  Broadcom Inc.
> > + *
> > + *  Authors: Broadcom Inc.
> > + *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > + *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> Why is the header needed?  Only seems to be used from one c file.
> Move everything down there and drop this file.
>
> > + */
> > +
> > +#ifndef PCI_SWITCH_DISC_H
> > +#define PCI_SWITCH_DISC_H
> > +
> > +#define SWD_MAX_SWITCH               32
> > +#define SWD_MAX_VER_PER_SWITCH       8
> > +
> > +#define SWD_MAX_VIRT_SWITCH  (SWD_MAX_SWITCH * SWD_MAX_VER_PER_SWITCH)
> > +#define SWD_MAX_CHAR         16
>
> Name this so it's clearer what it is sizing.
>
> > +#define SWITCH_DISC_VERSION  "0.1.1"
>
> Whilst there are module versions in the kernel etc, they are meaningless
> as we must support backwards compatibility anyway. So don't give
> it a version (this is basically ancient legacy no one uses any more)
>
> > +#define SWD_DIR_STRING               "pci_switch_link"
> All these better inline.  Defines just make yoru code harder to read.
> > +#define SWD_LINK_DIR_STRING  "virtual_switch_links"
> > +#define SWD_SCAN_DONE                "done\n"
> Definitely inline!
>
> > +
> > +#define SWD_FILE_NAME_STRING refresh_switch_toplogy
> Just use the string directly inline. This doesn't belong in
> a header.
> > +
> > +/* Broadcom Vendor Specific definitions */
> > +#define PCI_VENDOR_ID_LSI                    0x1000
> > +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC     0xC030
> > +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC     0xC034
>
> > +
> > +#define P2PMASK(x)           (((x) & 0x300) >> 8)
>
> Use FIELD_GET() on the mask alone and make sure it's clear from
> naming what register this applies to.
>
> > +#define SECURE_PART(x)               ((x) & 0x8)
> > +#define INTER_SWITCH_LINK    0x2
> Give this a name that matches with a register name or smilar.
>
> > +
> > +struct switch_data {
>
> More specific name needed as this will clash with something at somepoint
> in the future
>
> > +     int  devfn;
> extra space before devfn.
>
> > +     struct pci_bus *bus;
> > +     char serial_num[SWD_MAX_CHAR];
> > +};
> > +
> > +bool sw_disc_check_virtual_link(struct pci_dev *a, struct pci_dev *b);
> > +
> > +#endif /* PCI_SWITCH_DISC_H */
>

--=20
This electronic communication and the information and any files transmitted=
=20
with it, or attached to it, are confidential and are intended solely for=20
the use of the individual or entity to whom it is addressed and may contain=
=20
information that is confidential, legally privileged, protected by privacy=
=20
laws, or otherwise restricted from disclosure to anyone else. If you are=20
not the intended recipient or the person responsible for delivering the=20
e-mail to the intended recipient, you are hereby notified that any use,=20
copying, distributing, dissemination, forwarding, printing, or copying of=
=20
this e-mail is strictly prohibited. If you received this e-mail in error,=
=20
please return the e-mail to the sender, delete it from your computer, and=
=20
destroy any printed copy of it.

--000000000000964fb8061adb63c4
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDG3N/v/7cXC4xYP/YDANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwOTIzMzdaFw0yNTA5MTAwOTIzMzdaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEFN1bWFuZXNoIFNhbWFudGExLDAqBgkqhkiG
9w0BCQEWHXN1bWFuZXNoLnNhbWFudGFAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAsuiZfUgi9027cN+iQrYjDHStIlbjoJWWNwczYntRKg33D9vp+AVA1FV9sHTq
vC+5D42TNZY/dJZv0cwb4JWxZa0ZG3BJzvkpsRJNUreSojb5yuBrY6Tr8Hav57NDLZAnynhV3xZ6
iX6Wa0JFKZIept2rdGV201AJmgVaDZsRFPIpfHeRsUuTufDWr5A/2hVVTvQt7hQmgXyyQzcii9I3
zekCl3pjcoOObDAkznDD9vlyLLvDDWikUDmc6Q82vNt89t6IYnDV8PrsTGMlK2Js/LyhYHN3d/sQ
dBHV3iBHyeN6pUKZ0sDzQMKjzE2S0IRRX6Mwh+DYAUDm66pjXc8FOQIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1zdW1hbmVzaC5zYW1hbnRhQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU6TFlZ1Wo
0dmsZDo+/EXAseKlvxUwDQYJKoZIhvcNAQELBQADggEBACxY1CWol9aZ4MJi8uYcPC6El2gUSbiO
NySelOnmiuTKCJRj0e5NJqm6X7p7kN/JEqPy03YjEMTvqYCGcc0ExTQf3RPYeZzaQSrFr3oc9k8N
EGmluzckC+UTGlwVoo38RG+V/ixlatLYgSLqvrKV1h/wX79onLyMMlGR1yZUburAx5qpK6eE/EHW
o6GtvueloW9jET+RFa16TbcDTDio24qwqHELYzgk/PngQbUU82erdcVP80Rr7rWwC5XtbAB6cbjb
mca5iAjoc2SCWnNGFtyOQ5hUC10AMZrPOP4hPodpkP+FJR35N4NiEg6amrNvmPIEadV2JkyE0qVa
fniK4LcxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxt
zf7/+3FwuMWD/2AwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEYjY3aoLlI97/X3
cOIbVb8CoU1duUPzeSSSNaWkrMtGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDYxNDE1MzcxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCbO06n00EcxcFJnUYDjgoUVrUBq12m9DOh
zite6RC6ExlzmRYQW5D0dl972+PimE33xuw26iDI16ni8vuqLig22cWMHJyK03Kh6hzST74Ck2ay
pZTHFVz86BRsSQIu4hhKi4fDKi1WGMJb2031Mlwxr5Ai87gK2tb8CFmhS2teXoiMIW5JY4ANnwMG
0H4exqfuyaAxzELL7HQrDUki7xawOaFPKdlqobxWXsRzfQM/nyl4DzKXuK2aG1/U0QQCw0Pq4sXs
m6aMaHH+pq4867lHu9YrJQ7ipR8nnrVdC20ChDChE5kGhucXpl/fDLfW9Rm8Q+8JJy8XrWO6bAId
s76i
--000000000000964fb8061adb63c4--

