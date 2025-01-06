Return-Path: <linux-pci+bounces-19325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C33A021D1
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE3C5188547A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857261D90DD;
	Mon,  6 Jan 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D7jfTx+S";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ANEqEJcA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06412AD16;
	Mon,  6 Jan 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155689; cv=fail; b=arZpTbJi29a/wkI+XohwHdePoJSqPbnoaW9WWOK/4JwhnHM5TEQYJxGxguihevuVVGxDuEYJzIkufnrRH/oaSHs/bAIm1mc6lT7yiZcEf3ihnT/V3N1X7TBpaRDOAxONOUlVDHXN0XLsyZ0rmFeVMlDsD6fE9yRSpD85/eKRM24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155689; c=relaxed/simple;
	bh=IvO5dMOAC4L1SaOAC5SuBTOpflbmiKZsYV+tO/num5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dPX3vkUmvsAbxTDId1jQX06rDk4/Fo/B+xGPlG/qmGCPPV3yOTi5hfip1V3qRwM+G9emEEy3n/MGv5o9TErVE0/QvT35WWbpMqrWnD09UYBjYYgp3T7UBWTVyhMRtRxSIYmMCE5Y/cpM+RmnfYY9kEM8md5Kns+TkhTGK/bEsEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D7jfTx+S; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=ANEqEJcA; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 874a79dccc1011efbd192953cf12861f-20250106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=IvO5dMOAC4L1SaOAC5SuBTOpflbmiKZsYV+tO/num5E=;
	b=D7jfTx+S3B69eMVYGX7ZAdjpOroO4Fq6shHd6BympKXT4D90awiuG9UiJuBg53zNwzQFS6h4nvxKkhoXvc3O5zJKkNEK8WCNIswk7YEiZaXvGbt4Adug1mUiFlWQLSUpLahI2yLdTMggdnB76jBrBXyUk8NBb/tD9eJ7tncM0ls=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:92f6289b-b061-4004-b756-8bbb5192119f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:69b96e37-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 874a79dccc1011efbd192953cf12861f-20250106
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 718747062; Mon, 06 Jan 2025 17:28:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 6 Jan 2025 17:28:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 6 Jan 2025 17:28:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJA93heLbuijBM7pWv8+BmzHANBr4or9hJkCduG6yMA6xvObwFwuFsxnhNj3xBU4/Kxub0OIND01eVE/zNu/PJ+XYjjpLIzM5gxmMpxS19mzTgHrxpTkOGDxtzNYWhOQNBXvXumeXYmJJp2OMKbIF2DtTfSN6/1LqXw4yZhERRtS2PdOI184DttIk16mkPftqW4KQGesRx7mGTsfUJvwLHtHSq+RZ5vgGI8MVH6gbvhSr+yg3AEvbOIKgG/AVW4QyLSnZLYecNQhiajxZoB1WhUuHdF74OZwyYPNSp23axUNWdOls0jiOyN5wBZvRlpeyIbQTLdzpFusbyxs/itZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IvO5dMOAC4L1SaOAC5SuBTOpflbmiKZsYV+tO/num5E=;
 b=qi1rk1sb4zP07HlfgeEU2zxBaglZ0wtbGqlc++o3ABGfO8B59TJ8r7bRHvEeCaw89TX3/MAXR1Q87e7/o+xGM8zKeCni6JcxQkmF6TMs8hPLI9EAf7fjUcnRZHXV2qe4ACNGJcgtqSEyCQsLeV4gU7c0Y5eAT5PyJMrotejLyVs2gDLD+S2PqRhGhO4P0NP+rtNy33fqBZqFYkH0mFmHi1ahlPSXOta1igVpGpF3llS2JYF/KiEwGlPbCeVsg87nQ+4+GdVRmdr7GjrsWvBYMKNiS0EOFywjFuLBlO+qggs5tUKUiI2DhhYrH/i4+f+e0Xs8bDQogJM/XxeV6R36KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IvO5dMOAC4L1SaOAC5SuBTOpflbmiKZsYV+tO/num5E=;
 b=ANEqEJcAguEDnaBPY0jd4K3CynBLdQpLPMwf76+pzg4xoZqIJKJO7XQGGA82XwXMA84G9UIe/oZxt9TTHMJKsF8ySn6OJ42JGxZv17ucYmIkjDuMbzmD4uPliaGFQlqyyLNh9f5yduUSFSY03oJg/oJqpF3K5OveyWKYFJ5F4ds=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYZPR03MB6817.apcprd03.prod.outlook.com (2603:1096:400:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Mon, 6 Jan
 2025 09:27:59 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 09:27:59 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Ryder Lee <Ryder.Lee@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
Thread-Topic: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
Thread-Index: AQHbXaTudx8xtE3Nc0iENJOHrgCzn7MEyJkAgAS2sgA=
Date: Mon, 6 Jan 2025 09:27:59 +0000
Message-ID: <f0731a747515539e580372ce35dccf81d8f43b5c.camel@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
	 <20250103060035.30688-5-jianjun.wang@mediatek.com>
	 <9a874a5b-c698-4185-bb7f-f17245381af1@collabora.com>
In-Reply-To: <9a874a5b-c698-4185-bb7f-f17245381af1@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYZPR03MB6817:EE_
x-ms-office365-filtering-correlation-id: 0dcd5f8e-f24b-442f-b069-08dd2e346968
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|7055299003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WEw3UFR1a3VZN1czL0VYN3hSRldmSHg5RGE0ZUtmOW1ocnMwdXIrbzd3K2cw?=
 =?utf-8?B?U1ZWaCtHUmw0dWcyOEVrUEhWREtyNlJrNzY3ajJJZEc2OUQvSFI4UzZBa1lV?=
 =?utf-8?B?WWd4Z1VodTBHQ2JPQkJFRzBlUkdKSGJyeXBsUVRaR0x6cTBvMnQ5R2hTRHZT?=
 =?utf-8?B?d2VmY3p0bjUrL1BIcktmUzNibS9NVXppNDhUeGRmQnRQdmcyRzB6VUtRcnNM?=
 =?utf-8?B?Z2lDK1lxNUlFU21TcWQ0U3lNYlBTQ3hHbGJJekxIWFk3VFdTR25kNEJEbGtu?=
 =?utf-8?B?OHJtNEtYNVo0VG1QYXBsYjFvU09CMnVHcHpQODRVK05UVzh6RHRVZVlXNi9V?=
 =?utf-8?B?NHJmRlFUelFQcmlWRUhOVThDYmJLWEdQVVk4ckltSk54YTdZOTNJM1lzcUVs?=
 =?utf-8?B?MkdReFREUTN0bGZncUo4VXUralhCNG0zT2lxNVAwTXc4b1NXMjc2VTNKZFlD?=
 =?utf-8?B?RzhubG5EMmtIWnBEK1lnbXBvL3JUYWk2QTYzcGoyTG0vS1REOTR1bTJLeHRt?=
 =?utf-8?B?c3RGUUcvdzBrY2Izc2ZYVkpVeXFhS052TzVVZzRra0luV2tzZzNqM0lWQXZq?=
 =?utf-8?B?bWxPM3A5cXZTQW1OOUJkeGxyRE5uN2YyVEppY0ZLRUN1ZklvOERKcFZ3Rzgr?=
 =?utf-8?B?MDQ3QlVtMEVTYjRVWmJFTjg3a0dOSWJ4ZVhTbFNSUmR1Mjd2ZDk0b2VCY0tD?=
 =?utf-8?B?UG53M29RTXJjN2I3RSttZ05uTmxmVlBsMkxaU1NXcGNkSzhkU2RTalV1dTJP?=
 =?utf-8?B?VFZUc1NCQlU4bXJOVGUvbXVQTHJ6V0FWQjVTaDdvS25OcE5pNkkycUN1N1JL?=
 =?utf-8?B?WGU2QTNZdzBFQklhb2dSZmlGeFBRSHMzU2xwME1PN0hzajM3UDE3d0RZM3p0?=
 =?utf-8?B?N29TZE16c0EwZGwrNmNsaVdWMC9qSFUyVzR2bmJ1VFFLaXBHbDBRNVFhZ2ds?=
 =?utf-8?B?ZnZVVXhodEp2cHVyaHZ1dEdxNlExYy91N29QbHRoLzNWMHAybFZ4VHBkS0hy?=
 =?utf-8?B?Z0RXZHh1cHd0cVMxZ2xQZmxoalpORDh6RjBTYnh4eUxnaFlYVzErbENYbXE4?=
 =?utf-8?B?ZHU3WmlyMkI5UWNDaWRnOEVtU1JBVFBuWlRmYm1QTTFlSS9MSjhzRXNCM1Zz?=
 =?utf-8?B?a3pjRXUxemlyb3NVcUdWVkFROEVib21OZXNjTGVoYWMyMmg5YUJxUTFjT2Vz?=
 =?utf-8?B?TFZZZURxQjFOOFF1NDIwQWhjM3JOYkE3QklINUkrQm5ReEV1K3ZZeW82Qlgx?=
 =?utf-8?B?eWtQMUUyNjlpN0ZOVkp6V21JeFlKcldNWHB3NER4U3JGTEFDZGkyNWZldGh3?=
 =?utf-8?B?TkpEaWZLYStSMWQzS1ZVVC82ZFdaUmUzeGJ5OXBGbWVEWjkvUExFU3dlQ1ZZ?=
 =?utf-8?B?QU1LcWRxUEpkaDA2WVdRMWNxaGZzRC9DNVR5NWhuNENSTUxkZkM1L0dGYTBT?=
 =?utf-8?B?SlN1WGJ1ejcrTnZ6RWlGNXVETnpJUmdBdGt4c28rd09veEdOa3krNWZlMzFT?=
 =?utf-8?B?Z2dLU2FlUjNGNXJmK1pCRGo0WVhPbU9MeDlCUFk2TWxWQkNsZVZ0U3N5R05M?=
 =?utf-8?B?Vm9rMFlhRkdpRE04YURIY0VtdFFncDh4TXQrR21zV1FRMlhKb0V4NVppa2Fi?=
 =?utf-8?B?N0hnNllEaFhKVkFmREI1MzNCalZsNGxmQk9JRXNDekVlamdwZTU3MGxwQ1ZD?=
 =?utf-8?B?aWZlNkpRUUkzWXRONkhlaGF2RlB2YlVxSzMyTFU0RVFpeEZTQk1ES3AvZEtt?=
 =?utf-8?B?VExqL1c4VVZ1SFJtUVdoYXpWRnZlQ0wvMTZDbnovUHVkcGp5b1JEWWpjM1hu?=
 =?utf-8?B?MmNZOVpCQm5xNk5sWXQ2eFA0dnlaa2J1MUQrYXppczJKTDJ4Z2Q2SHBXYXht?=
 =?utf-8?B?ays3ZCtSVm9WcFZQUmt3eTd4MGNTeFJQdmZqY0t1TWRrTGsxcXBpY09OVzJa?=
 =?utf-8?B?NllDd284bzBibXpKeWN3R0JUdmpncndjYVRIV08rdUJ1R241eDRSVXMrejlj?=
 =?utf-8?B?NnF0ZjhGMGNnPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(7055299003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZS9hWW5ieXA4TWloLzFiWGI0S1lIK2t4NG5aMDQ4TStaN0tWSnFBbXpYYVNj?=
 =?utf-8?B?Y1hORSsrcVpTMkxKOE9hekZqd1puUUNUN2JtWmdwVlNDdEp3TUdGWTZjcGxU?=
 =?utf-8?B?M1RxaVZ1WUQ2SlA2ZzJ3a1loMjJHQWE1SkxsTjJhb0RGTXZ5bk45UGdLOW9n?=
 =?utf-8?B?WjFiTFp1cVZBcG1DWG1JUTgwcVJkNWpkZHk2ZEZBNEhDNGVNOGYxb0lROWlr?=
 =?utf-8?B?SUtNbDVvalZnOWFneDZFamVSR2ZlK3lzSFFCNnR3ckZVK3lhWDgxRkttVTNM?=
 =?utf-8?B?NzNwTFZkWHdDOW1sbS9KclhPSHJ2NjJSYWtTWElIaElQOExnVFJoaFdFZ29m?=
 =?utf-8?B?dk1aaUU3TC9DVmppZEdsclJkUnpnNUNQTm1WNU9Gc29WR1F6cFZYODRjSnpl?=
 =?utf-8?B?QlFzeTYvMlR0SmNvTUNHUDFXaFVodTluQWgxVE4vMzBGQmJZVVMxMWxWZjA3?=
 =?utf-8?B?VGdzVFF3eVdtOUFwbmFBMG5VWDNjMXIya1I1OENCbVljdlN3OHJSK0ZGWkk2?=
 =?utf-8?B?d0NOazdlVmJKdDZQWGF4Ny9FRktkSEg1ZTRlbHdpaFdvbzB5ZWxxbzZZOFFJ?=
 =?utf-8?B?dTlsZVJ0dVBzaHAxdHNaWlg1VjUrRHV3WFg5dFpwYmhFYllqS0tJbGY0QVJr?=
 =?utf-8?B?cjhJQkZacmljT2doN0dqSVJxVThIbVhENFFpajgraWRlZFpudktJbDh2R28z?=
 =?utf-8?B?eFF3akxLWHpYbGxRNi9LR3M1UUhFV1lHanY5dE11cFRUeUltUUVRcTJ4Vlgv?=
 =?utf-8?B?cDFScmYwbmE0WjFOOXQ1enVtOXlUSkM0NDRoYzR6bXFOYmIzeHRWTktMeXN5?=
 =?utf-8?B?ZlhIT1E1b045QXBNekw2eXpZVTVHNHpIejZJdERlcElQZWMyY1N3M09JY3FH?=
 =?utf-8?B?VU9nSVZBNXhHMlFaQTVLMXNtYUxGelJKS3pTQlZSTlZIeGJjcU5jZFlwc04v?=
 =?utf-8?B?eGN0d3NONk9uN0l6SWJIUC9YMVFPMEdaVGFVZEVkb1VkdjZ2SFFhNWJxSVJh?=
 =?utf-8?B?Tm9ucldScjVQVnBlellhTEIxMkxOMVZIQ3FlTVFQS0FsVWdEVnl6Z3p1Y0dm?=
 =?utf-8?B?ODdId3dvSUNKL0ZWV21jandTQkIyc21SM3BKM1FhYk5ZSGRSRFBnakdhK3Fy?=
 =?utf-8?B?NXVlU0xSdE80ZUNMU0xobFBPT1kzRm5ULzR2UkVQdXJNSCtMaWFiYVJNbHZ6?=
 =?utf-8?B?OE5BcGtqMDlEOHhJcW9kMjkyRU1IU3J1ZlhjOU9yamtaclQzbExhZjV3Mkh0?=
 =?utf-8?B?NzZ5YnNCV2gvcnpZTmFrd0NkM1lkVlNjbllNbW9kTzAwRFAzdHY5UXVvb1U4?=
 =?utf-8?B?Qm5sZ1M5QkVEa3JTL3VqVEdiMCtyVE5pVGF0UXFUNk5QaDVJckNLQkZKeCt5?=
 =?utf-8?B?Y3FyN21OMXYwVkJvQjZKTW9USnFwbEV1MVZnR013NDU0eXVCanZld2xSelQz?=
 =?utf-8?B?UTdmZ2hYaFJiK3p4SjdMNHFUcmtJRUwzZTk1QVNCeGV1YkRUREw0NGNUbDE1?=
 =?utf-8?B?TFFyY2Uvd3o5aitvb3pMWXJvYVJYNlFheGw4SU83UXROVkY1L2c0UnRPSkRw?=
 =?utf-8?B?bWwvcXVTN2pTZlB3aGtaR0doM0VCQUNSWC9GVnVmODdaRmkzYnZPR1FKY3B2?=
 =?utf-8?B?eGVlUXN3Zk13TzJ2ZEptaUxVUFEvRDJ2TE5CM2tGZWFsYjJlN0lTN20xbDZE?=
 =?utf-8?B?c3VKY1h2OTVUUXRFTEwvdFdrWmNTa0pXWVBtdk9kNnl3Vy84eGNSRmtKNExX?=
 =?utf-8?B?c3VSMS9yVitLNFlDMnpDd1VaRnFYbzZXWDVQTEpWUjhOL2M2aE5VY3Q4M0Rz?=
 =?utf-8?B?YTQ0NldKQmwvbnliMmtOb0FLYlBSZDVyTjExL1hSeWJKV1dkR2JUNXBLUS9G?=
 =?utf-8?B?YzVhNGRSMTZaNTFaOXRuS3ByY043VUpSejkwQzdOUTJoWVZMcUJ2NHVKRENP?=
 =?utf-8?B?MWh0ZTFodlo3c0M5SmJXU1F2SUx6Y3RiR1NNcFhZUFEzWVZLVnNNTEN4eUpt?=
 =?utf-8?B?RUdyaXZXcEVrWk9VQWV0NjFTdWVycDRaYjkzc3krblpybG9nMEpLWlFzMXA5?=
 =?utf-8?B?SjRKc2Vtc08vbVZwdTd4NE1EQW5KWUs3bkJYYjBCV3R4Q2xSSXA5NXNZMFcv?=
 =?utf-8?B?eDJOek1BQ0JEVnRJNk1tbGw1NkIvekk4cjlseHBwcVRPVE5SUDVFd3dKLzNN?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E4E67FA9A7B2F439DF4899FF45ED533@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dcd5f8e-f24b-442f-b069-08dd2e346968
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2025 09:27:59.7636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPb+MnpOw+Gpn7P+G+AFrPsdIABrHoxnMa6Auej9AH5Ym0eIRgjiG5lJK7xL6KpZHDV46kCI8OdYAlcB6pACjn9pU1Era1OIaQ4tz98NI8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6817

T24gRnJpLCAyMDI1LTAxLTAzIGF0IDEwOjI5ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMy8wMS8yNSAwNzowMCwgSmlhbmp1biBX
YW5nIGhhIHNjcml0dG86DQo+ID4gVGhlcmUgYXJlIHNvbWUgY2lyY3Vtc3RhbmNlcyB3aGVyZSB0
aGUgRVAgZGV2aWNlIHdpbGwgbm90IHJlc3BvbmQNCj4gPiB0bw0KPiA+IG5vbi1wb3N0ZWQgYWNj
ZXNzIGZyb20gdGhlIHJvb3QgcG9ydCAoZS5nLiwgTU1JTyByZWFkKS4gSW4gc3VjaA0KPiA+IGNh
c2VzLA0KPiA+IHRoZSByb290IHBvcnQgd2lsbCByZXBseSB3aXRoIGFuIEFYSSBzbGF2ZSBlcnJv
ciwgd2hpY2ggd2lsbCBiZQ0KPiA+IHRyZWF0ZWQNCj4gPiBhcyBhIFN5c3RlbSBFcnJvciAoU0Vy
cm9yKSwgY2F1c2luZyBhIGtlcm5lbCBwYW5pYyBhbmQgcHJldmVudGluZw0KPiA+IHVzDQo+ID4g
ZnJvbSBvYnRhaW5pbmcgYW55IHVzZWZ1bCBpbmZvcm1hdGlvbiBmb3IgZnVydGhlciBkZWJ1Z2dp
bmcuDQo+ID4gDQo+ID4gV2UgaGF2ZSBhZGRlZCBhIG5ldyBiaXQgaW4gdGhlIFBDSUVfQVhJX0lG
X0NUUkxfUkVHIHJlZ2lzdGVyIHRvDQo+ID4gcHJldmVudA0KPiA+IFBDSWUgQVhJMCBmcm9tIHJl
cGx5aW5nIHdpdGggYSBzbGF2ZSBlcnJvci4gU2V0dGluZyB0aGlzIGJpdCBvbiBhbg0KPiA+IG9s
ZGVyDQo+ID4gcGxhdGZvcm0gdGhhdCBkb2VzIG5vdCBzdXBwb3J0IHRoaXMgZmVhdHVyZSB3aWxs
IGhhdmUgbm8gZWZmZWN0Lg0KPiA+IA0KPiA+IEJ5IHByZXZlbnRpbmcgQVhJMCBmcm9tIHJlcGx5
aW5nIHdpdGggYSBzbGF2ZSBlcnJvciwgd2UgY2FuIGtlZXANCj4gPiB0aGUNCj4gPiBrZXJuZWwg
YWxpdmUgYW5kIGRlYnVnIHVzaW5nIHRoZSBpbmZvcm1hdGlvbiBmcm9tIEFFUi4NCj4gPiANCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2Vu
My5jIHwgMTIgKysrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
bWVkaWF0ZWstZ2VuMy5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0
ZWstZ2VuMy5jDQo+ID4gaW5kZXggNGJkM2IzOWVlYmUyLi40OGY4M2MyZDkxZjcgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBA
QCAtODcsNiArODcsOSBAQA0KPiA+ICAgI2RlZmluZSBQQ0lFX0xPV19QT1dFUl9DVFJMX1JFRyAg
ICAgICAgICAgICAweDE5NA0KPiA+ICAgI2RlZmluZSBQQ0lFX0ZPUkNFX0RJU19MMFMgICAgICAg
ICAgQklUKDgpDQo+ID4gDQo+ID4gKyNkZWZpbmUgUENJRV9BWElfSUZfQ1RSTF9SRUcgICAgICAg
ICAweDFhOA0KPiA+ICsjZGVmaW5lIFBDSUVfQVhJMF9TTFZfUkVTUF9NQVNLICAgICAgICAgICAg
ICBCSVQoMTIpDQo+ID4gKw0KPiA+ICAgI2RlZmluZSBQQ0lFX1BJUEU0X1BJRThfUkVHICAgICAg
ICAgMHgzMzgNCj4gPiAgICNkZWZpbmUgUENJRV9LX0ZJTkVUVU5FX01BWCAgICAgICAgIEdFTk1B
U0soNSwgMCkNCj4gPiAgICNkZWZpbmUgUENJRV9LX0ZJTkVUVU5FX0VSUiAgICAgICAgIEdFTk1B
U0soNywgNikNCj4gPiBAQCAtNDY5LDYgKzQ3MiwxNSBAQCBzdGF0aWMgaW50IG10a19wY2llX3N0
YXJ0dXBfcG9ydChzdHJ1Y3QNCj4gPiBtdGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ICAgICAgIHZh
bCB8PSBQQ0lFX0ZPUkNFX0RJU19MMFM7DQo+ID4gICAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBw
Y2llLT5iYXNlICsgUENJRV9MT1dfUE9XRVJfQ1RSTF9SRUcpOw0KPiA+IA0KPiA+ICsgICAgIC8q
DQo+ID4gKyAgICAgICogUHJldmVudCBQQ0llIEFYSTAgZnJvbSByZXBseWluZyBhIHNsYXZlIGVy
cm9yLCBhcyBpdCB3aWxsDQo+ID4gY2F1c2Uga2VybmVsIHBhbmljDQo+ID4gKyAgICAgICogYW5k
IHByZXZlbnQgdXMgZnJvbSBnZXR0aW5nIHVzZWZ1bCBpbmZvcm1hdGlvbi4NCj4gPiArICAgICAg
KiBLZWVwIHRoZSBrZXJuZWwgYWxpdmUgYW5kIGRlYnVnIHVzaW5nIHRoZSBpbmZvcm1hdGlvbiBm
cm9tDQo+ID4gQUVSLg0KPiA+ICsgICAgICAqLw0KPiANCj4gSXNuJ3QgaXQgc2FmZXIgaWYgd2Ug
c2V0IHRoaXMgYml0IGF0IHRoZSBiZWdpbm5pbmcgb2YNCj4gbXRrX3BjaWVfc3RhcnR1cF9wb3J0
KCkNCj4gaW5zdGVhZD8NCg0KQWdyZWUsIEknbGwgbW92ZSBpdCB0byB0aGUgYmVnaW5uaW5nIG9m
IG10a19wY2llX3N0YXJ0dXBfcG9ydCgpLg0KDQpUaGFua3MuDQoNCj4gDQo+IENoZWVycywNCj4g
QW5nZWxvDQo+IA0KPiA+ICsgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFzZSArIFBD
SUVfQVhJX0lGX0NUUkxfUkVHKTsNCj4gPiArICAgICB2YWwgfD0gUENJRV9BWEkwX1NMVl9SRVNQ
X01BU0s7DQo+ID4gKyAgICAgd3JpdGVsX3JlbGF4ZWQodmFsLCBwY2llLT5iYXNlICsgUENJRV9B
WElfSUZfQ1RSTF9SRUcpOw0KPiA+ICsNCj4gPiAgICAgICAvKiBEaXNhYmxlIERWRlNSQyB2b2x0
YWdlIHJlcXVlc3QgKi8NCj4gPiAgICAgICB2YWwgPSByZWFkbF9yZWxheGVkKHBjaWUtPmJhc2Ug
KyBQQ0lFX01JU0NfQ1RSTF9SRUcpOw0KPiA+ICAgICAgIHZhbCB8PSBQQ0lFX0RJU0FCTEVfRFZG
U1JDX1ZMVF9SRVE7DQo+IA0KPiANCj4gDQo=

