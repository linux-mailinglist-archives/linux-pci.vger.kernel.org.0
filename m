Return-Path: <linux-pci+bounces-19498-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3815CA05370
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 07:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C609165F3C
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 06:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2811A840E;
	Wed,  8 Jan 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sdOF1rjR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="loN9cGwi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD21A83F9;
	Wed,  8 Jan 2025 06:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319250; cv=fail; b=JcPZQ05J9m6HCdzT+9a2C+vIci03K3SjvHfOx4bji6MlEjbwsRvAA7XayhjAu16oDLaUmCgOtrw8cqAHjjRvPkO0+buZExHKkRXMXpNxGomgHxNaMvVaozxWHFxmyVGI5xnLlty53kiBtoYs0vVpcKWAx+iL7vWIBpy7TtxxelA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319250; c=relaxed/simple;
	bh=88U/v9jyTVAr5poB5jZsPP4fqLfJ5a1n1chLj3HDJK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9LyIB2Swd7MZkEKXK8d8z9wAdif5yjVzUIFHCNTcENGXSDRK/Rdc6BlStcLYYARFX3vuDI+6ZszFBdus4rIBs7YBYMirst7Y5JhAqjxPm7QbahOxdZCn9mZK8dR/SyPSRQcAe1Wl7xxDgO2T2mX8kGG4fMywyqAJq8ixiUBSUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sdOF1rjR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=loN9cGwi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 56f6a534cd8d11efbd192953cf12861f-20250108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=88U/v9jyTVAr5poB5jZsPP4fqLfJ5a1n1chLj3HDJK4=;
	b=sdOF1rjRWByh5q7HW3gegd2tB5rZzVHp5vm+4tmy+o5h2yFCW6WqrHFxOBRnxqJUNVjuKSZIyuFkxvO2LJ8IZ4OPzAK/xfgeoDtdrky7CQY53otwIJVLLRA/iTwKL1qe08iLUh5OH/lUl4DFlY7h3B2JINXUHmBM9GnEM4vTBvc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:6ea426d3-05ce-43ab-8727-fac7fa8f856d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:792b8e0e-078a-483b-8929-714244d25c49,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 56f6a534cd8d11efbd192953cf12861f-20250108
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1963563710; Wed, 08 Jan 2025 14:54:00 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 8 Jan 2025 14:53:59 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 8 Jan 2025 14:53:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pHLCpUgV1VwSsztN817vnsh66ImFG0mCrIZt4i/wg3Iay7/veX7wknS/cnF2eGuPBOE4ewLEUT7Jy5hlS0zSfsS7yr1104I/3FcO4m1H2EuSfCsD/5fMM/dvXeYu7byJPcCpjtOQkSpIlTT51u0DQO/Pcd9dfq4xAUj8gzeTd8eS9RxZ5badb/FWHBzs8EnraOTaVSt/E/VpCKOH+0bTtInxHrgA3wedxBKSWJ/RJtMBrn5c5jhdJaVQEmMXs2LNPOu2w6rnGxkCX73BMXUCvoaSJIoYIHyZWkvU1oiPtI6coUPYbsADX5kLUwkSYPRyq06AXXehE7YD/EpSXqKc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88U/v9jyTVAr5poB5jZsPP4fqLfJ5a1n1chLj3HDJK4=;
 b=FXj5kH1dcMy+mzWkIrJFMiYMKEGjXs/j3Y0FUZTuCsmT90p9f6e3dgwvoByu8jGP7eaj8/LluiAzIBsueqA1Q1+srN3yn0nMywMfyy35KP0MDkmx+WJ8jC/kAEw+8HaR64aHrrZ7H8YhI1HJArb/+EBN3llewG1uQSbHxntDjzXvX/ZfzGMm0wYbXyAJ6Qd3y8CafDHsmsOTx0KDVaSXf0e5jSMxukcsJL8Hx+RfJdWcrqBtzrKPok5YSmKwIAjF38h198NXEmMFKTX35R2eMnzhQizR8RsXHDVPqHF9sBfIxlGM3HuhD6j4ot0DmkAGy79sSChcP2YOaUFCa8jX+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88U/v9jyTVAr5poB5jZsPP4fqLfJ5a1n1chLj3HDJK4=;
 b=loN9cGwiHbzaU1EK99FGMX/5kZeaipeF/Te+qmVkRrwSshIzaCjmiEC/kkYVxplAimGM/JHLriyWVFXxINLRq/vOMqRyAIfUavxV6aSH6gNZXEoWLsNg2oMeQZALMIUKEgnZPWrcQrTBfrm7+IE6tLm3inQiyiDWZrWr2Bod9Y8=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SG2PR03MB6827.apcprd03.prod.outlook.com (2603:1096:4:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Wed, 8 Jan
 2025 06:53:57 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Wed, 8 Jan 2025
 06:53:56 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "wenst@chromium.org" <wenst@chromium.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "krzk@kernel.org"
	<krzk@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, =?utf-8?B?WGF2aWVyIENoYW5nICjlvLXnjbvmlocp?=
	<Xavier.Chang@mediatek.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	Ryder Lee <Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Topic: [PATCH 1/5] dt-bindings: PCI: mediatek-gen3: Add MT8196 support
Thread-Index: AQHbXaTW76fSj2ANakexjY3C+uSV4rMEw32AgAS7TICAADKxgIABU9KAgAAFFwCAAW5+gA==
Date: Wed, 8 Jan 2025 06:53:56 +0000
Message-ID: <762388e2c344faef987f3a9136124918b4b2723f.camel@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
	 <20250103060035.30688-2-jianjun.wang@mediatek.com>
	 <ndj6j2mmylipr7mxg42f3lcwgx55cvcjnuuofmlk6n6t5uz5pr@bxugolyfublc>
	 <04ae2a07e2c2d3c03e82596034b1b7711450a0ae.camel@mediatek.com>
	 <eb2088d3-81f6-4cb8-a4d7-6ef985aedbda@kernel.org>
	 <9b0a463312702fb78e4ca2ba79c9ec6b62e33c58.camel@mediatek.com>
	 <CAGXv+5H5ymEem=JWF1J6dHr4B7o5cdOgvCSg0Q_5GVkx487Ksw@mail.gmail.com>
In-Reply-To: <CAGXv+5H5ymEem=JWF1J6dHr4B7o5cdOgvCSg0Q_5GVkx487Ksw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SG2PR03MB6827:EE_
x-ms-office365-filtering-correlation-id: 5c1cc9c6-42b9-42f0-45c7-08dd2fb13900
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WktDUEx3em1yWnp5S3E5RGR1cDY2MlNwckxDeFZqaDZXOWJPbDJKek9CZStF?=
 =?utf-8?B?dkhCeUxHRG9mdUV2QVBDNUFDUlQySnVTTkRHU3VZSmxPZGNBY3RpaXRyV3Q3?=
 =?utf-8?B?dTJvcnNLMlhuQ2hKQ3ZUcHBxMDFGQVRzSk5vcVo0ODhaRkJ3YlVQcVdldUNr?=
 =?utf-8?B?cmNyR0JycHA4MkpGSFMxSjVwVkZwYnJQY1k4TzkwbjNLU1dTRC80N253bGsx?=
 =?utf-8?B?Y0VwMkJvTkZVM0VxTzZOMUNMZUZEOGhsNjhLRGN2TlNLcVhFTitxaTFOWVZE?=
 =?utf-8?B?VGtEMmx0bElsWGtXQjhHY3UzbC92bFB4ZUdjSTBOV0l6cVlYT1R6YVk5UUFs?=
 =?utf-8?B?cFB4dVNtbk5BZURBKzd0Nnl4bklGTCtldU1URkxkdUpiTVVRRlQ4SlQ2ZzFn?=
 =?utf-8?B?K010eXh2NE53UFNBUk9BeUxLcTBHb3dzOC9sbGFqRTgybnhCSWFtbm01Y0Ir?=
 =?utf-8?B?SFBNNHBrY3VoTnpQdktQVklJZ2l2dERzQ2UzdmVhM29FL245SDR4UCtaUVVS?=
 =?utf-8?B?MHlmZ2xRVERPWEd4SWtpSTMxTm1ldUtsei9iWjZJVGFRRWNlbzhnN0p5TGFi?=
 =?utf-8?B?djd4OG5TL1JhY2JMRExuWVlNbHAxV01ITGJqRnZsM1pWVlBPYTVJYUc5ZzFS?=
 =?utf-8?B?RGkxb2RjMklSV3FpWjZ0ekhzV1JHL012RXJuTGkxd3BkeW9ydUY5Y21WWE5r?=
 =?utf-8?B?L2ZZSHBieXo5WFFFclhvd2RUaUo2aWx6UndzdHI2b3UrelRUcE54TWIxUGRT?=
 =?utf-8?B?UEczOTEyYmFiVGJlOVgwL24ydWZvU3pSTUtxZXVUS0daREJ3YjVIdDRCZkxV?=
 =?utf-8?B?WVBXMHVIc09vRkFDbXB3K1FrRXVZZC9uSUhIQmRQSHNZNDgzZE4xUE9WanZR?=
 =?utf-8?B?cWlzbTFKSE5kTWhNWkUyU0MyR1NoYWZWN0pSc3diVkZXazFBbG5hVGpZVXoy?=
 =?utf-8?B?RXFiS043OTh2SEczTTRaM2ZFL1FpaGV2RUYrRG1xYk9kNDZYSDhveGpQMWk5?=
 =?utf-8?B?SnppNW4yNEc3OE8wd0ZmZXNNRGtvL3BLUXVldEtOSnI0Z2tCY1FPV0FWNzB4?=
 =?utf-8?B?VStlT3dzQ2dmY2g1aitXOG5kSlUwSkhVajQyRC9GRWhYYzBzZ3o0QVk3M2lq?=
 =?utf-8?B?RWRSZnFidmVvUnNzRUYrejhuV2pTbDUwSUlpR0ZYQnZ1YU1HK0VqVTVBSGpl?=
 =?utf-8?B?b1Q2VDNXWEFoSkVFemdDVVhBdGlCOGlTWnRvNVBjRXREeTJyWEZ2OUIzcm5B?=
 =?utf-8?B?bUFYMkkyc0xpVmRHWktIOXNmTjd5eE41SzdleFRkVUgwSnVReTJWQkdadE92?=
 =?utf-8?B?RFJURkk5YUVsN05HRFFpRTg2ZHB3eTZheVFNRG91cmVHSis5S0pIRGFsZjB0?=
 =?utf-8?B?bFJXbzRSQ1RaQmtCYVQwZ2lJQnRLamlTakVFRGhTaXJmSVJ3VVBleHo0NTlJ?=
 =?utf-8?B?emhhaExXbmszZ1NKdUdVYy9VcGhzeW56TkduTUFuY0VMeDJOd212VHkraXZZ?=
 =?utf-8?B?VU0yK2YxVjZGaWpPWG5RVHc4azh4SHZBTUJ3RSthYmxhdUxvM0VNcVFzNHRq?=
 =?utf-8?B?ekFMYkFkUFI2TzY0aWlIWHN6WHF3N2VqT2VJaWcvOTlsYmZaZTVkWWs2bTVC?=
 =?utf-8?B?eEc2bGxNdzB3Wng1MVhBL2o0YXVnTnR2OE5mL0JkSnlDN28yY3pyVzNZSEty?=
 =?utf-8?B?Mk5SZEkvOUdnSGJxWG92MFh5bHlIbWlrZzI4Rk92dkx1aTJlN1FRK0NIM0V6?=
 =?utf-8?B?M2hBQXdjcXJ4NnNQQjNvYUx5d3NwTmRDa2haV05ybkI2WGZQOFlRUnd0SnFB?=
 =?utf-8?B?aWxCZUd3Z0xNTXlGZWRLVG1BYUFVamVpOGlGZHIxYkpaQkVhNlFnVGxNaVhN?=
 =?utf-8?B?cU9qc3gvSmJGa244VkRVK0RQSi8vVVBQN1R0VndEcUp1d3l5UjNtYytjaXY4?=
 =?utf-8?Q?7q/BWTusbL2f8f6h/YsJs/KJZQmNGReV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHh2TG1DbzhYVDl6TnlVVFQ0Umd2VGV2YmJ4RWxLWFQrSjAzaDVXTkpyQnB5?=
 =?utf-8?B?bDBLYVJjSVRMWGhQWXJBQ3k4YUZwaGt5L2M4eTdyb2hOT0tHVVN0aGlHallG?=
 =?utf-8?B?VTQ5L2ZXZWRJSlNjTk9mTnY3cUlvL1R2dWZGaUZkUFRzV2tic2lLOXFHQ2hM?=
 =?utf-8?B?My93TmFQaFYvV0pPSnNSL1pUL2c1dFlmVU1DUGliZi9LbE1NbHY0Q0J4SWcv?=
 =?utf-8?B?Q1E1Mm83TUhSMmtuTFNHbkhnQnNnejJLV052UXl4S2hBZ0VXMmVLZUg1RWJ5?=
 =?utf-8?B?aTQ5MXIrdGF5Vm9CSmNGNE9OMDY3UEtSNFFTY2dhT3VJb3FNVG9VcEtWaHlU?=
 =?utf-8?B?dFdkMHVxYVduUHdONkxZaXpHNm1NQXBmZHUwVkFNUDVySUt5cG9uUXY2RlNY?=
 =?utf-8?B?VHlGdXZCdHpGZW0ybGVPalVVNldBQmFHWXNINEttSEphVmFVbmx3Skd2ZlhT?=
 =?utf-8?B?UTloRXdnTHRUV0g1dlRQMWxUcVlLUmdXR2RacDBuRDF4TjZWVUVqclNGYzg4?=
 =?utf-8?B?Unprcy83M21JV08xeFR3eHJpeUJnOWoycmlEbDR2TW5QR1lDeUoybHZ5a3dO?=
 =?utf-8?B?Z0w1NTh2RVFFNytPWHZ2UGJyd2kwaFQwR1ZxSE40SU96KzNpT3ZJbm44bVQ4?=
 =?utf-8?B?NkFFMVgydEFZVzlnQjdjMVRDOUlrcXZ1Um9uenpLUi9QaE56aHVPYTE0ejFr?=
 =?utf-8?B?TUNZOHV6UWhyNzdFWmxxVlpCNVFlKzBuZG9jMWlmM3V5Q2Rld2d1UEJmL2ph?=
 =?utf-8?B?azFoRVhEeGRVWHM5SUVZTnFUb2JhdmlMNWxNUVZ3TnJSNElZUVFNbFd5RU1V?=
 =?utf-8?B?MGxMQXFXVy84eWpwbzlNMk12WUV1K1dYdDRIMmZ0bWptcEVsUC9RWENnZ2Zt?=
 =?utf-8?B?SVVGd3NmRmFDVGE5OGdFaU9rWHcyZUZ0ZVNsMmhRYnp4THd2dWNCczRFRFZq?=
 =?utf-8?B?RkdneG9pZmVhVUxnMUxLWkZQbmxxY09YTHY0Q29RL01qcW5CUDgvZ0UydEUw?=
 =?utf-8?B?ZHgyWVBPNU5xMnRzNytpVzhHb0pYcnozZmtUd1QrNTA3ZENWOE9IaDIydGVY?=
 =?utf-8?B?UG1PK3BNWk5OSVY3Mkg3cmNMTzV4d3VHTEU0WkpXNW96L3MzeTFOc0RETDBQ?=
 =?utf-8?B?dlNuRTdGWHBUdE55WE1zaXFHeHBnVzFSaWhQT2xDdU9HbDJYRzc3bjQrYWpM?=
 =?utf-8?B?azhoR0IwUC9PSzRUU0dTeFluVUZubkw3enVFcGxiTktnL1cxVUprOGhNU212?=
 =?utf-8?B?UE9KaXpaU2NrQ1Q2RVBZQnFrRlRkTTdmUnNaR0VidzQxM3owUnBseVZmKzB1?=
 =?utf-8?B?OXlRaFJNUHlyaWRWZFBhTXhQVzE0Sk0ybVJXUkp0a3plZ3pycFg2QVFKN1Rh?=
 =?utf-8?B?S25ud0VlTnQrb3V3ZHhVOU9nUkpsRVlJWnNlZWF2STVkNU9HUXRzSmdoTzBv?=
 =?utf-8?B?QzdxaEtUanR6K1V6UFphZStCb25jZ0FvZkdhL2xnRWZZck84Ykk2alUzQWNm?=
 =?utf-8?B?bTRIVTZRMjJtUHc2S0QvcGNBaUxXTm9oK1d6djVrNWJ3dTRNZEVKS0ZOd3RH?=
 =?utf-8?B?MS9kTnE2M1IzamJrS3d2dTVxMkNSQ3lDcEZIc3d6QmN5WEVJZVJmMUhtbFpT?=
 =?utf-8?B?d3Rac1lQcm1ORXg0RDdVUHZHY2RDeUk2WGJNa3A2STBIZFdiZlplaDB3b3BF?=
 =?utf-8?B?WUEvOGlGVXl0ajQ3NG5BMGxxQ2g5NWQ5M1hKVUpyS21ZNTlhT3MwZ20wVUFl?=
 =?utf-8?B?ZEJDQmlUbnhMTlRzMGV0MHczTFdOTnh2WGh3ZjdCR2J1cmRtalJzWnVsRndJ?=
 =?utf-8?B?VDNGUURTSCtVRGcvMnIrUWNHWktXWm1uSnNMTFRvWGFqWlhuNE9obDMwazhE?=
 =?utf-8?B?SFlreGFRSzJCcFY2SmE0QWFQMmw5UitBTHRtMktCcWFHWjcwek80TDR4MFo3?=
 =?utf-8?B?aGFFSGZKWlYzRFBXZHpITUVLcFR6TXRjaUkwYy9iU2dTQTArVHNhcHRhT0Nq?=
 =?utf-8?B?dzhkR1VpdkdZeWxIbnVwak45M2s2dGxDVkhIdEZSbExleTF4aHo4TnhJN1VY?=
 =?utf-8?B?T0JybG5SSkpldXpTeXI5YTB2QmJLUVJ4OEFaRlFlV0cxSG54anZlajBpNHVt?=
 =?utf-8?B?eTVVeTkwaEpaQ1NXQ0hjTXpESWdnblF1elQrNFRjNUtvcnR5OXVFMWZab0JL?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <915E79614CF1B046A0142D7090F53A97@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1cc9c6-42b9-42f0-45c7-08dd2fb13900
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 06:53:56.8025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rrpj8YAky22sniSlE6+Ma+asv68ST9YU2jZol8a5LBGQWtqEPUecDHCVHP1LRyb8+WBVqtEyGBtXqdUwrhxNL1M1TxjwrTSeKZ6zx7cWNps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6827

T24gVHVlLCAyMDI1LTAxLTA3IGF0IDE3OjAyICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gT24gVHVlLCBKYW4gNywgMjAyNSBhdCA0OjQ14oCvUE0gSmlhbmp1biBX
YW5nICjnjovlu7rlhpspDQo+IDxKaWFuanVuLldhbmdAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4g
PiANCj4gPiBPbiBNb24sIDIwMjUtMDEtMDYgYXQgMTM6MjcgKzAxMDAsIEtyenlzenRvZiBLb3ps
b3dza2kgd3JvdGU6DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZl
cmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4g
T24gMDYvMDEvMjAyNSAxMDoyNiwgSmlhbmp1biBXYW5nICjnjovlu7rlhpspIHdyb3RlOg0KPiA+
ID4gPiBPbiBGcmksIDIwMjUtMDEtMDMgYXQgMTA6MTAgKzAxMDAsIEtyenlzenRvZiBLb3psb3dz
a2kgd3JvdGU6DQo+ID4gPiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNr
IGxpbmtzIG9yIG9wZW4NCj4gPiA+ID4gPiBhdHRhY2htZW50cw0KPiA+ID4gPiA+IHVudGlsDQo+
ID4gPiA+ID4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBPbiBGcmksIEphbiAwMywgMjAyNSBhdCAw
MjowMDoxMVBNICswODAwLCBKaWFuanVuIFdhbmcgd3JvdGU6DQo+ID4gPiA+ID4gPiArICAgICAg
ICBjbG9jay1uYW1lczoNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgaXRlbXM6DQo+ID4gPiA+ID4g
PiArICAgICAgICAgICAgLSBjb25zdDogcGxfMjUwbQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAg
IC0gY29uc3Q6IHRsXzI2bQ0KPiA+ID4gPiA+ID4gKyAgICAgICAgICAgIC0gY29uc3Q6IHBlcmlf
MjZtDQo+ID4gPiA+ID4gPiArICAgICAgICAgICAgLSBjb25zdDogcGVyaV9tZW0NCj4gPiA+ID4g
PiA+ICsgICAgICAgICAgICAtIGNvbnN0OiBhaGJfYXBiDQo+ID4gPiA+ID4gPiArICAgICAgICAg
ICAgLSBjb25zdDogbG93X3Bvd2VyDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAgICAg
ICByZXNldHM6DQo+ID4gPiA+ID4gPiArICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gPiA+ID4g
PiArICAgICAgICAgIG1heEl0ZW1zOiAyDQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArICAg
ICAgICByZXNldC1uYW1lczoNCj4gPiA+ID4gPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDENCj4g
PiA+ID4gPiA+ICsgICAgICAgICAgbWF4SXRlbXM6IDINCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBX
aHkgcmVzZXRzIGFyZSBmbGV4aWJsZT8NCj4gPiA+ID4gDQo+ID4gPiA+IFRoZXJlIGFyZSB0d28g
cmVzZXRzLCBvbmUgZm9yIE1BQyBhbmQgYW5vdGhlciBmb3IgUEhZLCBzb21lDQo+ID4gPiA+IHBs
YXRmb3Jtcw0KPiA+ID4gPiBtYXkgb25seSB1c2Ugb25lIG9mIHRoZW0uDQo+ID4gPiANCj4gPiA+
IEV2ZW4gbW9yZSBxdWVzdGlvbnMuIFdoYXQgZG9lcyBpdCBtZWFuIHVzZT8gSXMgaXQgdGhlcmUg
b3IgaXMgaXQNCj4gPiA+IG5vdD8NCj4gPiANCj4gPiBJdCB3aWxsIGJlIHVzZWQgYnkgY2FsbGlu
ZyB0aGUgcmVzZXQgY29udHJvbGxlcidzIEFQSXMgaW4gdGhlIFBDSWUNCj4gPiBjb250cm9sbGVy
IGRyaXZlci4gSWRlYWxseSwgaXQgc2hvdWxkIGJlIGRlLWFzc2VydGVkIGJlZm9yZSBQQ0llDQo+
ID4gaW5pdGlhbGl6YXRpb24gYW5kIHNob3VsZCBiZSBhc3NlcnRlZCBpZiBQQ0llIHBvd2VycyBk
b3duIG9yIHRoZQ0KPiA+IGRyaXZlcg0KPiA+IGlzIHJlbW92ZWQuDQo+ID4gDQo+ID4gPiBQbGF0
Zm9ybSBsaWtlIFNvQz8gQnV0IHRoaXMgaXMgb25lIHNwZWNpZmljIFNvQywgaXQgY2Fubm90IGJl
DQo+ID4gPiB1c2VkIG9uDQo+ID4gPiBkaWZmZXJlbnQgU29DLg0KPiA+IA0KPiA+IFllcywgaXQg
c2hvdWxkIGJlIFNvQywgZWFjaCBTb0MgaGF2ZSBpdHMgb3duIHJlc2V0cywgYW5kIHRoZSBudW1i
ZXINCj4gPiBvZg0KPiA+IHJlc2V0cyBmb3IgZWFjaCBTb0MgaXMgZGVmaW5lZCBieSB0aGUgaGFy
ZHdhcmUgZGVzaWduLCBtb3N0IFNvQ3MNCj4gPiBzaG91bGQNCj4gPiBoYXZlIG9uZSByZXNldCBm
b3IgTUFDIGFuZCBvbmUgcmVzZXQgZm9yIFBIWS4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiANCj4g
PiA+ID4gV291bGQgeW91IHByZWZlciB0byBzZXQgdGhlIG51bWJlciBvZiByZXNldHMgdG8gYSBm
aXhlZCB2YWx1ZQ0KPiA+ID4gPiBmb3INCj4gPiA+ID4gc3BlY2lmaWMgcGxhdGZvcm1zPw0KPiA+
ID4gDQo+ID4gPiBFdmVyeXRoaW5nIHNob3VsZCBiZSBjb25zdHJhaW5lZCB0byBtYXRjaCBoYXJk
d2FyZS4NCj4gPiANCj4gPiBGb3IgTVQ4MTk2LCB0aGVyZSBhcmUgMiByZXNldHMuIFNob3VsZCBJ
IHVzZSBhIGZpeGVkIGl0ZW0gaW4gdGhpcw0KPiA+IGNhc2U/DQo+IA0KPiBZZXMuIEFzIHlvdSBz
YWlkLCBNVDgxOTYgaGFzIHR3byByZXNldHMsIHRoZXJlZm9yZSB0aGUgYmluZGluZyBzaG91bGQN
Cj4gc2F5IGl0IHJlcXVpcmVzIHR3byByZXNldHMuDQo+IA0KPiBTbyBpbiB0aGUgc2Vjb25kIHBh
cnQgd2hlcmUgaXQgbWF0Y2hlcyBhZ2FpbnN0IG10ODE5NiwgeW91IHNob3VsZA0KPiBoYXZlIG1p
bkl0ZW1zID0gbWF4SXRlbXMgPSAyLg0KDQpHb3QgaXQsIEknbGwgZml4IGl0IGluIHRoZSBuZXh0
IHZlcnNpb24uDQoNClRoYW5rcy4NCg0KPiANCj4gDQo+IENoZW5ZdQ0KPiANCj4gPiBUaGFua3Mu
DQo+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4gS3J6eXN6
dG9mDQo+ID4gPiANCg==

