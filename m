Return-Path: <linux-pci+bounces-44774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84252D20288
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F3C130021C9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2030927A92D;
	Wed, 14 Jan 2026 16:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RDV67P09"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010023.outbound.protection.outlook.com [52.101.229.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED5F2DAFDE;
	Wed, 14 Jan 2026 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407608; cv=fail; b=LAtbxdE0AU5BFzdQ56Da7M9uDQjBnW0L7SPk5D6XPx+M62nrfaFGJLA9CahxVX6VKblr/3m8mpRbePAoiJTwox1ZB5NtUdFS+UPuxnGuztMvVdcj4VP0/2Pvv3LjzYkGxMPvMle3fDlDRSL+/GBVSVqbsV4f1bTqcQxaBZJwMIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407608; c=relaxed/simple;
	bh=TrkvcmZbey5miY7n2vvIlYztymBaaC5hT3Veypk+LMk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/mltkZsob50Y9rd1ghxAhF0EKrYMLoFqIXC/1iSl6cGrXvwYQDSCJlL2FmEuaF6ftyUV+dhz+Xsn1On9KlUegmH2iAQVkoVSVxBkYbKNDmJaG90TNF0Y4EZ6NsxoBVzWB0G/FO5WORZZU6wLaT/ZUNYBwE92Z+rkLyET+yQBqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RDV67P09; arc=fail smtp.client-ip=52.101.229.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOQ69wB3t+cvkP5odEt5gJX5e5tGPcaA2dtlWE0nUg6MTZHzPBeO+MNRjD2WWngl5Hxdqhv2EdBWMeo6T1eUJniEfLjgtDxnhn/kiM+iWTCI2J8Cy4Ok63fXUhoiAHjGTYKwGsAovwOJ/AfnirijpqoLgiH+S9/HuPRwSvOxFJfB7bfHGtYUMqzbEkyCJ919aepycVXWU9aLAP6Bp8nJ6Av4gSzMv9IxSEftJ7FGYmK1qM4fwBFARo5XZKzF6qh7P6HJPPcP79q6+Zjs+YgzDyvXQ04fWiSAZHrgAr7gZdNSIhfedpubhZG2ymDFKd2CwjFmI+0oG1Ubl+uf8jkG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6at2fO50jcNixEUF3OkQOlLooULfhc5HZ9D22RuQ0Gk=;
 b=Sy6uJ48r26yp/V4nMKTGagAWbRxCRRCEt033sYBzM+wUF4gEVSVu1RtMgROX6p3i0dwJC3ky8SXJrgFXGZPwgKVkYPXMgdMH9kZp31dgHT9SkUDTouKJoBco7dbikJWLhCu4/Nx+GQpLUT+wVJNCwESzl1LrPTzJxNNlAk2mBHoHj7WaBcbhdk+O/ZZ6emO+Gxc2puyHOmuVxoceqnj5IIGm4bUJiVIi4jES/w4GHPrMtDmhBqNg08BmNtjI7Cnq++lP8D+OqLXskvnZOtOhQDIUkK0NbQgJHJR2O8uzUdYk+NfG58Ih7NeDMW+A6QkRbpgBUuY1X8kmW1OSRyqEtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6at2fO50jcNixEUF3OkQOlLooULfhc5HZ9D22RuQ0Gk=;
 b=RDV67P0904TvsdBQ6BBA0rfS2OPnOmdsaBCsMowoQ/FQZbsTYaSwkY+9294SvkQ1whh9F9HRlVQvj1t1kQGdLJIX0IFg1YgCkodiuaOX7modlAZ4V4K1XSx1RqlBehWOrwYthLQKDXfdl2NIrg/tk78ZAlYlOsG5X1Ea+iTo2+8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYRPR01MB16860.jpnprd01.prod.outlook.com (2603:1096:405:13a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Wed, 14 Jan
 2026 16:19:56 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 16:19:56 +0000
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
Subject: RE: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable
 PCIe
Thread-Topic: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable
 PCIe
Thread-Index: AQHchWur9/nIdtd5C06yYiYnWalkELVR1xQg
Date: Wed, 14 Jan 2026 16:19:56 +0000
Message-ID:
 <TY3PR01MB11346AE1205D35A8D8BC90B9B868FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-17-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20260114153337.46765-17-john.madieu.xa@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYRPR01MB16860:EE_
x-ms-office365-filtering-correlation-id: f6ab8f23-4370-4035-6396-08de5388c197
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x7kXBqosul5ZOUlIAMhK0hqu0PR8hniYq5D1QH5+2LRFKyzlfM0l2DDiNpOV?=
 =?us-ascii?Q?dyt4yVnNd9Dnvsnapmh+owVs2teqx1jH2lMklzIhDXKwVj6AkZ5RJfw1/p4F?=
 =?us-ascii?Q?xlaf5FEfOlZxGdBsl0UhG9Z1DkLPTuL+rqGTBfFk+W/X2BD4xyj3lPn3W7jJ?=
 =?us-ascii?Q?CKpm5LAlqRRkw5pbDt9BDfkPbseMA8kkh9sFIk9/1HOCVw5VB3naqC6KW2Gs?=
 =?us-ascii?Q?tG6R1Lk4HzTBixmqSQct5SsdCeKVQuCHyVt1eIIVAyY5liWj5yUFwIc+ao9N?=
 =?us-ascii?Q?eIHCkL3Ltb1CVy4U30WnnJixaIt1UlPSML4c2HTz+0W/XGNwDzJ3pjn9X9YH?=
 =?us-ascii?Q?UFcgSQ8cJpD6Fu5dGUr6i97iNSSxg8XPhsjoNLNP1Vgm6a1doSpUL4U73fgm?=
 =?us-ascii?Q?7WIIf4ugIGUN+5U+cdis86VpQjWtFmF2d8MQM+z7s/DiAbpNLbZht/sAQQ7F?=
 =?us-ascii?Q?KWbWAZxsg4OiWgIFEG7xZXx9OA8BObbm3Y+NU3AYbGOIMXXZpJLuzH3yV7I7?=
 =?us-ascii?Q?HM+yOEQ4gQDN2fpO152n1F9FeL6PaHbcxPoYqQi48xC3OJY/coKujL9voqc7?=
 =?us-ascii?Q?mCgRn6JPv+TVjKdrqMwGYCwW91GiG57qgyg/EFyIBTj7fEJs9riQx84/ZPWS?=
 =?us-ascii?Q?NLZwQlc0hORlTFG40p8bQ3A909iJFHM1IIz+GMrGh9SYSgITDSsQP1hfdzod?=
 =?us-ascii?Q?2oyTBKtrqoqg3qDljBov9OFXJMQ8HTC23wCftf91QJj0Nbt967dlT4cwQ/EC?=
 =?us-ascii?Q?6rvPjNpoJ7pLB9VCAiHk0NAmWLU7XrpeIOHlCnJ/mVSRoeQ/GrjvNW27yIDb?=
 =?us-ascii?Q?WOlb42B6ach0zJGnlxPDCK7BZxNnNLQua1zZ4SUFbvr/HwnjRfW4mJMeuZOA?=
 =?us-ascii?Q?vAh1fm39j6jVVPE034RVTnVRDJIn4SEfUF0WnV9DWPDTyUmf6VqslVggxjNP?=
 =?us-ascii?Q?2GvuA+Mir2FYRC8mUerXay0M5sKvd2VduGAIXJ+s8zyf1zQMyqGHxvjYWWty?=
 =?us-ascii?Q?syJxOPNxEvyNiMe86/M9EcUREj/CnnEfJqpJFJpsJKXWLyDKS5xLAxU2zmvr?=
 =?us-ascii?Q?gCkEXZMOSd+WoyyHkGOKnORQDaXtOs8a4eUWCRQ2Jp4BIDg575w04Vpsbj7y?=
 =?us-ascii?Q?7A5kys22cGLV8oHdxGvhR0FNC2X3+mc9xQPr9cDSz/NbHVppT2YrZTqtA+W/?=
 =?us-ascii?Q?GYOApRaI6iJcd08MINPFX/bPmFavodgJscWa0vswG+l9UjRSceYmakmzeSzv?=
 =?us-ascii?Q?gSY7sdRDAuj8/S8F6fF0PuOXctuTcS+LKt22aI1s+/in3oc0v0jlMnUBr1Rb?=
 =?us-ascii?Q?0cQfP1mSF/Z4oCcJkPQMo2F6ywoH2FEz2zpugafFnYpVWs7eUsmTXezZt6X5?=
 =?us-ascii?Q?FX3oNaodn2YJ7+h0OxSe+859WbXlVbGNuZ63HMXWx9pcRsSpUP082r5Jq6BH?=
 =?us-ascii?Q?18CcvuItL1Bm/l1YR+qes4O6XlrTVh8Vg2pr37udyzDk3YVSniMd0a6bQO2P?=
 =?us-ascii?Q?FA86689PGB6GmOfTBrVLnnGMwoaSHTlSJERf8aASSRKfB9Tu7fT5TckSHegr?=
 =?us-ascii?Q?d4DaiwLcjAdEk4s53VVwghJeeDHyE6r/aDnkWgp90dwZWRAbCwA8dhRj8REH?=
 =?us-ascii?Q?rH9tF15yjCqPMM5YtCPYvQY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6tbx2jvPzvWBiXD3XOq9BYo/OP0z1yo8aJ9dGwjBOVLxr43k86uy8Uvw/+cv?=
 =?us-ascii?Q?+lBjXgHSGFGjCqGZHGD2K/tW9WKlSxQY3lzWzbB38VAQHnXjMMDI5eYXc0Dm?=
 =?us-ascii?Q?2FmX52xRfGuwFx6S9US4toviUQiKI8uLF9ozEZnvISFatZU2utvgRYukRE9D?=
 =?us-ascii?Q?wm8wnWGsH10iIma8hAjoGS1VcfJ6OGrxgQ67Y6ag1oQ9jkrXUms6cnincd/6?=
 =?us-ascii?Q?J60/O9wGvVeXKBtPRi148hWKuSapsskSsMTrz5BA8Ck3eWKI+FlsYH/mXwSM?=
 =?us-ascii?Q?sSgy4Jd8Ms2YiFyGBUaxoBD7Sw1mJtrk9eDlQ9eEDmkXjgEXjN1PKN1gC6lE?=
 =?us-ascii?Q?fBfpxr/LqKgfvw2TKEPG55BNT0hp8vvJXjRCAA130HuLRnZMXpbRUSAPTw7W?=
 =?us-ascii?Q?lkDSGRms4LtA6y5TgKopQFmPvyCiYolKfYT9ZC9PfoA88A2XP4au+P5sLMbT?=
 =?us-ascii?Q?Hs2Wkxsqwb7bUAY8BVUp6t5eNIVXId/1fIsgFCb6pQEpCL0sZx+3UzOCU95t?=
 =?us-ascii?Q?rrdYL6lR0gdq/LThBILy7UqScB4+W8dwcTUxiZl9oN5U213SQdFqOkxH1eID?=
 =?us-ascii?Q?OTwWXwWvrzykM8s0iE5yprUeOXkp0Hr2VK0Lf0R2Gc/lhaC0e2kQXn6h58oM?=
 =?us-ascii?Q?UHXc5xKsgEvhOk9cna8Apis7uqD7WibEeEfkrDLYiRJaAAaZzJaAgjJNoLVv?=
 =?us-ascii?Q?HvpbHtHdtjETrz6ZxFHy+a5h22yhx0aMQID6OtGLDVJSDJHbGHoftA54Ea6S?=
 =?us-ascii?Q?sNeRVOOUxNtz3Sb6OMZ/nkuVuk3BqZGcWdsDN9kBG329BV/QQKPcqnSd4Eeg?=
 =?us-ascii?Q?R8fxS5BLkeLCUXohOrfVYJBpC6410R18Cl4ddnACet1iyHNUSp114M+WAE51?=
 =?us-ascii?Q?PF541MUhjxxnaIkKdUn/1SxlQlEweFa3m9q6pEyEynuOeLlWpsAyCR5aHAc0?=
 =?us-ascii?Q?UOnDzonVP79taqvV+Gt8ytqxXr/CKcGyINAQKf8wU4ouhSU1/ZVhvRpLtbVo?=
 =?us-ascii?Q?K+lL1g5T1PzVTgHGivQ+rbgO/w39EUt+IwiTmBAzWW1btfDY/We0oFwU9rI0?=
 =?us-ascii?Q?BzdHCz+ec71lBjDi+P0gWW5Kmwa1umB2yXJYRM161UofuMLLvzkjXZ4s99xR?=
 =?us-ascii?Q?5NNyUK7LeuTXnQ0YMQPRF2PYwHQmbw1bk5CwVWdJELqXjoPytTYsh6O+ID9e?=
 =?us-ascii?Q?CADbM753/yCTUy728dzYURnbLhfosl7KvBZuL80YcbyMVeX28yUl2so59lt3?=
 =?us-ascii?Q?BE0VeOcBjRjejnnvxgJuwkrAI3qcUyWsNfnlg5ro5oeVippUA1PPtdzdxOg/?=
 =?us-ascii?Q?O9RNekGLG0BZKaJwfhzDMEKVMDQsf6bO0yM13Bo2FtxHb+GQA0ay3d7LXUYe?=
 =?us-ascii?Q?XV59KE2qGrnIBsQktVEm2B46/ahiSHh6Fd559ui8Qt9ppYNKPJiFadQBpQy/?=
 =?us-ascii?Q?V1adGOKIsPe8PI/JNFCCE7iBlD/pB3stfG4emQKrvxyJvCs8PIO8wjhcEbNK?=
 =?us-ascii?Q?TIjvQif0W840ARTUtIYMQgfsBKe2jn2/3Wpwpz7lQcitOnN4FWky+yzJ8WY2?=
 =?us-ascii?Q?qvVhpqCQHl4vd6wCI1SViyn7sv7Z+08Pyv6XMjDxVpCRNNqQQ9BF4j11QEmP?=
 =?us-ascii?Q?CXA/f3ICmaycM3g3Iai56CZS9yKvZAc5atjyE7vNbEZzDfPb4pdeWalz22+r?=
 =?us-ascii?Q?nVlEYkMZOQ/eFAKd0ylhdTuXptboPsyAs6VbNbaWAAA2M+7pxbx+1Y40JA/O?=
 =?us-ascii?Q?/7JKf50r6w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ab8f23-4370-4035-6396-08de5388c197
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 16:19:56.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J6eMrrZAK1Mq5JqiGfpeadkn/2TEJUUohpSdbgFBh6IqJh+qXgf1MBWRrUenJPcCv6bcT5VRt8bAh0ey7UFRypz3oXE4ThLMWOmxhDp40Ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16860

Hi John Madieu,

Thanks for the patch.

> -----Original Message-----
> From: John Madieu <john.madieu.xa@bp.renesas.com>
> Sent: 14 January 2026 15:34
> Subject: [PATCH 16/16] arm64: dts: renesas: r9a09g047e57-smarc: Enable PC=
Ie
>=20
> The RZ Smarc Crarrier-II board has PCIe slots mounted on it.
> Enable PCIe support.
>=20
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64=
/boot/dts/renesas/renesas-
> smarc2.dtsi
> index b607b5d6c259..3db7d31be2b2 100644
> --- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> +++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
> @@ -96,6 +96,13 @@ &i2c0 {
>  	clock-frequency =3D <400000>;
>  };
>=20
> +&pcie {
> +	dma-ranges =3D <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;

This entry to be only in SoC dtsi like RZ/G3S.

> +	pinctrl-0 =3D <&pcie_pins>;
> +	pinctrl-names =3D "default";

The pinctrl entries to be moved to board specific file as=20
it will be used by RZ/G3S, RZ/G3E and Upcoming SoC in future.

Cheers,
Biju

> +	status =3D "okay";
> +};
> +
>  &scif0 {
>  	status =3D "okay";
>  };
> --
> 2.25.1


