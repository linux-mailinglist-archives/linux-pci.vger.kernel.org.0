Return-Path: <linux-pci+bounces-21875-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11686A3D22A
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 08:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FCB16FB3D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 07:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C34B1E6DC5;
	Thu, 20 Feb 2025 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IL8Ohxa7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712901EA7EA
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 07:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036159; cv=none; b=PXJnZZOmsI5nSnuEVITHiSqBlMrYOTalqEYEwsjaJXZ9iJcFf5BvCHuWcFjlqao7pXwF3Y4kvSHc0TH3SBlhX74BP4SkTI/upBML1n0pImCdkE1M/CU89ekwcvk0Ci1c6b6hhUaXVN0X4k/C3c0znCH6oGPzHpbESmTBc7tSLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036159; c=relaxed/simple;
	bh=yp4vuPNWmuTad+sjj3PV/ZaApSHfQlGugPZMLv5Ueqs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=PbzDNvtX2nHR4IuPY/t9ketiB91GZlVsxTNfbfrsWV0bmNu6creLzmSwSMZHK9tXhY4d07n+IbRUyOaGIzy+hwOQxJvBe/3Cx7YS1EY0pO1Coaapgy0bUnz1jpoMxt90eD7FNC9fVYCbQ+GYNIQJ8pVCpWbXZH0musuCY+7kr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IL8Ohxa7; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250220072235epoutp042c8e05ad67ac3eac868b375050ee22b9~l2aoSV67E0422404224epoutp04H
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 07:22:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250220072235epoutp042c8e05ad67ac3eac868b375050ee22b9~l2aoSV67E0422404224epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740036155;
	bh=Wzk9sm9BVeLZ5VqQg425SUfCAuS8FC0ifKJugYIJQEk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=IL8Ohxa7y/a/rL90jLjTa707OUcgs2LZ64D9WoJGmD1+bof0u77TlKXjMpOf3TMJh
	 i56beNbxaUWExBGGATgRvwOjRgX2EtsLoSbcXDIz3hp1uSoGrig890T08RGrnvWwoc
	 XwrJ1PIUaIc3eARaB4cICW2jwhc5BQGMc8CfK4a4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250220072235epcas5p18eafd75868a97ee09f1340b05b9afd0a~l2an1VFZp1361013610epcas5p1B;
	Thu, 20 Feb 2025 07:22:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yz4Th746bz4x9QG; Thu, 20 Feb
	2025 07:22:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	95.06.19933.838D6B76; Thu, 20 Feb 2025 16:22:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250220061439epcas5p3a6a01825c005d0fa2b8cae1eb8a484f2~l1fUiG4sB1105511055epcas5p3O;
	Thu, 20 Feb 2025 06:14:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250220061439epsmtrp21edab93c84b0abc6507c10474ed751c1~l1fUhL4xU2724127241epsmtrp2T;
	Thu, 20 Feb 2025 06:14:39 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-06-67b6d8380da1
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	11.31.23488.F48C6B76; Thu, 20 Feb 2025 15:14:39 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250220061437epsmtip15671c13e41e9c2b6e9ac2261ed6b0865~l1fSFGWVo0755107551epsmtip1G;
	Thu, 20 Feb 2025 06:14:37 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@Huawei.com>, <fan.ni@samsung.com>, <nifan.cxl@gmail.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>, <cassel@kernel.org>,
	<18255117159@163.com>, <quic_nitegupt@quicinc.com>,
	<quic_krichai@quicinc.com>, <gost.dev@samsung.com>
In-Reply-To: <20250218144126.5kapvjj4e64bamvi@thinkpad>
Subject: RE: [PATCH v6 1/4] PCI: dwc: Add support for vendor specific
 capability search
Date: Thu, 20 Feb 2025 11:44:36 +0530
Message-ID: <02de01db835e$b94171c0$2bc45540$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHuuUhNCfQ5HYQc9eUwRFty5EaEfAHfdYwuAdtxeXsCBP6f1LL7SC1w
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd3p7bwuzcC0aDzi0u47J2xYBL4uIIiE3simLW/ZgGXZw1zL6
	Sm+ZY38oo/VR4gOigjDG2rVhXScPkVddaxAUAbfEDSSrWgKmwtRhGBAcAeYoFzb++/we3/M9
	v/PgI0IvFsLPU+lorUqqIDB/bmtXxNYY8vdWmdjQtZ0cODHHIyu6XiWtxXKyu9SGkMU/elDS
	3eHgkLbpSh5pNw9iZNGpOZTsv1qNkb/U3MJIw7yBS3oMRpRcaHUB8ruWaR45PFxIGqtvIOQL
	Zztvt5Cy2M6jlKPKw6NMTQWU4cY4SjXZjRj1YNCJUd6BCg5V5jxCnWm2A2qqaVOm/4f5O+W0
	NJfWimhVjjo3TyVLJjIOZu/NTkgUS2IkSeQOQqSSKulkIu3NzJj0PMXiRIToc6miYDGVKWUY
	YtuunVp1gY4WydWMLpmgNbkKTbwmlpEqmQKVLFZF696QiMVxCYuNh/LlT02TQNOy+YuOcT1W
	BFpDSoAfH+LxcKrcipUAf74Q/wlAy1d1HDaYBPD72d9QNpgB8GH5BXRFMnfu0rLEBWCbvQzx
	FYT4HwAWu5YYw6Ohd2B+idfhu+GJ8UmuT4DgbQhsaDzO8RX88B3QeX8ElAA+Pwj/ALq+pXxp
	Lh4GG/4ewHwswJNgx5NfUZbXwt5KL9fHCB4Fa81PEXZDIjj7qBZlvdJh4/WTGNuzAd6cPbXc
	84IPj5Vu8llBPA0a/2TYdBB8cquZx3IInHrmwliWwR+uXFyWKuDMFSuH5RTYMVDN9S2D4BGw
	4eo2Nh0KL/TVc1jXAHh6zrvcLoDtNSu8BU4vOLksB8Oa7n60FBBVqwarWjVY1aoBqv53MwGu
	HQTTGkYpo5kETZyKPvzfdeeolU1g6blH7msHI8MTsZ2AwwedAPIRYp3g+NFmmVCQKy38ktaq
	s7UFCprpBAmLp12GhKzPUS/+F5UuWxKfJI5PTEyMT9qeKCE2CPQOg0yIy6Q6Op+mNbR2Rcfh
	+4UUcTJ3obYHJ/Uaz/myDES7dRrbHzU61tj9rOhA31xYzKBu32vGjMuBC2+v//RcXcdn+o/d
	872S+pvuHsmwSR18R9H+j6k89V7aX9bQ2w9TAsf0R+XutmP5oo3Xfs46mz9vNkZgjyVhvYfH
	L3ocrxvXBIr3XltQRCbJHLWfbK7QWB4HuEfPpO4Zin5P/Hzi0dq3xnu6wkaHAmVNB/FD6SLl
	gS33Zu6+HGfUaLXz0bXmdHnWuwn96e8Inxc2W95vztNbwmNvu76ZHbmO3HU6joxNbFSaswT3
	Cz1fn7XVW3PXTNUJTod+lFI5VBkQJL8s6dn/Uh/Xcik8/JXW9qg7eS0L6ml7agnBZeRSSSSi
	ZaT/AhCv4Kp3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCSnK7/iW3pBh2NuhZX2n+zW0w/rGix
	pCnD4tiEFcwWTavvslrcPLCTyWLFl5nsFqsWXmOzaOj5zWpxedccNouz846zWbT8aWGxuNvS
	yWrxd9teRotFW7+wWzx4UGnROecIs8X/PTvYHYQ8Fq+Ywuqxc9Zddo8Fm0o9Wo68ZfXYtKqT
	zePOtT1sHk+uTGfymLinzqNvyypGj8+b5AK4orhsUlJzMstSi/TtErgyNn38x1TwQq5i/oqq
	BsY7kl2MnBwSAiYSvyevYQOxhQR2M0rcn6INEZeU+HxxHROELSyx8t9z9i5GLqCaZ4wSM6Yc
	AUuwCehIPLnyhxnEFhFwkGh/+4kFpIhZ4DSzxOEH7xE6Wmf8BKviFDCX2HP7ISOILSwQLrFl
	WTc7iM0ioCqx/scVsDN4BSwlDry6yAphC0qcnPmEBcRmFtCW6H3YyghjL1v4mhniPAWJn0+X
	sUJc4Sax4WAHG0SNuMTRnz3MExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6yYYFhXmq5
	XnFibnFpXrpecn7uJkZwlGtp7GB8961J/xAjEwfjIUYJDmYlEd62+i3pQrwpiZVVqUX58UWl
	OanFhxilOViUxHlXGkakCwmkJ5akZqemFqQWwWSZODilGpgM2M7WfF57UfsbN5uN04Vg/70H
	lk/ICM1QONy/91anzYRl8s8qC/4nHbRN7d8jErlSbhnb0gNHQxv5ugJFn77++uDpdweWs77v
	jb+fYY98v0llonfQA8X1D8Lf3zWLPKO2kO31TbW2d7/EhY8vzFkv9zT+14QP5Xw15Saia1wC
	F8buP31rtv7BJxUrM8836VgccitU3hQ5KedTYNWG9rCoVVmha5b4iTRbG7PfT6ng2bKSYY2P
	hJe8ErPqjyb+JImQPcm+7PF6zZzPNbsuZqQrpMtKPX23b1nqpRP1ohvu1C2+KFS58YvnnodZ
	MmGrF3Glaxn+EXApL7wt5ai1SX6GkOoaB5mVe994OTi1GyqxFGckGmoxFxUnAgDN4JnGYQMA
	AA==
X-CMS-MailID: 20250220061439epcas5p3a6a01825c005d0fa2b8cae1eb8a484f2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889
References: <20250214105007.97582-1-shradha.t@samsung.com>
	<CGME20250214105337epcas5p3a385fdb0bd03c3887df5c31037f47889@epcas5p3.samsung.com>
	<20250214105007.97582-2-shradha.t@samsung.com>
	<20250218144126.5kapvjj4e64bamvi@thinkpad>



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> Sent: 18 February 2025 20:11
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-kernel=40vger.kernel.org; linux-pci=40vger.kernel.org; lpierali=
si=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; jingoohan1=40gmail.com; Jonathan.Cameron=40Huawei.=
com; fan.ni=40samsung.com; nifan.cxl=40gmail.com;
> a.manzanares=40samsung.com; pankaj.dubey=40samsung.com; cassel=40kernel.o=
rg; 18255117159=40163.com;
> quic_nitegupt=40quicinc.com; quic_krichai=40quicinc.com; gost.dev=40samsu=
ng.com
> Subject: Re: =5BPATCH v6 1/4=5D PCI: dwc: Add support for vendor specific=
 capability search
>=20
> On Fri, Feb 14, 2025 at 04:20:04PM +0530, Shradha Todi wrote:
> > Add vendor specific extended configuration space capability search API
> > using struct dw_pcie pointer for DW controllers.
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
>=20
> I took this patch and modified to pass the 'struct dwc_pcie_vsec_id' to t=
he API to simplify the callers:
> https://lore.kernel.org/linux-pci/20250218-pcie-qcom-ptm-v1-2-16d7e480d73=
e=40linaro.org
>=20
> - Mani
>=20

I saw the series. I'm okay to move that to a common header file to avoid du=
plication but I feel that this movement will
cause my patch to become dependent on your PTM series. Since that series in=
 still in v1 stage and mine is already in v6,
I feel the debugfs patchset will get further delayed. If you are okay, I co=
uld take in the changes as part of v7 after waiting
for some more reviews. Or, the debugfs patches could be reviewed as it is, =
and the changes or movement could go on top
of that?

> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c =7C 19 ++++++++++++++++++=
+
> > drivers/pci/controller/dwc/pcie-designware.h =7C  1 +
> >  2 files changed, 20 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c
> > b/drivers/pci/controller/dwc/pcie-designware.c
> > index 6d6cbc8b5b2c..3588197ba2d7 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > =40=40 -277,6 +277,25 =40=40 static u16 dw_pcie_find_next_ext_capabilit=
y(struct dw_pcie *pci, u16 start,
> >  	return 0;
> >  =7D
> >
> > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
> > +u16 vsec_cap) =7B
> > +	u16 vsec =3D 0;
> > +	u32 header;
> > +
> > +	if (vendor_id =21=3D dw_pcie_readw_dbi(pci, PCI_VENDOR_ID))
> > +		return 0;
> > +
> > +	while ((vsec =3D dw_pcie_find_next_ext_capability(pci, vsec,
> > +					PCI_EXT_CAP_ID_VNDR))) =7B
> > +		header =3D dw_pcie_readl_dbi(pci, vsec + PCI_VNDR_HEADER);
> > +		if (PCI_VNDR_HEADER_ID(header) =3D=3D vsec_cap)
> > +			return vsec;
> > +	=7D
> > +
> > +	return 0;
> > +=7D
> > +EXPORT_SYMBOL_GPL(dw_pcie_find_vsec_capability);
> > +
> >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap)  =7B
> >  	return dw_pcie_find_next_ext_capability(pci, 0, cap); diff --git
> > a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 347ab74ac35a..02e94bd9b042 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > =40=40 -476,6 +476,7 =40=40 void dw_pcie_version_detect(struct dw_pcie =
*pci);
> >
> >  u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
> >  u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
> > +u16 dw_pcie_find_vsec_capability(struct dw_pcie *pci, u16 vendor_id,
> > +u16 vsec_cap);
> >
> >  int dw_pcie_read(void __iomem *addr, int size, u32 *val);  int
> > dw_pcie_write(void __iomem *addr, int size, u32 val);
> > --
> > 2.17.1
> >
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A

