Return-Path: <linux-pci+bounces-15389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E519B1450
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 05:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388381C212FA
	for <lists+linux-pci@lfdr.de>; Sat, 26 Oct 2024 03:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92D1B13A41F;
	Sat, 26 Oct 2024 03:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m84XaAvY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347C0374C4;
	Sat, 26 Oct 2024 03:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729913097; cv=fail; b=lKDINYM7qBjkrYxLFvnjdyb5w4oMt91cF+gfrw+/Vpsz9pxYiua7fgPAmRsUyCLwU3x53Yo+p+qg7UXQgN8nSXoMIpmMZPaAAoncairMFO5scYHbwA2HpIKcxCj7LGcvmUbVhgtegoVFstgB7qImIT4fzLZx4bXT0Eu9tACgkbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729913097; c=relaxed/simple;
	bh=WRizxiTiTkUGpbSrIHhP/Jy5vUzlF/rFIbrYk6CAbxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ELoj5BGeGAL1jcygsmXv/6x2PsTJJVQowsGYRKl1jINzOhTu9q9FQHT6SGE5Qr3C1QzVwaaV1G2uWSvd5KkD8k2SVEbZAbbrW1MYKt7oaMN962anZbq0UV7fmRFveZL0c6JtNkbrgf9sd61X3uQCyrCSAc9+F3CYpib+fmH5vvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m84XaAvY; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y675lvRELaCqiDG2XCjUjvrK3Ij74WDSHbKFJSh/6T8joiC77hXERjbN8D1jmEWm0UE2fGeAlDKQHlFFA7rmIHs9x4mBs8i7xDlmxVFvLiehRi8RHAsTWXTUrjWXbgH7TwvBI/HylNJqkKom9dyGxnqgaBG9gawd33qRLYtQ/5G7vrYjph33MLC2NxEeI9+OhVYRlJ1nOfLGlkRJJRsIf/LRWpYnV+j06GrO6gFtFJKYrZblyl0CMi3GOWkOjHgMmLQA7uZ9bfN4hwBTLs8MEWxs2egO3yrJ9j9XZuyiUdaKSfsvL/EqQZgxUyy5onJxwtVnarg/A9POnyY5NCVNgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrfxJGVNlQzuT6BSLuiUNz68dY/tAcMMFA33MoX/7uQ=;
 b=wNARCS9RPTZ6Bfd6KZdQgQ+Sl54s4KS5OHELNkBDs8FCFujUro3TglEGB4R1iZRUfrsjBgRo0YTSzxXgpmKOvuhDYH7pD508WdOfeiFs22j1KESf3JFuSUUwQVPd+6eRebrcZ2o1wzKESgn3sFTgE6y7S03aXqRScAdQCGU4TIRD41p5sUbCa5ypBJbh4vLjT9NVrMUipjlCJvwED1eI9xcV5qunTBy3eUoCNvoIvurmqTm7EEiR7c/yTZCnSKcdpXwlqUecA/nVwqe2eVbHyNvanwUsU+kd/ce3viWUDzl5biY8VO0ITuZdIvhLPuKbmTeTq3a6I8ILRn3qifvw3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HrfxJGVNlQzuT6BSLuiUNz68dY/tAcMMFA33MoX/7uQ=;
 b=m84XaAvYLr2usKBP8UOAnrGI/m6ELk2b5G3azxm0J8pQe2NndLJzxkXwUb4w95eQths7LQoyAF7g7LBa7WpfgDrylqiyGLghsQZSLkn4j42vj/MqVFSmrI0MiviqFC0Kv9SQlb/etpYrBYACrKhWfwMBazakHbv+h3KEmZfBOQMnRcAQmzgVW9Fwa0kmh6JFXdR02Q/PL/nTU/pJxyR8YuCA4FLM61Q6AbdyQf7C1KMDGU9Y4fcvJV4rYvdIbEEG47pBxJkgDrq1jI8NCDF+NnJd+FUiXtJ9E2lDom16tIekbhBQyk6vj7QcIIutqx0cLYcfuMFFn6Qlre0aAD9FzA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8111.eurprd04.prod.outlook.com (2603:10a6:102:1c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Sat, 26 Oct
 2024 03:24:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Sat, 26 Oct 2024
 03:24:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Topic: [PATCH v5 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbJeOTvufS9kY9MEKysOWJvOzLYLKXgr+AgADegaA=
Date: Sat, 26 Oct 2024 03:24:52 +0000
Message-ID:
 <PAXPR04MB8510F1E775483E4F6591B7A188482@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-3-wei.fang@nxp.com>
 <20241025140745.GA2021164-robh@kernel.org>
In-Reply-To: <20241025140745.GA2021164-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8111:EE_
x-ms-office365-filtering-correlation-id: 9f57b662-836e-476e-8bca-08dcf56dc14b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BpEosojwGHHsup1Ji3aAv4ltoZ2dKT3m4ebFuBSkhyJrxTh+XHPj7LKvtGcJ?=
 =?us-ascii?Q?Bnh53PTvFKuaAgvnDCOxL9gxy5ncTjB6z0EQhlWOS41xz72aXRlT0uj2yVu5?=
 =?us-ascii?Q?vn5m4vmfzALE3HCtezDAtFXK/YEMPGuSe5vCpSaeP6bmM/rykpMfwZ38Hqyn?=
 =?us-ascii?Q?rUUalYJzLNvmXMIZIl/+KqsVF2tULQ9zWt0jlgBI3R29+4ySxQr+E5yrgs8I?=
 =?us-ascii?Q?i3FVIPAeha8yRS7J7MHbzso4LozMAt3unXqlgX2DWIlkbid5i4pqMQELUZaM?=
 =?us-ascii?Q?POqXL7sOSo5MvIpMzqO0639Y6EiWDxmcCMR7ZzwJR4k8LER0XHSMC6klNrlb?=
 =?us-ascii?Q?t0zANhQi8RN6HcNh6cTNq4FailDAYV0OVBfsX8VgeZr9jap0WTNcGMm3pJYS?=
 =?us-ascii?Q?M9wFHQMoKFqCmN+6WFsCUZdmSrz9L2g2kTUgcQz2BnnP6hU/KAO5Dx2znSGN?=
 =?us-ascii?Q?HJfPSAYp0ZoqgeodHpXazdrYcqduXXRM0vRueI2avgy91yGlVhU5v6BwRU70?=
 =?us-ascii?Q?bjl6QLXGmlc2f4j2zgvg8cqhxftpdFZ10Znwoy/YPZayXv0Fh5YHKb1nKsQ8?=
 =?us-ascii?Q?7xgKFyQtOtAoPuCOW7pm+msOHdUIrXIabR5NYZLf44k7EK1NRPxY+qiJ+bDq?=
 =?us-ascii?Q?ShZiHEpO9QTDe4PP+KThzrJvGYI3ZEvVNSDGWD2jyerAnyGZsLBanK1/sV4J?=
 =?us-ascii?Q?9F/tq/qZTGV4YcFH4tS2g/QjUd/QlPdr2gJW2uWjeo55qvUWov0FW4yr/WEs?=
 =?us-ascii?Q?EfToMOnO51erEYVCe9l82KvcOa7iGp4TZzijIoHHqkUogiRpVhINuPdT+XCd?=
 =?us-ascii?Q?sT7MGf9iJrRF8y3NzMu1PdeC4NgZjwDbubJuM4tY6dyUt9CCiMTN6xHATc3r?=
 =?us-ascii?Q?/vRJEnkeGimcwfx7sz8J6Mdqp2oYIYf67j56Bsad+X6utkzqI/hUvAh9hiWf?=
 =?us-ascii?Q?Nx2SGHoDf2tb6LOeRU01Uu1NHijWXb3uJ//Dhcqyh8GMPVG9s/elsw7lKGUi?=
 =?us-ascii?Q?xzKLVQDIpkZUJrui2OqMbp15p1U/TsFDwJpclEu2FpgBgU5FLqiaObOItS9B?=
 =?us-ascii?Q?Fpw1ancVrHFrNix9JX+lm1zHtWa6ULrCdSqfs74+z8fw7YimjnbacomqL+eU?=
 =?us-ascii?Q?wLGyA1Q9zjUXfYR2XOhelj6K6qmXk8IfZnyR/XMEsoHtG5sa16iAM15Ez6f/?=
 =?us-ascii?Q?O/p73VpnJ3AH1YAOnB9fxJ8IPrV5JEyMn6Tmi22IlO37/iXy4f9Rqkv+fLeW?=
 =?us-ascii?Q?jC+0KnSSaTGUgfdJrFpnnCtsxc26Z++Grecd9KS3C7Z05AW6+YEMUBhG8tMg?=
 =?us-ascii?Q?B78WSQ06QEUfaglRtUfSIE/8TJFWY89O+h/9V1egl/3JvpvYTylbJGFGavSW?=
 =?us-ascii?Q?RBqJzC8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KyxP2kIQKFG11G+YvBr5fYcDh6WhiKVvW2NphxLyaCQDeauDCmDvGUwmNUIr?=
 =?us-ascii?Q?co8jsrA+85PNcUQpqLYa6U35W0dcHxyvpneevugeFwUkmC0AKSedE+pPgBnR?=
 =?us-ascii?Q?cGKjfcUieBvd8rvOE7QN1AF57q1KusFPXLGSeqRCEYkf1zvLxOpiz4QJDeJY?=
 =?us-ascii?Q?pBlmGIeTIR6Gc7AEZO8aZfx5dRc8ZUfE8pEt7Xf43xpiWJ8b5T/+Gp/+365Y?=
 =?us-ascii?Q?UPLjuQtg8G2eSk+ajku/yl65rjiXN//gkUzov7sTU1wwnMT0209BX9DCPRAj?=
 =?us-ascii?Q?E85vkWOGcUMrnX+koxaGXVVQVrJ9Un89uAKIB97sQr1zebYcS3RbjjandlAT?=
 =?us-ascii?Q?C9TdR534VEpRhT0C+y8+WVfG94KaP/eabT2Y9TnvL13hLcnv/FS5TjXS4Lx2?=
 =?us-ascii?Q?X8w+ADF7UsfeiqqQwnb07hW4CpL4tLRj5xpeB+qraWHZc69tf2GyFemzIW94?=
 =?us-ascii?Q?m6OZTtsO9UZgi82D5K1Mn20jnuF8If0DprIQ08PVMAHRDLyXY/bj1TS0jee8?=
 =?us-ascii?Q?IJA/66LXNsDdzYxL7uAfBd6o8pbWhh0SewVSu/FggQZbGNtTTPbGxP+Xsbad?=
 =?us-ascii?Q?5t/ixf7lyztk/cHT2iXLia/bbcOC8YC3Vwcee04ajOGb0Z+mkEtVC7K+t4dW?=
 =?us-ascii?Q?VAvfXqzE58JWtqdICSDnNZMyYwKdGcOONaIkpquIUQG5loWRPi2d50/iLn9l?=
 =?us-ascii?Q?t+fRMLuR30bHifLVqwcFSt9pvn1xDtY7LXwMCXNmo+fnWiyqocSpIcGjLp79?=
 =?us-ascii?Q?8pnwvn1APFUGUhUa/ujTdWjwVuqV/2BEPtaiHyvOMilE/BvR06pxYBj9uisq?=
 =?us-ascii?Q?vxcCxOCddTW4oBsOczkhsfxsFFjcNEpGLb8xWzTGnCwC2g0JW0ZwaFWHduyI?=
 =?us-ascii?Q?+MFQHWqcapnQ/2NYuWyBb5NFqtDwP9fTA7uH1uPvYF/NLVTPkA/p+ubauREx?=
 =?us-ascii?Q?eM/Qqu/POXL6FpjmzSJDkZjmGB3Y1igJlNOIIVH1Al9MyTAEngH6i8dK2RH3?=
 =?us-ascii?Q?rXz6UAChVSzsuE0/jzi0YVc5umtwbPd63V/KLtF5S97bj97e+IpoIxI1CIGc?=
 =?us-ascii?Q?fCDEg5YODEIHg6u7b+xaS29rsXeAW/aRfDPsbUa9XBBpZDRgcL/DEObOPFbq?=
 =?us-ascii?Q?HN1vQQbIOl8C3pDrkc4VYPT0wMDGg5tt6qbYQF4N6DpefvKrTGodZIwxXNb3?=
 =?us-ascii?Q?NDpq7kpih09TTYco5MByHEJyA1vD/6whr0iqmWyoo+CJldqCOrg/jaDCX/uR?=
 =?us-ascii?Q?wQoJCm/x9WERTfJySIyu4SGvTohHEGOXLBhpxmZ+nEoJ6BS0oOfZSmVAAIAq?=
 =?us-ascii?Q?faDqDoh/21CNd8FstKIEi3zGmsg27nDdYgRAstxenFsm6R6UzPiQ+/VZ71rN?=
 =?us-ascii?Q?GoftSCUskxaCcLk2NAIzWPNi1XeBAQp2IQLcpu9uKLI7WnDSgme8P1D84WHu?=
 =?us-ascii?Q?q7T7XXr/PYVwaV90EYIJJ4tq/b/svtyJN9dQBNwBbByy75EGfVK6GlxRYAal?=
 =?us-ascii?Q?PYK/xLL027DEXAEvgG1jhChdlANY1CFtJPr1/38iuk/dozoc9l5iIhfCi5E6?=
 =?us-ascii?Q?ljtEsWvTc36m0KoyWCE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f57b662-836e-476e-8bca-08dcf56dc14b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2024 03:24:52.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JcbtpOeSiR+Ls984Dz3mfWwn3YscxlFLOSETRdKkjIP3DJ8USI/V+H+XcENJnlUz3vcHQ8jTOd/ZkWiQ6z9bww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8111

>=20
> On Thu, Oct 24, 2024 at 02:53:17PM +0800, Wei Fang wrote:
> > The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> > ID and device ID have also changed, so add the new compatible strings
> > for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> > or RMII reference clock.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> > v2: Remove "nxp,imx95-enetc" compatible string.
> > v3:
> > 1. Add restriction to "clcoks" and "clock-names" properties and rename
> > the clock, also remove the items from these two properties.
> > 2. Remove unnecessary items for "pci1131,e101" compatible string.
> > v4: Move clocks and clock-names to top level.
> > v5: Add items to clocks and clock-names
> > ---
> >  .../devicetree/bindings/net/fsl,enetc.yaml    | 34 +++++++++++++++++--
> >  1 file changed, 31 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > index e152c93998fe..72d2d5d285cd 100644
> > --- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > +++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
> > @@ -20,14 +20,23 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    items:
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - pci1957,e100
> > +          - const: fsl,enetc
> >        - enum:
> > -          - pci1957,e100
> > -      - const: fsl,enetc
> > +          - pci1131,e101
> >
> >    reg:
> >      maxItems: 1
> >
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    maxItems: 1
> > +
> >    mdio:
> >      $ref: mdio.yaml
> >      unevaluatedProperties: false
> > @@ -40,6 +49,25 @@ required:
> >  allOf:
> >    - $ref: /schemas/pci/pci-device.yaml
> >    - $ref: ethernet-controller.yaml
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - pci1131,e101
> > +    then:
> > +      properties:
> > +        clocks:
> > +          items:
> > +            - description: MAC transmit/receiver reference clock
>=20
> This goes in the top-level or can just be dropped.
>=20
> > +
> > +        clock-names:
> > +          items:
> > +            - const: ref
>=20
> This goes in the top-level.
>=20
>=20
> > +    else:
>=20
> Then negate the 'if' schema (not: contains: ...) and you just need the pa=
rt
> below:

Okay, I'll improve it, many thanks.

>=20
> > +      properties:
> > +        clocks: false
> > +        clock-names: false
> >
> >  unevaluatedProperties: false
> >
> > --
> > 2.34.1
> >

