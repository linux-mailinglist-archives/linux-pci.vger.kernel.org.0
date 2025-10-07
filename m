Return-Path: <linux-pci+bounces-37673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C900BBC18C6
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 15:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AB273BD681
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 13:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE63B225785;
	Tue,  7 Oct 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="WfxYKU+E"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011068.outbound.protection.outlook.com [40.107.74.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA9CEACD;
	Tue,  7 Oct 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844669; cv=fail; b=oNGqUdY5hLy39vQNf0061pQKQgi1hQK5BsuH2yJAteKNjcrCczpPreK5hRW99aZhEZhzAYJHwXOMFfGlDTnUAajnRGPF0XlS4+spAIYUf9T+5G7FK78KsGOu6L6ZDSnZ5+12epQc8vxmzGNJBIzlv5oZ6hAlm4yrTwqdidHnfPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844669; c=relaxed/simple;
	bh=lHPqzn9tTQ0IO2AB3FWDipx8f+WYQUMbJ0Psoyp2tGA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KsrGSEQRA8SjJ7SWkmof7s6jDwnUAo6McxSHnUbf43AhHxtwSTp2y3+NOHM+LyRnt6UIcBEF/K36VDjsWmuTZCuSuWIMHo7kvX+lNGzu/3GdZBMV0oS0fqObenCugmEz8tl24RiurKc5KaAUPO7w/Lu5AyWDzbKe44b8+US7W8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=WfxYKU+E; arc=fail smtp.client-ip=40.107.74.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy+DJoXteGFWcyMcHqzTXNYQp86U6mJRQn004wCjx5mznGpnkOgsMmTF8G/10UiPkRKhtkNvCvEoBqX9A7VWHtP7m68mcWQesfIjqOdV1tHHM5RQ/8LKN7sjrdSvD2RTccIYeY3RTEebSll9aykh1rwaTDvMgjWsfShsVCuWg3e5SRXTHSmkTw4Pcrf8S8sZZR2r0ro2A5uq6W1Yt8X+NL+uo0U+xPODGqIYVfkSlbZuB5SGuDnXYTiypYtCfouWts5uX+8YlGx/aMsqy2MsTULbauSZ/udcHs6syOC5x4dmcxllyJ+mVtULvBSAZRQvO69fZU5dTMQ/B9mJQhaG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqyoXwoBHV5cVPYD21Gy9dPEukpIKlnjzfhpFWnfYXY=;
 b=w5aaoMCVrGFZnxJjVx8xC0pI0WitaFz/t4d9iUiIysy+SPzs9Vx3u4A8KWzpkZFV5vLtMuhVqoUcR76MPARPynkp3Y8OsE4zNvah51mg2ptgvPXb7MuwTKU54+CAH9rFKVAdalk3RxXVyjGtXAq3V1X9Mj51KWIo0oV5oS03L1Yb3aEOPweXWU4STn59BO70jjKiMADmDizovxKcxSh48j2LPPepli1wRkInHqeCPhEAAkdLmKDzmg7W3ClVDKuxC5lk+nFW5BCCgV3etlNozCufwDEqe49tZk20QPhPgstjA9kTrFPVLpLGwf7cSywmLXvN5QFLIkcaqkHjdkZJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqyoXwoBHV5cVPYD21Gy9dPEukpIKlnjzfhpFWnfYXY=;
 b=WfxYKU+EgjnAW/a44D6E1sm4m4DzNlz4KdP1kZiEftwyLM9YV6TqERps9b+3/Kl7yESoGjHkMVu9tGmLVl8xENFFCjFSUPNtAGKBYZ8I59eJ4PzMfsC0VY3IcyIGid2spZuaDibRLQxiALshbhxNNDzo2/qY9KPU2bUWmQ1MU7Q=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OSOPR01MB12378.jpnprd01.prod.outlook.com (2603:1096:604:2dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Tue, 7 Oct
 2025 13:44:20 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.9203.007; Tue, 7 Oct 2025
 13:44:20 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, magnus.damm
	<magnus.damm@gmail.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, wsa+renesas
	<wsa+renesas@sang-engineering.com>
Subject: RE: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Thread-Topic: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
Thread-Index: AQHcN4+Xl3bUT1Hya0C1BFZ2Fpr8n7S2sSOw
Date: Tue, 7 Oct 2025 13:44:19 +0000
Message-ID:
 <TY3PR01MB113461AF51BD346E1D96E43B486E0A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
 <20251007133657.390523-4-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251007133657.390523-4-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OSOPR01MB12378:EE_
x-ms-office365-filtering-correlation-id: f4f27f25-8e61-4f92-ca46-08de05a79dd8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8vgv4mKs/qrgaHEZZSzAeRZ86TaF6+qXHqgrAqkCmPaAErqhTkAlfxZiZTJ5?=
 =?us-ascii?Q?a0sMmHpvP/fTYm+xhJOVrsxwbVxVToXFxlw2LzsBuEnLEW8TO4p+ux08Yvoy?=
 =?us-ascii?Q?rF2uju8Y25js1B86JBAkQUoVjcE7dnS+bXW2OsLXqxFoEfMrJD47UdfBFs6n?=
 =?us-ascii?Q?84agz7c7VGo9XAAxGqQq0ctoQruibf+Hjdk3U2zfmQCZ7fON5fBr2eTaKA/1?=
 =?us-ascii?Q?W4pFSZ9QIJ3PPgJ06NgBxfatIKwIf0iTGn6Qe9fvYRPv6cXGbWmNlwWzpkBQ?=
 =?us-ascii?Q?XfAHvV7Qu8UEsyyLEMONQaUzRJ456dF+dSdH++8jOhY0PS+uIQpDBKRj0Qjk?=
 =?us-ascii?Q?Qd55GvmF3D96U3bLCtSLoKUwJXjaP7Toa0x8dt2AZuWQXXm4TyFk/bh4pfTG?=
 =?us-ascii?Q?PJY++2AIIkmbg+kjgWdNCP62ePkLKGT0475bg14zJLpv+kYGNy/q6+U1wA21?=
 =?us-ascii?Q?DfYcU6WF+CxYRqb7Ozuxiq+w6gZ+oOulwFaW5XLbj9ar8HlfIiP89vDKQwTv?=
 =?us-ascii?Q?bUNTPzeG465F+SnXV4SV0gze77zFN5ZQUBjfrYo2ociDhff8wVMwXhiRtGrO?=
 =?us-ascii?Q?pZybn9yHK7QTVPwiUkl5Bmw1o3C1VNa6LOHjeqsiMnRIQKsJDlHuTxQkyh5u?=
 =?us-ascii?Q?oA7w3bsi9j8tSQKHrpeQCLxehMwioPkYLJw1OWX28VhJg24ZEJY3rWZuOxST?=
 =?us-ascii?Q?nO5GIb6ej7swetFrbB7tlBBzXCcPjH0nksuGcx7PjK1JsLI8c391hRxYscHs?=
 =?us-ascii?Q?0SjS4AvDqsBRglR17q/5/euV3HVzH0f1/5vqKGEgja/EZ5O8gGtgyH/XDPmI?=
 =?us-ascii?Q?QXvWyYywWd1lzM87dQoIUK1JEeXTQUW7W5uTwKIfr5UGzAa3uI6O4j2ywYJS?=
 =?us-ascii?Q?Ts1Jw7gnPMT9ItLYshh5tjaITEihT77dpcAYccdKpfABSVdL6jf94K0fMapk?=
 =?us-ascii?Q?iq1qHeH6wEpbunojM1NxAwu6BnueZ60rO5VWCTzJ6H+7WHy1I2GfKVx4mmRp?=
 =?us-ascii?Q?ZG9HXcdft+AP1dWxM5Oo7S3VHmDKIV3aRjwrjaR3m/2ExnS9QAYM1TAb1XC5?=
 =?us-ascii?Q?ge8conAG+nM0yahL0e1Ses/ZlZiD2BM0xd6bqYEVxogKn1Nwisw49jTewQof?=
 =?us-ascii?Q?smX1WpcLsAI5IqaWFWnjWCxCecaK5nwPpyYb6n1GrTI2n5UpC0Vr4/s/GulI?=
 =?us-ascii?Q?ojR3ogniyzMpH9yw/FkMG6rKrpcmFvCsLv7sUCwjlZvj9MP9/JS3L6DOMiJ+?=
 =?us-ascii?Q?bwI8exSWIMU58Yr79RSiCkKKoSzjTccyalPA0PUCbI78wwXtB78zJh5piEeu?=
 =?us-ascii?Q?RnYXxyEYZ45iWrvSgvaM0AiTHB4dUXcMayhxiLmzxRFpNjK/h9DK+FYc1YjM?=
 =?us-ascii?Q?BNCo7cCyYyPTi7Zd6BMqv41SmYIvntpcyZhR+P0oLs/Bj8FGX2ZcND3nbzc8?=
 =?us-ascii?Q?fddj2vVBYEP3x4tg5YxNzEzjGg2o2t9eSrXnZo5bNLt7k3ZUKshbqFs19H/g?=
 =?us-ascii?Q?WcgWKtkkyK4mkZRFS9Ed5y5uvp1CbUSUCVWw4I6AT+qgRB2JhR9IPWG2uQ?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Cy570k8m9ERMGXJ0Vw1w7VJZTPY+zeRLVhvQzRfOUhcMMT5iRgGnuhwHwgdQ?=
 =?us-ascii?Q?4PHTD4Ery4p+rc2l1CpLOQ/4pGJozdDgQ8AWdeU+4s/n6j1rxhnt0YTAnaGr?=
 =?us-ascii?Q?v0KullIXjXMku8d/ge0KDmvjmfwIqNDVazl9ySl27CGKkGVJiv4gzyx2CnQv?=
 =?us-ascii?Q?GLNsKVFWU0d5MD3ARkmSHmwtfMhk2BGN9+XIkk5enSx6xK8l1cgj2MUsFXf7?=
 =?us-ascii?Q?Zw/aB9v2yPJky3hgEZtpxxd2+qUTMV5UroLRrmyy6LTj5JfcT3MVjSVBXHiP?=
 =?us-ascii?Q?n8orm5m8FzvVsODMDuw7P98r70ejZwLt1HAN18qA+VfeXSGRtVxdUTWR0sXR?=
 =?us-ascii?Q?gJxXXYQPObY4XM47Lf2AUgnEnWKWxwNVVkZaOVIlnwM3E7HIYcMCQP/U5sUQ?=
 =?us-ascii?Q?iTLxppGnsPfb2g1r/cINiLeRzCpN0/GOTX21CcLi4CDDFKdzz6LZYHWn1wZZ?=
 =?us-ascii?Q?naNLwxz/JCldtAGu89rBD00Sl1gxCIjvfunde6ql0PVOW+DvbputV6wuBnVL?=
 =?us-ascii?Q?ATdUA3PldkvjvRFye+6EY1Msg22dE7ABvIZlw0JAIAvJh9cdZ+T1c7oMqqWI?=
 =?us-ascii?Q?CH1OjG9rsB6ha8xr42GZp0+5pETW1ea2NVUqV06cYLKRRd6cfehwFMNgEOpH?=
 =?us-ascii?Q?K55mUhYs0CZEw8sRDl3m3p+J7rN+qxom1MUvgWLxBUUxq+OlYXc6yb8rheR8?=
 =?us-ascii?Q?BJgN4cfh06/cXKBmEhO4Y7m/fFYCGcFY4F5+hkQV0PrTCYGKy/kE/orUuZoK?=
 =?us-ascii?Q?MsNdhHSkEJpiyqR/JPyQVpfp5FINiBPT1xjkSzq1Txs2hZOWF9U9Mj3Jjd0p?=
 =?us-ascii?Q?qCfCaTzHAJMt6RRQhiwlsEgN+HmFNScucgdhipG0C/vp+Zkx74ChGyAPFg4F?=
 =?us-ascii?Q?kf/o+ZFuF90zZEPJPbaKnhJBoc7MWkhZ3JEjL/K0FrAG59MI9IC7NVSH+jUQ?=
 =?us-ascii?Q?U5EY1TwNUWSiQhxNxl3o71OpqfBXAyR6aWS4PKZNwHUBboDbMKY8125YEFGD?=
 =?us-ascii?Q?EnW25fjwflSkQJ8tXP9/Ve/lGsxBu9mfXq9z9Au9AKCLhH2BWC9Q1gvKlRO1?=
 =?us-ascii?Q?UcdQ4BYt138+H9PzL/JUrxq/kZchIjO2PDqnbhA5ECv/dBIMuDSh4rmcgpgz?=
 =?us-ascii?Q?cTd2coPK7lEgVguCp752Ys6O2g2+1oxWFvcjlwtX5vMBEBePd3Xf1KY2NKOk?=
 =?us-ascii?Q?TEp7ERdLZAaYgGverbkPvJc0ji2mQS/bqmfCioXFYpHYeRrlt8XNqc8z3Lj8?=
 =?us-ascii?Q?sVFKINsw1bfnGqz0XI58fD09jpsTtKSLjh8nWdAw8prRXoiAgLng9Kh2+oKT?=
 =?us-ascii?Q?xQc6zVSwCk8xwxpG15vH8O9j3YKBJm9HCKTadBo4hpC89RVlmFwEcqLMmd8c?=
 =?us-ascii?Q?ApfoTS/lzehBULXSYo3F5BSWSZ4zIm1C5sCWYPeRbE6zVAkZaUnfP1K/B3q1?=
 =?us-ascii?Q?5dxbRTp6OaC03NgVxGQ0wnkgUmQHJNF9LmGKDqheefme9SDFSUWH+XcH56WT?=
 =?us-ascii?Q?5nQfKPMFVkZhSijeK+YDuGkRycOGXuU/elurT5qabYIrsY44EWHVxJULxqDS?=
 =?us-ascii?Q?E2WIVvb1904hp+0TopZ9F2BM0aKmE7m5WFcHBnL+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f27f25-8e61-4f92-ca46-08de05a79dd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 13:44:19.8702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /2t6CN1Ap+JCawMhlIhLZxQwd918ACHW41e8r2ZjRduB/hhIXOZb9J6hA0HgncCuxry2hwpVHCup7i4Oy6WjQmnJRB94Spf5AEWIieI9/F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12378

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 07 October 2025 14:37
> Subject: [PATCH v5 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the =
PCIe node.
>=20
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>=20
> Changes in v5:
> - updated the last part of ranges and dma-ranges
> - collected tags
>=20
> Changes in v4:
> - moved the node to r9a08g045.dtsi
> - dropped the "s33" from the compatible string
> - added port node
> - re-ordered properties to have them grouped together
>=20
> Changes in v3:
> - collected tags
> - changed the ranges flags
>=20
> Changes in v2:
> - updated the dma-ranges to reflect the SoC capability; added a
>   comment about it.
> - updated clock-names, interrupt names
> - dropped legacy-interrupt-controller node
> - added interrupt-controller property
> - moved renesas,sysc at the end of the node to comply with
>   DT coding style
>=20
>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi b/arch/arm64/boot=
/dts/renesas/r9a08g045.dtsi
> index 16e6ac614417..00b43377877e 100644
> --- a/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a08g045.dtsi
> @@ -717,6 +717,72 @@ eth1: ethernet@11c40000 {
>  			status =3D "disabled";
>  		};
>=20
> +		pcie: pcie@11e40000 {
> +			compatible =3D "renesas,r9a08g045-pcie";
> +			reg =3D <0 0x11e40000 0 0x10000>;
> +			ranges =3D <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
> +			/* Map all possible DRAM ranges (4 GB). */
> +			dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;

On RZ/G3E, HW manual mentions PCIe can access up to a 36-bit address space =
(access to DDR and PCIE0).

Not sure about RZ/G3S?

Cheers,
Biju



> +			bus-range =3D <0x0 0xff>;
> +			interrupts =3D <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names =3D "serr", "serr_cor", "serr_nonfatal",
> +					  "serr_fatal", "axi_err", "inta",
> +					  "intb", "intc", "intd", "msi",
> +					  "link_bandwidth", "pm_pme", "dma",
> +					  "pcie_evt", "msg", "all";
> +			#interrupt-cells =3D <1>;
> +			interrupt-controller;
> +			interrupt-map-mask =3D <0 0 0 7>;
> +			interrupt-map =3D <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
> +					<0 0 0 2 &pcie 0 0 0 1>, /* INTB */
> +					<0 0 0 3 &pcie 0 0 0 2>, /* INTC */
> +					<0 0 0 4 &pcie 0 0 0 3>; /* INTD */
> +			clocks =3D <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
> +				 <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
> +			clock-names =3D "aclk", "pm";
> +			resets =3D <&cpg R9A08G045_PCI_ARESETN>,
> +				 <&cpg R9A08G045_PCI_RST_B>,
> +				 <&cpg R9A08G045_PCI_RST_GP_B>,
> +				 <&cpg R9A08G045_PCI_RST_PS_B>,
> +				 <&cpg R9A08G045_PCI_RST_RSM_B>,
> +				 <&cpg R9A08G045_PCI_RST_CFG_B>,
> +				 <&cpg R9A08G045_PCI_RST_LOAD_B>;
> +			reset-names =3D "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
> +				      "rst_rsm_b", "rst_cfg_b", "rst_load_b";
> +			power-domains =3D <&cpg>;
> +			device_type =3D "pci";
> +			#address-cells =3D <3>;
> +			#size-cells =3D <2>;
> +			max-link-speed =3D <2>;
> +			renesas,sysc =3D <&sysc>;
> +			status =3D "disabled";
> +
> +			pcie_port0: pcie@0,0 {
> +				reg =3D <0x0 0x0 0x0 0x0 0x0>;
> +				ranges;
> +				device_type =3D "pci";
> +				vendor-id =3D <0x1912>;
> +				device-id =3D <0x0033>;
> +				#address-cells =3D <3>;
> +				#size-cells =3D <2>;
> +			};
> +		};
> +
>  		gic: interrupt-controller@12400000 {
>  			compatible =3D "arm,gic-v3";
>  			#interrupt-cells =3D <3>;
> --
> 2.43.0
>=20


