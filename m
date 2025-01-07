Return-Path: <linux-pci+bounces-19368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1100FA03503
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 03:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F2D7A0390
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 02:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3213E2744D;
	Tue,  7 Jan 2025 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="icED3EOT";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="UL3ftbMg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197682594A5;
	Tue,  7 Jan 2025 02:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736216347; cv=fail; b=Cht5GB8SjfzFy4M3vPSUWFVEoqBlrJbjRS9y17VwpP9Dk3vzdIvJRqj6JY94vDw7Kg6W5yu+0nImdYuwZJNvrj4LJ7bEr4H2ha6ajE3sHbfqn5QbAUQwuXMRacWoxxQjm0tJz6nM1aSIwWtbFRQU3F3gghVmUHbRCQOKb6ZgXXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736216347; c=relaxed/simple;
	bh=2vaHYN8/btQaERNs0LYw3Q8QYko0IKBJXDqUolT7r58=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sU6luyJC4g+wm9bp5D+MQW6lk+lxrxV8wOfHBOhlBQ0pfvRlhM1/S85O2gWf9WLoZqTHbY0CWZIURBg8tx4RVh9lqZ60lPWZ0wXni7vYX63WND9fO0DHebx55fGd6wQVNSFDEhj6yABkuMnXGf5B1Oh5wqfXKmDg3PMkok0tLh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=icED3EOT; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=UL3ftbMg; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c0ea9220cc9d11efbd192953cf12861f-20250107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=2vaHYN8/btQaERNs0LYw3Q8QYko0IKBJXDqUolT7r58=;
	b=icED3EOTsScoRx0jDWWZPhA9aEf/tMzm9yp5lslbLD8PWuYbpr7BWNi1cToMRXNj1gpRU3vMVCp8fAtRQIQL/7oYvNI3xIBZXslzMeUEcX/VGSgfyC+YLqYwFGAlqzbF9cgrLgLUlu5l9Q5zcnm6gcJtWrXjJoZeQsHKUdbfrZQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:81a047d0-fa79-48f6-b82e-56620c21ed0f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:42dfc049-1563-4a46-85ba-7ddee3d98b2a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|50,
	EDM:-3,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c0ea9220cc9d11efbd192953cf12861f-20250107
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1859861655; Tue, 07 Jan 2025 10:18:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 7 Jan 2025 10:18:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 7 Jan 2025 10:18:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sY8WC6vkEpL0329UKZPnJ918QMJFs5Ve9tkEzUvzTZV1MZwinavY235AUDsz4M1q8l/CccNXrv0iYLNwUlw7vgY8oD3tLm0rGFQSF0szFpf4q/5l5mPjSehdLF0bxbekNLs3atKh+RG40lvZ2eBbgVXKrJYA+oTUupgb2OzYsXQw0kKGMgq5WqPCWT9L21ySK1SkPBCw/DcqCC/RC97zirlnvowBxam9pT5kzs466sBf0DeocAJltj6AKzGRgnibA6AwKLOp/v59ladcHUF03R284uf9PnAwQA771ckzPNH8P1PZKFfseEeZOuMPzEsVcDnTRq4F1UEcBYK3Pew7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vaHYN8/btQaERNs0LYw3Q8QYko0IKBJXDqUolT7r58=;
 b=YjN/jCg7J75v89min64ASlNniL23f5pJ7UE28zlXOojImP5IB6N4+fbn9er9O6szYlpTB08SCdqGfAqO9XQxKIihLexj5ltYqUgtym5KKW4AG9yAlppUEr8zuOGYPywggkJCg2QiFvYwHIedr+BZrPoGRz/7z5w6T2ZrlkMvt/y8PDdtDPWgX+fJ2urTJIsNb61FEnbnwyGoYQxwlzebxJiyvJc+5J3Z1PG0fdEd1cEXW8dV5NJFidWCKAa5ZEbill3wVFG6JgB0WhuugMd4Mg7FYw28fcZS/phwUf8/Muk0KrGjtS4/oXg/YcMNs2NqnIkexxttii1IxFY8H+8DTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vaHYN8/btQaERNs0LYw3Q8QYko0IKBJXDqUolT7r58=;
 b=UL3ftbMgU6g1QuraTiG8FZ+Dzwd+dkEXxREtCbCjJS2sD0RotvCifmCKpjELFmECpUlrL6zdV8nr0JknyCy4sFw5rv3hoY1T9JSV1I1+KQt5nV556V5hbodH0sDLXWpzZONkvunq+n2JJEJ5JUwFdGlQsGiM/QJ6oBVjO3qbWCY=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by TYZPR03MB6694.apcprd03.prod.outlook.com (2603:1096:400:1f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Tue, 7 Jan
 2025 02:18:56 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%3]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 02:18:55 +0000
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
Subject: Re: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Thread-Topic: [PATCH 3/5] PCI: mediatek-gen3: Disable ASPM L0s
Thread-Index: AQHbXaTtsPsaxOpwnE+nEN+OpOAW7LMExS+AgAXUjwA=
Date: Tue, 7 Jan 2025 02:18:55 +0000
Message-ID: <cecd7ebf0ccac9638b8e93b28fcf4df5bb81a794.camel@mediatek.com>
References: <20250103060035.30688-1-jianjun.wang@mediatek.com>
	 <20250103060035.30688-4-jianjun.wang@mediatek.com>
	 <b5ef9501-e07d-4150-9518-dd982518919e@collabora.com>
In-Reply-To: <b5ef9501-e07d-4150-9518-dd982518919e@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|TYZPR03MB6694:EE_
x-ms-office365-filtering-correlation-id: bd9decbb-25b1-46ab-4dc9-08dd2ec1a341
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0lOaFhzVmloWlpnMEo1amFidUlzZzlyTUxXK0t1SmpSYmpWZmF3SGhUakF4?=
 =?utf-8?B?WnlJK3Jzb0U5WStlUWtFeUxmaHJNVzBpYWVzdkhhZU13cGhGSFRybDVQMUJS?=
 =?utf-8?B?TzM5cTRHYlVqbmtYaWNYYVpSN2dRekVTUFdKUzFWVklXU2h6OG1ncnQ5TDAw?=
 =?utf-8?B?cnRqckZZaTh4OC85NVduU0Y2NDhQTXBBWk1MbW1iWlBvWG5XS1pGYjRFbGh3?=
 =?utf-8?B?cEdLUmNNTEJaVDg0cjVYczRUOGJ5eDJBc2E0T0dLajI0d0hzTTI5VVZZeUZs?=
 =?utf-8?B?TjlnQ29FL3R4eGhVTnVhZWh6TzJmYUVVRHUzTmUvL0hkMjgwWFhuT1ZvTlZB?=
 =?utf-8?B?MmIzQmlvdnNNU1dtWWtVMHVrUkJZaGRGd1FHOW1IWkhqS005dVNVVzBzTHZE?=
 =?utf-8?B?Uy8yNEgvRUh2cWlFN3dGbmxDSHc5UUo3dXFXcXJwQVZHNlZwMUIvYU1NWEo2?=
 =?utf-8?B?ZGp0QjNUK05udUk1cEg3MFVSajZYMzVOL2J0MENLWEk5dXBHOHFISUwyOTJo?=
 =?utf-8?B?VVRFZVlscGptZ3ZjM3BwZU1VeDNyMTB1RlR2TThtem1CSlBBMlEzMnVKcTc2?=
 =?utf-8?B?bVFLRmh6eS96WlVaMnAzempaV2dQT3czS0dLRzk0S2ZzZTBmTEgxZzFEZzBP?=
 =?utf-8?B?Ymc0U1FGcGswU21KbWlGN1VaSVBNR3F4Kytid0pUWlUwSVR4K3NrenUwb3Y4?=
 =?utf-8?B?Z0NnYWcyMzNkbExaS2h0b1NRZFJFYXpXTnVYMUhLMEZBR1hBRkRoQW9JUjFE?=
 =?utf-8?B?Y3lJS1JVQk1HanNMaDlGc3pCSlowNkFFK0lnZlZsaTBEcStlZ0U0dUlUeHdX?=
 =?utf-8?B?WWZ2VmFqdDFiZ2l5aTVKRkN0NG5DaS9LeCtUTmVhbE1tN2RMQjJSYVlaNEQy?=
 =?utf-8?B?NlJLbmxaSzRQaVNoNlJRK2R2ME9kKzcxR0gzMWxZanI1bFdjY3BMQ3gxbk02?=
 =?utf-8?B?dXdTSzdNZ1M4RzRTK1RQQXNpNzlWN1hpaFF1V0NNRTFKK0MzWlNxKzVrdEZo?=
 =?utf-8?B?NWZIY1hySUtWbHRJdCtxaCtkcmdXUm14b3k1SnNnUzFmWm9pWWQ5Y2FYcC9M?=
 =?utf-8?B?S0N4OEhMN3BDVW1pMWVXU1JDckorTFQyRDd2dytHaktMaDkybiticTFyZ0Js?=
 =?utf-8?B?bXd6TEZKZ2FxVGM5Yml5REt2d1ZOc2xyc3ltQzEvNlpzRVJ4a2VZTTZHTFZB?=
 =?utf-8?B?UnViWU1OcnFWN0RCdjdPQlRwMEFwZzFTcnlHS2U2VXJPcXNYS09JRTZjTk5R?=
 =?utf-8?B?dTNMaFFrWEc0Sk94ZFozb2FGMFlmNGpDalFRK1FiTEFFcmd0Y3F0ZlI1a1ZE?=
 =?utf-8?B?aFpmeXRVUlJUY2cxaVg4U2g5QWRhanV5NEVOWW1sK1hrUG80UzNvZWRPR1dT?=
 =?utf-8?B?cWpjd0d2Q1JKTEZ6QThZd3B2WUtHbEZTc0hHOVQ0dkhHR3JHeXhNRlVKVUhz?=
 =?utf-8?B?MUJRYVBZVVQrQm1BdGhFKzdyblBOQzNIUFlvbmdHTVVjL3J4UVRVcFpJSW42?=
 =?utf-8?B?azQxWGxFOWFDR2VlbWZ2VGRKdXNOWkZ6elhEaEgvTUp5VHN4dDRGM1lqWnNq?=
 =?utf-8?B?b3FEV0IrWXJadVFuRmhsdWlCWDFmN29pMFNvcWMvR2o3dnRSTyswK2RuY1pn?=
 =?utf-8?B?TG1iNkthdjVSejhjV1NrZWJNVkhrekFRelY3ekM0dzI3M0dmN0dyWnBDVU5l?=
 =?utf-8?B?eU1rSzUxWjNFQVNhOGxadEdyWVpJVC9HQTZYZHdSKzZNdi9JbzJLeWlsVEUz?=
 =?utf-8?B?dFBKVUlMaDZXcUYvMk9EcHA4SXdhcWNORWpSS1hhdTJmUlA2U1FQVzRjTnJm?=
 =?utf-8?B?QnlEM1ZZMVRhZ2FoblRvSnhjZHBsVXhEWGNYOU11dkc2YmtkN0hDUXgwMUpI?=
 =?utf-8?B?Rzg3b3J1bFBFYThqYVBZN255Zkh3bXdXK3IzaEY1UXVhanNZbXRoSi95eWJs?=
 =?utf-8?Q?9bIa4rZ2Jmoj0l/NkKolc2S6IvTf3ImL?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFV6NEhueTJ6V3EzM1ZvbjQ1N1ZIdFZzUm1kK0x2SzJibzR2NER2c0p4SHVr?=
 =?utf-8?B?VTQxN3RON0xVOWkxaFV4OVZGZFlyMm1aYndrdHhaZUlTYXM3VTFjcTZxd1A2?=
 =?utf-8?B?TFBFdjB2QjV3QjZtS0tBYUFQeFlCZXFkNml4by82Z2dHVjYyTjJYRnRRcnNH?=
 =?utf-8?B?Qm1ydlpiMUE4UDdZclNaWTE1S1N1TVJTNCtwVlhNNTJQM2xFVVJLU1AxVGVm?=
 =?utf-8?B?Z2pVb0FBUkFzT2xzN0JmTzYxcHVqZVJOYUo4Q1ZZc29zZGFLMEJQREM4WGYw?=
 =?utf-8?B?RE9xM0kxZlFLcXQzOE0xK2x3UFc5dVAzTnAvWFhTcWFmQ3Z2WURnNjZ3NGpm?=
 =?utf-8?B?NjduTmRldHpyK3gzVnhraks4Y2hFOEpFY1VNZURIY0M4a2wyMVZzYWo3SVVy?=
 =?utf-8?B?RWdlQllWVXFaY1pHOVJ4R2FMb0Nsc1VIeU9KSDZOaEtaeDBoMjNyVkloYmlj?=
 =?utf-8?B?SVRqNm9BOHc1TzJYZllQWFRmVE9pN2R0MHMyRmZCeGRRWGZvOGd5SUNVTmFo?=
 =?utf-8?B?U1ZXTXBGMDNtQUJ4YmRleHlqOG5wUmxRYldFRFp5YkRYWElmSThRdEN2OXhH?=
 =?utf-8?B?THd3bkxtbnVzT0JLWUtOR0hoazQwdUt4bkZ4MEYxTlEvdHprMGdUSE5ucWlM?=
 =?utf-8?B?bDVSTnVFSzFqbmluUGhLY3VGbURsZzQxdUY5OUg3SU1EVFRLZTJXVWJMVHRo?=
 =?utf-8?B?bkJ2cXJUWlN6YnVsVk9yZkJBaDE4QjlkYkdIYmwxbXJtQ25OcXREVDBSSmhL?=
 =?utf-8?B?SXdWQWt6a3pLZzRLL1BjaUNuRE84aHF4eHN2QVZRQ0piSnM4OVZmSVhmOVVp?=
 =?utf-8?B?TksrSkhETWhINmxLWDFKb2JRYjlnWU1ZcjR4Y2xmSDBwVi9aQ0VjQ25haUpz?=
 =?utf-8?B?dWZmUWlnUkVSR2dmWkNRK2JxVSt4SGk2VEVPWGh1WkVGNUhldTNkQUtaVEdp?=
 =?utf-8?B?MFkwbUxiZlBISmhCM1lKWVN0Wm9YWXd6cnRTZmpNUmZDQW8xNXUveGlQTytR?=
 =?utf-8?B?NDBzcVR4NVhtWE02elJFVnBUT1I2NmlUdDJPQk1iTzNob29scmJnM05nWldn?=
 =?utf-8?B?bHRnU2tQcDJDRjNhaDNuZnhaRmhsY0VsQ2hTQzdINUZ6N0J5eGY1M3ZQV0hr?=
 =?utf-8?B?bGorekRhZlFIYXhJNGVtVE1lQ1hXbGJ6Nk1oTmJLaWlsTkJFMG1aOUFSRWFD?=
 =?utf-8?B?VndkK3d0WlAvSHZBWVVRa2dTV2UwcGxjUDY5NGZ6UE1JcGxPSjVISnNIbXI3?=
 =?utf-8?B?b0Rxc2l4OEl1VE1XRDdxUzNoQWRzNDNBQXZMU1BoWStpMklKaURJTkpZUVVK?=
 =?utf-8?B?N0s0aFpCTzBGZEFyNHFHOXk4Z1ZiTS9wamxzU3duMVgyclZTSGU3aTBLb0No?=
 =?utf-8?B?b2JQRnN5anFWMURFZ0RzZmgydFQxUWEyMExWMEhQWGhrSDJ2YVp4RUxvb1dn?=
 =?utf-8?B?YjAxTzZtOUpsTWFJUThGalhXalNTTTF5NXZaOUlTdG1JQXhMbjc0RmZCTWN5?=
 =?utf-8?B?VUJIbGpsMWdCZ1dTam9ZVjQvaXdpR3gzVVNKZWM3NFFqcTFLNlJTTHZmSEVR?=
 =?utf-8?B?KzMzWTZ4aW02VVNvZlBTSXNscngvajJpVWRzUWNsM0Q3OVIrYis2ZW1RaU1r?=
 =?utf-8?B?dkQwMUZKZDFlZytmelRFY1JPUGtja0xDQzlLVTZxNzNUTklySThYeUVIbExv?=
 =?utf-8?B?aFUxeGxjUjczK2xtUW0wazFZZVJwUGVlK2k1czBlNURNZ3kzb2FOK1dKOHd5?=
 =?utf-8?B?eTNaeTJHR2M2U3BWYmRvZ0U1OE94bXVtcUNabmZpcjlZcDFVUGVMYXFHbFpz?=
 =?utf-8?B?ak5OMFRrLzFYNWJhdWV3YWs3aXlRYUYzbUpkUHFhNEZScDJiYTZPbnRWeWlv?=
 =?utf-8?B?NHJuNk9ZeE5DaFV1VG9jU1BDbnJRVW9ua2dCZVdIUTR0MElPOWtOLzJ4VjQ4?=
 =?utf-8?B?T01yaHdJbHUwZmFsQjNSd0JIWWNYeHNLR3ZjNWcyZWxDaExYRTFtTG5xeWNl?=
 =?utf-8?B?akJXaHF0SkR4NkhsSE13bU9kVzVzck5NMmtrWUhtcDlkWnNBMXFBT0hSblov?=
 =?utf-8?B?YmM1aVZ4N3ZUdGJpOGh4U295dFUwbjE4THVkb28zL0QwTmNIdmZUNzhycFRn?=
 =?utf-8?B?dlk3cTJRRWYrUjczY2ZKOUsySU4vRWV3VXFoc20xSktocnRoOWlKU0w4Z2tv?=
 =?utf-8?B?aFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5F890C475FD4E4B896AC60830B7A99B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9decbb-25b1-46ab-4dc9-08dd2ec1a341
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 02:18:55.8551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7lDkwaa71ej7Rqn47rVVlTqC+fhK9xf5GUEMF5Crot4o3+LYoI7dtnhbTOAdKnJUh0gKVRHipNVx9NC/ZbptUgisyQWvOv3nnuZcPbrreOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6694

T24gRnJpLCAyMDI1LTAxLTAzIGF0IDEwOjE2ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBJbCAwMy8wMS8yNSAwNzowMCwgSmlhbmp1biBX
YW5nIGhhIHNjcml0dG86DQo+ID4gRGlzYWJsZSBBU1BNIEwwcyBzdXBwb3J0IGJlY2F1c2UgaXQg
ZG9lcyBub3Qgc2lnbmlmaWNhbnRseSBzYXZlDQo+ID4gcG93ZXINCj4gPiBidXQgaW1wYWN0cyBw
ZXJmb3JtYW5jZS4NCj4gPiANCj4gDQo+IFRoYXQgbWF5IGJlIGEgZ29vZCBpZGVhIGJ1dCwgd2l0
aG91dCBudW1iZXJzIHRvIHN1cHBvcnQgeW91cg0KPiBzdGF0ZW1lbnQsIGl0J3MgYSBiaXQNCj4g
ZGlmZmljdWx0IHRvIHNheS4NCj4gDQo+IEhvdyBtdWNoIHBvd2VyIGRvZXMgQVNQTSBMMHMgc2F2
ZSBvbiBNZWRpYVRlayBTb0NzLCBpbiBtaWNyb3dhdHRzPw0KPiBIb3cgaXMgdGhlIHBlcmZvcm1h
bmNlIGltcGFjdGVkLCBhbmQgb24gd2hpY2ggc3BlY2lmaWMgZGV2aWNlKHMpIG9uDQo+IHRoZSBQ
Q0llIGJ1cz8NCg0KSXQncyBoYXJkIHRvIHRlbGwgdGhlIGV4YWN0IG51bWJlciBiZWNhdXNlIGl0
IGlzIGRpZmZpY3VsdCB0byBtZWFzdXJlLA0KYW5kIHRoZSBudW1iZXIgb2YgZW50cmllcyBpbnRv
IHRoZSBMMHMgc3RhdGUgbWF5IHZhcnkgZXZlbiBpbiB0aGUgc2FtZQ0KdGVzdCBzY2VuYXJpby4N
Cg0KSG93ZXZlciwgd2UgaGF2ZSBlbmNvdW50ZXJlZCBzb21lIGNvbXBhdGliaWxpdHkgaXNzdWVz
IHdoZW4gY29ubmVjdGVkDQp3aXRoIHNvbWUgUENJZSBFUHMsIGFuZCBkaXNhYmxpbmcgdGhlIEww
cyBjYW4gZml4IGl0LiBJIHRoaW5rIGRpc2FibGluZw0KTDBzIG1pZ2h0IGJlIHRoZSBiZXR0ZXIg
d2F5LCBzaW5jZSB3ZSB1c3VhbGx5IHVzZSBMMXNzIGZvciBwb3dlci1zYXZpbmcgDQp3aGVuIHRo
ZSBsaW5rIGlzIGlkbGUuDQoNClRoYW5rcy4NCg0KPiANCj4gQ2hlZXJzLA0KPiBBbmdlbG8NCj4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdAbWVkaWF0ZWsu
Y29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVr
LWdlbjMuYyB8IDExICsrKysrKysrKysrDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVk
aWF0ZWstZ2VuMy5jDQo+ID4gaW5kZXggZWQzYzA2MTQ0ODZjLi40YmQzYjM5ZWViZTIgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
PiBAQCAtODQsNiArODQsOSBAQA0KPiA+ICAgI2RlZmluZSBQQ0lFX01TSV9TRVRfRU5BQkxFX1JF
RyAgICAgICAgICAgICAweDE5MA0KPiA+ICAgI2RlZmluZSBQQ0lFX01TSV9TRVRfRU5BQkxFICAg
ICAgICAgR0VOTUFTSyhQQ0lFX01TSV9TRVRfTlVNIC0gMSwNCj4gPiAwKQ0KPiA+IA0KPiA+ICsj
ZGVmaW5lIFBDSUVfTE9XX1BPV0VSX0NUUkxfUkVHICAgICAgICAgICAgICAweDE5NA0KPiA+ICsj
ZGVmaW5lIFBDSUVfRk9SQ0VfRElTX0wwUyAgICAgICAgICAgQklUKDgpDQo+ID4gKw0KPiA+ICAg
I2RlZmluZSBQQ0lFX1BJUEU0X1BJRThfUkVHICAgICAgICAgMHgzMzgNCj4gPiAgICNkZWZpbmUg
UENJRV9LX0ZJTkVUVU5FX01BWCAgICAgICAgIEdFTk1BU0soNSwgMCkNCj4gPiAgICNkZWZpbmUg
UENJRV9LX0ZJTkVUVU5FX0VSUiAgICAgICAgIEdFTk1BU0soNywgNikNCj4gPiBAQCAtNDU4LDYg
KzQ2MSwxNCBAQCBzdGF0aWMgaW50IG10a19wY2llX3N0YXJ0dXBfcG9ydChzdHJ1Y3QNCj4gPiBt
dGtfZ2VuM19wY2llICpwY2llKQ0KPiA+ICAgICAgIHZhbCAmPSB+UENJRV9JTlRYX0VOQUJMRTsN
Cj4gPiAgICAgICB3cml0ZWxfcmVsYXhlZCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX0lOVF9FTkFC
TEVfUkVHKTsNCj4gPiANCj4gPiArICAgICAvKg0KPiA+ICsgICAgICAqIERpc2FibGUgTDBzIHN1
cHBvcnQgYmVjYXVzZSBpdCBkb2VzIG5vdCBzaWduaWZpY2FudGx5IHNhdmUNCj4gPiBwb3dlcg0K
PiA+ICsgICAgICAqIGJ1dCBpbXBhY3RzIHBlcmZvcm1hbmNlLg0KPiA+ICsgICAgICAqLw0KPiA+
ICsgICAgIHZhbCA9IHJlYWRsX3JlbGF4ZWQocGNpZS0+YmFzZSArIFBDSUVfTE9XX1BPV0VSX0NU
UkxfUkVHKTsNCj4gPiArICAgICB2YWwgfD0gUENJRV9GT1JDRV9ESVNfTDBTOw0KPiA+ICsgICAg
IHdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfTE9XX1BPV0VSX0NUUkxfUkVH
KTsNCj4gPiArDQo+ID4gICAgICAgLyogRGlzYWJsZSBEVkZTUkMgdm9sdGFnZSByZXF1ZXN0ICov
DQo+ID4gICAgICAgdmFsID0gcmVhZGxfcmVsYXhlZChwY2llLT5iYXNlICsgUENJRV9NSVNDX0NU
UkxfUkVHKTsNCj4gPiAgICAgICB2YWwgfD0gUENJRV9ESVNBQkxFX0RWRlNSQ19WTFRfUkVROw0K
PiANCj4gDQo=

