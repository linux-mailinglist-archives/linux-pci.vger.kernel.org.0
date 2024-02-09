Return-Path: <linux-pci+bounces-3311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4928500DB
	for <lists+linux-pci@lfdr.de>; Sat, 10 Feb 2024 00:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CE9F1C22A08
	for <lists+linux-pci@lfdr.de>; Fri,  9 Feb 2024 23:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D12238396;
	Fri,  9 Feb 2024 23:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M3YiBobb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDBB567A;
	Fri,  9 Feb 2024 23:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.189.100.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707522628; cv=none; b=gyDGLAuzDZAtHPbMVHZvt4h5RHZNK7eqpRTwNK0bJzlC61oUbZ9ihqrYgmeotLXgtFcJX3N8f9dZQcbP8dqIZaKsg5KysEILS+dGA5XOt9xzlOtZD/91cCEVixpqriSIv9gSMJeexxG0PTYOHCvKhNNXDHQpiIg83l51ARwY75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707522628; c=relaxed/simple;
	bh=mJqGTWuUY3hmWxmNQ15X30o5B0bN5IZ/Nf2MI7ggeZc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=Hw1Oqz03fkhQ2m1mQeNvGVaK1KBw7w5c0Bg83O7ptzOtOBplDqgI2COOGMpP5HqX/YscoABzDKVlLqbgI0T0PP2ylYYJiHQ9llK07MyVMfnTlDDnj0AGarLDfn5D96sKrYUkCRqLAMDc/B1G4hv8tOzAI/ka3T/7xdsBa5KsJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M3YiBobb; arc=none smtp.client-ip=211.189.100.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240209234111usoutp01bc82bdc142f29482d62907c837147c8d~yVkb5dabu2587425874usoutp01J;
	Fri,  9 Feb 2024 23:41:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240209234111usoutp01bc82bdc142f29482d62907c837147c8d~yVkb5dabu2587425874usoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707522071;
	bh=mJqGTWuUY3hmWxmNQ15X30o5B0bN5IZ/Nf2MI7ggeZc=;
	h=From:To:Subject:Date:References:From;
	b=M3YiBobbFH0ZSJXLlYfSRAYluuyvIBDwveNGiGbanQNQRZIxiw7F3vFh9XPQeusdI
	 FEtWYWh17/VwEZ8RLDETl4pkS2Acyh4scVscp5IJgpSeX89VOLg7lA9ItCvgDpLvaI
	 sBLuXBbbNBKXQvgs2jsiQfD8oMH9FoufgAmoFj5M=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
	[203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209234110uscas1p1b0b161a9a7de4c5f604f943e65847aae~yVkbWWiPU0374503745uscas1p12;
	Fri,  9 Feb 2024 23:41:10 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
	ussmges2new.samsung.com (USCPEMTA) with SMTP id 57.22.09760.618B6C56; Fri, 
	9 Feb 2024 18:41:10 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
	20240209234110uscas1p17b5701193c377f41047716ea7e50a78a~yVka6zWrj0801708017uscas1p1k;
	Fri,  9 Feb 2024 23:41:10 +0000 (GMT)
X-AuditID: cbfec36f-561ff70000002620-9b-65c6b816253c
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.67]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 5D.CB.50948.618B6C56; Fri, 
	9 Feb 2024 18:41:10 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2375.24; Fri, 9 Feb 2024 15:41:09 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
	9 Feb 2024 15:41:09 -0800
From: Jim Harris <jim.harris@samsung.com>
To: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Leon Romanovsky <leonro@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	"pierre.cregut@orange.com" <pierre.cregut@orange.com>
Subject: [PATCH v2 0/2] Series short description
Thread-Topic: [PATCH v2 0/2] Series short description
Thread-Index: AQHaW7F1RT+NY9W9+0eB6MuJuslBKw==
Date: Fri, 9 Feb 2024 23:41:09 +0000
Message-ID: <170752205288.1693110.11063930479227366897.stgit@bgt-140510-bm01.eng.stellus.in>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <F87BD652DB8EC640B0918DEC13EF7A1A@ssi.samsung.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsWy7djXc7piO46lGsx4ZGLx7X8Pm8WSpgyL
	K//2MFps2vCExeLyrjlsFmfnHWezWP/1PZsDu8eCTaUevc3v2Dxanp1k83i/7yqbx+dNcgGs
	UVw2Kak5mWWpRfp2CVwZnf/OsBRMYK5YeuU6ewNjC3MXIyeHhICJxPpPO4BsLg4hgZWMEndm
	zGOFcFqZJJY3TmSCqWq+9IYJIrGGUeJd6xWoqo+MEr8nXYDqX8oo8b5lMitIC5uApsSvK2vA
	WkQErjJJTF79AWyjsICBxLzDHYwgtoiAqUTj1ydMELaexOz2HqA4BweLgIrEuyt5IGFegRiJ
	CWuOgM1kFBCT+H5qDVg5s4C4xK0n86HOE5RYNHsP1ENiEv92PWSDsBUl7n9/yQ4ykhnonvW7
	9CFa7SQOn3zECmErSkzpfsgOsUpQ4uTMJywQrZISB1fcYAE5X0JgLYfE3aYpUAkXiRfrl7JD
	2NIS09dchopnS6xc38EEsktCoECi4UgQRNhaYuGf9VAn80n8/fWIEaKEV6KjTWgCo9IsJM/M
	Qjh0FpJDZyE5dBaSQxcwsq5iFC8tLs5NTy02ykst1ytOzC0uzUvXS87P3cQITEun/x3O38F4
	/dZHvUOMTByMhxglOJiVRHhDlhxJFeJNSaysSi3Kjy8qzUktPsQozcGiJM5raHsyWUggPbEk
	NTs1tSC1CCbLxMEp1cC0WuVXTe++A4sv7zlssj/xp/RSndl65ZPCJSw9fubY2734+XJF8c2A
	pTvT77x48tBw3YOIq6tPNLnsENkXErNdgJshUmdSbbb/9DeNb/YmbL3ltLay7eSFmYt3Lqj+
	OPP3nUVn1G4LPDDdZh3zYpbjfz7psA36TFe8HRNmrOOaVtT+9pXY03ktbLlbni6KsXUKzrl1
	+NI5Ufdj/UuEfI3XKhzdxp+cwxHZz5To0Lg47gz7pPm1Z0+4V/4V/yaoy5pR3778zDsjGbvZ
	Ir/fzHjwYI7l3p0aQfpyt4wXeP26toxt6aZf+z9PevZBT7zsyHbZXxd10ve5PJVv1me9YV/5
	Lv+ksm5ChFL3tJBJVxsZliixFGckGmoxFxUnAgDEsWRTugMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsWS2cDsrCu241iqwb1N4hbf/vewWSxpyrC4
	8m8Po8WmDU9YLC7vmsNmcXbecTaL9V/fszmweyzYVOrR2/yOzaPl2Uk2j/f7rrJ5fN4kF8Aa
	xWWTkpqTWZZapG+XwJXR+e8MS8EE5oqlV66zNzC2MHcxcnJICJhINF96w9TFyMUhJLCKUeJ9
	xw4o5yOjxPrVL6GcpYwSL9sPsIK0sAloSvy6sgYsISJwlUli8uoPYLOEBQwk5h3uYASxRQRM
	JRq/PmGCsPUkZrf3AMU5OFgEVCTeXckDCfMKxEhMWHMEbCajgJjE91NrwMqZBcQlbj2ZzwRx
	noDEkj3noU4VlXj5+B8rhK0ocf/7S3aQkcxA96zfpQ/Raidx+OQjVghbUWJK90N2iFWCEidn
	PmGBaJWUOLjiBssERtFZSLbNQpg0C8mkWUgmzUIyaQEj6ypG8dLi4tz0imLjvNRyveLE3OLS
	vHS95PzcTYzAaDz973DMDsZ7tz7qHWJk4mA8xCjBwawkwhuy5EiqEG9KYmVValF+fFFpTmrx
	IUZpDhYlcd67DzRShQTSE0tSs1NTC1KLYLJMHJxSDUyyrDv6MpV2C1267C0tzKSyXTf92Wyd
	RzePm+/ecopDMMmwnOcku9DCrpzoRCaGAukTxTtvaBxS+aE+M3Tlwncnyyc8V1i348ALce9J
	uT2r1vGdXeaqy9Gk9/53QtLJqrf7vmu8cXAy/XIyobT9XXDnA/ZpKXmGsyYyS/rMcsjczPK5
	bf4sm1ypzrf9UpozoxccUJK7efZrzPqVhuHddhsZPcPfljf99Dx6T+RrudUtjrltzw/seC56
	51xVcv/GiFCXCR9bFiizOet5zpLWkJjMvfvej33ptav3fI0PvG2jHKD8mHta7V7ucyv15X9t
	fbPmdN23EsvDyWaL3+ksnmj+f+aNd984lfOMdx54uGafEktxRqKhFnNRcSIAqUdGDTUDAAA=
X-CMS-MailID: 20240209234110uscas1p17b5701193c377f41047716ea7e50a78a
CMS-TYPE: 301P
X-CMS-RootMailID: 20240209234110uscas1p17b5701193c377f41047716ea7e50a78a
References: <CGME20240209234110uscas1p17b5701193c377f41047716ea7e50a78a@uscas1p1.samsung.com>

VGhlIGZvbGxvd2luZyBzZXJpZXMgaW1wbGVtZW50cy4uLgoKLS0tCgpKaW0gSGFycmlzICgyKToK
ICAgICAgUmV2ZXJ0ICJQQ0kvSU9WOiBTZXJpYWxpemUgc3lzZnMgc3Jpb3ZfbnVtdmZzIHJlYWRz
IHZzIHdyaXRlcyIKICAgICAgcGNpL2lvdjogZml4IGtvYmplY3RfdWV2ZW50KCkgb3JkZXJpbmcg
aW4gc3Jpb3ZfZW5hYmxlKCkKCgogZHJpdmVycy9wY2kvaW92LmMgfCAgIDEwICsrLS0tLS0tLS0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgotLQpTaWdu
YXR1cmUK

