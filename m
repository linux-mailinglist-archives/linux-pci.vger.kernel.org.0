Return-Path: <linux-pci+bounces-28676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71EAC7FE5
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 16:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766CD4E7C70
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F2222B598;
	Thu, 29 May 2025 14:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lsIxr1nT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDC81DFE22
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748530203; cv=none; b=SGpg9DU6R7VzY5tiFFzQhmUYHPYpl8ems3Pexh2sTgk5PxbYFzyhcHOcAdFAtcmNWPXAx/cbeE7OF1Tu4+gkdDuPWO5EMKsapsk0EUPWx+kQTzqzskIUQRBYOPA8i3MlXBprKVp5ldP66mqPq0sLycUTXeIDiYPN1/ArKOmQsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748530203; c=relaxed/simple;
	bh=mBxBS+F3w/cyhjrDcqffZ7kyoE4diOtuM+0VdOkSmnI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=FpHY/8R96/DIG4kbnEq4m1JCJSLdWGwJxtlI8VU442sHqwpKe4/iBcTL6HZr5Io44wwoDvJpSMhpDU6+Qmh0oa/CiXEJptucFn+C1EEwrESQvv0/iOKtOa0kELp8C2IUu+Gki7W8y4ucotmwOHibEzziMJOhQR6TYssKlZoLdyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lsIxr1nT; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250529144958epoutp0474b03475639085f5067a04b57c9bda51~EBvOMT3NS2549525495epoutp04q
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 14:49:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250529144958epoutp0474b03475639085f5067a04b57c9bda51~EBvOMT3NS2549525495epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1748530198;
	bh=JoVIT/YoibxB9MFqaRb9BAFdhMoHeYYoqYbA3YWaDwU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lsIxr1nT8d5gNFvvbFGbztnByv7dD3G0rMX/e5CCROqdCLNOYj97ql/jSZ/zMuM8N
	 vYzJ9/UHxwl4qOQN1q9djKaM9KMZPId/oy3NkURzKFHumIu/jUFYUaVd+0jEpYJq1A
	 oqW62/XHL8f14ceLQhrV+wvGGIdkQCMll60WGd3A=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250529144957epcas5p121ac1b2643ce23abb26c0448e1a0d2f6~EBvNmI7t03174131741epcas5p1v;
	Thu, 29 May 2025 14:49:57 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.182]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b7Tmh2V00z2SSKX; Thu, 29 May
	2025 14:49:56 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250529102448epcas5p1a8209b6700e2206c3bbb6669f473b28b~D_Hs54RNZ1678116781epcas5p1m;
	Thu, 29 May 2025 10:24:48 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250529102448epsmtrp2ae0261061f58b804d19887addb119fa9~D_Hs4qBBk2330423304epsmtrp2h;
	Thu, 29 May 2025 10:24:48 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-c2-683835f012c1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9D.C8.08766.0F538386; Thu, 29 May 2025 19:24:48 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250529102445epsmtip1d9de3beca2d4560f1d5e428ba1253ead~D_Hp7hmwq1925019250epsmtip1K;
	Thu, 29 May 2025 10:24:45 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-phy@lists.infradead.org>, <manivannan.sadhasivam@linaro.org>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <alim.akhtar@samsung.com>, <vkoul@kernel.org>,
	<kishon@kernel.org>, <arnd@arndb.de>, <m.szyprowski@samsung.com>,
	<jh80.chung@samsung.com>, "'Pankaj Dubey'" <pankaj.dubey@samsung.com>,
	<linux-samsung-soc@vger.kernel.org>
In-Reply-To: <441dd5c3-fd51-4471-86ad-337c646b1571@kernel.org>
Subject: RE: [PATCH 09/10] PCI: exynos: Add support for Tesla FSD SoC
Date: Thu, 29 May 2025 15:54:43 +0530
Message-ID: <0eec01dbd083$e78c8200$b6a58600$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKa2HaEso6x90WQFKmaYw3pYxuT6gLGtKN5Ag2CUBUBvBCtGwIQCop6Ao3fESGyEeNtsA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGec85O+dstDrOcO9KLBZJWlpCyRsM7aJw0ko/REUSOd3BlU7H
	zjSNJDWtlOxihjlETeziulBTl9YaOdMuVnZZSzA1aaUh1VJLNM3YVuC3HzzP7+H/4U/jkgFi
	Eb0/Xc/p0pVpclJEmNvlASGudUi95va4H/pQbSbRTFknheoL1Oj6/RcYqnn4QoB6po4J0NXx
	Sgp1FM3i6Iuhn0Td3bcolHfytwCZPjoE6M3dKhI9r35EojPGXwS60G3FUOF0IYFuPOyjUF9h
	sQDVNY9TaNbSQqHW94/xDX7s76kywLYa+ii21pTJmozFJPveYSFZp70CYxvrj7CnmoyAHTMF
	xAv3iBQqLm1/FqdbHZEoUjtOx2knArJLnSNkHrgrKwFCGjJr4bu6m1gJENES5h6Az4oGSG8g
	g2Ov3IGbfWHDnyHKW/oMYFd7v6dEMqug0z6Nu3khEwIbe654SjgzREDrmAt4jW4MdhbbBSWA
	poVMBHzyYJlb8GWiYUvXd49MMMuhreaiZ1TMrIdteRW4l33gk0on4WacWQlLB4vAf758cQT3
	XrcUTn66LPAesRPmN1b860thx+RJ/AzwNcyZMsyZMsyZMsxRagFhBDJOy2tSNHyYNiydOxjK
	KzV8ZnpKaHKGxgQ8PxAc1ALuGF2hNoDRwAYgjcsXigsiw9USsUqZc4jTZezTZaZxvA0spgm5
	VCwdLlVJmBSlnkvlOC2n+59itHBRHlZYbtG3S3+Ex1wZ6Ih++e2lYtYa/NwvNilAseNeSw4n
	O26tTOKzirD7GzcnB36Nm/dz9KMttcpfYg1ZGjhfZWZiLRPnQ8RxSV8cq/tikl25raiVmSi2
	97ADdr+uyAZqWwE++cbYuQsGrdk5tLXu4Hjidr1w+NKFTYNNk8j/m2M368JywIKnETGfm5xV
	CTWVfG/sgw5aH2pcIYoa9RnZ/srnz0RYUJklunzLXtyyuFfaXp+x/rEqkkvonVl3wphimcqt
	YdncEplqZNe5a6m2w5Hx2QVtoqizanPQYNSnLp867YFmujY83/xayYwqkKytvFxxNLt3eMlb
	TqDZLCd4tTIsGNfxyr95fT+4cgMAAA==
X-CMS-MailID: 20250529102448epcas5p1a8209b6700e2206c3bbb6669f473b28b
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
	<0e2801dbcef4$78fe5ec0$6afb1c40$@samsung.com>
	<441dd5c3-fd51-4471-86ad-337c646b1571@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 28 May 2025 12:56
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-arm-=
kernel=40lists.infradead.org;
> linux-samsung-soc=40vger.kernel.or; linux-kernel=40vger.kernel.org; linux=
-phy=40lists.infradead.org;
> manivannan.sadhasivam=40linaro.org; lpieralisi=40kernel.org; kw=40linux.c=
om; robh=40kernel.org;
> bhelgaas=40google.com; jingoohan1=40gmail.com; krzk+dt=40kernel.org; cono=
r+dt=40kernel.org;
> alim.akhtar=40samsung.com; vkoul=40kernel.org; kishon=40kernel.org; arnd=
=40arndb.de;
> m.szyprowski=40samsung.com; jh80.chung=40samsung.com
> Subject: Re: =5BPATCH 09/10=5D PCI: exynos: Add support for Tesla FSD SoC
>=20
> On 27/05/2025 12:45, Shradha Todi wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk=40kernel.org>
> >> Sent: 21 May 2025 15:18
> >> To: Shradha Todi <shradha.t=40samsung.com>
> >> Cc: linux-pci=40vger.kernel.org; devicetree=40vger.kernel.org; linux-a=
rm-kernel=40lists.infradead.org;
> linux-samsung-soc=40vger.kernel.or;
> >> linux-kernel=40vger.kernel.org; linux-phy=40lists.infradead.org; maniv=
annan.sadhasivam=40linaro.org;
> lpieralisi=40kernel.org;
> >> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=
=40gmail.com;
> krzk+dt=40kernel.org; conor+dt=40kernel.org;
> >> alim.akhtar=40samsung.com; vkoul=40kernel.org; kishon=40kernel.org; ar=
nd=40arndb.de;
> m.szyprowski=40samsung.com;
> >> jh80.chung=40samsung.com
> >> Subject: Re: =5BPATCH 09/10=5D PCI: exynos: Add support for Tesla FSD =
SoC
> >>
> >> On Mon, May 19, 2025 at 01:01:51AM GMT, Shradha Todi wrote:
> >>>  static int exynos_pcie_probe(struct platform_device *pdev)  =7B
> >>>  	struct device *dev =3D &pdev->dev;
> >>> =40=40 -355,6 +578,26 =40=40 static int exynos_pcie_probe(struct plat=
form_device *pdev)
> >>>  	if (IS_ERR(ep->phy))
> >>>  		return PTR_ERR(ep->phy);
> >>>
> >>> +	if (ep->pdata->soc_variant =3D=3D FSD) =7B
> >>> +		ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> >>> +		if (ret)
> >>> +			return ret;
> >>> +
> >>> +		ep->sysreg =3D syscon_regmap_lookup_by_phandle(dev->of_node,
> >>> +				=22samsung,syscon-pcie=22);
> >>> +		if (IS_ERR(ep->sysreg)) =7B
> >>> +			dev_err(dev, =22sysreg regmap lookup failed.=5Cn=22);
> >>> +			return PTR_ERR(ep->sysreg);
> >>> +		=7D
> >>> +
> >>> +		ret =3D of_property_read_u32_index(dev->of_node, =22samsung,syscon=
-pcie=22, 1,
> >>> +						 &ep->sysreg_offset);
> >>> +		if (ret) =7B
> >>> +			dev_err(dev, =22couldn't get the register offset for syscon=21=5C=
n=22);
> >>
> >> So all MMIO will go via syscon? I am pretty close to NAKing all this, =
but let's be sure that I got it right
> - please post your complete DTS
> >> for upstream. That's a requirement from me for any samsung drivers - I=
 don't want to support fake,
> broken downstream solutions
> >> (based on multiple past submissions).
> >>
> >
> > By all MMIO do you mean DBI read/write? The FSD hardware architecture i=
s such that the
> > DBI/ATU/DMA address is at the same offset.
> > The syscon register holds the upper bits of the actual address differen=
tiating between these 3
> > spaces. This kind of implementation was done
> > to reduce address space for PCI DWC controller. So yes, each DBI/ATU re=
gister read/write will have
> > syscon write before it to switch address space.
>=20
> Wrap your replies correctly to fit mailing list.
>=20
> No, I meant your binding does not define any MMIO at all. I see you use
> for example elbi_base which is mapped from =22elbi=22 reg entry, but you =
do
> not have it in your binding.
>=20
> Maybe just binding is heavily incomplete and that confused me.
>=20

Got it. I think the confusion is due to the incomplete dt-bindings.
I will fix these issues in the next version. Will post again once I get
clarity about how to avoid redirection in patch 4/10

> Best regards,
> Krzysztof


