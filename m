Return-Path: <linux-pci+bounces-1251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B17A81AACD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 00:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF267282F33
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3010F4D114;
	Wed, 20 Dec 2023 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k82YbAhI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871A74CB4A;
	Wed, 20 Dec 2023 22:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20231220225824usoutp012c7c73bfb55c20ff424025315b29b139~irFhK4VKv1791017910usoutp01X;
	Wed, 20 Dec 2023 22:58:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20231220225824usoutp012c7c73bfb55c20ff424025315b29b139~irFhK4VKv1791017910usoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703113104;
	bh=j+X1XlpJVazixEjaPvnlQ7y4Y2vct9sGwyqv0nkwLBU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=k82YbAhIjpIMe7pTwzPc/gpGaZ8kvR2FKGjr6CIxOhwUCs9v0tvkxi3icR1K+GI/N
	 yYHOQ1n7sar128O/vE+4fg/+4vWas6r+CWl2zPShYLpm3G9ZvNlgKKEDHSvbeTDo+A
	 VGBFH51ZOkGX5gNspqzZg1PycwhfvNBpwfpfhib0=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231220225823uscas1p2b31e7c1c80b31311e5909e41927dc4ff~irFg01EsS1791717917uscas1p2D;
	Wed, 20 Dec 2023 22:58:23 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 7F.12.09678.F8173856; Wed,
	20 Dec 2023 17:58:23 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20231220225823uscas1p12d012a034806edd76fbc66a8d04e15ee~irFgnoO9m2997329973uscas1p1D;
	Wed, 20 Dec 2023 22:58:23 +0000 (GMT)
X-AuditID: cbfec36d-85fff700000025ce-0b-6583718f50a0
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 78.DE.09930.F8173856; Wed,
	20 Dec 2023 17:58:23 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Wed, 20 Dec 2023 14:58:22 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
	20 Dec 2023 14:58:22 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 2/2] pci/iov: fix kobject_uevent() ordering in
 sriov_enable()
Thread-Topic: [PATCH 2/2] pci/iov: fix kobject_uevent() ordering in
	sriov_enable()
Thread-Index: AQHaM5gIymu+QAnEL0auqBpjRq8bEQ==
Date: Wed, 20 Dec 2023 22:58:22 +0000
Message-ID: <170311310235.2826.17048185824437453415.stgit@bgt-140510-bm01.eng.stellus.in>
In-Reply-To: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <56EA0B30ADDB974295D9DFBCB54F5162@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djXc7r9hc2pBq3bTCy+/e9hs1jSlGFx
	5d8eRotNG56wWFzeNYfN4uy842wObB4LNpV69Da/Y/N4v+8qm8fnTXIBLFFcNimpOZllqUX6
	dglcGTfu6RdsYq/ou3mOpYFxBnsXIyeHhICJxN7/T1i6GLk4hARWMko0PO1ihXBamST6/21m
	hKk6cv81I0RiDaPEtMfPoZxPjBJfv71gg3CWMUp8f/WMBaSFTUBT4teVNUwgtojAHCaJGRc8
	QWxhAX+JP/1tUPEQiQtr5rNA2HoSv8+cYAWxWQRUJfbdvs8MYvMKRErs3zcLrJ5TIEriz5HP
	bCA2o4CYxPdTEPOZBcQlbj2ZzwRxqqDEotl7mCFsMYl/ux6yQdiKEve/vwR6mgOoXlNi/S59
	CNNO4sKTTIgpihJTuh+yQ2wVlDg58wkLRKekxMEVN8BBJCGwg0Ni3+LFjCC9EgIuEg0vOCFq
	pCWuXp8KtTVbYuX6DiaIkgKJhiNBEGFriYV/1kMdzCfx99cjxgmMyrOQ3D8L4bZZCLfNQnLb
	LCS3LWBkXcUoXlpcnJueWmyYl1quV5yYW1yal66XnJ+7iRGYfE7/O5y7g3HHrY96hxiZOBgP
	MUpwMCuJ8O7tbEoV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmtoezJZSCA9sSQ1OzW1ILUIJsvE
	wSnVwLQjeu32llV3T7UVSxw7/6THe2uHzUnBHyXnDV5xn5rRXalrOdG+id/XunmSYF/oqh0u
	P34wnH8g1zNZPVa3fVZp8fLqm9Y2tR63XgeYtkqXXuOujbKLfpHuxDD5065Ql3zWyg8JjBfW
	sMtNmTSrMXSBepD0xmipR886t6tqhc7NO7mtS6qxufKzUf++pA0vfwgqBUz+z2y4daFv5v7X
	Lg+Z3poWXdhyc5N+cczq2S8XpxzpkD/GeGLW2oXnuEoFUv6ci1i6f2fZAYmbs0r77axmfhH0
	vZVhtJ6td5v9N+YbM4JXn5KYcM9bbx1P491Hyk5ynxfteql33Txn2zTzMu10LauIydN3dLsn
	6fw9VqvEUpyRaKjFXFScCABC/x/vrQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWS2cDspNtf2JxqsKJf1eLb/x42iyVNGRZX
	/u1htNi04QmLxeVdc9gszs47zubA5rFgU6lHb/M7No/3+66yeXzeJBfAEsVlk5Kak1mWWqRv
	l8CVceOefsEm9oq+m+dYGhhnsHcxcnJICJhIHLn/mrGLkYtDSGAVo0TbjR52COcTo8SP51NZ
	IZxljBKHut6zgbSwCWhK/LqyhgnEFhGYwyQx44IniC0s4Ctx8+9vNoh4iMSHBa8YIWw9id9n
	TrCC2CwCqhL7bt9nBrF5BSIl9u+bBTZHCMhuv/sZrIZTIEriz5HPYHMYBcQkvp+C2MUsIC5x
	68l8JoizBSSW7DnPDGGLSrx8/I8VwlaUuP/9JdAHHED1mhLrd+lDmHYSF55kQkxRlJjS/ZAd
	4gJBiZMzn7BAdEpKHFxxg2UCo/gsJMtmIQyahTBoFpJBs5AMWsDIuopRvLS4ODe9otgwL7Vc
	rzgxt7g0L10vOT93EyMwRk//Oxy5g/HorY96hxiZOBgPMUpwMCuJ8O7tbEoV4k1JrKxKLcqP
	LyrNSS0+xCjNwaIkznv3gUaqkEB6YklqdmpqQWoRTJaJg1OqgWm6Os/Vmw4z2mMv8mj3iL/7
	E3fQ+/CK+J9bGd+/vzbZOOBpy5/ryt+NOuwErt4LKp/nPO+e5wpe7wffLPLudPjrstr/Wt3s
	ZKnGP2nWoRd6ll4HpsZtOzZHMTDuQ/PeCRtl6syZLH61Wl5/0f2zvOT2veNRM1IjwqVe73me
	tajgb7zfx61331dtqF0wXyz1KZOf9P3bK+bu2GfhWrv8WOYD7w+e+98l6slKCd3bbmxl8+yn
	alpD392DugULnRWkftZ1L2iYV9G8bH6Cy5NburemudW7T+2ylp988mnc5IrXq+v2BFys7FNN
	0tW7zSXTarLqbJp76t6iA3N116u/nfq19NEBUbPvIkW/3v5OyvytxFKckWioxVxUnAgArbBk
	WUADAAA=
X-CMS-MailID: 20231220225823uscas1p12d012a034806edd76fbc66a8d04e15ee
CMS-TYPE: 301P
X-CMS-RootMailID: 20231220225823uscas1p12d012a034806edd76fbc66a8d04e15ee
References: <170311143880.2826.17853753430536108145.stgit@bgt-140510-bm01.eng.stellus.in>
	<CGME20231220225823uscas1p12d012a034806edd76fbc66a8d04e15ee@uscas1p1.samsung.com>

V2FpdCB0byBjYWxsIGtvYmplY3RfdWV2ZW50KCkgdW50aWwgYWxsIG9mIHRoZSBhc3NvY2lhdGVk
IGNoYW5nZXMgYXJlIGRvbmUsCmluY2x1ZGluZyB1cGRhdGluZyB0aGUgbnVtX1ZGcyB2YWx1ZS4K
ClN1Z2dlc3RlZCBieTogTGVvbiBSb21hbm92c2t5IDxsZW9ucm9AbnZpZGlhLmNvbT4KU2lnbmVk
LW9mZi1ieTogSmltIEhhcnJpcyA8amltLmhhcnJpc0BzYW1zdW5nLmNvbT4KLS0tCiBkcml2ZXJz
L3BjaS9pb3YuYyB8ICAgIDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2lvdi5jIGIvZHJpdmVycy9wY2kv
aW92LmMKaW5kZXggZDQ2NDZiZGNkODg3Li43YTBmMzNlZjE4MjYgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcGNpL2lvdi5jCisrKyBiL2RyaXZlcnMvcGNpL2lvdi5jCkBAIC02NzcsOCArNjc3LDggQEAg
c3RhdGljIGludCBzcmlvdl9lbmFibGUoc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IG5yX3ZpcnRm
bikKIAlpZiAocmMpCiAJCWdvdG8gZXJyX3BjaWJpb3M7CiAKLQlrb2JqZWN0X3VldmVudCgmZGV2
LT5kZXYua29iaiwgS09CSl9DSEFOR0UpOwogCWlvdi0+bnVtX1ZGcyA9IG5yX3ZpcnRmbjsKKwlr
b2JqZWN0X3VldmVudCgmZGV2LT5kZXYua29iaiwgS09CSl9DSEFOR0UpOwogCiAJcmV0dXJuIDA7
CiAKCg==

