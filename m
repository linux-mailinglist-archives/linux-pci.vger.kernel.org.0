Return-Path: <linux-pci+bounces-44921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C12D23A99
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70423301E14C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1371307AE3;
	Thu, 15 Jan 2026 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="n41clYVF"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011040.outbound.protection.outlook.com [40.107.74.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99443330664;
	Thu, 15 Jan 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470262; cv=fail; b=WXL9SBoFBwP43swOX3agxPeGI193rEdbrS2xE+utHNtxdva3dcIW6qDdqT/HonNGj6/vRNx77HQaBPxZwC2RErU7ET2J0EaFaSMErxAveSJ92SseR/DNN7thVB8Z4SzYDPCALtg6lR7fQvU+CeNqPCl46b34uh54hWuzBafoMSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470262; c=relaxed/simple;
	bh=9Pg4B2Pn9/oZp4ZyYJDhZqv7jDsi8fnjPG3qnOh1t60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SaHRwP9l5MqomsBAY+043+nLHFG0QVYmVBwMBOs9BcyYECb+CDBCcRsu9vhyVwi4el5tkMFrMDl8P2xwpyiNuYJYaHuvlvXLV7PrPyFsVxmtcKmig0AdZUA+Xv/DSoo50caxbhraKGj4/F2VUc5U7SFP/qZAPDqnQlGtEjqnIxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=n41clYVF; arc=fail smtp.client-ip=40.107.74.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMo4GClS9Jfi4LQNKxU/pdNEV4gYGbK+hr3+RguMKd6RZeaUXSGvKJkyQGTCeb1iiP8e9VP49NWtqzXz/Cpm2DvWGjzfqG/6t1YPssrGqUOi2f4G8lULu7FdHrrwRxM0ompIp6MBmXzeVWJHEl5MgKIbWNVXNRxVY/9Np8JVWIOogHemQi8VzWEp5Ksqp9zQIdhDYhpyH8ArvN5fhUfBZCArg52DTclxRxiZoif3oT4Sj/Y4LrVf2xEYnVG9irgPIrutq037F6/mZ0Bz+QGccoShJl3LWc5MtfVI2RR1zKtD/QnjWFZi4JSAfTQRuzVbluX/7h+fwRRrU1YuacEbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Pg4B2Pn9/oZp4ZyYJDhZqv7jDsi8fnjPG3qnOh1t60=;
 b=wINDFydVEgcpcSlofwIwSt8907U1H/Wntz7erXPfhNgtLvmQDJfoJ8L0CMOQRjiGJhPXgjK8qI/s6ILU4r5oUHf/Ka6tKYVbZfqmjyioapEn2xasmCGDQXXMngUpUEU/SuJ5mJuUrEmIVNeU5mi8rHq1s1etG9d4TEjKpSmEOch+/rj5yOGGiTQQhgZfulWwjvUKIymhBRMi7G3882OMU9veh1Ty/VuuZ78/rf8OMJZm53iSmLfZd9uW6t+/sW+RlWxVlQf7w3xhFeWrUXmLvvHdGuIT8VeRNyjcmpeEgEnn4EydmC/gW3BuYVC1yHMdZtIKR1mnvEcuyO2/XMg/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Pg4B2Pn9/oZp4ZyYJDhZqv7jDsi8fnjPG3qnOh1t60=;
 b=n41clYVFybyDHu/OD9srev0YKsyAqsOMZTWwoaImEwFP3dSz7LqiIem/yCrtR/z+scIkTdUcKHsefDJ8Tn7SUSqSA32k8pocex1A7yTPfw56NQPFD4KKNdzG87N1cmh9ECrnMiLrdJluZnR9xD6JzlGT4cfJun7LUbzmUB59zyI=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB12724.jpnprd01.prod.outlook.com (2603:1096:405:1b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 09:44:16 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::aa7e:1460:f303:3fd8%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 09:44:16 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"john.madieu@gmail.com" <john.madieu@gmail.com>
Subject: RE: [PATCH 07/16] PCI: rzg3s-host: Make configuration reset lines
 optional
Thread-Topic: [PATCH 07/16] PCI: rzg3s-host: Make configuration reset lines
 optional
Thread-Index: AQHchWuKToLx9IuDAUS+0vMNyru0s7VSQiOAgAC5xTA=
Date: Thu, 15 Jan 2026 09:44:16 +0000
Message-ID:
 <TY6PR01MB1737760E0AECC6238219BE96BFF8CA@TY6PR01MB17377.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-8-john.madieu.xa@bp.renesas.com>
 <20260114223823.GA838499@bhelgaas>
In-Reply-To: <20260114223823.GA838499@bhelgaas>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY6PR01MB17377:EE_|TYRPR01MB12724:EE_
x-ms-office365-filtering-correlation-id: b07d5081-f37a-4819-48ca-08de541aa64a
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yI6ywaRgUK935/H8mGxAqen/tHeS6GkqiE9YKUw8lQEey2fXJnvFCNtc9HIT?=
 =?us-ascii?Q?We8UXcQfv9vW7CP1qL8MGVFdsHdxfa2ZKhJ4U96r5nAbAnE7bpQI/f7i2Wja?=
 =?us-ascii?Q?r3mvhySyvDfWHvd61ksIOSsSPJfPTunp8FN0bg7V+O+iiG9FYwCYxKLo4uAB?=
 =?us-ascii?Q?+Cok0sahrpnx/BMjL37m8WafUsnB4BERuzpAATwa+pr9YeGgD50q29EmZTzZ?=
 =?us-ascii?Q?atOB3nElACNL6GGrS8COZQabuk3MEbRhZq9RXCvnGBdLnaih4ASsteGOWCmA?=
 =?us-ascii?Q?8oSPYhChHf1rdzSGqNoO2rzRjBUezLrX/5faVTZ0gO4D9jPXs74ZuhKXhYiL?=
 =?us-ascii?Q?B+9Yt6kXHnAXyY/jQLCVDY9U1O+kQ9tM9UTjiod9z0lSHRAh4c3yQo4HTvZK?=
 =?us-ascii?Q?ahoaGbclpt1bXfYXevLWJ0xq8NV+44P6Eg14FLZ2/2/R9zcijh1HMxd+XR00?=
 =?us-ascii?Q?e2HJfQkehCmpytNnxk0lKbs8R56afIFw+jDbHuLJ2MOwNqDZZiiAF1C1oV2g?=
 =?us-ascii?Q?EUfyHd4bS68Jp/AToOdTzLWTHqkxU8Fk6Vwf/VFupJ3e1RrsZh99o5YzpOcO?=
 =?us-ascii?Q?PrXUhUNvlUV40wZX3SuKyOucRAV23SfG/OANwzGQsbq2gYLhwzFdZE7PtWOp?=
 =?us-ascii?Q?3Q6ipXR7HiTfBU8PtbUpbzB1q/2RYt765CqyFvPXaiD4zlHBDy1f3Cvrv0s+?=
 =?us-ascii?Q?uWJQ3VyTIp/zMzrUp9hlHmxrAkY4RCtY6IRY+OBWodNVFOBb0LlV+KseVPfC?=
 =?us-ascii?Q?zX+iERI12f8WRaWjKk+5BCgG/7zJcTQ45nt+YnsQbGSro9CTkovamLFmkRE+?=
 =?us-ascii?Q?AbOxmUaQVcfA4ZKIk33Fi6Mn/sskIzmAM+P60gI+c6CXNYER1VCMdJNC4d0M?=
 =?us-ascii?Q?RHK8HY28j5tB3Febjx1w+SAbQSBv8SHOVBISpaudbTU2sOsHaJe8U5gEvzZv?=
 =?us-ascii?Q?qw6UYsWHrhdLc3ZvvBuS8R7cuJBJ1nhDQF+AnQyE+Sk4QYbPhBYULYDGYTd0?=
 =?us-ascii?Q?EfNsXqAvycB02MjcGUhhuAzP871f9THjiVK6ttvhFSSiEaVjsf1hUTfgwLGq?=
 =?us-ascii?Q?kfYucpaOpC1na/QCB/8m5XFx1d2klz1dwRoBj3YJKLZAlLJaTWDLleGdB1iL?=
 =?us-ascii?Q?VWKgPZwSMgkIRH3aRBXME56DbdCXV+tJnanqUBhmQnxwRG77FBZla31Uj+1j?=
 =?us-ascii?Q?RekUmhFQNrcGNmJoMIHcSArJSO8vnn/JeFttGv63NpmoZIdafUbyYV1V6lzU?=
 =?us-ascii?Q?+EnVUfm5QDsx9J78gFXSkduGW1+YsjFwhfRk6fkfv2wDzVFs+mHgVGmdo7IO?=
 =?us-ascii?Q?HgsQnfDLL7twsDc2WaX02enjZWmsk6WYIvGWa2p3Y8PLd5J1lqvwbZEiuxGz?=
 =?us-ascii?Q?0txwICjzum/ivtU2t1VlvNb+50hm1JfhrgvzETW2NgujWQMYiJaYLpFZsDV4?=
 =?us-ascii?Q?jPHHcEtqmHwmY6dV78bRy/WVBVghzj8uLUzpYtWUJXSZgUTMZzuwuLNT0ycJ?=
 =?us-ascii?Q?f2wumFMhQ/lEl/o7ljUKDWu4ikp3/6F4nn8n14FzpnaiRIbnLVb3JG+HQ9DE?=
 =?us-ascii?Q?CxNCFQiBcPXDFERX4EIjt+1Afq7bZtW2yXmZejtNTDuO/hUrEW/xH6irvrFB?=
 =?us-ascii?Q?tQ3ffpBFJwhhAjMTdxe80JE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wFipldMnXup6dEUhCnJD5K7eTprpcdyPRXSlOJhbTgZOZF9UiHwtQfDyF6+/?=
 =?us-ascii?Q?bNYyMrRT5ZzV8gEgX/hRcPZrTrOcCayDPCxdnlzH4EYv2I+QyWmg0IAgWvcJ?=
 =?us-ascii?Q?rN7tvbPtMLQRI4e62bsSPmFcYy0CxrGjcvo6JDini3AXtkaM7DagWiNwg7g/?=
 =?us-ascii?Q?awD7n1f6J17ODluB1fGSAldt4zpPa6iENB7S9d2NvqR0tcgS5YwBjeJ5hK8R?=
 =?us-ascii?Q?pgIizCJl4+tClcsWttr3oB98mZ3T4QQo0ET9BnaTTcfuPGOE9Ptvp9B4SqbI?=
 =?us-ascii?Q?Ouaq6rcNI6jzGflbSPytKrDy6kA2/kJaVzMprwn27p8cmfzsqy4cugoYMjkJ?=
 =?us-ascii?Q?Lj0necyFVBMI8k8LiDd3XJ/Q1Fm/bc+d3Lpa1OpFuDtjphnGBAMXAda8uhX7?=
 =?us-ascii?Q?0XSfIZ3BgLl+fI9AxXgcPWWYvGuJTgJaKg0JGALIS62+asj5F+PFcJaur4pa?=
 =?us-ascii?Q?ppCgaYOR6aiESN4vrICvHhIJWX0bjz/l1PRyaxiUS6OGBy8HFpLYibuXcM+/?=
 =?us-ascii?Q?DKk0ThPxLPnfC3DEZMEixmZ1U3btWG1jEkaMVR0wHQObjAoqeD2IQPofeqpG?=
 =?us-ascii?Q?hKFG4/RNl4I98fdsVO6lUvl9rIlB8Hj52JdnA92m4YtiTpLKE2zyrXfoM9QH?=
 =?us-ascii?Q?aL7eZsnfUiE5kRp6VaUg4vC5Zu9KcyFDdwsu6ysW3yubvZeudVlpY+AtSvH5?=
 =?us-ascii?Q?UWLg+iTdhrbKZKZPyPEjIZEXhndfztUTzpv96RjkogpyI0qSxJJjIh+2T9s3?=
 =?us-ascii?Q?cJoT4oF0xX9PbfPwpZnhdlIAqtIzzvFdcSSxdjAmnXnfnVzOH/hkWd7HwmHA?=
 =?us-ascii?Q?dP2U5zEgROlyS6KOuIE6GzyKd4pY/P4oWVw/5vPYEemyaEYMDlVARLOJ+Iy9?=
 =?us-ascii?Q?Cj7eRuKpTboKyiKeq6HsjczkvLXP7A6TPlPtBb398yEuaT1FV47A0dMs2S6R?=
 =?us-ascii?Q?OQ2LFrbFoI38mtFxsiTeZqAuGT2z5+ON/AZf/KktPffprhZGYJ8Fg5zW6PqB?=
 =?us-ascii?Q?t/17dFPMkEC+/UjvhakgYaGE/chRHsHuHcHlL7MZTjiAppdUHbQyllTeZR2h?=
 =?us-ascii?Q?oHrHT418rbQeJU386gCVkpXzYErTcq2a924zSPNr1Ig55le36rV7G6a3bY1W?=
 =?us-ascii?Q?Dzqfj+2K0XCQnJlq23YmGNGCzYwPDn1QKqTxl3gUZ3HMeqCwVaaQ8ihKx7JK?=
 =?us-ascii?Q?ON99BOGwChRPjhf6ywuo0iYvgqCUwPycBZzTpWbOdApDABWxn3B74VeLTTcz?=
 =?us-ascii?Q?0KZO1QKCT7U3xxrY5O2rEBSpMTQHoTfwgCmTs6kdKi7uHmkqEziqBg0eK8qs?=
 =?us-ascii?Q?U3fg0pt7KEoeD9zeOV7ihIFtMzTNoz3MDYP+erMnRE8PZ1y1ojhLyrY1tJdw?=
 =?us-ascii?Q?nC9GB/fSH+DZEzCRQpgGp+E1hQr5L3aVCYyXqas0auCO34nQaBH/wgFJ2Tzz?=
 =?us-ascii?Q?5hBjGqrsnG14Gvh2jfkd7MA7siSpkCNAbYrK6KOHulSPZWX7hdtfiL61LK1p?=
 =?us-ascii?Q?+9v0ghI0X2dYLlHDvOhxWFcf5js40lKUEEYE7UOIME4zk1bB0Zc8Pmd+u8Wp?=
 =?us-ascii?Q?Mp5QxG7nVbKqQZFLoVpOmNQjdrRMUxoDrNSbsV4uUkdqhi1UvvQLiT4YwIv6?=
 =?us-ascii?Q?Lxtb/U6VxWdA3k/qGkpK8ukzXL7ufICSiZcyHkObDfaYcGaPTDUQcvkFWhcO?=
 =?us-ascii?Q?UsLRvmBW0Wm5ixCpNf9bEg1lLkqbhDqalT+gsaH7ddD1+xoql1NeBqYcfTAn?=
 =?us-ascii?Q?o5UgWNHrdI/UBxENio/JnmyaTJqH+hs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07d5081-f37a-4819-48ca-08de541aa64a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 09:44:16.8371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nDumRJUbjN+qTZVRIjZBpoJDRf9Soiaye+dsRVD2gZS5EW4FAHARTtL0NyLPM+BQ9Ag+X3A1l+C5nTmFx2+4JEz7Q2IU4ZgeDBrYFIewT8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12724

Hi Bjorn,

Thanks for the feedback.

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Wednesday, January 14, 2026 11:38 PM
> To: John Madieu <john.madieu.xa@bp.renesas.com>
> Subject: Re: [PATCH 07/16] PCI: rzg3s-host: Make configuration reset line=
s
> optional
>=20
> On Wed, Jan 14, 2026 at 04:33:28PM +0100, John Madieu wrote:
> > Some SoC variants such as RZ/G3E handles configuration reset control
> > through PCIe AXI registers instead of dedicated reset lines. Make
> > cfg_resets optional by using
> > devm_reset_control_bulk_get_optional_exclusive() to allow SoCs to use
> alternative or complementaty reset control mechanisms.
>=20
> s/handles/handle/
> s/complementaty/complementary/

Thanks for pointing that out.
Will update in v2.

Regards,
John

