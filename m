Return-Path: <linux-pci+bounces-1644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00213823AE2
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 03:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20154288329
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8144C8E;
	Thu,  4 Jan 2024 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Gy+qwlJ/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE065673
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240104025523epoutp047574f4022271a6a028619e1d94b31478~nBWb2qMzi2802928029epoutp04d
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 02:55:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240104025523epoutp047574f4022271a6a028619e1d94b31478~nBWb2qMzi2802928029epoutp04d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1704336923;
	bh=OiF6tUgd+ueRws57hnQ7jHdR9ExFm1BoqeA7YyNenFM=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Gy+qwlJ/MGOJblbEV652VnWfOoXXZ8eAIE3yalowInA1+bfGifISG8p7c0CpnSIHh
	 bZTRuxswVgwoWrMkVEnNyrP9JmSgGSUWfrLyje9DNAiFLpcFVNNwhEqDZ25JFkbkFj
	 Ywv21jYCIJZrvHg0hNk0UwNA6wIjFurikp6eL/J4=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240104025522epcas5p24b9230be2421bb0d20030464e92d4560~nBWa45Cfa1864018640epcas5p2u;
	Thu,  4 Jan 2024 02:55:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4T5B604NNFz4x9Q2; Thu,  4 Jan
	2024 02:55:20 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.F3.10009.81E16956; Thu,  4 Jan 2024 11:55:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240103054323epcas5p1c66603ad92fc4af4efda6a4999fbec2e~mv-0ullNs1533915339epcas5p1O;
	Wed,  3 Jan 2024 05:43:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240103054323epsmtrp23ed95c1b41e03c2abe461efbe81c2d57~mv-0ttVE40670206702epsmtrp2A;
	Wed,  3 Jan 2024 05:43:23 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-2a-65961e18e9d2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.CA.08755.AF3F4956; Wed,  3 Jan 2024 14:43:22 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240103054321epsmtip2b82d46e8f2e04dbc7774751e17704108~mv-y3kFen0960509605epsmtip25;
	Wed,  3 Jan 2024 05:43:21 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<gustavo.pimentel@synopsys.com>, <josh@joshtriplett.org>,
	<lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
	<pankaj.dubey@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
In-Reply-To: 
Subject: RE: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Date: Wed, 3 Jan 2024 11:13:20 +0530
Message-ID: <000601da3e07$c39e5e00$4adb1a00$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/Q0WxGB9EWFeblm7N70OL8blxhQGR1/IBAmU4G1qwrtlAgIAu9wGg
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPJsWRmVeSWpSXmKPExsWy7bCmhq6E3LRUg83TFC2WNGVY7LrbwW4x
	a9tcRosVX2ayW/xfkG/R0POb1eLyrjlsFmfnHWezaPnTwmLRcrSdxeJuSyerxaKtX4DK9uxg
	d+D12DnrLrvHgk2lHrde23psWtXJ5nHn2h42jydXpjN5bHy3g8mjb8sqRo8t+z8zenzeJBfA
	FZVtk5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0uZJC
	WWJOKVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAh
	O6Px03TWgk79io7/v9gbGHepdTFyckgImEgs397H2MXIxSEksJtRYsf6B6wQzidGiRUHzkM5
	3xgljh3qZYFpWX95HwtEYi+jxKWzn5khnBeMEq8ermYCqWIT0JF4cuUPM4gtIuAg0f72E1gH
	s8BeJomtr3YDzeXg4BTglZjwzxqkRlggWGL61C6wDSwCKhInV71hBbF5BSwlvm9ayA5hC0qc
	nPkErIZZQFti2cLXzBAXKUj8fLqMFWKXm8SljcuZIWrEJY7+7AE7TkLgDofE0n8XWCEaXCSa
	5h2AekdY4tXxLewQtpTE53d72SDsdImVm2dALciR+LZ5CROEbS9x4MocFpD7mQU0Jdbv0ocI
	y0pMPbWOCWIvn0Tv7ydQ5bwSO+bB2MoSX/7ugVorKTHv2GXWCYxKs5C8NgvJa7OQvDALYdsC
	RpZVjJKpBcW56anFpgVGeanl8BhPzs/dxAhO2VpeOxgfPvigd4iRiYPxEKMEB7OSCO/6dZNT
	hXhTEiurUovy44tKc1KLDzGaAsN7IrOUaHI+MGvklcQbmlgamJiZmZlYGpsZKonzvm6dmyIk
	kJ5YkpqdmlqQWgTTx8TBKdXAlH/s0T6fgNBUzTa3LrEOxfIWJ9eff26f3CQl8ma+teLJfyH/
	lEr+Lbs7Teb47fVlTdN2bwu0PcfF8ut8UtmKcJ59mz5q5zI9clobLxFs9ZtfNGeJuYHXP7uV
	WX65E73COJ9vM9n9x2at+PTQPS+n/l3mdNDrwYz/VhsCVqfPU7lkqcFwfy07a0VJyHLPHSu0
	7zR9iL2dzpffUnG0ytBXeY7vFx6zqAlveO9Ozyty/OTVG1i6ad00qSN73pz9wLV7bWFQwJWO
	sN8nXRK3/flrE+tfsGn2jc3Pb7i/nu75b3VFw4yzjmtLtJv3O5qmGbhxmF6WEshSehi689vx
	Wavl505+d3zqU0/+xAPJTktFwpVYijMSDbWYi4oTAYu51pViBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsWy7bCSvO7vz1NSDSZKWSxpyrDYdbeD3WLW
	trmMFiu+zGS3+L8g36Kh5zerxeVdc9gszs47zmbR8qeFxaLlaDuLxd2WTlaLRVu/AJXt2cHu
	wOuxc9Zddo8Fm0o9br229di0qpPN4861PWweT65MZ/LY+G4Hk0ffllWMHlv2f2b0+LxJLoAr
	issmJTUnsyy1SN8ugSvj5TaLgq16FSfnvGNqYDyt2sXIySEhYCKx/vI+li5GLg4hgd2MEk+/
	3WSBSEhKfL64jgnCFpZY+e85O0TRM0aJef2/wIrYBHQknlz5wwxiiwg4SLS//QQ2iVngJJPE
	thuHwRJCAusYJVq3RHYxcnBwCvBKTPhnDRIWFgiU2LrxLdgCFgEViZOr3rCC2LwClhLfNy1k
	h7AFJU7OfAK2i1lAW+Lpzadw9rKFr5khjlOQ+Pl0GSvEDW4SlzYuZ4aoEZc4+rOHeQKj8Cwk
	o2YhGTULyahZSFoWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjlgtzR2M21d9
	0DvEyMTBeIhRgoNZSYR3/brJqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5xV/0pggJpCeWpGan
	phakFsFkmTg4pRqYlCsbvOXlPCunBTi+YJDq+3A1xe8wv0ow/3qbBs5E7lv3dGvvOvKGfnVe
	nuCrZRm8wk3dwjo4wXOfzL5CV/uTiz8KCc8K6+X+/Du8w3Jpu5++JMuVyRNljO8rvPdllWyW
	nuIba/NEydZ/ev32Mwyavyate6rH2xHAIBzZaMJd5btBx/Z83nHusPjSR+y/H9/bO0/h11aP
	jXErlK3zhW3X27NEF996slVf0Kygi/nNO/mJG2Zc6GN+ZbZS8MnpB+85io2mi7FOLpIVeeb1
	0STgSkf6c2b7h6cZSzTW7Foc9Phn93LB1Szf/mc6vt64cnsEy3Pml0eeH3zsemZfOVPV4eBp
	6Teq1abuvzOTY7ESS3FGoqEWc1FxIgAnUgVIRwMAAA==
X-CMS-MailID: 20240103054323epcas5p1c66603ad92fc4af4efda6a4999fbec2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231130115055epcas5p4e29befa80877be45dbee308846edc0ba
References: <CGME20231130115055epcas5p4e29befa80877be45dbee308846edc0ba@epcas5p4.samsung.com>
	<20231130115044.53512-1-shradha.t@samsung.com>
	<20231130165514.GW3043@thinkpad> 



> -----Original Message-----
> From: Shradha Todi <shradha.t=40samsung.com>
> Sent: 04 December 2023 14:10
> To: 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org>
> Cc: 'lpieralisi=40kernel.org' <lpieralisi=40kernel.org>; 'kw=40linux.com'
> <kw=40linux.com>; 'robh=40kernel.org' <robh=40kernel.org>;
> 'bhelgaas=40google.com' <bhelgaas=40google.com>; 'jingoohan1=40gmail.com'
> <jingoohan1=40gmail.com>; 'gustavo.pimentel=40synopsys.com'
> <gustavo.pimentel=40synopsys.com>; 'josh=40joshtriplett.org'
> <josh=40joshtriplett.org>; 'lukas.bulwahn=40gmail.com'
> <lukas.bulwahn=40gmail.com>; 'hongxing.zhu=40nxp.com'
> <hongxing.zhu=40nxp.com>; 'pankaj.dubey=40samsung.com'
> <pankaj.dubey=40samsung.com>; 'linux-kernel=40vger.kernel.org' <linux-
> kernel=40vger.kernel.org>; 'linux-pci=40vger.kernel.org' <linux-
> pci=40vger.kernel.org>
> Subject: RE: =5BPATCH v2 0/3=5D Add support for RAS DES feature in PCIe D=
W
> controller
>=20
>=20
>=20
> > -----Original Message-----
> > From: Manivannan Sadhasivam =5Bmailto:manivannan.sadhasivam=40linaro.or=
g=5D
> > Sent: 30 November 2023 22:25
> > To: Shradha Todi <shradha.t=40samsung.com>
> > Cc: lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> > bhelgaas=40google.com; jingoohan1=40gmail.com;
> > gustavo.pimentel=40synopsys.com; josh=40joshtriplett.org;
> > lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com;
> > pankaj.dubey=40samsung.com; linux-kernel=40vger.kernel.org; linux-
> > pci=40vger.kernel.org
> > Subject: Re: =5BPATCH v2 0/3=5D Add support for RAS DES feature in PCIe=
 DW
> > controller
> >
> > On Thu, Nov 30, 2023 at 05:20:41PM +0530, Shradha Todi wrote:
> > > DesignWare controller provides a vendor specific extended capability
> > > called RASDES as an IP feature. This extended capability  provides
> > > hardware information like:
> > >  - Debug registers to know the state of the link or controller.
> > >  - Error injection mechanisms to inject various PCIe errors including
> > >    sequence number, CRC
> > >  - Statistical counters to know how many times a particular event
> > >    occurred
> > >
> > > However, in Linux we do not have any generic or custom support to be
> > > able to use this feature in an efficient manner. This is the reason
> > > we are proposing this framework. Debug and bring up time of
> > > high-speed IPs are highly dependent on costlier hardware analyzers
> > > and this solution will in some ways help to reduce the HW analyzer us=
age.
> > >
> > > The debugfs entries can be used to get information about underlying
> > > hardware and can be shared with user space. Separate debugfs entries
> > > has been created to cater to all the DES hooks provided by the contro=
ller.
> > > The debugfs entries interacts with the RASDES registers in the
> > > required sequence and provides the meaningful data to the user. This
> > > eases the effort to understand and use the register information for
> > debugging.
> > >
> > > v1 version was posted long back and for some reasons I couldn't work
> > > on it. I apologize for the long break. I'm restarting this activity
> > > and have taken care of all previous review comments shared.
> > > v1:
> > > https://lore.kernel.org/all/20210518174618.42089-1-shradha.t=40samsun=
g
> > > .c
> > > om/T/
> > >
> >
> > There is already a series floating to add similar functionality via
> > perf
> > subsystem: https://lore.kernel.org/linux-pci/20231121013400.18367-1-
> > xueshuai=40linux.alibaba.com/
> >
> > - Mani
> >
>=20
> Hi Mani,
>=20
> The series proposed in perf includes only time based-analysis and event c=
ounters
> which will monitor performance (Group 6 and 7). The patch or framework th=
at we
> have proposed includes debug information, error injection facility and er=
ror
> counters (Group 0 - 5) which are not included as part of the functionalit=
y
> implemented via perf. In my opinion, these functionalities don't count as
> performance monitoring or counters but rather as debug counters. How abou=
t
> we take this up as a debugfs framework as proposed in my patch?
> Or if others feel it can be taken via perf driver then I am happy to exte=
nd the perf
> driver if authors do not have objection. Let me know what you think of th=
is?
> Meanwhile I will review the perf patches and share my feedback.
>=20

Hello Mani,
Any update on the above comment? IMO, even though the perf patches and this
patchset are both part of the DWC vendor specific capability - RASDES,  the=
y
cover different features. The perf file includes performance based paramete=
rs
like time-based analysis and event counters for count of packets whereas th=
is
patchset includes debugging fields, error injection and event counters for =
count
of errors. I think having a separate debugfs file fits more but would you s=
uggest
we extend the perf file itself?=20

Shradha

> > > Shradha Todi (3):
> > >   PCI: dwc: Add support for vendor specific capability search
> > >   PCI: debugfs: Add support for RASDES framework in DWC
> > >   PCI: dwc: Create debugfs files in DWC driver
> > >
> > >  drivers/pci/controller/dwc/Kconfig            =7C   8 +
> > >  drivers/pci/controller/dwc/Makefile           =7C   1 +
> > >  .../controller/dwc/pcie-designware-debugfs.c  =7C 476
> > ++++++++++++++++++
> > >  .../controller/dwc/pcie-designware-debugfs.h  =7C   0
> > >  drivers/pci/controller/dwc/pcie-designware.c  =7C  20 +
> > > drivers/pci/controller/dwc/pcie-designware.h  =7C  18 +
> > >  6 files changed, 523 insertions(+)
> > >  create mode 100644
> > > drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > >  create mode 100644
> > > drivers/pci/controller/dwc/pcie-designware-debugfs.h
> > >
> > > --
> > > 2.17.1
> > >
> >
> > --
> > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=
=A9=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=
=AE=E0=AF=8D=0D=0A=0D=0A

