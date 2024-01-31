Return-Path: <linux-pci+bounces-2858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F43843513
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 06:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0C05289FD2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 05:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06F03D0CA;
	Wed, 31 Jan 2024 05:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DecoXf+h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82043D554
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 05:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677520; cv=none; b=XX3noBRkhDE4qPvT6+IsObykpAbzftCKcPaw2aysRpAB08mrJeYpkLp3mg0EWqOBsLCdnaLvtpWnjZUGF5iF4XgJQkp11yKraPqCozS9f+1EZfm+PoBJYpNKDKDP+iy/Uu795lxaAdpSVoxGwP2Nl7J4lU9Gi6w2qH79MF112js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677520; c=relaxed/simple;
	bh=n2Tq6bEYRktcu0UZ4ZDAI8v/i2S9seIWoTbtVHKBVp4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=s3Hz5JyNdbVYVGSiUlanCFjRSYw7cUIYDsSp+erjfmGhQ77ThZCSVmdOGVnzKg+AD1VaA3s7vJr1eKydIVgRN9/4YgzI4l4HZrh8Zmlem+z+86V373Uc/KDW6VZ7uIeMkYo38/TjgCXgM/5Ai4CZ2nITYpNHxBiw/UZNO8lpsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=DecoXf+h; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240131050516epoutp0297310c831b48e71c20b22446f0a0fa97~vVijEsx3V2712727127epoutp026
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 05:05:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240131050516epoutp0297310c831b48e71c20b22446f0a0fa97~vVijEsx3V2712727127epoutp026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706677516;
	bh=qL3Ay4Pba21ebKmLP4wgOqqtjTV7NsQxQZC9542ZZjY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=DecoXf+hQ/1V8f4MuFlF9yo32Dbk2T/9Z5muRsTIVYMSCgPBtWWjCMInWaF7/FNPJ
	 tgiDxgf3AJed02x519mN5FUHlK1cvEcn0GmLVoNg5O55yv3/XRGWUaAajHYoYfmqiY
	 8lKooD6FW7HM0H+od1QGLmDClVXCRQEhbGtFMows=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240131050516epcas5p47d8730317828176765d0897f441b7e6e~vViiq6zJ30567105671epcas5p4U;
	Wed, 31 Jan 2024 05:05:16 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4TPqjQ3n3kz4x9Pw; Wed, 31 Jan
	2024 05:05:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BA.59.08567.A05D9B56; Wed, 31 Jan 2024 14:05:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240131050514epcas5p4be8d9e13921fd986fe4575a0e6b1357c~vVigf2yS90107301073epcas5p48;
	Wed, 31 Jan 2024 05:05:14 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240131050514epsmtrp2abde2bb514eebfd5e4158a59666f7af3~vVigdBfIQ0572005720epsmtrp2E;
	Wed, 31 Jan 2024 05:05:14 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-41-65b9d50a5e2e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	24.A0.08817.905D9B56; Wed, 31 Jan 2024 14:05:13 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240131050511epsmtip154775cf4996d87fa587c78df7e8f1ced~vVidxnqFt2072320723epsmtip1O;
	Wed, 31 Jan 2024 05:05:11 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Shradha Todi'" <shradha.t@samsung.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <jingoohan1@gmail.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
	<linux@armlinux.org.uk>, <m.szyprowski@samsung.com>,
	<manivannan.sadhasivam@linaro.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <20240124103838.32478-3-shradha.t@samsung.com>
Subject: RE: [PATCH v4 2/2] PCI: exynos: Adapt to clk_bulk_* APIs
Date: Wed, 31 Jan 2024 10:35:10 +0530
Message-ID: <009c01da5403$12b926d0$382b7470$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIcpPks/WB953w72Rl3v8cfkz9jJgIOwv9MAllxpn6wS3ptMA==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbZRjG+XoHxZwVyD6KznIMYzCBVgocBmyDgTvKEjDEJZooO6EnlFBO
	m152M5uddMxdQEDIRhmTFsKwyBiFymWwAbsgIEHCVnDKlJuZI4AbWDAwsO3ZlP9+7/c+T57v
	/S48Jn+GI+BlURpSRRFylOPB+v52UGCIx4M2UmT8yg+r/kKG1S6VcbHOWSsX011YZWOWKRsb
	e3rhERsbab/MwQav9HKwS0M3GVhPaSfA9Gt6FlZ/Z5yLjevPsrHh/iTMZF3iYhsdrVxs3dbI
	wvJvn9jLx0dsw0x8Yew0F28zjHPxSosWt5jPcvBfbR0cfPr+RQbeVP05XtBsBviiZVuqx8fZ
	sTKSkJIqIUllKKRZVGYcmpyWvi89IlIkDhFHY1GokCJyyDg08UBqyLtZcsdEqPAwIdc6llIJ
	tRoN2x2rUmg1pFCmUGviUFIplSslylA1kaPWUpmhFKnZJRaJ3olwCA9lyyYry5nKDfTo4q1B
	hg48f/0ccOdBRAJHbd3AyXzkBoB9E0dpfgbgpFV6Dng42A5g6e/lnJeGurZGNt3oBHD5+R8c
	ungMoGFqiOtUcZAQ2FqV52p4I6MALi2bWc6CidxgwLn2FVegOxIDJ6t7mE72QuLhY/vXLmYh
	AdB0a4TtZE8kGhaUDrBo3gL7yqZdzER2whrjLJPekxD+M1Pj0nsjCXChto5Da7bCP+/e4TqD
	IbLBg7PFl1i0IRGWjAy8MHvBJ73NXJoFcHG+02HmORiHpjUBvSyDc1cbAM17YNf9yyynhIkE
	wYb2MDrqNZi/Os2gnZ7wyzw+rQ6AufMPXoT6waLz59k04zDP/oRTCPwNmwYzbBrMsGkAw/9h
	lYBlBr6kUp2TSWZEKMUUeeS/+85Q5FiA670HJ7aCsW/WQ3sAgwd6AOQxUW/Pb7e1kXxPKXHs
	OKlSpKu0clLdAyIcp13EFPhkKBwfhtKkiyXRIklkZKQkOjxSjG71nD1dIeUjmYSGzCZJJal6
	6WPw3AU6hq95vWqitj9+/MdjQabc7Vla4Z78h7+EBM4UuX04vvdwxILeS1xQfBN/76mv36Dg
	4FsnT5bsC89utK4kdu3W/vATdQ33f9acNCNJfVNwKD1+LbG7cAXvqCqLsjE+6Ky2G4dMxrdb
	djwK3tFb6nY9bCgZpNUn7S/W/XWxrXG95VURNexjuZISc0Qyub0ld3VN98oJ6mdtytjDxYnC
	Nz4rqbib0Tyv/7RVMFATk7M8F+7vZp/L3WUt6K0/OFNo/u5UH9tny73QhWKiXldR3tFckHYm
	wNiYMBp44NTfpoCm/pSue1PvD8+zric07LzKLpo1dp+5Vpf8CRFrbtKjvx2Xy6LsH+1HWWoZ
	IQ5mqtTEv6KRjfJ4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsWy7bCSnC7n1Z2pBveuWFksacqwWPFlJrvF
	3tdb2S0aen6zWmx6fI3V4mPPPVaLy7vmsFmcnXeczWLG+X1MFoem7mW0aPnTwmKx9shddou7
	LZ2sFhdPuVos2vqF3eL/nh3sFv+ubWSx6D1c6yDkcfnaRWaP9zda2T12zrrL7rFgU6nHplWd
	bB53ru1h83hyZTqTx+Yl9R59W1YxenzeJBfAFcVlk5Kak1mWWqRvl8CVcaBpCWvBLcWKfZ+2
	MjcwXpPuYuTkkBAwkVi9cyNrFyMXh5DAbkaJ5n+TmSES0hLXN05gh7CFJVb+e84OUfSMUWLS
	/yZGkASbgK7EjsVtbCAJEYG7jBKNy/+AdTALnGSSmDdfBW7ssgNnWEASnALWEo+WHAJbISzg
	KPHiG8Q6FgFViUX7L7OC2LwClhJ9U0+zQNiCEidnPmGBGKot0fuwlRHGXrbwNdSpChI/ny4D
	6xURcJJ4v2I1G0SNuMTLo0fYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwKjvNRy
	veLE3OLSvHS95PzcTYzgSNfS2sG4Z9UHvUOMTByMhxglOJiVRHhXyu1MFeJNSaysSi3Kjy8q
	zUktPsQozcGiJM777XVvipBAemJJanZqakFqEUyWiYNTqoEpwiLDRv6GcOpx0cLzq4rPmv/Q
	e7L03ILZVu2bL9jURavcFHbZNoeNdwlPuMb/jQ+6GWo1v4QfmlOQqXx+4tbmP+eUzM8ph37d
	FqrK61x+mPN1WOFPqYTbfKbrgxddPSPe5S7S98n0S+Pv0w9+VJVKuq5u5N3I8vfPwxlBX851
	O9pP5ro6aZpj5IWZvrIlHR7rjxuGaFdmX9Hc0TtRn/HX3+BnRuJ+0ctfvs2a0javRVuk/MnD
	k7aiBseyDvseqN378wpjqPMr9YkH7uwJMXSN2HhRPaN+qsChffGuLdtuaQfOijeSPRkQ1K5c
	eVlU7/Fjpg9eez768x9nenNtg9/x88cjL5n9u5Z1XLdWuZpDiaU4I9FQi7moOBEAYH66VWMD
	AAA=
X-CMS-MailID: 20240131050514epcas5p4be8d9e13921fd986fe4575a0e6b1357c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124103858epcas5p3d96cdbe8a6c8f31ccc934025411a09b8
References: <20240124103838.32478-1-shradha.t@samsung.com>
	<CGME20240124103858epcas5p3d96cdbe8a6c8f31ccc934025411a09b8@epcas5p3.samsung.com>
	<20240124103838.32478-3-shradha.t@samsung.com>

Hello Shradha

> -----Original Message-----
> From: Shradha Todi <shradha.t=40samsung.com>
> Sent: Wednesday, January 24, 2024 4:09 PM
> To: linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-sams=
ung-
> soc=40vger.kernel.org
> Cc: mturquette=40baylibre.com; sboyd=40kernel.org; jingoohan1=40gmail.com=
;
> lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; krzysztof.kozlowski=40linaro.org;
> alim.akhtar=40samsung.com; linux=40armlinux.org.uk;
> m.szyprowski=40samsung.com; manivannan.sadhasivam=40linaro.org;
> pankaj.dubey=40samsung.com; Shradha Todi <shradha.t=40samsung.com>
> Subject: =5BPATCH v4 2/2=5D PCI: exynos: Adapt to clk_bulk_* APIs
>=20
> There is no need to hardcode the clock info in the driver as driver can r=
ely on
> the devicetree to supply the clocks required for the functioning of the
> peripheral. Get rid of the static clock info and obtain the platform supp=
lied
> clocks. All the clocks supplied is obtained and enabled using the
> devm_clk_bulk_get_all_enable() API.
>=20
> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

>  drivers/pci/controller/dwc/pci-exynos.c =7C 54 ++-----------------------
>  1 file changed, 4 insertions(+), 50 deletions(-)
>=20
> diff --git a/drivers/pci/controller/dwc/pci-exynos.c
> b/drivers/pci/controller/dwc/pci-exynos.c
> index ec5611005566..3234eb5be1fb 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> =40=40 -54,43 +54,11 =40=40
>  struct exynos_pcie =7B
>  	struct dw_pcie			pci;
>  	void __iomem			*elbi_base;
> -	struct clk			*clk;
> -	struct clk			*bus_clk;
> +	struct clk_bulk_data		*clks;
>  	struct phy			*phy;
>  	struct regulator_bulk_data	supplies=5B2=5D;
>  =7D;
>=20
> -static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep) -=7B
> -	struct device *dev =3D ep->pci.dev;
> -	int ret;
> -
> -	ret =3D clk_prepare_enable(ep->clk);
> -	if (ret) =7B
> -		dev_err(dev, =22cannot enable pcie rc clock=22);
> -		return ret;
> -	=7D
> -
> -	ret =3D clk_prepare_enable(ep->bus_clk);
> -	if (ret) =7B
> -		dev_err(dev, =22cannot enable pcie bus clock=22);
> -		goto err_bus_clk;
> -	=7D
> -
> -	return 0;
> -
> -err_bus_clk:
> -	clk_disable_unprepare(ep->clk);
> -
> -	return ret;
> -=7D
> -
> -static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep) -=
=7B
> -	clk_disable_unprepare(ep->bus_clk);
> -	clk_disable_unprepare(ep->clk);
> -=7D
> -
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)  =
=7B
>  	writel(val, base + reg);
> =40=40 -332,17 +300,9 =40=40 static int exynos_pcie_probe(struct platform=
_device
> *pdev)
>  	if (IS_ERR(ep->elbi_base))
>  		return PTR_ERR(ep->elbi_base);
>=20
> -	ep->clk =3D devm_clk_get(dev, =22pcie=22);
> -	if (IS_ERR(ep->clk)) =7B
> -		dev_err(dev, =22Failed to get pcie rc clock=5Cn=22);
> -		return PTR_ERR(ep->clk);
> -	=7D
> -
> -	ep->bus_clk =3D devm_clk_get(dev, =22pcie_bus=22);
> -	if (IS_ERR(ep->bus_clk)) =7B
> -		dev_err(dev, =22Failed to get pcie bus clock=5Cn=22);
> -		return PTR_ERR(ep->bus_clk);
> -	=7D
> +	ret =3D devm_clk_bulk_get_all_enable(dev, &ep->clks);
> +	if (ret < 0)
> +		return ret;
>=20
>  	ep->supplies=5B0=5D.supply =3D =22vdd18=22;
>  	ep->supplies=5B1=5D.supply =3D =22vdd10=22;
> =40=40 -351,10 +311,6 =40=40 static int exynos_pcie_probe(struct platform=
_device
> *pdev)
>  	if (ret)
>  		return ret;
>=20
> -	ret =3D exynos_pcie_init_clk_resources(ep);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep-
> >supplies);
>  	if (ret)
>  		return ret;
> =40=40 -369,7 +325,6 =40=40 static int exynos_pcie_probe(struct platform_=
device
> *pdev)
>=20
>  fail_probe:
>  	phy_exit(ep->phy);
> -	exynos_pcie_deinit_clk_resources(ep);
>  	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
>=20
>  	return ret;
> =40=40 -383,7 +338,6 =40=40 static int __exit exynos_pcie_remove(struct
> platform_device *pdev)
>  	exynos_pcie_assert_core_reset(ep);
>  	phy_power_off(ep->phy);
>  	phy_exit(ep->phy);
> -	exynos_pcie_deinit_clk_resources(ep);
>  	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
>=20
>  	return 0;
> --
> 2.17.1



