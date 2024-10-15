Return-Path: <linux-pci+bounces-14559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B899F2D8
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 18:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C358C1F240EE
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623931F6668;
	Tue, 15 Oct 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lVuaG9Ob"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D11B3931;
	Tue, 15 Oct 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010251; cv=fail; b=qm4AXrDsrekdYQkUFWk6HhORKyZDFrDlo+mh7a67cFeT6NA3LvWMIjlp0OSiZOMoo2/ixeUsGA4gkEXJC/H6J0pPT4py/UC/ZgqH79J3Qje9HVJCPQLlko063q+M4Gmyot3EC7pvbthiFtWyMZ0RIJVf0wkjkL/6OrLl5Y8CfTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010251; c=relaxed/simple;
	bh=FZq68sAVd3KEtB4S80096IH8LpB38qRl+i+EFPNv5W0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wd2n8+DdYev00yS9tGMsWGnl76a8ctn5nKSxo5l0HWBAgdsvRV3a7UdHzla1nM781No+MWscoV1jXdsS72nj7F9HxoNQ5M7TeXBzTlpJ0jQXnSB7pw9x4Bril5kKAqFQwq+1eVe9vRd3Sc2HSfu87sHpDs+53WMLhsX0SQ3jwy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lVuaG9Ob; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHH+u/rGqCx2y+FY9Xla69+9y/RSNJSl7cAfJh1lCu5Uv0E6R3dRIuZPM4iJNxHeNeAueP60fLUaKqFOrWi2+Iby54cc2izgHChHbGd4FkzYCtmVihnfTk23/YFtOQ6KQewdhYW9aJM5965dareibao9cIikTwyqalqH712dFRe/TkD5kfToBSci7z4uPNOLD4nDtjPlNcdszqblS8adbiBp889Uy6uVJZgi9h3gzsitCgXbApc9K/iA31q/lJNSxrjcrgTzsNTq7/P4zToqKIxfkCIPCkC/GqhkSZhiS1tc49A4zmN1v1Dq0oNKKOeVg1nBVi6igsVncXuHSkNMlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZq68sAVd3KEtB4S80096IH8LpB38qRl+i+EFPNv5W0=;
 b=ojAZfLY3ZCqPX82qI3O0l9EojkSqxYvMs1qj2BTlL6pPWFo18L+h5jLARC6ZTsSeyO9w4BhfUoZigb5WpAzBNjcxWpWCc3oDcIQa4uuZ4A0TwbO5MPuIsk/omKhB1Zl8LgQSBUGQ69iP0/d87qQHv+nBseIRmtidKQy7i9cnbwe9BQZI03KnMNkArAGridQqSUImveiQeu7Oi/Wx9AdlGK+hgnDTx3Nzlb9vtca5wb1u+DdyiGtSZdbFjJY4zAgnZFHQ9yFjOJUz/kp3VMoiFyhl/WPZj0polymP3RzBTIRG8n32SpayXomHA8BtLAmkQdihRZypRP/S1HQWPwOcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZq68sAVd3KEtB4S80096IH8LpB38qRl+i+EFPNv5W0=;
 b=lVuaG9Obfvq5Y0EhVesNZHV1olBSO0J0qicIFaAD9uYQaDeAe1uHWw8sSnE2rmgVWCReFb/eQOsZMm/xlwjPsArLMt+EuDYJaVOsMYp+VLdemvMtM99PcFxSK2Bn+QvcVYp6yPhV7Cp8I8osuEJ/JTt/vp3J/NMw5uPBZJceSiIw+8OPBZjmjkxy8lda04Bz8YmXWdm9kPlEfYxyPZ4KpB7H/wcKxfONmk2U3XC+u2594iL9NsaN9p6kA799LEK5gUgduT2OPLai3Wm1HH4p2RTse5hjpPP2iC2TbptQjjiJzYT9gY2M1Z+mKSvfc9eQLnC4g+8/BePS8tLu4p/jBA==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by VI0PR04MB10568.eurprd04.prod.outlook.com (2603:10a6:800:26c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:37:25 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:37:25 +0000
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
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Thread-Topic: [PATCH v2 net-next 11/13] net: enetc: optimize the allocation of
 tx_bdr
Thread-Index: AQHbHwQv9J4lsyjKokWMm866u4f7sbKIAsWA
Date: Tue, 15 Oct 2024 16:37:25 +0000
Message-ID:
 <AS8PR04MB884971F5EA6950404C33FE6996452@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-12-wei.fang@nxp.com>
In-Reply-To: <20241015125841.1075560-12-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|VI0PR04MB10568:EE_
x-ms-office365-filtering-correlation-id: 637e7590-39cc-4bfb-15f8-08dced37a67a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?uUnVk175sTyvdHIrWve+OPdjLeZpvQI4T2129J/+J4/QmZZEnbgbVQP4xxyE?=
 =?us-ascii?Q?+FZ+TESfPnuDnIsgHHizebFD9O9MT0PrGxYDNoW88ntCG9jrLBWVXPll1ltx?=
 =?us-ascii?Q?1c3prQDmiQsCJazAF+g5Z65rhJIYfY6kD5mxksAU8IkYwsgaX/1sQAowR+bn?=
 =?us-ascii?Q?jKc8zRHNHtjZBFX6cu8YXo9mIpjeANdEr97LpEZDtoSm229OJVtV0P/tzL/w?=
 =?us-ascii?Q?hWjq/r927UQMpjihKvYk8lEz7Djw9CgPk4Q2pGoOHYBi6YCsmeUQtuX/4daB?=
 =?us-ascii?Q?Jewzho6OgB5WyeirdG7Hn2zAdLKC1fli+Yvnm7p/oTihTQ+eJsDLQc0X4ToG?=
 =?us-ascii?Q?yu5NcmqeUHFE0dbvbDS77MeVVtvt9xZIWKN1LKXJwmo8b6TLhdevrtwPKFBM?=
 =?us-ascii?Q?gTF9H4GA3rBIDahAH0ZpPtM5/rtUQADx+r/C/uaASbINC2H/OBTGBdoVPYGl?=
 =?us-ascii?Q?S7gmxRu29aIHqH0CNAf62Yn+/auSIpFn4ou75xN1MzOS243iSGsya80cwr7E?=
 =?us-ascii?Q?3VQY/Pryp7EQk8GgynzZCak1hY0g/ECV1Chg0T7MPgGnUDVYt+f+PpVhbolY?=
 =?us-ascii?Q?cifVezqUEmMgOlDt/moCMN1DFtEPElu45hH8Tn733TUMS3ndKep2URmwa7Uu?=
 =?us-ascii?Q?X+FVsHOK9oG9+2D56SkYx0u3+6WjbnBn7bt6knYmONaVl9tzHRTXUgniTnR4?=
 =?us-ascii?Q?oRxeMfrbOOp/qYp1WRW4/jTUW22b71qqwbAHNtxr2O8VJHwsVcK5MuajZ2B6?=
 =?us-ascii?Q?cef4/1Ta8PHTAJ3bOTwN6rr2RloctF3/BUKxeuYfDQKEkjfnV+WZ+zYYjF9S?=
 =?us-ascii?Q?hkM8sxVDC+H7eUhfnphKvL3v4FkKiGaKQAmS44bwb2p60HfWYdxf4fOwsx5G?=
 =?us-ascii?Q?xhEHys401HoMiTz8IYdaI8pZ7jyRm1gMTXhqgRcS2L2nV0y+ph5Wi+1vReCV?=
 =?us-ascii?Q?RkACqmVeTXo2EDW0tWSVtLxHYh0ifMSYNXlT8DJy8zp8HoM31DGK8pr9JkWD?=
 =?us-ascii?Q?+u/ytOcmBMeeIsY46JOi2OXgCMG8YnzTckprE6FqoBK+Bis8y6pB0v+9Y4J1?=
 =?us-ascii?Q?N+wJ8BRYzE77T3CXKPkXMyk5NACo2Fdiq5HcdM8Ncc3/lsn7MhE2QsTwOGUY?=
 =?us-ascii?Q?5aNM9McDO/Dfp2HfBsUB5ihgYY1kMs84dhVG9qCWVa+jFRhDkdrz2g5aFfIT?=
 =?us-ascii?Q?kxQWE4Eaf/146ANn1e1+gLaM+DieAGbeMTO7R5q4ClupPyiRD2xvouF1XFu4?=
 =?us-ascii?Q?p+p1gCoXOLcEu+I6zvuMDHD0QCO40rVgESBL8b2qGL+gF8yhyJQ28BDZ8Pvk?=
 =?us-ascii?Q?iGjqq/KrYAuK5PLZLp66xlwE73TxLovzSJXGrXuQdBOoK14lzaJX0S/exa8H?=
 =?us-ascii?Q?r70PKKI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F1cSGx44JIm4XM3Mw+rfePTOj7TfnaurG4qq9skXTDAjkPtn+hMKs5qJXxAO?=
 =?us-ascii?Q?FMWP8DhT9UjhYNfBN+XW7L6sL5G62k4nEfrjdHgKGUs6w0fCDzETDF9GDj0L?=
 =?us-ascii?Q?kJCLJGjL1AZ4NfaTpz4jEqaTHRZtzdOOIlsxo9YRAdaIXKQvNLlr5IMqN4B9?=
 =?us-ascii?Q?RGVoA3JNPd6QAi2HbF4X/fKPI1H69EEFrc5NbS2c83kOJRXJ44G9MgR/toLG?=
 =?us-ascii?Q?vOcDubgYtAbKzvlC0IClLob60xVrfHFma9cCPVGWj9thVT1Go27kp6ubz372?=
 =?us-ascii?Q?e2O+6N738xbpT00B1EGoEb/3LdhoUnAWAtsIayvbHQHGsINzJpwL8vCNPn1P?=
 =?us-ascii?Q?OXc+DWmLUolMadDINmROmNvvEPu6p/N3D8QwoRGEn0L42DB91XVzj7ygbuuf?=
 =?us-ascii?Q?G4Mi+zfN2FB/5XLwwBkEkh+HdP2fCpeQXOFsQL9TaINJMjffuTcb/4jL6R83?=
 =?us-ascii?Q?Gxd9/ie9vawG50GjtT8thfa2Ce5pg30Jpcf+oBXIdGRYMlfrUFJMerZrXURt?=
 =?us-ascii?Q?vzvJ3NyYQLlG8GPGiJC+5iB6KvmY3dW2IaX4KSneAuJp49Cc4EhCDeD14d+4?=
 =?us-ascii?Q?eDAwXrlNkDwSyHjub+nEY/QeomVolGpe3628yo5Sacq44pRWGMUCuvZ5O0uW?=
 =?us-ascii?Q?LqwXwMsjgvi2C81e6zu+pm7xYffj055Ke8FEKoLUwcvDkJCVIDJkq/NpFx9n?=
 =?us-ascii?Q?6V+5pi4NYEQue0mciHfnW9ECt8I7C5ojIYxkRV/Vcx1S5T+aLfcyXXljhZ4R?=
 =?us-ascii?Q?PdfHUQtTCVjSzN6tsBQ8qGbnjkYntuF2eu0TKCH14fNZ5SFv93qpU0Xh2ckX?=
 =?us-ascii?Q?qSV64L2M/p7z6sSODUnRIPHHvm2AvZhorB2Xd38J2e2/qZ0GEp2kGLeNYam0?=
 =?us-ascii?Q?5472hzUSR/LH+62wHazELTBDheKFpscclPsuHMaX8mmEBXvWIvaffj4q0PXg?=
 =?us-ascii?Q?0swSzU+kAm7AJhm0vZBOuhrABn9ZiaNhck2bt9PXO8QpuqCgNqsGDRLcNtbi?=
 =?us-ascii?Q?OlWr/i/zrjGwIoIrtl1moQpizo6GZbh8eB5H0nRmf6ii4XpdejHYuFkHT17H?=
 =?us-ascii?Q?/ahXk3L9DBcjdnNwBCg6v8a+2hpV+ZuYDKkH+6XmriyPLvydOJB4ndMkYqqG?=
 =?us-ascii?Q?AsfXN1TkPRInPs6eIFu7R+TdwDMBCLqf1uSGDX4K4z6/LFimpMs4nOgttr7v?=
 =?us-ascii?Q?UWwIqJigE+RTtN1UjH2qsjSUeBVYiRYD20m/nqVtnoBleie+NPt6YN9L7N9T?=
 =?us-ascii?Q?XxBGCShB6vDL0H5LRZmYP6T7j73x93eJ0t8CdBIXlX3tNgcBQgxaLx3wBeAm?=
 =?us-ascii?Q?JTHaxjKKtR7C0CxS7COQgTlVZVXr4cvB6CrQK27eLUAnJAYLIGCw9HIKr+Hu?=
 =?us-ascii?Q?UerOgzEJQAKOBtmDMUvUGozgXr2B7byw+GFwNOrMslHDY3JyChaBunH2Cy6x?=
 =?us-ascii?Q?xgT71pelb7TIinUV5gAeXd3qQFPV06eGPTHrDOSMQykcMvAFK+ktLp8MUPFr?=
 =?us-ascii?Q?IH7pybK5d08VU7iILUhO/bdT7YD3jdmZtsd5KDYPbjZScEVbVtLPmdqE578q?=
 =?us-ascii?Q?Vte5wwOm+L2U+oChYjB29gExP7ZVc+ZMlGuBY7Xt?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 637e7590-39cc-4bfb-15f8-08dced37a67a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 16:37:25.1337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCrn3Dl0K49Iu4aSW3mmKZ9D+6YlIHCt7QN8YcryH6h4UJfPopjBwlkOOpD/dzdhO+QfOyaKtsc7139TYRFgDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10568

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Tuesday, October 15, 2024 3:59 PM
[...]
> Subject: [PATCH v2 net-next 11/13] net: enetc: optimize the allocation of
> tx_bdr
>=20
> From: Clark Wang <xiaoning.wang@nxp.com>
>=20
> There is a situation where num_tx_rings cannot be divided by bdr_int_num.
> For example, num_tx_rings is 8 and bdr_int_num is 3. According to the
> previous logic, this results in two tx_bdr corresponding memories not
> being allocated, so when sending packets to tx ring 6 or 7, wild pointers
> will be accessed. Of course, this issue doesn't exist on LS1028A, because
> its num_tx_rings is 8, and bdr_int_num is either 1 or 2. However, there
> is a risk for the upcoming i.MX95. Therefore, it is necessary to ensure
> that each tx_bdr can be allocated to the corresponding memory.
>=20
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2 changes:
> This patch is separated from v1 patch 9 ("net: enetc: optimize the
> allocation of tx_bdr"). Only the optimized part is kept.
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>

