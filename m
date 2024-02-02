Return-Path: <linux-pci+bounces-3021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1595847191
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 15:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B511C278CC
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 14:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7961854;
	Fri,  2 Feb 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Y9YIZYgg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7925A4C2
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882398; cv=none; b=QL/buoq8ZXq8tbmw2/UaQVRWsOc9dFioJb/BhzfOzSsZDCidq4shdQ8VS2MU+fmMQY1KIuME8QYD5yuv1fklSzM5hEvDA7DLRCRyORM2FKOufbfe+G/k2GIojNtaZOu2XWwkEiZqLvKVZg6VSqSY+Q55RiZd+XfOKZ/rKfAwDAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882398; c=relaxed/simple;
	bh=ANIJS9UzkOmFsPmPeZuENE1ZuoiAp/fMOA7MnKgVqIE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=dofQeL6O8lxjvXoNIoBYAgCzMjDiD95CuwwBTRQ8ubNPJhAVqkGqSPeXraSHUlSRHRdnNqeaTLQU6E5pbyPCWB7gVkGZdJ1QLrab3RXvDWVZUZPWqJr5MZG3w4q4Bs/wCrZ4gCh6tIgWNg8Yra/tSKZci41NUkr6/PMFE/FYPmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Y9YIZYgg; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240202135954epoutp013e620482f4d3adcf145dd24c0e21cd28~wEH5w4AdI1386213862epoutp01D
	for <linux-pci@vger.kernel.org>; Fri,  2 Feb 2024 13:59:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240202135954epoutp013e620482f4d3adcf145dd24c0e21cd28~wEH5w4AdI1386213862epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706882394;
	bh=uPljuUqcnvBKfoTySKkhA0+5apgmEsMGTJCKcyU/yGk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Y9YIZYgg0UM/CDb7siYyh1EpHU+CwmZrspyKMd+PBWop6KQgudfOqKCmHWgANBUtg
	 rEHe3CjXYZxJwsheX4pVvc0iobLihlKFsKQ4ny572K0NcvRJwDL8dpWBGkBUcTG9es
	 j1M9pU78pNuj3pC6yMo8ZToCfJp9VW5s6AlfMNI4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240202135952epcas5p14a5f82d917b630160044cc0cab67da79~wEH4njU-I2501125011epcas5p1N;
	Fri,  2 Feb 2024 13:59:52 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TRHTM0l7hz4x9Ps; Fri,  2 Feb
	2024 13:59:51 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.4C.19369.655FCB56; Fri,  2 Feb 2024 22:59:50 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240202115943epcas5p4ffd74eaf0571f61e3bac50be11a94632~wCe_eyBOS1710017100epcas5p4u;
	Fri,  2 Feb 2024 11:59:43 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240202115943epsmtrp1f6562f1a4757eff343b41e8d1578699c~wCe_dpNxn1052510525epsmtrp1f;
	Fri,  2 Feb 2024 11:59:43 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-e9-65bcf556438e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D7.27.07368.F29DCB56; Fri,  2 Feb 2024 20:59:43 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240202115940epsmtip103f90ce67606603a09560c7217533b83~wCe79AHbc2779527795epsmtip1y;
	Fri,  2 Feb 2024 11:59:40 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>,
	<m.szyprowski@samsung.com>, <sboyd@kernel.org>, <mturquette@baylibre.com>
Cc: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <jingoohan1@gmail.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
	<alim.akhtar@samsung.com>, <linux@armlinux.org.uk>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <20240129065448.GC2971@thinkpad>
Subject: RE: [PATCH v4 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Date: Fri, 2 Feb 2024 17:29:30 +0530
Message-ID: <08a901da55cf$4ee48000$ecad8000$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIcpPks/WB953w72Rl3v8cfkz9jJgG3GiapAsOufW4BkcYK8bBB75tA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxjGc3r7ydLlrkU5dKHBi1MR+agreFEYS2DsLriExTjnpmM3cNci
	/UpvK27OjLiqgYH41SBFqiIBRWBSKAJr58K3ZBNZm06jqJtd6GSbHQM2BMooFzf++533vM95
	8rznHD4i8nEl/HyNgdJrSBXGDWG390RHx7475aASiq3b8EfWdi5ee1iJX56s5OHOcTsPLyqd
	5eC2xx4O/mfpAw7u6jrHxb+3DnDxs8PfsPBusxPgpjkTG2/qHeXho6ZiDj4y9AZeY5/k4QuO
	Dh4e8LSwXxcRLs8IQjy9c4RHdFpGecQFm5GwNRRzifseB5fwuitYRGvt58TxtgZA/GWTZoe8
	X5CipMg8Sh9JaXK1efkaRSqWtSMnPScxKUEWK0vGt2CRGlJNpWIZ27NjM/NVi5GwyP2kyrhY
	yiZpGot/LUWvNRqoSKWWNqRilC5PpZPr4mhSTRs1ijgNZdgqS0jYnLjY+FGB0tXbw9X54w/8
	dOMMUgSc60qAgA9ROfReq+GVgBC+CHUAaHd0IsxiAsDATQuLWUwDWDrZySkB/CXJvaZtTN0J
	4B9zjezgUSLUB+BvTXSQuegm6HXPIUEORcsA7PIXBgUIegqB9X2zILghQGPhbb+JE2Qxugue
	ni5jBZmNroWDPw4usRBNhjd8VQjDL8Gbld4lMwSNgXUXxxEmQySc+aWOw5hlwqo2G5fpCYN9
	M6VLcSBaLoDHpqo4jCADfrnwA2BYDJ8MtPEYlsBfy48uswJeaT27bKCC0621LIbT4Lfuc+zg
	JBA0Gn7VFc+UI6B5qJnF+L4Iy2a9y+1C2GF9zlFwct7BZjgcWvtdnBMAs6yIZlkRzbIiguV/
	twuA3QAklI5WK6jcRJ0sVkMV/nfjuVq1DSw9+Y3ZHeDqtfm4bsDig24A+QgWKrwi7aREwjzy
	k08pvTZHb1RRdDdIXBz4SUSyKle7+Gc0hhyZPDlBnpSUJE9+NUmGhQnHj1TniVAFaaAKKEpH
	6Z/rWHyBpIgljvEJ/XX2OM+T/XdbHqetj7ofisR4Wpoa/+krd8vTn30Xte/Q3g3tt1ZpGmKm
	9ogiXI/2kIrLBtRpCxdVrD5/Ujph/yzz2Bnz9dOEtPDtiJJdCrZZvHNd2VTgwzHBYH7DQ/vH
	nuohgfbOm2rJWv+limHBzykzPVdHyIM7X9CJd/eEHbi3ufnB9Q/Ulpa0/vqMTv+mv+fGwmVF
	t9dkheZKzvc3krKnvb8nNu09vrU7ekvNRLTyYav1vUPpRwONh794eQYUBr5Ok7SNiQcqrT4W
	1Ruzen4N37yw3aQcHqqYCevPEtD1mbtPVG94S3p3yjTUjD07NWK79QpcMO94Z5/i0kE3xqaV
	pGwjoqfJfwHDWPdIewQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSnK7+zT2pBj2XRSwezNvGZrGkKcNi
	xZeZ7BZ7X29lt2jo+c1qsenxNVaLjz33WC0u75rDZnF23nE2ixnn9zFZHJq6l9Gi5U8Li8Xa
	I3fZLe62dLJaXDzlarFo6xd2i/97drBb/Lu2kcVByOPytYvMHu9vtLJ77Jx1l91jwaZSj02r
	Otk87lzbw+bx5Mp0Jo/NS+o9+rasYvT4vEkugCuKyyYlNSezLLVI3y6BK+Ptjr9MBc/1Kv5M
	nMzUwLhYtYuRg0NCwETi9lrrLkYuDiGB3YwSX46sYOti5ASKS0p8vriOCcIWllj57zk7RNEz
	RomTT68wgiTYBHQknlz5wwySEBGYyCixfl4HK4jDLLCAWWL+pW/MEC13GCVaF71gAWnhFNCV
	uPChhRXEFhYIldh9ZjM7iM0ioCJx4voJsH28ApYS+1/MZoawBSVOznwC1sssoC3x9OZTOHvZ
	wtfMEPcpSPx8ugxspoiAm8TsLZvYIGrEJY7+7GGewCg8C8moWUhGzUIyahaSlgWMLKsYJVML
	inPTc5MNCwzzUsv1ihNzi0vz0vWS83M3MYJjXUtjB+O9+f/0DjEycTAeYpTgYFYS4V0ptzNV
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK/hjNkpQgLpiSWp2ampBalFMFkmDk6pBqatWysDRbm3
	Brx7+sh3F3/+IncXe3a/iukzfTP/eNZce701VP5WinJG0WvuXWXuJ+euenLUaP+GI9dmsP7w
	cMz903svS2fNf3nZQ+7/znU7XTv63OvWJVEPVcE3kwW+h+5kTdbOPCPV1fOvUDjxVrybTdeN
	10ZNE9Sn7A+Kkcu01rP0Vwhjrm4qFjn44Nsij+WvZ0xXPH/ALW7ny/VRZz1bJx5uWWUVPP8V
	+9Q4C837cTY6Nj8mM+7nVy6syZUVitaedOTkxW/JCw5/+v9h+4FTS+9M2Gpt/H9iwyXeNR0v
	NrzYqfwqkUdPODtYNEzc2vTuB7EzZ77l6YqeOicp2sAkonDHpujZJv2VSiJTGf2VWIozEg21
	mIuKEwFOiEzzZAMAAA==
X-CMS-MailID: 20240202115943epcas5p4ffd74eaf0571f61e3bac50be11a94632
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d
References: <20240124103838.32478-1-shradha.t@samsung.com>
	<CGME20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d@epcas5p2.samsung.com>
	<20240124103838.32478-2-shradha.t@samsung.com>
	<20240129065448.GC2971@thinkpad>



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> Sent: 29 January 2024 12:25
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-sams=
ung-
> soc=40vger.kernel.org; mturquette=40baylibre.com; sboyd=40kernel.org;
> jingoohan1=40gmail.com; lpieralisi=40kernel.org; kw=40linux.com; robh=40k=
ernel.org;
> bhelgaas=40google.com; krzysztof.kozlowski=40linaro.org;
> alim.akhtar=40samsung.com; linux=40armlinux.org.uk;
> m.szyprowski=40samsung.com; pankaj.dubey=40samsung.com
> Subject: Re: =5BPATCH v4 1/2=5D clk: Provide managed helper to get and en=
able bulk
> clocks
>=20
> On Wed, Jan 24, 2024 at 04:08:37PM +0530, Shradha Todi wrote:
> > Provide a managed devm_clk_bulk* wrapper to get and enable all bulk
> > clocks in order to simplify drivers that keeps all clocks enabled for
> > the time of driver operation.
> >
> > Suggested-by: Marek Szyprowski <m.szyprowski=40samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/clk/clk-devres.c =7C 40
> ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h      =7C 24 ++++++++++++++++++++++++
> >  2 files changed, 64 insertions(+)
> >
> > diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c index
> > 4fb4fd4b06bd..cbbd2cc339c3 100644
> > --- a/drivers/clk/clk-devres.c
> > +++ b/drivers/clk/clk-devres.c
> > =40=40 -182,6 +182,46 =40=40 int __must_check devm_clk_bulk_get_all(str=
uct
> > device *dev,  =7D  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
> >
> > +static void devm_clk_bulk_release_all_enable(struct device *dev, void
> > +*res) =7B
> > +	struct clk_bulk_devres *devres =3D res;
> > +
> > +	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
> > +	clk_bulk_put_all(devres->num_clks, devres->clks); =7D
> > +
> > +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> > +					      struct clk_bulk_data **clks) =7B
> > +	struct clk_bulk_devres *devres;
> > +	int ret;
> > +
> > +	devres =3D devres_alloc(devm_clk_bulk_release_all_enable,
> > +			      sizeof(*devres), GFP_KERNEL);
> > +	if (=21devres)
> > +		return -ENOMEM;
> > +
> > +	ret =3D clk_bulk_get_all(dev, &devres->clks);
> > +	if (ret > 0) =7B
> > +		*clks =3D devres->clks;
> > +		devres->num_clks =3D ret;
> > +	=7D else =7B
> > +		devres_free(devres);
> > +		return ret;
> > +	=7D
>=20
> How about:
>=20
> 	ret =3D clk_bulk_get_all(dev, &devres->clks);
> 	if (ret <=3D 0) =7B
> 		devres_free(devres);
> 		return ret;
> 	=7D
>=20
> 	*clks =3D devres->clks;
> 	devres->num_clks =3D ret;
>=20
> Even though this patch follows the pattern used by the rest of the APIs i=
n the
> driver, IMO above makes it more readable.
>=20

Since I have usually seen that maintainers suggest to maintain the coding s=
tyle of the file, I followed the same.
If you have a stronger reason to change this, please let me know
Marek, Michael, Stephen please let us know what do you think about this?

> > +
> > +	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> > +	if (=21ret) =7B
> > +		devres_add(dev, devres);
> > +	=7D else =7B
> > +		clk_bulk_put_all(devres->num_clks, devres->clks);
> > +		devres_free(devres);
> > +	=7D
> > +
>=20
> Same as above:
>=20
> 	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> 	if (ret) =7B
> 		clk_bulk_put_all(devres->num_clks, devres->clks);
> 		devres_free(devres);
> 		return ret;
> 	=7D
>=20
> 	devres_add(dev, devres);
>=20
> > +	return ret;
>=20
> 	return 0;
>=20

Same as above

> > +=7D
> > +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
> > +
> >  static int devm_clk_match(struct device *dev, void *res, void *data)
> > =7B
> >  	struct clk **c =3D res;
> > diff --git a/include/linux/clk.h b/include/linux/clk.h index
> > 1ef013324237..a005e709b7bd 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > =40=40 -438,6 +438,23 =40=40 int __must_check
> > devm_clk_bulk_get_optional(struct device *dev, int num_clks,  int
> __must_check devm_clk_bulk_get_all(struct device *dev,
> >  				       struct clk_bulk_data **clks);
> >
> > +/**
> > + * devm_clk_bulk_get_all_enable - managed get multiple clk consumers a=
nd
> > + *				  enable all clks
>=20
> =22Get and enable all clocks of the consumer (managed)=22
>=20

Will take this up in the next patchset

> > + * =40dev: device for clock =22consumer=22
> > + * =40clks: pointer to the clk_bulk_data table of consumer
> > + *
> > + * Returns success (0) or negative errno.
> > + *
> > + * This helper function allows drivers to get several clk
>=20
> =22This helper function allows drivers to get all clocks of the consumer =
and enables
> them...=22
>=20
> - Mani
>=20

Will take this up. Thanks for your review Mani=21

> > + * consumers and enable all of them in one operation with management.
> > + * The clks will automatically be disabled and freed when the device
> > + * is unbound.
> > + */
> > +
> > +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> > +					      struct clk_bulk_data **clks);
> > +
> >  /**
> >   * devm_clk_get - lookup and obtain a managed reference to a clock pro=
ducer.
> >   * =40dev: device for clock =22consumer=22
> > =40=40 -960,6 +977,13 =40=40 static inline int __must_check
> devm_clk_bulk_get_all(struct device *dev,
> >  	return 0;
> >  =7D
> >
> > +static inline int __must_check devm_clk_bulk_get_all_enable(struct dev=
ice
> *dev,
> > +						struct clk_bulk_data **clks)
> > +=7B
> > +
> > +	return 0;
> > +=7D
> > +
> >  static inline struct clk *devm_get_clk_from_child(struct device *dev,
> >  				struct device_node *np, const char *con_id)  =7B
> > --
> > 2.17.1
> >
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A

