Return-Path: <linux-pci+bounces-15765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B05E9B893E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 03:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4334B20CBD
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE529132106;
	Fri,  1 Nov 2024 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IQ2/N5px"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2089.outbound.protection.outlook.com [40.107.105.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2211F374D1;
	Fri,  1 Nov 2024 02:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427544; cv=fail; b=kZ7DN1yVObI+d5oxugWm/CNmf8q2YiLjiys66E7nfnGoy/nFOSUT0M2Hc4Osj8ckmdTL0tLX+KqaMOWLmZLM8Ms8kSBEdezkJXPXhdH5SUmwEpamuolDvZ7n7aJQZTyEUd/mpuB31mprn9wj8VzqJ4x2UxkoZ/+PdAVoY3d/how=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427544; c=relaxed/simple;
	bh=PEbBcgBrKzgjCEmuvGHOmDmuIxbeqLEcPNQIaHBYjdo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I67Iz6ov9UHdkHTYg3c6irMtrpefyC1qYmvvkm91/48hQdfm8clbp9VL7jP6EWlpBfHG1C3oiXfG6oUh4UprNa+znCJ3dvMg/VltzZW2JuDVi760RzsuB36mvGeXDL2FmK4VlPry0MUklPCmlaQT94BDL8oLVFIE0BX3ZMjRfww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IQ2/N5px; arc=fail smtp.client-ip=40.107.105.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFhXoeF8WZKlmUJmSPoXF6YsVm1Qh0M5VLbPZdvyxpUp4LW60al1Uk56Mb5DUkkmhufF2lH9IToKKdOi0Cd3PtpqxSAnjqoTz2u8o6mbfU/kIh0tDOiDeClOY2DwooXOcuXceCASOPHyqcdtApm8yBurkDxnphtnVqHGOfffIJa0fv6dLkgxuW6nrG/bjlWRxLXHv8yQlPqQiS+Sn8Pm83ZYblMQhWHUoEfKbz/qex6f9JLeylBY5MZpQojxQrath/y5pJq3F1ushbMbutMNiZP+dK2px5eQUd4aorFtg3ODHsAce6/E2JTY2aovyaSLZ6VxUsjbjuUHFIiwlraKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEbBcgBrKzgjCEmuvGHOmDmuIxbeqLEcPNQIaHBYjdo=;
 b=iiU3bPSd2ZG9FRJbu55Ki9+sO35H0DssFgYBqbrNnWLD4BbSZKwiZzhjRxj9rrs6n6VmNE7QqioBQKfW5L7HM5b+tGEhvCwayrnT/P9BSMwpDtwsVnTb5YEXOWG7hSKJmAM1Rh+xsV5OGZX/XIjKrv9FGeU+CjLd1ptb8rN3Kbko1Xmbt0acPqIZiXqg7Rhwfxt0Plf1yoV9cq9STSjjp+/y8/bjo4ySLTGEVj7jicbYpHF5ZPn6xjv5MeiLvQzNOsBF9CEyztpVcEJarJjog/JjugCB2+4k3Tv1SFl1HDTq0ibC/oknyJHdszueVSUy4jVMJas4GHmHi4E2ugQPyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEbBcgBrKzgjCEmuvGHOmDmuIxbeqLEcPNQIaHBYjdo=;
 b=IQ2/N5px0bcz8NezTFse7B/fPQnmW/xLbl/OAdjHABKohLd7u+99Yk8/qSnawPWVZDCP7pdmUWkv5+/1QvYo+ua72nWGxyGLIA72QyHj0Qsc+MVoK4MkrJHd6yXwviyotRkL4x08zoYoANY6cc1maM+zXk4qu/KFg6fLg/I6cCnnsPwWMQJJQlivVKO2dqdTDbJ1Yf7D5gVvz4f+X3OjFFzLHhg8F19SF3jwWyx8QQtNb6VVOSCZCqhO/eECQrv7Um21jmBEKUyITlqX13lMUYskTcY2dvIYOA9V/c/Yqp9StSSn7I/Nxb+7wwjEnm/hQOZO+OsiaVlgVCyVOoDKjw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8883.eurprd04.prod.outlook.com (2603:10a6:20b:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 02:18:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 02:18:55 +0000
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
Thread-Index:
 AQHbJEi1opWCvzFL8kS18Y10TWXurLKT6McAgAAQObCAAgF4AIABJnHAgAAKx9CAAEkYuoAA5gGggAiCCgCAANxaMA==
Date: Fri, 1 Nov 2024 02:18:55 +0000
Message-ID:
 <PAXPR04MB851041AFADEE8FC8790E90FF88562@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
 <20241022055223.382277-4-wei.fang@nxp.com>
 <xx4l4bs4iqmtgafs63ly2labvqzul2a7wkpyvxkbde257hfgs2@xgfs57rcdsk6>
 <PAXPR04MB851034FDAC4E63F1866356B4884D2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241024143214.qhsxghepykrxbiyk@skbuf>
 <PAXPR04MB8510BE30C31D55831BB276B2884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB85102B944E851C315F4C5BE1884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241025130611.4em37ery2iwirsbf@skbuf>
 <PAXPR04MB8510B731B4F27B1A45C1792588482@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20241031124500.vxj7ppuhygh6lkpm@skbuf>
In-Reply-To: <20241031124500.vxj7ppuhygh6lkpm@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8883:EE_
x-ms-office365-filtering-correlation-id: ebdb98df-5935-454c-9db1-08dcfa1b8930
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HIlybRPbpqdg84ELIIDWlukh+PhHMXOPDlJIW0xmpmHGRen9iCrawNR0tm0o?=
 =?us-ascii?Q?vN3zYQo1LrZzGqW0bz8/8TP7qsWsL56asmUEtjV8hC0SxvWV7/uaCw4WJyyC?=
 =?us-ascii?Q?v0yq5z8+k3uVPudIAI52sekQNKUOT34Rjn2xBy0QKvQcYihfAGo4mh72MqAp?=
 =?us-ascii?Q?Gvs2ZqyfdP0LNtOSC78cjEkrPvc1cJli3sg1b7FtXflWB7gNsEmPjHjIR6Pz?=
 =?us-ascii?Q?ojBKZwtAZrm49pvz80iSxGqbtZ0uf+bGR0ebJyO9yWmV+38ipjVF5IHNkgi/?=
 =?us-ascii?Q?UFBEwuMEYutSq9kQuJ1PLeOhXW813gXJVomEUFaywQ6GhdghFg8g2cDTSPbz?=
 =?us-ascii?Q?3SG/ZD0ny5r6ayGViZ2e0hVLMYrkDGhzspeCNe6/O2608669q5ZzNjE4Siba?=
 =?us-ascii?Q?9ZVc+mNC8nZteq/kHAeNG3C+mfFBiaHN7r59KqJ+lGHu9qr8hmhPyIavH0Ne?=
 =?us-ascii?Q?9sBSPYlCAsiuuRZ9Dru1RTiwagpIgd03nJIhOIpieos2kX79Vj5NKTvVW9vg?=
 =?us-ascii?Q?NyeWr/UJP0OWBTsDNUnp29Zkm+HDVAqeGHfi8A7t7RAn7UIuurccqMUjsBg6?=
 =?us-ascii?Q?uaEPuVnhtf0JkwwfQIrHKGKFLz7HFtTgAXXg3cQsCqXc4ZP4gMLpmP8oeRb5?=
 =?us-ascii?Q?I3NZTo9B4dY4h9yANn3zFgPWRNmSyQER4QMb1fiDaymQMBZya16pCwiipyQo?=
 =?us-ascii?Q?5EQ62zJ4ldi3yDbihEzT6AgHP7K9UhHiGQEveRPwDNpx1f1yh9FoZ7j5WmBt?=
 =?us-ascii?Q?um8pU2VMdR4t5dPN2V3hTY80qUEOz/1EXlHQt+Q+X7f6iO620JcTGBgPDcss?=
 =?us-ascii?Q?5Zk+vfVHfvJw8nb1NrDhzAHtXuCfOptxaeMYRa7AgahSyXf3Ou0u+An2FPM4?=
 =?us-ascii?Q?mHPArvGj2OeuZoZVrttkf1Vy9iVs1z7MwrO24ADjlcPiq8jkkpUiql3/br5b?=
 =?us-ascii?Q?H+o4ncMyw3rpTZOuZ8j95TCrRvlL522VPXhQesxiX6CqqG77hnkOqgu+Xuh4?=
 =?us-ascii?Q?Is1dJDTrSlgiFGuKIoOG3MCEzbOesqVMGP3YQHr7bQYVxQmESJEUOQG75Bo+?=
 =?us-ascii?Q?VxjNwSVQc+GqvCOfosHqfT4hSNyIBc5LTd2H1QVT45T0rDL6yS8Pfl/97ges?=
 =?us-ascii?Q?zZ3jT2O6mD/9m6aiiQnKBX43rfue6Mm8v8aYxe5O3+CSp+EAtkqKxah4rLsy?=
 =?us-ascii?Q?5kEna38OAg0b0DbJvh7SJENIzuvO1plSxaCMAYP6ADhepOKREn6O+6Fbk95e?=
 =?us-ascii?Q?4eR6mr+ZXHT+C5QoaZrPu2fF8CfW/v4zDjo71aytgEJ6KK8NB175RjZ2rwwJ?=
 =?us-ascii?Q?5l95r13ZwQAnrWeS5lMk+BKjs33m2kjDmcFcx8SmRdW0VygGAdzqKgfCAsQJ?=
 =?us-ascii?Q?3v6rIlc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0oPZMCFNIXxMtFoBIZTvpPf3MhBZ1C+XmX4Dbuk61BRdgfE7uj+Gyf46MUH/?=
 =?us-ascii?Q?IX/2/MCOrhgQHFUTWWrris+SrYzZTH2wrUiP12obqyi9iT+zb6dkG4Je6HOi?=
 =?us-ascii?Q?QI0gI/Jb5JjhXR4OV3kTogrkBIODGGpeWazX2V701hGMn7XocR6NboMpefjZ?=
 =?us-ascii?Q?j2Az1QJ7OCb61X/HmKRXFVF/aUWrvm8uFk5t5MLkA/tgeaebqdckwog/63Jz?=
 =?us-ascii?Q?94RvTjlJpiO/wp5U25jX9ohO6sCahLMD8fxvYhRLaRp8MWAv/DTi+a7Eddwr?=
 =?us-ascii?Q?LzGgf9EJ4qjQjFW4bsMWpD+Q5ReJ0zSLPETBtvap6+/3Pd62v/ThTRRZVmwU?=
 =?us-ascii?Q?HjXFwwTRVq53lM+10lqwURW5BMwmK4H8PXj45fQaTyrfohs179ETLvXxcDIy?=
 =?us-ascii?Q?hJBlx3etcwJRy1BsymtdeoCIj/LeNJfc5rJnO3QUbTf4xCa1CiOH4L1A5Yir?=
 =?us-ascii?Q?lwdYBBI+Fy9bEB0YnXcdJpOHK4YKRu6woh98cMOUEkb7V1+OQTBKircQ/QzN?=
 =?us-ascii?Q?JRxxcfidKeSvBg1TVlgnQAlxQzsBCzDE8ckrrCQ/ZVcmWhv1cjy5ceYRLX8H?=
 =?us-ascii?Q?rJ3lqqSefLMggOaFrES9SAdy3l6l5wEXhEnj0xgHV2wGr/YsQpvhEt52WG4P?=
 =?us-ascii?Q?xBUc6Zrg5U3C77VoN4TfqU65SUv6QxWgg+o6552TYju7vZbvHtLzPzDTY590?=
 =?us-ascii?Q?BqG0CiEFeO5e0glf8c9gMhdMZEwqVoi590r4xfSrN7FlukJQ/q9iBnPJYXop?=
 =?us-ascii?Q?+zIolEFy3SSGYw/QmAceW8MG6Oi0f5Xwcw8qP0vBItfkwg5p27HApfhgyHfh?=
 =?us-ascii?Q?KgNU5WwfQm0ulGKc+fuF577ztk/nlEXL9pARourLTR9q67Cyt2y6mTitUgpJ?=
 =?us-ascii?Q?b22A6aVzIZ/C70ISSLGJUlJFtd7Jg4J6cdLkfIEW11FleUN4Dap3nOP5Tcje?=
 =?us-ascii?Q?91h+iETtZJhbLLJvFmQDSY5HIQ8ah0cBEAuCkAzTg3qvPpPwlss6lZyh1d9N?=
 =?us-ascii?Q?SZNGIorCKJ2VeccPi+7GEVszq4LiiJtMBfQTk8mUSen5wpdTfXOIaVENrRRY?=
 =?us-ascii?Q?NccuZ6XW9L/UjmFa92MgDaRK68xev2uB+GlBRGTmTZs1WMN96gwCRYYiZtbN?=
 =?us-ascii?Q?8gGj5WN1ilG0easTb6udCKk/5hvAM/83ycC4f9/piwZdfNtlIaI+Bx43sXiS?=
 =?us-ascii?Q?gWdHWrYqfOBB9LSZZlgRbpc0BKUMXJ0ddDuH1gZXCWLL8s0n/qWv4VfrAgRY?=
 =?us-ascii?Q?0JEniEiMm8ZQZlsoMmvWI+y95oE9ycv6a2+6INKax8dby/ZDJ8/8hiwzz+w1?=
 =?us-ascii?Q?mjso6eql7umVCtgbFhGGCkI0z6JSCze2Grt62Wp5naJet4zvIbL7wpFhJYB0?=
 =?us-ascii?Q?rK99BTi6bLVBJE8SBDnaUlD5w4Wl6+1Cf2ubVNszdUPJFO0DKtiFyScOvGNB?=
 =?us-ascii?Q?TAhq0WELzG2mzUJco+WbQjHIZ04sl0vrM5K1X/XGnIEkUKvZW0sNR4bEURa9?=
 =?us-ascii?Q?TCOcix+7wUAXy9cWaHgTRZtRqugcPyO2lLvQ5oyWD0rN5i9ZpAWj42lUetdI?=
 =?us-ascii?Q?Y3toBckljCWjPYxNPCQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdb98df-5935-454c-9db1-08dcfa1b8930
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 02:18:55.2272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIcMa4Sc4VZfP07k6+K4GRPd67n/gtDQAQQBV/jWy7czyog8XA26Dd23iPecsG6gnViHXLXFnxxoh/Yf7tnwIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8883

>=20
> On Sat, Oct 26, 2024 at 06:01:37AM +0300, Wei Fang wrote:
> > system-controller not only configure the endpoints of the NETC, but als=
o
> > can configure the ECAM space, such as the vendor ID, device ID, the RID
> > of endpoint, VF stride and so on. For this perspective, I don't think t=
he
> > ECAM space should placed at the same hierarchical level with
> system-controller.
> >
> > If they are placed at the same level, then before pci_host_common_probe=
() is
> > called, we need to ensure that IERB completes probe(), which means we n=
eed
> > to modify the PCI host common driver, component API or add a callback
> function
> > or something else, which I don't think is a good idea.
>=20
> Ok, that does sound important. If the NETCMIX block were to actually
> modify the ECAM space, what would be the primary source of information
> for how the ECAM device descriptions should look like?
>=20

I think the related info should be provided by DTS, but currently, we do no=
t
have such requirement that needs Linux to change the ECAM space, this may
be supported in the future if we have the requirement.

> I remember a use case being discussed internally a while ago was that
> where the Cortex-A cores are only guests which only have ownership of
> some Ethernet ports discovered through the ECAM, but not of the entire
> NETCMIX block and not of physical Ethernet ports. How would that be
> described in the device tree? The ECAM node would no longer be placed
> under system-controller?

Yes, we indeed have this use case on i.MX95, only the VFs of 10G ENETC
are owned by Cortex-A, the entire ECAM space and other NETC devices
are all owned by Cortex-M. In this case, the system-controller is no needed
in DTS, because Linux have no permission to access these resources.

>=20
> At what point does it simply just make more sense to have a different
> PCIe ECAM driver than pcie-host-ecam-generic, which just handles
> internally the entire NETCMIX?

Currently, I have not idea in what use case we need a different ECAM driver
to handle internally the entire system-controller.

For the use case I mentioned above, we use a different ECAM driver, which
is implemented by RPMSG, because the entire ECAM space is owned by
Cortex-M. So we use the ECAM driver to notify the Cortex-M to enable/disabl=
e
VFs or do FLR for VFs and so on. But this ECAM driver does not need to
configure the system-controller.


