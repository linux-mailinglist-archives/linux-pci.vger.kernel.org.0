Return-Path: <linux-pci+bounces-3314-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487BF8500E1
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 00:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE621C23DEC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FB238DFB;
	Fri,  9 Feb 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mN14RZDL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044F538399;
	Fri,  9 Feb 2024 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522742; cv=none; b=qYsCvZntC1Xb7vqZKhUV+JOxWaV5hJaRStZg8SEt2zz4FSd7M9LwhEw33rb5BPOaGnGNCpsnUcsd/RcC1SEVhiveVT0fpb0zaFwd/YrsnSPAycNwRoNccsGoPsnH+j1RUPtowuQF+reFH+ITuh5BpA4qQU2n3EUdjTOrVzqcw40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522742; c=relaxed/simple;
	bh=WLrHOuX9LdrO7L5O1dP72CK5rXJ4snnRsQhv9u8vEK0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=DIMALQU1CgVjvKMuPZ9zJqZhQREBbzrjNPmTa7EprKTHXNkjG0VGksDiWJSFHMzQPpAeEt44g8I4owtygi5LqwS8YxKRW97xa27UovHbvpaVyIFgrmV0ikNozk2wcC6H7WlTI7OEZtw3w5MiPcycvnxvI01SpMPpNZtAjlQZemY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mN14RZDL; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240209235219usoutp0184de282892a811f8b9d7e9d2b15b3cbc~yVuJldZpG0135901359usoutp01F;
	Fri,  9 Feb 2024 23:52:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240209235219usoutp0184de282892a811f8b9d7e9d2b15b3cbc~yVuJldZpG0135901359usoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707522739;
	bh=WLrHOuX9LdrO7L5O1dP72CK5rXJ4snnRsQhv9u8vEK0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=mN14RZDLHqp2SNMowOLAWAowlYnXEl0FcmsVph8ugmoaXOMn6CbUhuxAYJj6U6414
	 SQzYMDTl7M+Ye444r5OHYP57uZX/BoBVIM552DA2HODRWR6QB0BXzSlLY9gORN0PrK
	 e9rVv5Yr3AToaUlZtM4QadfA9Eoe/V9fJHgGCMKw=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209235218uscas1p122a48f65d0cbd18350608763c21ef317~yVuJfB9Ov2264622646uscas1p1O;
	Fri,  9 Feb 2024 23:52:18 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 55.51.09678.2BAB6C56; Fri, 
	9 Feb 2024 18:52:18 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209235218uscas1p2d0978af6623037fa1b9358a2ad2320c5~yVuJLHlSF3138731387uscas1p2u;
	Fri,  9 Feb 2024 23:52:18 +0000 (GMT)
X-AuditID: cbfec36d-acdff700000025ce-cf-65c6bab23583
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 97.EB.50948.2BAB6C56; Fri, 
	9 Feb 2024 18:52:18 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 9 Feb 2024 15:52:17 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	9 Feb 2024 15:52:17 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: [PATCH v2 2/2] pci/iov: fix kobject_uevent() ordering in
 sriov_enable()
Thread-Topic: [PATCH v2 2/2] pci/iov: fix kobject_uevent() ordering in
	sriov_enable()
Thread-Index: AQHaW7MDr2cp3vZCgUeCreKO+yDYPA==
Date: Fri, 9 Feb 2024 23:52:17 +0000
Message-ID: <170752273749.1693615.1293677023514112939.stgit@bgt-140510-bm01.eng.stellus.in>
In-Reply-To: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <2400EE9658E5F547852121863CD747C6@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djX87qbdh1LNfi8zsTi2/8eNoslTRkW
	V/7tYbTYtOEJi8XlXXPYLM7OO85msf7rezYHdo8Fm0o9epvfsXm0PDvJ5vF+31U2j8+b5AJY
	o7hsUlJzMstSi/TtErgyVj/6wFiwhbPixPnNrA2MUzi7GDk5JARMJC7fnsvexcjFISSwklGi
	Y9FSKKeVSaLr8kwWmKpfPyewQSTWMEqsXfWTFcL5yCgx/90LqMxSRolNf5+wgrSwCWhK/Lqy
	hgkkISJwlUli8uoPzCAJYYEgiQdPXzGC2CIC4RIH3jexQdh6Eidm3GYCsVkEVCS+fnwLVsMr
	EC2xe+c5sDinQIzEu75NYHMYBcQkvp9aAxZnFhCXuPVkPhPErYISi2bvYYawxST+7XrIBmEr
	Stz//hLoOQ6gek2J9bv0IVrtJDb1TWSDsBUlpnQ/ZIdYKyhxcuYTqPclJQ6uuMEC8ouEwBkO
	ibvvZkDtcpHYf/8M1C5pielrLkM1ZEusXN/BBLJLQqBAouFIEETYWmLhn/VQJ/NJ/P31iHEC
	o/IsJB/MQrhuFpLrZiG5bhaS6xYwsq5iFC8tLs5NTy02zEst1ytOzC0uzUvXS87P3cQITE2n
	/x3O3cG449ZHvUOMTByMhxglOJiVRHhDlhxJFeJNSaysSi3Kjy8qzUktPsQozcGiJM5raHsy
	WUggPbEkNTs1tSC1CCbLxMEp1cC0UOzw/p0LjoR4dp9LOpM7b8NG9p1ekd8DAzcozuw04pxm
	6Ms3eVVg1+mroQFKV69od/+e051UyTXbZM4bz/sFsi7c9ey/1q3LynzcueGydsrPIoV7LTv2
	cnw/EibstXfBJUmTl4lOHIbNTK65LOXr+1z6L126bJmdtd7g1o99xjud/81RXPWUR9NHS/CD
	rTBva/jdQ7J/4ms+Ol3o/9324kvHU/bIyuU+c10PeqRyOnJcbAxOeL+oKcc5dolyndTcK8YR
	L5yUyjoeSz+ZU7dBjonZjPH0boXbK3Xr2tZebD+e0ynLnfgk0On809yOS4ee3+S7LSo13SlP
	JdeY4cGqG56S6/TYUjcmfJr43lKJpTgj0VCLuag4EQABwtNZvAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWS2cDspLtp17FUg44HShbf/vewWSxpyrC4
	8m8Po8WmDU9YLC7vmsNmcXbecTaL9V/fszmweyzYVOrR2/yOzaPl2Uk2j/f7rrJ5fN4kF8Aa
	xWWTkpqTWZZapG+XwJWx+tEHxoItnBUnzm9mbWCcwtnFyMkhIWAi8evnBLYuRi4OIYFVjBJN
	/z4wQzgfGSXedj5jh3CWMkp8uXyCEaSFTUBT4teVNUwgCRGBq0wSk1eDtHByCAsESTx4+gqs
	SEQgXGLP4oPsELaexIkZt5lAbBYBFYmvH9+C1fAKREvs3nkOLC4EZM+fOBmsnlMgRuJd3yaw
	mYwCYhLfT60Bq2EWEJe49WQ+E8TdAhJL9pxnhrBFJV4+/scKYStK3P/+EmgOB1C9psT6XfoQ
	rXYSm/omskHYihJTuh+yQ5wgKHFy5hMWiFZJiYMrbrBMYBSfhWTbLIRJs5BMmoVk0iwkkxYw
	sq5iFC8tLs5Nryg2zkst1ytOzC0uzUvXS87P3cQIjN/T/w7H7GC8d+uj3iFGJg7GQ4wSHMxK
	IrwhS46kCvGmJFZWpRblxxeV5qQWH2KU5mBREue9+0AjVUggPbEkNTs1tSC1CCbLxMEp1cBU
	6HT4YFyPMENx7U2bpwK//ucua9nLZ5T8eFnxkc49rrPterL2B+/O/33T9cq2UKHZE1gf5nWy
	W5+d8tdLJODpgz1y7kssmSwsNsvsOmWwNYxt3TTmSbOXzi4/5ZywIcP7l4VY0MW2GfW3DofW
	5/3J/Prb0GTeDXWr69wGTNxMO/6KVqyKX3T69oTdD6Tv3fwuWvJ7erVCpTl785TErt2tvgWs
	995yXpHd4LX3gYvLnnovy5RrXhmm5x374kSePftvyew5X+Xq9PvXAlTXTmlvEeu19PVf2tJ6
	vkzwwMavCZVbynWTYpn+rehh4e1XW2rfLrBW8lur/vm/Ln7rl37NUdpzPmf7lOA1Xxtvuj5T
	YinOSDTUYi4qTgQAO5jdO04DAAA=
X-CMS-MailID: 20240209235218uscas1p2d0978af6623037fa1b9358a2ad2320c5
CMS-TYPE: 301P
X-CMS-RootMailID: 20240209235218uscas1p2d0978af6623037fa1b9358a2ad2320c5
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
	<CGME20240209235218uscas1p2d0978af6623037fa1b9358a2ad2320c5@uscas1p2.samsung.com>

V2FpdCB0byBjYWxsIGtvYmplY3RfdWV2ZW50KCkgdW50aWwgYWxsIG9mIHRoZSBhc3NvY2lhdGVk
IGNoYW5nZXMgYXJlIGRvbmUsCmluY2x1ZGluZyB1cGRhdGluZyB0aGUgbnVtX1ZGcyB2YWx1ZS4g
VGhpcyBhdm9pZHMgYW55IHBvc3NpYmlsaXR5IG9mCnVzZXJzcGFjZSByZXNwb25kaW5nIHRvIHRo
ZSBldmVudCBhbmQgZ2V0dGluZyBhIHN0YWxlIHZhbHVlIChhbHRob3VnaApwcm9iYWJseSBpbXBv
c3NpYmxlIHRvIGFjdHVhbGx5IGhhcHBlbikuCgpTdWdnZXN0ZWQtYnk6IExlb24gUm9tYW5vdnNr
eSA8bGVvbnJvQG52aWRpYS5jb20+ClJldmlld2VkLWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25y
b0BudmlkaWEuY29tPgpTaWduZWQtb2ZmLWJ5OiBKaW0gSGFycmlzIDxqaW0uaGFycmlzQHNhbXN1
bmcuY29tPgotLS0KIGRyaXZlcnMvcGNpL2lvdi5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
aW92LmMgYi9kcml2ZXJzL3BjaS9pb3YuYwppbmRleCAwY2EyMGNkNTE4ZDUuLmMwMGIwZjgyMjUy
NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wY2kvaW92LmMKKysrIGIvZHJpdmVycy9wY2kvaW92LmMK
QEAgLTY3Nyw4ICs2NzcsOCBAQCBzdGF0aWMgaW50IHNyaW92X2VuYWJsZShzdHJ1Y3QgcGNpX2Rl
diAqZGV2LCBpbnQgbnJfdmlydGZuKQogCWlmIChyYykKIAkJZ290byBlcnJfcGNpYmlvczsKIAot
CWtvYmplY3RfdWV2ZW50KCZkZXYtPmRldi5rb2JqLCBLT0JKX0NIQU5HRSk7CiAJaW92LT5udW1f
VkZzID0gbnJfdmlydGZuOworCWtvYmplY3RfdWV2ZW50KCZkZXYtPmRldi5rb2JqLCBLT0JKX0NI
QU5HRSk7CiAKIAlyZXR1cm4gMDsKIAoK

