Return-Path: <linux-pci+bounces-22966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F6CA4FF1F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 13:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BC4188FA16
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78915245039;
	Wed,  5 Mar 2025 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="o+kurU52"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EEE2441A3
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179441; cv=none; b=r6oaIYsfeoAYp3qAsIG+VANYxrvu+JBPiswZo+346jQS0l0Ksy7nIja2G59e8PZPNeOLsopPZNKd7Eykop9wo8tgnOvDZ1mzfChnH/OuVtxP7pOBYZzD6P/55Aa4/gIBMXGowJPkTWrMefaEd42PwzF/tnpcZ7sDZJeUsel9unU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179441; c=relaxed/simple;
	bh=gd5LQxYSNobGONqsfWu3J4CvsQJn9S8T/g4qqw/qSsQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=RxY4iwa48K0cs+EUEVx+9arLEW8DqGGfzXXWNpm+iTNgEkA/8MB8+qNhKWXleCYGFlzHf3UtByoaiDFQz8SD9ooQ7+Gb0GU9r1hsKhoC+hnOlPFCx3ims1W3HOn+YJt+vUDvLjVFNgoYdTi26bbus+iNyJSyiuuHYojzxHAP0wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=o+kurU52; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250305125717epoutp0385b4e18c9f7439cebd59315e2e76cb59~p6XkWUSOi2058320583epoutp039
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 12:57:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250305125717epoutp0385b4e18c9f7439cebd59315e2e76cb59~p6XkWUSOi2058320583epoutp039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741179437;
	bh=gd5LQxYSNobGONqsfWu3J4CvsQJn9S8T/g4qqw/qSsQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=o+kurU52q76p8064cA/1np7LRzyqDOvytsjGSNEDr0eAzDZtCgr0kyQJc58YJ4liv
	 ClOOHf9oBdHbEAjf6+XDjOVdPczNytOQBXJafOXSE9hyYTSCW2Lw8Buc02nuNwq8V5
	 pkDnpUHIJ7w9Fefjxy5j1AlCRLwBDooBLLDrXx0A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250305125716epcas5p322c88e6ed91a5222a4693b12e9234e1b~p6XjsaVpt1709517095epcas5p3K;
	Wed,  5 Mar 2025 12:57:16 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z7CHt4xThz4x9Pp; Wed,  5 Mar
	2025 12:57:14 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BD.F8.19933.A2A48C76; Wed,  5 Mar 2025 21:57:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250305090444epcas5p4acfc664ce6db58fb94e563626d6dba98~p3MhwhOu-1500615006epcas5p4c;
	Wed,  5 Mar 2025 09:04:44 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250305090444epsmtrp18b28e75d93a81114b71ebefec3d4f9cf~p3MhviHD91135411354epsmtrp1b;
	Wed,  5 Mar 2025 09:04:44 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-30-67c84a2aac7e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.5D.23488.CA318C76; Wed,  5 Mar 2025 18:04:44 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250305090440epsmtip2174139d7bcd7df32de34daa127ba8ad4~p3MemAZKR0782607826epsmtip2M;
	Wed,  5 Mar 2025 09:04:40 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: =?iso-8859-2?Q?'Krzysztof_Wilczy=F1ski'?= <kw@linux.com>
Cc: "'Geert Uytterhoeven'" <geert@linux-m68k.org>, "'Fan Ni'"
	<nifan.cxl@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-perf-users@vger.kernel.org>, <manivannan.sadhasivam@linaro.org>,
	<lpieralisi@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
	<jingoohan1@gmail.com>, <Jonathan.Cameron@huawei.com>,
	<a.manzanares@samsung.com>, <pankaj.dubey@samsung.com>, <cassel@kernel.org>,
	<18255117159@163.com>, <xueshuai@linux.alibaba.com>,
	<renyu.zj@linux.alibaba.com>, <will@kernel.org>, <mark.rutland@arm.com>,
	"'Yoshihiro Shimoda'" <yoshihiro.shimoda.uh@renesas.com>, "'Linux-Renesas'"
	<linux-renesas-soc@vger.kernel.org>
In-Reply-To: <20250305074447.GC847772@rocinante>
Subject: RE: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Date: Wed, 5 Mar 2025 14:34:39 +0530
Message-ID: <065b01db8dad$a2f0a4a0$e8d1ede0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJfby7SiE0e/TbLvAHLJIl0P7SXpgHiQm8TAh/83CQB4BrFQwHvpDbsAQ7NFRkCkbJgbAIxNbulA4ETfrmx01XmsA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTVxiHOb39glhyBVwPbNp6ZVsGK7ZYusOK25IpuWE6URaXuBjWwV2L
	lLbrh+IyNpQGsKKgwwkNNoLAgDkSyoeglBFAunVDIzY1E0ioAhEdHxsdGQHGWloW/nvOOc+b
	9/zOycvGwr5lRbGzVHpKq5IpCWYIvaP/jdcFMSk/y4WuoteQs2iZha7270S1ZxVosKwBQ1OP
	bTTU4KlkoaZqFxPllywzkPWpi4Ee3q5ioiGLnYmc7c101D49S0PGFSMdjRnPMVDdowc0tNph
	A6im3cNC1QXTAK11d7KQcTQBzS21MtHftgXme1zyRkM5g7xpuQnILvMYi7xuNZDGgRkGaW06
	xyRHXd1Msq+/2HvoTiQnnFdpZGvtN+Tib5fo5MW2JkAuWHekhh7LTlJQskxKy6dUGerMLJV8
	L/FBWvr76QkSoUggSkRvEXyVLIfaS+w7kCpIzlJ60xP8kzKlwbuVKtPpiN3vJGnVBj3FV6h1
	+r0EpclUasSaOJ0sR2dQyeNUlP5tkVAYn+AVP81WXHw+ztBYYe6v5jlWPhjhmkAwG+JieLb8
	PjCBEHYYfgfAApsD8y/+AtA084DhXywCuGI9z9woGfdYGT4Ow20A3q7a45eeAVhfeQH4Dpj4
	m3DCuYL5OAJPgitdM3SfhOEOBuwpLFyXgnEhdE8NrHM4ngIb3W6vxGbT8Wh4uYTrQw6eCIsn
	tvkMDr4V/lI5QfcxhsfBKYc5wLGwvvoF5r8bHy5N1jP8bU/Apf5x4He48O5SyXoyiP8UDP+Y
	rwsU7INFNXXAz+Hwub2N5ecoOF1aGGA5bGytCPhKuNhaS/Pzu7DXWUX383Z4xdFM8zcLhReW
	JwIOB3ZaNngX9Kx2B/xIaBl8yCgDhHlTNvOmbOZN2cybMlwH9CYQSWl0OXJKl6CJV1Gn/v/x
	DHWOFaxPR0xKJ3CPz8f1ARob9AHIxogIzguHXR7GyZSd/pLSqtO1BiWl6wMJ3ve+hEVty1B7
	x0ulTxeJE4ViiUQiTtwjERFcTkGXUR6Gy2V6KpuiNJR2o47GDo7Kp30dc1R0Q/K4I1d0emyE
	3pOnszfM2v7UTEVNb3nloDxi4aBJ6ryXWsH7pCWvjVdhOHyNEdKPVd1yHjXYYew/945/XH7i
	CzJ0J5dq31GHBnql3+1XaGmT/z7ZP1Q0MCmeH453T5q2CghDifRkReT3Z5KeMLu3xEoOTwfx
	5lZzR4SDp4rTqphDZVcEGZ6ID+/ao1NeMpSO8i1Pa1vKTdIGtSU7aI2TfRz7Xb57yFrfHmO+
	Nev66syBzl6hIe3lI8ON0txgR4k1JdfzkeQ8N/pIUNrny8nS5LWg+yj8s0zeoV3Ds4cqtz9r
	ruH1zN+p+FHwKoF3Z0XHU6WuR9fyjgl/4LUQdJ1CJorBtDrZf2vNyhamBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCSvO4a4RPpBhdeClhcaf/NbjH9sKLF
	kqYMi2MTVjBbPLu1l8lixZeZ7BarFl5js2jo+c1qsenxNVaLy7vmsFmcnXeczeLK1nUsFltf
	vmOyaPnTwmJxt6WT1WLp9YtMFn+37WW0WLT1C7vFwuaXjBb/9+xgt2i5Y2rx/udmNouvez+z
	OYh7LF4xhdVjzbw1jB47Z91l91iwqdSj5chbVo9NqzrZPO5c28PmcehwB1DyoaXHkyvTmTw2
	L6n3+HZmIotH35ZVjB6fN8kF8EVx2aSk5mSWpRbp2yVwZdz9+Iyl4IVgxd+OGcwNjM/4uhg5
	OSQETCQefNnE2sXIxSEksJtRYsWNNmaIhKTE54vrmCBsYYmV/56zg9hCAs8YJd59kwex2QR0
	JJ5c+QNWLyJgI/Fn51sWEJtZ4AGrxNtb1RD125glNu0RBbE5BQwkHj47wghiCwt4Sax8+BCo
	noODRUBFYlKPOIjJK2Ap0fEErJpXQFDi5MwnUBMNJJYs/MUEYWtLLFv4GupKBYmfT5exQlyQ
	JfHz8ANGiBpxiaM/e5gnMArPQjJqFpJRs5CMmoWkZQEjyypGydSC4tz03GTDAsO81HK94sTc
	4tK8dL3k/NxNjOC0oaWxg/Hdtyb9Q4xMHIyHGCU4mJVEeF+fOp4uxJuSWFmVWpQfX1Sak1p8
	iFGag0VJnHelYUS6kEB6YklqdmpqQWoRTJaJg1OqgYllU+/ZbS7nDVSiWZOsX3psLnPw4Z7B
	6/n7Wkxx+Z5eToPSL1a523UbltTM9Ahc9E9GM/Cgot3Ta9K1saIVC5+0i1YE+Pk9uiT648AM
	zS6tnE7lPv4eH9kkjo1KU/52y+94qy8WYXdp14UzXC9N+OIiQg9vLp+k8+Xgik/db1oe5wr+
	8O04wpuo99dI7drthVvnmTMpKi7w/idjk6GaeHH/09X/pxbctOMO9NsaErRpUr2B0EHlusyN
	O3S3PQm4x81Q6nVM5FjtMpX2w2wb1JeVrz5r09KVylLzV81cZm+ED1Pvm6m/7rRFWHd2Mx1g
	mbul7ELg4vPrShIP+Wb8+M695LKs6OInC3flnD3pqsRSnJFoqMVcVJwIAE1XIcOKAwAA
X-CMS-MailID: 20250305090444epcas5p4acfc664ce6db58fb94e563626d6dba98
X-Msg-Generator: CA
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250221132035epcas5p47221a5198df9bf86020abcefdfded789
References: <20250221131548.59616-1-shradha.t@samsung.com>
	<CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
	<20250221131548.59616-4-shradha.t@samsung.com> <Z8XrYxP_pZr6tFU8@debian>
	<20250303194647.GC1552306@rocinante>
	<CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>
	<20250304154638.GB2310180@rocinante>
	<061201db8d25$dd1e2bd0$975a8370$@samsung.com>
	<20250305074447.GC847772@rocinante>



> -----Original Message-----
> From: 'Krzysztof Wilczy=F1ski'=20<kw=40linux.com>=0D=0A>=20Sent:=2005=20M=
arch=202025=2013:15=0D=0A>=20To:=20Shradha=20Todi=20<shradha.t=40samsung.co=
m>=0D=0A>=20Cc:=20'Geert=20Uytterhoeven'=20<geert=40linux-m68k.org>;=20'Fan=
=20Ni'=20<nifan.cxl=40gmail.com>;=20linux-kernel=40vger.kernel.org;=20linux=
-=0D=0A>=20pci=40vger.kernel.org;=20linux-arm-kernel=40lists.infradead.org;=
=20linux-perf-users=40vger.kernel.org;=20manivannan.sadhasivam=40linaro.org=
;=0D=0A>=20lpieralisi=40kernel.org;=20robh=40kernel.org;=20bhelgaas=40googl=
e.com;=20jingoohan1=40gmail.com;=20Jonathan.Cameron=40huawei.com;=0D=0A>=20=
a.manzanares=40samsung.com;=20pankaj.dubey=40samsung.com;=20cassel=40kernel=
.org;=2018255117159=40163.com;=0D=0A>=20xueshuai=40linux.alibaba.com;=20ren=
yu.zj=40linux.alibaba.com;=20will=40kernel.org;=20mark.rutland=40arm.com;=
=20'Yoshihiro=20Shimoda'=0D=0A>=20<yoshihiro.shimoda.uh=40renesas.com>;=20'=
Linux-Renesas'=20<linux-renesas-soc=40vger.kernel.org>=0D=0A>=20Subject:=20=
Re:=20=5BPATCH=20v7=203/5=5D=20Add=20debugfs=20based=20silicon=20debug=20su=
pport=20in=20DWC=0D=0A>=20=0D=0A>=20Hello,=0D=0A>=20=0D=0A>=20>=20I=20think=
=20we=20shouldn't=20move=20the=20log=20level=20to=20be=20a=20WARN.=20I=20be=
lieve=20many=0D=0A>=20>=20controllers=20might=20not=20support=20RAS=20DES=
=20feature=20in=20their=20design=20and=0D=0A>=20>=20giving=20a=20warn=20dum=
p=20would=20draw=20unnecessary=20attention.=0D=0A>=20=0D=0A>=20There=20will=
=20be=20no=20backtrack=20printed=20with=20neither=20dev_err()=20nor=20dev_w=
arn(),=20which=20is=20what=20we=20were=20using=20here.=20=20Using=20dev_WAR=
N()=20or=0D=0A>=20the=20WARN()=20macro=20directly=20would=20be=20an=20overk=
ill=20in=20this=20case,=20indeed.=0D=0A>=20=0D=0A=0D=0AOh=20sorry,=20I=20th=
ought=20we=20were=20talking=20about=20WARN()=20here.=0D=0A=0D=0A>=20>=20My=
=20opinion=20is=20to=20silently=20let=20it=20fail=20unless=20the=20user=20i=
s=20actually=0D=0A>=20>=20interested=20in=20getting=20the=20RAS=20DES=20fea=
ture=20up.=0D=0A>=20=0D=0A>=20I=20think,=20what=20we=20have=20there=20now=
=20is=20fine.=20=20We=20don't=20error=20on=20the=20lack=20of=20RAS=20DES=20=
capability=20when=20the=20platform=20does=20not=20support=20it,=0D=0Aand=0D=
=0A>=20only=20return=20an=20error=20following=20a=20memory=20allocation=20f=
ailure,=20which=20should=20ideally=20never=20happen.=0D=0A>=20=0D=0A>=20Tha=
t=20said,=20have=20a=20look=20at=20the=20following:=0D=0A>=20=0D=0A>=20=20=
=20https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=
=3Dcontroller/dwc=0D=0A>=20=0D=0A>=20This=20is=20how=20the=20code=20looks=
=20like=20at=20the=20moment.=0D=0A>=20=0D=0A>=20We=20can=20still=20move=20i=
t=20to=20dev_dbg(),=20so=20basically=20suppress=20any=20errors=20or=20warni=
ngs=20from=20being=20printed=20outside=20of=20the=20debug=20log=20level,=0D=
=0Aif=20you=0D=0A>=20think=20it=20would=20be=20better.=0D=0A>=20=0D=0A=0D=
=0ANo,=20the=20current=20version=20looks=20perfect.=20Thanks=21=0D=0A=0D=0A=
>=20Thank=20you=21=0D=0A>=20=0D=0A>=20=09Krzysztof=0D=0A=0D=0A

