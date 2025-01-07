Return-Path: <linux-pci+bounces-19369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3560A03568
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BFDF3A698C
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D09180BFF;
	Tue,  7 Jan 2025 02:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kEb7N13v";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="efy98Kya"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFA96F30C;
	Tue,  7 Jan 2025 02:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217890; cv=fail; b=dM0yKXrNKnV2J5nciVPLyqv2RzDFx2eL+tT6DcTOKHQ4/7dOSoxlR6DUPBzhOe+RvGJ/I+1mfsTX8SCvspL+6F90/3H5dBPvftK4L47LAoyuYrPIl75/xIhrX/Upb/jFiYSMYXrHsjA+m042NLpHVhC976DD677PHC9aeQ8Q+mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217890; c=relaxed/simple;
	bh=C6dD0zL1Q8Z8g7tuIo3IhBM3HWOkYF0xW8dzUrTxna0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ug1i4Y+9nOiBATr2w5SXMqxGGuzQHf+H6kaUlp71DcBrQ8aThJrOie2vC1FG9NyEiujZFp1BJcGYqzp1xvnYDHGz5Te2093clY4jvc4TLf7WjoCXpEJhIMAJXjvNIsYGxwIGdHarE/lfddtRpPwTd8aCdo2cEXQ8hoNg57zlngk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kEb7N13v; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=efy98Kya; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 57d93c92cca111efbd192953cf12861f-20250107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=C6dD0zL1Q8Z8g7tuIo3IhBM3HWOkYF0xW8dzUrTxna0=;
	b=kEb7N13vHFWuhdTzRByMyc3Y/McXXNuc5aNbqu+j52lidyhke3NRnYb0RRM2FrDp7w11TqkjAiElLyhBBN1vRrbNw5AV3l+EvsgNbNtN3hB3tsJ6UPQBi0HhL3JFFgf7Fn78MYDJ4JUQ0HT+/9BTwfQMSadciNjNfM1zTvRErsk=;
X-CID-CACHE: Type:Local,Time:202501071019+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:b5723b58-c11d-44da-9d19-849c7a68749a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:42dfc049-1563-4a46-85ba-7ddee3d98b2a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 57d93c92cca111efbd192953cf12861f-20250107
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 850654446; Tue, 07 Jan 2025 10:44:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Jan 2025 10:44:39 +0800
Received: from HK2PR02CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Jan 2025 10:44:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agisZtpnD0LjehwirqGLxx1372rRkpjKmNoYAORZ56QOB4qXGZ7CqUMPvMVpj1X9o8n4aKETBYOui1RjBey8+6tWJoQtnaECDajU2J32krspjhw0NUqBXJEK4RLN+KsxJQLc9HcYvo9a/psuXpqO4rCkNBOz1Vd6RL1sENB0ayLqsuFyAHeh7Voxy7Y/i3YTkR3tlDus3Xv6GS//VfI+pdoJ4hgq3RwcojDt+HYkTxRtoTxwEeRo3divpHxuEzlSbXIPa++AnQBm9nbVXA6gHiSFpRaBTd414rut3qmgNrfy9KLTTHDACYUw3bdlO6roUzHf5PYq1KNCZSX0+HnM4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6dD0zL1Q8Z8g7tuIo3IhBM3HWOkYF0xW8dzUrTxna0=;
 b=aRQxP5ReRFPjXxG2RV4KqbXNFHYW6/gCH1iT45YXyYp4lgB8/fVanmBUb7r+ko1nnqoOdjLLE3Zb1+G4JdGl9XB13LSP9Uy2L1WVZd0Unh1bJY5ncEP2kn79AaxPM4WPmoqziepHDgw4YLv+fhB8ibhtYE3sDdjvATG+exrow/SET1cMfzMoNXWpSmQ1jHArm01Bw/zKgpTNFQgciBCj1WWNgMyajcgnyNw6R1wrCfHjTJrscRzqzXjXiupaMq2L0FZU4stnn+rJs9Kctj8pVSSJOwxfWZIoZMJUWsdeSLARbkuy9h3L21xIL4hxY9O3gOE5v5G3byqhCMRf8Hj7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6dD0zL1Q8Z8g7tuIo3IhBM3HWOkYF0xW8dzUrTxna0=;
 b=efy98KyaVeQAuAqNp/U4dmx6ooK9dvcBk1OMeFF3FSjGyggpGZ3meFM/m3d3Yok02Pil8u6r0pzm1kB7X/gLcDZXaT1QpYg+Cn7/Q3Hmjjn2k9S9NPpRXI3/e9J88+H0M038MNZjfUjvHclw8sG6KOEkzWIhZCKlpDG0zTbndgk=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TY0PR03MB6656.apcprd03.prod.outlook.com (2603:1096:400:212::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 02:44:37 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 02:44:37 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "helgaas@kernel.org" <helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?= <Xavier.Chang@mediatek.com>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Ryder Lee <Ryder.Lee@mediatek.com>
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Thread-Topic: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Thread-Index: AQHbXaTtsPsaxOpwnE+nEN+OpOAW7LMFbIUAgAU0YoA=
Date: Tue, 7 Jan 2025 02:44:37 +0000
Message-ID: <8b7b0d1bca5088bda46a651481b9a42f3be1a75d.camel@mediatek.com>
References: <20250103191552.GA4190763@bhelgaas>
In-Reply-To: <20250103191552.GA4190763@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TY0PR03MB6656:EE_
x-ms-office365-filtering-correlation-id: 5be677e5-b4c7-4cbd-6aad-08dd2ec539e8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVNXbEhPYkZSQ01INWhweklxWlp1eXN6ZUpoMk9oL2pMT2JBZk16STNOa1J1?=
 =?utf-8?B?K0x6ODJHK09QdUd1M3ZPRUFFcGpnV1lGWkozVXZ3MUhSRTRIb3VvZlRzMUZo?=
 =?utf-8?B?bE1wSlkxU0ZwYzlJZ1R2T0c4ckpMSXptZmxxRjN5VjVmV25kTmhpbG52ejk4?=
 =?utf-8?B?OFV3M1c2Tm9YRjQ3bGNBY1RocGVraWNoL2hndkZ1NCtVdjJHZlF1MGIzeUpB?=
 =?utf-8?B?bmNKTFlhcUgrS1RzWk9hc0xCelNxR3AwRmRmNkFWaFQzK0h5UThrWFJFZGNK?=
 =?utf-8?B?RVgrMUxKem5UdnVtYkVRMlVndFdhc005cm9jQWcwN1RKbFZ0T3BmTDRZT0dC?=
 =?utf-8?B?NDZYMmM2a3J0Y2ttT1pLdjN1a0NrK0ZNRmg4YWZkVzdCZE9qMTFnbnhEVEhB?=
 =?utf-8?B?bS9kTmRWcklBckJsZWxDR1N3NmxRdzAyMW9lVjJBN3hvY3ZyODFsVEEzRzh4?=
 =?utf-8?B?dzJTekxuVzlnNVVtb1JndTc2OTQwZEowZ0VZU2V6SFErZnhVZ0sxMHZodk41?=
 =?utf-8?B?L1ZLL1cyUEFONERkNHMxS2JaZDBGN0JxN3R5MnZYcmlnbENzMStFeitjd2NM?=
 =?utf-8?B?WlMyeDc1cUtTUEF1TEJHL2FEOFA2M2Y4eDFJV2hEMjdKR3gvaHJOK0JyLzNS?=
 =?utf-8?B?R2duZGM5UmkrY2tzeEx5RUhvUi9NSFFyZW9KUXBuUWVrV3lSNnhnaWRZRzIy?=
 =?utf-8?B?VjdmUm5EZURDMHZpM3Z6OW1TbXhXb0JIYVNuaHdLQXoyRVFGQXhrRnpJSGRw?=
 =?utf-8?B?V2txbVdXSlV5eXF4QnNLTmNkS01UdFNvRFg4ODdoY1F3d1JjbDlVOG5RQWxk?=
 =?utf-8?B?ajdEdjRBRWpCQWhua2F0UU5sRVl5R1p3WDlKekVIR3daTE5qZ05MamQ2Q3pO?=
 =?utf-8?B?eTBheXViYzNMWTE4UTBMbjhWTHhNWTRJTC9EeC9JNHMvNE4ycW5aaWI4N3dU?=
 =?utf-8?B?RGdYMXJpQ1Noa2NaSWNLWDRZWUdzZmlEQnk2TTdFUmRFUGF1eVRxWEk4L0dh?=
 =?utf-8?B?ZU9QcXFXZDV6M0R0QnowSDBVSkR4NEVEWUpRSjRFNUZZY0lkNXc4UTgxSEs4?=
 =?utf-8?B?cy9YekZLNEVXbzB6MHJCNHNjZUI2V2ErYlVXWW1CRHo5RVg0aldTL0J3RGp5?=
 =?utf-8?B?M2tlVU4ybHJOZDhIWldDcTRYbE1IUXRBQ1JRSzlEYWZHQld2Z0FxMVVrZlMr?=
 =?utf-8?B?RjBReHNvWGNWYkhVcUJFVTFPTE9rZzkvUXVSMDVpRm5qSFF4dFlRRzRCWDIx?=
 =?utf-8?B?V1NXazFrSXVGQVY3Y21hNkluejhPQmhOVXZTRDhoaEUrUEs2bzR6aWhDQmtl?=
 =?utf-8?B?L0dwRlhJWGVYWFNIRDI5UGVkYzlKcGE3VDl2aEZscmN2N3F3dmxRZUp0c3F6?=
 =?utf-8?B?WmM4Wklva3NLVm1mUC9lNnNJMkJ5V3JEUmUwOGVWVWpxR1AyZ2VtZlVYdkgw?=
 =?utf-8?B?TmhvOXVoVWEyRzMxeEsyaUtJeDBxaEQxdWVrWmZ3clo5dlFTNjlyS05UTTlP?=
 =?utf-8?B?RGYzeDFPSTVpbExYbVUzTFcydHZvU3BWUWw2eXJHaUttNFJ4QUhRWFAvNTNo?=
 =?utf-8?B?djI2ZmovbjFVNGpJQjB0alJkWHVKNUUwaW9uc0tWclJueGZ2ZHgyQ2tGZGhB?=
 =?utf-8?B?SFE2WVA1ZjdycjR1anBmdmQyNS9HcHNaS2hOQkR3d0hoSzRNSjluVmk3VjJ2?=
 =?utf-8?B?VUJ3aTB1V0Z6Ri9abG1iYkVMUkVwS0dXbDhPU1UvN2Y1Q0lqWi8zTjgvYWE0?=
 =?utf-8?B?MVg0cXpHTGhCMkhhOVFoMW92TUtRSnVER1ZTMzhBSXRienNPcVNJVTZ0dVFL?=
 =?utf-8?B?TzBLbjFzdDVkdEdYb1ZrQkV3QzJWYndHeDhOT0xCRTl2ckZDaXRzNVZqMmRE?=
 =?utf-8?B?QVdxRmpjRHZLYW9INUROUjloaXNBNFFNRk9CNEg0d0NZVTNZR1c1TjBTYysy?=
 =?utf-8?Q?poV7r1uUHKW3itxDS+3GUwS0eGLXwGMR?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWxRZzJZSEhBVGhnK0JKb3Vqa3pRVVYzWkptL3grYThIcEc2ZHY1TUx5ZnhH?=
 =?utf-8?B?TW0rNzNETGYrWlpPUEh1WHJTQU9XS3JNdzJ6QnYrWHI4OFlPSkVZbWpKNlNV?=
 =?utf-8?B?RTVYdVVRQk9mT2kzR1JPVlEyZnhJbzZzRUJjS2pNQmhXZlNsUEZ2YTRHM2hw?=
 =?utf-8?B?ZDYwYWlyYkhmSFVTczhNajZzYUhCRUhwSUF4L0tlRjg1QjRSdTJHY01YcjIv?=
 =?utf-8?B?QU40eUZyMjdWVWxFeVYrd3VOdm95YTViYndSSkU2eDFqdVBoRnAreXdlaDdF?=
 =?utf-8?B?dnVoOTkrMVJib05IUm91Q24xa09mWElhdG9HQnJ1QTJlRmFIWkpYRE1TZG5W?=
 =?utf-8?B?a05BWVZQbExZZFlqNVdXRTlrRk1DRURBbXcxSEVkczR5Z0YyMkdZdTNpaXRv?=
 =?utf-8?B?R2NkNC81b0NyN0pjYkZxa2o0V3c4Y3VMU1Mva3ZXaGVZcGVBNGZsYWxJaEFt?=
 =?utf-8?B?YWJOQ2FQZTNFTTVQbjdMc3AyWjdOWUQ0L3dnR3U1QzV0YVZlU1lEbXNyKzhW?=
 =?utf-8?B?dlA0OHlvUkFPVHhQdjUwNHVycDUrSnJKM2paKzRHdkMwMURnelJrdFczOXZS?=
 =?utf-8?B?S2tWanlxWFMyWWlud1U5cFA5MUswNlFVaThXaVhMcjQvRXdWSGdhNXZaWEFt?=
 =?utf-8?B?S0VtcStXYlp0SHpxVEtaQlVQS2ZTVHAvMXI2U21OMDQ5RHZucmhzSlprd0V2?=
 =?utf-8?B?OWRXVXhjaGdES1UwVkNoUkRqd0ZuNnBQQUJ6M2hxR1NMcmtubWZxZGkxL2NS?=
 =?utf-8?B?TEhUampmZW5LSG5XS0pZeWxIUjVQL2x3TStFTkVmd2FGemlTbElEU1JPRXRu?=
 =?utf-8?B?MCtUTHNPYnMrb25zUWFNSzNWdlpQaHZoZ1pEM3dQVW52YjdzUDltUmt5ZVpL?=
 =?utf-8?B?T0cydThrZm5ic0VnbnZXbWpvQ2N3MjZjQWZtNm9OVHY3ZlZVMlE1NzRWbURP?=
 =?utf-8?B?T2E0TXJXS0JoVFpqSEVPdDJrc2FId2FMakFLNzNrU1JYdVI4OTRNMDNpM01k?=
 =?utf-8?B?L2FMcUVGWU1hVmlVQjh3aGF5Y1RMUkxhTG42VjUrSDlyRUhHQWtKZUx3d0ZI?=
 =?utf-8?B?NVVWRG9hRFkzWlpYbHdnN0l5Qld5TlNrcHdwd2FteVNHRVhsNkF4NUxJYndP?=
 =?utf-8?B?elppR1dYak1jZzVud0txQ1loa3lwaTVEL010TG93bHI0dmdkRTgvZ0VqYys0?=
 =?utf-8?B?UTdMMjlValNSUGRqYU9wMlJKd0pOVTR1cXBTVml1WnJqSWo4TkErNzdyOFY4?=
 =?utf-8?B?WXRORmYvOVFTMlV6akpMOWdYUUF6MDczbVZoazdteExzNXY5Z3JSOG9lRXFi?=
 =?utf-8?B?K2ExZHpFMUdkWFdVTjVzcmYxczFSR0FCSTBSODVlTXhKUFNNLzZyK1lHclRN?=
 =?utf-8?B?V1NBbmRMZGNhY3ZoSGVUaHJtcTExTFFMTmgwbk5RVzNGSlU5ZVZoR3lhcGlM?=
 =?utf-8?B?OTBNdmpDZDdnMEJPSGJFSzVlc05JYzFWNGJzVy84enA2R3JqNHVad3hScmtn?=
 =?utf-8?B?V2hMSzFteG5JVzRXK2dVdXF0Z0JsWmY2N2lFaEFtbzNCZEk2L3pqcnY3bFY4?=
 =?utf-8?B?WjJnZzl5NlJNL1VGTTBvVWRCeFV3ZzlmZUc1dmpNNmRsMi9MaEpVYTJOT2VQ?=
 =?utf-8?B?aFgxdlVPaExmOVpjMUdJSTJ1bWlYMG5HR3VaYkNBekVBcmNjWjNsTDY3VkRO?=
 =?utf-8?B?ZjNnTlpLMEdmQXVVMGpPUzJDQ2FPeHdFZUY4WmlaVU5tMU04U2JKWUExZTVP?=
 =?utf-8?B?R08zM2NmZEJscTVzNGI4WlRVMCttV3pqUVJkKzAvR3RBRGdYTHdUUHpFZEZn?=
 =?utf-8?B?L1k4ZGthTzlLQVhTdFUvRFNERGNKdUpyenFLR3dTMy8xdnhMK1ZtaXJ6U0px?=
 =?utf-8?B?TnRVTms2RmtVcUgybFVxNVZMVTdGQllEQ2M4MUxVNHVsL3dVYkQzTjdMTDlT?=
 =?utf-8?B?a2NZYXNKK0p1QUM1RjZja0JEaFFjbnhXS1NubEpFcHBoNE44dGJoSmFSMmMy?=
 =?utf-8?B?ZllBYnVZdlF0V0NJNmFUOEEwY0w3Yko3Q3ZqRVZuazZCWHBOVWhvNFhROUhj?=
 =?utf-8?B?ZWhPU2RxRnIxSUVobGdBT1MzclRzaTR1S3BsWXNvQVRWc2VYRjYrRWhwZlR2?=
 =?utf-8?B?UHlXMTRzaTY4ZUtOYW5iL0hxRHVlNmdickxrVHFoVU1iSUNQWHpDU1p3ODFT?=
 =?utf-8?B?S3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AC0DDC6A456B8342967670355A0728C8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be677e5-b4c7-4cbd-6aad-08dd2ec539e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:44:37.1405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wWOl6Qj/PKZH7UcWRl387XYpvyv1gaAwSAIk6dCpNxCoRduvOJW+H2witGw17DE/wB7pS4iwThIBWu4WXihc/zwAnnyYlhBa5vZIcSQpx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6656

T24gRnJpLCAyMDI1LTAxLTAzIGF0IDEzOjE1IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRh
Y2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250
ZW50Lg0KPiANCj4gDQo+IE9uIEZyaSwgSmFuIDAzLCAyMDI1IGF0IDAyOjAwOjEzUE0gKzA4MDAs
IEppYW5qdW4gV2FuZyB3cm90ZToNCj4gPiBEaXNhYmxlIEFTUE0gTDBzIHN1cHBvcnQgYmVjYXVz
ZSBpdCBkb2VzIG5vdCBzaWduaWZpY2FudGx5IHNhdmUNCj4gPiBwb3dlcg0KPiA+IGJ1dCBpbXBh
Y3RzIHBlcmZvcm1hbmNlLg0KPiANCj4gVGhpcyBzZWVtcyBsaWtlIGEgdXNlci9hZG1pbmlzdHJh
dG9yIGRlY2lzaW9uLCBub3QgYSBkcml2ZXIgZGVjaXNpb24uDQo+IA0KPiBMMHMgcmVkdWNlcyBw
b3dlciBhdCB0aGUgY29zdCBvZiBwZXJmb3JtYW5jZSBmb3IgKmFsbCogUENJZSBkZXZpY2VzLA0K
PiBhbHRob3VnaCB0aGUgYWN0dWFsIG51bWJlcnMgbWF5IHZhcnkuDQoNCldlIGhhdmUgZW5jb3Vu
dGVyZWQgc29tZSBjb21wYXRpYmlsaXR5IGlzc3VlcyB3aGVuIGNvbm5lY3RlZCB3aXRoIHNvbWUN
ClBDSWUgRVBzLCB0aGVzZSBpc3N1ZXMgYXJlIHByb2JhYmlsaXN0aWMgYW5kIGRpc2FibGluZyB0
aGUgTDBzIGNhbiBmaXgNCnRoZW0uDQoNClVzZXJzIG1heSBub3QgYmUgYXdhcmUgb2YgdGhlc2Ug
aXNzdWVzLCBzbyBJIHRoaW5rIGRpc2FibGluZyBMMHMNCnRocm91Z2ggdGhlIGRyaXZlciBtaWdo
dCBiZSB0aGUgYmV0dGVyIHdheSwgc2luY2UgaXQgZG9lcyBub3QNCnNpZ25pZmljYW50bHkgc2F2
ZSBwb3dlciBhbmQgd2UgdXN1YWxseSB1c2UgTDFzcyBmb3IgcG93ZXItc2F2aW5nIHdoZW4NCnRo
ZSBsaW5rIGlzIGlkbGUuDQoNClRoYW5rcy4NCg==

