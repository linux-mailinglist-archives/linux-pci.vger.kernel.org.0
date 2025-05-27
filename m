Return-Path: <linux-pci+bounces-28492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D600FAC60F8
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 06:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21674A5129
	for <lists+linux-pci@lfdr.de>; Wed, 28 May 2025 04:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D1B1F4CB8;
	Wed, 28 May 2025 04:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EJrYRTqp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490CD20CCC8
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748408014; cv=none; b=JBrxO4qDuzdehaTZeRpciLSrru6RYi35AgZfRuxh/3VaQ9Ff5LELwR/7bnAQFvnPUn2NJV2SXT4y2Db6B2KliuonC0di46ocS+BHCpDRAIVJZcSh8Z5Xo3ixTWkiJHAc/sarYIRcxEEJV/M8vUOSL6uzr0Cude/aV7e25NJ8h+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748408014; c=relaxed/simple;
	bh=VB3eq3aBNnjKqYRK+RlhX0GF7OHenCwl9MVAsuqjPq4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ZrHvRWdCGabdb7uU117Jb8MjtF34FnMi+0hUlQGIzEroxmnYLVp/aPqcQ3vbs0nKoh8uTYb+dF9oRNRtVBvitSNkW3dT/aBcaRnHF4V/t4me4qmHOjHoJY3ZzRfau5JNjEOVeu1cU7MKaXezUYhGXAgVWkHbEwWMZtKCv9/0V1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EJrYRTqp; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250528045328epoutp0342695dc02cbb1c8ce460b63b08082aa3~Dl9H-8ehc1085510855epoutp03C
	for <linux-pci@vger.kernel.org>; Wed, 28 May 2025 04:53:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250528045328epoutp0342695dc02cbb1c8ce460b63b08082aa3~Dl9H-8ehc1085510855epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748408008;
	bh=FdZF5l83khTomcseO+QoMWKGMiLcHWOd9nqmuhm1swA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=EJrYRTqp/+MYUfnbc2HwU5likBWwHpJ+eK95A9am+3wxwQNbo+QlzgTYFrRz+AhEF
	 fC9lmU0dmVGakWqw9MjJs28kBPCGOpmnHwePuxgH5cnEP4v0fLpy9fGRHVXC+vBjkB
	 f4FhFUAiAyBMz5DEy2bP7cUugUb1sGxieRrjnqVg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250528045327epcas5p355159aadc57fde03a3cb555653fe9bd6~Dl9HZzFwx0196601966epcas5p3-;
	Wed, 28 May 2025 04:53:27 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.182]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4b6cZt1bwDz3hhTR; Wed, 28 May
	2025 04:53:26 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250527104533epcas5p2ce335b06bb6564469fcfd96786de5cbb~DXHP819kQ1647416474epcas5p2I;
	Tue, 27 May 2025 10:45:33 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250527104533epsmtrp298f462a0270bbc1d8cee2dbe97f1a7ae~DXHP6vdyF3064030640epsmtrp2d;
	Tue, 27 May 2025 10:45:33 +0000 (GMT)
X-AuditID: b6c32a29-566fe7000000223e-7b-683597cd959e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C2.54.08766.DC795386; Tue, 27 May 2025 19:45:33 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250527104530epsmtip121c695d30e18eef84fe768e5794ed6fa~DXHNDu7CF0476404764epsmtip1H;
	Tue, 27 May 2025 10:45:30 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.or>,
	<linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alim.akhtar@samsung.com>,
	<vkoul@kernel.org>, <kishon@kernel.org>, <arnd@arndb.de>,
	<m.szyprowski@samsung.com>, <jh80.chung@samsung.com>
In-Reply-To: <20250521-competent-honeybee-of-will-3f3ae1@kuoka>
Subject: RE: [PATCH 09/10] PCI: exynos: Add support for Tesla FSD SoC
Date: Tue, 27 May 2025 16:15:29 +0530
Message-ID: <0e2801dbcef4$78fe5ec0$6afb1c40$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gLGtKN5Ag2CUBUBvBCtG7IzpxAA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWy7bCSnO7Z6aYZBpcuSVk8mLeNzeLvpGPs
	FkuaMizW7D3HZDH/yDlWixu/2lgtVnyZyW5xtPU/s8XLWffYLM6f38Bu0dDzm9Vi0+NrrBaX
	d81hszg77zibxYRV31gszn5fwGTR8qeFxWLtkbvsFndbOlkt/u/ZwW6x884JZgdRj9+/JjF6
	7Jx1l91jwaZSj02rOtk87lzbw+bx5Mp0Jo/NS+o9+rasYvQ48nU6i8fnTXIBXFFcNimpOZll
	qUX6dglcGQcXtTEX7BeueHd1HWsDY6NAFyMHh4SAicTpeaZdjFwcQgK7GSV2H9/H1sXICRSX
	lPh8cR0ThC0ssfLfc3aIomeMEs2fHjKDJNgEdCSeXPkDZosI6EpsvrEcrIhZYDuLxJmlDxkh
	Ot4zSrS2bWEFqeIUsJe4NakXrENYwFVix+n3YDaLgKrE0f3TwFbzClhKtBzbygphC0qcnPmE
	BcRmFtCW6H3YyghjL1v4mhniPAWJn0+XsUJc4SaxYslBqHpxiaM/e5gnMArPQjJqFpJRs5CM
	moWkZQEjyypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k/NxNjOBEoKW5g3H7qg96hxiZOBgP
	MUpwMCuJ8G6bYJIhxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJ
	g1OqgWmnfMa32XIi8zh+mf4yL3j35vz1hfL/Hq3+vzbygrhv/u8ZPSJcH3dqzFy9u+EGA29G
	fef0lfFCxo8m+E1cvsJ7y6Il+7YZNBfPNTb6fvZMluduXUnjusitiouj815NczijP+fhCjOr
	e3e85KQ5HU9esMuxWFxnsD/AuUDzZeEUnhsW05Nv7XFb927nW5VrhfXFM5ZpXE4uM3pky+Ih
	4eh2NDPD5rHPvcRTFbpSyxLPfMrlepDKYd6ek8n18chzCVUug/VLm/bonDtbftK356/5xIOP
	JlpfVLU5arQp4Ub836IWdYOVz968dvVcWcB6Y9eJIx4zbFfOdYmaeelhTMFWnsibk/axbnlu
	O4e99cEbJZbijERDLeai4kQAUGU8LXMDAAA=
X-CMS-MailID: 20250527104533epcas5p2ce335b06bb6564469fcfd96786de5cbb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-541,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046
References: <20250518193152.63476-1-shradha.t@samsung.com>
	<CGME20250518193300epcas5p17e954bb18de9169d65e00501b1dcd046@epcas5p1.samsung.com>
	<20250518193152.63476-10-shradha.t@samsung.com>
	<20250521-competent-honeybee-of-will-3f3ae1@kuoka>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 21 May 2025 15:18
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-=
kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.or;
> linux-kernel=40vger.kernel.org; linux-phy=40lists.infradead.org; manivann=
an.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=40gm=
ail.com; krzk+dt=40kernel.org; conor+dt=40kernel.org;
> alim.akhtar=40samsung.com; vkoul=40kernel.org; kishon=40kernel.org; arnd=
=40arndb.de; m.szyprowski=40samsung.com;
> jh80.chung=40samsung.com
> Subject: Re: =5BPATCH 09/10=5D PCI: exynos: Add support for Tesla FSD SoC
>=20
> On Mon, May 19, 2025 at 01:01:51AM GMT, Shradha Todi wrote:
> >  static int exynos_pcie_probe(struct platform_device *pdev)  =7B
> >  	struct device *dev =3D &pdev->dev;
> > =40=40 -355,6 +578,26 =40=40 static int exynos_pcie_probe(struct platfo=
rm_device *pdev)
> >  	if (IS_ERR(ep->phy))
> >  		return PTR_ERR(ep->phy);
> >
> > +	if (ep->pdata->soc_variant =3D=3D FSD) =7B
> > +		ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> > +		if (ret)
> > +			return ret;
> > +
> > +		ep->sysreg =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> > +				=22samsung,syscon-pcie=22);
> > +		if (IS_ERR(ep->sysreg)) =7B
> > +			dev_err(dev, =22sysreg regmap lookup failed.=5Cn=22);
> > +			return PTR_ERR(ep->sysreg);
> > +		=7D
> > +
> > +		ret =3D of_property_read_u32_index(dev->of_node, =22samsung,syscon-p=
cie=22, 1,
> > +						 &ep->sysreg_offset);
> > +		if (ret) =7B
> > +			dev_err(dev, =22couldn't get the register offset for syscon=21=5Cn=
=22);
>=20
> So all MMIO will go via syscon? I am pretty close to NAKing all this, but=
 let's be sure that I got it right - please post your complete DTS
> for upstream. That's a requirement from me for any samsung drivers - I do=
n't want to support fake, broken downstream solutions
> (based on multiple past submissions).
>=20

By all MMIO do you mean DBI read/write? The FSD hardware architecture is su=
ch that the DBI/ATU/DMA address is at the same offset.
The syscon register holds the upper bits of the actual address differentiat=
ing between these 3 spaces. This kind of implementation was done
to reduce address space for PCI DWC controller. So yes, each DBI/ATU regist=
er read/write will have syscon write before it to switch address space.

> Best regards,
> Krzysztof



