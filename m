Return-Path: <linux-pci+bounces-18120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCBD9ECB87
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D02D281C50
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 11:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2802238E3B;
	Wed, 11 Dec 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OOaMfFC0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BB2238E0F
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733917584; cv=none; b=tYieyC2RAGr0tUlULHUJMM3JLgiD3D/tLbUVBBpkwXOlYZZJp9rld67vxdqA46iXk5nDW+Q04GEKs+5Z7Zbl/ZDLO/kPfqoGSeub88Xn43npnUSJVP1QLeeccAboBjtyutN6f2k82opbLpZRcrffUXPNrTNo4SAPK6Qh6FbKrJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733917584; c=relaxed/simple;
	bh=5Tp3dyqHHpseArL3qQvnHJzkCSSer9Lxcs7I6o/7vL8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=VytBRwAMHNMQkVMCmmjHG3YsHSxKWv2LtyAWKdI1jPaTP3DE1sEy5eCemjqRM0gfWOjg+d7qWOTeveTsbWQW97XHHUPyXnZX92odp4QG0fGARy6xXG5+Ay8ogg0X2QnfeXkYW6NcFyL1M9PuYSyDTUyNynXaIx+NhPwTlzfX40I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OOaMfFC0; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241211114618epoutp04ad1cf6fda7a0a37b3d886d7815e67eca~QHNnhXSCx0614006140epoutp04n
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 11:46:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241211114618epoutp04ad1cf6fda7a0a37b3d886d7815e67eca~QHNnhXSCx0614006140epoutp04n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733917578;
	bh=Pg+qsa559G5yxose7doBfGWwKZYwTKA4hFOmcOxyL4A=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=OOaMfFC0tS25CNJupk6js0QGXizc7Pn7NXHeNiBgH70X7+IWilZIh08yX1nAnVBKY
	 zOiSWZ54dTIUDwe4vSF+cVf72tpaxVfRN5Mx+g0TM5FLV0w6Zm+mnA7ToqgWO74WdU
	 dSHVffqcjZ5NaB5kLRurnZ8gwoqTUtwImulUcNEw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20241211114617epcas5p40b1266e360c89f0d7b879a3a5fedc330~QHNmOL7UB2979129791epcas5p48;
	Wed, 11 Dec 2024 11:46:17 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y7Yhl4VvLz4x9Q6; Wed, 11 Dec
	2024 11:46:15 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2C.0D.19956.68B79576; Wed, 11 Dec 2024 20:46:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241211114553epcas5p4e7566e44f0d65371d57def76851f7983~QHNQjCSZr3195731957epcas5p4H;
	Wed, 11 Dec 2024 11:45:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241211114553epsmtrp25ad99902bb7ff3a73a990b2b1a73acc0~QHNQiM3co2253622536epsmtrp2T;
	Wed, 11 Dec 2024 11:45:53 +0000 (GMT)
X-AuditID: b6c32a4b-fd1f170000004df4-05-67597b86c3ea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B9.BF.18729.17B79576; Wed, 11 Dec 2024 20:45:53 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241211114551epsmtip13981d505855900b7f1bd35b2240211b5~QHNOY8DTw0441004410epsmtip11;
	Wed, 11 Dec 2024 11:45:51 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Bjorn Helgaas'" <helgaas@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@huawei.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>,
	<quic_nitegupt@quicinc.com>, <quic_krichai@quicinc.com>,
	<gost.dev@samsung.com>
In-Reply-To: <20241206161314.GA3101322@bhelgaas>
Subject: RE: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific
 capability search
Date: Wed, 11 Dec 2024 17:15:50 +0530
Message-ID: <0d6301db4bc2$3be58dc0$b3b0a940$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQKqwUqkS3i3H+E5/iBI1vzIBNwqmAFi+xIzsTbfpjA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH8+ttby8mkAvK/MEc6674AARbafGWFdwydGWdgjFbwtxSG3rX
	An3ltmUiYSECJmVMYQtBGoYPFKGTudQKFMpgPGUB2SZDSNbJtF2QycKwITHCXK8XNv77/L7n
	nN/3nN8DQyJ+QaOxPIOFog0qHYFu4rYPxMUlninO0QjHO2PJuoHXyCunteTpr708cqbPzSHn
	x9pQsiVQzycdl6ZQsrTqGY+829WAkuONIyhZvlLOJb3lNh55+VaAT87OFpG2hkGEfO7p5L+B
	y912L19+0WmVlw8u8OROhw2V/zrlQeW+yTqOvMbzqfysywHkT5wx2SEfFMi0lEpN0QLKkGtU
	5xk0aYTimPItpSRFKEoUScn9hMCg0lNpRMa72YmH8nTBEQhBoUpnDUrZKrOZ2Jsuo41WCyXQ
	Gs2WNIIyqXUmsSnJrNKbrQZNkoGypIqEwn2SYOKJAq2/uw+YrsecvDHxM1IK6qMqQQgGcTH8
	ab6JXwk2YRF4N4A1t5s4TCACXwLQ1a5meRnAf5rD1wu+86yibEEPgEMrvrXFHIC2hWWUyULx
	PdA3uYIwvAWPhyPf9/KYJAQ/j8Cx0WkeEwjBhdDvqACVAMM24zmw+Q8+I3PxHTDQVw0YDsWl
	8Ln/DpflcDha73vBCP4q7FhoQNiOBPCpv5nH6lvh0NOqNd9U2PHtKmB8If4Yg+4eL4fxgngG
	HGjD2NrNcH7ExWc5Gj75qwdlWQNbb55f218Hl29e4bB8APZNNnCZbRA8Dt7o2svKr8DaH77h
	sC2Ewc+f+dbSQ2Fn4zpvh4FVD5flKNg4fJdXDQj7hsnsGyazb5jG/r/bRcB1gCjKZNZrKLPE
	lGygPvnvunONeid48b7jFZ3gwexiUj/gYKAfQAwhtoROH8jRRISqVUWnKNqopK06ytwPJMHj
	rkGiI3ONwQ9isChFYqlQnJKSIpYmp4iIraF/VnyljsA1KgtVQFEmil6v42Ah0aWc6t/KlE5T
	7J6pEkmtJ//E4ZmKC/mt2/XC94raOwbTdxe/rCn5wtQos2ZmzbljpX78keRwsiDhaO6bBxNv
	bYs74z3kOaYePxo5mDi87+RnxTzLwyXX/e4jx6+NpMfwOrkl/KHhuXcuJVR1lcwIdxyUeJcG
	PgzHKkbrfm/Lylq97Q47h4qSdtKoeyW+ZVA57UnQv03ZWz6WvXTniEdxSjHujNzlqnlsm75W
	0LR/RDFbJqC3jc1n0t3Hz6EXrn5ZW0Y7Ha/7CheHJnq5vR+FeaiHkvz3yZjY+1OWiUh769lH
	/NSdi/cQZSDv8o8ya80A8nebq9BxPdOdmzEW+8Byb5d2luCatSpRPEKbVf8CpYzCHmgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWy7bCSnG5hdWS6waEt5hbTDytaLGnKsGha
	fZfV4uaBnUwWr86sZbNY8WUmu8WqhdfYLBp6frNaXN41h83i7LzjbBYtf1pYLO62dLJaLNr6
	hd3iwYNKi845R5gt/u/Zwe4g4LFz1l12jwWbSj1ajrxl9di0qpPN4861PWweT65MZ/KYuKfO
	o2/LKkaPz5vkAjijuGxSUnMyy1KL9O0SuDKe7j7AWLBGrmL9+UvMDYwzJbsYOTkkBEwk9u35
	y9bFyMUhJLCbUaLjSx8rREJS4vPFdUwQtrDEyn/P2SGKnjFKrHxxlxEkwSagI/Hkyh9mEFtE
	QEvi+MH9rCBFzAIrmCWO7HvKBNHRyChxq6sbrIpTwEDi6apWsG5hgXCJm1/OsIDYLAKqEl8O
	TACL8wpYSvx/eo4FwhaUODnzCZDNATRVT6JtI1gJs4C8xPa3c5ghrlOQ+Pl0GStEXFzi6M8e
	qIOsJLZv+Ms4gVF4FpJJsxAmzUIyaRaS7gWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS
	83M3MYLjWEtzB+P2VR/0DjEycTAeYpTgYFYS4b1hH5kuxJuSWFmVWpQfX1Sak1p8iFGag0VJ
	nFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgSn15gaZ9dN457NnHK/9ulKCW2TTEteNdZwSTZz9
	TS5V9t25+Z2lQQsOv17GzWwl8ariadjGOtZrU0p4dbx0/Gfmze4suGN5h3Eq74oUmyAbHYai
	XYyJ+0SOTjHc/kAxPmypo6DPgmmcyVflWL70fZ15KuRj5vzY3f/mtwf92sKvZSvJvOOIb1uj
	/MQLfnFacQ8233YQ2sQQ/DX582nGVxbinLJKuh/X5WTNWbXnE5/8AmYvvvtrjheltQcezbVw
	5Ysruc6XvuGyS2z5+veH2qryJULij/16uajBZePCTcfP6nxcWfbp2KM1FcIBqwV2zK0/2y78
	eq6CceW6/XNN90kuzM7gEl1/f+FcBgk9PSWW4oxEQy3mouJEAAlIJLxSAwAA
X-CMS-MailID: 20241211114553epcas5p4e7566e44f0d65371d57def76851f7983
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206161320epcas5p46ad6746fd2fdfd30a45de1a34393abf0
References: <CGME20241206161320epcas5p46ad6746fd2fdfd30a45de1a34393abf0@epcas5p4.samsung.com>
	<20241206161314.GA3101322@bhelgaas>



> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: 06 December 2024 21:43
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> fan.ni@samsung.com; a.manzanares@samsung.com; pankaj.dubey@samsung.com; quic_nitegupt@quicinc.com;
> quic_krichai@quicinc.com; gost.dev@samsung.com
> Subject: Re: [PATCH v4 1/2] PCI: dwc: Add support for vendor specific capability search
> 
> On Fri, Dec 06, 2024 at 01:14:55PM +0530, Shradha Todi wrote:
> > Add vendor specific extended configuration space capability search API
> > using struct dw_pcie pointer for DW controllers.
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 16 ++++++++++++++++
> > drivers/pci/controller/dwc/pcie-designware.h |  1 +
> >  2 files changed, 17 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 6d6cbc8b5b2c..41230c5e4a53 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -277,6 +277,22 @@ static u16 dw_pcie_find_next_ext_capability(struct dw_pcie *pci, u16 start,
> >  	return 0;
> >  }
> >
> > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap)
> 
> To make sure that we find a VSEC ID that corresponds to the expected vendor, I think this interface needs to be the
same
> as pci_find_vsec_capability().  In particular, it needs to take a "u16 vendor"

As per my understanding, Synopsys is the vendor here when we talk about vsec capabilities.
VSEC cap IDs are fixed for each vendor (eg: For Synopsys Designware controllers, 0x2 is always RAS CAP,
0x4 is always PTM responder and so on).
So no matter if the DWC IP is being integrated by Samsung, NVDIA or Qcom, the vendor specific CAP IDs will
remain constant. Now since this function is being written as part of designware file, the control will reach here
only when the PCIe IP is DWC. So, we don't really require a vendor ID to be checked here. EG: If 0x2 VSEC ID is present
in any DWC controller, it means RAS is supported. Please correct me if I'm wrong.

>and a "u16 vsec_cap".
> 
> (pci_find_vsec_capability() takes an "int cap", but I don't think that's quite right).
> 

It should be u16 vsec_cap. You're right. I will fix this in the next patchset.

Shradha

> > +{
> > +	u16 vsec = 0;
> > +	u32 header;
> > +
> > +	while (vsec = dw_pcie_find_next_ext_capability(pci, vsec,
> > +					PCI_EXT_CAP_ID_VNDR)) {
> > +		header = dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> > +		if (PCI_VNDR_HEADER_ID(header) == vsec_cap)
> > +			return vsec;
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
> > +
> >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)  {
> >  	return dw_pcie_find_next_ext_capability(pci, 0, cap); diff --git
> > a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 347ab74ac35a..98a057820bc7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -476,6 +476,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
> >
> >  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u8 vsec_cap);
> >
> >  int dw_pcie_read(void __iomem *addr, int size, u32 *val);  int
> > dw_pcie_write(void __iomem *addr, int size, u32 val);
> > --
> > 2.17.1
> >


