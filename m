Return-Path: <linux-pci+bounces-44489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9713D11FAB
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 11:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E04C1300D561
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 10:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78526056E;
	Mon, 12 Jan 2026 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="v6HMB/RN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30367320A33
	for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 10:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768214645; cv=none; b=iPRVO6wTCfmnu9QdXp2TqyOjn1Ede76l1lAqR6twByKIv7kjlmjdUEImUVguM/I28UG025mlKeeCYxbLdezqqPXUT4mfKDnFuP36ExkBI3PDbhnzs/9mvls9kKl+eR1Q17O7kqNWSjX3BWRVNd7AlOnaa6SU0LoaRY5XIb3PDXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768214645; c=relaxed/simple;
	bh=pMUNyAs7tZrKAtJ4QzgUA9ASB+rC7z9YJhFyA5un8Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKdMQd6gWRuk1Ij7BBS0/P+9/Q+xasxeSfmTbwiQGsczOCqzWKSwH8QC3cPJ3GqXgFc1UIytJ6DN2aXLmEZolxzMI3Do78QX4ZI4tYbQLPyVV5W7z8sbDZ370+Vh6erGowrTYoVDLT45DPgS5j8hQnNRF0Gbp+vloNKhutHF/G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=v6HMB/RN; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47774d3536dso43837025e9.0
        for <linux-pci@vger.kernel.org>; Mon, 12 Jan 2026 02:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768214641; x=1768819441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMrDt4Q4wL0V7piIVYei7vk5FOHcXlVo0bsU8ISZ+M0=;
        b=v6HMB/RNYGTpCDolLfYMVrpKc5hCqHbH+pZ4aWtxPR4zODS0tm/hcOe0c+3ykItWOe
         MpsigYQaPIKr4lynP+z1eblMgu/qXkh2OSYhZTWq0iGxc3X4HwnJXuIFI91ju+833dPR
         S3PXkRVq2i2b9fQR5wZpNAarc49Hk2T9wYAkROmAcr5AxUQ4GeTSe3KxRh5dZR8qbuPQ
         JOJrzP/t8K1HxEoTRSqEXbbbvKrrF0fRwT5+kOBeUPokf06RcLVCusGIAHi/ByYqSG0x
         QXKj2IztlW7HzPmyT00YmcLQObTQEtv3seIUPA4teuJEb+QhgMQvqENRIMwUAVZ0cXsS
         sWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768214641; x=1768819441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMrDt4Q4wL0V7piIVYei7vk5FOHcXlVo0bsU8ISZ+M0=;
        b=DTEz046orhnX5cXGkSVmFSMutZT2zJBJnTjyDid9lLJHGmrTsdrDCdKLQYxl072H4h
         8P6rHvXBnTuhyvk8+dCQbdSBWF5f82Qir2paZYJl1+8ldUcvnai0hzgRTFQUgOaoq3HY
         BzW5ct99CmV53/cer7KiAqBnnOPu9bSFQNqEmrO8bhvr7aSSVnaD+wVAiDKcV3H9JJek
         /i377FRhEicJ4sk2lv3akMEZlaI/aHlEoMbvuwIVwo4MdoRAy8idSE3wQUWvWU3wLnKj
         spsXGnvkBd8MdsXo5sZiPOblfJXVfuK35icsQxnawOEdgtV3njLpwZY0fKXOxsL/poqV
         WdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQbTkeG8MA+OwbIF+k/Np9IxIH6xbXT+c6rT8Mwu/iakroh8zcarY9CDjPF5Rg/TjIUTPE2ycvbZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+peckdltc1vd7J2YvNyXj6fLnZPQaW6sv88eVO0vz4JQRo0Y6
	VrOb79k7xG3Ps46SQIDV7wsbd5VMgTmoIQEAWhWi2nxKGlhKPyp+wd67lm2a6yQKdB85DYUs5v2
	hwJI6
X-Gm-Gg: AY/fxX69c3xsj1UNAz9NY7zsx4bckJLlYkzzrIbeviylp8LMQ/JwA1EdyYTxaZRKqU/
	FDL1T4nJ/cILY/DN2DpzRCg8nFpzWTn//Lmm/jyP50gg9JOAz5/46jWC3eVLIRS+8xE/LoOOTJP
	GGyiy7hRFo2oEkUowvHM6+p8teqwRsIW+FF84aZQLjYNwxhtH3hT60Md0sbOPbIAdLvh1oJsBs/
	sZALyCnaroea+qv3REUiZR1u49OqXF5tq/iCd/xAAud4hPQ2Ucyaiz4wC3wBtTW9ma5vk7RrTAS
	U472nfoVsNdHBedDWepnB99d14nitcHw2xw3USX9ZwuSMgd7Ov9HhYd3Oogm/BiC6uPXG8MhoLZ
	d5R6bED4wpGuZ1W1YuEX3KV5dDXqPUPohHTefRa8yG4NFf70Z+94bicaOnsMn3Lr2kfPMCogTOo
	dbz6hcaTI0Fr3oD1R8mn5gwzdU1xWdCM8JOvWwlx0T0I8qRAXUYFU3XL8Xf3Yy7DHJICDb6dVdG
	A2FBwi0BVP9
X-Google-Smtp-Source: AGHT+IHhhDX1svaSTURQuNz/hlSlDEcbpqJnlm/jbbU9BrgUUIm/I6vxYYgCdCFRIp9etNOMRf/78g==
X-Received: by 2002:a05:600c:a30c:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-47d848787eemr145811145e9.15.1768214641505;
        Mon, 12 Jan 2026 02:44:01 -0800 (PST)
Received: from localhost (p200300f65f20eb045084e32706235b2b.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:5084:e327:623:5b2b])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47d8661caffsm126396445e9.5.2026.01.12.02.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 02:44:00 -0800 (PST)
Date: Mon, 12 Jan 2026 11:43:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Feng Tang <feng.tang@linux.alibaba.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 4/6] PCI/portdrv: Move pcie_port_bus_type to pcie source
 file
Message-ID: <bzezw7ocr65qe33l2jpdhrybckjq7eu65edakxcqdeqjl5ozo4@ipljx5zlol3u>
References: <cover.1764688034.git.u.kleine-koenig@baylibre.com>
 <420d771f0091dea7cf18f445b94301576dcee4c8.1764688034.git.u.kleine-koenig@baylibre.com>
 <df1810e3-6c16-0534-9042-f04dbf123e33@linux.intel.com>
 <iiowlowpgwezv7gffkijkicana64mdgv4vq2mxwztjztqbivgi@w7snrgu5qg3d>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4jlshotm5dxcz2zd"
Content-Disposition: inline
In-Reply-To: <iiowlowpgwezv7gffkijkicana64mdgv4vq2mxwztjztqbivgi@w7snrgu5qg3d>


--4jlshotm5dxcz2zd
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/6] PCI/portdrv: Move pcie_port_bus_type to pcie source
 file
MIME-Version: 1.0

On Fri, Dec 12, 2025 at 11:35:40PM +0100, Uwe Kleine-K=F6nig wrote:
> Hello Ilpo,
>=20
> On Thu, Dec 11, 2025 at 07:28:45PM +0200, Ilpo J=E4rvinen wrote:
> > On Tue, 2 Dec 2025, Uwe Kleine-K=F6nig wrote:
> > > @@ -564,6 +579,11 @@ static int pcie_port_remove_service(struct devic=
e *dev)
> > >  	return 0;
> > >  }
> > > =20
> > > +const struct bus_type pcie_port_bus_type =3D {
> > > +	.name =3D "pci_express",
> > > +	.match =3D pcie_port_bus_match,
> > > +};
> > > +
> > >  /**
> > >   * pcie_port_service_register - register PCI Express port service dr=
iver
> > >   * @new: PCI Express port service driver to register
> >=20
> > I wonder if you should also relocate that #ifdef region=20
> > bus_register(&pcie_port_bus_type); is in and make pcie_port_bus_type=20
> > static? As is, this move feels somewhat incomplete.
>=20
> Yeah, I agree, I had the same feeling. I decided against that because
> I'd need a new function that just calls bus_register and that has to be
> called from pci_driver_init(). I thought this to be hardly better than
> the status quo. Looking again pcieportdrv.o is a separate module that
> doesn't have an initcall, so this could be done in there. Will have a
> look early next week.

This is wrong for two reasons. a) there is an initcall in
drivers/pci/pcie/portdrv.c, and b) it took me longer than "next week".

So the move could be completed by:

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 2cc4e9e6f5ef..23316b5f1491 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1709,11 +1709,6 @@ static int __init pci_driver_init(void)
 	if (ret)
 		return ret;
=20
-#ifdef CONFIG_PCIEPORTBUS
-	ret =3D bus_register(&pcie_port_bus_type);
-	if (ret)
-		return ret;
-#endif
 	dma_debug_add_bus(&pci_bus_type);
 	return 0;
 }
diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 88af0dacf351..3382d50ecb3e 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -838,9 +838,15 @@ static void __init pcie_init_services(void)
=20
 static int __init pcie_portdrv_init(void)
 {
+	int ret;
+
 	if (pcie_ports_disabled)
 		return -EACCES;
=20
+	ret =3D bus_register(&pcie_port_bus_type);
+	if (ret)
+		return ret;
+
 	pcie_init_services();
 	dmi_check_system(pcie_portdrv_dmi_table);
=20
But I'd like to have this postponed and in a separate patch because
pci_driver_init() is a postcore_initcall and pcie_portdrv_init is only a
normal device_initcall(). So it definitively changes ordering and I'd
fear regressions. It would be sad if patches #5 and #6 would need to be
reverted to fix a regression in this area.

So given this is the only open issue in this series I'm aware of, can we
please get this in? Then I'll send a patch for the above change during
the next development cycle.

Best regards
Uwe

--4jlshotm5dxcz2zd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlk0GMACgkQj4D7WH0S
/k69NAf9H7g2LcgmdrVpdBBzmZ6H0mKlnj9nNzs5M8a2drvin7vuP/y0+wYjpRLv
lWHyZ5qIYkqi9wUU0CnEKHYR7u3e4up0dkfPTdWZ4npozl85f36zIeucvraQ5T0T
LGR/q/An2FGkawN1Bqhq11uqBoQpdwqkYlMcDI/WPRluX/wtQ6eeuNUKaDj/aQJz
s41J9ZJJfoeMcSXfckyo58GDglQ8c8Vn2D6y5Dd7GfwOXVTW1V7dqD1/USW0c/Lr
ZLGAAAimG6u0MX8AlxUe4W0Xe5iO5mZPvuIJi/zwtwcP93KH2e6WYJeN0XNRphck
F4Zdgd0L1cZ0MXDVpkxCxIUQ3LVNBg==
=xKCL
-----END PGP SIGNATURE-----

--4jlshotm5dxcz2zd--

