Return-Path: <linux-pci+bounces-6862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040BB8B6E4C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6491F24FA5
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206FF1BF6CE;
	Tue, 30 Apr 2024 09:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Q9RdRfQT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF131BED8A;
	Tue, 30 Apr 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468967; cv=fail; b=hn7vsT1w3q4RechCBdVL5SBJ6SGwBRyLB2N4sBVGppjMUvj82PXLaMT9lXTIhtMQPvo0wqmGEGfvEJyN6OaBW6Y4vNy4zs1iqKE0OZK3z3znEPscLPz6sFePLuMvUUvQ5l8qVLaZC4Kc/LcX6C5Vjo0Rw9ZhJckPmTwXABKo/ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468967; c=relaxed/simple;
	bh=ltMCD8H2MZ/ZNNzDmMrc2TrMCh22Do2Vodgk9gGnASM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mxdasbt1CDsbmg3F9vGgJcYU9iLj4volXdh4EszToTZOdgMks1o8lrQGhY3VkkXVElGyvioRGr22L0h6jNEI2haGezJTMePiWvqtVqL5ZbQZdnOdRGHdAQNQRgAoibnOW6rxsWwd7BgYzfl/nVm9NbvfFp83Twa937vfbQm0gIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Q9RdRfQT; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TM0j3t032644;
	Tue, 30 Apr 2024 02:22:02 -0700
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43b1g62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 02:22:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os9q50gqSSRGOw9d1969SWmgUt4kq+RT/jV5CH+bMl4x6YZvMVI5Y7qdGj5hKi2Wlo52e5NEEdzgvDg8gnH4hFzNBLudSQUFaCzHpbcDn4vikc8a7rSpwPrSynz6/NBqbxjSyUNhM9O8ahfPsvthSTCixeJCvaB+dWivAmTfs3WFe0U74xlmBED/PO8J7xGROYBtKoWJFVlT9kgco+I0muYQowpFzEjJFYgO9V88JKDyMrg0R1GzE3adLU+Z7gsXg8ok5dpYoFUfaSu648d8h5qbgFPook/irRXti/tskXT6ZVBm2LZNgflIS0cysYBZTAKA3uI1TtKYrgWqOlAEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUms/3DjoNbouRV2BLmL7TVHVH7WLT/NB362+/zT6k4=;
 b=et9Zg6vj+QXCjvKMFqkC0wz5wuFFQs8AxS1rFRyeOWnxvidcW8puI8h6nPyUpIXuWMS26rx95JCPNlBZQxSxBMBxaPLOEi9Rpr2XKXuFDZ51QRDtyB3jr1DCP8xvWCP3xa6cp6aYX7D6uCxDSzA/PlxLntb8eqxwyzmymxNFO05/wEgsXcgzVTLI0UixSDXjqaYm/k7Od1cY4F3+avmrDmqgF/bNwl8WJ2Sz3+jTo3WPq0eOgItLPlG/BnWy3t1TTFZU/EacCWZwdoWRGhr1huJpt1cq5UXhmtQNNaJiyrmsHjNpyeXUhKWvBfcewEytB384lzZQCaB8uKtymO096Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUms/3DjoNbouRV2BLmL7TVHVH7WLT/NB362+/zT6k4=;
 b=Q9RdRfQTkt4VnhjCGtiB3fj8pe6dH3BjABGAElyQ4/hJGrVOUgYCd5RW3ZcPxtpUGKnJmfGqErkOrdSxeO7myoU73roXPvZmOI8ffq3s8LYLXadgJn85ucnkUtcKf+wk5yE2xKEkhaGMen87Emg68IQIQNvL87XYmHijYWdnVN4=
Received: from BY3PR18MB4707.namprd18.prod.outlook.com (2603:10b6:a03:3ca::23)
 by LV8PR18MB5784.namprd18.prod.outlook.com (2603:10b6:408:1ea::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:21:58 +0000
Received: from BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81]) by BY3PR18MB4707.namprd18.prod.outlook.com
 ([fe80::1f55:2359:3c4d:2c81%5]) with mapi id 15.20.7519.035; Tue, 30 Apr 2024
 09:21:58 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Herve Codina <herve.codina@bootlin.com>,
        Thomas Gleixner
	<tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Lee Jones
	<lee@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Horatiu Vultur
	<horatiu.vultur@microchip.com>,
        "UNGLinuxDriver@microchip.com"
	<UNGLinuxDriver@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan
	<saravanak@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen
 Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon
	<daniel.machon@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Allan Nielsen
	<allan.nielsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH 07/17] net: mdio: mscc-miim: Handle the switch reset
Thread-Topic: [PATCH 07/17] net: mdio: mscc-miim: Handle the switch reset
Thread-Index: AQHamt/ZzC0MRaHyQUOivu1NdGJeIg==
Date: Tue, 30 Apr 2024 09:21:57 +0000
Message-ID: 
 <BY3PR18MB4707BE42247B0A418EFEE35EA01A2@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-8-herve.codina@bootlin.com>
In-Reply-To: <20240430083730.134918-8-herve.codina@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4707:EE_|LV8PR18MB5784:EE_
x-ms-office365-filtering-correlation-id: cc19a5bd-b99c-4e32-a3c9-08dc68f6fc1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|366007|376005|7416005|38070700009|921011;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?1BnzGenHornSh7m4r+bZE8iMSyIdDdxoihl++3pjAlngTJjix+6dsN+6viHh?=
 =?us-ascii?Q?cWj6sfns5yslwo++rqoifnPdGc2fqTkBB6oPBtGeA1HyPr+AD4b2k8HKbQO+?=
 =?us-ascii?Q?HxMnzIuZZapAFQVWPTCoR746bVHr+U88+HhYAt89BaOAVHCv6oNGZwlrkQJt?=
 =?us-ascii?Q?9vAnn0BQ7fjoGTMEtGzfKyTvnIXAtyf6Mya5cGysOtrURqbS0YhjY3PwjRP3?=
 =?us-ascii?Q?BMQBUsc5skhA1/rAU3o0BDAhWaHk+ZX206D3MI1WaXuS0aK1N731o0l+DHhJ?=
 =?us-ascii?Q?IyT5ZEA7+32WCk90Uhv4XiiWFUNjKnBWfu/AhJNX7tLfLn1/YqtbZ0I7PSFf?=
 =?us-ascii?Q?eGR3XleaVJXBoPuicvEV6jl/0HjvdsNMekXhiYHtk8K//KnUZeZE2Dkun1LF?=
 =?us-ascii?Q?XHyhqGohjkHTxaZcYnR4e4NzgbMMLrs5afwohfofgR2SalzwBmHLGXxE9WWl?=
 =?us-ascii?Q?n6sV8QnA8ijSHe3ILqGCXAqGZxxw6Jb/CTQbtuy0T1amOwbToJVMW80BIePQ?=
 =?us-ascii?Q?a9oJ8GSg4JZMWH4Z/WdroRVrQayC2HR2JgWlCnF8egycNNtmlPc8VmNOkPXn?=
 =?us-ascii?Q?H5n3WVGixoHjKWg/qV4AGSzREDOS07QafA1cNABy7wZJmSkbd35FL5k4Q/eE?=
 =?us-ascii?Q?ekR7Bd7axgWYZ3Lhlo2ufam7+vUzLCBog0Y+5X+AaAi2CsJ/loSdG/WhptyH?=
 =?us-ascii?Q?xWSA1HLvyaajcIFi1jtzugP0KQuhaEEt8ogpUA7SvsdCeHf1eb6D4nbcCrVq?=
 =?us-ascii?Q?RDxkmjI/rFlm9McEulLTdO/Q7Laubqn9tLXZV6s85iuDCIB5tCg0QdV98KC9?=
 =?us-ascii?Q?RTzFPjENwJvnP6j4XBwyhjz51DV7qfPshYorcqMYo9i3mIcmwhnaQxHThHfM?=
 =?us-ascii?Q?CqpL3yeG46yg1xeG+hwn4n9yNX5myhZvnWIeU/IcqP5sn253UOnfPLboVLJq?=
 =?us-ascii?Q?/8ycT69l2zscjXzyLhPDhl7BaBHAhY6s3GIkcV15kiO3e9+BIF1zutLUHHHW?=
 =?us-ascii?Q?TKFbjL5x0r42IcvthuqvGF4HluavwkY04AFASxeWOtGlKSlJb9WEei7IN4fc?=
 =?us-ascii?Q?DLHL+lSlWV5VfkBL9CwPWLmeOuLRceX0nTelWt3iE6WM7b6x84Gz6NE5Pf4x?=
 =?us-ascii?Q?euwqzkd42liB8GMAMIOpJhAObiegVVkbaFK3j+0YPT0tRD53vXbkP6j8tg04?=
 =?us-ascii?Q?bMl0sV72jy9rC7VRQ7mgXdN7NoyqquHQxJRDFc+mf8vwH0ekTy7CT8lqKEmY?=
 =?us-ascii?Q?LuJ+f0Tr2cuIlLIDgbfXLBzL0fSf67G+RTZ1JjJacDbtPv6mR57IthHlLFIY?=
 =?us-ascii?Q?d83+KapNn9GbB7tmDeexUe1h3NRnG0t+Nh5OgsXFSd8uUc6u4C72E4Wo/VRq?=
 =?us-ascii?Q?6/Kkbm0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4707.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?IWtLOlyJUFXNpG4pCW7JqzmPUd1FJg7E5u3kXoWWAMPqKaqXLwm31PzSkIgi?=
 =?us-ascii?Q?QJr6m7Vmhce+N2PrSM0/wFQ8lCTBFmW/29THGON25siy92MLQAtn5c90MuKh?=
 =?us-ascii?Q?f8nAW4MhHsi35HuDwdndhtG4EIKzixBQnZDQqlhwjaISj3ifCgMcKwKHnffh?=
 =?us-ascii?Q?5Y89elpwFxdk6gnc3F7nHckmceLwqYwzSxEz7ChEWE5Lx73hNHxih1AN3ufj?=
 =?us-ascii?Q?4OEEoUBh1xWUsJNfmm6KQZGRepSgiTaOZ0+VeP+IdKNYtiv718rFc2Mpg1QC?=
 =?us-ascii?Q?BSa13OtHCW/pEnj1xj+ByPkRjRqxDtztZgzqfXCaWoG92ILgF/N8/AHtNMWj?=
 =?us-ascii?Q?ZQHVBcxlxwomKB7A68Dd4kssRm6vNBBxktdbXZ/baXBtUU8trKiLLna/l1u6?=
 =?us-ascii?Q?KNGN/Z/4JnMStww7qIEcJpMIMDLXMCLu9ZaUCep5B8KGZV9oVh/z4p/rCoUG?=
 =?us-ascii?Q?Pxf8tCvuVvPwLUHTBrUYPX42+x63w/OstkESgA5Mb+v02+tMx7RzoZa9wpwp?=
 =?us-ascii?Q?fPN6pYGHaYc5CtDZCzgDaT8z43PjNrBoNFQ+mrwmNZZ6qkBFP+tZijavhXko?=
 =?us-ascii?Q?ibMEzWwA1cfsSdqU2Kh/9TgXd5yYC4raKFzPZ6w/3IYhM952YMecJCiHxHlz?=
 =?us-ascii?Q?lDxf4ROfyHz1MVswgwCDNa5ypG/XmhlSf59EK3U8dXWg5sjwATs3bNhlG/BN?=
 =?us-ascii?Q?aRHyqe8XozARP+PMy4LBlwrwN+kp5d6PzolQU2RdTsjuNV+bbfi6Crnnj397?=
 =?us-ascii?Q?3hQtvT7Frd0KDgB2FluMxxEEd4H6YUI9FiiC9n8e79rTdCDIt4hh/bhZg4c+?=
 =?us-ascii?Q?49HJbMyga5RjwU1tqGcZlawAgQi68Kq2l9My7Sdge0mrS9qHheXVTqRkdFnz?=
 =?us-ascii?Q?5zYEudfIMO+ExVSnrqu21jd8AxpeAm101JiUGSAWRLkMUD6UlBG7SUHYSoR+?=
 =?us-ascii?Q?fNsDr3fN1Ssw7207mdinu6EBgAs7+dEQz8l9L+ESQywDrYL2HTxfg/oVPsla?=
 =?us-ascii?Q?yKOP1Kg2VGcUI2PkkG37hQMCdB4b/1nW6w3Ngh+fN4+Aj+yHu2JeqO2/Vf1N?=
 =?us-ascii?Q?uS7h1h/DZQqZ4BWzYzOo2n4+V6TarBoBnkWETYzmqZOBVb1JLHkFfModD6G5?=
 =?us-ascii?Q?skyB7ZInXX1tJgrunm3ceV21D8mVC6h9y5k+eUl6JhFKbtPU/p4DH4LPMEcT?=
 =?us-ascii?Q?ZMwDEyeBQWQ85K/C/8DAorOae4zGwfoB7wntb9u7jEK1xYsgT4mzZbPoQTF7?=
 =?us-ascii?Q?MgXBvwoQHfmIYzcoZm2KX37kmaIFlGKc1CBq89AZxHU0h7h3SvKDrRT7zKrt?=
 =?us-ascii?Q?tcX+oYsF0XL+Y3qWVW2sU/he571rblEXZjlV+IelRhTtnSTd0fLM1/435oWd?=
 =?us-ascii?Q?/BrVS3wBfTmEYGV9Rlbo0grwYVdP6E579yoR9E12pzjzJ5v/N/RG2YNroFEN?=
 =?us-ascii?Q?V06Dbi1TLxXYAN8m7Pwx8k6m2BNbYtJAbfu5Yssu1XczCDza9mjqKeL98+X0?=
 =?us-ascii?Q?GntbQQznR0tYlL2FMlaRupvtBtP84ZpGOlwNFrypYuqNYkVpaRKxphVcca/8?=
 =?us-ascii?Q?A0nfhqtwwvJjuIggqbjSI9BRbX6JBsgFfjSl/i2N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4707.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc19a5bd-b99c-4e32-a3c9-08dc68f6fc1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 09:21:58.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSS+zKecTeP0NItR2ogPCuoIneZjHwUSmUigofK67NbHkEQSRKTUgTePCmMRya+1smJ/8P9wHM0RRffE/KJE6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5784
X-Proofpoint-ORIG-GUID: CfTm_nJjGJc9ZOgwQ2HlsVTVwFbPjowh
X-Proofpoint-GUID: CfTm_nJjGJc9ZOgwQ2HlsVTVwFbPjowh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_04,2024-04-29_01,2023-05-22_02


> -----Original Message-----
> From: Herve Codina <herve.codina@bootlin.com>
> Sent: Tuesday, April 30, 2024 2:07 PM
> To: Herve Codina <herve.codina@bootlin.com>; Thomas Gleixner
> <tglx@linutronix.de>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Lee Jones
> <lee@kernel.org>; Arnd Bergmann <arnd@arndb.de>; Horatiu Vultur
> <horatiu.vultur@microchip.com>; UNGLinuxDriver@microchip.com; Andrew
> Lunn <andrew@lunn.ch>; Heiner Kallweit <hkallweit1@gmail.com>; Russell
> King <linux@armlinux.org.uk>; Saravana Kannan <saravanak@google.com>;
> Bjorn Helgaas <bhelgaas@google.com>; Philipp Zabel
> <p.zabel@pengutronix.de>; Lars Povlsen <lars.povlsen@microchip.com>;
> Steen Hegelund <Steen.Hegelund@microchip.com>; Daniel Machon
> <daniel.machon@microchip.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> netdev@vger.kernel.org; linux-pci@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; Allan Nielsen <allan.nielsen@microchip.com>;
> Steen Hegelund <steen.hegelund@microchip.com>; Luca Ceresoli
> <luca.ceresoli@bootlin.com>; Thomas Petazzoni
> <thomas.petazzoni@bootlin.com>
> Subject: [PATCH 07/17] net: mdio: mscc-miim: Handle the switch
> reset
>=20
> The mscc-miim device can be impacted by the switch reset, at least when t=
his
> device is part of the LAN966x PCI device.
>=20
> Handle this newly added (optional) resets property.
>=20
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/net/mdio/mdio-mscc-miim.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-
> mscc-miim.c
> index c29377c85307..6a6c1768f533 100644
> --- a/drivers/net/mdio/mdio-mscc-miim.c
> +++ b/drivers/net/mdio/mdio-mscc-miim.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> +#include <linux/reset.h>
>=20
>  #define MSCC_MIIM_REG_STATUS		0x0
>  #define		MSCC_MIIM_STATUS_STAT_PENDING	BIT(2)
> @@ -270,11 +271,18 @@ static int mscc_miim_probe(struct platform_device
> *pdev)  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct regmap *mii_regmap, *phy_regmap;
> +	struct reset_control *reset;

Please follow reverse x-mass tree order

>  	struct device *dev =3D &pdev->dev;
>  	struct mscc_miim_dev *miim;
>  	struct mii_bus *bus;
>  	int ret;
>=20
> +	reset =3D devm_reset_control_get_optional_shared(dev, "switch");
> +	if (IS_ERR(reset))
> +		return dev_err_probe(dev, PTR_ERR(reset), "Failed to get
> reset\n");
> +
> +	reset_control_reset(reset);
> +
>  	mii_regmap =3D ocelot_regmap_from_resource(pdev, 0,
>=20
> &mscc_miim_regmap_config);
>  	if (IS_ERR(mii_regmap))
> --
> 2.44.0
>=20


