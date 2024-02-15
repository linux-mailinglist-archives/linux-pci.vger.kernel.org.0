Return-Path: <linux-pci+bounces-3482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05060855E9E
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 10:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92881B23DB0
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 09:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D6B63501;
	Thu, 15 Feb 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BV1gElW/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAFD626A2
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707991101; cv=none; b=Z7q1X/RjLB94xpOgAtLsf9bkVOlDHt/1boe8KXN2/t6kSoK1EfV9WqonTisSJ5LEcAFCM3QMaEzYJA0luDWB7SgVubofWH9BRDe+/umWum/9KOJJAMo87Qze7cNwsv2zENPV1QepVTJ5Dpw7G7OLOuWT/vuNcvghmXM4ZfXeDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707991101; c=relaxed/simple;
	bh=e5vEoZfalQ7ETsoq8w3fcWgduZ0bVqf8JRJGtHVYDXE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=bYCqtKeRIsYuqn1+cj2y1VCm1wVFDN780SJJ3jQHUDizA3HP0WcxA5hu+C96moR2mOvoXWHlsuj16MU3C57IIqNy+Ff52O+NeFo7ik3XVOMp2sRaU06KrjNBT+xh7gjqRsNsQMqrn3WvvZ3GBqDPqYpCwU1Wj/i0Yjr8fFgUk94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BV1gElW/; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240215095816epoutp04104710b489698393331f8645d83e4c14~0ANpWMwLq0911409114epoutp04I
	for <linux-pci@vger.kernel.org>; Thu, 15 Feb 2024 09:58:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240215095816epoutp04104710b489698393331f8645d83e4c14~0ANpWMwLq0911409114epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707991096;
	bh=ZcRCX4KBMk+YzH589sh1YuW8w7G6ITYKVlq6z2Xqxv4=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=BV1gElW/siM1FvfUiwfA5nXApynTNvwbw6yV1fI/TBph34aJqPh0ogkPMyScaT67H
	 j52TKvI097vMOIZlWjXYtwHBu6JkjVskMS2HyBnJEWrUWkBjEabUNp7T3x1fWC7xp0
	 2vHXg0WuWsYlesWimTM5SFEdVB/CEzUkor4bqSiQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240215095815epcas5p3736e6b4bf9539b8f7549bc3775f8e09e~0ANon2xWW3195431954epcas5p3N;
	Thu, 15 Feb 2024 09:58:15 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Tb9VY6T1Zz4x9Pr; Thu, 15 Feb
	2024 09:58:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DD.BE.19369.530EDC56; Thu, 15 Feb 2024 18:58:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240215092510epcas5p1933a0e8f88899a0efa7ee15e89561769~z-wv9TjTA1192011920epcas5p1U;
	Thu, 15 Feb 2024 09:25:10 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240215092510epsmtrp24eb6474cb2f7807ba64dcf19d2c9f93a~z-wv71Kw22416124161epsmtrp24;
	Thu, 15 Feb 2024 09:25:10 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-f5-65cde0356a5b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AD.49.08755.678DDC56; Thu, 15 Feb 2024 18:25:10 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240215092508epsmtip1c8d596affb39998795f1a15f13ad8a51~z-wtx9UmN2876028760epsmtip1_;
	Thu, 15 Feb 2024 09:25:08 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Manivannan Sadhasivam'" <manivannan.sadhasivam@linaro.org>
Cc: <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
	<bhelgaas@google.com>, <jingoohan1@gmail.com>,
	<gustavo.pimentel@synopsys.com>, <josh@joshtriplett.org>,
	<lukas.bulwahn@gmail.com>, <hongxing.zhu@nxp.com>,
	<pankaj.dubey@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <vidyas@nvidia.com>, <gost.dev@samsung.com>
In-Reply-To: <20240104055030.GA3031@thinkpad>
Subject: RE: [PATCH v2 0/3] Add support for RAS DES feature in PCIe DW
 controller
Date: Thu, 15 Feb 2024 14:55:06 +0530
Message-ID: <0df701da5ff0$df1165a0$9d3430e0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/Q0WxGB9EWFeblm7N70OL8blxhQGR1/IBAmU4G1oB/2O7JgJFQ8VesP9yRcA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwbZRzOe1euBe24FRjvqi7NbU632dJKy45vwoi56GYat2SZ0WFtL5RQ
	rk2vxYkmgmtlMEBmZIPKWN0aHDBFyjcBhp24oEOJEGR8jA3BOZhkAqkbg2DLdcp/z/O8zy/P
	77l7XwEqmsDEgkzGQpsZjYHAQnit1/a8IFXdHqDls7eiSdfHevJmbwdCdk6e4pOO1vOAvLxc
	ySfXnUYyr/hxEDnUWYWRA9XXMdK2auORtr4CHjlpKwwiL7Ys+2xd7XxypE2YEkp1OCb5lNNt
	pcbmEyl3XSFGTYx0YdTM8DmEKjm5gFGNC+0IVdpcB6jmq0uAWnLvUD/1ZlaCntboaLOEZrRG
	XSaTkUi8djj9QLoqRq6QKmLJ/YSE0WTTiUTaQbX0lUyDrwchydEYrD5JrWFZIiopwWy0WmiJ
	3shaEgnapDOYlCYZq8lmrUyGjKEtcQq5/GWVz/hOlt52pgI1jRw68evYAJYHapOKQLAA4kpY
	NnGBVwRCBCK8C8B7jrOAI4sA/u18GCBeAB8O+gk3MvVpA5876AawsP87lCN/Ath234X6XRj+
	EpwZXt3A4XgKLPhr0RciEKD4HALrZX45GJfC++4LiB+H4YfhufIinh/z8Ofh+NDPmN8uxGPh
	tTu5flmIb4X9lTMbFhTfB2u+nEe5fSTw0WxNEJf0Opz9rRxwnkjY96h4YzWILwtgw4MCHjeQ
	Bu0X5wJlwuDc9WY+h8VwaaEb43AGrG2qCAQYoLfJhXA4GfYOVwWq7IENnVGc/Bws//EbhMvd
	AksezwTsQthe/QTvhMtrXYEVtsPqH4aCygDh2FTNsamaY1MFx/9pTsCrA2LaxGZn0FqVSSFl
	6Pf+++FaY7YbbFzzvep2UP/tmswDEAHwAChAiXDhZyU3aJFQp3k/lzYb081WA816gMr3vc+g
	4git0fdOGEu6QhkrV8bExChjo2MURKRw3n5eJ8IzNBY6i6ZNtPnJHCIIFuch6X8c/So1v35A
	+1N+yAH7RA7fo8BDVuqfZRJuVaaat+dV7H7a6ik7lu+9ceXIyAnXWBLaI++6HJTQnHOps3BX
	SLx2/8z0B9PeUqnkSGl4RG3v6EdUn15+dTf83iO6w8pUb5uSIzvico+6Pgx9JsoxOjWtTA5d
	O42crLw3eGXqCzzndyszpM5GGkMbip1w9dXxFUlPS9PAuvaXFm30imOr5FLPabvea6GhPfL4
	i60pSfu+bnxr/MGps07t7buxowrm8/jVle5g0FNTJcnpVhcNNoN3F4dq+g9V7oxbj3pDerfn
	WId0LSy+O9WlYnWDn2zbcfMfR9pxWdu2LaIIeyufJXisXqPYi5pZzb+E9FFSbwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsWy7bCSnG7ZjbOpBotnyFssacqwuHlgJ5PF
	rrsd7Bazts1ltFjxZSa7xf8F+RYNPb9ZLS7vmsNmcXbecTaLlj8tLBYtR9tZLO62dLJaLNr6
	Bahszw52i2vbeR34PXbOusvusWBTqcet17Yem1Z1snncubaHzePJlelMHr3N79g8Nr7bweTR
	t2UVo8eW/Z8ZPT5vkgvgjuKySUnNySxLLdK3S+DKmHyyi71gs0/F7AlNLA2Mt2y6GDk5JARM
	JO73r2fvYuTiEBLYzShxa34fI0RCUuLzxXVMELawxMp/z6GKnjFK7P88nQUkwSagI/Hkyh9m
	EFtEwEGi/e0nFpAiZoFfTBITOj6wQnT8YZR4vvoEK0gVp4CuxJtN88HGCgsESmzd+BbMZhFQ
	lbh9+RxbFyMHB6+ApcThh1UgYV4BQYmTM5+ALWMW0JZ4evMpnL1s4WtmiOsUJH4+XcYKcYSf
	xNPrUxkhasQljv7sYZ7AKDwLyahZSEbNQjJqFpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OL
	S/PS9ZLzczcxgmNaS3MH4/ZVH/QOMTJxMB5ilOBgVhLhndR7JlWINyWxsiq1KD++qDQntfgQ
	ozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMHp1QD07TDi2+o+ihdfpjwP7t55+vpUhHGHW7f
	DDT2/3l+rjdw4sGedu5p72LXGLjucTDNWsDMNfmR6G2z3hJxQc8dz3vKt6v7tkgc9H3ddKd/
	T4xAvxjH7YLLZ+eZqD148L5DZ/bb3oaHSpLc9tce9Lx6YG0ha1sm/fSXpFb0ov0zOK83yDmG
	KlwLlX+/Zlr2tS2liQ9Yrm//LzMvOG3+q6sWDy2Fw6dInWiry/05p8c5JudkGEfzpPMV3hG+
	bIxTFT45BX/atfSE+hXltXFZZhlLz0rEXcq8a+aj+HWjfkH8pQvG23vEFneHuvucNg1xuc8f
	fsNi+esgqa27wnhcA88d63n/0/NUteuFmU0LXdXXK7EUZyQaajEXFScCAPM9wCJYAwAA
X-CMS-MailID: 20240215092510epcas5p1933a0e8f88899a0efa7ee15e89561769
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
	<000601da3e07$c39e5e00$4adb1a00$@samsung.com>
	<20240104055030.GA3031@thinkpad>



> -----Original Message-----
> From: 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org>
> Sent: 04 January 2024 11:21
> To: Shradha Todi <shradha.t=40samsung.com>
> Cc: lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> bhelgaas=40google.com; jingoohan1=40gmail.com;
> gustavo.pimentel=40synopsys.com; josh=40joshtriplett.org;
> lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com;
> pankaj.dubey=40samsung.com; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org
> Subject: Re: =5BPATCH v2 0/3=5D Add support for RAS DES feature in PCIe D=
W
> controller
>=20
> On Wed, Jan 03, 2024 at 11:13:20AM +0530, Shradha Todi wrote:
> >
> >
> > > -----Original Message-----
> > > From: Shradha Todi <shradha.t=40samsung.com>
> > > Sent: 04 December 2023 14:10
> > > To: 'Manivannan Sadhasivam' <manivannan.sadhasivam=40linaro.org>
> > > Cc: 'lpieralisi=40kernel.org' <lpieralisi=40kernel.org>; 'kw=40linux.=
com'
> > > <kw=40linux.com>; 'robh=40kernel.org' <robh=40kernel.org>;
> > > 'bhelgaas=40google.com' <bhelgaas=40google.com>; 'jingoohan1=40gmail.=
com'
> > > <jingoohan1=40gmail.com>; 'gustavo.pimentel=40synopsys.com'
> > > <gustavo.pimentel=40synopsys.com>; 'josh=40joshtriplett.org'
> > > <josh=40joshtriplett.org>; 'lukas.bulwahn=40gmail.com'
> > > <lukas.bulwahn=40gmail.com>; 'hongxing.zhu=40nxp.com'
> > > <hongxing.zhu=40nxp.com>; 'pankaj.dubey=40samsung.com'
> > > <pankaj.dubey=40samsung.com>; 'linux-kernel=40vger.kernel.org' <linux=
-
> > > kernel=40vger.kernel.org>; 'linux-pci=40vger.kernel.org' <linux-
> > > pci=40vger.kernel.org>
> > > Subject: RE: =5BPATCH v2 0/3=5D Add support for RAS DES feature in PC=
Ie
> > > DW controller
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: Manivannan Sadhasivam
> > > > =5Bmailto:manivannan.sadhasivam=40linaro.org=5D
> > > > Sent: 30 November 2023 22:25
> > > > To: Shradha Todi <shradha.t=40samsung.com>
> > > > Cc: lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org;
> > > > bhelgaas=40google.com; jingoohan1=40gmail.com;
> > > > gustavo.pimentel=40synopsys.com; josh=40joshtriplett.org;
> > > > lukas.bulwahn=40gmail.com; hongxing.zhu=40nxp.com;
> > > > pankaj.dubey=40samsung.com; linux-kernel=40vger.kernel.org; linux-
> > > > pci=40vger.kernel.org
> > > > Subject: Re: =5BPATCH v2 0/3=5D Add support for RAS DES feature in
> > > > PCIe DW controller
> > > >
> > > > On Thu, Nov 30, 2023 at 05:20:41PM +0530, Shradha Todi wrote:
> > > > > DesignWare controller provides a vendor specific extended
> > > > > capability called RASDES as an IP feature. This extended
> > > > > capability  provides hardware information like:
> > > > >  - Debug registers to know the state of the link or controller.
> > > > >  - Error injection mechanisms to inject various PCIe errors inclu=
ding
> > > > >    sequence number, CRC
> > > > >  - Statistical counters to know how many times a particular event
> > > > >    occurred
> > > > >
> > > > > However, in Linux we do not have any generic or custom support
> > > > > to be able to use this feature in an efficient manner. This is
> > > > > the reason we are proposing this framework. Debug and bring up
> > > > > time of high-speed IPs are highly dependent on costlier hardware
> > > > > analyzers and this solution will in some ways help to reduce the =
HW
> analyzer usage.
> > > > >
> > > > > The debugfs entries can be used to get information about
> > > > > underlying hardware and can be shared with user space. Separate
> > > > > debugfs entries has been created to cater to all the DES hooks pr=
ovided
> by the controller.
> > > > > The debugfs entries interacts with the RASDES registers in the
> > > > > required sequence and provides the meaningful data to the user.
> > > > > This eases the effort to understand and use the register
> > > > > information for
> > > > debugging.
> > > > >
> > > > > v1 version was posted long back and for some reasons I couldn't
> > > > > work on it. I apologize for the long break. I'm restarting this
> > > > > activity and have taken care of all previous review comments shar=
ed.
> > > > > v1:
> > > > > https://lore.kernel.org/all/20210518174618.42089-1-shradha.t=40sa=
m
> > > > > sung
> > > > > .c
> > > > > om/T/
> > > > >
> > > >
> > > > There is already a series floating to add similar functionality
> > > > via perf
> > > > subsystem:
> > > > https://lore.kernel.org/linux-pci/20231121013400.18367-1-
> > > > xueshuai=40linux.alibaba.com/
> > > >
> > > > - Mani
> > > >
> > >
> > > Hi Mani,
> > >
> > > The series proposed in perf includes only time based-analysis and
> > > event counters which will monitor performance (Group 6 and 7). The
> > > patch or framework that we have proposed includes debug information,
> > > error injection facility and error counters (Group 0 - 5) which are
> > > not included as part of the functionality implemented via perf. In
> > > my opinion, these functionalities don't count as performance
> > > monitoring or counters but rather as debug counters. How about we tak=
e this
> up as a debugfs framework as proposed in my patch?
> > > Or if others feel it can be taken via perf driver then I am happy to
> > > extend the perf driver if authors do not have objection. Let me know =
what
> you think of this?
> > > Meanwhile I will review the perf patches and share my feedback.
> > >
> >
> > Hello Mani,
> > Any update on the above comment? IMO, even though the perf patches and
> > this patchset are both part of the DWC vendor specific capability -
> > RASDES,  they cover different features. The perf file includes
> > performance based parameters like time-based analysis and event
> > counters for count of packets whereas this patchset includes debugging
> > fields, error injection and event counters for count of errors. I
> > think having a separate debugfs file fits more but would you suggest we=
 extend
> the perf file itself?
> >
>=20
> For the error injection and counters, we already have the EDAC framework.=
 So
> adding them in the DWC driver doesn't make sense to me.
>=20

Sorry for late response, was going through the EDAC framework to understand=
 better how we can fit RAS DES support in it. Below are some technical chal=
lenges found so far:
1: This debugfs framework proposed =5B1=5D can run on both side of the link=
 i.e. RC and EP as it will be a part of the link controller platform driver=
. Here for the EP side the assumption is that it has Linux running, which i=
s primarily a use case for chip-to-chip communication.  After your suggesti=
on to migrate to EDAC framework we studied and here are the findings:
- If we move to EDAC framework, we need to have RAS DES as a pci_driver whi=
ch will be binded based on vendor_id and device_id. Our observation is that=
 on EP side system we are unable to bind two function driver (pci_driver), =
as pci_endpoint_test function driver or some other chip-to-chip function dr=
iver will already be bound. On the other hand, on RC side we observed that =
if we have portdrv enabled in Linux running on RC system, it gets bound to =
RC controller and then it does not allow EDAC pci_driver to bind. So basica=
lly we see a problem here, that we can't have two pci_driver binding to sam=
e PCI device
2: Another point is even though we use EDAC driver framework, we may not be=
 able to use any of EDAC framework APIs as they are mostly suitable for mem=
ory controller devices sitting on PCI BUS. We will end up using debugfs ent=
ries just via a pci_driver placed inside EDAC framework.

Please let me know if my understanding is wrong.

> But first check with the perf driver author if they have any plans on add=
ing the
> proposed functionality. If they do not have any plan or not working on it=
, then
> look into EDAC.
>=20
> - Mani
>=20

Since we already worked and posted patches =5B1=5D, =5B2=5D, we will contin=
ue to work on this and based on consent from community we will adopt to mos=
t suitable framework.
We see many subsystems like ethernet, usb, gpu, cxl having debugfs files th=
at give information about the current status of the running system and as o=
f now based on our findings, we still feel there is no harm in having debug=
fs entry based support in DesignWare controller driver itself.=20
Others any opinion please?

=5B1=5D: https://lkml.org/lkml/2021/5/18/1371
=5B2=5D: https://lkml.org/lkml/2023/11/30/574

> > Shradha
> >
> > > > > Shradha Todi (3):
> > > > >   PCI: dwc: Add support for vendor specific capability search
> > > > >   PCI: debugfs: Add support for RASDES framework in DWC
> > > > >   PCI: dwc: Create debugfs files in DWC driver
> > > > >
> > > > >  drivers/pci/controller/dwc/Kconfig            =7C   8 +
> > > > >  drivers/pci/controller/dwc/Makefile           =7C   1 +
> > > > >  .../controller/dwc/pcie-designware-debugfs.c  =7C 476
> > > > ++++++++++++++++++
> > > > >  .../controller/dwc/pcie-designware-debugfs.h  =7C   0
> > > > >  drivers/pci/controller/dwc/pcie-designware.c  =7C  20 +
> > > > > drivers/pci/controller/dwc/pcie-designware.h  =7C  18 +
> > > > >  6 files changed, 523 insertions(+)  create mode 100644
> > > > > drivers/pci/controller/dwc/pcie-designware-debugfs.c
> > > > >  create mode 100644
> > > > > drivers/pci/controller/dwc/pcie-designware-debugfs.h
> > > > >
> > > > > --
> > > > > 2.17.1
> > > > >
> > > >
> > > > --
> > > > =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=
=AE=A9=E0=AF=8D=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=
=AE=AE=E0=AF=8D=0D=0A>=20>=0D=0A>=20>=0D=0A>=20=0D=0A>=20--=0D=0A>=20=E0=AE=
=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=E0=AF=8D=
=20=E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=E0=AF=8D=
=0D=0A=0D=0A

