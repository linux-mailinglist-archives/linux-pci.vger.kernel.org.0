Return-Path: <linux-pci+bounces-9708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839209256E6
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 11:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77611C210B8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E631411E1;
	Wed,  3 Jul 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="XR5vYtU8"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010064.outbound.protection.outlook.com [52.101.229.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844713D61B;
	Wed,  3 Jul 2024 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719999278; cv=fail; b=gdbi+N7TCQ7xwIQbKx7LzOjKXuvUu4QoWGWQT1sgCcPe93LLH7s7mzsTrnLLpC/wAZ6gEloZUgUNgvzGqBAYWeSmg744Lw8neixMItjQGj27fruDBJfpUPlKMksP5T6zoYLtNYxFxHVuDNw/iSm8iEaPfHj7uNcZGfaqsviZtpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719999278; c=relaxed/simple;
	bh=mQjtHVZLwBYizNdT0aWIaBO372al/PASEqABZMehQ3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnIiilwQoTkYROslYP8In4kwHhGmWPYn1M5g80Z6IePCFn1XdjOiiak4mhyuczGbJ2JmlNpn5dvaNtpI+G7MAs1D9rRa7OJcen09vceRQNhiGUWFajyfMb5Sej71BV3efgnWu8nyjJvX/M3XCR0TXm2ZoeEpS55lAUIEVRDDsi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=XR5vYtU8; arc=fail smtp.client-ip=52.101.229.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqeTu22hacjPs4yVYcMr1FWrXso6DY4NsuhIi6DojSqLhIGJwJkfcxQt6nVy9a57K+qThdIWMhXD0G411WFa07vYsu+9NgeIPOkvvQgxjIlwTVGGsYsCK4BkxorgJ47pP0UsZJ9XfUS1EOFzMHXVBRKxVHDYBRtUllcCg1dIoBrId7hXyaPgC59i+u1wPbLLMfkMPYuqH0rzYiPHTXkVQxYJS8cwSj3+V2ATlziKVFMslPMStzUxz/p/pNlwsKlcg3mC8H6EGAhqvx1twgAT6rDeQW5gZns63yATF8Y/fZe9/kTrWMERbiUTZG1lPwuuj7q17DcgTfGFCGUFkHcPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckreS44sDKXIT6SgZ17otgx5HyALomNMmQqPgFrcBkU=;
 b=ld4B/yGI7VDn86T73oikyAhx9GTFVMfHplj2W8JMUMwevz8xo9MQP8JlQroDq/rSgOHdT0UVU3Yoe7JsurLHNFqVRwU0SqBYZucZHSTJCeQrhv1RljifLG1gXeCcmWtzWUT0l2wZSmb88NnqYo4Y5PCDv3I1LxszyIb8Pks4XZi4tZVa5fiRRfs4zWbYDGmDVg5J2yQxPriCftVIKc1Zxo9aRQBsjPJ3ejdZF+ztZDhtMQCTtCpSzlRPpfQ36zFL/AbUUZ92EaCHdi/FgtcPDcUHeCJIQVgGzrDrEzly8tQA/0DkQ4VzHTEe1mRM8dXUtUkD9+stTQ2lz2T2mujxaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckreS44sDKXIT6SgZ17otgx5HyALomNMmQqPgFrcBkU=;
 b=XR5vYtU8wYbQ0EGqCwypHSkhS5JwV+lxte4mVO/71qE2iMq4SeGGcaMIJMbGasO3fGXH3T/CMqmi/jGphsfSiT0CCnA9DyUHJphYGmdTsnGW1nvqZsluxAhzRsm/qMnuP3kpG5CzynpqTd/hA1Z2C4GqQyrc+/36L3l+sARseSI=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB11125.jpnprd01.prod.outlook.com (2603:1096:400:3be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Wed, 3 Jul
 2024 09:34:32 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::b183:a30f:c95f:a155%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 09:34:32 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"jingoohan1@gmail.com" <jingoohan1@gmail.com>, "mani@kernel.org"
	<mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Index:
 AQHau/4H2Ue+Yvqse06eFL/aaE81cLHfRNCAgAIafiCAARdjgIABBaRggAFSq4CAABE0cA==
Date: Wed, 3 Jul 2024 09:34:32 +0000
Message-ID:
 <TYCPR01MB110407EAC6DD09E2C40D240FDD8DD2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240629195615.GC2249818@rocinante>
 <TYCPR01MB1104021C193620D3E02D32BB9D8D32@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240701204333.GB412915@rocinante>
 <TYCPR01MB1104021542E26342F961B1499D8DC2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <20240703083209.GB4117643@rocinante>
In-Reply-To: <20240703083209.GB4117643@rocinante>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB11125:EE_
x-ms-office365-filtering-correlation-id: 6990fb43-a6ac-49ab-7c3b-08dc9b435844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?kaB/Hnn8IwC8OHRtArgnkGwJoBpq/BHNW9PuZ1McVANmu0cS3nqbiHN/l8?=
 =?iso-8859-2?Q?8evXaxVULlRiqUtSrlViz4gOuuhGW/VF6GQ5kFU2O+/RdDvuKfmhggn74C?=
 =?iso-8859-2?Q?HV3D5f1smcYjd61Nohh7uoL2vGdbAAJ0pXcPWrS2tmcvYwHuREoxzF/vCC?=
 =?iso-8859-2?Q?amGmJaf6riH6xH+xdK7LDl/b98uPYkT8eJ7FsW0FLwXI4QBeNtcgWkHAKL?=
 =?iso-8859-2?Q?zfBPe71D46tcglP1ZB7CVW1bRuK2Y6IOHDm1+ovycTBv9BXL9fG9Lb3h/t?=
 =?iso-8859-2?Q?ZlxozPeZkj1NVo/8vZr+ilEVK7xoyuosCsb7MN49KQCg6uhND5rLpLBk6v?=
 =?iso-8859-2?Q?KXxvLOPbz3dfketKg16QoCPexlX00rRNXpbQ/x/dfsww+55ywKTXHt+VI9?=
 =?iso-8859-2?Q?8sroHtIFcw1bpjj6KJI7/D9uqnkFniI14Xg171SM78lX764EmcUJDdwRRY?=
 =?iso-8859-2?Q?enIoW70IE3MTDZkfDzRvfOXr3rgKLz+nas98HYIKq097/y52Nzs7Sxq/IQ?=
 =?iso-8859-2?Q?Wr0H2dukbDawfkX7FZR2VAcPqDQERqpOKfCyE1FM7K+jBTNJYyg9/PiGPR?=
 =?iso-8859-2?Q?mLOlpX1feslYEG9aDeUtRVDoMmMPWgdxX3bIkFRqDpCYorelBMyiQhfuVb?=
 =?iso-8859-2?Q?r+FF6NJF0kjOTulZcm5+/Up1YSvxnIppgqeVc/MrP/HL+BAvycCJ1fWzYJ?=
 =?iso-8859-2?Q?aW4LeMQFPqiMMcm1eJT4QkaYck3YYfAn7VLpcbLjkCXxFY58bCEs9eIoBl?=
 =?iso-8859-2?Q?k2DZD3P46kRcttxpK1pFc+ZhOWRP8OZ21ckuUVSZugH4XHFsJNMy5QVKsm?=
 =?iso-8859-2?Q?ggWHHfa9yWXKQFkkwoEZUgsrR7rm8KU7qCFMPC1ugxTmFZOcLlpPrVcUh1?=
 =?iso-8859-2?Q?VodUi53ZzujxZBZDe3blHQUIkoVgwuyhjbWWKBOvr5N2qksC7ggr9MtGO3?=
 =?iso-8859-2?Q?FTY7I258Xp+X+yzaTII2hreXVRTzPW+9dRosJVkbAkgd5UuAxGDdEiXcRW?=
 =?iso-8859-2?Q?r4+2cM97VqOWVfvuiDnOqlY2VnzE6LVKVoZ0Qg+G17BmB/vffcgyHsa+0R?=
 =?iso-8859-2?Q?CzYGpxuMQEFv2B5RGirOSNNLbPBH0JdzZwB2JHyptXvhPU7KC7Dv1XbPM3?=
 =?iso-8859-2?Q?y5oMy5Pqpern0nftwGTxzmDFesKCvC7lvOexozxrK0R5CTLN0urzk0jjGV?=
 =?iso-8859-2?Q?B8/1F/NCo7P76voUpy7gFZ62vIarfO/6v5O31ICs7n+oVipaJcW5j9pXSc?=
 =?iso-8859-2?Q?oNLljvrngbt9XY35QdzAJ8Iw4U8Ai6FmWO2WB/4dTcPjEfwpjgJsTlYe2o?=
 =?iso-8859-2?Q?/OrDahLu+NlWqs1T7HDnOwnSYhD9/TsGw+N4ZxpdO7kDLC/pO4/rKYryrx?=
 =?iso-8859-2?Q?UuTJ9bF+WzWxkqCaVyYuRUVdnSDF1X1M4u4tlrRInEiCb4AwvnJXIF/WbP?=
 =?iso-8859-2?Q?V/fgPvokW7jDe0t2ISr+zrwoeDL0WhxGeIZ89Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?YVKgDaBP9sX3oeV5BRYWzaqzEUzzpLd3uKTzRngKvEvyFkDFZLtaqiV4Gd?=
 =?iso-8859-2?Q?pnSlS04prPgagoTwldR2s0DQX8M9HdwemX8FZA4J02dEA0+9N+21sxF5gi?=
 =?iso-8859-2?Q?YknfpSz+e4szvqXpGOtlV7PjyysPMmn9pma00SxHso7doyb7p+toIXMqbU?=
 =?iso-8859-2?Q?MgJVJ8e9KxRE5POBi4xU5ZE4qPYAGG3+nDue0Ngua5i5e1c6QXF4dzvLBH?=
 =?iso-8859-2?Q?5wjuTn1cc/gH6zuBzRac5m9rELyYIIhsnoW5gxz4u9YHVSguoEAto2cFLH?=
 =?iso-8859-2?Q?QbwlZc6mcrWy9bfxwBa9RSwX4jWICcqkGYtSJcVR0Hpx4hRK90BHRHuBFo?=
 =?iso-8859-2?Q?3WGrAsF+pzlbBq9aUJwiGPf7r8PNOdouS4bSXWi1ZAQLeYY4N21+xkxp/R?=
 =?iso-8859-2?Q?GuaKyY24BwUbWrG1ABU7PmOtUI2IPZfUCYJJmb7wgbmyT3qwkMM419WIUa?=
 =?iso-8859-2?Q?TpMxpsk6DsqkvmQM9tExBZ81PaOi+yoXzYf2h7/euk6cUy8P/Orc4W2l+b?=
 =?iso-8859-2?Q?IyZNV0VPFq7En0i5IFivYq2PqkoYisUinfY+hxrQR/CwNq2cG4DTa/j1+U?=
 =?iso-8859-2?Q?//OuKeLFrheRaFTBmzRNdj0aFwWGGcvNs2vKwsSUi1wMgW26VfmrbkoWeu?=
 =?iso-8859-2?Q?5iGCBz9QBOf/yj0dd4Kkckyp59YE9fvte7BI/H6/LvUWGfik6WCifvoJmz?=
 =?iso-8859-2?Q?kTnP7YDKrX6O2Dqq2iqmcB3QGULUQpT0KGQQPosyZ3ezPPZ/fZO/yubidf?=
 =?iso-8859-2?Q?nXkyHIIWW961vdrE4aP0/hC/+dazTL0yMWAYwd4TJe6gxJcATn0uabkkKQ?=
 =?iso-8859-2?Q?7m+iCasx5eV331WIxDOQiqVp9DI5Btr9vfdI6xNVV7A6kHSd4p455xIM4L?=
 =?iso-8859-2?Q?JSKQ3GA4+y/T7iw2wIwoCvXbUVGQ4kwAIfWDzobmvOhPBIPdW8SgpKutbs?=
 =?iso-8859-2?Q?4bDF+Hu9TVepXT2PjCQjQ6wupoe9DyRxaThntp153gKFA68SPv0TnEcnJz?=
 =?iso-8859-2?Q?BGfTlr4u0JjFMASeLQcdQpcvFGCmTaZcf9FfEEtrsredGxQAUBpj4mHG05?=
 =?iso-8859-2?Q?d4IB+FVvKoEwbL3RzC4ylHfH9GCxbSCqIZHC8T8oj68KqpsKZBAlAdKv9M?=
 =?iso-8859-2?Q?4JRNBj+kka/UFg2+F2YwW/id42K3e6CZXMKw8D/9o0H2bbPj70zMbN9nn2?=
 =?iso-8859-2?Q?mPI1VUJyFZrlY4Mft5dd5l4Jg+PW9zAadNbgYzRgw09MkQkgFpN1ACFfsM?=
 =?iso-8859-2?Q?XHU0Ng02Gf5hk7UbkQXCpM+KoHAclwPRGT+o52Ovvt1h3OAM+WicDku6cu?=
 =?iso-8859-2?Q?BmYW+GOaM6temc96iYK2jGaJ8shFMImbFSJ0mFrQt47wxwuxJgFds6N7cV?=
 =?iso-8859-2?Q?mSlccLMmLqNpQ5XMG7qQNlIWvc2oktbIcEEWvpgmwPnJRYfjxtHl9NHPGb?=
 =?iso-8859-2?Q?bX0KeduFS61EyPV8lIstV8CpzBoODJd4F5pv0ydmPo2m8B3jh8HmOQIB5J?=
 =?iso-8859-2?Q?61QCH/VqOxoR4+sVmRobY267zCI5LZl1RubYkTPLG+oDQ10/zunAP1r32c?=
 =?iso-8859-2?Q?HhpWdum18tKDX1PZ/D0uzbgbV7rrgkH6teNayfaHK7aNvdmuzwQ5R7Sj4E?=
 =?iso-8859-2?Q?XNyWGX59pQA9NYh262XibG0NjyBWcmCCEOFmz2As0PpEYFk5BhMVETTQ?=
 =?iso-8859-2?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6990fb43-a6ac-49ab-7c3b-08dc9b435844
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2024 09:34:32.5147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Va8Bwuxq0Wst/dbSZ7X/OdEvUV8v6JeT2Mj1kTBKPHgK7CUmKhEhlswRu49N/uCXfXm9Y1LfD9nvMBkjz7j+HrWulznG6wp5lEDktt7ArRx4QNllmpqzKsqUhY1f7jCl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11125

Hello Krzysztof-san,

> From: Krzysztof Wilczy=F1ski, Sent: Wednesday, July 3, 2024 5:32 PM
> [...]
> > > After thinking about this a little more, I believe that it might be b=
etter
> > > to follow what some other drivers have done, and simply add this guid=
e as
> > > a text file under a dedicated ../Documentation/admin-guide directory.
> > >
> > > We can then mention, or not, at the top of the file that there is a g=
uide
> > > available at this location for people to read on how to obtain and pr=
epare
> > > the firmware.
> > >
> > > Thoughts?
> >
> > Thank you for your comments. I agreed. So, may I send such a patch? Or,=
 should
> > I send whole patches as v10?
>=20
> No need to send a new series.  A small patch that I can pick would be fin=
e.

I got it. I'll send such a small patch soon.

Best regards,
Yoshihiro Shimoda

> Thank you!
>=20
> 	Krzysztof


