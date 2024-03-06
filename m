Return-Path: <linux-pci+bounces-4572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879CA873618
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 13:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDBD1C20A05
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 12:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103DA7FBD9;
	Wed,  6 Mar 2024 12:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bhDodZOL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79C1426B
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 12:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727204; cv=none; b=dHf0zBEJyzyyTKJv8sLF/TepQYe4Hy7qE0tq434pLchxHLpfxn/JzEVJ9Ej+QKmEoW02V+b0HfZjPnO7GTb02IwXWWPL7VOmXgHkzN0Q79XacwtMvLolmZu5Gs/UypTjSRsW4c3bzj319vuFKUqmOvDqNi9IllZftwLXXMOYq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727204; c=relaxed/simple;
	bh=MvQWTMYzbR7pSSNPtXrU0pZYKoIJ+SgRUhNdIt6jGjg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=MsvXdJ3OjzdITpXccYmTIwL6rC9QAsTji8eOnWN2hYeVLuQeD064aY0EK6zAg15UxPcil30MYiavzi1LxqDFsOiSYL8ZE9oz93YI2Ufl7MHqwI+v6vSRSYIaYWDGb+WoXJ9D90QAeFTPvALvPmIgzMpaw87d1/fpvaFG9dFnzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bhDodZOL; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240306121318epoutp01496b10f78084117cfa7256656c44e2df~6K9QwPT9Y1207212072epoutp01b
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 12:13:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240306121318epoutp01496b10f78084117cfa7256656c44e2df~6K9QwPT9Y1207212072epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1709727198;
	bh=WTQ15VypupqP8VXJmmdKI+HBcUQn7Q0FdOahxVlCL5Q=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=bhDodZOL5GHRl6QNmRlQvbmmZ8mxapoCFy7ev0q1057BdCSiTV6exNPL9FjMuaTWT
	 PRn2744KUFFmWRmmffLSihx1+AqnHoHA/TK1FnNDWPjy6Ir7BaXAv/nk6zdH/ZVUPP
	 U+hK+4+L2AOPoV4DyHiV35SAlS+hPEgaAbZBHtas=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240306121318epcas5p46d8921f3096590ae7e8b27e08f1f0a0e~6K9QQ5BhA2378723787epcas5p4E;
	Wed,  6 Mar 2024 12:13:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TqWY84pFhz4x9Pv; Wed,  6 Mar
	2024 12:13:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E0.62.09634.CDD58E56; Wed,  6 Mar 2024 21:13:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240306121316epcas5p2dd93d2a62d83e2bae45ef4fcfb7362f5~6K9OKiGjh1360113601epcas5p2_;
	Wed,  6 Mar 2024 12:13:16 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240306121316epsmtrp17a3a8dcd902734f3b463752b5ef267a5~6K9OJjFBD1302513025epsmtrp1g;
	Wed,  6 Mar 2024 12:13:16 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-af-65e85ddc69fc
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.63.08817.BDD58E56; Wed,  6 Mar 2024 21:13:15 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240306121311epsmtip1a9216d1eb53f803e079c054ed232e15a~6K9J5QBtm2312523125epsmtip1O;
	Wed,  6 Mar 2024 12:13:11 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Dan Carpenter'" <dan.carpenter@linaro.org>
Cc: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <mturquette@baylibre.com>,
	<sboyd@kernel.org>, <jingoohan1@gmail.com>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
	<krzysztof.kozlowski@linaro.org>, <alim.akhtar@samsung.com>,
	<linux@armlinux.org.uk>, <m.szyprowski@samsung.com>,
	<manivannan.sadhasivam@linaro.org>, <pankaj.dubey@samsung.com>,
	<gost.dev@samsung.com>
In-Reply-To: <f00eed31-4baf-4d5c-934d-8223d1ab554d@moroto.mountain>
Subject: RE: [PATCH v6 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Date: Wed, 6 Mar 2024 17:43:03 +0530
Message-ID: <022301da6fbf$aae4f7e0$00aee7a0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH2hJCcwYDjJDqbclltz640cKP7jQL/AcmgAaOboDkDexFUCLCxgc9A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0xTVxjN62v7CoPxBhguxG317UeECbSjhcsi4AKaN6YGsjgXg6lv8GyR
	/lp/6GAkIKEykK1ixkYLVNDGAIYRWioUYbDiYHNBZUA3MiA4cEOJAxRMQHFreXXjv/N995yc
	73z3Xh4avMyN4OUqdbRGSckJrj/76kBkZPTk0XlacPcOH85YrnKhtUQGlywGDE70O1mwacWE
	wd4FBwaLK59woG3WzYHLldMcONpdx4XDliEurLn1HQu6qnsRWPq0lA1br09hcKq0nANHbuyF
	Fx0rGPynpwuDz9zt7D2h5Kh7BCUXfzNgpNM8hZENNj1paynnkpPuHi45N/YNi7Rbi8gvO1oQ
	8pHtlQz/I3m7ZTSVQ2v4tDJblZOrlCYR738gSZWI4wXCaGEiTCD4SkpBJxFp+zOi9+XKPeEI
	/klKrve0MiitlohN3q1R6XU0X6bS6pIIWp0jV4vUMVpKodUrpTFKWveOUCB4W+whHsuT2S58
	rJ4P+bT7tAUtRlaDKhA/HsBFoHn2K3YF4s8Lxq8hoOFsGcYUDxHwc1UXhykeI+D7v43s55K1
	y4u+g14EjN+5wmWKeQTc6h/GvCwuvgvMjT1FvTgUF4AldzvqJaF4PRv0j5dvkvzwVPCnu4nl
	xSH4YVC2+JDrxWz8ddBq79jsB+KJoH71Dw6DXwI/meY2x0DxV0HngzqUGYkP1u5e5jBm+4DF
	8S2L4YSBH9YqN40BXusHnH3TLEaQBn6/edEnDgH3hzowBkeAe8YzPiwFzfYaH0cOHtutPm0K
	6B+r8wzB8xhEgrbuWMbrRfDFkzmWtw3wQPD5mWCG/RpY2ejxbS4cWAZHOQwmQe3GDewcssO8
	JZl5SzLzlgTm/80aEHYLEk6rtQoprRWrhUr61H8Xnq1S2JDNtx/1XhcyNbMU40JYPMSFAB5K
	hAYWrs/RwYE5VH4BrVFJNHo5rXUhYs+6q9CIbdkqz+dR6iRCUaJAFB8fL0qMixcSYYELhvqc
	YFxK6eg8mlbTmuc6Fs8vopjlPN7X112AlvwSjpvpo9d3haVY9oObhfnOKKNpo3P2XfbJ9MHC
	9pS4rimVZEhITBgPH7p/ujFoukK7ai9q+pHq3xZq7UytPhBRf2xHQkl6QBhbVyh6OXln821F
	46meRiuYyBJHG4ySQ1X2EEf6lemeIwS8ECA9aN3eNqCJTB8OeqFWWBWwvpxlGHkjoywzzDEt
	1H8ofrNlT2HsbSz2gOlE3M7M85c4Q/L8kYTt6WnrJ/aeXVgrMznvXUpx9ZpnDraajhuanpFZ
	mX99Nrlh/JpnbnRzEmHRR82DKnoypIR6q3Rko616dgzrcP06sGyihbJrDx4ln3dwxj/JVBTM
	1hBsrYwSRqEaLfUvVaqDpYQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7bCSnO7t2BepBlN7LSwezNvGZrGkKcPi
	w7xWdoubB3YyWaz4MpPdYu/rrewWDT2/WS02Pb7GavGx5x6rxeVdc9gszs47zmYx4/w+JotD
	U/cyWrT8aWGxWHvkLrvF3ZZOVouLp1wtFm39wm7xf88Odot/1zayOIh4XL52kdnj/Y1Wdo+d
	s+6yeyzYVOqxaVUnm8eda3vYPJ5cmc7ksXlJvUffllWMHp83yQVwRXHZpKTmZJalFunbJXBl
	bJqfVPBCuGJX4zzmBsav/F2MnBwSAiYSP5e9Z+1i5OIQEtjNKLFuyS0miISkxOeL66BsYYmV
	/56zg9hCAs8YJe7/UQSx2QR0JJ5c+cMMYosIGEh8uLaRGWQQs8BGFok5n/awQEz9xCjxs2kt
	I0gVp4CzxLNrK8CmCguESnRN2QI2lUVARWLt5i1gcV4BS4m5Xx+xQtiCEidnPgEaxAE0VU+i
	bSPYGGYBeYntb+cwQxynIPHz6TJWiCPcJOZthTiaWUBc4ujPHuYJjMKzkEyahTBpFpJJs5B0
	LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERz3Wlo7GPes+qB3iJGJg/EQowQH
	s5IIb82vJ6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeb+97k0REkhPLEnNTk0tSC2CyTJxcEo1
	MKkXvuir5VvLqlqaYK5TfqST/fTc7652zlNPa9Rt9tHxZD/Qvi24fRf37N/6b//8/fjw9cRF
	0tL7+80mXNn6wD/504cd+XE187aIyou/Yfx5i+/qrMn9ApMjZ+o1GUz8WVz1KNV9dqIgJ2NF
	9Kq+qy85w6q2ztymNPtg9Y4LdZuNivqWXl90e2FH+LUfZ8QXRS/b8nZKb/60Lws3xPO+eBvn
	o7//xa6PkziuFM00++L9a6eC5HW3CT/23gizf8Ltsz6Fw+PuA/4+9ewStl1bVYS/e4pdXbUj
	OLSveK6U97qQVYFTroTxcTefORH2cL9idMn0Gf4bV9xQ2nZUSI3F3vF9N+c3lwL7G61zK78p
	BbYosRRnJBpqMRcVJwIAvC2ismoDAAA=
X-CMS-MailID: 20240306121316epcas5p2dd93d2a62d83e2bae45ef4fcfb7362f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c
References: <20240220084046.23786-1-shradha.t@samsung.com>
	<CGME20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c@epcas5p1.samsung.com>
	<20240220084046.23786-2-shradha.t@samsung.com>
	<f00eed31-4baf-4d5c-934d-8223d1ab554d@moroto.mountain>



> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: 05 March 2024 14:20
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-
> soc@vger.kernel.org; mturquette@baylibre.com; sboyd@kernel.org;
> jingoohan1@gmail.com; lpieralisi@kernel.org; kw@linux.com; robh@kernel.org;
> bhelgaas@google.com; krzysztof.kozlowski@linaro.org;
> alim.akhtar@samsung.com; linux@armlinux.org.uk;
> m.szyprowski@samsung.com; manivannan.sadhasivam@linaro.org;
> pankaj.dubey@samsung.com; gost.dev@samsung.com
> Subject: Re: [PATCH v6 1/2] clk: Provide managed helper to get and enable bulk
> clocks
> 
> On Tue, Feb 20, 2024 at 02:10:45PM +0530, Shradha Todi wrote:
> > +int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
> > +					      struct clk_bulk_data **clks) {
> > +	struct clk_bulk_devres *devres;
> > +	int ret;
> > +
> > +	devres = devres_alloc(devm_clk_bulk_release_all_enable,
> > +			      sizeof(*devres), GFP_KERNEL);
> > +	if (!devres)
> > +		return -ENOMEM;
> > +
> > +	ret = clk_bulk_get_all(dev, &devres->clks);
> > +	if (ret > 0) {
> 
> I feel like this should be >= instead of >.  There aren't any callers of this
function
> yet so we can't see what's in *clks at the start but it's easy to imagine a
situation
> where it's bad data.
> 

Reference for this piece of code has been taken from devm_clk_bulk_get_all()
which
has multiple callers, so it's safe. If we make this >=, it will hold on to the
devres node
even though there are no clocks.

> > +		*clks = devres->clks;
> > +		devres->num_clks = ret;
> > +	} else {
> > +		devres_free(devres);
> > +		return ret;
> 
> When clk_bulk_get_all() returns zero then we return success here.
> 

Yes, we are returning success in case there are no clocks as well. In case there
are no
clocks defined in the DT-node, then it is assumed that the driver does not need
any
clock manipulation for driver operation. So the intention here is to continue
without
throwing error.

> regards,
> dan carpenter
> 
> > +	}
> > +
> > +	ret = clk_bulk_prepare_enable(devres->num_clks, *clks);
> > +	if (!ret) {
> > +		devres_add(dev, devres);
> > +	} else {
> > +		clk_bulk_put_all(devres->num_clks, devres->clks);
> > +		devres_free(devres);
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
> > +



