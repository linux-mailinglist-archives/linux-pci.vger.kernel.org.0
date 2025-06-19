Return-Path: <linux-pci+bounces-30145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A31ADFBEA
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 05:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845623BBF83
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 03:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28192634;
	Thu, 19 Jun 2025 03:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VpMlInn9"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013002.outbound.protection.outlook.com [40.107.159.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9527224AF9;
	Thu, 19 Jun 2025 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750304361; cv=fail; b=uvG0jhryhq+iEidmsOwZOxht+zm4DD225GCYyNw3PAbAkeW/BVoku+sT9rduQK3HGrDyW2gl2p+C6UmQnf+vjSIGtHh22S7yIoz7ngc2CaPkIPw5S8GKsNRCNT5Pcq/6zzf9vOSddet+7xcRc6uktiXvQF8oF7l/zw50k4bzQTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750304361; c=relaxed/simple;
	bh=SgVNvot0oRe29A/JFdktHAlEv+hXbYV+NL/r9kFabd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdYR2P3XnfgCwV/MewOJ15UL8HHGEWjKM+1wdhgKwcdqTPdd7RM0gRDLD/jyt5qS6SbDqTtWVzQXI2BJSfk4f9rCmvqRcKi+00RQn5nDFd80jPmnJzSWAU3dkPor2L55W93+0OiEbMDh0K3tJNFr7RTF2Oor6WEjzKbPLLW7i4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VpMlInn9; arc=fail smtp.client-ip=40.107.159.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aHOj7lCK345JwP5cKBzytKR4KtCL+ntDmqcW1U+0Lo0Lq9dzeai2zIUppmjEr4ooSADAoZlJa4pgm6KNMVFT4gkXXn0j1NL0UaFsI6BCLY3beU+PjsgKfJLVMp2badxwyDx0Z6BYIyjOrH28sjQkVfsbFd/YTv24errILOqwBfGnw6q6voHJnh3BPmSdYChBIwdHOCKyAf0v+omqZ8WKg3duRs1SsjSoBNWPk+U5eoInm2VvxaBMdh0WBcIJJOWuiIaDCm4PIX24IljR1ykCIJWimvbMP74EB8uBjhbdlpa8/SFOPvaT5zGb4G1i3mCQuNezsquRsCJID8zuSwq4Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SgVNvot0oRe29A/JFdktHAlEv+hXbYV+NL/r9kFabd0=;
 b=KScPfOBhg2aksf+hlgk8ntGrwliG+n9Zlvv2Jfc4N1nQLTd1LymNhzLDCZyT3tNqFyAUxbjTFEmZSxfAiFrz4u+JkwmThHMtfRaqx7dPhdxqD/Rn91GTRHg8VXEM7v7OlIfEJcxUlaHtKr6FrFeZYOBmCh9r37AZEOF+GIYxtpmzFdtw9LQ+CuaDOXBlp6uuh28ENkDje3KvgAbZA7Y0Qff0H1GZg9Hh7SIGXVozX53/SiUbarEdci2ggo0QNoU0DOVt4kzTg8M1yxXbtJ4SCe+y6TOash2WihZWnwPRSBjJjk4Ae/wu2X/E8La6WkSUeD6h/DkWs9xv1+afo09DsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SgVNvot0oRe29A/JFdktHAlEv+hXbYV+NL/r9kFabd0=;
 b=VpMlInn9nI7fxoLQRpJoFOvBIMpfn3wSn9NaYNAVF7dwprph4VispDpS0CX5LZFiDM92eBh8Vfm4vtpGPd/4T7NIU/smv5LsGv8hmtCB51smr8KCZZQHGpiY9928tabMDyCXRv/9t1IP0rH6DzRFvYgZovwLg9smo8Q6J4mC6XmNj/jtccSmOay7FMM7d2VItEf4G0w5CvZjlEoYmapc1/sVca0Bo++ya/5YkFnd3+cpa2TuNDJKecS6unjiai5M+4Gytp1+6RlwnDT99cpF89BvcTlgdZBrh4mR58O8ESPVSJaOgP9xXBydXutaun7mYXXTdugiKyFe3o9f0iwoOQ==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM6PR04MB11265.eurprd04.prod.outlook.com (2603:10a6:20b:6d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 03:39:15 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 03:39:15 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <frank.li@nxp.com>,
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] dt-binding: pci-imx6: Add external reference clock
 mode support
Thread-Topic: [PATCH v1 1/2] dt-binding: pci-imx6: Add external reference
 clock mode support
Thread-Index: AQHb4CWwCvzCL+C9yUG66r0KH9mCgbQI7awAgADnkWA=
Date: Thu, 19 Jun 2025 03:39:15 +0000
Message-ID:
 <AS8PR04MB86765037AB641C982FBF720A8C7DA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250618074848.3898532-1-hongxing.zhu@nxp.com>
 <5da5c462-704f-4868-90b7-824e68ec11e9@kernel.org>
In-Reply-To: <5da5c462-704f-4868-90b7-824e68ec11e9@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM6PR04MB11265:EE_
x-ms-office365-filtering-correlation-id: 5d23450b-c13c-4218-ea66-08ddaee2dd07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzNvUzBJUURoeWE4SjF4YnRVT1lpK3VVY2RqQnh6MWtjbTFsQzI3K3pESjl4?=
 =?utf-8?B?ekxjVzA2K05RQ0EzbTdMQW9oWEdJRndnL1N1cVFWTWJTMGp0SmwvYkJNQnlV?=
 =?utf-8?B?eDQrV0JUOE9Gc29uU3Rza0x3SUtxeXZQWUNjdzBPUklNOSt2RHBYRzY1bFkw?=
 =?utf-8?B?OFhsSzhnMml6RCtadUxpQ3JTM1lDekxkV2RHczBkTEtHb2djZ3o5bXI2cnhm?=
 =?utf-8?B?bnZKNHRkd1NRcEVxWnZkKy83L3ZjMVFmRGJiSWtQK3RiNmhnQks4Y2VyQklK?=
 =?utf-8?B?RUlvSkRQOHZzd3kzY2k0cC9lb2ZHTmtmQXZ1RVNFc0pTUzQ2dURUaENmdnVq?=
 =?utf-8?B?RzZjdWQxV0VRSU5HK2hwdjlIb25tQUF6Z0VJSjNaeEw3NUJQd1lHQXhpT3Jo?=
 =?utf-8?B?NnNWYThUaHNMZzdmWWNUR2VoSEg5UmtQSE8yTjE1WWZlMWU1M2FlNjVBZ1dD?=
 =?utf-8?B?Tys0SllMTVB4L3BKMlRrWHNuUmgvdzhtVWFSWkxva3JpUWlWM05INU1VaDVG?=
 =?utf-8?B?aE9kSjdnb3VyWUZxT2JTQWJFK2JsTzc2VlpuWUZEcDhQa3BQSysvWFBBZFJ6?=
 =?utf-8?B?Qi82Z1krSTliQmFxd0lFOHZ2ejhFVUpmZk5pL2FFeUdZY3B4L3FJY0pCOW5X?=
 =?utf-8?B?QUkrZ3VyYjhMbFBxYmN5eFRyd0htemtwVFViVFhGSmRodmRXZktQVS81dzND?=
 =?utf-8?B?YWFkZzdVY2huVGwrWkx6Sm83NWZpa1VXb2J4VjFCLzFuUWhGdllPT0hQVGY0?=
 =?utf-8?B?QlQ2SFRSZktQbDlhSVhucUx4eXJCNWlFWTV6SWNWUGhBVGpvNFFneWk4cmRj?=
 =?utf-8?B?azJCR0hyK1BYbW5ROVVndXB2Mzg3UEtPaS90YlZ3Y3BwNlJPYThCcE83dVFJ?=
 =?utf-8?B?ZWsxRjBRVHVublRZTWNubXBSMEVxeVI4ZFFNbjRhc2RQZVdLZVBQaUZCcVBW?=
 =?utf-8?B?M0FIN0ZSeSswMkJFemtWSUNXNmtpblliVG15bmsxVW4vK0hHaDVIYlpTTGFJ?=
 =?utf-8?B?bkszNHpOb1QvMm1SYjZiRjF5WmpFU1N6RUZEOHdLVDYrSDUySDQxRElNdUVS?=
 =?utf-8?B?dUNNMm0vbFk0TktYT2hTaEptVHJtWHdWczhVZHhGOFN2ZlpRVUVHOUI0enpR?=
 =?utf-8?B?WVBJZjlzNjZwWWpTLzZ6WUI4NTdQeElHNkh0T0RNNzlPUFRId0gza0t0QnNj?=
 =?utf-8?B?cUlJaTBJcEdZVDg5c0ZrRnkrczErQU4wd2U2R0gvbGNOVFI1M2V0NDVmeFFi?=
 =?utf-8?B?OU5ybVdicDcweUdwVGpJaVJuU3A5VEw4L1lwanpqOFQ2N3hwdGgwNzhVQWxj?=
 =?utf-8?B?SzV6eEpCVFByckIzajZlamRocFB6NlVKWFd0V2pEYnNORkxvUXpsdEtVcFdL?=
 =?utf-8?B?VzEzSG40dk1Pa3pPck5sNWZqT0daVHpMZHNYbTkwaWJCdDN6L2g1bjFIamhS?=
 =?utf-8?B?Z3VzdThFdE9hKzJQY1duV2w2UDJEU2hpVEZaVmFYNVhZUGJCTWdaUUZ6MXJU?=
 =?utf-8?B?MHJydWkrano0ZGs2OUkzZFdTbmJhTWFQdlZhUG5ZKzNkS2V1NC83c2pBY2xl?=
 =?utf-8?B?bmRNRnlYRldFVmMvNTExN2xUcktJY0t6OEtCTGtGL0F4eExaWEJnMk9NMDZv?=
 =?utf-8?B?VHdxWGxBcU9wYThBSmRuWCtPWnlhK0ZzNlYzQUd0MkZXanV5MzZmQWJIeEJW?=
 =?utf-8?B?NTMxbFllSFFWQzlZeVovcW95ekRMdTZKKzJOR3dsZUIzeVlEbFZMWjZ3aXJW?=
 =?utf-8?B?QVhZOXk5VlozNTIvR3UxN2IzbGNyZmtsdEoxcm5UMnRUWlBJdmlYZ09MTTJz?=
 =?utf-8?B?aDBrUTZ6VXlvWHdnL0VmKzNUaEdFNVlQMUsyeFZrTXhlVUQ4emdjY2lSMXlw?=
 =?utf-8?B?YkM1Z0FZcmtzd0xPb0Q4ZlRQVkY1OWNwcmI2bmlxd3RrWk1Gak8yNk5yMnkr?=
 =?utf-8?B?c3RHcGU4ZUt2Ym4xMVFMbklycERUcXF4OG5MOGxYdkdSQ0orMlpaZzQ5TVcy?=
 =?utf-8?Q?85thqsV6ube0h+vmA9BewixQVPAle0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnZVWWxUMjIzSWpMNElIMkJFbUs1QzRrK1NncG9saHFObkRJcS94bUlXQXhN?=
 =?utf-8?B?aCs0SGVHc3oxekZ3d3J6ZHpXS2hDTThnNFRSK0oxYXM0M1NHZWNJWTlzeW5K?=
 =?utf-8?B?TS9lalBkOW1oeFlldEFqT3BFVjdxaVFJeWJOUzEvQUszd3NXUjl0eEsvdUtM?=
 =?utf-8?B?TUJsRkNxRU1JTTJQMnJiMHN4SWdFYlNFR2lRUUY1ZlhwUmh2c2VCekxkeXFI?=
 =?utf-8?B?NEdaczJtdFlNaTZnTmpMbXYwdGZWaUx4b01ZMWtubHRndHNLUStHUE9pVTZo?=
 =?utf-8?B?T0JwbWNuNlpaa2RGNW02NGV2M2Z0WnByMlFJazVvOUF3aktkZDRuNVgvLzN0?=
 =?utf-8?B?WjI2MitYYVY1c2hhZlFoVDdYZWpOakRlenlURUx6YXNqM1R2UVdJb1NQR3JQ?=
 =?utf-8?B?Tmd1WkhyclA1Sjk4bEpDNE51WTJtMUJoUDVsYS9QampvM1BwNm8vMk1PQ2Rv?=
 =?utf-8?B?SFVJMnVKMityMUIyNDRWTWY4aXlsTmRIQnVDV0RoZDZlcHBpOXJSR3NidG1z?=
 =?utf-8?B?WW5RQnViK3ZMT2pRTjE2TjJFR3R3QXFqcnlSS1BHNjBiSmlXMmM2eXAvQ2N3?=
 =?utf-8?B?NDZMdGk5aGJnalNPdEhKWlJ4eTRNU3d0dkpvbi8rQ09zRXBIczdyRCs4M3RG?=
 =?utf-8?B?Mm54K0xMWHo2aFp5QU9HWUlMdlRHaVRmN016NzdsdG5Qb0pueC9nNTRKTGVZ?=
 =?utf-8?B?TVl4WWFpUUN3ZldvNzhTZjA5ekN0SnBXQi9qUXZYckRmQUd4dWorN1dneGli?=
 =?utf-8?B?N0NhL1RBd3RMdFlGaWpxYnJkYm5vcjZtcEhwbnRKZmU1dVU4K011dlRTN3R6?=
 =?utf-8?B?Z1FPTXU2TEl4OHlLN2xUSU96QmxlY2Q4dnRpUm4vd0ZkVVpvQk1WcE1WV296?=
 =?utf-8?B?aGptZEFLTExnQXNzUjZLZ2pGTGhVb05oWGR0dkJGUnl6NUFGckdjYnQzRlFn?=
 =?utf-8?B?YXl4L29PMUUxTFF1clVhRk5FM0VPeVF2Wm9HSnFJN3pkemJkNzArNTZyNkNU?=
 =?utf-8?B?TGJSUGRNMEZIaEE1NGVhZ053dTVFVFNHN0NoODdhUXJTZW81NDlmSDI3Nnlk?=
 =?utf-8?B?OXVpR1RsWDVkMEczdFNDYUprVXFVSUdIOFpuWmFJbitja2NydU9ja3BPQlhG?=
 =?utf-8?B?RklTaStQbXpER3lFY2xjUHhuSzlQZEVwaHc1dE9qZ2VvNzY5OVNuTldDNElU?=
 =?utf-8?B?di9UUk15eE9pYjh1YWxTWWsyZU1IY0ZHSUdSVU1BcmhzRkhLdXN5K2xiN3pY?=
 =?utf-8?B?S2JlWEp0WjlwbnZyOFNoTFJrSGxOTVFPZ2hJQk90T3lNZDF4Ky9MTFhuRk05?=
 =?utf-8?B?VkpOYldSbmtETS94UU4yVTJKV3BQbGpVTWZrajg1QkFSZmVvdlB2SWxOTFhK?=
 =?utf-8?B?MFBNNnQ5SGZpb1JHOWpXN0VsYktxVXRJdWpnS0ZvYWhlV3k1M1ZmMnNHRVJj?=
 =?utf-8?B?TlVldEk1RlA0N3hjZnBNWFBQR2JGVHNaKzFNcy9nK3ppSXZqNU1CNzNVaXJr?=
 =?utf-8?B?MFBFZFpFSVl1ZmNySXdpNGhSMnNMMXVaSXVGd3dITlFzcWZEVkNSRUxVUGh1?=
 =?utf-8?B?UlFsQWFZdGN2dTFZY3ljSFV4dGM4OXBJc0NPbzJSU09JUmZpMHJWdldNRmFp?=
 =?utf-8?B?ZXN0QVRLSGFKR1lDczdXcmFxTDZTTEMrWVhONXhzMWorbVY2SW1FR2VJRStG?=
 =?utf-8?B?cTJTcUJ5blZTWlV6cGs1UDFKTmxFZndtZWhjZlp0aXNkSE1lY1ZnQ3dLZlRx?=
 =?utf-8?B?ZTd0THQ5bDNTcG5EZjRJN3FsVzMxenN4VTlPMkJOMG1qRkwyNk1LNmVpOWRI?=
 =?utf-8?B?NzhRYkw0YUdma0tyemNSVEFIQnluNGNuZDQ2TEtjQS9LK0srM1RLeEdzcXpa?=
 =?utf-8?B?dm1Od2NTYUI1NFh3N0I2VEk3UjREQnBNWFY2ZmxwTG9LNlVTUm1lU0tuVWVw?=
 =?utf-8?B?MnZ0T3N1c2F2NDVBQXZnV2VmVHVKTTJndkluQzVqZzZUL25rLzNKWEVhVjB2?=
 =?utf-8?B?UnVKWmFPekMrdUJwSlZVYmE1OUZaV0Q2TElNSTF0aGc0aHhmeXdNbjYyZzJZ?=
 =?utf-8?B?TkpYS2t2TmllNm9Nek40VmVVK21XTlBpTG40M2pyWHJ3aWZtT2krMXNBQzRq?=
 =?utf-8?Q?xEg9DuLXcbo/I5ciydphlonFI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d23450b-c13c-4218-ea66-08ddaee2dd07
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 03:39:15.0583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iH+vuU04i30cJfqqNJF9rUVkVBs7lecJ314GP3FrcNCjbFzXQqgl1Tm4ogzT7yEpcd03cFd4bxekQAY59vFzww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB11265

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXlubQ25pyIMTjml6UgMjE6NDQNCj4gVG86
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBGcmFuayBMaSA8ZnJhbmsubGlA
bnhwLmNvbT47DQo+IGwuc3RhY2hAcGVuZ3V0cm9uaXguZGU7IGxwaWVyYWxpc2lAa2VybmVsLm9y
Zzsga3dpbGN6eW5za2lAa2VybmVsLm9yZzsNCj4gbWFuaUBrZXJuZWwub3JnOyByb2JoQGtlcm5l
bC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21h
aWwuY29tDQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRp
bmc6IHBjaS1pbXg2OiBBZGQgZXh0ZXJuYWwgcmVmZXJlbmNlIGNsb2NrDQo+IG1vZGUgc3VwcG9y
dA0KPiANCj4gT24gMTgvMDYvMjAyNSAwOTo0OCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gT24g
aS5NWCwgdGhlIFBDSWUgcmVmZXJlbmNlIGNsb2NrIG1pZ2h0IGNvbWUgZnJvbSBlaXRoZXIgaW50
ZXJuYWwNCj4gPiBzeXN0ZW0gUExMIG9yIGV4dGVybmFsIGNsb2NrIHNvdXJjZS4NCj4gPiBBZGQg
dGhlIGV4dGVybmFsIHJlZmVyZW5jZSBjbG9jayBzb3VyY2UgZm9yIHJlZmVyZW5jZSBjbG9jay4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVAbnhwLmNv
bT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9m
c2wsaW14NnEtcGNpZS55YW1sIHwgNyArKysrKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IDxmb3JtIGxldHRlcj4NCj4gUGxlYXNl
IHVzZSBzY3JpcHRzL2dldF9tYWludGFpbmVycy5wbCB0byBnZXQgYSBsaXN0IG9mIG5lY2Vzc2Fy
eSBwZW9wbGUgYW5kDQo+IGxpc3RzIHRvIENDLiBJdCBtaWdodCBoYXBwZW4sIHRoYXQgY29tbWFu
ZCB3aGVuIHJ1biBvbiBhbiBvbGRlciBrZXJuZWwsIGdpdmVzDQo+IHlvdSBvdXRkYXRlZCBlbnRy
aWVzLiBUaGVyZWZvcmUgcGxlYXNlIGJlIHN1cmUgeW91IGJhc2UgeW91ciBwYXRjaGVzIG9uDQo+
IHJlY2VudCBMaW51eCBrZXJuZWwuDQo+IA0KPiBUb29scyBsaWtlIGI0IG9yIHNjcmlwdHMvZ2V0
X21haW50YWluZXIucGwgcHJvdmlkZSB5b3UgcHJvcGVyIGxpc3Qgb2YgcGVvcGxlLCBzbw0KPiBm
aXggeW91ciB3b3JrZmxvdy4gVG9vbHMgbWlnaHQgYWxzbyBmYWlsIGlmIHlvdSB3b3JrIG9uIHNv
bWUgYW5jaWVudCB0cmVlIChkb24ndCwNCj4gaW5zdGVhZCB1c2UgbWFpbmxpbmUpIG9yIHdvcmsg
b24gZm9yayBvZiBrZXJuZWwgKGRvbid0LCBpbnN0ZWFkIHVzZSBtYWlubGluZSkuDQo+IEp1c3Qg
dXNlIGI0IGFuZCBldmVyeXRoaW5nIHNob3VsZCBiZSBmaW5lLCBhbHRob3VnaCByZW1lbWJlciBh
Ym91dCBgYjQgcHJlcA0KPiAtLWF1dG8tdG8tY2NgIGlmIHlvdSBhZGRlZCBuZXcgcGF0Y2hlcyB0
byB0aGUgcGF0Y2hzZXQuDQo+IA0KPiBZb3UgbWlzc2VkIGF0IGxlYXN0IGRldmljZXRyZWUgbGlz
dCAobWF5YmUgbW9yZSksIHNvIHRoaXMgd29uJ3QgYmUgdGVzdGVkIGJ5DQo+IGF1dG9tYXRlZCB0
b29saW5nLiBQZXJmb3JtaW5nIHJldmlldyBvbiB1bnRlc3RlZCBjb2RlIG1pZ2h0IGJlIGEgd2Fz
dGUgb2YNCj4gdGltZS4NCj4gDQo+IFBsZWFzZSBraW5kbHkgcmVzZW5kIGFuZCBpbmNsdWRlIGFs
bCBuZWNlc3NhcnkgVG8vQ2MgZW50cmllcy4NCj4gPC9mb3JtIGxldHRlcj4NCkhpIEtyenlzenRv
ZjoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBraW5kbHkgcmVtaW5kZXIuDQpBZnRlciBjb3JyZWN0
IHRoZSBsaXN0IG9mIG5lY2Vzc2FyeSBwZW9wbGUgYW5kIGxpc3RzLg0KV291bGQgcmVzZW5kIHRo
ZSB2MSBzZXJpZXMsIGFkZHJlc3MgdGhlIGNvbW1lbnRzLCB0aGVuIHNlbmQgb3V0IHYyIGxhdGVy
Lg0KDQpCZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0K

