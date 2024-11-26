Return-Path: <linux-pci+bounces-17336-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA78D9D9604
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 12:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64F2D166BFD
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874E1CDFA9;
	Tue, 26 Nov 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cDdLH/zP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5CC1C4A3D
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732619438; cv=none; b=IDvLYjI7GL+MZHHm+7naedOFjRu+/avarbyMPGjpTs3yCbwWZXhmiXABDkUjGY2v9uroouZbG1rQ+sGkAl0BsPZvlUOXiJL5uVgoA88gOkrGTN5Fu0nrSuuuCz6yxPsrm6mmcxkCz/mqFe385IJeUqR0lgGBk4RW9+BklOmXV0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732619438; c=relaxed/simple;
	bh=Ypev9a6WFoYIXfQoQHvxGPBdvitO6NBRqG8NApJYJw4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=JOSDK99DdzSbyeJLC/xLJIuSRAZCGCsPfPddyNGMq2K7b24IKCgZBzTIytAyR9PFBXX1SkvxB/tPrek9+qKqtn8WJEuzZLlhGAkeWM/GIr1Acif4hQiwi8SUxBuTFg/X620E5WYi91l5C/vxYgQaD62mpIcImG2uECOfiyItRFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cDdLH/zP; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241126111032epoutp0229e90d45afe558c54ef05b4d7ccc7839~LgDG48yig2826828268epoutp020
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 11:10:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241126111032epoutp0229e90d45afe558c54ef05b4d7ccc7839~LgDG48yig2826828268epoutp020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1732619432;
	bh=zHVQj8Mi51pPEJ8jZxMB7t75igtc/2ssLRlqmu7llEA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=cDdLH/zP58/DpFnHmjrHWsCSScg48UqfeylP4GRb13TpKbbWN94ZYS4HbAznBd0P+
	 P4IN572Fz/aytEEVLCs6LloM3s9dVG4WKqn9gwc3zgZKNwkroVI8F1ccynJHGvO+WX
	 iHkdWqVRiYbijK2XGHc22M5dJIK4ap0rmSrt8jKI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241126111032epcas5p1f0bc7d3a0e251d66c4b7db8bd4d8c039~LgDGXw5-p0928209282epcas5p1G;
	Tue, 26 Nov 2024 11:10:32 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XyKcQ3L8Kz4x9Pp; Tue, 26 Nov
	2024 11:10:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.A3.19710.6ACA5476; Tue, 26 Nov 2024 20:10:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241126101541epcas5p4928126490d570998cf6ebef9a3b32e37~LfTOCSPiv2884528845epcas5p4N;
	Tue, 26 Nov 2024 10:15:41 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241126101541epsmtrp27646342c6d07f599f04c42e815c813b7~LfTOBaw6i1661016610epsmtrp2_;
	Tue, 26 Nov 2024 10:15:41 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-eb-6745aca60f7d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	91.6D.19220.4BF95476; Tue, 26 Nov 2024 19:15:16 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241126101511epsmtip1e0132b746acf41c301e2da353e8c5729~LfSx9NUOo2173021730epsmtip1O;
	Tue, 26 Nov 2024 10:15:11 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Nitesh Gupta'" <quic_nitegupt@quicinc.com>, "'Krishna Chaitanya
 Chundru'" <quic_krichai@quicinc.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Cc: <manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>,
	<kw@linux.com>, <robh@kernel.org>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <fancer.lancer@gmail.com>,
	<yoshihiro.shimoda.uh@renesas.com>, <conor.dooley@microchip.com>,
	<pankaj.dubey@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <35395249-7aeb-459c-9c78-2cfdaad2bb6a@quicinc.com>
Subject: RE: [PATCH v3 0/3] Add support for RAS DES feature in PCIe DW
Date: Tue, 26 Nov 2024 15:45:10 +0530
Message-ID: <085801db3fec$16b87260$44295720$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQJJ5mIqR3PJIx/W7Cp/XOg5shxg3AHKwgKyAQ6dYEQB5w+8d7HGBrGA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmpu6yNa7pBgdfCVssacqwmLJpB7vF
	ho45rBY3D+xksljxZSa7RUPPb1aLy7vmsFmcnXeczaLlTwuLxd2WTlaLRVu/sFs8eFBp0Tnn
	CLPF/z1ArV/3fmZz4PfYOesuu8eCTaUem1Z1snncubaHzePJlelMHnd+LGX0mLinzuPbmYks
	Hn1bVjF6fN4kF8AVlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk
	4hOg65aZA/SDkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8v
	tcTK0MDAyBSoMCE7Y99K+4IrshXNE9pZGhi/incxcnJICJhI3P67ib2LkYtDSGA3o8TxbZeZ
	IZxPjBJvZr+CynxjlNizu5sFpuXjtWdQVXsZJVYefAvlvGCUePn2DRtIFZuAjsSTK3/AEiIC
	qxklrn7ZCOYwC6xikrhw5AU7SBWngL3EswfHWEFsYQE3iZvdt8FsFgFViRd/F4BN4hWwlDjc
	dYQdwhaUODnzCdgdzALaEssWvmaGuElB4ufTZawQcXGJoz97wOIiQDOvLGhnAVksIfCGQ2Lm
	/INQDS4SO/s+skHYwhKvjm9hh7ClJD6/2wsVT5dYuXkGVH2OxLfNS5ggbHuJA1fmAA3lAFqm
	KbF+lz5EWFZi6ql1TBA38En0/n4CVc4rsWMejK0s8eXvHmg4SkrMO3aZdQKj0iwkr81C8tos
	JO/MQti2gJFlFaNkakFxbnpqsmmBYV5qOTzKk/NzNzGCE7mWyw7GG/P/6R1iZOJgPMQowcGs
	JMLLJ+6cLsSbklhZlVqUH19UmpNafIjRFBjeE5mlRJPzgbkkryTe0MTSwMTMzMzE0tjMUEmc
	93Xr3BQhgfTEktTs1NSC1CKYPiYOTqkGppouL4mX/uV99drGy0s/vuAq1y/PyPkpdKZgE9um
	Y7KWP/6WHtDP+veg9LiCmMrGt4ePPNk5r2ix42TBty2m1Qcrn9x6oi1zpuzv0fNvetJMrjb+
	/Zi9bcUD92t68XO5vT6WL7r44XORU6v2I6bSW2pfr95JFfR+e2lWFvP2W2+fuWz0+fBG3ElA
	8XnTzo0C6+bE8a/V5q2aXGn95umDSl/RO5qzn3pY3lQvZymL+rH/gc3pK+2MypeUr7SbMzPX
	ehlURe7IXPRd+ZG9dI5btHUl37uyJXfuHJS7spNhDp9sSRSjTUf38i/8ahcTYxNS7qx/L5Mc
	7xq38/J3VVnPHj59pgPZYov67VSPNstPVmIpzkg01GIuKk4EAGjY4DFtBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWy7bCSnO7Z+a7pBjce6losacqwmLJpB7vF
	ho45rBY3D+xksljxZSa7RUPPb1aLy7vmsFmcnXeczaLlTwuLxd2WTlaLRVu/sFs8eFBp0Tnn
	CLPF/z1ArV/3fmZz4PfYOesuu8eCTaUem1Z1snncubaHzePJlelMHnd+LGX0mLinzuPbmYks
	Hn1bVjF6fN4kF8AVxWWTkpqTWZZapG+XwJXxZNEP1oKlshXdV84yNzAeEO9i5OSQEDCR+Hjt
	GTOILSSwm1Hi+QEriLikxOeL65ggbGGJlf+es3cxcgHVPGOU2HfwPiNIgk1AR+LJlT/MIAkR
	gbWMEpOPvQBLMAtsY5K41M4H0fGZUWLaqwssIAlOAXuJZw+OsYLYwgJuEje7b4PZLAKqEi/+
	LmADsXkFLCUOdx1hh7AFJU7OfMICMVRb4unNp3D2soWvmSHOU5D4+XQZK0RcXOLozx6wuAjQ
	/CsL2lkmMArPQjJqFpJRs5CMmoWkfQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxN
	jOBY1tLawbhn1Qe9Q4xMHIyHGCU4mJVEePnEndOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8357
	3ZsiJJCeWJKanZpakFoEk2Xi4JRqYOKcsv/0pds17jyTjyWu0H+86b1d7PUu6bSE9IquArWn
	LZpKvvO+vFi78qLPba4Y1Z68fUxPZ14ra8rqj4//Ml/LUHHRljDrzUof8z4lyUYuc/d6ftg6
	skRnmgDjyrmMwq/upv5Wf9l82+yaie+5vS1rqmuiSvmem/z7uaROauNErjcLZ249lnt75pK2
	eYb7As2eijnOjAljf5kl8TPkg+XEddKmXY0XOZ/8nt3tGaJ+2eTB6yVTXhQGFp19vUplmpFC
	mYpDiIiKvL9ZaaF508U40dJ7z1kNFE6qBLjuuHR8k+kfqXWXd9oaypxhnv9i+ZfHVvImTzZp
	n6rOKTFQ3ir2+GXP1NccF26smrrEp0+JpTgj0VCLuag4EQAX7b/IVAMAAA==
X-CMS-MailID: 20241126101541epcas5p4928126490d570998cf6ebef9a3b32e37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d
References: <CGME20240625094434epcas5p2e48bda118809ccb841c983d737d4f09d@epcas5p2.samsung.com>
	<20240625093813.112555-1-shradha.t@samsung.com>
	<03c5bf0e-d65b-7ebb-d12d-3f9b3bae2a4c@quicinc.com>
	<35395249-7aeb-459c-9c78-2cfdaad2bb6a@quicinc.com>

Hey Nitish,

Due to some discussions about including this in the EDAC framework etc, the=
 patches got
delayed. Sorry about that. I am already working on the next version and wil=
l post it by this
Friday=21 Feel free to add review comments to the previous version if there=
 are any so that
I can include them in my next version.

> -----Original Message-----
> From: Nitesh Gupta <quic_nitegupt=40quicinc.com>
> Sent: 26 November 2024 12:46
> To: Krishna Chaitanya Chundru <quic_krichai=40quicinc.com>; Shradha Todi
> <shradha.t=40samsung.com>; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org
> Cc: manivannan.sadhasivam=40linaro.org; lpieralisi=40kernel.org;
> kw=40linux.com; robh=40kernel.org; bhelgaas=40google.com;
> jingoohan1=40gmail.com; fancer.lancer=40gmail.com;
> yoshihiro.shimoda.uh=40renesas.com; conor.dooley=40microchip.com;
> pankaj.dubey=40samsung.com; gost.dev=40samsung.com
> Subject: Re: =5BPATCH v3 0/3=5D Add support for RAS DES feature in PCIe D=
W
>=20
> Hi Shradha,
>=20
> Can you please update on status of this Patch?
>=20
> Are you going to take it up or is it fine for us to take it up?
>=20
> -Nitesh Gupta
>=20
> On 11/26/2024 10:47 AM, Krishna Chaitanya Chundru wrote:
> >
> > forgot to add the email in the previous mail.
> >
> > - Krishna chaitanya.
> > On 6/25/2024 3:08 PM, Shradha Todi wrote:
> >> DesignWare controller provides a vendor specific extended capability
> >> called RASDES as an IP feature. This extended capability provides
> >> hardware information like:
> >>   - Debug registers to know the state of the link or controller.
> >>   - Error injection mechanisms to inject various PCIe errors
> >> including
> >>     sequence number, CRC
> >>   - Statistical counters to know how many times a particular event
> >>     occurred
> >>
> >> However, in Linux we do not have any generic or custom support to be
> >> able to use this feature in an efficient manner. This is the reason
> >> we are proposing this framework. Debug and bring up time of
> >> high-speed IPs are highly dependent on costlier hardware analyzers
> >> and this solution will in some ways help to reduce the HW analyzer usa=
ge.
> >>
> >> The debugfs entries can be used to get information about underlying
> >> hardware and can be shared with user space. Separate debugfs entries
> >> has been created to cater to all the DES hooks provided by the control=
ler.
> >> The debugfs entries interacts with the RASDES registers in the
> >> required sequence and provides the meaningful data to the user. This
> >> eases the effort to understand and use the register information for
> debugging.
> >>
> >> v2: https://lore.kernel.org/lkml/20240319163315.GD3297=40thinkpad/T/
> >>
> >> v1:
> >> https://lore.kernel.org/all/20210518174618.42089-1-shradha.t=40samsung=
.
> >> com/T/
> >>
> >> Shradha Todi (3):
> >>    PCI: dwc: Add support for vendor specific capability search
> >>    PCI: debugfs: Add support for RASDES framework in DWC
> >>    PCI: dwc: Create debugfs files in DWC driver
> >>
> >>   drivers/pci/controller/dwc/Kconfig            =7C   8 +
> >>   drivers/pci/controller/dwc/Makefile           =7C   1 +
> >>   .../controller/dwc/pcie-designware-debugfs.c  =7C 474
> >> ++++++++++++++++++
> >>   .../controller/dwc/pcie-designware-debugfs.h  =7C   0
> >>   .../pci/controller/dwc/pcie-designware-host.c =7C   2 +
> >>   drivers/pci/controller/dwc/pcie-designware.c  =7C  20 +
> >>   drivers/pci/controller/dwc/pcie-designware.h  =7C  18 +
> >>   7 files changed, 523 insertions(+)
> >>   create mode 100644
> >> drivers/pci/controller/dwc/pcie-designware-debugfs.c
> >>   create mode 100644
> >> drivers/pci/controller/dwc/pcie-designware-debugfs.h
> >>


