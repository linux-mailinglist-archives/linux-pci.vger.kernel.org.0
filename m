Return-Path: <linux-pci+bounces-30913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F04AEB4F2
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 12:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30BA1564AE9
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 10:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456A8298CB0;
	Fri, 27 Jun 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="xV8XKsjm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF01260580
	for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 10:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751020200; cv=none; b=bww0vXGVFwZ96Owq4Fd24opmsC22RM4Z+7Ks5t3Uc05A+H9fm9UVUgyUYuYZN3met3+T2mHj8FzmDZlSHLwjJjj1oEAprZ4xMAnVhLelu4Jan3x/FYMkm/VYRByWsCnA2kpnLa+mxWeim5oveBAAxFL6yRRDCUiZ65ilryl7T0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751020200; c=relaxed/simple;
	bh=2EOkAnNBvBCKn2GplUgHqTmWB4d9ijjHq7lRv7TbOdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjLgazogvs/kn+NHC4J0MjTL2ns1Cnq6W9npd+flZ1I3ZbIficBV9WAKEEbPCs061O6GPrpsRAQgrvxj0G2D/ii5m1p0pKiJpIPAj/6gzEltBJchyN82+bGRPMDVdIdyDLqg/t1ZjJGVCSwC/x/qfCJmIycfYMYsg4T8vLoa8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=xV8XKsjm; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so1821205f8f.3
        for <linux-pci@vger.kernel.org>; Fri, 27 Jun 2025 03:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751020195; x=1751624995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X6MFVfJiP7rHh32OSgQoFMHZ8o6ooG+IvLMko8nULpU=;
        b=xV8XKsjmJFr5xN9Avyn5hXenpeFdftqJww30zDZs34BPUmwtW2OpEtpY3LFyOZL2o8
         owi60uYg2rdoHUxG6EMp4rJQtKtcaWi2FLaruxGCFhLAYBYUITtloXbcl8iRDW818pnc
         dFiqR6uAdevSfciBNt2MXaQRzYs0rL/6yGNjLO5M46mlAGpFQB3KPtIkcccRreDnW9Il
         AewIxkqcOD+7NYlUYSHLkDIkJutsPJKBlthwaH50o8bUP8HcpoI9h79YGAEC+72hiI4Y
         7dBMmY4charzTiElUbvQAWW3dRm4s9hvkFbQbqXdy9X58oF1lUlYyCXeiIB9tEzyMRC8
         8q+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751020195; x=1751624995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6MFVfJiP7rHh32OSgQoFMHZ8o6ooG+IvLMko8nULpU=;
        b=G2C3nM4EP9+fEePgFY8hgeLwlBXhgVNnGKwJdXHTZMDAaXqsfNAfVIBG75/051cTqv
         IOixPCnM5dIUlfqnz1SPY7MowfPRO8SoNA7cL6qTeOSZILtEJJC3oI3RoazaxKHENoq+
         6dk3PAKkZ6+hUbaPnZmgm+M0wHvC4pjhl6WlQU3wGHoTPI4WwKbUV6NKUX2cbW4slyB5
         n1XtnkhrPE++qUfPHKyozdWzBMPl19YDovo4IRyAxoPkVMkTT3L7DI+6gzc42vtdVPiG
         8/AAGnl1r5d34fFcpsgQnBy0c/Gz9lEjQkaytnokfKQZhgN9Xqxvkegg33OLRHU09k37
         HAmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP7NiGQcmg1Emq8JfZTkNQQIgA/2KGzLaaaQ48rRahmDAGLcSZCghgUnF5Ec2GDq7AsVyVRDDvRzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCAr9nb/dc0TOC9HNEXpM0Ynlr5a6Nb1RQJe/foryxQUX+EQTE
	FpokKFUu4UCiYWdAP/skj5nl/fYrQPkXKs5i27zhglSh5KSI7Uq342/tv2kWIvRZNac=
X-Gm-Gg: ASbGnctSKWjQkWVdsXQygQde0l6stcyaxb/kgd+dbEiOinlnbeSY0QDLYJWhS5oMglQ
	oCGJo+KKQNeFbjbnjaZD2SCGYL6NPu7cp6LQGX8pJ+8qfMnhe2i/L129i8Ggud0kLD20s2SNuz3
	2FEkNI0Z02CkayFIkPOC90EF+o0xHcb1J32yx4tw9ldultxmmqlNPWY0TXpeYPayFIfosu7XGtQ
	JOFn+kxKFc2gYExpFKl4MLiCh9a51aRAD6ojBDdLGmrUm1mFWYr2qQUhapzT5IjV9Py8w3cRnd7
	I12VlO78tsuL7QIDMpjA0fkjDq+j3GVdPd1vqmML6EQM+9na8Mgm4KYhmNJA9J6BUog0oWG1Mnb
	7rBkcNrvVeSbiGb0Pj+YrstOn8yZA
X-Google-Smtp-Source: AGHT+IFgsX9FSlNszRWNMnA4oqFZpX3uvqJeMPddf44g+s+uUo53j7YUDYVDdrbJmC3jytJM9+cesw==
X-Received: by 2002:a5d:64e3:0:b0:3a4:f52f:d4a3 with SMTP id ffacd0b85a97d-3a8fed705ffmr2820183f8f.28.1751020194947;
        Fri, 27 Jun 2025 03:29:54 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a406879sm47136915e9.28.2025.06.27.03.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 03:29:54 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:29:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: last.ocean8435@goose.ws, 1107142@bugs.debian.org
Cc: lord2y <lord2y@pm.me>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: Bug#1107142: linux-image-6.12.27-amd64: mpt3sas LSI SAS2008
 [1000:0072] probe failure - BAR 1 reservation error
Message-ID: <sfjmooeo4rjqwbf4equggtn3st5tyzgup5vjmnmulqwomkfhlb@tqzt52d7r5gp>
References: <174884821929.71574.3484777873234546045.reportbug@localhost>
 <_1E4lJd3zEeJlb1Xg_eKu3N4-sF4g_2MxFAo7lA5RfWU8N4UtEyidG7se5UdSRWaK-1bN9n6_sXEpoLrRIVlvpfpRnYpgyBTYM84xS5xYuk=@pm.me>
 <174884821929.71574.3484777873234546045.reportbug@localhost>
 <3cd95113-69e0-44c5-9c1c-8b65269d11fe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jafp56i2trqcgquc"
Content-Disposition: inline
In-Reply-To: <3cd95113-69e0-44c5-9c1c-8b65269d11fe@app.fastmail.com>


--jafp56i2trqcgquc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1107142: linux-image-6.12.27-amd64: mpt3sas LSI SAS2008
 [1000:0072] probe failure - BAR 1 reservation error
MIME-Version: 1.0

Control: forwarded -1 https://lore.kernel.org/linux-pci/sfjmooeo4rjqwbf4equ=
ggtn3st5tyzgup5vjmnmulqwomkfhlb@tqzt52d7r5gp
Control: tag -1 + moreinfo

Hello,

[expanding the audience to include upstream and mark the bug as
forwarded accordingly]

On Sat, Jun 21, 2025 at 01:13:48PM -0400, last.ocean8435@goose.ws wrote:
> Sorry for the late reply, I've been out of the country and just returned =
home.
>=20
> > Can you try booting 6.12.27-amd64 passing the kernel boot option pci=3D=
realloc=3Doff?
>=20
> Upon returning home, I found a newer kernel available, 6.12.32-amd64. I i=
nstalled that and rebooted with kernel boot options:
>=20
> GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet splash"
>=20
> The bug was still present on kernel 6.12.32-amd64, none of my SAS drives =
attached via my LSI card were coming up. I edited the boot options to:
>=20
> GRUB_CMDLINE_LINUX_DEFAULT=3D"quiet splash pci=3Drealloc=3Doff"
>=20
> And that appears to have fixed it. My SAS drives are now showing up and I=
 can interact with them as normal.

Can you please additionally add

	dyndbg=3D"file drivers/pci/* +p"

to the cmdline and provide the complete output of `dmesg` with and
without passing pci=3Drealloc=3Doff?

Thanks
Uwe

--jafp56i2trqcgquc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhecpwACgkQj4D7WH0S
/k5AMwf/ZrRso0QuO2i8euxBl6ix+UtnVLgknpb0L4AAlJ7iBxb00PnC3EwPtfJ4
pX6PNawscM76ooxrmiXwCP22AUX71FzCimfGrkV2G/IZDhipohJJzcbRPH2XJCX/
cjWSN0iTRqW+Tpk6D4gwaYuy909zV5UkfO+lOnG82oFEHxuq97gwZV1fUQDeh4Zi
kFDZqjjG0/n+O9oj/dzI+DPPzrCr8y2VBXWvjfoWNSmWZ6SKqGNQ2hbBTGd6+dJ5
YFYzci3cyix9Rf8CoH4rDDUucHUknGf/CGBLHKVmOPpgDwMnQxd0vXj7TRtTn+ug
JvV0SKPLReqK1e1Goa1nedk0Y1aL3w==
=ufF3
-----END PGP SIGNATURE-----

--jafp56i2trqcgquc--

