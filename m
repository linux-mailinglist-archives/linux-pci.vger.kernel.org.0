Return-Path: <linux-pci+bounces-7264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5DB8C0479
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5219028C000
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95473B646;
	Wed,  8 May 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ppC0+yau"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC44F14A9F;
	Wed,  8 May 2024 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193236; cv=none; b=ewNmKkEesM94Vc/dxPPSan5DYyQp1rSfjfzY/m+Wo0We87Obsaz+TD36oAehCpeP4mZi0ziknRM/iKFPgmZg2q9mudnfN+A0E+1TKHNUSapRL+3HvJBA45o4tZfveSzU8G64tdYCVaYthHUfv4qHhVgrSmSZJuZdvqUpANqBxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193236; c=relaxed/simple;
	bh=+GKzrwDDje9xL1agtIpDU63JUFc4U4WwEIaD48oCDI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=eTTunT6tW+zIxc9qMiLfLHkGyP2Z2CXGLIZSodDguXABmGLVMrdFJxJw5EPXdOoIf0cUbPnwE3YVlyboCJ3Xz8Ek7QEQ8CdY3gBTq8kl/LwzpZNMH11YSux+wLpDzBfK+ZTOebxIiMaSStvm/uVCDd4K0fEl/QmbsAce4hRkKQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ppC0+yau; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240508182625usoutp01c53c0488931d8fb681ee50314512d77e~NlsBGWAtk0541805418usoutp01W;
	Wed,  8 May 2024 18:26:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240508182625usoutp01c53c0488931d8fb681ee50314512d77e~NlsBGWAtk0541805418usoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715192785;
	bh=ADy6altnCCmTZdV0jetpYV+xMuQBv/62xo0t0U50deU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ppC0+yaukrOgcenGDeLf8QJBlLOq7jz+G6sj9waIucn+9k85OsCITlmTY03PeAoIi
	 7s9wx9k36tZ2oA+0YBl7xn9onE8Hp/q2WWDE/bQ66IxIpxfmIskW232FQWbSpm4euS
	 vTkbpeh/t2T8ggFRsLhQwwcK9P11mYwfPYhIEnMs=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
	[203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508182625uscas1p1b86e6e57b4abc4e846b6f94262b8b4d0~NlsA8hPsZ0965109651uscas1p12;
	Wed,  8 May 2024 18:26:25 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges3new.samsung.com (USCPEMTA) with SMTP id 87.CE.09504.1D3CB366; Wed, 
	8 May 2024 14:26:25 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240508182624uscas1p2693660020f1c82155813d83e905662e7~NlsAdbtqD2562725627uscas1p2U;
	Wed,  8 May 2024 18:26:24 +0000 (GMT)
X-AuditID: cbfec370-ed5ff70000002520-b3-663bc3d1e47d
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 3F.54.09521.0D3CB366; Wed, 
	8 May 2024 14:26:24 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Wed, 8 May 2024 11:26:23 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Wed,
	8 May 2024 11:26:23 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
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
	<jim.harris@samsung.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Topic: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Index: AQHan+tkd4BPRAK+n02hrtqAe44hSbGLVQ6AgALK6YA=
Date: Wed, 8 May 2024 18:26:23 +0000
Message-ID: <e51cc411-a05a-4b0c-b43f-bc99a94208eb@nmtadam.samsung>
In-Reply-To: <66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A386930B6EAB444D828D3317216D1F57@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7djXc7oXD1unGRy5Kmlx9/EFNovpUy8w
	Wpy42chmsfrmGkaLF3+eM1nsf/qcxWLVwmtsFudnnWKxuLfmP6vF2XnH2Sz2vd7LbHFjwlNG
	i/t9DhZtSzYyWSy4185icWvCMSaL9XsWsDoIemxoesPmsXPWXXaPBZtKPVqOvGX1WLznJZPH
	plWdbB6bPk1i95h8Yzmjx9TZ9R7rt1xl8fi8SS6AO4rLJiU1J7MstUjfLoEr4+CmD6wFTxUr
	/q3ax9TAeESqi5GTQ0LARGL5qy72LkYuDiGBlYwSLzetYoNwWpkkPr86zwpT9fHPL6jEGkaJ
	P+t2M0E4Hxklrt9sYoFwljJK3H85lxGkhU3AQOL38Y3MILaIgLbExDkHmUGKmAX2s0tMftbE
	BJIQFrCWePl1D1CCA6jIRuLzcwGIeiuJX+sXgvWyCKhIvPrQywZi8wo4ScycuxIszikQKNH1
	firYGEYBMYnvp9aA2cwC4hK3nsxngjhbUGLR7D3MELaYxL9dD9kgbEWJ+99fskPU60gs2P2J
	DcK2k5j9bDqUrS2xbOFrZoi9ghInZz5hgeiVlDi44gbYwxIChzkl+tr+QS1zkTj7/h6ULS1x
	9fpUqMX5ErvarkDZFRJXX3dDHWEtsfDPeqYJjCqzkNw9C8lNs5DcNAvJTbOQ3LSAkXUVo3hp
	cXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYPI8/e9wwQ7GW7c+6h1iZOJgPMQowcGsJMJbVWOd
	JsSbklhZlVqUH19UmpNafIhRmoNFSZzX0PZkspBAemJJanZqakFqEUyWiYNTqoFJYOur6ceU
	P/7PlZwyoZ/7e6BgZcpfvgq5cN3Yr0IdCRdNX34QPdQqs675jM3/d07Gy4/81Cu4eEMmXUHi
	YPLi7uRlC9pSQp537uN6N6fUPdNjV8vCP/aW516xxcz7+3TB72U7BXgOqveJyGyvurbht2kE
	a+ELjj8WT3xifLpWTA3NXhLWtoZRb+MdpvwO40IrGV7uLbNXGu0JK1I9N42/OKWB8/jTh+Iv
	nxYznkvIEIjYu+La/L2cdm9msb6fWdfuwV/36L6hv3Zj3paYmRdFX18LEAt/bpXkPbtpz8Pc
	62wJ556aman9yL+hK7f1mM6Nd6+XBb+4z5ax1D5R72NVlMCz3ON/Fr0tnC1YIKWvxFKckWio
	xVxUnAgArrJEKQ0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfVBMURjGnXvv3r2bWa6VOvI1rYYU0SjOaCWRucaM1D/5jB2uLSq5d7dI
	Qz6GsWiWRLutbBRajdjpDx+rnbYoQhmDyoZB1oYhyzTCpu0ys//95n2e93neM3MoXHZKFESl
	Z6lZLkuZISf9iPQCfNGMtoaYzbO+f5+Nut62keh0cRtAzR17SXS5oxqgD7+dGLJ1OwlkLn9G
	olbDfQK9rB4QoYdlTSSq+3gbR+26boBeFcahgxXXMGR6eYhAnbq7GKqxmkRxo5ir+z6RzA1D
	l5gxWTTMgcbPIua81YUxFvNhkrF8OyFmitovAqa4dA9TU/uUYNyWiSuGr/ZTbGIz0nNYbmbs
	Br+0estXUXZ38A6PuQ4rAI1BWiChIB0Fe3/3k1rgR8loM4ADjeXAK8joXgCP1MYKQiWAB0v6
	hwSSngV/NV3DvexPh8PjxvohxmmbGN68McXLo+kY6PphHZxTgx4FdDtpwT4P9teUD9kJOgT2
	fD1GellKx0P9mSpc6OoCsEz7eEiQ0ElQ+6UY8zKgA2Df/WpM6AqEne/OYsILaFhhbcUFHgNd
	bz0igYPhqz6XWPBPh6Zb30iBY2Hp+9P/OBxeKP+IC0eMgvf07whhdyysv9RO6AA0+NQZfKIM
	PlEGnyiDT5QJiMwgUMPzmaodfGQWmxvBKzN5TZYqYuO2TAsY/DotnoZV18Gdzt4IO8AoYAeQ
	wuX+0rz8mM0y6SblzjyW27ae02SwvB2Mowh5oLTrdSgro1VKNbuVZbNZ7r+KUZKgAsyY4Jme
	u9BJN6lKjHrCXaxOy9X2SDXT3r8YkLXIUy3cVEdO48jU5WVvolpDpbawUJUuuiLk59Uex5yt
	0bWmyZm6REtBgKJPN+yCdbKtxF60Z2DtZfujMD173ug4VLV/QfOagLFxqx7qCxeMR8NTjPsj
	+7aIHOOWrDf/SeVXzpctEZ+72DB32YMr+RWpI9STolyzJQp1XbUpaapttyfhz4zSqnViJq+Z
	63i+1x2/b2lIb3L8xqO3L+H5OU8mJLfsqrp++IiNcEQlbk+sXdwc/sx4UmG9WXgmOqczN/lA
	W6X/Lbcnu3teSuld6aSjwS7uUXDCFUq6Ji4lZbQEOmdq+o/JCT5NGRmGc7zyL/cuSAypAwAA
X-CMS-MailID: 20240508182624uscas1p2693660020f1c82155813d83e905662e7
CMS-TYPE: 301P
X-CMS-RootMailID: 20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
	<9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
	<66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Mon, May 06, 2024 at 04:47:37PM -0700, Dan Williams wrote:
> Adam Manzanares wrote:
> > Hello all,
> >=20
> > I would like to have a discussion with the CXL development community ab=
out
> > current outstanding issues and also invite developers interested in RAS=
 and
> > memory tiering to participate.
>=20
> Thanks for putting this together Adam!

NP, its been great working together in the community.

>=20
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
> Dave already replied here but one thing I will add is help keeping an
> eye out for things that should be in queue. Likely a good way to
> do that is send a note along with a review so both get reflected in the
> tracking.
>=20

Noted.

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
>=20
> If I could uplevel this a bit there are multiple efforts in memory RAS
> that likely want to figure out a cohesive story, or at least make
> conscious decisions about implementation divergence. Some related work
> that caught my eye:
>=20
> * AMD M1300 specific poison handling that sounds similar to CXL List
>   Poison facility:
>   http://lore.kernel.org/r/20240214033516.1344948-3-yazen.ghannam@amd.com
>=20
> * Scrub subsystem that has both ACPI and CXL intercepts:
>   http://lore.kernel.org/r/20240419164720.1765-1-shiju.jose@huawei.com
>=20
> * Inconsistencies between firmware reported fatal errors and native
>   error handling, compare:
>=20
>   ghes_proc()::
>         if (ghes_severity(estatus->error_severity) >=3D GHES_SEV_PANIC)
>                 __ghes_panic(ghes, estatus, buf_paddr, FIX_APEI_GHES_IRQ)=
;
>=20
>   ...vs:
>=20
>   pcie_do_recovery()::
>         /* TODO: Should kernel panic here? */
>         pci_info(bridge, "device recovery failed\n");
>=20
>   Also the inconsistencies between EXTLOG, GHES, BERT, and native error
>   reporting.
>=20

Thanks for pointing these out. I will try to put all of these references
in context for discussion.

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
> I think benchmarking for memory-tiering is orthogonal to patch
> unit, function, and integration testing.
>=20

Agreed.=20

> For testing I think it is an "all of the above plus hardware testing if
> possible" situation. My hope is to get to a point where CXL patchwork
> lights up "S/W/F" columns with backend tests similar to NETDEV
> patchwork:
>=20
> https://patchwork.kernel.org/project/netdevbpf/list/
>=20
> There are some initial discussions about how to do this likely we can
> grab some folks to discuss more.
>=20
> I think Paul and Song would be useful to have for this discussion. Can
> you recommend others that would be useful for this or other CXL
> topics to help with timeslot conflict resolution?
>=20

Luis already chimed in and he is definitely our expert in terms of
establishing baselines for new functionalities.=20

