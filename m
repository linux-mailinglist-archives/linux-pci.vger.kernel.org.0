Return-Path: <linux-pci+bounces-19946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3836A133E4
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 08:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81EB1620BA
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 07:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C38F1DCB0E;
	Thu, 16 Jan 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YjZgMnre"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694FF1DC988
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737012459; cv=none; b=a5d5lCEYZOgVC9mCFpSq62B+jqE+s6rXyhlT/WrBFNVx+Ina8L8lG3Cv/nVkzsZsTVA6aSaX87WJZZnx5znfDXSmZkcROQRsar1ns1rE5xfZOHYh5pMls174OBG8a7D4DX4T8zXl5IGV/iZ8zmcbJpyzw1+buFUWwsrx6+EY+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737012459; c=relaxed/simple;
	bh=em9maLYI4dYvksJEA1F4pj6QX71e4FaG8rVx7EGR3vk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=gG5/oIZwOFj4dYsSYGdD2jl9Vx7zECvxY4Z4y4cDTbdmPcAgjBNXktYoMH4C/B2NWwlj4ZtIHm+BkL6ErXu7a4jzd5ma9ZQYFmib2QwuT+YD9Wi4Lnmzr/i25lq5rQwI7b5mdgfJ8M/9MojB0nN8bYmvo1Z/O/caurje1Kogigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YjZgMnre; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250116072729epoutp04d217e7bac4ca183f7fb49784b385ad6b~bG56K7ls42517925179epoutp04w
	for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 07:27:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250116072729epoutp04d217e7bac4ca183f7fb49784b385ad6b~bG56K7ls42517925179epoutp04w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1737012449;
	bh=Bd/dtSXXAAXUURE4IprsDawIDO27wwgGmm+luW/xpbI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=YjZgMnreWgKVxXR/ZQz3AMsPkCwVjkmnfCxasCqG0vRhGLvO6gzeR4SMxoQlgCOkX
	 ltNm+LNTNOk0wtbV8uS2zrFc/7F4qK406Pf8BGsiVZmWC0l/FBD6wuav8h2izC4G3N
	 mFxmXkYEDd2aDo1mAfeC69WsbKcEchLkjjtmtm24=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250116072728epcas5p28ec71152e7c1ce06668a23af326b9476~bG55nlm5f1991319913epcas5p22;
	Thu, 16 Jan 2025 07:27:28 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YYZFV1xvpz4x9QR; Thu, 16 Jan
	2025 07:27:26 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	88.40.29212.ED4B8876; Thu, 16 Jan 2025 16:27:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250116071227epcas5p4d60f5f7d769b134cebb12d6f965b3ff2~bGsyXERN82913729137epcas5p4P;
	Thu, 16 Jan 2025 07:12:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250116071227epsmtrp1ed049133caee4441246addaa76966826~bGsyV9f7s0982109821epsmtrp1F;
	Thu, 16 Jan 2025 07:12:27 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-40-6788b4dea035
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.67.18729.B51B8876; Thu, 16 Jan 2025 16:12:27 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250116071224epsmtip293ff459ad876448c1619abaed0256fa0~bGswGDv4K1510915109epsmtip29;
	Thu, 16 Jan 2025 07:12:24 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>, "'Bjorn
 Helgaas'" <helgaas@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>,
	<quic_nitegupt@quicinc.com>, <quic_krichai@quicinc.com>,
	<gost.dev@samsung.com>
In-Reply-To: 
Subject: RE: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Date: Thu, 16 Jan 2025 12:42:23 +0530
Message-ID: <00fd01db67e5$ff8c7b50$fea571f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKWsodhYC6NSirBymwM1Ar2SvsMdgIPlXY2AuD9S+YB7UyiObFqhjaggADw8qA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBJsWRmVeSWpSXmKPExsWy7bCmhu69LR3pBt3nuC2mH1a0WNKUYdG0
	+i6rxc0DO5ksXp1Zy2ax4stMdotVC6+xWTT0/Ga1uLxrDpvF2XnH2Sxa/rSwWNxt6WS1WLT1
	C7vFgweVFp1zjjBb/N+zg91BwGPnrLvsHgs2lXq0HHnL6rFpVSebx51re9g8nlyZzuQxcU+d
	R9+WVYwenzfJBXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5
	+AToumXmAL2gpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tL
	LbEyNDAwMgUqTMjO+LtoJmPBOp+KD9NvsTYw7rLpYuTkkBAwkbhwpZOli5GLQ0hgD6PE3hdb
	mCCcT4wSEx89Y4RwvjFK3PxxghGmZem9K6wQib2MEjNeT4ByXjBK/Dv5ggmkik1AR+LJlT/M
	ILaIQJbEr3fn2UCKmAW+MEnsuTgZqIODg1OAV2LCP2sQU1ggUmLZM3aQchYBVYm7X+aBjeEV
	sJTYNPs4C4QtKHFy5hMwm1lAW2LZwtfMEAcpSPx8uowVYpWfRNP2DawQNeISR3/2MIOslRB4
	wyHRt+AI1AcuEhPnnWGBsIUlXh3fwg5hS0m87G+DstMlVm6eAbUgR+Lb5iVMELa9xIErc1hA
	bmYW0JRYv0sfIiwrMfXUOiaIvXwSvb+fQJXzSuyYB2MrS3z5uwdqraTEvGOXWScwKs1C8tos
	JK/NQvLCLIRtCxhZVjFKpRYU56anJpsWGOrmpZbDYzw5P3cTIziJawXsYFy94a/eIUYmDsZD
	jBIczEoivEvYWtOFeFMSK6tSi/Lji0pzUosPMZoCA3wis5Rocj4wj+SVxBuaWBqYmJmZmVga
	mxkqifM272xJFxJITyxJzU5NLUgtgulj4uCUamBK5vd62OxgLfq8xWqpjf2xQxyuXSkKbomd
	xbuO5nv8PHVP7AObfseD5/mFTQJP/klKHeY9ZdFz7ZmuaLjLvN02nSm6dwIMz3AvLTnT8aZ6
	SsWyHK6rvRHC75g7jyZvX/Np7rGAXywb9+dzmTsqc/a/neea3ffmBG/7+ufWwbVW70xjVv55
	v/aTq2wan11E//1fLNr9UVv3hK3bf8vl3n6X5RH/P/19b1NxSDm/ttX7noJIt6f396OiS9Y+
	c/L47ty0z1J067Jsi4fv/Q5Y73PT+pF1ymoet7AVy4sNKt/bntQ7dH/a9PZevcUZ/Yf/elT3
	vnxr8zL3+Bs1aY4L5Yy8C/8/X2s6zfuyhrfiYyclluKMREMt5qLiRAAINq11awQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCSvG70xo50g4k3OS2mH1a0WNKUYdG0
	+i6rxc0DO5ksXp1Zy2ax4stMdotVC6+xWTT0/Ga1uLxrDpvF2XnH2Sxa/rSwWNxt6WS1WLT1
	C7vFgweVFp1zjjBb/N+zg91BwGPnrLvsHgs2lXq0HHnL6rFpVSebx51re9g8nlyZzuQxcU+d
	R9+WVYwenzfJBXBGcdmkpOZklqUW6dslcGU0zFcu2OVdMfXqYfYGxn7rLkZODgkBE4ml966w
	djFycQgJ7GaUWLmynRUiISnx+eI6JghbWGLlv+fsEEXPGCVmTP/PBpJgE9CReHLlD3MXIweH
	iECWxLXjYDXMAk3MErs2vWaGaLjOKNF/5yELSBGnAK/EhH9gm4UFwiVufjnDAmKzCKhK3P0y
	D2wZr4ClxKbZx1kgbEGJkzOfgNnMAtoSvQ9bGWHsZQtB5oMcpyDx8+kysKNFBPwkmrZvYIWo
	EZc4+rOHeQKj8Cwko2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P
	3cQIjmItzR2M21d90DvEyMTBeIhRgoNZSYR3CVtruhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe
	8Re9KUIC6YklqdmpqQWpRTBZJg5OqQYmwXkau76tvrh1i8Fq3+QTgfkyGvt2/PpY8Hl3c9n7
	ZOWgSzcjlkW1TmzNm71/4fVvvFYfzdNCc7W/JhwMuHpR6+r+LwfaFi/yzvF+W/1kR0HpKtkF
	i25y7tQ/pDDzzZmw70v2KPo8FfJcb/3M5VzQD4PZ+SFvz8mxS7+5WybcaXjXa9/Sc1Gi09rv
	q80MUp+55/q8JUd2Bzh/frQ76nPJgm87fPNiljHOcZ/hEhHZP6cjTedA789sxn8xl7lFdp+X
	5VRt3egv6M5yexePxSaHlY1fzjxZY/AucN+aR4b+7bvYZ3u6bKoS0u93v/lP8JP6rApV1vLt
	fp+Xfp6ncT/w2efuPLmeAnEW14KAFBHJn0osxRmJhlrMRcWJAPMdgulRAwAA
X-CMS-MailID: 20250116071227epcas5p4d60f5f7d769b134cebb12d6f965b3ff2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250115163012epcas5p185dd4aebcdf093c2760aadea8480b8a5
References: <20250115152742.yhb57c6cbbwrnjcg@thinkpad>
	<20250115161201.GA532637@bhelgaas>
	<CGME20250115163012epcas5p185dd4aebcdf093c2760aadea8480b8a5@epcas5p1.samsung.com>
	<20250115162953.yiwhq2m5s5nf7b33@thinkpad> 



> -----Original Message-----
> From: Shradha Todi <shradha.t=40samsung.com>
> Sent: 15 January 2025 22:33
> To: 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org>; 'Bjorn =
Helgaas' <helgaas=40kernel.org>
> Cc: 'linux-kernel=40vger.kernel.org' <linux-kernel=40vger.kernel.org>; 'l=
inux-pci=40vger.kernel.org' <linux-pci=40vger.kernel.org>;
> 'lpieralisi=40kernel.org' <lpieralisi=40kernel.org>; 'kw=40linux.com' <kw=
=40linux.com>; 'robh=40kernel.org' <robh=40kernel.org>;
> 'bhelgaas=40google.com' <bhelgaas=40google.com>; 'jingoohan1=40gmail.com'=
 <jingoohan1=40gmail.com>;
> 'Jonathan.Cameron=40huawei.com' <Jonathan.Cameron=40huawei.com>; 'fan.ni=
=40samsung.com' <fan.ni=40samsung.com>;
> 'a.manzanares=40samsung.com' <a.manzanares=40samsung.com>; 'pankaj.dubey=
=40samsung.com' <pankaj.dubey=40samsung.com>;
> 'quic_nitegupt=40quicinc.com' <quic_nitegupt=40quicinc.com>; 'quic_kricha=
i=40quicinc.com' <quic_krichai=40quicinc.com>;
> 'gost.dev=40samsung.com' <gost.dev=40samsung.com>
> Subject: RE: =5BPATCH v4 1/2=5D PCI: dwc: Add support for vendor specific=
 capability search
>=20
>=20
>=20
> > -----Original Message-----
> > From: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> > Sent: 15 January 2025 22:00
> > To: Bjorn Helgaas <helgaas=40kernel.org>
> > Cc: Shradha Todi <shradha.t=40samsung.com>; linux-kernel=40vger.kernel.=
org; linux-pci=40vger.kernel.org; lpieralisi=40kernel.org;
> > kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=40=
gmail.com; Jonathan.Cameron=40huawei.com;
> > fan.ni=40samsung.com; a.manzanares=40samsung.com; pankaj.dubey=40samsun=
g.com; quic_nitegupt=40quicinc.com;
> > quic_krichai=40quicinc.com; gost.dev=40samsung.com
> > Subject: Re: =5BPATCH v4 1/2=5D PCI: dwc: Add support for vendor specif=
ic capability search
> >
> > On Wed, Jan 15, 2025 at 10:12:01AM -0600, Bjorn Helgaas wrote:
> > > On Wed, Jan 15, 2025 at 08:57:42PM +0530, Manivannan Sadhasivam wrote=
:
> > > > On Wed, Dec 11, 2024 at 08:43:30AM -0600, Bjorn Helgaas wrote:
> > > > > On Wed, Dec 11, 2024 at 05:15:50PM +0530, Shradha Todi wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Bjorn Helgaas <helgaas=40kernel.org>
> > > > > > > Sent: 06 December 2024 21:43
> > > > > > > To: Shradha Todi <shradha.t=40samsung.com>
> > > > > > > Cc: linux-kernel=40vger.kernel.org; linux-pci=40vger.kernel.o=
rg;
> > > > > > > manivannan.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> > > > > > > kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com;
> > > > > > > jingoohan1=40gmail.com; Jonathan.Cameron=40huawei.com;
> > > > > > > fan.ni=40samsung.com; a.manzanares=40samsung.com;
> > > > > > > pankaj.dubey=40samsung.com; quic_nitegupt=40quicinc.com;
> > > > > > > quic_krichai=40quicinc.com; gost.dev=40samsung.com
> > > > > > > Subject: Re: =5BPATCH v4 1/2=5D PCI: dwc: Add support for ven=
dor
> > > > > > > specific capability search
> > > > > > >
> > > > > > > On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> > > > > > > > Add vendor specific extended configuration space capability
> > > > > > > > search API using struct dw_pcie pointer for DW controllers.
> > > > > > > >
> > > > > > > > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > > > > > > > ---
> > > > > > > >  drivers/pci/controller/dwc/pcie-designware.c =7C 16
> > > > > > > > ++++++++++++++++
> > > > > > > > drivers/pci/controller/dwc/pcie-designware.h =7C  1 +
> > > > > > > >  2 files changed, 17 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > > index 6d6cbc8b5b2c..41230c5e4a53 100644
> > > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > > =40=40 -277,6 +277,22 =40=40 static u16 dw_pcie_find_next_e=
xt_capability(struct dw_pcie *pci, u16 start,
> > > > > > > >  	return 0;
> > > > > > > >  =7D
> > > > > > > >
> > > > > > > > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8
> > > > > > > > +vsec_cap)
> > > > > > >
> > > > > > > To make sure that we find a VSEC ID that corresponds to the
> > > > > > > expected vendor, I think this interface needs to be the same
> > > > > > > as pci_find_vsec_capability().  In particular, it needs to
> > > > > > > take a
> > > > > > > =22u16 vendor=22
> > > > > >
> > > > > > As per my understanding, Synopsys is the vendor here when we
> > > > > > talk about vsec capabilities.  VSEC cap IDs are fixed for each
> > > > > > vendor
> > > > > > (eg: For Synopsys Designware controllers, 0x2 is always RAS CAP=
,
> > > > > > 0x4 is always PTM responder and so on).
> > > > >
> > > > > For VSEC, the vendor that matters is the one identified at 0x0 in
> > > > > config space.  That's why pci_find_vsec_capability() checks the
> > > > > supplied =22vendor=22 against =22dev->vendor=22.
> > > > >
> > > > > > So no matter if the DWC IP is being integrated by Samsung, NVDI=
A
> > > > > > or Qcom, the vendor specific CAP IDs will remain constant. Now
> > > > > > since this function is being written as part of designware file=
,
> > > > > > the control will reach here only when the PCIe IP is DWC. So, w=
e
> > > > > > don't really require a vendor ID to be checked here. EG: If 0x2
> > > > > > VSEC ID is present in any DWC controller, it means RAS is
> > > > > > supported. Please correct me if I'm wrong.
> > > > >
> > > > > In this case, the Vendor ID is typically Samsung, NVIDIA, Qcom,
> > > > > etc., even though it may contain Synopsys DWC IP.  Each vendor
> > > > > assigns VSEC IDs independently, so VSEC ID 0x2 may mean something
> > > > > different to Samsung than it does to NVIDIA or Qcom.
> > > > >
> > > > > PCIe r6.0, sec 7.9.5 has the details, but the important part is t=
his:
> > > > >
> > > > >   With a PCI Express Function, the structure and definition of th=
e
> > > > >   vendor-specific Registers area is determined by the vendor indi=
cated
> > > > >   by the Vendor ID field located at byte offset 00h in PCI-compat=
ible
> > > > >   Configuration Space.
> > > > >
> > > > > There IS a separate DVSEC (=22Designated Vendor-Specific=22)
> > > > > Capability; see sec 7.9.6.  That one does include a DVSEC Vendor
> > > > > ID in the Capability itself, and this would make more sense for t=
his situation.
> > > > >
> > > > > If Synopsys assigned DVSEC ID 0x2 from the Synopsys namespace for
> > > > > RAS, then devices from Samsung, NVIDIA, Qcom, etc., could
> > > > > advertise a DVSEC Capability that contained a DVSEC Vendor ID of
> > > > > PCI_VENDOR_ID_SYNOPSYS with DVSEC ID 0x2, and all those devices c=
ould easily locate it.
> > > > >
> > > > > Unfortunately Samsung et al used VSEC instead of DVSEC, so we're
> > > > > stuck with having to specify the device vendor and the VSEC ID
> > > > > assigned by that vendor, and those VSEC IDs might be different pe=
r vendor.
> > > >
> > > > Atleast on Qcom platforms, VSEC_ID is 0x2 for RAS. But this is not
> > > > guaranteed to be the same as per the PCIe spec as you mentioned.
> > > > Though, I think it is safe to go with it since we have seen the sam=
e
> > > > IDs on 2 platforms (my gut feeling is that it is going to be the
> > > > same on other DWC vendor platforms as well). If we encounter
> > > > different IDs, then we can add vendor id check.
> > >
> > > This series uses:
> > >
> > >   dw_pcie_find_vsec_capability(pci, DW_PCIE_VSEC_EXT_CAP_RAS_DES)
> > >
> > > in dwc_pcie_rasdes_debugfs_init(), but I don't see any calls of that
> > > function yet.
> >
> > I guess that the caller got missed unintentionally in patch 2/2.
>=20
> Actually the missing caller is intentional. Jonathan rightly pointed out =
in the
> previous version that the function : dw_pcie_setup() was being called in =
the
> resume path as well and so I thought it would be best to leave it up to t=
he
> platform drivers to decide when and how to call the rasdes init. Do you s=
uggest any
> other approach?
>=20

On second thoughts, I will add the dwc_pcie_rasdes_debugfs_init and deinit =
calls in the
dwc common PCIe files but in the probe/remove path.

> >
> > >  If it is called only from code that already knows the device vendor
> > > has assigned VSEC ID 0x02 for the DWC RAS functionality, I guess it i=
s
> > > =22safe=22.
> > >
> >
> > It should be called from the DWC code driver (pcie-desginware-host.c).
> >
> > > But I think it would be a bad idea because it perpetuates the
> > > misunderstanding that DesignWare can independently claim ownership of
> > > VSEC ID 0x02 for *all* vendors, and other vendors have already used
> > > VSEC ID 0x02 for different things (examples at =5B1=5D).  If any of t=
hem
> > > incorporates this DWC IP, they will have to use a different VSEC ID t=
o
> > > avoid a collision with their existing VSEC ID 0x02.
> > >
> >
> > Fair enough. I was trying to avoid updating the vendor id table for ena=
bling the RAS DES debug feature, but I think it would be worth
> > doing so (perf driver is also doing the same).
>=20
> Makes sense to add the vendor ID check. Will include it in the next versi=
on.
>=20
> >
> > So yeah, I'm OK with the idea of having the vendor_id check in this API=
.
> >
> > (Also, I don't see the VSEC_IDs defined in the DWC reference manual tha=
t I got access to).
> >
> > - Mani
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D=0D=0A=0D=0A

