Return-Path: <linux-pci+bounces-7262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2738C0421
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A291C21EB5
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F612BEBC;
	Wed,  8 May 2024 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ucvhW3z8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB73127B5D;
	Wed,  8 May 2024 18:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715191726; cv=none; b=FHQOG0WthkyYPdqBJHLGAt2nqn3HZKP9e7SPexc5hQ85VVFYmCWYFMbDcp8R62xHhqZYMsnWnZuUgNCbqCix+R+kGF54Pb2NnmJllBkj9zUbH7ySyKvrUzbXlurO7uSpcYo+OugbhrNXyp6+W+GiTvWiC+Ya2cAK5htZ1EgRXAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715191726; c=relaxed/simple;
	bh=KWQTRutK8z/kDSDxRPmlV0xVb51MohjPj1mGYwt1CX8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=putWN8OUhY9AxjCTvt7ribZ9DzVl6k1HzV96sZyHw7mzMpM8nQWPDYICB68I31rqfFXmjPaaxnwKWNT7oI220rLaORGHXHm0n2I75PL0IE6y/2TiS7xtW6w/xFfGv9TkDxJ4GkVUOYoHWOoDfSzta976PBA3a/3hIpXStsmeWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ucvhW3z8; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240508180836usoutp0210bf0a19f6ceb30cd094717671e900e5~Nlcdh9sEq1908019080usoutp02w;
	Wed,  8 May 2024 18:08:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240508180836usoutp0210bf0a19f6ceb30cd094717671e900e5~Nlcdh9sEq1908019080usoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715191716;
	bh=kKdLu29wFnfJkxE/U7gB+iPML9yCI/oni0aLS022fY0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ucvhW3z8ZvjifKyz2a7LJCtImh3v/XxcxW0zbMLCrVTBaNZz6RKSGuQ3QTpKDqoxB
	 ZJtRMXcwrIko4WFhCN17dJO/X90ZHBd4VSIVBbsddmzsAR2djkSi5T1Kdq2M/Q//6h
	 pTXN/YLzCHyrNxmgGiFvQFihmOPtp5/OTz7pwHyg=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508180836uscas1p17e9209e1fd7d1f8410a7aa0d37fbeffc~NlcdY0Lb32327823278uscas1p1N;
	Wed,  8 May 2024 18:08:36 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 3F.9A.09616.4AFBB366; Wed, 
	8 May 2024 14:08:36 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508180836uscas1p1ea1dd0b8fe0d1aa628c3101b9bbbc0cb~Nlcc-ZJS60646006460uscas1p1P;
	Wed,  8 May 2024 18:08:36 +0000 (GMT)
X-AuditID: cbfec36d-ff7ff70000002590-ea-663bbfa4846e
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id F8.53.09795.3AFBB366; Wed, 
	8 May 2024 14:08:35 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Wed, 8 May 2024 11:08:34 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Wed,
	8 May 2024 11:08:34 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "gourry.memverge@gmail.com"
	<gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com"
	<ruansy.fnst@fujitsu.com>, "shradha.t@samsung.com" <shradha.t@samsung.com>,
	"mcgrof@kernel.org" <mcgrof@kernel.org>, Jim Harris
	<jim.harris@samsung.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Topic: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Index: AQHan+tkd4BPRAK+n02hrtqAe44hSbGLHWGAgAL9mIA=
Date: Wed, 8 May 2024 18:08:34 +0000
Message-ID: <a2381d09-f9a5-4466-bedf-277f604df245@nmtadam.samsung>
In-Reply-To: <3d18ae36-4dea-496a-a8fc-253b21135838@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2C8D255D936F0842A6EB6372F455E49D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwbdRjH87u7Xg+WuqMj9LHERRtIDMOO6qanBRxo3M04w1400WVxdTvY
	eCmkBVdJE5mZMEBGhdVlJbIyXsag2lLFUSxMb6RsI0NmygS0kPEigzLNVhGMULRcTfjv8zzP
	93me75M8FC5dFsmpE9pCTqfV5CrISOJbz+LgM03X1JlJ435gfFNDJHPePISYG6OnSKZ91IaY
	+yuzGHNtZpZg2hruksyPllsEM25bEzG36/tJptffgzMjphnETJzdxZQ2dWCMdbyMYMZMHoyx
	u62iXVGs4+MFknVZfGLW6ixiT/c9ELGN7jmMdbaVk6zzUY2YrR25jFhz3Ues/Zthgg04t2Zs
	ejcy+RiXe+IDTrc99Ujk8UH+HlFQLjN4fXfEJahbWoEiKKB3QN3dSqwCRVJS+gqCeXsVLgSf
	YLAw5BJXIGpd1dv8spC3IXAFTaQQPERwemKZDI2S0s0I2v3GEJN0EvzT34GHOJqOhwn71HoD
	TveLYckzjUKFLbQa5hbdeGhDNJ0MgVla0L8EfT0zWIgJOg5+rRLmSOh0+N1ftc4RdAosXKol
	QozoGFi6ZVvX47QMxqYvYsJpUXCpzo0LHAPB7nukwE/BxNKcWNAngvW7R6TAqRCoqcUF3gYt
	Df7w3ii4eWGaEHofhx9aR4jQLUD/FAF8s0MsFF6FYZ4PL4uFVV9L2EQ+dJd6w3kDDPsrwybU
	0LBix0wozrLBt2WDJ8sGT5YNniwbPFmRqA3JivT6vCxOr9JyJ5V6TZ6+SJulPJqf50T/PedA
	8HpeF+oae6jkEUYhHgGFK6IlxUZ1plRyTPNhMafLf09XlMvpeRRLEQqZRJVy86iUztIUcjkc
	V8Dp/q9iVIS8BHv9K/Nnu0GLH0lt1Bmhvnj3QfkbT+841/n5HxkPxs4aJmN+rql8PmHqYKmE
	H621ybOMGeeufv+KorD1ygXzp1Mlv/Bf/731JPnnX9Xvd6RA2TvZLyQm1N2+2Cjf+9b+xwhq
	e3rxjaoDm3oJ6xP3FUnpz33hbXbrDke51s68WTOT+uxhE77ZUYbWXjSWDa60rHnj4oNPXk62
	NG6eVAXVBYHf5mN76u/4D6VV5zadt5vMez1XJ5U5W2iXI/u1WH7P9EBaZnV75eJAjmebKjHe
	tS/QGb9zxJC2GpzvG+/KkfSd8Q3t0ztaW5UlmGwPNbuavnP57S+9ndUJ2YmD5Yf4U8R1uUFB
	6I9rVAm4Tq/5FxVogHALBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsWS2cDsrLt4v3WaQeN2a4u7jy+wWUyfeoHR
	4sTNRjaL1TfXMFq8+POcyWL/0+csFqsWXmOzOD/rFIvFvTX/WS3OzjvOZrHv9V5mixsTnjJa
	3O9zsGhbspHJYsG9dhaLWxOOMVms37OA1UHQY0PTGzaPnbPusnss2FTq0XLkLavH4j0vmTw2
	repk89j0aRK7x+Qbyxk9ps6u91i/5SqLx+dNcgHcUVw2Kak5mWWpRfp2CVwZ5w49ZCnoFK+4
	cvciewPjLqEuRg4OCQETiX1L7bsYuTiEBFYxSry+9IwdwvnIKLHp3loWCGcpo8SEtz+Zuxg5
	OdgEDCR+H98IZosIqErcX/+YDaSIWeA4u8TsZYtZQRLCAtYSL7/uYQZZISJgI/H5uQBEvZXE
	kb1PmUBsFgEViTu9EHN4BZwk3r3uZYZYdpJR4uThFrAEp4CtxJtFk1lAbEYBMYnvp9aANTML
	iEvcejIfzJYQEJBYsuc8M4QtKvHy8T9WCFtR4v73l+wQ9ToSC3Z/YoOw7SQ+T5rMDGFrSyxb
	+BrqCEGJkzOfsED0SkocXHGDZQKjxCwk62YhGTULyahZSEbNQjJqASPrKkbx0uLi3PSKYqO8
	1HK94sTc4tK8dL3k/NxNjMC0c/rf4egdjLdvfdQ7xMjEwXiIUYKDWUmEt6rGOk2INyWxsiq1
	KD++qDQntfgQozQHi5I4790HGqlCAumJJanZqakFqUUwWSYOTqkGJpEmjtb0i50fwyZ6+Z6P
	Ldr8MmmRuHDGZp9HMreEcieqaOndMzgUsF3pVoXBzHvlM86oXp7gLaXilSe7ZeKCxeLCmSd/
	an+78OaKvsjzd08DEivXCXRaRda42/wUYVt7fKf+9t0CNvUbZqjFT6xTkr716YT6goU3v2dm
	LU2Yw+0Qf3NKQbDEwXbNgyqhhn7ivReu7a099vfjzpIbVyZ0TepIW7HFuXrqpU9NH5l5Xl0L
	v/rmYuTHJ1+Y3WelsJsfXh794GWtlx0ns9ry9Vlv1rR3vvtpxbc0nGHRb+cFhxerzzTsOCmx
	4pSJwRmj/I6Aja3u9XsrstZt3n0o84979L66WRdvB8kp81xpnrXmT7kSS3FGoqEWc1FxIgAv
	4YYRqgMAAA==
X-CMS-MailID: 20240508180836uscas1p1ea1dd0b8fe0d1aa628c3101b9bbbc0cb
CMS-TYPE: 301P
X-CMS-RootMailID: 20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
	<9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
	<3d18ae36-4dea-496a-a8fc-253b21135838@intel.com>

On Mon, May 06, 2024 at 01:28:21PM -0700, Dave Jiang wrote:
>=20
>=20
> On 5/6/24 12:27 PM, Adam Manzanares wrote:
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
>=20
> Bundle for the potential fixes
> https://patchwork.kernel.org/bundle/cxllinux/cxl-fixes/
>=20
> Bundle for the next merge window
> https://patchwork.kernel.org/bundle/cxllinux/cxl-next/
>=20
> Just be aware patchwork only takes patches, so the bundle are registered =
with the first patch of a series. The listing does display the origin serie=
s.

Thanks Dave, much appreciated. We will leverage this and I will spread the
message about how important it is to review.

>=20
> DJ
>=20
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
> >=20
> > Apologies for getting this out late, and please include anyone that may=
 be
> > interested in joining a discussion.
> >=20
> > [1] https://lore.kernel.org/linux-cxl/20240417075053.3273543-1-ruansy.f=
nst@fujitsu.com/
> > [2] https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t@samsu=
ng.com/
> > [3] https://lore.kernel.org/all/2b29dd3d-bb2c-6a8c-94d2-d5c2e035516a@go=
ogle.com
> > [4] https://lore.kernel.org/linux-cxl/170795677066.3697776.125878127130=
93908173.stgit@ubuntu/
> =

