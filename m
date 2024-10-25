Return-Path: <linux-pci+bounces-15280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A29AFC70
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 10:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F4721F238D3
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 08:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5DA1CFECF;
	Fri, 25 Oct 2024 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j9o3/KPr"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C51CEEB8;
	Fri, 25 Oct 2024 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844585; cv=fail; b=PQ2PdewXrHqilq/olgQX0h9P9omjIP6fUW3BZaA2Ytt87QXskuiit1+l6/Hr60lY3lyzKpG2PklTl6CuubjGW4E4n2LsU+Cye4Au5v4F4FSsAnnPCDQlaWmlXk9qfyCaZCjt63Mx/ypCuptKMTP7miHSWFfDUnUdtjp1Qy4rUO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844585; c=relaxed/simple;
	bh=dF97soH7zSwN/cbXHEAPwF/grkTNrCDA0nam8MSrgTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LmE4IVtuuQRukY4prwa5VSTwxzSaAvUudxDI5kKCwYXLdL0dBsk1nerXLzF5DTCqxJSy4haWczXtagXJFQz13SjduMBwoMFf1T73pFjTOpHd6prIBf6hcVfHFAyj85qVkD3TOtIlCO5WnhFtMhVEsy1ykONcivG/atpAzbwguwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j9o3/KPr; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcskPIhnD1lb8AbueW0vAps3mzBXLnhm2EzQ2IFTcqJsDzoH3EqBnXpV5n3LBumozLeVnFqEdwQrntjsGO1kQph3WTitBa5zUr385njByLu3moBzl9BCtiwrWNJX6x5igsX0Rk4Kllo1t0Vxzh9/j7oJ1qt1dBq/VLyFCdhDSuvcyVXFC7jsyjJTM6fl5V1AELMAIjQ31dTPw6oaXPfteGDyfh4aDxdhzKP+t9JHeFEnkYaWlKuq9tWSuSbWjP71E/Mn29aNLShVTyLOd7/qoxdxOYq/iZWlqiT9IprmK9b8RsJwL/aR4+8sOgWcUWpXSAK2vvzQVUCKQDTHMn+1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DZ0+xif4o7klnA83/mugVAtjqnArlER6f+/prtqknM=;
 b=vNdDPCO1sGREGGHOQb+PS7e7h34mQhrKg5IVM7uNQ0kuEgyh1+4dDx11Z3bjACOMnEaTUb4dOGRFJMNB2XnqirA4fRX9r8JaXOzsnbp5LucARo11U/D6JWCOa1nc+sfGwP37tSCqDgI4MyJMmLGC346NR0qeOvFBIgIxEQ9P06Lsq9byQxcEG3WXJLFc5BIgjq+cBIkWhFCfN9D5mFCG8KGmKLO4ujqNog1hYqwaSi3VeVLUAC5zpVAlmLyyihFOlCk1/nYpky6lM7V8cIPwSEOdGQ5rJQ182MTB36cNwGC1xNpjWQ6yGksb7aUD073fkgdy2Wpf8I2LzbUgxZxYiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DZ0+xif4o7klnA83/mugVAtjqnArlER6f+/prtqknM=;
 b=j9o3/KPrgd6JrH3KI1kH+6w3YRnxuVptkQNN2vrEiMJtBsqfrg0wnTPPMOnS9WTtckoFbpRnIR6LkqqQ2ynrCXdjNhkH1gAP82af7dn5kx60YWzoxZWQqlJFQh0eWuLZwKpw7HAVABCqZPP5Zq1USAx1prE+RWdo++XVdIP2TxEgMiHEyVmsIlFSFzfNbLOtJMJ4x/CDZDxt7dU1K3n56FJvqRRKSfUNN2v/+k2jx1lDYe5XWADix+pcGPCniFTI+eldYEqQDFQz+jdwblQESD/TmOqLPQF/Qq8NSmHrW3f+gsjkYjwG5AJlg+SSbRDf8jqWO+7IROWY/+o1srqJ4A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10296.eurprd04.prod.outlook.com (2603:10a6:102:44a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 08:22:57 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 08:22:57 +0000
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
Thread-Index: AQHbJEi1opWCvzFL8kS18Y10TWXurLKT6McAgAAQObCAAgF4AIABJnHA
Date: Fri, 25 Oct 2024 08:22:57 +0000
Message-ID:
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241024143214.qhsxghepykrxbiyk@skbuf>
In-Reply-To: <20241024143214.qhsxghepykrxbiyk@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA1PR04MB10296:EE_
x-ms-office365-filtering-correlation-id: 4e7ac05c-3df1-4f19-71a2-08dcf4ce3b4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SUoDR7+18Qp+90erotOb4QKcPP+x5NS6D4jibh9pmVvPAzqCm8iqWCfLygR1?=
 =?us-ascii?Q?vyVc6BZeIawfpdxReCOPtuXOq77wcIPYmxmGO8HSUbM7MHnOQ+K0Ma5uNFv6?=
 =?us-ascii?Q?gDGItz1Fbg8R4yzZKecRvqqE+Pwpahe20RaAaAxpF3UzRIMId7yYl65q0PDN?=
 =?us-ascii?Q?B7PvnS+ceiaNmCAuuip1N0mQzm8MagV9xwV/nuUSNaLHaCATUIwKA3hhK4zE?=
 =?us-ascii?Q?94ahqJO8T2A7BpjZn27qGPeIv9x90853kaROOnZIC2Gt6WdNo3VXY6gsnP2i?=
 =?us-ascii?Q?MfUSo7fOlw64A8NUPKHMf96g0i8BX9+0MD4rFCVvrpXFak1LoRqz6wX2X76H?=
 =?us-ascii?Q?irc8x6sjaJmY0/cdzq3IwSyVnc7FT/O/QZ0Q/bjMp8GpbfJukAj09JFJGmEl?=
 =?us-ascii?Q?BA5a5xNGS32cyFjQx4v+SJ2M7nym6Q6dARMlPJq8JY2JMGekCQTdkm7n9Glr?=
 =?us-ascii?Q?DyeWdcf1HpQfI1HWZo9mda54DTHqEbsrjpDVweZY4qIATYvmIAMnSSNshobl?=
 =?us-ascii?Q?s1b8gIonnXcvKBEyPm+g6lqtc5ha7bCK6r2mQxgC8pEhxWz8RMWajwgXJfgz?=
 =?us-ascii?Q?5Gp+R8WquBPHjlo0Rmfb00mjmInwwXZ29BnNrKMHr5f1yCd6XIpu1KwdqokH?=
 =?us-ascii?Q?jcGgwpE5MCpPg3oB53yqdC9COoBGc5WQhrwLy8INp8QnJO6Jyw9RcO++im6v?=
 =?us-ascii?Q?AodVeMbd4HSfxIj4uLfqw+nnOhU4vblbg8rxaHrvDaFZhTWLmLNEUXQ1RNxw?=
 =?us-ascii?Q?bXs/64daCRks9fyNv5yLSxvxBLCbLxbI8VlkvW7Gbex7KroKZPjc6BOkC/wn?=
 =?us-ascii?Q?AD8MZBv5EEhNP10piKAHIvM/YZmWSDORIULEY/hsVciw0cO2fxybbHHUFF5+?=
 =?us-ascii?Q?6zdfNsqHvk6PguFcBK/Ivu8iQuY2eQWSfWD5I3Zymy+A7Qu9bw+mt2Pdwfgy?=
 =?us-ascii?Q?BYikM647gnMumXw7fbtOV1U1Tpm1Jqg7YjfnuOWwsApPbVotezgAYh09HOgP?=
 =?us-ascii?Q?MT0upkxTjK8rejVAUlqVfK9vquwEoRTQ3ni+oh9kLpANsQWMNeP05SVtsJzP?=
 =?us-ascii?Q?zZiqB2yIM2bFqxkt8DEWVy0v3OSrmcAEl01c7hz5by40xYeMW+jz0pZzHoKB?=
 =?us-ascii?Q?FzXDaw0AGjpcpbdTLGx2WXGreEcMUXv/Ikj4k10O2JD5a5VePpOQCQVniaHg?=
 =?us-ascii?Q?4o0+l1MrgVJNIvbN6iZ0FXZTEFdpwRFpSAUqPVQkA5fkvdMB5FRE3i4JaOpg?=
 =?us-ascii?Q?S+HWsyFES4qw24wb/F3LJZfbxiLZOrdNV0d4mNc0+lFmFGD9b/jdXGGnWQVK?=
 =?us-ascii?Q?SSzDHNdQYAMq1Q1wukXYu2wIA23EHDQjATnsQEvHBtBdFZzVMtOnyhXZoqrg?=
 =?us-ascii?Q?hlxc0NY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hqZ52XtLGM9J9N7Y8kkizN6dXaiKAv3qi88Tlnmf4GyHKUjG5hSE5EuzlgOr?=
 =?us-ascii?Q?4/S9c/xaHoRS4WttxtjeNhlhNTsXIZNe2aCG08RJNOheplpdvPuCBPTYfwTE?=
 =?us-ascii?Q?yKv1OTUJ2qPQHnHi54dsnUD0o8pOa4/bT7pUsZzMePj03ob/jxh96cetzWn/?=
 =?us-ascii?Q?EzpR9gNdsfqiMnKVYT/ilmsyuzCF418QBDc/da8Ro+CEaXrAW3CQliQsTTgj?=
 =?us-ascii?Q?fK/vYZWCXg7esNeAagjBSIY3JjbiNYNsSvccxGIQlgFiDGBVqk1lK0Nivy1s?=
 =?us-ascii?Q?nBbBEm/GFg9sao/iFKPfFX7YQFYViWf6zrzQ2+hESASA97kQusLAtWYIbkTR?=
 =?us-ascii?Q?3vAipKxut800Jl5oxSq1gVYYkpn5cI7hqwq3r6JKMy9G7TqF/XbaeynQs5Bq?=
 =?us-ascii?Q?er2A9Skv9sx4bKAQYlgQGH4IUKStQSFJfqt7AjxXt1X4YrTLnbntPh3dqQQp?=
 =?us-ascii?Q?eDe/N0yh+hhhXbO5mqCfGKXeSlU9aC0C4cS3hyMt/qcIieBbHDnA+8z0JBE3?=
 =?us-ascii?Q?GNOltGrvAPXL1xIwowQdlpFgn3CW0FgMcAgTp51nnxwKfBkoLC1WlPPYtQLV?=
 =?us-ascii?Q?CgZPNOVVht5yvpMxrb1gaAkkSeerHiAFcphWk7ZRqPL5D+6CFgBc/ojbWaib?=
 =?us-ascii?Q?q3xthNjHZcExWvm8GsNQBkE+LYBrt6auxbfLFFf7m5QSxJHI2NP0zUexAhPC?=
 =?us-ascii?Q?a2E1AESxBIzUiS+OWjrac1ywSkMkiaaI3yExTcchyVQxfsldg6yEtWymfrbf?=
 =?us-ascii?Q?KOF/Tqre7eOFbgIzd+ZnihuVEUUwGKWkO1zUkjZM2AJDVs7zvTUgbvDjpV0H?=
 =?us-ascii?Q?fUPoQzoRSEnbGmxtYR9Y7gZXoaXXPGE0AH0uuCuU7nQhL3godMQbh71XoHRU?=
 =?us-ascii?Q?q4X6/c0S3unhhYxFpPGLxFtEwjnl8RDC4gnPHCc2aLNlv19n+YUt++Kmux5E?=
 =?us-ascii?Q?6rWs+GtmSKCGj0Smo2kLLHPo0OJ1Hoj7K4uOzepIkvirl4q+4BAX8V/KKZPs?=
 =?us-ascii?Q?s/M8+hX46eaZ3A1AkCt/48N8HD1gS0iScn/8p/iY+Z9umeErjONU/KxwQoGt?=
 =?us-ascii?Q?xWlswLVtSocyGYM3Moblh0qZn3rOJ+IocgtPG8hQ7XZMk3W/59WWs9O2eRmm?=
 =?us-ascii?Q?07CeBjgNjfFcXNv8SvImPalwisq2H4fg5CS7jo3Crxr6rDa/p1hAEZy+ppnb?=
 =?us-ascii?Q?FxokyMOTh/jCQ/mh4l1qCr0g1JlNQNJM8/U/1Sw1+IkRiDXSVCNl9fkYbL5T?=
 =?us-ascii?Q?mEYd2v8ilBSMDwvg1cNFKHnvRg8JMa5J8lh9OqNuqrqSYfaIvC7Cisq9MOzA?=
 =?us-ascii?Q?J9E0CMmuapc1NZRXJcDNqHG9g95oVkyCBsLwIQIvHW9fXMr5yqgOTLuzBqOT?=
 =?us-ascii?Q?d3YCRHVLqbexfoZlqpGtes/zVCiaAxZpsyKFLW2WVVtyt326hWnHMlTHuqOI?=
 =?us-ascii?Q?+e/y+9l0avsq4So/KQwmZ/QITEHxRuFEM6wkfqmdZaxV2GNdQxyCQJqM4Vf2?=
 =?us-ascii?Q?3LOnWjZhCX+DlXx/xzZRqG5H4SsJU5069cK6gZZJhjKftvzGg0wSGoclg+Z4?=
 =?us-ascii?Q?UryF7x53bOkNGVNCfaE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7ac05c-3df1-4f19-71a2-08dcf4ce3b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 08:22:57.4587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VfN7aRsxkJlfSm5/vzmeLLDN7gdMlAod3Jw9XRgpa6UV+RR3B2UKMbAng/QUhuiqZAkmSG7ta9VUqz70hQdsng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10296

> On Wed, Oct 23, 2024 at 11:18:43AM +0300, Wei Fang wrote:
> > > > +maintainers:
> > > > +  - Wei Fang <wei.fang@nxp.com>
> > > > +  - Clark Wang <xiaoning.wang@nxp.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - nxp,imx95-netc-blk-ctrl
> > > > +
> > > > +  reg:
> > > > +    minItems: 2
> > > > +    maxItems: 3
> > >
> > > You have one device, why this is flexible? Device either has exactly =
2
> > > or exactly 3 IO spaces, not both depending on the context.
> > >
> >
> > There are three register blocks, IERB and PRB are inside NETC IP, but N=
ETCMIX
> > is outside NETC. There are dependencies between these three blocks, so =
it is
> > better to configure them in one driver. But for other platforms like S3=
2, it
> does
> > not have NETCMIX, so NETCMIX is optional.
>=20
> Looking at this patch (in v5), I was confused as to why you've made
> pcie@4cb00000
> a child of system-controller@4cde0000, when there's no obvious parent/chi=
ld
> relationship between them (the ECAM node is not even within the same
> address
> space as the "system-controller@4cde0000" address space, and it's not
> even clear what the "system-controller@4cde0000" node _represents_:
>=20
> examples:
>   - |
>     bus {
>         #address-cells =3D <2>;
>         #size-cells =3D <2>;
>=20
>         system-controller@4cde0000 {
>             compatible =3D "nxp,imx95-netc-blk-ctrl";
>             reg =3D <0x0 0x4cde0000 0x0 0x10000>,
>                   <0x0 0x4cdf0000 0x0 0x10000>,
>                   <0x0 0x4c81000c 0x0 0x18>;
>             reg-names =3D "ierb", "prb", "netcmix";
>             #address-cells =3D <2>;
>             #size-cells =3D <2>;
>             ranges;
>             clocks =3D <&scmi_clk 98>;
>             clock-names =3D "ipg";
>             power-domains =3D <&scmi_devpd 18>;
>=20
>             pcie@4cb00000 {
>                 compatible =3D "pci-host-ecam-generic";
>                 reg =3D <0x0 0x4cb00000 0x0 0x100000>;
>                 #address-cells =3D <3>;
>                 #size-cells =3D <2>;
>                 device_type =3D "pci";
>                 bus-range =3D <0x1 0x1>;
>                 ranges =3D <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000
> 0x0 0x20000
>                           0xc2000000 0x0 0x4cd10000  0x0
> 0x4cd10000  0x0 0x10000>;
>=20
> But then I saw your response, and I think your response answers my confus=
ion.
> The "system-controller@4cde0000" node doesn't represent anything in and
> of itself, it is just a container to make the implementation easier.
>=20
> The Linux driver treatment should not have a definitive say in the device=
 tree
> bindings.
> To solve the dependencies problem, you have options such as the component
> API at
> your disposal to have a "component master" driver which waits until all i=
ts
> components have probed.
>=20
> But if the IERB, PRB and NETCMIX are separate register blocks, they shoul=
d
> have
> separate OF nodes under their respective buses, and the ECAM should be on
> the same
> level. You should describe the hierarchy from the perspective of the SoC
> address
> space, and not abuse the "ranges" property here.

I don't know much about component API. Today I spent some time to learn
about the component API framework. In my opinion, the framework is also
implemented based on DTS. For example, the master device specifies the
slave devices through a port child node or a property of phandle-array type=
.=20

For i.MX95 NETC, according to your suggestion, the probe sequence is as
follows:

--> netxmix_probe() # NETCMIX
		--> netc_prb_ierb_probe() # IERB and PRB
				--> enetc4_probe() # ENETC 0/1/2
				--> netc_timer_probe() #PTP Timer
				--> enetc_pci_mdio_probe() # NETC EMDIO
					=09

From this sequence, there are two levels. The first level is IERB&PRB is
the master device, NETCMIX is the slave device. The second level is
IERB&PRB is the slave device, and ENETC, TIMER and EMDIO are the master
devices. First of all, I am not sure whether the component API supports
mapping a slave device to multiple master devices, I only know that
multiple slave devices can be mapped to one master device. Secondly,
the two levels will make the driver more complicated, which is a greater
challenge for us to support suspend/resume in the future. As far as I
know, the component helper also doesn't solve runtime dependencies, e.g.
for system suspend and resume operations.

I don't think there is anything wrong with the current approach. First,
as you said, it makes implementation easier. Second, establishing this
parent-child relationship in DTS can solve the suspend/resume operation
order problem, which we have verified locally. Why do we need each register
block to has a separated node? These are obviously different register
blocks in the NETC system.

