Return-Path: <linux-pci+bounces-15260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96C9AF80B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 05:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCAD280FC0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 03:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F3E1DFD8;
	Fri, 25 Oct 2024 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b1GHIvuV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B03418BBB6;
	Fri, 25 Oct 2024 03:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825954; cv=fail; b=qoy0yrsW41Zf4zPw3kxpuu699UlRfqRFsKvI399djAr6r65WnJPQGSGtPbYHbBcYGGMGU2vvlC5OH3aEClrZIQ7HaLxqDMaiIKHDx76FgddYAgdvN0/wnFr3PkxJTMo00bhshlBaEtkDVoP8tVIsUuZW/jvWMDz0L1jHhpzVJck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825954; c=relaxed/simple;
	bh=9OrJJjU+arIJZP3JOmAZjphQBgP4imZIpcxBQZ/Qs08=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rq5TGOjGup8TND5HNOLH2I9WMXKIjYMbSlyOBKUz9TBP7j+4kSpF6Wszdm9qY/AEomuZ1q9FlebQXuckFZ7WBMCrz44hIDRVCIhI/z8riF8NQDVUcJ4Zbzl7XZj1ZQQDEcjio0494qU/lxlvcapfoapFDPgfaS8Fh4d/FA2jKfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b1GHIvuV; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhbWQeIx3/1TGapq3Udt18IoL4Dz5kJv89Y2GJN7kKhFYWDXN0qmMgF2KLGFFxzUkwsc2XBjG57fK6oPc68kFY+wJL47ZzOzvvzWAkd2r6qQTbwwJiO14RVBbV87vvlFD0lngyTJ+YdeOvwjT3imS4wehOq3C4AOAu4+9yBZnWQzlAk6TVNRQN5jKnutt/5r4O140GRaa0aJVK6zfE8/n8oYhpViB/T5JluPQCUxO+vgyz01CcSFGgeeMMix13Z8j76TkQSHpKp60zEQpxTg58tClEY6m4gRjDGJgwYWSkKMLomJ328uCe6PaaR6S/ckQcfVe+Z2fhkNrFXQqd3plA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNrlB28U7gmZsgC7UHvjsVyV4otCqO/TDNoDIAQE95g=;
 b=E84KI0ruZc/C2eL18FzvZNDN3wPZjPBfIJHTpuAB828I6AzCSLrOFNxndjLzWlZDTeCs5SAdum3mf7zkuSmiTWBPtcf3rPEmwwo1UDtLhPFxcSFslfbj129hJRGMxnueMjMfUMmAW4pNWmU2O/SvjGFzbb/vGt3yo+JRPADStiaqFDTsdlHRudp85N55MVVN9c1vza8bJ8k5O2Et4lQeAV+ktLWhYAfJ4MOPoVhb2iMyc4glhOPFrVXp/2y0mNpPdSNNwTLbV/ayOE2gIT/COIlps3EBv3EaUiW9btdIHsijEMJiW51JX9JEm/WXTYa+ZxLD8u76chIY7nI/h7NlcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNrlB28U7gmZsgC7UHvjsVyV4otCqO/TDNoDIAQE95g=;
 b=b1GHIvuV17aXnZHzhGU98Uv6NhBsMer3e3Utum1UfIWwxwyFKB0YbB3j6/Ib7uqdtxMYimra5xRs0HxcTB11gyzXBICr19yx7Exx50wrMqYS0zD4/rJNsWi4T9689YVL94ad5eUHiVu85FBUp6rF3bJdTyw3IS2M/IFS2dHXxY38u37921XdJJjtaWnoLY4oydeI8OacpMimKfnF4DvXhs1EF/JDwQ9tXNy7x/ZoGC80kiO0e5D5e270mLRZ+ZL0njdVVzT1bmnxI2Xo18WRSQkAUUczYwcsNs+nMpCmVS1NIohlZtsKgHa87Fgd7av/YgOFPqdYOxc9EDtb9b6zcw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB7808.eurprd04.prod.outlook.com (2603:10a6:102:c8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 03:12:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 03:12:29 +0000
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
Subject: RE: [PATCH v5 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Thread-Topic: [PATCH v5 net-next 09/13] net: enetc: add i.MX95 EMDIO support
Thread-Index: AQHbJeOuQPYjy02H9USxeFoL+ztOjbKWMWrogACY5YA=
Date: Fri, 25 Oct 2024 03:12:29 +0000
Message-ID:
 <PAXPR04MB85109E3A5F7D94D8FD00B43B884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-10-wei.fang@nxp.com>
 <20241024065328.521518-10-wei.fang@nxp.com>
 <20241024180018.i6bizcc5amrapody@skbuf>
In-Reply-To: <20241024180018.i6bizcc5amrapody@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB7808:EE_
x-ms-office365-filtering-correlation-id: 54857f2b-dfbe-499d-78fc-08dcf4a2dc3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4uSHWNf1UWFynOnyjDOzlqU0CwUR2QMkQD9hovMw3Ekt1yZc3DbamfbxlCvV?=
 =?us-ascii?Q?1ZjbnAynwRSJQNKaw9bV1GvWwRJ6gTNVv8N3QewIZjMEUJRTOD1tB/kGfVvD?=
 =?us-ascii?Q?/fK76YN6CGtMS1dpNs1tHD0lcQmpHXSHvI3aHgg2V+IILKk9RuI8cLDfnQL+?=
 =?us-ascii?Q?imtQT8YCeveHFLZfGlPawyViaIXA2h6rTFZ/xd/6d2eTaZT7dVB6zPdNljLj?=
 =?us-ascii?Q?zfuWOZHyB0Mt9+QHnlWt6Q2x6ZT22KyiIlmB2ZdqYtnQ80DofT3tVNB82+iG?=
 =?us-ascii?Q?Ix4/hFcHyIOPuCGU56oOEVyRQKncOqHyIDYP2OoiWHRfRH4X8Gi2FOjsJFWu?=
 =?us-ascii?Q?14/KAuOSDfb6ALMRTWyUypC1vOJoujAzu1HIbF3PId7HTMPNHgL8GmNubTeH?=
 =?us-ascii?Q?JMRhGPUVqfKrGa8kN8JSfgC5wjO+Jxs+YHsrqoULNVo/XX4V1VqX570Alsnq?=
 =?us-ascii?Q?jmW3oHxPItA9X+TwrGVUvKRQVW8OxeGa4n+tBN0ZDEduJHSmgD2Edr5WPGP4?=
 =?us-ascii?Q?ubHc0x/d6hpSr5bPqetj7Ht/AYlUhAqDxTmjcg7Rf7n+ll9PUTHSZ2ukKErd?=
 =?us-ascii?Q?axmMczdVTYuhLQCwQWPTQe3NGp6MaEe/NS6P3b77y25l3l9wHPevG4Ca8Sc8?=
 =?us-ascii?Q?msmXpG353qjfIu5st5JarcGsq8JEOYipk86puiRvu+H/Vo+k36SbWTt4ph7w?=
 =?us-ascii?Q?3Eze4/tPWQntvah9O88oEqRarReUKu/zTFtl/R0Sp8Nf9t7VTN40UAl6B1u6?=
 =?us-ascii?Q?ZOuFWQWr5Exa1F1vmqzBciO52l5O1QIplcmnneJqXvq5C7UQXbAQxlc86KEH?=
 =?us-ascii?Q?rADDLhk8w/vcDpNoGPZppHJT2/aaP7dE70Z2joCiR/gwBxUvRVkzCFqK5sPL?=
 =?us-ascii?Q?gF7HLiRa6vv668ehaXRUnVha04miy72EaDXRh8csXCrRePPYAjcLr+aqy8hm?=
 =?us-ascii?Q?YhYaT6jfq36CZYTBRshBVtlqOSi+g/j8ueD9+1t+ot5z7EUR1MpkgWqyrunE?=
 =?us-ascii?Q?30NEw7lmF7Ftwrpmn9YFtzEl6rb3t4hdWUgM/QXCJtGS1Koen4g/Np3hq0Ro?=
 =?us-ascii?Q?GCns+8bf0gN3aWIPcTQGer35Y0vRn1dPN65WyX6NsW4E982Onv9vPorwUgNR?=
 =?us-ascii?Q?chmrU/06Q+8NqplT0Sxme7R9bjbXRYDU9+J1mjlOZ32V2qQlfFCRQwhPvowY?=
 =?us-ascii?Q?XIOzpfEuSUt0ONTnJqsr85mqx4hZq5xmUn6ZuaUk/jTdL4t6VX8M4WEmKEnM?=
 =?us-ascii?Q?MDWB4e6PvshCeyGi0NWXuCmZJwptaqBsz/aPv0Ku8lE1cpqjbQ9zcLtBkYQE?=
 =?us-ascii?Q?0lmBpsQMwmV9V+TY6sm+KcF9z0MPq9ZxmCJ2zR7P6GhbNdowjoWfRbeqoSGO?=
 =?us-ascii?Q?kwkc9iE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?H5aCbnwabiclrKfh/v+WG/K3v4Jt4gEazgaGUtCpPX7NvyCeCfwBUkj8fFcr?=
 =?us-ascii?Q?sf+9xeeSIGQ8tBMHxfNOAlx1W3u9jyFBnNOjXuryUk0W7KD3QFxFpjZ2F1QN?=
 =?us-ascii?Q?r6HV5Tn6/GfEUNaoUC5Cu0xFh0frkQXs5QSiBG/IHdL4wBtYPKkBF01Xmmsd?=
 =?us-ascii?Q?QTPPAly9rZ7w7j8/tStnD7JoPJifKy+cN1MKfI5CrCPv7ZfwjF6n6U7uf4QW?=
 =?us-ascii?Q?4dhQiwkTCHXS1X7t/OuRuQrBxHfvF92Ip1e5CiTUxqm4b343ubDnZGEGxjRy?=
 =?us-ascii?Q?Wk/uT5G6u3VcJMZd0gy0AwQULGNrGTMAtI1A/ko6lYIXsO/mHxKV0zzcenTW?=
 =?us-ascii?Q?3RbhRp5auypA8CeHTziSL9AXp3vwsQN6w6pt6KoXaIk05jkUMTzlP3VHwDsS?=
 =?us-ascii?Q?pA75zcp25Xnok9wUCCp+DUblQJF6OWTPSc6lrFZsPWFXosw+TiiA5jlKxAFR?=
 =?us-ascii?Q?KvrEmH+7uJ5JRZDV6vJJpY7nT9WyQeubHeke2vIRKazI10Ro8aPdvK0cNYMI?=
 =?us-ascii?Q?lk1RZgY2L6W647aGRrtNpNqXq7/CuNM9iWf6Hc8BUDGmXIX3ag+2x6rYLwCo?=
 =?us-ascii?Q?N7azWh5GSBQG5OonuQsdS4K7aS5vTei/d4GzF9SSSF35cfWgLVBDUpvA75Ud?=
 =?us-ascii?Q?f3NbzwtXBCiITPfQFDS4GybukQ+Z74YVsqro3HmeMrdpyAJWbezmnWfsQXix?=
 =?us-ascii?Q?R+lU7Y/Ill50SgSinwLlN3s3IHQW9j595kiyTzcfmgXTw0ZCpzWHgZlFJlOw?=
 =?us-ascii?Q?Ore3I2CbCV3KlxiF8/HJ3zlCiKA/cIxpD+Hjvtb7utZPQ6H7Qg/0NSoxUqp9?=
 =?us-ascii?Q?H2yclvbJczy3nIJWkxxDRpwU8Girg8gPC1BcaJTqoYRNlrX8i6Ru4rDcEPgY?=
 =?us-ascii?Q?UIhif0x/vitlh79Ft38uC7Bx0D7iirhklHUkRJLC6XR8qTmkACkZ4XgzWjqC?=
 =?us-ascii?Q?B+CiTHIYZodvgc6JzanRpI4P3lSBAJzlLx83i4CXrFNozbZN2yILDW7G9Bjd?=
 =?us-ascii?Q?l3Fs4L0kfvfkZ+IUsK0IyIoS9A08Ohi0LvkC1+CGemPCQZCWtTP9AzTdnHg4?=
 =?us-ascii?Q?Z/pAubdqMYBmE5stAS+UphIbkpa4i+sY+rlIJDPY/LVbeuejhTTBI5sibuaE?=
 =?us-ascii?Q?Uhqy2hOSMTL5W3KeXZ/s8Di14YZX0EGKP78c1+56ikWPi9WdHsnAwK0YvV8n?=
 =?us-ascii?Q?D1subCsVjmJlOtqQMR4/HttOOje9wEoXOthaVmhbI2AYpZpIvLxyhoxyw/yU?=
 =?us-ascii?Q?R+2M6mrMguQJkkTL+/g4E77RJuhDCd+q0HWA1lVsVx2zer6je/pOvXO5arrB?=
 =?us-ascii?Q?80gi/FAJTS1Y1evAmn7YflTq+mNSs0ecftnoqvpIdmLhb/FeXAdNL1LqzdEm?=
 =?us-ascii?Q?f1241+pTOkzPGjVd+H4PUbeV3ngKytrxBDy50QPyLpHoE4dGPMbkAY0diVVT?=
 =?us-ascii?Q?L23M9cqZoHlL09JuBApeSwhNC2vnKSNjtUuFbOzkZUNp1W67B/WQAQgjoD0Q?=
 =?us-ascii?Q?fSWKDynpP3jtKBM8Wa1+0ui9+CEnOUR73J2alyFo937JysJhwxhd0wdrP/3V?=
 =?us-ascii?Q?xQVht6hmWStTppcGyqM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54857f2b-dfbe-499d-78fc-08dcf4a2dc3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 03:12:29.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxCQinXY/zoEv94rbqssSYQnJu+XJ+S8Yowfax1cDqKTnwc8zT5PLzCyle4grlpwp1TBwmKM2sKZbhYfzF89vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7808

> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > v5: no changes
> > ---
> >  drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> > index 2445e35a764a..9968a1e9b5ef 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright 2019 NXP */
> >  #include <linux/fsl/enetc_mdio.h>
> >  #include <linux/of_mdio.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include "enetc_pf.h"
> >
> >  #define ENETC_MDIO_DEV_ID	0xee01
> > @@ -71,6 +72,8 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
> >  		dev_info(&pdev->dev, "Enabled ERR050089 workaround\n");
> >  	}
> >
> > +	pinctrl_pm_select_default_state(dev);
> > +
>=20
> Not an expert on pinctrl by any means.. but is this needed?
> Documentation/driver-api/pin-control.rst says:
>=20
> | When a device driver is about to probe the device core will automatical=
ly
> | attempt to issue ``pinctrl_get_select_default()`` on these devices.
> | This way driver writers do not need to add any of the boilerplate code
> | of the type found below.
>=20
> The documentation is obsolete, because pinctrl_get_select_default()
> doesn't seem to be the current mechanism through which that happens. But
> there is a pinctrl_bind_pins() function in really_probe() which looks
> like it does that job. So.. is this needed?

I think it is no need, I will remove it, thanks.



