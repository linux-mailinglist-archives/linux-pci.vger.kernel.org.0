Return-Path: <linux-pci+bounces-14610-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171FE99FF26
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 05:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA96F285FED
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 03:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DE16FF44;
	Wed, 16 Oct 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XwExutJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010000.outbound.protection.outlook.com [52.101.69.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02ED57CBE;
	Wed, 16 Oct 2024 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729048379; cv=fail; b=D7IXP3IaUHoGZ9AgSRLNV9Fp96ij3Jvx+UUdF8utOsNY13dsBjhMWQpWgEK76Do6UfJWfDt5yoQBhb1QqkTj/t+2cIQ9CTyJL0/lDjRQl85Zn10rJVywh/GrKLuq5moyaxgveekJNOiRWslfI7WYG9yes3rFK78hX0zZyR4mynM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729048379; c=relaxed/simple;
	bh=LQAjNhyovFxfWWXSuIWt9FpufeHX8L/0y3rwu87Qeh0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hc5T5MQEtPbZ9x9mrpu+2oGmEoeF8CLUfgJcOSkHNXKN7YPKmpJDJnuReswIkFKUCrWi0MW3Kx38QXkOseiU8MIOBsXkPGEmRIWr/9i4ke8v2Vu+JcyZduuOiSINlSgt7NrVsHznGlAkNMq4F1ds5S+oVJ1uUQE4D6f/Ku8Nat0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XwExutJc; arc=fail smtp.client-ip=52.101.69.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNQn8deFEIJ4fmfJT+Vm5WOfsDOlkTRoBjFe01loZHG+0YMSsp/f5coVr++mG7oS2Ii8PqrCPuxRk/2JL2bgSV553TjM0nI1e5+vH1oxpBmEV2h50FAGYO3+l6S6knrgXikbISr3+Um2VozluP86OvDx4GuJjMCqwN68IBCiS7LxgVDIDaLsqFIH523Yr+JPjdXGcX9bCJECzDa8rkFooBBj1jZoocmgcgYBSvL5ZUyOw+kOCWwbBBd2kFdEyHAgd9It9PR173Rk7p73Vfx6VB94Xt2J5F/NP4nM4YKDRG//2q5DH7n3xZo3rICJ/qCCT0z1Sl4wgZby3uYWQ7lzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQAjNhyovFxfWWXSuIWt9FpufeHX8L/0y3rwu87Qeh0=;
 b=tY2bqHRNXKR7eNKpTmrYNHF69MGDHloFEOjmq3EJkI8Iua7EMZki+x5VyC9VDGX8jxwadMO7FRYR8J1JT2uoPCuWXjoeYAmasqFdQxypYvfIRocpXseQR5DzUh1y0/NQJRG4koPnppcFwC0HRX1nfuJu7strnYfGW61NFWM10sDgrQalAPw7vFF+C194yqnWrQL9cU+WbNBBtKtJGXGaLDTU8RE86mBMDz26K5CfFe4AyvrlisCYMadyIiseoWCKUoFkEVrbnBVVCyWJbC0PPM1oVGTGHw3+/TeVoIGaOtZGbN2pMBYSSNdUQRhQ2+2dJue3ziAXVZD+yxWH3v1fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQAjNhyovFxfWWXSuIWt9FpufeHX8L/0y3rwu87Qeh0=;
 b=XwExutJcvFUQWRrRoKgi/RJCFT+KfuXaTE3yOgOJvB9ZwucOxmy+571mToAAqzLyAcaDnDFW0Q4u10EQaQj6XOhVRNXuFmHkJOXKcSQoWzCSuRbDNnz1EWiKGlKyS92yoYHAIkTpnIP2wATA0hUcksbPBYM36DXVWak2HPo7cTlavXsqJvXEvFyABZab9c/Mxw4qH/Cvi9kKOfszZWnIq6bzg71/A4uK+lQjhWZkY4H+UFj2qi3N8QNsgIh4BIudxshE9FGETU4bsHy8tQY3CeH6KlhV+gYjQoK+NMlMApMdYxSiidRRxmUlXz/AP5rkmILmxaCNnXaeit0sa/zi8Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10668.eurprd04.prod.outlook.com (2603:10a6:800:26d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 03:12:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 03:12:51 +0000
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
Subject: RE: [PATCH v2 net-next 12/13] net: enetc: add preliminary support for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v2 net-next 12/13] net: enetc: add preliminary support
 for i.MX95 ENETC PF
Thread-Index: AQHbHwQxXBrdazfKGEW+klb1yVYxobKIJJgAgACGPIA=
Date: Wed, 16 Oct 2024 03:12:51 +0000
Message-ID:
 <PAXPR04MB8510D0801E08C3F526E4B2DB88462@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
 <20241015125841.1075560-13-wei.fang@nxp.com>
 <Zw62dNHsTbSKGV25@lizhi-Precision-Tower-5810>
In-Reply-To: <Zw62dNHsTbSKGV25@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10668:EE_
x-ms-office365-filtering-correlation-id: b91a46ed-d43d-4643-d008-08dced906ba2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?QkhMY0RzVEtNMGVlM1JRTitRclR3VkYwL3A4OGV2dWZ4NVR4dTRlVkxTdkxP?=
 =?gb2312?B?WlhRUkZPS2szL3FkSVFxcC9sSDhEMko5TXJxNmd2eGd4TjdkRkt3V3N5dnBi?=
 =?gb2312?B?Ui9BU1RtNkRSelhQcCs0a0Uyem1MTzhtb2J5dDUyZFY5eUZ6TU5QRFhOVno0?=
 =?gb2312?B?NlpuOXowdU9mWGVzMWVqM2ZPNzJPb0o4V29PTEtXMGVIbmVqamFxRmRkd3lu?=
 =?gb2312?B?UW1ZaHM4NS9QWXMvT0NUSXQ0NnJZZ0F4VFVZS3Z1QWorNktCMG9lNEhsUzE3?=
 =?gb2312?B?dSszMFp0eHppN0dXWXRFTEFMNlBKNDVYQ3B5NEk0NDNLZVBrdVdIbGZaaXYy?=
 =?gb2312?B?STFqb0FzZXE0U2hSMlZPRXlsUFQwQko0L01EbkpQdzFkZ3F4T1lIL2RRWGUw?=
 =?gb2312?B?cEp3dzJwTUZVRm11RHozZlF4ajRDd1N2eXFKdVA4YmJtelFzQXRsa3IxTFRs?=
 =?gb2312?B?SlRMNCs4VS9payswbXpyOS9sSmtxSm54REJ1SXhuWEpseDZpb09aWE44QmZP?=
 =?gb2312?B?bkpEZi9Hc3JCVWxSb044cmxrcmY0YTc1eDg5WHlQZ0NuaWVodkFlOFFNZzhQ?=
 =?gb2312?B?NDdLZXBWS2JNRDFtWHRudkRUdnJKTzRYa1Y5L1hEcjd5ZTRHY2dESGZ0aUs4?=
 =?gb2312?B?R2VSK25QZkxiRExaZ1kzQms3MzVHYWMzTjRiNUFUVTZaM1VyM1MxZDR0VHkr?=
 =?gb2312?B?aWgxaStqMEJvNm9Lak13ZU04NFBBQ0xKY3pxQ0VtVzd2clRVSjVoMkhkeWlN?=
 =?gb2312?B?ekxTUERhdzBhWU4wWmVrN2lEN0NKLzYzRVlidW1FV3JNUUdDSC83aG1sWllk?=
 =?gb2312?B?ekFsdnBLbGQwY25kNXllWHV3aXpnMzlpSHE1d2NOeUlxUTBVY1BoVlNRdllo?=
 =?gb2312?B?WU5zb2FoVitnejM5MkpRSFdVN0hGRDA0Q2EvRnZQOWVXNktzdjBnS0Z1ODVF?=
 =?gb2312?B?bkVrNytrZnQvTG9PSkhSS0F0L0Vsb3dSdkFuWXcwcyt0blhUbG44cElPTzBU?=
 =?gb2312?B?SWhsUERLUXZ1ejFlQ05xbW5McjZzalFtaStVSkVLK3VmUElXRVRpSDF1c1Js?=
 =?gb2312?B?YUE3OVdpRCtHN2szYkJwT0tWQWg4OWU5MlVBdGd0VGFNdldiakU2emk3cGp5?=
 =?gb2312?B?T3N1UTZmWGZ4VllqVXdiMTBpYjlzb1FRSkRlT1c1ZTlWdWYvQUViR0QyZ1M1?=
 =?gb2312?B?TXZMc1BkdlpzZmUrRGRSUTdBQkNFMGRlQWVDbTZxOXEwamV0UWhTZDlyVTI3?=
 =?gb2312?B?Z2xyMGtGWDZaR3luMWRaR0ZoTnlzS0VrNkgvd2lNdkU0cWM1QXBpa2VPWXox?=
 =?gb2312?B?M2szdFdtMVFtcEtHUzZCZjh3SjdSR1B2ZGtNYVNzZittd1o4K2FIUm9VOXpl?=
 =?gb2312?B?aVZIWkVuaUs4UktUa3d6Wk11bUlITU5STTREM2hjeisxbkJpdElLTWxHN2dD?=
 =?gb2312?B?c2l6QUtRMFpMR1BzVGx3WDVOTG5OYjJ1Q09WYXlldXh0TFlHNWRRcGlsWU9E?=
 =?gb2312?B?ZDEzQzlJL25KbEFhZmMxYU1kRzFJM1JlaVJFZVJQdVlmdDVoM1JHOEkxdmZo?=
 =?gb2312?B?RkJvanNBck1iU3QyU3pBTmJFdlhiek16QnkyTHZVb1BTajBGVkFTb0tRcW9Y?=
 =?gb2312?B?SDN6b2dDMTc1M3dyVFc2ZjBvTzhvc2oyUW1KY24vbjNpYXJLemR3NUttQXVs?=
 =?gb2312?B?czBtc0ttclVZbnp5RXUzMjZnN3l6TlYxZGJtTVBMTXhuOHI0N29zVUhXVDNP?=
 =?gb2312?B?ZDNEM1g3azRtOVFDRU5UZGVZaXBldDlqcEVTckE3dE9aZTVyQ2tTYXFsTzcr?=
 =?gb2312?B?bi9HZVh3K2twc1lNNnBIdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dXJZakpXSG9jdTFOcUdjR0ExYU9TcmViUDBDS0IwWXBWbG9vUDhDaVREdmlr?=
 =?gb2312?B?V29Rckx4dlY4UTVHdWxGb2gwdFY0aDZORS9zeU1oS010SEJpVDVIT1lQNFB3?=
 =?gb2312?B?dEoyOXoxRTY5NURRRmlucExRS1NUQ0JqRklJS3ZIZUNQLy92dkdrdW9VdGdG?=
 =?gb2312?B?bEM5MjFKU3pTMnhSNC85N2FjREQvOFlOK3BORXRJa21tekxza1ZoVkh5aTc3?=
 =?gb2312?B?VWtIcGRaZVhoQkxOeVREd0hhT0FaenJIb3R2WWZmRElaS2tpZ0owT3dWT3FL?=
 =?gb2312?B?dENvaGwrZnFlZkFIQjgzYmcveXNRL3NGYm5wZk1lZGhEbjBFSG8rSWE2UW1G?=
 =?gb2312?B?bGR4R1RSWUhDQWpEMW01K1NzenVub09LNXo0TUU3T2V2OEJHck9RREx2U1M3?=
 =?gb2312?B?SGxCdFJ6MTVTUkJFMWc4eFZzcW5XTU13NkJJb05zN1hVU0hQUUpDYzZyd1FE?=
 =?gb2312?B?b1hvbmwxV1NSTWw1K1lkelRFQ2tBSXFuQWNxdHFGbSs4K0tSQ1pHNXA3UXRJ?=
 =?gb2312?B?WW1Oc1Fjd0N6QzBMNHNLRm85eXFMNTRGRHBhRzlyM0d4WW1NUHpYekxaMWVL?=
 =?gb2312?B?SHZXTTJWS2xCRklMeWxwTXZCTmJvN2lWbmVtaXlUbTV3K2JaQU50dVRuNVBP?=
 =?gb2312?B?QlB3SUg4dzVnYS84VXdiSVE3bWNhSGhFbXczendXU2lXOXVnVGdaU1d3Ylpn?=
 =?gb2312?B?Zk9XaStTcXdURUZqYU5EVHNGaHh4UEFNUnBCQUJZMllvTVM5YnBvZ3FiUHFR?=
 =?gb2312?B?a2pJeUdVMHV3Q1I5ekhpVFdjd0xjU2FjalluN1kxQXF2U1VmWE9hVUFDM0tZ?=
 =?gb2312?B?SU1ZMys2WGZyRkthU1BSNEM4Q1pYbmdDZVV6cjZhbW9qTWU1Qm5jSEVEaWRV?=
 =?gb2312?B?UW55Zzh4cXZCcGNSa0pZWENQeW9BTDNGclBKZjk2bTVGbGNNUzF5QUNZWEdj?=
 =?gb2312?B?ays3ODVQQ2VUMkh2OTVzQ0Fmd2tZQitGczlMWFFIeHF3NEhqKzRlT00zYmVV?=
 =?gb2312?B?b2tiQWJsYjJUNTNTaks5b01hM2o1bU1OMDViS2doZHlNRHlJa2J6b2xvaEFw?=
 =?gb2312?B?cG4yQ2g5VnhTMFgwNjQrNVVhUld2TnpsY0FId3ZDM2hjZ012QWp5KzU3cHdV?=
 =?gb2312?B?V29nMGVIV0RibFNBRVVhZ2IxME0yUm1lSkZTNVRlVmorMnJPSWpucFV4NGpR?=
 =?gb2312?B?eUdzUm1yRkg4WkVFSG1sT1RKdGtCSzZjdk1rNDI0SWI0M3RGYUpDS3ZIbDNU?=
 =?gb2312?B?MElxTTBzZDJSWmtjQlZOZGhaYjByOUJuSGs1ZUxMc0lrbkRiazF5QXEwWXNX?=
 =?gb2312?B?VzZlK3Q2SHllazFGODZ6RG9DTVZmUVBaYXBiNWdzTEp4RkNJTkRHWUlJbko5?=
 =?gb2312?B?ZVhDMGR0dDBaa1U2bU9DQmpKR0VJWE94N2ljSGpvR1Fma1NreFBucDcyaEhh?=
 =?gb2312?B?eXd0WE9teDVEdDJadVNpbmpCS2M1eSsxMXQwaHIxSVdHbUk5Y1Z3c0ZFZDdN?=
 =?gb2312?B?dUZ5S0grUitjOHlaNjBaMUoweDdmNHBtdGptQTBrSW5ValZkZXNvblMrVlVI?=
 =?gb2312?B?T2w3VlJTckxYeG4vSEFNUkZwNlFtSy81VWpQcmJCVEJ2ZHBkK3JWVHV2Mk9C?=
 =?gb2312?B?UDFxaXhpODJ6SXN5WE1KaG9CMmJqVTkySXBSZjBmMUZqaWZaTGZTejBETFgr?=
 =?gb2312?B?VmNlTDlaTEUxNVl0SjNRdUhpRDJFb2FTU2dkb284aUNKRUdaelJUTHhmY0l5?=
 =?gb2312?B?VWJIZmMraEh5UGdiTVpwNk9Bc0hBeXVyQ0k1blIzZjZSWEoyOWpLVCtKM3h6?=
 =?gb2312?B?cFR1eXVnZWw0RVllWHlrR0E3cEJUOUYvRTlQSWpXOUZ3M0xieEs5T3BERTVj?=
 =?gb2312?B?aWFMVzVCVE1OVFliSlZBemwrejN4NzBIYWczaDBHZjQreTRnTDhxUEV4eUFh?=
 =?gb2312?B?bXE5T1VXd0lpSlBWQy92d0dkbDdxZExCQmlpKyt4TU9uSDNCYlo2OXprLzVz?=
 =?gb2312?B?RURDR0RzaVcrVHFoWk1TQ0pjWkxIM2lpYjBzZGxQN1dNWndXWGlxV3hPSi9k?=
 =?gb2312?B?QnpBRCtvR1BsdU9oNDRtUDBzZEFBZDE5OHBuK2JDZGtJdEFSMVkzNkNXU3J0?=
 =?gb2312?Q?LJxw=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91a46ed-d43d-4643-d008-08dced906ba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2024 03:12:51.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wj3wjPzlGseN9uoHiYPwTPUdIo6uNGkfwH4k/pCV96sYoYqerl+SibJelY4vMQODlK53K2g1cUU19gWucKhZGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10668

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqMTDUwjE2yNUgMjozOA0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+DQo+IENjOiBkYXZlbUBkYXZlbWxvZnQubmV0OyBlZHVtYXpldEBnb29n
bGUuY29tOyBrdWJhQGtlcm5lbC5vcmc7DQo+IHBhYmVuaUByZWRoYXQuY29tOyByb2JoQGtlcm5l
bC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgVmxhZGlt
aXIgT2x0ZWFuIDx2bGFkaW1pci5vbHRlYW5AbnhwLmNvbT47IENsYXVkaXUNCj4gTWFub2lsIDxj
bGF1ZGl1Lm1hbm9pbEBueHAuY29tPjsgQ2xhcmsgV2FuZyA8eGlhb25pbmcud2FuZ0BueHAuY29t
PjsNCj4gY2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1OyBsaW51eEBhcm1saW51eC5vcmcudWs7
IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IGhvcm1zQGtlcm5lbC5vcmc7IGlteEBsaXN0cy5saW51
eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgbmV0LW5leHQgMTIvMTNdIG5ldDogZW5l
dGM6IGFkZCBwcmVsaW1pbmFyeSBzdXBwb3J0IGZvcg0KPiBpLk1YOTUgRU5FVEMgUEYNCj4gDQo+
IE9uIFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDA4OjU4OjQwUE0gKzA4MDAsIFdlaSBGYW5nIHdyb3Rl
Og0KPiA+IFRoZSBpLk1YOTUgRU5FVEMgaGFzIGJlZW4gdXBncmFkZWQgdG8gcmV2aXNpb24gNC4x
LCB3aGljaCBpcyB2ZXJ5DQo+ID4gZGlmZmVyZW50IGZyb20gdGhlIExTMTAyOEEgRU5FVEMgKHJl
dmlzaW9uIDEuMCkgZXhjZXB0IGZvciB0aGUgU0kNCj4gPiBwYXJ0LiBUaGVyZWZvcmUsIHRoZSBm
c2wtZW5ldGMgZHJpdmVyIGlzIGluY29tcGF0aWJsZSB3aXRoIGkuTVg5NQ0KPiA+IEVORVRDIFBG
LiBTbyBhZGQgbmV3IG54cC1lbmV0YzQgZHJpdmVyIHRvIHN1cHBvcnQgaS5NWDk1IEVORVRDIFBG
LCBhbmQNCj4gPiB0aGlzIGRyaXZlciB3aWxsIGJlIHVzZWQgdG8gc3VwcG9ydCB0aGUgRU5FVEMg
UEYgd2l0aCBtYWpvciByZXZpc2lvbiA0DQo+ID4gZm9yIG90aGVyIFNvQ3MgaW4gdGhlIGZ1dHVy
ZS4NCj4gPg0KPiA+IEN1cnJlbnRseSwgdGhlIG54cC1lbmV0YzQgZHJpdmVyIG9ubHkgc3VwcG9y
dHMgYmFzaWMgdHJhbnNtaXNzaW9uDQo+ID4gZmVhdHVyZSBmb3IgaS5NWDk1IEVORVRDIFBGLCB0
aGUgbW9yZSBiYXNpYyBhbmQgYWR2YW5jZWQgZmVhdHVyZXMgd2lsbA0KPiA+IGJlIGFkZGVkIGlu
IHRoZSBzdWJzZXF1ZW50IHBhdGNoZXMuDQo+IA0KPiBOaXQ6IHdyYXAgYXQgNzUgY2hhci4NCg0K
QWxsIGxpbmVzIGFyZSB3aXRoaW4gNzUgY2hhcmFjdGVycy4gSSB0aGluayB5b3UgcmVtb3ZlZCBl
eHRyYSBsaW5lIGJyZWFrcw0KZnJvbSB0aGUgZW1haWwuDQoNCj4gPiArCWlmIChpc19lbmV0Y19y
ZXYxKHNpKSkNCj4gPiArCQlzaS0+Y2xrX2ZyZXEgPSBFTkVUQ19DTEs7DQo+ID4gKwllbHNlDQo+
ID4gKwkJc2ktPmNsa19mcmVxID0gRU5FVENfQ0xLXzMzM007DQo+ID4gKw0KPiANCj4gDQo+IEFz
IHBlcnZpb3VzIHN1Z2dlc3RlZA0KPiBpZiB1c2UgcGNpIGRydmRhdGEsIG5lZWRuJ3QgdGhpcyBj
aGVjayBicmFuY2gNCj4gCXNpLT5jbGtfZnJlcSA9IGRydmRhdGEtPmNsa19mcnE7DQo+IA0KDQpT
dWJzZXF1ZW50IEVORVRDcyBiYXNpY2FsbHkgdXNlIHRoZSBzYW1lIGRldmljZSBJRCwgc28gaWYg
d2UgbWF0Y2ggZHJ2ZGF0YQ0KYnkgdmVuZG9yIElEIGFuZCBkZXZpY2UgSUQsIHRoZWlyIGRydmRh
dGEgYXJlIHRoZSBzYW1lLiBIb3dldmVyLCB0aGVpciBzeXN0ZW0NCmNsb2NrIGZyZXF1ZW5jaWVz
IGFyZSBub3QgZXhhY3RseSB0aGUgc2FtZSwgc29tZSBtYXkgYmUgNDAwTUh6LCBhbmQgc29tZQ0K
bWF5IGJlIDMzM01Iei4NCg0KT2YgY291cnNlLCB3ZSBjYW4gYWxzbyBtYXRjaCB0aHJvdWdoIGNv
bXBhdGlibGUgc3RyaW5nLCBidXQgVkYgbm9kZSBkb2VzIG5vdA0KaGF2ZSBhIGNvcnJlc3BvbmRp
bmcgRFRTIG5vZGUsIHNvIHRoaXMgaXMgbm90IHN1aXRhYmxlIGZvciBWRi4gSG93ZXZlciwgdGhp
cyBmdW5jdGlvbg0KaXMgc2hhcmVkIGJ5IGJvdGggUEYgYW5kIFZGIGRyaXZlcnMuIFNvIEkgc3Rp
bGwgdGhpbmsgdGhhdCBkaWZmZXJlbnQgY2xvY2sgZnJlcXVlbmNpZXMNCnNob3VsZCBiZSBkaXN0
aW5ndWlzaGVkIGFjY29yZGluZyB0byB0aGUgSVAgcmV2aXNpb24uDQoNCj4gPiAgCS8qIGZpbmQg
b3V0IGhvdyBtYW55IG9mIHZhcmlvdXMgcmVzb3VyY2VzIHdlIGhhdmUgdG8gd29yayB3aXRoICov
DQo+ID4gIAl2YWwgPSBlbmV0Y19yZChodywgRU5FVENfU0lDQVBSMCk7DQo+ID4gIAlzaS0+bnVt
X3J4X3JpbmdzID0gKHZhbCA+PiAxNikgJiAweGZmOw0KPiA+ICAJc2ktPm51bV90eF9yaW5ncyA9
IHZhbCAmIDB4ZmY7DQo+ID4NCj4gPiBAQCAtMjA4MCw5ICsyMDk3LDE1IEBAIHZvaWQgZW5ldGNf
aW5pdF9zaV9yaW5nc19wYXJhbXMoc3RydWN0DQo+IGVuZXRjX25kZXZfcHJpdiAqcHJpdikNCj4g
PiAgCSAqLw0KPiA+ICAJcHJpdi0+bnVtX3J4X3JpbmdzID0gbWluX3QoaW50LCBjcHVzLCBzaS0+
bnVtX3J4X3JpbmdzKTsNCj4gPiAgCXByaXYtPm51bV90eF9yaW5ncyA9IHNpLT5udW1fdHhfcmlu
Z3M7DQo+ID4gLQlwcml2LT5iZHJfaW50X251bSA9IGNwdXM7DQo+ID4gKwlpZiAoaXNfZW5ldGNf
cmV2MShzaSkpIHsNCj4gPiArCQlwcml2LT5iZHJfaW50X251bSA9IGNwdXM7DQo+ID4gKwkJcHJp
di0+dHhfaWN0dCA9IGVuZXRjX3VzZWNzX3RvX2N5Y2xlcyg2MDAsIEVORVRDX0NMSyk7DQo+ID4g
Kwl9IGVsc2Ugew0KPiA+ICsJCXByaXYtPmJkcl9pbnRfbnVtID0gcHJpdi0+bnVtX3J4X3Jpbmdz
Ow0KPiA+ICsJCXByaXYtPnR4X2ljdHQgPSBlbmV0Y191c2Vjc190b19jeWNsZXMoNTAwLCBFTkVU
Q19DTEtfMzMzTSk7DQo+ID4gKwl9DQo+ID4gKw0KPiANCj4gd2h5IG5lZWQgNTAwLzYwMCBmb3Ig
ZGlmZmVyZW5jZSB2ZXJzaW9uPw0KPiANCg0KQmVjYXVzZSB0aGUgY2xvY2sgZnJlcSBpcyBkaWZm
ZXJlbnQuDQoNCj4gTWF5YmUNCj4gCXByaXYtPnR4X2ljdHQgPSBlbmV0Y191c2Vjc190b19jeWNs
ZXMoNTAwLCBzaS0+IGNsa19mcmVxKTsNCj4gDQoNClllcywgSSdsbCByZWZpbmUgaXQsIHRoYW5r
cw0KDQo+ID4gIAlwcml2LT5pY19tb2RlID0gRU5FVENfSUNfUlhfQURBUFRJVkUgfCBFTkVUQ19J
Q19UWF9NQU5VQUw7DQo+ID4gLQlwcml2LT50eF9pY3R0ID0gRU5FVENfVFhJQ19USU1FVEhSOw0K
PiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0xfR1BMKGVuZXRjX2luaXRfc2lfcmluZ3NfcGFyYW1z
KTsNCj4gPiArc3RhdGljIGludCBlbmV0YzRfcGZfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYs
DQo+ID4gKwkJCSAgIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICplbnQpIHsNCj4gPiArCXN0
cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3QgZW5ldGNfc2kgKnNp
Ow0KPiA+ICsJc3RydWN0IGVuZXRjX3BmICpwZjsNCj4gPiArCWludCBlcnI7DQo+ID4gKw0KPiA+
ICsJZXJyID0gZW5ldGNfcGNpX3Byb2JlKHBkZXYsIEtCVUlMRF9NT0ROQU1FLCBzaXplb2YoKnBm
KSk7DQo+ID4gKwlpZiAoZXJyKSB7DQo+ID4gKwkJZGV2X2Vycl9wcm9iZShkZXYsIGVyciwgIlBD
SWUgcHJvYmluZyBmYWlsZWRcbiIpOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+IA0K
PiAJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCBlcnIsICJQQ0llIHByb2JpbmcgZmFpbGVkXG4i
KTsNCj4gDQoNCk9rYXksIHRoYW5rcy4NCg0KPiA+ICsNCj4gPiArCS8qIHNpIGlzIHRoZSBwcml2
YXRlIGRhdGEuICovDQo+ID4gKwlzaSA9IHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsNCj4gPiArCWlm
ICghc2ktPmh3LnBvcnQgfHwgIXNpLT5ody5nbG9iYWwpIHsNCj4gPiArCQllcnIgPSAtRU5PREVW
Ow0KPiA+ICsJCWRldl9lcnJfcHJvYmUoZGV2LCBlcnIsICJDb3VsZG4ndCBtYXAgUEYgb25seSBz
cGFjZVxuIik7DQo+ID4gKwkJZ290byBlcnJfZW5ldGNfcGNpX3Byb2JlOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCWVyciA9IGVuZXRjNF9wZl9zdHJ1Y3RfaW5pdChzaSk7DQo+ID4gKwlpZiAoZXJy
KQ0KPiA+ICsJCWdvdG8gZXJyX3BmX3N0cnVjdF9pbml0Ow0KPiA+ICsNCj4gPiArCXBmID0gZW5l
dGNfc2lfcHJpdihzaSk7DQo+ID4gKwllcnIgPSBlbmV0YzRfcGZfaW5pdChwZik7DQo+ID4gKwlp
ZiAoZXJyKQ0KPiA+ICsJCWdvdG8gZXJyX3BmX2luaXQ7DQo+ID4gKw0KPiA+ICsJcGluY3RybF9w
bV9zZWxlY3RfZGVmYXVsdF9zdGF0ZShkZXYpOw0KPiA+ICsJZW5ldGNfZ2V0X3NpX2NhcHMoc2kp
Ow0KPiA+ICsJZXJyID0gZW5ldGM0X3BmX25ldGRldl9jcmVhdGUoc2kpOw0KPiA+ICsJaWYgKGVy
cikNCj4gPiArCQlnb3RvIGVycl9uZXRkZXZfY3JlYXRlOw0KPiA+ICsNCj4gPiArCXJldHVybiAw
Ow0KPiA+ICsNCj4gPiArZXJyX25ldGRldl9jcmVhdGU6DQo+ID4gK2Vycl9wZl9pbml0Og0KPiA+
ICtlcnJfcGZfc3RydWN0X2luaXQ6DQo+ID4gK2Vycl9lbmV0Y19wY2lfcHJvYmU6DQo+ID4gKwll
bmV0Y19wY2lfcmVtb3ZlKHBkZXYpOw0KPiANCj4gc3RpbGwgc3VnZ2VzdCB1c2UgZGV2bV9hZGRf
YWN0aW9uX29yX3Jlc2V0KCkgdG8gc2ltcGxpZnkgZXJyb3IgaGFuZGxlLg0KDQpJJ20gbm90IHN1
cmUsIGJ1dCBJIHdpbGwgY29uc2lkZXIgaXQuIHRoYW5rcy4NCg0KPiANCj4gPiArDQo+ID4gKwly
ZXR1cm4gZXJyOw0KPiA+ICt9DQoNCg==

