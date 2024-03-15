Return-Path: <linux-pci+bounces-4852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2987CC62
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 12:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947321C211A2
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 11:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2575E1B5B2;
	Fri, 15 Mar 2024 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rvN6rl9c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949F1B5B1
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502546; cv=none; b=pKjVkSp6QISW7PmNqxUklwfmZjEWFjVPxEG5NPapvtsNhmtSj9kUW5U9MWc50+bJu5e3VLIJtTrBQ98MTwThXrRRfY6z22BxA+3XzJhI6TzP0zlBQRcsmecd0m7sVHPqMg0VJnRY5vq25+9AwVrkJNwdMmJI9yMHiuu8O933FpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502546; c=relaxed/simple;
	bh=ei6uKuFHNES6Tz2lkRZwuDlTAQukDr3qpC/ZyrUr5b8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=NrBa+HRzZbdzuAq09iyWYaAjNpORomdTA8q4/JHP6bKY7RVPcVBQxQzT/s6+yGfBwvud7GFbhzE8F6PXlA3mW0TLI3nd1Eh5IubIoIlPsa50UY5ivuvHYo1E/z8cRy45fEKa7piquhPGuNDiL0VAEyV4HrC8evdxCb1w5MCWjPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rvN6rl9c; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240315113539epoutp0497646e2edadf67933a76977cfe49dac3~87P82S77K3162231622epoutp04S
	for <linux-pci@vger.kernel.org>; Fri, 15 Mar 2024 11:35:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240315113539epoutp0497646e2edadf67933a76977cfe49dac3~87P82S77K3162231622epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1710502539;
	bh=ei6uKuFHNES6Tz2lkRZwuDlTAQukDr3qpC/ZyrUr5b8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rvN6rl9czyOhuEqDQYokPV2FU6HbTky8MkvTWDm7xYyJyA344VgoX7tundiSihIFa
	 E9F6APy0xyVfNKxlD5zUptWX/2URthuwihQrO/yKLOaiRidNIMQkRv9zAoj51Faws6
	 w000B/Z8eZ4ew+EpGlYRqvKHyNLCxObaHRWwBKZo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240315113538epcas5p435e6d22a7e21c7eb693a923dcefe8038~87P8Mnr102078120781epcas5p4j;
	Fri, 15 Mar 2024 11:35:38 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Tx2HY0N7Lz4x9Pt; Fri, 15 Mar
	2024 11:35:37 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	02.D1.08567.88234F56; Fri, 15 Mar 2024 20:35:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240315113454epcas5p3a5663e477e0da4b9a6237acb72ea8448~87PTB2AHh2680026800epcas5p3d;
	Fri, 15 Mar 2024 11:34:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240315113454epsmtrp2ad74d84a85d8e88d650483e693a97a23~87PTA3H0h3050830508epsmtrp2q;
	Fri, 15 Mar 2024 11:34:54 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-ec-65f43288d5bd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2A.2F.08755.E5234F56; Fri, 15 Mar 2024 20:34:54 +0900 (KST)
Received: from FDSFTE462 (unknown [107.122.81.248]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240315113451epsmtip18aea286a6886ca9c902ce0c807f1000a~87PQOkNfX0872908729epsmtip1h;
	Fri, 15 Mar 2024 11:34:51 +0000 (GMT)
From: "Shradha Todi" <shradha.t@samsung.com>
To: "'Stephen Boyd'" <sboyd@kernel.org>, "'Dan Carpenter'"
	<dan.carpenter@linaro.org>
Cc: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <mturquette@baylibre.com>,
	<jingoohan1@gmail.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <krzysztof.kozlowski@linaro.org>,
	<alim.akhtar@samsung.com>, <linux@armlinux.org.uk>,
	<m.szyprowski@samsung.com>, <manivannan.sadhasivam@linaro.org>,
	<pankaj.dubey@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <9927a3356ce54c626ab4733844a4385b.sboyd@kernel.org>
Subject: RE: [PATCH v6 1/2] clk: Provide managed helper to get and enable
 bulk clocks
Date: Fri, 15 Mar 2024 17:04:44 +0530
Message-ID: <104401da76cc$ccc772c0$66565840$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH2hJCcwYDjJDqbclltz640cKP7jQL/AcmgAaOboDkDexFUCAD2UfeNAfilKBWwqCa/4A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbUxTZxTHc9vb3paty12p44FlDqv7gBOkUrqnU14ymV42l7EZIDNTdmkv
	BSlt7S2gZmHdBgENL26DAI1W3IAhGwzLO9JFKoNBoqyBNDCGokUkEGRIZYH6srYXN779znn+
	55zn/7zw2MIlbhAvQ2Og9BpSLeb6oR3XQ0JCi/a4qPD1ZjmcNndwYe1X6fBvcwEGJ651s2CD
	qxqD1oV2DBqL3RxocTo4cLn4FgeO9pznwhvmQS6sGvmVBW0VVgTmP85HYVP/FAan8s9woH34
	Xfh9uwuDz3q7MPjUcQWNFRGjDjubWBovwIhu0xRG1FiyCUvjGS7xl6OXS8yMVbKI1toviNK2
	RoRYsWxN8DuSuS+dIpWUPpjSKLTKDI0qSvz+4ZT9KZGycEmoRA7fEgdryCwqShx3KCH0QIba
	Y04cnEOqsz2pBJKmxbuj9+m12QYqOF1LG6LElE6p1kl1YTSZRWdrVGEayvC2JDx8T6RH+Flm
	+nBZMaqbFJxsmJhjGRHrC2cRHg/gUnD/xodnET+eEL+KAMtgJYsJHiLAOHNrI1hFQLtjzRPw
	fRWli79zvSzErQj4skXDiOYQcLuvAvMucPFdYGbsMdvLIjwZjJ2bZHtFbLwQBT9c/9lXzcdj
	wb2bQz7294gKlx76GMXfAOOdd30swOXAXeLkMPwyGKqeQb3Mxt8E9ZcW2MyOgsHavXqO148I
	TwKj9TgjCQC/rRX75gK8kg8W/ihFGc9x4MpKPFPqD+YH2zCGg8DKAyuXYRW43Fq10V4NVltr
	N8zHgGtj531t2HgI+KVnN5N+DVQMN7OYsS+BEvfMhlwAuszPeTtwPelFGQ4E5oFRzjlEbNpk
	zLTJmGmTA9P/02oQtBEJpHR0lopSROokGir3v+tWaLMsiO/l74zrQsYvPg2zISweYkMAjy0W
	CfK2LVNCgZI8dZrSa1P02WqKtiGRntP+hh20RaH1fB2NIUUilYdLZTKZVB4hk4gDBAsFF5RC
	XEUaqEyK0lH653UsHj/IyIK7bNv5w9Hu7ncKE+sS83v8/4mP+EDlb+sDuaJTE9IOZ/V00qz9
	68VqZf3xzHGuVZEaIBuKiVt93W7tvptsSZs2t96+r9DUXXryU3l8+1GCINeN/TEL/Pn+PFFu
	ZfnhWHP5oy2Zrdi3rpatuJFsLizze3XkxLpoznDhZuTBkTsgrZS82PkJb6/wETXbeIS+PLi/
	vfGVNMoZUdXUdPVgcuWJzqIH7pM7OgLrX5xLXa4B26I/t9sSS4pks32Lk8eMedWLB350fXcn
	573jfzrj3BFR00lNx/aOzWd9Oij62DG5jjbDNlO5s6U/Fc1pGgB1ztiAoxFy+0cDQ6fpZ6sN
	ZWKUTiclO9l6mvwXYDHaJYIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSnG6c0ZdUgyuzRS0ezNvGZrGkKcPi
	w7xWdoubB3YyWaz4MpPdYu/rrewWDT2/WS02Pb7GavGx5x6rxeVdc9gszs47zmYx4/w+JotD
	U/cyWrT8aWGxWHvkLrvF3ZZOVouLp1wtFm39wm7xf88Odot/1zayOIh4XL52kdnj/Y1Wdo+d
	s+6yeyzYVOqxaVUnm8eda3vYPJ5cmc7ksXlJvUffllWMHp83yQVwRXHZpKTmZJalFunbJXBl
	HN1yia1gA2/F8xfv2RoYJ3B3MXJySAiYSPS9PcEGYgsJ7GaUuPvUHSIuKfH54jomCFtYYuW/
	5+xdjFxANc8YJc43rGAESbAJ6Eg8ufKHGcQWEQiX2Nf0GqyIWWA2i8TfuQuZIaZeYZI4u0YF
	xOYUcJB4eu4k2DZhgVCJrilb2EFsFgFViRvbH4HFeQUsJX73PmaFsAUlTs58wgJiMwtoS/Q+
	bGWEsZctfM0McZ2CxM+ny4DqOYCOCJO4vEwAokRc4ujPHuYJjMKzkEyahWTSLCSTZiFpWcDI
	sopRMrWgODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzjytTR3MG5f9UHvECMTB+MhRgkOZiUR
	3jrFj6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamCa6
	6dq//iJZ3+3ouX9Je9GnvWc5ZBw2JM6X2DJLdu5nBYN/S7+7tE5/8yJVxGCl6f7fn6/z9M3+
	W+CyzvByh6J71JUY9o5ZvSKFh+0rWHUMmCwvWvf+enPMW/tXYEpZxH+ZuW+/WD3vU+92jan5
	Jebq2HOV89W7XU9mHGdZ9ENJ9Y3tth1FU96om9t6Jll4zV45Q6J07c4T3vEcqZHXpv+9yzDL
	59a6SPFJpmkfO3ec7bs5efuEZz/mhXO5CGyeMd2XJX3tgu9hrxZ411ybffvn/Fjbp5LJFuqz
	72qmud3fmvfSq3nVh85JBZvqP0s+rNYLdA3uiz709vFjE7HXS21uxzxnyzi7ZusSe4Vb0ZeU
	WIozEg21mIuKEwEqsX+lawMAAA==
X-CMS-MailID: 20240315113454epcas5p3a5663e477e0da4b9a6237acb72ea8448
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c
References: <20240220084046.23786-1-shradha.t@samsung.com>
	<CGME20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c@epcas5p1.samsung.com>
	<20240220084046.23786-2-shradha.t@samsung.com>
	<f00eed31-4baf-4d5c-934d-8223d1ab554d@moroto.mountain>
	<022301da6fbf$aae4f7e0$00aee7a0$@samsung.com>
	<9927a3356ce54c626ab4733844a4385b.sboyd@kernel.org>



> -----Original Message-----
> From: Stephen Boyd <sboyd=40kernel.org>
> Sent: 09 March 2024 06:21
> To: 'Dan Carpenter' <dan.carpenter=40linaro.org>; Shradha Todi
> <shradha.t=40samsung.com>
> Cc: linux-clk=40vger.kernel.org; linux-kernel=40vger.kernel.org; linux-
> pci=40vger.kernel.org; linux-arm-kernel=40lists.infradead.org; linux-sams=
ung-
> soc=40vger.kernel.org; mturquette=40baylibre.com; jingoohan1=40gmail.com;
> lpieralisi=40kernel.org; kw=40linux.com; robh=40kernel.org; bhelgaas=40go=
ogle.com;
> krzysztof.kozlowski=40linaro.org; alim.akhtar=40samsung.com;
> linux=40armlinux.org.uk; m.szyprowski=40samsung.com;
> manivannan.sadhasivam=40linaro.org; pankaj.dubey=40samsung.com;
> gost.dev=40samsung.com
> Subject: RE: =5BPATCH v6 1/2=5D clk: Provide managed helper to get and en=
able bulk
> clocks
>=20
> Quoting Shradha Todi (2024-03-06 04:13:03)
> > >
> > > When clk_bulk_get_all() returns zero then we return success here.
> > >
> >
> > Yes, we are returning success in case there are no clocks as well. In
> > case there are no clocks defined in the DT-node, then it is assumed
> > that the driver does not need any clock manipulation for driver
> > operation. So the intention here is to continue without throwing
> > error.
>=20
> Maybe we shouldn't even return the clks to the caller. Do you have any us=
e for
> the clk pointers?

The intention to return the clk pointers was in the case where caller wants=
 to
manipulate a particular clock in certain conditions. They can obtain the cl=
ock pointer
and use clk_set_parent, clk_set_rate on those particular clocks.
But I understand that in that case users can use existing clk_bulk_get_all(=
) API.
So, should I go ahead and send v7?


