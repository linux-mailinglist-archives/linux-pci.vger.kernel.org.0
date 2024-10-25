Return-Path: <linux-pci+bounces-15284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBE79AFD06
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 10:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF51F1F22780
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 08:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93DE1D1F63;
	Fri, 25 Oct 2024 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UTILEWAQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2080.outbound.protection.outlook.com [40.107.103.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D178818DF6E;
	Fri, 25 Oct 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846106; cv=fail; b=ecMqX7lxBTyMTwFvrzXzQ5D1RQ5rui5OMSmSoM0DTR1c3IOjMWT46lJvB2iK+0S6nTnCt2GeMw9/z8rbTPri/5aO8aold2w0VUwvGznzkci4XVT6gilX3msV9yv3V/PvgITmybOH0/YXcNWc9d+1gusRVwNMcWNhvYidwRjPVHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846106; c=relaxed/simple;
	bh=aqQetWAeHJGuKQK+rPa9OTj5BNJ317y3EeJvadwHipw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HRoDGaxtOv08Vs9DdOcgOkbnNQ/LvgKEGUygjzzvLvmcRQl4fPa7kBeBgyNojJUPAXZKp4GbdOE1CT4/aBEb5j3PuPnuHqFh+LJRKbI6lj5yh4DCltrsf+JXUyySkTNWmiS236yr2lwWu0I0WnffWZsb/u7cUd6S7XS2TCnhpT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UTILEWAQ; arc=fail smtp.client-ip=40.107.103.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G5W2rrVjjrYdm5g9QOh03q9wVQjKNd1iG+ghCgSo2XtMuMxsHo5RwAi9vDkfrjTVGnbTSiapjy3wihcpfIabqA6iY4KekC1OMMvOVUwG2T4m1Xc63j4WzK78mDQx0znqAv44UUh0zKAcW9CSEpCsXQgzODAKuyb1uGAZszy+2EZDA16NYotZmG070qAl8O4BTH+BGKDMIoY+Gx4lf8wIPE7p2+nvSspooI+gcjf/FPciAPU2F+7rOqmze4++9Oy1vWBkKCBsCESL/7UDWW1fjxJ+0ewVnb+p3A+a82XzL+gR1TNs23hNzVscdSNRTKbLMmriKjbMgwoKWmufZmndhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPFZqmkmbB07VoF2LakOQ6rJT+Zg734igHdZu7DYsMw=;
 b=j8qtIyccPhtDnkHDeLBQWQlPfP6l2ytS0DmbfB0c/Wu9m3zhVnIiCW1WmCp6Bk3NPfMG1IO6DQC5v/jvf0u/E1RNv3WsvsaTi4mKl/OemhhVG24W6JRd7eZ0e2GIFUKOCoYO4nsUyW1aXd6mkwQoy1uyogoftZTL26jJFp+i/rHMBuewDpGtMDfm5Mu2uiedEMIv7FfbuScJAQvbsnJXEVVqx/bnAw+kndCo+SMAX1VfvMsAthSC4WHMhW8yqngMYLF3i+6/n6WxkCf17+LFQJ2OLCi77cbbhACTLc5dJ4X9EwBsxnzKa/4zNdlKa6pU0eFifi3MMRiax1tjl7t/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPFZqmkmbB07VoF2LakOQ6rJT+Zg734igHdZu7DYsMw=;
 b=UTILEWAQNZv1QAiB5hNgo5SA0D/TVKli9XOaGI1vwck7pWrnqq7OIb4lWDH76ALEDdmjMC4S+LPRp5+4C4iLLKqPRs7vPtgWJXPYESgQQo/lI2TXO8S6EzU8v34hFe3yMyizdf7ccj3rmwIboPra72HVzdAuyMGOHmjwamLMdGpikteSKIlxHdQcPXYGhIUp0uWMMTUeMMetL2Xwx0tz621RvCS0EaAT0NmMbTlaZzcn2xcEsVGWyqWNS6VuW1hBRvHQKCgDBkUlSCauAXvYCN0SAtEh6RbETdCfzjhi+Zx8x4uaXaFurgcZ5gRFS9hFGQpQIblDWJDWnls4k/N+OQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 08:48:18 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 08:48:18 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for NETC
 blocks control
Thread-Topic: [PATCH v4 net-next 03/13] dt-bindings: net: add bindings for
 NETC blocks control
Thread-Index: AQHbJEi1opWCvzFL8kS18Y10TWXurLKT6McAgAAQObCAAgF4AIABJnHAgAAKx9A=
Date: Fri, 25 Oct 2024 08:48:18 +0000
Message-ID:
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241024143214.qhsxghepykrxbiyk@skbuf>
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10818:EE_
x-ms-office365-filtering-correlation-id: ad815980-5eac-4730-5a6a-08dcf4d1c5e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?m/+M3uuDMY22JoBlQwUPcLRcYzX8zwpZh6YGhMjtnUzZimTdpWTyESBHd/R9?=
 =?us-ascii?Q?r9MS24lR9NWX0pZhaWOGm3jHWXagiwuGjDPwIUZvGoiq1ym2gpgOIdYAwK/Q?=
 =?us-ascii?Q?h8F4fgERgw18Ev97QWDhRNIWa2SSpqroqWGoC4OVs3goqdNji6ZB1YOM9BvO?=
 =?us-ascii?Q?icLN1gxKFkS079p0L6BBhTXihQAQMcwf45m322f4zrU3EajjK7moViBa7hW9?=
 =?us-ascii?Q?C/2FqQQ2E6JPWInSvQTEI+E2lnYCBheqULgDZqkocap9cLYM5c6u2MqVyFlh?=
 =?us-ascii?Q?UVrr3iKEvELdhpBcT9vTrwvvlR7GOByYRcalTa2u0LxiaLjLoCEPzQwyASb9?=
 =?us-ascii?Q?C+3DHWyrzMZkJ2vUCCw6yohI/NVPKPv6ZaTmMjtDWf05RwzOuBmX7qO41ycu?=
 =?us-ascii?Q?eUJ/OHaK9qWRnxMt4QUGXxS4vPgkMhQaoCiyUMsWLRiFRjq2ntIdcNzozYvP?=
 =?us-ascii?Q?ncx9GJiM6PxjptVGGPBFWjZ0I7a4aMUpTgfm8/phkmOzcqajoUzZgYJMk8W8?=
 =?us-ascii?Q?V/5H5h8oi3JICIHlHkuQOiiYVTKQ7j8PoqkK3Nm2eQBuBOwCS0L1NvZf38HN?=
 =?us-ascii?Q?aLDYHUMBi126hB3CdZ9d9nxDxuo3RC9m3fKS4OGBdiHWzWzZgFWDLedCdWR0?=
 =?us-ascii?Q?CnH53E8kMrylQrS/JX+sWX6XIPJ7whUMBQfo/G4D6jbbJWtg8lXbbntPEGPh?=
 =?us-ascii?Q?jMXUikzAV7Rf6wSB7u4WUIt9iYXouO6n18kDxWaBpvcZYrhv9AYllcbMRPpS?=
 =?us-ascii?Q?M9he2D8pWKnmr0w/xRwXRP8o4OzKNQ71mOgBhJQ9tPF5DvahRosomLNabUhI?=
 =?us-ascii?Q?mvM2sGw4ygC1SoZjbsGIGHCQ/hSeBbqngA7NmHt6M4qvPktD4JVi7skVvhjG?=
 =?us-ascii?Q?vzuI7h4k8TG2hlJsSm95NO1+2AnTGaUcSorjU6XOXcZm28rymptwv4qmuD37?=
 =?us-ascii?Q?bFJK6xrfFFVzxus4NzUUi2xu9yfyv58b57lnr3VRx9tydX+rCu0eSLaDZz+m?=
 =?us-ascii?Q?2gDC6bv1PRjtV7+y0jiR57nUzrkUrNgjFEL3vMf4AgbssWoL4aO/eDalTn8+?=
 =?us-ascii?Q?U8QXcpqt1cvjS3gO7uQGzPHyjB0X5SRnEDrhpaI6xmfoCK4O981VmKlDu+1+?=
 =?us-ascii?Q?hQy6ecDDpwviXZHCLWaNnkB6jSRSecA1jRTCPCltYyUo7vU+R8YmGiMEdCn5?=
 =?us-ascii?Q?6ZeZ2p5yzSLUIkOgvwnRhtRRM295jqMtLOClwg/89sqibLyt6xw17zmyzszt?=
 =?us-ascii?Q?jhinihrunVMpGloJvc8o5VKQlN00fwDHJwFZ7b9K69wLm+v07RkKEcEc3Nt/?=
 =?us-ascii?Q?iOMF3YUsUp3+NP7bjUFQ41n7Abxmf6yZ52Jy7H+iGi6PzPhD27B+D+WdgwUC?=
 =?us-ascii?Q?ttBy/ew=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kZftV3cEEvoykUbyTU7UTkocAhVZ1KxqtVIyzHxvGshf4/dFdWGgreRThyjh?=
 =?us-ascii?Q?hpFjmxX2I0J67MWTXqwgHoXlEamClg0bq77qNAIFK9ustR9lXLOH2iYmr5dX?=
 =?us-ascii?Q?ApcC3UxuFh1EqXZoBxW7YIIE6goP/HjNYYxhKTvl+K7Gde9bRfBbZ6DZFWFh?=
 =?us-ascii?Q?BDuE7gZb32Sso3RjOpFQ0T7FnpTGQ2XdR89UstVVWEnS+DJqFu2OuqxK+vnM?=
 =?us-ascii?Q?t+IJxWXOqvXIZU/C8i0ATVVCP3NCEmoTt1ugKM3Ma1mpELhPStmj0PTuN2HC?=
 =?us-ascii?Q?5tD12q47IO7preFBCCOcRjTl+qqM2U0MXRrpZyA9sVxmasQPYriTpu3Vsnf0?=
 =?us-ascii?Q?9Z8aLrbssguKluEBSlfSQZzqi0cOkmvCSYRj8nvMpoDuSJXfNW8258KP8F7B?=
 =?us-ascii?Q?4HPwuau2nVfGRl95ZXhInvs9PzYrLiYIUiZtvYCV4+DINarMVsgnYqXzmTD1?=
 =?us-ascii?Q?L7nqrmdlQOUdA3ovt+Okdv2tAvij6NQXH9nlF4Fu5od+7qWti5UudU7KbAbT?=
 =?us-ascii?Q?X1L2VH5Ixk7t4LCza8geght2ecTZSeXD8cFNbNMBb4xyyjIqHbcGJ7F8Yynb?=
 =?us-ascii?Q?ImhiRWPo8vEARzxXZmvCrK1j06jXk576iBQnW6xUWqB5+gWHKTysb/sYCQc3?=
 =?us-ascii?Q?DChqzZ0+bkgJ1xmvGOsPgfnPrNbyeBHq5826ENZuPNHI0CLm87uV18001aB5?=
 =?us-ascii?Q?OL9oFIQMhMPPOfRxN0wKNilYKkCeiQZPK1RSvRjhkm0/i1F0vDV/CIb3Kg0K?=
 =?us-ascii?Q?5+2uMNC+AGo/R2cl8JDKayLeR4aV6zEi1a/G0sjFS0OuAGleGAxsiUiYQxU/?=
 =?us-ascii?Q?C0gzYfR4T8lskQwXVBeo/QKuvypJZYTebodslDyfZSU8xxjiBCpoTnLDCM2D?=
 =?us-ascii?Q?GTEYm7feHZwLDm1H+mwaLEtyChay6q8aOfru6VxxyIlH7dQkv8NVhDMr/20J?=
 =?us-ascii?Q?D5rSXBcGIDV9PA07i658LLxGphdulB7UVma4mQwE3o50Z79bz3vPUAk1hlSh?=
 =?us-ascii?Q?tibsyfeSAPQ9Dv88Has5MPVojSgVWKSjIImzc9y3FqE5zaesfBMFwnwzT4Zc?=
 =?us-ascii?Q?U9XTEt4KE0eO3IcJ/g23Y+an5pBC8QMXIMcv2TEYRpm+w5UUSF/qh6dgUg/3?=
 =?us-ascii?Q?a3W3XW2myRYwfiC8JZP7gbRdjwwF4zg3iioQ11KkFF5f2SORyiu7utqUPisL?=
 =?us-ascii?Q?YImO4PFQWc12i+pyhRy8XBSoucp6GQ8i6hQFP9FtjWodiJ3wO56jHVx3mUy0?=
 =?us-ascii?Q?IlOuU5/K7xMRnhMCPhBgKJftLD7lR6368CrnJuhwpmcJ0moTj/fMuIPX2NaY?=
 =?us-ascii?Q?g7sEu3Gi7pEDcMLHJk0gVqrOolaqEt+zKJIZgZZUjuAqb4+DC+lxgkwTd7/t?=
 =?us-ascii?Q?BBUb4ZDQq5Lp50H2429pYopt/0Vytf3+hWvauOkC2x+GkYTvfkT46RUcheXK?=
 =?us-ascii?Q?HOGunh2L02+G5BXy9TpfDaSPCDJ7nWxeJe4nMAim2qvqHCkqXaYlWW8ey1Uv?=
 =?us-ascii?Q?eX+yj9AB4t4RbXnCdvE5cmtZt2Plk2fgW07ec81QEmUglRMU/IuF/A1B2hFD?=
 =?us-ascii?Q?CkxR1mGEmQCbfDGSTOw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ad815980-5eac-4730-5a6a-08dcf4d1c5e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:48:18.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gVjXqYEY7o48IKHsDbcBhA9Ur/f0SiZ5jf4CtoGHMIF5YWrtnuhEvGK8nvmthHdv5Kx08vbUMiPQrOEHL4NFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

> > On Wed, Oct 23, 2024 at 11:18:43AM +0300, Wei Fang wrote:
> > > > > +maintainers:
> > > > > +  - Wei Fang <wei.fang@nxp.com>
> > > > > +  - Clark Wang <xiaoning.wang@nxp.com>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - nxp,imx95-netc-blk-ctrl
> > > > > +
> > > > > +  reg:
> > > > > +    minItems: 2
> > > > > +    maxItems: 3
> > > >
> > > > You have one device, why this is flexible? Device either has
> > > > exactly 2 or exactly 3 IO spaces, not both depending on the context=
.
> > > >
> > >
> > > There are three register blocks, IERB and PRB are inside NETC IP,
> > > but NETCMIX is outside NETC. There are dependencies between these
> > > three blocks, so it is better to configure them in one driver. But
> > > for other platforms like S32, it
> > does
> > > not have NETCMIX, so NETCMIX is optional.
> >
> > Looking at this patch (in v5), I was confused as to why you've made
> > pcie@4cb00000
> > a child of system-controller@4cde0000, when there's no obvious
> > parent/child relationship between them (the ECAM node is not even
> > within the same address space as the "system-controller@4cde0000"
> > address space, and it's not even clear what the
> > "system-controller@4cde0000" node _represents_:
> >
> > examples:
> >   - |
> >     bus {
> >         #address-cells =3D <2>;
> >         #size-cells =3D <2>;
> >
> >         system-controller@4cde0000 {
> >             compatible =3D "nxp,imx95-netc-blk-ctrl";
> >             reg =3D <0x0 0x4cde0000 0x0 0x10000>,
> >                   <0x0 0x4cdf0000 0x0 0x10000>,
> >                   <0x0 0x4c81000c 0x0 0x18>;
> >             reg-names =3D "ierb", "prb", "netcmix";
> >             #address-cells =3D <2>;
> >             #size-cells =3D <2>;
> >             ranges;
> >             clocks =3D <&scmi_clk 98>;
> >             clock-names =3D "ipg";
> >             power-domains =3D <&scmi_devpd 18>;
> >
> >             pcie@4cb00000 {
> >                 compatible =3D "pci-host-ecam-generic";
> >                 reg =3D <0x0 0x4cb00000 0x0 0x100000>;
> >                 #address-cells =3D <3>;
> >                 #size-cells =3D <2>;
> >                 device_type =3D "pci";
> >                 bus-range =3D <0x1 0x1>;
> >                 ranges =3D <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000
> > 0x0 0x20000
> >                           0xc2000000 0x0 0x4cd10000  0x0
> > 0x4cd10000  0x0 0x10000>;
> >
> > But then I saw your response, and I think your response answers my conf=
usion.
> > The "system-controller@4cde0000" node doesn't represent anything in
> > and of itself, it is just a container to make the implementation easier=
.
> >
> > The Linux driver treatment should not have a definitive say in the
> > device tree bindings.
> > To solve the dependencies problem, you have options such as the
> > component API at your disposal to have a "component master" driver
> > which waits until all its components have probed.
> >
> > But if the IERB, PRB and NETCMIX are separate register blocks, they
> > should have separate OF nodes under their respective buses, and the
> > ECAM should be on the same level. You should describe the hierarchy
> > from the perspective of the SoC address space, and not abuse the
> > "ranges" property here.
>=20
> I don't know much about component API. Today I spent some time to learn
> about the component API framework. In my opinion, the framework is also
> implemented based on DTS. For example, the master device specifies the sl=
ave
> devices through a port child node or a property of phandle-array type.
>=20
> For i.MX95 NETC, according to your suggestion, the probe sequence is as
> follows:
>=20
> --> netxmix_probe() # NETCMIX
> 		--> netc_prb_ierb_probe() # IERB and PRB
> 				--> enetc4_probe() # ENETC 0/1/2
> 				--> netc_timer_probe() #PTP Timer
> 				--> enetc_pci_mdio_probe() # NETC EMDIO
>=20
>=20
> From this sequence, there are two levels. The first level is IERB&PRB is =
the
> master device, NETCMIX is the slave device. The second level is IERB&PRB =
is the
> slave device, and ENETC, TIMER and EMDIO are the master devices. First of=
 all, I
> am not sure whether the component API supports mapping a slave device to
> multiple master devices, I only know that multiple slave devices can be m=
apped
> to one master device. Secondly, the two levels will make the driver more
> complicated, which is a greater challenge for us to support suspend/resum=
e in
> the future. As far as I know, the component helper also doesn't solve run=
time
> dependencies, e.g.
> for system suspend and resume operations.
>=20
> I don't think there is anything wrong with the current approach. First, a=
s you
> said, it makes implementation easier. Second, establishing this parent-ch=
ild
> relationship in DTS can solve the suspend/resume operation order problem,
> which we have verified locally. Why do we need each register block to has=
 a
> separated node? These are obviously different register blocks in the NETC
> system.

Another reason as you know, many customers require Ethernet to work as soon
as possible after Linux boots up. If the component API is used, this may de=
lay the
ENETC probe time, which may be unacceptable to customers.

