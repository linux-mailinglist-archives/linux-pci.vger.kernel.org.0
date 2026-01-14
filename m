Return-Path: <linux-pci+bounces-44702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B7D1CB1C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 07:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44426303998E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 06:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6B36E46F;
	Wed, 14 Jan 2026 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EwEsuDzL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="G7so2yUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8326121FF5F;
	Wed, 14 Jan 2026 06:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768372786; cv=fail; b=Ks8FdwfBDU4wGeiNSn5ndCjyCF0O/3H8yYJ2t/Zyflax8tWiutl8TYbJFv7UBW983rJxIrEfqm8GUXnQYJELkIIh++1CvjgY9HzERwg8n+lqpAN5mYpXwGTAgHLA/0zNqBgE6BfZ9PjuC/eiwbac2NKfUfSthQvsfKvWcWNMSks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768372786; c=relaxed/simple;
	bh=GgNs4iYCJiE1WMbtRypqd4MPzblsaf5wcRG1Q+NNIFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gmv+R+L1/+zJZxQ6ozHCIGWzERslBOWe+qrDFizUyBq5mvRONCMkguWHGtWYKR+hMoKVokX8Yz6gdzrCvXw/NEMSO7Au2kUsIxGnnhEV7EiUq866uszBYxZJ2gUuVTYKgadQ4WLXXdSE1gjB8d8V6seEPAB57ej1Y3gN8Y20egg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=EwEsuDzL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=G7so2yUr; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c71cf3ccf11311f0bb3cf39eaa2364eb-20260114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GgNs4iYCJiE1WMbtRypqd4MPzblsaf5wcRG1Q+NNIFM=;
	b=EwEsuDzLpQq/MwqKt5Sa7TxqLzJV4BHYCh1ahKJ3JA3JydwjjGkfb9+/BQeNeK5xBNbqvEBBLtXDj7UgHCSgQqcVJ38H3DIASF1av73jCeeDYd4f0SGQKPSpi+FVW5ayGkEsF5k/yGp8y+BNHhzjoVGBJGr6q0VqjIigWsuIt2k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.9,REQID:d2d0f832-259a-4f43-af24-bf1193eb9731,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:5047765,CLOUDID:95b782ef-16bd-4243-b4ca-b08ca08ab1d8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c71cf3ccf11311f0bb3cf39eaa2364eb-20260114
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <johnny-cc.chang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 468160083; Wed, 14 Jan 2026 14:39:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 14 Jan 2026 14:39:28 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 14 Jan 2026 14:39:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQ6trJEgIu0/fDiyPjqQuJkU14c/1zSfVt7WpBScDrzbbYy5mV73aeyUnlJnk6nXO/IVxQFvaLjmq/ESrBKv5MGrNbAYBZJIDHw16eDwk38L2v8J53fpVac/dFb2K606VYBYxSZlRRKGoGe6zqClngm2CArzPCklTBPbHw66eK/472WixpiULsjNR//aY4/70nqmjJmbFnzFprwD4Zz5LysJx3MGpAKnZcPfhR/YFyPhqYZbXHC+OCxccMrWztVM3vAef+hrcTof8HSrrUB52s1Q2gf3FqLWDILQhTUe6rRcU3ZXTCe180OxpICmSVYfcO5eg+WyvAdf4T9P+b5x3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgNs4iYCJiE1WMbtRypqd4MPzblsaf5wcRG1Q+NNIFM=;
 b=sDxl4BLLkMlHQ2AOqqHfVUv3E2k3eG0H/Ji80EFz1vKJN9bwL3mWqBFansmpRVYJ7DEr7oKoD7UCvUazY0in+ozk30xj2/BFqHN3cSrVwBRlijbyy9iySah/aDfXJIrGOkryPQNhaTH8cHl74C+r1tFbJLyeBEs5kTGt4VEUDVvyRMsEuU507lfjkHvRFJ/5f9QhR8GLKQxyBuQJgMP/gIztl0TExF5bCoP2tLFA5YcC0hezBUUcUQpTVgV2O/8cdeoMsH7pcOYGMR06GtWHrNn+NL3aQ6mz2nEDnyM9f8x7vTD1FB04TGHdZ5Iy9WXw3mAeLf8jwn25GG6NBImKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgNs4iYCJiE1WMbtRypqd4MPzblsaf5wcRG1Q+NNIFM=;
 b=G7so2yUrtPXHqtH+ijYjya7A6lFzR00PCDU5ahuaEOgXA5hhifzajSFqdQpjIQJUBYMuZgAolGjC/ijGRhuB9K2RZi47pnZ79qfLrCM8XAzn0KeeSqDGlAPpEWd/kJcFTrB7v9BtuRfIJwBDuX9jKw2UAUmxD1VxRWRqy+cnRFo=
Received: from KL1PR03MB6169.apcprd03.prod.outlook.com (2603:1096:820:90::7)
 by JH0PR03MB8234.apcprd03.prod.outlook.com (2603:1096:990:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 06:39:24 +0000
Received: from KL1PR03MB6169.apcprd03.prod.outlook.com
 ([fe80::9304:c8ee:ce3c:e70d]) by KL1PR03MB6169.apcprd03.prod.outlook.com
 ([fe80::9304:c8ee:ce3c:e70d%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 06:39:24 +0000
From: =?utf-8?B?Sm9obm55LUNDIENoYW5nICjlvLXmmYvlmIkp?=
	<Johnny-CC.Chang@mediatek.com>
To: "lukas@wunner.de" <lukas@wunner.de>
CC: Project_Global_Digits_Upstream_Group
	<Project_Global_Digits_Upstream_Group@mediatek.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Thread-Topic: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Thread-Index: AQHcVHnastJoxsIJbEqLLkQpp8yUiLTwWe4AgAfbiICAWWKdgA==
Date: Wed, 14 Jan 2026 06:39:24 +0000
Message-ID: <8d91c98a99a0a1b368691a93141f4f14e5ece44c.camel@mediatek.com>
References: <20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com>
	 <aRWnYCI6Ax14XNJq@wunner.de>
	 <39028d84844a08b8b716eb3941cc02562d21dc84.camel@mediatek.com>
In-Reply-To: <39028d84844a08b8b716eb3941cc02562d21dc84.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6169:EE_|JH0PR03MB8234:EE_
x-ms-office365-filtering-correlation-id: 1a0fde14-8059-451b-0249-08de5337a844
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZjRXZkVBdUxzNGtlbG41ajdDcld4aXIxcWRFVWFkc0ZMREZ2SnAwMFMwbC81?=
 =?utf-8?B?NWoyd2NaZDE0d0hiSTViK0FKSTgwU21RRUxRTnNheXNBSUxQSDBtcWdTRUUv?=
 =?utf-8?B?YjNEVHBTc2xQcnRhakxuQ1JpbGRSdHB0SVhOLzFQeUlkaysweURPUWtqM0E4?=
 =?utf-8?B?ZjgreUNzRWJWV3V0SWFHWnU3M3pEcGZXS0N0dFk2UFJLQ09CdDhaOFdmVFVz?=
 =?utf-8?B?Ulc2Zkl5TXI5VFNESkF4QUNyak1LZm9ORmI2SUFncjhTNDV0djhzc0ZsOHp2?=
 =?utf-8?B?TFZxK0VKTFRkaUgzbmRIcUxVZ1dIRkhORzFvRStTSUczSWRUZ1djazJCd3Fv?=
 =?utf-8?B?RUNQTXFlUS9OS2R5NjJCa3JGWk5YVzl1VkFPQ1dmTjFVRHUxM20wZngvZDZr?=
 =?utf-8?B?UW1MNWh2a3pCdlpXZXNES3hlOGFIOUl6ZTdJVjY0YWlYdWNMUHhNMEVWbzNl?=
 =?utf-8?B?NldRNUdJNUhOa2ZuQ2dNOHJWcTBod3FZYUVDeS9Eak5HU05yRk5JelpkVndP?=
 =?utf-8?B?SlNrUVRtak1YM2FHUmcyV1o3MmRnSy9lTkx2TVc4SFluVTd0SlNNQU1sZExt?=
 =?utf-8?B?N2M4WEdmVmZLZ3JzaTBTdElVbkl2VkkvMmd1UWhPd05Cbk1ibm9rQmFPTDZQ?=
 =?utf-8?B?ekkwUHFvdXczNTRHN2QrYldKcEpGTnRpS0VUYWc5a3hqV1B4a09Bc1BVSlBz?=
 =?utf-8?B?ZzVlVTJCNDNzRk5PbE81ajBiZ2VQbDYyZ0FJRi80VU16bHFmTFJaSkNQRHNh?=
 =?utf-8?B?aXcwM1UvZjJTR3p2TnU0OWM2c0N1Wml4ZC8vQm9JTUZHbFFRQmd6c0JxQzEv?=
 =?utf-8?B?bEduVC8rR2xzeU84dzAxejdBYmJRUFhsdmlLYmJxS1VraE5CM2VJem1BS3p5?=
 =?utf-8?B?OWk5MXh4R3VxUXJCeXI5Sm1TS3hoVlA0MjhvVVFpb2ZiVWJRaTRBeVdVTE5T?=
 =?utf-8?B?R0VNRU1WaHJxOGN2RlJiM3pCMnkrVlEzYVB5T00zbVdrcDVEZE1aSkJXQ1Nk?=
 =?utf-8?B?L2xmV0RpUW5mWStVcFFHY2FzaVlhRzQvRTRKUkFZaERnZEhnL0VhelJ2TEVw?=
 =?utf-8?B?R3RrUDc5dXJDWGdSTExvOW02NC92U1J6NGlBQk4xMmFlZVl5UURvWUlvc280?=
 =?utf-8?B?TDlMd0R3U0MvaUZ0WWZsaHBOMURiVEkva05UakxTVmRTUDAwL0pCV3Q1b21S?=
 =?utf-8?B?cmduRHhvZ1pKMFJncmowdEFXVm1GclRqMXpScWZNeE5oRU95WFJaNTVpSXYx?=
 =?utf-8?B?UkJkeHpoSUt4NW9JY0lCenloSHE3anVjTGtTOGw0NjFJTDZaLzgxOE93Rld5?=
 =?utf-8?B?YmNPTUh3OEowdk9mWmlGUk9LZXQ5ZDQ2YUUvV0pTa3dsVU9WaWQxTm94dDNS?=
 =?utf-8?B?MkVEQ3J1bkNkUmppR21TaDJjZ3BWbEU1bEMxVWF6WktQMGZNM3NqODNSK1o3?=
 =?utf-8?B?dThndVAzb3VXb1dGdUE1bXFab0dGcFlEM3FMSEtjeGtyOENvWDdwcFNZQU9T?=
 =?utf-8?B?TUx6Q25tOWxGNlIyK1VoVEpCaHBaK043US9qTm9uVWdyWVRhUjJsY2Vnb284?=
 =?utf-8?B?K3FaVG5KVjNwdFVZaTRPdGcyNmZxZUdtbWt4Qi9sVHhZem1UaWRkLzdhNTZ4?=
 =?utf-8?B?NUFjSDlseVRxS2ZRWndENHNwcjJic2VrcGY4Mkw5VWRKZlB2aDd0SVBERmpm?=
 =?utf-8?B?SW5ERVpiek95T3pJN3pHVGJpbHIxaE8yS0VPY3AvOGdHQzVOUGFPSTZhS0pt?=
 =?utf-8?B?alJwbmpZRS8xcTAxZ1JkTzgxOHFFWHFBTWtJM05ubStkOVRkeDBLZ2lRYjlX?=
 =?utf-8?B?Y0VsRXRCSjJxZjk2a2U3U2V0aXM1V3Qrd3VqVFMvd2xFZ1djYllzZEE4ZVZ2?=
 =?utf-8?Q?WcexZotFqtDh7?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6169.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFY4K3B3TkpyaEVrRUp1YTZMTHk3NWRnYjZKZFVrZjZYS1M0Wjg4cjNxdGhi?=
 =?utf-8?B?SDVvaXhHNjlaSXJsTTFqV3ZHU3l2VURGd0NoRTIzQk1hUUdEd28walpZRUJS?=
 =?utf-8?B?YzgxTEsrZE1wMFRDM2NwTmdBbVROSEQ3cGFZY25JdUtOeXU2U29XeE85R21s?=
 =?utf-8?B?UnBZVE0yV1JHb0VUT2ZFYUlPcUNhSUlUSGc0WUpKK0dKQWdNQXlIdWZ1UjhV?=
 =?utf-8?B?akIrQ3BDRVJYY2FGaGdZUGJrRW84dzdGcUZKNFV5ZDhUSHorRW8vQk15OTI2?=
 =?utf-8?B?ZUF3ZERJVUE0Wm5rY2lhdWZuZUJRWnQ4bUUwbkhPMm03ZTdPemdTNXd6c3ZH?=
 =?utf-8?B?K243VWZWM0UzVFVQWkNhWWw2ME5tc2ZIVGtaQWdSc0NtMHBtSGdYYlFsSENQ?=
 =?utf-8?B?aXpvekptRlpuVTd6VWwwUVdYekpML2lZVnJzZXdUTXpSUVlQQk5MUkNuTDF1?=
 =?utf-8?B?Sno0aTRvUm40VmdyVkt4MUhGaDJaSkRJblo3RklZUEk4RDgza2FkOWk4bG1G?=
 =?utf-8?B?cXdFTk5VWFVtZE5PNFJRc3dOZTVqUG90cDZMaWhBdDU5UGpZR0VTbC85SGJT?=
 =?utf-8?B?aHBMU1NqMnR4UCt2YUxtVGE0TWZsak1QY0dXQXY5VVowUnZvZy8vVHFndDB0?=
 =?utf-8?B?YWpNUXlBNGRMNHRMc2M3SDV2NG5abG16VnQzWGJUQnJjSXN4ZnZSaFBBR05k?=
 =?utf-8?B?eFZKV0VPMzl6UEEwL1p2U0djTlV0SmZxazl2ZGg4N2JDYkhndlRsUjdhV1d2?=
 =?utf-8?B?KzNHTUtnclRiUTFXTFpqYWM1em5uUFh6MkFGTjRhakdpdmdIM3E5MGFwMndt?=
 =?utf-8?B?TUNkU2JOMnhMSFpPdUVHeVhMVEFVZlI3RjBtTDFSUW4zT3RWVzNPdS9nTnBE?=
 =?utf-8?B?VVErdFFLQWl4M2FjRFovRXp2UFdiTkFlcURZeEpmU1hwN2NaSklyVzVxZDhr?=
 =?utf-8?B?YWVrY0hNQThySEFkUHhjN3NTMmxCK2dGTkxiR1dFTzlqZzhrVEFPWHlUbkZq?=
 =?utf-8?B?MFpWSWZBdDRjeUcxTjZ3MUEyRTB3ejdXQ0kvbzV3NFZjNWhmZWViTm13N2tD?=
 =?utf-8?B?b3MzL1pzUVVyazFkdG5jcmMvcWtZalhOVit6STc3SUllR0VUbzZMbjd2c21q?=
 =?utf-8?B?emZqbjFXRFRBS3dvUS9FRWkwdUsxeVVBQm1uSFhpR00xWW5XYUd6eDBrRkJB?=
 =?utf-8?B?dytOZ28vYW1iY1R6cHVFU2s3RStnaERyeUxHQTN3NFc3NEE1T2xDN2FJNzl1?=
 =?utf-8?B?cEU3WGlFcHU1bk5hU1hxQ3d5bFpRV3UzWURIZFl3TWhhSTYvZmtmWTNTZnVi?=
 =?utf-8?B?b0Y1NGZHV1hSQnRTN1NxTWx0dFFSOS9JQms3WDFYRHBpbHRKUzh5eEV3S29y?=
 =?utf-8?B?VmtSVUVRaWY4VlArRllhTXlnYVdTQVhFNWhyeTltVm5QbHgwWXU1bEFsdHlO?=
 =?utf-8?B?V3JWYW9lQnhxbnIvTVBzLzJ5clZKV3Q1ZjZkbFhOMVFxRStiQmw5UDlRWmtG?=
 =?utf-8?B?NEwvRzhrV1BwRVdXQThTOVZHTjM5QTVjeDJoWHVkWlZjUUJHem9Ra0ZBVUdr?=
 =?utf-8?B?a3BnNjVMUGVCSUo0SW9JdmJ4L2t3c1NwUm9PbjVqaldtQzRtWmM5RmVuTFh5?=
 =?utf-8?B?eUN3TWx5QUFYSjFsUGFTelp4SWhOZWY3RkdITUxnSlh6MENiZDR1SjUyRm43?=
 =?utf-8?B?THJ0UnVTUVZRb0xiNHkzZkxmdXVBL1BIL0tGK3JlVzFTcXd4cGI3K05oVGk0?=
 =?utf-8?B?RVh4YmtTY0RRanRJRTVGTUFQcFcrendLVjk5VEpBeDdxbnVFeUdJR0YzYTNJ?=
 =?utf-8?B?aFFWUVo1cEx4OGIvcE11RFZqempHTll1THoxbW15TWtISUFhcERNSTQybUlP?=
 =?utf-8?B?d0k3cllucDVaMmY4RW15SGhFVnJJd3N1czF5V0p3VW9iT1ZwR01USElGSGJO?=
 =?utf-8?B?ck9lZFgyK3lXdkNKTWx2ZXVIVGY4Szl2bmJGOWtMRUh4cjYyZzFCNE5EQ1Vu?=
 =?utf-8?B?c1FuYTFpTlh4VXc0Qmk0WUVpc21jTzZLL3BoazJ5Rnl5aEJ6Nkpxa09NZkxx?=
 =?utf-8?B?YmlpU3JSYTV0ZDhWNGVrMUxxcFhIamFxNVlZZ3NVY2tmeE9KdkJPNjNUcVY4?=
 =?utf-8?B?MW1WQ1NKYitsTzVOckFxR0lNYjV4TFhjemVCR1J4RGFWMFdXNFFkd1pEMXh2?=
 =?utf-8?B?TGYrcGt1Sko0eTdyaldSQ3lDd2VGZndhemJNeU5GODMwd1d1bFJyenVHVDVC?=
 =?utf-8?B?ZzRlL1Jrc0duTzBmNzJRQ0owMjB6dFpoQzdlcExiN1liNS81NUZVZHptb3cz?=
 =?utf-8?B?Nm1GQ3l5NTh0ajlJOTRPUzRVbWlpWHA0R0R1N1d1ZW1UOXBsK2t3L0tCWGtE?=
 =?utf-8?Q?OshIzRTbYNs+aSrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0008E8CFF8E74499472F93D8EF1336B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6169.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0fde14-8059-451b-0249-08de5337a844
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 06:39:24.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ic6Fhzyrb55zk/M4W78mRWqeBpiecCfhuTWQV0sarPbJU4ai1O4p9pYP9liXYNLGug34x7IAzzmsqthimLU84cI3ctB9UKiJ3jNDX8ZQxwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8234
X-MTK: N

T24gVHVlLCAyMDI1LTExLTE4IGF0IDE3OjM5ICswODAwLCBKb2hubnktQ0MgQ2hhbmcgd3JvdGU6
DQo+IE9uIFRodSwgMjAyNS0xMS0xMyBhdCAxMDozOSArMDEwMCwgTHVrYXMgV3VubmVyIHdyb3Rl
Og0KPiA+IE9uIFRodSwgTm92IDEzLCAyMDI1IGF0IDA0OjQ0OjA2UE0gKzA4MDAsIEpvaG5ueSBD
aGFuZyB3cm90ZToNCj4gPiA+IE52aWRpYSBHQjEwIFBDSWUgaG9zdHMgd2lsbCBlbmNvdW50ZXIg
cHJvYmxlbSBvY2Nhc2lvbmFsbHkNCj4gPiA+IGFmdGVyIFNCUihzZWNvbmRhcnkgYnVzIHJlc2V0
KSBpcyBhcHBsaWVkLg0KPiA+IA0KPiA+IENvdWxkIHlvdSBlbGFib3JhdGUgd2hhdCBraW5kcyBv
ZiBwcm9ibGVtcyBvY2N1ciwgaG93IG9mdGVuIHRoZXkNCj4gPiBvY2N1ciwgZXRjPw0KPiANCj4g
VGhlcmUgaXMgYWJvdXQgMS8xMDAwIGNoYW5jZSB0aGF0IGFmdGVyIFNCUiBpcyBhcHBsaWVkLCBh
bnkgZnVydGhlcg0KPiBhY2Nlc3MgdmlhIHRoaXMgcm9vdCBwb3J0IHdpbGwgYmUgYmxvY2tlZCBh
bmQgbWFrZSBzeXN0ZW0gY3Jhc2guIA0KPiANCj4gVGhhbmtzLA0KPiANCj4gSm9obm55DQoNCkkg
d291bGQgbGlrZSB0byB1cGRhdGUgYmVsb3cgZGVzY3JpcHRpb24gdG8gcmVwbGFjZSBvcmlnaW5h
bCBjb21tZW50IGluDQp2MSBwYXRjaCwgaXMgdGhpcyBpbmZvcm1hdGlvbiBzdWZmaWNpZW50PyAN
Ci0tLS0tLS0tDQovKg0KICogQWZ0ZXIgU0JSKHNlY29uZGFyeSBidXMgcmVzZXQpIGlzIGFwcGxp
ZWQgb24gYW4gTnZpZGlhIEdCMTANCiAqIFBDSWUgcm9vdCBwb3J0LCB0aGVyZSBpcyAxLzEwMDAg
Y2hhbmNlIHRoYXQgZnVydGhlciByZXF1ZXN0cw0KICogdmlhIHRoaXMgcm9vdCBwb3J0IHdpbGwg
YmUgYmxvY2tlZCBhbmQgY2F1c2Ugc3lzdGVtIHVuc3RhYmxlLg0KICovDQotLS0tLS0tLQ0KDQo=

