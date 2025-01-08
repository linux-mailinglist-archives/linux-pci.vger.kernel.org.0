Return-Path: <linux-pci+bounces-19529-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7384A0588B
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 11:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534DB1881F67
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 10:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FF21F5422;
	Wed,  8 Jan 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="V9zsyC/Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010061.outbound.protection.outlook.com [52.101.228.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374841E131B;
	Wed,  8 Jan 2025 10:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333147; cv=fail; b=mdpYQril23zmp0by90JCLOLH52lvblj920SwNUDawKCCEMhpbGG5ro4ow48vCR79A+qYx9RPbn4bo+Dmg295fJHkKogD8B8etawvGIwKLZ9RkvOJJ+s9TLC5Jx5CJYLT0zK0xPUUQG4hIKNUAaNfJ452aCoY08l0faCit3Bnbic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333147; c=relaxed/simple;
	bh=kx8a+UH4d+Px0doGCzTUEeDoOe1WdbZGLQV0Wrox1kQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ja3QWeRBSEuuBanKRfwuK61uTfB0thGmxu5kci27E0tHowSVm42YoG6Lswh25068cTSnDDgzuLAdeC6v72sMbKRpN13L2ZBWxgONY3MvyrSa+eWEUzRO6JEl0xkSkR7cZPfWr12C77eKo1KjZTyA9kQAMuxdHOkcAAIqGshzGkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=V9zsyC/Y; arc=fail smtp.client-ip=52.101.228.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TC6GDvDL61ahlpOEqOorxBknyS7RbsEzWf8xcXRjaudQgykaffni5tOjhL90Fn7CHGI+/i+V5Sa3GJ001QdgrU1kiLfbGT6dsjHWxZrpR2dUPOrMeUq1oRQkqxW9BExF/GpV9/5+Sq+tcEJ3uC7V8d7rgGdpC2qNajGHaZOHdk51hEI9e88iZmxnTBYL5wV1+y4CCjyAZt4rdBzmqu72PrbckapKKQicxG334gT+W3VzYNvCh9gq1lCLMas6X5iodXphksmsKHtslqSYmS+TeB8XbTGKgF+5AQiJnFDz4Nc1scmTCW+Quy9x+GrQHn5MjmY4N2asPdquhi9W52GHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kx8a+UH4d+Px0doGCzTUEeDoOe1WdbZGLQV0Wrox1kQ=;
 b=vMzlE3aEijOenrusAxOIPlDX1uFZEKHZyj0UU76Hu8qM6x9RL+BqOW5R45jdkqUlhamvtUhnsMqsY11PllMs05RE0UAbX49na8aIiDQG3udXkBWHxhRmO3GZXhEHIge727eB6TzJBNWxMFbP/ELpBOzOCsSOF3bpejkh56yobUQ2thIPnLvQ9+U2PkqTrJ+87RvMrMzwJ0TAWf61aHyHL/mHtv3/JrzJD3l/t3AW4PrI5Hhlnij+1qjJ9QJnbLjf7DIn3w/BwTcwO9whq9sTj9cdp/8NUsTS/IWjEKh5H/FbJDsgo6Snlrn6PxVXZmZH29uxcOSdLGx0NjIsuczwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kx8a+UH4d+Px0doGCzTUEeDoOe1WdbZGLQV0Wrox1kQ=;
 b=V9zsyC/YOJPl5irlxAIbKNk6JYlLrPoHDPqyFOwJTsSeROo54dciiD4XgMGtyVqmMlv432YfyR4yyQ803gd1evLiUcXj3nPUj1T1xc1SHVwLidNQRo2HmvEPBOlbTTIh1u52G57GGHnrlqTcBLc2qUyRQipE/Y+hWHhmCPE7Rs8=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB13167.jpnprd01.prod.outlook.com (2603:1096:405:16a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 10:45:41 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 10:45:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "kingdix10@qq.com" <kingdix10@qq.com>, "helgaas@kernel.org"
	<helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "kw@linux.com"
	<kw@linux.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "prabhakar.csengg@gmail.com"
	<prabhakar.csengg@gmail.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, "robh@kernel.org"
	<robh@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
Thread-Topic: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region
Thread-Index: AQHbYQw8Ov+GrVYXIkOEHDS2QfYjaLML7MqAgABlOoCAAGBE4A==
Date: Wed, 8 Jan 2025 10:45:40 +0000
Message-ID:
 <TY3PR01MB1134694A42FADD885D9D7596C86122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250107225653.GA189000@bhelgaas>
 <tencent_D3EAA236B531BDF17998832CC18EC36CBC07@qq.com>
In-Reply-To: <tencent_D3EAA236B531BDF17998832CC18EC36CBC07@qq.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB13167:EE_
x-ms-office365-filtering-correlation-id: 9cbf56d8-6af5-4f25-40b7-08dd2fd1987c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WwT/FuJ3zcXWY3FzC+tYlALlUaouZmuR/24EsnLGTW8zNW9lZ2jS/xg2mxmz?=
 =?us-ascii?Q?TzGSAPVE9jfbLoUc9iGxisGB4k3lZdyuH9z8ReQr7qoRLAMulP4MTYT1vOGl?=
 =?us-ascii?Q?Be77oltFTILyYtxo8P1U5wAw66BNMI+C3wyBydbNN874dM79b20AsP8Mxcim?=
 =?us-ascii?Q?WDHeGuKqECxwji0AgzxXDsv9QJPBbeW0NW1VZeGnKJmkKGoipprq0Y14Jmgc?=
 =?us-ascii?Q?0w+biRQpoKECMzxnNVYlnwUWM+QrdRVkzXa07hYtPAYfMjWgFZ2SrrASdUDQ?=
 =?us-ascii?Q?enAQ29lHNAxY3PF+hxL4+jXGeE+aDV/FfSSjUAe2DerCrena4uf7XaqtZzGw?=
 =?us-ascii?Q?64+jG8ZjI+v3oDOxBb52AJTyw8LByk8nP6EOAH+zLjtXAs9VKPXTs+eSCgif?=
 =?us-ascii?Q?fJArRmSX4EjsO4p66/U2uJaEBmcJeKwnrfgoi9ESPF4UPXD4sAzQYo/zO5Lb?=
 =?us-ascii?Q?6fd+ohf2mpyRINzXj8S1scX3NUAbRfDwkmOE21H24rUxx4pt5yqA0bVh3IOH?=
 =?us-ascii?Q?/5XvJnq1F+CEmrdmTQFDgtKFvPPvTBsDmtaavU/RCpLE2Xf0ou7DWzcgCfQC?=
 =?us-ascii?Q?tgmtnZiMq00Tv8YxYEgaYgbFgeh2Ij+gdUHQl/OmZEdNjeNxw0S9w6ga3geu?=
 =?us-ascii?Q?SLPvrILykkTRFlcsuB4UbcDT3aYKsAgWJZtjGOsxiVpNAsuUVHo3JNY3I0vE?=
 =?us-ascii?Q?4+rxd9V58SwB8wLOXJjU9v7HkcTUZPP8bAj1onmfc2Nw0eYaNNrXmWPfaqeV?=
 =?us-ascii?Q?z5zSsGnvDsjNZxJd4GX7kqJqh/e4QKWqPugxIk94GAiIQpCthNJUBs2SJXNr?=
 =?us-ascii?Q?bf/ZFOglp73woVKQgBrPv0FWtmChf2d/wb14gUktG6Lvc683ItpsLJWccFQc?=
 =?us-ascii?Q?7ZLoE4ishVzUIC4sk2djKUqB66yAo48QDgtm+5AREYKxKJyb8gciVctW/sdn?=
 =?us-ascii?Q?QBCiRgMzpEm9UQjl6P/IDLXufhgTmT3T9NS3hG8AJzVQOYuofHgOG89kjvVL?=
 =?us-ascii?Q?KLDbldznr36N3p2TkwnLAToos5ttNSCYBWCRlIUePwEGebdqLuQcBnoGzDfw?=
 =?us-ascii?Q?MS1m9qhfxJT1JI3MAXS08XDZsRjJcUruShYDcbzftVQnYT3xXJBFL6FkborA?=
 =?us-ascii?Q?3FYcWTp7K93nDd2tML7kFrjM8gahyAxO0y/8QspCt0qQ8OyUkcBebcSPimQY?=
 =?us-ascii?Q?wDBsibhA8TgVIS3saKm7ASbXYhsn6ElvbDPIT+ZaPvd6KvOl3WDBh7e3y0Zl?=
 =?us-ascii?Q?eF26DQOUlzVXX8S/kOPoo2gOqEWeFh90eTeaLf+wUpV/vuYSZHS1kI7hxBfz?=
 =?us-ascii?Q?S9EYL6voopFul/BcF5naQuJKfkJwlp9/e5QUqlyo6m+KHLmg4us8B16sDyIr?=
 =?us-ascii?Q?j+JOvUoNv44Npb0f7qA5rin8vcAIRkbwFKjQ1zYNUVU9px8fo/wHpfrIIVNZ?=
 =?us-ascii?Q?gEpL+Vg7ViLVYdG4d5vwuqZe07e5q3JK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+4FgoF1TG/MWNFrIRLix/XI5uiP9IX2uOPDENlXDZGbxB7ZPiRCVgFaGSvGh?=
 =?us-ascii?Q?UBTfLDUS24zBx8kY323J8f+vlKNjxUOSFTskwH6xVvwFO1AVYpC4RrnRiPJX?=
 =?us-ascii?Q?aZ2YY8hh6xuLKoTssJcsD5ECGiVlFymNbVadELQ9HAgYzJu4RlnQjT8wNwzQ?=
 =?us-ascii?Q?WQ+7UjgsZTuOH7mqPHQnc5QxLWZ7cI1kLJ0uSuKopLilsVxodRJYrUxhEkho?=
 =?us-ascii?Q?uWqgZ0QbZn2wSSOrJ6I3j8cQU6E6QdzXqRRVlnBRXyWqGVhjLRYVnbJOk339?=
 =?us-ascii?Q?T2Rip98AtyMptYIqOG9KYkw0xvdwhLtujDH9A7fKxH8AquPCMYmBCsGp5xYd?=
 =?us-ascii?Q?S0fmmGmokyvHBHi6kOciZJI9NMz8moIz8uruhgsiMYI80QfDFsW/4m4PhLs8?=
 =?us-ascii?Q?BotWYyEHaTNZU0x7QcziXxQRraTnO/kleU0SbayT0hpFq+lLS5y+1jKY32sC?=
 =?us-ascii?Q?I/JbdYoXjPOed3ojTdOHr4HYSqlJLSWlWOukNxms6PeG3UNujjYspoWRw+lp?=
 =?us-ascii?Q?2xvGb36UtqMSFjgDoC7ACnjajcObm+JPHIzItLW5KnSwIkPIyKoHRN7TJtYV?=
 =?us-ascii?Q?eRw0xy4pGSnesOCQ11DaG1kvkQ+bYHGxwd42vROsL+7YXHKBDKY9h8y8qwue?=
 =?us-ascii?Q?8ou3oRegGV/c3ZdWmsCTx9rO+dIwpZgtU/IdEwORWJT4kPr/djyJjbJHyzYr?=
 =?us-ascii?Q?4JvDQfgBu4C9ZE5y/HnXCRD3kn5VvTGU14LYIPw3hHENqN9CXO8oa95TMCiD?=
 =?us-ascii?Q?ng7Gzdvb1hs+SS+A9Xv774C4sVxmEjRn0mUz9nE57c2p5c9nvGU1z/FWHlbz?=
 =?us-ascii?Q?u4rwuwEQqtmDYVYg/dZkbZxy2lsloPHqKpTvq59AHWTnoLFuju4jy0VsYr+H?=
 =?us-ascii?Q?3wg4ONjKRKGMx9V6h4gyf/+afsOTlsdjRwgQ7aVFHcNLY3q0aq0HsV6kNT54?=
 =?us-ascii?Q?OPV1JsYGgtXsSmkgLLpJ1T5yFdCujlfEPvAHcyGgGi9uw34okmMFHXFx+4UT?=
 =?us-ascii?Q?7Ima1nBZGm3FIoQt3yTkmdPUs65feS2k14lcyTONM9Y1uJU6V3I1uwpKXHYS?=
 =?us-ascii?Q?NjHi0aChish62snuW5jbnuz+Rbk++iZL9LD8VfKycIDk74JxufNA5UG6+eBS?=
 =?us-ascii?Q?dTlZtPgK/obz+XLrm9yAkJWha6kt3yLa1JJ6YsmtL6U/6iLQfeD1JCxKO7tj?=
 =?us-ascii?Q?9D5A2/4D30lu1mFgBN0NMqgNwfJX+wM8YekCP5ecBJZ2LTCUHXCaU7PeoRFu?=
 =?us-ascii?Q?OMoDxh41zE51tc0DDlv6ebW9C7xztSZwBZMNx8/Fhfxvet8Hv9kY9+HyuKVg?=
 =?us-ascii?Q?V5X54uO/tRgTpiRMtn+qzsOjCf7PVB4VKFvP8b0slNqa/YLLo7ZN6q/MTSj7?=
 =?us-ascii?Q?LGSX+WWH9AuQnoG2JD576k7gEwAYEoQa998A3w0Ca5OB6sESi4Q2wU5H2RDC?=
 =?us-ascii?Q?c/n2n9/NEHqb3+aucZgXyRHBUqVrtlTeJ5NzRys0hn1BrwpIvNuURG36OFsM?=
 =?us-ascii?Q?Va6L5+4j+AoMDEXZmd+NEAvRjKA3hNF7pngtZ0k1DWxvBBgKoz/wtDAbPKv3?=
 =?us-ascii?Q?M6XP0S37T5Uj6DtnGvS/TJQ67scK4eFxoM9G0BUz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbf56d8-6af5-4f25-40b7-08dd2fd1987c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 10:45:40.9386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I6Cypb8T9S1QYCSNWcg6C+4ANLdF98rYV0fyjHqEfmrQ0nkWcLSqyRzsMp4WuMp2k7GroxLX0ogREgSivvFoVxHdeoVWWVvu6Lcy61mUWlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13167



> -----Original Message-----
> From: kingdix10@qq.com <kingdix10@qq.com>
> Sent: 08 January 2025 04:59
> Subject: Re: Re: [PATCH v4] PCI: rcar-ep: Fix the issue of the name param=
eter when calling
> devm_request_mem_region
>=20
> On Tue, 2025-01-07 at 16:56 -0600, Bjorn Helgaas wrote:
> > On Tue, Jan 07, 2025 at 09:51:23PM +0800, kingdix10@qq.com wrote:
> > > From: King Dix <kingdix10@qq.com>
> > >
> > > When using devm_request_mem_region to request a resource, if the
> > > passed variable is a stack string variable, it will lead to an oops
> > > issue when executing the command cat /proc/iomem.
> > >
> > > Fix this by replacing outbound_name with the name of the previously
> > > requested resource.
> >
> > Thanks a lot for doing this work!
> >
> > Add "()" after function names in subject and commit log.
> >
>=20
> Thanks for your review. I will fix the issue right now.
>=20
> > Please include a couple lines of the oops message to help people
> > connect the problem with the fix.

Maybe Prabhakar should be able to provide Oops log, as it is tested on real=
 platform??

>=20
> > > Fixes: 2a6d0d63d999 ("PCI: rcar: Add endpoint mode support")
> > > Signed-off-by: King Dix <kingdix10@qq.com>
> > > Reviewed-by: Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Biju

