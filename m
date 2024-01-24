Return-Path: <linux-pci+bounces-2511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 150D183A40B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 09:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AFEA1F224E8
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02DD1754C;
	Wed, 24 Jan 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IL0TuiFa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5D117551
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 08:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084553; cv=none; b=WC+dhfxXAnWTM9itxtS3bp41x5rtDcSwVxtieoQBhbZvl+wQOrLF5WqlV8HOmu2TuCDcJ73M8XXgHY7jjCXvgZbkgOEUtQKfz4fMKo1zWYMNaFW76CXz+uqCPoxerjx9g9bZdbFRZ1lq+y7/puvY2ZZLPFCfnV93p2sZMGCRANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084553; c=relaxed/simple;
	bh=VOrPe0Px8OH+E8oC5sQu7xuToA+TdC/y8OTGx/mvutc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=EXk3H740k6xXsENApQxRjY3N0IdJpIKJkuwgYdTCrKboff8CWEmdJT5V9M+pccegu0dyCTvFYcf1W6xDxVRhKv5r84nV4PmxRsDuGiigvYtB13kmiu+b7J979gV5lJqEs6cMtzyCvmESEts557wNApNHrVlH2D1d0EmJWXswrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IL0TuiFa; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240124082228epoutp0474308580ee9e3145c2fdfd6c7ff6b6af~tOttxEWEC1751517515epoutp04f
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 08:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240124082228epoutp0474308580ee9e3145c2fdfd6c7ff6b6af~tOttxEWEC1751517515epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706084548;
	bh=/uytoDMxLCBDZBYsTuKhf3zBY1XyUga051NVgA740ac=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=IL0TuiFajNSqPeBkrKtQnRppY05z+M58TtZDgG7u34xo20+yaAP7kJkwPWatYNHax
	 nKYaW+Ehf0rjom8XuYSPGCdls3/RpPckGyjwao7FZvFz4gmPygTC5+EiYBit4Xu0AE
	 0Q2VvG9mEeM/KA3DcWD1EZydF2gaHbxDY9BGC6LA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240124082227epcas5p3b8fa4c06838be625565b9855849e04e4~tOttOVoVP2021520215epcas5p3L;
	Wed, 24 Jan 2024 08:22:27 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TKcQ91LJZz4x9Pr; Wed, 24 Jan
	2024 08:22:25 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.A5.19369.0C8C0B56; Wed, 24 Jan 2024 17:22:25 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240124063912epcas5p2682fbdd5bcebc79ab2bfb197b75f8e64~tNTj9L_-O2475224752epcas5p2W;
	Wed, 24 Jan 2024 06:39:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240124063912epsmtrp21de30c7627d4caa52fd2e4b01346b156~tNTj8SHUg1695016950epsmtrp2e;
	Wed, 24 Jan 2024 06:39:12 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-21-65b0c8c0ff7f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D3.24.08755.090B0B56; Wed, 24 Jan 2024 15:39:12 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240124063910epsmtip2015245bed1cd1cc245f8e8683500ccd0~tNThgFfnR1071810718epsmtip2b;
	Wed, 24 Jan 2024 06:39:09 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Alim Akhtar'" <alim.akhtar@samsung.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <jingoohan1@gmail.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
	<linux@armlinux.org.uk>, <m.szyprowski@samsung.com>,
	<manivannan.sadhasivam@linaro.org>
In-Reply-To: <001001da43c0$e8e9a8e0$babcfaa0$@samsung.com>
Subject: RE: [PATCH v3 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Date: Wed, 24 Jan 2024 12:09:08 +0530
Message-ID: <05e001da4e90$0ace4b80$206ae280$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK3Yhu837gawrdP2S3E1hwP53Jf7wFhoUR7AWI/r/kCd/fnoa8EfBEQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmuu7BExtSDeZOZLJ4MG8bm8WSpgyL
	FV9mslvsfb2V3aKh5zerxabH11gtPvbcY7W4vGsOm8XZecfZLGac38dkcWjqXkaLlj8tLBZr
	j9xlt7jb0slqcfGUq8X/PTvYLf5d28jiIOhx+dpFZo/3N1rZPXbOusvusWBTqcemVZ1sHneu
	7WHzeHJlOpPH5iX1Hn1bVjF6fN4kF8AVlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhr
	aGlhrqSQl5ibaqvk4hOg65aZA/SNkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA
	pECvODG3uDQvXS8vtcTK0MDAyBSoMCE74/rNqawFR40qlnW9YW1gnK7ZxcjJISFgIrH4YAtz
	FyMXh5DAHkaJ3kfT2CCcT4wSk+91QDnfGCXmHrjMBtNy8OlvqJa9jBJ35+xgAkkICbxglNh5
	zgzEZhPQkXhy5Q9YkYjADUaJ64+OgjnMAvOZJB7ufw82ilPASuJm/05mEFtYIFzi55WfrCA2
	i4CqxNP+ZSwgNq+ApcSFbZeZIGxBiZMzn4DFmQW0JZYtfM0McZKCxM+ny8B6RQTcJJ4/nMgK
	USMucfRnD9hiCYEfHBJz7xxlgWhwkXj1r4kJwhaWeHV8CzuELSXx+d1eqD/TJVZungG1IEfi
	2+YlUPX2EgeuzAGawwG0QFNi/S59iLCsxNRT65gg9vJJ9P5+AlXOK7FjHoytLPHl7x6oEyQl
	5h27zDqBUWkWktdmIXltFpIXZiFsW8DIsopRKrWgODc9Ndm0wFA3L7UcHufJ+bmbGMHpXStg
	B+PqDX/1DjEycTAeYpTgYFYS4b0huS5ViDclsbIqtSg/vqg0J7X4EKMpMMAnMkuJJucDM0xe
	SbyhiaWBiZmZmYmlsZmhkjjv69a5KUIC6YklqdmpqQWpRTB9TBycUg1MrLx+DGsLqpcH7Bbs
	EKnZpyHkV+RZq8q01bd6gYBw6x4rmVv/A4WvnZ6t9cmaW1++IOePhXK1rvyT+2sXxGuaWyne
	l93kJL921X3vjQK2R15Wcf644n/h34nKInvms7ypF0O7v5z+eHSeqJbtBGm+br3p668U60is
	uBvao52ftGzCsj7fRS+vKTtJHd6THl9+cOE/pqebvNJz32y/1t56+5/DjZIzTgq9DFPZ4zKL
	i9T/MdkZ81d9r3tzpUXkzSXnK1VXbZpXLti38OYWU/OHL4V0jA7mM8ic8Pm9WH5XSF/CqiXN
	bRf9XebptF8Tkbmm55KoOfX2DreXt1Uv+hzM7bndelBt8XJ2JV0bhitKLMUZiYZazEXFiQAG
	ivfueAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSvO6EDRtSDRatVbV4MG8bm8WSpgyL
	FV9mslvsfb2V3aKh5zerxabH11gtPvbcY7W4vGsOm8XZecfZLGac38dkcWjqXkaLlj8tLBZr
	j9xlt7jb0slqcfGUq8X/PTvYLf5d28jiIOhx+dpFZo/3N1rZPXbOusvusWBTqcemVZ1sHneu
	7WHzeHJlOpPH5iX1Hn1bVjF6fN4kF8AVxWWTkpqTWZZapG+XwJXx4axSwRzDii8v5zE1ML5Q
	72Lk5JAQMJE4+PQ3cxcjF4eQwG5GiV1tnawQCUmJzxfXMUHYwhIr/z1nhyh6xihxan8DO0iC
	TUBH4smVP8wgtojAPUaJyefqQYqYBVYzSfxZ/pcNouMlo8SLU91gVZwCVhI3+3eC2cICoRIX
	G9exgdgsAqoST/uXsYDYvAKWEhe2XWaCsAUlTs58AhZnFtCWeHrzKZy9bOFrZojzFCR+Pl3G
	CnGFm8TzhxNZIWrEJY7+7GGewCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPTc4sNCwzzUsv1
	ihNzi0vz0vWS83M3MYLjW0tzB+P2VR/0DjEycTAeYpTgYFYS4b0huS5ViDclsbIqtSg/vqg0
	J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwTB6dUA9O+/3ITzE6t1TgyzSHnpsu9d5tt
	w6r37lpalJW98L7pV0dDT9G37IIRGlXTar1MIh/eK769ecW2BHX7wxJZl4sFDobkGH/o0Jzn
	XXXs/WfHzyxCARG7j6w5Y1K/+dHPs229+XNM1sxkLNJtmrXUNKVGT8mA+Urt1a29N4XObEsq
	W6ezU/qaz4RVZjn3hUWWXiu+7btRxMNYSlb8yczQySWn3E435cr9z7vTckB9opO/bm+eFIP2
	PF6x6L99ftebGArUVqolhaRz3apd9V9c7bDbujNH957p23u6VVihaML8v60Pz6WGWKS4vuUy
	4agQTX/i7/Xxu1hv7eJ+llUxDxKznE0EUp4/TxZwtNn/TomlOCPRUIu5qDgRALnOZxNeAwAA
X-CMS-MailID: 20240124063912epcas5p2682fbdd5bcebc79ab2bfb197b75f8e64
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3
References: <20240110110115.56270-1-shradha.t@samsung.com>
	<CGME20240110110156epcas5p36bac4093be0fa6eaa501d7eaed4d43d3@epcas5p3.samsung.com>
	<20240110110115.56270-2-shradha.t@samsung.com>
	<001001da43c0$e8e9a8e0$babcfaa0$@samsung.com>



> -----Original Message-----
> From: Alim Akhtar <alim.akhtar=40samsung.com>
> Sent: 10 January 2024 18:01
> To: 'Shradha Todi' <shradha.t=40samsung.com>; linux-clk=40vger.kernel.org=
; linux-
> kernel=40vger.kernel.org; linux-pci=40vger.kernel.org; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org
> Cc: mturquette=40baylibre.com; sboyd=40kernel.org; jingoohan1=40gmail.com=
;
> lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org; bhelgaas=40go=
ogle.com;
> krzysztof.kozlowski=40linaro.org; linux=40armlinux.org.uk;
> m.szyprowski=40samsung.com; manivannan.sadhasivam=40linaro.org;
> alim.akhtar=40samsung.com
> Subject: RE: =5BPATCH v3 1/2=5D clk: Provide managed helper to get and en=
able bulk
> clocks
>=20
> Hi Shradha,
>=20
> > -----Original Message-----
> > From: Shradha Todi <shradha.t=40samsung.com>
> > Sent: Wednesday, January 10, 2024 4:31 PM
> > To: linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> > pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org;
> > linux-samsung- soc=40vger.kernel.org
> > Cc: mturquette=40baylibre.com; sboyd=40kernel.org; jingoohan1=40gmail.c=
om;
> > lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> > bhelgaas=40google.com; krzysztof.kozlowski=40linaro.org;
> > alim.akhtar=40samsung.com; linux=40armlinux.org.uk;
> > m.szyprowski=40samsung.com; manivannan.sadhasivam=40linaro.org; Shradha
> > Todi <shradha.t=40samsung.com>
> > Subject: =5BPATCH v3 1/2=5D clk: Provide managed helper to get and enab=
le
> > bulk clocks
> >
> > Provide a managed devm_clk_bulk* wrapper to get and enable all bulk
> > clocks in order to simplify drivers that keeps all clocks enabled for
> > the time of driver operation.
> >
> > Suggested-by: Marek Szyprowski <m.szyprowski=40samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/clk/clk-devres.c =7C 41
> > ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h      =7C 25 ++++++++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> >
> > diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c index
> > 4fb4fd4b06bd..05b0ff4bc1d4 100644
> > --- a/drivers/clk/clk-devres.c
> > +++ b/drivers/clk/clk-devres.c
> > =40=40 -102,6 +102,7 =40=40
> > EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
> >  struct clk_bulk_devres =7B
> >  	struct clk_bulk_data *clks;
> >  	int num_clks;
> > +	void (*exit)(int num_clks, const struct clk_bulk_data *clks);
> >  =7D;
> >
> >  static void devm_clk_bulk_release(struct device *dev, void *res) =40=
=40
> > -182,6
> > +183,46 =40=40 int __must_check devm_clk_bulk_get_all(struct device *de=
v,
> > +=7D
> > EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
> >
> > +static void devm_clk_bulk_release_all_enabled(struct device *dev,
> > +void
> May be devm_clk_bulk_release_all_disable()
>=20

Will change this in the next patchset

> Also this is similar to already existing devm_clk_bulk_release_all(), may=
 be you
> can reuse this function And add the exit() callback in devm_clk_bulk_rele=
ase_all()
>=20

Since I'm planning to remove the exit callback in the next version as sugge=
sted by Manivannan, I will have to
go with a new release function

> > +*res) =7B
> > +	struct clk_bulk_devres *devres =3D res;
> > +
> > +	if (devres->exit)
> > +		devres->exit(devres->num_clks, devres->clks);
> > +
> > +	clk_bulk_put_all(devres->num_clks, devres->clks); =7D
> > +
> > +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
>=20
> May be devm_clk_bulk_get_all_enable() is more suitable
>=20

Will take this in the next patchset=21 Thanks for the review

> > +				  struct clk_bulk_data **clks, int *num_clks) =7B
> > +	struct clk_bulk_devres *devres;
> > +	int ret;
> > +
> > +	devres =3D devres_alloc(devm_clk_bulk_release_all_enabled,
> > +			      sizeof(*devres), GFP_KERNEL);
> > +	if (=21devres)
> > +		return -ENOMEM;
> > +
> > +	ret =3D clk_bulk_get_all(dev, &devres->clks);
> > +	if (ret > 0) =7B
> > +		*clks =3D devres->clks;
> > +		devres->num_clks =3D ret;
> > +		*num_clks =3D ret;
> > +		devres_add(dev, devres);
> > +	=7D else =7B
> > +		devres_free(devres);
> > +		return ret;
> > +	=7D
> > +
> > +	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> > +	if (=21ret)
> > +		devres->exit =3D clk_bulk_disable_unprepare;
> > +
> > +	return ret;
> > +=7D
> > +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
> > +
> >  static int devm_clk_match(struct device *dev, void *res, void *data)  =
=7B
> >  	struct clk **c =3D res;
> > diff --git a/include/linux/clk.h b/include/linux/clk.h index
> > 1ef013324237..bf3e9bee5754 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > =40=40 -438,6 +438,24 =40=40 int __must_check
> > devm_clk_bulk_get_optional(struct device *dev, int num_clks,  int
> > __must_check devm_clk_bulk_get_all(struct device *dev,
> >  				       struct clk_bulk_data **clks);
> >
> > +/**
> > + * devm_clk_bulk_get_all_enabled - managed get multiple clk consumers
> > and
> > + *					enable all clk
> > + * =40dev: device for clock =22consumer=22
> > + * =40clks: pointer to the clk_bulk_data table of consumer
> > + * =40num_clks: out parameter to store the number of clk_bulk_data
> > + *
> > + * Returns success (0) or negative errno.
> > + *
> > + * This helper function allows drivers to get several clk
> > + * consumers and enable all of them in one operation with management.
> > + * The clks will automatically be disabled and freed when the device
> > + * is unbound.
> > + */
> > +
> > +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> > +				struct clk_bulk_data **clks, int *num_clks);
> > +
> >  /**
> >   * devm_clk_get - lookup and obtain a managed reference to a clock
> > producer.
> >   * =40dev: device for clock =22consumer=22
> > =40=40 -960,6 +978,13 =40=40 static inline int __must_check
> > devm_clk_bulk_get_all(struct device *dev,
> >  	return 0;
> >  =7D
> >
> > +static inline int __must_check devm_clk_bulk_get_all_enabled(struct
> > device *dev,
> > +				struct clk_bulk_data **clks, int *num_clks) =7B
> > +
> > +	return 0;
> > +=7D
> > +
> >  static inline struct clk *devm_get_clk_from_child(struct device *dev,
> >  				struct device_node *np, const char *con_id) =7B
> > --
> > 2.17.1
>=20



