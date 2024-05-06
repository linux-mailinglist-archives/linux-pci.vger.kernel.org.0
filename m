Return-Path: <linux-pci+bounces-7133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CDA8BD578
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 21:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC2B21130
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5015AAA8;
	Mon,  6 May 2024 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MnElFODV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3833015A48D;
	Mon,  6 May 2024 19:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024034; cv=none; b=o69sRhTgvHrlE1M3SHEtEjrKHrpKSBVfWrRqQohaApuOw13ifCz/7nkeBEdBAjxUWZAo4ja+lEOe1HvyL3KIdRLDrXhwXJHCses2z5SAYVKwUagv+BqKPU1dr6gWQ5tXxrgwPRsu6hnI951d6JLh2SNuwPzz/UhBfyRvEsNeK1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024034; c=relaxed/simple;
	bh=uGNZYALauFd+eorjQt0yfZ+3Ro57ABFt2jTbWDQHeso=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=MgduE8RlVbSbbaxCm306DgVV9Lu9xonKOZ5u2iGiz3ifh8kjLHIFzAVYyDMSNrHOxte9nlyN1688cH1ksPWMFx86btAKZkE+b7YmCsNhKvciOqM3xfQtRuyTLfzNMMgo6rCEEuOpThn3HkbU98h3ljEINMqKBNGzGkthBoJiTgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=MnElFODV; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240506192712usoutp02a7fd872013caa01356bbc91300710432~M-OhNNr1O0084000840usoutp02N;
	Mon,  6 May 2024 19:27:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240506192712usoutp02a7fd872013caa01356bbc91300710432~M-OhNNr1O0084000840usoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715023632;
	bh=qgUXmuEvpZEMMkoIcaOwLLWWNc96RMPxkgBeekrSEbY=;
	h=From:To:CC:Subject:Date:References:From;
	b=MnElFODV0bTtv7jIIqS+c2gQRQp8HR2zJNh+OBLMrcdNhS5PE8wj6Z6PYa8z666k7
	 AMIKcXHl62bMBHIf1yCh+gS12fFSEfwNMYbEQQFgnoDqFH6GGu6LFXmF/xRrSrap+v
	 oxigb8KMEnyo5MDidKjK266dGiqYj6C21HoVhYxg=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240506192712uscas1p298e23e311f906ba6de129f1eb0e1cef3~M-OhB2c2O1663016630uscas1p2F;
	Mon,  6 May 2024 19:27:12 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 0B.BB.09749.01F29366; Mon, 
	6 May 2024 15:27:12 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
	[203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f~M-Ogk8mG81446114461uscas1p29;
	Mon,  6 May 2024 19:27:12 +0000 (GMT)
X-AuditID: cbfec36f-bebff70000002615-23-66392f1057b2
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id EE.EF.09795.F0F29366; Mon, 
	6 May 2024 15:27:11 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Mon, 6 May 2024 12:27:11 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Mon,
	6 May 2024 12:27:10 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
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
	<jim.harris@samsung.com>, "mhocko@suse.com" <mhocko@suse.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Topic: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Index: AQHan+tkd4BPRAK+n02hrtqAe44hSQ==
Date: Mon, 6 May 2024 19:27:10 +0000
Message-ID: <9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5A48A5029EF4A842AAA1F52896BCC6F3@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsWy7djX87oC+pZpBsumyFrcfXyBzWL61AuM
	FiduNrJZrL65htHixZ/nTBb7nz5nsVi18BqbxflZp1gs7q35z2pxdt5xNot9r/cyW9yY8JTR
	4n6fg0Xbko1MFgvutbNY3JpwjMli/Z4FrA6CHhua3rB57Jx1l91jwaZSj5Yjb1k9Fu95yeSx
	aVUnm8emT5PYPSbfWM7oMXV2vcf6LVdZPD5vkgvgjuKySUnNySxLLdK3S+DKmDKZpeCKQEXP
	7gtsDYyXebsYOTkkBEwkFt57wQJiCwmsZJRo2FTcxcgFZLcySeyc95URrujvHHaIxBpGiZOH
	NjNCOB8ZJc7OucAE0b6UUeLrbT4Qm03AQOL38Y3MIEUiAlfZJCb8X8IK4jALLGaU6N/ymhWk
	SljAXGLepKtAVRxAVTYSn58LgIRFBPQkZu75BjaURUBFounebkaQEl4BJ4mlJyVAwowCYhLf
	T60BK2EWEJe49WQ+E8SlghKLZu9hhrDFJP7tesgGYStK3P/+kh2iXkdiwe5PbBC2ncSR9U+h
	4toSyxa+BuvlBZpzcuYTFoheSYmDK26wgJwvIbCZU+Lbg4msEAkXiV9PmqCKpCX+3l0GdUS+
	xK62K1BHVEhcfd0NdYS1xMI/66GO5pP4++sR4wRG5VlIfpiF5L5ZSO6bheS+WUjuW8DIuopR
	vLS4ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwbZ7+dzh/B+P1Wx/1DjEycTAeYpTgYFYS4T3a
	bp4mxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfQ9mSykEB6YklqdmpqQWoRTJaJg1Oqgck5tS58
	VoVdxsrdBzyfrHL51mW/c+eX9WeEn84wvKYnMP33oruunbP0S5+3/FrYxiWqV+O+bE4u6wml
	zLZXR15s8O+z3dq+YXnC0Yvp79hW+5yxXLPFoc6gyFNcODag90HKpNZTLQ/YlsW5N61fusb6
	y6pL67Svu9/xZwlVvbJm0f9Vr/aEn3rp/VPsStwH33W3HnH85t0/eebhW53mbdJHo/sbj+X6
	SDoqKBy41B0241bK49XOZ/k5jvbd/ps2f8rexeIcE4Jennj++/qiT/x++b9nTwnJCNJkOuJy
	lmPLpIfioSu1fjTvuztDa0tR0mE594kuMZ+zFQUrOqSvrzURqt80rU/1gGnsrefPbpl+UmIp
	zkg01GIuKk4EAKk+FXgKBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWS2cDsrMuvb5lmsPyBjcXdxxfYLKZPvcBo
	ceJmI5vF6ptrGC1e/HnOZLH/6XMWi1ULr7FZnJ91isXi3pr/rBZn5x1ns9j3ei+zxY0JTxkt
	7vc5WLQt2chkseBeO4vFrQnHmCzW71nA6iDosaHpDZvHzll32T0WbCr1aDnyltVj8Z6XTB6b
	VnWyeWz6NIndY/KN5YweU2fXe6zfcpXF4/MmuQDuKC6blNSczLLUIn27BK6MKZNZCq4IVPTs
	vsDWwHiZt4uRk0NCwERi4d857F2MXBxCAqsYJQ7fu80E4XxklJjUuIgZwlnKKPHvZDMjSAub
	gIHE7+MbwRIiAlfZJHZeO88G4jALLGaU6N/ymhWkSljAXGLepKtAVRxAVTYSn58LgIRFBPQk
	Zu75xgRiswioSDTd280IUsIr4CSx9KQESJhRQEzi+6k1YCXMAuISt57MZ4I4VUBiyZ7zzBC2
	qMTLx/9YIWxFifvfX7JD1OtILNj9iQ3CtpM4sv4pVFxbYtnC12C9vAKCEidnPmGB6JWUOLji
	BssERrFZSNbNQjJqFpJRs5CMmoVk1AJG1lWM4qXFxbnpFcVGeanlesWJucWleel6yfm5mxiB
	SeT0v8PROxhv3/qod4iRiYPxEKMEB7OSCO/RdvM0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rx3
	H2ikCgmkJ5akZqemFqQWwWSZODilGpgytHgOxkbl/NCNOG25ZeL6h9943z11CqiK/B+ke6Vi
	o+OLNfWed/TsZv5dVml4TtC3br0J0z6RPbvfyefv2c2a3ntqiaLTj25/+UMr/BZLN5+VfjXt
	9u3+cieDO+5tt6c8rN7r5ZH93TQy6dOcmBrZQ/0cH3TyL98vjxSS/8/eqSUpZ9W2La+H7Y7l
	kYe1r46IHxTTu357l+WLzJ7HK+2SbHTYPd8xG7e//3mtcNcrt4gPuilCsfuOW3o2Vs/el+l4
	wjNY4tNaI6nJto2Wy6Us0xx4W2fzL17AFfBzcuXJKGPxWwo/2RWvX+TT8Qsx5X82U2fHweWz
	Z4WfLXSe0x3lZCvHkLHyn/Shaylpz5RYijMSDbWYi4oTAUH6bfORAwAA
X-CMS-MailID: 20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f
CMS-TYPE: 301P
X-CMS-RootMailID: 20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>

Hello all,

I would like to have a discussion with the CXL development community about
current outstanding issues and also invite developers interested in RAS and
memory tiering to participate.

The first topic I believe we should discuss is how we can ensure as a group
that we are prioritizing upstream work. On a recent upstream CXL developmen=
t
discussion call there was a call to review more work. I apologize for not
grabbing the link, but I believe Dave Jiang is leveraging patchwork and thi=
s
link should be shared with others so we can help get more reviews where nee=
ded.

The second topic I would like to discuss is how we integrate RAS features t=
hat
have similar equivalents in the kernel. A CXL device can provide info about=
=20
memory media errors in a similar fashion to memory controllers that have ED=
AC
support. Discussions have been put on the list and I would like to hear tho=
ughts
from the community about where this should go [1]. On the same topic CXL ha=
s=20
port level RAS features and the PCIe DW series touched on this issue  [2]

The third topic I would like to discuss is how we can get a set of common
benchmarks for memory tiering evaluations. Our team has done some initial
work in this space, but we want to hear more from end users about their=20
workloads of concern. There was a proposal related to this topic, but from =
what=20
I understand no meeting has been held [3].=20

The last topic that I believe is worth discussion is how do we come up with
a baseline for testing. I am aware of 3 efforts that could be used cxl_test=
,=20
qemu, and uunit testing framework [4].

Apologies for getting this out late, and please include anyone that may be
interested in joining a discussion.

[1] https://lore.kernel.org/linux-cxl/20240417075053.3273543-1-ruansy.fnst@=
fujitsu.com/
[2] https://lore.kernel.org/lkml/20231130115044.53512-1-shradha.t@samsung.c=
om/
[3] https://lore.kernel.org/all/2b29dd3d-bb2c-6a8c-94d2-d5c2e035516a@google=
.com
[4] https://lore.kernel.org/linux-cxl/170795677066.3697776.1258781271309390=
8173.stgit@ubuntu/

