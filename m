Return-Path: <linux-pci+bounces-9133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C966A913BD1
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFA901C20E41
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 14:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35F181BBE;
	Sun, 23 Jun 2024 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XxHV5VdV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37A61CD25
	for <linux-pci@vger.kernel.org>; Sun, 23 Jun 2024 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719153894; cv=none; b=XKA3wI0BROkFzSpiDo8tyVX01c7TzHNjTFEF3WIxNIIDt7/VxBH3fMM3+CWs6rQ3OxtMDFpzm4M74BY7wn6OrZcjmoteLN+Pq4EsGXhKDL8H8G5/7VmTx3NA3miCKz7LDYaBTFdsULblcEgwJkU+Y/uEHfRl+lVnZtB62i7VxpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719153894; c=relaxed/simple;
	bh=baXldSR4Agunedicg4MvhnwlORwvvWWi+nrKL2q+N9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr6i4PmIjCMTlXcC7+Ss8RiGMggcgzNwlNALEeAedPbV0HM7+Tm6qC1Cs7cBW+yJmH0u4g5AaT70J8IOFMwy/Hf0y+Y5E3zXpX0tqpOkm8GKhedItzjw15/sovvfJ3+gpeYtEWgK0QCDMrAOpZoV++QpG2TpPpk02q4mawAcoH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XxHV5VdV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f6fabe9da3so28827675ad.0
        for <linux-pci@vger.kernel.org>; Sun, 23 Jun 2024 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719153891; x=1719758691; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ur4Am8E3gDYSfg0X+m3b3DT4z0jWR/bjftyhjGBk8Nw=;
        b=XxHV5VdVDVhbbAbe0PUpUBU3V9MeO0j9SUlBYw4MOTdH1LAbosLrcl/hUM1mJvd4+/
         s/xUPbHRG0xCMuZEjA3J+vXri/6DnxVBB/XDNdLlcIke+UanKLDcssANShm5SgiC7ZvU
         J6esCWf9cNYPbrDKTuyeU4isC3+cYGmMNkRqE/ISA7BLHDvKDTJAgWaH6s5O3t/yWOHb
         Rqi0YHWWgLI0S3PHnoUw1vwnPslnrob6dHg7Z8ClhB4DQhUMHH3OUIolIjSnhkR+58rj
         vqIGoTBhDWQNwZTCig2AkAq6ndWmH0IFoC/JVLJTghlwsprP7oqY1T6Sr+evxLqNoEVu
         /EvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719153891; x=1719758691;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ur4Am8E3gDYSfg0X+m3b3DT4z0jWR/bjftyhjGBk8Nw=;
        b=YHr2dwcFp1j9nsHmTa/t3Kem3fpiD1PCj4/F2C2atAF/1QoC9EOBYlbD6TOIp1m9r5
         6pvM/wAoZjrxwRKODcRFdp7ZonGrttpQ0czY8BJ5+mEVU0KAAIiZ8Rjb0KJR/S91sTvI
         cGsrF9rz491y9Fm27n/ixR3gQmv4SGVxg6cXYieAVzFnIgM10MWnd2O1X6ziCbvq5wQ6
         nGG5u7EZV7lP6y8Yfxo0j7GvnlIsliR+3KRmZOdZJxpsmiIgcGIJduhs+M0mv5vVA2XU
         tRC6LlhYMROVkbOJN6Gf8oqtbsfB7VaS6dtqpfNmbeR8jztRl/VdpVtgSRrV6x0QG1F8
         sp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUH4H+0Bxxxx/Iz4B6+7rM7Jd1e/JpICMdwQAC/vU+6gbWA/CdPPGn9v5wFEA7h38uQHJbWADioOxOLSsjU8BuXwnCwVS7xBmU
X-Gm-Message-State: AOJu0YzWoxdX4nchSxJBEfA16d4eQ6dyQ+eo+lTeFUn4SzTDic86vGwq
	Dunqzf/crleC9/DpoHbrhFVuDRkcJAh8WHxSef7kRt2yzJTypOKGpmJ1PmQJVg==
X-Google-Smtp-Source: AGHT+IF/0v+dAnNlnHmmZnkjOmE1EforBhwoA5Y+MAXyQ1oUuYisyaykGDrx/RNqtxcZuSPjNr5HDQ==
X-Received: by 2002:a17:902:bb16:b0:1fa:a46:aa4d with SMTP id d9443c01a7336-1fa23eeff64mr20250445ad.38.1719153890592;
        Sun, 23 Jun 2024 07:44:50 -0700 (PDT)
Received: from thinkpad ([220.158.156.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa048c6639sm31262365ad.268.2024.06.23.07.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 07:44:49 -0700 (PDT)
Date: Sun, 23 Jun 2024 20:14:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, sathya.prakash@broadcom.com
Subject: Re: [PATCH 1/2] switch_discovery: Add new module to discover inter
 switch links between PCI-to-PCI bridges
Message-ID: <20240623144444.GE58184@thinkpad>
References: <1718191656-32714-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <1718191656-32714-2-git-send-email-shivasharan.srikanteshwara@broadcom.com>
 <20240613134003.00003a38@Huawei.com>
 <CADbZ7FoEY=ss_LZaozkBaAifHbMm4egJ=shoU7HwtrjAM-VtpQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADbZ7FoEY=ss_LZaozkBaAifHbMm4egJ=shoU7HwtrjAM-VtpQ@mail.gmail.com>

On Fri, Jun 14, 2024 at 09:36:58AM -0600, Sumanesh Samanta wrote:
> Hi Jonathan and others,
> 
> Thanks for the feedback.
> 
> > It think the functionality is useful in general.
> >
> > Not sure that's an appropriate location though.  I'd rather
> > see something in in each of the USP devices that references
> > to others they share with.
> 
> Yes, we did think of using /sys/bus/pci/devices/, but that would of
> course mean changing the PCIe driver ( as you too noted later), and we
> were not sure if that would be acceptable to the community.
> There is also an issue with race condition during discovery, more on that below.
> 
> > I also don't think we actually care
> > if these are virtual or real inter switch links (which are hidden
> > from the host anyway I think?)
> 
> Yes, correct. The discovery of whether the switches are connected will
> be different for Virtual Switch and physical Inter switch link, but
> the sysfs entries will be identical, and applications/consumers need
> not care.
> 
> >>We may want a way to discover the bandwidth though.
> 
> Agreed, that would be a good enhancement, but will need more vendor
> specific discovery, I think. But that is very useful, I agree and we
> can take that later once this set of patches are approved
> 
> > I'm not sure if a bus walk and search is the right way to do this.
> >
> > I need to think on this more, but options that occur are:
> > 1) Do it in the PCI core (so without a driver binding).
> >    /sys/bus/pci/devices/0000:0c:00.0/isl/0000:12:00.0 -> ../../../0000:12:00.0
> >    Controversial perhaps because PCIe provides no 'standard' way to discover
> >    this but it it is slim enough, maybe?
> >
> > 2) Do it in portdrv as that will currently bind to the USP anyway.
> >
> 
> One issue with using the PCI core and/or portdrv is that when those
> drivers load, they will discover devices one by one, and when a given
> device tries to find its connected peers, it may not be able to do so,
> because its peers might not have been discovered yet.
> We solved that problem by having a "refresh_link" sysfs entry, and
> when that entry is triggered, we rediscover all the p2p switch links.
> If we move the code to PCI core/portdev, then we shall probably need a
> "refresh" under each device node, and when that is triggered, we shall
> need to discover the links for that device. But still we shall still
> need to do the bus walk, as we shall still need to find the peer
> devices and check whether they are connected to the given device.
> So, basically, what I am saying is, something like this:
> 
> /sys/bus/pci/devices/0000:0c:00.0/isl/refresh_link
> /sys/bus/pci/devices/0000:0c:00.0/isl/0000:12:00.0 -> ../../../0000:12:00.0
> 
> Will that be acceptable? If so, we shall incorporate that change in
> the next patch.
> We shall also incorporate the rest of your feedback.
> 

I feel like moving this part of the code to portdrv/pci core would be the
correct approach as the functionality itself is generic but only the
implementation is vendor specific.

But I'm thinking that instead of discovering the link during device probe
itself, can we just create the sysfs attribute for each switch during probe,
and display the link during attribute read?

This would also mean that we can have the sysfs attribute under each bridge
instead of a separate location. Like,

/sys/bus/pci/devices/0000:01:00.0/p2p_link

- Mani

> sincerely,
> Sumanesh
> 
> 
> 
> 
> 
> On Thu, Jun 13, 2024 at 6:40 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Wed, 12 Jun 2024 04:27:35 -0700
> > Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:
> >
> > > This kernel module discovers the virtual inter-switch P2P links present
> > > between two PCI-to-PCI bridges that allows an optimal data path for data
> > > movement. The module creates sysfs entries for upstream PCI-to-PCI
> > > bridges which supports the inter switch P2P links as below:
> > >
> > >                              Host root bridge
> > >                 ---------------------------------------
> > >                 |                                     |
> > >   NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> > > (af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
> > >                 |                                     |
> > >                GPU1                                  GPU2
> > >             (b0:00.0)                             (8e:00.0)
> > >                                SERVER 1
> > >
> > > /sys/kernel/pci_switch_link/virtual_switch_links
> > > ├── 0000:8b:00.0
> > > │   └── 0000:ad:00.0 -> ../0000:ad:00.0
> > > └── 0000:ad:00.0
> > >     └── 0000:8b:00.0 -> ../0000:8b:00.0
> >
> > It think the functionality is useful in general.
> >
> > Not sure that's an appropriate location though.  I'd rather
> > see something in in each of the USP devices that references
> > to others they share with.  I also don't think we actually care
> > if these are virtual or real inter switch links (which are hidden
> > from the host anyway I think?)  The discovery means might be different
> > in those case (large 'switch' made up of multiple connected smaller
> > switches).  We may want a way to discover the bandwidth though.
> >
> >
> > Needs a formal sysfs doc under
> > Documentation/ABI/testing/sysfs*  (not totally sure where for this
> > interface, but I think that location will change anyway)
> >
> > The comments below are mostly superficial. I need to think a bit
> > more on how this might fit better with the linux driver model
> > as I really don't like magic things that cross many devices.
> >
> > >
> > > Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > > Signed-off-by: Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > > ---
> > >  .../driver-api/pci/switch_discovery.rst       |  52 +++
> > >  MAINTAINERS                                   |  13 +
> > >  drivers/pci/switch/Kconfig                    |   9 +
> > >  drivers/pci/switch/Makefile                   |   1 +
> > >  drivers/pci/switch/switch_discovery.c         | 375 ++++++++++++++++++
> > >  drivers/pci/switch/switch_discovery.h         |  44 ++
> > >  6 files changed, 494 insertions(+)
> > >  create mode 100644 Documentation/driver-api/pci/switch_discovery.rst
> > >  create mode 100644 drivers/pci/switch/switch_discovery.c
> > >  create mode 100644 drivers/pci/switch/switch_discovery.h
> > >
> > > diff --git a/Documentation/driver-api/pci/switch_discovery.rst b/Documentation/driver-api/pci/switch_discovery.rst
> > > new file mode 100644
> > > index 000000000000..7c1476260e5e
> > > --- /dev/null
> > > +++ b/Documentation/driver-api/pci/switch_discovery.rst
> > > @@ -0,0 +1,52 @@
> > > +=================================
> > > +Linux PCI Switch discovery module
> > > +=================================
> > > +
> > > +Modern PCI switches support inter switch Peer-to-Peer(P2P) data transfer
> > > +without using host resources. For example, Broadcom(PLX) PCIe Switches have a
> > > +capability where a single physical switch can be divided up into multiple
> > > +virtual switches at SOD. PCIe switch discovery module detects the virtual links
> > > +between the switches that belong to the same physical switch.
> > > +This allows user space applications to discover these virtual links that belong
> > > +to the same physical switch and configure optimized data paths.
> > > +
> > > +Userspace Interface
> > > +===================
> > > +
> > > +The module exposes sysfs entries for user space applications like MPI, NCCL,
> > > +UCC, RCCL, HCCL, etc to discover the virtual switch links.
> > > +
> > > +Consider the below topology
> > > +
> > > +                             Host root bridge
> > > +                ---------------------------------------
> > > +                |                                     |
> > > +  NIC1 --- PCI Switch1 --- Inter-switch link --- PCI Switch2 --- NIC2
> > > +(af:00.0)   (ad:00.0)                             (8b:00.0)   (8d:00.0)
> > > +                |                                     |
> > > +               GPU1                                  GPU2
> > > +            (b0:00.0)                             (8e:00.0)
> > > +                               SERVER 1
> > > +
> > > +The simple topology above shows SERVER1, has Switch1 and Switch2 which are
> > > +virtual switches that belong to the same physical switch that support
> > > +Inter switch P2P.
> > > +Switch1 and Switch2 have a GPU and NIC each connected.
> > > +The module will detect the virtual P2P link existing between the two switches
> > > +and create the sysfs entries as below.
> > > +
> > > +/sys/kernel/pci_switch_link/virtual_switch_links
> > > +├── 0000:8b:00.0
> > > +│   └── 0000:ad:00.0 -> ../0000:ad:00.0
> > > +└── 0000:ad:00.0
> > > +    └── 0000:8b:00.0 -> ../0000:8b:00.0
> > > +
> > > +The HPC/AI libraries that analyze the topology can decide the optimal data
> > > +path like: NIC1->GPU1->GPU2->NIC1 which would have otherwise take a
> > > +non-optimal path like NIC1->GPU1->GPU2->GPU1->NIC1.
> > > +
> > > +Enable P2P DMA to discover virtual links
> > > +----------------------------------------
> > > +The module also enhances :c:func:`pci_p2pdma_distance()` to determine a virtual
> > > +link between the upstream PCI-to-PCI bridges of the devices and detect optimal
> > > +path for applications using P2P DMA API.
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 823387766a0c..b1bf3533ea6f 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -17359,6 +17359,19 @@ F:   Documentation/driver-api/pci/p2pdma.rst
> > >  F:   drivers/pci/p2pdma.c
> > >  F:   include/linux/pci-p2pdma.h
> > >
> > > +PCI SWITCH DISCOVERY
> > > +M:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > > +M:   Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > > +L:   linux-pci@vger.kernel.org
> > > +S:   Maintained
> > > +Q:   https://patchwork.kernel.org/project/linux-pci/list/
> > > +B:   https://bugzilla.kernel.org
> > > +C:   irc://irc.oftc.net/linux-pci
> > > +T:   git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> > > +F:   Documentation/driver-api/pci/switch_discovery.rst
> > > +F:   drivers/pci/switch/switch_discovery.c
> > > +F:   drivers/pci/switch/switch_discovery.h
> > > +
> > >  PCI SUBSYSTEM
> > >  M:   Bjorn Helgaas <bhelgaas@google.com>
> > >  L:   linux-pci@vger.kernel.org
> > > diff --git a/drivers/pci/switch/Kconfig b/drivers/pci/switch/Kconfig
> > > index d370f4ce0492..fb4410153950 100644
> > > --- a/drivers/pci/switch/Kconfig
> > > +++ b/drivers/pci/switch/Kconfig
> > > @@ -12,4 +12,13 @@ config PCI_SW_SWITCHTEC
> > >        devices. See <file:Documentation/driver-api/switchtec.rst> for more
> > >        information.
> > >
> > > +config PCI_SW_DISCOVERY
> > > +     depends on PCI
> > > +     tristate "PCI Switch discovery module"
> > > +     help
> > > +      This kernel module discovers the PCI-to-PCI bridges of PCIe switches
> > > +      and forms the virtual switch links if the bridges belong to the same
> > > +      Physical switch. The switch links help to identify shorter distances
> > > +      for P2P configurations.
> > > +
> > >  endmenu
> > > diff --git a/drivers/pci/switch/Makefile b/drivers/pci/switch/Makefile
> > > index acd56d3b4a35..a3584b5146af 100644
> > > --- a/drivers/pci/switch/Makefile
> > > +++ b/drivers/pci/switch/Makefile
> > > @@ -1,2 +1,3 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_PCI_SW_SWITCHTEC) += switchtec.o
> > > +obj-$(CONFIG_PCI_SW_DISCOVERY) += switch_discovery.o
> > > diff --git a/drivers/pci/switch/switch_discovery.c b/drivers/pci/switch/switch_discovery.c
> > > new file mode 100644
> > > index 000000000000..a427d3885b1f
> > > --- /dev/null
> > > +++ b/drivers/pci/switch/switch_discovery.c
> > > @@ -0,0 +1,375 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + *  PCI Switch Discovery module
> > > + *
> > > + *  Copyright (c) 2024  Broadcom Inc.
> > > + *
> > > + *  Authors: Broadcom Inc.
> > > + *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > > + *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > > + */
> > > +
> > > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > > +
> > > +#include <linux/init.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/module.h>
> > > +#include <linux/sysfs.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/rwsem.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/vmalloc.h>
> >
> > Pick an ordering scheme for headers. Can't remember which PCI uses
> > but alphabetical is always a good starting point unless there is
> > a local standard.
> >
> > > +#include "switch_discovery.h"
> > > +
> > > +static DECLARE_RWSEM(sw_disc_rwlock);
> > > +static struct kobject *sw_disc_kobj, *sw_link_kobj;
> > > +static struct kobject *sw_kobj[SWD_MAX_VIRT_SWITCH];
> > Why can't this be dynamically sized?  Use a list.
> >
> > > +static DECLARE_BITMAP(swdata_valid, SWD_MAX_VIRT_SWITCH);
> > > +
> > > +static struct switch_data *swdata;
> > > +
> > > +static int sw_disc_probe(void);
> > > +static int sw_disc_create_sysfs_files(void);
> > > +static bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_num);
> >
> > Can you reorder the code to avoid the need for these forwards definitions?
> >
> > > +
> > > +static inline bool sw_disc_is_supported_pdev(struct pci_dev *pdev)
> > > +{
> > > +     if ((pdev->vendor == PCI_VENDOR_ID_LSI) &&
> > > +        ((pdev->device == PCI_DEVICE_ID_BRCM_PEX_89000_HLC) ||
> > > +         (pdev->device == PCI_DEVICE_ID_BRCM_PEX_89000_LLC)))
> > > +             return true;
> > > +
> > > +     return false;
> > > +}
> > > +
> > > +static ssize_t sw_disc_show(struct kobject *kobj,
> > > +                     struct kobj_attribute *attr,
> > > +                     char *buf)
> > > +{
> > > +     int retval;
> > > +
> > > +     down_write(&sw_disc_rwlock);
> > > +     retval = sw_disc_probe();
> > > +     if (!retval) {
> > > +             pr_debug("No new switch found\n");
> > > +             goto exit_success;
> > > +     }
> > > +
> > > +     retval = sw_disc_create_sysfs_files();
> > > +     if (retval < 0) {
> > > +             pr_err("Failed to create the sysfs entries, retval %d\n",
> > > +                    retval);
> > > +     }
> > > +
> > > +exit_success:
> > > +     up_write(&sw_disc_rwlock);
> > > +     return sysfs_emit(buf, SWD_SCAN_DONE);
> > Don't have side effects on a read.  Write 1 to the file to scan and when
> > it is done, return len;
> >
> > > +}
> > > +
> > > +/* This function probes the PCIe devices for virtual links */
> >
> > I'm not sure if a bus walk and search is the right way to do this.
> >
> > I need to think on this more, but options that occur are:
> > 1) Do it in the PCI core (so without a driver binding).
> >    /sys/bus/pci/devices/0000:0c:00.0/isl/0000:12:00.0 -> ../../../0000:12:00.0
> >    Controversial perhaps because PCIe provides no 'standard' way to discover
> >    this but it it is slim enough, maybe?
> >
> > 2) Do it in portdrv as that will currently bind to the USP anyway.
> >
> > There are other discussions on going on refactoring the pcie portdrv
> > and this usecase might well fit in there.  Doesn't seem very invasive
> > to add this.
> >
> > > +static int sw_disc_probe(void)
> > > +{
> > > +     int i, bit;
> > > +     struct pci_dev *pdev = NULL;
> > > +     int topology_changed = 0;
> > > +     DECLARE_BITMAP(sw_found_map, SWD_MAX_VIRT_SWITCH);
> >
> > As above, I'd use a list of found virtual switches then removal
> > is dropping an entry from middle of that list.
> > Probe finds what is there and moves things to a new temporary list.
> > Delete anything left on the old list.
> >
> > > +
> > > +     while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
> >
> > Not using the port class code?  Feels like every switch will if this isn't
> > in a different function? (I've been assuming it is vsec on the USP function)
> >
> > > +             int sw_found;
> > > +
> > > +             /* Currently this function only traverses Broadcom
> > > +              * PEX switches and determines the virtual SW links.
> > > +              * Other Switch vendors can add their specific logic
> > > +              * determine the virtual links.
> > > +              */
> >
> > I'd move this comment to the supported query. As you observe, it is
> > general in principle.
> >
> > > +             if (!sw_disc_is_supported_pdev(pdev))
> >
> > It's not really about discovering switches. So I'd call it
> > sw_might_be_virtual_switch() or something like that.
> >
> > I'm sure we'll eventually have to handle multiple physical switches
> > with a real interswitchlink at some point, but that can be addressed
> > separately.
> >
> >
> > > +                     continue;
> > > +
> > > +             sw_found = -1;
> >
> > int sw_found = -1; above
> >
> > > +
> > > +             for_each_set_bit(bit, swdata_valid, SWD_MAX_VIRT_SWITCH) {
> > > +                     if (swdata[bit].devfn == pdev->devfn &&
> > > +                         swdata[bit].bus == pdev->bus) {
> >
> > Can we use an xarray or similar to do this lookup?
> >
> > > +                             sw_found = bit;
> > > +                             set_bit(sw_found, sw_found_map);
> > > +                             break;
> > > +                     }
> > > +             }
> > > +
> > > +             if (sw_found != -1)
> > > +                     continue;
> > > +
> > > +             for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++)
> > > +                     if (!swdata[i].bus)
> > > +                             break;
> > > +
> > > +             if (i >= SWD_MAX_VIRT_SWITCH) {
> > > +                     pr_err("Max switch exceeded\n");
> > > +                     break;
> > > +             }
> > > +
> > > +             sw_found = i;
> > > +
> > > +             if (!brcm_sw_is_p2p_supported(pdev, (char *)&swdata[sw_found].serial_num))
> > > +                     continue;
> > > +
> > > +             /* Found a new switch which supports P2P */
> > > +             swdata[sw_found].devfn = pdev->devfn;
> > > +             swdata[sw_found].bus = pdev->bus;
> > > +
> > > +             topology_changed = 1;
> > > +             set_bit(sw_found, sw_found_map);
> > > +             set_bit(sw_found, swdata_valid);
> > > +     }
> > > +
> > > +     /* handle device removal */
> > > +     for_each_clear_bit(bit, sw_found_map, SWD_MAX_VIRT_SWITCH) {
> > > +             if (test_bit(bit, swdata_valid)) {
> > > +                     memset(&swdata[bit], 0, sizeof(swdata[i]));
> > > +                     clear_bit(bit, swdata_valid);
> > > +                     topology_changed = 1;
> > > +             }
> > > +     }
> > > +
> > > +     return topology_changed;
> > > +}
> > > +
> > > +/* Check the various config space registers of the Broadcom PCI device and
> > > + * return true if the device supports inter switch P2P.
> > > + * If P2P is supported, return the device serial number back to
> > > + * caller.
> > > + */
> > > +bool brcm_sw_is_p2p_supported(struct pci_dev *pdev, char *serial_num)
> > > +{
> > > +     int base;
> > > +     u32 cap_data1, cap_data2;
> > > +     u16 vsec;
> > > +     u32 vsec_data;
> > > +
> > > +     base = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DSN);
> > > +     if (!base) {
> > > +             pr_debug("Failed to get extended capability bus %x devfn %x\n",
> > > +                      pdev->bus->number, pdev->devfn);
> > > +             return false;
> > > +     }
> >
> > I'd just call pci_get_dsn()   If it doesn't return 0 the cap is there
> > and we get the value and just use it.
> >
> >
> > > +
> > > +     vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_LSI, 1);
> > > +     if (!vsec) {
> > > +             pr_debug("Failed to get VSEC bus %x devfn %x\n",
> > > +                      pdev->bus->number, pdev->devfn);
> > > +             return false;
> > > +     }
> > > +
> > > +     if (pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM)
> > > +             return false;
> >
> > I'd do this first.  Will apply to a lot of matches and this
> > is much cheaper than finding capabilities.
> >
> > > +
> > > +     pci_read_config_dword(pdev, base + 8, &cap_data1);
> > > +     pci_read_config_dword(pdev, base + 4, &cap_data2);
> > > +
> > > +     pci_read_config_dword(pdev, vsec + 12, &vsec_data);
> >
> > Use a define for that vsec offset that gives some indication
> > of it's purpose in the LSI VSEC.
> >
> > > +
> > > +     pr_debug("Found Broadcom device bus 0x%x devfn 0x%x "
> > > +              "Serial Number: 0x%x 0x%x, VSEC 0x%x\n",
> > > +              pdev->bus->number, pdev->devfn,
> > > +              cap_data1, cap_data2, vsec_data);
> > > +
> > > +     if (!SECURE_PART(cap_data1))
> > > +             return false;
> > FIELD_GET()
> >
> > > +
> > > +     if (!(P2PMASK(vsec_data) & INTER_SWITCH_LINK))
> >
> > FIELD_GET() for the relevant bits in each.
> >
> > > +             return false;
> > > +
> > > +     if (serial_num)
> > > +             snprintf(serial_num, SWD_MAX_CHAR, "%x%x", cap_data1, cap_data2);
> > Just use the u64.
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +static int sw_disc_create_sysfs_files(void)
> > > +{
> > > +     int i, j, retval;
> > > +
> > > +     for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> > > +             if (sw_kobj[i]) {
> > > +                     kobject_put(sw_kobj[i]);
> > > +                     sw_kobj[i] = NULL;
> > If you are freeing kobjects in a creation path something went wrong.
> > Don't do this - if it makes sense free them before calling this create function.
> >
> > > +             }
> > > +     }
> > > +
> > > +     if (sw_link_kobj) {
> > > +             kobject_put(sw_link_kobj);
> > > +             sw_link_kobj = NULL;
> > > +     }
> > > +
> > > +     sw_link_kobj = kobject_create_and_add(SWD_LINK_DIR_STRING, sw_disc_kobj);
> >
> > Don't use defines for file names. We want to see them inline as
> > much more readable!
> >
> > > +     if (!sw_link_kobj) {
> > > +             pr_err("Failed to create pci link object\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> > > +             int segment, bus, device, function;
> > > +             char bdf_i[SWD_MAX_CHAR];
> >
> > No obvious reason why this is the same length as serial numbers?
> > Use an appropriate define for each.  We print the bdf in
> > various places, maybe there is already a suitable define and if
> > not perhaps worth adding one.
> >
> > > +
> > > +             if (!test_bit(i, swdata_valid))
> > > +                     continue;
> > > +
> > > +             segment = pci_domain_nr(swdata[i].bus);
> > > +             bus = swdata[i].bus->number;
> > > +             device = pci_ari_enabled(swdata[i].bus) ?
> > > +                             0 : PCI_SLOT(swdata[i].devfn);
> > > +             function = pci_ari_enabled(swdata[i].bus) ?
> > > +                             swdata[i].devfn : PCI_FUNC(swdata[i].devfn);
> > > +             sprintf(bdf_i, "%04x:%02x:%02x.%x",
> > > +                     segment, bus, device, function);
> > > +
> > > +             for (j = i + 1; j < SWD_MAX_VIRT_SWITCH; j++) {
> > > +                     char bdf_j[SWD_MAX_CHAR];
> > > +
> > > +                     if (!test_bit(j, swdata_valid))
> > > +                             continue;
> > > +                     segment = pci_domain_nr(swdata[j].bus);
> > > +                     bus = swdata[j].bus->number;
> > > +                     device = pci_ari_enabled(swdata[j].bus) ?
> > > +                                     0 : PCI_SLOT(swdata[j].devfn);
> > > +                     function = pci_ari_enabled(swdata[j].bus) ?
> > > +                                     swdata[j].devfn : PCI_FUNC(swdata[j].devfn);
> > > +                     sprintf(bdf_j, "%04x:%02x:%02x.%x",
> > > +                             segment, bus, device, function);
> > > +
> > > +                     if (strcmp(swdata[i].serial_num, swdata[j].serial_num) == 0) {
> > > +                             if (!sw_kobj[i]) {
> > > +                                     sw_kobj[i] = kobject_create_and_add(bdf_i,
> > > +                                                                         sw_link_kobj);
> > > +                                     if (!sw_kobj[i]) {
> > > +                                             pr_err("Failed to create sysfs entry for switch %s\n",
> > > +                                                    bdf_i);
> > > +                                     }
> > > +                             }
> > > +
> > > +                             if (!sw_kobj[j]) {
> > > +                                     sw_kobj[j] = kobject_create_and_add(bdf_j,
> > > +                                                                         sw_link_kobj);
> > > +                                     if (!sw_kobj[j]) {
> > > +                                             pr_err("Failed to create sysfs entry for switch %s\n",
> > > +                                                    bdf_j);
> > > +                                     }
> > > +                             }
> > > +
> > > +                             retval = sysfs_create_link(sw_kobj[i], sw_kobj[j], bdf_j);
> > > +                             if (retval)
> > > +                                     pr_err("Error creating symlink %s and %s\n",
> > > +                                            bdf_i, bdf_j);
> > > +
> > > +                             retval = sysfs_create_link(sw_kobj[j], sw_kobj[i], bdf_i);
> > > +                             if (retval)
> > > +                                     pr_err("Error creating symlink %s and %s\n",
> > > +                                            bdf_j, bdf_i);
> > > +                     }
> > > +             }
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +/*
> > > + * Check if the two pci devices have virtual P2P link available.
> > > + * This function is used by the p2pdma to determine virtual
> > > + * links between the PCI-to-PCI bridges
> > > + */
> > > +bool sw_disc_check_virtual_link(struct pci_dev *a,
> > > +                              struct pci_dev *b)
> > No need to wrrap line.
> >
> > > +{
> > > +     char serial_num_a[SWD_MAX_CHAR], serial_num_b[SWD_MAX_CHAR];
> > > +
> > > +     /*
> > > +      * Check if the PCIe devices support Virtual P2P links
> > > +      */
> >
> > Single line comment
> >         /* Check if the PCIe devices support Virtual P2P links */
> >
> > > +     if (!sw_disc_is_supported_pdev(a))
> > > +             return false;
> > > +
> > > +     if (!sw_disc_is_supported_pdev(b))
> > > +             return false;
> > > +
> > > +     if (brcm_sw_is_p2p_supported(a, serial_num_a) &&
> > > +         brcm_sw_is_p2p_supported(b, serial_num_b))
> > > +             if (!strcmp(serial_num_a, serial_num_b))
> > > +                     return true;
> > > +
> > > +     return false;
> > > +}
> > > +EXPORT_SYMBOL_GPL(sw_disc_check_virtual_link);
> > > +
> > > +static struct kobj_attribute sw_disc_attribute =
> > > +     __ATTR(SWD_FILE_NAME_STRING, 0444, sw_disc_show, NULL);
> >
> > As below. Use string directly for file names, don't hide it behind
> > a define.
> >
> > > +
> > > +// Create attribute group
> > Drop comment + if it was here /* */
> >
> > > +static struct attribute *attrs[] = {
> > > +     &sw_disc_attribute.attr,
> > > +     NULL,
> > No comma on NULL terminators as we won't add anything after them.
> >
> > > +};
> > > +
> > > +static struct attribute_group attr_group = {
> > > +     .attrs = attrs,
> > > +};
> > > +
> > > +static int __init sw_discovery_init(void)
> > > +{
> > > +     int i, retval;
> > > +
> > > +     for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++)
> > > +             sw_kobj[i] = NULL;
> > > +
> > > +     // Create "sw_disc" kobject
> >
> > Drop any 'obvious' comments.
> >
> > > +     sw_disc_kobj = kobject_create_and_add(SWD_DIR_STRING, kernel_kobj);
> > > +     if (!sw_disc_kobj) {
> > > +             pr_err("Failed to create sw_disc_kobj\n");
> > > +             return -ENOMEM;
> > > +     }
> > > +
> > > +     retval = sysfs_create_group(sw_disc_kobj, &attr_group);
> > > +     if (retval) {
> > > +             pr_err("Cannot register sysfs attribute group\n");
> > > +             kobject_put(sw_disc_kobj);
> > return an error.
> > > +     }
> > > +
> > > +     swdata = kzalloc(sizeof(swdata) * SWD_MAX_VIRT_SWITCH, GFP_KERNEL);
> > > +     if (!swdata) {
> > > +             sysfs_remove_group(sw_disc_kobj, &attr_group);
> > > +             kobject_put(sw_disc_kobj);
> > return an error.
> > > +             return 0;
> > > +     }
> > > +
> > > +     pr_info("Loading PCIe switch discovery module, version %s\n",
> > > +             SWITCH_DISC_VERSION);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void __exit sw_discovery_exit(void)
> > > +{
> > > +     int i;
> > > +
> > > +     if (!swdata)
> > I'm fairly sure that if you return an error in failure above (which shouldn't
> > fail anyway) you won't need this protection as for exit() to be called init()
> > must have succeeded and the data must have been allocated.
> >
> > > +             kfree(swdata);
> > > +
> > > +     for (i = 0; i < SWD_MAX_VIRT_SWITCH; i++) {
> > > +             if (sw_kobj[i])
> > > +                     kobject_put(sw_kobj[i]);
> > > +     }
> > > +
> > > +     // Remove kobject
> >
> > /* Remove kobject */ but that's pretty obvious anyway so better to just drop the
> > comment.
> >
> >
> > > +     if (sw_link_kobj)
> > > +             kobject_put(sw_link_kobj);
> > > +
> > > +     sysfs_remove_group(sw_disc_kobj, &attr_group);
> > > +     kobject_put(sw_disc_kobj);
> > > +}
> > > +
> > > +module_init(sw_discovery_init);
> > > +module_exit(sw_discovery_exit);
> > > +
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_AUTHOR("Broadcom Inc.");
> > > +MODULE_VERSION(SWITCH_DISC_VERSION);
> > > +MODULE_DESCRIPTION("PCIe Switch Discovery Module");
> > > diff --git a/drivers/pci/switch/switch_discovery.h b/drivers/pci/switch/switch_discovery.h
> > > new file mode 100644
> > > index 000000000000..b84f5d2e29ac
> > > --- /dev/null
> > > +++ b/drivers/pci/switch/switch_discovery.h
> > > @@ -0,0 +1,44 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +/*
> > > + *  PCI Switch Discovery module
> > > + *
> > > + *  Copyright (c) 2024  Broadcom Inc.
> > > + *
> > > + *  Authors: Broadcom Inc.
> > > + *           Sumanesh Samanta <sumanesh.samanta@broadcom.com>
> > > + *           Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> > Why is the header needed?  Only seems to be used from one c file.
> > Move everything down there and drop this file.
> >
> > > + */
> > > +
> > > +#ifndef PCI_SWITCH_DISC_H
> > > +#define PCI_SWITCH_DISC_H
> > > +
> > > +#define SWD_MAX_SWITCH               32
> > > +#define SWD_MAX_VER_PER_SWITCH       8
> > > +
> > > +#define SWD_MAX_VIRT_SWITCH  (SWD_MAX_SWITCH * SWD_MAX_VER_PER_SWITCH)
> > > +#define SWD_MAX_CHAR         16
> >
> > Name this so it's clearer what it is sizing.
> >
> > > +#define SWITCH_DISC_VERSION  "0.1.1"
> >
> > Whilst there are module versions in the kernel etc, they are meaningless
> > as we must support backwards compatibility anyway. So don't give
> > it a version (this is basically ancient legacy no one uses any more)
> >
> > > +#define SWD_DIR_STRING               "pci_switch_link"
> > All these better inline.  Defines just make yoru code harder to read.
> > > +#define SWD_LINK_DIR_STRING  "virtual_switch_links"
> > > +#define SWD_SCAN_DONE                "done\n"
> > Definitely inline!
> >
> > > +
> > > +#define SWD_FILE_NAME_STRING refresh_switch_toplogy
> > Just use the string directly inline. This doesn't belong in
> > a header.
> > > +
> > > +/* Broadcom Vendor Specific definitions */
> > > +#define PCI_VENDOR_ID_LSI                    0x1000
> > > +#define PCI_DEVICE_ID_BRCM_PEX_89000_HLC     0xC030
> > > +#define PCI_DEVICE_ID_BRCM_PEX_89000_LLC     0xC034
> >
> > > +
> > > +#define P2PMASK(x)           (((x) & 0x300) >> 8)
> >
> > Use FIELD_GET() on the mask alone and make sure it's clear from
> > naming what register this applies to.
> >
> > > +#define SECURE_PART(x)               ((x) & 0x8)
> > > +#define INTER_SWITCH_LINK    0x2
> > Give this a name that matches with a register name or smilar.
> >
> > > +
> > > +struct switch_data {
> >
> > More specific name needed as this will clash with something at somepoint
> > in the future
> >
> > > +     int  devfn;
> > extra space before devfn.
> >
> > > +     struct pci_bus *bus;
> > > +     char serial_num[SWD_MAX_CHAR];
> > > +};
> > > +
> > > +bool sw_disc_check_virtual_link(struct pci_dev *a, struct pci_dev *b);
> > > +
> > > +#endif /* PCI_SWITCH_DISC_H */
> >
> 
> -- 
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.



-- 
மணிவண்ணன் சதாசிவம்

