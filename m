Return-Path: <linux-pci+bounces-3312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7678500DD
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 00:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D79A28C0CC
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4838396;
	Fri,  9 Feb 2024 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MbNkyH8c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AC737712;
	Fri,  9 Feb 2024 23:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522733; cv=none; b=AUqdCUJTMVsOL/nVjMVNHx2vbGK7GiVr6gJAwfk7q1TYMYbJppypSdCjUVzrB3HGadpU+x6JXCuSawklvX2YkxpACNB2JuRy4AVw1/JwoeJHGr+7UYHKF96yEy65r2yEmZp5/PAiIE/MdWtOVtVQZejmKd4V0JhuVkpjArhLYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522733; c=relaxed/simple;
	bh=gM8WcyxM0kyctkmXBtKgbCJjoJZPH+hDa6zePYZQYvA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=hCCRbCQ7rH8M4Fav7BKu2y1c5DVXsvCT1xNgv/g12lVaZLEkwqsR7AdJZRhak2LJnZiETCo/wqbjDL4lT44buDkPc41somn9FtrPlXJUVeEM8Ub+e+krjdkQUUGEXHuel9sAGSNWNEvuzbD1/ciHIs4o9+T/nq+LK0jKEWq+zJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MbNkyH8c; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240209235208usoutp02fd2aa98ee21f69de46c2430c3bd08edd~yVuAEcc3i0585005850usoutp02c;
	Fri,  9 Feb 2024 23:52:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240209235208usoutp02fd2aa98ee21f69de46c2430c3bd08edd~yVuAEcc3i0585005850usoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707522728;
	bh=gM8WcyxM0kyctkmXBtKgbCJjoJZPH+hDa6zePYZQYvA=;
	h=From:To:Subject:Date:References:From;
	b=MbNkyH8cDAQuRnxgBMegujqbg5c/1zut1qWTXEcwHiO7+yX2drNTAEE0lw5QJUiMt
	 YTo1btTTaiqOkwZ3Ew8dNYU/eUYgmpsiGwTQFpzCOAPJpwNx/ee08ljAFj8dxNg91W
	 P1EphlJg2omjgpPYuvZOkjQdgBMaNu2jfHB6hEiw=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209235208uscas1p1e00495a73f5b23c3074158c26e625217~yVt-5uaqz1606916069uscas1p1V;
	Fri,  9 Feb 2024 23:52:08 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 90.E2.09760.8AAB6C56; Fri, 
	9 Feb 2024 18:52:08 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240209235208uscas1p26c658c64cc85711cd3aa6312224164fc~yVt-hE2-o0911209112uscas1p2S;
	Fri,  9 Feb 2024 23:52:08 +0000 (GMT)
X-AuditID: cbfec36f-7f9ff70000002620-34-65c6baa89ee7
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id B6.EB.50948.7AAB6C56; Fri, 
	9 Feb 2024 18:52:08 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 9 Feb 2024 15:52:07 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	9 Feb 2024 15:52:07 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: [PATCH v2 0/2] PCI/IOV: sriov_numvfs bug fixes
Thread-Topic: [PATCH v2 0/2] PCI/IOV: sriov_numvfs bug fixes
Thread-Index: AQHaW7L9HxX7C6a7gEK+/jIBMuGoFw==
Date: Fri, 9 Feb 2024 23:52:07 +0000
Message-ID: <170752254154.1693615.9176696143128338408.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <67380BDDF3A3E047873C9EF42CA726CF@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djXc7ordh1LNTh8Ucni2/8eNoslTRkW
	V/7tYbTYtOEJi8XlXXPYLM7OO85msf7rezYHdo8Fm0o9epvfsXm0PDvJ5vF+31U2j8+b5AJY
	o7hsUlJzMstSi/TtErgyZrR+YCmYwVExe8IExgbGP+xdjJwcEgImEtPW/GTsYuTiEBJYySgx
	c2IzG4TTyiSxce1xZpiq/vdnoRJrGCXWPNjJDuF8ZJQ4O+8dVGYpo8TKh+fABrMJaEr8urKG
	CSQhInCVSWLy6g9Aszg4hAXMJbpv14LUiAjYSBw78JIVwtaTuHb6PNg6FgEViaYFnxhBbF6B
	aIn1l6+wgNiMAmIS30+BzOTkYBYQl7j1ZD4TxHmCEotm74E6VUzi366HbBC2osT97y/ZQdYy
	A92zfpc+RKudxOn9LewQtqLElO6H7BCrBCVOznzCAtEqKXFwxQ0WkPMlBPZwSHz40M0IkXCR
	eHroCtReaYnpay5DNWRLrFzfwQSyS0KgQKLhSBBE2Fpi4Z/1UCfzSfz99YgRooRXoqNNaAKj
	0iwkz8xCOHQWkkNnITl0FpJDFzCyrmIULy0uzk1PLTbKSy3XK07MLS7NS9dLzs/dxAhMS6f/
	Hc7fwXj91ke9Q4xMHIyHGCU4mJVEeEOWHEkV4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmtoezJZ
	SCA9sSQ1OzW1ILUIJsvEwSnVwLRW7kaTZfpbA2ZzaR6FIKOXF7cbHfl5fMONq29U9F5IWIkz
	s1m+0D8nffn6TublRSm75O+uKDJVYckt9u6YeFNT5HLJw11GlSs3pF5rurqgsPr3ocd8utIn
	Vu1ui1OvOj/py4RmpxPme32POu4vFvs6ueaE2KXY4xPTvB1OfPL/IzYr7WeyYeeVI+wBn38U
	6e9vvlAU3rBs6Yq7Fys8l/8u6PwmLqWgXHHatjnZ5ESjSuylBerrdsae0RDZcDrnTKZ39uIX
	5a/65R+V6UyxXBV3XXTfnC0+64uPGMkGrOJeIz2Dw37WNo0QJofHD9pLDMMYDtaF3Q9cnquk
	+jf5Z+CnY90bPj968n365TdTstmUWIozEg21mIuKEwEW4fdKugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsWS2cDspLti17FUgwVbWS2+/e9hs1jSlGFx
	5d8eRotNG56wWFzeNYfN4uy842wW67++Z3Ng91iwqdSjt/kdm0fLs5NsHu/3XWXz+LxJLoA1
	issmJTUnsyy1SN8ugStjRusHloIZHBWzJ0xgbGD8w97FyMkhIWAi0f/+LFsXIxeHkMAqRom/
	u86wQzgfGSX+z+1gBqkSEljKKHHyFxuIzSagKfHryhomkCIRgatMEpNXfwAq4uAQFjCX6L5d
	C1IjImAjcezAS1YIW0/i2unzYHNYBFQkmhZ8YgSxeQWiJdZfvsICYjMKiEl8PwUyk5ODWUBc
	4taT+UwQ1wlILNkD0SshICrx8vE/VghbUeL+95fsIGuZge5Zv0sfotVO4vT+FnYIW1FiSvdD
	dohVghInZz5hgWiVlDi44gbLBEbRWUi2zUKYNAvJpFlIJs1CMmkBI+sqRvHS4uLc9Ipi47zU
	cr3ixNzi0rx0veT83E2MwFg8/e9wzA7Ge7c+6h1iZOJgPMQowcGsJMIbsuRIqhBvSmJlVWpR
	fnxRaU5q8SFGaQ4WJXHeuw80UoUE0hNLUrNTUwtSi2CyTBycUg1MWvZ3ll7bNVH1e0DK38m/
	jmitK7rFyrRsYtJJjyWrg1VcPmxqy4ra3L3j8y6ud95zxbTuVHe3+PK8+K62b7lSgMHlQ9OK
	dfMfZSydPvViZP3pzfHTV/QaZpg/nlok+msXX5BI49nE5dkLLlWtdHcQv5F+2+q8X2jH9pfW
	91u9zB9dfB+0cOe3U8ZK52Kjz+s/mLT76z7DF1Vz5ENKe2ak3dxXYrvz4MGyPyfbn2b5X1rK
	fG0S/973adofBJq/r36YLnz48abrFVc1dojPclc89vTjLYfS1VsOiT24dPx19Kzc15XPDcwn
	8fByipXdfVd/uLTZeaegr07wO8E3Cdfdtu5SU/gle/e6pEaXDrti73QlluKMREMt5qLiRACb
	JXnzNAMAAA==
X-CMS-MailID: 20240209235208uscas1p26c658c64cc85711cd3aa6312224164fc
CMS-TYPE: 301P
X-CMS-RootMailID: 20240209235208uscas1p26c658c64cc85711cd3aa6312224164fc
References: <CGME20240209235208uscas1p26c658c64cc85711cd3aa6312224164fc@uscas1p2.samsung.com>

QSBkZWFkbG9jayBjb25kaXRpb24gd2FzIGRpc2NvdmVyZWQgYnkgU1BESyB3aGVuIHJlbW92aW5n
IGFuIFNSSU9WLWVuYWJsZWQgYW5kClZGSU8tYXR0YWNoZWQgZGV2aWNlLCB3aXRoIGEgc3BlY2lm
aWMgdGhyZWFkaW5nIG1vZGVsLiBXaGlsZSBkaXNjdXNzaW5nIHRoaXMKb24gdGhlIG1haWxpbmcg
bGlzdCwgYSBzZXBhcmF0ZSBpc3N1ZSBhcm91bmQgdXBkYXRpbmcgc3Jpb3ZfbnVtdmZzIGFuZCBp
dHMKa29iamVjdF91ZXZlbnQoKSB3YXMgYWxzbyBkaXNjb3ZlcmVkLiBUaGlzIHNlcmllcyBmaXhl
cyBib3RoIG9mIHRob3NlIGlzc3Vlcy4KCi0tLQp2MSA9PiB2MjoKKiBObyBjb2RlIGNoYW5nZXMK
KiBVcGRhdGVkIGNvbW1pdCBtZXNzYWdlcyBwZXIgZmVlZGJhY2sgZnJvbSBCam9ybgoqIEFkZGVk
IExlb24ncyBSZXZpZXdlZC1ieSB0YWdzCiogTW92ZWQgYnVsayBvZiB0aGUgdjEgY292ZXIgbGV0
dGVyIHRvIHRoZSByZXZlcnQgcGF0Y2ggY29tbWl0IG1lc3NhZ2Ugd2hlcmUKICBpdCBiZWxvbmdl
ZAoKSmltIEhhcnJpcyAoMik6CiAgICAgIFBDSS9JT1Y6IFJldmVydCAiUENJL0lPVjogU2VyaWFs
aXplIHN5c2ZzIHNyaW92X251bXZmcyByZWFkcyB2cyB3cml0ZXMiCiAgICAgIFBDSS9JT1Y6IGZp
eCBrb2JqZWN0X3VldmVudCgpIG9yZGVyaW5nIGluIHNyaW92X2VuYWJsZSgpCgoKIGRyaXZlcnMv
cGNpL2lvdi5jIHwgICAxMCArKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCA4IGRlbGV0aW9ucygtKQoKLS0K

