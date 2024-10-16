Return-Path: <linux-pci+bounces-14603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834199FE54
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B65D28393A
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 01:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBA9139CFA;
	Wed, 16 Oct 2024 01:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a9XBgmQw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A81433D9;
	Wed, 16 Oct 2024 01:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729042441; cv=fail; b=pZ6SvsUpDTpTj+MXeHpujru2HbcqaWm3AXqRJJ5P7eL7rkU7niZMzhYHBFSJuN8VzRZ+msnCi1E1SHXcywGi00Yzbe1fRN6VIhb0uJG/XN4jXrUZoPe/0Pzjl1htsBDQ0ZWn3tGLPbfttmA6YyAVCvGrX/H5vh3dVQp+C18XXi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729042441; c=relaxed/simple;
	bh=SfHpu8PJg9ZWrGdnXqejFAOAaOdapGddIVd1CIWeMYs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5NxFv19q9wfhukIUb76VjSHaeY2AnU+cLVHNDwVdk/rIw6cLAh/SSiVSQCDZerZwnPfW4joeaTtexLjYIaKROf26zh2n2jJmbB7VVKZ17mwaxGHsZXtSlNBbcrOm0fKbBP3TeOLMQAPe7I4veFPr1bPn5q5jl+KwNn5kv4Dqnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a9XBgmQw; arc=fail smtp.client-ip=40.107.22.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpzJnISaFYJn248yVTEqLFNzlrpQWkiAC/KkwS/goERQt8ZyMQbfWsuHlmBaYMd5VumiOLT9MWttiKt86qwZssVhxssiQ33yDJeKOMGtq6k9YSan3tWdPlmzTNN1Afwuded0n7Cq/e9zf5dxxvapOLN/OQcEgdgkPjEM2kfVVPInAFSgYk5cLOCm4Ld8UfpkooZNMfvSmI1YnpmkAgbFJn9TldAcL5wB9BDbjoEYpTzxgbe0ZMKB/Xin4SPni9+zQ3OqsisHNj+Rs/cYQfKHX7VPE9U+wf6UMF0m+ETirIp8z6DoDOAB0cMkW7fxCpX2odA/vDS1mql3KJEqVX4FUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKTlQXzKw56TNGv+V7KOya3atzhrzcQhEOJk14SAXac=;
 b=dJXRCiLzCotvc8WHh1RTAZteCxKX22o3MQa3pYSiYknPoCXVzhYda8FzYlHuyXJrowr8j/mvQgSlSjckrHN6hmY+qLfcYbgDUAKNH8MxheirugK5Wpg1qtr6obtWgVKwQ7f6WMPB6dbLhY5qPuBJXo4YiEi1epzOY2hvAT4YionLt9cxSLlrYtybVnzM4iKsV+WfPdeUqHNGaG3CgL7wCOIEz4ej8stJi7FtZZCWB3+HO8UI7MrAVRim9bcFrEizDHq8hOnyl+d0fCWu/NMWkcvLo04hsP2AcSR9NfXZ2D6XSTEIuIINNcW9F2EizoE6hWQaIJjPDBZtiNTYPK855w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKTlQXzKw56TNGv+V7KOya3atzhrzcQhEOJk14SAXac=;
 b=a9XBgmQw3myfuW6zLL7Mv3EnnRs9z5DRXhZNAD4cuaWFLq5Q+S/j/+7eZlU2DKzlsHV5T5Cm3ksHgTcF3fTdQo7wDz31Bm1GN36b4qCmAhARFU+RMbwK5TiIK68W25R37OUaNG3xfesSC5r7x1DlLbucoDrXt0MOrTn+FaCIm+IpInKhY0wJk/55BFzFqS1iNwGmVgcGxOIjB0DBXC64MzQdThtCHmWZEsg2CMVCiwzLkbBcqwaooTPTWscihYLuPcHph33q8uZKif3Nwf0bHW7iDUxNTMCfDp3XGT1PT2viqbhNFe4TRLorvxruzAHC15VbMfaiufRQE9DQwyFK1Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8624.eurprd04.prod.outlook.com (2603:10a6:102:21b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 01:33:55 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 01:33:55 +0000
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
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v2 net-next 05/13] net: enetc: move some common interfaces
 to enetc_pf_common.c
Thread-Topic: [PATCH v2 net-next 05/13] net: enetc: move some common
 interfaces to enetc_pf_common.c
Thread-Index: AQHbHwQa5bKTDNXqY0mLBS1tz8kgbrKH/0WAgACZT1A=
Date: Wed, 16 Oct 2024 01:33:55 +0000
Message-ID:
 <PAXPR04MB85104492780A4F7AAD99F40188462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-6-wei.fang@nxp.com>
 <Zw6XJVvUKl7abjPb@lizhi-Precision-Tower-5810>
In-Reply-To: <Zw6XJVvUKl7abjPb@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8624:EE_
x-ms-office365-filtering-correlation-id: eafc7850-e450-42c3-d02a-08dced82995c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EbOMIwagH7oHDYY/l1tPg/gb7t/6mclwVQ241RS1MIb9c0SyjQjOPaxeNa7C?=
 =?us-ascii?Q?KDa0bPUCZG+x5fzM8oNakYpT8d6oXfUoPfXp1zI+tgX63Eb9WgeMJjqTDtE7?=
 =?us-ascii?Q?v70nrldQt4DqGGsvh7GueykJcfR8fGkKKgu6HiBRb1wtWF+piS4t052ih1oy?=
 =?us-ascii?Q?6hYU/J2eWiAc7auwaDmh8xVtU52FIs9dg51+mjNLZzAWJyxROXJXABwmG8bj?=
 =?us-ascii?Q?V4ckvGl0/wBJuLo8cV4D/7CXgPYcjF4KoraX5s33NXjJhWTSTiSQ+2ZXNvqG?=
 =?us-ascii?Q?tGElB8SomRyq6rkE0rkuDWFAd1uIxlZkFPocyeaKqHjdh9LRdTvP7nxwGLJO?=
 =?us-ascii?Q?XQ//Iwo8VP1BOMuK24a3xAgkwZljFynZfvf2rsfJeZQEWRZMn/dVuJN4h2Zf?=
 =?us-ascii?Q?VSkSedsAUy9Z8vm8ZTp0kmaYqbxRewfS0ShBOI/l7qHJqJwUMdI2j0V46UrV?=
 =?us-ascii?Q?BQt5r04ame/ueErMB1rf8V+9p2F9OcQdWKtllgcFn605t/0qszoo1x1sfeE0?=
 =?us-ascii?Q?I0Mj5dLQNr5EvAOO/mkaZA/pWmjJxrp4Rl+5CpK6CNsOXOtdLhyrO69abN49?=
 =?us-ascii?Q?dKhVbPYvZmEi/YHgV8Bkx/qjYNMU0Ia73/5bmUoSnKvzzYxELildW9/oCyrR?=
 =?us-ascii?Q?S8qz4+2/xldi6M/Y+lhyPu0Fy6zYJF1UGQWT7bsQqRKAAbivwNgdx5dHb14h?=
 =?us-ascii?Q?ZMnpNA3FIJkYmY+qzBrWCvwYc06zCCiVxoOuSB5AyN5eEvJxBARWzRm9ycZI?=
 =?us-ascii?Q?rKt7SFpKxiamIf+arhfEaNGwdQJgWzVDuRZOYA/YMCPNCKwx1V6pwzIsUafv?=
 =?us-ascii?Q?qs6KFbmKVHXzxTlXKzrfGZgHJ0ADyl/neVS/36MKLUo0rOXkDFyVhg1S4Y2l?=
 =?us-ascii?Q?hhErlbGWbLj8E2CCuTnp04PPNLS4C01bvcPfs878XFH6ODFVaX8L/5TqOkyW?=
 =?us-ascii?Q?r/T/hUestb3Ap/l8wLdSTAw53DS+nscKgHUwbYzQrFbtALEhTr0aVVxl+gv0?=
 =?us-ascii?Q?3J/nFcQ/EbuFBuAUvpeiL3HtDKoL8Ed7mQ7BMm0Y7XwMdoCRyhrL2W+bZJ4Z?=
 =?us-ascii?Q?0BZok1UlULCOskkPy2oO/sUJATTDcUM2aeLXWGna3G3BreF4peyoFjy16Ju9?=
 =?us-ascii?Q?7wOpjo1HIl+Mobv8JCp1FBFLDYrNoLMCftCt1M9WMU/bGjJzoJOg/ijzI4dk?=
 =?us-ascii?Q?tb1WSwRqDGC09L3bJM4roYXuybRHQEKOiceJ4y6Np37BuaoGZjlScuCenP+Z?=
 =?us-ascii?Q?1MvI3cN432zI6azIDbBYX6298l3664ZwRERFzokcxJ3kWUKLHgYUGZGjtRyS?=
 =?us-ascii?Q?lECn1zBctIAPGMr+WIom9chef5tG9we32mBIlN/grkoN9A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5BZROxBVLJ6sAbNMRRU+yZ58d/HMvHhNfc4+mf8XcTMx0GJM+brFYtEnW6s+?=
 =?us-ascii?Q?pieeYPDGgH/tnNu8WnHGw+r5ps+McTMxPz5bSpuzGpZjOC4B53aS0EyxNikU?=
 =?us-ascii?Q?d9CMVuAmba1+QJYFh803LYsik74v4JOf2QJe//elLv8V31JQPJUbHTzE6PkB?=
 =?us-ascii?Q?qsTU8/Fxa7Alkg3D+Dsfj+wcBv4glx4OOsrm4gMH98goAxaS+JtxFY2BIVAW?=
 =?us-ascii?Q?68Juun3P0DE9F6h4DDB5+JADQKPTDx1y2UKsWD0nQXd3FR0BIq06Ev2Q/cve?=
 =?us-ascii?Q?8zcCJO9/GGQzm/I8EUuPwog6NhgNtKZ43Nu4rXxJbI7rSaHkgjikID0/d+sd?=
 =?us-ascii?Q?qtVuwdR32bdCnRYvfl7Ef4XZL1nYlkD6D4zkagSWFuXOkHQEnntkzOtMHyrv?=
 =?us-ascii?Q?ydJq5TREyVv7Kb/bLicU5b1WoNDdJigbrelV2C8m1NK2HIaBI5gzWoz+hW9J?=
 =?us-ascii?Q?diE4UTg1RIEgBSE8SlDpNvsrva96S1MVyYoyrN3mZ0hnAlnuS1K8lRkWjTKX?=
 =?us-ascii?Q?nVhVpvunSqM8v/MWNBCHZh5hUKbBTYQ+me8U5H84nDfYbAvGSo3l8ot3bsKe?=
 =?us-ascii?Q?Ld8jCY/OV1qVGuWx/NFIt/x4Jd/urd3X/db2lBISgJ9eKKIY+XK8c/z1u/D7?=
 =?us-ascii?Q?RtrSV2geNCP0OviOPwFQA2fZby9CE4V0+h11DonbZ1lJm6YrPPbetzYuUqB7?=
 =?us-ascii?Q?2Dms/EKo6jP3rBd58hf85paxCoxIokHVBGjyzeVkhdgj6eCKXn+BnvaESeHl?=
 =?us-ascii?Q?yyBYK11qb4v1FpxsqimBQZBPOI/UpkDchIjTGUcoTq1Fa1X9joG2k/v+TgKX?=
 =?us-ascii?Q?V1aH4BHZTwHekOvUjxiEsigGOqGw2UNBKOaE2K8ict1mnylu82/QCrisUBQu?=
 =?us-ascii?Q?Vl9neoq7rEEIj7uAlTiNaxpyrMX+VqeZOOLv8bEb3QEpRhnrzlBdVo3AdyyI?=
 =?us-ascii?Q?ldJyZFXrVdA4q+5oFhNpMWKEmT//n/1fZ1MpP3HMrCPoXfXZpKFrZAuJ6mJC?=
 =?us-ascii?Q?KkS5wRkCgZuMFydC3zKo6mUUe8vQXxmWbPBNyqvB33n5Sz8oHkwwr3P5gdfl?=
 =?us-ascii?Q?HqxuDNoNl2pinQRrlOHRXivcj+SVMqOK9GeaaFggn5GOjDVOGxd9RQ23SKuo?=
 =?us-ascii?Q?6VWvGuyduWT1xb5idIqpCFltKARXkuxyoI4ZlYjB57KDGruWzqfKHfScUyuM?=
 =?us-ascii?Q?EOVlaQBwyWBhC3V84RTC47jTln7fDivWJDzter1VcaUMYv52SHiF+8zmi3UT?=
 =?us-ascii?Q?nzes3R+zS65Q4hXWamqvXxLWgyk5ju1uOoxnnZeoH60lfpQViLuc/iUqSMKk?=
 =?us-ascii?Q?cKAnr+DswtNRXBr10CL6y6/OwRZcgYqgE9+hVsSN6rLlRoZffINbOB1NHHEx?=
 =?us-ascii?Q?Uy5CkcDRb0oDAxgDX4B2MGpbIZhxMKEMotB9cZ1owthCMap7+XFnzGrn+02j?=
 =?us-ascii?Q?dnHDynlP2rAzySqRY0/mICBBxAVHD9f6I4KMlnWK5TMQ6yoyGawxgljsovlL?=
 =?us-ascii?Q?1V9YlijA8768iHkKqAGi2GksTBICz9OcVa85XurfN4+VELuC5jOMoxdT54pj?=
 =?us-ascii?Q?oWjAoRhHgc4QWoPj9c0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eafc7850-e450-42c3-d02a-08dced82995c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 01:33:55.3888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +46HvlExNrha2rZMO61T8HmWDEhy5iYMx1KpUOPDSAncFy65VEriNRQnze9xOd/ppJYfmnyhs2hc4A+J0JqPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8624

>=20
> On Tue, Oct 15, 2024 at 08:58:33PM +0800, Wei Fang wrote:
> > The ENETC of LS1028A is revision 1.0. Now, ENETC is used on the i.MX95
> > platform and the revision is upgraded to version 4.1. The two versions
> > are incompatible except for the station interface (SI) part. Therefore,
> > A new driver is needed for ENETC revision 4.1 and later. However, the
> > logic of some interfaces of the two drivers is basically the same, and
> > the only difference is the hardware configuration. In order to reuse
> > these interfaces and reduce code redundancy, so extract the interfaces
> > from enetc_pf.c and move them to enetc_pf_common.c. This is just the
> > first step, later enetc_pf_common.c will be compiled into a separate
> > driver for use by both PF drivers.
>=20
>=20
> Extract common ENETC parts for LS1028A and i.MX95 platforms
>=20
> The ENETC for LS1028A (rev 1.0) is incompatible with the version used on
> the i.MX95 platform (rev 4.1), except for the station interface (SI) part=
.
> To reduce code redundancy and prepare for a new driver for rev 4.1 and
> later, extract shared interfaces from enetc_pf.c and move them to
> enetc_pf_common.c. This refactoring lays the groundwork for compiling
> enetc_pf_common.c into a shared driver for both platforms' PF drivers.
>=20

Great, thanks.

> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> > v2 changes:
> > This patch is separated from v1 patch 5 ("net: enetc: add enetc-pf-comm=
on
> > driver support"), it just moved some common functions from enetc_pf.c t=
o
> > enetc_pf_common.c.
> > ---
> >  drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
> >  .../net/ethernet/freescale/enetc/enetc_pf.c   | 297 +-----------------
> >  .../net/ethernet/freescale/enetc/enetc_pf.h   |  13 +
> >  .../freescale/enetc/enetc_pf_common.c         | 294
> +++++++++++++++++
> >  4 files changed, 312 insertions(+), 294 deletions(-)
> >  create mode 100644
> drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/Makefile
> b/drivers/net/ethernet/freescale/enetc/Makefile
> > index 5c277910d538..39675e9ff39d 100644
> > --- a/drivers/net/ethernet/freescale/enetc/Makefile
> > +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> > @@ -4,7 +4,7 @@ obj-$(CONFIG_FSL_ENETC_CORE) +=3D fsl-enetc-core.o
> >  fsl-enetc-core-y :=3D enetc.o enetc_cbdr.o enetc_ethtool.o
> >
> >  obj-$(CONFIG_FSL_ENETC) +=3D fsl-enetc.o
> > -fsl-enetc-y :=3D enetc_pf.o
> > +fsl-enetc-y :=3D enetc_pf.o enetc_pf_common.o
> >  fsl-enetc-$(CONFIG_PCI_IOV) +=3D enetc_msg.o
> >  fsl-enetc-$(CONFIG_FSL_ENETC_QOS) +=3D enetc_qos.o
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > index 8f6b0bf48139..3cdd149056f9 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
> > @@ -2,11 +2,8 @@
> >  /* Copyright 2017-2019 NXP */
> >
> >  #include <linux/unaligned.h>
> > -#include <linux/mdio.h>
> >  #include <linux/module.h>
> > -#include <linux/fsl/enetc_mdio.h>
> >  #include <linux/of_platform.h>
> > -#include <linux/of_mdio.h>
> >  #include <linux/of_net.h>
> >  #include <linux/pcs-lynx.h>
> >  #include "enetc_ierb.h"
> > @@ -14,7 +11,7 @@
> >
> >  #define ENETC_DRV_NAME_STR "ENETC PF driver"
> >
> > -static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si,=
 u8
> *addr)
> > +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8
> *addr)
> >  {
> >  	u32 upper =3D __raw_readl(hw->port + ENETC_PSIPMAR0(si));
> >  	u16 lower =3D __raw_readw(hw->port + ENETC_PSIPMAR1(si));
> > @@ -23,8 +20,8 @@ static void enetc_pf_get_primary_mac_addr(struct
> enetc_hw *hw, int si, u8 *addr)
> >  	put_unaligned_le16(lower, addr + 4);
> >  }
> >
> > -static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> > -					  const u8 *addr)
> > +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> > +				   const u8 *addr)
> >  {
> >  	u32 upper =3D get_unaligned_le32(addr);
> >  	u16 lower =3D get_unaligned_le16(addr + 4);
> > @@ -33,20 +30,6 @@ static void enetc_pf_set_primary_mac_addr(struct
> enetc_hw *hw, int si,
> >  	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
> >  }
> >
> > -static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> > -{
> > -	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > -	struct sockaddr *saddr =3D addr;
> > -
> > -	if (!is_valid_ether_addr(saddr->sa_data))
> > -		return -EADDRNOTAVAIL;
> > -
> > -	eth_hw_addr_set(ndev, saddr->sa_data);
> > -	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
> > -
> > -	return 0;
> > -}
> > -
> >  static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
> >  {
> >  	u32 val =3D enetc_port_rd(hw, ENETC_PSIPVMR);
> > @@ -393,56 +376,6 @@ static int enetc_pf_set_vf_spoofchk(struct
> net_device *ndev, int vf, bool en)
> >  	return 0;
> >  }
> >
> > -static int enetc_setup_mac_address(struct device_node *np, struct enet=
c_pf
> *pf,
> > -				   int si)
> > -{
> > -	struct device *dev =3D &pf->si->pdev->dev;
> > -	struct enetc_hw *hw =3D &pf->si->hw;
> > -	u8 mac_addr[ETH_ALEN] =3D { 0 };
> > -	int err;
> > -
> > -	/* (1) try to get the MAC address from the device tree */
> > -	if (np) {
> > -		err =3D of_get_mac_address(np, mac_addr);
> > -		if (err =3D=3D -EPROBE_DEFER)
> > -			return err;
> > -	}
> > -
> > -	/* (2) bootloader supplied MAC address */
> > -	if (is_zero_ether_addr(mac_addr))
> > -		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> > -
> > -	/* (3) choose a random one */
> > -	if (is_zero_ether_addr(mac_addr)) {
> > -		eth_random_addr(mac_addr);
> > -		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
> > -			 si, mac_addr);
> > -	}
> > -
> > -	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> > -
> > -	return 0;
> > -}
> > -
> > -static int enetc_setup_mac_addresses(struct device_node *np,
> > -				     struct enetc_pf *pf)
> > -{
> > -	int err, i;
> > -
> > -	/* The PF might take its MAC from the device tree */
> > -	err =3D enetc_setup_mac_address(np, pf, 0);
> > -	if (err)
> > -		return err;
> > -
> > -	for (i =3D 0; i < pf->total_vfs; i++) {
> > -		err =3D enetc_setup_mac_address(NULL, pf, i + 1);
> > -		if (err)
> > -			return err;
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> >  static void enetc_port_assign_rfs_entries(struct enetc_si *si)
> >  {
> >  	struct enetc_pf *pf =3D enetc_si_priv(si);
> > @@ -775,187 +708,6 @@ static const struct net_device_ops
> enetc_ndev_ops =3D {
> >  	.ndo_xdp_xmit		=3D enetc_xdp_xmit,
> >  };
> >
> > -static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_devi=
ce
> *ndev,
> > -				  const struct net_device_ops *ndev_ops)
> > -{
> > -	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > -
> > -	SET_NETDEV_DEV(ndev, &si->pdev->dev);
> > -	priv->ndev =3D ndev;
> > -	priv->si =3D si;
> > -	priv->dev =3D &si->pdev->dev;
> > -	si->ndev =3D ndev;
> > -
> > -	priv->msg_enable =3D (NETIF_MSG_WOL << 1) - 1;
> > -	ndev->netdev_ops =3D ndev_ops;
> > -	enetc_set_ethtool_ops(ndev);
> > -	ndev->watchdog_timeo =3D 5 * HZ;
> > -	ndev->max_mtu =3D ENETC_MAX_MTU;
> > -
> > -	ndev->hw_features =3D NETIF_F_SG | NETIF_F_RXCSUM |
> > -			    NETIF_F_HW_VLAN_CTAG_TX |
> NETIF_F_HW_VLAN_CTAG_RX |
> > -			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> > -			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> > -	ndev->features =3D NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
> > -			 NETIF_F_HW_VLAN_CTAG_TX |
> > -			 NETIF_F_HW_VLAN_CTAG_RX |
> > -			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> > -	ndev->vlan_features =3D NETIF_F_SG | NETIF_F_HW_CSUM |
> > -			      NETIF_F_TSO | NETIF_F_TSO6;
> > -
> > -	if (si->num_rss)
> > -		ndev->hw_features |=3D NETIF_F_RXHASH;
> > -
> > -	ndev->priv_flags |=3D IFF_UNICAST_FLT;
> > -	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> NETDEV_XDP_ACT_REDIRECT |
> > -			     NETDEV_XDP_ACT_NDO_XMIT |
> NETDEV_XDP_ACT_RX_SG |
> > -			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> > -
> > -	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> > -		priv->active_offloads |=3D ENETC_F_QCI;
> > -		ndev->features |=3D NETIF_F_HW_TC;
> > -		ndev->hw_features |=3D NETIF_F_HW_TC;
> > -	}
> > -
> > -	/* pick up primary MAC address from SI */
> > -	enetc_load_primary_mac_addr(&si->hw, ndev);
> > -}
> > -
> > -static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *n=
p)
> > -{
> > -	struct device *dev =3D &pf->si->pdev->dev;
> > -	struct enetc_mdio_priv *mdio_priv;
> > -	struct mii_bus *bus;
> > -	int err;
> > -
> > -	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> > -	if (!bus)
> > -		return -ENOMEM;
> > -
> > -	bus->name =3D "Freescale ENETC MDIO Bus";
> > -	bus->read =3D enetc_mdio_read_c22;
> > -	bus->write =3D enetc_mdio_write_c22;
> > -	bus->read_c45 =3D enetc_mdio_read_c45;
> > -	bus->write_c45 =3D enetc_mdio_write_c45;
> > -	bus->parent =3D dev;
> > -	mdio_priv =3D bus->priv;
> > -	mdio_priv->hw =3D &pf->si->hw;
> > -	mdio_priv->mdio_base =3D ENETC_EMDIO_BASE;
> > -	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> > -
> > -	err =3D of_mdiobus_register(bus, np);
> > -	if (err)
> > -		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
> > -
> > -	pf->mdio =3D bus;
> > -
> > -	return 0;
> > -}
> > -
> > -static void enetc_mdio_remove(struct enetc_pf *pf)
> > -{
> > -	if (pf->mdio)
> > -		mdiobus_unregister(pf->mdio);
> > -}
> > -
> > -static int enetc_imdio_create(struct enetc_pf *pf)
> > -{
> > -	struct device *dev =3D &pf->si->pdev->dev;
> > -	struct enetc_mdio_priv *mdio_priv;
> > -	struct phylink_pcs *phylink_pcs;
> > -	struct mii_bus *bus;
> > -	int err;
> > -
> > -	bus =3D mdiobus_alloc_size(sizeof(*mdio_priv));
> > -	if (!bus)
> > -		return -ENOMEM;
> > -
> > -	bus->name =3D "Freescale ENETC internal MDIO Bus";
> > -	bus->read =3D enetc_mdio_read_c22;
> > -	bus->write =3D enetc_mdio_write_c22;
> > -	bus->read_c45 =3D enetc_mdio_read_c45;
> > -	bus->write_c45 =3D enetc_mdio_write_c45;
> > -	bus->parent =3D dev;
> > -	bus->phy_mask =3D ~0;
> > -	mdio_priv =3D bus->priv;
> > -	mdio_priv->hw =3D &pf->si->hw;
> > -	mdio_priv->mdio_base =3D ENETC_PM_IMDIO_BASE;
> > -	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
> > -
> > -	err =3D mdiobus_register(bus);
> > -	if (err) {
> > -		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
> > -		goto free_mdio_bus;
> > -	}
> > -
> > -	phylink_pcs =3D lynx_pcs_create_mdiodev(bus, 0);
> > -	if (IS_ERR(phylink_pcs)) {
> > -		err =3D PTR_ERR(phylink_pcs);
> > -		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> > -		goto unregister_mdiobus;
> > -	}
> > -
> > -	pf->imdio =3D bus;
> > -	pf->pcs =3D phylink_pcs;
> > -
> > -	return 0;
> > -
> > -unregister_mdiobus:
> > -	mdiobus_unregister(bus);
> > -free_mdio_bus:
> > -	mdiobus_free(bus);
> > -	return err;
> > -}
> > -
> > -static void enetc_imdio_remove(struct enetc_pf *pf)
> > -{
> > -	if (pf->pcs)
> > -		lynx_pcs_destroy(pf->pcs);
> > -	if (pf->imdio) {
> > -		mdiobus_unregister(pf->imdio);
> > -		mdiobus_free(pf->imdio);
> > -	}
> > -}
> > -
> > -static bool enetc_port_has_pcs(struct enetc_pf *pf)
> > -{
> > -	return (pf->if_mode =3D=3D PHY_INTERFACE_MODE_SGMII ||
> > -		pf->if_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX ||
> > -		pf->if_mode =3D=3D PHY_INTERFACE_MODE_2500BASEX ||
> > -		pf->if_mode =3D=3D PHY_INTERFACE_MODE_USXGMII);
> > -}
> > -
> > -static int enetc_mdiobus_create(struct enetc_pf *pf, struct device_nod=
e
> *node)
> > -{
> > -	struct device_node *mdio_np;
> > -	int err;
> > -
> > -	mdio_np =3D of_get_child_by_name(node, "mdio");
> > -	if (mdio_np) {
> > -		err =3D enetc_mdio_probe(pf, mdio_np);
> > -
> > -		of_node_put(mdio_np);
> > -		if (err)
> > -			return err;
> > -	}
> > -
> > -	if (enetc_port_has_pcs(pf)) {
> > -		err =3D enetc_imdio_create(pf);
> > -		if (err) {
> > -			enetc_mdio_remove(pf);
> > -			return err;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -}
> > -
> > -static void enetc_mdiobus_destroy(struct enetc_pf *pf)
> > -{
> > -	enetc_mdio_remove(pf);
> > -	enetc_imdio_remove(pf);
> > -}
> > -
> >  static struct phylink_pcs *
> >  enetc_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t
> iface)
> >  {
> > @@ -1101,47 +853,6 @@ static const struct phylink_mac_ops
> enetc_mac_phylink_ops =3D {
> >  	.mac_link_down =3D enetc_pl_mac_link_down,
> >  };
> >
> > -static int enetc_phylink_create(struct enetc_ndev_priv *priv,
> > -				struct device_node *node)
> > -{
> > -	struct enetc_pf *pf =3D enetc_si_priv(priv->si);
> > -	struct phylink *phylink;
> > -	int err;
> > -
> > -	pf->phylink_config.dev =3D &priv->ndev->dev;
> > -	pf->phylink_config.type =3D PHYLINK_NETDEV;
> > -	pf->phylink_config.mac_capabilities =3D MAC_ASYM_PAUSE |
> MAC_SYM_PAUSE |
> > -		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
> > -
> > -	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > -		  pf->phylink_config.supported_interfaces);
> > -	__set_bit(PHY_INTERFACE_MODE_SGMII,
> > -		  pf->phylink_config.supported_interfaces);
> > -	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > -		  pf->phylink_config.supported_interfaces);
> > -	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > -		  pf->phylink_config.supported_interfaces);
> > -	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> > -		  pf->phylink_config.supported_interfaces);
> > -	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
> > -
> > -	phylink =3D phylink_create(&pf->phylink_config, of_fwnode_handle(node=
),
> > -				 pf->if_mode, &enetc_mac_phylink_ops);
> > -	if (IS_ERR(phylink)) {
> > -		err =3D PTR_ERR(phylink);
> > -		return err;
> > -	}
> > -
> > -	priv->phylink =3D phylink;
> > -
> > -	return 0;
> > -}
> > -
> > -static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
> > -{
> > -	phylink_destroy(priv->phylink);
> > -}
> > -
> >  /* Initialize the entire shared memory for the flow steering entries
> >   * of this port (PF + VFs)
> >   */
> > @@ -1338,7 +1049,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
> >  	if (err)
> >  		goto err_mdiobus_create;
> >
> > -	err =3D enetc_phylink_create(priv, node);
> > +	err =3D enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
> >  	if (err)
> >  		goto err_phylink_create;
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> > index c26bd66e4597..92a26b09cf57 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
> > @@ -58,3 +58,16 @@ struct enetc_pf {
> >  int enetc_msg_psi_init(struct enetc_pf *pf);
> >  void enetc_msg_psi_free(struct enetc_pf *pf);
> >  void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16
> *status);
> > +
> > +void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8
> *addr);
> > +void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
> > +				   const u8 *addr);
> > +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
> > +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf
> *pf);
> > +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *nde=
v,
> > +			   const struct net_device_ops *ndev_ops);
> > +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node=
);
> > +void enetc_mdiobus_destroy(struct enetc_pf *pf);
> > +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_n=
ode
> *node,
> > +			 const struct phylink_mac_ops *ops);
> > +void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > new file mode 100644
> > index 000000000000..be6aec19b1f3
> > --- /dev/null
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
> > @@ -0,0 +1,294 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > +/* Copyright 2024 NXP */
>=20
> empty line here

Sure.

>=20
> > +#include <linux/fsl/enetc_mdio.h>
> > +#include <linux/of_mdio.h>
> > +#include <linux/of_net.h>
> > +#include <linux/pcs-lynx.h>
> > +
> > +#include "enetc_pf.h"
> > +
> > +int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +	struct sockaddr *saddr =3D addr;
> > +
> > +	if (!is_valid_ether_addr(saddr->sa_data))
> > +		return -EADDRNOTAVAIL;
> > +
> > +	eth_hw_addr_set(ndev, saddr->sa_data);
> > +	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
> > +
> > +	return 0;
> > +}
> > +
> > +static int enetc_setup_mac_address(struct device_node *np, struct enet=
c_pf
> *pf,
> > +				   int si)
> > +{
> > +	struct device *dev =3D &pf->si->pdev->dev;
> > +	struct enetc_hw *hw =3D &pf->si->hw;
> > +	u8 mac_addr[ETH_ALEN] =3D { 0 };
> > +	int err;
> > +
> > +	/* (1) try to get the MAC address from the device tree */
> > +	if (np) {
> > +		err =3D of_get_mac_address(np, mac_addr);
> > +		if (err =3D=3D -EPROBE_DEFER)
> > +			return err;
> > +	}
> > +
> > +	/* (2) bootloader supplied MAC address */
> > +	if (is_zero_ether_addr(mac_addr))
> > +		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
> > +
> > +	/* (3) choose a random one */
> > +	if (is_zero_ether_addr(mac_addr)) {
> > +		eth_random_addr(mac_addr);
> > +		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
> > +			 si, mac_addr);
> > +	}
> > +
> > +	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
> > +
> > +	return 0;
> > +}
> > +
> > +int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf
> *pf)
> > +{
> > +	int err, i;
> > +
> > +	/* The PF might take its MAC from the device tree */
> > +	err =3D enetc_setup_mac_address(np, pf, 0);
> > +	if (err)
> > +		return err;
> > +
> > +	for (i =3D 0; i < pf->total_vfs; i++) {
> > +		err =3D enetc_setup_mac_address(NULL, pf, i + 1);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *nde=
v,
> > +			   const struct net_device_ops *ndev_ops)
> > +{
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(ndev);
> > +
> > +	SET_NETDEV_DEV(ndev, &si->pdev->dev);
> > +	priv->ndev =3D ndev;
> > +	priv->si =3D si;
> > +	priv->dev =3D &si->pdev->dev;
> > +	si->ndev =3D ndev;
> > +
> > +	priv->msg_enable =3D (NETIF_MSG_WOL << 1) - 1;
> > +	ndev->netdev_ops =3D ndev_ops;
> > +	enetc_set_ethtool_ops(ndev);
> > +	ndev->watchdog_timeo =3D 5 * HZ;
> > +	ndev->max_mtu =3D ENETC_MAX_MTU;
> > +
> > +	ndev->hw_features =3D NETIF_F_SG | NETIF_F_RXCSUM |
> > +			    NETIF_F_HW_VLAN_CTAG_TX |
> NETIF_F_HW_VLAN_CTAG_RX |
> > +			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
> > +			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> > +	ndev->features =3D NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
> > +			 NETIF_F_HW_VLAN_CTAG_TX |
> > +			 NETIF_F_HW_VLAN_CTAG_RX |
> > +			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
> > +	ndev->vlan_features =3D NETIF_F_SG | NETIF_F_HW_CSUM |
> > +			      NETIF_F_TSO | NETIF_F_TSO6;
> > +
> > +	if (si->num_rss)
> > +		ndev->hw_features |=3D NETIF_F_RXHASH;
> > +
> > +	ndev->priv_flags |=3D IFF_UNICAST_FLT;
> > +	ndev->xdp_features =3D NETDEV_XDP_ACT_BASIC |
> NETDEV_XDP_ACT_REDIRECT |
> > +			     NETDEV_XDP_ACT_NDO_XMIT |
> NETDEV_XDP_ACT_RX_SG |
> > +			     NETDEV_XDP_ACT_NDO_XMIT_SG;
> > +
> > +	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
> > +		priv->active_offloads |=3D ENETC_F_QCI;
> > +		ndev->features |=3D NETIF_F_HW_TC;
> > +		ndev->hw_features |=3D NETIF_F_HW_TC;
> > +	}
> > +
> > +	/* pick up primary MAC address from SI */
> > +	enetc_load_primary_mac_addr(&si->hw, ndev);
> > +}
> > +
> > +static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *n=
p)
> > +{
> > +	struct device *dev =3D &pf->si->pdev->dev;
> > +	struct enetc_mdio_priv *mdio_priv;
> > +	struct mii_bus *bus;
> > +	int err;
> > +
> > +	bus =3D devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	bus->name =3D "Freescale ENETC MDIO Bus";
> > +	bus->read =3D enetc_mdio_read_c22;
> > +	bus->write =3D enetc_mdio_write_c22;
> > +	bus->read_c45 =3D enetc_mdio_read_c45;
> > +	bus->write_c45 =3D enetc_mdio_write_c45;
> > +	bus->parent =3D dev;
> > +	mdio_priv =3D bus->priv;
> > +	mdio_priv->hw =3D &pf->si->hw;
> > +	mdio_priv->mdio_base =3D ENETC_EMDIO_BASE;
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
> > +
> > +	err =3D of_mdiobus_register(bus, np);
> > +	if (err)
> > +		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
> > +
> > +	pf->mdio =3D bus;
> > +
> > +	return 0;
> > +}
> > +
> > +static void enetc_mdio_remove(struct enetc_pf *pf)
> > +{
> > +	if (pf->mdio)
> > +		mdiobus_unregister(pf->mdio);
> > +}
> > +
> > +static int enetc_imdio_create(struct enetc_pf *pf)
> > +{
> > +	struct device *dev =3D &pf->si->pdev->dev;
> > +	struct enetc_mdio_priv *mdio_priv;
> > +	struct phylink_pcs *phylink_pcs;
> > +	struct mii_bus *bus;
> > +	int err;
> > +
> > +	bus =3D mdiobus_alloc_size(sizeof(*mdio_priv));
> > +	if (!bus)
> > +		return -ENOMEM;
> > +
> > +	bus->name =3D "Freescale ENETC internal MDIO Bus";
> > +	bus->read =3D enetc_mdio_read_c22;
> > +	bus->write =3D enetc_mdio_write_c22;
> > +	bus->read_c45 =3D enetc_mdio_read_c45;
> > +	bus->write_c45 =3D enetc_mdio_write_c45;
> > +	bus->parent =3D dev;
> > +	bus->phy_mask =3D ~0;
> > +	mdio_priv =3D bus->priv;
> > +	mdio_priv->hw =3D &pf->si->hw;
> > +	mdio_priv->mdio_base =3D ENETC_PM_IMDIO_BASE;
> > +	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
> > +
> > +	err =3D mdiobus_register(bus);
> > +	if (err) {
> > +		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
> > +		goto free_mdio_bus;
> > +	}
> > +
> > +	phylink_pcs =3D lynx_pcs_create_mdiodev(bus, 0);
> > +	if (IS_ERR(phylink_pcs)) {
> > +		err =3D PTR_ERR(phylink_pcs);
> > +		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
> > +		goto unregister_mdiobus;
> > +	}
> > +
> > +	pf->imdio =3D bus;
> > +	pf->pcs =3D phylink_pcs;
> > +
> > +	return 0;
> > +
> > +unregister_mdiobus:
> > +	mdiobus_unregister(bus);
> > +free_mdio_bus:
> > +	mdiobus_free(bus);
> > +	return err;
> > +}
> > +
> > +static void enetc_imdio_remove(struct enetc_pf *pf)
> > +{
> > +	if (pf->pcs)
> > +		lynx_pcs_destroy(pf->pcs);
> > +
> > +	if (pf->imdio) {
> > +		mdiobus_unregister(pf->imdio);
> > +		mdiobus_free(pf->imdio);
> > +	}
> > +}
> > +
> > +static bool enetc_port_has_pcs(struct enetc_pf *pf)
> > +{
> > +	return (pf->if_mode =3D=3D PHY_INTERFACE_MODE_SGMII ||
> > +		pf->if_mode =3D=3D PHY_INTERFACE_MODE_1000BASEX ||
> > +		pf->if_mode =3D=3D PHY_INTERFACE_MODE_2500BASEX ||
> > +		pf->if_mode =3D=3D PHY_INTERFACE_MODE_USXGMII);
> > +}
> > +
> > +int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node=
)
> > +{
> > +	struct device_node *mdio_np;
> > +	int err;
> > +
> > +	mdio_np =3D of_get_child_by_name(node, "mdio");
> > +	if (mdio_np) {
> > +		err =3D enetc_mdio_probe(pf, mdio_np);
> > +
> > +		of_node_put(mdio_np);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	if (enetc_port_has_pcs(pf)) {
> > +		err =3D enetc_imdio_create(pf);
> > +		if (err) {
> > +			enetc_mdio_remove(pf);
> > +			return err;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +void enetc_mdiobus_destroy(struct enetc_pf *pf)
> > +{
> > +	enetc_mdio_remove(pf);
> > +	enetc_imdio_remove(pf);
> > +}
> > +
> > +int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_n=
ode
> *node,
> > +			 const struct phylink_mac_ops *ops)
> > +{
> > +	struct enetc_pf *pf =3D enetc_si_priv(priv->si);
> > +	struct phylink *phylink;
> > +	int err;
> > +
> > +	pf->phylink_config.dev =3D &priv->ndev->dev;
> > +	pf->phylink_config.type =3D PHYLINK_NETDEV;
> > +	pf->phylink_config.mac_capabilities =3D MAC_ASYM_PAUSE |
> MAC_SYM_PAUSE |
> > +		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
> > +
> > +	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
> > +		  pf->phylink_config.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_SGMII,
> > +		  pf->phylink_config.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
> > +		  pf->phylink_config.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
> > +		  pf->phylink_config.supported_interfaces);
> > +	__set_bit(PHY_INTERFACE_MODE_USXGMII,
> > +		  pf->phylink_config.supported_interfaces);
> > +	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
> > +
> > +	phylink =3D phylink_create(&pf->phylink_config, of_fwnode_handle(node=
),
> > +				 pf->if_mode, ops);
> > +	if (IS_ERR(phylink)) {
> > +		err =3D PTR_ERR(phylink);
> > +		return err;
> > +	}
> > +
> > +	priv->phylink =3D phylink;
> > +
> > +	return 0;
> > +}
> > +
> > +void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
> > +{
> > +	phylink_destroy(priv->phylink);
> > +}
> > --
> > 2.34.1
> >

