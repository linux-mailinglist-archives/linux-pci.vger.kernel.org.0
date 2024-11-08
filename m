Return-Path: <linux-pci+bounces-16299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 359109C1392
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 02:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDB71F23463
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 01:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97271BD9FB;
	Fri,  8 Nov 2024 01:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b="N6nr2ypw";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="EsGbvwYE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC37BE46;
	Fri,  8 Nov 2024 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029032; cv=fail; b=hh33yKd1K4T8KkBV7ErPXJq9hjA86OvfrUvCS1jj0iSRZOkgnRoh5YUaIAZZ9F697ivihqsgAOxLB7xNopcz4Lo/fWrs0LUqiOXwCHf/mIvQvIu/SGqj77jJercwg0C3YniqDX7DCnxkyXtiiy3ynwrS/6bry4plaXMk7fg8Oag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029032; c=relaxed/simple;
	bh=BtA1vnkthhnHDV7bOg/Xk5eZpU4IPXuBO+hxuwcQuRs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QdQV6wO8vxpoivy87pUXOvl5LLkjY7i5fHwOz2rJ8zg1DyynNPKqBLMQJfFeWLPx7KOhcjNIdLpdTumEBLia9abV2qMfjcepN4xyjyZKprOL57jaGwmHj9fVwLdgcRRwAcPg7MR7QmpYwnjNGQ/V3bjkL1VdLxCpe6llEQcajeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com; spf=pass smtp.mailfrom=airoha.com; dkim=pass (1024-bit key) header.d=airoha.com header.i=@airoha.com header.b=N6nr2ypw; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=EsGbvwYE; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=airoha.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airoha.com
X-UUID: 17b36b5c9d7011efbd192953cf12861f-20241108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=airoha.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BtA1vnkthhnHDV7bOg/Xk5eZpU4IPXuBO+hxuwcQuRs=;
	b=N6nr2ypw/Hgw2rZU7Gig5nK+37XhMf/POTEDB2rClXjhmd4kh82d+CZAz6JHwV1Fc1X3/Q+v1vuGn2BWR357p0gv4NpTNlh5lkcpWgsMqzJd+8t/VvQ7kQXZ6iUZ0XCTdxoBfLp507bD8uk8isxPlGijeN5PpW798QLzF4TBXbQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:01ae2e57-9d53-4260-a27f-0ac929c42375,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:c246bc06-6ce0-4172-9755-bd2287e50583,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:817|102,TC:nil,Content:-5,EDM:-3,IP:
	nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 17b36b5c9d7011efbd192953cf12861f-20241108
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <hui.ma@airoha.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1500316095; Fri, 08 Nov 2024 09:23:43 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 8 Nov 2024 09:23:41 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 8 Nov 2024 09:23:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O56n7Bj4JQN/521P5q0S4x+Obi4W086YZ8bGOM0uEOWJn4CkbJoUB/PvjjsNKNtuE2UVzTnarTkBC1kMMW2rX2dCPxss6oinzxHI2NW/6IVYtxaolaWLF/2h7kSxwAYjyYfCPcUnw+i/FmNpMFRgQISIwSNytVXeA+sOLuXA+CCjcQ4m6UEjwvEbpZOUGC4vNUXncu0g6rFpUKHwCIbRmxriScyxLdRltovVBbqD1tpNPMoy2P5pDQeQd42ObvPkV5Y4nAwWu72Z639gKhEWnSsJirmzFAizHqwxZaHdTowBJpL9A4OmvqsnLOZ/QBQAFPdLDvhCHIM7S7WT27LdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtA1vnkthhnHDV7bOg/Xk5eZpU4IPXuBO+hxuwcQuRs=;
 b=EIS2lxC7UUkrit9Utn5mYTP8F5YIyJkBPmRbbC3rWLvSyt7MS3vDa8xE7cN9qZU0I9gcIHOOFpB/jiFYRgtZaIif868dtFiTMO+8oam2hJlcAmJ0yfGpmgze9C5lvBkIj4qM1tBxmI+w8QwC7XQQzQKss2QcQGuO0Een2dDv8EHD1pMOxMbI7gb8bu5Hqe0BRM0hgRDZI23bUZw0ff2IcmjI3CM6t2lTKNKa5TqB/MzJVuxu6bjHxsI2HYchLiQzA3sUguf5cQJH2GcgKu9NDkuhHuvPcxEq62MWGeYNWMp7H8BgGsixfZ3YUgYPValZA6M7tf/TaCPAX/ogMtysMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=airoha.com; dmarc=pass action=none header.from=airoha.com;
 dkim=pass header.d=airoha.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtA1vnkthhnHDV7bOg/Xk5eZpU4IPXuBO+hxuwcQuRs=;
 b=EsGbvwYEvj6krvqQ/LwFvBKq+YKsegyZUfpmeE+7QhM8tQ2mGKkpwCIcMuPyz8OjntOu0GmqdzuClFU0ghdwUcTvScojtgVwLmqfMElvCpF56yzJUIC/VMUdZkHA9QJstteIYXp4EWEnl+hhb8lhMpFQtsFEzZtpL4YpHalW1pM=
Received: from KL1PR03MB6350.apcprd03.prod.outlook.com (2603:1096:820:ad::12)
 by SEZPR03MB8039.apcprd03.prod.outlook.com (2603:1096:101:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Fri, 8 Nov
 2024 01:23:35 +0000
Received: from KL1PR03MB6350.apcprd03.prod.outlook.com
 ([fe80::9372:2ede:5a26:513c]) by KL1PR03MB6350.apcprd03.prod.outlook.com
 ([fe80::9372:2ede:5a26:513c%3]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 01:23:35 +0000
From: =?gb2312?B?SHVpIE1hICjC7bvbKQ==?= <Hui.Ma@airoha.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, =?gb2312?B?Smlhbmp1biBXYW5nICjN9b2ovvwp?=
	<Jianjun.Wang@mediatek.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"lorenzo.bianconi83@gmail.com" <lorenzo.bianconi83@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "nbd@nbd.name" <nbd@nbd.name>, "dd@embedd.com"
	<dd@embedd.com>, upstream <upstream@airoha.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHY0IDQvNF0gUENJOiBtZWRpYXRlay1nZW4zOiBBZGQg?=
 =?gb2312?Q?Airoha_EN7581_support?=
Thread-Topic: [PATCH v4 4/4] PCI: mediatek-gen3: Add Airoha EN7581 support
Thread-Index: AQHbMV/yjTpzpkxs30uMvvSIs5ZH3rKslW/A
Date: Fri, 8 Nov 2024 01:23:35 +0000
Message-ID: <KL1PR03MB6350EF22DE289B293D34FD6FFF5D2@KL1PR03MB6350.apcprd03.prod.outlook.com>
References: <ZyzpGSyAVe6bz9H2@lore-desk> <20241107164624.GA1618716@bhelgaas>
 <Zy03gz7czVIMQUcD@lore-desk>
In-Reply-To: <Zy03gz7czVIMQUcD@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=airoha.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6350:EE_|SEZPR03MB8039:EE_
x-ms-office365-filtering-correlation-id: 33c77b62-589a-45c6-d58b-08dcff93f766
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?gb2312?B?bnBVanNxUzNzWElDYjJySVdLVnA0a3FvREgyUTlMSDMrZ2xZNS9OcEVpdnd5?=
 =?gb2312?B?QXpOMlhjVkdMcWdHSStndEgrRk56dUFUOWwxQUU3amVwTVZINmZBWUR2dXcx?=
 =?gb2312?B?NURENFZ1R1l3Tm9jSlcrUmtyejV4dVlkbGhqR1FYaitEODd5dTVWOUw2SE55?=
 =?gb2312?B?OENMWDNBUUJJQkpDVEJkdm4rcEZDVFh3a2JOSE0vbjF0SG1QMkFCaHA0V2lN?=
 =?gb2312?B?WVptVW8wVFU3TWlGNXQ4M1IzeDhkclZtWm5mbk5PNklkU2tPZ0FhVXhROFRF?=
 =?gb2312?B?b2JXNDRhRzlRZGVodW5uUlY0RmJxbVN4aGJlR1gxMnZLTTlGdHVQQmhnLzVy?=
 =?gb2312?B?UGVXcXIzbUo2NGhCRUcrb2FseXBDRExKMklXRGxUM3ZJTkdWQm5qTnM5T2hH?=
 =?gb2312?B?YnVGMmd1bVNVT1lqZ0tEcVJPY3p1RnA4SGc5b016T2NGVm1CNUVENHVYMjBL?=
 =?gb2312?B?WGVvd3FhcEVCb2N0bjVWNW5iMFVKdXFOUTlpbkdldk1KSzdNRXFyTXdtSDhi?=
 =?gb2312?B?Zk9GN0pKdzM0TThJa3lTY2dVdUoxNDljeUVVRTRXaFEycmxlZDQxSVVyeTls?=
 =?gb2312?B?Tlp3ZThVNk5jeVFyaUIxZjFhWDJQV3NzL0xuSTBDUU8rVHRyeHdqb2xUTGtC?=
 =?gb2312?B?LzRXbXhOTUNlWjgwaU91eVd1eHJQUlhxYnhDRTBBTVF5NVp3OWNCYUhBc3hr?=
 =?gb2312?B?R0ZINDZqQm5HVklqQ3dpK3FXcVVQUkZTcTFNam5rUXpBQVhmWitVZzd1WWlh?=
 =?gb2312?B?cEpUMnNUUUpENVBrb2x3NTNWUTdJV3J6SW45Z3BHcDFNOGkvMHl6WEtZK3Vp?=
 =?gb2312?B?VC8ycDQyZjhTLzZOMExSMDFqR2d3U0ZKRWErUW5sMUJKeGpod0VXU01oTWFl?=
 =?gb2312?B?eWxCdC9iRm9icUtNYXVmSm8xU2gyUHF0WnBSaVZvRFpwSW5ZK2FFQ1JoZ1Fz?=
 =?gb2312?B?VG83ekp0alFkSS9nOHFsNG5ZdUZGSTRXK2M2OXAxSWlvalRCMUZxdTNsVEFv?=
 =?gb2312?B?YVlhVkRaOFZpL0MxbStqczAwelJ3cE16TnJhTGYwNlN5Vkt4MUphUnYwZFdU?=
 =?gb2312?B?RG81UHlXWmxqSEtsblJEN3crSGdOdCtaNWVFcXprbmoyOU1OQWdUbjhja2FT?=
 =?gb2312?B?T2Q4UlNJUkRaR2hhcEh2bGR3bVV0UFY2M2pVaUJUUWJEalk5YUhFeGRVZTFM?=
 =?gb2312?B?VUQ3ZXdzbVNmMWlwUm9oSXZSLzgxQSs5RXNlSnhQMVk2RzJvUEF5cm9WcVdR?=
 =?gb2312?B?c1VLdlAwMEVrNjVQM3VhNm94Z29vTWxMM0xaMVVjaWw1K3FEZDdpZXBmSWs3?=
 =?gb2312?B?cWRodlArazExV3RxTnRmeGFqRWhzOGZZTU9DZlhDMWpZM203OUx3RFluSWhn?=
 =?gb2312?B?RndtZE9kb1Ruam9mVXFQSzJieHRMcGdSb1phbEJzMEtEbklMaDZwYzM0aVl3?=
 =?gb2312?B?WktRaDBOU2RjTUZuczBnYlZOb3RlN0pFeGkzWFJyd0RtOVpyWERiYVVES3Y2?=
 =?gb2312?B?UGxZaXpIeDZnRkxyeXVVNncxYnpjL2F3YXNlZlhKaEtlcUU5aHJyU0dlSUdN?=
 =?gb2312?B?YVd3VC93MEd2UmRRSFdVQUVxVzZncUQ1WkdCWkZhNE5UQmJsck16NE1vRTE4?=
 =?gb2312?B?UHVSNDZDOHFHbWFraEsxcy9IdlRYTkxUUkFUV2EyUkdGRG5FTUN5NGRSdUNT?=
 =?gb2312?B?ZnF5UUx0QjBjQkVZSDA5Uk5MMzhQM2tNeDZoR3IwTkhUWkhIQXBoMWxNY082?=
 =?gb2312?Q?33Nb1CcABat09Ow9JPmFncgO5w/S6MXxGk3Wwri?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6350.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?aUF4V012bGhxRUVPR2pSZUNuOFR4ZUwzMUN0MVZyRk4rckMzckt0VlVsTFJt?=
 =?gb2312?B?OU1ucGlIQWpveE9FM3ovRHNaandBdXV2WnMrSmQzVFhCOXFpWnZUb2JPaURr?=
 =?gb2312?B?LzRnMmFUd3NLK2gzMkJ6VU50TUxWTWlLNCtsbE1yT1FOY3ZTelE5OUwwQU4w?=
 =?gb2312?B?cVpqVWt4WEVqbXZvVEpMVXU0anpjUzZ1bGtxMnpBdnc0bE1SZGRCUWFVZ2g3?=
 =?gb2312?B?K28rbnhZNGxJaTBZU3JWRDhaU1ZpN25GcXZmQlFnd1BCenY1MHZMbE9UbG04?=
 =?gb2312?B?OEV4eEpZMk5KSHBQbzIwRzBjQ25xYVVUUVhUYWNTenEvTGwxWW5XOVdMcXI1?=
 =?gb2312?B?NFhRS3pCYXdlamx0cGtUZFhqeUYzOXRmM1pOSlhYcTM5M2ZxdFBWeDcrNHN4?=
 =?gb2312?B?QXBRN3pqekR4L1U0Nnl3Vm9sN0pBYk1LdkpHSjQ2cFJMMVVXbzc3SUcwczk2?=
 =?gb2312?B?dUhHOFNEeUR0VFpHWksxRThMVENqUW1IZHAzU3h2SjZuYzVVYmZUQkF3dlJj?=
 =?gb2312?B?SWIzWGFIZnBtbVRLb3dNQkY2QkVDMGFlNDFCSmJIRGsyVEpqZ3FCVG43ZHJx?=
 =?gb2312?B?QzRjWHZjVTg1bXhtRWRoQXQ4d2FWa0F2WkIwYlFSdVBMbUxQU2doTTlOejJv?=
 =?gb2312?B?VmJXeXkwRWhvR1E1VHNNTTNCeUJiaktmcFdJUHJKT21QejhzZmwwZGkycy8y?=
 =?gb2312?B?RnN2VmQ0NnI3TzNsNUJqZEhkdWFUR2d0cFVLYlIzZklXSXVCcDZwQUVqcXNN?=
 =?gb2312?B?VG9iV09CajlIVGtjV3oyamZrWWc4SjgvZmVJRFI4bGxEZ29NcXpmNGVLL1g1?=
 =?gb2312?B?VzMybGgxWm9oY0hEbms5d3NqV21sQ2M4RFErTjh3SXFkRHRIQUh5YUlUd0tD?=
 =?gb2312?B?MmlIOE9ZZjExQmN1MDRsbWc5anRkalZUV2JIbkxkc1pPVlo3WE9lTWFQNHVk?=
 =?gb2312?B?MjNObmRvVG42Yks0TXJNMFVxWTVQZ0NQRFN0TytzcFN1c0x5R2N2OEhES2Z4?=
 =?gb2312?B?WVdvR1NzUmlpSGp4aFJoTE5BZ2ZzRUROeUU5dmhOdk5PR2t6VTdjaUhvWHNz?=
 =?gb2312?B?bzJWNnAxOVA4WFN4VXExWElURG1KbEtKU1VySGEzRUhCeCt4RTh3d0NrQjdk?=
 =?gb2312?B?V1oxMlBBeDFoTDBBU05jYXdWYW9NVkdvNGc4YUUxL0cvb0JEVU1oVHF0SFdR?=
 =?gb2312?B?ZXF6VjV0a3RPb3JrUDRqNlQzWTl0MUJGWWhFZ3Z3aEY3V3pnS1dsR2NpQnB4?=
 =?gb2312?B?N1YvS3NCcC83NXJnNFlRNVFtNXl1Mi8zMlp5VzI2ZHNjTGVKeUhCenk5N2VC?=
 =?gb2312?B?alVkcE13RW9QbHl2bjgvUXpBV1E2S0ZrWkcrcmVkcXlNRUlHMzhaYXhWM0hp?=
 =?gb2312?B?MUMxQ2FISGZDdk1iRXFMcmF3WUltdG9mSUpJenFvNHNuN05yWEN5S1JhVHVV?=
 =?gb2312?B?cG9hK2x1N2x0WjBoZnZPZml2VDBCejVpVm9PTXY0bHQ1VlpFNUJLaUpUQS9T?=
 =?gb2312?B?WHBTbStkSzhPNXduVjdYV2srV1AxUkE2eHhKRjBlL3FsZFdpWUJHRllWbEVZ?=
 =?gb2312?B?L2s1MTBHNVJ3d1BWcHllTlBIenpZc2ZTUkxHb3dqaGdCN21vQnZ0RUZCSVI5?=
 =?gb2312?B?ellCUHZtLzNINERWVnBPTjlDUnppenhCalRFdWZNRU1CSEFqV0xWSHQ2NC93?=
 =?gb2312?B?bEVndWt3VDZpZWg3akZ0SEFsRG9PcDhLRlJGR2daNzJhWVNpbVRsQThsL3Mv?=
 =?gb2312?B?UGRobnFKOHZXK2lLME9PdWNnemFXRTRaVWQ1UTBKRCsvNklvMXdhdXQvN2FP?=
 =?gb2312?B?RW1kKzJiTHIzemRxY09YcDRVQnRvUzBmYkQ4U0twZ3J0WVcwc3NnZlpRMURN?=
 =?gb2312?B?M2NuUDNBdktYSHFnbzNUczh2b1REQmRPZ0dISm5EeEVwanlBU1FGQmU3YVo3?=
 =?gb2312?B?VTdaNXgwWE95VTNFTWtTSGgxTVJVTVdoa1RuU1pVYmkyNHFzdFk2WXVzN0hz?=
 =?gb2312?B?TE5SRitmYzlPenE2L0hNTlVOR2NTVUo1RUVPbWxZWW9SVWtnMUF5QkV3LzQ5?=
 =?gb2312?B?cCtkOUpyUlJ1cEJvYUJiVnRtTHFZMWNvSDRzSjVBYmVyR3cyQy85cTc4VTV4?=
 =?gb2312?Q?ygMk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6350.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c77b62-589a-45c6-d58b-08dcff93f766
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 01:23:35.5196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wwio4k0J163em1BO2DueWk67IverV49B5CDICbwe7r3KO4+Bdwa2BkmlP5ErvYZ6qZi21LOhqup6k6V1UH+o2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8039
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.896100-8.000000
X-TMASE-MatchedRID: WTos3XtpXXFbRbA/K/rHzBj42LMyJUg8jLOy13Cgb4+e9toQ6h6LE9ll
	We93NG91v+io1+NFyY2/jRl0xND5zSbkA69Y/24EXP5rFAucBUGZ2scyRQcerwYuY4V2klnUsmc
	+HzD5HmiwUKc5qBhL57BqC2HNT6cMVrPbvdfF7GYTRDzcDa8P60olfE5GSrD5eE5rgL9o43mhPT
	x3lW8C2U25zqcELZKSvTyMtG3v9FSgf+GUh8ndpUhwlOfYeSqxNACnndLvXwfxSV7YBeBhS8IHN
	Fhh3K8wZba7TbjqApGQ/KUhF7zmqXy3NtgjFBPrq1ZJZ2z+SbZAq6/y5AEOOslgi/vLS272rhOh
	ST9pKbWw2nks2gP6QYtw6F7mr8LqroQgRZf2+t6eAiCmPx4NwMFrpUbb72MUavU8OIEwowLUZxE
	AlFPo8/cUt5lc1lLgZON9R+uSfQA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.896100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9FF2F3E5EFA6B6C83C89084B92CC090A2D23189E5CC30AEAB977F0DF339B5AED2000:8

PiBPbiBUaHUsIE5vdiAwNywgMjAyNCBhdCAwNToyMTo0NVBNICswMTAwLCBMb3JlbnpvIEJpYW5j
b25pIHdyb3RlOg0KPiA+IE9uIE5vdiAwNywgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiA+IE9u
IFRodSwgTm92IDA3LCAyMDI0IGF0IDA4OjM5OjQzQU0gKzAxMDAsIExvcmVuem8gQmlhbmNvbmkg
d3JvdGU6DQo+ID4gPiA+ID4gT24gV2VkLCBOb3YgMDYsIDIwMjQgYXQgMTE6NDA6MjhQTSArMDEw
MCwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gT24gV2VkLCBKdWwgMDMs
IDIwMjQgYXQgMDY6MTI6NDRQTSArMDIwMCwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4gPiA+
ID4gPiA+ID4gPiBJbnRyb2R1Y2Ugc3VwcG9ydCBmb3IgQWlyb2hhIEVONzU4MSBQQ0llIGNvbnRy
b2xsZXIgdG8gDQo+ID4gPiA+ID4gPiA+ID4gbWVkaWF0ZWstZ2VuMyBQQ0llIGNvbnRyb2xsZXIg
ZHJpdmVyLg0KPiA+ID4gPiA+ID4gPiA+IC4uLg0KPiA+ID4gDQo+ID4gPiA+ID4gPiA+IElzIHRo
aXMgd2hlcmUgUEVSU1QjIGlzIGFzc2VydGVkPyAgSWYgc28sIGEgY29tbWVudCB0byANCj4gPiA+
ID4gPiA+ID4gdGhhdCBlZmZlY3Qgd291bGQgYmUgaGVscGZ1bC4gIFdoZXJlIGlzIFBFUlNUIyBk
ZWFzc2VydGVkPyAgDQo+ID4gPiA+ID4gPiA+IFdoZXJlIGFyZSB0aGUgcmVxdWlyZWQgZGVsYXlz
IGJlZm9yZSBkZWFzc2VydCBkb25lPw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIGNhbiBh
ZGQgYSBjb21tZW50IGluIGVuNzU4MV9wY2lfZW5hYmxlKCkgZGVzY3JpYmluZyB0aGUgDQo+ID4g
PiA+ID4gPiBQRVJTVCBpc3N1ZSBmb3IgRU43NTgxLiBQbGVhc2Ugbm90ZSB3ZSBoYXZlIGEgMjUw
bXMgZGVsYXkgaW4gDQo+ID4gPiA+ID4gPiBlbjc1ODFfcGNpX2VuYWJsZSgpIGFmdGVyIGNvbmZp
Z3VyaW5nIFJFR19QQ0lfQ09OVFJPTCByZWdpc3Rlci4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gaHR0cHM6Ly9naXRodWIuY29tL3RvcnZhbGRzL2xpbnV4L2Jsb2IvbWFzdGVyL2RyaXZlcnMv
Y2xrL2NsDQo+ID4gPiA+ID4gPiBrLWVuNzUyMy5jI0wzOTYNCj4gPiA+ID4gPiANCj4gPiA+ID4g
PiBEb2VzIHRoYXQgMjUwbXMgZGVsYXkgY29ycmVzcG9uZCB0byBhIFBDSWUgbWFuZGF0b3J5IGRl
bGF5LCANCj4gPiA+ID4gPiBlLmcuLCBzb21ldGhpbmcgbGlrZSBQQ0lFX1RfUFZQRVJMX01TPyAg
SSB0aGluayBpdCB3b3VsZCBiZSANCj4gPiA+ID4gPiBuaWNlIHRvIGhhdmUgdGhlIHJlcXVpcmVk
IFBDSSBkZWxheXMgaW4gdGhpcyBkcml2ZXIgaWYgDQo+ID4gPiA+ID4gcG9zc2libGUgc28gaXQn
cyBlYXN5IHRvIHZlcmlmeSB0aGF0IHRoZXkgYXJlIGFsbCBjb3ZlcmVkLg0KPiA+ID4gPiANCj4g
PiA+ID4gSUlSQyBJIGp1c3QgdXNlZCB0aGUgZGVsYXkgdmFsdWUgdXNlZCBpbiB0aGUgdmVuZG9y
IHNkay4gSSBkbyANCj4gPiA+ID4gbm90IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBhYm91dCBpdCBi
dXQgSSBndWVzcyBpZiB3ZSBtb3ZlIGl0IGluIA0KPiA+ID4gPiB0aGUNCj4gPiA+ID4gcGNpZS1t
ZWRpYXRlay1nZW4zIGRyaXZlciwgd2Ugd2lsbCBuZWVkIHRvIGFkZCBpdCBpbiBlYWNoIGRyaXZl
ciANCj4gPiA+ID4gd2hlcmUgdGhpcyBjbG9jayBpcyB1c2VkLiBXaGF0IGRvIHlvdSB0aGluaz8N
Cj4gPiA+IA0KPiA+ID4gSSBkb24ndCBrbm93IHdoYXQgdGhlIDI1MG1zIGRlbGF5IGlzIGZvci4g
IElmIGl0IGlzIGZvciBhIHJlcXVpcmVkIA0KPiA+ID4gUENJIGRlbGF5LCB3ZSBzaG91bGQgdXNl
IHRoZSByZWxldmFudCBzdGFuZGFyZCAjZGVmaW5lIGZvciBpdCwgYW5kIA0KPiA+ID4gaXQgc2hv
dWxkIGJlIGluIHRoZSBQQ0kgY29udHJvbGxlciBkcml2ZXIuICBPdGhlcndpc2UgaXQncyANCj4g
PiA+IGltcG9zc2libGUgdG8gdmVyaWZ5IHRoYXQgYWxsIHRoZSBkcml2ZXJzIGFyZSBkb2luZyB0
aGUgY29ycmVjdCBkZWxheXMuDQo+ID4gDQo+ID4gYWNrLCBmaW5lIHRvIG1lLiBEbyB5b3UgcHJl
ZmVyIHRvIGtlZXAgMjUwbXMgYWZ0ZXIgDQo+ID4gY2xrX2J1bGtfcHJlcGFyZV9lbmFibGUoKSBp
biBtdGtfcGNpZV9lbjc1ODFfcG93ZXJfdXAoKSBvciBqdXN0IHVzZSBQQ0lFX1RfUFZQRVJMX01T
ICgxMDApPw0KPiA+IEkgY2FuIGNoZWNrIGlmIDEwMG1zIHdvcmtzIHByb3Blcmx5Lg0KPiANCj4g
SXQncyBub3QgY2xlYXIgdG8gbWUgd2hlcmUgdGhlIHJlbGV2YW50IGV2ZW50cyBhcmUgZm9yIHRo
ZXNlIGNoaXBzLg0KPiANCj4gRG8geW91IGhhdmUgYWNjZXNzIHRvIHRoZSBQQ0llIENFTSBzcGVj
PyAgVGhlIGRpYWdyYW0gaW4gcjYuMCwgc2VjIA0KPiAyLjIuMSwgaXMgaGVscGZ1bC4gIEl0IHNo
b3dzIHRoZSByZXF1aXJlZCB0aW1pbmdzIGZvciBQb3dlciBTdGFibGUsIA0KPiBSRUZDTEsgU3Rh
YmxlLCBQRVJTVCMgZGVhc3NlcnQsIGV0Yy4NCj4gDQo+IFBlciBzZWMgMi4xMS4yLCBQRVJTVCMg
bXVzdCBiZSBhc3NlcnRlZCBmb3IgYXQgbGVhc3QgMTAwdXMgKFRfUEVSU1QpLCANCj4gUEVSU1Qj
IG11c3QgYmUgYXNzZXJ0ZWQgZm9yIGF0IGxlYXN0IDEwMG1zIGFmdGVyIFBvd2VyIFN0YWJsZSAN
Cj4gKFRfUFZQRVJMKSwgYW5kIFBFUlNUIyBtdXN0IGJlIGFzc2VydGVkIGZvciBhdCBsZWFzdCAx
MDB1cyBhZnRlciANCj4gUkVGQ0xLIFN0YWJsZS4NCj4gDQo+IEl0IHdvdWxkIGJlIGhlbHBmdWwg
aWYgd2UgY291bGQgdGVsbCBieSByZWFkaW5nIHRoZSBzb3VyY2Ugd2hlcmUgc29tZSANCj4gb2Yg
dGhlc2UgY3JpdGljYWwgZXZlbnRzIGhhcHBlbiwgYW5kIHRoYXQgdGhlIHJlbGV2YW50IGRlbGF5
cyBhcmUgDQo+IHRoZXJlLiAgRm9yIGV4YW1wbGUsIGlmIFBFUlNUIyBpcyBhc3NlcnRlZC9kZWFz
c2VydGVkIGJ5IA0KPiAiY2xrX2VuYWJsZSgpIiBvciBzaW1pbGFyLCBpdCdzIG5vdCBhdCBhbGwg
b2J2aW91cyBmcm9tIHRoZSBjb2RlLCBzbyANCj4gd2Ugc2hvdWxkIGhhdmUgYSBjb21tZW50IHRv
IHRoYXQgZWZmZWN0Lg0KDQo+SSByZXZpZXdlZCB0aGUgdmVuZG9yIHNkayBhbmQgaXQganVzdCBk
byBzb21ldGhpbmcgbGlrZSBpbiBjbGtfZW5hYmxlKCk6DQo+DQo+CS4uLg0KPgl2YWwgPSByZWFk
bCgweDg4KTsNCj4Jd3JpdGVsKHZhbCB8IEJJVCgxNikgfCBCSVQoMjkpIHwgQklUKDI2KSwgMHg4
OCk7DQo+CS8qd2FpdCBsaW5rIHVwKi8NCj4JbWRlbGF5KDEwMDApOw0KPgkuLi4NCj4NCj5ASHVp
Lk1hOiBpcyBpdCBmaW5lIHVzZSBtc2xlZXAoMTAwKSAoc28gUENJRV9UX1BWUEVSTF9NUykgaW5z
dGVhZCBvZiBtc2xlZXAoMTAwMCkgKHNvIFBDSUVfTElOS19SRVRSQUlOX1RJTUVPVVRfTVMpPw0K
SGkgTG9yZW56b6OsDQoJSSB0aGluayBtc2xlZXAoMTAwMCkgd2lsbCBiZSBzYWZlcixiZWNhdXNl
IHNvbWUgZGV2aWNlIHdvbid0IGxpbmsgdXAgd2l0aCBtc2xlZXAoMTAwKS4NClJlZ2FyZHMsDQpI
dWkNCj4NCj5SZWdhcmRzLA0KPkxvcmVuem8NCg0KPiANCj4gQmpvcm4NCg==

