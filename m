Return-Path: <linux-pci+bounces-9614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E964924C77
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2024 01:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314E81C20DCA
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 23:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C9A17DA01;
	Tue,  2 Jul 2024 23:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="dMSlUIZZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010064.outbound.protection.outlook.com [52.101.229.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE1217A5BC;
	Tue,  2 Jul 2024 23:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964644; cv=fail; b=B/GDgQ2tdNZMHJ+efbQXF1PQvTfvGB22Ui5uQp+sS/tTXjKdp14fTZRsAUjWmmLodgLc1uhOwknVIsFNni596ebJplNcYkEcyZBVvTiavzcp9RXpRZ8EGUZ746mjDgfLtFCeLnqgYgmDQoTzpAmvvjMUXen5YAjbQu/a+7h4w/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964644; c=relaxed/simple;
	bh=lfENILj+LQcd2uhqqSkYOit2jLt6+ysINj9XGnqMw94=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kvcg4E6FdarZfcyA7ahcLKk3SRGPRBK7fvBHq+weym/9ynzWXE5zg0HujWPSH6WqcWTbTkbUmtIrst3gqeRHPMGNAlH13gopD1p6G7hsq1jhTduYO2NXYdbrombd0yvTLBFoxfoh4nWXdn6gPdQqAxRxcMLHXz3hrrbZnH1Ekbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=dMSlUIZZ; arc=fail smtp.client-ip=52.101.229.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DLGI01MAcF4LS34m3IPtCdnVdv2TUiuJrA1zF7Nl5drmveA59vV1SvBB+h1ye/Js/e1qwyMhfEcucMx/LFUpMDtKTIWbnxXNYzQnOkhO6QuoKvTs+SG/LWghHXm5DKyzXtysSWDUFexPlIwYhcw/JKhjUHHcajnKRJWhOFC01dO1L0sEIQJf0mQyMB/F6cHuxDmo0uArUYX5JyaqW/Ete+BD+K3cOMYyulgLCrGQGpoLggdeQNYwlOnJ2VSHMjcwNuw43MkmHMen9Hkig6UTXx+uZV+VU/Bz64tpbsV9DDklGFSsFxgtTvxy73RwRHem00Xj61sz3dydlbmgkhQviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki48rb6pa7MJwulXgcAqCz0sPgNTGmiG/J3WtAeQhuU=;
 b=O7EClHScFC0BMdAwiKtS7/UA9Rua5gN60idNP1k0sgsSkqCZaKZDnphGPksKjNlUaYo3TaTGNRj6vigo2Kdui8/FdTxwxwo/W0Lsd/bEZwRulZ2QauaWwm93MDn4boo1k6PpNVPKBejlTqEdWjajaG8ysYzmjlfoBQXss6Dkqgmja35pfF1VrUTufnQCJ7ptDC/MPqthrTAzrkfCtDmOBJIalKs2C8U2emoNOSmQtiYQoWVTR97EJKkmGDQo/nhG+ULaXCqhRtnQiXndyX/Iwh3fGqeQCOy7Mmj8+8E9u3gOqqtvPpw0th7SJ0nyDM9D/rQFptCm62jCHtvjl+HmsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ki48rb6pa7MJwulXgcAqCz0sPgNTGmiG/J3WtAeQhuU=;
 b=dMSlUIZZfDjtPHLhZB8Q+SngIYuCrXuMevcC8u/sSpCFKnPfuo5GiKr2MnpjlRA+6zLBv2aG3iUdNBT9wQjWaKW7TtjThmrgRBczEPCEi/v3AoIikng7zoqjTnnJiqj4t/tKOEC2mhJ1s9CJI71yWnHgqmIwfkKm90mldUY1EDM=
Received: from TYWPR01MB11030.jpnprd01.prod.outlook.com
 (2603:1096:400:390::11) by TYTPR01MB10978.jpnprd01.prod.outlook.com
 (2603:1096:400:3a0::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Tue, 2 Jul
 2024 23:57:18 +0000
Received: from TYWPR01MB11030.jpnprd01.prod.outlook.com
 ([fe80::a78e:aecb:953:b562]) by TYWPR01MB11030.jpnprd01.prod.outlook.com
 ([fe80::a78e:aecb:953:b562%6]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 23:57:18 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Thread-Index: AQHau/4H2Ue+Yvqse06eFL/aaE81cLHjznkAgABwIqA=
Date: Tue, 2 Jul 2024 23:57:18 +0000
Message-ID:
 <TYWPR01MB110303C9F35723AB43EDFFBADD8DC2@TYWPR01MB11030.jpnprd01.prod.outlook.com>
References: <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
 <20240702171400.GA25366@bhelgaas>
In-Reply-To: <20240702171400.GA25366@bhelgaas>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11030:EE_|TYTPR01MB10978:EE_
x-ms-office365-filtering-correlation-id: f65134e1-6347-4346-97d0-08dc9af2b48f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?I56RvVIt/vvwTKWqJ5BXnBAKilmcL+vm/p2JN/YP4PR+SqsJ8eaqQ2cYOIn9?=
 =?us-ascii?Q?qjiocs/6KrukrzUh9+DDssXGY7SvjKXXc3mSAeKHMkuIqBoD/zqaXDEorIYJ?=
 =?us-ascii?Q?L3IDNQORDvjWCXGl+g5BsyLEz1Y+BNQdn5FVc7ZDF0OakU0jLRMrjGsSWYXH?=
 =?us-ascii?Q?Ru/kx9VHrDZSk04qBs3PrG60eHrvTkh3usoDd+GdH+bGXn2iRGjzn6P/GtHN?=
 =?us-ascii?Q?Iis/LbES36JfJem6tkrLUU4vRrpT4dz1RfFz2zYpwONmyui0cc84OWUqzdDx?=
 =?us-ascii?Q?cIc1imaOdGdUUxgYISMKt7OTgVUnTSOr0mQF0r0ITok5z6GDUZxHOw4+KCYh?=
 =?us-ascii?Q?cRROCX2HuNt/+2acCgnPpHPq5nGYcYhIxxWvuO295ZaZFiK/nL71dyMevg+B?=
 =?us-ascii?Q?cc4WETxQ5fwVNDkp53kOuV7e51cpNeTRqW/amAyGlEje0HuriKsmW4kylEAi?=
 =?us-ascii?Q?4THNXABZA4Z+ffXmiSdMGEhuS1dye9uQgcixVNOVf+uw3X3bhcII0FRWwc+A?=
 =?us-ascii?Q?gcag6vXH4kInMZ+XMk1xYDU7Xff/C8X3GSoIfGaVvHdGyaYOwqQmX1695D6S?=
 =?us-ascii?Q?KguSbtfNZhjMZ92mflZUriAkpKUjerCxeEX2jtiScxg1/ZVhp935czNzEWXV?=
 =?us-ascii?Q?sDKVg5Liqv5RxjLZaKKCnfWYj4QKf8yfTsmP/vcTGW20ISBGjc/YEQJbB6p/?=
 =?us-ascii?Q?rJjnTDulJB/s9FoZ1fbZ84vT59EUq13C6lcULlvZQBJOAKcub8pXao/SOZHx?=
 =?us-ascii?Q?lZjSJB1E6T+obptUOObEq7SKL5YkqTi2t8OcdRuaHBcOERpYDhVMzY1Gj9Gv?=
 =?us-ascii?Q?hmIg3FN52WpYAGsHczl8YCqXGhYiSexW14OsbnDg5OpzhHJ3YMf1T7IkLZZ+?=
 =?us-ascii?Q?xyWwtMseJ/gtl1LwbR9A8xsdEBcOzIgiMSKP7xfwa1f+tgPdqgk0Fwj8QwnG?=
 =?us-ascii?Q?eeF1DVMvp1A9cUdbB1GRPZBojr9DqW9c/jbf24TJBzaK5hUBL9U6rKVnNvm5?=
 =?us-ascii?Q?KUC5QT7PWIJA3pi8kNAzorP7ZZZD1GZwHNOSQEUNVdpyibRXAyCgptzAezFZ?=
 =?us-ascii?Q?h17b8bgJrUzuKsemVK3xJb1AfiZLEviJRe24vkILzdsC4zYA6L8YGL8lVuTK?=
 =?us-ascii?Q?14FuGX3unFSULLw5aX531CxywjdG6+JAkG3pzKF5YdwHE+fhOjAtdau7t2zg?=
 =?us-ascii?Q?3y+YEH/0qT0XbPhrLV93vc0/GntCUaiPB6i1CBOYWOkwuIPVR2TdpyFuRE3w?=
 =?us-ascii?Q?0A2yz0FI0pW1PU0QnYJRvWZGhnvweO5uNdqVe7NqRapcKcqyK/KNxLT36Sfu?=
 =?us-ascii?Q?g1EE65TqlbIBP3ryvsvhMy1pTn5UW2h8Lgo9zItA51WYKZpBtMclx7nJNOoa?=
 =?us-ascii?Q?7mOj+93fNbn7GN2DzWhTIFELiRm988Qh9nWSWI932R1j2ifJGw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11030.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hY30wgFE/D4pseEnyfIws/kVIbCdhwZzmQFVl6H7V/+MXHskdoVfBfqK3s7r?=
 =?us-ascii?Q?JqfhC9ystGlNJndCSmBuMKnZDKC9Cih2ecgqpAgrv2Y46fnDV3NEhIYQyx1r?=
 =?us-ascii?Q?sy0b5vvFptpWvff8E9A0AWApS7W2ewEkGGAP1Y2F9o/saBj1Cxnv0n7TB/Zy?=
 =?us-ascii?Q?rmf/ZHMOhr55u+2xYT8LQdGJ+ENewVZQv/3ToKN9dz7m3DeWjn+P4ixw2DIK?=
 =?us-ascii?Q?d3z5vdEceOUDpVwRQZkkMxY7yy2Emw5TKKHbN8uRy6Vo070geLrBZNfS+3jf?=
 =?us-ascii?Q?Z+QOEpZCre0kavApsu/Ph49sTFihch+wyAX5GLhZxLoMhgUgZGoWT8K/jAnQ?=
 =?us-ascii?Q?HBauzCVca5RuKsykm/Gzml2gMt1DDuJ5r0+zEMTPgqwvEgOhYQonZazfjxx1?=
 =?us-ascii?Q?f/ahErgyllGmCvdLGDEbOP2wF7p0SaetHvrxtE8axL4zfciqyIV8Rci8B6ql?=
 =?us-ascii?Q?s3vvwKohRFgd4GGmLUXFahsGT7C6doBEpXmA7ep3xwr9WMHZcLIwc+EZG5ZW?=
 =?us-ascii?Q?7TzHqwCGUdoLH6wYIkfNSmSLFDNluj825OkXm+FIIWkxwoegRYHXyzCDmOWO?=
 =?us-ascii?Q?+cuRDn1Dn+Pm6z8oi+AJdKkZIGB8MWdMf7e1JMrj9m+w/uZSiDJkfFnJ9iaP?=
 =?us-ascii?Q?yuHqz0zqN8Y5xtE3dlOj+YICJiGxsOzMRfU2sZ5EmKsB72gpKnITGQnmdA6E?=
 =?us-ascii?Q?B7J55Vs/aMOsTbPrHsFPF1u+89HDby+qPAcxwYvs8cvJzwX2errYPTO6kzcv?=
 =?us-ascii?Q?f8AR8vScKFoJE6u8OXCM3hdTP92N+PXQetpcchyHY6FW/UsjkSyfxJC1HNWn?=
 =?us-ascii?Q?GeH5NN0RKEPCHpFJlcK9rRbDSEY+ztQS5KhAxf9hmlKg8CW6+7Xn1NeXD6Z2?=
 =?us-ascii?Q?IQpf4s5cVgo0I31w6tZewz+SV1pNtagcyZ4IovYVOigkJMEoq7hlHLzMgwWh?=
 =?us-ascii?Q?Mkdwq9Av5GXP+WctkF9Inqk7XOIjLVUNJ7KDKHrhlQO58CjBn28H79css9Cz?=
 =?us-ascii?Q?LjSNnideAtBnHOpALOhU3gZ+md+6XIhTPmICrCTA+lSp42Q+10ZlRBLVNS66?=
 =?us-ascii?Q?rfJBDjEAISHtV3V0dYw+DdPhHziMNVM/Dr/l/j5kECIFpj27yIUvzxKusWJc?=
 =?us-ascii?Q?j57dzSmZ2j36wY0t/sMEE+dAm54Q70WbpTPk6fhc27VMJT/60Juw0yp1GQvj?=
 =?us-ascii?Q?Hh7Lu2vzBw5Nujqm9Rlt2nq6jdUE3zIa3LKl4O+KyApJlFMuo76jIniu64DI?=
 =?us-ascii?Q?eXqMY0usHYAeeJ+2Ex1YFlJglaF1tli0a4loawNHkK27cZMT/v6nh6YdI2xI?=
 =?us-ascii?Q?mowf5vvBMtWpKReSKiEyAx9YyNRwXo+1pruHKsfXmR2u9XLbOFU26sHoWExK?=
 =?us-ascii?Q?6APolRgm91VYke2/crb2whltUc8Mo96NzpqeXFG5x8HLkvOu2L9OY0Gjo6Fy?=
 =?us-ascii?Q?l73U2C0yuIMPesnBPTXPuvBjQ4QMryqlfPnlDX5K2M78V8l8qmMLlDnx5z+e?=
 =?us-ascii?Q?MnvlBCfnaLqVD064gJQkYUEfbtlsFmA+5FFIC2ZCSUpV/sIDeExOWQz5soYY?=
 =?us-ascii?Q?1G8OEpqqxmMEuKj8BE3U9zIoTbtpU1VE77MMDqCvgyMjcnATgaB71y6sz6rx?=
 =?us-ascii?Q?ZfDcFcOchRKBXGEKO5b0SFxaURkWcW1HA2qa7saOqPPMx55n/TBCZ+UN+f9e?=
 =?us-ascii?Q?u4d95g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11030.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f65134e1-6347-4346-97d0-08dc9af2b48f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 23:57:18.1534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mc5unvklDnzWxyi5u5Cu6x5WgEEO7g5tbSkLxk1OXAmyZRbHh2vblpdy/1ylhErAxR5UQmhnTspxk+oFf9oA6QlWNgVTIBDanCzeOOLlVkZT5gxDGK741iGRozPd5v5K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB10978

Hello Bjorn,

> From: Bjorn Helgaas, Sent: Wednesday, July 3, 2024 2:14 AM
>=20
> On Tue, Jun 11, 2024 at 09:50:56PM +0900, Yoshihiro Shimoda wrote:
> > Add support for r8a779g0 (R-Car V4H).
> >
> > This driver previously supported r8a779f0 (R-Car S4-8). PCIe features
> > of both r8a779f0 and r8a779g0 are almost all the same. For example:
> >  - PCI Express Base Specification Revision 4.0
>=20
> This item is too general to be really useful.  I don't think it means
> the device supports every feature described in the r4.0 spec.  I
> suspect it means it supports the 16.0 GT/s transfer rate that was
> added in r4.0?  *That* would be useful information here.  Perhaps also
> the number of lanes it supports.

You're correct. The device doesn't support every feature described in the r=
4.0 spec.
The device supports the 16.0 GT/s transfer rate. Also, it supports up to 4 =
lanes.

Best regards,
Yoshihiro Shimoda


