Return-Path: <linux-pci+bounces-20163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238DBA17103
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 18:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058D83A8F4B
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jan 2025 17:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0D31EC00F;
	Mon, 20 Jan 2025 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyURggIG"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563981EBFEB
	for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737393050; cv=none; b=Ug/IerOL7YxXHuTVbOgm4qOMcoCxg/GWWApzoBeIOmmIhGj7jtVEoOPP7Gt6xVAqMiITubnonchmFirEdK6Iv4JYXIn9At+Du03Aree6E+NEudgvfeUOADYfIe9D58p4YSKFJiyEJNzqDVZ8cDvuUuLHvqYIQT57+aV34T+VMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737393050; c=relaxed/simple;
	bh=esF1fmYWMOGV+bqeDkl0ie2MJdBahFpG84qLccphcqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mcMDAhwB5JZ0nvTAeodSnB1shW7y5TROE1oBPtE5D03hJ+Cmn24iMZQq9JdUlao0LTRuWyIo/EIQeHpJHN6Tz+k8nOWowa7IXhQHNWbE6VgK1Nh5Ivh+HVJEBt/RTzfilQe/CegTKO4Gd8h/P0pBtkjfM6DIbkoZm4t9auju2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyURggIG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737393046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kIC2BvpomO5150sOquNOq6fToagOWeJEFF/3T+Gjbls=;
	b=dyURggIG1lEWUBhkIz9NGb3wpK++ngFdGTbJLkplW8WKFnpYhTleQLzMbM3WSVsdlCfGH8
	/BMUGGXkTBoFTgB/XluUSMEtaU3xpeZ0jiTPPvJY0VdHpuKMY5cqkTNVI3EHI0YN0IleoP
	xscUHbx8qu/j8q85caznBtv4Gincae4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-1eE_OczRPquYXqAfcZCwsg-1; Mon, 20 Jan 2025 12:10:44 -0500
X-MC-Unique: 1eE_OczRPquYXqAfcZCwsg-1
X-Mimecast-MFC-AGG-ID: 1eE_OczRPquYXqAfcZCwsg
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-849cc81984eso19501639f.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jan 2025 09:10:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737393044; x=1737997844;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIC2BvpomO5150sOquNOq6fToagOWeJEFF/3T+Gjbls=;
        b=seWc9bK/A7ZYqUaVzD+xrSHFqMSpfwn4/4fas9PvrSDip5QUzmwfX/6eglCYwy5PWX
         qMN+IBPIsJW+j8kcnTcALgk/V6XS8MDHItIHyb9DdufAydN5OIMfruKPxjx9Ksbma1NU
         rQjZzhu3BIPLmneQEA45xGJYjgkOfGwGsqi5xZO0U5Hg7XTl3y4uEwWxKIMMw7KHfhoK
         I91s62UoG5geKiC3W+vUumlR5wz4kR2JeMK9ogTLFJPXI1UolScHzuoY3PGTLvHzJciC
         XQoTtCUUa0AP7MY5bbbjdhBl3lJiA40btxdi6ey/NS7DQ7X8z3PYWjOIdtXlNIUadgow
         baUA==
X-Forwarded-Encrypted: i=1; AJvYcCVk7YQH5rDIxf6uCzyVrC7Ap1P4BPaum6sK75qBbVD0gE+XefpuziJpq2GzfJWM6EcL4OObjRxizDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGP0uJqVLH63SiKHjXJRHtm2j7yfIIyz04RIoFroKpP+gMS7o+
	YHAnqENJTscU/yMRrWW0NqLo/0dwdFbpzUTLB91XMuU50NenzsAbPIshXG+V/9I+YSdW643zaEs
	5cjyV6+tuDNkqNIlyeMgh6D7+P/S5lSSNp4HRr9MqrrvEWse1vAVwpK7PMQ==
X-Gm-Gg: ASbGncsP1jEe4zVbHri3KRCPID41FooMJVEdMmJ3QqsVi1wGgfMzBtiq0pGqMyZe4fa
	NdrBdWkHMY5L/SKuo3PJgceroHfBn+ukk8xIu2cfuq7oocYnCwqRyWeacLVounRVF6BJcu+Mohc
	F8gXCOBOWQoOXv4wACKjQOk0aZtPhihQ5ckJmmMRU83xuSHDXb5PBDALIRWQgcDx8LvMZlXHLWB
	rmeqyHfB6NMXs54ZKjti7qj2/8M3heKwaiIuO72pa6R4Y52QPqTjSBWPKWQaGoWR0FzoLNVrA==
X-Received: by 2002:a05:6e02:1d81:b0:3a7:bd4c:b17e with SMTP id e9e14a558f8ab-3cf74289e2fmr29485255ab.0.1737393043708;
        Mon, 20 Jan 2025 09:10:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8Rg78A0d5Rrk7t5AsSIfd7niS+lkFqWIuCxZMHDSqd9SvuUYBKC5h/T7W7AU6Fn/86dXPnA==
X-Received: by 2002:a05:6e02:1d81:b0:3a7:bd4c:b17e with SMTP id e9e14a558f8ab-3cf74289e2fmr29485115ab.0.1737393043249;
        Mon, 20 Jan 2025 09:10:43 -0800 (PST)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea753f551csm2637076173.20.2025.01.20.09.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 09:10:42 -0800 (PST)
Date: Mon, 20 Jan 2025 10:10:40 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, mitchell.augustin@canonical.com
Subject: Re: [PATCH] PCI: Batch BAR sizing operations
Message-ID: <20250120101040.2289d453.alex.williamson@redhat.com>
In-Reply-To: <d635d3b0-92bf-5a96-c64e-fe2aae8a522f@linux.intel.com>
References: <20250111210652.402845-1-alex.williamson@redhat.com>
	<d635d3b0-92bf-5a96-c64e-fe2aae8a522f@linux.intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Jan 2025 18:10:14 +0200 (EET)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Sat, 11 Jan 2025, Alex Williamson wrote:
>=20
> > Toggling memory enable is free on bare metal, but potentially expensive
> > in virtualized environments as the device MMIO spaces are added and
> > removed from the VM address space, including DMA mapping of those spaces
> > through the IOMMU where peer-to-peer is supported.  Currently memory
> > decode is disabled around sizing each individual BAR, even for SR-IOV
> > BARs while VF Enable is cleared.
> >=20
> > This can be better optimized for virtual environments by sizing a set
> > of BARs at once, stashing the resulting mask into an array, while only
> > toggling memory enable once.  This also naturally improves the SR-IOV
> > path as the caller becomes responsible for any necessary decode disables
> > while sizing BARs, therefore SR-IOV BARs are sized relying only on the
> > VF Enable rather than toggling the PF memory enable in the command
> > register.
> >=20
> > Reported-by: Mitchell Augustin <mitchell.augustin@canonical.com>
> > Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEy=
ZgQZub4mDRrV5w@mail.gmail.com
> > Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> > ---
> >=20
> > This is an alternative to the patch proposed by Mitchell[1] and more
> > in line with my suggestion in the original report thread[2].  It makes
> > more sense to me to stash all the BAR sizing values into an array on
> > the front end of parsing them into resources than it does to pass
> > multiple arrays on the backend for status printing purposes.  We can
> > discuss in either of these patches which is the better approach or
> > if someone has a better yet alternative.
> >=20
> > I don't have quite the config Mitchell has for testing, but this
> > should make effectively the same improvement and does show a
> > significant improvement in guest boot time even with a single 24GB
> > GPU attached.  There are of course further improvements to investigate
> > in the VMM, but disabling memory decode per BAR is a good start to
> > making Linux be a friendlier guest.  Further testing appreciate.
> > Thanks,
> >=20
> > Alex
> >=20
> > [1]https://lore.kernel.org/all/20241218224258.2225210-1-mitchell.august=
in@canonical.com/
> > [2]https://lore.kernel.org/all/20241203150620.15431c5c.alex.williamson@=
redhat.com/
> >=20
> >  drivers/pci/iov.c   |   8 ++-
> >  drivers/pci/pci.h   |   4 +-
> >  drivers/pci/probe.c | 132 +++++++++++++++++++++++++++++---------------
> >  3 files changed, 97 insertions(+), 47 deletions(-)
> >=20
> > diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> > index 4be402fe9ab9..9e4770cdd4d5 100644
> > --- a/drivers/pci/iov.c
> > +++ b/drivers/pci/iov.c
> > @@ -747,6 +747,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >  	struct resource *res;
> >  	const char *res_name;
> >  	struct pci_dev *pdev;
> > +	u32 sriovbars[PCI_SRIOV_NUM_BARS];
> > =20
> >  	pci_read_config_word(dev, pos + PCI_SRIOV_CTRL, &ctrl);
> >  	if (ctrl & PCI_SRIOV_CTRL_VFE) {
> > @@ -783,6 +784,10 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >  	if (!iov)
> >  		return -ENOMEM;
> > =20
> > +	/* Sizing SR-IOV BARs with VF Enable cleared - no decode */
> > +	__pci_size_stdbars(dev, PCI_SRIOV_NUM_BARS,
> > +			   pos + PCI_SRIOV_BAR, sriovbars);
> > +
> >  	nres =3D 0;
> >  	for (i =3D 0; i < PCI_SRIOV_NUM_BARS; i++) {
> >  		res =3D &dev->resource[i + PCI_IOV_RESOURCES];
> > @@ -796,7 +801,8 @@ static int sriov_init(struct pci_dev *dev, int pos)
> >  			bar64 =3D (res->flags & IORESOURCE_MEM_64) ? 1 : 0;
> >  		else
> >  			bar64 =3D __pci_read_base(dev, pci_bar_unknown, res,
> > -						pos + PCI_SRIOV_BAR + i * 4);
> > +						pos + PCI_SRIOV_BAR + i * 4,
> > +						&sriovbars[i]);
> >  		if (!res->flags)
> >  			continue;
> >  		if (resource_size(res) & (PAGE_SIZE - 1)) {
> > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > index 2e40fc63ba31..6f27651c2a70 100644
> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -315,8 +315,10 @@ bool pci_bus_generic_read_dev_vendor_id(struct pci=
_bus *bus, int devfn, u32 *pl,
> >  int pci_idt_bus_quirk(struct pci_bus *bus, int devfn, u32 *pl, int rrs=
_timeout);
> > =20
> >  int pci_setup_device(struct pci_dev *dev);
> > +void __pci_size_stdbars(struct pci_dev *dev, int count,
> > +			unsigned int pos, u32 *sizes);
> >  int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
> > -		    struct resource *res, unsigned int reg);
> > +		    struct resource *res, unsigned int reg, u32 *sizes);
> >  void pci_configure_ari(struct pci_dev *dev);
> >  void __pci_bus_size_bridges(struct pci_bus *bus,
> >  			struct list_head *realloc_head);
> > diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> > index 2e81ab0f5a25..5ca96280d698 100644
> > --- a/drivers/pci/probe.c
> > +++ b/drivers/pci/probe.c
> > @@ -164,50 +164,75 @@ static inline unsigned long decode_bar(struct pci=
_dev *dev, u32 bar)
> > =20
> >  #define PCI_COMMAND_DECODE_ENABLE	(PCI_COMMAND_MEMORY | PCI_COMMAND_IO)
> > =20
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
> > +			    unsigned int pos, u32 *sizes, bool rom)
> > +{
> > +	u32 orig, mask =3D rom ? PCI_ROM_ADDRESS_MASK : ~0;
> > +	int i;
> > +
> > +	for (i =3D 0; i < count; i++, pos +=3D 4, sizes++) {
> > +		pci_read_config_dword(dev, pos, &orig);
> > +		pci_write_config_dword(dev, pos, mask);
> > +		pci_read_config_dword(dev, pos, sizes);
> > +		pci_write_config_dword(dev, pos, orig);
> > +
> > +		/*
> > +		 * All bits set in size means the device isn't working properly.
> > +		 * If the BAR isn't implemented, all bits must be 0.  If it's a
> > +		 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR,
> > +		 * bit 1 must be clear.
> > +		 */
> > +		if (PCI_POSSIBLE_ERROR(*sizes))
> > +			*sizes =3D 0;
> > +	}
> > +} =20
>=20
> I'm trying to understand how 64-bit BARs are supposed to work here. The=20
> *sizes is being filled inside this function for both lower and upper=20
> u32, right? So why can PCI_POSSIBLE_ERROR() be used for the upper part?=20
> Can't the upper u32 of a 64-bit BAR have all bits as 1?

Thanks for catching this, I think this check just needs to be moved
back to its original location below so that we only do this on the
lower u32.  I'll send a v2 with that change.  Thanks!

Alex

> > +void __pci_size_stdbars(struct pci_dev *dev, int count,
> > +			unsigned int pos, u32 *sizes)
> > +{
> > +	__pci_size_bars(dev, count, pos, sizes, false);
> > +}
> > +
> > +static void __pci_size_rom(struct pci_dev *dev, unsigned int pos, u32 =
*sizes)
> > +{
> > +	__pci_size_bars(dev, 1, pos, sizes, true);
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
> > -		    struct resource *res, unsigned int pos)
> > +		    struct resource *res, unsigned int pos, u32 *sizes)
> >  {
> > -	u32 l =3D 0, sz =3D 0, mask;
> > +	u32 l =3D 0;
> >  	u64 l64, sz64, mask64;
> > -	u16 orig_cmd;
> >  	struct pci_bus_region region, inverted_region;
> >  	const char *res_name =3D pci_resource_name(dev, res - dev->resource);
> > =20
> > -	mask =3D type ? PCI_ROM_ADDRESS_MASK : ~0;
> > -
> > -	/* No printks while decoding is disabled! */
> > -	if (!dev->mmio_always_on) {
> > -		pci_read_config_word(dev, PCI_COMMAND, &orig_cmd);
> > -		if (orig_cmd & PCI_COMMAND_DECODE_ENABLE) {
> > -			pci_write_config_word(dev, PCI_COMMAND,
> > -				orig_cmd & ~PCI_COMMAND_DECODE_ENABLE);
> > -		}
> > -	}
> > -
> >  	res->name =3D pci_name(dev);
> > =20
> >  	pci_read_config_dword(dev, pos, &l);
> > -	pci_write_config_dword(dev, pos, l | mask);
> > -	pci_read_config_dword(dev, pos, &sz);
> > -	pci_write_config_dword(dev, pos, l);
> > -
> > -	/*
> > -	 * All bits set in sz means the device isn't working properly.
> > -	 * If the BAR isn't implemented, all bits must be 0.  If it's a
> > -	 * memory BAR or a ROM, bit 0 must be clear; if it's an io BAR, bit
> > -	 * 1 must be clear.
> > -	 */
> > -	if (PCI_POSSIBLE_ERROR(sz))
> > -		sz =3D 0;
> > =20
> >  	/*
> >  	 * I don't know how l can have all bits set.  Copied from old code.
> > @@ -221,35 +246,30 @@ int __pci_read_base(struct pci_dev *dev, enum pci=
_bar_type type,
> >  		res->flags |=3D IORESOURCE_SIZEALIGN;
> >  		if (res->flags & IORESOURCE_IO) {
> >  			l64 =3D l & PCI_BASE_ADDRESS_IO_MASK;
> > -			sz64 =3D sz & PCI_BASE_ADDRESS_IO_MASK;
> > +			sz64 =3D *sizes & PCI_BASE_ADDRESS_IO_MASK;
> >  			mask64 =3D PCI_BASE_ADDRESS_IO_MASK & (u32)IO_SPACE_LIMIT;
> >  		} else {
> >  			l64 =3D l & PCI_BASE_ADDRESS_MEM_MASK;
> > -			sz64 =3D sz & PCI_BASE_ADDRESS_MEM_MASK;
> > +			sz64 =3D *sizes & PCI_BASE_ADDRESS_MEM_MASK;
> >  			mask64 =3D (u32)PCI_BASE_ADDRESS_MEM_MASK;
> > +
> > +			if (res->flags & IORESOURCE_MEM_64) {
> > +				pci_read_config_dword(dev, pos + 4, &l);
> > +				sizes++;
> > +
> > +				l64 |=3D ((u64)l << 32);
> > +				sz64 |=3D ((u64)*sizes << 32);
> > +				mask64 |=3D ((u64)~0 << 32);
> > +			}
> >  		}
> >  	} else {
> >  		if (l & PCI_ROM_ADDRESS_ENABLE)
> >  			res->flags |=3D IORESOURCE_ROM_ENABLE;
> >  		l64 =3D l & PCI_ROM_ADDRESS_MASK;
> > -		sz64 =3D sz & PCI_ROM_ADDRESS_MASK;
> > +		sz64 =3D *sizes & PCI_ROM_ADDRESS_MASK;
> >  		mask64 =3D PCI_ROM_ADDRESS_MASK;
> >  	}
> > =20
> > -	if (res->flags & IORESOURCE_MEM_64) {
> > -		pci_read_config_dword(dev, pos + 4, &l);
> > -		pci_write_config_dword(dev, pos + 4, ~0);
> > -		pci_read_config_dword(dev, pos + 4, &sz);
> > -		pci_write_config_dword(dev, pos + 4, l);
> > -
> > -		l64 |=3D ((u64)l << 32);
> > -		sz64 |=3D ((u64)sz << 32);
> > -		mask64 |=3D ((u64)~0 << 32);
> > -	} =20
>=20
> No PCI_POSSIBLE_ERROR() check here for the upper u32 in the previous=20
> code.
>=20


