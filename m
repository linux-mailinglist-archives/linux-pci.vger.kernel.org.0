Return-Path: <linux-pci+bounces-1253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1651F81AAE3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 00:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F261F28A8C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 23:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9E74F8B2;
	Wed, 20 Dec 2023 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FyZ+W7Y/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EF150264;
	Wed, 20 Dec 2023 23:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231220225813usoutp01a69809fd1697b5b3d6bf63c8bdf8d1a8~irFXKeojt1790817908usoutp01k;
	Wed, 20 Dec 2023 22:58:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231220225813usoutp01a69809fd1697b5b3d6bf63c8bdf8d1a8~irFXKeojt1790817908usoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703113093;
	bh=vHjHVuNeMvsYn/jGlYOwAfeBkkG04z0tW8qpz0yXs/Q=;
	h=From:To:Subject:Date:References:From;
	b=FyZ+W7Y/VhbLPiZsAXd51gGWEz9YXuY2oZIV21iTyB70lF4BxrP+5ZJExlU64bUGW
	 KH+gx0+9RicXHf+azd8lZ9GDYU6FWSy9BX14XHNvTFM1umu+YPFEZ4XfCie6llGLO1
	 Rvjm06yzpIHjQvxELv35qHnZufkE4ljP9Qdmq4tE=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231220225813uscas1p20ef1e841a3f4350729c33fac0b286679~irFXB_21L2500725007uscas1p2-;
	Wed, 20 Dec 2023 22:58:13 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 5A.12.09678.58173856; Wed,
	20 Dec 2023 17:58:13 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231220225813uscas1p15c950a58c7de44d32199a63a13f1bb31~irFWtWa1u0648706487uscas1p1Y;
	Wed, 20 Dec 2023 22:58:13 +0000 (GMT)
X-AuditID: cbfec36d-acdff700000025ce-ea-658371852dd0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 17.DE.09930.48173856; Wed,
	20 Dec 2023 17:58:12 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 20 Dec 2023 14:58:12 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	20 Dec 2023 14:58:12 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 0/2] pci/iov: avoid device_lock() when reading sriov_numvfs
Thread-Topic: [PATCH 0/2] pci/iov: avoid device_lock() when reading
	sriov_numvfs
Thread-Index: AQHaM5gBfWDt8KjT2UOEaPDLPlceog==
Date: Wed, 20 Dec 2023 22:58:12 +0000
Message-ID: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF2E3680E2EA3F46880DED17DB27D83B@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djX87qthc2pBncnCFt8+9/DZrGkKcPi
	yr89jBabNjxhsbi8aw6bxdl5x9kc2DwWbCr16G1+x+bxft9VNo/Pm+QCWKK4bFJSczLLUov0
	7RK4MuY+bGIq2MRdsfXaU+YGxh7uLkZODgkBE4kpHbsYuxi5OIQEVjJKdL+dzALhtDJJ3On4
	xgpTterlInaIxBpGiV+T5zNBOJ8YJbbOmQ/VsoxRoulZMxtIC5uApsSvK2uYQGwRgTlMEjMu
	eHYxcnAIC3hLHOiugggHSRycf5oVwtaT+NXykwWkhEVAVeLsznqQMK9ApMTFS4fYQWxGATGJ
	76cgJjILiEvcejKfCeI4QYlFs/cwQ9hiEv92PWSDsBUl7n9/yQ4ykhnomvW79CFMO4m++VIQ
	UxQlpnQ/ZIfYJChxcuYTFohOSYmDK26APSUhMJdD4s22rVCrXCRezj/GDmFLS1y9PhVqbbbE
	yvUdTCDzJQQKJBqOBEGErSUW/lkPdTGfxN9fjxghSnglOtqEJjAqzULyyyyEO2ch3DkLyZ2z
	kNy5gJF1FaN4aXFxbnpqsWFearlecWJucWleul5yfu4mRmDqOf3vcO4Oxh23PuodYmTiYDzE
	KMHBrCTCu7ezKVWINyWxsiq1KD++qDQntfgQozQHi5I4r6HtyWQhgfTEktTs1NSC1CKYLBMH
	p1QD09RVEy1Fyo8wrOAqCdOfx9nhWbnt0mRWxq0K02/JRMu0yDm7SllvvTt7ywWJH+lMzJNU
	srad/f6VhyGVJSnX5MyKgxEypSuOvbqse8DtZuNaNd/nX2UZnk7kYZFf2uO75kgl68Pcl0v+
	5Ss2Ll0XovaGQ+J/0UqOv7rBRTef/kh6vUivNMFE2ueg1CrJBNsgufvO3N1lmkJhm72XX1Ur
	PKt7IbNj//+m3ysYdqU+krDZlBo1Y/Pdxckh7ZEq808pH9o6N/EVD3+iOu8bcU25/YqxXTpX
	hRMf/th0cZL4dHGLWxPzbKUWumvof05xeb9NX/E61+slc9UZ1pxLf7Lx5cfMFXyHT0W+s54d
	JWQcpsRSnJFoqMVcVJwIANPKD4CsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCIsWRmVeSWpSXmKPExsWS2cDsrNtS2Jxq0PTf0uLb/x42iyVNGRZX
	/u1htNi04QmLxeVdc9gszs47zubA5rFgU6lHb/M7No/3+66yeXzeJBfAEsVlk5Kak1mWWqRv
	l8CVMfdhE1PBJu6KrdeeMjcw9nB3MXJySAiYSKx6uYi9i5GLQ0hgFaNEx+O3bBDOJ0aJ1d9/
	QmWWMUqceXeVFaSFTUBT4teVNUwgtojAHCaJGRc8uxg5OIQFvCUOdFdBhIMkzi3rYISw9SR+
	tfxkASlhEVCVOLuzHiTMKxApcfHSIXYQm1FATOL7KYiJzALiEreezGeCOE5AYsme88wQtqjE
	y8f/WCFsRYn731+yg4xkBrpm/S59CNNOom++FMQURYkp3Q/ZITYJSpyc+YQFolNS4uCKGywT
	GEVnIVk2C2HQLIRBs5AMmoVk0AJG1lWM4qXFxbnpFcWGeanlesWJucWleel6yfm5mxiBEXf6
	3+HIHYxHb33UO8TIxMF4iFGCg1lJhHdvZ1OqEG9KYmVValF+fFFpTmrxIUZpDhYlcd67DzRS
	hQTSE0tSs1NTC1KLYLJMHJxSDUx7xFam3uBdf47tsnDZ+mnT1nc4+aq6VO3PWVOqdTVm91z5
	G7c3iF3/99I+8NLSlP2bLrm/EChTO7vo5JQpOQXca7JYAjYmzb0bELH8oK+fxZRHSeIbp+9s
	De5n4s2o+vxR+cyGt6/P6OomfdNS2FSulFdsfqh49sXTme7afU8eG56/ycMxXTZj6Wqj/y+6
	r1y2+Dc9893e1WuTLGd0PFCN1tg6/X7X5QmHvnjXTqxut2JekPxGfrrmhTDDX/fnBdsWxd7N
	lU+72Lot6SD77wADmUKvzeUbbuV/XVndsjkxjXNmVrNG6uob7e/u/+U9uWpmfeUDKf1ZJ65m
	ygoIZtUEB+nqql8vFD1wZGmDfeo9JZbijERDLeai4kQAe1AuXycDAAA=
X-CMS-MailID: 20231220225813uscas1p15c950a58c7de44d32199a63a13f1bb31
CMS-TYPE: 301P
X-CMS-RootMailID: 20231220225813uscas1p15c950a58c7de44d32199a63a13f1bb31
References: <CGME20231220225813uscas1p15c950a58c7de44d32199a63a13f1bb31@uscas1p1.samsung.com>

SWYgU1ItSU9WIGVuYWJsZWQgZGV2aWNlIGlzIGhlbGQgYnkgdmZpbywgYW5kIGRldmljZSBpcyBy
ZW1vdmVkLCB2ZmlvIHdpbGwgaG9sZApkZXZpY2UgbG9jayBhbmQgbm90aWZ5IHVzZXJzcGFjZSBv
ZiB0aGUgcmVtb3ZhbC4gSWYgdXNlcnNwYWNlIHJlYWRzIHNyaW92X251bXZmcwpzeXNmcyBlbnRy
eSwgdGhhdCB0aHJlYWQgd2lsbCBiZSBibG9ja2VkIHNpbmNlIHNyaW92X251bXZmc19zaG93KCkg
YWxzbyB0cmllcwp0byBhY3F1aXJlIHRoZSBkZXZpY2UgbG9jay4gSWYgdGhhdCBzYW1lIHRocmVh
ZCBpcyByZXNwb25zaWJsZSBmb3IgcmVsZWFzaW5nIHRoZQpkZXZpY2UgdG8gdmZpbywgaXQgcmVz
dWx0cyBpbiBhIGRlYWRsb2NrLgogCk9uZSBwYXRjaCB3YXMgcHJvcG9zZWQgdG8gYWRkIGEgc2Vw
YXJhdGUgbXV0ZXgsIHNwZWNpZmljYWxseSBmb3Igc3RydWN0IHBjaV9zcmlvdiwKdG8gc3luY2hy
b25pemUgYWNjZXNzIHRvIHNyaW92X251bXZmcyBpbiB0aGUgc3lzZnMgcGF0aHMgKHJlcGxhY2lu
ZyB1c2Ugb2YgdGhlCmRldmljZV9sb2NrKCkpLiBMZW9uIGluc3RlYWQgc3VnZ2VzdGVkIGp1c3Qg
cmV2ZXJ0aW5nIHRoZSBjb21taXQgMzVmZjg2N2I3NjUgd2hpY2gKaW50cm9kdWNlZCBkZXZpY2Vf
bG9jaygpIGluIHRoZSBzdG9yZSBwYXRoLiBUaGlzIGFsc28gbGVkIHRvIGEgc21hbGwgZml4IGFy
b3VuZApvcmRlcmluZyBvbiB0aGUga29iamVjdF91ZXZlbnQoKSB3aGVuIHNyaW92X251bXZmcyBp
cyB1cGRhdGVkLgoKUmVmOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvWlhKSTUr
ZjhiVWVsVlhxdUB1YnVudHUvIAogCi0tLQoKSmltIEhhcnJpcyAoMik6CiAgICAgIFJldmVydCAi
UENJL0lPVjogU2VyaWFsaXplIHN5c2ZzIHNyaW92X251bXZmcyByZWFkcyB2cyB3cml0ZXMiCiAg
ICAgIHBjaS9pb3Y6IGZpeCBrb2JqZWN0X3VldmVudCgpIG9yZGVyaW5nIGluIHNyaW92X2VuYWJs
ZSgpCgoKIGRyaXZlcnMvcGNpL2lvdi5jIHwgICAxMCArKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKLS0K

