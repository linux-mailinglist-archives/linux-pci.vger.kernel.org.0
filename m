Return-Path: <linux-pci+bounces-44556-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC4ED15724
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 22:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4C53006F73
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 21:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ABC30FC1D;
	Mon, 12 Jan 2026 21:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H/yBOAYy"
X-Original-To: linux-pci@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011025.outbound.protection.outlook.com [40.107.208.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775C2F693B;
	Mon, 12 Jan 2026 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768253544; cv=fail; b=MAcSmqhzG3zu0UiHs4iHX3St77jxInQa2a/bKOh3ybPbhtWl9khxSc6gXbpo+dITBgG9PrZ0KCDbc+4cwo2lr/eaQMmpoCTT3tcsbD8guagOY/STJxxjLRvU7UPje4z8Rtu9i0QPdPusMUq5FDBI8C7eys4EUMNPiK0MCX8xgCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768253544; c=relaxed/simple;
	bh=31EK9VDjV849ZjLUtD8h6CtbUjH2qknNZVYlKMhjgNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gRBf6c23c9ivw1w4xCeqAqv8udbMM5nAClxy6QOiswZPe4Cm8DiNiSEzoM5lGZdOy+pndKVGcKzANCTgD8cuN0edyXocSyVn+yhPlxRCq//NLFRJuzpwK3bPXmkNPLDeLzB/kQ96cWuK+SFE8+mLDtbQgKohXqeDqTdoFqAyxxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H/yBOAYy; arc=fail smtp.client-ip=40.107.208.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lRSoMYqlahEFBy5ohlqKAh+cdjivxbnI8qHiqonxTmWGh44goRrNbaod12etFsfTaHBjoOWgkNKpxCV7mRQ9lP+c64nGbdSI0pe2C0mJNpUCrZpqFLahLMK9Om2PhfUsN6ViURK3xEf+iR4YoglCteLPWFXmJdHzUyPwyMG1OCY/h4e+RPpChYQnq+KHPwoYn3fUBN+0IKm9Px1z4cWeXTXAmLlWSUJuDgpeguu+XgyfpFcARX8npBn3zRLTrejn5/nNRylgTZg7HqbTWgeE39NLfjbek53Ox+BuQVCMlBisKXtzw9arBoAnBIYY0yKdvYpbKt2vI5tS9V/XhnuCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZiobMKN5krUX3POrAi/on2zpHBzAypcburG8jmh4oQ=;
 b=x7Q/dBdDDztONQtJ0IoNBL6mHdeeUqOg3neZscQNQWtLTJWyvWFHd5ZbS12QHTiebEgANJPKC0ln98l54+gGIOh0JzH/xVDfC9RvamY70LT95UbIWsn+GUo3U/oIJgIylZzzpSVynFmBIRrF54KVtthYq//8zBLrJorWkb4ZCgLYpJi4F2Bc2sop8/3lXhZvuFnDGeuGnxIuNaib8JZKVYEr0dJl/W1Gnof6jIp2qUvBaqNW27wMT7vkibWuimxFdeqtSNY8vRhu8QJ+SDfU2VqhFidQVFD/9HU/3f4b0sCqGp5uTLn5wbAC6aajPSxRjwHn6vHUe1sSKl1LVbIIQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZiobMKN5krUX3POrAi/on2zpHBzAypcburG8jmh4oQ=;
 b=H/yBOAYyth1phIBbDMlAomKwqsTNfiMkeJtXvDnkdhLxADCKhxCBuxOxepu/J+IKcmcio1X6A+KSOeoQHS7qDQKWvwwCB/Izwu5h4lSElRn2G4BfDFCjcXrbw4rx9btFNRXDS/MjAwIdT08Qg6ZieEzLSuoOHE85ySOGsVNDeYU6wzLehWpR2MsGb3y/aOhmil5JBTSpJaerq4DXJsP9+74VBeqh02BiApHxtlSHgLWXK6jNIzF5fscnePiSCoUkm/PN0lcN6gjPnM/DGF5qTFylnxYFzKcgpRXymYG0D7SmNLd3nbZrLWTTpy8ZxSE2lVz98x9ZhcTiVOciAdWAvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SN7PR12MB7956.namprd12.prod.outlook.com (2603:10b6:806:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 21:32:19 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 21:32:19 +0000
Message-ID: <bee812e6-85c6-4d82-8bfc-69517f17492d@nvidia.com>
Date: Mon, 12 Jan 2026 21:32:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] genirq: Update effective affinity for redirected
 interrupts
To: Radu Rendec <rrendec@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Daniel Tsai <danielsftsai@google.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jingoo Han
 <jingoohan1@gmail.com>, Brian Masney <bmasney@redhat.com>,
 Eric Chanudet <echanude@redhat.com>,
 Alessandro Carminati <acarmina@redhat.com>, Jared Kangas
 <jkangas@redhat.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-tegra@vger.kernel.org
References: <20260112211402.2927336-1-rrendec@redhat.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260112211402.2927336-1-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0676.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::14) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SN7PR12MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 1485342d-476c-4c17-eba4-08de52221051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNRNEd0N2tGaWVWYzdiSExUVXVaTkE0eUxwMkN5SzFsQ2lYb2hFS1dEY3Rn?=
 =?utf-8?B?VDJ3VEhMKzRkNmhCaTB4ckZBRVdNc09jcUx1QkNENVJWMENTaWpobTV2dzgx?=
 =?utf-8?B?Y1FXOXpjQkozTTZLVWdEQ0tHMVAvUWdqM2lHZCtWSThlblAxUk1WN0JodkxI?=
 =?utf-8?B?MjRKQ21vYjhVMWo4cXVDaXo5ejlwdGtKK1c1TzRKZXNCeHg1UVAvaXcvMThm?=
 =?utf-8?B?MktpWXRwOTdadW1KdUdjOGpJcFBIOUtWQWRmakk2eGV6amFvbDNJdzZnUVM5?=
 =?utf-8?B?SEUrOE8zZjFPSXJRL0g3WGcyUFZRdWVYaUtPZVNPWnhja2RwcXJTZ2d3enN3?=
 =?utf-8?B?Z2FmRmVUczNKVHFJY1VWdXZyRU5CZ01ZbUxrNkZiRVc2UGFtN1AzbWg3akZO?=
 =?utf-8?B?SUcyNEVCTDhhZEUyRHE0L3k5eFdsNE04T0F1eUI4ekpvSElWRFlMaFp4TWdI?=
 =?utf-8?B?KzJHVGhVQVorbDE2bzF2Z05EOWdpeTkvaUFtdEJzTDdEYnVqRjZoY1FBcWNG?=
 =?utf-8?B?WkRQS01ET3BHZ3hhS0N0RTQzclQyaFZqTXhUN3llSFQ1VEZEZUE0WUgyOWRK?=
 =?utf-8?B?Si9NR3NFVEovckNWWUxuaXVib1o0T2k4b0VDT2MzV1NVZTZkRGV5VGY1TEpi?=
 =?utf-8?B?RDBVNmV1K1ROTzFDYlRqc1VmSjc0NEVyY0t1bkI0K0o1L0kxUUpyQWF0ZkZi?=
 =?utf-8?B?U0k2aFVRS2hPMVJleTN3U3NzOG13d2VwKzFMbFczcnRxVlZISlg1bTlWUlRr?=
 =?utf-8?B?bkM0ZWhmTEd6Q3I4TlB0YXN6YTIxL1BGeVFxbUFPQWdmTmRPTmV1Q2RvMEM3?=
 =?utf-8?B?Nk5YYmZINlppczFCVUtyR1JrTVBFWXNkWDFkdlZtWm5QYVlxVWtYcEQxazg3?=
 =?utf-8?B?NDRBbHJwSUdrcXU5RWNhV3NKSmV3N25ud3kvb0lxTDM5OXkwVkpzMlRsbUsv?=
 =?utf-8?B?OHcwV2ZUY3FsNnRiL2RGYXhRUkk4MlZ2dzJucHFXK2wwdGN5OW5Ud21kMDVU?=
 =?utf-8?B?MDdHWkJMV2hzNlVwWEdkU2pPTnVYcmdjWG1jWGpVWmxNT2Q2NnVhSEIxbWFS?=
 =?utf-8?B?V24waWtTbGhWL0o2WXdzWkRDMUliZ2VlL1hsbzhQOTZLcmc4TW1kY0lXU1NI?=
 =?utf-8?B?NWYvOVkyb0RnQU5JRlhENnpsYWUrRVRBakV1dDA2V1QxZ3hJTU9YY2N1MFRq?=
 =?utf-8?B?SkgxY3BMK0x0VHBNcjFzOStwQTNLMWRzSHJESW5HaEdXS2ZDcCtuY3QreStB?=
 =?utf-8?B?WVZzWE56aWVTNG9JSUJVekxrZzZ5S3QxWXZsbk80Qk1VUmNuZklsN0llSU5m?=
 =?utf-8?B?Ym5Ya014d0czZm9DNi8vSDJtb01PcHY4elVtWmtmbjBWMWhQRmQrYkkvMkZ1?=
 =?utf-8?B?QW5CdWtnZDh0cnA4Qy90RVp5YW8vR1V6SFVYUmNuS2xvZW9IRDBpSTIrcjB0?=
 =?utf-8?B?UnJhck8wb2lLNkZRSklEeDI4MkdTRGFZUTM0VXR0ZEFoRFBhOWs2V2FPYi9Z?=
 =?utf-8?B?VkxUdS9lVUtBUXcxbG9qUzBlVlRDSXAwNFRZamlWanJUWkgrdWhPRmtaKy9t?=
 =?utf-8?B?bEYzcXhjL0dpaDFITUZucldyZWFZTE5MUGhXRGNsMnZaamJhUmdmc1VjQUtV?=
 =?utf-8?B?YUhvK0F0eWxoa2trOE1iMit2ZkFNK005ajBuU2J0QWluQ0d0VzlWY0JCOXpr?=
 =?utf-8?B?TXhTTG9JYTNmdkFpdGc2bHN4VXZROWhCVGNxaTh5aGN1aDBMSUt5RUcvNXhw?=
 =?utf-8?B?b1BUSHBBc1RVa2p5dHF0bm5OakVJaGNCcVpzSVEzZmVxVVlwSzNFUmRreTNu?=
 =?utf-8?B?ekRsTlVKUFQwOHEyWUFhdGFydHdGanlsSG1zSXE1VjNJTjZDTlRReEQyNTNG?=
 =?utf-8?B?cG9oL21mNmZEZFpWNjZ3MVFHK3FpWm9rblFPMEREcmhHUHpvMFBHejV3N3dO?=
 =?utf-8?B?dUIrdFZTQXRNeCtRTENUTGtpOHlUUUIvajQ2cCs5aUYzZGRaR2VBNVNmcmIy?=
 =?utf-8?B?SnFCU1pUd1dnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTU1SERNN3FPWUxIbldtYXV0UTRCM0M1UGtocXpYb28wcUl1bHc4eGRyNXp6?=
 =?utf-8?B?ZUl6TE1Hck84TUFkM0NRNzIrb1p4R0ZKcU50T05yZFN0dnJzWDVCeGErWUl6?=
 =?utf-8?B?MGZlcHlvenNFNW5DWTZ0KzVSY1JsSTY4RDF3eURwa1Q3WXJaWFY3R3luNnFn?=
 =?utf-8?B?Mm5Ma3l6cjNIcWFmS01QUDFVWkVNL2x4Zi9vRk9YVFJxU01QWWRDRjc2MWwv?=
 =?utf-8?B?RDJ3TGVpN01CL2k3alpDRlJqRXVaVFY0RytrdEJJelNiNmdxalRpRUlrcElK?=
 =?utf-8?B?RURhR094cG5xUU1uZEFwbndBQSt4a0I4VEIzeHZhOTVQaHRBcTlzWm5ZRExU?=
 =?utf-8?B?bjlVcHpQa0RGNlNxR0x3bWRzbFpyczlSNE1ML3o5TFpHcVYybFlwV2Y2dUwx?=
 =?utf-8?B?bVVxY0pwMW5hNS9kUjdqZVF2VTJZWGhhSklHbWJ1L2RRZW9Fc0d5akM2cDZ0?=
 =?utf-8?B?UXF6VFBFVG01cVF0S2plL29Oc29HekEwVnBRZjVpMSs0TzkrRnJXVGMwUkFQ?=
 =?utf-8?B?YjgyY0pnd1ZVZUtxZnR2dUpPV2VRWW9Rdkh0Rk8wY3l3UWNMUFk5Qi9oWC9E?=
 =?utf-8?B?cWJnS2lQTlRnUVQyaU1GVm9EQ0Robk5Zd0VFbTFHenpYQ0o2alVQVlN0WVY5?=
 =?utf-8?B?MEluVVI4eGZjL1pxMUFNaEp6UEFjT29GeUJQSXBkT1NlUTFER3RRdXJjMG5M?=
 =?utf-8?B?Y3NXakczODZVYm9CbHA2dnp0WHh3MXl5UldYbXNOWXFzYk9IOG9HbmtrRkE2?=
 =?utf-8?B?YWk4U0JaN1NKd0RjWW1nTWNEU29TZU1UM3BoNnBnNlQyTElvQ1FLeUNkWXp4?=
 =?utf-8?B?a0tJNUxQUnVkc1NYR3g0Yi9vaVhnd3B3RGcrQ2Flc1owY1FFQUh5Vmk0U29U?=
 =?utf-8?B?a2k2MnB1TEJvMk5LVEY0cnp3VDhvT3NZZXlRdElQOFJYZW5PWFVTUnpwdjEw?=
 =?utf-8?B?Nmt6WVpLblY5elVibWVRQVhWTWZiSEtaVGVkRmFGNmR3ZENkNkVmWEJaZWNx?=
 =?utf-8?B?RVFZbnhpR3MraG9LY2dINzBJMXd2a1N3V0FrRFNSSnNWS1EwZ29rNmtPby9p?=
 =?utf-8?B?YTlhblZYSUlXT2JnNjBQOW5mSzc5UnM3QmQrZU5NV2Z3WnREMkx1bW5OZXpB?=
 =?utf-8?B?TXZIeCtkYVAxUXRhTzR1V00rUktKUXFvNm1xWjJpZVh1NlBuMUJDYTZnNWds?=
 =?utf-8?B?QmZ0ckFzNlphckNyUkRLZ29OWHBrL0ZkdWU5UjZDaTZsWldJaUNla05BanAr?=
 =?utf-8?B?M1BiekJvU0ppUnFQRnlBb3YwRlh2cEw2Y0llRTZJR1UxYzFzRnBQUlY1M0VE?=
 =?utf-8?B?YWZHOWY3QUZ5SEZkZDd3RDU3VzFoQUxYL2twVXdBWm5weUZpM2RjT2tuanJN?=
 =?utf-8?B?dENlQ2RqRFJBeE9NZzVJZ2xEYXZQcjU3VjZLTkhnVU1HbC8xOE1hZXJHY0xT?=
 =?utf-8?B?YWREeklXU0ZEN1B0NlM0WW5oQVFZeWhTUzRzaE5jWk4vQk5qYnRRK2ZQMlRF?=
 =?utf-8?B?c2dVRGtkNTNxeXhmZGNVV2F6Q2hocFl4RDdtaVE0aXBZTHNySHcrN2dlTitB?=
 =?utf-8?B?eTQxWC9NZG8zUFd0eFYxNWQyKzVuVlMyM3NRU2xmeEVuT1ZlZTB5UVJMWUxq?=
 =?utf-8?B?eE40YXpKL0FYTExkZXVsOGdFdEJRRlNsVGRMYTdseEcxb2NLM1g5OFZPM1FJ?=
 =?utf-8?B?OW5jQTNVak8ya05QODVpczFPeW5vVTZLMjdCN0JOUk5SVWx5a2pNZ2VvaUdl?=
 =?utf-8?B?dlFTREEzb2lGazA2YW5PdnhiZVpGS2VvNzNYckNSZzJkM2tBa2xVakJjbVZ2?=
 =?utf-8?B?QUJXQ0xuZVdKRWdlM1BVUElxdy8xN1FRK05Sa1FiY2hHL0hhbnVTdERydklX?=
 =?utf-8?B?ZkhDMnp0Y0FmWjR6Y1lGdjBMc2RuaFZQd2lQT01FREh6NFQ3dXorU2NwUmtm?=
 =?utf-8?B?cjVQektZMGZMNkE0Z2FuK2xlbWlyWUZzZTNKd0cxYUllY0ZzRjBOcTVhZ3lZ?=
 =?utf-8?B?V0ZOTFVpOGtUazVEK2hpcnBIV0NlMU8vRElpbTlGUElLWkRmTDdCdGx4RHdu?=
 =?utf-8?B?ODQrWUdsaEIwT0JleVQwTTQyQnpxSmtSM1l4S1VRUlVXNmF5aDZCcVd4dlV3?=
 =?utf-8?B?VjEva1VSaEpwRG1KNzZwa2hxVHMyQkZ4L3JJR0t2R0cvUWgvbHlvRisxVkZP?=
 =?utf-8?B?OUZLM2Uya3RpZGhaVmlMOStYbzdqejZGTEtxeTdaeHVQN25NUzRUdEVxZ0dV?=
 =?utf-8?B?ZFhFR0Q3NXBrREpqZm9SWDV6UEdoUTd5MjRyV3dWNHEvNEIxSXVFZkErYmJk?=
 =?utf-8?B?UjA5WkFobEppM1RXQlBHb1VMT29pWXQzNmtuckVSNlBvOVNnemorcWhQOTdH?=
 =?utf-8?Q?m4nNCpV50Xmr4/IkPnmZsXuJPdoo6wLFBzP+a1O6eWdtY?=
X-MS-Exchange-AntiSpam-MessageData-1: TKLWH/JbIfuALw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1485342d-476c-4c17-eba4-08de52221051
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 21:32:19.2672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uiq8yUKXdR3jeuq8kn4VWzATBRziJ/oaKfX9FfL3Q1k+6TkTi/XRUUAuNpnhM7x0DXUxKEMs8Eo93jPROs5FKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7956


On 12/01/2026 21:14, Radu Rendec wrote:
> For redirected interrupts, irq_chip_redirect_set_affinity() does not
> update the effective affinity mask, which then triggers the warning in
> irq_validate_effective_affinity(). Also, because the effective affinity
> mask is empty, the cpumask_test_cpu(smp_processor_id(), m) condition in
> demux_redirect_remote() is always false, and the interrupt is always
> redirected, even if it's already running on the target CPU.
> 
> Set the effective affinity mask to be the same as the requested affinity
> mask. It's worth noting that irq_do_set_affinity() filters out offline
> CPUs before calling chip->irq_set_affinity() (unless `force` is set), so
> the mask passed to irq_chip_redirect_set_affinity() is already filtered.
> 
> The solution is not ideal because it may lie about the effective
> affinity of the demultiplexed ("child") interrupt. If the requested
> affinity mask includes multiple CPUs, the effective affinity, in
> reality, is the intersection between the requested mask and the
> demultiplexing ("parent") interrupt's effective affinity mask, plus
> the first CPU in the requested mask.
> 
> Accurately describing the effective affinity of the demultiplexed
> interrupt is not trivial because it requires keeping track of the
> demultiplexing interrupt's effective affinity. That is tricky in the
> context of CPU hot(un)plugging, where interrupt migration ordering is
> not guaranteed. The solution in the initial version of the fixed patch,
> which stored the first CPU of the demultiplexing interrupt's effective
> affinity in the `target_cpu` field, has its own drawbacks and
> limitations.
> 
> Fixes: fcc1d0dabdb6 ("genirq: Add interrupt redirection infrastructure")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/44509520-f29b-4b8a-8986-5eae3e022eb7@nvidia.com/
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>   kernel/irq/chip.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 433f1dd2b0ca7..35bc17bc369e0 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1493,6 +1493,8 @@ int irq_chip_redirect_set_affinity(struct irq_data *data, const struct cpumask *
>   	struct irq_redirect *redir = &irq_data_to_desc(data)->redirect;
>   
>   	WRITE_ONCE(redir->target_cpu, cpumask_first(dest));
> +	irq_data_update_effective_affinity(data, dest);
> +
>   	return IRQ_SET_MASK_OK;
>   }
>   EXPORT_SYMBOL_GPL(irq_chip_redirect_set_affinity);


This is working for me ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


