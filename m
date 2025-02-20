Return-Path: <linux-pci+bounces-21886-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474EA3D474
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 10:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1093B7E9C
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2025 09:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FC1C3C1F;
	Thu, 20 Feb 2025 09:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JC7aHGbA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD94B1BC09A
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 09:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043201; cv=none; b=KfHM77JTnOaZlFT6ZkcXjgEsgX8gug+2w84073EW+jI8dmyZvAKwgu1OKqnUK6GriuQeIbVNXxvhh932YfRxowbMKpX2gGsmTrt3/jeyzrJDjojo6Q84fryV/XJYbiKat4vEePxbLtvWQEzvCEmzqfjsB8cRyKO/1+l1IS0Rshk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043201; c=relaxed/simple;
	bh=servypCfrG50zrbkz3KzL/jJhdt/ydaogXCyuC+62p4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=bumYuzttTev1a6kYfHXC9lMoW9P28EAhG1ZzeyBzvN/CG/t0hhgBspBlotAQ4XqIlNQD+RJ6BbckJTmnPscgnoYh5U3SyI8PuVHi9oFnj8azVVhxkJEJ+YCaOsE8va203GjQ4uBQsEQCMXHLALat8uP4KhT7mBDnrRXcC+Pd1dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JC7aHGbA; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250220091956epoutp01ac5e37cdf7b105fbdd7ae34711fd03a7~l4BF4Cm2k0723807238epoutp01a
	for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2025 09:19:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250220091956epoutp01ac5e37cdf7b105fbdd7ae34711fd03a7~l4BF4Cm2k0723807238epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740043196;
	bh=h+HMJnPQAIMLPApV/z/JB/GWHHJPk4CUu2mrLER1NYQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=JC7aHGbAYUvklU9HMOmfXJLt208/RMVYyLuavuYP+M3+aVL8IulID1U0PzdfoZ0/w
	 MYCIJ6JNpWqlyrVMZPJWQ4EW/HYmj3YD10chySKWRXSeQ8GjjCUBDJFbtCbNR7Qa1c
	 3Xp2Me3K1UrsWOc55gHXd6c3WY3EqM5UStwqJPU0=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250220091955epcas5p10621655837b8365a687425ca8e52398b~l4BFHI2iC0827708277epcas5p1E;
	Thu, 20 Feb 2025 09:19:55 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Yz7556pflz4x9Pp; Thu, 20 Feb
	2025 09:19:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8F.74.20052.9B3F6B76; Thu, 20 Feb 2025 18:19:53 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250220091816epcas5p1462401c771d1f3b0e0022408eb520ff0~l3-o1TQ1Y2371623716epcas5p1Y;
	Thu, 20 Feb 2025 09:18:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250220091816epsmtrp2359fe19395cafff3e72945bb7385b2e0~l3-o0VFRX0599205992epsmtrp2U;
	Thu, 20 Feb 2025 09:18:16 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-f4-67b6f3b96a32
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	62.7B.18729.853F6B76; Thu, 20 Feb 2025 18:18:16 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250220091814epsmtip14f2f38a73e463bdf632787bb177c598c~l3-mVPKk92530425304epsmtip1z;
	Thu, 20 Feb 2025 09:18:13 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@Huawei.com>, <fan.ni@samsung.com>, <nifan.cxl@gmail.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>, <cassel@kernel.org>,
	<18255117159@163.com>, <quic_nitegupt@quicinc.com>,
	<quic_krichai@quicinc.com>, <gost.dev@samsung.com>
In-Reply-To: <20250218150239.mnylvhyfnw6dtzag@thinkpad>
Subject: RE: [PATCH v6 2/4] Add debugfs based silicon debug support in DWC
Date: Thu, 20 Feb 2025 14:48:12 +0530
Message-ID: <02f501db8378$5fce2060$1f6a6120$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHuuUhNCfQ5HYQc9eUwRFty5EaEfAH6I/DhAZxdZp0CAfD9vrL8kWSg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGJsWRmVeSWpSXmKPExsWy7bCmpu7Oz9vSDea0mFlcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgdxDyWLxiCqvHzll32T0WbCr1aDnyltVj06pO
	No871/aweTy5Mp3JY+KeOo++LasYPT5vkgvgisq2yUhNTEktUkjNS85PycxLt1XyDo53jjc1
	MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6SEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5Ra
	kJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnbHqxXzmgoaaisWz17E2MJ5K6WLk5JAQMJGY
	+LuLsYuRi0NIYDejxIsNj1ghnE+MEh/O32SCcL4xSjz6MYUZpuXPih0sEIm9jBK9f5ugWl4w
	Svx5No0dpIpNQEfiyZU/YB0iAg4S7W8/gXUwC2xnlli/oY0JJMEpYC4x9dMqti5GDg5hAS+J
	6d0OIGEWAVWJ3+sugfXyClhKbD51jh3CFpQ4OfMJC4jNLKAtsWzha6iLFCR+Pl3GCrHLTeLU
	p33sEDXiEkd/9kDV/OeQ+DLfDMJ2kWjsX8MKYQtLvDq+hR3ClpL4/G4vG4SdLrFy8wyo3hyJ
	b5uXMEHY9hIHrsxhATmZWUBTYv0ufYiwrMTUU+uYINbySfT+fgJVziuxYx6MrSzx5e8eFghb
	UmLescusExiVZiH5bBaSz2Yh+WAWwrYFjCyrGCVTC4pz01OLTQsM81LL4RGenJ+7iRGc4LU8
	dzDeffBB7xAjEwfjIUYJDmYlEd62+i3pQrwpiZVVqUX58UWlOanFhxhNgcE9kVlKNDkfmGPy
	SuINTSwNTMzMzEwsjc0MlcR5m3e2pAsJpCeWpGanphakFsH0MXFwSjUw1QYvPXfg+ZxAnZq7
	7hVOkUtLir7Kh/7VVlX+Hf5J4f/luuVCPPue1GwqEat1UOOr4P1t0t5Y0/ynI8j33dfVi1ID
	Tm19tX3Nx4eHyuYFHVQN7Uj40cN3tuz+itiXk4JbWGXytTN57J2uXJ6nW/iWMfLvbkvjnWcf
	PJOdO/v1G/mnVw775K7SmHxES+8ak5n99tmlHas0Fc5X+H1Jy/vN9Yc1aPG9ZxrPvwe7tmh9
	nXzRRu9t+Yt0l03Gb4R7ZNpXXDi2ofpY5DRf48cfCmWFTpyo21mw4UnxB0GBH9NUH9auPLj8
	1PWMnrafXJEbtLM5N9/0jJq866vv8ryYqbcN88s+Tbyxk6Mwsz/Me8MSXiWW4oxEQy3mouJE
	APpM+195BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSnG7E523pBvPXKFtcaf/NbjH9sKLF
	kqYMi2MTVjBbNK2+y2px88BOJosVX2ayW6xaeI3NoqHnN6vF5V1z2CzOzjvOZtHyp4XF4m5L
	J6vF3217GS0Wbf3CbvHgQaVF55wjzBb/9+xgdxDyWLxiCqvHzll32T0WbCr1aDnyltVj06pO
	No871/aweTy5Mp3JY+KeOo++LasYPT5vkgvgiuKySUnNySxLLdK3S+DKmH5iAXvBxMqKuzN3
	szQwHkvsYuTkkBAwkfizYgdLFyMXh5DAbkaJ/RubmCESkhKfL65jgrCFJVb+e84OUfSMUWLz
	pzdsIAk2AR2JJ1f+gDWICDhItL/9BDaJWeA0s8ThB+8ROhq3HwDr4BQwl5j6aRWQzcEhLOAl
	Mb3bASTMIqAq8XvdJbBBvAKWEptPnWOHsAUlTs58wgJiMwtoS/Q+bGWEsZctfA11qYLEz6fL
	WCGOcJM49WkfO0SNuMTRnz3MExiFZyEZNQvJqFlIRs1C0rKAkWUVo2RqQXFuem6xYYFhXmq5
	XnFibnFpXrpecn7uJkZwnGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrxt9VvShXhTEiurUovy44tK
	c1KLDzFKc7AoifOKv+hNERJITyxJzU5NLUgtgskycXBKNTB5XcgVUlnaXF0ambH76tXnZ/Q4
	DR8uCq1+oPBz2cG7ypYy5V3PunhEX4n8VVxQEye42Yy5KaKA5+LK/9fXMHS2+ExfpXX28IFy
	oU97Vur9mMqx4NGlX0aNOzzu6vfoxalFGz8RNZyVvmlu3elO5gV3+8Lm33eceut1s17nd9Uv
	8+7fa1ZdJ7xPz3vV68P13/TDixn3KV+e8M7+tM+kwweWp/z45XYndMvTqhP/Tk06s8E3r8JZ
	rv2l41TXvV8C2bmnpLv8E0oqz3i3rU9WgnPCL5dTXIqx7XGngx/f9F+xnqM+IWdVkpvTGrXd
	Wk+5E1//cp9swtO0VvZxShznjxlCq4PnzGxnD+X92i/X+opfiaU4I9FQi7moOBEAWe1fC2ID
	AAA=
X-CMS-MailID: 20250220091816epcas5p1462401c771d1f3b0e0022408eb520ff0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8
References: <20250214105007.97582-1-shradha.t@samsung.com>
	<CGME20250214105341epcas5p11ea07dba0a55700bc098077eb53e79b8@epcas5p1.samsung.com>
	<20250214105007.97582-3-shradha.t@samsung.com>
	<20250218150239.mnylvhyfnw6dtzag@thinkpad>



> -----Original Message-----
> From: Manivannan Sadhasivam <manivannan.sadhasivam=40linaro.org>
> Sent: 18 February 2025 20:33
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: linux-kernel=40vger.kernel.org; linux-pci=40vger.kernel.org; lpierali=
si=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; jingoohan1=40gmail.com; Jonathan.Cameron=40Huawei.=
com; fan.ni=40samsung.com; nifan.cxl=40gmail.com;
> a.manzanares=40samsung.com; pankaj.dubey=40samsung.com; cassel=40kernel.o=
rg; 18255117159=40163.com;
> quic_nitegupt=40quicinc.com; quic_krichai=40quicinc.com; gost.dev=40samsu=
ng.com
> Subject: Re: =5BPATCH v6 2/4=5D Add debugfs based silicon debug support i=
n DWC
>=20
> On Fri, Feb 14, 2025 at 04:20:05PM +0530, Shradha Todi wrote:
> > Add support to provide silicon debug interface to userspace. This set
> > of debug registers are part of the RASDES feature present in
> > DesignWare PCIe controllers.
> >
> > Signed-off-by: Shradha Todi <shradha.t=40samsung.com>
> > ---
> >  Documentation/ABI/testing/debugfs-dwc-pcie    =7C  13 ++
> >  drivers/pci/controller/dwc/Kconfig            =7C  10 +
> >  drivers/pci/controller/dwc/Makefile           =7C   1 +
> >  .../controller/dwc/pcie-designware-debugfs.c  =7C 207 ++++++++++++++++=
++
> >  .../pci/controller/dwc/pcie-designware-ep.c   =7C   5 +
> >  .../pci/controller/dwc/pcie-designware-host.c =7C   6 +
> >  drivers/pci/controller/dwc/pcie-designware.h  =7C  20 ++
> >  7 files changed, 262 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
> >  create mode 100644
> > drivers/pci/controller/dwc/pcie-designware-debugfs.c
> >
> > diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie
> > b/Documentation/ABI/testing/debugfs-dwc-pcie
> > new file mode 100644
> > index 000000000000..e8ed34e988ef
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> > =40=40 -0,0 +1,13 =40=40
> > +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
> > +Date:		Feburary 2025
>=20
> Please align these fields

The fields are already aligned in my patch (when I check in git), not sure =
why the mail misaligns it. Can you suggest how
should I fix this?

>=20
> > +Contact:	Shradha Todi <shradha.t=40samsung.com>
> > +Description:	(RW) Write the lane number to be checked for detection.	R=
ead
> > +		will return whether PHY indicates receiver detection on the
> > +		selected lane. The default selected lane is Lane0.
> > +
> > +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
> > +Date:		Feburary 2025
> > +Contact:	Shradha Todi <shradha.t=40samsung.com>
> > +Description:	(RW) Write the lane number to be checked as valid or inva=
lid. Read
> > +		will return the status of PIPE RXVALID signal of the selected lane.
> > +		The default selected lane is Lane0.
> > diff --git a/drivers/pci/controller/dwc/Kconfig
> > b/drivers/pci/controller/dwc/Kconfig
> > index b6d6778b0698..48a10428a492 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > =40=40 -6,6 +6,16 =40=40 menu =22DesignWare-based PCIe controllers=22
> >  config PCIE_DW
> >  	bool
> >
> > +config PCIE_DW_DEBUGFS
> > +	default y
> > +	depends on DEBUG_FS
> > +	depends on PCIE_DW_HOST =7C=7C PCIE_DW_EP
> > +	bool =22DWC PCIe debugfs entries=22
> > +	help
> > +	  Enables debugfs entries for the DW PCIe Controller. These entries
> > +	  provide all debug features related to DW controller including the R=
AS
> > +	  DES features to help in debug, error injection and statistical coun=
ters.
> > +
> >  config PCIE_DW_HOST
> >  	bool
> >  	select PCIE_DW
> > diff --git a/drivers/pci/controller/dwc/Makefile
> > b/drivers/pci/controller/dwc/Makefile
> > index a8308d9ea986..54565eedc52c 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > =40=40 -1,5 +1,6 =40=40
> >  =23 SPDX-License-Identifier: GPL-2.0
> >  obj-=24(CONFIG_PCIE_DW) +=3D pcie-designware.o
> > +obj-=24(CONFIG_PCIE_DW_DEBUGFS) +=3D pcie-designware-debugfs.o
> >  obj-=24(CONFIG_PCIE_DW_HOST) +=3D pcie-designware-host.o
> >  obj-=24(CONFIG_PCIE_DW_EP) +=3D pcie-designware-ep.o
> >  obj-=24(CONFIG_PCIE_DW_PLAT) +=3D pcie-designware-plat.o diff --git
> > a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > new file mode 100644
> > index 000000000000..fe799d36fa7f
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > =40=40 -0,0 +1,207 =40=40
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Synopsys DesignWare PCIe controller debugfs driver
> > + *
> > + * Copyright (C) 2025 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * Author: Shradha Todi <shradha.t=40samsung.com>  */
> > +
> > +=23include <linux/debugfs.h>
> > +
> > +=23include =22pcie-designware.h=22
> > +
> > +=23define SD_STATUS_L1LANE_REG		0xb0
> > +=23define PIPE_RXVALID			BIT(18)
> > +=23define PIPE_DETECT_LANE		BIT(17)
> > +=23define LANE_SELECT			GENMASK(3, 0)
> > +
> > +=23define DWC_DEBUGFS_BUF_MAX		128
> > +
> > +struct dwc_pcie_vsec_id =7B
> > +	u16 vendor_id;
> > +	u16 vsec_id;
> > +	u8 vsec_rev;
> > +=7D;
> > +
> > +/*
> > + * VSEC IDs are allocated by the vendor, so a given ID may mean
> > +different
> > + * things to different vendors. See PCIe r6.0, sec 7.9.5.2.
> > + */
> > +static const struct dwc_pcie_vsec_id dwc_pcie_vsec_ids=5B=5D =3D =7B
> > +	=7B .vendor_id =3D PCI_VENDOR_ID_ALIBABA,
> > +		.vsec_id =3D 0x02, .vsec_rev =3D 0x4 =7D,
> > +	=7B .vendor_id =3D PCI_VENDOR_ID_AMPERE,
> > +		.vsec_id =3D 0x02, .vsec_rev =3D 0x4 =7D,
> > +	=7B .vendor_id =3D PCI_VENDOR_ID_QCOM,
> > +		.vsec_id =3D 0x02, .vsec_rev =3D 0x4 =7D,
> > +	=7B .vendor_id =3D PCI_VENDOR_ID_SAMSUNG,
> > +		.vsec_id =3D 0x02, .vsec_rev =3D 0x4 =7D,
> > +	=7B=7D /* terminator */
>=20
> This should go into the common include file as I proposed in my series:
> https://lore.kernel.org/linux-pci/20250218-pcie-qcom-ptm-v1-1-16d7e480d73=
e=40linaro.org/
>=20
> > +=7D;
> > +
> > +/**
> > + * struct dwc_pcie_rasdes_info - Stores controller common information
> > + * =40ras_cap_offset: RAS DES vendor specific extended capability
> > +offset
> > + * =40reg_lock: Mutex used for RASDES shadow event registers
>=20
> If this is not used by all register accesses, please rename it as such. L=
ike, reg_event_lock.
>

Will fix in next version
=20
> > + *
> > + * Any parameter constant to all files of the debugfs hierarchy for a
> > +single controller
> > + * will be stored in this struct. It is allocated and assigned to
> > +controller specific
> > + * struct dw_pcie during initialization.
> > + */
> > +struct dwc_pcie_rasdes_info =7B
> > +	u32 ras_cap_offset;
> > +	struct mutex reg_lock;
> > +=7D;
> > +
> > +static ssize_t lane_detect_read(struct file *file, char __user *buf,
> > +size_t count, loff_t *ppos) =7B
> > +	struct dw_pcie *pci =3D file->private_data;
> > +	struct dwc_pcie_rasdes_info *rinfo =3D pci->debugfs->rasdes_info;
> > +	char debugfs_buf=5BDWC_DEBUGFS_BUF_MAX=5D;
> > +	ssize_t off =3D 0;
>=20
> Not required. See below.
>=20
> > +	u32 val;
> > +
> > +	val =3D dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LA=
NE_REG);
> > +	val =3D FIELD_GET(PIPE_DETECT_LANE, val);
> > +	if (val)
> > +		off +=3D scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, =22Lane
> > +Detected=5Cn=22);
>=20
> I don't understand why you want to add 'off' which was initialized to 0. =
Also this just prints single string.
>=20

Okay will change it everywhere.

> > +	else
> > +		off +=3D scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, =22Lane
> > +Undetected=5Cn=22);
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> > +=7D
> > +
> > +static ssize_t lane_detect_write(struct file *file, const char __user =
*buf,
> > +				 size_t count, loff_t *ppos)
> > +=7B
> > +	struct dw_pcie *pci =3D file->private_data;
> > +	struct dwc_pcie_rasdes_info *rinfo =3D pci->debugfs->rasdes_info;
> > +	u32 lane, val;
> > +
> > +	val =3D kstrtou32_from_user(buf, count, 0, &lane);
> > +	if (val)
> > +		return val;
> > +
> > +	val =3D dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LA=
NE_REG);
> > +	val &=3D =7E(LANE_SELECT);
> > +	val =7C=3D FIELD_PREP(LANE_SELECT, lane);
> > +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
> > +SD_STATUS_L1LANE_REG, val);
> > +
> > +	return count;
> > +=7D
> > +
> > +static ssize_t rx_valid_read(struct file *file, char __user *buf,
> > +size_t count, loff_t *ppos) =7B
> > +	struct dw_pcie *pci =3D file->private_data;
> > +	struct dwc_pcie_rasdes_info *rinfo =3D pci->debugfs->rasdes_info;
> > +	char debugfs_buf=5BDWC_DEBUGFS_BUF_MAX=5D;
> > +	ssize_t off =3D 0;
> > +	u32 val;
> > +
> > +	val =3D dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LA=
NE_REG);
> > +	val =3D FIELD_GET(PIPE_RXVALID, val);
> > +	if (val)
> > +		off +=3D scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, =22RX
> > +Valid=5Cn=22);
>=20
> Same here.
>=20
> > +	else
> > +		off +=3D scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, =22RX
> > +Invalid=5Cn=22);
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> > +=7D
> > +
> > +static ssize_t rx_valid_write(struct file *file, const char __user
> > +*buf, size_t count, loff_t *ppos) =7B
> > +	return lane_detect_write(file, buf, count, ppos); =7D
> > +
> > +=23define dwc_debugfs_create(name)			=5C
> > +debugfs_create_file(=23name, 0644, rasdes_debug, pci,	=5C
> > +			&dbg_ =23=23 name =23=23 _fops)
> > +
> > +=23define DWC_DEBUGFS_FOPS(name)					=5C
> > +static const struct file_operations dbg_ =23=23 name =23=23 _fops =3D =
=7B	=5C
> > +	.open =3D simple_open,				=5C
> > +	.read =3D name =23=23 _read,				=5C
> > +	.write =3D name =23=23 _write				=5C
> > +=7D
> > +
> > +DWC_DEBUGFS_FOPS(lane_detect);
> > +DWC_DEBUGFS_FOPS(rx_valid);
> > +
> > +static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci) =7B
> > +	struct dwc_pcie_rasdes_info *rinfo =3D pci->debugfs->rasdes_info;
> > +
> > +	mutex_destroy(&rinfo->reg_lock);
> > +=7D
> > +
> > +static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct
> > +dentry *dir) =7B
> > +	struct dentry *rasdes_debug;
> > +	struct dwc_pcie_rasdes_info *rasdes_info;
> > +	const struct dwc_pcie_vsec_id *vid;
> > +	struct device *dev =3D pci->dev;
> > +	int ras_cap;
> > +
> > +	for (vid =3D dwc_pcie_vsec_ids; vid->vendor_id; vid++) =7B
> > +		ras_cap =3D dw_pcie_find_vsec_capability(pci, vid->vendor_id,
> > +							vid->vsec_id);
> > +		if (ras_cap)
> > +			break;
> > +	=7D
> > +	if (=21ras_cap) =7B
> > +		dev_dbg(dev, =22no rasdes capability available=5Cn=22);
> > +		return -ENODEV;
> > +	=7D
>=20
> This will also go inside a new API, dw_pcie_find_rasdes_capability(pci).
>=20

Okay, are we planning to make a function for each VSEC? Or should we just p=
ass the rasdes_vids to the
dw_pcie_find_vsec_capability?

> > +
> > +	rasdes_info =3D devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
> > +	if (=21rasdes_info)
> > +		return -ENOMEM;
> > +
> > +	/* Create subdirectories for Debug, Error injection, Statistics */
> > +	rasdes_debug =3D debugfs_create_dir(=22rasdes_debug=22, dir);
>=20
> _debug prefix is not needed since the directory itself belongs to debugfs=
.
>=20

It's not for the debug in debugfs. So the DES features are
Debug
Error Injection
Statistics.
The debug here is for the =22D=22 in DES.

> > +
> > +	mutex_init(&rasdes_info->reg_lock);
> > +	rasdes_info->ras_cap_offset =3D ras_cap;
> > +	pci->debugfs->rasdes_info =3D rasdes_info;
> > +
> > +	/* Create debugfs files for Debug subdirectory */
> > +	dwc_debugfs_create(lane_detect);
> > +	dwc_debugfs_create(rx_valid);
> > +
> > +	return 0;
> > +=7D
> > +
> > +void dwc_pcie_debugfs_deinit(struct dw_pcie *pci) =7B
> > +	dwc_pcie_rasdes_debugfs_deinit(pci);
> > +	debugfs_remove_recursive(pci->debugfs->debug_dir);
> > +=7D
> > +
> > +int dwc_pcie_debugfs_init(struct dw_pcie *pci) =7B
> > +	char dirname=5BDWC_DEBUGFS_BUF_MAX=5D;
> > +	struct device *dev =3D pci->dev;
> > +	struct debugfs_info *debugfs;
> > +	struct dentry *dir;
> > +	int ret;
> > +
> > +	/* Create main directory for each platform driver */
> > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, =22dwc_pcie_%s=22, dev_name(de=
v));
> > +	dir =3D debugfs_create_dir(dirname, NULL);
> > +	if (IS_ERR(dir))
> > +		return PTR_ERR(dir);
>=20
> debugfs creation is not supposed to fail. So you should remove the error =
check.
>=20

There was no error check until v3. Got a comment from Jonathan in v3:
	=22Check for errors in all these.=22
I think he wanted to add in all the debugfs creations but I just added in t=
he topmost directory.
I checked that error will be returned in case someone turns off debugfs mou=
nting as early param.
So, if the first directory gets made, there would be no issues in subsequen=
t subdirectories.

> > +
> > +	debugfs =3D devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > +	if (=21debugfs)
> > +		return -ENOMEM;
> > +
> > +	debugfs->debug_dir =3D dir;
> > +	pci->debugfs =3D debugfs;
> > +	ret =3D dwc_pcie_rasdes_debugfs_init(pci, dir);
> > +	if (ret)
> > +		dev_dbg(dev, =22rasdes debugfs init failed=5Cn=22);
>=20
> RASDES
>=20
> > +
> > +	return 0;
> > +=7D
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index f3ac7d46a855..a87a714bb472 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > =40=40 -642,6 +642,7 =40=40 void dw_pcie_ep_cleanup(struct dw_pcie_ep *=
ep)  =7B
> >  	struct dw_pcie *pci =3D to_dw_pcie_from_ep(ep);
> >
> > +	dwc_pcie_debugfs_deinit(pci);
> >  	dw_pcie_edma_remove(pci);
> >  =7D
> >  EXPORT_SYMBOL_GPL(dw_pcie_ep_cleanup);
> > =40=40 -813,6 +814,10 =40=40 int dw_pcie_ep_init_registers(struct dw_pc=
ie_ep
> > *ep)
> >
> >  	dw_pcie_ep_init_non_sticky_registers(pci);
> >
> > +	ret =3D dwc_pcie_debugfs_init(pci);
> > +	if (ret)
> > +		goto err_remove_edma;
> > +
> >  	return 0;
> >
> >  err_remove_edma:
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c
> > b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index d2291c3ceb8b..6b03ef7fd014 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > =40=40 -524,6 +524,10 =40=40 int dw_pcie_host_init(struct dw_pcie_rp *p=
p)
> >  	if (ret)
> >  		goto err_remove_edma;
> >
> > +	ret =3D dwc_pcie_debugfs_init(pci);
> > +	if (ret)
> > +		goto err_remove_edma;
> > +
>=20
> Why can't you move it to the end of the function?

So the debugfs entries record certain debug values that might be useful to =
read
in case link does not come up. Therefore, I'm adding it before starting lin=
k up so that users can=20
read it in case some failure occurs in further steps.

>=20
> >  	if (=21dw_pcie_link_up(pci)) =7B
> >  		ret =3D dw_pcie_start_link(pci);
> >  		if (ret)
> > =40=40 -571,6 +575,8 =40=40 void dw_pcie_host_deinit(struct dw_pcie_rp =
*pp)
> >
> >  	dw_pcie_stop_link(pci);
> >
> > +	dwc_pcie_debugfs_deinit(pci);
> > +
>=20
> This should be moved to the start of the function.
>=20
> - Mani
>=20
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D=0D=0A=0D=0A

