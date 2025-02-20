Return-Path: <linux-pci+bounces-21874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B17A3D21E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07DFD189541F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 07:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E011E9B3F;
	Thu, 20 Feb 2025 07:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="f2P2McsZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A745B1E9B3C
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 07:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036155; cv=none; b=lxtSdziZqDGDmLLR6+8dRBZ+POrqS7lWPu+XcXg4bgG1oLuczzQrOlleYz9Sdptgiimz0g4Jeq9k7G+FAH9QViAY0jlWYOfH1VR840a0phOUxcL3eb6BqGNev9sTeA0r0IRQdVJc1usdQVDVyFvw5GHDfRNCjtZH5FC2G2x8zFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036155; c=relaxed/simple;
	bh=RdupzPmikV/P65nVhhGwKWRWthUC+iidk838vqEzQ84=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=mPuGJw1Q74jXxT2ECSGGI0G2B4HC0/NWcb9oBXM4u015mHDIXH9F+EyW3s3wDsVHaiZt0IiMXZUWEgogm6rn93xKXy7EtmaYN8Oz3I4MtCaNCp2G1nc0Vhpv1jZ+QNY7ZIATcW9YPTRQb6VsGixAWAUjHzS6lx1/O0oAB0rOpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=f2P2McsZ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250220072231epoutp027cd3153e666c7674bbdd0cf3ae7cee61~l2ak5nH6L0745907459epoutp02f
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 07:22:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250220072231epoutp027cd3153e666c7674bbdd0cf3ae7cee61~l2ak5nH6L0745907459epoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740036151;
	bh=RdupzPmikV/P65nVhhGwKWRWthUC+iidk838vqEzQ84=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=f2P2McsZ+A9f+D/jhcNNnz8Xtj3NgVgB8/tqX5s84qEfpREN/XAkcAGxbKATZmpkd
	 KrPrakSh4bffOfBKwl/ZcksLMbW9cbG2nHmb/xgeQYRUWKaMq+1zfKy1Ol5PVOftBo
	 ZelX9jVNpAQnnBWwH7FJQN30m3EHlY5qbj0uZBmo=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250220072231epcas5p392bca22d09fed6b3b4da7a65131ba69b~l2akbD6MB1872018720epcas5p3P;
	Thu, 20 Feb 2025 07:22:31 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Yz4Td3GmHz4x9QQ; Thu, 20 Feb
	2025 07:22:29 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	61.08.19710.538D6B76; Thu, 20 Feb 2025 16:22:29 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250220060153epcas5p4f401dbb501378149ed3ef8f162c228a9~l1UKvso6a1980019800epcas5p4M;
	Thu, 20 Feb 2025 06:01:53 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250220060153epsmtrp1167c9903277def94d25e9725d9b4615d~l1UKu7kPm3242832428epsmtrp16;
	Thu, 20 Feb 2025 06:01:53 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-f3-67b6d835ab96
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.C7.18949.155C6B76; Thu, 20 Feb 2025 15:01:53 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250220060151epsmtip2bf3316cff94a9f18d49ac2d7e01b95ef~l1UIrTjn80534005340epsmtip2S;
	Thu, 20 Feb 2025 06:01:51 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: <manivannan.sadhasivam@linaro.org>, "'Shuai Xue'"
	<xueshuai@linux.alibaba.com>, "'Jing Zhang'" <renyu.zj@linux.alibaba.com>,
	"'Will Deacon'" <will@kernel.org>, "'Mark Rutland'" <mark.rutland@arm.com>,
	"'Jingoo Han'" <jingoohan1@gmail.com>, "'Bjorn Helgaas'"
	<bhelgaas@google.com>, "'Lorenzo Pieralisi'" <lpieralisi@kernel.org>,
	=?UTF-8?Q?'Krzysztof_Wilczy=C5=84ski'?= <kw@linux.com>, "'Rob Herring'"
	<robh@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>
In-Reply-To: <20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>
Subject: RE: [PATCH 1/4] perf/dwc_pcie: Move common DWC struct definitions
 to 'pcie-dwc.h'
Date: Thu, 20 Feb 2025 11:31:49 +0530
Message-ID: <02d901db835c$f0710450$d1530cf0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQI3arGx4qNz+c5jkBcOUS0/Rx6ChQIRRsQWAieNK+yydh1aoA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCJsWRmVeSWpSXmKPExsWy7bCmhq7pjW3pBn3/xS2WNGVYrPgyk92i
	oec3q8Wmx9dYLSbuP8tucXnXHDaLs/OOs1lc2bqOxaLlTwuLxd2WTlaLpdcvMlksbH7JaPF/
	zw52i5Y7phbvf25mc+D3WDNvDaPHzll32T0WbCr12LSqk83jzrU9bB47H1p6PLkynclj85J6
	j8+b5AI4o7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0y
	c4CuV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoY
	GJkCFSZkZ/x+uZ2l4LRJxeUt29kbGD8adTFyckgImEi8ad7B1MXIxSEksJtR4vnuU1DOJ0aJ
	llm3WSCcb4wSZw6cZIdp2XnvGFTVXkaJv9OuMIMkhAReMEpcea0CYrMJ6Eg8ufKHGaRIRGAj
	s8T5Y8fZQBxmgQ2MEp8/nmUFqeIUcJKY2v2ODcQWFoiROD3jE9gkFgFViRNvLoGt4xWwlLjy
	dTMjhC0ocXLmExYQm1lAW2LZwtfMECcpSPx8ugxspgjQzBdrdkDViEsc/dkDdoWEwBMOibbW
	bSwQDS4SOzfPYoOwhSVeHd8C9ZuUxMv+Nig7XWLl5hlQC3Ikvm1ewgRh20scuDIHaA4H0AJN
	ifW79CHCshJTT61jgtjLJ9H7+wlUOa/EjnkwtrLEl797oE6QlJh37DLrBEalWUhem4XktVlI
	XpiFsG0BI8sqRsnUguLc9NRk0wLDvNRyeJQn5+duYgQnby2XHYw35v/TO8TIxMF4iFGCg1lJ
	hLetfku6EG9KYmVValF+fFFpTmrxIUZTYHhPZJYSTc4H5o+8knhDE0sDEzMzMxNLYzNDJXHe
	5p0t6UIC6YklqdmpqQWpRTB9TBycUg1Mx6U0v10zYRH/toDHUum1jU9/+dzgnSr7I8oaOv9o
	+WQuWrh7u+WEV8duyy3bdmxC5s2WW0XqDN5zlM6td5Wae906bcW71tzg7oPb3ojncl5uUpa/
	cy2B/Z+hjmZ6lAbDHM4jsUmGHy+IygSVH1LZqL8760rBvFDDjIOtk21+hcwQi0q7vGxL4bPX
	x/bwLlf+pfL5yMp9Zmwr/DgYA6Qyb52rCzjxPft9yrOIjRtkDa3CF7uuO7qdQ9xLI7/kY/Q1
	Bo/FMrf3F32uqO+1+3RWSe1z2+xeod1bOX5km0tJXHz4wHnG7rwZS3Z8XH9m2dWO3zNTFkc/
	nuHJ/uVNIcuKfS6LjW/W7Xe/aFuRLHn6pRJLcUaioRZzUXEiACK7ckdnBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWy7bCSvG7g0W3pBhM2iVgsacqwWPFlJrtF
	Q89vVotNj6+xWkzcf5bd4vKuOWwWZ+cdZ7O4snUdi0XLnxYWi7stnawWS69fZLJY2PyS0eL/
	nh3sFi13TC3e/9zM5sDvsWbeGkaPnbPusnss2FTqsWlVJ5vHnWt72Dx2PrT0eHJlOpPH5iX1
	Hp83yQVwRnHZpKTmZJalFunbJXBl7N/wnLlgvWpF/7N/rA2MF+S6GDk5JARMJHbeO8YEYgsJ
	7GaUWN2sARGXlPh8cR0ThC0ssfLfc/YuRi6gmmeMEptapjCDJNgEdCSeXPkDZosIbGeWOPnN
	B6SIWWALo8S2OZeZITpOMkr8evmADaSKU8BJYmr3OyCbg0NYIEpi6g5vkDCLgKrEiTeX2EFs
	XgFLiStfNzNC2IISJ2c+YQGxmQW0JXoftjLC2MsWvmaGuE5B4ufTZawQRzhJvFizA6peXOLo
	zx7mCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1oDg3PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4
	erW0djDuWfVB7xAjEwfjIUYJDmYlEd62+i3pQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5N
	ERJITyxJzU5NLUgtgskycXBKNTCZKhzaqRm/q0YyxmODf+627kuOohNWL3b1vVPhcv2QSMGu
	R0pOEwqmXiqQ/zXvimznG+WgwGffXJM81qzxnLjnZ5sWo/Ky0g1GWltud/8oUGcLer0gUfH2
	Y/Vkj/g5c3cWS0qu5q8I25HB8/zExYje49e31HUUp+UtWJZuGJu8InyhNcdEoS2h0k8lejas
	X9GXYOMoNt38AsPa3/2nmpRnpHkc3sQs3z7j4Lkg2Qb2Kbl2T/7sW+3BsWmxOvfUG8cWSm5U
	5I7Y8DKuRHluhaWQRzFD9s+rCTpMZo2xzHwl6mVvj/u0/6+aKdHb4xJywT8sosHKPtJ1hv4C
	PwXWTDEOjajn01123jBep/nvmBJLcUaioRZzUXEiAHQICo9NAwAA
X-CMS-MailID: 20250220060153epcas5p4f401dbb501378149ed3ef8f162c228a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250218143703epcas5p2c0b9a60d17e030f7d3ce37c00c9b56ca
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
	<CGME20250218143703epcas5p2c0b9a60d17e030f7d3ce37c00c9b56ca@epcas5p2.samsung.com>
	<20250218-pcie-qcom-ptm-v1-1-16d7e480d73e@linaro.org>



> -----Original Message-----
> From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.l=
inaro.org=40kernel.org>
> Sent: 18 February 2025 20:07
> To: Shuai Xue <xueshuai=40linux.alibaba.com>; Jing Zhang <renyu.zj=40linu=
x.alibaba.com>; Will Deacon <will=40kernel.org>; Mark Rutland
> <mark.rutland=40arm.com>; Jingoo Han <jingoohan1=40gmail.com>; Bjorn Helg=
aas <bhelgaas=40google.com>; Lorenzo Pieralisi
> <lpieralisi=40kernel.org>; Krzysztof Wilczy=C5=84ski=20<kw=40linux.com>;=
=20Rob=20Herring=20<robh=40kernel.org>=0D=0A>=20Cc:=20Shradha=20Todi=20<shr=
adha.t=40samsung.com>;=20linux-kernel=40vger.kernel.org;=20linux-arm-kernel=
=40lists.infradead.org;=20linux-perf-=0D=0A>=20users=40vger.kernel.org;=20l=
inux-pci=40vger.kernel.org;=20linux-arm-msm=40vger.kernel.org;=20Manivannan=
=20Sadhasivam=0D=0A>=20<manivannan.sadhasivam=40linaro.org>=0D=0A>=20Subjec=
t:=20=5BPATCH=201/4=5D=20perf/dwc_pcie:=20Move=20common=20DWC=20struct=20de=
finitions=20to=20'pcie-dwc.h'=0D=0A>=20=0D=0A>=20From:=20Manivannan=20Sadha=
sivam=20<manivannan.sadhasivam=40linaro.org>=0D=0A>=20=0D=0A>=20Since=20the=
se=20are=20common=20to=20all=20Desginware=20PCIe=20IPs,=20move=20them=20to=
=20a=20new=20header,=20'pcie-dwc.h'=20so=20that=20other=20drivers=20could=
=20make=20use=20of=0D=0A>=20them.=0D=0A>=20=0D=0A>=20Signed-off-by:=20Maniv=
annan=20Sadhasivam=20<manivannan.sadhasivam=40linaro.org>=0D=0A>=20---=0D=
=0A>=20=20MAINTAINERS=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=7C=
=20=201=20+=0D=0A>=20=20drivers/perf/dwc_pcie_pmu.c=20=7C=2023=20++--------=
-------------=0D=0A>=20=20include/linux/pcie-dwc.h=20=20=20=20=7C=2034=20++=
++++++++++++++++++++++++++++++++=0D=0A>=20=203=20files=20changed,=2037=20in=
sertions(+),=2021=20deletions(-)=0D=0A>=20=0D=0A>=20diff=20--git=20a/MAINTA=
INERS=20b/MAINTAINERS=0D=0A>=20index=20896a307fa065..b4d09d52a750=20100644=
=0D=0A>=20---=20a/MAINTAINERS=0D=0A>=20+++=20b/MAINTAINERS=0D=0A>=20=40=40=
=20-18123,6=20+18123,7=20=40=40=20S:=09Maintained=0D=0A>=20=20F:=09Document=
ation/devicetree/bindings/pci/snps,dw-pcie-ep.yaml=0D=0A>=20=20F:=09Documen=
tation/devicetree/bindings/pci/snps,dw-pcie.yaml=0D=0A>=20=20F:=09drivers/p=
ci/controller/dwc/*designware*=0D=0A>=20+F:=09include/linux/pcie-dwc.h=0D=
=0A>=20=0D=0A>=20=20PCI=20DRIVER=20FOR=20TI=20DRA7XX/J721E=0D=0A>=20=20M:=
=09Vignesh=20Raghavendra=20<vigneshr=40ti.com>=0D=0A>=20diff=20--git=20a/dr=
ivers/perf/dwc_pcie_pmu.c=20b/drivers/perf/dwc_pcie_pmu.c=20index=20cccecae=
9823f..05b37ea7cf16=20100644=0D=0A>=20---=20a/drivers/perf/dwc_pcie_pmu.c=
=0D=0A>=20+++=20b/drivers/perf/dwc_pcie_pmu.c=0D=0A>=20=40=40=20-13,6=20+13=
,7=20=40=40=0D=0A>=20=20=23include=20<linux/errno.h>=0D=0A>=20=20=23include=
=20<linux/kernel.h>=0D=0A>=20=20=23include=20<linux/list.h>=0D=0A>=20+=23in=
clude=20<linux/pcie-dwc.h>=0D=0A>=20=20=23include=20<linux/perf_event.h>=0D=
=0A>=20=20=23include=20<linux/pci.h>=0D=0A>=20=20=23include=20<linux/platfo=
rm_device.h>=0D=0A>=20=40=40=20-99,26=20+100,6=20=40=40=20struct=20dwc_pcie=
_dev_info=20=7B=0D=0A>=20=20=09struct=20list_head=20dev_node;=0D=0A>=20=20=
=7D;=0D=0A>=20=0D=0A>=20-struct=20dwc_pcie_pmu_vsec_id=20=7B=0D=0A>=20-=09u=
16=20vendor_id;=0D=0A>=20-=09u16=20vsec_id;=0D=0A>=20-=09u8=20vsec_rev;=0D=
=0A>=20-=7D;=0D=0A>=20-=0D=0A>=20-/*=0D=0A>=20-=20*=20VSEC=20IDs=20are=20al=
located=20by=20the=20vendor,=20so=20a=20given=20ID=20may=20mean=20different=
=0D=0A>=20-=20*=20things=20to=20different=20vendors.=20=20See=20PCIe=20r6.0=
,=20sec=207.9.5.2.=0D=0A>=20-=20*/=0D=0A>=20-static=20const=20struct=20dwc_=
pcie_pmu_vsec_id=20dwc_pcie_pmu_vsec_ids=5B=5D=20=3D=20=7B=0D=0A>=20-=09=7B=
=20.vendor_id=20=3D=20PCI_VENDOR_ID_ALIBABA,=0D=0A>=20-=09=20=20.vsec_id=20=
=3D=200x02,=20.vsec_rev=20=3D=200x4=20=7D,=0D=0A>=20-=09=7B=20.vendor_id=20=
=3D=20PCI_VENDOR_ID_AMPERE,=0D=0A>=20-=09=20=20.vsec_id=20=3D=200x02,=20.vs=
ec_rev=20=3D=200x4=20=7D,=0D=0A>=20-=09=7B=20.vendor_id=20=3D=20PCI_VENDOR_=
ID_QCOM,=0D=0A>=20-=09=20=20.vsec_id=20=3D=200x02,=20.vsec_rev=20=3D=200x4=
=20=7D,=0D=0A>=20-=09=7B=7D=20/*=20terminator=20*/=0D=0A>=20-=7D;=0D=0A>=20=
-=0D=0A>=20=20static=20ssize_t=20cpumask_show(struct=20device=20*dev,=0D=0A=
>=20=20=09=09=09=09=09=20struct=20device_attribute=20*attr,=0D=0A>=20=20=09=
=09=09=09=09=20char=20*buf)=0D=0A>=20=40=40=20-529,7=20+510,7=20=40=40=20st=
atic=20void=20dwc_pcie_unregister_pmu(void=20*data)=0D=0A>=20=0D=0A>=20=20s=
tatic=20u16=20dwc_pcie_des_cap(struct=20pci_dev=20*pdev)=20=20=7B=0D=0A>=20=
-=09const=20struct=20dwc_pcie_pmu_vsec_id=20*vid;=0D=0A>=20+=09const=20stru=
ct=20dwc_pcie_vsec_id=20*vid;=0D=0A>=20=20=09u16=20vsec;=0D=0A>=20=20=09u32=
=20val;=0D=0A>=20=0D=0A>=20diff=20--git=20a/include/linux/pcie-dwc.h=20b/in=
clude/linux/pcie-dwc.h=20new=20file=20mode=20100644=20index=20000000000000.=
.261ae11d75a4=0D=0A>=20---=20/dev/null=0D=0A>=20+++=20b/include/linux/pcie-=
dwc.h=0D=0A>=20=40=40=20-0,0=20+1,34=20=40=40=0D=0A>=20+/*=20SPDX-License-I=
dentifier:=20GPL-2.0=20*/=0D=0A>=20+/*=0D=0A>=20+=20*=20Copyright=20(C)=202=
021-2023=20Alibaba=20Inc.=0D=0A>=20+=20*=0D=0A>=20+=20*=20Copyright=202025=
=20Linaro=20Ltd.=0D=0A>=20+=20*=20Author:=20Manivannan=20Sadhasivam=20<mani=
vannan.sadhasivam=40linaro.org>=0D=0A>=20+=20*/=0D=0A>=20+=0D=0A>=20+=23ifn=
def=20LINUX_PCIE_DWC_H=0D=0A>=20+=23define=20LINUX_PCIE_DWC_H=0D=0A>=20+=0D=
=0A>=20+=23include=20<linux/pci_ids.h>=0D=0A>=20+=0D=0A>=20+struct=20dwc_pc=
ie_vsec_id=20=7B=0D=0A>=20+=09u16=20vendor_id;=0D=0A>=20+=09u16=20vsec_id;=
=0D=0A>=20+=09u8=20vsec_rev;=0D=0A>=20+=7D;=0D=0A>=20+=0D=0A>=20+/*=0D=0A>=
=20+=20*=20VSEC=20IDs=20are=20allocated=20by=20the=20vendor,=20so=20a=20giv=
en=20ID=20may=20mean=0D=0A>=20+different=0D=0A>=20+=20*=20things=20to=20dif=
ferent=20vendors.=20=20See=20PCIe=20r6.0,=20sec=207.9.5.2.=0D=0A>=20+=20*/=
=0D=0A>=20+static=20const=20struct=20dwc_pcie_vsec_id=20dwc_pcie_pmu_vsec_i=
ds=5B=5D=20=3D=20=7B=0D=0A=0D=0ARename=20this=20to=20dwc_pcie_rasdes_vsec_i=
ds?=20pmu=20was=20perf=20file=20specific=20but=20technically=20the=20vsec=
=20is=20rasdes.=0D=0A=0D=0A>=20+=09=7B=20.vendor_id=20=3D=20PCI_VENDOR_ID_A=
LIBABA,=0D=0A>=20+=09=20=20.vsec_id=20=3D=200x02,=20.vsec_rev=20=3D=200x4=
=20=7D,=0D=0A>=20+=09=7B=20.vendor_id=20=3D=20PCI_VENDOR_ID_AMPERE,=0D=0A>=
=20+=09=20=20.vsec_id=20=3D=200x02,=20.vsec_rev=20=3D=200x4=20=7D,=0D=0A>=
=20+=09=7B=20.vendor_id=20=3D=20PCI_VENDOR_ID_QCOM,=0D=0A>=20+=09=20=20.vse=
c_id=20=3D=200x02,=20.vsec_rev=20=3D=200x4=20=7D,=0D=0A>=20+=09=7B=7D=20/*=
=20terminator=20*/=0D=0A>=20+=7D;=0D=0A>=20+=0D=0A>=20+=23endif=20/*=20LINU=
X_PCIE_DWC_H=20*/=0D=0A>=20=0D=0A>=20--=0D=0A>=202.25.1=0D=0A>=20=0D=0A=0D=
=0A=0D=0A

