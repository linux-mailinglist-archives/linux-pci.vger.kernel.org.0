Return-Path: <linux-pci+bounces-19913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8DBA129BD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4401167C6A
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462711CF28B;
	Wed, 15 Jan 2025 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="p1AFli7Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF3418A93E
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961811; cv=none; b=ElZ0auaTkrBiK/mhFnlb20Vu+kf7xfcRXJdVzXvACLhp1Zw/YikWFFJ7yVqxibS2gxLgmni3W0VGERhLCtQZLiqjB7OwVuck+wZS8cYC2UVGBva1BPB4tq/dcnIVYZb+1Bot2P5TzbEiFcOujtDjiKn0XOLhze7/FoKCwLqM++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961811; c=relaxed/simple;
	bh=dS1GxqFui0Gf2+lpmwQKRKlNiDkLcmPOhBe5o8KqxVI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=jSMSOwHB7C3GG+Ys4yy1rXe5Xv0uqbdWrdJIxf8/B1Ya9WmxynBgrwSM5eVqfDMGhOiwQcXhS1evkPS7xs5CPvzYiedOJpYgEcqGdshhKad2AQHsaq1Ra7pD8hQGwfaZiRIngTC4GY7yyxjdztenWfkZ+eF282irDTbVveNt1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=p1AFli7Z; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250115172320epoutp02710ab458550aec0880fa530e95aef310~a7Y4NXe8s3022530225epoutp02J
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 17:23:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250115172320epoutp02710ab458550aec0880fa530e95aef310~a7Y4NXe8s3022530225epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736961800;
	bh=Xz66nAzgv0QS0vXEA+LVNwy41dAQe7U9gGrpuzzplGc=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=p1AFli7ZPcqpp2Ap6HGDlSoWV4ZtaJaUtYahxGmn5SlLXJ6MX3Euo/mn7Fnh8cqXE
	 3nJCYhBi9O2MRyyv+XVXcTzj3sBw/S4qApZpTPNSdiHdRJMDPu8pOSaqxmSnqJ3GiB
	 Jvi8AaVf1QWQ2ZzgjpDAQkVycVVO4YjrV/Wva0MQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250115172319epcas5p113d0017786ead758d8c983a07adc0a7f~a7Y3kbvqO2816728167epcas5p1x;
	Wed, 15 Jan 2025 17:23:19 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YYCWV1Ybtz4x9Pt; Wed, 15 Jan
	2025 17:23:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.CB.20052.60FE7876; Thu, 16 Jan 2025 02:23:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250115170321epcas5p1a89a92befb3a4dd8a6885edf8f9daf67~a7HbpXA_C2225922259epcas5p12;
	Wed, 15 Jan 2025 17:03:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250115170321epsmtrp29658356f1a61dd3a9816cdaa4542ab27~a7HbnL38h0445204452epsmtrp2Y;
	Wed, 15 Jan 2025 17:03:21 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-11-6787ef06b823
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.6B.18729.95AE7876; Thu, 16 Jan 2025 02:03:21 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250115170319epsmtip1fcd6d509d6a148ab749207723a5ffef2~a7HZVpFZh0180001800epsmtip1m;
	Wed, 15 Jan 2025 17:03:19 +0000 (GMT)
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
In-Reply-To: <20250115162953.yiwhq2m5s5nf7b33@thinkpad>
Subject: RE: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Date: Wed, 15 Jan 2025 22:33:18 +0530
Message-ID: <009301db676f$61935d40$24ba17c0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKWsodhYC6NSirBymwM1Ar2SvsMdgIPlXY2AuD9S+YB7UyiObFqhjag
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeuff29mIou1aHRxYBrzPEB9iyttwy0CUa7DKXsZElVZdBA3ct
	UNqmDxwbWzqtYSgbz42HDauuMq28XykIA6FQmYhxAm5xBBKZU8fDIGAYMNf24sZ/3+93vu98
	v+88CJR/Fw8iUjVGRq9RqCl8A9bauyssHJ/NUQos91C6tHc7bT+pok9eGePQv3W3IfTjwRqc
	vjRfzqUd50dx2py3zKHvtFtx+malG6ctKxaMHrPkcugLLfNcemIii861ulD6eYeT+yYpa6sY
	48psjSaZxTXNkTU6cnHZ76MduGxyuBSRFXZ8Ifum2QFkTxuD4/2OpceoGEUKow9lNMnalFSN
	MpZ6OyHxYKJYIhCGC6V0FBWqUWQwsdShI/HhcalqTwQqNFOhNnla8QqDgdq3P0avNRmZUJXW
	YIylGF2KWifSRRgUGQaTRhmhYYzRQoEgUuwhJqWrnBd6Ed3MgU9+qr2GmkFN5BngR0BSBFsL
	B9EzYAPBJ68CmPejmcsWcwCeLnJgbLEIYK17yEMjfJKqie1svxPAQVf1GukhgH1PqrnefXFy
	L5wcXkG9eDOZBv+euYV7SSg5j8CO28Uc74IfGQXLBnIQ766byKOw6oFPi5E74aVnJT4Kj5TC
	dtsQxuKNcKB80odRcg+sOv8XymYIhUt/VHFYrzjouNkIWM4W2LeU58sGySkCjs7ZMFZwCOYX
	WgGLN8HH7mYui4Pg05lOnMVKeLmpbM1ADReb7AiLD8DuYSvmnRkld8G69n1sexv89udahPUN
	gF8vT67RedBZ+QLvgPOrHWsjbIWV/Xc4BYCqWBetYl20inURKv53swHMAbYyOkOGkjGIdUIN
	c+K/C0/WZjQC3wvf/ZYTjE08iegBCAF6ACRQajPPjp9W8nkpiqxPGb02UW9SM4YeIPacdyEa
	9Eqy1vNFNMZEoUgqEEkkEpH0dYmQ2sI71WZR8kmlwsikM4yO0b/QIYRfkBn5oMRtdh0uOwaq
	+dmn3LMhBXv8g59NLcxfJBDBzqwfMuW99XXNE/7fXylx/RJzXfTe1I6zIdmr+OfFX15bdM/+
	Op1gHRSeqGUe5F3tOi4cCEvTaoZazpbaRiJnQNLHEQEx41/NYUELH5arG1q2ue7Hpd23y+QR
	aUVyU0xTytLQ7cxo3a3iogJyVT/uvB73RmdLiIj/6Dv7yMOPVFM5LX57b1x8GZuWh1ir6xf6
	/Uv0CaVZd83vL9eG7W+NrmHG8cB3P7N3HSdBHdqMBdTZs6WBIw19r57rzn8+cvm11IaCd5LF
	kq70R/UD8oN/Dt6Y6o/PjVpJEh91zhx+6d7GwPx/uMEUZlAphLtRvUHxL4/71ONqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnG7kq/Z0g+tnVS2mH1a0WNKUYdG0
	+i6rxc0DO5ksXp1Zy2ax4stMdotVC6+xWTT0/Ga1uLxrDpvF2XnH2Sxa/rSwWNxt6WS1WLT1
	C7vFgweVFp1zjjBb/N+zg91BwGPnrLvsHgs2lXq0HHnL6rFpVSebx51re9g8nlyZzuQxcU+d
	R9+WVYwenzfJBXBGcdmkpOZklqUW6dslcGXce3qJrWCJfcXs3U/YGhj3GHYxcnBICJhILHug
	2MXIxSEksJtRYtmx+axdjJxAcUmJzxfXMUHYwhIr/z1nhyh6xiix9tl5NpAEm4COxJMrf5hB
	BokIZElcOw5WwyzQxCyxa9NrZoiGa4wStye9ZgFp4BQwl5hxsh1sqrBAuMTNL2fA4iwCqhIr
	vk8B28wrYCmxa8E5FghbUOLkzCdgNrOAtkTvw1ZGGHvZQpAFINcpSPx8ugysV0TATWLV2U1Q
	NeISR3/2ME9gFJ6FZNQsJKNmIRk1C0nLAkaWVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
	uZsYwXGspbmDcfuqD3qHGJk4GA8xSnAwK4nwLmFrTRfiTUmsrEotyo8vKs1JLT7EKM3BoiTO
	K/6iN0VIID2xJDU7NbUgtQgmy8TBKdXAtPH+lK3cC90srl/rChNOrC+tt3x/RM/Ebvp554v8
	nPu77MSb495FR+VqObBt6ch88e/oS9bm6okbp7kxM59zeStxcMfCO6mFZX0fIy8mXqk8Iqnz
	kfXnhMZa/v0bEjhLlPT7VNlOSossV8pz6bm94s+/Y7Mj163/Wbp26wPTWff+rC7bLW/55Fho
	/luNpXLTNnyt7kwVl776sfDoh0neDtc1kv2SFsy8kJ5xXunwpLiNVnw6Exb+kjvF2KhZL2SW
	9nqr0UQuq+lt7a7yHCxGAlwrZOuDlf7rL+qPz0m05OqIWu8+jW/DxCsZf6KFPm/0aJzmrLhI
	ePdSI7E5RcVMG/lK3jo3rLCd+O9A6t8SJZbijERDLeai4kQA3VTy31IDAAA=
X-CMS-MailID: 20250115170321epcas5p1a89a92befb3a4dd8a6885edf8f9daf67
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
> From: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> Sent: 15 January 2025 22:00
> To: Bjorn Helgaas <helgaas=40kernel.org>
> Cc: Shradha Todi <shradha.t=40samsung.com>; linux-kernel=40vger.kernel.or=
g; linux-pci=40vger.kernel.org; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com; jingoohan1=40gm=
ail.com; Jonathan.Cameron=40huawei.com;
> fan.ni=40samsung.com; a.manzanares=40samsung.com; pankaj.dubey=40samsung.=
com; quic_nitegupt=40quicinc.com;
> quic_krichai=40quicinc.com; gost.dev=40samsung.com
> Subject: Re: =5BPATCH v4 1/2=5D PCI: dwc: Add support for vendor specific=
 capability search
>=20
> On Wed, Jan 15, 2025 at 10:12:01AM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 15, 2025 at 08:57:42PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Dec 11, 2024 at 08:43:30AM -0600, Bjorn Helgaas wrote:
> > > > On Wed, Dec 11, 2024 at 05:15:50PM +0530, Shradha Todi wrote:
> > > > > > -----Original Message-----
> > > > > > From: Bjorn Helgaas <helgaas=40kernel.org>
> > > > > > Sent: 06 December 2024 21:43
> > > > > > To: Shradha Todi <shradha.t=40samsung.com>
> > > > > > Cc: linux-kernel=40vger.kernel.org; linux-pci=40vger.kernel.org=
;
> > > > > > manivannan.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> > > > > > kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com;
> > > > > > jingoohan1=40gmail.com; Jonathan.Cameron=40huawei.com;
> > > > > > fan.ni=40samsung.com; a.manzanares=40samsung.com;
> > > > > > pankaj.dubey=40samsung.com; quic_nitegupt=40quicinc.com;
> > > > > > quic_krichai=40quicinc.com; gost.dev=40samsung.com
> > > > > > Subject: Re: =5BPATCH v4 1/2=5D PCI: dwc: Add support for vendo=
r
> > > > > > specific capability search
> > > > > >
> > > > > > On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> > > > > > > Add vendor specific extended configuration space capability
> > > > > > > search API using struct dw_pcie pointer for DW controllers.
> > > > > > >
> > > > > > > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > > > > > > ---
> > > > > > >  drivers/pci/controller/dwc/pcie-designware.c =7C 16
> > > > > > > ++++++++++++++++
> > > > > > > drivers/pci/controller/dwc/pcie-designware.h =7C  1 +
> > > > > > >  2 files changed, 17 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > index 6d6cbc8b5b2c..41230c5e4a53 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > > > > > > =40=40 -277,6 +277,22 =40=40 static u16 dw_pcie_find_next_ext=
_capability(struct dw_pcie *pci, u16 start,
> > > > > > >  	return 0;
> > > > > > >  =7D
> > > > > > >
> > > > > > > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8
> > > > > > > +vsec_cap)
> > > > > >
> > > > > > To make sure that we find a VSEC ID that corresponds to the
> > > > > > expected vendor, I think this interface needs to be the same
> > > > > > as pci_find_vsec_capability().  In particular, it needs to
> > > > > > take a
> > > > > > =22u16 vendor=22
> > > > >
> > > > > As per my understanding, Synopsys is the vendor here when we
> > > > > talk about vsec capabilities.  VSEC cap IDs are fixed for each
> > > > > vendor
> > > > > (eg: For Synopsys Designware controllers, 0x2 is always RAS CAP,
> > > > > 0x4 is always PTM responder and so on).
> > > >
> > > > For VSEC, the vendor that matters is the one identified at 0x0 in
> > > > config space.  That's why pci_find_vsec_capability() checks the
> > > > supplied =22vendor=22 against =22dev->vendor=22.
> > > >
> > > > > So no matter if the DWC IP is being integrated by Samsung, NVDIA
> > > > > or Qcom, the vendor specific CAP IDs will remain constant. Now
> > > > > since this function is being written as part of designware file,
> > > > > the control will reach here only when the PCIe IP is DWC. So, we
> > > > > don't really require a vendor ID to be checked here. EG: If 0x2
> > > > > VSEC ID is present in any DWC controller, it means RAS is
> > > > > supported. Please correct me if I'm wrong.
> > > >
> > > > In this case, the Vendor ID is typically Samsung, NVIDIA, Qcom,
> > > > etc., even though it may contain Synopsys DWC IP.  Each vendor
> > > > assigns VSEC IDs independently, so VSEC ID 0x2 may mean something
> > > > different to Samsung than it does to NVIDIA or Qcom.
> > > >
> > > > PCIe r6.0, sec 7.9.5 has the details, but the important part is thi=
s:
> > > >
> > > >   With a PCI Express Function, the structure and definition of the
> > > >   vendor-specific Registers area is determined by the vendor indica=
ted
> > > >   by the Vendor ID field located at byte offset 00h in PCI-compatib=
le
> > > >   Configuration Space.
> > > >
> > > > There IS a separate DVSEC (=22Designated Vendor-Specific=22)
> > > > Capability; see sec 7.9.6.  That one does include a DVSEC Vendor
> > > > ID in the Capability itself, and this would make more sense for thi=
s situation.
> > > >
> > > > If Synopsys assigned DVSEC ID 0x2 from the Synopsys namespace for
> > > > RAS, then devices from Samsung, NVIDIA, Qcom, etc., could
> > > > advertise a DVSEC Capability that contained a DVSEC Vendor ID of
> > > > PCI_VENDOR_ID_SYNOPSYS with DVSEC ID 0x2, and all those devices cou=
ld easily locate it.
> > > >
> > > > Unfortunately Samsung et al used VSEC instead of DVSEC, so we're
> > > > stuck with having to specify the device vendor and the VSEC ID
> > > > assigned by that vendor, and those VSEC IDs might be different per =
vendor.
> > >
> > > Atleast on Qcom platforms, VSEC_ID is 0x2 for RAS. But this is not
> > > guaranteed to be the same as per the PCIe spec as you mentioned.
> > > Though, I think it is safe to go with it since we have seen the same
> > > IDs on 2 platforms (my gut feeling is that it is going to be the
> > > same on other DWC vendor platforms as well). If we encounter
> > > different IDs, then we can add vendor id check.
> >
> > This series uses:
> >
> >   dw_pcie_find_vsec_capability(pci, DW_PCIE_VSEC_EXT_CAP_RAS_DES)
> >
> > in dwc_pcie_rasdes_debugfs_init(), but I don't see any calls of that
> > function yet.
>=20
> I guess that the caller got missed unintentionally in patch 2/2.

Actually the missing caller is intentional. Jonathan rightly pointed out in=
 the
previous version that the function : dw_pcie_setup() was being called in th=
e
resume path as well and so I thought it would be best to leave it up to the
platform drivers to decide when and how to call the rasdes init. Do you sug=
gest any
other approach?

>=20
> >  If it is called only from code that already knows the device vendor
> > has assigned VSEC ID 0x02 for the DWC RAS functionality, I guess it is
> > =22safe=22.
> >
>=20
> It should be called from the DWC code driver (pcie-desginware-host.c).
>=20
> > But I think it would be a bad idea because it perpetuates the
> > misunderstanding that DesignWare can independently claim ownership of
> > VSEC ID 0x02 for *all* vendors, and other vendors have already used
> > VSEC ID 0x02 for different things (examples at =5B1=5D).  If any of the=
m
> > incorporates this DWC IP, they will have to use a different VSEC ID to
> > avoid a collision with their existing VSEC ID 0x02.
> >
>=20
> Fair enough. I was trying to avoid updating the vendor id table for enabl=
ing the RAS DES debug feature, but I think it would be worth
> doing so (perf driver is also doing the same).

Makes sense to add the vendor ID check. Will include it in the next version=
.

>=20
> So yeah, I'm OK with the idea of having the vendor_id check in this API.
>=20
> (Also, I don't see the VSEC_IDs defined in the DWC reference manual that =
I got access to).
>=20
> - Mani
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A

