Return-Path: <linux-pci+bounces-14654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB1D9A0B50
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 15:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0B51C22A2B
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 13:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A4620966A;
	Wed, 16 Oct 2024 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDYNJCeg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12531EB5B
	for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729084905; cv=none; b=cNd+xN4OauzLVVbSABdahC5658YDPLSk2WlSnCtVtUghdB8s8boVNgUp8bJmndCr/IchlnUT4ZG2dWYfD2z+nvacBOaLRXQmxuTroa1waoEVH5N67nljzC/NMsmedc/xKpQ9vRuXBBgA/62uqkndDg1F2Dvddb6BvkEQmVUZ7R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729084905; c=relaxed/simple;
	bh=rUj8Gwg342FS1TKcMCdVbJGB3eQfR/cCHLotI1AQICg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6yqoiTu5kw1TGXt5mWmz2VfyDuN+qn3jK9eVKKM/eJ1/6qxMGBIVOjtZE4rFeZHP7GqgOYRPzq6myPBtGnF+jdnTEu7ZBugv7YvhVOtEQNqwpgsLTV9joBnC+3lNaqUALYD1/gfwMPXxHTRH70U4/bINOrib2xeGKb8OL+AG54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MDYNJCeg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729084901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cZqaY7QF+tALXuS6sAhZnIZBBqHZXvbBY3wvvmoqrxM=;
	b=MDYNJCegRB+tTdVHxZ17VvNoJ4d19UsigoRWD8JgdVkF3nwgt3/CIZb9CBWkyLEUQdP1SA
	iPxi7+QYCQMt1kFRMriUvfjE8R9q8pIwJKQdly5Q6fzXLrrKU2g/Z4U1f/wkVYfi6ARQUJ
	0I+s6xct1DgD4fXR/XlRyEgqkx96a3M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-coJlnEnAPNea9E6zBtZZww-1; Wed, 16 Oct 2024 09:21:40 -0400
X-MC-Unique: coJlnEnAPNea9E6zBtZZww-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d49887a2cso509833f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 16 Oct 2024 06:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729084899; x=1729689699;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZqaY7QF+tALXuS6sAhZnIZBBqHZXvbBY3wvvmoqrxM=;
        b=pI9WM12mttte1OeQhvUr2mPa2V+Arwg4VxLUPGNuc0cvyW935r7UGVruAUcOSauQUc
         1zWwCJD1T+6QIY2xdkpkXw0mjqjz9w3+WREUyPfeQBrHBDhmphavgEepRe3XuFwnlFly
         T1xrsPSon6T+h26g2Uhzp5/5bRPgEix6LTgJ+n3BIvS1ADZmxOSX8TK0HoYL+wSaxsUC
         gwRB8Voiuash4t3ct9hPT9YmuyL/LQugCoIpnFsw+1FZNrcmgRf6UvJhi1tvKFqRrFH6
         a3RJguRCZKEvh1NRJN71CV4wUwrPEe2kMIcx1GV8uQeKhYaBenphMf/ogG7g2GsM4P63
         /mzw==
X-Forwarded-Encrypted: i=1; AJvYcCV2sKScqhlkZ8mBYHH+13Um7KgSPEHmGprHGLeq1vMk06oMGavEjJnWvXaBIX+w3ytCZXxoOPGA9MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4TVoLuVNWsYyv/JMpHl1mB24En864+efX/dWu6Z9Ki9JPkNWC
	U93Jsh0PXEx8X3VNg64uQvWdL0zbgnUNh5QIFaXKU0Iy/cJD3LSlDRM4XD9nnhndoMZSSjkIZdo
	8/QVrUUWQkiBzemULsY8knqSKO26wA2pmNAI97GIuan0YRZr6hCt3UIh5Nw==
X-Received: by 2002:a5d:4603:0:b0:37d:39ff:a9cf with SMTP id ffacd0b85a97d-37d86266138mr3021780f8f.5.1729084899299;
        Wed, 16 Oct 2024 06:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvgZxmtzCYA4vi7Un7UeUDYjOsv1/PXUBoFfIYhsnpv94gR+MUgt7A/ZOnYZrAG6OOK+0ycQ==
X-Received: by 2002:a5d:4603:0:b0:37d:39ff:a9cf with SMTP id ffacd0b85a97d-37d86266138mr3021762f8f.5.1729084898858;
        Wed, 16 Oct 2024 06:21:38 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6b1e9esm49252895e9.37.2024.10.16.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:21:38 -0700 (PDT)
Message-ID: <ac50d7cf2a2071f196552fa4dc4109f9a551c7e7.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource
 name helper
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, LKML
	 <linux-kernel@vger.kernel.org>
Date: Wed, 16 Oct 2024 15:21:37 +0200
In-Reply-To: <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com>
References: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>
	 <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com>
	 <fc0649b5-d065-2627-f475-d61f0594d0e5@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 16:15 +0300, Ilpo J=C3=A4rvinen wrote:
> On Wed, 16 Oct 2024, Philipp Stanner wrote:
>=20
> > On Wed, 2024-10-16 at 15:00 +0300, Ilpo J=C3=A4rvinen wrote:
> > > Use pci_resource_name() helper in pdev_sort_resources() to print
> > > resources in user-friendly format.
> > >=20
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> > > ---
> > > =C2=A0drivers/pci/setup-bus.c | 5 +++--
> > > =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> > > index 23082bc0ca37..071c5436b4a5 100644
> > > --- a/drivers/pci/setup-bus.c
> > > +++ b/drivers/pci/setup-bus.c
> > > @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct
> > > pci_dev
> > > *dev, struct list_head *head)
> > > =C2=A0	int i;
> > > =C2=A0
> > > =C2=A0	pci_dev_for_each_resource(dev, r, i) {
> > > +		const char *r_name =3D pci_resource_name(dev, i);
> > > =C2=A0		struct pci_dev_resource *dev_res, *tmp;
> > > =C2=A0		resource_size_t r_align;
> > > =C2=A0		struct list_head *n;
> > > @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct
> > > pci_dev
> > > *dev, struct list_head *head)
> > > =C2=A0
> > > =C2=A0		r_align =3D pci_resource_alignment(dev, r);
> > > =C2=A0		if (!r_align) {
> > > -			pci_warn(dev, "BAR %d: %pR has bogus
> > > alignment\n",
> > > -				 i, r);
> > > +			pci_warn(dev, "%s: %pR has bogus
> > > alignment\n",
> > > +				 r_name, r);
> >=20
> > Why do you remove the BAR index number, don't you think this
> > information is also useful?
>=20
> That's because of how pci_resource_name() works. The number will be=20
> included in the returned string and it won't be always same as i.
> So that change is done on purpose.
>=20
> > One could also consider printing r_align, would that be useful?
>=20
> As per the preceeding condition, it's known to be zero so it's not=20
> that useful for any developer looking at these code lines.

Ah, right. Would it then make sense then to do:

pci_warn(dev, "%s: %pR: Alignment must not be zero.\n", ...);

Would tell then exactly what the problem is. Unless the devs know that
a bogus alignment is definitely always 0.

?

>=20
> > Note
> > that there is a similar pci_warn down below in line 1118 that does
> > print it. Would you want to change that pci_warn()-string, too?
>=20
> pci_warn() on line 1118 does NOT print i (as expected when using=20
> pci_resource_name()) and there align is not zero so I don't see how
> this=20
> is relevant.
>=20
> But thanks for taking a look anyway. :-)

Sure thing

>=20


