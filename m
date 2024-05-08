Return-Path: <linux-pci+bounces-7265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 817E48C047A
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43471F21069
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976521E521;
	Wed,  8 May 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="u6vsIl8g"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A1523D;
	Wed,  8 May 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193356; cv=none; b=dRLMZg5olm/D+gybAmY72twP5dZ8NmNjP4mipr7lVCkSMWH6F7o11uO4Fh7XejDI8xrMr6+andbcnwhPStxv8fvVP0aKPagsopIw3mS+7hY1fTyo8Pa6ksLVTPCi/IbObpy5Yo5ads4JXTjaCOIl1nrQH3N31Rc2tHoPuFY0Tag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193356; c=relaxed/simple;
	bh=MAZemTVIxbbNdAXjauGs3j7pc3YiV5dz1grKxXNvLfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=tUTrpwtviPJs9Obu59+EZL83evITXVouffkG7fwe6acn1+02ArWiVjdB+0fk+O0UB6X2MMQEXqtOxs8z1WTfH/sSz9lhsJIzlfUr+K0m9KJf14KymDypdw9MaQS8nnoaLSgnlJJ2gnGPStpLoCofxwZNUdXTCrNfdBMT3A2lHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=u6vsIl8g; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240508183552usoutp01b83795cd216711334497135027464070~Nl0RMtz9J1797317973usoutp016;
	Wed,  8 May 2024 18:35:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240508183552usoutp01b83795cd216711334497135027464070~Nl0RMtz9J1797317973usoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715193352;
	bh=glT/YkXulVm/q0ZI/+Nj1dOUvzJ97c/oga4X16Ufhs8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=u6vsIl8gnjuqTmxbqwgs+4zxYfGu7wQSbTkyMuU3qmtjWCaj864T9VN2G7mAmF/4t
	 89+JJgv745fgiiUFguyr3nBHO4GrsXrr17PMFAE7eh6Lmd6Hc5dAU0yGm3DqJcJ29A
	 OyIq3oHaeUH+Ww28Im+e/UFSsiJ50a/Q3Q/i2+mI=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508183552uscas1p1938f6a75fb6aeb367969fc0bb1f6ff68~Nl0Q_A0qK0528405284uscas1p1R;
	Wed,  8 May 2024 18:35:52 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id A5.3F.09616.806CB366; Wed, 
	8 May 2024 14:35:52 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508183552uscas1p198b490406a13bf31836c0964882362b8~Nl0Qn3SSF2186721867uscas1p1f;
	Wed,  8 May 2024 18:35:52 +0000 (GMT)
X-AuditID: cbfec36d-265ff70000002590-8b-663bc60849e3
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 02.24.09511.706CB366; Wed, 
	8 May 2024 14:35:51 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Wed, 8 May 2024 11:35:50 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Wed,
	8 May 2024 11:35:50 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Michal Hocko <mhocko@suse.com>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "gourry.memverge@gmail.com"
	<gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com"
	<ruansy.fnst@fujitsu.com>, "shradha.t@samsung.com" <shradha.t@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, Jim Harris
	<jim.harris@samsung.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Topic: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Index: AQHan+tkd4BPRAK+n02hrtqAe44hSbGMHooAgAIEEQA=
Date: Wed, 8 May 2024 18:35:50 +0000
Message-ID: <cd7de8e2-6520-4b06-92be-668aeb96bc40@nmtadam.samsung>
In-Reply-To: <ZjoVHhiSLm3KRW63@tiehlicka>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E891342E91B197468547BDB109FBDA48@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7djXc7ocx6zTDI4vFbO4+/gCm8X0qRcY
	LU7cbGSzWH1zDaPFiz/PmSz2P33OYrFq4TU2i/OzTrFY3Fvzn9Xi7LzjbBb7Xu9ltrgx4Smj
	xf0+B4u2JRuZLBbca2exuDXhGJPF+j0LWB0EPTY0vWHz2DnrLrvHgk2lHi1H3rJ6LN7zkslj
	06pONo9Nnyaxe0y+sZzRY+rseo/1W66yeHzeJBfAHcVlk5Kak1mWWqRvl8CVMeXTbKaCPUIV
	lw7vZmpgXMvXxcjJISFgIjHr3AS2LkYuDiGBlYwSxw/tY4JwWpkkrrffY4epOni5gxEisYZR
	4sSPxVBVHxklHj7czA7hLGWUONSzmxGkhU3AQOL38Y3MILaIgJJE1+adYEuYBS6yS7y5uZwF
	JCEsYC3x8useoCIOoCIbic/PBSDqrSTmzV8OtppFQEXi4eJusJm8Ak4Sv/afYAOxOQU0JdpO
	vQObzyggJvH91BomEJtZQFzi1pP5TBBnC0osmr2HGcIWk/i36yEbhK0ocf/7S3aIeh2JBbs/
	sUHYdhJnVqxlgbC1JZYtfM0MsVdQ4uTMJywQvZISB1fcYAH5RULgEqfE95XvGSESLhIvJ72C
	sqUlpq+5DNWQL7Gr7QrUERUSV193Qx1hLbHwz3qmCYwqs5DcPQvJTbOQ3DQLyU2zkNy0gJF1
	FaN4aXFxbnpqsWFearlecWJucWleul5yfu4mRmDyPP3vcO4Oxh23PuodYmTiYDzEKMHBrCTC
	W1VjnSbEm5JYWZValB9fVJqTWnyIUZqDRUmc19D2ZLKQQHpiSWp2ampBahFMlomDU6qBqV2V
	7dLDX7e5Z/SWevLfit6jXnjk4QHPm+4M7d94HNl4spm26Fhv5hISVJES/Dk/uj1ednXwM/UI
	Gzl95uWT3mpOWbTvWN/v2ZV3i3d+jWlbtrPZa2LBZ7ZbcZofZZmez7pwPvQGp2Dxd9Gwsr2s
	F1aorV/UwM8skbtT+8DDHanztJ9rf1//S8LUYOFpt72aT/Ury1ezO231D3NbYVhaPbOXZYPc
	Yp+NDyR2JiY92nVY3fl0dNyjIxNv2ke8WXXXf3p8Rusz7U3X9uUnfmE1+iGqy9m7UD583YS4
	qHspIbe1fWRWxJsmT71qM+H73tsiitsulWztOzHv9Web32l3/s/b8DrjwU59Pw6VE+aaXEos
	xRmJhlrMRcWJAN/1wTgNBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWS2cDsrMt+zDrN4NoNK4u7jy+wWUyfeoHR
	4sTNRjaL1TfXMFq8+POcyWL/0+csFqsWXmOzOD/rFIvFvTX/WS3OzjvOZrHv9V5mixsTnjJa
	3O9zsGhbspHJYsG9dhaLWxOOMVms37OA1UHQY0PTGzaPnbPusnss2FTq0XLkLavH4j0vmTw2
	repk89j0aRK7x+Qbyxk9ps6u91i/5SqLx+dNcgHcUVw2Kak5mWWpRfp2CVwZUz7NZirYI1Rx
	6fBupgbGtXxdjJwcEgImEgcvdzB2MXJxCAmsYpTY0dDMDOF8ZJS4ve8nlLOUUWL/1alsIC1s
	AgYSv49vZAaxRQSUJLo272QDKWIWuMgusXx5HwtIQljAWuLl1z1ARRxARTYSn58LQNRbScyb
	v5wdxGYRUJF4uLibEcTmFXCS+LX/BBvEsq2MEofmHGQCSXAKaEq0nXoHtoxRQEzi+6k1YHFm
	AXGJW0/mM0H8ICCxZM95ZghbVOLl43+sELaixP3vL9kh6nUkFuz+xAZh20mcWbGWBcLWlli2
	8DUzxBGCEidnPmGB6JWUOLjiBssERolZSNbNQjJqFpJRs5CMmoVk1AJG1lWM4qXFxbnpFcXG
	eanlesWJucWleel6yfm5mxiBief0v8MxOxjv3fqod4iRiYPxEKMEB7OSCG9VjXWaEG9KYmVV
	alF+fFFpTmrxIUZpDhYlcd67DzRShQTSE0tSs1NTC1KLYLJMHJxSDUxbTUzPKQbbXbtswCvS
	1G/86ByzuhPTkpnB5f5eW6sMgjisjsgytVWcnz3Be2bJO5+9J971tv9pP7XWxcyB59/MDOce
	Q4XVMxr2Jbwo4plS6MbHXloV0J/pZq5eMePicYFFHzybTic81NZ8ueHUvi2Vr/m9m8M/NDfr
	Ccx3a7pa5/79W9Ednpm/Ott3xExVnhLx2ayrez0ra9PW/Wm157rknKWmKjVdOSrQ861yp0Hs
	tC1iAltFQhvXpCoUfJZOcjvVPmvil8VXV80sPnnT1fsH81S10NeZrlNEfoYfFJ/4rIylh/ed
	+abp7UFLvL9PM32+JSJFPfX30QkPZkdNXL/z67qMHTNXvrZzaL4hGavEUpyRaKjFXFScCADb
	xD/qqwMAAA==
X-CMS-MailID: 20240508183552uscas1p198b490406a13bf31836c0964882362b8
CMS-TYPE: 301P
X-CMS-RootMailID: 20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
	<9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
	<ZjoVHhiSLm3KRW63@tiehlicka>

On Tue, May 07, 2024 at 01:48:46PM +0200, Michal Hocko wrote:
> On Mon 06-05-24 19:27:10, Adam Manzanares wrote:
> > Hello all,
> >=20
> > I would like to have a discussion with the CXL development community ab=
out
> > current outstanding issues and also invite developers interested in RAS=
 and
> > memory tiering to participate.
> >=20
> > The first topic I believe we should discuss is how we can ensure as a g=
roup
> > that we are prioritizing upstream work. On a recent upstream CXL develo=
pment
> > discussion call there was a call to review more work. I apologize for n=
ot
> > grabbing the link, but I believe Dave Jiang is leveraging patchwork and=
 this
> > link should be shared with others so we can help get more reviews where=
 needed.
> >=20
> > The second topic I would like to discuss is how we integrate RAS featur=
es that
> > have similar equivalents in the kernel. A CXL device can provide info a=
bout=20
> > memory media errors in a similar fashion to memory controllers that hav=
e EDAC
> > support. Discussions have been put on the list and I would like to hear=
 thoughts
> > from the community about where this should go [1]. On the same topic CX=
L has=20
> > port level RAS features and the PCIe DW series touched on this issue  [=
2]
> >=20
> > The third topic I would like to discuss is how we can get a set of comm=
on
> > benchmarks for memory tiering evaluations. Our team has done some initi=
al
> > work in this space, but we want to hear more from end users about their=
=20
> > workloads of concern. There was a proposal related to this topic, but f=
rom what=20
> > I understand no meeting has been held [3].=20
> >=20
> > The last topic that I believe is worth discussion is how do we come up =
with
> > a baseline for testing. I am aware of 3 efforts that could be used cxl_=
test,=20
> > qemu, and uunit testing framework [4].
>=20
> This seems to be quite a lot for a single time slot. I think it would
> make sense to split that into more slots. WDYT?

+1. I think the performance implications of CXL memory and how it relates
to existing memory management code tackling performance differentiated memo=
ry=20
would be nice to separate. I think Davidlohr would be a great candidate to=
=20
lead this discussion.

> --=20
> Michal Hocko
> SUSE Labs
> =

