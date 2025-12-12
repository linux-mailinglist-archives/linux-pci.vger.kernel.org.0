Return-Path: <linux-pci+bounces-43020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85068CB9F43
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 23:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B4F33007E49
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 22:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E0A26ED2B;
	Fri, 12 Dec 2025 22:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JClcehWe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B18C254AE1
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 22:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578947; cv=none; b=Lic2Fs+C1QiaSdhdiZMYJX0Dsh7eN7doq8ilELNomYH8aQ0e3Vx+V4mEbL56iwtJGhckC6yFnD7CNlfE1/fA30PWFJL0iVU9t0OvzuZcG6vk+6+55UgUgxp/p8dVXLdDtK5sZ4kgGAwZcZ7m2lUZGah4IU2+R103oOzCTtkoXQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578947; c=relaxed/simple;
	bh=IovUBwQI+WADoaJ+HWPmhLmwtoeiRIg6cJqNCYGwCvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bG41PUO0R1YdolaJHzRWZML3AdlWb3KcY4YccA/k3xwIA9+p6zF2DeY/WKZADbDhFLfEDK4dXJMhH9dXNXC71rElRUZua4Lrcvjtq/oP01PWcgd/zDj137ozTgwMz6EXmooLRy5qzoJ79V8ul7rXba30s76ZMBybZrfd9Mwsy0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JClcehWe; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso998064a12.2
        for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2025 14:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765578943; x=1766183743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5cQB5nkzNrqDrJNanzRJc7cTb8ZQpWaeDUDTPWaWIYk=;
        b=JClcehWehqjuRFUXTmer7c00kRzw0EZ+gcdNUSNtpzUOCWieaVbqu28IDhCENgZ7dv
         tnFw/BZrFg9h68jAQ9kh7uiNu1xj6OL9d8Qcwch8dU6eqNKRuznTe6Y0/w6LVY07brNB
         G6eHeit/YL5P1ec7kVKRG6UJ97XXOUug88okUrZGYqsbvu3kVtJpSS17J4eL535h8ikC
         0Icl0zPe6p4/IPC7qdN02Q7zPocVto9tsG+wVyPjDK7cexQVrpWqjGdVJA83GBAF8coq
         CFeaN7Hplv3fNO53XMFxfPjgZwH+Nzwzdw4UHGgCUt4O9+KAQbUQ/R/hU+pZumlgEhm/
         mOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765578943; x=1766183743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5cQB5nkzNrqDrJNanzRJc7cTb8ZQpWaeDUDTPWaWIYk=;
        b=nRqHTmw5i7lGMw2L1nR2ECd7v9C73t60yt06AeNDuSoj4WSQMJIqE/CEL1/8SkTIaa
         0NgGNxtVhfoap5S1+pcORCFVJLEVN0HZy6g7rDlNRWQdsah3P2Sk3ErRJGTwI73A8GnY
         s/Ia9HSLOr0bnbmIiMCEfsMIbgbe3pTMtY3+2yj0LIrevJAkkWO2R9tLo4cJidNIkwZW
         c6iegZLN2H5A2uJducVVj68704tRofSCF8cyhk5inVxe9CnCpNS4N4TT88xfBzWlNdD8
         foHLJHiExLKltXNNd/5wlTJRs53/HjtmX0v7ymke4O6+Pjda0HNrJweZUPS95pxVVPLU
         UeHg==
X-Forwarded-Encrypted: i=1; AJvYcCU1xjCK249bMVInznzyJj2KuB/qh9sISpUSt9zvwYal7zMN2Q1RBlkVEH+V6NHCGffOFbBNB8j9/R0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzraFRQQoQDjvoYnHrMGnbEwD7Tcqml4Wgg2Tflf7uEWLpFRHzj
	KRsN7ZJoyp6kWDPax60+6YrkUSALrZVRJQzsHKDnbbBswM/yVXtcpr/Yw5PME6ngCWM=
X-Gm-Gg: AY/fxX6tX4Z+VSnVNkOxalMM4kTquLKsmX4j6ffOi5YK/Dab5yqk2onsmIYxoWuWNOk
	IpIzcuQ5wiQx8MC8gixzzrPuJWJdBQM0zG4PUnNM1o0Q/xJMb0bouU2Mbo0QMac+dtUyjCPTfUH
	a4SjX6IbLcYYIpI9fSSNPbjXo8YZIegS2fFixZc2UNQ7xbXAHQEYsRsaQUecDgeTPR0o/JVXhtB
	qDBbA4jZfpnsOmw8ZX0pbx0cSQfJ7xAg/x6xXecQVSTxS1qv929++KEuVazEgiQdleEdtfTR3aL
	8bTPqNeqSLSawKPZEoVeJcDzCd1zXf6sxAkqJnRScJDZ2Fu3Z2MmrsD9eg7Va7XH7lko8mW/AfT
	K/4TgrzIFQH6qjqcJ7wqCKNk0rXU7qexnrY3Jaxj1vib7CFwJYUg9o/+M80bGhcI6Mh0ALimScc
	9i+BXWqAO6rm/maGUj
X-Google-Smtp-Source: AGHT+IF/7oP6/88I1ORc0fTiiVfApiPspIjeappNHdnGJBgBTsh65L0jZM3B1MfApHxXJnbdrrThRw==
X-Received: by 2002:a17:907:9613:b0:b4c:137d:89bb with SMTP id a640c23a62f3a-b7d236ff023mr430665766b.29.1765578942910;
        Fri, 12 Dec 2025 14:35:42 -0800 (PST)
Received: from localhost ([2a02:8071:b783:6940:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b7cfa2ec0d2sm695138866b.27.2025.12.12.14.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:35:42 -0800 (PST)
Date: Fri, 12 Dec 2025 23:35:40 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI/portdrv: Move pcie_port_bus_type to pcie source
 file
Message-ID: <iiowlowpgwezv7gffkijkicana64mdgv4vq2mxwztjztqbivgi@w7snrgu5qg3d>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
 <420d771f0091dea7cf18f445b94301576dcee4c8.1764688034.git.u.kleine-koenig@baylibre.com>
 <df1810e3-6c16-0534-9042-f04dbf123e33@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ildlarvir46jz3aa"
Content-Disposition: inline
In-Reply-To: <df1810e3-6c16-0534-9042-f04dbf123e33@linux.intel.com>


--ildlarvir46jz3aa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/6] PCI/portdrv: Move pcie_port_bus_type to pcie source
 file
MIME-Version: 1.0

Hello Ilpo,

On Thu, Dec 11, 2025 at 07:28:45PM +0200, Ilpo J=E4rvinen wrote:
> On Tue, 2 Dec 2025, Uwe Kleine-K=F6nig wrote:
> > @@ -564,6 +579,11 @@ static int pcie_port_remove_service(struct device =
*dev)
> >  	return 0;
> >  }
> > =20
> > +const struct bus_type pcie_port_bus_type =3D {
> > +	.name =3D "pci_express",
> > +	.match =3D pcie_port_bus_match,
> > +};
> > +
> >  /**
> >   * pcie_port_service_register - register PCI Express port service driv=
er
> >   * @new: PCI Express port service driver to register
>=20
> I wonder if you should also relocate that #ifdef region=20
> bus_register(&pcie_port_bus_type); is in and make pcie_port_bus_type=20
> static? As is, this move feels somewhat incomplete.

Yeah, I agree, I had the same feeling. I decided against that because
I'd need a new function that just calls bus_register and that has to be
called from pci_driver_init(). I thought this to be hardly better than
the status quo. Looking again pcieportdrv.o is a separate module that
doesn't have an initcall, so this could be done in there. Will have a
look early next week.

Best regards
Uwe

--ildlarvir46jz3aa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmk8mLkACgkQj4D7WH0S
/k7UNAgAgISQDQdZNSVt+2hrhL1BpVGMv125WUMtgsDsGKzz9P454Aco5RzwZevJ
ecTlWN2fEr5quHeJ02+go9bDDZJ5gekUO2NnFUeJOLOKGDFaJczkmmjux9bq2n7P
0vjREM3ENzZroSHj7/1zu78kgSgichqPLJlAVXgAzFHi4Mr+B61b2Aakh7By10N0
D13baNK6GSUUGc/JgWLcn3ckwa+SuMj9i/VRl2dYfMloKYsWiuj9ZZU+jxVSId5m
yKp07vNkAeRoayXj1kI1e0jW+jOliPk9vukRwvplkpUBLvqdNydqRrx7w1gcsB99
LzZUmMo/1gxt0tdJCMEznwRWd8ADdw==
=vgZ/
-----END PGP SIGNATURE-----

--ildlarvir46jz3aa--

