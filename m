Return-Path: <linux-pci+bounces-2857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E38434FB
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 06:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DB2EB22AAE
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 05:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8523D384;
	Wed, 31 Jan 2024 05:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="C/6DBw1b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDF03D38C
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 05:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706677490; cv=none; b=jmElntBFG31BJ9n+lGcEHC6dQdPJ1LslObkbyZkfALtlsQ1j4UkSsfgc6og+YjvjqnDtmJ5Sd0u29SCpaL722a42eekqczWN26zU86/IlInmJqX0RC+OtXMLxECX0fGCswN3S5miSNNWAxz6zTI91+8A27YdH+IXRpcT731Bq7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706677490; c=relaxed/simple;
	bh=ozsbjuFfrDrel1zvIqWJ+Px1N3BXsFW7a0mQarbNt40=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=M5OcOWbhAa94MN0CkBm/5T2l+vKRsslUXkYR6lSGLr4yOFFL/9642GRcRQudEPmNvuVmgPUC5d6MaZReN+2jqB86GLuiNfZeCYf1g1n/K+8rSANOt8wh3b6tykyeb7yOv4f9cwSVBblnaDV9h8DQtbyBXHfvg+iUzkJ3Lvoqdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=C/6DBw1b; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240131050444epoutp01073f485e24dd849799ecd51e5a7ceeb9~vViEtLkwi0085900859epoutp01P
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 05:04:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240131050444epoutp01073f485e24dd849799ecd51e5a7ceeb9~vViEtLkwi0085900859epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706677484;
	bh=gsvbIOyOSrjMUXayJMmPPRCKGWsgCiQGBNQtMy3C5Aw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=C/6DBw1bxMVG5f5WoK4u3lOPBD1QhtRpbnNU1FGaYYWrqSgShVQpPiIhwtVdmZUmR
	 DIzoJdJ4A9m8wOjGCYwR1BKnvgnWu5UrIJQO0LTS4RoQd6/5whR8zt8QwxjkG8m4U+
	 MHLBCYMIHQBxO5CTxkEodGNnRP4jcBSreoVoPNRM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240131050443epcas5p46e1e2a1232f33e77123606dc2574df3a~vViEVV9AP0567105671epcas5p4b;
	Wed, 31 Jan 2024 05:04:43 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TPqhp1cR7z4x9QD; Wed, 31 Jan
	2024 05:04:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.39.08567.AE4D9B56; Wed, 31 Jan 2024 14:04:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240131050441epcas5p1854fb3d30778fa7033a920d4a207662c~vViB8sDBR1292912929epcas5p13;
	Wed, 31 Jan 2024 05:04:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240131050441epsmtrp23a454530efc67a243c01ef85ad6bdbf5~vViB7px8B0527905279epsmtrp2I;
	Wed, 31 Jan 2024 05:04:41 +0000 (GMT)
X-AuditID: b6c32a44-c1e3da8000002177-e2-65b9d4eabdbd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	28.6C.08755.9E4D9B56; Wed, 31 Jan 2024 14:04:41 +0900 (KST)
Received: from INBRO000447 (unknown [107.122.12.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240131050438epsmtip1bc422215090eb3317c9da112fce8166d~vVh-YEDJ21904719047epsmtip17;
	Wed, 31 Jan 2024 05:04:38 +0000 (GMT)
From: "Alim Akhtar" <alim.akhtar@samsung.com>
To: "'Shradha Todi'" <shradha.t@samsung.com>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>
Cc: <mturquette@baylibre.com>, <sboyd@kernel.org>, <jingoohan1@gmail.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
	<linux@armlinux.org.uk>, <m.szyprowski@samsung.com>,
	<manivannan.sadhasivam@linaro.org>, <pankaj.dubey@samsung.com>
In-Reply-To: <20240124103838.32478-2-shradha.t@samsung.com>
Subject: RE: [PATCH v4 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Date: Wed, 31 Jan 2024 10:34:37 +0530
Message-ID: <009b01da5402$ff3370c0$fd9a5240$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIcpPks/WB953w72Rl3v8cfkz9jJgG3GiapAsOufW6wSuUg0A==
Content-Language: en-us
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmlu6rKztTDTqbWSyWNGVYrPgyk91i
	7+ut7BYNPb9ZLTY9vsZq8bHnHqvF5V1z2CzOzjvOZjHj/D4mi0NT9zJatPxpYbFYe+Quu8Xd
	lk5Wi4unXC0Wbf3CbvF/zw52i3/XNrJY9B6udRDyuHztIrPH+xut7B47Z91l91iwqdRj06pO
	No871/aweTy5Mp3JY/OSeo++LasYPT5vkgvgisq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
	MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
	kJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfFm8XXWghvKFUc2r2JuYFwq28XIwSEhYCLx
	Z4NgFyMXh5DAbkaJbVvOskI4nxglfn49wgjhfGOUuLhoF3MXIydYx7K9k9ghEnsZJfZ8P8wM
	4bxglHhzZiMLSBWbgK7EjsVtbCAJEYHrjBJfvq9iAXGYBXYzSbzd9YMRpIpTwFpi5qpusA5h
	gXCJyd96mUBsFgFViVNvJrGC2LwClhLzmvYyQtiCEidnPgGrZxbQlli28DXUTQoSP58uA6sX
	EXCSmPnjKlSNuMTLo0fAbpUQ+M8hcf3XYSaIBheJ7TfOs0HYwhKvjm9hh7ClJD6/28sGCRoP
	iUV/pCDCGRJvl69nhLDtJQ5cmcMCUsIsoCmxfpc+xCo+id7fT5ggOnklOtqEIKpVJZrfQVwj
	ISAtMbG7mxXC9pBYOqOfeQKj4iwkj81C8tgsJA/MQli2gJFlFaNkakFxbnpqsmmBYV5qOTzC
	k/NzNzGCE7yWyw7GG/P/6R1iZOJgPMQowcGsJMK7Um5nqhBvSmJlVWpRfnxRaU5q8SFGU2Bo
	T2SWEk3OB+aYvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OEBNITS1KzU1MLUotg+pg4OKUamM7J
	n1eoPyM+wSynZHZWEuf6PtlyhhqDc2a+585+1ZYwla8z33jnZUIj1z33ql3c2+fO1qn//fHU
	V/eHj9qLmef+PPk85OSOkMPyM0Q/1iZd/jAr6XLUhkm75ok/OWPquDxXTDL+Y7Kr0MpSvbAT
	Pumc/XVqeh4RfHLNR9N86yW6Neuv8sd72xlfKc3ezWjhnuDO5VN58+m+Yg/RoAfH/DO6vYN3
	3H274v6t+2WiE+MXn2/aXliVK6c2cbnGUT19/ZjIPW4+QZeeV+bzimqFL/uTcfTMP/+QhzNn
	v+pcenSCP89SSY5iXo9gs+lyL9ewv+t/M6tzxib5k7FLcuo75q3ymia2IrCqe9417iQHJZbi
	jERDLeai4kQACFIquXkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSnO7LKztTDTZs47VY0pRhseLLTHaL
	va+3sls09Pxmtdj0+Bqrxceee6wWl3fNYbM4O+84m8WM8/uYLA5N3cto0fKnhcVi7ZG77BZ3
	WzpZLS6ecrVYtPULu8X/PTvYLf5d28hi0Xu41kHI4/K1i8we72+0snvsnHWX3WPBplKPTas6
	2TzuXNvD5vHkynQmj81L6j36tqxi9Pi8SS6AK4rLJiU1J7MstUjfLoErY9+yXvaCc0oV/W2z
	2RsY58t0MXJySAiYSCzbO4kdxBYS2M0o8WZWPERcWuL6xgnsELawxMp/z4FsLqCaZ4wS63Zf
	ZwVJsAnoSuxY3MYGkhARuMso0bj8D1gHs8BJJol581UgOoCmvluyCKyDU8BaYuaqbhYQW1gg
	VGL3mc1gDSwCqhKn3kwCq+EVsJSY17SXEcIWlDg58wkLxFBtid6HrYww9rKFr5khzlOQ+Pl0
	GViviICTxMwfV6HqxSVeHj3CPoFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucWGxYY5qWW
	6xUn5haX5qXrJefnbmIEx7mW5g7G7as+6B1iZOJgPMQowcGsJMK7Um5nqhBvSmJlVWpRfnxR
	aU5q8SFGaQ4WJXFe8Re9KUIC6YklqdmpqQWpRTBZJg5OqQamdU1qOxMWhv978cC6I0iLufPh
	pe52sVSZZTyxGpfC9kn92prF7nm6TNmknlVfYv1hnpKPcypeTBLjqK+ZbG2l5X/dqimw4+kn
	0wsehWdPB56ayvuUv+OlWXjh2yB3iUP3U/wLbhc7u/6ZN7HjTWaPf09LsEgDI/9mlo07hGu5
	ZoXyr0351Ps69Fae56qEdQU/bDWPWvPxSS1LT7H8MrVAI/azhw6n3i8rphlOxxjvbckK73/8
	aXZiiP7TTt478ru+C6zTlmF5ZdI+P+Sy5HrZkPjgY7M9DimEvfXtP5i29p7i7V8bxFLWt15a
	UXb6xc3m7/16M/9rZn13lX09yzP88N1/9ZGON9ZdnHCxaaUSS3FGoqEWc1FxIgDKZv07YgMA
	AA==
X-CMS-MailID: 20240131050441epcas5p1854fb3d30778fa7033a920d4a207662c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d
References: <20240124103838.32478-1-shradha.t@samsung.com>
	<CGME20240124103855epcas5p27400bd95df42f36b9547a4e28aa26f5d@epcas5p2.samsung.com>
	<20240124103838.32478-2-shradha.t@samsung.com>

Hi Shradha

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
> Subject: =5BPATCH v4 1/2=5D clk: Provide managed helper to get and enable=
 bulk
> clocks
>=20
> Provide a managed devm_clk_bulk* wrapper to get and enable all bulk clock=
s
> in order to simplify drivers that keeps all clocks enabled for the time o=
f driver
> operation.
>=20
> Suggested-by: Marek Szyprowski <m.szyprowski=40samsung.com>
> Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar=40samsung.com>

>  drivers/clk/clk-devres.c =7C 40
> ++++++++++++++++++++++++++++++++++++++++
>  include/linux/clk.h      =7C 24 ++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>=20
> diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c index
> 4fb4fd4b06bd..cbbd2cc339c3 100644
> --- a/drivers/clk/clk-devres.c
> +++ b/drivers/clk/clk-devres.c
> =40=40 -182,6 +182,46 =40=40 int __must_check devm_clk_bulk_get_all(struc=
t
> device *dev,  =7D  EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
>=20
> +static void devm_clk_bulk_release_all_enable(struct device *dev, void
> +*res) =7B
> +	struct clk_bulk_devres *devres =3D res;
> +
> +	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
> +	clk_bulk_put_all(devres->num_clks, devres->clks); =7D
> +
> +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> +					      struct clk_bulk_data **clks) =7B
> +	struct clk_bulk_devres *devres;
> +	int ret;
> +
> +	devres =3D devres_alloc(devm_clk_bulk_release_all_enable,
> +			      sizeof(*devres), GFP_KERNEL);
> +	if (=21devres)
> +		return -ENOMEM;
> +
> +	ret =3D clk_bulk_get_all(dev, &devres->clks);
> +	if (ret > 0) =7B
> +		*clks =3D devres->clks;
> +		devres->num_clks =3D ret;
> +	=7D else =7B
> +		devres_free(devres);
> +		return ret;
> +	=7D
> +
> +	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
> +	if (=21ret) =7B
> +		devres_add(dev, devres);
> +	=7D else =7B
> +		clk_bulk_put_all(devres->num_clks, devres->clks);
> +		devres_free(devres);
> +	=7D
> +
> +	return ret;
> +=7D
> +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
> +
>  static int devm_clk_match(struct device *dev, void *res, void *data)  =
=7B
>  	struct clk **c =3D res;
> diff --git a/include/linux/clk.h b/include/linux/clk.h index
> 1ef013324237..a005e709b7bd 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> =40=40 -438,6 +438,23 =40=40 int __must_check
> devm_clk_bulk_get_optional(struct device *dev, int num_clks,  int
> __must_check devm_clk_bulk_get_all(struct device *dev,
>  				       struct clk_bulk_data **clks);
>=20
> +/**
> + * devm_clk_bulk_get_all_enable - managed get multiple clk consumers
> and
> + *				  enable all clks
> + * =40dev: device for clock =22consumer=22
> + * =40clks: pointer to the clk_bulk_data table of consumer
> + *
> + * Returns success (0) or negative errno.
> + *
> + * This helper function allows drivers to get several clk
> + * consumers and enable all of them in one operation with management.
> + * The clks will automatically be disabled and freed when the device
> + * is unbound.
> + */
> +
> +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> +					      struct clk_bulk_data **clks);
> +
>  /**
>   * devm_clk_get - lookup and obtain a managed reference to a clock
> producer.
>   * =40dev: device for clock =22consumer=22
> =40=40 -960,6 +977,13 =40=40 static inline int __must_check
> devm_clk_bulk_get_all(struct device *dev,
>  	return 0;
>  =7D
>=20
> +static inline int __must_check devm_clk_bulk_get_all_enable(struct devic=
e
> *dev,
> +						struct clk_bulk_data **clks)
> +=7B
> +
> +	return 0;
> +=7D
> +
>  static inline struct clk *devm_get_clk_from_child(struct device *dev,
>  				struct device_node *np, const char *con_id)
> =7B
> --
> 2.17.1



