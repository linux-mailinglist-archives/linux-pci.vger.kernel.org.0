Return-Path: <linux-pci+bounces-1252-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74981AACE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 00:11:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEAB1F255EC
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 23:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DFF4D589;
	Wed, 20 Dec 2023 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cT6EvW6x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DB14B5D0;
	Wed, 20 Dec 2023 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20231220225819usoutp02a2b7636fa1a1a83d085f37470b58fa99~irFcombhy3179731797usoutp02i;
	Wed, 20 Dec 2023 22:58:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20231220225819usoutp02a2b7636fa1a1a83d085f37470b58fa99~irFcombhy3179731797usoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703113099;
	bh=pWPHRez3lE3xKoymhilbgrompZKvRUVieFbZgZqSp6w=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cT6EvW6x3e7bJAP/IZGn/qKfONUzDEXiOSIWIpj7AMOtUHCAJ5O0z42nG3iAosbwE
	 IcF1QFLncvqdY4gWYMkkSyR7NKvJsLjc1US9k+ZTDSZbjBvlJSx9H43Du097VeWvUP
	 T0EHKnhw+sIZr3xRZAa9b8bodqOsVarz9I6NXpjA=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231220225818uscas1p24cb8016b3d74556b586b975fc854aa4a~irFcKqyMG1793317933uscas1p2D;
	Wed, 20 Dec 2023 22:58:18 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id CC.12.09678.A8173856; Wed,
	20 Dec 2023 17:58:18 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231220225818uscas1p1e01e19bc82953b21b473ae1daf17e839~irFblIfRf2098420984uscas1p1A;
	Wed, 20 Dec 2023 22:58:18 +0000 (GMT)
X-AuditID: cbfec36d-85fff700000025ce-fb-6583718a35d0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id EA.4B.09813.A8173856; Wed,
	20 Dec 2023 17:58:18 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 20 Dec 2023 14:58:17 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	20 Dec 2023 14:58:17 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 1/2] Revert
 "PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes"
Thread-Topic: [PATCH 1/2] Revert "PCI/IOV: Serialize sysfs sriov_numvfs
 reads vs writes"
Thread-Index: AQHaM5gFg92cIiE8Xka1UVYgjQ/z/A==
Date: Wed, 20 Dec 2023 22:58:17 +0000
Message-ID: <170311309712.2826.11254260046040224092.stgit@bgt-140510-bm01.eng.stellus.in>
In-Reply-To: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B10883F28563046AE2025CE533E93D4@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djXc7pdhc2pBtdnGVp8+9/DZrGkKcPi
	yr89jBabNjxhsbi8aw6bxdl5x9kc2DwWbCr16G1+x+bxft9VNo/Pm+QCWKK4bFJSczLLUov0
	7RK4Mj5+/sVYMIu7YseUT4wNjF+4uhg5OSQETCTedB9j7WLk4hASWMkoMe/+IzYIp5VJ4tXS
	18wwVd8ePASzhQTWMEq0XnKDKPrEKDH98UQmCGcZo8S3CQ2sIFVsApoSv66sYQKxRQTmMEnM
	uOAJYgsLhErsO3+PGSIeJbG/8SAbhK0ncWzHO6B6Dg4WAVWJZQ3xIGFegUiJvq2N7CA2J1D5
	nyOfwcoZBcQkvp+CGM8sIC5x68l8JohDBSUWzd4DdbSYxL9dD9kgbEWJ+99fsoOMZwY6bf0u
	fYhWO4kzyw8wQ9iKElO6H7JDrBWUODnzCQtEq6TEwRU3WEBelBDYwyGx7NZrqF0uEv9W9rFC
	2NISf+8ug4pnS6xc3wH2ioRAgUTDkSCIsLXEwj/roU7mk/j76xHjBEblWUg+mIVw3Swk181C
	ct0sJNctYGRdxSheWlycm55abJiXWq5XnJhbXJqXrpecn7uJEZiATv87nLuDccetj3qHGJk4
	GA8xSnAwK4nw7u1sShXiTUmsrEotyo8vKs1JLT7EKM3BoiTOa2h7MllIID2xJDU7NbUgtQgm
	y8TBKdXApHUoa8a/Y6UHUkweb1AJOSj+d1tJZHTYZZfJe/cZhzqmNW/kcQk4+KboI++b/ZNq
	4/9/zv2zor//8cEp8s9nOVnHyVe63zk7bc901/Xzn7/eODf0knPHhQMF+5S0mG0uzlq52ov5
	VfFt2Qx35tyeyINtM8si37ILVVQyJho3Zj62bTW9+GrTs3qpaoXs2UtP7+CeP2t5ghC/6vx5
	NYdsp3NIddkHai384ef/zn6f3KKMHP2pR/ICGI2aV/90+OGc58OTMydYuuzCGnebO46t+lfe
	1a7yuPaf/W3PRL9smxjDeyIBzdcucuyoSLnomfxMMKZUYcm2JSf9ONMkT3JpqTV2sG75fVNA
	b8HLyUnHlFiKMxINtZiLihMBqaKDJa8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsWS2cDspNtV2JxqsPomr8W3/z1sFkuaMiyu
	/NvDaLFpwxMWi8u75rBZnJ13nM2BzWPBplKP3uZ3bB7v911l8/i8SS6AJYrLJiU1J7MstUjf
	LoEr4+PnX4wFs7grdkz5xNjA+IWri5GTQ0LAROLbg4fMXYxcHEICqxgljm99xQThfGKUuDFv
	GQtIlZDAMkaJ+005IDabgKbErytrmEBsEYE5TBIzLniC2MICoRJrdjYzQsSjJO4eWM4GYetJ
	HNvxDqieg4NFQFViWUM8SJhXIFKib2sjO8T4SIn2u59ZQWxOoNY/Rz6DtTIKiEl8PwWxillA
	XOLWk/lMEEcLSCzZc54ZwhaVePn4HyuErShx//tLdpBVzEBnrt+lD9FqJ3Fm+QFmCFtRYkr3
	Q3aIEwQlTs58wgLRKilxcMUNlgmM4rOQbJuFMGkWkkmzkEyahWTSAkbWVYzipcXFuekVxUZ5
	qeV6xYm5xaV56XrJ+bmbGIFRevrf4egdjLdvfdQ7xMjEwXiIUYKDWUmEd29nU6oQb0piZVVq
	UX58UWlOavEhRmkOFiVx3rsPNFKFBNITS1KzU1MLUotgskwcnFINTJ236pmytrnvmLP6T/6R
	mROLQ6fWTI9N2PTLO3VDI//bndOVc5lyp/scMJv2p7ZPzPjsg2vL9qfdUT52+opZm/qB1P6Z
	8lErI+d2ljnFd6xcZVMgKN37u+aA4Z0/gXZXtr7Z6RK7Wthy/ux5EQIKx9OSUz9G9B5e5f9/
	3tldLNNzTpx2/as1Z2nbsex8RdU9QqoVz7+5bQq4ueuo5x4erq1yrj/P3PNK3nLFfLfzbt2j
	hyRmssTXnno+oZV1M8/3VDOXPb1TN7btmnnuVdDevn/xZ6Nftf1gKjxgKfDfdI094/eTJ2Y7
	7fzt7njrYYyeT3PPw6c6b1+ZvmM5NftKSeLHh8fvCb34wnX3hNnrAxvXK7EUZyQaajEXFScC
	ABZb+LNBAwAA
X-CMS-MailID: 20231220225818uscas1p1e01e19bc82953b21b473ae1daf17e839
CMS-TYPE: 301P
X-CMS-RootMailID: 20231220225818uscas1p1e01e19bc82953b21b473ae1daf17e839
References: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
	<CGME20231220225818uscas1p1e01e19bc82953b21b473ae1daf17e839@uscas1p1.samsung.com>

VGhlIHByb3BlciB3YXkgdG8gZGV0ZWN0IGEgY2hhbmdlIHRvIHRoZSBudW1fVkZzIHZhbHVlIGlz
IHRvIGxpc3RlbiBmb3IgYQpzeXNmcyBldmVudCwgbm90IHRvIGFkZCBhIGRldmljZV9sb2NrKCkg
b24gdGhlIGF0dHJpYnV0ZSBfc2hvdygpIGluIHRoZQprZXJuZWwuCgpUaGlzIHJldmVydHMgY29t
bWl0IDM1ZmY4NjdiNzY1NzZlMzJmMzRjNjk4Y2NkMTEzNDNmN2Q2MTYyMDQuClJldmVydCBoYWQg
YSBzbWFsbCBjb25mbGljdCwgdGhlIHNwcmludGYoKSBpcyBub3cgY2hhbmdlZCB0byBzeXNmc19l
bWl0KCkuCgpTdWdnZXN0ZWQtYnk6IExlb24gUm9tYW5vdnNreSA8bGVvbnJvQG52aWRpYS5jb20+
ClNpZ25lZC1vZmYtYnk6IEppbSBIYXJyaXMgPGppbS5oYXJyaXNAc2Ftc3VuZy5jb20+Ci0tLQog
ZHJpdmVycy9wY2kvaW92LmMgfCAgICA4ICstLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvaW92LmMg
Yi9kcml2ZXJzL3BjaS9pb3YuYwppbmRleCAyNWRiZTg1YzQyMTcuLmQ0NjQ2YmRjZDg4NyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9wY2kvaW92LmMKKysrIGIvZHJpdmVycy9wY2kvaW92LmMKQEAgLTM5
NSwxNCArMzk1LDggQEAgc3RhdGljIHNzaXplX3Qgc3Jpb3ZfbnVtdmZzX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LAogCQkJCSBjaGFyICpidWYpCiB7CiAJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0
b19wY2lfZGV2KGRldik7Ci0JdTE2IG51bV92ZnM7Ci0KLQkvKiBTZXJpYWxpemUgdnMgc3Jpb3Zf
bnVtdmZzX3N0b3JlKCkgc28gcmVhZGVycyBzZWUgdmFsaWQgbnVtX1ZGcyAqLwotCWRldmljZV9s
b2NrKCZwZGV2LT5kZXYpOwotCW51bV92ZnMgPSBwZGV2LT5zcmlvdi0+bnVtX1ZGczsKLQlkZXZp
Y2VfdW5sb2NrKCZwZGV2LT5kZXYpOwogCi0JcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXVcbiIs
IG51bV92ZnMpOworCXJldHVybiBzeXNmc19lbWl0KGJ1ZiwgIiV1XG4iLCBwZGV2LT5zcmlvdi0+
bnVtX1ZGcyk7CiB9CiAKIC8qCgo=

