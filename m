Return-Path: <linux-pci+bounces-7266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 665ED8C0480
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 20:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6544B242BB
	for <lists+linux-pci@lfdr.de>; Wed,  8 May 2024 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE87920309;
	Wed,  8 May 2024 18:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LU5JNmHz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D679523D;
	Wed,  8 May 2024 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193521; cv=none; b=HVCjDWP2D/g4jl/LfHSHQMXxWJZeONyPbCBE4hxT8rYWkmvwonryFpiYyPKO97A2Mv/jSKvY+1abqvY3Wcil+Fxgcn93lj5zDwk61S0tBeik6IyvN2T7EXlUorttPQngRtJvJFsrd4h2cfwTMRXWZeOlfe4i3jg/t8XGZlejv2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193521; c=relaxed/simple;
	bh=wpbvWC4ha7CssvQsauRhb0dZ044s8nbMP1EbMzYpl6w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version:References; b=ghMu0Kumvq6TlGrlSKxTNv+B9cy8yx3tNEjq+Np9GJtBU4DFEKkMY/lSjbYYQbwA/jrznBPr2S/jwUJLh7G6F6ZbH3JyjSRZBrmDCvnMeCvtzWPKtTyOKiOW7bGjf1JT0q9J21DTJ0+OhaTgsQHUzD4JKgi0cKg/91pRgHtFUr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LU5JNmHz; arc=none smtp.client-ip=211.189.100.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
	by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20240508183838usoutp02f91dd065362ba392dba94690b12e9e4b~Nl2r5qiCI1304913049usoutp02F;
	Wed,  8 May 2024 18:38:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20240508183838usoutp02f91dd065362ba392dba94690b12e9e4b~Nl2r5qiCI1304913049usoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1715193518;
	bh=0YOZE9kCrjbEseQtFDfjvnydC78ktL8z4ZCMKzK4UkA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=LU5JNmHzSZ10ziPm4xLZkJUJTGflyk2OgTTwny21DHTyTz4Nc+CNgPHym/WeZR1Pk
	 FtDtp0FdvsYXn/Nlxa15amjqeJPcM+5TSPOLahDj1ujKfBtfOwmOZuxvt1WMrf4IMZ
	 6NSp2L1ZPoJrSo5Jrl4bSofVcsxcbRsUpEuBZs4Y=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508183838uscas1p1c3b500bdfec3606ece8713e4cce8e7e9~Nl2rMdIyO1930119301uscas1p15;
	Wed,  8 May 2024 18:38:38 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id DE.BF.09749.DA6CB366; Wed, 
	8 May 2024 14:38:38 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
	[203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240508183837uscas1p146b110624839282fa0342776c062bdd2~Nl2q3S48m1929719297uscas1p10;
	Wed,  8 May 2024 18:38:37 +0000 (GMT)
X-AuditID: cbfec36f-bebff70000002615-db-663bc6ad7d00
Received: from SSI-EX2.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id A7.84.09521.DA6CB366; Wed, 
	8 May 2024 14:38:37 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
	SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Wed, 8 May 2024 11:38:36 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
	SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2507.035; Wed,
	8 May 2024 11:38:36 -0700
From: Adam Manzanares <a.manzanares@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>
CC: Dan Williams <dan.j.williams@intel.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "gourry.memverge@gmail.com"
	<gourry.memverge@gmail.com>, "wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	"rientjes@google.com" <rientjes@google.com>, "ruansy.fnst@fujitsu.com"
	<ruansy.fnst@fujitsu.com>, "shradha.t@samsung.com" <shradha.t@samsung.com>,
	Jim Harris <jim.harris@samsung.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Topic: [LSF/MM/BPF TOPIC] CXL Development Discussions
Thread-Index: AQHan+tkd4BPRAK+n02hrtqAe44hSbGLVQ6AgAE/bgCAAY7eAA==
Date: Wed, 8 May 2024 18:38:36 +0000
Message-ID: <48a26545-5d41-47f4-95a6-e55395b63c66@nmtadam.samsung>
In-Reply-To: <Zjp4DtkCFGOiFA6X@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7A98C47085D98469B71017B43E87A12@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7djX87rrjlmnGUzTsLj7+AKbxfSpFxgt
	TtxsZLNYfXMNo8WLP8+ZLPY/fc5isWrhNTaL87NOsVjcW/Of1eLsvONsFvte72W2uDHhKaPF
	/T4Hi7YlG5ksFtxrZ7G4NeEYk8X6PQtYHQQ9NjS9YfPYOesuu8eCTaUeLUfesnos3vOSyWPT
	qk42j02fJrF7TL6xnNFj6ux6j/VbrrJ4fN4kF8AdxWWTkpqTWZZapG+XwJXxZ8FtpoJNbBXP
	+jeyNDD+Z+li5OSQEDCROHHoP1sXIxeHkMBKRompez6ygiSEBFqZJHZ+c4Ypmn62B6poDaPE
	hr6JjBDOR0aJj7+2skI4Sxklmt++ZgdpYRMwkPh9fCMziC0ioCGxb0IvE0gRs8B+dolfv+aC
	JYQFrCVeft0DZHMAFdlIfH4uAFHvJNG6cjYTiM0ioCLxbMV8sFt5geKrp19gA7E5Bcwkrj3a
	DlbDKCAm8f3UGjCbWUBc4taT+UwQZwtKLJq9hxnCFpP4t+shG4StKHH/+0t2iHodiQW7P7FB
	2HYSDyZthLK1JZYtfM0MsVdQ4uTMJ9DwkpQ4uOIGC8gvEgKnOCWW/lwCtcBF4vTNz1CLpSWu
	Xp8KFc+X2NV2BcqukLj6uhvqCGuJhX/WM01gVJmF5O5ZSG6aheSmWUhumoXkpgWMrKsYxUuL
	i3PTU4uN8lLL9YoTc4tL89L1kvNzNzECE+fpf4fzdzBev/VR7xAjEwfjIUYJDmYlEd6qGus0
	Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGtieThQTSE0tSs1NTC1KLYLJMHJxSDUzaTvKhWXuy
	rxWtOvPkkm+Gxqb7PDIC7lETV9iH79666tT8/TdWPvTxCjmipDOh/n7OOr8blSkZi9Y1K/3i
	+DZ1Do+b6L/9KuzN1qu0pPPOXCgKXclceOzvZqXv+TGsb+siJBwbFDn2FnfJGItPkfTW+3V6
	Z9xjcROtfx86NA5aBa43vBHyOX/ZzhzTvwUJh0+6CT1c/6f03sN26xW+z1PmeJyafDk2fe6m
	jkgH1bj9P6dMnN5ta9iv/vcH87fpIe0TgnqauLxtBdl1vKbMuNMc2ladtPlhWecNp/+Zdmdv
	vPWxLLdZ2FctlXfprkxe7o0PjXcPX13muUnek0HylZGM8WYnoabYqfu4Fra0P1FiKc5INNRi
	LipOBADoQwD7CwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRmVeSWpSXmKPExsWS2cDspLv2mHWawc/lyhZ3H19gs5g+9QKj
	xYmbjWwWq2+uYbR48ec5k8X+p89ZLFYtvMZmcX7WKRaLe2v+s1qcnXeczWLf673MFjcmPGW0
	uN/nYNG2ZCOTxYJ77SwWtyYcY7JYv2cBq4Ogx4amN2weO2fdZfdYsKnUo+XIW1aPxXteMnls
	WtXJ5rHp0yR2j8k3ljN6TJ1d77F+y1UWj8+b5AK4o7hsUlJzMstSi/TtErgy/iy4zVSwia3i
	Wf9GlgbG/yxdjJwcEgImEtPP9rB1MXJxCAmsYpRY0rMNLCEk8JFRYspvTwh7KaPE83muIDab
	gIHE7+MbmUFsEQENiX0TeplAmpkF9rNL/Po1FywhLGAt8fLrHiCbA6jIRuLzcwGIeieJ1pWz
	mUBsFgEViWcr5oPt4gWKr55+AeqITiaJvxtesIIkOAXMJK492g7WwCggJvH91Bowm1lAXOLW
	k/lMEB8ISCzZc54ZwhaVePn4HyuErShx//tLdoh6HYkFuz+xQdh2Eg8mbYSytSWWLXzNDHGE
	oMTJmU+goSIpcXDFDZYJjBKzkKybhWTULCSjZiEZNQvJqAWMrKsYxUuLi3PTK4oN81LL9YoT
	c4tL89L1kvNzNzECk87pf4cjdzAevfVR7xAjEwfjIUYJDmYlEd6qGus0Id6UxMqq1KL8+KLS
	nNTiQ4zSHCxK4rx3H2ikCgmkJ5akZqemFqQWwWSZODilGpg2Fs2IV+RYueXGcvvZ8x791jIu
	+/7goILwrnxj35WrCqZf5WBnactaOLF6i6128MqO+ZWTBbyZDbbOWlfxfLlYTvm0lV9WGXgk
	TrV/sMCcJaPP/hlvyevrs6M1mASM1/T+c8qsunLt//n32y+GbDj4j6vr4Ko8/7bJRZYxqSvF
	jv92DgstMHymKVG4tFY8Xnzpe2NNgZJvCq9uzmZaYsR6omtbjkTC3Ej+T1w33t2T1gw8tr2T
	Y8Kc/qhVvQ8Xzb9s6npoxppGI5kz3PfW+khp/w/0T6144Nk/fWXTU7HlKZ6pHGxiCSzu3W9k
	izqCFy8T/+I5Q4ld4Zpr5rLPAXf2X86q0r0nfUXuRFXjbkklluKMREMt5qLiRADouuGtqQMA
	AA==
X-CMS-MailID: 20240508183837uscas1p146b110624839282fa0342776c062bdd2
CMS-TYPE: 301P
X-CMS-RootMailID: 20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f
References: <CGME20240506192712uscas1p225316f79bb69f979b647d2a06a00a25f@uscas1p2.samsung.com>
	<9bf86b97-319f-4f58-b658-1fe3ed0b1993@nmtadam.samsung>
	<66396c1938726_2f63a29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<Zjp4DtkCFGOiFA6X@bombadil.infradead.org>

On Tue, May 07, 2024 at 11:50:54AM -0700, Luis Chamberlain wrote:
> On Mon, May 06, 2024 at 04:47:37PM -0700, Dan Williams wrote:
> > For testing I think it is an "all of the above plus hardware testing if
> > possible" situation. My hope is to get to a point where CXL patchwork
> > lights up "S/W/F" columns with backend tests similar to NETDEV
> > patchwork:
> >=20
> > https://patchwork.kernel.org/project/netdevbpf/list/
> >=20
> > There are some initial discussions about how to do this likely we can
> > grab some folks to discuss more.
> >=20
> > I think Paul and Song would be useful to have for this discussion.
>=20
> I think everyone and their aunt wants this to happen for their subsystem,
> so a separate session to hear about how to get there would be nice.

+1

>=20
>   Luis
> =

