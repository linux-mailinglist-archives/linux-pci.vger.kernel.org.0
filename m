Return-Path: <linux-pci+bounces-15666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1E9B71D1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506B6284EF1
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 01:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078B428379;
	Thu, 31 Oct 2024 01:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JTewcz07"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74401BD9C0;
	Thu, 31 Oct 2024 01:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730337995; cv=fail; b=ME8SQY4UFvaXVbu+z1zNUgQh3YizYTJuUVrTOCi5TLcWXLBjKk54fcQE//Sreb/JkMiTJptx9QM3ujndqh8axuZVjxZnxxyT+fiNb8EOAUrJJTBG5L38ZsWT4LGf8emIXKl8nUbzX/aZDwgFUGjYucjnBypzFkMIWrxCRNUEVy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730337995; c=relaxed/simple;
	bh=b/LBAiV9aIUOGzqFU02EEkpjzw+zt9H2F73r92S1nIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t3rmY66r/sTVALfToXnma+HBoqYkmDydXdxqsRJ+UXlfeBzdvpeV3qA3ub9iVmfLIwhNOqicR7kDgpvt2MW4J2ZfKnQBjWL7xqyT6LANlphKY51dqf4fbYCJPemdHNVZ20dMswMAeS+FnQ7gYTvSqmk18kJLvUon9rfedCT7bS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JTewcz07; arc=fail smtp.client-ip=40.107.22.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeyV7lDpa0NOSm8qAfRDG+NLuH+BZbq1wECQMSyx5KWdOcACR1pLv7vMNCuTrAXVIa0id9CmRR/lfAIzIRA8IE41T54j1/4sV1OMcCTUSE/lzST4E0qbNe90/pLHzSTS506D4tHdUv2v97yKrUtxg6lGIZgdusGK3xHuDsfq0i1OsSRNGjbd6eYJGCgRkSsvdrdAq+Z5FJb89AVM9HeFLDtxMZwPBbpA6aDns8Z77y9Bh9NVYuLwnLuH5FvNJ/VVNxRRoJ+MS3XHLnNtZePsLn+ATL02dLs/Hy4I+p6JOPdADYk0Ba6+hxvyvWjHRav3AVzFAlMbPOkpC/2eZxJOvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF39aNChMfPHKung+CzUY3m5kV/Blgjnm9KWjy25JrU=;
 b=Fd0Fds7144lCeunqMBZI3NeLbPO4FjLXLvAtACAsUKbMJ4FUmRHrpJbXjDSrRCapPKdeavEogYxCe02hdm6qP2k7hcR3BUv832ReaTuV7RHBLKXd+N9wiAK2Opa+p4YHumBjI4yu6toPlhdEfTHbwckUxkJDHh+D72LJQ/oNx8y3Laake2OVBdHtKjC0U24ebPNPO7firWEkgTP/Rss8lptO1Bt92SjMkL7u2Mp5ror+pi3MW+m4bGiMwIJP7NKmDf5G+4OCQ1ds21l0Th9O00OOyKsv15VXeM0uRj+ndReU1uai5pSoi1XG9pDyh4bEUNDsLswDMnLyGA4KCcmzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF39aNChMfPHKung+CzUY3m5kV/Blgjnm9KWjy25JrU=;
 b=JTewcz07TilrxHx2d56YlZU/C+obta115wT0+CzV98uMQ/gaUHlXAfOmyi80wwjryU6rFk+U1kl3S4vBlOpqgveU3aSTzU4S0UUKrB5eIL8uK/AFQSx3Nm6IjLJtJHzMQsine/pNQ4IFtppyM4qCcLojebL+gO5ofSmZGnnPdQnTk+srMHeqYbNIiQQ9UjPZqG1vQ2mJRQ/Ri6tGSg/1oK/AlsQVqAkdUeZZ4K8sXvp7GuJ9hZ61qfQ6M+pVj1+NjHOyuq767bjAvTgilA1OsgAEeQx1DITDmeFIV7+3FP2ua5wqIJjlyWErsPyWvvdSnv0u/+N/ICVPidcyasUTrQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DB9PR04MB9233.eurprd04.prod.outlook.com (2603:10a6:10:361::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Thu, 31 Oct
 2024 01:26:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 01:26:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "horms@kernel.org"
	<horms@kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v6 net-next 11/12] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v6 net-next 11/12] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbKrHn5Cx/gSzd1kS+DY84A/YsZ7KfZdwAgACrXCA=
Date: Thu, 31 Oct 2024 01:26:28 +0000
Message-ID:
 <PAXPR04MB851050C8930CF89E7929850688552@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
 <20241030093924.1251343-12-wei.fang@nxp.com>
 <ZyJMAkNw+z9NuGGZ@lizhi-Precision-Tower-5810>
In-Reply-To: <ZyJMAkNw+z9NuGGZ@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DB9PR04MB9233:EE_
x-ms-office365-filtering-correlation-id: e53f4294-9317-42ad-5824-08dcf94b0b03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ubH3WEsVJRj6InfktQLB//awmDAMFBbWxlg5Kp0wluAa1r4yf+6c5TkuJ/oq?=
 =?us-ascii?Q?+Wmc4FFT1pyhezFm39+5VsEiVwpmNfH1qFbxbtihjBopJUn0a4pFIopACwFO?=
 =?us-ascii?Q?v6z1Ck3r9eQq+tDf/aEY03ZE3CnEdhLPYuMp1TXHHgFUR9P9V6lK6KK8+N59?=
 =?us-ascii?Q?3DuUQeC3bzO2kPptEE9Fjgpw2ervJlgvnXi4rVpWTaK3HJKZrxTVZmsrOE1v?=
 =?us-ascii?Q?iPjukGCEw0kb/JLC1biwCBaRs5xwDu4ydSxwbvSMiGyu/oL1xk46eXJkqV/R?=
 =?us-ascii?Q?iho82xintOl0MbeYYmFxYuj4u82PoawwdD8lozCJrlkRMw9NFlgs6vu59Tfz?=
 =?us-ascii?Q?L7qH+0W7241rhwL3yft8AejtfirioGw9DGEK2auV2/HxXsiL9EJiXFujX8Rl?=
 =?us-ascii?Q?XAdSaigfo/rkgmOXcV3JTzUAztN0MDSQdDNGGW2jos1l3vqJBttVbP9h2Pnk?=
 =?us-ascii?Q?mo+U2OchTdIdcrrJp3MBfmHIdlqxDdfcYh2SIlJpXumxqhQnXsJ0SKLnclJx?=
 =?us-ascii?Q?PaB1SI8cBcC806O2rc++QRaKn0oEebNzQE6SPbxgepBMD9riGMH32ZPFY3LD?=
 =?us-ascii?Q?RhNdm34BuP/zW+dxY++0FpjoNgRZ+S48EkfoKDIxCnoi+pR+cy/lieWaYbbB?=
 =?us-ascii?Q?KRLjNrt/J4wsJ5FyNxCmvEdUmHud8RDoH73z/vVrfqze6Q882QNOuOxdY2Zz?=
 =?us-ascii?Q?l8b0eN2HUI6yc7rp92QlLp7xLhZTJk+L2X3RL0wP+mAA6WEpyy9cwLQz89qB?=
 =?us-ascii?Q?der5vvRNXVyVMoxosG0pBeT4v/y5NzvGsNResamgbXXxyiOQ97MxtoMa/ZsL?=
 =?us-ascii?Q?BISZAYDZG0Jat04diMOk9UG93wLJ5g+BfkqZdeDB2nx8x6ACbm0O7cTnHA/c?=
 =?us-ascii?Q?MM++disxSrsvKkFEVFx0YIkjmxs2ELS4m4CB+PMiFWrnEKZJNh15NRHUhiDt?=
 =?us-ascii?Q?eykqHw6SsSknPK7z64PzJaos4eGBulDXUYfM9JU8UQiHXO8e9Qw3S45MpSzg?=
 =?us-ascii?Q?8s1Sg0f/v/E3bCraPLIlqB7k/35wg31j+ofjJmfQcGcAwQ4RXxLrSaIiAgdU?=
 =?us-ascii?Q?7dWZfa5QfTsCPf8/d5GpqPubtu6XHmct1tDlYRNOGNM0sWlCvE//aoSt9O/I?=
 =?us-ascii?Q?5yy/Y6be6YmQOqAWVnyuU/WSpGAu5XfYgyljesRr0qJKYyP0bN2+HlkST1ug?=
 =?us-ascii?Q?34z8fIALzfm99MQ0t7bHL5Luq9/53jET0FVbfa1m1Y/HsgWDb+IixzRSm6Wd?=
 =?us-ascii?Q?R8kGyGhXTETy8SeC7ZTOWcO7NLwk4erm/rk47m7WHjmMJoG82YHGhMHe8AcY?=
 =?us-ascii?Q?bqRT0oY3Qm44Lz6jxd6ciwJAyCZavYk/Ds4Gy0tjLxPU1zEMt16+bPu4pC9G?=
 =?us-ascii?Q?dtHqap0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vO7s9AmGvrC4ap+fvJkUCTvQP9AnmbfGPdeeehEOVE4JP7iJG3rK+wqI7T3a?=
 =?us-ascii?Q?+W98VJEiK32ghHQzuwwTdHimzoWk4bBSzTWL01a6hPHUvCLgaztE6XIPz5xf?=
 =?us-ascii?Q?PAb0ui1HJdn6wU4YcpATjtd5FVxqZzsJ1B7jbBkFYJ5Z4RoWH9yAgqZl+tMq?=
 =?us-ascii?Q?DjoAOh7W3D4nkvyaIfVPy2qHbl2GrMhUY6Eqo6Kum6uY4Ph2vkB5+mowX3pZ?=
 =?us-ascii?Q?oDCRYI3J5/PfLVxp/VUPyhzh9frCyXB2q8GSCfDBAmCT8fy7ibJxatngbu2X?=
 =?us-ascii?Q?D177beZuLl9ir/YrxrlycC5bhaWrkUL1Ns/q9JRmrlcm2WyjTSaMeOk3Cxib?=
 =?us-ascii?Q?wU1JU7qQoFoYY1L45XdTkjXyiaED0hp75yhl3og0DuUPF+D/JX7I726igEf6?=
 =?us-ascii?Q?744P1IzEM4e/hi5tNcZtMxyg3/3GOhZfXGtBwWyZ3giFyQHYSNU0KRC6BmiB?=
 =?us-ascii?Q?2/6QiM/JbrJ+oRrqFPFjyAhR3FbEk3AdJhEPwbwrv2fMrxpWt708/4WppPw5?=
 =?us-ascii?Q?q9D8UT6CCgP9pPctXmmpH5SdsRghkKN1LRRxUv+jPLfbkCBBjpcyyrvPmiGJ?=
 =?us-ascii?Q?5t1JNrRNk4uUy3F03i9sJmV87x/ca1/Dnt20zQO8HHbBieumxckRvSpH5ICf?=
 =?us-ascii?Q?9zriUwZd5Ulgzx6NyH0Cu5ptgrBle346uxuWDhwaoiw4NTAHGz8l9mJmUe3x?=
 =?us-ascii?Q?Y70hzFfC7+k40CxBRgdECnjurq/H4VyHZ2lcSe9Ryb1nQi5n22KgyDzVX4BF?=
 =?us-ascii?Q?TugpJkPGFgMPyDNElIuDD0yGTb54PR1FYjj3O51GQ17b9A/dBLU97ytDG1Gb?=
 =?us-ascii?Q?gzJF2ZXgZi1m35X15K/o2PlVxOM0yIpyJeXIZNVY2cCDq0/5hJ/Jt0Xl0irJ?=
 =?us-ascii?Q?VokBLh2AuMU0esb4cJLVBTL0Qu9Rmta25+YYUPfhNisD6ObUc2ZL8l4Qukz3?=
 =?us-ascii?Q?IFsN1MzRptWZYO8QtoMZJa9l2cMSGDf/oV22zAwhvexbzi9i9s8by10ioSD3?=
 =?us-ascii?Q?XK8LpawihdcRRqLJ71HwWyVyfqz9/dKScZRN4/rJqlNFHzkuEbhNYtsWBIHe?=
 =?us-ascii?Q?1X8GXmb4edYvqRGzFT+ri8EhkwdljNw318t3Dfe/lgU2Wums6RooIg526+dQ?=
 =?us-ascii?Q?KfbHdtbblS13OgtUZLlxKV2v8Ed7C/0lN9aoaWubzwEbRfuzBPLp3ezlcqzb?=
 =?us-ascii?Q?6G6rp0Mi95jwH+P8tvdnMcNncizh9o0iUkcdUcg6cF2LlKcRA9IPPRPFRn50?=
 =?us-ascii?Q?EIgnrRG3aGSmprG3fvGHcKhKhxhJ3ErDXlU1tC88VUFrmiqJa8EeezLkcnef?=
 =?us-ascii?Q?fSFxrwTbiUM1LnIsouGyIo68h0+WzsVYkzHG6oTOYS7c5O3U/dc6wogaS2sb?=
 =?us-ascii?Q?zQaSo19jT6wD3uwwj11+82/GLXHTSSSf/ARggbOFdyfzCvDc4E303XEXLIcC?=
 =?us-ascii?Q?FfOkHB9SLcAnQgD7tAQE4VDktX4PcNa+mxba9Q334OZ4Puer1Bajirg8A/wn?=
 =?us-ascii?Q?RCNn8QRJxiWMp+MGHVa6hbzF62DOIPOI6GMDRzIKSWY7tg1XZ87ZqMik7Sso?=
 =?us-ascii?Q?iEpxQu91yy1KFJV+96M=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e53f4294-9317-42ad-5824-08dcf94b0b03
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 01:26:28.2221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: svDdnXL/PS05iJnQxerhymIx/9X7kVXmSy0ZIdaphEusP0tMY2mSXYYUvDIzl9qpYE52mXJFBJpbbZUmgKBDpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9233

> On Wed, Oct 30, 2024 at 05:39:22PM +0800, Wei Fang wrote:
> > The i.MX95 ENETC has been upgraded to revision 4.1, which is different
> > from the LS1028A ENETC (revision 1.0) except for the SI part.
> > Therefore, the fsl-enetc driver is incompatible with i.MX95 ENETC PF.
> > So add new
> > nxp-enetc4 driver to support i.MX95 ENETC PF, and this driver will be
> > used to support the ENETC PF with major revision 4 for other SoCs in
> > the future.
> >
> > Currently, the nxp-enetc4 driver only supports basic transmission
> > feature for i.MX95 ENETC PF, the more basic and advanced features will
> > be added in the subsequent patches. In addition, PCS support has not
> > been added yet, so 10G ENETC (ENETC instance 2) is not supported now.
> >
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > ---
> > v6:
> > 1. remove pinctrl_pm_select_default_state() 2. add macros to define
> > the vendor ID and device ID of ENETC PF
> > ---
> >  drivers/net/ethernet/freescale/enetc/Kconfig  |  17 +
> >  drivers/net/ethernet/freescale/enetc/Makefile |   3 +
> >  drivers/net/ethernet/freescale/enetc/enetc.c  |  86 +-
> > drivers/net/ethernet/freescale/enetc/enetc.h  |  30 +-
> > .../net/ethernet/freescale/enetc/enetc4_hw.h  | 155 ++++
> > .../net/ethernet/freescale/enetc/enetc4_pf.c  | 756 ++++++++++++++++++
> > .../ethernet/freescale/enetc/enetc_ethtool.c  |  35 +-
> >  .../net/ethernet/freescale/enetc/enetc_hw.h   |  19 +-
> >  .../net/ethernet/freescale/enetc/enetc_pf.c   |   7 +
> >  .../net/ethernet/freescale/enetc/enetc_pf.h   |   9 +
> >  .../freescale/enetc/enetc_pf_common.c         |  11 +-
> >  .../freescale/enetc/enetc_pf_common.h         |   5 +
> >  .../net/ethernet/freescale/enetc/enetc_qos.c  |   2 +-
> >  .../net/ethernet/freescale/enetc/enetc_vf.c   |   6 +
> >  14 files changed, 1113 insertions(+), 28 deletions(-)  create mode
> > 100644 drivers/net/ethernet/freescale/enetc/enetc4_hw.h
> >  create mode 100644 drivers/net/ethernet/freescale/enetc/enetc4_pf.c
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig
> > b/drivers/net/ethernet/freescale/enetc/Kconfig
> > index e1b151a98b41..6c2779047dcd 100644
> > --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> > +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> > @@ -33,6 +33,23 @@ config FSL_ENETC
> >
> >  	  If compiled as module (M), the module name is fsl-enetc.
> >
> > +config NXP_ENETC4
> > +	tristate "ENETC4 PF driver"
> > +	depends on PCI_MSI
> > +	select MDIO_DEVRES
> > +	select FSL_ENETC_CORE
> > +	select FSL_ENETC_MDIO
> > +	select NXP_ENETC_PF_COMMON
> > +	select PHYLINK
> > +	select DIMLIB
> > +	help
> > +	  This driver supports NXP ENETC devices with major revision 4. ENETC=
 is
> > +	  as the NIC functionality in NETC, it supports virtualization/isolat=
ion
> > +	  based on PCIe Single Root IO Virtualization (SR-IOV) and a full ran=
ge
> > +	  of TSN standards and NIC offload capabilities.
> > +
> > +	  If compiled as module (M), the module name is nxp-enetc4.
> > +
> >  config FSL_ENETC_VF
> >  	tristate "ENETC VF driver"
> >  	depends on PCI_MSI
> > diff --git a/drivers/net/ethernet/freescale/enetc/Makefile
> > b/drivers/net/ethernet/freescale/enetc/Makefile
> > index ebe232673ed4..6fd27ee4fcd1 100644
> > --- a/drivers/net/ethernet/freescale/enetc/Makefile
> > +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> > @@ -11,6 +11,9 @@ fsl-enetc-y :=3D enetc_pf.o
> >  fsl-enetc-$(CONFIG_PCI_IOV) +=3D enetc_msg.o
> >  fsl-enetc-$(CONFIG_FSL_ENETC_QOS) +=3D enetc_qos.o
> >
> > +obj-$(CONFIG_NXP_ENETC4) +=3D nxp-enetc4.o nxp-enetc4-y :=3D enetc4_pf=
.o
> > +
> >  obj-$(CONFIG_FSL_ENETC_VF) +=3D fsl-enetc-vf.o  fsl-enetc-vf-y :=3D
> > enetc_vf.o
> >
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index 89d919c713df..4be7c767d1e9 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -3,6 +3,7 @@
> >
> >  #include "enetc.h"
>=20
> nit: generally private header file  should be after common header file.
> #include "..." should after #include <...>
>=20

Yeah, but this is not the change of this patch. We can fix this nit in the =
future.

> Reviewed-by: Frank Li <Frank.Li@nxp.com>


