Return-Path: <linux-pci+bounces-18117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A760F9ECADE
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 12:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F25B2816DF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 11:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808E1EC4E2;
	Wed, 11 Dec 2024 11:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L/4O/Iun"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F851C5CAC
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 11:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733915443; cv=none; b=ZQaORa6zXpT2k4w32N8WITmInr7nOz6oyfMkcgdH4E4UA7UbEO3sEoAQvGHcDjZMM7gwlSyfzSoF4T6nOEHcq+ypciTtC9nPL4OM8tZDxFVJFgze9TaaDnAqRVjGiGps39IueTRbxGWFN5x3j1aRgpjGMV413AaBTgm7ntN1D20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733915443; c=relaxed/simple;
	bh=sP0CBwDC8h6oyLqP0YWRbrFGE1Gih3tU7ePHx2hCOpU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=qgINHYs+LfjRssMPDn7pNRGdBjZJ3n/3T1bjKElRabfrHcKs8wiRJ6LsrIqOPpJxHK6v0Y2qk/Qkp5Jg7hVmCmiLNwd5pJI5CMkroTijJZKluIgxBMgxKtr9FSGjgJVIOBa1sqRT/X60c0pM//gWK4+GnBwxVnj3cr1TOUdTeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=L/4O/Iun; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241211111038epoutp02e74e0542baddc1df2bdcd178759516ec~QGud5H_JA1404114041epoutp02F
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 11:10:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241211111038epoutp02e74e0542baddc1df2bdcd178759516ec~QGud5H_JA1404114041epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733915438;
	bh=k1gxNIHXsKkxq7iCwXRiOf7sm7TQm7qiRGmrtw/idc8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=L/4O/Iun8CX2FaAKk0mHcDPiJK3ggB6GJiWCAlFGE6Dhc8ZAn+57l7TDasE6wLl9u
	 ILZKUFLA3koxTv06N6H1TGgW5K/xDa6/zNo9H7Hw95sataBKDVNAUqH0X8qHAlbXxM
	 ABHikjbE5hMAi89eXmLPReYNo0atKU+uzUXi6o6Q=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241211111037epcas5p131a8ff7f7f7af7b40de6f1f36d681327~QGudZBpOQ2266822668epcas5p1p;
	Wed, 11 Dec 2024 11:10:37 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y7Xvb2Vxwz4x9Px; Wed, 11 Dec
	2024 11:10:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.C7.19710.B2379576; Wed, 11 Dec 2024 20:10:35 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241211110837epcas5p44f5a8bffaac320261b2228923a4281e7~QGstxMHuK0966909669epcas5p4n;
	Wed, 11 Dec 2024 11:08:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241211110837epsmtrp2863c24972e5e1fe06c0949af8b9eacae~QGstwU7-F0095400954epsmtrp2o;
	Wed, 11 Dec 2024 11:08:37 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-7e-6759732bf759
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	45.1C.18729.5B279576; Wed, 11 Dec 2024 20:08:37 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241211110835epsmtip1a515f01b742f376380db2cb242091ea9~QGsrp9YYj1247812478epsmtip1i;
	Wed, 11 Dec 2024 11:08:35 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Fan Ni'" <nifan.cxl@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<manivannan.sadhasivam@linaro.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<Jonathan.Cameron@huawei.com>, <a.manzanares@samsung.com>,
	<pankaj.dubey@samsung.com>, <quic_nitegupt@quicinc.com>,
	<quic_krichai@quicinc.com>, <gost.dev@samsung.com>
In-Reply-To: <Z1dvOn_9_3Y9oRCa@smc-140338-bm01>
Subject: RE: [PATCH v4 2/2] PCI: dwc: Add debugfs based RASDES support in
 DWC
Date: Wed, 11 Dec 2024 16:38:34 +0530
Message-ID: <0d6001db4bbd$06de0f80$149a2e80$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQKcWCCb84Lfm93x1G99wWEikqEDsgFPQDD5AeD2TuECK9NK6bEz4ygA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKJsWRmVeSWpSXmKPExsWy7bCmpq52cWS6wYqJPBbTDytaLGnKsLh5
	YCeTxYovM9ktVi28xmbR0POb1eLyrjlsFmfnHWezaPnTwmJxt6WT1eLvtr2MFou2fmG3ePCg
	0qJzzhFmi/97drA78HvsnHWX3WPBplKPliNvWT02repk87hzbQ+bx5Mr05k8Ju6p8+jbsorR
	4/MmuQDOqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
	HKDrlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYG
	RqZAhQnZGasvXmUtOPuAseLvkv8sDYwnNzN2MXJySAiYSFy/9Ziti5GLQ0hgN6PEi8M3GCGc
	T4wSe9ruQ2W+MUo8PbQfrmX68mZ2iMReRolN218wgySEBF4wStyeygViswnoSDy58gcsLiKg
	IvHjyjKwscwCDcwSl68dZgVJcAroS7x8v4wJxBYW8Je4sGMpWAOLgKrEt9nrwGxeAUuJR+2r
	2SBsQYmTM5+wgNjMAvIS29/OYYa4SEHi59NlrBBxcYmjP3ugFrtJ/DjzkgVksYTAGw6J3TNa
	2SEaXCTm9e5kgbCFJV4d3wIVl5L4/G4vG4SdLrFy8wyoBTkS3zYvYYKw7SUOXJkD1MsBtExT
	Yv0ufYiwrMTUU+uYIG7gk+j9/QSqnFdixzwYW1niy989UGslJeYdu8w6gVFpFpLXZiF5bRaS
	d2YhbFvAyLKKUTK1oDg3PTXZtMAwL7UcHufJ+bmbGMHpW8tlB+ON+f/0DjEycTAeYpTgYFYS
	4b1hH5kuxJuSWFmVWpQfX1Sak1p8iNEUGN4TmaVEk/OBGSSvJN7QxNLAxMzMzMTS2MxQSZz3
	devcFCGB9MSS1OzU1ILUIpg+Jg5OqQYmplbjOed21gr87JFsuO23Vu1XQX6P9U2uW+8T+5OY
	XzNt3p+V9e1z+4RH8/hevLW5lvH5VdeV3ov/yyUuTe267/L6xsFZn1VEb1W2Tqvfr71bx/Ge
	VsSdV/JSm9d23+kR9t54es2HlM2eD1sTOO7tfeswSedTlD6ngFk7/8UPM1/XcCcbCd+28f53
	nsn1suQtzsOcTyJ9XH7N6T6rvGr3sR27VFV/P4w1eucTpGFiNWXL/T2NG8u39FuwO7G2xt90
	O3r7n/CiN0FPNyU8PswSLi64l2WFi+WzyhUXqsu+RJ1fvSrFakGZ6y7+H/8Fly37xV/7Kd16
	XqCgw+agvumKbx4rdKYK972Tn8T6MXXxWiWW4oxEQy3mouJEANvZ1PtoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsWy7bCSnO7Wosh0g8v/ZSymH1a0WNKUYXHz
	wE4mixVfZrJbrFp4jc2ioec3q8XlXXPYLM7OO85m0fKnhcXibksnq8XfbXsZLRZt/cJu8eBB
	pUXnnCPMFv/37GB34PfYOesuu8eCTaUeLUfesnpsWtXJ5nHn2h42jydXpjN5TNxT59G3ZRWj
	x+dNcgGcUVw2Kak5mWWpRfp2CVwZqy9eZS04+4Cx4u+S/ywNjCc3M3YxcnJICJhITF/ezN7F
	yMUhJLCbUeLl4xmsEAlJic8X1zFB2MISK/89hyp6xijxeVMrWIJNQEfiyZU/zCC2iICKxI8r
	yxhBipgFJjBLTHsD4QgJ3GOU+LT1C9hYTgF9iZfvl4F1Cwv4Siy+d58NxGYRUJX4Nnsd2CRe
	AUuJR+2r2SBsQYmTM5+wdDFyAE3Vk2jbCHY2s4C8xPa3c5ghrlOQ+Pl0GStEXFzi6M8eqIPc
	JH6ceckygVF4FpJJsxAmzUIyaRaS7gWMLKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3
	MYIjWEtzB+P2VR/0DjEycTAeYpTgYFYS4b1hH5kuxJuSWFmVWpQfX1Sak1p8iFGag0VJnFf8
	RW+KkEB6YklqdmpqQWoRTJaJg1Oqgan1pe6soAvyK+5e+VcQeKz/6Fnzvb6zEy5GSq2rPOnS
	vq5rPm+rpTu/TF7tlFZpvuBVO4+esBazdbB7c+1K2uSpF+V+7knR4BPSmrBlV5avqNmt1j1V
	Z9o9pU+bhVtcFPpW+3RKNYtlzve+Lu3HuX87n/74tsXp4SVW/+CP+z/2nN8oUj5732dmp5zK
	rzL9j/PuG7F0Jfj3Xz9bKJj7TCh0wZ9+9WuB194ZbL1wIiuELdZ308Xk1NNm+tl3JtnyfArI
	nPR5f9x5drvNtxrbFVeKTNwf5faVWa1c89CTtMXfuuxP29/Ntf5//nrYz8+XFZaKms88Jv/9
	Yc56YcsFUkpFXUzr9bY2cbirW3v53VNiKc5INNRiLipOBABx6XcLTwMAAA==
X-CMS-MailID: 20241211110837epcas5p44f5a8bffaac320261b2228923a4281e7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241206074242epcas5p35c4db25aade3f328a93475225c170bb7
References: <20241206074456.17401-1-shradha.t@samsung.com>
	<CGME20241206074242epcas5p35c4db25aade3f328a93475225c170bb7@epcas5p3.samsung.com>
	<20241206074456.17401-3-shradha.t@samsung.com>
	<Z1dvOn_9_3Y9oRCa@smc-140338-bm01>



> -----Original Message-----
> From: Fan Ni <nifan.cxl@gmail.com>
> Sent: 10 December 2024 03:59
> To: Shradha Todi <shradha.t@samsung.com>
> Cc: linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org; manivannan.sadhasivam@linaro.org; lpieralisi@kernel.org;
> kw@linux.com; robh@kernel.org; bhelgaas@google.com; jingoohan1@gmail.com; Jonathan.Cameron@huawei.com;
> a.manzanares@samsung.com; pankaj.dubey@samsung.com; quic_nitegupt@quicinc.com; quic_krichai@quicinc.com;
> gost.dev@samsung.com
> Subject: Re: [PATCH v4 2/2] PCI: dwc: Add debugfs based RASDES support in DWC
> 
> On Fri, Dec 06, 2024 at 01:14:56PM +0530, Shradha Todi wrote:
> > Add support to use the RASDES feature of DesignWare PCIe controller
> > using debugfs entries.
> >
> > RASDES is a vendor specific extended PCIe capability which reads the
> > current hardware internal state of PCIe device. Following primary
> > features are provided to userspace via debugfs:
> > - Debug registers
> > - Error injection
> > - Statistical counters
> 
> I think this patch can break into several to make it easier to review.
> For example, it can be divided by the three features list above, with the documentation change coming last as a
separate
> patch.
> 

Sure Fan. I have no issues in breaking this into smaller patches. Though I think the documentation
should go along with the implementation rather than a separate patch?
Anyway, I'll wait for some time for further review comments or if anyone has any objection to
splitting the patches before going for the next revision.

> Some minor comments inline.
> 
> >
> > Signed-off-by: Shradha Todi <shradha.t@samsung.com>
> > ---
> >  Documentation/ABI/testing/debugfs-dwc-pcie    | 143 +++++
> >  drivers/pci/controller/dwc/Kconfig            |  11 +
> >  drivers/pci/controller/dwc/Makefile           |   1 +
> >  .../controller/dwc/pcie-designware-debugfs.c  | 544 ++++++++++++++++++
> >  .../controller/dwc/pcie-designware-debugfs.h  |   0
> >  drivers/pci/controller/dwc/pcie-designware.h  |  17 +
> >  6 files changed, 716 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/debugfs-dwc-pcie
> >  create mode 100644
> > drivers/pci/controller/dwc/pcie-designware-debugfs.c
> >  create mode 100644
> > drivers/pci/controller/dwc/pcie-designware-debugfs.h
> >
> > diff --git a/Documentation/ABI/testing/debugfs-dwc-pcie
> > b/Documentation/ABI/testing/debugfs-dwc-pcie
> > new file mode 100644
> > index 000000000000..7da73ac8d40c
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/debugfs-dwc-pcie
> > @@ -0,0 +1,143 @@
> > +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/lane_detect
> > +Date:		December 2024
> > +Contact:	Shradha Todi <shradha.t@samsung.com>
> > +Description:	(RW) Write the lane number to be checked for detection.	Read
> > +		will dump whether PHY indicates receiver detection on the
> > +		selected lane.
> > +
> > +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_debug/rx_valid
> > +Date:		December 2024
> > +Contact:	Shradha Todi <shradha.t@samsung.com>
> > +Description:	(RW) Write the lane number to be checked as valid or invalid. Read
> > +		will dump the status of PIPE RXVALID signal of the selected lane.
> > +
> > +What:		/sys/kernel/debug/dwc_pcie_<dev>/rasdes_event_counters/<event>/counter_enable
> 
> I think "counter_enable" can be "enable" since the upper directory already shows it is for event counter.
>

Makes sense. I'll fix this in the next patchset.

> > +Date:		December 2024
> > +Contact:	Shradha Todi <shradha.t@samsung.com>
> > +Description:	rasdes_event_counters is the directory which can be used to collect
> > +		statistical data about the number of times a certain event has occurred
> > +		in the controller. The list of possible events are:
> > +
> > +		1) EBUF Overflow
> > +		2) EBUF Underrun
> > +		3) Decode Error
> > +		4) Running Disparity Error
> > +		5) SKP OS Parity Error
> > +		6) SYNC Header Error
> > +		7) Rx Valid De-assertion
> > +		8) CTL SKP OS Parity Error
> > +		9) 1st Retimer Parity Error
> > +		10) 2nd Retimer Parity Error
> > +		11) Margin CRC and Parity Error
> > +		12) Detect EI Infer
> > +		13) Receiver Error
> > +		14) RX Recovery Req
> > +		15) N_FTS Timeout
> > +		16) Framing Error
> > +		17) Deskew Error
> > +		18) Framing Error In L0
> > +		19) Deskew Uncompleted Error
> > +		20) Bad TLP
> > +		21) LCRC Error
> > +		22) Bad DLLP
> > +		23) Replay Number Rollover
> > +		24) Replay Timeout
> > +		25) Rx Nak DLLP
> > +		26) Tx Nak DLLP
> > +		27) Retry TLP
> > +		28) FC Timeout
> > +		29) Poisoned TLP
> > +		30) ECRC Error
> > +		31) Unsupported Request
> > +		32) Completer Abort
> > +		33) Completion Timeout
> > +		34) EBUF SKP Add
> > +		35) EBUF SKP Del
> > +
> > +		counter_enable is RW. Write 1 to enable the event counter and write 0 to
> > +		disable the event counter. Read will dump whether the counter is currently
> > +		enabled	or disabled.
> ...
> > diff --git a/drivers/pci/controller/dwc/Kconfig
> > b/drivers/pci/controller/dwc/Kconfig
> > index b6d6778b0698..9ab8d724fe0d 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -6,6 +6,17 @@ menu "DesignWare-based PCIe controllers"
> >  config PCIE_DW
> >  	bool
> >
> > +config PCIE_DW_DEBUGFS
> > +	default y
> Why we need to enable it by default?
> 

Actually the config depends on debug_fs, so the intention was that if debug_fs and atleast
one DW driver is enabled in the kernel, there should be no harm in enabling this. 

> Fan
> > +	depends on DEBUG_FS
> > +	depends on PCIE_DW_HOST || PCIE_DW_EP
> > +	bool "DWC PCIe debugfs entries"
> > +	help
> > +	  Enables debugfs entries for the DWC PCIe Controller.
> > +	  These entries make use of the RAS features in the DW
> > +	  controller to help in debug, error injection and statistical
> > +	  counters
> > +
> >  config PCIE_DW_HOST
> >  	bool
> >  	select PCIE_DW
> > diff --git a/drivers/pci/controller/dwc/Makefile
> > b/drivers/pci/controller/dwc/Makefile
> > index a8308d9ea986..54565eedc52c 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -1,5 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_PCIE_DW) += pcie-designware.o
> > +obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
> >  obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
> >  obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
> >  obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o diff --git
> > a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > new file mode 100644
> > index 000000000000..a93e29993f75
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > @@ -0,0 +1,544 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Synopsys DesignWare PCIe controller debugfs driver
> > + *
> > + * Copyright (C) 2024 Samsung Electronics Co., Ltd.
> > + *		http://www.samsung.com
> > + *
> > + * Author: Shradha Todi <shradha.t@samsung.com>  */
> > +
> > +#include <linux/debugfs.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +#define SD_STATUS_L1LANE_REG		0xb0
> > +#define PIPE_DETECT_LANE		BIT(17)
> > +#define PIPE_RXVALID			BIT(18)
> > +#define LANE_SELECT			GENMASK(3, 0)
> > +
> > +#define RAS_DES_EVENT_COUNTER_CTRL_REG	0x8
> > +#define EVENT_COUNTER_GROUP_SELECT	GENMASK(27, 24)
> > +#define EVENT_COUNTER_EVENT_SELECT	GENMASK(23, 16)
> > +#define EVENT_COUNTER_LANE_SELECT	GENMASK(11, 8)
> > +#define EVENT_COUNTER_STATUS		BIT(7)
> > +#define EVENT_COUNTER_ENABLE		GENMASK(4, 2)
> > +#define PER_EVENT_OFF			0x1
> > +#define PER_EVENT_ON			0x3
> > +
> > +#define RAS_DES_EVENT_COUNTER_DATA_REG	0xc
> > +
> > +#define ERR_INJ_ENABLE_REG		0x30
> > +#define ERR_INJ0_OFF			0x34
> > +#define EINJ_COUNT			GENMASK(7, 0)
> > +#define EINJ_TYPE_SHIFT			8
> > +#define EINJ0_TYPE			GENMASK(11, 8)
> > +#define EINJ1_TYPE			BIT(8)
> > +#define EINJ2_TYPE			GENMASK(9, 8)
> > +#define EINJ3_TYPE			GENMASK(10, 8)
> > +#define EINJ4_TYPE			GENMASK(10, 8)
> > +#define EINJ5_TYPE			BIT(8)
> > +#define EINJ_VC_NUM			GENMASK(14, 12)
> > +#define EINJ_VAL_DIFF			GENMASK(28, 16)
> > +
> > +#define DWC_DEBUGFS_BUF_MAX		128
> > +
> > +/**
> > + * struct dwc_pcie_rasdes_info - Stores controller common information
> > + * @ras_cap_offset: RAS DES vendor specific extended capability
> > +offset
> > + * @reg_lock: Mutex used for RASDES shadow event registers
> > + * @rasdes_dir: Top level debugfs directory entry
> > + *
> > + * Any parameter constant to all files of the debugfs hierarchy for a
> > +single controller
> > + * will be stored in this struct. It is allocated and assigned to
> > +controller specific
> > + * struct dw_pcie during initialization.
> > + */
> > +struct dwc_pcie_rasdes_info {
> > +	u32 ras_cap_offset;
> > +	struct mutex reg_lock;
> > +	struct dentry *rasdes_dir;
> > +};
> > +
> > +/**
> > + * struct dwc_pcie_rasdes_priv - Stores file specific private data
> > +information
> > + * @pci: Reference to the dw_pcie structure
> > + * @idx: Index to point to specific file related information in array
> > +of structs
> > + *
> > + * All debugfs files will have this struct as its private data.
> > + */
> > +struct dwc_pcie_rasdes_priv {
> > +	struct dw_pcie *pci;
> > +	int idx;
> > +};
> > +
> > +/**
> > + * struct dwc_pcie_event_counter - Store details about each event
> > +counter supported in DWC RASDES
> > + * @name: Name of the error counter
> > + * @group_no: Group number that the event belongs to. Value ranges
> > +from 0 - 4
> > + * @event_no: Event number of the particular event. Value ranges from -
> > + *		Group 0: 0 - 10
> > + *		Group 1: 5 - 13
> > + *		Group 2: 0 - 7
> > + *		Group 3: 0 - 5
> > + *		Group 4: 0 - 1
> > + */
> > +struct dwc_pcie_event_counter {
> > +	const char *name;
> > +	u32 group_no;
> > +	u32 event_no;
> > +};
> > +
> > +static const struct dwc_pcie_event_counter event_list[] = {
> > +	{"ebuf_overflow", 0x0, 0x0},
> > +	{"ebuf_underrun", 0x0, 0x1},
> > +	{"decode_err", 0x0, 0x2},
> > +	{"running_disparity_err", 0x0, 0x3},
> > +	{"skp_os_parity_err", 0x0, 0x4},
> > +	{"sync_header_err", 0x0, 0x5},
> > +	{"rx_valid_deassertion", 0x0, 0x6},
> > +	{"ctl_skp_os_parity_err", 0x0, 0x7},
> > +	{"retimer_parity_err_1st", 0x0, 0x8},
> > +	{"retimer_parity_err_2nd", 0x0, 0x9},
> > +	{"margin_crc_parity_err", 0x0, 0xA},
> > +	{"detect_ei_infer", 0x1, 0x5},
> > +	{"receiver_err", 0x1, 0x6},
> > +	{"rx_recovery_req", 0x1, 0x7},
> > +	{"n_fts_timeout", 0x1, 0x8},
> > +	{"framing_err", 0x1, 0x9},
> > +	{"deskew_err", 0x1, 0xa},
> > +	{"framing_err_in_l0", 0x1, 0xc},
> > +	{"deskew_uncompleted_err", 0x1, 0xd},
> > +	{"bad_tlp", 0x2, 0x0},
> > +	{"lcrc_err", 0x2, 0x1},
> > +	{"bad_dllp", 0x2, 0x2},
> > +	{"replay_num_rollover", 0x2, 0x3},
> > +	{"replay_timeout", 0x2, 0x4},
> > +	{"rx_nak_dllp", 0x2, 0x5},
> > +	{"tx_nak_dllp", 0x2, 0x6},
> > +	{"retry_tlp", 0x2, 0x7},
> > +	{"fc_timeout", 0x3, 0x0},
> > +	{"poisoned_tlp", 0x3, 0x1},
> > +	{"ecrc_error", 0x3, 0x2},
> > +	{"unsupported_request", 0x3, 0x3},
> > +	{"completer_abort", 0x3, 0x4},
> > +	{"completion_timeout", 0x3, 0x5},
> > +	{"ebuf_skp_add", 0x4, 0x0},
> > +	{"ebuf_skp_del", 0x4, 0x1},
> > +};
> > +
> > +/**
> > + * struct dwc_pcie_err_inj - Store details about each error injection
> > +supported by DWC RASDES
> > + * @name: Name of the error that can be injected
> > + * @err_inj_group: Group number to which the error belongs to. Value
> > +can range from 0 - 5
> > + * @err_inj_type: Each group can have multiple types of error  */
> > +struct dwc_pcie_err_inj {
> > +	const char *name;
> > +	u32 err_inj_group;
> > +	u32 err_inj_type;
> > +};
> > +
> > +static const struct dwc_pcie_err_inj err_inj_list[] = {
> > +	{"tx_lcrc", 0x0, 0x0},
> > +	{"b16_crc_dllp", 0x0, 0x1},
> > +	{"b16_crc_upd_fc", 0x0, 0x2},
> > +	{"tx_ecrc", 0x0, 0x3},
> > +	{"fcrc_tlp", 0x0, 0x4},
> > +	{"parity_tsos", 0x0, 0x5},
> > +	{"parity_skpos", 0x0, 0x6},
> > +	{"rx_lcrc", 0x0, 0x8},
> > +	{"rx_ecrc", 0x0, 0xb},
> > +	{"tlp_err_seq", 0x1, 0x0},
> > +	{"ack_nak_dllp_seq", 0x1, 0x1},
> > +	{"ack_nak_dllp", 0x2, 0x0},
> > +	{"upd_fc_dllp", 0x2, 0x1},
> > +	{"nak_dllp", 0x2, 0x2},
> > +	{"inv_sync_hdr_sym", 0x3, 0x0},
> > +	{"com_pad_ts1", 0x3, 0x1},
> > +	{"com_pad_ts2", 0x3, 0x2},
> > +	{"com_fts", 0x3, 0x3},
> > +	{"com_idl", 0x3, 0x4},
> > +	{"end_edb", 0x3, 0x5},
> > +	{"stp_sdp", 0x3, 0x6},
> > +	{"com_skp", 0x3, 0x7},
> > +	{"posted_tlp_hdr", 0x4, 0x0},
> > +	{"non_post_tlp_hdr", 0x4, 0x1},
> > +	{"cmpl_tlp_hdr", 0x4, 0x2},
> > +	{"posted_tlp_data", 0x4, 0x4},
> > +	{"non_post_tlp_data", 0x4, 0x5},
> > +	{"cmpl_tlp_data", 0x4, 0x6},
> > +	{"duplicate_dllp", 0x5, 0x0},
> > +	{"nullified_tlp", 0x5, 0x1},
> > +};
> > +
> > +static const u32 err_inj_type_mask[] = {
> > +	EINJ0_TYPE,
> > +	EINJ1_TYPE,
> > +	EINJ2_TYPE,
> > +	EINJ3_TYPE,
> > +	EINJ4_TYPE,
> > +	EINJ5_TYPE,
> > +};
> > +
> > +static ssize_t lane_detect_read(struct file *file, char __user *buf,
> > +size_t count, loff_t *ppos) {
> > +	struct dw_pcie *pci = file->private_data;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > +	ssize_t off = 0;
> > +	u32 val;
> > +
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> > +	val = FIELD_GET(PIPE_DETECT_LANE, val);
> > +	if (val)
> > +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane Detected\n");
> > +	else
> > +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane
> > +Undetected\n");
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> > +}
> > +
> > +static ssize_t lane_detect_write(struct file *file, const char __user *buf,
> > +				 size_t count, loff_t *ppos)
> > +{
> > +	struct dw_pcie *pci = file->private_data;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	u32 lane, val;
> > +
> > +	val = kstrtou32_from_user(buf, count, 0, &lane);
> > +	if (val)
> > +		return val;
> > +
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> > +	val &= ~(LANE_SELECT);
> > +	val |= FIELD_PREP(LANE_SELECT, lane);
> > +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
> > +SD_STATUS_L1LANE_REG, val);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t rx_valid_read(struct file *file, char __user *buf,
> > +size_t count, loff_t *ppos) {
> > +	struct dw_pcie *pci = file->private_data;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > +	ssize_t off = 0;
> > +	u32 val;
> > +
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
> > +	val = FIELD_GET(PIPE_RXVALID, val);
> > +	if (val)
> > +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX Valid\n");
> > +	else
> > +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "RX
> > +Invalid\n");
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> > +}
> > +
> > +static ssize_t rx_valid_write(struct file *file, const char __user
> > +*buf, size_t count, loff_t *ppos) {
> > +	return lane_detect_write(file, buf, count, ppos); }
> > +
> > +static void set_event_number(struct dwc_pcie_rasdes_priv *pdata, struct dw_pcie *pci,
> > +			     struct dwc_pcie_rasdes_info *rinfo) {
> > +	u32 val;
> > +
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> > +	val &= ~EVENT_COUNTER_ENABLE;
> > +	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
> > +	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
> > +	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
> > +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset +
> > +RAS_DES_EVENT_COUNTER_CTRL_REG, val); }
> > +
> > +static ssize_t counter_enable_read(struct file *file, char __user
> > +*buf, size_t count, loff_t *ppos) {
> > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > +	struct dw_pcie *pci = pdata->pci;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > +	ssize_t off = 0;
> > +	u32 val;
> > +
> > +	mutex_lock(&rinfo->reg_lock);
> > +	set_event_number(pdata, pci, rinfo);
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> > +	mutex_unlock(&rinfo->reg_lock);
> > +	val = FIELD_GET(EVENT_COUNTER_STATUS, val);
> > +	if (val)
> > +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter Enabled\n");
> > +	else
> > +		off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter
> > +Disabled\n");
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> > +}
> > +
> > +static ssize_t counter_enable_write(struct file *file, const char __user *buf,
> > +				    size_t count, loff_t *ppos)
> > +{
> > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > +	struct dw_pcie *pci = pdata->pci;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	u32 val, enable;
> > +
> > +	val = kstrtou32_from_user(buf, count, 0, &enable);
> > +	if (val)
> > +		return val;
> > +
> > +	mutex_lock(&rinfo->reg_lock);
> > +	set_event_number(pdata, pci, rinfo);
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> > +	if (enable)
> > +		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
> > +	else
> > +		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
> > +
> > +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> > +	mutex_unlock(&rinfo->reg_lock);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t counter_lane_read(struct file *file, char __user *buf,
> > +size_t count, loff_t *ppos) {
> > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > +	struct dw_pcie *pci = pdata->pci;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > +	ssize_t off = 0;
> > +	u32 val;
> > +
> > +	mutex_lock(&rinfo->reg_lock);
> > +	set_event_number(pdata, pci, rinfo);
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> > +	mutex_unlock(&rinfo->reg_lock);
> > +	val = FIELD_GET(EVENT_COUNTER_LANE_SELECT, val);
> > +	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Lane:
> > +%d\n", val);
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> > +}
> > +
> > +static ssize_t counter_lane_write(struct file *file, const char __user *buf,
> > +				  size_t count, loff_t *ppos)
> > +{
> > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > +	struct dw_pcie *pci = pdata->pci;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	u32 val, lane;
> > +
> > +	val = kstrtou32_from_user(buf, count, 0, &lane);
> > +	if (val)
> > +		return val;
> > +
> > +	mutex_lock(&rinfo->reg_lock);
> > +	set_event_number(pdata, pci, rinfo);
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
> > +	val &= ~(EVENT_COUNTER_LANE_SELECT);
> > +	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
> > +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
> > +	mutex_unlock(&rinfo->reg_lock);
> > +
> > +	return count;
> > +}
> > +
> > +static ssize_t counter_value_read(struct file *file, char __user
> > +*buf, size_t count, loff_t *ppos) {
> > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > +	struct dw_pcie *pci = pdata->pci;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	char debugfs_buf[DWC_DEBUGFS_BUF_MAX];
> > +	ssize_t off = 0;
> > +	u32 val;
> > +
> > +	mutex_lock(&rinfo->reg_lock);
> > +	set_event_number(pdata, pci, rinfo);
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_DATA_REG);
> > +	mutex_unlock(&rinfo->reg_lock);
> > +	off += scnprintf(debugfs_buf, DWC_DEBUGFS_BUF_MAX - off, "Counter
> > +value: %d\n", val);
> > +
> > +	return simple_read_from_buffer(buf, count, ppos, debugfs_buf, off);
> > +}
> > +
> > +static ssize_t err_inj_write(struct file *file, const char __user
> > +*buf, size_t count, loff_t *ppos) {
> > +	struct dwc_pcie_rasdes_priv *pdata = file->private_data;
> > +	struct dw_pcie *pci = pdata->pci;
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +	u32 val, counter, vc_num, err_group, type_mask;
> > +	int val_diff = 0;
> > +	char *kern_buf;
> > +
> > +	err_group = err_inj_list[pdata->idx].err_inj_group;
> > +	type_mask = err_inj_type_mask[err_group];
> > +
> > +	kern_buf = memdup_user_nul(buf, count);
> > +	if (IS_ERR(kern_buf))
> > +		return PTR_ERR(kern_buf);
> > +
> > +	if (err_group == 4) {
> > +		val = sscanf(kern_buf, "%u %d %u", &counter, &val_diff, &vc_num);
> > +		if ((val != 3) || (val_diff < -4095 || val_diff > 4095)) {
> > +			kfree(kern_buf);
> > +			return -EINVAL;
> > +		}
> > +	} else if (err_group == 1) {
> > +		val = sscanf(kern_buf, "%u %d", &counter, &val_diff);
> > +		if ((val != 2) || (val_diff < -4095 || val_diff > 4095)) {
> > +			kfree(kern_buf);
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		val = kstrtou32(kern_buf, 0, &counter);
> > +		if (val) {
> > +			kfree(kern_buf);
> > +			return val;
> > +		}
> > +	}
> > +
> > +	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group));
> > +	val &= ~(type_mask | EINJ_COUNT);
> > +	val |= ((err_inj_list[pdata->idx].err_inj_type << EINJ_TYPE_SHIFT) & type_mask);
> > +	val |= FIELD_PREP(EINJ_COUNT, counter);
> > +
> > +	if (err_group == 1 || err_group == 4) {
> > +		val &= ~(EINJ_VAL_DIFF);
> > +		val |= FIELD_PREP(EINJ_VAL_DIFF, val_diff);
> > +	}
> > +	if (err_group == 4) {
> > +		val &= ~(EINJ_VC_NUM);
> > +		val |= FIELD_PREP(EINJ_VC_NUM, vc_num);
> > +	}
> > +
> > +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ0_OFF + (0x4 * err_group), val);
> > +	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + ERR_INJ_ENABLE_REG,
> > +(0x1 << err_group));
> > +
> > +	kfree(kern_buf);
> > +	return count;
> > +}
> > +
> > +#define dwc_debugfs_create(name)			\
> > +debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
> > +			&dbg_ ## name ## _fops)
> > +
> > +#define DWC_DEBUGFS_FOPS(name)					\
> > +static const struct file_operations dbg_ ## name ## _fops = {	\
> > +	.open = simple_open,				\
> > +	.read = name ## _read,				\
> > +	.write = name ## _write				\
> > +}
> > +
> > +DWC_DEBUGFS_FOPS(lane_detect);
> > +DWC_DEBUGFS_FOPS(rx_valid);
> > +
> > +static const struct file_operations dwc_pcie_counter_enable_ops = {
> > +	.open = simple_open,
> > +	.read = counter_enable_read,
> > +	.write = counter_enable_write,
> > +};
> > +
> > +static const struct file_operations dwc_pcie_counter_lane_ops = {
> > +	.open = simple_open,
> > +	.read = counter_lane_read,
> > +	.write = counter_lane_write,
> > +};
> > +
> > +static const struct file_operations dwc_pcie_counter_value_ops = {
> > +	.open = simple_open,
> > +	.read = counter_value_read,
> > +};
> > +
> > +static const struct file_operations dwc_pcie_err_inj_ops = {
> > +	.open = simple_open,
> > +	.write = err_inj_write,
> > +};
> > +
> > +void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci) {
> > +	struct dwc_pcie_rasdes_info *rinfo = pci->rasdes_info;
> > +
> > +	debugfs_remove_recursive(rinfo->rasdes_dir);
> > +	mutex_destroy(&rinfo->reg_lock);
> > +}
> > +
> > +int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci) {
> > +	struct dentry *dir, *rasdes_debug, *rasdes_err_inj, *rasdes_event_counter, *rasdes_events;
> > +	struct dwc_pcie_rasdes_info *rasdes_info;
> > +	struct dwc_pcie_rasdes_priv *priv_tmp;
> > +	char dirname[DWC_DEBUGFS_BUF_MAX];
> > +	struct device *dev = pci->dev;
> > +	int ras_cap, i, ret;
> > +
> > +	ras_cap = dw_pcie_find_vsec_capability(pci, DW_PCIE_VSEC_EXT_CAP_RAS_DES);
> > +	if (!ras_cap) {
> > +		dev_dbg(dev, "No RASDES capability available\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);
> > +	if (!rasdes_info)
> > +		return -ENOMEM;
> > +
> > +	/* Create main directory for each platform driver */
> > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > +	dir = debugfs_create_dir(dirname, NULL);
> > +	if (IS_ERR(dir))
> > +		return PTR_ERR(dir);
> > +
> > +	/* Create subdirectories for Debug, Error injection, Statistics */
> > +	rasdes_debug = debugfs_create_dir("rasdes_debug", dir);
> > +	rasdes_err_inj = debugfs_create_dir("rasdes_err_inj", dir);
> > +	rasdes_event_counter = debugfs_create_dir("rasdes_event_counter",
> > +dir);
> > +
> > +	mutex_init(&rasdes_info->reg_lock);
> > +	rasdes_info->ras_cap_offset = ras_cap;
> > +	rasdes_info->rasdes_dir = dir;
> > +	pci->rasdes_info = rasdes_info;
> > +
> > +	/* Create debugfs files for Debug subdirectory */
> > +	dwc_debugfs_create(lane_detect);
> > +	dwc_debugfs_create(rx_valid);
> > +
> > +	/* Create debugfs files for Error injection subdirectory */
> > +	for (i = 0; i < ARRAY_SIZE(err_inj_list); i++) {
> > +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> > +		if (!priv_tmp) {
> > +			ret = -ENOMEM;
> > +			goto err_deinit;
> > +		}
> > +
> > +		priv_tmp->idx = i;
> > +		priv_tmp->pci = pci;
> > +		debugfs_create_file(err_inj_list[i].name, 0200, rasdes_err_inj, priv_tmp,
> > +				    &dwc_pcie_err_inj_ops);
> > +	}
> > +
> > +	/* Create debugfs files for Statistical counter subdirectory */
> > +	for (i = 0; i < ARRAY_SIZE(event_list); i++) {
> > +		priv_tmp = devm_kzalloc(dev, sizeof(*priv_tmp), GFP_KERNEL);
> > +		if (!priv_tmp) {
> > +			ret = -ENOMEM;
> > +			goto err_deinit;
> > +		}
> > +
> > +		priv_tmp->idx = i;
> > +		priv_tmp->pci = pci;
> > +		rasdes_events = debugfs_create_dir(event_list[i].name, rasdes_event_counter);
> > +		if (event_list[i].group_no == 0 || event_list[i].group_no == 4) {
> > +			debugfs_create_file("lane_select", 0644, rasdes_events,
> > +					    priv_tmp, &dwc_pcie_counter_lane_ops);
> > +		}
> > +		debugfs_create_file("counter_value", 0444, rasdes_events, priv_tmp,
> > +				    &dwc_pcie_counter_value_ops);
> > +		debugfs_create_file("counter_enable", 0644, rasdes_events, priv_tmp,
> > +				    &dwc_pcie_counter_enable_ops);
> > +	}
> > +
> > +	return 0;
> > +
> > +err_deinit:
> > +	dwc_pcie_rasdes_debugfs_deinit(pci);
> > +	return ret;
> > +}
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> > b/drivers/pci/controller/dwc/pcie-designware-debugfs.h
> > new file mode 100644
> > index 000000000000..e69de29bb2d1
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h
> > b/drivers/pci/controller/dwc/pcie-designware.h
> > index 98a057820bc7..ed0f26d69626 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -260,6 +260,8 @@
> >
> >  #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
> >
> > +#define DW_PCIE_VSEC_EXT_CAP_RAS_DES		0x2
> > +
> >  /*
> >   * The default address offset between dbi_base and atu_base. Root controller
> >   * drivers are not required to initialize atu_base if the offset
> > matches this @@ -463,6 +465,7 @@ struct dw_pcie {
> >  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
> >  	struct gpio_desc		*pe_rst;
> >  	bool			suspended;
> > +	void			*rasdes_info;
> >  };
> >
> >  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie,
> > pp) @@ -796,4 +799,18 @@ dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
> >  	return NULL;
> >  }
> >  #endif
> > +
> > +#ifdef CONFIG_PCIE_DW_DEBUGFS
> > +int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci); void
> > +dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci); #else static
> > +inline int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci) {
> > +	return 0;
> > +}
> > +static inline void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie
> > +*pci) { } #endif
> > +
> >  #endif /* _PCIE_DESIGNWARE_H */
> > --
> > 2.17.1
> >
> 
> --
> Fan Ni (From gmail)


