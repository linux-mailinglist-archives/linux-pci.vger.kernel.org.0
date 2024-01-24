Return-Path: <linux-pci+bounces-2512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C683A411
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 09:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FED1F21989
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jan 2024 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630A17755;
	Wed, 24 Jan 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EKGpWJEF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822771757D
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 08:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706084566; cv=none; b=oDqXUxSS59P36e4uwtFKa08DFnHTTLcXk3zdr1Ex/M8aEalT6+Q5eVRGuq3LftVZtP0D4Cin+71Ypg56LbluYPle84g4pgxJOQOO7Hmnl9JqAu7AFeMvdYOmZDmNnpur46KuzmAnp0Q7Aiqlf/ispCMguLrmwaduLt8ltWEPEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706084566; c=relaxed/simple;
	bh=p9xxsKE47BRCCzcGZBCseP1f0ej9KUvrtDS/BG/oTrE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=lDz4x7CNDnf0JROHViYVWzQgkZn5ohtKD1so/U0vJX+NY84rXwLQte+TUnJ7KsrfANdnnFggCFiA9HRNzt1/YZ8u+uVFKaDkI2Oin73d0nt65WG2My858Waj9POaJM6bz9H+GvlVeNJ5GLVYF7dAsEGiwiowz1t96LRrQItURkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EKGpWJEF; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240124082241epoutp03bd5502ade4f44d98a909a597c305c330~tOt6YmiUu1179711797epoutp03j
	for <linux-pci@vger.kernel.org>; Wed, 24 Jan 2024 08:22:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240124082241epoutp03bd5502ade4f44d98a909a597c305c330~tOt6YmiUu1179711797epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706084561;
	bh=R5VbhjhJVO8m4BgjCBAU+C1rYvkYBd3wZ2ug5Ml/88E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=EKGpWJEF0zpSo81OWNqMSljiRQ32fWPfc6KPNlJVyWLiQ56ITJNVmTM44Y3rKFLR+
	 xN86nOLXqNZU/rnZO1AdgOjfrZkRfMN0tUPOutAXlrkoMBvw3goCQXQdZpU4oR2EPI
	 TfMVhRN2gu7tbW9RBlJh8vTLyJP4d7XFuBf9fFl0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240124082241epcas5p1bd3312b6a923e5ba85857413994a2308~tOt55RoXl1857318573epcas5p1J;
	Wed, 24 Jan 2024 08:22:41 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TKcQR2dMcz4x9Pv; Wed, 24 Jan
	2024 08:22:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C4.B5.19369.FC8C0B56; Wed, 24 Jan 2024 17:22:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240124065319epcas5p12681e301fd10a8da9f063f9fc1581d01~tNf4U_fHF0975209752epcas5p1N;
	Wed, 24 Jan 2024 06:53:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240124065319epsmtrp1f32bb73c3b9651595741bfd10bd3be1e~tNf4TOi9i2267022670epsmtrp1a;
	Wed, 24 Jan 2024 06:53:19 +0000 (GMT)
X-AuditID: b6c32a50-c99ff70000004ba9-4f-65b0c8cfaa23
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	54.55.08755.FD3B0B56; Wed, 24 Jan 2024 15:53:19 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240124065316epsmtip2581a492f05445697e6023d189fec380a~tNf1tsIX72736927369epsmtip2K;
	Wed, 24 Jan 2024 06:53:16 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <jingoohan1@gmail.com>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
	<krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
	<linux@armlinux.org.uk>, <m.szyprowski@samsung.com>,
	<pankaj.dubey@samsung.com>
In-Reply-To: <20240120150303.GB5405@thinkpad>
Subject: RE: [PATCH v3 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Date: Wed, 24 Jan 2024 12:23:15 +0530
Message-ID: <05ea01da4e92$0357d310$0a077930$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQK3Yhu837gawrdP2S3E1hwP53Jf7wFhoUR7AWI/r/kCQ7XGLK8GH1bw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBJsWRmVeSWpSXmKPExsWy7bCmuu75ExtSDT53CFk8mLeNzWJJU4bF
	ii8z2S32vt7KbtHQ85vVYtPja6wWH3vusVpc3jWHzeLsvONsFjPO72OyODR1L6NFy58WFou1
	R+6yW9xt6WS1uHjK1WLR1i/sFv/37GC3+HdtI4uDkMflaxeZPd7faGX32DnrLrvHgk2lHptW
	dbJ53Lm2h83jyZXpTB6bl9R79G1ZxejxeZNcAFdUtk1GamJKapFCal5yfkpmXrqtkndwvHO8
	qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EtKCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul
	1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMOUvXMhasMKiYtn8bcwPjFPUuRk4OCQET
	iVMfvjOB2EICexglLu2QgLA/MUrc7zPuYuQCsr8xSkxdv4QdpuHL8pmsEIm9jBIzp3ayQzgv
	GCUWbZnPCFLFJqAj8eTKH2YQW0TAQaL97ScWkCJmgfvMEhd6z4Pt4xTQlbj6fRMriC0sEC7x
	88pPMJtFQFVi8tb5YDavgKXEurP/WCBsQYmTM5+A2cwC2hLLFr5mhjhJQeLn02WsEMvcJJ6c
	bmKGqBGXOPqzhxlksYRAO6fEoQXToX5wkVhx+D0ThC0s8er4Fqi4lMTL/jYoO11i5eYZUAty
	JL5tXgJVby9x4MocoCM4gBZoSqzfpQ8RlpWYemodE8RePone30+gynkldsyDsZUlvvzdwwJh
	S0rMO3aZdQKj0iwkr81C8tosJC/MQti2gJFlFaNUakFxbnpqsmmBoW5eajk8xpPzczcxgpO8
	VsAOxtUb/uodYmTiYDzEKMHBrCTCe0NyXaoQb0piZVVqUX58UWlOavEhRlNggE9klhJNzgfm
	mbySeEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpiydTwcpogvMMz5
	tF3kyNVdr9jDV35Ie9rGprsqsX/Oaw39bd7thyd/vXze01T66pJ50hKXK5f6rj278mTt2jvi
	i7zE2VVt63QzP977xZS4TvzS45Rdu8S+7tN/ah1rOe3wTZMbr0Or+S8qx94y0evXT57wOcz2
	SdlykdIJBzx6yzRN6jWeR56LcYnu6Kxe8qvnRaNgXfkxWcdVPe6Zm/Yfdjnc1xmxMkZMtJql
	cnpja5raXHvfjGiF4F9cHd53rXkyVY5Wtf3lEA/mujjZ+Plr1jV225o09e5+ntESYa994E79
	y868KUt+lWkfa49eUe6yZuH2Mt27khMuXk/I5DpzN2Ri9zmxyd3BT9K7OZVYijMSDbWYi4oT
	AZRMtxZ7BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvO79zRtSDX6uYbV4MG8bm8WSpgyL
	FV9mslvsfb2V3aKh5zerxabH11gtPvbcY7W4vGsOm8XZecfZLGac38dkcWjqXkaLlj8tLBZr
	j9xlt7jb0slqcfGUq8WirV/YLf7v2cFu8e/aRhYHIY/L1y4ye7y/0crusXPWXXaPBZtKPTat
	6mTzuHNtD5vHkyvTmTw2L6n36NuyitHj8ya5AK4oLpuU1JzMstQifbsErozlvf9YCxbpV5zY
	8ZitgfG/ahcjJ4eEgInEl+UzWbsYuTiEBHYzSuy4+IEFIiEp8fniOiYIW1hi5b/n7BBFzxgl
	Dp84C5ZgE9CReHLlDzOILSLgINH+9hMLSBGzwEdmic2zf0KNvcMoseraCrAqTgFdiavfN7GC
	2MICoRIXG9exgdgsAqoSk7fOB4vzClhKrDv7jwXCFpQ4OfMJmM0soC3x9OZTOHvZwtfMEOcp
	SPx8uowV4go3iSenm5ghasQljv7sYZ7AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0L
	DPNSy/WKE3OLS/PS9ZLzczcxgmNdS3MH4/ZVH/QOMTJxMB5ilOBgVhLhvSG5LlWINyWxsiq1
	KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QDU7eL2yuRM6dUum5fzlP4
	3+9UVLD55Qr9N43s9ufX31k932J9CGN3+Bppo5Dt/gbsVYtnv7ode/FQ84KFexvmLLNW+sZ0
	PqrubVyHgtusvq3rAs0CWHYKnc3tXS5flrZ6o75p40Rj2a28smmXJxxs/NHsmTthcmlPVJHd
	9UeFZ1ZwBy+X37thBjd3vSRb4ZqdKb7HHRucm5/U3lzBXr69KujACsvIzGnFcz48lzAu7RSx
	3b088zb3knPZZ28ECHxY+endC2n2/ezcUYKvLn27aXVshUN5tsSrp06Gq1kemFz2EJ+VdOD7
	ywt7+Asyon9OYpt5cOPKOy+3z3nw/H27gejEimLvFdU7QnUjFnSLRCuxFGckGmoxFxUnAgAV
	H02gZAMAAA==
X-CMS-MailID: 20240124065319epcas5p12681e301fd10a8da9f063f9fc1581d01
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
	<20240120150303.GB5405@thinkpad>



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> Sent: 20 January 2024 20:33
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-sams=
ung-
> soc=40vger.kernel.org; mturquette=40baylibre.com; sboyd=40kernel.org;
> jingoohan1=40gmail.com; lpieralisi=40kernel.org; kw=40linux.com; robh=40k=
ernel.org;
> bhelgaas=40google.com; krzysztof.kozlowski=40linaro.org;
> alim.akhtar=40samsung.com; linux=40armlinux.org.uk;
> m.szyprowski=40samsung.com
> Subject: Re: =5BPATCH v3 1/2=5D clk: Provide managed helper to get and en=
able bulk
> clocks
>=20
> On Wed, Jan 10, 2024 at 04:31:14PM +0530, Shradha Todi wrote:
> > Provide a managed devm_clk_bulk* wrapper to get and enable all bulk
> > clocks in order to simplify drivers that keeps all clocks enabled for
> > the time of driver operation.
> >
> > Suggested-by: Marek Szyprowski <m.szyprowski=40samsung.com>
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  drivers/clk/clk-devres.c =7C 41
> ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/clk.h      =7C 25 ++++++++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> >
> > diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c index
> > 4fb4fd4b06bd..05b0ff4bc1d4 100644
> > --- a/drivers/clk/clk-devres.c
> > +++ b/drivers/clk/clk-devres.c
> > =40=40 -102,6 +102,7 =40=40
> EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
> >  struct clk_bulk_devres =7B
> >  	struct clk_bulk_data *clks;
> >  	int num_clks;
> > +	void (*exit)(int num_clks, const struct clk_bulk_data *clks);
> >  =7D;
> >
> >  static void devm_clk_bulk_release(struct device *dev, void *res) =40=
=40
> > -182,6 +183,46 =40=40 int __must_check devm_clk_bulk_get_all(struct dev=
ice
> > *dev,  =7D  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
> >
> > +static void devm_clk_bulk_release_all_enabled(struct device *dev,
> > +void *res) =7B
> > +	struct clk_bulk_devres *devres =3D res;
> > +
> > +	if (devres->exit)
> > +		devres->exit(devres->num_clks, devres->clks);
> > +
> > +	clk_bulk_put_all(devres->num_clks, devres->clks); =7D
> > +
> > +int __must_check devm_clk_bulk_get_all_enabled(struct device *dev,
> > +				  struct clk_bulk_data **clks, int *num_clks)
>=20
> What is the user supposed to do with =22num_clks=22 when you are already =
handling
> the enable part?
>=20

Since the initial clk_bulk_get_all was returning the num_clks value, the th=
ought was to maintain this
as the user might want to have a check in their driver whether x number of =
clocks were successfully
retrieved and enabled.

> > +=7B
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
>=20
> If you move the statements inside this condition to the end of this funct=
ion, you
> could get rid of the exit() callback and directly use
> clk_bulk_disable_unprepare() in devm_clk_bulk_release_all_enabled().
>=20

Okay=21 I will change this in the next patchset as suggested

> > +	=7D else =7B
> > +		devres_free(devres);
> > +		return ret;
> > +	=7D
> > +
> > +	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> > +	if (=21ret)
> > +		devres->exit =3D clk_bulk_disable_unprepare;
>=20
> Here you can just do clk_bulk_put_all() and devres_free() directly becaus=
e you
> know that the driver won't proceed after this error.
>=20
> - Mani
>=20

Thanks for the review, Mani. Will change this as suggested=21

> > +
> > +	return ret;
> > +=7D
> > +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enabled);
> > +
> >  static int devm_clk_match(struct device *dev, void *res, void *data)
> > =7B
> >  	struct clk **c =3D res;
> > diff --git a/include/linux/clk.h b/include/linux/clk.h index
> > 1ef013324237..bf3e9bee5754 100644
> > --- a/include/linux/clk.h
> > +++ b/include/linux/clk.h
> > =40=40 -438,6 +438,24 =40=40 int __must_check
> > devm_clk_bulk_get_optional(struct device *dev, int num_clks,  int
> __must_check devm_clk_bulk_get_all(struct device *dev,
> >  				       struct clk_bulk_data **clks);
> >
> > +/**
> > + * devm_clk_bulk_get_all_enabled - managed get multiple clk consumers =
and
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
> >   * devm_clk_get - lookup and obtain a managed reference to a clock pro=
ducer.
> >   * =40dev: device for clock =22consumer=22
> > =40=40 -960,6 +978,13 =40=40 static inline int __must_check
> devm_clk_bulk_get_all(struct device *dev,
> >  	return 0;
> >  =7D
> >
> > +static inline int __must_check devm_clk_bulk_get_all_enabled(struct de=
vice
> *dev,
> > +				struct clk_bulk_data **clks, int *num_clks) =7B
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

