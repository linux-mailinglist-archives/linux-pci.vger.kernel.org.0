Return-Path: <linux-pci+bounces-16303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA89C1444
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 03:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7511A1F23D92
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 02:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959973EA9A;
	Fri,  8 Nov 2024 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PCGqmIAs";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HNhn5YnC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE90D528
	for <linux-pci@vger.kernel.org>; Fri,  8 Nov 2024 02:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731033697; cv=fail; b=Rt1rfMo7x5PTe4QR/hcfs0n3hF//y4dgHStJLVCdXM3JRireOXIMmNEvQP7FpmMbtJi/KDGWJMkt7BnJY0/O6aia48D26MFWr0cUX8YHmQUpY5N5B9bOYtbGOUoB4lhCMeXEp9UAyODoSYyR2ThH4Wk6ObbdwrurxPm8MTdeVQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731033697; c=relaxed/simple;
	bh=27fz6WFTk+qWe/V5qPRAfuDwsmVC74cE6461Uc451kA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SFAGF20Pe0mYuP/9hsf5LiqhrgQH3dUQp3/E0rqBNMPRRJvzZMgzvBDufGPxTF1ajnWQRJ3ZFR/TSvNVR/zh9xWwIYNk90witmqcRsyXRKBOGftcztpeYyUebMKFgTWBWTtmsho+8kenwtACnQDPJXBCr+JJvGl7/jfZUs3BTW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PCGqmIAs; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=HNhn5YnC; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f4bc8bbe9d7a11efbd192953cf12861f-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=27fz6WFTk+qWe/V5qPRAfuDwsmVC74cE6461Uc451kA=;
	b=PCGqmIAs6EsPxdOAbJp4j26xjKWMVk6tQ5Q7QquvdDham/stpZfzjXYINm+uqHiEIU2jVUTvvZ8NYz412JvhBKyVyaMermiKx18UnERSszKGhconLsQlgZ3ppwW1Kqw2SQOM7JVRE/8egBJbQYbenawM87jK4/AdGHDDUZtuYWk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:305e0498-32ad-4216-aee1-daf62e2fd248,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:ded3cf1b-4f51-4e1d-bb6a-1fd98b6b19d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f4bc8bbe9d7a11efbd192953cf12861f-20241108
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1469293392; Fri, 08 Nov 2024 10:41:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 10:41:27 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 10:41:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d4dP+IsNbhv1GBf4MRJEweqr42SysA4YLPMP+6lddDum3mXU/S9ccJw6MTcqxSLiUPoVhkZJ64ojroctkYdSQzmuP/09xhE0sqkr1f4PiBMmWuLAW/4zvLPu5/8Ghmt9xmush2ZVM+H7Un1Wskn5KXEeJbo6lLZgUjiJo+Htna6cqdFp+R8CJXTirr24c69lPAbKAc9do77+MnXm0LAh+8k2sgCrq6ZoHkaGAZyr5QSrq9PHubPshTikgO5mn5LX6EqQDji6AtC9pFoLw2HosauzhYG8mH0FHTk3xuQ++cFmSZGMLHbXlcCNWLPc4KsolF9Xh2V7uVk5i5esejyHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27fz6WFTk+qWe/V5qPRAfuDwsmVC74cE6461Uc451kA=;
 b=srbgynDCoscAaY81qs/+Ua5aXfP4Y1+tkihZRSQ1NlNnUEwHMHc3qY/bZ+eGRODEOr1OhbxtJQLlWuZcP5uyKajPVhbLMWL4J9fyLq8PAAnuTj6TFVEeNbydLjgX8bK/MGXJnT1LRWdpz/QgwmrJ+YpYK09089BnUX3MW9HbvpNbR/saO/GEuRxmJIF4bPKtOJB2bU4dKyPAD7Zx2wnCpa2Lr4Nih0Uk+tImzYjwG0aiqcCxg3lCrSwQMshG8zToo5LKpmUnII3mCwfuNkYkpUya9CPu4bNV+UUHUlQah7cP7/55YNJc4zs2ihFAmWV87Fek1fvX/M1ziy/T0Wp1hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27fz6WFTk+qWe/V5qPRAfuDwsmVC74cE6461Uc451kA=;
 b=HNhn5YnCUubGti5CBba4WD65JtAryEhDryTJu/nRdNcFIUULCxIBeV961LPenFm7c8bP+cEXcZhT5USROrmUOwxWQOeFAXTmDqZIR/aH5o2Nx+hbl+r9ly/I82FW0opcF+gEuGIgRXsD49Q/bE+e7ELCTqKHQ27fXtgtJQ092eU=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by KL1PR03MB8239.apcprd03.prod.outlook.com (2603:1096:820:114::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 02:41:24 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 02:41:24 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Thread-Topic: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Thread-Index: AQHbMRw97PA6QAWRm0+g05S2U5zNfLKr8MeAgAALsICAALC1AA==
Date: Fri, 8 Nov 2024 02:41:24 +0000
Message-ID: <5c04ba80ef7a280bf2925282173802a8b2f40f3a.camel@mediatek.com>
References: <20241107-pcie-en7581-fixes-v1-3-af0c872323c7@kernel.org>
	 <20241107152705.GA1614612@bhelgaas> <ZyzmFyRYDHX0W6bB@lore-desk>
In-Reply-To: <ZyzmFyRYDHX0W6bB@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|KL1PR03MB8239:EE_
x-ms-office365-filtering-correlation-id: e76d2df8-f02f-49ed-2167-08dcff9ed641
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?emR1b1VmV3JpMTE0WGsyRFYyNWRESE03YWl3eWJ0N0M1TlowQlBqc2xQdE5K?=
 =?utf-8?B?SmhsVWk1TTNIb1J2dnNVTXZ6cDFyQzNGNHQralcxeVVZT1FxZytsMnM1K3dD?=
 =?utf-8?B?SGNtV0NHa3dFcExDUitacW9WTDYxbTh5SVErWTZmc2NvVE9GRlZFYk00d2N3?=
 =?utf-8?B?OWU1R1UweEZhNGRDbUdvYTBLZjFUT2thejlSOVpLRWR3SUttUTVVY0gvbDY4?=
 =?utf-8?B?RW9Ma0FpUDVkZEUxdFVwZmlCWldFNzFHa1FxZ0svU3pqeU9NeVRreDdRc1p1?=
 =?utf-8?B?NWZWVjhMVjhMRlMrZEIxVVpWcVU4dmtEMUhENlJQN1p5cHFxZlF0MjJBQTBn?=
 =?utf-8?B?UElSaHpsaUMramd0cVNkL2dTaDVFUFFPeUswZW1OREEzMVE0eVQwVVlnYXdT?=
 =?utf-8?B?by9sQnJwR0t1V1pXWlhESDhkajFMc25GemNpQjVoT3Y2OEVLOFUrUWpWeTRk?=
 =?utf-8?B?L3ovT0NUOWsyY2hUc2ZoWkk2K0NCdjVLaWlsaUNYS3dSekFncVUxb2FxMmJO?=
 =?utf-8?B?RThkZ0VzbG5nNzJ0TktEd2wzZWtDNVVkeGtRcitZeXJzbUVoWkgvS1Yzb21T?=
 =?utf-8?B?MkVIbmJWVytpeHMyMEpCM05jOTB1OGtmMGFVZWxFckQ0b2pESWRpY2paVlRL?=
 =?utf-8?B?ay83RGhRekpudll0SVNFS2hTdTZORjFaNGQyTHBERmJEV0VnbGdGTXpTaEt3?=
 =?utf-8?B?a0QvM1RzVXFiRm4rYTkveW1LdkRic1dFdCtzTE83K2NYNGgyeUJqU25ndC9l?=
 =?utf-8?B?cGlDb1JYY2llNGdNSXhiS3pNeUgyWlVKdC95SFZ3Q0c5cHArdEc4WmczOFJj?=
 =?utf-8?B?R21WQmdoOTBqMEg2OEdwUk9GN1p3cmFtRCtRdlNSZ0RIb0UwODdnQ0IrY3pi?=
 =?utf-8?B?UG1lcUNJeG81VXlxVWdxSWtITjFBT043TXhTQnlqb1Nvazk1MzNscXUxUnI0?=
 =?utf-8?B?M3NCaGFieXBST015cmdCclRPYUs3Rjh1a1ROM3hKL1RYQ2tid29Pa1dBVVgx?=
 =?utf-8?B?cTFIRzJsRzE0VXA0b2NzakROQmxQb2I0emtmeXp6T2VZVHBnSUk2N0hNeld1?=
 =?utf-8?B?RVdpcHFRT2F1anVpUmRTbTgzdWNONzVnWEpxbVFCQXFLeHM0MXRsMGZQZnBC?=
 =?utf-8?B?M0Q0ZXRWSmsxU3F1TFpieC9FeTNTOUZRU0ZTdUF6eHN0ODl2dy9LYkVIaFNR?=
 =?utf-8?B?enpNWjVicUpaV3FmSHNEaC9pY2VGcDAvdjdxODRTcUJGd1J4eisybDVBM0g1?=
 =?utf-8?B?VXVzWmE2bHZ1SXM4REdLRk1BdUdaQXN6Rjl6WHdXdjRIb3B1UzhrTE9IVUZj?=
 =?utf-8?B?NHg2MXhqUUwrQXZ1dGJhVGVrNGpBdGFxZ1ExS3hvSHc1Rjl1aWcwZUo1Qmlk?=
 =?utf-8?B?bTdML2VrMUxGalZiSVV4VFpzL1BGU0lrd1dxUmR4M1lkb3FFWmNkc1RFQnV5?=
 =?utf-8?B?cHZpTk13Y0ZtcnhCbkRYT1ZQMjh6Mk5sUitKd1BxWTBRbmFHdzlIK3hPS1Nu?=
 =?utf-8?B?SjF5REs3cUROVlpmcDZ2L1lwZllFRkNjOFFZdXIrV2J6Z2RFbHVGdXo3djlW?=
 =?utf-8?B?bDV2cjVOMEZ1dVB2bW1wY1VvazNQV01DOVloQjB3T2ltL2lYQ2c0c0FkTStX?=
 =?utf-8?B?TnMwU2NkU0lYNGRTeTU2RGdCS3dQYWx6OFlIZFFoSXJncEZ5enhqUnIrWU9y?=
 =?utf-8?B?WklDOEVMblNiZmZBQit1ZHpVREFTakJLWmtHeENvclBHZENNaG9yd1hISkFm?=
 =?utf-8?B?bllWTUtJbitjM2NlZWdEejIzL1dlKzNITDhTYnlwY1A0Q0ZWMkNjaDIzQkZ1?=
 =?utf-8?Q?NqhfZd9dqb8NE2MGMxSh5StqMD5VCOE0FXtDo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGx2M1BZUkplS0Y0QlBqVTI4Y05udTZ3OW5VRXlIQVhhTk1zR0FxYkpZdWo3?=
 =?utf-8?B?cDREdG1QQUdHVjdQOWlwMlg5ZEYrbTFnZlM1MkEwZGpMRFBweXNFZmg5WFlL?=
 =?utf-8?B?WnhVZ3FMbzBTMWgwb2NXQjc5ZFRYSmNaU0pYdXNCS2RpQm9XNU5JOS8vRXN5?=
 =?utf-8?B?blRVMXNFRkNna1ZUSTJVL1pmdlpNYUp2ZDBoQlBDbkNmeG1KN1RPS2tzWStK?=
 =?utf-8?B?REtCWVJXVHFJMGJ6SnByV0ozcjJSZXJVVTdTcVF4cWx3N1o2Q2NzWGVQYUU5?=
 =?utf-8?B?c0Z3NW1NbTEza1JlS0lNVVJMMDRkU1JyMUMwS1pjOE5rNkplSzR2RU90Q0xo?=
 =?utf-8?B?MU50YnQ3dUh5eGg0L0xCZ3VXMXlXSzI2TEx1VzNBVjZVZTVITExsYjZzU3I5?=
 =?utf-8?B?U1NhSTZya2NrdUg3TGM2Y0E0V3FrRnFOY0RzM1U5T3dtK0k3Sm9nc1Bad2dB?=
 =?utf-8?B?RGRHMCtBN0pzTEoxaXJocTlzYU5yMWYzUjkya1JNeHZEbjhzcTdBcmRlR2dj?=
 =?utf-8?B?NE9LZ2FBZkt1OTQyeTRsQ2YzbE56MHJDMjU0dkRUL1lMM2hlMkpRS2pEb1Jz?=
 =?utf-8?B?d093empVN0pja1BhMWVlelpNMDdyNHRQendiQkZxZGlqVmJYSkI0aEQvaFJs?=
 =?utf-8?B?dmtYRVFRdHNkUXd4dklRVElvRFBxcGsxTDdFT2sreUdydXltMW12V2w3SWFR?=
 =?utf-8?B?R05GTHVYYWhFMzNvaHZEWmg4VXFZSWExNWEwUFYyQmhsVkQ2b1d1RzlCMnZ2?=
 =?utf-8?B?b3dRTmlwVU9mTHFmc3YxUUI0bUEwRjFsS0JXM21CQW9LcTdaSUQxMFlqOHA1?=
 =?utf-8?B?a2dXczFxL1VyOXRwaU5SditUeTFMSTBJcFpHY3NabmJZTWc1T2wvL2M5eHFy?=
 =?utf-8?B?VXczTEdsWktld04xWVR1QjZ4S0pPUmk2dGFySzVHRFBkbW1DVm1iQTROUklN?=
 =?utf-8?B?VEdWUzdiQUxlbG80bVVQN25ibjFBU0xWQzlxSHBWT2EwL2JuZFNTZjU5eFJG?=
 =?utf-8?B?YS9ocU1FL2xPa0kra2RLSVQveEppOWYrZVAzNnFlWFkrMHhqNXRHaWVnMDFX?=
 =?utf-8?B?QjZsUEo4Wm9RVDMzMy9MN0dsTEJ2MFYwNytGV3FVVXR5b3RYV0hiSWVHaFFW?=
 =?utf-8?B?Uk0wUDZwMVorMllWKzRGYWx0RWt1SzF4YmhhUDFOemNZUXBSYW1ETTZXMC8v?=
 =?utf-8?B?QXJSTWllREMvY2V6bVVFblZCLzNiTnJQR09rK3Vic1AwVTJFeXlhVXVFUkRJ?=
 =?utf-8?B?N2NUb3hqNXFqK3U4TlJFQ0pSdmExU2ZCT3dMK1I2Z21BbEo4d3lOZng5NW5h?=
 =?utf-8?B?bG1QN1lVcklSYmQwZnFCVUFzS3gwUkRuWmlUUE9DZ29NRElzY3hXckJuMko1?=
 =?utf-8?B?UmdQYU5EYmZNa1pSeWlENVVnUGNsbjNSejl5VnA5Njd4WFNqU21Cb2xwVDRk?=
 =?utf-8?B?MkFkMHJsSU9PRnBQVmttQVdrbFRQb3NrR0RrYmJrN3VkekhvZkp5WDlsQjhY?=
 =?utf-8?B?ZW9zZnZQV2dESUU2aTNpTjNhV0U0MWhzaUZhRWU4V0pSQlZqMG45bGFEVVRW?=
 =?utf-8?B?alcwaHdIcStkdy9vdjdWOWxKTWl1OXBadURxZnp1bnNEeFBOVEgxb0JMN0hS?=
 =?utf-8?B?OXFKcGRDbmhkTUNzdEFYZXYxYjVhVG9wblUwYzZ2YzQvMy8wM0xTbFRoZi9z?=
 =?utf-8?B?Q3QxekZTNVlIcWdvMm9QZ2N2cS9xNEp6aFhPbXBESFhxeERTcWlCMmU2aUJo?=
 =?utf-8?B?aXI5SjlaK2k5bFRKS2dWQWFGdVkrblJaSGVBaFZuS3AvWjlDR0dEWkhSMUM5?=
 =?utf-8?B?Rmw2VzN3THZGazlOekFLU0ZpbW1vaWliQ2NoV2FlTnU3a3lISW90YklmTjVW?=
 =?utf-8?B?NldWbG5OUHZ1ZFdCRU14U1F6dDJFMW1MQlMrYkFUWGgzcWN3ME1tNDlHU01P?=
 =?utf-8?B?akIzY2Z0UTYxNHRibm1obHd5UVVGcWlLQjZXS0hDSVNBOVRxZE1TdXo4Q2JK?=
 =?utf-8?B?eVA2clhPN05JUHIwaWVPYXg4SmhkcldQVjdqZGd5YkRLRkJycytaRFhxZXBj?=
 =?utf-8?B?dC9SaXJmSzNOcjRCNThleVUxSWp3dnk4N0p0MXl5Vlpyd3JYdndFYUYycGwy?=
 =?utf-8?B?WnpxUFVYYWpBZkNwQ3hFWlVEV0RVRTJzeTBwTmQ1bnhPUm1hNEFIdkQ0QVFP?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36B16398BD57424BA46D6C855C74CFC2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e76d2df8-f02f-49ed-2167-08dcff9ed641
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 02:41:24.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g//trN32Fn8cGk57RPsLffzT1UBHnzgI4w5CLYE7oVaDN91TIlqC/VJDnb7UfgsteCSgrZAwNcVc4+YN3IQovI17Rjb9g8/BpOYFFwibEm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8239
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.781100-8.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4ia1MaKuob8PfjJOgArMOCblbPAzatNoQsbK
	+pu0ZYwRBrr3oyhWzZYTzo/7p2GUyBLmJd2F/yFu4pdq9sdj8LU7r2Gtb9iBYSJ8zskw0dbroHD
	i7wfuepqxj+cG/tVNvjtvcmzcXq9UTkaqbB0m3sKXXOyNnX/prOPmXK6rwg5BZdzNCWiQJFk/Kr
	XN2adn+HG0WO1igPtfj5R8Z6SCRAPww+sel1EBga+dYEguu4aVT1s1mQSVaBjjsTquy0JRiy3Ed
	RJJW1f/P+mp1Sryxa28Pp73cpmr3fhDfjwsp9c430XlLB/ilE19LQinZ4QefKU8D0b0qFy9mTDw
	p0zM3zoqtq5d3cxkNQP90fJP9eHt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.781100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	814F4E830B0E3519719948B115E37A2EC080F6F6370D4C5FDF025DFDD65EB13A2000:8

T24gVGh1LCAyMDI0LTExLTA3IGF0IDE3OjA4ICswMTAwLCBMb3JlbnpvIEJpYW5jb25pIHdyb3Rl
Og0KPiA+IE9uIFRodSwgTm92IDA3LCAyMDI0IGF0IDAyOjUwOjU1UE0gKzAxMDAsIExvcmVuem8g
QmlhbmNvbmkgd3JvdGU6DQo+ID4gPiBJbiBvcmRlciB0byBtYWtlIHRoZSBjb2RlIG1vcmUgcmVh
ZGFibGUsIG1vdmUgcGh5IGFuZCBtYWMgcmVzZXQNCj4gPiA+IGxpbmVzDQo+ID4gPiBhc3NlcnQv
ZGUtYXNzZXJ0IGNvbmZpZ3VyYXRpb24gaW4gLnBvd2VyX3VwIGNhbGxiYWNrDQo+ID4gPiAobXRr
X3BjaWVfZW43NTgxX3Bvd2VyX3VwL210a19wY2llX3Bvd2VyX3VwKS4NCj4gPiA+IA0KPiA+ID4g
U2lnbmVkLW9mZi1ieTogTG9yZW56byBCaWFuY29uaSA8bG9yZW56b0BrZXJuZWwub3JnPg0KPiA+
ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMu
YyB8IDI0DQo+ID4gPiArKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
PiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+ID4g
aW5kZXgNCj4gPiA+IDhjOGM3MzNhMTQ1NjM0Y2RiZmVmZDMzOWY0YTY5MmYyNWE2ZTI0ZGUuLmMw
MTI3ZDBmYjRmMDU5YjlmOWU4MTYzDQo+ID4gPiA2MDEzMGUxODNlOGYwZTk5MCAxMDA2NDQNCj4g
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
PiA+IEBAIC04NjcsNiArODY3LDEzIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfZW43NTgxX3Bvd2Vy
X3VwKHN0cnVjdA0KPiA+ID4gbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gPiA+ICAJaW50IGVycjsN
Cj4gPiA+ICAJdTMyIHZhbDsNCj4gPiA+ICANCj4gPiA+ICsJLyoNCj4gPiA+ICsJICogVGhlIGNv
bnRyb2xsZXIgbWF5IGhhdmUgYmVlbiBsZWZ0IG91dCBvZiByZXNldCBieSB0aGUNCj4gPiA+IGJv
b3Rsb2FkZXINCj4gPiA+ICsJICogc28gbWFrZSBzdXJlIHRoYXQgd2UgZ2V0IGEgY2xlYW4gc3Rh
cnQgYnkgYXNzZXJ0aW5nIHJlc2V0cw0KPiA+ID4gaGVyZS4NCj4gPiA+ICsJICovDQo+ID4gPiAr
CXJlc2V0X2NvbnRyb2xfYnVsa19hc3NlcnQocGNpZS0+c29jLT5waHlfcmVzZXRzLm51bV9yZXNl
dHMsDQo+ID4gPiArCQkJCSAgcGNpZS0+cGh5X3Jlc2V0cyk7DQo+ID4gPiArCXJlc2V0X2NvbnRy
b2xfYXNzZXJ0KHBjaWUtPm1hY19yZXNldCk7DQo+ID4gDQo+ID4gQWRkIGJsYW5rIGxpbmUgaGVy
ZS4NCj4gDQo+IGFjaywgSSB3aWxsIGZpeCBpdC4NCj4gDQo+ID4gDQo+ID4gPiAgCS8qDQo+ID4g
PiAgCSAqIFdhaXQgZm9yIHRoZSB0aW1lIG5lZWRlZCB0byBjb21wbGV0ZSB0aGUgYnVsayBhc3Nl
cnQgaW4NCj4gPiA+ICAJICogbXRrX3BjaWVfc2V0dXAgZm9yIEVONzU4MSBTb0MuDQo+ID4gPiBA
QCAtOTQxLDYgKzk0OCwxNSBAQCBzdGF0aWMgaW50IG10a19wY2llX3Bvd2VyX3VwKHN0cnVjdA0K
PiA+ID4gbXRrX2dlbjNfcGNpZSAqcGNpZSkNCj4gPiA+ICAJc3RydWN0IGRldmljZSAqZGV2ID0g
cGNpZS0+ZGV2Ow0KPiA+ID4gIAlpbnQgZXJyOw0KPiA+ID4gIA0KPiA+ID4gKwkvKg0KPiA+ID4g
KwkgKiBUaGUgY29udHJvbGxlciBtYXkgaGF2ZSBiZWVuIGxlZnQgb3V0IG9mIHJlc2V0IGJ5IHRo
ZQ0KPiA+ID4gYm9vdGxvYWRlcg0KPiA+ID4gKwkgKiBzbyBtYWtlIHN1cmUgdGhhdCB3ZSBnZXQg
YSBjbGVhbiBzdGFydCBieSBhc3NlcnRpbmcgcmVzZXRzDQo+ID4gPiBoZXJlLg0KPiA+ID4gKwkg
Ki8NCj4gPiA+ICsJcmVzZXRfY29udHJvbF9idWxrX2Fzc2VydChwY2llLT5zb2MtPnBoeV9yZXNl
dHMubnVtX3Jlc2V0cywNCj4gPiA+ICsJCQkJICBwY2llLT5waHlfcmVzZXRzKTsNCj4gPiA+ICsJ
cmVzZXRfY29udHJvbF9hc3NlcnQocGNpZS0+bWFjX3Jlc2V0KTsNCj4gPiA+ICsJdXNsZWVwX3Jh
bmdlKDEwLCAyMCk7DQo+ID4gDQo+ID4gVW5yZWxhdGVkIHRvIHRoaXMgcGF0Y2gsIGJ1dCBzaW5j
ZSB5b3UncmUgbW92aW5nIGl0LCBkbyB5b3Uga25vdw0KPiA+IHdoYXQNCj4gPiB0aGlzIGRlbGF5
IGlzIGZvcj8gIENhbiB3ZSBhZGQgYSAjZGVmaW5lIGFuZCBhIHNwZWMgY2l0YXRpb24gZm9yDQo+
ID4gaXQ/DQo+IA0KPiBJIGFtIG5vdCBzdXJlIGFib3V0IGl0LCB0aGlzIHdhcyBhbHJlYWR5IHRo
ZXJlLg0KPiBASmlhbmp1biBXYW5nOiBhbnkgaW5wdXQgb24gaXQ/DQoNClRoaXMgZGVsYXkgaXMg
dXNlZCB0byBlbnN1cmUgdGhlIHJlc2V0IGlzIGVmZmVjdGl2ZS4gQSBkZWxheSBvZiAxMHVzDQpz
aG91bGQgYmUgc3VmZmljaWVudCBpbiB0aGlzIHNjZW5hcmlvLg0KDQo+IA0KPiA+IA0KPiA+IElz
IHRoZXJlIGEgcmVxdWlyZW1lbnQgdGhhdCB0aGUgUEhZIGFuZCBNQUMgcmVzZXQgb3JkZXJpbmcg
YmUNCj4gPiBkaWZmZXJlbnQgZm9yIEVONzU4MSB2cyBvdGhlciBjaGlwcz8NCj4gPiANCj4gPiBF
Tjc1ODE6DQo+ID4gDQo+ID4gICBhc3NlcnQgUEhZIHJlc2V0DQo+ID4gICBhc3NlcnQgTUFDIHJl
c2V0DQo+ID4gICBwb3dlciBvbiBQSFkNCj4gPiAgIGRlYXNzZXJ0IFBIWSByZXNldA0KPiA+ICAg
ZGVhc3NlcnQgTUFDIHJlc2V0DQo+ID4gDQo+ID4gb3RoZXJzOg0KPiA+IA0KPiA+ICAgYXNzZXJ0
IFBIWSByZXNldA0KPiA+ICAgYXNzZXJ0IE1BQyByZXNldA0KPiA+ICAgZGVhc3NlcnQgUEhZIHJl
c2V0DQo+ID4gICBwb3dlciBvbiBQSFkNCj4gPiAgIGRlYXNzZXJ0IE1BQyByZXNldA0KPiA+IA0K
PiA+IElzIHRoZXJlIG9uZSBvcmRlciB0aGF0IHdvdWxkIHdvcmsgZm9yIGJvdGg/DQo+IA0KPiBF
Tjc1ODEgcmVxdWlyZXMgdG8gcnVuIHBoeV9pbml0KCkvcGh5X3Bvd2VyX29uKCkgYmVmb3JlIGRl
YXNzZXJ0IFBIWQ0KPiByZXNldA0KPiBsaW5lcy4NCj4gDQo+IFJlZ2FyZHMsDQo+IExvcmVuem8N
Cj4gDQo+ID4gDQo+ID4gPiAgCS8qIFBIWSBwb3dlciBvbiBhbmQgZW5hYmxlIHBpcGUgY2xvY2sg
Ki8NCj4gPiA+ICAJZXJyID0gcmVzZXRfY29udHJvbF9idWxrX2RlYXNzZXJ0KHBjaWUtPnNvYy0N
Cj4gPiA+ID5waHlfcmVzZXRzLm51bV9yZXNldHMsIHBjaWUtPnBoeV9yZXNldHMpOw0KPiA+ID4g
IAlpZiAoZXJyKSB7DQo+ID4gPiBAQCAtMTAxMywxNCArMTAyOSw2IEBAIHN0YXRpYyBpbnQgbXRr
X3BjaWVfc2V0dXAoc3RydWN0DQo+ID4gPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ID4gIAkg
KiBjb3VudGVyIHNpbmNlIHRoZSBidWxrIGlzIHNoYXJlZC4NCj4gPiA+ICAJICovDQo+ID4gPiAg
CXJlc2V0X2NvbnRyb2xfYnVsa19kZWFzc2VydChwY2llLT5zb2MtPnBoeV9yZXNldHMubnVtX3Jl
c2V0cywNCj4gPiA+IHBjaWUtPnBoeV9yZXNldHMpOw0KPiA+ID4gLQkvKg0KPiA+ID4gLQkgKiBU
aGUgY29udHJvbGxlciBtYXkgaGF2ZSBiZWVuIGxlZnQgb3V0IG9mIHJlc2V0IGJ5IHRoZQ0KPiA+
ID4gYm9vdGxvYWRlcg0KPiA+ID4gLQkgKiBzbyBtYWtlIHN1cmUgdGhhdCB3ZSBnZXQgYSBjbGVh
biBzdGFydCBieSBhc3NlcnRpbmcgcmVzZXRzDQo+ID4gPiBoZXJlLg0KPiA+ID4gLQkgKi8NCj4g
PiA+IC0JcmVzZXRfY29udHJvbF9idWxrX2Fzc2VydChwY2llLT5zb2MtPnBoeV9yZXNldHMubnVt
X3Jlc2V0cywNCj4gPiA+IHBjaWUtPnBoeV9yZXNldHMpOw0KPiA+ID4gLQ0KPiA+ID4gLQlyZXNl
dF9jb250cm9sX2Fzc2VydChwY2llLT5tYWNfcmVzZXQpOw0KPiA+ID4gLQl1c2xlZXBfcmFuZ2Uo
MTAsIDIwKTsNCj4gPiA+ICANCj4gPiA+ICAJLyogRG9uJ3QgdG91Y2ggdGhlIGhhcmR3YXJlIHJl
Z2lzdGVycyBiZWZvcmUgcG93ZXIgdXAgKi8NCj4gPiA+ICAJZXJyID0gcGNpZS0+c29jLT5wb3dl
cl91cChwY2llKTsNCj4gPiA+IA0KPiA+ID4gLS0gDQo+ID4gPiAyLjQ3LjANCj4gPiA+IA0K

