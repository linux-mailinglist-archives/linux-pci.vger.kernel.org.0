Return-Path: <linux-pci+bounces-28487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FAEAC60E3
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657C71BA68D1
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BB31F3BAB;
	Wed, 28 May 2025 04:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Yona9kOw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016431F1905
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407975; cv=none; b=rh4cc+1H3u3ZZvpt2ld7/RkGcMTfMzRuJI2g6kvgjSfT0cuXlFOA6bDbpsk/9nkUyIWXmldrzl3F4W9VrV3U48+hKLQPQ2i2R5c3k6zS/vE8hWQZaadO6U8p/jLJo2LTVawbdqHtAEcR1h12a3U9bCP/gSS2Bq8VNtY1YxZ9MYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407975; c=relaxed/simple;
	bh=chpPkjGBHsF1rawZaxDr/Kmqc581yTNojlqsCDk5+Wg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=CCDbnYpoNcuS7LoMj8gawCbbNDp/pbbMOWfflmAhRLVBROHBPG1Cp33MBatRnlkUIcjCvPTie7o6F/N+lJcFDhv0N+38W6BRzYlcSu9ZFKzyMo2hS7M30Q2xL7lVAppmLsPx1bSO8n1j5i2FG7lVd0rYk6zUaHavl1+q2c15z4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Yona9kOw; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250528045252epoutp01b8d0e70d15d7629d12faf740f45fd4d3~Dl8maEnJ73110731107epoutp01k
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:52:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250528045252epoutp01b8d0e70d15d7629d12faf740f45fd4d3~Dl8maEnJ73110731107epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748407972;
	bh=U83q4TToxT2dLPTnjUMvyipfG7vxWpSM/Xy4BogwD50=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Yona9kOwXnnHmYNWwO7kGy5GnQa2Nb5V7JUJ+mzvkFsuUjjbQK/DfyajYOeKFMZgl
	 X7UuIwrkYQxV9rMcttsWxyJta4GDUhN2nCbc9iOMKaZrShHmSXSOVhCwtsNqkjAPFQ
	 QHsCOv09KwDqIIQ+yJiT2irIPst/0uo4fnFVLfBQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250528045251epcas5p37228d43c995988ca4594d59a3364d287~Dl8llKL4N1435114351epcas5p3_;
	Wed, 28 May 2025 04:52:51 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.175]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b6cZ86rQsz6B9m5; Wed, 28 May
	2025 04:52:48 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250527104402epcas5p25412c8db4f4408c9306253aee970b99d~DXF67b4Ey0603206032epcas5p2H;
	Tue, 27 May 2025 10:44:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527104402epsmtrp2eda0d810ba7f1e069366fbf77cc1cea0~DXF66JL8s3025330253epsmtrp2K;
	Tue, 27 May 2025 10:44:02 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-49-683597722900
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3F.24.08766.27795386; Tue, 27 May 2025 19:44:02 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104359epsmtip2b424b14cc99129bce93c32001ecb90f8~DXF398JWP3242432424epsmtip2T;
	Tue, 27 May 2025 10:43:58 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.or>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>, "'Pankaj Dubey'"
	<pankaj.dubey@samsung.com>
In-Reply-To: <20250521-cheerful-spiked-mackerel-ef7ade@kuoka>
Subject: RE: [PATCH 04/10] PCI: exynos: Add platform device private data
Date: Tue, 27 May 2025 16:13:58 +0530
Message-ID: <0e2301dbcef4$42969af0$c7c3d0d0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gIYYP2wAv7F/dIBkV9JfLIyj0bg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRmVeSWpSXmKPExsWy7bCSvG7RdNMMg3U3OC0ezNvGZvF30jF2
	iyVNGRZr9p5jsph/5ByrxY1fbawWK77MZLc42vqf2eLlrHtsFufPb2C3aOj5zWqx6fE1VovL
	u+awWZydd5zNYsKqbywWZ78vYLJo+dPCYrH2yF12i7stnawWi7Z+Ybf4v2cHu8XOOyeYHcQ8
	fv+axOixc9Zddo8Fm0o9Nq3qZPO4c20Pm8eTK9OZPDYvqffo27KK0ePI1+ksHp83yQVwRXHZ
	pKTmZJalFunbJXBlLDmzg7FgkXTFvgPt7A2MW8S6GDk5JARMJD4smMHWxcjFISSwm1Hi3fwe
	VoiEpMTni+uYIGxhiZX/nrNDFD1jlNjfcY8ZJMEmoCPx5MofMFtEQFdi843lYEXMAs9YJPYu
	eMAK0fGGUeL+1vlADgcHp4CtxKbjsiANwgIeEsvmnmMDsVkEVCX6pu1jBLF5BSwlrn76ywJh
	C0qcnPkEzGYW0JbofdjKCGMvW/iaGeI6BYmfT5exQhzhJnFt1R12iBpxiaM/e5gnMArPQjJq
	FpJRs5CMmoWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOCUoKW5g3H7qg96
	hxiZOBgPMUpwMCuJ8G6bYJIhxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6Yklqdmpq
	QWoRTJaJg1OqgUngVt/d2udmhk2hmRr779hvmKOy/uLlW42+OpMU3vLbJM6+xl47pfOytslx
	843/K7J9L86vj1YXDimsOuX1N96h6ySf10GFBfZWa2vDV8RxLPRZ/ePFIRfJP5/T7VSmvWbV
	/aAfOG/u1IMlF8/X3L8065XHnD1y7sYOaxUKVz9JMd36zIGPYbNeQ6eWWN+08GfPMhc8u3p6
	Wdr8y1Xb9GOYLnJt3MA7oWI+Z7XNzfePCw9eFsswuDg1Xvmwp66NzHvxFNcOC6HwaRzv7G+b
	K8T51touPhzGHXCcW3CJVWnCmn1Gdw3a3xjfLwi23MI4cd6ilPmGR1TC+h8+F49cnnT6WYpT
	yHLe7H+/tsTrcimxFGckGmoxFxUnAgBmLNE7eAMAAA==
X-CMS-MailID: 20250527104402epcas5p25412c8db4f4408c9306253aee970b99d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193239epcas5p4cb4112382560f38ad9708e000eb2335f
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193239epcas5p4cb4112382560f38ad9708e000eb2335f@epcas5p4.samsung.com>
	<20250518193152.63476-5-shradha.t@samsung.com>
	<20250521-cheerful-spiked-mackerel-ef7ade@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 21 May 2025 15:15
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-=
kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.or;
> linux-kernel=40vger.kernel.org; linux-phy=40lists.infradead.org; manivann=
an.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=40gm=
ail.com; krzk+dt=40kernel.org; conor+dt=40kernel.org;
> alim.akhtar=40samsung.com; vkoul=40kernel.org; kishon=40kernel.org; arnd=
=40arndb.de; m.szyprowski=40samsung.com;
> jh80.chung=40samsung.com; Pankaj Dubey <pankaj.dubey=40samsung.com>
> Subject: Re: =5BPATCH 04/10=5D PCI: exynos: Add platform device private d=
ata
>=20
> On Mon, May 19, 2025 at 01:01:46AM GMT, Shradha Todi wrote:
> > -static const struct dw_pcie_ops dw_pcie_ops =3D =7B
> > +static const struct dw_pcie_ops exynos_dw_pcie_ops =3D =7B
> >  	.read_dbi =3D exynos_pcie_read_dbi,
> >  	.write_dbi =3D exynos_pcie_write_dbi,
> >  	.link_up =3D exynos_pcie_link_up,
> > =40=40 -279,6 +286,7 =40=40 static int exynos_pcie_probe(struct
> > platform_device *pdev)  =7B
> >  	struct device *dev =3D &pdev->dev;
> >  	struct exynos_pcie *ep;
> > +	const struct samsung_pcie_pdata *pdata;
> >  	struct device_node *np =3D dev->of_node;
> >  	int ret;
> >
> > =40=40 -286,8 +294,11 =40=40 static int exynos_pcie_probe(struct platfo=
rm_device *pdev)
> >  	if (=21ep)
> >  		return -ENOMEM;
> >
> > +	pdata =3D of_device_get_match_data(dev);
> > +
> > +	ep->pdata =3D pdata;
> >  	ep->pci.dev =3D dev;
> > -	ep->pci.ops =3D &dw_pcie_ops;
> > +	ep->pci.ops =3D pdata->dwc_ops;
> >
> >  	ep->phy =3D devm_of_phy_get(dev, np, NULL);
> >  	if (IS_ERR(ep->phy))
> > =40=40 -363,9 +374,9 =40=40 static int exynos_pcie_resume_noirq(struct =
device *dev)
> >  		return ret;
> >
> >  	/* exynos_pcie_host_init controls ep->phy */
> > -	exynos_pcie_host_init(pp);
> > +	ep->pdata->host_ops->init(pp);
> >  	dw_pcie_setup_rc(pp);
> > -	exynos_pcie_start_link(pci);
> > +	ep->pdata->dwc_ops->start_link(pci);
>=20
> One more layer of indirection.
>=20
> Read:
> https://lore.kernel.org/all/CAL_JsqJgaeOcnUzw+rUF2yO4hQYCdZYssjxHzrDvvHGJ=
imrASA=40mail.gmail.com/
>=20

I went through this thread and the solution to avoid redirection seems to b=
e:
1. Make the common parts into a library that each driver can call
2. When there is barely anything in common, make a separate driver

=46rom my understanding of these 2 drivers, there is hardly anything that c=
an go into common library
1. host_init, dbi_read, dbi_write these ops have completely different flow
2. link_up, start_link have similar flow but different register offsets
3. write_dbi2 and stop_link is not implemented for exynos but needed for FS=
D
4. Resources are different - FSD does not have regulator, Exynos5433 does n=
ot have syscon, FSD has msi IRQ vs exynos5433 has legacy
5. Exynos is host only whereas FSD is dual mode controller.

I don=E2=80=99t=20see=20any=20other=20way=20except=20redirection,=20or=20us=
ing=20lots=20of=20if(variant=20=3D=3D=20FSD)=20which=20is=20also=20discoura=
ged.=0D=0A=0D=0AAnd=20about=20making=20it=20a=20different=20driver=20altoge=
ther,=20I'm=20completely=20okay=20to=20do=20so.=20In=20fact=20we=20had=20pr=
eviously=20tried=20to=20post=20it=20as=20a=0D=0Adifferent=20driver=20which=
=20was=20rejected.=0D=0A=0D=0AIf=20you=20still=20feel=20there=20is=20a=20wa=
y=20to=20separate=20out=20the=20common=20parts=20into=20a=20library,=20plea=
se=20guide=20me.=0D=0A=0D=0A>=20Best=20regards,=0D=0A>=20Krzysztof=0D=0A=0D=
=0A=0D=0A

