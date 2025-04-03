Return-Path: <linux-pci+bounces-25200-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CCCA79A6A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931A817211A
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 03:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CC9178372;
	Thu,  3 Apr 2025 03:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lrv4m3+8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2079.outbound.protection.outlook.com [40.107.104.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDB82E339D;
	Thu,  3 Apr 2025 03:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743650566; cv=fail; b=AF6hRNBaIsBddZAPiiIxJgDX2MKzlpGYsVsW96SMl3r3u2SJy72pZY+N3EeS8pdgBpGIGDm87ABNgJDO1GMKuOYcL1S5ZAaYJKK6kilyvTJ5SPvyEB+6uBMcw3b89EDP0csgbtaLyTUhFJ2+8QhY1uQRa7nbUefelU5VaHtcco8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743650566; c=relaxed/simple;
	bh=iHI0YqkBKRGg9RIBUbOKXQI1vbxFWwvXVylY/2OtvxU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PemknfUqH2hTUC/FEDhb20PCkhOcFVSd0hgApWIA4m3JCkaeOCG0fyES2H+O7AlNG7cqUjFOtLGzWA9yjEts61ycNvubVLXREPfxsydm02ELOcfkrnnhQOvuC/6S1jdw2Z8YMypZdVnsqb3bDfNbBMmO9fPFhyAAyEeb9Ihana0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Lrv4m3+8; arc=fail smtp.client-ip=40.107.104.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzuoPbALCePsj5zk4au4yZTc2Yh+xdYpOw/8kU/XvY/0egN4jcKzt7IZLP3Xkfp2lWJXJ4xSZOhD/oi6P8Lcfkm6/Ug71MrMNc0nBpU0Rbyr3TUQQaq7yF4zRbS0sB0UYivth/lZDR90egXtLkli8FgydqVjqwkn0j0RS3/mS3+uIamdbWLjf+67jbmX2b1hbKGz2RImPh/aVGmYE4lLt19wmSCGqzFUkfbHDE/xparyg96xfiubACJ7KlTud+P82w0REyjJu7Iqx1q5OmxQddSVYcXaYWvZJZuwNU7G8B7uzqDgnx102McCqyrkwKBLrwX3CDlxFjRv5UpQ2Z3RQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHI0YqkBKRGg9RIBUbOKXQI1vbxFWwvXVylY/2OtvxU=;
 b=ufWeYtJ1MrpXC+JBR8a8HSujTZ8qVFTwevDwXnEkEv8KHQt5/7liC/LKsy7GBCOL1TgObeRx4KZBIbdcTiFsw1MJnstvsXwpIUSh8CVivdfQ/5NcJBtccwji2BVFEK91tSqZ1SCx7J9HcReNjMRSI18BxKztrm6jty4ecQhW3/W/oyyYSoHVloYKZhrzSGt+Nuds4bgQl9BT16+R4TiFzbycnxnsT5AQPFwW4LOshEl0QxrObce6QPMXBfCXUOaGgfIadrBsqpDAIa3KwBw7PgNxE7jd16bZh69erUwMoWQzgq0OYh6MClWIpv4byrus0uKrWhzydWMUe8D+kF+BGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHI0YqkBKRGg9RIBUbOKXQI1vbxFWwvXVylY/2OtvxU=;
 b=Lrv4m3+8wpXUlZeWt70o+zrIFALzguVnyXaFanKpN3zJhZKaNar2Chge1ZGqc/nGPkrlKro1tMFOokae3taoy0QUvnqtPFVDFVB3MLcDkOlynaaJw+zHX71r+bHHv0B9UJNsSx9qapsyR45BdByx4wMOxehkF+3Z+mF6Ynxs4g5tR8iDHAhdii8dEIzwYIcDE5swWajryTkL7lLPx3KoviWCJQTzMf/cY1xZaEW5uUGIjjujl4AyWqoFjb0Q+hb2arty1cWypN553L6oo5jOLWKI6QEOz45rvJbARCpb/crw4TqEiloM1kshVrFYPAkGYBOvMNpQvFGAKMxrX0g35A==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8996.eurprd04.prod.outlook.com (2603:10a6:20b:42f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 03:22:40 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 03:22:40 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit L23
 ready
Thread-Topic: [PATCH v3 3/6] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Thread-Index: AQHbn44DKK1oo7avrE6ytacDA3gL7LOP/LQAgAAFMnCAAIO0gIAAxEXQ
Date: Thu, 3 Apr 2025 03:22:40 +0000
Message-ID:
 <AS8PR04MB8676BB3EDFCF3E5A490AC0628CAE2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-4-hongxing.zhu@nxp.com>
 <ovaomfvo7b3uxoss3tzhrkgdy6cvxi4kr2zxmqsfjxds5qfohl@t6kc4rswq6gp>
 <AS8PR04MB8676687332C78840B927E7568CAF2@AS8PR04MB8676.eurprd04.prod.outlook.com>
 <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
In-Reply-To: <rqgl5jjauppyudgmugp34fillkeli3qkwf4uf2djghi6nslebg@pyi6rbwyduxd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AS8PR04MB8996:EE_
x-ms-office365-filtering-correlation-id: 574a36c7-5ca6-4a0d-c8e8-08dd725eca9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ekNybUlDMEo0YUhoUVV4NVY2T1ZxRnNZd2hCb0hSaXJsSWdHeUdtR003dyt2?=
 =?utf-8?B?bU5KMVNwK2NxVFRjcDBTYzRuRkJ5MzNHSFFSbGFuUWd3VDZXeFhFdXFBTHpC?=
 =?utf-8?B?TkJRd2FnUGZzVlM2NzZjeHoxM2JiL0JkcXZJZFVXYWE2YzZvUi9mZXJSUUNi?=
 =?utf-8?B?cGJuMTRuMDF6M2diTVRuWjNDT0dFblV3RGR2UCtROG9uTG1SbGdsdnRJcWdI?=
 =?utf-8?B?SzBsbnU1MFJOc0tZYVZvT2RtTFFTVmRKT3hFVnMxRkUrc05PaHFsOXVjSk5m?=
 =?utf-8?B?ZThGWXlkbUNPRmRab1VLMnFKMzhLUUNWSCs2TGZDRWtBNHFLdVQ0TEx6TEhI?=
 =?utf-8?B?WHJxaER3aVJzNTFITFZFR2ZhREtUeG9nM1I4Y2Z0TVExVStIdDVqUXZWYlpr?=
 =?utf-8?B?UCt2M0NHc1h2RE96c0FvTnJHVWR1UU45MVUzbTJNd2VyQ2pheU12QUN1azMw?=
 =?utf-8?B?MkMxL29Vb1g0WUhDSlI1eFFFZEIrbEFkMFlvaTFKeThIWjR2cmFSV1NCTnNo?=
 =?utf-8?B?WjlDNE9DREkzY2ZzaTIvMllZbTBROWZZOWVHV0oxcTlOM1RFcmhXbytUK3ZU?=
 =?utf-8?B?RHVFOUx5V0tOVFp3aXJKNmtsazlKb2c1cjBOWXE2L3JlSzFzaUVHQXY3YXow?=
 =?utf-8?B?ajl1UXpJdlRNVWZJcWkxT2ZWdURneTNWRnpqMTNLWWpyY2t3NkR3aGI0U0pE?=
 =?utf-8?B?N0JRbTRRTFRaT0huaG9LcnhLMHdPSEJ1dU10TWU4cFpUblEwd1hOU3BQZjk5?=
 =?utf-8?B?SEJxaU1BbjdtLzJwT0J5dkQwakxhazI3clNsaFpSYWxxSjJ3MG10eVRROXZq?=
 =?utf-8?B?QXJLRWxXNkVBQmhxUlk1OXdGTHRLSVZjMlFxU1RpOUFITWlyR0JraDhma1Yy?=
 =?utf-8?B?d0RNU3hwbmt5c0wvaEg2eVRmVkpyZXRvaUZwblZ6bXE3OExMUjhYTVNkR2pp?=
 =?utf-8?B?SVZsVXNhY25TVTVIekQrUDNLQ0N3cUJOQ1lXY2g2VlpmdEJZUndmVVJWays2?=
 =?utf-8?B?SGp0V25MZGJtdUZ5ODNiVjd3elN3Ym1ma201TnBxVkhtTVh2UGU4UXFVeVpX?=
 =?utf-8?B?cDhyMWRTWjFBdjRQd1FFQmd1ek1ZOUxJclV6eThUYXhySmRITFdyTkttdjhq?=
 =?utf-8?B?TGRuenRwdGZzaC83SkVxeTJjYzd6cFRqUWtEWUtzbWpjcTk1MHc4bWpqRHpu?=
 =?utf-8?B?WTNsUi9NQWMxK3ZUbWNldEx4VFRDbisyQVdyUXkzdXdpUXVHRk9sRVVVSTIx?=
 =?utf-8?B?cEFROHJVWm5KeUNML2NUN1VianhYR3kxS1NSSWJKZE1uYndFMUVzb1dxU1Bo?=
 =?utf-8?B?V3Ira2Fma3Yrd1JlVEthZURQL2NEWFBpR0JJMEs1d1RJaVkyVEI5ZHIxOGJJ?=
 =?utf-8?B?cFdXY1RJaXVrSW9IcUlSck5iWmpUOEYvL25QRWlES2p4QVhJTEVuaCtqQmRx?=
 =?utf-8?B?RHNqZTR2YWN5WVZaclFkSUZqQ2s2cjFZWENmQkNZZEpQajZ2OGpJNjJRbUtH?=
 =?utf-8?B?b2RWRUtXeis4NHdsR29YbU1DeHNmbFZEYk51UGZsM1NxVC83QW5HeldILzNu?=
 =?utf-8?B?dmZBWnNtTFFzampPU2l6eFJlcTVKTCtvTTdCZkR5T3dHTDd1R2NGYnlyM1I4?=
 =?utf-8?B?Y1dPNzlzWWxUYlJkbVE4RTNtU1lNL3hrQjZOV3lycnpmcWFhV0s4N1ppeHg0?=
 =?utf-8?B?SktUTms2Ykw2Y25XRFN4ZGNpaU5IZ1RjZzQwS2ZWRFhUUm8zRWF5WklVTWFB?=
 =?utf-8?B?UVNETDZCblcwZTNKMWJhR0JSUTRibHpYbWR5TUoxeXJ6VER1c0lLN01XMW9t?=
 =?utf-8?B?RlAvZVZYcmtaRUwvZ3ExQjhncUZCYzRheXJ1N2ZRcFFVZ0NmcG96M2szbGl1?=
 =?utf-8?B?bmEvTE54anR6MjJ1N2Y5NDZpZ2xyTiszenBRTnBwOEgzamVTWnFYOGJlYnZJ?=
 =?utf-8?B?WW93eG14c3VRdFlpVVVIdmhRZ1N2cGNxdU9jdXZtU3pUamY5R0EraGtHSC9T?=
 =?utf-8?B?N25tWlN6QXhRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YlRLYVgyVmV1cXNzK3NJakJxR0t0b2xaS1RKRlUzTHJVWkgxd2VqSnRvZjFl?=
 =?utf-8?B?Q2ZyU1hRcEZBN09TQTd4dTd6VEhXZ2xxRGtpTjJLZTF3L3RwL1hxNncrYVZl?=
 =?utf-8?B?QXkycXpLU3BZVXRENzRoMzlFd0p1aHJLSnZtWnB4ZytPeWVYR1BHOXdIY1dn?=
 =?utf-8?B?MXcxMTAxVWdkdndVeUdla1VPcWwzdFlqOWF3d0lZSnRncXlzSnQ1blk0czVq?=
 =?utf-8?B?UHQyQ3l4QXE2MnJiNTlVVGZ4Z3ovSVhlbzJaNDFxaTNWRjlNMXJaMEgvSnFC?=
 =?utf-8?B?VHZncEFzbGFDRkZieTRnb2dLYUtyNFFVM3JTSUZiNUJyQ1V5ekV2M0czRVl5?=
 =?utf-8?B?NUg4MW14NzY2aE5nS3I4WFFDclByQ3JFWk5NbzRadnZGMlVaM3lqenR1Q09F?=
 =?utf-8?B?VEQvaWpOSy9WandSMjNPdFh0YkJ5L1RRTTllS3E4UDZ4citQeW5DNTlxWlF5?=
 =?utf-8?B?VzluOG1IRUEzeVI5Ri80Umo1L1NrZEtYZDAyVXhuUlVBeWZ5YWNNS2xvRXZF?=
 =?utf-8?B?YndyckQ5bzhiSHZCclZDY29VL2RPWmY2d0tITVN0YVN1VTFhZ0ZOSHB5a0dS?=
 =?utf-8?B?Njd5R2NQbmljRytMU01XSTE2a0g2cUE5MDc0V0ZqNGJmVFhlREtYOU9OeWda?=
 =?utf-8?B?dEVMRXd0a2VmK1VFdWlBZ0tPbW82ZW1PL0x3L0lqd1hKWWdPODFTdUIyZmUy?=
 =?utf-8?B?TTRVVU1iZklRZ2VMU1o3eGloMUpxbVlIM1dHYnZuRFROSUx3MGNuUXpENjcw?=
 =?utf-8?B?OGVFKzlRM0EzMjdWb0RNT0NGY3crbnJoTjVMR2NFWFpHb1RhYVRhajB4RCtB?=
 =?utf-8?B?VlJoSFF5dlVRNzFLKy93YnVXRVFOMVhaUlMrNnBkR2VyWjNuWHN3ZnJCMTlI?=
 =?utf-8?B?aTJKWWU5MFZsS2k4NXlyaFZRcHMyWnRaeXBZNWErdXJDUUNIYUxKUWFDdTJ2?=
 =?utf-8?B?VXBQOGZtZytOcFRMUVloOUwyeUErTUVCaXRHVHc3SkFmZG9lcHE4dTN5enpz?=
 =?utf-8?B?TTFhaEFVYWV2N2RySFExUnVCWThxdkRmYnlkdW1YcFluZENwNUlQcm9OYldO?=
 =?utf-8?B?YTNFVWdHTE5CRVZCT1NpODNYZkhmR2pjeSt5WTBjUEU1TDVrQmdEbWcwaXpp?=
 =?utf-8?B?d3pLaVJZQjMxTmltZk1WNDh3NmNNTXVMLzNwK2VjK2NrbU9ZSXl2UkhXTitE?=
 =?utf-8?B?SDBFNmgrRGtKM2RPY1RtakhyUm5GK3B1NWV5K0tQR1FCcndsa0VCSG5rWTZu?=
 =?utf-8?B?TDFXZkM4Q3FqdHUrcVJHTU5oY0dmcmZIR0FieFFGVVFpU2ZRM0NQMm9jTEdR?=
 =?utf-8?B?Snd4cDVzZW5kVVJVVUw5U0tUdFdzRlpKVjBYRVhvb0ZPSzVNVnlnNXNxdCtW?=
 =?utf-8?B?T2Y2THJHd1hCYVFQTXVjSkFSZ29xN3lSajlRQi9sNmg3QXNpTEJXR1hiNVJo?=
 =?utf-8?B?UzNVZ0JRWWhzWkVDUE5QZEhMeHo5MWpEelM3VHRhZHFWZVlGWVpIVCs3L0Ns?=
 =?utf-8?B?bGNDU1NFRW9hM1FTSVdMcjFKdW1icm9kQlNJbFQ0cEZzdXF0L1VyejFnYy91?=
 =?utf-8?B?V2I4dEdrVklIbGxhMXpUQTZNUURCejJEZnc4Q1hXOW1MQ0dMWm40U3dSbENv?=
 =?utf-8?B?UVhhc1NJSlRGRzdXTlRlY1VXRXROUEh0QVRkb20wbzVlYWJHck9VZXJDYUY3?=
 =?utf-8?B?ZGl2dy9ZS0hkbmVxUG9sVjFhaEpSUTB5dmQ5ZWJHbVdGbmNPdEE3cS93M0Ey?=
 =?utf-8?B?NFpPTDM1NlF5ZUIvcUt2WExqV0FHK2x5dkx3SkFzdXBaaUczQkErNi9jalE1?=
 =?utf-8?B?TGFwdGZkVWF0ZFBITm9ZK1BUQ0JRN0sxK01ZTTVSNUk0L1J1TnBRdGRrOG9l?=
 =?utf-8?B?UUJQYXBOWlZvUXlwdXdQTHE1ODhsZExUWVVxYnFqZ01mVEZ6WDEvWk1LYjMx?=
 =?utf-8?B?bGc2a3ZQWUwzaHpoRDlOS2xrUVV5cUc5V3Q5ZGVtcEtJem96TlZMc0RJQmF0?=
 =?utf-8?B?ZTlUdXV2dWdxellFM01JNVg4Wi9UMjE1OHUzYmRpcXp0S2FPdzJObmVGQm85?=
 =?utf-8?B?SkhhdHBVcFduRUdDdXFOT3lpVEhMOVI2ZWhRUEJkQ0NKTnA4N0hKa2xhZnFM?=
 =?utf-8?Q?dlGGoogyr4ffBHlDdvZJ7XrFi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 574a36c7-5ca6-4a0d-c8e8-08dd725eca9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 03:22:40.7706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfHsungVGVDYYTTdoEtgwBeZ4aUyZL+vcmkC9GdwG5qSDLRfj/tLJa/xH5EL0hQ695HZgAc106M4yoEHUaeDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8996

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbml2YW5uYW4uc2FkaGFzaXZhbUBsaW5hcm8ub3JnPg0KPiBTZW50OiAyMDI15bm0NOac
iDLml6UgMjM6MTgNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+
IENjOiBGcmFuayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7
IGxwaWVyYWxpc2lAa2VybmVsLm9yZzsNCj4ga3dAbGludXguY29tOyByb2JoQGtlcm5lbC5vcmc7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVu
Z3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwuY29t
OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAzLzZdIFBDSTogaW14NjogV29ya2Fy
b3VuZCBpLk1YOTUgUENJZSBtYXkgbm90IGV4aXQgTDIzDQo+IHJlYWR5DQo+IA0KPiBPbiBXZWQs
IEFwciAwMiwgMjAyNSBhdCAwNzo1OToyNkFNICswMDAwLCBIb25neGluZyBaaHUgd3JvdGU6DQo+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBT
YWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gPiA+IFNlbnQ6
IDIwMjXlubQ05pyIMuaXpSAxNTowOA0KPiA+ID4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+ID4gPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBsLnN0
YWNoQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4gbHBpZXJhbGlzaUBrZXJuZWwub3JnOyBrd0BsaW51
eC5jb207IHJvYmhAa2VybmVsLm9yZzsNCj4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+ID4gPiBrZXJuZWxAcGVu
Z3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPiA+IGlt
eEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy82XSBQQ0k6IGlteDY6IFdvcmthcm91bmQgaS5NWDk1IFBD
SWUgbWF5DQo+ID4gPiBub3QgZXhpdCBMMjMgcmVhZHkNCj4gPiA+DQo+ID4gPiBPbiBGcmksIE1h
ciAyOCwgMjAyNSBhdCAxMTowMjoxMEFNICswODAwLCBSaWNoYXJkIFpodSB3cm90ZToNCj4gPiA+
ID4gRVJSMDUxNjI0OiBUaGUgQ29udHJvbGxlciBXaXRob3V0IFZhdXggQ2Fubm90IEV4aXQgTDIz
IFJlYWR5DQo+ID4gPiA+IFRocm91Z2ggQmVhY29uIG9yIFBFUlNUIyBEZS1hc3NlcnRpb24NCj4g
PiA+DQo+ID4gPiBJcyBpdCBwb3NzaWJsZSB0byBzaGFyZSB0aGUgbGluayB0byB0aGUgZXJyYXR1
bT8NCj4gPiA+DQo+ID4gU29ycnksIHRoZSBlcnJhdHVtIGRvY3VtZW50IGlzbid0IHJlYWR5IHRv
IGJlIHB1Ymxpc2hlZCB5ZXQuDQo+ID4gPiA+DQo+ID4gPiA+IFdoZW4gdGhlIGF1eGlsaWFyeSBw
b3dlciBpcyBub3QgYXZhaWxhYmxlLCB0aGUgY29udHJvbGxlciBjYW5ub3QNCj4gPiA+ID4gZXhp
dCBmcm9tDQo+ID4gPiA+IEwyMyBSZWFkeSB3aXRoIGJlYWNvbiBvciBQRVJTVCMgZGUtYXNzZXJ0
aW9uIHdoZW4gbWFpbiBwb3dlciBpcw0KPiA+ID4gPiBub3QgcmVtb3ZlZC4NCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoZSBwcmVzZW5jZSBvZiBWYXV4IGFm
ZmVjdHMgdGhlIGNvbnRyb2xsZXIuDQo+ID4gPiBTYW1lIGdvZXMgZm9yIFBFUlNUIyBkZWFzc2Vy
dGlvbi4gSG93IGRvZXMgdGhhdCByZWxhdGUgdG8gVmF1eD8gSXMNCj4gPiA+IHRoaXMgZXJyYXR1
bSBmb3IgYSBzcGVjaWZpYyBlbmRwb2ludCBiZWhhdmlvcj8NCj4gPiBJTUhPIEkgZG9uJ3Qga25v
dyB0aGUgZXhhY3QgZGV0YWlscyBvZiB0aGUgcG93ZXIgc3VwcGxpZXMgaW4gdGhpcyBJUCBkZXNp
Z24uDQo+ID4gUmVmZXIgdG8gbXkgZ3Vlc3MgLCBtYXliZSB0aGUgYmVhY29uIGRldGVjdCBvciB3
YWtlLXVwIGxvZ2ljIGluDQo+ID4gZGVzaWducyBpcyAgcmVsaWVkIG9uIHRoZSBzdGF0dXMgb2Yg
U1lTX0FVWF9QV1JfREVUIHNpZ25hbHMgaW4gdGhpcyBjYXNlLg0KPiANCj4gQ2FuIHlvdSBwbGVh
c2UgdHJ5IHRvIGdldCBtb3JlIGRldGFpbHM/IEkgY291bGRuJ3QgdW5kZXJzdGFuZCB0aGUgZXJy
YXRhLg0KPiANClN1cmUuIFdpbGwgY29udGFjdCBkZXNpZ25lciBhbmQgdHJ5IHRvIGdldCBtb3Jl
IGRldGFpbHMuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gLSBNYW5pDQo+IA0KPiAt
LQ0KPiDgrq7grqPgrr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+N
DQo=

