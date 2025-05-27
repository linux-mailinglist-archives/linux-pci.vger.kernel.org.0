Return-Path: <linux-pci+bounces-28488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11794AC60E6
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4EB1BA667E
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD66B1DC997;
	Wed, 28 May 2025 04:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bL2V57wz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071A41F09BF
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748407991; cv=none; b=hFVu1Rvy5JEEjVc3QUXk2FcWxQShMGQQr0GSrQxycWDtjDQBQq/OLOG3ExL9V0UXlwJeEdLJ8ycyNVk3EVSrIL3goSCqF3j2mhFo9o5Nru1rnlhG45/B6heNYACZXs/mc/lmRz0ylcmmxq7byw8TOAEazuW+DRDYzeW8sDq7KFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748407991; c=relaxed/simple;
	bh=V1XcbZPGXAXp6XejwNKhntEAabTvTeXQm7dU+Bp7nuU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ddl/UochEpDAIcO7lPRqSDehndUSVH3CCJaMcDXUp4UmQeeyEI8aOoJ9LrwIc3u5dK1ggMtuqE8b/uVCoqUUoiX3gs9adujcIDRWPwnOcJWHpV0EgdhQ1Cnfei+beDmoEnj72U+5eOR+xuqugrX2ZRp/qIfmhqOInDzDca09GSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bL2V57wz; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250528045308epoutp018252a03261cc0bd35ea8e56d25ea6d48~Dl81S1bla3110531105epoutp01K
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250528045308epoutp018252a03261cc0bd35ea8e56d25ea6d48~Dl81S1bla3110531105epoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748407988;
	bh=hz1HFML4XK8tE1xQaBIm71xwTifq2WWbFnq2f3NNQ0E=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=bL2V57wzOaOrxx/gyWgzW2shDUf6RxqJlGB61pJjo+GUnG6mmBkLneThSuMYo8flY
	 apExJvKmRvnwM4dVlC+SmicyHhIbvQbU/mWeaFSoC//xm6xbYaDTFSi3vqGN84P3oT
	 E8EIaepC/kqDInCWYbbInKaet/wNFFcap7x5zs8E=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250528045307epcas5p1113e1487d13fa5416235b207a856d08e~Dl80pu5tZ2422124221epcas5p1G;
	Wed, 28 May 2025 04:53:07 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.178]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4b6cZV1601z6B9mG; Wed, 28 May
	2025 04:53:06 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250527104410epcas5p1d22eefe556eb86feb2992bb1adfadd45~DXGCbhsaC0535405354epcas5p1Y;
	Tue, 27 May 2025 10:44:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527104410epsmtrp25ea45d14158feda1545913d9812e61d4~DXGCZh-mN3025330253epsmtrp25;
	Tue, 27 May 2025 10:44:10 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-7c-6835977af2eb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.34.08766.A7795386; Tue, 27 May 2025 19:44:10 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104407epsmtip1d156293db8b97e6644aa25fca2b95139~DXF-jWkYy0369003690epsmtip1J;
	Tue, 27 May 2025 10:44:07 +0000 (GMT)
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
In-Reply-To: <20250521-nostalgic-fox-of-valor-f6d725@kuoka>
Subject: RE: [PATCH 05/10] PCI: exynos: Add structure to hold resource
 operations
Date: Tue, 27 May 2025 16:14:06 +0530
Message-ID: <0e2401dbcef4$476ba2a0$d642e7e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gIERDRHAaZvXO0CKPaYJLI5OpqA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG/e+cnZ0NRqdp+S9La1CkNVMw+FdiRphHDCmjoL7Uaic32nRt
	XlKKRpmxMfNopLjURkmXkZrTdOUsmLOL1UIULUzRmuuGUHlJTVttK/Lbw/v+nud9PrwkJnqH
	LycVmdmMJlOqFBMCvKVDHC4pqNgkjym5swgN17QQaL7sMQ/VnpWjO+0uDrrqdHHR69kiLro1
	UclDnee9GPpkGiLQq1d3eUhn/MlF1vd9XNTzoIpAL2ueEIi1TOHo5Q8zBxXOFeKozjnIQ4OF
	ei66dm+Ch7x2Gw/df/sUS1xK/5wtA/R90yCPNltzaKtFT9Bv++wE7e6t4NBNtWfoi80WQDsn
	K3B63Bq+W3BQEC9jlIpcRrMx4bBA/qWexdR64cl613dCB2YEBkCSkIqDXdUqAxCQIqoNwGtj
	LmAA/D/zZXC8u54T0MHw9q8PvADkAZAtv477FgS1Abp75zCfDqEksOn1TT+EUR4ctpuHuQHH
	5z+xHgPho/jUVuitG/C7g6k90DM/7D+HU2tghc7kZ4TUZjjpPQcCejF8VunGfVUxKhoWNfrH
	GBUBW8eqsEC7VXBm9AbXh4RQO2F/018kFHbOGDEWBJsWBJn+B5kWBJkWOMwAt4BljFqrylBp
	Y9WxmUxetFaq0uZkZkQfzVJZgf8NoiJtoNXyNdoBOCRwAEhi4hBhCxsnFwll0vwCRpN1SJOj
	ZLQOEEbi4lBh6MdimYjKkGYzxxlGzWj+bTkkf7mOg+vHWOQW7Sgt3q8IqykvfXOiq02c4Ox5
	l9jYXG8/shkk73Kue2TQHAGR3lykBka2eevAXNlQx+2wUxJbuVr1Irnh6IrubxE65VRlGz9+
	pWLLkynb5enTTUPZdduUEodNHR95RhhecsyRNJt2ZYmyNaZw9fqOpUnjtxzefaHT+4LS082y
	2Bi7xJX/vms+9UCRPeVSylhn/+gJmTQhw/N1fV512reJVSVyo5Plp3eimUpd8d7nQdZw5+qS
	ngK9UVNbWq3wNA9wklIv/5IJNlQl5jc2jAS9MLfvAi2n1ua6R5WfWrOmH0awqXn8549Stv/g
	r93rejNywQGT09dMinGtXBobhWm00t/1KgkCdQMAAA==
X-CMS-MailID: 20250527104410epcas5p1d22eefe556eb86feb2992bb1adfadd45
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193244epcas5p3cacfbdc3b0e5c32f7a4dd97062a931a4
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193244epcas5p3cacfbdc3b0e5c32f7a4dd97062a931a4@epcas5p3.samsung.com>
	<20250518193152.63476-6-shradha.t@samsung.com>
	<20250521-nostalgic-fox-of-valor-f6d725@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 21 May 2025 15:13
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.or;
> linux-kernel@vger.kernel.org; linux-phy@lists.infradead.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> alim.akhtar@samsung.com; vkoul@kernel.org; kishon@kernel.org; arnd@arndb.de; m.szyprowski@samsung.com;
> jh80.chung@samsung.com; Pankaj Dubey <pankaj.dubey@samsung.com>
> Subject: Re: [PATCH 05/10] PCI: exynos: Add structure to hold resource operations
> 
> On Mon, May 19, 2025 at 01:01:47AM GMT, Shradha Todi wrote:
> > +struct samsung_res_ops {
> > +	int (*init_regulator)(struct exynos_pcie *ep);
> > +	irqreturn_t (*pcie_irq_handler)(int irq, void *arg);
> >  };
> >
> >  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
> > @@ -74,6 +81,36 @@ static u32 exynos_pcie_readl(void __iomem *base, u32 reg)
> >  	return readl(base + reg);
> >  }
> >
> > +static int samsung_regulator_enable(struct exynos_pcie *ep) {
> > +	struct device *dev = ep->pci.dev;
> > +	int ret;
> > +
> > +	if (ep->supplies_cnt == 0)
> > +		return 0;
> > +
> > +	ret = devm_regulator_bulk_get(dev, ep->supplies_cnt, ep->supplies);
> 
> No. Getting resources on every enable is making this much less readable.
> 
> NAK
> 

Will make sure that we get the resources only once during probe.

> Best regards,
> Krzysztof



