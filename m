Return-Path: <linux-pci+bounces-23242-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6327A58319
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 11:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F2557A5F8B
	for <lists+linux-pci@lfdr.de>; Sun,  9 Mar 2025 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894FF180A80;
	Sun,  9 Mar 2025 10:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="XCHKLtWS"
X-Original-To: linux-pci@vger.kernel.org
Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AA8C2C8;
	Sun,  9 Mar 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741516402; cv=fail; b=ogxuC5idNqrlCC7oEGDNqnK0WBHiveo1ebIsHwh6wkfZx6WcOcPP2mcdqBChC1Kwfl/amrjIXOt1KE3aqi1eS4+enL5cm4nQNEh7Reihq5d8abiesOAndtSPgkKChkP5ZtVsv+amhXJbsLYoZKO51Bl8txllyEiNOc4zz0xGjXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741516402; c=relaxed/simple;
	bh=9kmrVFRSyeLvb7oWMAMhE7jcwcL/TNnootJheCAxBG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GF4rTBv84aZHAkLfuJpv1QYBe7Wvmy773Ksm2gpRlg+FCzdOna2kH7uarrJxR6M+DC/AngaBKyXdueEKzvyCti2djSKlKhh+crU0ZF3mb9HSiwxfGAM52OpSGu706r35vYwIZ1dC5Y1GhoDDOa2RraCgTfzX6Vgdjtb+FGALZ2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=XCHKLtWS; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jyXGN7eu7Z4LtiFIy/qkcZ4rIHxsuuKEHqZF+OaZV8hrqsjR0bxWrAPY2p2UK6Ui6Gu4huhzETdyE9KOZRVW2PcRb2LCmjA6++1XXLOibfgO2dCTpzbbblBqxfu5HzJ2rSPxJoMUrnm3Oz5osisOLGjS2Ux8Vdk20huqFO76FNwrKBVc52IZPAd/OEKF9dvgU75WUgMWnElhyahxuFkSCFK1bwbV91MYwBVBpSeABu0qpLDS7yneAPSB4WZBtNSeYioOEO6lYKVCzUJCY5QviocRCGst65yJf4a35ZQP28OhCyBa9/LThvlCg+Iv64KYuOxILwbUFnkurTvn0507rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kmrVFRSyeLvb7oWMAMhE7jcwcL/TNnootJheCAxBG8=;
 b=OE3p9V3yAarO40UokLnjhBuvuE+bkVUosYgQGfiAZTgtXgzSG2wHW0eqfdpNghCfS9paSy1gj5sdIHuCI/vlKMnM9iH75sk94XGzA6o//VWdx3gGS1gTU9tHYCLD/J9B1s5XSttXE3o1KLZ0t0ineLy/71WGpgYm8ZdnA7ePo2Gcl+vLlTyL8qdsHEd/6vkvrDU++ktwlqwfPugLGFa6b35iT/vALDyvWrfZgECUdpydTYBjzxF6W4LGfhOtMRZL/5bKxwDRmHtWXBiHKkY+lvplpOL99yGQ1ZSRNwC4SfQGYtIEzCks2N32pGfqA2GjtUzUzcmtnsyENqGMrQVTEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kmrVFRSyeLvb7oWMAMhE7jcwcL/TNnootJheCAxBG8=;
 b=XCHKLtWS+MGJ4XtAZxfpsaYc1rmn26CZg3qO2fLwDC6Hi1IQIGkaJJoKdP6LM7aX/Eke3VrjWMVORL7r0hnxhFuAaWj15PbNvmNvYzqXMZ4RaC7KH9pbEB5AeYPJYmkoDGwQ2rZniTI6bZ9/EQ0lHy7AbkQhFbe9AI7UuXcLNBnHjrae4hOdSEpPZRTbZUC2zroQy2PjnbSqjz+KIc4CimOXJbgkyUasGTnRQKPIGmeHNf4Hybd+iaM3RmLjviFCiPSOEzZyW8/4bqarX6o85qBi+vLwLBlQCwsUd8kKD16R3oceb3Qn0A0MimAsopJlzgLEVwuecc4Gdbo8+HSHnw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7905.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:8c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 10:33:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8511.025; Sun, 9 Mar 2025
 10:33:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Aun-Ali Zaidi <admin@kodeit.net>, "paul@mrarm.io" <paul@mrarm.io>, Orlando
 Chamberlain <orlandoch.dev@gmail.com>
Subject: Re: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Topic: [PATCH RFC] staging: Add driver to communicate with the T2
 Security Chip
Thread-Index:
 AQHbkM7rYdRJRFFoLkaQD5PHjXHnmrNqf5kAgAADB4OAAAMjgIAAA7jxgAACxYCAAAD/g4AAAhAAgAABE5aAAACyAIAABLn9gAAC+ICAAALuWg==
Date: Sun, 9 Mar 2025 10:33:13 +0000
Message-ID:
 <PN3PR01MB9597BD16BBDD5D84329FF0CDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <2025030931-tattoo-patriarch-006d@gregkh>
 <PN3PR01MB9597793C256B5A16048ADBFDB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030937-antihero-sandblast-7c87@gregkh>
 <PN3PR01MB9597F037471B133B54BA25BCB8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030935-contently-handbrake-9239@gregkh>
 <PN3PR01MB9597F040DD8F5A9B1A65B397B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030909-recoup-unafraid-1df0@gregkh>
 <PN3PR01MB95970E60B250F91CA8E12720B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030901-deceiver-jolliness-53f5@gregkh>
 <PN3PR01MB9597B64008E01DC0336FAE37B8D72@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025030929-cryptic-ducky-9e23@gregkh>
In-Reply-To: <2025030929-cryptic-ducky-9e23@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB7905:EE_
x-ms-office365-filtering-correlation-id: f6553df5-47ee-4a97-2c3e-08dd5ef5cb8b
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|461199028|7092599003|19110799003|8062599003|6072599003|12071999003|21061999003|3412199025|102099032|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2NGR0hYUVRtRUtLQWxseWZwcGJuVytsb2pnQ1FHWUxSSnQrYndPQndUVmRp?=
 =?utf-8?B?K2FxSUVUaGxLelJtLy9XUXhXaGtHVlpZdDBQZmlxS0ZISTFsMEFQaXl5Ynpk?=
 =?utf-8?B?OHNzQVlyenJXSXpMRHRicS9GczNUbkJVSWdmUXpzNzlYUzA5NG1haUV2QmJ3?=
 =?utf-8?B?ZjlJQVNxWWZZdFhrSzFxWWd5K1FTMjFMUjhpNDNmdEVZSi9UL3A2akw0aFVR?=
 =?utf-8?B?dUM5WjhJYk5jd2cyTHROOE5ndkpHT2x3aFBBMTFjdzBRZklEcE1hWnNIR1Rr?=
 =?utf-8?B?aWpKNkNKNWRxc1AvK2orUDJZVlVuNGVLaktDakZWdGovZit5Z2RBMXJXMDBY?=
 =?utf-8?B?bTJvcEZSZWNIZjNsblJzTVBiWUsvQWI1aFVicE9ZeElyV01UMkQvcE54SldI?=
 =?utf-8?B?eWw2MStlV2xManZ5MWdBd3FXYkxvSUhjSXVuU0Rwc1hxa3VzaGc1MEVLYXRC?=
 =?utf-8?B?dEttYVBVSjBoZXJ4MmZScUdPQkFjQnpGVlFWWGVxNlE5c1FEdHJldWw0UXhX?=
 =?utf-8?B?TXhERWE4TCs3Rit1TTNGa3pBZGxQalRpYjFYK1djM1BhQ3RSdEkzRUhpQW5s?=
 =?utf-8?B?T3FpT1hFeGFuSjdVRjdsTkpoVHRBdWNnYWpKVnFGOU8wVGlyNEN3T1VkMU83?=
 =?utf-8?B?c2tzOTJXYVoyZUNQSncrcVYzTmJpSFArZFQyTjJqZnZ3cENkdTUwMVFmdnc3?=
 =?utf-8?B?dm5IUzhubjJ5alZLR1g0QUI1ZktMS2RSUGR4V09wQnBPU3ZyKzEyV2hCMG0x?=
 =?utf-8?B?UnVXQ2duUVNsd1g4U0RVbTY0NkRJZnFGbjZXRzdmcHovcDNTcGRNekN6OCtT?=
 =?utf-8?B?dGNqeDU0bWZJMWtyUGxLYmRibWhITEEyVHJQUk1ZUVM1cE1UK0JUVEtQTzF4?=
 =?utf-8?B?b2ZjTW5kTSt0RFFqQnd4R0ZEaFhEYVN1UjZIZ21VTlkvNmxTNW5xb3R0R0tX?=
 =?utf-8?B?aGN3SnNoZEV1NStwZEJmOEgyaFVvSHMzZldSYzUzWmRFSUpJeVJCQVRMS1lv?=
 =?utf-8?B?dWlua3MrK3hkVzhGeUlqNzNCV2QyNG9lSDJCNHhFS0ZLaldXcmwxblFJZGhQ?=
 =?utf-8?B?elpYbHVkL2tSVS9mbHQrSVpxL3J1cWxKYWNiRXZvdFg5ejJKSVhEV3BmcVp1?=
 =?utf-8?B?YlptMUNOeHVjZHBmR2ZxV3lHYzdQc1BseFNuRWVSL0FxTE1OL1RyOXlWcTNM?=
 =?utf-8?B?Y1hFcTNIZ1RwN3AwUHB6MnlJL28wYWJEU2Y3eldWN3lEd0ZyempTV0tpbzgr?=
 =?utf-8?B?bjg4YnNOVmVFalF1bkRubHdnNUFLSnplM2JZVTNkRmF1ZEVXSjdLR1BHcTNZ?=
 =?utf-8?B?ZW1qTjNjMnJwOU5QY1o0SEZoS21JUmRzeGpUMkljUXE4bnZML0lVcTNuTWRt?=
 =?utf-8?B?cE40Z0sxQlNmcEUzamVzaWN5NTQwWW40amljenpXelJCZ3ZNeDFMTDVobEpi?=
 =?utf-8?B?UWlDZktKYmJIR0xTbm9pbjlVUEFqbmJqcURLbW00eHpsWjM3Q0JVU3I2S0Vz?=
 =?utf-8?B?aVlwcjZSNVBqdmlhYXhNN3g2Y3AzdWYyTTREVUZVajhheU1QbXp2WWt0TURv?=
 =?utf-8?Q?ri6PVpPsfZFUfbX2cr/Hib7so=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a21LeTBZaXlwbkcxc1RoK2lpbmt6WXJxK2ZXTWNuT2F6ZWdDMkRlWEo4UW5x?=
 =?utf-8?B?MXVWZ0dZQ0xPVWhIMnFUZE9DUVpSbEFsWnJIYnUwbmp5L29yNjdXOThVaktM?=
 =?utf-8?B?dFJudEEvaGFyU3lxbHZaOWZjSXBsejNZUDNqNDhKV3F3THdYRG5Pbkc3WVdY?=
 =?utf-8?B?RWV6MHJJcUpIZmdzVWo5aUZnUTBwbm1sWDlvUy9uRUJRR3p1QmV5UkJKN2du?=
 =?utf-8?B?bnEvN2NXblVvR0tOYXVHakpiNW9zcDZ5K0Z5T1lJMll4TUNqL2hEL013NWVo?=
 =?utf-8?B?M1VnNWlNaXJyQ1h4eURZUmNzb05MdkdDK2RSRTY2aTNMYjB2SG5zR1dUQ0pX?=
 =?utf-8?B?ZDRpNVNJK2piSzBXdmlFZmZOTXpkN1dJOUg2eDFNWnlwUWMxMnZudDRRRTJa?=
 =?utf-8?B?VzREMFYrY2RNeU1odWZkRVZ3NEF4NXpPUVdLcHlmeW0ybWxPK3RSRHlSZTE5?=
 =?utf-8?B?NllUMGdNVk1FQTR0cEpzbVZRZm1VN1R3c3lITms4ZTVmL0xTRWZtRzVIWEZJ?=
 =?utf-8?B?SjhDenpCZFM3RU9nY1Y0NEg0YktYWUJZdksrZ25SWWhuODYxdGNpWDVNTmZY?=
 =?utf-8?B?dHFNQnN2eEpFZThUQlFVanREcTJwSnVIc2hsSDMveXlCRklaZ0tweDBkekxL?=
 =?utf-8?B?N3Z5NlJSanIwSFNpTmNjWFoyb3BqVFJNRjkwVVFwVHFZcjR2VjQ5c2N3VnFB?=
 =?utf-8?B?TW4vUmZtVkFNcEpJeWRYeExxcU9sNkxlRTgwZzdJL3JYQTdRQy9TRUNPaWFq?=
 =?utf-8?B?ZWVRL1JzOTZqL3lrSFZSdUlqcHdpdmNETWMxNU13MVMxa04wa1g2Rk1zVk9y?=
 =?utf-8?B?b3ozV0ZOMncvNEh6N3o5V3NENk9oZWNja2hTTm9kQS9ib0ZSOUV5blhaZVg4?=
 =?utf-8?B?RE1HYWlIQkZMc2VkaGlqUVpuWW9JWklXbmtIdmVQUnJVQnNWbElFYnBXVEd2?=
 =?utf-8?B?OHpRMmJGK0g3OEN1NEdpK1FTL203UUJZL1hQQmRHOGUwUnlZcTJQMDEyb2gx?=
 =?utf-8?B?R2FEWWtHRnYwdDloRmFLT2hjNXZaOHpDV243dXY1M0VXZHVnUUdtMytySTBw?=
 =?utf-8?B?WWFINzM4REp0c1NFeTgvQmRRWmREVytETEU4NGpLeDlvam5qQW1ka2RzS1Zo?=
 =?utf-8?B?T0ZnRnZvVFlCcHNGMGtNNWx0em45VjNuSGIwZmZwZm94dm1yMnNEQ3NDckJ1?=
 =?utf-8?B?TFBtY1oyZmpjQnRiQ0x6RURMczNhMm1LNDhqVWJCa0pqbUs1ZVFRMnlTQjBL?=
 =?utf-8?B?aEFOZlZ6bkFGR3NrZnVDM243c1ZpT1ZiMEs0YXlpZWVSWjE0VStCTkVrSkZH?=
 =?utf-8?B?Y1c1aGh2RTVWbFJIQllGRVdHYjJnc0hyREhCNUVETGx6bVdNUzhqSWJtTXNL?=
 =?utf-8?B?RElORHVTS1Fqa2p2QkV0UnZzdm80T1ZYQ2k0STBvbW9wc1ZLd3VJV01BRkU4?=
 =?utf-8?B?czFCY21ablppWjhJT2dqRHJKWlBMNUhmUndKb1U3RFBaeDFLWDFlWUxFZjBa?=
 =?utf-8?B?L2t0bUZiNnhZbi9oSHRDQmFRQkFOTm12SHZjbDFDVUJEMEhqdml0VjEvYWN1?=
 =?utf-8?B?aEFVclhoUkJFdWR1WWdpaFNQbTBUYm1NcXZnRm1CUlNxcXFFeDVLRzJ3L1JN?=
 =?utf-8?Q?EyONI9ydwLpjjxDXQIDsN/XA/p6iGgp1pMkaHiCHnFFM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f6553df5-47ee-4a97-2c3e-08dd5ef5cb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 10:33:13.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7905

DQoNCj4gT24gOSBNYXIgMjAyNSwgYXQgMzo1NOKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9u
Lm9yZyB3cm90ZToNCj4gDQo+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDEwOjEyOjA2QU0g
KzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gDQo+PiANCj4+Pj4gT24gOSBNYXIgMjAyNSwg
YXQgMzoyNuKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+PiANCj4+
PiDvu79PbiBTdW4sIE1hciAwOSwgMjAyNSBhdCAwOTo1Mjo0M0FNICswMDAwLCBBZGl0eWEgR2Fy
ZyB3cm90ZToNCj4+Pj4gDQo+Pj4+IA0KPj4+Pj4+IE9uIDkgTWFyIDIwMjUsIGF0IDM6MjHigK9Q
TSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcgd3JvdGU6DQo+Pj4+PiANCj4+Pj4+IO+7v09u
IFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjQxOjI5QU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3Rl
Og0KPj4+Pj4+IA0KPj4+Pj4+IA0KPj4+Pj4+Pj4gT24gOSBNYXIgMjAyNSwgYXQgMzowOeKAr1BN
LCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+Pj4+Pj4gDQo+Pj4+Pj4+IO+7
v09uIFN1biwgTWFyIDA5LCAyMDI1IGF0IDA5OjI4OjAxQU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdy
b3RlOg0KPj4+Pj4+Pj4gDQo+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4gT24gOSBNYXIgMjAyNSwgYXQg
Mjo0NuKAr1BNLCBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4+Pj4+Pj4+PiAN
Cj4+Pj4+Pj4+PiDvu79PbiBTdW4sIE1hciAwOSwgMjAyNSBhdCAwOTowMzoyOUFNICswMDAwLCBB
ZGl0eWEgR2FyZyB3cm90ZToNCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+Pj4+
IE9uIDkgTWFyIDIwMjUsIGF0IDI6MjTigK9QTSwgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmcg
d3JvdGU6DQo+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+IO+7v09uIFN1biwgTWFyIDA5LCAyMDI1
IGF0IDA4OjQwOjMxQU0gKzAwMDAsIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+IEZy
b206IFBhdWwgUGF3bG93c2tpIDxwYXVsQG1yYXJtLmlvPg0KPj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+
Pj4+Pj4+IFRoaXMgcGF0Y2ggYWRkcyBhIGRyaXZlciBuYW1lZCBhcHBsZS1iY2UsIHRvIGFkZCBz
dXBwb3J0IGZvciB0aGUgVDINCj4+Pj4+Pj4+Pj4+PiBTZWN1cml0eSBDaGlwIGZvdW5kIG9uIGNl
cnRhaW4gTWFjcy4NCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBUaGUgZHJpdmVyIGhhcyAz
IG1haW4gY29tcG9uZW50czoNCj4+Pj4+Pj4+Pj4+PiANCj4+Pj4+Pj4+Pj4+PiBCQ0UgKEJ1ZmZl
ciBDb3B5IEVuZ2luZSkgLSB0aGlzIGlzIHdoYXQgdGhlIGZpbGVzIGluIHRoZSByb290IGRpcmVj
dG9yeQ0KPj4+Pj4+Pj4+Pj4+IGFyZSBmb3IuIFRoaXMgZXN0YWJpbGlzaGVzIGEgYmFzaWMgY29t
bXVuaWNhdGlvbiBjaGFubmVsIHdpdGggdGhlIFQyLg0KPj4+Pj4+Pj4+Pj4+IFZIQ0kgYW5kIEF1
ZGlvIGJvdGggcmVxdWlyZSB0aGlzIGNvbXBvbmVudC4NCj4+Pj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4+
Pj4gU28gdGhpcyBpcyBhIG5ldyAiYnVzIiB0eXBlPyAgT3IgYSBwbGF0Zm9ybSByZXNvdXJjZT8g
IE9yIHNvbWV0aGluZw0KPj4+Pj4+Pj4+Pj4gZWxzZT8NCj4+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4+
IEl0J3MgYSBQQ0kgZGV2aWNlDQo+Pj4+Pj4+Pj4gDQo+Pj4+Pj4+Pj4gR3JlYXQsIGJ1dCB0aGVu
IGlzIHRoZSByZXNvdXJjZXMgc3BsaXQgdXAgaW50byBzbWFsbGVyIGRyaXZlcnMgdGhhdCB0aGVu
DQo+Pj4+Pj4+Pj4gYmluZCB0byBpdD8gIEhvdyBkb2VzIHRoZSBvdGhlciBkZXZpY2VzIHRhbGsg
dG8gdGhpcz8NCj4+Pj4+Pj4+IA0KPj4+Pj4+Pj4gV2UgdGVjaG5pY2FsbHkgY2FuIHNwbGl0IHVw
IHRoZXNlIDMgaW50byBzZXBhcmF0ZSBkcml2ZXJzIGFuZCBwdXQgdGhlbiBpbnRvIHRoZWlyIG93
biB0cmVlcy4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoYXQncyBmaW5lLCBidXQgeW91IHNheSB0aGF0
IHRoZSBiY2UgY29kZSBpcyB1c2VkIGJ5IHRoZSBvdGhlciBkcml2ZXJzLA0KPj4+Pj4+PiByaWdo
dD8gIFNvIHRoZXJlIGlzIHNvbWUgc29ydCBvZiAidGllIiBiZXR3ZWVuIHRoZXNlLCBhbmQgdGhh
dCBuZWVkcyB0bw0KPj4+Pj4+PiBiZSBwcm9wZXJseSBjb252ZXllZCBpbiB0aGUgZGV2aWNlIHRy
ZWUgaW4gc3lzZnMgYXMgdGhhdCB3aWxsIGJlDQo+Pj4+Pj4+IHJlcXVpcmVkIGZvciBwcm9wZXIg
cmVzb3VyY2UgbWFuYWdlbWVudC4NCj4+Pj4+PiANCj4+Pj4+PiBZZXMgdGhlcmUgbmVlZHMgdG8g
YmUgYSB0aWUsIGJhc2ljYWxseSBmaXJzdCBlc3RhYmxpc2ggYSBjb21tdW5pY2F0aW9uIHdpdGgg
dGhlIHQyIHVzaW5nIGJjZSBhbmQgdGhlbiB0aGUgb3RoZXIgMiBjb21lIGludG8gdGhlIHBpY3R1
cmUuIEkgZGlkIGdldCBhIGJhc2ljIGlkZWEgZnJvbSB3aGF0IHRoZSBtYWludGFpbmVycyB3YW50
LCBhbmQgdGhpcyB3aWxsIGJlIHNvbWUgd29yayB0byBkby4gVGhhbmtzIGZvciB5b3VyIGlucHV0
cyENCj4+Pj4+IA0KPj4+Pj4gSWYgdGhlcmUgaXMgImNvbW11bmljYXRpb24iIHRoZW4gdGhhdCdz
IGEgYnVzIGluIHRoZSBkcml2ZXIgbW9kZWwNCj4+Pj4+IHNjaGVtZSwgc28ganVzdCB1c2UgdGhh
dCwgcmlnaHQ/DQo+Pj4+IA0KPj4+PiBTbyBiYXNpY2FsbHkgUkUgdGhlIHdob2xlIGRyaXZlciB0
byBzZWUgd2hhdCBleGFjdGx5IHNob3VsZCBiZSB1c2U/DQo+Pj4gDQo+Pj4gSSdtIHNvcnJ5LCBJ
IGNhbiBub3QgcGFyc2UgdGhpcy4NCj4+IA0KPj4gDQo+PiBJIHdhcyBhc2tpbmcgdGhhdCBzaG91
bGQgSSBpbnRyb2R1Y2UgYSBjb21wbGV0ZWx5IG5ldyBidXMgaW5zdGVhZCBvZg0KPj4gcGNpIGFu
ZCBwcm9iYWJseSByZXZlcnNlIGVuZ2luZWVyIHRoZSBvcmlnaW5hbCBtYWNPUyBkcml2ZXIgdG8g
c2VlDQo+PiB3aGF0IGV4YWN0bHkgaXMgZ29pbmcgb24gdGhlcmU/DQo+IA0KPiBObywgaWYgaXQn
cyBhIFBDSSBkZXZpY2Ugb24gYSBQQ0kgYnVzLCB0aGVuIHVzZSB0aGUgUENJIGFwaSBmb3IgYWxs
IG9mDQo+IHRoYXQuDQo+IA0KPiBJdCdzIHdoYXQgdGhhdCBQQ0kgZGV2aWNlICJleHBvc2VzIiBo
ZXJlLCBhcmUgdGhlIG90aGVyIGRldmljZXMsIGxpa2UNCj4gdGhlIFVTQiBob3N0IGNvbnRyb2xs
ZXIsIGhhbmdpbmcgb2ZmIG9mIHRoYXQsIG9yIGFyZSB0aGV5IHJlYWwgUENJDQo+IGRldmljZXMg
YXMgd2VsbD8NCj4gDQo+IFdoYXQgZXhhY3RseSBkb2VzIHRoaXMgQkNFIGRyaXZlciBkbz8NCj4g
DQo+PiBJIG1pZ2h0IG5vdCBoYXZlIGJlZW4gY2xlYXIsIGJ1dCBJJ20gbm90IHRoZSBhdXRob3Ig
b2YgdGhpcyBwYXRjaC4NCj4gDQo+IFRoYXQncyBmaW5lLCBidXQgd2h5IGRvZXNuJ3QgdGhlIG9y
aWdpbmFsIGF1dGhvciB3YW50IHRvIGRvIHRoaXMgd29yaz8NCg0KTGFjayBvZiBtb3RpdmF0aW9u
IEkgc3VwcG9zZS4gVGhlIGRyaXZlciB3YXMgZ2V0dGluZyBtb3JlIGFuZCBtb3JlIGFubm95aW5n
IHRvIGZpeCBidWdzIElJUkMuDQo+IEhhdmUgeW91IGFza2VkIHRoZW0gaWYgdGhleSB3YW50IHRo
aXMgY29kZSBpbmNsdWRlZCBpbiB0aGUga2VybmVsIHRyZWU/DQoNCkhlIGhhZCBwZXJtaXR0ZWQg
bWUgdG8gc2VuZCB3aGF0ZXZlciBJIHdhbnQgdXBzdHJlYW0gaW4gYSBjb252ZXJzYXRpb24uDQo+
IFdobyBpcyBnb2luZyB0byBkbyB0aGUgbWFpbnRlbmFuY2UgZm9yIGl0IGFuZCB3aG8gaXMgZ29p
bmcgdG8gYW5zd2VyDQo+IHF1ZXN0aW9ucyBsaWtlIHRoZSBvbmVzIEkgaGF2ZSBoZXJlPw0KDQpJ
IGNhbm5vdCBhbnN3ZXIgdGhpcyBybiwgSSBzdXBwb3NlIEkgYWNrbm93bGVkZ2VkIG15IGxhY2sg
b2YgTWFpbnRhaW5lcnMgYmVpbmcgYWRkZWQuIFNpbmNlIEkgYW0gYSBwYXJ0IG9mIGEgc21hbGwg
Z3JvdXAgb2YgZGV2ZWxvcGVycyB3aG8gYWltIHRvIGJyaW5nIHN1cHBvcnQgZm9yIHQyIG1hY3Ms
IG9uZSBvZiB1cyB3aWxsIHRha2UgdXAuIEN1cnJlbnRseSBJIGFtIGp1c3QgdHJ5aW5nIHRvIGdl
dCBhbiBvdmVydmlldyB3aGljaCBjYW4gZ3VpZGUgbWUgZnVydGhlciBvbiB3aGF0IGNhbiBiZSBp
bXByb3ZlZCBhcyBmYXIgYXMgbWFpbnRhaW5lcnMgYXJlIGNvbmNlcm5lZC4NCj4gDQo+IEFuZCBh
Z2Fpbiwgd2hhdCBpcyB3aXRoIHRoZSBuZXcgdXNlci9rZXJuZWwgYXBpIGJlaW5nIGFkZGVkPyAg
V2hhdCBpcw0KPiBhbGwgb2YgdGhhdCBmb3I/DQoNClBsZWFzZSBnaXZlIG1lIHRpbWUgdG8gcmVh
ZCB0aGUgZHJpdmVyIGEgYml0IG1vcmUsIHNvIHRoYXQgSSBjYW4gYW5zd2VyIGl0IGJldHRlci4g
SSBuZWVkIHRvIGZpbmQgdGhlIG5vdGVzIG9mIHRoZSBhdXRob3Igd2hvIGFjdHVhbGx5IHdyb3Rl
IHRoZSBkcml2ZXIuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K

