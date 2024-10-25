Return-Path: <linux-pci+bounces-15255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A839AF71E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 03:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09531281E0F
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 01:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358125FEE6;
	Fri, 25 Oct 2024 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WIKjVU+e"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D26B22B644;
	Fri, 25 Oct 2024 01:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729820698; cv=fail; b=CZMZ7aLFkmvPuH+2139w2ojFZ6iF4jSxhMLr7+EXi9oJYz7VEl644FfX6wCUd7xwbWRKbysa1ZKGqU+v74oR1mt0/j8cTqFzXOuzl13noYnMl7ylO9G6tMsxWHctKRNQ3YwUwo49eEziyRliZw33H0fKQ8413/2ih0arnKcKw1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729820698; c=relaxed/simple;
	bh=4LcaxyCjt/UTWaBRohLsbTA1dib8L9kYjjTzbhuVNNg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kdt42VYF8Q16R9POY8wJWCz9XiwX9VaimZOlGAlv1Hwjr0h7vg75W683kOg6jVl3xEJPQFB+8S5t3e8qzuLGKd4eo9eKtKqYhsnnEHZb1Ep1NJBJqC6T6bGinZB6ora7Q8HBsVwh4Zujgyya1b3zN54gJMOb4USXWxHPXSPLAAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WIKjVU+e; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbMlzW+PIuhJbdSG9Lbwjl4A7XUjRSkBmo1lkr6rYYWn89/29I5nviwE0oBaipkfvUQczkwM+KQPUdloADZQ2I8D5Yxk09Hj/Pi/0dCBBxbtxbej92XJC+YcTdNBRUn78AXHYxWW0ZPvI4vyucuk2KV3OKhXp+r4fUoenbmluNkbdv5BKqD9pLdbOYiYMJUQ39pgEnK9lH9QSd4si0n2XZ/VTsyp42yeZz7dhDoNcGHQ4uIdpSEqfib+EkAkaWakFhA3Vc4Fv/TiGyemwum29jEEmMGYyPPiLOxgewYMoVN5Dr10Cy76hYL2FsXk0uahXl0SmEuqrAtR0GZ4AX7QnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4LcaxyCjt/UTWaBRohLsbTA1dib8L9kYjjTzbhuVNNg=;
 b=uSkoZvLDzuxDJgpJDA/hdcPNbQyl2MCDai8LTuKsVbEEZDPDTYS/M8vTpWpOdMaaQOwmqxknxC/gMWEWSO2pgsdGBh0qXyRhh7yMiIZzwoeGhmSrlSWuvqg4zEVaSujRGG6m9mCK3kj9x7DP9hq87zWcJiUY49C2UH1HvvK1S/Do7CumbTkrxYWOlujV0d5HWrbHb63NSyoHjjPyyVJPvmBH49LucMSCUO3C4G6Ly8S66N+X+1RLcfh9HOdmAmhtyLUDxWIQQGQa+JnJzKTITDXf4iUcZt8813Tr/5AvGuuRLy3/p8dwXiGBa2YL8ZCqQt/Z8YTGxdM1bpouWYkSNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4LcaxyCjt/UTWaBRohLsbTA1dib8L9kYjjTzbhuVNNg=;
 b=WIKjVU+eEqeSiciMqxU1ov3HA8p8EAfLqbiVH1Ct8GBlKyyHUZDhUEHhMFvwrG827vloAURJFWTLy83eloFx3KKAP56sYjQHB0+t0YxsuDVB73YZ1QlSumd075cFO4Za+crHfcfQ8Z+Mho2BpD6tKjJl9Q2K7qKMBmLXgK2HoqMM+dAAvPyTrhV+Q+9hIPrl4IDa2RMUCukXD+IFBxf7DpTbjwQ+AC04Xm2r8VCSi4XPOAXBh5gYbD13rD/Qn4zj7VbBcJxfqP7NClr3Nyt/i26yZ/seFQiu0Kmr24AY7PXTXbAUF7uvfKv2cGAeew+U6ReTL49V685Soh0Di+u25Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Fri, 25 Oct
 2024 01:44:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Fri, 25 Oct 2024
 01:44:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Frank Li <frank.li@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "alexander.stein@ew.tq-group.com"
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v5 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Thread-Topic: [PATCH v5 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Thread-Index: AQHbJeObq9aJ5gD5VUaSDq26CRIwdrKWF14AgACXuTA=
Date: Fri, 25 Oct 2024 01:44:50 +0000
Message-ID:
 <PAXPR04MB851014063D11AC2C668C9B2C884F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-5-wei.fang@nxp.com>
 <20241024162710.ia64w7zchbzn3tji@skbuf>
In-Reply-To: <20241024162710.ia64w7zchbzn3tji@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA2PR04MB10347:EE_
x-ms-office365-filtering-correlation-id: 990b82bd-91ec-48bd-4cd8-08dcf4969dc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?K3UY6UZRbDCr0dqXK/2T2OYSsYHFR1zg3TX0sZKa7gU/leYPl6r95k6Q7IEO?=
 =?us-ascii?Q?0Wh5z2CDG6qYk1WGOZ+y02+OuWe9so4Qkri1ZQYhM5XQhg0Gv7yiKrNV1UOk?=
 =?us-ascii?Q?cwHz9/rsHCqU6hMK96XsyrrtYHaCdIVINP0e26UklJrJH8HYpWbTcHbgVfVo?=
 =?us-ascii?Q?vqhKBRKp0lRqEGRJGHRDrplNKfu6fWHZtFajqMkVWdJowUf9BYKqayXYsZtY?=
 =?us-ascii?Q?hvJgkRmpqP+uhcapFMcDWK1wzSEjoVDTJ2mP/es6JPg1joioHy1LDFKDmtwV?=
 =?us-ascii?Q?ApwfiObWxwAL4AdUyhGi9VJbKDkpMRWz6YxzogY9rnD6eHjR1U9TvsFEYMZT?=
 =?us-ascii?Q?RC2xRBH0qEW4JHNMNTWxN6nqmve4ywOyojOaB1usIjz6ND4NajRHK7E9ank9?=
 =?us-ascii?Q?NZkygmG6E2E1d7wzWK3rJu9c8YHZpk41ZHrtSiScU5IRJs8wMh10XWdv7rZ7?=
 =?us-ascii?Q?jcEP3aSEF9j4MKR+XrzlHt3iMz5HBQgiUi+D5N7d9Ztp64tAoFU6/10Tu8W5?=
 =?us-ascii?Q?haNkuCHI0rAIuSssMqAA7QuFDZizyOMX8enDulofH9ELYHu+NR9lV/RfXgge?=
 =?us-ascii?Q?yxw10E6p1TX3jeJ47hDcx5+i0GX21H5bd6cwp8nFYgdZHudrSXainJ333snx?=
 =?us-ascii?Q?TXVH+pYTBbSuDION86CNiXaikIum2Ww5y6oo5VhkT2eChfT684LyQl5R6cw9?=
 =?us-ascii?Q?WgZjOt832ZkpLdbdB7m3tTUQYvqUFt4I7FtuHB2GVzxtZOtPFgBXVqLmXvwN?=
 =?us-ascii?Q?6cqyzgeAI0S2iTuCH2bD6/E4MUZkeex3mTi+vN70fGFpahFjA1HIOCRZx/g7?=
 =?us-ascii?Q?hKd61wGIDMZScfcTbYgpjlh7/7ZPekId5TVG8et6QveuSYr8ZSzzLunueLJp?=
 =?us-ascii?Q?OQUVQrQYfd1gxxnCmgK7X64LVT4AHm58+xpP+9rQ/XI2+2O6tiioW5INNZDL?=
 =?us-ascii?Q?fCPAFgZ5Q+kRkX+QDh6Zd1w5yVHTzkYF8eD4YpMCGeSJFi67GM/c2LafqWCU?=
 =?us-ascii?Q?j5NaOrRMcQtleHmx9hlDHzCXiWdhSbw8MB1y7HcPMKTxGDo0pWpXd2INJakF?=
 =?us-ascii?Q?c617eb5ty+9pkJ3DW4rbIGM70t33la5QV+xYAR5Bg9sancnPuWtdtMsp3mkI?=
 =?us-ascii?Q?jx9eomfgZo56f+E0uwHs+MTHVzfovEOQqYWFHp/hUhpyfXx9fy725UXr3i6B?=
 =?us-ascii?Q?b9Fyze7Z9m3idpvXE8eCLSGFydy6cnPVfeYuCo1o5F6s7q5FrtSxN5mUf8Wm?=
 =?us-ascii?Q?3ndeUqsf87HU5FC/J32dN2EwUmyDiLmp5QzrD6AhyfTHhWtHn9UtCKMhnzWN?=
 =?us-ascii?Q?eqVQb6KVporlpUHl8Y9FIJsQgo9LcBRGe6e4BhV3+fcPlwXSDg1lYEmMFSRr?=
 =?us-ascii?Q?GeP6oOs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Oc2DD2CcbrWux0HdNRIqTWuqAAam8PzAGfEgVFwPlgBtHDpVisfmEt5vHeP?=
 =?us-ascii?Q?zJvkoA5OqVPVChKNA9Sl+vs59yIs+2PCV/e3QwELZEuViLMpdUNaY9hRSPoD?=
 =?us-ascii?Q?jG/2kk+DEcyfEsOQ3iharBUmmre1nObqdov57eSHuWDVeoGuEs2ompCzYhws?=
 =?us-ascii?Q?kZwOAL1VT+3mNn9zNTpXV1nJNP+VQIjdcW37tguFcsPJk6hscrnVmnXpb83Q?=
 =?us-ascii?Q?GUOmWldWFYbWefif+nUzqksWvLG6zylD2opIg1HaOcNux5IAGzpCH8kpDB9/?=
 =?us-ascii?Q?2kky8De/R5I5jb09eduCuTkFThbEJzIgf9z0bYhp7mQlPvBDUh5AxMbLkOAk?=
 =?us-ascii?Q?zHjbmduqhAUuzOTHfYyKjcUxsqKqSPkC2E67r6kS3ahfCck+ImngufaYvL4M?=
 =?us-ascii?Q?lRzhxEp6QkIlg/7vCH6HduGBQ+mAtBGaOSWHHqQQY9QqeDG7Mb7EZJX6D8zf?=
 =?us-ascii?Q?PUvwR7Te43pYbOSQZfMn8LizWiyq8EmpnjLOOU7AIh7JmNRp/56DTvBJ0dgN?=
 =?us-ascii?Q?jLJJb5TRDvbboMJdOXFtXwUIOKeLx2WIAPi/IGT7Pio0f7CPmg4IqPAYQBnT?=
 =?us-ascii?Q?AtPGQSWnb3F5LhakfmhRl2OVMYnrM8Rs9R2Ss91/RPUGcTHmEipklLZurztm?=
 =?us-ascii?Q?NRn6iBfzbz70BAI38HZuBM2PsD+izUmdTy/RHSiddfUe5w6ruYl/xZG1CKPM?=
 =?us-ascii?Q?iE+ENUXbN+dDYMj4oDZqnQNmC4MHgrJf3Bu/Xr6RYbCeYmveF70qC4zlqVeT?=
 =?us-ascii?Q?hWqdaXVukd2ZC3a0qhkzzIcAsssGEb5UAtbNfg/Pmy5I+sZQe727+ihn+lr8?=
 =?us-ascii?Q?NOk5WtwJLbeNhbc4CKXgCDNKYAcDk046eXAqtm8PSKt/OP/Yf8pLWlf8z3Xg?=
 =?us-ascii?Q?GKZVIT8zkZweogPq3pW80meITW+Yxzkj3BNzWHmwwC6KwkZGVusjGEZNYPUD?=
 =?us-ascii?Q?Bmk5Es1JEEu0Uf5M7aMxFkSBXnbdMpICrsHXwXoOmiu7kKF5xcVR7NQGwUUC?=
 =?us-ascii?Q?NfSq/rS6ozsWnlDAGyb+drU0xbBePUpAVEVFgIcHL4rigv3HJ4A+KzLQuyr5?=
 =?us-ascii?Q?j3FjOZ/3F7vYLJWjglsKqwTsbGtasH0Hgn/xKiAi8+mPIP1O3dTF5PE/5Xz6?=
 =?us-ascii?Q?JQy7OhpeG/EFfBiGxnFSnrMlsBbB5rsYwrGlSsYOSLnu03LQ+VM4RzDhl1NM?=
 =?us-ascii?Q?5iIuHPCo6wOGiKgodWsVPmmUHeOjzlzl77KmgJNAoxDWGqQgaM8Ydapp4f0l?=
 =?us-ascii?Q?ASy4EHcaD7GdfW2wtpnq7X0Rjx9n/SrUDKXv5XlGyQ5erw67SUhjG1b3UcK1?=
 =?us-ascii?Q?tRrPZVkkudF6eXlciyq8CWDs0fNgUJo9laHsSgsmDuQlnsahrjx4Rxd2QbJs?=
 =?us-ascii?Q?OMrAcDaqDLuJnktnaDhMiwbPhIknH7afNhPlaLnnpoueJSFDirkGW3nw5nUc?=
 =?us-ascii?Q?Xfwur75ductwdf5qKA/Eg9sEu40XEL1e2hTNkIKD7Av4XNOvecx1GsSqPuRm?=
 =?us-ascii?Q?jREmoI09zrtTPSqSuugU3FsyM6RuEdAyoYUtf4eV4kVBseB04e6ZcG2vtqv4?=
 =?us-ascii?Q?TAficmgA9F2GVqtybyE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 990b82bd-91ec-48bd-4cd8-08dcf4969dc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 01:44:50.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KAITiG/LGph6du4IErKVFvWQbtKTPniOO+LqXy69tPnh5vQ72LxiWe+AylUD8D4xxp0e8WQILKXsjdHJw8F2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

> On Thu, Oct 24, 2024 at 02:53:19PM +0800, Wei Fang wrote:
> > The netc-blk-ctrl driver is used to configure Integrated Endpoint
> > Register Block (IERB) and Privileged Register Block (PRB) of NETC.
> > For i.MX platforms, it is also used to configure the NETCMIX block.
> >
> > The IERB contains registers that are used for pre-boot initialization,
> > debug, and non-customer configuration. The PRB controls global reset
> > and global error handling for NETC. The NETCMIX block is mainly used
> > to set MII protocol and PCS protocol of the links, it also contains
> > settings for some other functions.
> >
> > Note the IERB configuration registers can only be written after being
> > unlocked by PRB, otherwise, all write operations are inhibited. A warm
> > reset is performed when the IERB is unlocked, and it results in an FLR
> > to all NETC devices. Therefore, all NETC device drivers must be probed
> > or initialized after the warm reset is finished.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
>=20
> Can U-Boot deal with the IERB/PRB configuration?
>=20
> For LS1028A, the platform which initiated the IERB driver "trend", the si=
tuation
> was a bit more complicated, as we realized the reset-time defaults aren't=
 what
> we need very late in the product life cycle, when customer boards already=
 had
> bootloaders and we didn't want to complicate their process to have to red=
eploy
> in order to get access to such a basic feature as flow control. Though if=
 we knew
> it from day one, we would have put the IERB fixups in U-Boot.

The situation of i.MX95 is different from LS1028A, i.MX95 needs to support =
system
suspend/resume feature. If the i.MX95 enters suspend mode, the NETC may
power off (depends on user case), so IERB and PRB will be reset, in this ca=
se, we need
to reconfigure the IERB & PRB, including NETCMIX.

>=20
> What is written in the IERB for MII/PCS protocols by default? I suppose t=
here's
> some other mechanism to preinitialize it with good values?

The MII/PCS protocols are set in NETCMIX not IERB, but the IERB will get th=
ese
info from NETCMIX, I mean the hardware, not the software. The default value=
s
are all 0.

