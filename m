Return-Path: <linux-pci+bounces-3313-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F438500DF
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 00:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C8E1C2418A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9994038396;
	Fri,  9 Feb 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LusQBJ16"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C71538FB9;
	Fri,  9 Feb 2024 23:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522738; cv=none; b=CIe4jl7yvndKnDwiIo1p+tgNqbwY/9FlSbJw35lS3fc4cMwcl+YqbGS4fanvoelox73mlhnk/qgf9a41cONa4j/EA1Ep6LUOFGOUHWUp8Yd9q6gUQMzdFGfy1afwD1FsXP1GlHstoQoPWYHTeGolamTauUcpOVK2jEGr3B87JOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522738; c=relaxed/simple;
	bh=NWHjQPlaGIQ9OtliJHmGY1JMnvToGgMO8MA8ryL6e5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=ZLVeItb58A219DQmxjOGVLQ8j2C6XD+FfF+pTH7lQ30EylsNhwSZcdUlQ2XBYN2AoumnsEvZ/J+pMNSZuDoTPm+9WGv3VTVIpcj5xmT4d98mp+t9qoLS1Mr0/9aYzSZKUWC8gGtd5ml+gKUL7wSZb3gnDHgEjQH/b8mbbji5krI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LusQBJ16; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240209235214usoutp0211a981d2cc3704b6e04b6afb426759d7~yVuFVnazW0735807358usoutp02P;
	Fri,  9 Feb 2024 23:52:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240209235214usoutp0211a981d2cc3704b6e04b6afb426759d7~yVuFVnazW0735807358usoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707522734;
	bh=NWHjQPlaGIQ9OtliJHmGY1JMnvToGgMO8MA8ryL6e5g=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LusQBJ16MTV4T+mTwWDCGSexl6lXIN7AQppjKIB6Hmy5/0FLZGqWv6b0NgZolkSY+
	 lZjvi1QT4Zeu5qbVMrKyVDAVxkcC3SOiamThh6szztPK/pY394hFkyV76E1lFF4+28
	 /ODqlv7WejgD+GiUpDNN7bOSDLV4z7vwI3qWRNOM=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209235213uscas1p1405627f096500d89d28cc2b46806a5fd~yVuEi2rxO2023420234uscas1p1P;
	Fri,  9 Feb 2024 23:52:13 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 73.51.09678.DAAB6C56; Fri, 
	9 Feb 2024 18:52:13 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4~yVuEO-23j3138731387uscas1p2s;
	Fri,  9 Feb 2024 23:52:13 +0000 (GMT)
X-AuditID: cbfec36d-85fff700000025ce-c6-65c6baadf240
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id A1.0B.50167.DAAB6C56; Fri, 
	9 Feb 2024 18:52:13 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 9 Feb 2024 15:52:12 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	9 Feb 2024 15:52:12 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: [PATCH v2 1/2] PCI/IOV: Revert
 "PCI/IOV: Serialize sysfs sriov_numvfs reads vs writes"
Thread-Topic: [PATCH v2 1/2] PCI/IOV: Revert "PCI/IOV: Serialize sysfs
 sriov_numvfs reads vs writes"
Thread-Index: AQHaW7MAtwi2xwjfZkaUZDAOVEJQAw==
Date: Fri, 9 Feb 2024 23:52:12 +0000
Message-ID: <170752273224.1693615.11371097645648272257.stgit@bgt-140510-bm01.eng.stellus.in>
In-Reply-To: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <89791AD5EB1C934187241FFFDADB64F6@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djXc7prdx1LNfg6Wdni2/8eNoslTRkW
	V/7tYbTYtOEJi8XlXXPYLM7OO85msf7rezYHdo8Fm0o9epvfsXm0PDvJ5vF+31U2j8+b5AJY
	o7hsUlJzMstSi/TtErgymmbsYSnYJlBxe3EDewNjg0AXIyeHhICJxMSnRxlBbCGBlYwSC3qU
	IexWJomLr4Ngal427GPtYuQCiq9hlNh9YxorRNFHRol/5+0gEksZJSb397KDJNgENCV+XVnD
	BJIQEbjKJDF59QdmkISwQKLEjeb3LCC2iECaxLXTlxghbD2JR/+fgtksAioS/26uAavnFYiR
	2PPxLROIzQlkv+vbBBZnFBCT+H5qDVicWUBc4taT+UwQpwpKLJq9hxnCFpP4t+shG4StKHH/
	+0ug4ziA6jUl1u/Sh2i1k3gxdx8bhK0oMaX7ITvEWkGJkzOfsEC0SkocXHGDBeQXCYEzHBLT
	Xn5mhUi4SLw8vYcdwpaWuHp9KtTebImV6zuYQHZJCBRINByBhqK1xMI/66FO5pP4++sR4wRG
	5VlIPpiFcN0sJNfNQnLdLCTXLWBkXcUoXlpcnJueWmyYl1quV5yYW1yal66XnJ+7iRGYlE7/
	O5y7g3HHrY96hxiZOBgPMUpwMCuJ8IYsOZIqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfQ9mSy
	kEB6YklqdmpqQWoRTJaJg1OqgclJ++PdVTMvKqUGN+qcm60vt7316E/914bbYzbu3/T/N4fb
	kzcKmskGc+tKm5PutIifbHcrnGcg9MDJVeZ0w6Sp500kxEKzVsxQmPgrzHd6UuubvZOOrp2U
	Ktz/Sr+i/+LbxRV3WGtXS60qk5olfOrn+u9vM7vX1oqsqjx4etYUFS0Fq5nv7V+kbr/8QtTn
	4nGJ5WU5f8SP7f7eucHm1fuV7C5nP7mXCcp8PngvzIT7XRb/tsY5tnZvDDtuRC8X0bql8m/e
	xxPTuOflvlL9edZ7ocyczmfH4m5uXj35b+B34TvzElacfih4mKPw1SenIzXft13T5F3TvK9k
	5g7R4rp/z9XkVqb8Pldlf09w1eMEOyWW4oxEQy3mouJEANMPk6i5AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRmVeSWpSXmKPExsWS2cDsrLt217FUg2e7eS2+/e9hs1jSlGFx
	5d8eRotNG56wWFzeNYfN4uy842wW67++Z3Ng91iwqdSjt/kdm0fLs5NsHu/3XWXz+LxJLoA1
	issmJTUnsyy1SN8ugSujacYeloJtAhW3FzewNzA2CHQxcnJICJhIvGzYx9rFyMUhJLCKUWLF
	lbUsEM5HRoklS5dAZZYySiw8+4kNpIVNQFPi15U1TCAJEYGrTBKTV39gBkkICyRKXL08jxHE
	FhFIk7h2+hKUrSfx6P9TMJtFQEXi3801YPW8AjESez6+ZQKxhQSiJeZPnMwOYnMCxd/1bQKr
	YRQQk/h+ag1YDbOAuMStJ/OZIO4WkFiy5zwzhC0q8fLxP1YIW1Hi/veXQHM4gOo1Jdbv0odo
	tZN4MXcfG4StKDGl+yE7xAmCEidnPmGBaJWUOLjiBssERvFZSLbNQpg0C8mkWUgmzUIyaQEj
	6ypG8dLi4tz0imLDvNRyveLE3OLSvHS95PzcTYzA+D3973DkDsajtz7qHWJk4mA8xCjBwawk
	whuy5EiqEG9KYmVValF+fFFpTmrxIUZpDhYlcd67DzRShQTSE0tSs1NTC1KLYLJMHJxSDUwh
	Bi/tDFxrHTed+iEn92TBBPt+U2WORczPtqw6+P3f4yCjHetUgiSvzLz38cHu1J7lvUveCPb8
	XbpWft7iWQElPFEPWQPrFv6YdrfRsejP1Dm3801N/I0cylOrW1Nl3f6lLK2YZnLkyeKQtO/b
	FpnuCwqst04uVTr76oH1kkO/7V/HRcmo+dlGum27lbDtZ1ce7web8xtjSs7t3nVg3b1nRs9f
	XU+WbXNssit4pPBtr+/sUC6NzI8pSfpqkzZeWnl3xg/TuaZOru3d4dnlsZwXF9TXSZyJTfnf
	NLEi+/gsj5N7L9/rWvm0+/JL371hVq0pLVvvGO6slT/oKiwhstZtz7E9308ayq+4nBNsJ1Ko
	xFKckWioxVxUnAgAc2HpCE4DAAA=
X-CMS-MailID: 20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4
CMS-TYPE: 301P
X-CMS-RootMailID: 20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4
References: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
	<CGME20240209235213uscas1p2e8de2bdf05e6e7cba51bd41ddb42a8e4@uscas1p2.samsung.com>

SWYgYW4gU1ItSU9WIGVuYWJsZWQgZGV2aWNlIGlzIGhlbGQgYnkgdmZpbywgYW5kIHRoZSBkZXZp
Y2UgaXMgcmVtb3ZlZCwKdmZpbyB3aWxsIGhvbGQgZGV2aWNlIGxvY2sgYW5kIG5vdGlmeSB1c2Vy
c3BhY2Ugb2YgdGhlIHJlbW92YWwuIElmCnVzZXJzcGFjZSByZWFkcyB0aGUgc3Jpb3ZfbnVtdmZz
IHN5c2ZzIGVudHJ5LCB0aGF0IHRocmVhZCB3aWxsIGJlIGJsb2NrZWQKc2luY2Ugc3Jpb3ZfbnVt
dmZzX3Nob3coKSBhbHNvIHRyaWVzIHRvIGFjcXVpcmUgdGhlIGRldmljZSBsb2NrLiBJZiB0aGF0
CnNhbWUgdGhyZWFkIGlzIHJlc3BvbnNpYmxlIGZvciByZWxlYXNpbmcgdGhlIGRldmljZSB0byB2
ZmlvLCBpdCByZXN1bHRzIGluCmEgZGVhZGxvY2suCgpUaGUgcHJvcGVyIHdheSB0byBkZXRlY3Qg
YSBjaGFuZ2UgdG8gdGhlIG51bV9WRnMgdmFsdWUgaXMgdG8gbGlzdGVuIGZvciBhCnN5c2ZzIGV2
ZW50LCBub3QgdG8gYWRkIGEgZGV2aWNlX2xvY2soKSBvbiB0aGUgYXR0cmlidXRlIF9zaG93KCkg
aW4gdGhlCmtlcm5lbC4KClRoaXMgcmV2ZXJ0cyBjb21taXQgMzVmZjg2N2I3NjU3NmUzMmYzNGM2
OThjY2QxMTM0M2Y3ZDYxNjIwNC4KUmV2ZXJ0IGhhZCBhIHNtYWxsIGNvbmZsaWN0LCB0aGUgc3By
aW50ZigpIGlzIG5vdyBjaGFuZ2VkIHRvIHN5c2ZzX2VtaXQoKS4KCkxpbms6IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2xpbnV4LXBjaS9aWEpJNStmOGJVZWxWWHF1QHVidW50dS8KU3VnZ2VzdGVk
LWJ5OiBMZW9uIFJvbWFub3Zza3kgPGxlb25yb0BudmlkaWEuY29tPgpSZXZpZXdlZC1ieTogTGVv
biBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4KU2lnbmVkLW9mZi1ieTogSmltIEhhcnJp
cyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJzL3BjaS9pb3YuYyB8ICAgIDgg
Ky0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNyBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9pb3YuYyBiL2RyaXZlcnMvcGNpL2lvdi5jCmluZGV4
IGFhYTMzZThkYzRjOS4uMGNhMjBjZDUxOGQ1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3BjaS9pb3Yu
YworKysgYi9kcml2ZXJzL3BjaS9pb3YuYwpAQCAtMzk1LDE0ICszOTUsOCBAQCBzdGF0aWMgc3Np
emVfdCBzcmlvdl9udW12ZnNfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCiAJCQkJIGNoYXIgKmJ1
ZikKIHsKIAlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoZGV2KTsKLQl1MTYgbnVt
X3ZmczsKLQotCS8qIFNlcmlhbGl6ZSB2cyBzcmlvdl9udW12ZnNfc3RvcmUoKSBzbyByZWFkZXJz
IHNlZSB2YWxpZCBudW1fVkZzICovCi0JZGV2aWNlX2xvY2soJnBkZXYtPmRldik7Ci0JbnVtX3Zm
cyA9IHBkZXYtPnNyaW92LT5udW1fVkZzOwotCWRldmljZV91bmxvY2soJnBkZXYtPmRldik7CiAK
LQlyZXR1cm4gc3lzZnNfZW1pdChidWYsICIldVxuIiwgbnVtX3Zmcyk7CisJcmV0dXJuIHN5c2Zz
X2VtaXQoYnVmLCAiJXVcbiIsIHBkZXYtPnNyaW92LT5udW1fVkZzKTsKIH0KIAogLyoKCg==

