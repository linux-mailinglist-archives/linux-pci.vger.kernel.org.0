Return-Path: <linux-pci+bounces-11601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9F94F67B
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 20:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E171F2493C
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2024 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E79F187870;
	Mon, 12 Aug 2024 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNTKb7cE"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E010A16EB7A
	for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486575; cv=none; b=dBhk6hXYpMc1fNYpqmC8C4wcw8l71B/E8vUBX479K1Fm6yDtGbLa3XMz+T/1gXaCPMqAQdW+fKKjUHVHALpqwh5ofYh7Qbe2SBNQXQRs3BghG7lV5OQi8z2Q0o99U/2UrKdF61Fnf5V1Ht6GaSea+9trGmeooZ0s/2wy867l9xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486575; c=relaxed/simple;
	bh=w4mmnkbUQyC+3Ff/oXNqR2TgwvhhjDG3ND1sxdUTW2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UU55BdnxnZ4bbuDUHIFwBmuLHNGztBIaoh1ssf95pC9/GMx6QeAx2Zg1oN/XqJRu9Cwdo1bItQ5reE1uUw/5z8b6feSPQ5EveVrnaOLhRkO4a2On7cL3F/ZUF/e9AWgWmDu+nWVELBmfExkwpUYOU1L766F+wY4wmLxv6YCwiKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNTKb7cE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723486572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SdkF0C2zVbB066Bu4nbcfORzCEZVZFrzFyLmGHaFIHU=;
	b=ZNTKb7cEVocNuuMGObIWjYqDiBH/bqB32JOyKtMIGrBv2pn2nn/lbt1deF/c4ITuV+wCMX
	Hjt/FdwWzf/dIvkC18j0TvHdgdpuIPMmK65S6bNsgnXbocOvkWfMqP+29ZidDVTwEJ01tV
	9NW4CS4Qppzy3PggArXDj0wh6b5886Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-mRp9SFvQMTiNPSX8PEUJfg-1; Mon, 12 Aug 2024 14:16:11 -0400
X-MC-Unique: mRp9SFvQMTiNPSX8PEUJfg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428f1b437ecso8935955e9.1
        for <linux-pci@vger.kernel.org>; Mon, 12 Aug 2024 11:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723486570; x=1724091370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdkF0C2zVbB066Bu4nbcfORzCEZVZFrzFyLmGHaFIHU=;
        b=GEddMJ2UwJwr6gRlcNTPawXIqq8ajHugZuiKfBVgqc2lxZbvKRwPkuA62hJmFXsz4w
         CALooSjtcxJpS6ipmuHwNN8gaNeBhOjjpKHDzb+nqb2g2/1siUP6Xfo7x1GiUFHS7v+p
         kLztB2aikLoixds/FazWyGlWK8QY22wEIiuB/AI3E7ZmqvrPDzVxrcPEhBKCAIkkC2jb
         YCusc0oABpsKoIhnsyLPLhxTNCrJVXk1GqXaYD9Z/KzxMvMs8FsUVO6PSe/jsd5uz81o
         +ApckbL+wv9Za+vLVDVDh85RrvdLrq8fvULDdJ5kNNKYkJx9j0QGfBfEwWJRsbJ1/PuZ
         124g==
X-Forwarded-Encrypted: i=1; AJvYcCXM8W5SgnHyoezMbLs897M6Wq3woo0mPw6ZQQAIYCHOAhJdLWkNuzp3088PB/6sivaAkmCmYvY7aio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS6F1C9ngCa7JSFHmqqjnrrFVUOd7VoU1PP+7+YglBtQ3bTed5
	I7SOJUjpGMNtBHV5uyd2zeO9KQUB5kuEFB5fTZ4Kj4hYl26N/+biQa9o8TIKBu/avvcZTNs1Ezr
	Fr8o7hndAse1T8Radn90W5vbMkg+KRd7+2eo+4CODsCRcZ+vV/88vYVzd1g==
X-Received: by 2002:a05:6000:1f89:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-3716ccd6d04mr588778f8f.2.1723486570219;
        Mon, 12 Aug 2024 11:16:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk4syqNza/9kyyQE6dwwthidXy5tZvgm37dWORCESuvttYgk7Yi7KbYqY7kGz7zl7a7deUuQ==
X-Received: by 2002:a05:6000:1f89:b0:35f:2584:76e9 with SMTP id ffacd0b85a97d-3716ccd6d04mr588770f8f.2.1723486569679;
        Mon, 12 Aug 2024 11:16:09 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d02:8a00:2d28:15cf:9c1d:ae3d? (200116b82d028a002d2815cf9c1dae3d.dip.versatel-1u1.de. [2001:16b8:2d02:8a00:2d28:15cf:9c1d:ae3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429c750393asm111238125e9.1.2024.08.12.11.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 11:16:09 -0700 (PDT)
Message-ID: <70a70c74be9ba1a6ae6297ac646fa82600d9296c.camel@redhat.com>
Subject: Re: [PATCH v2 04/10] crypto: marvell - replace deprecated PCI
 functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>,  Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
 <u.kleine-koenig@pengutronix.de>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, linux-kernel@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org
Date: Mon, 12 Aug 2024 20:16:07 +0200
In-Reply-To: <Zrow42L9dYC6tSZr@smile.fi.intel.com>
References: <20240805080150.9739-2-pstanner@redhat.com>
	 <20240805080150.9739-6-pstanner@redhat.com>
	 <Zrow42L9dYC6tSZr@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Yo Andy!

On Mon, 2024-08-12 at 18:57 +0300, Andy Shevchenko wrote:
> (Reduced Cc list a lot)
>=20
> On Mon, Aug 05, 2024 at 10:01:31AM +0200, Philipp Stanner wrote:
> > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions()
>=20
> Missing period at the end.

ACK

>=20
> ...
>=20
> > - /* Map PF's configuration registers */
> > - err =3D pcim_iomap_regions_request_all(pdev, 1 <<
> > PCI_PF_REG_BAR_NUM,
> > - =C2=A0=C2=A0=C2=A0=C2=A0 OTX2_CPT_DRV_NAME);
> > + err =3D pcim_request_all_regions(pdev, OTX2_CPT_DRV_NAME);
> > =C2=A0 if (err) {
> > - dev_err(dev, "Couldn't get PCI resources 0x%x\n", err);
> > + dev_err(dev, "Couldn't request PCI resources 0x%x\n", err);
> > =C2=A0 goto clear_drvdata;
> > =C2=A0 }
>=20
> I haven't looked at the implementation differences of those two, but
> would it
> be really an equivalent change now?

Well, if I weren't convinced that it's 100% equivalent I weren't
posting it :)

pcim_iomap_regions_request_all() already uses
pcim_request_all_regions() internally.

The lines you quote here are not equivalent to the old version, but in
combination with the following lines the functionality is identical:
   1. Request all regions
   2. ioremap BAR OTX2_CPT_BAR_NUM

>=20
> Note, the resource may be requested, OR mapped, OR both.

Negative, that is not how pcim_iomap_regions_request_all() works. That
overengineered function requests *all* PCI BARs and ioremap()s those
specified in the bit mask.

If you don't set a bit, you'll request all regions and ioremap() none.
However you choose to use it, it will always request all regions and
map between 0 and PCI_STD_NUM_BARS.


> In accordance with the
> naming above I assume that this is not equivalent change with
> potential
> breakages.

The nasty thing of us in PCI is that you more or less already use the
code above anyways, because in v6.11 I reworked most of
drivers/pci/devres.c, so pcim_iomap_regions_request_all() uses both
pcim_request_all_regions() and pcim_iomap() in precisely that order
already.

The only hypothetical breakages which are not already in v6.11 anyways
I could imagine are:
 * Someone complaining about changed error codes in case of failure
 * Someone racing between the calls to pcim_request_all_regions() and
   pcim_iomap(). But that's why the region request is actually there in
   the first place, to block off drivers competing for the same
   resource. And AFAIU probe() functions don't race anyways.

Anything I might have overlooked?

P.

>=20
>=20
> > - cptpf->reg_base =3D pcim_iomap_table(pdev)[PCI_PF_REG_BAR_NUM];
> > + /* Map PF's configuration registers */
> > + cptpf->reg_base =3D pcim_iomap(pdev, PCI_PF_REG_BAR_NUM, 0);
> > + if (!cptpf->reg_base) {
> > + err =3D -ENOMEM;
> > + dev_err(dev, "Couldn't ioremap PCI resource 0x%x\n", err);
> > + goto clear_drvdata;
> > + }
>=20
> (Yes, I see this).
>=20
> ...
>=20
> > --- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
> > +++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
>=20
> Ditto. here.
>=20


