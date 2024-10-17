Return-Path: <linux-pci+bounces-14823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2A9A2C2F
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 20:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9660D1C20D13
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB6C17ADF8;
	Thu, 17 Oct 2024 18:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PS07fTpW"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2081.outbound.protection.outlook.com [40.107.103.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDE513A878;
	Thu, 17 Oct 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189862; cv=fail; b=rSonxImh4pg8Vrzw8zwFAnkEaof0hTd2Wx2J+9BjTdQi8M1JWOruViBUwt99irLgdsWgGrG01nt5lceTeEJPd8l/gocfGYLmvP4x3siaU4+H0RvzCR8pW26SQcOBpt/XokmoLdRx6e8EFhCGfXP0BUmxjI4sNOy/zfTls3AkKK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189862; c=relaxed/simple;
	bh=sJc7tfEjAZ8lzChW/bU2vB9QcrU2sa3aqbKliJcappI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dKwZN7YpaIvkZv+wAUvuOMpl8WOd5N89Bvob5UQA1aXhtGfq6TiWonRS0wuxujQehj0p0I/XfjnPWxZSFFsQiORXB20zekZlFPnMcaXjLgYuykpMCwl5mIqna9qYZu/K8fqi3b+YA16QmWKvAs4DeRif4M2+evVDIBEbO+U+VlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PS07fTpW; arc=fail smtp.client-ip=40.107.103.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EZ6s3AIN8BdF3SW2pjv0E9gGXpOhNuosa+oouvCamWLGsZAWatFZ55KVmBQ3LF6MY15gNHJM8dclAItl/GDTHOrjaGen0cGOIUPROtgTdSXb7bOGEDzXPLmUZ7ahz5XGpL9O19DOWNET5GaMbyFSQUu+n8PrZAR0xoDpJXyIHu/84put7ugJBHLKr4S5ZstKjQRwTSU9wCbZSmaxFYqn31z4yGgZJ2ay76CxjojKtTJ30N5ghFUrQnGwd5eTnraUqcUsV2tOminR5/q9aArjEP6Mp0FeeRUUzyZ6dZ4TjYyfCSD5WM3+A2EaT9bZnhCVY2wNwMwZCZCtMyX+GddgSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVakE6RK7nZJK19IEw0KNfzjdF/25HbgUnPboGSSVnk=;
 b=i1XvIBYHoGmarxXoc9jXRmCQ9LJ7ssOZJKR26RMyvCRlGN9UkWAJX+eo22yM6Rer5/Pap4hS7Atw4mllDIp/a1uTYV2smmm2F+1SIbqrT+X0OJmsAtJyikmKTP3ZxeKjRBWRf6GlzBF1h+X+/uWKWVnjiyMMJhxS0LqPoiBINS64Dh+ByLnkASy6TukJF3OV35L39yQ7rRgXAeJ0GW74Gc4QD5hq5QdW8Osrgar70acZQm/ROP5OEsRyMJJrF1mDCCbgjUodpitC3r/X1v00Bcd4+kO6ySR2fRG7PaVyApiYI+xKz0ip6OGvj0JOxecN8Z55t4GhHIVQqwZni1FOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVakE6RK7nZJK19IEw0KNfzjdF/25HbgUnPboGSSVnk=;
 b=PS07fTpWt4Fwjrr6sLQmsu9DFYEc+YLip3mlc3kXzsZkwcjLNrMpU4hy9m1Nc42KLeP3Z5aqbuDMRYmQw/iWErftngyUqTIzdR4sUDlek8gONKhl4gb4KQYx4ZnRTZpyyt6yWUJk9hXwC5T2WiqHdAEtvxDDv1zTMNeY0ZKc7eTxakR0Ym4RMFqS/lcZ0h2iujySBlERjiBXqXkMsE32PETeGABAuz1mzzktuenEj9Pb94mUzOhvTkBOwLQNqrLUHP6fKABSzNJUSkqFkMaXJ2pkch1mBJEWGKdQOeEUsj1hpId1kzh5qUMgyZ4/sEe3wZ8zNreQAI7Ri6BWzXOCCg==
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com (2603:10a6:20b:42c::17)
 by GV1PR04MB10306.eurprd04.prod.outlook.com (2603:10a6:150:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 18:30:47 +0000
Received: from AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684]) by AS8PR04MB8849.eurprd04.prod.outlook.com
 ([fe80::d8e2:1fd7:2395:b684%7]) with mapi id 15.20.8069.018; Thu, 17 Oct 2024
 18:30:46 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Frank Li
	<frank.li@nxp.com>, "christophe.leroy@csgroup.eu"
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
Thread-Index: AQHbIGsIfAvDgR/YZEaIQgKt0OyiKrKLOOTA
Date: Thu, 17 Oct 2024 18:30:46 +0000
Message-ID:
 <AS8PR04MB8849EAD1D2A4D3C84FB28C6796472@AS8PR04MB8849.eurprd04.prod.outlook.com>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-13-wei.fang@nxp.com>
In-Reply-To: <20241017074637.1265584-13-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8849:EE_|GV1PR04MB10306:EE_
x-ms-office365-filtering-correlation-id: 88d3820c-f15a-4c91-073e-08dceed9d10a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2V1dinDoYbW/7CQP+CiOgACkMQD/v+t8kILYk9N9ewheTw1fIesILrbCYSOa?=
 =?us-ascii?Q?RYK+SC5lYVfvitckSA6t8TE0YExPTGD2+UnISu2w3klrjvC6p4IjBbwgasSg?=
 =?us-ascii?Q?xJtk7n9MhmjXI5K54arqSVww5pM4pD+0rbEmmVqm0C2ITbNcjrJ70k1qBp6k?=
 =?us-ascii?Q?1OzJ3Kqbbo732lTEoDMoEpzc3PgoFYsZknuWauLDjK9+hki6JRsiu5KrnXjf?=
 =?us-ascii?Q?q88QZP7/8YyGpVcPeQVAK8ekBWxz3+yy/yPHBSPT/EKsHK+1fyvmgF/8SqC7?=
 =?us-ascii?Q?2Q4ULTi+vg+HMioPb8cnucwZdxzRsFoe/YPEiHT9DCVIXGxT7IZ8pgPyMYW/?=
 =?us-ascii?Q?ecmNKd09DT7nMyg0Ai1DsYRgXXNnOi0/lum/T3IQK4elbcQWjcfQZZ47SbSj?=
 =?us-ascii?Q?3XsEG9Jwwt9KQzMdMlkF+3JOUysWA8nGjAafue3gsLVq6ZhwXD+IqaA7PSqN?=
 =?us-ascii?Q?egzJaBjRuYyYcBAJFcLpui8SEW55gZkgfsl2l9Ui7aZezjEQa48IyGnf1fxu?=
 =?us-ascii?Q?hWzTywgXr+SoyZiiK4tLYRA78fcMRLmdTFHNqn2Lq5FWd3ag9zkqrDnnJov/?=
 =?us-ascii?Q?tgKphVs2E2Qt65j/u7qFcvHXRj7vIqKL/t68rGdblhjiCwnLA/ASQ0WlLHGH?=
 =?us-ascii?Q?uCw0zPEtYen3kNcn5RvYfUfVOOjcNa/qIUnqKhlxDdRukME+B5gk/HK6uoj2?=
 =?us-ascii?Q?1U1z0Kn9aYk1cYFob6t4Eh+Eo1zgB+EBqhdxhBq4N41s+xkng1WZ59pS1DqI?=
 =?us-ascii?Q?6uTQQqNJBPCyDenS0naBur5r6tESGFuRUNQ9mHP2PQAeRNN/n2LP/A3foSMr?=
 =?us-ascii?Q?uPLOOAKXZMG2zDFIzIf0RyFLCdu9eJu0terRn2s/tE6+k+9COy/Rvz2pnekG?=
 =?us-ascii?Q?C9dXy5VzjD2RaZuq6xJBw3lZ6D+MwkAZppvICKcC9p2+4UKfdOEiP3yEu9MU?=
 =?us-ascii?Q?U+0bI/8uQGz/pNMuZKdUOoA7C47EW73YFAN1lk8/MBkrI6jSkwD0EJ6A6suQ?=
 =?us-ascii?Q?xi8Wnkry4idNq5Nu5iMW+2SpRV2x4rnYtpC8tXYhB6cpV4LLuoxCZovEszeM?=
 =?us-ascii?Q?RjI1djVkDsqEGUExXTNBoXgOXiCCYncxmSh85kmPw9/Qw2jpHBC0eLidn62x?=
 =?us-ascii?Q?CspxoDTQsZlEzw2fn8SFcly4WO71tOh54BSHaWz8AVIpruCbaZYDY+54PPml?=
 =?us-ascii?Q?CrK9FiQbonqy84vEJfnkpOIBU8D53REhOEMq0kUnbtECq0P2mRD/IQoxm6HT?=
 =?us-ascii?Q?3cYS4dYx1k6iGYLykx6f9oWHkZFBhEwShlL6STGdvAHQb4LzSetRxyxReWyK?=
 =?us-ascii?Q?M/9MEAD9x2M18ouqESlEPdOwy7StovEN/NafCTQlpvWqr3fEPVxhcUULoYCn?=
 =?us-ascii?Q?AQw6JhyRtwrwZyQ+MetpoSwVWyfQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8849.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kVi4780sRsjFLKiytXMSDjHimLNTrYWV8HYQJJRNBX2Zw5MIs7dkvu8ioA3+?=
 =?us-ascii?Q?F0Oy5d6VM0vtxqjF+OmV1RmmQVCOibdifMopwnSQLI6ua+seP/rCxlWNoBdD?=
 =?us-ascii?Q?/gIRIwjK0Nm1FkRl3syP7VTqRAWkv+Kvwpq5cvypqIvarrPBtLzuxL9nteZ1?=
 =?us-ascii?Q?uPBH5fxc1B1YiNJYrssn0FSwTxZ/YB9U9ywENTTYXoW/31fnNqEhainHUP3q?=
 =?us-ascii?Q?9u9okhVipYEJjDo7vvyfSqcBB0LEgKaIjq5yjtmg5ArdaLDbKAtoi8WDiw33?=
 =?us-ascii?Q?po23RhczGYc/BxJfmI/ERXVuIqoiKF2K8uwHb769fO90BTRirHlUNPi+ntJq?=
 =?us-ascii?Q?8DrbmiDpAlCd1md/+NhIA97sFDvjkKwH/n32Pl9Qq+p/rGeEP5GE2wQxmNwJ?=
 =?us-ascii?Q?Fv5Nv41c2CPEHVgxmYH9V3W8RwR0gWXS9w3zgQrNjCVy7AhbNZUwso9f4Urg?=
 =?us-ascii?Q?WZEbojSd8bEz1IdcfbbJGVhJ8xIYZBgbj4xMLWJOvttBgcG6tUHX6zNvTZ+D?=
 =?us-ascii?Q?bCi2izi8bRuAOsbWxVJ/iV0qPsXrS3uE6+WZtcWQlS8rUhsS6gYa8aFnz8dH?=
 =?us-ascii?Q?gHS+OZ2t2g6oapJxhOwOkCsdE/Nh2o8HuiAvHt44bStu9AwYOGVJK37h24Yk?=
 =?us-ascii?Q?HzGjboAlEFDJgPzFCohkrXMmW/i9DiZ90F6lo4hcYy32FQBzAzHMUsEgEQ8Z?=
 =?us-ascii?Q?9npRqVB/kCKHm/2LVzjfSITzXbCbxZAS8MZWCpGuXmDh6Ic+vonSEJ/v/l7C?=
 =?us-ascii?Q?dETlCOhycFn5JJkQwbYduRGonf09j4r1YYLrehQGPUfYFNfLGZt+qeDKKLlu?=
 =?us-ascii?Q?2CHX0AYudpB3gnDsnY6vBriZmo4wm0p2uYdz1qgJjRFbrHGcjM1/kMBAK37l?=
 =?us-ascii?Q?HuXWxo5qtqT5N/FosY5fzilSbiWrxZIo+R0bPpcV67jQkjd3SV03M5E9q4ig?=
 =?us-ascii?Q?sgvn6a1nqf8gHXf5nr+0BTgr5bZlNKl3/XFFSADjBfAoudm3RQ5etKdRSOj0?=
 =?us-ascii?Q?qNSR9wttSg6a9dccaTyupHPAVWZNPUoH/vPRPeICxiEv+0uWowHWplcm6yN9?=
 =?us-ascii?Q?yN1alEoeMTn+U2cn+RsDO3ZX4GFeRigt2//r49Yc+UVXukKpDwJVzuyopk55?=
 =?us-ascii?Q?3lWnFESiw/Md287QosNFT12fr9eZLI4GjiawpS32j+oNVUzuh/u/tIqXfq8X?=
 =?us-ascii?Q?B8jbbkWXxxGB766cqaK/RYhLhD9Z4z62EGMmu95cN1s7nkj2nvom6uEkETtR?=
 =?us-ascii?Q?DmDGf8osmjyLc7OYkG74+fUciZzdCXBqYVipYBhOe6sVfUcqfNx+zoL9gK1X?=
 =?us-ascii?Q?Os/0y1wm0btghdaFmMM2B64uRNrlXXgTNpHRbn1Ztofpn48wIEbi3Q+Xj4FW?=
 =?us-ascii?Q?cet0tba0SoxcA8o3Y6ziy69qvHaTWNG77pwD/F8piue2KXHFkrV22JOyifdU?=
 =?us-ascii?Q?bz7wR1R4f+iu0AHzy5CjDQ17ka5cI9J/YTwhvj03vqXRg3cqQHpnaMIaJItM?=
 =?us-ascii?Q?DdSOGwxuUUUaJlP0/gZuz0tTORUv2B2SB2Q298a+Si6CAadWEI5Y33Va8ddJ?=
 =?us-ascii?Q?G3dFJaqdjP+FtAWxBDZxFtMX3+nkfUvgS+AuVyWm?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8849.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d3820c-f15a-4c91-073e-08dceed9d10a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2024 18:30:46.1732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mepDR0hkuOpVq3nJqk9enN/nD0eAwMzyQshy0KMrnipO+4OqYpqifopKzlUPGKTg8LRY6uIa33xhPjIViGohOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10306

Hi, Wei,

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Thursday, October 17, 2024 10:47 AM
[...]
> Subject: [PATCH v3 net-next 12/13] net: enetc: add preliminary support fo=
r
> i.MX95 ENETC PF
>=20
[...]
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index bccbeb1f355c..927beccffa6b 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -2,6 +2,7 @@
>  /* Copyright 2017-2019 NXP */
>=20
>  #include "enetc.h"
> +#include <linux/clk.h>
>  #include <linux/bpf_trace.h>
>  #include <linux/tcp.h>
>  #include <linux/udp.h>
> @@ -21,7 +22,7 @@ void enetc_port_mac_wr(struct enetc_si *si, u32 reg,
> u32 val)
>  {
>  	enetc_port_wr(&si->hw, reg, val);
>  	if (si->hw_features & ENETC_SI_F_QBU)
> -		enetc_port_wr(&si->hw, reg + ENETC_PMAC_OFFSET, val);
> +		enetc_port_wr(&si->hw, reg + si->pmac_offset, val);
>  }
>  EXPORT_SYMBOL_GPL(enetc_port_mac_wr);
>=20
> @@ -700,8 +701,10 @@ static void enetc_rx_dim_work(struct work_struct
> *w)
>  		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>  	struct enetc_int_vector	*v =3D
>  		container_of(dim, struct enetc_int_vector, rx_dim);
> +	struct enetc_ndev_priv *priv =3D netdev_priv(v->rx_ring.ndev);
> +	u64 clk_freq =3D priv->si->clk_freq;

Not happy to access 'priv' struct here and redirect again to the 'si' struc=
t just
to get some init time parameter value like 'clk_freq'. enetc_rx_dim_work() =
should
be fast and have a small footprint. Messing up caches by accessing these 2 =
extra
structures periodically doesn't help. Pls move 'clk_freq' to 'priv' to get =
rid of one
indirection at least (I don't have a better idea now).

>=20
> -	v->rx_ictt =3D enetc_usecs_to_cycles(moder.usec);
> +	v->rx_ictt =3D enetc_usecs_to_cycles(moder.usec, clk_freq);
>  	dim->state =3D DIM_START_MEASURE;
>  }
>=20
> @@ -1721,14 +1724,25 @@ void enetc_get_si_caps(struct enetc_si *si)
>  	struct enetc_hw *hw =3D &si->hw;
>  	u32 val;
>=20
> +	if (is_enetc_rev1(si))
> +		si->clk_freq =3D ENETC_CLK;
> +	else
> +		si->clk_freq =3D ENETC_CLK_333M;
> +

[...]

> @@ -2079,10 +2096,11 @@ void enetc_init_si_rings_params(struct
> enetc_ndev_priv *priv)
>  	 * TODO: Make # of TX rings run-time configurable
>  	 */
>  	priv->num_rx_rings =3D min_t(int, cpus, si->num_rx_rings);
> +	priv->num_rx_rings =3D min_t(int, cpus, si->num_rx_rings);

Duplicated statement.
[...]

