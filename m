Return-Path: <linux-pci+bounces-15262-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0129AF824
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 05:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5331F2261A
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 03:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6245C18BB90;
	Fri, 25 Oct 2024 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m3y+h+Wi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37D418B484;
	Fri, 25 Oct 2024 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826840; cv=fail; b=OewRS4q7ipB0C9B0uT/Ul/pdIDxfJkmvU0Q0SGlHuIjc2uXqyPKATpmu/ZCXROCfUKBOxdQJWwh4PXksEkEUv3vQ5XZKolVIRGkH0b4INsifplOPbCGDnJzy+ZOwPcRmzimuRMkNuf9esvRaOCyCPMVM6vwrYQQjCWYUhAxB/9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826840; c=relaxed/simple;
	bh=NcNgORYf8bAhQaHNrxOJDIsCC13SMU8acZwn91FnYVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FuwCEc6NoSdHUeTEiZVLXDWt6dV5wPpS+D7uGFgmziTYziwUw5sfmQFXyQiUTwaftbHt20fYlDk8BSXuoC8Ozo8tmAUxjTO6P4ejWCRD92tQ5228GI2ooPid3L0MQFohFS4pAHXrcl3/YRRqQMBn7HgtSNoZf/zHulE8QTqwJdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m3y+h+Wi; arc=fail smtp.client-ip=40.107.22.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQNvbwwSPV4MWkaX0z5h1FY/2kgc28xYmC/RVDPYF4ustA2nnWsduuvVqRomdnYWQdJFRKLTpYSwxTFVDVsL+jEa3Uf+YKeNT9NdxYZ/x0o1uYjTAxj3prodJmD6rPq8+0eDlbQVJ5m7JMd0rPCqse6Qc1RRubpYv8/WMUB4HUtDe0jAAvk+YOjswxnRZNCz2X/k7tE6s2HOSHGoZSRj5xIU5Isu4wst5m1gARoh9rykgmxiYguVwvEbq1CnluJLqGNoB8AsP6lCm8/GDsGACXTuslCHeJ+vWVNq9nB/dx1L3s7ruKmbOVq49nIK8Be0A5qNfhPrGfS3clmrdPak5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ACWz4fSaYhWGxGXypQa6EMx17YbdDCxoJr4NdNRUsw=;
 b=Py819NZf9Yo+RPqbvFeeWYzeuJzdhFZaCZCnj/T1+X2Fk9QbaELqS3lnR1dY9r5wI4dZM9NmdHUYsbK5bJzZ/Fk9TZgkZYQjX5hCbQ+eJqkOVxwDrHfa55KHSTQzKyz6dNcm7zJVqKewhQMUNZTfk8UQDrdc7YVOPvK8zfhwBy6jk7qTkj5pvRiLUqoP3qTQm1DD7X7lgsTfVCjxbXTVp4/oYN3/sO4eKdPCTS2OuKyEDoMZMil4Z8jvMKD5bcsIDVzcgYARDComuXdmVfbKD6Iee067RXMGWzww1d3ZA2FuYwS+kVubVAm2VQZfITqpr0ebTUdGoO1OnDFJy6Fe5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ACWz4fSaYhWGxGXypQa6EMx17YbdDCxoJr4NdNRUsw=;
 b=m3y+h+WioCKSy8Jt2YSe7zpkCUAlibQdE9ENFdBjuwrpB/Z/LFGT58iakk1iBFnGlNZmpCN1RqCgHOVPal85XEXu6aJLEViO5MK3OWmnYdtY6Av1awxxgMjjsKGhuB5/bsWXtYbvhzMHRtuoN0At0NABppHE8JHTEjzVlZLkOZkpMSnMJeRYKhwTMjhDK5qPQmAW1QF4GHcpB4qNjgjsYjRwgMjFiIFoDDtOo/ZVKr+opnT2ELOK3J9NYHkHWqzNQjCz+zvXwRYksq9r5qfRZ9ZV0Gx1sRqiSmTrEfPdq9WqC/LPxb4HITt/8WjrktIXj2zwOuM0Yg1MhpJrf8AWwg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 03:27:14 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 03:27:14 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Topic: [PATCH v5 net-next 10/13] net: enetc: extract
 enetc_int_vector_init/destroy() from enetc_alloc_msix()
Thread-Index: AQHbJeOysCPGy3kquEKsxzByUAN/5rKWYN2AgABuaNA=
Date: Fri, 25 Oct 2024 03:27:14 +0000
Message-ID:
 <PAXPR04MB8510865086A2629DCF58B20C884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-11-wei.fang@nxp.com>
 <20241024205013.xw72mtssgvmwfmuu@skbuf>
In-Reply-To: <20241024205013.xw72mtssgvmwfmuu@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7348:EE_
x-ms-office365-filtering-correlation-id: e0c2d0b1-c939-4c19-a24b-08dcf4a4eb71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ufy3IoOxPg2i5AtktNzYJd740+NHQNF4Y9ZmyqSL2Szwy2EcFCinAAPTGF7l?=
 =?us-ascii?Q?LRxIRu5xrmgC3VVSvi6MMB16xjnW9S1j3s01vylkSvYEZVEHipVmtAcfdioe?=
 =?us-ascii?Q?ae5lYIlN1UfdpFSTZygmi/fTCoEeZpszoQVBcohceuYinivwbiyPufjJ7NuB?=
 =?us-ascii?Q?++tuAgNNUMWeXKoEHneBD70BgdKl4XM03njfFLfhBoT2Zf37+XbR0GpK14cF?=
 =?us-ascii?Q?VpsY50/E7It16ynEPJBMxMmAb6x69G7ywHMq7swDYbhNem07DQY2mu+tFKEd?=
 =?us-ascii?Q?5xpF7Qjb6u5Bjk9Ov4tgspUR2od63IRQ5P3GQPBCfN81Fzc1jsSafVMV5I2N?=
 =?us-ascii?Q?oX7EVnBeIZCYdTK+PQFPHH0uae1VSOtu8ZEYkzZxKNtlmh5DrnhJY3BtCwew?=
 =?us-ascii?Q?olKRBexcnLkBUPpQVRboNILPk/QFH0Hhyx/lGBhRlgUiPPjXNx443VOT1Byj?=
 =?us-ascii?Q?quFJ0K2cybcQK2PJDE0EcoE/+3R7dtXU0UVg+WXE3k1I4EBUbFqKL+jpCCFZ?=
 =?us-ascii?Q?Jr9cnsEIiqZGVc7xfBN23qXi9qweZTu+tTNSTON/Rq2pk2QSo2GSu+TA2MtE?=
 =?us-ascii?Q?rIqUAMOh62a/m0zaNlUyt6/vQAeLJUO1q9HN+LmU2YztzjnqTl46bv1ZQjBm?=
 =?us-ascii?Q?7e9sISn7lktY/lKS0O516uNNq45dliNE/BRqw3R4Isldf77KFg/8hRxQ0LlR?=
 =?us-ascii?Q?UroD7EQxkWkw3FGUtDXPeKSwIPmWuB9lSotQ4cUWRKUsh0lySHgUp/ksYDv1?=
 =?us-ascii?Q?60il3/qygxITd/6R64tNugLftD6IEcTD329t5jsz25ecolhgdmVOTFUorf2F?=
 =?us-ascii?Q?vqjD6PvvtpRdaaA4/1j6833rpMDSHofQ9gqkynhBRPxd9M4EyZk9DDVe2ux2?=
 =?us-ascii?Q?idwFMzvZQzm5clXfQrOQJ8BKsH4yN53VdtZRRJB4mO27//h5M63qWKvguqDL?=
 =?us-ascii?Q?iWTbhEyjzirxsh5uudf3lhhEEqAh8VP3swxmAKCLuaqI9d0dE/ZsvDWQDrBf?=
 =?us-ascii?Q?9X6t+Hp5BbnCdSAaYg49zxWNjeTRjFjK0SC8x+bbGc6ueuWyBe2tNgvehUd6?=
 =?us-ascii?Q?vkYEuMj6rvbuSWkgpkImMKh6dK7lXMAXyJqNBdkjQTQ7AwPXar+BSdHB+Tnv?=
 =?us-ascii?Q?/bPQeDiuQFkMAyHPtrqkYhK0AcuzJU2PojZi1NdL2JCDgEPBwYMC93Z6E/CF?=
 =?us-ascii?Q?tfZwC+/6SJzTE7foM8SayPuBHa10Du3nPHggZgL0aPTupBnPXS9fbsXf1FEx?=
 =?us-ascii?Q?7xykFPWcjg0fkKzFqJmw3rXr5qXtx0pn8a6lQ70A7SXzHg5hDJIoLVuUnmrW?=
 =?us-ascii?Q?fVRojnlGnEKMBFizeX9AL5mq68b7Vtc/7MNqOcgYr9p2p1NPc4OnhwEiXkCR?=
 =?us-ascii?Q?ca8xVA4=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uTXyfZWAFqu4XC7pss6F+Ml9q4Cm7gd+1myFoiUO1I9LVvJck+l5MRP7Pjax?=
 =?us-ascii?Q?2aOHROKJlsa/37aVxperHbvu3ngm2bfaC/z8IvGJUF3yqftlhNju2PYgiqEE?=
 =?us-ascii?Q?Chf1HiQ3Btb1OATUShAp2fQT8FTVENzveQcAfvWRSRoVYUKnIyx15yOQ/kaZ?=
 =?us-ascii?Q?6/q3Ug4UjYenC6dVy9Crk9iCqnYxTNQ2LJdU47wjm2z9Z6fL6H4QjmbDcUtc?=
 =?us-ascii?Q?NKmn4452IPm7677OCkkGQQHuDkFqHwgBOH+3J5UadVa1G46ZJgZgijsgylVd?=
 =?us-ascii?Q?RfhvjNFGttPSAHTqGBsdAnQpgnDbzCG5Lnmnm7vHeSrAmlE+Zc3oAmFaX275?=
 =?us-ascii?Q?00HBC9spxQ4pt6ngZZOyqVauKgG+uJkV9IEfw3Sj0Iof5XagMjifJ+JArkQG?=
 =?us-ascii?Q?9nZvGlYtGn24Tp+p26Z1/5tBAZsKacgrx7cvHtOKoG1ifZ9Q9ybJZhH95KIK?=
 =?us-ascii?Q?OiuLeR9U4yZIRdGyvrknQc/pQfDbVZeJGonY9lrb3HuSxhyoLa8NOotzfrS/?=
 =?us-ascii?Q?elju3SfNbK5VrRwxDlpR+PifvpDpjx9tVOKgfWmEm76Pdn3nI+z4ePRkSwK8?=
 =?us-ascii?Q?6wQdna0L/7OOolf02Pz1ITZwiCVqJHxEYrVNYmGL3xWn2fOggGhmGhxpzPxY?=
 =?us-ascii?Q?haid4H4YrqLg68gzihUaN3k0sVu2U4JqnbSxZwB/K9AOmzvz+0qhTzL8SN4u?=
 =?us-ascii?Q?vCt55pix/J3K9mOM4nYZ4eo4Lm14RjJ68B1fOHiyIzXs+rA4KqFew/RKZ0wY?=
 =?us-ascii?Q?3lqXuqGDFgNL+EoZ783EwRN96LmK1JAeQyGBpxk7YrRvkl/x1BWz+DS9V++s?=
 =?us-ascii?Q?utboqARycQUyLpMea0UbXpbjGCdyHf7xpNfuGNhn1QKJ4UqF94YEB4xahrJT?=
 =?us-ascii?Q?R2t/LDnzJfsBongtq8kNt1EN20cTVM0IA67D8b96MXt8zqvwEzrN1Gm/BLO5?=
 =?us-ascii?Q?p7+lx4NMsuTa8Tu1KQ9DakLJrOWG5dIL94OAKsYj5y85wxyzRPrYx1ossjFc?=
 =?us-ascii?Q?b8K7Y1LWm/MpukVqBQ73AY+YIKMzABizIKXlszKROBv8W7szzIEbfr7m5BYo?=
 =?us-ascii?Q?09d2zIf/H7qwxhqEHbZltMH0v57EWrx1X85/eXVFzmby/33c4ZhJZFRwI9d0?=
 =?us-ascii?Q?ZT7k2FpxAes5oHZmH5LZtJoJJAjKQnyObgHae1LFIbVsflEidH5PUZZVyBLJ?=
 =?us-ascii?Q?MCkSXv+yhRL/GFZZsC5R4hxjBERduIJdUm8Vbjy/78Y4NxmODHXtiWjdmvuf?=
 =?us-ascii?Q?xBlA1JkuO7mx8OEiXH08kvcuujXHc71VDh9ELdWaoTfjX5y/wH0u/x1WX0zE?=
 =?us-ascii?Q?VH9gr21UvnJxDdJfQoGLaS6JeQxLUh0/lm+w+yxt0wSzqjJLMbC3CHNjBGGu?=
 =?us-ascii?Q?/10wHG+vz52wgivb3veypO5+XbCRK9FoMmXYOiZjUGGyDJOIxuKlGDqjvHj+?=
 =?us-ascii?Q?J2CiObW/AEjTNiMOj0Mysm1wt4lhj6TFeKWHmcfap4xHjWFvUHDGdwxAc8qS?=
 =?us-ascii?Q?qGYk5XE1ZJcxRQOFF0nHFmKT81NXv7knQbe/IpE1h81YTa3oCC4fdu/ton7S?=
 =?us-ascii?Q?n8dwzxcPRZ3bjnU9rAU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c2d0b1-c939-4c19-a24b-08dcf4a4eb71
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 03:27:14.1057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dpZSCM8TAA5ge+1JH6VMisyLDS0VJMDgTRaTgy1SW9Q1aY7FENf40KFdSpdhLnTxUdXa7FKOMg2FZbteUCQZyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348

> On Thu, Oct 24, 2024 at 02:53:25PM +0800, Wei Fang wrote:
> > From: Clark Wang <xiaoning.wang@nxp.com>
> >
> > Extract enetc_int_vector_init() and enetc_int_vector_destroy() from
> > enetc_alloc_msix() so that the code is more concise and readable. In
> > addition, slightly different from before, the cleanup helper function
> > is used to manage dynamically allocated memory resources.
> >
> > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> > ---
> > v5: no changes
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc.c | 172 ++++++++++---------
> >  1 file changed, 87 insertions(+), 85 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 032d8eadd003..bd725561b8a2 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -2965,6 +2965,87 @@ int enetc_ioctl(struct net_device *ndev, struct
> ifreq *rq, int cmd)
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_ioctl);
> >
> > +static int enetc_int_vector_init(struct enetc_ndev_priv *priv, int i,
> > +				 int v_tx_rings)
> > +{
> > +	struct enetc_int_vector *v __free(kfree);
>=20
> Please limit yourself to refactoring the code as-is into a separate funct=
ion.

Okay

> This function does not benefit in any way from the use of __free() and
> no_free_ptr(). The established norm is that the normal teardown path
> should be identical to the error unwind path, minus the last step.
> Combining normal function calls with devres/scope-based cleanup/whatever
> other "look, you don't get to care about error handling!!!" APIs there ma=
y be
> makes that much more difficult to reason about. If the function is really
> simple and you really don't get to care about error handling by using __f=
ree(),
> then maybe its usage is tolerable, but that is hardly the general case.
> The more intricate the error handling becomes, the less useful __free() i=
s,
> and the more it starts getting in the way of a human correctness reviewer=
.
>=20
> FWIW, Documentation/process/maintainer-netdev.rst, section "Using
> device-managed and cleanup.h constructs", appears to mostly state the
> same position as me here.
>=20
> Obviously, here, the established cleanup norm isn't followed anyway, but
> a patch which brings it in line would be appreciated. I think that a
> multi-patch approach, where the code is first moved and just moved, and
> then successively transformed in obviously correct and easy to review
> steps, would be best.
>=20
> Since you're quite close currently to the 15-patch limit, I would try to
> create a patch set just for preparing the enetc drivers, and introduce
> the i.mx95 support in a separate set which has mostly "+" lines in its di=
ff.
> That way, there is also some time to not rush the ongoing IERB/PRB
> dt-binding discussion, while you can progress on pure driver refactoring.
>=20

Thanks for your suggestion.


