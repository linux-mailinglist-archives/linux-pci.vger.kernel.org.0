Return-Path: <linux-pci+bounces-15093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7449ABEEC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 08:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39FCF1C21038
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 06:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD3914A0B7;
	Wed, 23 Oct 2024 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HEW+sHHH"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6EF14A0AA;
	Wed, 23 Oct 2024 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665474; cv=fail; b=FLE2LxnXdPdkPlVjmd9Y5Igmm1d+LySLkeJCtZOgq9uSytxTSqGXRJBeJeXQ8//d9bw2qFxhw002ilFb5YFCwRyzHGxzSHuH1m4Yrzr/6d3osAqq8AnTyZ5J8x/PDoBlAOvKyw2msGstFkyY0QUiFWpKTJnSa9nvpvDbQCoZe8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665474; c=relaxed/simple;
	bh=BL538X9Eh0aQFwuKJjZIfh5zdIpdSUZR/9tmeV579Nc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lTtPHF7d0G6nRWrjKBDTEzIXzHeRrxV5kjOYXlhoil3t5ZJJfhfNomeM2gmvKL36Tb5MrkMlYCVGwywIeyiz2m6qWEgF6U986qtsR9OaN2WUTR7rO9j/e4vsstZ+lzdyvYjqwb+O6w2AKZNzISFKPtsaw67NFsMRP4kxGhd7x4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HEW+sHHH; arc=fail smtp.client-ip=40.107.20.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wxy5Ydk+cNBS15dy7CCh0Nh8Uft+LDAG7u1rlm8pzAYoiZE6aPnPs9FmoWP44OD35mSBUkGvd6yD/zJspt5vfbAsA9NUPASIWo1tYF4APFP4zAao0hjSPyvz3SyerWNyLuG9YE8cCkK5zh5oyFj9Qn1Z1uQteWFbgna7zOQfrBzM30u8laaMQFXClXsZKnPULMS9p8n25umXaqXtTvdqnu3cg5CwogtmXet5Wg9NPQelNaNx4lKYoFo7tEaHLsLDgZQnZinF0GeiWyIwwzZRN4SJ5owQ4IFplLg/5Jj4g33ITLuoGKleyUtfluv+jmqOL1oocJdYdbv2ZH6/x2g90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BL538X9Eh0aQFwuKJjZIfh5zdIpdSUZR/9tmeV579Nc=;
 b=U7QRjm5wVPEcwf63aZV7LW4ZnM3w00cY5GOVEmtDyET1WIflY1x8frUaBFtEzUmXBAIa4GFIEQB+Qtqi5QxD6EmCssV5d6J1dyl7AVYsX+4LSahbMm++AtkUyHX6DOjc0PnN3Mi6OwlHtjW2RfEqBJonGKboQ9fpHeUAzw7gZUpZECK9jr76PqY7lpm0+VBJPHxz5ygpAS4RKOo74LZAC4OToCeNGFBf42F9dcvIQ3SU+qOfv3nHhyJgIjBIm0F4ai5ZllkzIxm8OErW+/n9XfsYYLYQtV3sI9bTh6K5Rrwawo5+6m2HK2BoGOPnPUkwBfVt+L34Qd6iK5IyrbY09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BL538X9Eh0aQFwuKJjZIfh5zdIpdSUZR/9tmeV579Nc=;
 b=HEW+sHHHeJzIZ4pP+v1Z/YieQIib1sWtnVpuoBDoj4r5AHmAL/9P6OMKZXvpFTcRY4KAWPIkIa28oaSwCaRRfIO83L3uysnmm7GgDWlVnmImK121AVtb5/696ZdPgrehLdqcK1vl24eALbDBoVF1cOdv5y8GMV7b9LPEflWjksOlvucqOgTn1EWNnZqi6OWEX8Ss4ujrveuHeo/YxxoYRdZNCl14ZISPxuwhht986/1Wi6wA6ugafpC+ZqPPO808+ZXuMBw0m62LHnRcxX6AoXVgf2waG5pftMycSzQ+E8ZvooW5b4mDvy9/ZbPVG8IEdg3wndA8riuydIOGPdtWVQ==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by DB9PR04MB9867.eurprd04.prod.outlook.com (2603:10a6:10:4c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Wed, 23 Oct
 2024 06:37:49 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 06:37:48 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Topic: [PATCH v4 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Index: AQHbJEjRMaGd/16dp0ueGxJYDqbmkLKT3vUA
Date: Wed, 23 Oct 2024 06:37:48 +0000
Message-ID:
 <AS8PR04MB88497C3155127C27C2C5A9DA964D2@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-11-wei.fang@nxp.com>
In-Reply-To: <20241022055223.382277-11-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|DB9PR04MB9867:EE_
x-ms-office365-filtering-correlation-id: f4ce999a-da10-4184-6411-08dcf32d362c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oixWGAAoSOr1/uEgfDiGXXsioUj2sFOIViRs6410V0K604DhtWX4hN9YX4VH?=
 =?us-ascii?Q?rcgmuAZWAWcjhjIvPADD8jxrRjVfaAXMXEmMHHe0k4aj7IUoKCu/gq2TKj6/?=
 =?us-ascii?Q?mVq3IT7V/Meu6wa01vcE1wmuak79RXKhWU010QKKxSD5IWOlTSOvI2FuGxlv?=
 =?us-ascii?Q?MMP5JQ5B6kNeuhcST6c2eNj8wgXmaPUBsX5/ogzhIUeUfRfkbM1GaZjARQoz?=
 =?us-ascii?Q?hYG4eIjFU7glPsVRYX1PqbMW+6UZif2WOS8jEK2Nh+x6M+t8ANbrCvz8BQqU?=
 =?us-ascii?Q?LLPWga1P2l98RSnyTrFHuQwtO5E4AKMBgOb7RlX66Lcf/wcNjT9CirqM3dEQ?=
 =?us-ascii?Q?3Q6yb5ddkcQuUTmGMkyyCQjZBOF/Th2Ck9TTXDZRUgRVryY0yPANHKN7U5/I?=
 =?us-ascii?Q?CJaULudkvV2hrQd4CWqJheIcpNBr5eazNQ3LrEIu8cgq8YDNK7odahtkaVqe?=
 =?us-ascii?Q?LJEa2zJqmOC78P5/iwO9osQoxgm5mx7OcKmvHMADjBRhOcJkh4zS5kzN7N7U?=
 =?us-ascii?Q?rhQZ2Nk6UA9+mYXBvHmG0wRI/KKwXfhU/QNdQ/JpvDEyHLaSe3G/L2XKbB3/?=
 =?us-ascii?Q?Tnw1sIVCKBGLjMLE31KdOYyyRzH65LtnbIyE5FwcPzbX/4t/G1eL3s2nXqkY?=
 =?us-ascii?Q?mQ43IKIcg8dC/7hKcUQK+z4ddVz5TfFgAtocxlvc7xllAogz2ISp4ZxnHduj?=
 =?us-ascii?Q?+hdb+iOm+7WF4K6h+rT5m3xL2xcaNUFmOymOx+7s+2jjLwQu1jm9COOiZw94?=
 =?us-ascii?Q?qoVCxZYR8k18KFZ7rwy6aVmlLvKXKxGUbf0VVzTJnDy3XSoXEevvdcT2iKS4?=
 =?us-ascii?Q?xde93FuaP0vS6yw11ChtsMTl6RGmw8dAu2EVDdUvGy1VTIHVXTZNvXmgkW5A?=
 =?us-ascii?Q?vvcePxfhsJ3tnJ691XB8zBWPj5DdiYCtHOjzbwFRvh0j8nd7AN7co1m781P9?=
 =?us-ascii?Q?3biEwGGunQdwbvfKI/JFJ5gii/V4bCgC1bo+NgxQiPjmUjV4jDcMn/eDqm2U?=
 =?us-ascii?Q?m3JUQ/0AdJvqWswcu3t4lkPvUEpSTEvhlWquM/LGVOHOVxSLP+UuwKgtqqwv?=
 =?us-ascii?Q?UtXR70Al20WX1HKL7i3W7T5iJH2y5tMU0z6frVWIbWzQhy0/t4buyU+5JyVE?=
 =?us-ascii?Q?dg5MSZq/Xeytod+5pKGVYoi22mKrVnUEeY86D2U/0c2dKFsEJNGOuxuoNKg+?=
 =?us-ascii?Q?i/kZLwgkufmq44gZgEc6XioRbyzuVhdVr0gO2dh5+1u58hWJXPSjtnCKeY8I?=
 =?us-ascii?Q?3z78BfLmTt6bu6C295PwMykVoH9IoQeLvQyTdTfnvvCQ9h4aTYIkG8SAqxo/?=
 =?us-ascii?Q?SKpwTmM9cYA7RVdTIf70VEk7sf+oQuagLRh2ypRZaZSUx4mnX6CBidUywBcM?=
 =?us-ascii?Q?vp0WcETD1ihIkQHFh6sjw9qBAVFv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?85P+vEh4ymNf6PsW/+ifMXVRqhz4kzys3bGsMwONLIdVCe9aDSgfGa7FN4a5?=
 =?us-ascii?Q?7BrisVpAk+Mh4qnKxti4yiL+3yJMDKwPbbW4p0q4pSz8fue2no0SQuU+6qzA?=
 =?us-ascii?Q?P7ajp8DB7+PFqpZWFH+ssWUNX5VV5VbvhWwPR5i8St+M0N+9UZM2eORzzTzY?=
 =?us-ascii?Q?oiCcg4a1Gb/yDePpQZD/mSW3ZRehqNVZpUlD0r5xjDaZOfvMcgoNqshi/NSe?=
 =?us-ascii?Q?InmKq5qxNrTZiC/FSgtMAs6iOmisMlBcrjd4d0zUh2KIaP+bWUOsPiceo2oX?=
 =?us-ascii?Q?tI/43T0UBXZU7ymp8NJqsobNRDtvmgMh0j6GPP2npLip/ff7EcFNFv8mDNA6?=
 =?us-ascii?Q?d2woQWgl4eeC3zH0daocG3hSYxZ+rp0IzQk0BOmi1RsikmbqT/4pGFocegG8?=
 =?us-ascii?Q?WfpktEJCHm8jBt70gq06h5RMl8EbIPmfjrsUiHiXIjzn3TcvsOlTyhXiOSvW?=
 =?us-ascii?Q?P/p1IRBTn5hcW15qqRIC538LcHjENKkhSJnzEaljslk/Mi0mg1GaCu820vM2?=
 =?us-ascii?Q?OdJsIkmveLteAYgmhLmakt3/lKdjQGDGu0bBCeqcjGJ66Kn8r85XusquDAuK?=
 =?us-ascii?Q?MIXvfMrSda6WGit3mpf+EBcsuwRa0C6NueK0GJ1SPHzKQC8/DhMfVpW3uMSY?=
 =?us-ascii?Q?RbR8vmPts781+xRK4rKD2APB4k/QN323WxszmAy0XcS8Paxj6tUyExjPKoUP?=
 =?us-ascii?Q?IclTNTb5l5uNwJQ/pxDYRz2K62I/bV0OSzyEuvvN90lH0hjkF/qG5u8uHljm?=
 =?us-ascii?Q?ne0xlkkPBefzaCM+dhLcOVybYmwi9XZxCeBvA8xEC8VtHp/66jMGhspnZSxF?=
 =?us-ascii?Q?TA6HW7MIz2w0GJFIt+2uEhmGqCe+uucKYmstv9q9+N8qH61sDale8Cxh3vIC?=
 =?us-ascii?Q?O1JhSWL8Kht7Zppd8v3Bd9FKyQyK4nDuBvaFqnT4nvst9u2uLksqSvJUvcPw?=
 =?us-ascii?Q?bWeBC6b1TkmGdof2Y3KUQcpphL4rrUoiwH8FONeur8TdRA5VHcmSP/fyoUdR?=
 =?us-ascii?Q?cYqWiLK5guQg1Fj5Lfy/X5oktTecv7KbvSa3aEu+IeCPhuU9DZTwBfpm1H2y?=
 =?us-ascii?Q?IDwhsdLQVbu6CATeJIyLFjBMNRy/8LbAubXUSOHncoAHNA4D5pdkKPRc0+IF?=
 =?us-ascii?Q?o8xQ0d4GrKsla05cV2W1vfTQiUM0ZMuEMxUD2gW+5wMsBDjxjL3xaZcZnaPH?=
 =?us-ascii?Q?YyepSxlTXpuLpCjekcwkpSNV6zOUPrtv2WQ0V8/cQ/a3yASArjnbfSBWgYkb?=
 =?us-ascii?Q?NmlrU9L4F3wog8xRSdY+AhsyyAxfiOPTGxzajpHGObJ3QB/SMos+MeSjpzIM?=
 =?us-ascii?Q?3QhHYZwWe/bbkXhJZsjblMYvyGFmu/oR0wkcGMszWCL5Y3048sTGL3ZeUaA1?=
 =?us-ascii?Q?aEImN8Ujq+RQIrb9YSBwdoL6P9grJfy7NsJddU34wVrZ3qynn9n76MxvNMr9?=
 =?us-ascii?Q?xDQllWauMRsaI/6BQfag7xKRm7Qib7CHIrAE/iAwkZIMRGr2DLuSSLPrjlB8?=
 =?us-ascii?Q?rIo+IPCgVumhcOf8IUPdpkq1u15rbxlX8PdEHVmpzQQruO3Xkjjz/GxOP5Gy?=
 =?us-ascii?Q?ycAjSHKX46lOri4Z5RBqlDXfxPBob3WCJEAx3mgy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ce999a-da10-4184-6411-08dcf32d362c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 06:37:48.7617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hP5ESibZgY0UV8E8NkUh3JMnu1HMPAuP8Sm+3+IgHC10rB1Tp8/rz7RzAaGadsnNTgxKBe9JcDd3xtm082baSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9867

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, October 22, 2024 8:52 AM
[...]
> Subject: [PATCH v4 net-next 10/13] net: enetc: extract
> enetc_int_vector_init/destroy() from enetc_alloc_msix()
>=20
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
> enetc_alloc_msix() so that the code is more concise and readable. In
> addition, slightly different from before, the cleanup helper function
> is used to manage dynamically allocated memory resources.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

