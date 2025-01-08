Return-Path: <linux-pci+bounces-19503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C54A05475
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 08:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3020F3A5BCD
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A001AAA1E;
	Wed,  8 Jan 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b5lcXPqW";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mf6tA/Dz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB91A9B48;
	Wed,  8 Jan 2025 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736321114; cv=fail; b=akzg635UcwBf4H6byBxi19oNbQ9pzwdAVN8wd/U4XkSX9PbuVEWKTxnfePtCG5O1hJILUid3M1RcpMu/u5vYHv0a3jmqQaDOTU6sUQKZvF+EhKh+h3tmGFEkXTHXEooxFZ2xQvelDJkjcS5C9CEF8OFA/0I/FEJDEhm6QY6kcFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736321114; c=relaxed/simple;
	bh=hw9BVOPfLWv3mX6Fu7L0hJfKZtNspLy6qaJhCLTxeCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQrkc1kyaDFs29HEDnKia7+6u1QmL5vospqKmOg1QnlR3rgjS+mLrHIfmxV5ZiSu0LvbTJGmt6LsXtYDjv4xSWk9r7ort8O4HygDihAmSbAMHs925nCHViNRbJqN6G1EzWEeMnxid6uqZRfGmOrxG+OoWO+UdssXKK+uNxXNJio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=b5lcXPqW; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mf6tA/Dz; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ab3ad3d2cd9111ef99858b75a2457dd9-20250108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hw9BVOPfLWv3mX6Fu7L0hJfKZtNspLy6qaJhCLTxeCw=;
	b=b5lcXPqW2/1dTlOFSl2qBbvwDErBrM6WN4+XXKVvsR46LEGw8vNtrJ8JjJr/Itn7IMWeEA/ZCv7WpCfLO/Z2qWsU2kM2WJJJf52ETEOx/cLKg75sSz1Fd8V+IuyE+oac7KYhKzJEKI5eq3tBIjXuAIMoodzJ0MuXBqi8doNCSPI=;
X-CID-CACHE: Type:Local,Time:202501081454+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:16e8bfed-b2eb-4c5e-8c6a-0387cf6ae472,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:1cb4e0d1-15ca-4d8b-940c-bbea7162947b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: ab3ad3d2cd9111ef99858b75a2457dd9-20250108
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1986002984; Wed, 08 Jan 2025 15:24:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Jan 2025 15:24:58 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Jan 2025 15:24:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEdeWgqZjWsr007ghzHuo54tikrV3Aa7XCJfbtyxvP1w/ElUgiUt3viqrLSnKQAEvnzrsDx4fMoSMGJ48bTCpyw6JzFJ9tyO7uterQxF5FhdYpdLr1tb741YgqSMRUkCzIf2Mts+5Ck0m62FH9M4qSW/WhJfwxXKZp/2LN/c5+ndHfS8CThwAsYuH0Z8SkD5SXghhN0t9Qewep6sDS35P3s0X3Ea8o4HYAZX3SxL9qwNEySvEn8ApYWnR1jU6fi4lxywK2GhM2CjVlBAImsesXNvCYbWNEwj+Ldcmd3eQws5QbUFWrnnOi5immx22vR8BZWLdsYWoIwjlQuLm3shAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hw9BVOPfLWv3mX6Fu7L0hJfKZtNspLy6qaJhCLTxeCw=;
 b=XZrOdFS7JrUdw/0s4LzGT0YjEE+44X6M9cO/9hUfDwziUb8/XL1eqz84MgAzjBSs4iOfEAreUnp8Zd+u6S7fYUiwdHQgOFsPnDYgdBE4MmTNdGasIX93npHPxb/axT9F2GwFSVlrmNW8TVenThHowfWWgCRLp+H9Wy/ZKv9jMfr2SarN9lYh1iS85TrJTw/IF7evKgLaPni2pTvfzeME1xKCWnJeCNA9LtjYuevZrpcUw9aAT+u4wvQXpKyaIsz93fdeKri+1p3RnDtTOFUFg1UXTAfCIVUgiRmHuYIuGsnHRIQEaOyQ8sBvLn7ecq9pQh9s1Rjtab3++mmZvs1FKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hw9BVOPfLWv3mX6Fu7L0hJfKZtNspLy6qaJhCLTxeCw=;
 b=mf6tA/Dz+qyLfaISDr+cVrssxSVDyrbhvvv7+ro+QnMURcqJdAETGxi2J3nnBJY38iO8JqT1YZ5jv0Wvg6MyjMG1Ml9q8T/TTo5P9slV4OfYanQPgggd7D63FMUKehGhNUIhjtgiS0n2NFcANO6DBTqCYOBAgZy7w/9LxQDpwz8=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB8568.apcprd03.prod.outlook.com (2603:1096:101:21a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 07:24:56 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 07:24:56 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
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
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Topic: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Index: AQHbXaTW76fSj2ANakexjY3C+uSV4rMEx8+AgAS1EwCAAdE0AIABM3SA
Date: Wed, 8 Jan 2025 07:24:56 +0000
Message-ID: <de7e350e16fc6ccdf932691bdddf6f3c66092130.camel@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
	 <20250103060035.30688-2-jianjun.wang@mediatek.com>
	 <0555fb64-312d-4490-9b03-89fca580c602@collabora.com>
	 <8269f5fb280d0847ceba288a83a64c99bbf92cb7.camel@mediatek.com>
	 <660e3bbb-4b16-49ad-82d1-a2c3e3ef76bb@collabora.com>
In-Reply-To: <660e3bbb-4b16-49ad-82d1-a2c3e3ef76bb@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB8568:EE_
x-ms-office365-filtering-correlation-id: 71c796d2-66b9-4122-2f43-08dd2fb58d65
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?STJMbElwenFUYlZJcmdUMVVwR3VQaHluZkEyMW5vTVJ2KzhwUFRXM3NFTUxS?=
 =?utf-8?B?NVJBaFZhNi9admZqQTIxTmVVVHFMd3d1MFZoaEwwbFBpcVU0U0NKQmVuYjZk?=
 =?utf-8?B?ZFl2dzlLTmR2OGFwT3FUdkZzdmhGbmVXOFR1eG45czdabC81dzdyeTEzMVBH?=
 =?utf-8?B?dlFxUi8rSnNuMkFUTXZWUUJjNUxlWmRCQTBxWDNnd0xmSjI4SklzT25VOVZ2?=
 =?utf-8?B?WTFDUUZlZTlLU09McFhYSjFtampUM3AwblRiVDlVWkdsVWppakcrQ25JRTVT?=
 =?utf-8?B?UW10bTA1bzZuSlJGbGcrMFZkbFUzL0V4eHI5c2d1UWg2Ujh1VFo3c0JEdEIy?=
 =?utf-8?B?K010aU5QejlUQ2xUd2xOUHBZeXBOQUd1TlJJYlJOVUF2bW5RMCtHT1pndytR?=
 =?utf-8?B?d3kvTVArOWpEZ29TSGJCU1o4ZXh6NWswQTlwU3M5UUwxUjk3YVQzcWYvTVZS?=
 =?utf-8?B?VjhWMENWNHRsM0tWNE9FUzlyOC9qNHhTSUt5VFNoSXVVb3dWWEx3bmw2bE9i?=
 =?utf-8?B?djl0OW9GZUg5WEk1djV5TUZxaTZCa2Vqa2kzN1BEa1ZwcEs0VFRPdW1hVi9p?=
 =?utf-8?B?ZTliRGoraHI3OTVSVXU5VFdkYlpteWpjMHhwUG90K1hyYlZuaGN5Q203eGtk?=
 =?utf-8?B?RjZTSi96eStpVUo2TXFTZ0lUT2VTU25PdFN0Yk1nSW9PbWVMS25qM1Z0d1FC?=
 =?utf-8?B?Zk95Um04c1R2LzhMcVFvYmp4b1h1eFNYaFIwRmR1YTV3dHNwVFY2eEZ1eVNo?=
 =?utf-8?B?NXhTZzBZZzZKZFVJYlhCa0tVN1FxTk9FUDVsR2pTTEpvN0U4LzhMWHFMa1lx?=
 =?utf-8?B?MTlmZW96QXZSd0IwSVl2WjUwWTh6eHFtajY2UkVHNUxzVnY3VDFXMmVqWHp1?=
 =?utf-8?B?QWFqVS8xelllQnRDZEZsSkU0bzZZdGIwNUhpNlhFc1cvTTIyTDRKdzFZV0Vi?=
 =?utf-8?B?Mk9DdWNFR2xkSDAzd0Z5NjdURHJpa0tLTC9WWW9sVDVDREI1RWdjb04vdEdF?=
 =?utf-8?B?YytteGpoeU1RV1JTS3ltS2UyMVVGT3lSU3dTbXlKaUluaHBUNStLK3V2QzR1?=
 =?utf-8?B?eVZQdWg0dXFYU1cwbGF1VXFoY0NLbVpyVjdzN2FzWWtFUDBTeEJUQWYySWpF?=
 =?utf-8?B?K0FJZ1JHaWZTemlLcVpHZXlOQjVpdkRKbjRQMWhTQzduQW1oTkhMY2t0T0hx?=
 =?utf-8?B?K2lNcjBtM25aL3lBVkp4RE5NN3cwQTlTWWRQMkxMUmh0ZFdGa0d6QVJUalRC?=
 =?utf-8?B?N2JkQ3VmSnlBTVNQQ3MzOGZieUpmdFBCNGxCc1pGRCsxT0p1Q05PVmRnNkUr?=
 =?utf-8?B?M3RucCt6TVk5NjJ5SEZTNHJremh5dHE2M3JWRDBxUk8xMUZDeGlHSGw3SGlE?=
 =?utf-8?B?REpVSmVZMFQ3MHBUek41WTRIRGxlcGVsZTh4VmZjSUFIVGc0ODdueGVsY1pz?=
 =?utf-8?B?VklnNEdlY2VBeTcvd3BHNnRqRzgyQkxXWDJxRnZWKzE2WTdmc0k0UnRkUTJK?=
 =?utf-8?B?aytZRmQvbGIwYlZFS0pabUFqQmljMml0NDZPNFh5RTh2ZytCUmlaYjROTjJx?=
 =?utf-8?B?L0U0eEsvRGNXdU9aeVNmZS9XV1hEaWpDejhZTXozQXhHM0tJSHdsek0vOWpJ?=
 =?utf-8?B?eE5FMTZsY3REVlIxSjY3Zi9NcXA0ZVV5eEpyTWRzS1FUVTdiMEhCdnFlNVNo?=
 =?utf-8?B?cC9SNmRKbzFBanRLZVZkaFUxc1JDOXU0UStwVUViTFNlOFBkekV4MWlXbzQw?=
 =?utf-8?B?MGJSUWNLbjFqcitVMkdDNnFvcXF2Y2ovOGdTenNVUlJxVWZpL0pFQ0RKNkxJ?=
 =?utf-8?B?YmlVS0xOQW5MRVdoOFdZNHFVYVBoN3FKaU1rMG8zTHdxL0NxcUdaYTBBQ3c2?=
 =?utf-8?B?Y1pBRXBsd0Vza09oUTdnU0g3OS9OYnNZVVMzQmV3S0J4RFZMNUxPUURINFdt?=
 =?utf-8?Q?5lbTlU4ONryhcxCJXz8e/3cI/VkGqa+G?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXZXQWR5VkNYTWF4clRlWnUramFTVkRsYmdJaG9wZ1hrRXRBMjh3ZlpCOHQ1?=
 =?utf-8?B?d3RuV0d4OCtFT2xpSmVvLzFQUEJBQ0NSOG1Sb2l2bGQ3MzZuQ3F1WDZHb2FB?=
 =?utf-8?B?Um04TGtVNXY4N2JrYnllekpvcjcxbHhKMFFCTlNRc2V1TVJyd2d6MG1oL0pU?=
 =?utf-8?B?NTF1Vzc1MDNnMys4WWtyRDZlaHdwcWNoSmc5Q0ZzcVhTZ1VDMDV4T2pkc0wv?=
 =?utf-8?B?Nm4rbnA1TTI2eTU4Y3JlKzVRcXdjU2trN1JROVJhOGJOSURBN1RZMFhPQk1a?=
 =?utf-8?B?WVcwN3RjNlFkcXpKbG1mMDcvZng1N2hqQ2xudU5JcUxsY1orNWQ5Y3dqWEoy?=
 =?utf-8?B?MFdJOU9DK1lYVldwTVNSY0V3V0RSd2lNaG16Sy9NSDhwQlVQS1ZUdkc2N2R5?=
 =?utf-8?B?YXlmZi8xVWtHVXVEMkFVeEk4K1VQSHZHdCtRUjZnT2pLUlJFc055SGZPbVdu?=
 =?utf-8?B?dmVoN0prckFOTjJDRWd3eTloS1JHSWZUK2s1blZFeGlvMG00MEFEenpBVVpp?=
 =?utf-8?B?TnV1b09NRzhxOGpNKzRtWmlKaHN5NWVUdWhXenpjRjBzSVlyd0RBQzJQSFVZ?=
 =?utf-8?B?c1VHb0FUM2ZFK2RJZXBSOXBXT1JZME9OUDEvRkcwT2RqSitxVGtOdi9uRE10?=
 =?utf-8?B?M2VNaGRsMWNnSnE5ZnVFd3d0a2hKNUR5aHo3YjZxQmxMSXBQbDhrUWVHQ2Ra?=
 =?utf-8?B?MzJ5SGMySWZ1bWdJR1dmTGsxUm5FMkZwVGxRSTZjVGtSS2ZPeENmNHJuVDV1?=
 =?utf-8?B?L28vaHNLT0hOY1RVVEdiMWdiR3hHQ0RXRWlqQ3JlLytjUGVscnF5T1FRVDl4?=
 =?utf-8?B?NWx1TWVtTmxSRG1wTWIyVGRHaDFWbGpiNnNPbThuYlRERXY2V0VPVVpVZEcv?=
 =?utf-8?B?RkVDV2tIOEhiNDdBQlExb0NRTERIVjQ0dmF2Q3ZhaEI2S3JRendZNnk5Qjg0?=
 =?utf-8?B?S0c5ejRuRnAxcUYrU1J3U3ppSmFqNHNmUTR4b0NxNEVqRllIK3hucllBNmtw?=
 =?utf-8?B?V01vSmFWa3hzRTd0TDRRaHNBNEVGUjY5OGVnN09zVjgwUC91Q2lWZUJUcDBG?=
 =?utf-8?B?UlZGcnBlMmlJcGJEV0pjV2t0MkJKWlZNVUdhOUxsR2FFb1NGTXBJekJRUlpu?=
 =?utf-8?B?U1ZQdFByYnhPZFBBOTlhdnNyQ3RjWXFDWm04M2tNa3YySDNYQ1NzYzRXZ0dH?=
 =?utf-8?B?ZTJXOGVZOUN6VGl3T1pYKzl2cVBGZEUxTTVQbHBIZE11SXg1M3BMUW52dXlp?=
 =?utf-8?B?eWhzSlZPZmkxNkdSaDhLdGZTUGt2eEV2aWtmaUc5ODBSelJJSjh4MGJZL2I3?=
 =?utf-8?B?OXhlbGdrK3g5d2FMeHhvdGdEUzVNeUordnkrdkdQR09kc0hNckVJNU1RWHcx?=
 =?utf-8?B?TUpELytkMjhyelRMRzBSa1ZSY2hYclhQWDIyL2pYUUN4RTFMbHQ5YjdLd0pi?=
 =?utf-8?B?b0JMTGdGMVJicFNBKzR3cE9YZk00ZXA2TFlhQ3pScU83VExROVZMM0E1TThK?=
 =?utf-8?B?YU1jaXM0eVp5b21NQmJNTVRpdWtFQSt1MkFUUkVNMVVsbTV0VFBtSnV0eS9j?=
 =?utf-8?B?d0lvTVpJcjRZYnYrb0hNS2JKMC9HQXBtZXNLRXBnN1ZudGdpRDRqQmpmYlZz?=
 =?utf-8?B?SDM4dkZnak5FTkhLV3l1V0g3cVRKWVBDY01YdGUyS3ZXdWxpNkN6NXJkeVdM?=
 =?utf-8?B?KzBXbVhIL0ZoZUtHV0lCTVJVdVF0VlE1bnhDa3VsQSttWGUvcmx5S1R5WUtw?=
 =?utf-8?B?VnQzNXM5V21BWW0yNWVUbWw5MWNmbmtKMFJQSmpKYVlkQ01Cbzd1cFArNFlk?=
 =?utf-8?B?NW1Lejh3amRqbnBLR0NJS0pZazF5c1ZrYzdjcjVGd3N4MUJnako5TW0rZ3Vw?=
 =?utf-8?B?UFQ2Z251TXI2dFpWL29XMjA5cVJNTlBTZGNpeGo4QjU2cUtSWFRUM2FVNXNY?=
 =?utf-8?B?TzhBY0hqUHVpOWlQZG8yMkJYQ3hUVWw1cUdnSWd4WGV3K2lCMHAwa1U5angy?=
 =?utf-8?B?YzhhaHBJUmQ4dlBRY0RUeEs0TzVyTkIxNXJsc3p6SlNxTWQ1WE90QnRBOG1U?=
 =?utf-8?B?SXluVnpNM3ZGWTlPeHd1ZnVuUHZWYWMvMXVPR2xSUkdDQkowMUpuc2RWQkxx?=
 =?utf-8?B?dEFrRjM5bG82SnRyYmZUam81TUU1MXJDY0ZnT1lTSjNBbzYwSGVETmMrR1Qz?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F02AA41218B4546BBA4566E52408C71@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c796d2-66b9-4122-2f43-08dd2fb58d65
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 07:24:56.4148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZanyr/t3QagcjD2J/u+VOISCJn0qBkH50npAscyhfPHLyR+S24Ke6Dht4lfJOV0TXRxO5HTB8gNH/AGnlY/ZUPqBNLotzuiSu1NmJWBdcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8568

T24gVHVlLCAyMDI1LTAxLTA3IGF0IDE0OjA0ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwNi8wMS8yNSAxMDoxOSwgSmlhbmp1biBX
YW5nICjnjovlu7rlhpspIGhhIHNjcml0dG86DQo+ID4gT24gRnJpLCAyMDI1LTAxLTAzIGF0IDEw
OjI2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubw0KPiA+IHdyb3RlOg0KPiA+ID4g
RXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMNCj4gPiA+IHVudGlsDQo+ID4gPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IElsIDAzLzAxLzI1IDA3OjAwLCBK
aWFuanVuIFdhbmcgaGEgc2NyaXR0bzoNCj4gPiA+ID4gQWRkIGNvbXBhdGlibGUgc3RyaW5nIGFu
ZCBjbG9jayBkZWZpbml0aW9uIGZvciBNVDgxOTYuIEl0IGhhcyA2DQo+ID4gPiA+IGNsb2NrcyBs
aWtlDQo+ID4gPiA+IHRoZSBNVDgxOTUsIGJ1dCAyIG9mIHRoZW0gYXJlIGRpZmZlcmVudC4NCj4g
PiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEppYW5qdW4gV2FuZyA8amlhbmp1bi53YW5n
QG1lZGlhdGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgIC4uLi9iaW5kaW5ncy9wY2kv
bWVkaWF0ZWstcGNpZS1nZW4zLnlhbWwgICAgICB8IDI5DQo+ID4gPiA+ICsrKysrKysrKysrKysr
KysrKysNCj4gPiA+ID4gICAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKykNCj4gPiA+
ID4gDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcGNpL21lZGlhdGVrLQ0KPiA+ID4gPiBwY2llLQ0KPiA+ID4gPiBnZW4zLnlhbWwgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21lZGlhdGVrLQ0KPiA+ID4gPiBwY2ll
LQ0KPiA+ID4gPiBnZW4zLnlhbWwNCj4gPiA+ID4gaW5kZXggZjA1YWFiMmIxYWRkLi5iNDE1OGE2
NjZmYjYgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWVkaWF0ZWstcGNpZS0NCj4gPiA+ID4gZ2VuMy55YW1sDQo+ID4gPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWVkaWF0ZWstcGNpZS0NCj4g
PiA+ID4gZ2VuMy55YW1sDQo+ID4gPiA+IEBAIC01MSw2ICs1MSw3IEBAIHByb3BlcnRpZXM6DQo+
ID4gPiA+ICAgICAgICAgICAgICAgICAgLSBtZWRpYXRlayxtdDc5ODYtcGNpZQ0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXBjaWUNCj4gPiA+ID4gICAgICAgICAg
ICAgICAgICAtIG1lZGlhdGVrLG10ODE5NS1wY2llDQo+ID4gPiA+ICsgICAgICAgICAgICAgIC0g
bWVkaWF0ZWssbXQ4MTk2LXBjaWUNCj4gPiA+ID4gICAgICAgICAgICAgIC0gY29uc3Q6IG1lZGlh
dGVrLG10ODE5Mi1wY2llDQo+ID4gPiA+ICAgICAgICAgIC0gY29uc3Q6IG1lZGlhdGVrLG10ODE5
Mi1wY2llDQo+ID4gPiA+ICAgICAgICAgIC0gY29uc3Q6IGFpcm9oYSxlbjc1ODEtcGNpZQ0KPiA+
ID4gPiBAQCAtMTk3LDYgKzE5OCwzNCBAQCBhbGxPZjoNCj4gPiA+ID4gICAgICAgICAgICAgIG1p
bkl0ZW1zOiAxDQo+ID4gPiA+ICAgICAgICAgICAgICBtYXhJdGVtczogMg0KPiA+ID4gPiANCj4g
PiA+ID4gKyAgLSBpZjoNCj4gPiA+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gPiA+ICsgICAg
ICAgIGNvbXBhdGlibGU6DQo+ID4gPiA+ICsgICAgICAgICAgY29udGFpbnM6DQo+ID4gPiA+ICsg
ICAgICAgICAgICBlbnVtOg0KPiA+ID4gPiArICAgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE5
Ni1wY2llDQo+ID4gPiA+ICsgICAgdGhlbjoNCj4gPiA+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+
ID4gPiA+ICsgICAgICAgIGNsb2NrczoNCj4gPiA+ID4gKyAgICAgICAgICBtaW5JdGVtczogNg0K
PiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgIGNsb2NrLW5hbWVzOg0KPiA+ID4gPiArICAgICAg
ICAgIGl0ZW1zOg0KPiA+ID4gPiArICAgICAgICAgICAgLSBjb25zdDogcGxfMjUwbQ0KPiA+ID4g
PiArICAgICAgICAgICAgLSBjb25zdDogdGxfMjZtDQo+ID4gPiA+ICsgICAgICAgICAgICAtIGNv
bnN0OiBwZXJpXzI2bQ0KPiA+ID4gPiArICAgICAgICAgICAgLSBjb25zdDogcGVyaV9tZW0NCj4g
PiA+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IGFoYl9hcGINCj4gPiA+IA0KPiA+ID4gYWhiX2Fw
YiBpcyBhIGJ1cyBjbG9jaywgc28geW91IGNhbiBzZXQgaXQgYXMNCj4gPiA+IA0KPiA+ID4gLSBj
b25zdDogYnVzDQo+ID4gDQo+ID4gQWdyZWUsIEknbGwgY2hhbmdlIGl0IHRvICJidXMiIGluIHRo
ZSBuZXh0IHZlcnNpb24sIHRoYW5rcy4NCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiA+ICsg
ICAgICAgICAgICAtIGNvbnN0OiBsb3dfcG93ZXINCj4gPiA+IA0KPiA+ID4gQ2FuIHlvdSBwbGVh
c2UgY2xhcmlmeSB3aGF0IHRoZSBMUCBjbG9jayBpcyBmb3I/DQo+ID4gDQo+ID4gVGhpcyBpcyBh
IHBvd2VyLXNhdmluZyBjbG9jay4gSXRzIGNsb2NrIHNvdXJjZSBjb25zdW1lcyBsZXNzIHBvd2Vy
DQo+ID4gdGhhbg0KPiA+IGEgcmVndWxhciBjbG9jaywgd2UgbmVlZCB0byBrZWVwIHRoaXMgY2xv
Y2sgb24gaWYgd2hlbiBlbnRlcmluZw0KPiA+IEwxLjINCj4gPiBkdXJpbmcgc3VzcGVuZC4NCj4g
PiANCj4gDQo+IEluIHRoZSBkcml2ZXIsIHlvdSBhcmUga2VlcGluZyBhbGwgY2xvY2tzIE9OIGlu
c3RlYWQuDQo+IA0KPiBJcyB0aGlzIGNsb2NrIHJlcXVpcmVkIHRvIGJlIE9OIHdoZW4gdGhlIGZ1
bGwgcG93ZXIgb25lcyBhcmUgZW5hYmxlZA0KPiBhbmQNCj4gdGhlIFNvQyBpcyBub3QgaW4gc3Vz
cGVuZCBzdGF0ZT8NCg0KVGhpcyBjbG9jayBhZmZlY3RzIHRoZSBleGl0IGZyb20gTDEuMiB2aWEg
dGhlIENMS1JFUSMgc2lnbmFsLCBhbmQgQVNQTQ0KTDEuMiBjYW4gYmUgZW50ZXJlZCBpbiB0aGUg
bm9ybWFsIHN0YXRlLiBUaGVyZWZvcmUsIHdlIG5lZWQgdG8ga2VlcCBpdA0Kb24gbGlrZSB0aGUg
b3RoZXIgY2xvY2tzLg0KDQo+IA0KPiBDYW4geW91IHBsZWFzZSBhZGQgaGFuZGxpbmcgZm9yIHRo
aXMgInNwZWNpYWwiIGNsb2NrIHNvIHRoYXQgd2UgY2FuDQo+IHNhdmUgcG93ZXINCj4gZHVyaW5n
IHN1c3BlbmQ/DQoNCldoZW4gZW50ZXJpbmcgdGhlIEwxLjIgc3RhdGUsIHRoaXMgY2xvY2sgaXMg
dGhlIG9ubHkgY2xvY2sgbmVlZGVkIGJ5DQp0aGUgUENJZSBIVy4gSG93ZXZlciwgc2luY2UgQVNQ
TSBMMS4yIGlzIGNvbnRyb2xsZWQgYnkgSFcgYW5kIHdlIGRvbid0DQprbm93IHdoZW4gaXQgd2ls
bCBleGl0KGUuZy4sIGV4aXQgYnkgdGhlIGRldmljZSBzaWRlKSwgd2Ugc3RpbGwgbmVlZCB0bw0K
a2VlcCBvdGhlciBjbG9ja3Mgb24gdG8gZW5zdXJlIHRoZSBQQ0llIGlzIHJlYWR5IHRvIHdvcmsu
DQoNClRoYW5rcy4NCg0KPiANCj4gQ2hlZXJzLA0KPiBBbmdlbG8NCj4gDQo+ID4gVGhhbmtzLg0K
PiA+IA0KPiA+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBBbmdlbG8NCj4gPiA+IA0KPiA+ID4g
PiArDQo+ID4gPiA+ICsgICAgICAgIHJlc2V0czoNCj4gPiA+ID4gKyAgICAgICAgICBtaW5JdGVt
czogMQ0KPiA+ID4gPiArICAgICAgICAgIG1heEl0ZW1zOiAyDQo+ID4gPiA+ICsNCj4gPiA+ID4g
KyAgICAgICAgcmVzZXQtbmFtZXM6DQo+ID4gPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDENCj4g
PiA+ID4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPiA+ID4gPiArDQo+ID4gPiA+ICAgICAgLSBp
ZjoNCj4gPiA+ID4gICAgICAgICAgcHJvcGVydGllczoNCj4gPiA+ID4gICAgICAgICAgICBjb21w
YXRpYmxlOg0KPiA+ID4gDQo+ID4gPiANCj4gDQo+IA0KPiANCg==

