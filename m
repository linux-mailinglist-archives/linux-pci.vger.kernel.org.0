Return-Path: <linux-pci+bounces-14840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8859A3280
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 04:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A1B1C221A2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 02:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384D1428E0;
	Fri, 18 Oct 2024 02:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mqQh8OiX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2062.outbound.protection.outlook.com [40.107.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24F481A3;
	Fri, 18 Oct 2024 02:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729217906; cv=fail; b=CzQ/3J9rKXZVCkgzGv8kgC1V7boSrxb/2ovQSMs/+D5GSM37/pb8c5JhWUG4ZpYguX6SzYAW1375j16klvkeqt3g729QPr6bTCUbZhpz5SHJZNiAhUuVroyyL527nT1uePZzn17PMgulk7jPuabKmjIUzhBVNk2zg6KTU10g/g8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729217906; c=relaxed/simple;
	bh=bKzodzc5w5vIBlDlbXccC8laEynydngQLsqDDCrKpR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ndb+Rl5F8Gj6ehQBz5i3N99oHEqXHOcJx1q5w7ovaApq6WG+HKnPBiPLWFL6q33iTyKaJtVibd6Gv/8+G5eYlOlAO8F7zUUIt9WclwE/uN+2tSRkAtogekbYT9mRenWAKracNpNf5lHuA5WKcoMgl05I7mMtJzHJxeHIyLUiAOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mqQh8OiX; arc=fail smtp.client-ip=40.107.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCNYDuH/cNbP64jP2vXzvyHqBcAEeA8F5QNygauLArHG+q0zQrvvsLubAoRcZDTEuOYVx2VwmZftPiNDgD32HzxL854rYYYnigy7jHLXA+CnB2sQW+AXj99y2AUQUvmQpDF9QuVNHF8IELPpGdIDROczk1vmKhFC7ydcovc3kY2lGQ0SS8BBYp2noH7axqQb98HK4Ks81wVVo15hRdneE1icIdPumxj1fNvCfR81YapU8qWtFaCMhCoPpyofk0ywJ4LQpeDr4bGQZH2MQ1c7aBXHtLANh72iDLQf2a1EtjKmKe6BJWxj2uitN1HnhjNBa0u9lyqK+aHOvx8xADNgkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwmDdv8apEd/CyKSBXZ20w6vaXfMLXBAKqL/psl0Ulk=;
 b=R0auw0J0kRv4w0HC2bue6qX+d+2Jv9rPrEwhZASaUQzS2nvd84im/GxNhFI5O8ZxEIomrD21Xo8dkNzFpxaSNVRmOwOqHScJXPU+PezuVXqeW3DpOkYZiBkMAg4Ua5yjBZKZpR1O1uBjDQi3hmeBV7FT1bueluFa7/bzqP9hZGuD+za0oBfmtLWhJl2uFqAP0kawnGjbggfjSxn98SqHynGyw3WpMKxbORAPDDxuexE7Skdm0uVAaIUdoTmWQByXX0l/noTkRVAKi9DLYksDaEw8hHhgSQ/xppZm++fD4/6MAKZZ/UN6VsCaveSxNXCvg4dProMWRqz+B8AMWFHYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwmDdv8apEd/CyKSBXZ20w6vaXfMLXBAKqL/psl0Ulk=;
 b=mqQh8OiX+IJzmfvhSXSZlLnNEjhQeYSTvSEbNnYV7oSlJvexy+6FJ5qQn57wFEb2aqvP7V7Wrpax5CI+RJI0obREDLrLh8GRshYHMG4IRq6j+4tv+4khDLvdhEd/TGlEOuFeXCsRdSPBZ2z4c/DslOJsxZQ3caJhSgxwgWQlNGRIGgVVOuIPPYa7B8Ys/ifX9qk8N9jBLiJ9Xx1cnHD9qJSN6SI+ojGsSWL2GpaOzbcru3jdG5kTHzpb7yW8nJnPXugyTfhJ6WgMrCxLob1rN7U9lJ+HsdbvijD3Wx6rc6+ypMXJv164Cy1Mb2xJlpgeXMfpPxhsSDqY7EmQbQ1UdQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB11073.eurprd04.prod.outlook.com (2603:10a6:800:26e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 02:18:20 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 02:18:20 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Claudiu Manoil <claudiu.manoil@nxp.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank
 Li <frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"horms@kernel.org" <horms@kernel.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: RE: [PATCH v3 net-next 12/13] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v3 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbIGsGfwE9ZCz3ZEi++6XhhsicXLKLRIYAgACCbiA=
Date: Fri, 18 Oct 2024 02:18:20 +0000
Message-ID:
 <PAXPR04MB85102E935C1CEC4B40DCC50488402@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-13-wei.fang@nxp.com>
 <AS8PR04MB8849EAD1D2A4D3C84FB28C6796472@AS8PR04MB8849.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS8PR04MB8849EAD1D2A4D3C84FB28C6796472@AS8PR04MB8849.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB11073:EE_
x-ms-office365-filtering-correlation-id: d94615da-c626-4ac8-ad42-08dcef1b22ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Fv64V38t7NZZJfU132AeCSVQmxKdzutXZTVHuT0acKBEyRgMcdmj9IHPAsQY?=
 =?us-ascii?Q?x2nkcPyv6BjqAIwdxg8pwzHtVkdD/F3aIZgStcetXDsiSeljRRBGx1SyGO8K?=
 =?us-ascii?Q?yydnIiiB0XnSctGAtrMYGP7xiA3qBMo1Dpy7DTiAz4NIFu8218mtDXbpgKBa?=
 =?us-ascii?Q?SDJ/2dLDsNtvtsDJhXfy0MPf5axYXbIrnor88h9xfMIzlsPNHCfa35Xbxam0?=
 =?us-ascii?Q?nNSnD+0VcMNI9yftlR7HwzTHtYr0S92MGyRVgn8tIQM7VloAppscZddkuCsc?=
 =?us-ascii?Q?2ihea0v8Q70iFFJY6f/FPNR0SRCyBiU9t4NuRRz2r7E4PzDbI8rzZjFd6YMG?=
 =?us-ascii?Q?sU6TO+WQQCM8nY4qGLkMjElEyHBnUJsEVEveIZcFTuoJxC2ULHJSXNpQ1dzm?=
 =?us-ascii?Q?A5dHnovxpcW0STSv4gu8xzwbsvatwaDiPVDGUWOzfkUE4RF4fIKxVCVteB0Q?=
 =?us-ascii?Q?fBtesbXXf7e8u24kA3zwbqpaiCLJHjYDlrpZm/WPEHibCfL8IM1SxTlBjC17?=
 =?us-ascii?Q?nbXf740fwK8Zwds/gEvBWo9efvKhYcqJMXP3L7YE81BKmqH+f+qnhqAvwlxQ?=
 =?us-ascii?Q?m8bD86AhAdO0GXWG/LJ/y8wDwphW89LxZZEsxXqgmZffQJbABzffEGFumvzA?=
 =?us-ascii?Q?A7wucdvdT/Hubh2oks7ofO3Dp7B6zm+vYl1gnn/4zmNzO5fAq2C4ous6TZff?=
 =?us-ascii?Q?+1Pd2FAXToUjW1SV36JHvR0VHu955+dI9ZHhfnWnCl8Fn+AwObl9AL/pcrKz?=
 =?us-ascii?Q?Fh1XZtCCI2/ZaG9WtnOpjpUfMPTKwanyKcdMUVL5OaTb3/f6E9lieu2rLaKa?=
 =?us-ascii?Q?AFjgqHlQ8WeEtNM9D5o8FYbGck18qBhcPkz7qrivWwChBIkr8OCJzy8D/4zF?=
 =?us-ascii?Q?deu6XdWR9V4TPwGzjWy8Ohz2hda/z8gBUWDxnTYYLPT8y5Hk8OiUH++tc3ru?=
 =?us-ascii?Q?y+g0P8mww25TPwY45AD2+N1KAzxsIQU0gVsIC/lZ9fvGoqY5mrAyEHOFY+v9?=
 =?us-ascii?Q?qrtawvINYd5wLu+MBMh78MDWNwn3qKlYudFuJ7bH3BfeG59gL+oYgyYrWaNc?=
 =?us-ascii?Q?bQi6tJoWCQWekGRc9yOEEjV/efT1g2/uRkN1dJOSIxWoxGn8MASF/NmSH9tn?=
 =?us-ascii?Q?+suB4HUTSDV5TLL+3D3XZcZtXPTw6Vp+6Dd7j3u0S9agMgP9A9fynhe5ivoC?=
 =?us-ascii?Q?WYKoLp7RFLYTwo64lN6cBVU78hxxZhQIJIG7rqcSLl8F+9OuJkcjD4Y7CidO?=
 =?us-ascii?Q?ZVmfMRKuV3ofOHe99+yjITCPJvwVNVDcUsGKb4VeMMFU27E/wzXcYAN/Ti/D?=
 =?us-ascii?Q?JS9erpiHBBG9yEhavGfB88zaqe+GMC+Zo84LJ65nH8xRk7VvYIGemBdycuSw?=
 =?us-ascii?Q?CDk/5xSGOr4G8WYJnMkv3qUTVM58?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oSw5Jf5pSAe2IOxGiALsgnULhymU08KWUXya3L0tiK4PtAaCiv/q6Tdwm2+v?=
 =?us-ascii?Q?5hLhypyVjkR9R7kUKjX1ZVH9STQIH+CangtK7GvOkjt0W4uWeoZO1jnAIhBw?=
 =?us-ascii?Q?X+h+7cKRDT2fh3sx8gMOA0KKz950woKI0NDJi/bM0+V5RSsd9cOMiQuPzkH+?=
 =?us-ascii?Q?SJ5spiDklazWqN1J3IeKRKZrs5cmykisGajYi+9y2KX7/UZvP4t7+zj9v+mS?=
 =?us-ascii?Q?dPz3YCtyAFTEgSea5eX4+6fH/WijXZghV6FSdVxlJk4npYxTTquJKMPjeuJv?=
 =?us-ascii?Q?HE/oY+yuCMEWeqLLb1Zfnugz5giKF3NFMD169/D8nH7xWuNKjqm+NpeJc0K0?=
 =?us-ascii?Q?C4xYbRIjMCoia56JRHdFG/8wvKF1OSmRQqPULBi5cD/vUWSZmyEzWbq0SO7R?=
 =?us-ascii?Q?OraaI4TDB08lHeGb+2Sf4WZfj0NYtXShUN1Lql/tYjXkSJZtT6fFX2kA965z?=
 =?us-ascii?Q?HWFQjF0v3QaPcl7z5N0V+NxGkwBg10uGCJ+h85x5QW1ww8D+lo5rsrqzrhEe?=
 =?us-ascii?Q?HfPbHgOoSkvDjNYlpBKGynDVaWl1WgnX5butD5/HmrhOFIS7eom2ZaPtuNql?=
 =?us-ascii?Q?W5bPkjxMnItG4Sy4Trug2kU8R/IuwEUR2cGkBPFQFzIk2p1oInbjdKx9GELn?=
 =?us-ascii?Q?Jp5zsdXksbPBcqMdi05GVVBEo7SbSUuLELuNFaAQ4X3sY709/2wjET8ysLGn?=
 =?us-ascii?Q?PeWuGZKHdTqjTndugeHWv51v9rYYmcbdfu+sHnKwhx+GS5UXZrUF2GI2hhAh?=
 =?us-ascii?Q?BjsfXISZRtl6I8sViw4cbWAr3cnkBGqPKjU9r9RLVQbJefNaiG1V4XyBvIZ9?=
 =?us-ascii?Q?deLaw4RCXugG04orNwAbvMkPCTjDKfiA5o399Pqc2a9y83JLhtxqXfTnWsPw?=
 =?us-ascii?Q?ug1i7oYM1MJs0uAAxbspaYnTJNxTyQGLWaiDDDimJwZ843dgq7NN+kg4y/I+?=
 =?us-ascii?Q?x+e1DZww3FLsWlIvFuO3FXV+4kL0zwLU7WYm15BoiKZoGEIRm6SkhZeK6kSN?=
 =?us-ascii?Q?Zt6zlqkwezVBs8INi79kg0ixRjtCWKMNbo2gPD661EjKtH2HwB98JfffWX1e?=
 =?us-ascii?Q?D83im/RSSJLJIYBkp8KbPNiCX5r6uBYs2IEEJm8BkUaQhB9JLWA4SRCgik3F?=
 =?us-ascii?Q?vCJaBjnRj0kC6nocODIQ+KDssVWmXKSgZcSVCu2eDQSielZPBO8ghsdgwLaL?=
 =?us-ascii?Q?pRVy9O+HfpPu8cizRu4P26oNgSqOt2rOmp+VppSHm3PbH55Utl7unUBMFBCG?=
 =?us-ascii?Q?hadRUHrQgKX5m8gi+x/bjYV6tcPxVv4hCwh4rlfTcq545R1964aafDMo0ti2?=
 =?us-ascii?Q?dLKTedjqvE6vnzatBRoGD9ZCO00XJqv6GB+Ws0jOUt+icGvxHE35+Mil9qbA?=
 =?us-ascii?Q?mpSgF+s84+Wyc+4O+JuHTk7Fq7UWSNEXVLhJc+6TnTnsXBOJikFHLZlzY3EF?=
 =?us-ascii?Q?V0z88/2yWwQriKik7YFt5XLQSpP5s1PlRprA9ZwG/JY1vUG5pV61vxajfRqv?=
 =?us-ascii?Q?DBFUBVL8xXmtl8bjsN5F1rgO+CioihwpCvbJEGq/yx5YWmt/ofH40eeD/po8?=
 =?us-ascii?Q?AqPqtOIf52JAlmcvYB0=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d94615da-c626-4ac8-ad42-08dcef1b22ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 02:18:20.4185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U6TbxCF9ihddOGHYhuSP6WTS40oflCWt5kbKNNMjTLAOHmnq+AjmjvttPqUhOAJ9yh1eTQxaxAWRCRWPn06dvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11073

> > -----Original Message-----
> > From: Wei Fang <wei.fang@nxp.com>
> > Sent: Thursday, October 17, 2024 10:47 AM
> [...]
> > Subject: [PATCH v3 net-next 12/13] net: enetc: add preliminary support =
for
> > i.MX95 ENETC PF
> >
> [...]
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> > b/drivers/net/ethernet/freescale/enetc/enetc.c
> > index bccbeb1f355c..927beccffa6b 100644
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> > @@ -2,6 +2,7 @@
> >  /* Copyright 2017-2019 NXP */
> >
> >  #include "enetc.h"
> > +#include <linux/clk.h>
> >  #include <linux/bpf_trace.h>
> >  #include <linux/tcp.h>
> >  #include <linux/udp.h>
> > @@ -21,7 +22,7 @@ void enetc_port_mac_wr(struct enetc_si *si, u32 reg,
> > u32 val)
> >  {
> >  	enetc_port_wr(&si->hw, reg, val);
> >  	if (si->hw_features & ENETC_SI_F_QBU)
> > -		enetc_port_wr(&si->hw, reg + ENETC_PMAC_OFFSET, val);
> > +		enetc_port_wr(&si->hw, reg + si->pmac_offset, val);
> >  }
> >  EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
> >
> > @@ -700,8 +701,10 @@ static void enetc_rx_dim_work(struct work_struct
> > *w)
> >  		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
> >  	struct enetc_int_vector	*v =3D
> >  		container_of(dim, struct enetc_int_vector, rx_dim);
> > +	struct enetc_ndev_priv *priv =3D netdev_priv(v->rx_ring.ndev);
> > +	u64 clk_freq =3D priv->si->clk_freq;
>=20
> Not happy to access 'priv' struct here and redirect again to the 'si' str=
uct just
> to get some init time parameter value like 'clk_freq'. enetc_rx_dim_work(=
)
> should
> be fast and have a small footprint. Messing up caches by accessing these =
2 extra
> structures periodically doesn't help. Pls move 'clk_freq' to 'priv' to ge=
t rid of one
> indirection at least (I don't have a better idea now).

Not sure if this helps much, but I could move the clk_freq to priv.

>=20
> >
> > -	v->rx_ictt =3D enetc_usecs_to_cycles(moder.usec);
> > +	v->rx_ictt =3D enetc_usecs_to_cycles(moder.usec, clk_freq);
> >  	dim->state =3D DIM_START_MEASURE;
> >  }
> >
> > @@ -1721,14 +1724,25 @@ void enetc_get_si_caps(struct enetc_si *si)
> >  	struct enetc_hw *hw =3D &si->hw;
> >  	u32 val;
> >
> > +	if (is_enetc_rev1(si))
> > +		si->clk_freq =3D ENETC_CLK;
> > +	else
> > +		si->clk_freq =3D ENETC_CLK_333M;
> > +
>=20
> [...]
>=20
> > @@ -2079,10 +2096,11 @@ void enetc_init_si_rings_params(struct
> > enetc_ndev_priv *priv)
> >  	 * TODO: Make # of TX rings run-time configurable
> >  	 */
> >  	priv->num_rx_rings =3D min_t(int, cpus, si->num_rx_rings);
> > +	priv->num_rx_rings =3D min_t(int, cpus, si->num_rx_rings);
>=20
> Duplicated statement.

Oh, I was not aware of this, thanks

> [...]

