Return-Path: <linux-pci+bounces-44789-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1109D209FA
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 18:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 62D3C3009D6B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D91329E46;
	Wed, 14 Jan 2026 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="qNi7PCzq"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011002.outbound.protection.outlook.com [40.107.74.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39346328B40;
	Wed, 14 Jan 2026 17:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412867; cv=fail; b=oiykIrR3gB/cPVQNT+LNGS2Tv71EfnMFX066rWw94B5aalWGmOn11NlzY1XeKwSArS9pdTQ2CFjoxNIlNzVbqDkDdhFJBCBMpUNpXDhx90P/BgIZhRN65nuKhdsOwjJHspbv/CbNIP7HqvvmWWvHrxJ6JL7x3F5X6V1jg1OM0uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412867; c=relaxed/simple;
	bh=p1O8L+TbhvBOwlYdJgSCMx6325LgXBzfKzAMUHuo8js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iI+breWTjoYZWbYRxT6Iv/Yq9ItE5GE2epGNk82e/M8N/4XJKef2VJvBXp3pwCWDl2xn/OVDb9iHduhkGADwCYYvyvsXkJfFBkuqI1b5su/K+WRa/PlqYD/wUnn/qrMS4DB9pW8eqhHWtTgCyfSuPJLO81bAp+rC5AvdvRSaDkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=qNi7PCzq; arc=fail smtp.client-ip=40.107.74.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTrnHgVhhpo+dMQI4qKi63PXXoZMTwoW8ChDxjy/ezab3p9W1gKI5lMBNx1UsTnlMv1eEbrJKpOxxREaqhxqFaCSLkm8Q+YMsGYe58uZJL2G3giHf8VswuLTPLqI1LAj/qevoMuaAn19V/Pj2rrZjVzX80AKqtmFTFzahBePYIfzcQsUDVsLXt4YgdUHGY4K0SuFAutRjRka8d9s9dYD/zsIKhtPVJ2gcAu0Oe9eeuQ4DGrwgQwpqLpIsOvFBJrIGt0P0wRXK/Yd992tbGfPUTbuZCPPIFUVfj++NZ3uNWGrA7pEGeHwQcofa8y6zRsN0IGnOSpq0zpPIhzFjcngIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnTKYpDbTyZXjFs5CwBDbeW6ezp9rfqJd3ihZXvnr8c=;
 b=Jim9nXLeIS1a3XI+dFeaD76Isjii3roEioLnHkibqH3VzCVXdFNRTsTYlgYpo9TzlT20ou909JnupsFieIGWxm+JZBo70CJ2KGPQRuSBMfzVuyGFD9d1vz94aWvDtwGrxoj00+FEe9VYALnSVZuT3ED4fZWUt5rageJHFDVWn6mCe+WlXMriBgl7MBbwlrZFJSNX8gLdT75wv2mcUPJ3hKU3Ft5FofJJ65Cp9q8XzsTxxj8mm1wwTEBtapuSN1NeCuJUIVYieMyOO9dmJKI3L2L1dWYbw+Ig/DRy5SNmU60FLjYNqFq249CMAK+AEnfgBtT6HIUHOWsX8TZXR76S9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnTKYpDbTyZXjFs5CwBDbeW6ezp9rfqJd3ihZXvnr8c=;
 b=qNi7PCzqgH0T1beQ51s+jYtvqkYeIrtxAT5qtHM3SRi9qqdEGKSi/GlTtiHXeYrHfmHkuFpiLZBQgNZAW6NFtGcBVYOrWHlamHpICwfJKY/zRijNBuisYnBpgFYsy4Oy+TUvWiTdsf+Lyg0SQyVPqDl957JAeK5W7QxxTbmDlA4=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8145.jpnprd01.prod.outlook.com (2603:1096:604:173::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 17:47:36 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 17:47:36 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: John Madieu <john.madieu.xa@bp.renesas.com>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	magnus.damm <magnus.damm@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "john.madieu@gmail.com" <john.madieu@gmail.com>,
	John Madieu <john.madieu.xa@bp.renesas.com>
Subject: RE: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller support
Thread-Topic: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller support
Thread-Index: AQHchWtwA+Ax51VNZU+Vfidd6Z+H9bVR8F0Q
Date: Wed, 14 Jan 2026 17:47:36 +0000
Message-ID:
 <TY3PR01MB113468B042E34541768F3E898868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8145:EE_
x-ms-office365-filtering-correlation-id: b3690ccd-e598-4b32-13e1-08de53950107
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?K4pgYiEGaj7GYfqYV7VELhTwevz6wHHSRCSSW5OCglWXc1kFBsci7TpYAE2z?=
 =?us-ascii?Q?QOJSVEj3y0Flnw5nZQ+ZODoxESQnVaohujJeCFgv9qDxnjRZWtZwPONYnpwl?=
 =?us-ascii?Q?sE6H85OZ9TswIZsG+yXTZ+kjwoj009ugXBcdTAN3qoHnJfIeahnJeAFk3f6p?=
 =?us-ascii?Q?h2Vqtpmio7AqFah+O7mFDeY6+hvPB+RAc43oPtKt3wjqyB5H4hYKDgeR6bOg?=
 =?us-ascii?Q?4CvRlUNiCdozndTPHRXh4BT6c2aodsAnay2jayAxPt5xraGNn1p1C/7GYuhe?=
 =?us-ascii?Q?ezb/R0ipT2n/Vt0VDEpWBT8zGFm5MEhFwqJb50Oyd4qhlxwz4Lg8Fzpw6R2f?=
 =?us-ascii?Q?MjWKozlcO6QCsNaYluywXo5IU5B59A7nmkROiMfY7L/C/iHSAsUGCtIumnWl?=
 =?us-ascii?Q?GWDqaGa9ofFPsOeuKpbo2m8/S9sM/pdl7aLguvbfPmuY2VnGL9+B0gzLPN1e?=
 =?us-ascii?Q?53Q7y5U3VardLXKKjZaHAEGJWQLK2gmxN09aJDgXhzBm55Ycxcx40OPakvtT?=
 =?us-ascii?Q?nKQe3RqS9UsTdSoreGqermdMPgib6/oVp9tTbRpXWT3rAGgNa8JtBnZHyecH?=
 =?us-ascii?Q?XtiW9BdRYLJ4zrJWuKaCLe9pXzJMjdA+VxNJCf5nKlVZVeZ4cua+BKBZ3JjD?=
 =?us-ascii?Q?r4JIjJoflGCkUaYlozuUpuXUpYgv3K3MulY65gCLiUMK9yDR33IMX7DE/5bW?=
 =?us-ascii?Q?+NDLtvzAQXlUbTCMib+F6ENJby6m1hFyq4W1n5rEdbokYUyYsc1Libj5XlXV?=
 =?us-ascii?Q?qoHrgrtc7GcGYJQds7g+e3/ep3NAlc5CJhN+OBKKuzZxhW56DNkN6of35LYt?=
 =?us-ascii?Q?4xEeD5Pp4C/zomOS5vTTNsUOs3XIkaNPjWc4aWxTn6F2Z5Mvn1XcVDgmTNwj?=
 =?us-ascii?Q?Dwwt3AFyoXgYGbcTPj17YBLXsRl+F3FAQzpZ2T6lWn6pmqYzjF+L7QWKS5mk?=
 =?us-ascii?Q?TcxCM01hgQ2msRP8Ob8GMZETbfKrsnowTG1wK8SKjBsBcHdn464l1zB6VQhP?=
 =?us-ascii?Q?wUoEKn85Ii5hNA6Ih8zAjfle392CZ4xCj9D5hhnUYGsgbrzbDnEUwPadNWOH?=
 =?us-ascii?Q?L0yuUYR2u3vjNoAhKizHy6I+lXp9vAQrVdWRB9ZsTFqmPpJy5HT//LRn6iy7?=
 =?us-ascii?Q?TK5KvEZdwYp+5i2IT+h9i9inEQxqVbIk1wKDmziJEuGd1VZbNElxJ+mxCemM?=
 =?us-ascii?Q?EL/KBMRRJKVmikATFLQPmqcRrRvVI1IS4p0z1G7eg+1am0d0GUFFSc63rmsU?=
 =?us-ascii?Q?ALQVW/JeSRXWKvXb03A3T42hQeYvDwZu+yDrw2Gg6oyHOgYDtoET9VRppKFK?=
 =?us-ascii?Q?7t8YhmeyNBQX+vyuZjbAtkGa4surDzxQKucq0PPHDJq1tNxgEVYIJdDaFcP0?=
 =?us-ascii?Q?TCilWkxaCV5An/RJYkEbZ5L+t5NWfPO0jQ4QTi0M0NFpzMtAksX33hZz1PWx?=
 =?us-ascii?Q?J/IvWfXrLW211BzpN/zQs1Er41SKAYseiS5TtzOskadUz8lMDO9+UmEHkP0l?=
 =?us-ascii?Q?v8vURFCJ3ZGNEJkr+yKB4JljfWW9dWiKf3QUqnHweAcgyPAnmz4e+kRwG1NO?=
 =?us-ascii?Q?QCGLX1AZ9/WJcy/2g8y9nOqfQk3Z0r0To49LNE7q8S+ebM24XO55E40ECq+3?=
 =?us-ascii?Q?DR+xghFuYwvVWzb1oMUyJEo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fMN4t9YrIlqDPGVT5WIhdhWKeBVCLuTvtiMJ4+yoaudgbPqNnwEfgVVYRRhe?=
 =?us-ascii?Q?5sVasH6Y2qt9mhKYGWdahQVz4ROHmXv9T7rvsqUGQJL82Id0G7qVv5Q76pG/?=
 =?us-ascii?Q?XXHhuG7kshFKPj6dm/EQ0jJf8f5920dYcduAra+ywM1BHHmgb2XA9uXfA73K?=
 =?us-ascii?Q?fi2ZEGJZhKj3bI12/rw2xNRsqkLmZ3mRsftGgfR3u3/AVWIfffunLRQV04Jd?=
 =?us-ascii?Q?o5A8F3eigxVdSHgqn52XtvV3e0s2+gI+eDUioSnIAA9QHenACKvOM4bX69jt?=
 =?us-ascii?Q?w2gd8S9pJQu6VASkf0lUtV0hla9sN8ZzIYs36rvZg9NndZMVUwVZ9SxK+e0E?=
 =?us-ascii?Q?zD6Bb9Iq2X/wFdWVHty5OjeZZsAwgjd1OliW6KZk2EZ6RKzstzgLcJbnBXEK?=
 =?us-ascii?Q?eiAhSv9A9LvZTI7fX/oyaw8eabQiSI7iVki1FE0sn1kKolfsoU2K84COU5Yh?=
 =?us-ascii?Q?jD/fGf8tcuCyEN5fItLqdZ64W8jXU8WsDOBFj5hw0z5FoAiGTtg9QpsaZdTd?=
 =?us-ascii?Q?llN17iQNbtZ72PTuLI2b/YPQv8u33zoKcaBPKvoOIqog1Tf2ugu7o6/64rkB?=
 =?us-ascii?Q?hRHUXE3CjyWBAPZGNMcEr6JqVBmqMQlqGAMaUuGkavRbbMKox1m/UIQQjsmP?=
 =?us-ascii?Q?HvQAdsf982x/qgwlA1mCC5jbXiY0R/6RncJEwmRVI+A7ofoD2lt3JZDxNqWf?=
 =?us-ascii?Q?8NS+ISai2PT3AL+ejhDHQZ8WzDCKWfxSzLwjZ39SkB/Bn2bxwnYJixUIBE78?=
 =?us-ascii?Q?f4NLsLBiETr/ANkySbNo52U0AL+G04xU3CrhH3NaYj8bqlgnVzjoP1FV78Vb?=
 =?us-ascii?Q?W+GdORh6GoTs2mAG6xymoOoM/fQ6NbaIDAPlZXitfiZ+fQ6jJPBu5t39zXHt?=
 =?us-ascii?Q?Az1g50UfDhYPjWc2RRjhAdwTNtddBh7GAD+0tvJBOyOWEDhbBXPFidF7P9gC?=
 =?us-ascii?Q?6pWrY1S1akryMQyiaSHMn77CvvBB5n6tOPhJDsVUyn1VsY/zXJ8Plyb07/U3?=
 =?us-ascii?Q?WAnCbhYAj9xAEq04/vxHtMd3ZcU1daqxEompPtDtfWyVTGdRKk2vu48oHnpd?=
 =?us-ascii?Q?mdLALBEz1GvM087PZ0HOTN2UoecLMtIU4dLJCacgwmoqUYLAkv5g/mR5qULZ?=
 =?us-ascii?Q?iyrSqEe6KR1e174NTKZCkeuo8T1g1PcLFpzNxaZKpid4x2Ms0uPgxNSPERqe?=
 =?us-ascii?Q?4OJRmS3lGbytFnfHobrWaK8UvjO1/O5Ve1HroKAhXLIDjT8LgOmOumAGCzHj?=
 =?us-ascii?Q?/D0owsPknHufte8l+/WieN1pedXfBUPVeqBUbCM7lcjSVOJkEdo3i+vcmP53?=
 =?us-ascii?Q?IMVEHknEyaGJFhryabzDo8jzp+3Ja4l+xvowE36ZDz8oHJrkJ4EaGVM7eE4f?=
 =?us-ascii?Q?dSTa1wLp5+XwdQvCJhI1MuJeWXu2AOgLAoxGytKbJh+vESjv/DM8B3XgzINJ?=
 =?us-ascii?Q?yb7AWtVBH9vr5W3sD0uM/KRJAyUl3qsMRaNRyFK9se4wdhAxBpGzMN3guETt?=
 =?us-ascii?Q?qS0JpzUBg/PZ4jsHv1M3kZsqSOmxHZPK9JFSi9+3V8IAC0HKPAmDZg6aLaEC?=
 =?us-ascii?Q?u0Fdd5Cuo1cx4+/lAgcMfk7UR1mXvTyiu0dz5vFEFBnlTVVV+6eGZg4l1XgD?=
 =?us-ascii?Q?9lgbgX9qXg8Hg0bfbYwkEk3KwU5de+ctWM/iVPxoNekDBqzzVqWXoFSdePoX?=
 =?us-ascii?Q?tU67N86PWvzgBQSNT/UQiO3BMFLnW0aivSA6iLFx+K8HzHy3azy8vSzeDSmc?=
 =?us-ascii?Q?P+8L7YalUQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b3690ccd-e598-4b32-13e1-08de53950107
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 17:47:36.5137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PLoHQkkTehOpFJ6VGvi0LwUw4QOFv2kuuQB25N1NSTLi/yWN08x97pGiB6AFlvXtReUpPjny1fb30i5btf8/q2r6Ytou1k5dEQvGYZw4a0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8145

Hi John,

Thnaks for the patch.

> -----Original Message-----
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> Sent: 14 January 2026 15:33
> Subject: [PATCH 00/16] PCI: renesas: Add RZ/G3E PCIe controller support
>=20
> The Renesas RZ/G3E SoC features a PCIe controller that shares similaritie=
s with the existing RZ/G3S
> PCIe controller, but with several key differences.
> This series adds support for the RZ/G3E PCIe controller by extending the =
existing RZ/G3S driver and
> device tree bindings.
>=20
> Key differences between RZ/G3E and RZ/G3S PCIe controllers:
>=20
> Link Speed Support:
>  - RZ/G3E: Supports PCIe Gen3 (8.0 GT/s) alongside Gen2 (5.0 GT/s)
>  - RZ/G3S: Supports PCIe Gen2 (5.0 GT/s) only
>=20
> Reset Control:
>  - RZ/G3E: Uses register-based reset control mechanism
>  - RZ/G3S: Uses exclusively external reset control signals
>=20
> Inbound Window Configuration:
>  - RZ/G3E: Requires precise power-of-2 window coverage with strict addres=
s
>    alignment constraints. Non-power-of-2 memory regions must be split int=
o
>    multiple windows to avoid over-mapping, ensuring proper hardware addre=
ss
>    decoding for DMA operations.
>  - RZ/G3S: Uses a simpler approach that rounds up to the next power-of-2,
>    creating single larger windows. The hardware tolerates over-mapped reg=
ions.
>=20
> Class/Revision IDs:
>  - RZ/G3E: Requires explicit setting of class/revision values
>  - RZ/G3S: Has default values in hardware
>=20
> Clock Naming:
>  - RZ/G3E: Uses "clkpmu" PM control clock while CLKREQ_B is deasserting
>  - RZ/G3S: Uses "clkl1pm" clock for power management

Typo: RZ/G3S and RZ/G3E swapped. FYI, the upcoming SoC has both clocks.

Cheers,
Biju=20

>=20
> Phy Settings:
>  - RZ/G3E: Does not need PHY settings as it works with default hw values
>  - RZ/G3S: Requires explicit PHY settings
>=20
> This series extends the existing driver to detect the SoC type from the d=
evice tree compatible string
> and configure the controller appropriately. The updates are minimal and f=
ocused on the hardware-
> specific differences while keeping the common code paths unified.
>=20
> Note: The clks "PCIE_0_REFCLK_IN" and "PCIE_0_CORECLKIN" are added by mis=
take in hardware manual
>=20
> John Madieu (16):
>   PCI: rzg3s-host: Fix reset handling in probe error path
>   PCI: rzg3s-host: Fix inbound window size tracking
>   clk: renesas: rzv2h-cpg: Add support for init_off clocks
>   clk: renesas: r9a09g047: Add PCIe clocks and reset
>   dt-bindings: PCI: renesas,r9a08g045s33-pcie: Document RZ/G3E SoC
>   PCI: rzg3s-host: Make SYSC register offsets SoC-specific
>   PCI: rzg3s-host: Make configuration reset lines optional
>   PCI: rzg3s-host: Make inbound window setup SoC-specific
>   PCI: rzg3s-host: Add SoC-specific configuration and initialization
>     callbacks
>   PCI: rzg3s-host: Explicitly set class code for RZ/G3E compatibility
>   PCI: rzg3s-host: Add PCIe Gen3 (8.0 GT/s) link speed support
>   PCI: rzg3s-host: Add support for RZ/G3E PCIe controller
>   arm64: dts: renesas: r9a09g047: Add PCIe node
>   arm64: dts: renesas: r9a09g047e57-smarc-som: Add PCIe reference clock
>   arm64: dts: renesas: r9a09g047e57-smarc: Add PCIe pincontrol
>   arm64: dts: renesas: r9a09g047e57-smarc: Enable PCIe
>=20
>  .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 243 +++++++----
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  68 +++
>  .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  11 +
>  .../boot/dts/renesas/renesas-smarc2.dtsi      |   7 +
>  .../boot/dts/renesas/rzg3e-smarc-som.dtsi     |  11 +
>  drivers/clk/renesas/r9a09g047-cpg.c           |   5 +
>  drivers/clk/renesas/rzv2h-cpg.c               |   9 +
>  drivers/clk/renesas/rzv2h-cpg.h               |  18 +-
>  drivers/pci/controller/pcie-rzg3s-host.c      | 393 +++++++++++++++---
>  9 files changed, 632 insertions(+), 133 deletions(-)
>=20
> --
> 2.25.1


