Return-Path: <linux-pci+bounces-15082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3CC9ABB12
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 03:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4445E1F22781
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 01:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E9F2B9A6;
	Wed, 23 Oct 2024 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ltGn7VAY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3129C3D97A;
	Wed, 23 Oct 2024 01:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647635; cv=fail; b=KquZ8MvOTD4oYLOrNgXAgabbzwJD94EvgRlZA8Hq0MvDqvixgQive+7Mzs/0UFEweeP0cw4HNnWX0UpsTyYiUhsGxMoG79urKpSHGgfIZmiy2Ei95TsNjBBTPZfUodt+VnEoB8xKwcEdhUqZJzfBUQkotrUo47GgnTMwt1gc8Xg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647635; c=relaxed/simple;
	bh=2U39muAIO5vQAgjzK6xG1V7hNmls9yx7YIV3oGbs6Vk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PxevbTPQ8bLSRtIA5qyP8VunBBGXcOBHv1lOVwwaIIvNXzjAuW0J7hxh+xfhcNenbbZQwbk5dDc+6uHE7I6owf9W5pjOS7v5CKh33Vs1IBCT2ROlwSD8FFlDyQ2WdIUy8/8mLTq5kio4UPU/oIiuwnpLTUqtQpOV3LbNFSt8wxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ltGn7VAY; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbLO4SNlBL4X2H+bT7I5IZ630faFglNr0un6y7uT7ASyYnDUMGdrayKqIepvE1qmj1nNqPEpy7WfYzw1zDSuAaUWbmfMNauHm+VzN1fvIyFHGTkHidLjXaSbbTRMI1F4MPjSUk7VbjpmHsvc/eoPvl88RVtn2a6hl3urI3oYCwOxgjTTk3bsUU7NK0PY6MN8WGoTZgR0m/y3SoyxvqMv/3nqWXso41vUjPqMjSdcmqa+uhOn4vmr8zo2/p9fsC+gq8CUlb0SyjAbbyM8+USijZ7WHZATKsSDmNJwe2rXvOaQu2Smit2P3L4zpH6lIVFBDyCt75tljLRKh/+Ul0eGvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMI7dfRp7aeJd8aiindVjS67pto86IOwH8E9RbGXmm4=;
 b=Om7lolcZEhk2TLPP5zhNnSY5AfmZsiHiatK0kR8cYz45uM42u1/W8MJXeIKEdxm3jnM9HIh03Uo1Rdp6kplY124EGsnwAwP9gjeJ/auEc1ESZEH5ZVGAVDo2to6B8t5UJnEt1Bs1u9WWmweQ2F6CLFNHjv/gJ1E/gVLrLx6+qGE8hYOydo8Z41w7VSp85TQGZlGDeRPdm4AWEDZ5CYGhZzVtGXhHBTOANpJGz/h0IOFBBgIi0qrUokx+HofrSSPdDLzNRlea/KUjVVLmJKyWE+2UGPrWM2XWGmYNtK7ZPoVf+MOVhR1BZ9JKTDzStdemsYVSlnJVNulL1XcbiO71Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMI7dfRp7aeJd8aiindVjS67pto86IOwH8E9RbGXmm4=;
 b=ltGn7VAYdtQSlfP4AT+Hdl6Yj7xulIowEqEjkSM9vFdP9Cd63a65DNbrA497WHj1z+lbE+T8uy/h/3RcyMzbV1RDid9+Tcq1EPfgIMxN2nUiB/ietrwMWRwTrcCoNUkwUtsJNjMDgogXRUVXB7Coy8UdwuMAxFDBazyzu6oC5/q0iYs/rS0aslseZMt43uP1vYtmnBy4TAjPRtHPfWkwD6wVHqwe/wk3hUi8hJ7RdGCw6Rv63DG+0bEOx9cgxLSnLSRtQcGQ4VF+S+BEi/V8k0q6EjR6L88d4JgoStQIcTVox0dJm5m/DcS5UuKyJk7HsPSkXUQp6Fot0lkQzgkdcQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8376.eurprd04.prod.outlook.com (2603:10a6:102:1bf::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 01:40:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 01:40:29 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v4 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Topic: [PATCH v4 net-next 02/13] dt-bindings: net: add i.MX95 ENETC
 support
Thread-Index: AQHbJEixP/Jjfq+gXUqyl2N+K0AQ9rKS8h+AgACcLBA=
Date: Wed, 23 Oct 2024 01:40:29 +0000
Message-ID:
 <PAXPR04MB8510C0504057BC764E03713B884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-3-wei.fang@nxp.com>
 <ZxfPL/9+U6L9HoOO@lizhi-Precision-Tower-5810>
In-Reply-To: <ZxfPL/9+U6L9HoOO@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8376:EE_
x-ms-office365-filtering-correlation-id: fe967a35-75a6-43f9-84a6-08dcf303ad41
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fyoLGa+p9wgtAOdu5ucL0KOzPhwS2u9WFQOFQxCGx1b6ADpb2/emehNfFCNU?=
 =?us-ascii?Q?I/Y1QQnDKcVEdqqam4A/hB/bXDd0vjyIx7SOQGBQnVLqmT1OZydeXzxggnD4?=
 =?us-ascii?Q?uLW8TDrtGI0fA4ty9DoX1evnKcbJC9sSpOEqUeInp2axNSxxw5LKkMEEv3Lc?=
 =?us-ascii?Q?SlIU2nd1uXf9EEBo02Wr7nBawL4YkNkxMfSJFkwMSUCMcNhHuvhN+bQpcRah?=
 =?us-ascii?Q?7KiHQPV29ySZfhT5xJ9gHTxCQV69yMhTNBwjgm0xFerH3fDtaKa+esm/hWdc?=
 =?us-ascii?Q?y0WueaekUq0hiux+XSThgs7SWV+1W1FKhu4HLTu27d33hRG4CVgkLlZYfHZh?=
 =?us-ascii?Q?GlG33hZcCj3s7HKJ/2uN+333V9rETRCS8xnUijn/uU5uMu1Gt8qdJyubXIbf?=
 =?us-ascii?Q?gDJIWlQ1W1t3WDJGGwvH38Tk49q/U2aqW5T+70U6/nLj52SulfNTnGDTqK9f?=
 =?us-ascii?Q?mN8EBqiCzQMY1zeS+3qsmRpvfx5MXBymhByTlHRz6xoRM/l90jSVXIkqa2IM?=
 =?us-ascii?Q?NCBY6okfAUjRhzG8LYFquDnPxLKV1QDaeFCydvAMDTmd6ztuPhoITh+kKTna?=
 =?us-ascii?Q?zIV0TJaQf1l1ysMPVjosl2PD4RFqaiBP8deq+QI5CVvXk/I3WR3WnMIZu0Zt?=
 =?us-ascii?Q?zVDX4z3F6TuD1w1acwpcHWQQdKtrEqFkmeW+6yMwOxQdALWlrf0vY5Vy4S8v?=
 =?us-ascii?Q?WXsnwR15fCgUMyIFtQEEoawyDMGmmANCPAL+DJwYAzXyWAcnZsT0N7nvto8O?=
 =?us-ascii?Q?PSFN2FC4XejoyHpug+tJxadSH75pjvFcgDJcXDgrIEtWeNRyge1ATffe38L3?=
 =?us-ascii?Q?yVC/RsPY0toEyzaMzvV5om36fYD+TY6OLyKrQMCbDWiPSIHgJ6AjpxTSJDJz?=
 =?us-ascii?Q?z3A9sX0mEtF/JzTQZoIeUUfLLmB2ISV5qSubEltTjtv11GgPPJ2vcrnh3Cnk?=
 =?us-ascii?Q?v19XXEnv5MG6EPTajOtAOwNiM+T7gUrljozu0sc75P4VVQpf/eJeHQwyRgJO?=
 =?us-ascii?Q?nsmRqRKB+DskKvOQ8rEFrpYs3t84ml4kh4YFe7atDQDj17AFJlT4KW+0maJk?=
 =?us-ascii?Q?jNl9HSLx5bFt3L43zNBwlujjc+g5IpyM7gVRZUTS9fNZGkxPnMORBMbtVQPF?=
 =?us-ascii?Q?6/WQEfx2oogJJMSTkq5hQMBEl+ibKn/9OgKNEwTEzTHUhD9cIjmdIYYbpCix?=
 =?us-ascii?Q?kTB9v8Rby9AGZ3DbDBK0ET+1IZHojny7xzBch6H8s39Q9EDnuiG2IKNzpHb6?=
 =?us-ascii?Q?y1BSaPGCi8YCYTvlZdP8gKm9+dgcV8SPzvsJnASFU3t5AFsYCumgLgsdwZnK?=
 =?us-ascii?Q?qrk53VOyjf3WN8tu6LUPjpPfSJcogKjgKRWMv9sT01AvuA68dWczJFE7sTy2?=
 =?us-ascii?Q?LxQdvNQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zi/gF872cO90cUSKA84DfdKx2iZloMgR1ybZb5p8SVIAmZnLDId7HbmtBugE?=
 =?us-ascii?Q?MCMccvHBYT7KwsW/Zbi8HGP+gnqpGvdIcD90tQMW2Yq+FPeeXfRfSqZ6fS/g?=
 =?us-ascii?Q?yMlUUzCTqvgjErNV4mDtXgoUAbWUyOCJ+brku+ikk654PtClszwomKhDIBaA?=
 =?us-ascii?Q?gBDsNzIXDOXlhX8nS+pcI2+NT9lSnulFLQT+i+cII16pKCbeqZi+PzkCFyts?=
 =?us-ascii?Q?rCsZVaQNIhDI+SDX9oJKpEW+o3nkP3Qt3yDyjd2tpn0zbQYcNRP/WDZi+J1G?=
 =?us-ascii?Q?EWTjSJXPToufiLTqWmZSES+41zLp7WNDxEa+orz+odFdSqxarbWtqhDeC0oL?=
 =?us-ascii?Q?kgcDFqCID33CTz2jwhxWL0PzNpdQEFd/3FW/3wwxxcsGL6NwpEQgaWrtgwtE?=
 =?us-ascii?Q?ZHbmw9uYeHy7KUcM+GbYm05K4HjQgpfVkg5gOKae5nku1sM6zJYSPv7k5QFB?=
 =?us-ascii?Q?r8KaNcVo5+x6u5252FlqxQmrQQ7nQLmIWD3VtVBNV809TjF86BF3IIk+x8ZB?=
 =?us-ascii?Q?bm0E4HEzTuYCWwGQriZdI8J5y3ZJ4Xryaf+CV9LBxCKd/qD2efQV3D7AFVQd?=
 =?us-ascii?Q?PFXt5e+e1eKhyjIOc+oeL0PsKKdE2RYFUNL4i52KiPD1yo2/+IJiU18Q/NCX?=
 =?us-ascii?Q?LW/D1+pQXNvGX+n1Z+VXrtH0SUamw+0GZHBOQYB1usPEejMynk0RWSmIAZju?=
 =?us-ascii?Q?fGjC6d9J0bEnizX+z6JNyRVqowmjAFXNQytZnC3UuDC+Pz2cOWUlPCEnIFJW?=
 =?us-ascii?Q?rpcPdwm7aPMES2AJ/ao+/DW4aV0lEBWRs6F2Ru0ObFBw5Sv0ltuHHIWXXkX9?=
 =?us-ascii?Q?4k/3tJmTiyMbwC/XQkmbyA/MCx4FDTjlexIVBne236kItEVIaDPhNd6fnGGi?=
 =?us-ascii?Q?CBtNRHCNfeECSdJ5JvpTnMcoOc9stdvIb7G8ikMzSNMto4Td+po0vXnyuo3Q?=
 =?us-ascii?Q?A1bB5m6OraMVuNInZJtSew84O62PnOX5ZMdICqujJp4Gaha+RGQhY9zy+gkK?=
 =?us-ascii?Q?4dkvh8bV0TkD34cGA16zrNIYTYVIeKDYYXKJRj5nrCAD79QGX53nTECITaj9?=
 =?us-ascii?Q?Fw2VZ0DL3LEzb9hDcSKbHxBVHIlk9RrNCw4v1W5/fSAAFE+RzTGcuaK47PnY?=
 =?us-ascii?Q?o+t9r81bJ4beTZSGrjt7zbbElH/JbBkvuZjeozOCPp4s4ZxDfaOkv9x39MsB?=
 =?us-ascii?Q?7V02q4mfEVq2uvIO6klVDhh0lkz7o5Qi2X0RZsfv7WZseeLxP3/v3rPJ4MWJ?=
 =?us-ascii?Q?0vM93oCL0zRe6sLHvPfR2JOU+vZy4F6TvMTrIpgOkwgLKvTow6RCZ8yQUlxs?=
 =?us-ascii?Q?xKHX4NuRCUU2VQZmal0Y/oF1muqTW7sXe/oXfJwYpYQ9eK5aYju58QlbNP/0?=
 =?us-ascii?Q?aOacrNtz0MFsj/dPozDvQLI5p1I4e9Ibv3k7odzC5xgxvwt/dOiMkKUxvrcP?=
 =?us-ascii?Q?JAekI7+suXmb2UgsoSoE5eoenbV5jV1FUcbhyH9MMGHbbX1kZP+FdkiWeFXk?=
 =?us-ascii?Q?DORV/jUlupDuiLqaNReWC6C7w8x8hWrVNBA9/F9gqdkw04tiqCKQG5vn2EPo?=
 =?us-ascii?Q?U4uDBeJABld9yWoFrCw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe967a35-75a6-43f9-84a6-08dcf303ad41
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 01:40:29.6888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fh56GeeRPehsAwuAhYmcEqQJaAEVJIM4AKCvzOTBKEPkwbsm+9LSL6xaTvVvWUxWIG7Gdsx3l/3fXOt9IPpM5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8376

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
> > +          maxItems: 1
> > +          description: MAC transmit/receiver reference clock
>=20
> items:
>   - description: MAC transmit/receiver reference clock

I remember Rob said maxItems:1 is enough, I think items is no needed here.

>=20
> > +
> > +        clock-names:
> > +          const: ref
>=20
> items:
>   - const: ref

I think const: ref is enough, I referenced several other YAML files, such a=
s
cortina,gemini-ethernet.yaml, allwinner,sun8i-a83t-emac.yaml.

> >=20
> > +    else:
> > +      properties:
> > +        clocks: false
> > +        clock-names: false
> >
> >  unevaluatedProperties: false
> >
> > --
> > 2.34.1
> >

