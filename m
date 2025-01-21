Return-Path: <linux-pci+bounces-20210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC49DA18570
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 20:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C068316792C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 19:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4501186294;
	Tue, 21 Jan 2025 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="rFh7AtXj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0075CE57D
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 19:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737486116; cv=none; b=sVz9E6a5veTckc1x04ftYuGNofCPgKeCOo5uvB+TOro8Pv7zBM27c7/BrFNfNLWNrIlap2e5rxYEj9t6/seAQluFn4903qpthVrPKWXsqvQrnJGTxhkry3waayvJhB/+ZcZpS6J+8JygQOOUYnJHGxKh9u3A8mAyPvaFTUbeXwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737486116; c=relaxed/simple;
	bh=CAWxStfiwMZ75bFGshhNosdyaxzjH5KgoH3YUBHIzyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKTalKqMg7XvIt5GKrHIonfCrCUAQsnAErEFr67rS44ct6D8NmBBpCTsxV6Ovq4fs0yKEkLT0MHei8c+Q1JrzuAwmQKxkyG+tlNZimxBCIqpSdvr95QRm5hOuYB7VUUCjOQ7jKCOdr4u7Rlz9oUf1xjX1UlAYT9UbF+/DZigpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=rFh7AtXj; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25B3A3F181
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 19:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1737486112;
	bh=GMzw9GXlDyvS/BSEbrNLg/9Jk00HsS1BvVcf82jJIfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=rFh7AtXjPwRdfNOrB5ogRt2w746KCSqE4uzElBOaTZ9M4wSo3eJ4Ri4RJbsN4RyIY
	 qPnzYyN14vWSg80yQSCE71dl8y6eYSBpr26/MYsLPjC+m9XvJyNJnOBA42bJmIP3sq
	 il9Aus3YwZ6PLeNzppz3BjZXQdPw/3H/xh2NeLoBKNPhQMiAHACncu+6mTv5BWhvPC
	 IfR4/Ec1jXTaV0Doej2ynZ8zA4HyHPsZ68SKjLaae4KhDoPlrPwHIFFs/e3F+Gl2sP
	 chsDKcgYYCI/J82zk2h+pFZLdAgBAP8h7aT1Mfvqe2vthRMQiCBrUPDrkjuTyh9gq0
	 SXbXDlDuMmWPA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5dbaaed8aeeso3905903a12.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 11:01:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737486111; x=1738090911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMzw9GXlDyvS/BSEbrNLg/9Jk00HsS1BvVcf82jJIfg=;
        b=g1DkLCg2eorZvkDddkU/JoGVPIwCScBMN65MiBTYCok/Z/FTHwSHDOrdM8pZnefBDZ
         uqS4gpNsxBgN3D9Axpd1TxatFZ12FFQIpy1IOwBTMsmP4WijWXgWoKFWwsoJL0PUwTPu
         crzjlbbldZtNVdFi/zlyEIqnIciRQhF7GflY6OAx/LAmCQu9GLGrEthVwC+YGYrRjYEm
         kpfNSWurlKLxJxDF3beTQk55uftAGoGpb3wIP7U3xt9wzFbPFKQ/mflFq3W5wFjIJ9Im
         wDDn1cDUQv4XuQnAcv3VBaXVRVnnIKqNp5Mk7e62rlCtSoXe+fgddqtEHA1rJr3vVu7N
         EK3g==
X-Forwarded-Encrypted: i=1; AJvYcCVpnnCvk3n5nAHazJcB209hruPR3gOp98DjkRpOUlmqTP5je5K5QRwBD0Tu+9U4Ey90lgWLlK/AXQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQX1zixyGMfk1uZjR0bXe+oEzP3g8Wx0eMyKGEy5mDGS82CBa
	Lzf2NVQ2nxCsfOcj6nSuudU4WYy+kIKNOISebOjCMZOFmOZx5Q3Yez5Payvdipse0BH1BsCA67h
	PTmd+ClQEuGcCiT7LWHt7mMk1rxpyg622Td/MxTMVuPuBv6hFZ/mgJc2/b3HHfVapnrStBf1uAS
	fN/X3e/o2R5T2rTgpTuq7viKiE+CrslGlhsbKjVaTui4Cj+7hR
X-Gm-Gg: ASbGncun4HkZIYW7OAsftnFqIEEhJvW3K4XiSf/PyPMEqf2kcD3iBK2wcPCqFIMx1tN
	sELCD93NmZX8uhxb6EWVQboyoMvM3zF5Bn7w3PbjqBOqvKdi8KQ==
X-Received: by 2002:a05:6402:2349:b0:5d9:a61:ed1c with SMTP id 4fb4d7f45d1cf-5db7d2f5794mr16967998a12.11.1737486111431;
        Tue, 21 Jan 2025 11:01:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjSR7v4NE4zxVOWRUqyW6akAXN9rnUkckA64I0H70QyFQnv8H+8sZEogdsaupItQ5gZ8LqsAfzjnqlli29AZU=
X-Received: by 2002:a05:6402:2349:b0:5d9:a61:ed1c with SMTP id
 4fb4d7f45d1cf-5db7d2f5794mr16967930a12.11.1737486110901; Tue, 21 Jan 2025
 11:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120182202.1878581-1-alex.williamson@redhat.com> <20250120224418.GA906057@bhelgaas>
In-Reply-To: <20250120224418.GA906057@bhelgaas>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Tue, 21 Jan 2025 13:01:39 -0600
X-Gm-Features: AbW1kvZfBLhqzngDqNjzT3WgJLVDlLzaeJwbEsZAcahljmKdrSJ6_TA1yeCBu8c
Message-ID: <CAHTA-ubVtNfT9-MW=ts7LGN8apOhV8Yr3iv-Pv3-75E=0c0=7w@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Batch BAR sizing operations
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Alex Williamson <alex.williamson@redhat.com>, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Alex,

I just verified that v2 of the patch causes no regressions and
performs just as well as v1 and my original patch on my hardware.

Reviewed-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Tested-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>


On Mon, Jan 20, 2025 at 4:44=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Mon, Jan 20, 2025 at 11:21:59AM -0700, Alex Williamson wrote:
> > Toggling memory enable is free on bare metal, but potentially expensive
> > in virtualized environments as the device MMIO spaces are added and
> > removed from the VM address space, including DMA mapping of those space=
s
> > through the IOMMU where peer-to-peer is supported.  Currently memory
> > decode is disabled around sizing each individual BAR, even for SR-IOV
> > BARs while VF Enable is cleared.
> >
> > This can be better optimized for virtual environments by sizing a set
> > of BARs at once, stashing the resulting mask into an array, while only
> > toggling memory enable once.  This also naturally improves the SR-IOV
> > path as the caller becomes responsible for any necessary decode disable=
s
> > while sizing BARs, therefore SR-IOV BARs are sized relying only on the
> > VF Enable rather than toggling the PF memory enable in the command
> > register.
> >
> > Reported-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> > Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEy=
ZgQZub4mDRrV5w@mail.gmail.com
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
>
> Updated pci/enumeration with this v2, thanks, Alex!
>
> > ---
> >
> > v2:
> >  - Move PCI_POSSIBLE_ERROR() test back to original location such that i=
t
> >    only tests the lower half of 64-bit BARs as noted by Ilpo J=C3=A4rvi=
nen.
> >  - Reduce delta from original code by retaining the local @sz variable
> >    filled from the @sizes array and keep location of parsing upper half
> >    of 64-bit BARs.
> >
> >  drivers/pci/iov.c   |  8 +++-
> >  drivers/pci/pci.h   |  4 +-
> >  drivers/pci/probe.c | 93 +++++++++++++++++++++++++++++++++------------
> >  3 files changed, 78 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 4be402fe9ab9..9e4770cdd4d5 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -747,6 +747,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >       struct resource *res;
> >       const char *res_name;
> >       struct pci_dev *pdev;
> > +     u32 sriovbars[PCI_SRIOV_NUM_BARS];
> >
> >       pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
> >       if (ctrl & PCI_SRIOV_CTRL_VFE) {
> > @@ -783,6 +784,10 @@ static int sriov_init(struct pci_dev *dev, int pos=
)
> >       if (!iov)
> >               return -ENOMEM;
> >
> > +     /* Sizing SR-IOV BARs with VF Enable cleared - no decode */
> > +     __pci_size_stdbars(dev, PCI_SRIOV_NUM_BARS,
> > +                        pos + PCI_SRIOV_BAR, sriovbars);
> > +
> >       nres =3D 0;
> >       for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> >               res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> > @@ -796,7 +801,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >                       bar64 =3D (res->flags & IORESOURCE_MEM_64) ? 1 : =
0;
> >               else
> >                       bar64 =3D __pci_read_base(dev, pci_bar_unknown, r=
es,
> > -                                             pos + PCI_SRIOV_BAR + i *=
 4);
> > +                                             pos + PCI_SRIOV_BAR + i *=
 4,
> > +                                             &sriovbars[i]);
> >               if (!res->flags)
> >                       continue;
> >               if (resource_size(res) & (PAGE_SIZE - 1)) {
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2e40fc63ba31..6f27651c2a70 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -315,8 +315,10 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci=
_bus *bus, int devfn, u32 *pl,
> >  int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs=
_timeout);
> >
> >  int pci_setup_device(struct pci_dev *dev);
> > +void __pci_size_stdbars(struct pci_dev *dev, int count,
> > +                     unsigned int pos, u32 *sizes);
> >  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> > -                 struct resource *res, unsigned int reg);
> > +                 struct resource *res, unsigned int reg, u32 *sizes);
> >  void pci_configure_ari(struct pci_dev *dev);
> >  void __pci_bus_size_bridges(struct pci_bus *bus,
> >                       struct list_head *realloc_head);
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 2e81ab0f5a25..bf6aec555044 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -164,41 +164,67 @@ static inline unsigned long decode_bar(struct pci=
_dev *dev, u32 bar)
> >
> >  #define PCI_COMMAND_DECODE_ENABLE    (PCI_COMMAND_MEMORY | PCI_COMMAND=
_IO)
> >
> > +/**
> > + * __pci_size_bars - Read the raw BAR mask for a range of PCI BARs
> > + * @dev: the PCI device
> > + * @count: number of BARs to size
> > + * @pos: starting config space position
> > + * @sizes: array to store mask values
> > + * @rom: indicate whether to use ROM mask, which avoids enabling ROM B=
ARs
> > + *
> > + * Provided @sizes array must be sufficiently sized to store results f=
or
> > + * @count u32 BARs.  Caller is responsible for disabling decode to spe=
cified
> > + * BAR range around calling this function.  This function is intended =
to avoid
> > + * disabling decode around sizing each BAR individually, which can res=
ult in
> > + * non-trivial overhead in virtualized environments with very large PC=
I BARs.
> > + */
> > +static void __pci_size_bars(struct pci_dev *dev, int count,
> > +                         unsigned int pos, u32 *sizes, bool rom)
> > +{
> > +     u32 orig, mask =3D rom ? PCI_ROM_ADDRESS_MASK : ~0;
> > +     int i;
> > +
> > +     for (i =3D 0; i < count; i++, pos +=3D 4, sizes++) {
> > +             pci_read_config_dword(dev, pos, &orig);
> > +             pci_write_config_dword(dev, pos, mask);
> > +             pci_read_config_dword(dev, pos, sizes);
> > +             pci_write_config_dword(dev, pos, orig);
> > +     }
> > +}
> > +
> > +void __pci_size_stdbars(struct pci_dev *dev, int count,
> > +                     unsigned int pos, u32 *sizes)
> > +{
> > +     __pci_size_bars(dev, count, pos, sizes, false);
> > +}
> > +
> > +static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 =
*sizes)
> > +{
> > +     __pci_size_bars(dev, 1, pos, sizes, true);
> > +}
> > +
> >  /**
> >   * __pci_read_base - Read a PCI BAR
> >   * @dev: the PCI device
> >   * @type: type of the BAR
> >   * @res: resource buffer to be filled in
> >   * @pos: BAR position in the config space
> > + * @sizes: array of one or more pre-read BAR masks
> >   *
> >   * Returns 1 if the BAR is 64-bit, or 0 if 32-bit.
> >   */
> >  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> > -                 struct resource *res, unsigned int pos)
> > +                 struct resource *res, unsigned int pos, u32 *sizes)
> >  {
> > -     u32 l =3D 0, sz =3D 0, mask;
> > +     u32 l =3D 0, sz;
> >       u64 l64, sz64, mask64;
> > -     u16 orig_cmd;
> >       struct pci_bus_region region, inverted_region;
> >       const char *res_name =3D pci_resource_name(dev, res - dev->resour=
ce);
> >
> > -     mask =3D type ? PCI_ROM_ADDRESS_MASK : ~0;
> > -
> > -     /* No printks while decoding is disabled! */
> > -     if (!dev->mmio_always_on) {
> > -             pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> > -             if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> > -                     pci_write_config_word(dev, PCI_COMMAND,
> > -                             orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> > -             }
> > -     }
> > -
> >       res->name =3D pci_name(dev);
> >
> >       pci_read_config_dword(dev, pos, &l);
> > -     pci_write_config_dword(dev, pos, l | mask);
> > -     pci_read_config_dword(dev, pos, &sz);
> > -     pci_write_config_dword(dev, pos, l);
> > +     sz =3D sizes[0];
> >
> >       /*
> >        * All bits set in sz means the device isn't working properly.
> > @@ -238,18 +264,13 @@ int __pci_read_base(struct pci_dev *dev, enum pci=
_bar_type type,
> >
> >       if (res->flags & IORESOURCE_MEM_64) {
> >               pci_read_config_dword(dev, pos + 4, &l);
> > -             pci_write_config_dword(dev, pos + 4, ~0);
> > -             pci_read_config_dword(dev, pos + 4, &sz);
> > -             pci_write_config_dword(dev, pos + 4, l);
> > +             sz =3D sizes[1];
> >
> >               l64 |=3D ((u64)l << 32);
> >               sz64 |=3D ((u64)sz << 32);
> >               mask64 |=3D ((u64)~0 << 32);
> >       }
> >
> > -     if (!dev->mmio_always_on && (orig_cmd & PCI_COMMAND_DECODE_ENABLE=
))
> > -             pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> > -
> >       if (!sz64)
> >               goto fail;
> >
> > @@ -320,7 +341,11 @@ int __pci_read_base(struct pci_dev *dev, enum pci_=
bar_type type,
> >
> >  static void pci_read_bases(struct pci_dev *dev, unsigned int howmany, =
int rom)
> >  {
> > +     u32 rombar, stdbars[PCI_STD_NUM_BARS];
> >       unsigned int pos, reg;
> > +     u16 orig_cmd;
> > +
> > +     BUILD_BUG_ON(howmany > PCI_STD_NUM_BARS);
> >
> >       if (dev->non_compliant_bars)
> >               return;
> > @@ -329,10 +354,28 @@ static void pci_read_bases(struct pci_dev *dev, u=
nsigned int howmany, int rom)
> >       if (dev->is_virtfn)
> >               return;
> >
> > +     /* No printks while decoding is disabled! */
> > +     if (!dev->mmio_always_on) {
> > +             pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> > +             if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> > +                     pci_write_config_word(dev, PCI_COMMAND,
> > +                             orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> > +             }
> > +     }
> > +
> > +     __pci_size_stdbars(dev, howmany, PCI_BASE_ADDRESS_0, stdbars);
> > +     if (rom)
> > +             __pci_size_rom(dev, rom, &rombar);
> > +
> > +     if (!dev->mmio_always_on &&
> > +         (orig_cmd & PCI_COMMAND_DECODE_ENABLE))
> > +             pci_write_config_word(dev, PCI_COMMAND, orig_cmd);
> > +
> >       for (pos =3D 0; pos < howmany; pos++) {
> >               struct resource *res =3D &dev->resource[pos];
> >               reg =3D PCI_BASE_ADDRESS_0 + (pos << 2);
> > -             pos +=3D __pci_read_base(dev, pci_bar_unknown, res, reg);
> > +             pos +=3D __pci_read_base(dev, pci_bar_unknown,
> > +                                    res, reg, &stdbars[pos]);
> >       }
> >
> >       if (rom) {
> > @@ -340,7 +383,7 @@ static void pci_read_bases(struct pci_dev *dev, uns=
igned int howmany, int rom)
> >               dev->rom_base_reg =3D rom;
> >               res->flags =3D IORESOURCE_MEM | IORESOURCE_PREFETCH |
> >                               IORESOURCE_READONLY | IORESOURCE_SIZEALIG=
N;
> > -             __pci_read_base(dev, pci_bar_mem32, res, rom);
> > +             __pci_read_base(dev, pci_bar_mem32, res, rom, &rombar);
> >       }
> >  }
> >
> > --
> > 2.47.1
> >



--=20
Mitchell Augustin
Software Engineer - Ubuntu Partner Engineering

