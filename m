Return-Path: <linux-pci+bounces-2249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6238830194
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 09:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4262B22123
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jan 2024 08:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A679611709;
	Wed, 17 Jan 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4SNebiV"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E375013AF0
	for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 08:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481695; cv=none; b=PB2RvCXe9QPspASGdWku748qPQnozzs5Ixjo3bXfVHmfCrFrPjOJMs3qhqv1ygFrzPvMcx8H5qvnYUMxXJFDeEWDMCKlBm8n/IH/oA/xTdjDVhNQoDVLNMBr31LYJoUPyCdao/UQVuGkc9yqSDevC3lSkLBxDCP3sh+z4Lcg/sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481695; c=relaxed/simple;
	bh=YbhqHgZ8qrRwRRdHssnLB+nFCjalZT7Y0BQbw4Hg2cQ=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:Received:Message-ID:Subject:From:
	 To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version; b=iG2/bSlpWQA4udKLRsq6XwKdJqZGss7J+tnrzbfN0VPnRJHX4utl/ygQ8L08lztLnP2+Mka56eb7tCoXkeCh8NaJ0YMPJdvAUQEjnVA3tr/f9usIh6oR5DBvJzH+4e42ppUTF5ODyOlE6Hlp9BQikPVdGjsytFn+QLxQHcnC0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4SNebiV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705481692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D00hU3PzeJuPDTbACxnMMgiUCTQ91p211OWtV23tV44=;
	b=A4SNebiV+WI0csUla7zNRisE0lhY/CmPVFhVO5p3fiwP4pXQuD/GyevMlOUjVKmoxqHp88
	3vMV/u8xVLz0HpmgS6f/IcyuwaJnShzDtxK8MOdxbWuXsIfgMiwdK/gRW6FbVEtk0VMDhi
	AT+nxBcsBUoJ4CEoJjvWQUOKtgSE0BY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-KL1caou-PEC5uSJulPizpQ-1; Wed, 17 Jan 2024 03:54:51 -0500
X-MC-Unique: KL1caou-PEC5uSJulPizpQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78315f4f5c2so193790685a.0
        for <linux-pci@vger.kernel.org>; Wed, 17 Jan 2024 00:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705481691; x=1706086491;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D00hU3PzeJuPDTbACxnMMgiUCTQ91p211OWtV23tV44=;
        b=K5u0TZfRKKtCqu3tM59L8jXdgKHHkqhnGVB3m8hXOfBQJP7hT0Yco80Wh2pt0jxhtu
         gJIb0dC1vJWzNeroWg4REn6nrcsv9d/Z3QQb/BRG4aIUe9aIdftT/9igp5gfCajF/fJX
         MqJzjWMWcFhsmD41VWBl6fyKB7vVOsG1mt/3DMdKi66hPLGmq4nPjdAnSXDLk0F+1rfK
         oBvNgG04/iR6/E5t7wpko5/BTwUeygqaUQY+sqxihSJt/ci0CAUmAwB9qjy+OCV3sT0N
         2yaLlnYpUWmRmN+ZpQC7QhUNsoXgWkyNEPLaV922RgOmPywMPl0utBmj13+CL20LeJr3
         FKhQ==
X-Gm-Message-State: AOJu0YxYQQv6oRNZdKU1woNud/HJkKlrAHyayk38Hk0z0v0EmA1eYzNN
	dB+HagFle5WbkrGtvu4HPwJrIAFMWaJPymUPKexEM/f3A5zxvvtXycX5z2yYVX0n82xq+rpS8g/
	QXWyrEiTE9jlJDKca/cqnQXeVQR/d
X-Received: by 2002:a05:620a:8019:b0:783:68ab:9ade with SMTP id ee25-20020a05620a801900b0078368ab9ademr1389358qkb.7.1705481690791;
        Wed, 17 Jan 2024 00:54:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/PfPCNwITnjUQYv8Uu8hwD3Ulky89OHnA+85OkcfyY06xXLEGkkaNflyvHvodm12ON4wvqw==
X-Received: by 2002:a05:620a:8019:b0:783:68ab:9ade with SMTP id ee25-20020a05620a801900b0078368ab9ademr1389343qkb.7.1705481690454;
        Wed, 17 Jan 2024 00:54:50 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id vr28-20020a05620a55bc00b0078199077d0asm4355821qkn.125.2024.01.17.00.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 00:54:50 -0800 (PST)
Message-ID: <1983517bf5d0c98894a7d40fbec353ad75160cb4.camel@redhat.com>
Subject: Re: [PATCH 01/10] pci: add new set of devres functions
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Hans de Goede <hdegoede@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas
 <bhelgaas@google.com>, Sam Ravnborg <sam@ravnborg.org>, dakr@redhat.com,
 linux-pci@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  linux-doc@vger.kernel.org
Date: Wed, 17 Jan 2024 09:54:47 +0100
In-Reply-To: <20240116184436.GA101781@bhelgaas>
References: <20240116184436.GA101781@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-16 at 12:44 -0600, Bjorn Helgaas wrote:
> On Mon, Jan 15, 2024 at 03:46:12PM +0100, Philipp Stanner wrote:
> > PCI's devres API is not extensible to ranged mappings and has
> > bug-provoking features. Improve that by providing better
> > alternatives.
>=20
> I guess "ranged mappings" means a mapping that doesn't cover an
> entire
> BAR?=C2=A0 Maybe there's a way to clarify?

That's what it's supposed to mean, yes.
We could give it the longer title "mappings smaller than the whole BAR"
or something, I guess.


>=20
> > When the original devres API for PCI was implemented, priority was
> > given
> > to the creation of a set of "pural functions" such as
> > pcim_request_regions(). These functions have bit masks as
> > parameters to
> > specify which BARs shall get mapped. Most users, however, only use
> > those
> > to mapp 1-3 BARs.
> > A complete set of "singular functions" does not exist.
>=20
> s/mapp/map/
>=20
> Rewrap to fill 75 columns or add blank lines between paragraphs.=C2=A0
> Also
> below.
>=20
> > As functions mapping / requesting multiple BARs at once have
> > (almost) no
> > mechanism in C to return the resources to the caller of the plural
> > function, the devres API utilizes the iomap-table administrated by
> > the
> > function pcim_iomap_table().
> >=20
> > The entire PCI devres implementation was strongly tied to that
> > table
> > which only allows for mapping whole, complete BARs, as the BAR's
> > index
> > is used as table index. Consequently, it's not possible to, e.g.,
> > have a
> > pcim_iomap_range() function with that mechanism.
> >=20
> > An additional problem is that pci-devres has been ipmlemented in a
> > sort
> > of "hybrid-mode": Some unmanaged functions have managed
> > counterparts
> > (e.g.: pci_iomap() <-> pcim_iomap()), making their managed nature
> > obvious to the programmer. However, the region-request functions in
> > pci.c, prefixed with pci_, behave either managed or unmanaged,
> > depending
> > on whether pci_enable_device() or pcim_enable_device() has been
> > called
> > in advance.
>=20
> s/ipmlemented/implemented/
>=20
> > This hybrid API is confusing and should be more cleanly separated
> > by
> > providing always-managed functions prefixed with pcim_.
> >=20
> > Thus, the existing devres API is not desirable because:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0a) The vast majority of=
 the users of the plural functions
> > only
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ever sets =
a single bit in the bit mask, consequently
> > making
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 them singu=
lar functions anyways.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0b) There is no mechanis=
m to request / iomap only part of a
> > BAR.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0c) The iomap-table mech=
anism is over-engineered,
> > complicated and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 can by def=
inition not perform bounds checks, thus,
> > provoking
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memory fau=
lts: pcim_iomap_table(pdev)[42]
>=20
> Not sure what "pcim_iomap_table(pdev)[42]" means.

That function currently is implemented with this prototype:
void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);

And apparently, it's intended to index directly over the function. And
that's how at least part of the users use it indeed.

Here in drivers/crypto/inside-secure/safexcel.c, L.1919 for example:

	priv->base =3D pcim_iomap_table(pdev)[0];

I've never seen something that wonderful in C ever before, so it's not
surprising that you weren't sure what I mean....

pcim_iomap_table() can not and does not perform any bounds check. If
you do

void __iomem *mappy_map_mapface =3D pcim_iomap_table(pdev)[42];

then it will just return random garbage, or it faults. No -EINVAL or
anything. You won't even get NULL.

That's why this function must die.


>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0d) region-request funct=
ions being sometimes managed and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sometimes =
not is bug-provoking.
>=20
> Indent with spaces (not tabs) so it still looks good when "git log"
> adds spaces to indent.
>=20
> > + * Legacy struct storing addresses to whole mapped bars.
>=20
> s/bar/BAR/ (several places).
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* A region spaning an entir=
e bar. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCIM_ADDR_DEVRES_TYPE_REGION=
,
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* A region spaning an entir=
e bar, and a mapping for that
> > whole bar. */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PCIM_ADDR_DEVRES_TYPE_REGION=
_MAPPING,
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * A mapping within a bar, e=
ither spaning the whole bar or
> > just a range.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Without a requested regio=
n.
>=20
> s/spaning/spanning/ (several places).
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (start =3D=3D 0 || len =
=3D=3D 0) /* that's an unused BAR. */
>=20
> s/that/That/
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Ranged mappings don't get=
 added to the legacy-table,
> > since the table
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * only ever keeps track of =
whole BARs.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +
>=20
> Spurious blank line.


I'll take care of the grammar and spelling stuff in v2.

Thanks,
P.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0devres_add(&pdev->dev, res);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return mapping;
> > +}
> > +EXPORT_SYMBOL(pcim_iomap_range);
>=20
> Bjorn
>=20


