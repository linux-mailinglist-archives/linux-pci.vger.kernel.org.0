Return-Path: <linux-pci+bounces-39236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4382CC04403
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 05:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CA1A4E7F44
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 03:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5DF26ED29;
	Fri, 24 Oct 2025 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NPJ8qDNt"
X-Original-To: linux-pci@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19011004.outbound.protection.outlook.com [52.103.1.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D90726E146
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 03:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.1.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761276487; cv=fail; b=gm705jwgf+dzSCjuYHPpgnsYNgg2zz2DTD1Y9VJl0WW3pn0etaLpW3CabSkcKC7oNDe7psIniYUGJGOp3pRxDY36B2foIlhE8vke93gmkEO2eBAsUYStpd6pRzOkw2XHqG1bWfsk0xA3ASE/8XRpshlt8K2GmwWD656wGC+bDvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761276487; c=relaxed/simple;
	bh=h1bm83Qdz14MZjh2bDc9DHiT6UG81JwA25gncEyIapc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SXrP8AY6D3ZqRxneJ3+AOB65l/2E8g9RdRXQSspsQHhTZ8ANA5FiHDDGlm0gAof+ofzlZ1CHACjqO/Vb7Mt5s5KRgxZiWdxeAvzXPFUglH/3CQsEpXxyjQJpWuyVzu6xhoEJ4qHFyP5SVFTS0J2DBMOVMwW48lkeOvLeZrjGSs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NPJ8qDNt; arc=fail smtp.client-ip=52.103.1.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pls20RDHvbM4qRQc5YsjvrZcshlVaQu2WxsrxXZwiHzkVA5AOPlVGFCxGk/9XApJAxWOQqn8YaWbfo3jMz5A/64Co6TQrfYC9JKlgOKozc9/WP2JGFma8z33lYTps9eNxTrxczH7LBy8Gc7u0pqf0JNHw4GBl98HV4oHvgSwhfN9Cr9Tf5Bw31rdzfcEx8XjONqQ49ktZEWUNLowzeGsj84dAUAsS/bAYAnZRc0dS8c81qthXgpbKrkiHf+BsDCmMSqh1/jLBAc95YrvZvK+vsck8Hr0TmyB8KZXRSe0Qv6nHPxjHTUMIuZPwDL41RM+foZMWyOTr1fOrlWSGvS/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GG43WKmLO23GS8dNyMxTqTXO+Fe7eilFhO06UoOFLUQ=;
 b=QMC2YuqhhBQpIHF9jF2PJIxrQVdt+lHXNjL5xeWqEqZICuxAw0vI1QDAt/Y8pm+hKadtRqd76IuoO3eLmsPXW2wTYrXK9y36HFo9rZYbkm0PdEQ/OFK7lasHZLFhll/bztOGAVCaeUSrmCZtGBFPm+vcdRkRs1dUpG8vvzZTD9z9g1RoFwaYMnF0sOIq7+7jXbOvSKqrrbnQ9QVjuFPY4RnVweZ9NzhRJO1bPRHce8a3pqcUVGUativAnhRJBTpH9LDc7riJ/xqs2uIknrLhkGrnND0xKFqz81spP88KRtsB8OXLmh0iw0AkzUvbwKnrT1ssYNdMXl3Y1ko9qkxTpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GG43WKmLO23GS8dNyMxTqTXO+Fe7eilFhO06UoOFLUQ=;
 b=NPJ8qDNteUC5E8u936lD0e+KptPhNuG6GbxhGRX4saoAk+R/euymd/fiOcFhRcYIxO5vWwS0poZ6MrLokpxryXP2hgbczB+B5U2STeQbHsfV/IEmiSexG+kmSaNWKPcDsDVJpUFUgFXBkRJ/f/8GVCyWoku9/3ZS/0JfLgKZQDFcWIux0WdGAg9zU8sQlUSKsrKUDomQiSOPxHCNPaGlXmybVCARfB3iwl9bFiWjk2O+Ic/l1xHGqQLjrZfOR7fYIK7giTVvFUV1qnv+zhcvfDbMfiyPHw1+MkHpMWfsu4K2aEfSLAf93FGWahqwOTD/vUydpRiCN1TmCch8odNcNQ==
Received: from DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
 by PH8PR05MB9268.namprd05.prod.outlook.com (2603:10b6:510:1c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Fri, 24 Oct
 2025 03:27:57 +0000
Received: from DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c]) by DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 03:27:57 +0000
Message-ID:
 <DM4PR05MB102709E0A9C0CF0D62AEC3524C7F1A@DM4PR05MB10270.namprd05.prod.outlook.com>
Date: Fri, 24 Oct 2025 11:27:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251023164205.GA1299816@bhelgaas>
Content-Language: en-US
From: Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <20251023164205.GA1299816@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To DM4PR05MB10270.namprd05.prod.outlook.com
 (2603:10b6:8:180::11)
X-Microsoft-Original-Message-ID:
 <7bea0d58-b092-4546-8e97-a2b592cac507@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB10270:EE_|PH8PR05MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9d6e8d-5b01-4ab8-2eaf-08de12ad5300
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnoyTIwSrGph0lItVprk4CpisOKrAiZrTBifRcKTksSvdtyvOjiTx8kI+C0KWAYkFzUdLyCVaYbZpjaSm0FC7uzEeh3IhBfASlDPTaLyKroiCZMkooodyJgyeV7Pq6p2THBZ8uziJksDXF04bnFCpVhg21Y9x3L5mK/aLCs3SQnInvYPnKwfIutak2J/LVhhU+mxiUPpZu3sPVm7QQCsgchcdz4AL+bwo6wCVDSp9jWljxkEUwVNxaNfL0/GBoKs3R37xl2l+wOeP/Ek1/ukFWv3Y59EFdwiXVA9WyiVdMB0zjP4GOflXd3/3t8KykCyLP4SqGu+bYysvHbX3JvTYKvq0zkatxy6HgXTmce6MkQWUCv3ev5qoN60ELkL4W34lgA2CxaGeP9AOydfRmAsUOsvd4g3EjVENdq3BpDJapYRzCfwMYM2zqHxywRsFMA80P68tG4XrgfxgcHO+8ZGWEqikj/j1zBPxnZMKWEFO1KZ6b7T/58XM5suYxvQWQa2AGc1wdnZDvdLHl6z3VGbsXZrgvHW9iAxs4tE2LVhllKut8kUl0NrmvisF4RO7o3o7990FZAhlZOrX9SkU81iwPqsn1J50OXIS/8YkMFqq7hX6xWwQH4v795OsxFOTKGuWhUUeY7v9KyJKZXIuaUOLFTK5OoIcfFLPt4/N6gi1ccGGL4fR8mAW8v33qYNHROD1Oa9vHt1u/utyl/zpxyPim2jX2Oykxzjvlj7lcg3co3ZcAfDD3esjnfecI81/C6Nahc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|41001999006|8060799015|15080799012|13031999003|23021999003|461199028|19110799012|5072599009|6090799003|40105399003|53005399003|3412199025|440099028|19111999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXgraUh4aERTVWpaOERuUng5WnltVXkreUxIZlNBTnkyOWFVY2dyTkhvb1Ez?=
 =?utf-8?B?UW1oNWt2MjUvSUNMQ3VtcC9Udk4vRHJneHZzc3ZOVnRmejRDM2owNWhFb3VV?=
 =?utf-8?B?UEdqNXNNMC9xditxejBNQWV5OU9EL3AvZUhtajBzZUpBcTVSVXNaM0hpVG5X?=
 =?utf-8?B?Q1hSdWdObVFRb21peHBjTnVBRGtSVzJqZlkxUnN6VmJtbXBhTkgwT0FydTlC?=
 =?utf-8?B?bCszaGRvUm1ucTloVVNIeVlwRW5zLzB1RWVTRGhDLzdnN1h2Vnp4cEpEbHhB?=
 =?utf-8?B?MEhzeU02em9ONGExTm81RTlIYmhaVkpFdDhJQXhpb1BEeGdUOUcxSEZaN2pL?=
 =?utf-8?B?Zms2c1NIQ0dSWHBMUGk4SnRUSWdWWjZEMHQ4NzVYQW5MWkIzTStneWpQYzll?=
 =?utf-8?B?Y3hLMDdJS2paKzIxa3c3eVZJZlBWUHJ0VlNobzZrbFFsZGZmQU1YT3VPaTJX?=
 =?utf-8?B?VmlrL3pNSFY5L3RmaWRuMTRRUW1USW16eG9KUUpYU3VPWnQzdmhOSktyQkV6?=
 =?utf-8?B?R3FaTVBtK0F0L2ZiRE4xdEZCZ2I5UURObGxTYTRXT0YwY2Q0SVA1bmgveWR5?=
 =?utf-8?B?TXVTV3FSaXpQMzlyajhhTWdHYVU5R25rU2VZNUJDZkNaSHBTV1JBSFROZElq?=
 =?utf-8?B?QTlLbGdaZGV3T1RhcEZiOWNsYys0azlXdkNrWTAzTDVaN2hIY3Y1bGNsQVUr?=
 =?utf-8?B?UkY2d0VjYUpmcjE1cHdtYnIzcnpHbFBVckN4WlJyRlNUaC9oNkkzUzgrWE1Q?=
 =?utf-8?B?ZkRHVUZFRlpyL2lNRU4zOUxkMFIxTDF6T2F0cXhkSldHMFpSWWNRYXBmZjNm?=
 =?utf-8?B?VDAxTjhJcnFnakp4OUhZL2xsdzZXeVFROFVrdDdnazArUHVMbFYrY2EyLzN2?=
 =?utf-8?B?TzRwNVRVckRpbkh6ampqMXI3RHZXZ1dSZ2V5T052ckZzeW5JcWMybXVaK09u?=
 =?utf-8?B?MDRyNWJnbExWc3ZSTUFwTGNIb2dtZnJIUDlDRTh5OXcxS0wvbFZodm50Y3RX?=
 =?utf-8?B?RlhWOG95QWJWZUtNN3E2bzJOZjQ4eHE0a1pSdTFGc3BjUzRmMnB2OFg2VHY0?=
 =?utf-8?B?d3hlaHZhOGJmb1FsOENzTUkvWWVXOXJSOW13c2l1amJrZDlsL0RJY2FobVJD?=
 =?utf-8?B?UDJ0MitPK0trcGlieVRKSDJVVnRJY1gwOStKbk1hKytsaEtDa1huaklaeUtM?=
 =?utf-8?B?QnVrRVU4dGVXVHZwRlozUXRVYnBraHhpM1lSSXdnSFdjaGx2aWRNdXpid0Z6?=
 =?utf-8?B?WVFVdTd0eVdldVJXd01tMC9mY2FrbFV1UkZRZ0djQkJWa2xrbUQwTnJ6Q25l?=
 =?utf-8?B?cGtTU3daRFBreXBGcC9vdldGbnlKTzZMejZNR010UzhtaDc5UnFxbWxqclNV?=
 =?utf-8?B?Q3RubXNmSVVWbnRMbHZFeER4bjBtalJ4Uk1ONjZZMFpxUFR6dHFIQm1yYzMr?=
 =?utf-8?B?eUVMM3B5WjNHUG9hbllpZE53NVN6VDNGR0tHWmpRaVF2WHQ2VlJRK3ZmSkRt?=
 =?utf-8?B?cTloRTZJaDNDTXpld1diS1VNTjhQR2FBOHdQZFBqeldPcFIrNUpwMEYzbGFK?=
 =?utf-8?B?Q0NhM21jQVFjUHE2d2JmWVZuSXRhVmJWeDY3by9KOHluQkRYcnU5dzJ5QUdi?=
 =?utf-8?B?V0VleklUMVMraUMyaTBkb09kdHc1WlNtaXlhZHdDbjVISFFsVm9BMlp6UDJx?=
 =?utf-8?B?cnhyVS9Gd0pmQzgvaVA0NnV3N09PNFRMTTRpMks5SUpiZHNuK2d6ZVhBTDZ6?=
 =?utf-8?B?cUxzdHE2aHdBTjZQcW5vaGJzQnNLVXlxU3JBMUdyZGt3TUhoKzJGREhEeXpx?=
 =?utf-8?Q?ooQ1ki0VNRHxPmxjHez1bRkUFryR5BJk9T6CI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U1cyTnNVSmQ1ZGNMQnhpRVF0UkpDSG1UWC9scU94a2U0b3FRbEVjejZCb1VL?=
 =?utf-8?B?WVNnUHZGZlZlM1NXVTA2NnVDQnYydVBqMUJVR1FOM0dYeFhVZUN0YVltdWdG?=
 =?utf-8?B?RkdhTGppTVY5ZHZYVjF4d2JPNUhXa3lLZGMvTDZldnRsWUNtV0NyWlQ5eXVQ?=
 =?utf-8?B?T3ZhZmx0aFFqZysrdk1UUUlYM2FpM3NIdFA2VDRhVkRTNzhKejBETXlITHE3?=
 =?utf-8?B?ZERnbncyREppSkpVMTNKbElVTzlDcXg2Y1UyemRYQ3lqQWVIZjdtTUYvZzVF?=
 =?utf-8?B?M3E4WmhOc3E4Y2JYUlphaGRtQzliNjNrdVhPWDRPeHVJV2ZmdFpwbHJVTmxN?=
 =?utf-8?B?Rk1xTFc4aWNzZUd6YUlGbGJDSEtwNHJacFpaWjBvQkEvWVp5NTl1dWVNb3lC?=
 =?utf-8?B?bWFZS1NZdDlmRFhLcmZpdVc3cVN3aTg4cG5LTUtvOW5OZ1R0Mk85TXIrVkRC?=
 =?utf-8?B?aFZuUlVBakE1cXVWcTFpcHpLSzRiMERjYy96NDZwdzZ5MkFBTGhnZy8zUlBN?=
 =?utf-8?B?RWlpWmV1cCtLS3l4NFR3eTNRdkt0bHVhNkpYenlLKzNCYlRRcHdRMTFDaGRy?=
 =?utf-8?B?Q2p6VVNURlJFcE51N3kxREFGRzgva2NTUkduMmlqeXpyaVRKbHlxb1A1NGR1?=
 =?utf-8?B?dHVHQjNKQmFlUGtPcWxKblFnVTRYSUdSYUIwMUxtRVBBWkZNOWgxRHRoaVNy?=
 =?utf-8?B?TFdkMHlTb0FWaCt3SUJ3VzNkZTVUOHF0RnZoSTY2T2NEUEMzd1JnUFA1SHg5?=
 =?utf-8?B?UUIyOGpVeDM2Q2E1SDA3cDRsaWlRZzJTR3BjRDJTYm5MUis1Z1dzZk0vT2tG?=
 =?utf-8?B?T21RNlZXNU1SWC9NeUY2ZlNvdlpZRXc0MlQzMG1vcEVRdE82aUZoc00rbTcy?=
 =?utf-8?B?ekg0aUJVZHpmNG9KSDYyeEhkcGhQa0s2VmttRFpibUIrdHRjOVFxZWJkcHVI?=
 =?utf-8?B?OUZhaDE3ekpuSFZUV2loMXJoQW1kbDJBbFl6ZG9pS1FlNDJ0SWNyOTFjbmx6?=
 =?utf-8?B?eXIzWDYzVFlNQXU1NFZOVzduc1NaUkpoY21jQmgzeEdxejhpYlAzRlVmay9w?=
 =?utf-8?B?S3MxS2lmbEltcTdKVVh0a1V3cU14elFoKzVVNnJrbUE4Mm1weCs1ajF3bXJa?=
 =?utf-8?B?bElTQ2FiQVhOZks0dzJ6eTlQK3poUHFucUorTm9tdVRxZ0RDRXVuMnBxTjhx?=
 =?utf-8?B?UGNQSUtRdVZYZmJwTjRBTk9TY0tOc2pTM29FdHZ2dEtJVWl4b0Q1NmdDZyt1?=
 =?utf-8?B?ZjJvajRPUWVnRmQ4ZWtIR0R3TUZtMmIraE5jUUExQjJwUjAyaGpYb0pWbi9u?=
 =?utf-8?B?b090NGtUWi9uampZRGJxbHlhejlmcDF0Q3UwRCtqVFRuK05FeEgxZGNhQlZj?=
 =?utf-8?B?VlVwc2gzek9zT2ZhSlhBNzdBUDZjaXV1ejA3L3RvODg0N0d3MzZNeWwrQ0xj?=
 =?utf-8?B?aUttd3BBVlhaVWsrZEdxYTRQckVtWHJRcENDUjBUZlV4SlRnQ3cyM0hObE0v?=
 =?utf-8?B?SDJESWNjWG83ZTk5NTg5SHM3bTJkc3RkWlp3cDlvTHhyeGZ6ODJianVPelJ6?=
 =?utf-8?B?bzEwdEl0ZTFiZFFnOW9XWXBBbVVDa2hBT016ci9VMHgraGlvaDlFM3Z4MGNW?=
 =?utf-8?B?U2xudmNXZi8zNi9QRWYvd1V3TE1tRWRlSUdlY0x3VERJdEtHeVJoNm1PQ0Ja?=
 =?utf-8?Q?k+U8LSk3NUrWClGP88P6?=
X-OriginatorOrg: sct-15-20-8534-9-msonline-outlook-d08a8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9d6e8d-5b01-4ab8-2eaf-08de12ad5300
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB10270.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 03:27:57.4920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR05MB9268

On 10/24/2025 12:42 AM, Bjorn Helgaas wrote:
> [+cc Meson folks, Krishna, author of c96992a24bec]
> 
> On Thu, Oct 23, 2025 at 11:33:07AM +0000, Linnaea Lavia wrote:
>> I'm getting the following in dmesg after installing 6.18-rc1 on a VIM3 board.
>>
>> [    5.391324] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
>> [    5.411265] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
>> [    5.415323] [     T50] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
>> [    5.422278] [     T50] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
>> [    5.442280] [     T50] meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
>> [    5.449631] [     T50] meson-pcie fc000000.pcie: Add PCIe port failed, -16
>> [    5.458779] [     T50] meson-pcie fc000000.pcie: probe with driver meson-pcie failed with error -16
>>
>> I think the problem is related to c96992a24bec("PCI: dwc: Add
>> support for ELBI resource mapping") and 2f2cea1ea70a("PCI:
>> dwc/meson: Rework PCI config and DW port logic register accesses"),
>> as they're both trying to map ELBI/DBI registers.
> 
> Thanks for the report!  Can you post complete dmesg logs for working
> and broken boots, e.g., v6.17 and v6.18-rc1?
> 

On 6.17.4

[    0.000000] [      T0] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] [      T0] Linux version 6.17.4 (geeko@buildhost) (gcc (SUSE Linux) 15.1.1 20250714, GNU ld (GNU Binutils; SUSE Linux 16) 2.43.1.20241209-160000.2) #1 SMP PREEMPT_DYNAMIC Mon Oct 20 09:22:09 UTC 2025 (b07233b)
[    0.000000] [      T0] KASLR enabled
[    0.000000] [      T0] Machine model: Khadas VIM3
[    0.000000] [      T0] efi: EFI v2.10 by Das U-Boot
[    0.000000] [      T0] efi: RTPROP=0xefed5040 SMBIOS=0xefefc000 RNG=0xedc4d040 MEMRESERVE=0xe7d51040
[    0.000000] [      T0] random: crng init done
[    0.000000] [      T0] Reserved memory: created CMA memory pool at 0x00000000c9800000, size 480 MiB
[    0.000000] [      T0] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] [      T0] OF: reserved mem: 0x00000000c9800000..0x00000000e77fffff (491520 KiB) map reusable linux,cma
[    0.000000] [      T0] OF: reserved mem: 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable secmon@5000000
[    0.000000] [      T0] OF: reserved mem: 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap non-reusable secmon@5300000
[    0.000000] [      T0] Zone ranges:
[    0.000000] [      T0]   DMA      [mem 0x0000000000000000-0x00000000f4ffffff]
[    0.000000] [      T0]   DMA32    empty
[    0.000000] [      T0]   Normal   empty
[    0.000000] [      T0]   Device   empty
[    0.000000] [      T0] Movable zone start for each node
[    0.000000] [      T0] Early memory node ranges
[    0.000000] [      T0]   node   0: [mem 0x0000000000000000-0x0000000004ffffff]
[    0.000000] [      T0]   node   0: [mem 0x0000000005000000-0x00000000072fffff]
[    0.000000] [      T0]   node   0: [mem 0x0000000007300000-0x00000000efed4fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed5000-0x00000000efed5fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed6000-0x00000000efed6fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed7000-0x00000000efed8fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed9000-0x00000000efed9fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efeda000-0x00000000efef9fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efefa000-0x00000000efefbfff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efefc000-0x00000000efefcfff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efefd000-0x00000000f2f0ffff]
[    0.000000] [      T0]   node   0: [mem 0x00000000f2f10000-0x00000000f2f1ffff]
[    0.000000] [      T0]   node   0: [mem 0x00000000f2f20000-0x00000000f4e5afff]
[    0.000000] [      T0]   node   0: [mem 0x00000000f4e5b000-0x00000000f4ffffff]
[    0.000000] [      T0] Initmem setup node 0 [mem 0x0000000000000000-0x00000000f4ffffff]
[    0.000000] [      T0] On node 0, zone DMA: 12288 pages in unavailable ranges
[    0.000000] [      T0] psci: probing for conduit method from DT.
[    0.000000] [      T0] psci: PSCIv1.0 detected in firmware.
[    0.000000] [      T0] psci: Using standard PSCI v0.2 function IDs
[    0.000000] [      T0] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] [      T0] psci: SMC Calling Convention v1.1
[    0.000000] [      T0] RME: RMM doesn't support RSI version 1.0. Supported range: 1.0-0.0
[    0.000000] [      T0] percpu: Embedded 56 pages/cpu s103704 r8192 d117480 u229376
[    0.000000] [      T0] pcpu-alloc: s103704 r8192 d117480 u229376 alloc=56*4096
[    0.000000] [      T0] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
[    0.000000] [      T0] Detected VIPT I-cache on CPU0
[    0.000000] [      T0] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] [      T0] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] [      T0] alternatives: applying boot alternatives
[    0.000000] [      T0] Kernel command line: BOOT_IMAGE=/boot/Image-6.17.4 root=UUID=6a42b9d0-571c-4394-9ebb-c9a490151bba rd.timeout=15 mitigations=off delayacct
[    0.000000] [      T0] printk: log_buf_len individual max cpu contribution: 32768 bytes
[    0.000000] [      T0] printk: log_buf_len total cpu_extra contributions: 163840 bytes
[    0.000000] [      T0] printk: log_buf_len min size: 262144 bytes
[    0.000000] [      T0] printk: log buffer data + meta data: 524288 + 1835008 = 2359296 bytes
[    0.000000] [      T0] printk: early log buf free: 258728(98%)
[    0.000000] [      T0] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] [      T0] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] [      T0] software IO TLB: SWIOTLB bounce buffer size adjusted to 3MB
[    0.000000] [      T0] software IO TLB: area num 8.
[    0.000000] [      T0] software IO TLB: mapped [mem 0x00000000f3894000-0x00000000f3c94000] (4MB)
[    0.000000] [      T0] Built 1 zonelists, mobility grouping on.  Total pages: 1003520
[    0.000000] [      T0] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] [      T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] [      T0] ftrace: allocating 46334 entries in 182 pages
[    0.000000] [      T0] ftrace: allocated 182 pages with 5 groups
[    0.000000] [      T0] Dynamic Preempt: voluntary
[    0.000000] [      T0] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] [      T0] rcu:  RCU event tracing is enabled.
[    0.000000] [      T0] rcu:  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=6.
[    0.000000] [      T0]       Trampoline variant of Tasks RCU enabled.
[    0.000000] [      T0]       Rude variant of Tasks RCU enabled.
[    0.000000] [      T0]       Tracing variant of Tasks RCU enabled.
[    0.000000] [      T0] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] [      T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] [      T0] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.000000] [      T0] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.000000] [      T0] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.000000] [      T0] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] [      T0] Root IRQ handler: gic_handle_irq
[    0.000000] [      T0] GIC: Using split EOI/Deactivate mode
[    0.000000] [      T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] [      T0] arch_timer: cp15 timer(s) running at 24.00MHz (phys).
[    0.000000] [      T0] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000001] [      T0] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000494] [      T0] Console: colour dummy device 80x25
[    0.000510] [      T0] printk: legacy console [tty0] enabled
[    0.001397] [      T0] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.001426] [      T0] pid_max: default: 32768 minimum: 301
[    0.001619] [      T0] LSM: initializing lsm=capability,apparmor,bpf,ima,evm
[    0.002014] [      T0] AppArmor: AppArmor initialized
[    0.002512] [      T0] LSM support for eBPF active
[    0.002820] [      T0] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.002858] [      T0] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.004129] [      T0] spectre-v4 mitigation disabled by command-line option
[    0.005933] [      T1] rcu: Hierarchical SRCU implementation.
[    0.005974] [      T1] rcu:  Max phase no-delay instances is 1000.
[    0.006236] [      T1] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.007605] [      T1] Remapping and enabling EFI services.
[    0.008167] [      T1] smp: Bringing up secondary CPUs ...
[    0.008999] [      T0] Detected VIPT I-cache on CPU1
[    0.009196] [      T0] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.010553] [      T0] CPU features: detected: Spectre-v2
[    0.010569] [      T0] CPU features: detected: Spectre-v4
[    0.010573] [      T0] CPU features: detected: Spectre-BHB
[    0.010577] [      T0] CPU features: detected: ARM erratum 858921
[    0.010588] [      T0] Detected VIPT I-cache on CPU2
[    0.010714] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.010732] [      T0] arch_timer: CPU2: Trapping CNTVCT access
[    0.010743] [      T0] CPU2: Booted secondary processor 0x0000000100 [0x410fd092]
[    0.011514] [      T0] Detected VIPT I-cache on CPU3
[    0.011610] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.011620] [      T0] arch_timer: CPU3: Trapping CNTVCT access
[    0.011627] [      T0] CPU3: Booted secondary processor 0x0000000101 [0x410fd092]
[    0.012468] [      T0] Detected VIPT I-cache on CPU4
[    0.012564] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.012574] [      T0] arch_timer: CPU4: Trapping CNTVCT access
[    0.012581] [      T0] CPU4: Booted secondary processor 0x0000000102 [0x410fd092]
[    0.013318] [      T0] Detected VIPT I-cache on CPU5
[    0.013416] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.013426] [      T0] arch_timer: CPU5: Trapping CNTVCT access
[    0.013433] [      T0] CPU5: Booted secondary processor 0x0000000103 [0x410fd092]
[    0.013524] [      T1] smp: Brought up 1 node, 6 CPUs
[    0.013770] [      T1] SMP: Total of 6 processors activated.
[    0.013783] [      T1] CPU: All CPU(s) started at EL2
[    0.013808] [      T1] CPU features: detected: 32-bit EL0 Support
[    0.013821] [      T1] CPU features: detected: 32-bit EL1 Support
[    0.013838] [      T1] CPU features: detected: CRC32 instructions
[    0.013860] [      T1] CPU features: detected: PMUv3
[    0.013937] [      T1] alternatives: applying system-wide alternatives
[    0.015142] [      T1] CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
[    0.037577] [     T47] node 0 deferred pages initialised in 20ms
[    0.037659] [      T1] Memory: 3332424K/4014080K available (14848K kernel code, 2598K rwdata, 11596K rodata, 7424K init, 721K bss, 184396K reserved, 491520K cma-reserved)
[    0.038637] [      T1] devtmpfs: initialized
[    0.048887] [      T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.048957] [      T1] posixtimers hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.049023] [      T1] futex hash table entries: 2048 (131072 bytes on 1 NUMA nodes, total 128 KiB, linear).
[    0.052878] [      T1] 2G module region forced by RANDOMIZE_MODULE_REGION_FULL
[    0.052910] [      T1] 0 pages in range for non-PLT usage
[    0.052914] [      T1] 514928 pages in range for PLT usage
[    0.053198] [      T1] pinctrl core: initialized pinctrl subsystem
[    0.053877] [      T1] SMBIOS 3.0 present.
[    0.053899] [      T1] DMI: khadas VIM3/VIM3, BIOS 2024.01-rc4-00039-gce25ceb939 01/01/2024
[    0.053921] [      T1] DMI: Memory slots populated: 0/0
[    0.055931] [      T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.056798] [      T1] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.057055] [      T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.057356] [      T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.057416] [      T1] audit: initializing netlink subsys (disabled)
[    0.057566] [     T58] audit: type=2000 audit(0.056:1): state=initialized audit_enabled=0 res=1
[    0.058816] [      T1] thermal_sys: Registered thermal governor 'fair_share'
[    0.058822] [      T1] thermal_sys: Registered thermal governor 'bang_bang'
[    0.058836] [      T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.058847] [      T1] thermal_sys: Registered thermal governor 'user_space'
[    0.058857] [      T1] thermal_sys: Registered thermal governor 'power_allocator'
[    0.058903] [      T1] cpuidle: using governor ladder
[    0.058945] [      T1] cpuidle: using governor menu
[    0.059085] [      T1] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.059205] [      T1] ASID allocator initialised with 32768 entries
[    0.059400] [      T1] Serial: AMBA PL011 UART driver
[    0.066121] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.066511] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.066563] [      T1] /soc/vpu@ff900000: Fixed dependency cycle(s) with /soc/bus@ff600000/hdmi-tx@0
[    0.066591] [      T1] /soc/interrupt-controller@ffc01000: Fixed dependency cycle(s) with /soc/interrupt-controller@ffc01000
[    0.066677] [      T1] /soc/usb@ffe09000: Fixed dependency cycle(s) with /soc/bus@ff800000/i2c@5000/usb-typec@22/connector
[    0.067279] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.067684] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.072817] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.074031] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.074537] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.074603] [      T1] /soc/vpu@ff900000: Fixed dependency cycle(s) with /soc/bus@ff600000/hdmi-tx@0
[    0.076836] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.076907] [      T1] /soc/usb@ffe09000: Fixed dependency cycle(s) with /soc/bus@ff800000/i2c@5000/usb-typec@22/connector
[    0.079911] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /hdmi-connector
[    0.079985] [      T1] /hdmi-connector: Fixed dependency cycle(s) with /soc/bus@ff600000/hdmi-tx@0
[    0.081962] [      T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.081986] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.081999] [      T1] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.082011] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.082023] [      T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.082034] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.082045] [      T1] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.082057] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.083745] [      T1] fbcon: Taking over console
[    0.084330] [      T1] iommu: Default domain type: Translated
[    0.084349] [      T1] iommu: DMA domain TLB invalidation policy: strict mode
[    0.086812] [      T1] pps_core: LinuxPPS API ver. 1 registered
[    0.086827] [      T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.086850] [      T1] PTP clock support registered
[    0.086882] [      T1] EDAC MC: Ver: 3.0.0
[    0.086977] [      T1] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.087116] [      T1] scmi_core: SCMI protocol bus registered
[    0.087263] [      T1] efivars: Registered efivars operations
[    0.088323] [      T1] NetLabel: Initializing
[    0.088337] [      T1] NetLabel:  domain hash size = 128
[    0.088348] [      T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.088416] [      T1] NetLabel:  unlabeled traffic allowed by default
[    0.088437] [      T1] mctp: management component transport protocol core
[    0.088447] [      T1] NET: Registered PF_MCTP protocol family
[    0.088690] [      T1] vgaarb: loaded
[    0.088973] [      T1] clocksource: Switched to clocksource arch_sys_counter
[    0.089462] [      T1] VFS: Disk quotas dquot_6.6.0
[    0.089502] [      T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.090167] [      T1] AppArmor: AppArmor Filesystem Enabled
[    0.095274] [      T1] NET: Registered PF_INET protocol family
[    0.095477] [      T1] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.129172] [      T1] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.129234] [      T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.129308] [      T1] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.129483] [      T1] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.129804] [      T1] TCP: Hash tables configured (established 32768 bind 32768)
[    0.130059] [      T1] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
[    0.130156] [      T1] UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.130242] [      T1] UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.130482] [      T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.130523] [      T1] NET: Registered PF_XDP protocol family
[    0.130580] [      T1] PCI: CLS 0 bytes, default 64
[    0.130785] [     T50] Trying to unpack rootfs image as initramfs...
[    0.135620] [      T1] kvm [1]: nv: 567 coarse grained trap handlers
[    0.135994] [      T1] kvm [1]: IPA Size Limit: 40 bits
[    0.137875] [      T1] kvm [1]: vgic interrupt IRQ9
[    0.137932] [      T1] kvm [1]: Hyp nVHE mode initialized successfully
[    0.142901] [      T1] Initialise system trusted keyrings
[    0.142954] [      T1] Key type blacklist registered
[    0.143126] [      T1] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    0.144262] [      T1] integrity: Platform Keyring initialized
[    0.144300] [      T1] integrity: Machine keyring initialized
[    0.144311] [      T1] Allocating IMA blacklist keyring.
[    0.184509] [      T1] Key type asymmetric registered
[    0.184541] [      T1] Asymmetric key parser 'x509' registered
[    0.184668] [      T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.184859] [      T1] io scheduler mq-deadline registered
[    0.184878] [      T1] io scheduler kyber registered
[    0.184961] [      T1] io scheduler bfq registered
[    0.186166] [      T1] irq_meson_gpio: 100 to 8 gpio interrupt mux initialized
[    0.192182] [      T1] ledtrig-cpu: registered to indicate activity on CPUs
[    0.201900] [      T1] soc soc0: Amlogic Meson G12B (A311D) Revision 29:b (10:2) Detected
[    0.203287] [      T1] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.211113] [      T1] Serial: AMBA driver
[    0.212016] [      T1] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.212065] [      T1] printk: legacy console [ttyAML0] enabled
[    0.580368] [     T50] Freeing initrd memory: 23008K
[    0.593808] [      T1] ffd24000.serial: ttyAML6 at MMIO 0xffd24000 (irq = 15, base_baud = 1500000) is a meson_uart
[    1.823937] [      T1] serial serial0: tty port ttyAML6 registered
[    1.830386] [      T1] msm_serial: driver initialized
[    1.837522] [      T1] mousedev: PS/2 mouse device common for all mice
[    1.841715] [      T1] meson-sm: secure-monitor enabled
[    1.845501] [      T1] hid: raw HID events driver (C) Jiri Kosina
[    1.851993] [     T77] watchdog: NMI not fully supported
[    1.856165] [     T77] watchdog: Hard watchdog permanently disabled
[    1.857393] [      T1] drop_monitor: Initializing network drop monitor service
[    1.869376] [      T1] NET: Registered PF_INET6 protocol family
[    1.875534] [      T1] Segment Routing with IPv6
[    1.879052] [      T1] RPL Segment Routing with IPv6
[    1.883742] [      T1] In-situ OAM (IOAM) with IPv6
[    1.893603] [      T1] registered taskstats version 1
[    1.924118] [      T1] zswap: loaded using pool zstd/zsmalloc
[    1.924229] [      T1] page_owner is disabled
[    1.928369] [      T1] Key type .fscrypt registered
[    1.932706] [      T1] Key type fscrypt-provisioning registered
[    1.938847] [      T1] Key type big_key registered
[    1.998514] [      T1] Key type encrypted registered
[    1.998575] [      T1] AppArmor: AppArmor sha256 policy hashing enabled
[    2.004095] [      T1] ima: secureboot mode disabled
[    2.008618] [      T1] ima: No TPM chip found, activating TPM-bypass!
[    2.030640] [      T1] ima: Allocated hash algorithm: sha256
[    2.036044] [      T1] ima: No architecture policies found
[    2.041236] [      T1] evm: Initialising EVM extended attributes:
[    2.046998] [      T1] evm: security.selinux
[    2.050982] [      T1] evm: security.SMACK64 (disabled)
[    2.055921] [      T1] evm: security.SMACK64EXEC (disabled)
[    2.061208] [      T1] evm: security.SMACK64TRANSMUTE (disabled)
[    2.066928] [      T1] evm: security.SMACK64MMAP (disabled)
[    2.072214] [      T1] evm: security.apparmor
[    2.076287] [      T1] evm: security.ima
[    2.079927] [      T1] evm: security.capability
[    2.084174] [      T1] evm: HMAC attrs: 0x1
[    2.101071] [     T50] simple-framebuffer f4e5b000.framebuffer: [drm] Registered 1 planes with drm panic
[    2.104670] [     T50] [drm] Initialized simpledrm 1.0.0 for f4e5b000.framebuffer on minor 0
[    2.115234] [     T50] Console: switching to colour frame buffer device 90x36
[    2.120593] [     T50] simple-framebuffer f4e5b000.framebuffer: [drm] fb0: simpledrmdrmfb frame buffer device
[    2.162151] [      T1] clk: Disabling unused clocks
[    2.162525] [      T1] PM: genpd: Disabling unused power domains
[    2.176852] [      T1] Freeing unused kernel memory: 7424K
[    2.221979] [      T1] Checked W+X mappings: passed, no W+X pages found
[    2.222888] [      T1] Run /init as init process
[    2.227078] [      T1]   with arguments:
[    2.227085] [      T1]     /init
[    2.227090] [      T1]   with environment:
[    2.227094] [      T1]     HOME=/
[    2.227098] [      T1]     TERM=linux
[    2.241253] [      T1] systemd[1]: System time advanced to built-in epoch: Thu 2025-07-31 14:32:25 UTC
[    2.280011] [      T1] systemd[1]: Successfully made /usr/ read-only.
[    2.289042] [      T1] systemd[1]: systemd 257.7+suse.19.ga0dfd5de4c running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE -SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[    2.324212] [      T1] systemd[1]: Detected architecture arm64.
[    2.325827] [      T1] systemd[1]: Running in initrd.
[    2.353290] [      T1] systemd[1]: Hostname set to <linux-g12b>.
[    2.570749] [      T1] systemd[1]: Queued start job for default target Initrd Default Target.
[    2.606120] [      T1] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    2.625192] [      T1] systemd[1]: Expecting device /dev/disk/by-uuid/6a42b9d0-571c-4394-9ebb-c9a490151bba...
[    2.645084] [      T1] systemd[1]: Expecting device /dev/disk/by-uuid/CE59-EAEA...
[    2.661228] [      T1] systemd[1]: Reached target Initrd /usr File System.
[    2.677189] [      T1] systemd[1]: Reached target Path Units.
[    2.689160] [      T1] systemd[1]: Reached target Slice Units.
[    2.701238] [      T1] systemd[1]: Reached target Swaps.
[    2.713187] [      T1] systemd[1]: Reached target Timer Units.
[    2.725695] [      T1] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.741532] [      T1] systemd[1]: Listening on Journal Sockets.
[    2.753585] [      T1] systemd[1]: Listening on udev Control Socket.
[    2.769399] [      T1] systemd[1]: Listening on udev Kernel Socket.
[    2.789219] [      T1] systemd[1]: Reached target Socket Units.
[    2.804616] [      T1] systemd[1]: Starting Create List of Static Device Nodes...
[    2.855446] [      T1] systemd[1]: Starting Journal Service...
[    2.875713] [      T1] systemd[1]: Starting Load Kernel Modules...
[    2.898878] [      T1] systemd[1]: Starting Virtual Console Setup...
[    2.919643] [      T1] systemd[1]: Finished Create List of Static Device Nodes.
[    2.940780] [      T1] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    2.953107] [    T152] systemd-journald[152]: Collecting audit messages is disabled.
[    2.971443] [    T153] zram: Added device: zram0
[    2.975736] [      T1] systemd[1]: Finished Load Kernel Modules.
[    2.980599] [      T1] systemd[1]: Starting Apply Kernel Variables...
[    2.986763] [      T1] systemd[1]: Started Journal Service.
[    3.628979] [    T274] raid6: neonx8   gen()  2660 MB/s
[    3.696978] [    T274] raid6: neonx4   gen()  2924 MB/s
[    3.764973] [    T274] raid6: neonx2   gen()  2343 MB/s
[    3.832981] [    T274] raid6: neonx1   gen()  1780 MB/s
[    3.900987] [    T274] raid6: int64x8  gen()  1201 MB/s
[    3.968984] [    T274] raid6: int64x4  gen()  1407 MB/s
[    4.036989] [    T274] raid6: int64x2  gen()  1358 MB/s
[    4.104979] [    T274] raid6: int64x1  gen()  1093 MB/s
[    4.105736] [    T274] raid6: using algorithm neonx4 gen() 2924 MB/s
[    4.176975] [    T274] raid6: .... xor() 2182 MB/s, rmw enabled
[    4.177616] [    T274] raid6: using neon recovery algorithm
[    4.187998] [    T274] xor: measuring software checksum speed
[    4.189640] [    T274]    8regs           :  3978 MB/sec
[    4.194347] [    T274]    32regs          :  4201 MB/sec
[    4.199544] [    T274]    arm64_neon      :  3107 MB/sec
[    4.203471] [    T274] xor: using function: 32regs (4201 MB/sec)
[    4.470939] [    T274] Btrfs loaded, assert=on, zoned=yes, fsverity=yes
[    5.163979] [    T306] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    5.249320] [    T338] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    5.252896] [    T307] pca953x 0-0020: using no AI
[    5.259129] [     T45] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.260109] [    T303] meson-vrtc ff8000a8.rtc: registered as rtc1
[    5.273053] [    T307] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    5.274684] [     T45] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.289867] [     T45] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.297925] [     T45] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.307114] [     T45] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
[    5.352480] [    T302] meson-drm ff900000.vpu: Queued 1 outputs on vpu
[    5.353749] [    T313] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    5.355846] [     T45] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.359076] [    T313] dwc3-meson-g12a ffe09000.usb: USB3 ports: 0
[    5.379709] [     T45] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
[    5.382559] [     T45] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
[    5.388871] [     T45] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.396188] [     T45] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    5.402825] [    T290] Console: switching to colour dummy device 80x25
[    5.402870] [     T45] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
[    5.415578] [     T45] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
[    5.423485] [     T45] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.430349] [     T45] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.436191] [     T45] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.442955] [     T45] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.450406] [     T45] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.458363] [     T45] pci 0000:00:00.0: supports D1
[    5.463040] [     T45] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.474323] [     T45] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
[    5.480785] [     T45] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    5.487467] [     T28] mmc1: new HS200 MMC card at address 0001
[    5.487771] [     T45] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    5.502681] [     T45] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    5.510581] [     T45] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.526115] [    T290] meson-drm ff900000.vpu: CVBS Output connector not available
[    5.526498] [     T45] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
[    5.533861] [    T291] rtc-hym8563 0-0051: registered as rtc0
[    5.540761] [     T45] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
[    5.540796] [     T45] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
[    5.552322] [    T291] rtc-hym8563 0-0051: setting system clock to 2025-10-23T16:12:22 UTC (1761235942)
[    5.554001] [     T45] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.556100] [    T295] mmcblk1: mmc1:0001 BJTD4R 29.1 GiB
[    5.558738] [    T311] usbcore: registered new interface driver usbfs
[    5.558784] [    T311] usbcore: registered new interface driver hub
[    5.558827] [    T311] usbcore: registered new device driver usb
[    5.563157] [    T295]  mmcblk1: p1 p2 p3
[    5.571003] [     T45] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    5.571018] [     T45] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    5.577056] [    T290] meson-dw-hdmi ff600000.hdmi-tx: Detected HDMI TX controller v2.01a with HDCP (meson_dw_hdmi_phy)
[    5.582037] [     T45] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
[    5.584045] [    T295] mmcblk1boot0: mmc1:0001 BJTD4R 4.00 MiB
[    5.589372] [    T290] meson-dw-hdmi ff600000.hdmi-tx: registered DesignWare HDMI I2C bus driver
[    5.594140] [     T45] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    5.594943] [     T45] pcieport 0000:00:00.0: PME: Signaling with IRQ 22
[    5.598866] [    T295] mmcblk1boot1: mmc1:0001 BJTD4R 4.00 MiB
[    5.603023] [    T290] meson-drm ff900000.vpu: bound ff600000.hdmi-tx (ops meson_dw_hdmi_ops [meson_dw_hdmi])
[    5.603247] [    T295] mmcblk1rpmb: mmc1:0001 BJTD4R 4.00 MiB, chardev (234:0)
[    5.608166] [     T45] pcieport 0000:00:00.0: AER: enabled with IRQ 22
[    5.612195] [    T290] meson-drm ff900000.vpu: DSI transceiver device is disabled
[    5.628176] [     T48] meson-gx-mmc ffe05000.mmc: Got CD GPIO
[    5.637133] [    T290] [drm] Initialized meson 1.0.0 for ff900000.vpu on minor 1
[    5.637694] [    T311] dwc2 ff400000.usb: supply vusb_d not found, using dummy regulator
[    5.637799] [    T311] dwc2 ff400000.usb: supply vusb_a not found, using dummy regulator
[    5.649999] [    T311] dwc2 ff400000.usb: EPs: 7, dedicated fifos, 712 entries in SPRAM
[    5.666878] [     T49] meson-gx-mmc ffe03000.mmc: allocated mmc-pwrseq
[    5.786590] [    T354] mmc0: new UHS-I speed SDR104 SDXC card at address 1388
[    5.788294] [    T354] mmcblk0: mmc0:1388 Stora 466 GiB
[    5.818458] [    T295] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    5.818494] [    T295] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 1
[    5.818800] [    T295] xhci-hcd xhci-hcd.2.auto: hcc params 0x0228fe64 hci version 0x110 quirks 0x0000808000000010
[    5.818851] [    T295] xhci-hcd xhci-hcd.2.auto: irq 26, io mem 0xff500000
[    5.819142] [    T295] xhci-hcd xhci-hcd.2.auto: xHCI Host Controller
[    5.819157] [    T295] xhci-hcd xhci-hcd.2.auto: new USB bus registered, assigned bus number 2
[    5.819173] [    T295] xhci-hcd xhci-hcd.2.auto: Host supports USB 3.0 SuperSpeed
[    5.819330] [    T295] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.17
[    5.819339] [    T295] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.819345] [    T295] usb usb1: Product: xHCI Host Controller
[    5.819349] [    T295] usb usb1: Manufacturer: Linux 6.17.4 xhci-hcd
[    5.819354] [    T295] usb usb1: SerialNumber: xhci-hcd.2.auto
[    5.820255] [    T295] hub 1-0:1.0: USB hub found
[    5.820415] [    T295] hub 1-0:1.0: 2 ports detected
[    5.901768] [    T290] Console: switching to colour frame buffer device 128x48
[    5.907292] [     T86] mmc2: new UHS-I speed SDR104 SDIO card at address 0001
[    6.037459] [    T290] meson-drm ff900000.vpu: [drm] fb0: mesondrmfb frame buffer device
[    6.053559] [    T295] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.059877] [    T295] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.17
[    6.068675] [    T295] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.076555] [    T295] usb usb2: Product: xHCI Host Controller
[    6.082088] [    T295] usb usb2: Manufacturer: Linux 6.17.4 xhci-hcd
[    6.090666] [    T295] usb usb2: SerialNumber: xhci-hcd.2.auto
[    6.096741] [    T295] hub 2-0:1.0: USB hub found
[    6.100657] [    T295] hub 2-0:1.0: 1 port detected
[    6.348249] [    T381] BTRFS: device fsid 6a42b9d0-571c-4394-9ebb-c9a490151bba devid 1 transid 289466 /dev/mmcblk1p3 (179:3) scanned by mount (381)
[    6.358236] [    T381] BTRFS info (device mmcblk1p3): first mount of filesystem 6a42b9d0-571c-4394-9ebb-c9a490151bba
[    6.366811] [    T381] BTRFS info (device mmcblk1p3): using crc32c (crc32c-lib) checksum algorithm
[    6.391884] [    T381] BTRFS info (device mmcblk1p3): enabling ssd optimizations
[    6.394315] [    T381] BTRFS info (device mmcblk1p3): enabling free space tree
[    7.201146] [    T152] systemd-journald[152]: Received SIGTERM from PID 1 (systemd).
[    7.537061] [      T1] systemd[1]: systemd 257.7+suse.19.ga0dfd5de4c running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE -SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[    7.570687] [      T1] systemd[1]: Detected architecture arm64.
[    7.937815] [      T1] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    8.248007] [      T1] systemd[1]: /usr/lib/systemd/system/frr.service:30: PIDFile= references a path below legacy directory /var/run/, updating /var/run/frr/watchfrr.pid → /run/frr/watchfrr.pid; please update the unit file accordingly.
[    8.532291] [      T1] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[    8.535896] [      T1] systemd[1]: Stopped Switch Root.
[    8.555279] [      T1] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    8.562763] [      T1] systemd[1]: Created slice Slice /system/getty.
[    8.586734] [      T1] systemd[1]: Created slice Slice /system/openvpn.
[    8.602667] [      T1] systemd[1]: Created slice Slice /system/serial-getty.
[    8.622699] [      T1] systemd[1]: Created slice Slice /system/systemd-fsck.
[    8.641679] [      T1] systemd[1]: Created slice User and Session Slice.
[    8.657304] [      T1] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    8.677614] [      T1] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    8.705092] [      T1] systemd[1]: Expecting device /dev/disk/by-uuid/CE59-EAEA...
[    8.721042] [      T1] systemd[1]: Expecting device /dev/ttyAML0...
[    8.733073] [      T1] systemd[1]: Reached target Local Encrypted Volumes.
[    8.753115] [      T1] systemd[1]: Stopped target Switch Root.
[    8.765092] [      T1] systemd[1]: Stopped target Initrd File Systems.
[    8.785065] [      T1] systemd[1]: Stopped target Initrd Root File System.
[    8.805095] [      T1] systemd[1]: Reached target Local Integrity Protected Volumes.
[    8.821170] [      T1] systemd[1]: Reached target Remote File Systems.
[    8.841068] [      T1] systemd[1]: Reached target Slice Units.
[    8.853111] [      T1] systemd[1]: Reached target Swaps.
[    8.865105] [      T1] systemd[1]: Reached target Local Verity Protected Volumes.
[    8.881359] [      T1] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    8.897357] [      T1] systemd[1]: Listening on LVM2 poll daemon socket.
[    8.927348] [      T1] systemd[1]: Listening on Process Core Dump Socket.
[    8.943952] [      T1] systemd[1]: Listening on Credential Encryption/Decryption.
[    8.961554] [      T1] systemd[1]: Listening on Network Service Netlink Socket.
[    8.977330] [      T1] systemd[1]: Listening on udev Control Socket.
[    8.997255] [      T1] systemd[1]: Listening on udev Kernel Socket.
[    9.022028] [      T1] systemd[1]: Mounting Huge Pages File System...
[    9.069543] [      T1] systemd[1]: Mounting POSIX Message Queue File System...
[    9.087790] [      T1] systemd[1]: Mounting Kernel Debug File System...
[    9.104852] [      T1] systemd[1]: Mounting Kernel Trace File System...
[    9.126835] [      T1] systemd[1]: Starting Create List of Static Device Nodes...
[    9.150033] [      T1] systemd[1]: Starting Load Kernel Module configfs...
[    9.174126] [      T1] systemd[1]: Starting Load Kernel Module dm_mod...
[    9.198077] [      T1] systemd[1]: Starting Load Kernel Module drm...
[    9.222216] [      T1] systemd[1]: Starting Load Kernel Module fuse...
[    9.232683] [    T435] device-mapper: uevent: version 1.0.3
[    9.234539] [    T435] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    9.279631] [      T1] systemd[1]: Starting Load Kernel Module loop...
[    9.297691] [      T1] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    9.318760] [    T437] fuse: init (API version 7.44)
[    9.320076] [    T438] loop: module loaded
[    9.325469] [      T1] systemd[1]: Starting Journal Service...
[    9.344839] [      T1] systemd[1]: Starting Load Kernel Modules...
[    9.370932] [      T1] systemd[1]: Starting Generate network units from Kernel command line...
[    9.392510] [      T1] systemd[1]: Starting Remount Root and Kernel File Systems...
[    9.416457] [      T1] systemd[1]: Starting Load udev Rules from Credentials...
[    9.432769] [    T439] systemd-journald[439]: Collecting audit messages is disabled.
[    9.444571] [    T447] BTRFS info (device mmcblk1p3 state M): use zstd compression, level 2
[    9.469779] [      T1] systemd[1]: Starting Coldplug All udev Devices...
[    9.496192] [      T1] systemd[1]: Started Journal Service.
[    9.760089] [    T439] systemd-journald[439]: Received client request to flush runtime journal.
[   10.745740] [    T526] cpu cpu0: EM: created perf domain
[   10.761734] [    T526] cpufreq: cpufreq_policy_online: CPU2: Running at unlisted initial frequency: 999999 kHz, changing to: 1000000 kHz
[   10.769578] [    T526] cpu cpu2: EM: created perf domain
[   10.773795] [    T526] energy_model: updating cpu0 cpu_cap=449 old capacity=512
[   10.794887] [    T520] mc: Linux media interface: v0.10
[   10.833439] [    T512] etnaviv etnaviv: bound ff100000.npu (ops gpu_ops [etnaviv])
[   10.835679] [    T512] etnaviv-gpu ff100000.npu: model: GC8000, revision: 7120
[   10.842505] [    T512] etnaviv-gpu ff100000.npu: etnaviv has been instantiated on a NPU, for which the UAPI is still experimental
[   10.847890] [    T520] videodev: Linux video capture interface: v2.00
[   10.872540] [    T512] [drm] Initialized etnaviv 1.4.0 for etnaviv on minor 0
[   10.905517] [    T526] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   10.909149] [    T526] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   10.915637] [    T526] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[   10.925158] [     T82] faux_driver regulatory: Direct firmware load for regulatory.db failed with error -2
[   10.937797] [     T82] cfg80211: failed to load regulatory.db
[   10.945546] [    T491] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[   10.947964] [    T491] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[   10.954941] [    T491] meson8b-dwmac ff3f0000.ethernet: IRQ sfty not found
[   10.964383] [    T491] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[   10.968306] [    T491] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[   10.975667] [    T491] meson8b-dwmac ff3f0000.ethernet:      DWMAC1000
[   10.981521] [    T491] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[   10.989684] [    T491] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[   10.997769] [    T491] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[   11.003620] [    T491] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[   11.011341] [    T491] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[   11.018568] [    T491] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[   11.021177] [    T540] debugfs: 'ff800280.cec' already exists in 'regmap'
[   11.024631] [    T491] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[   11.027298] [    T520] meson_vdec: module is from the staging directory, the quality is unknown, you have been warned.
[   11.039744] [    T526] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[   11.048030] [    T491] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[   11.067621] [    T526] iwlwifi 0000:01:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
[   11.073131] [    T526] iwlwifi 0000:01:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
[   11.080985] [    T526] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6E AX210 160MHz
[   11.102253] [    T523] panfrost ffe40000.gpu: clock rate = 24000000
[   11.103448] [    T523] panfrost ffe40000.gpu: error -ENODEV: _opp_set_regulators: no regulator (mali) found
[   11.134370] [    T523] panfrost ffe40000.gpu: mali-g52 id 0x7212 major 0x0 minor 0x0 status 0x0
[   11.137986] [    T523] panfrost ffe40000.gpu: features: 00000000,00000df7, issues: 00000000,00000400
[   11.146805] [    T523] panfrost ffe40000.gpu: Features: L2:0x07110206 Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
[   11.159425] [    T466] iwlwifi 0000:01:00.0: loaded firmware version 89.af655058.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm
[   11.160187] [    T523] panfrost ffe40000.gpu: shader_present=0x3 l2_present=0x1
[   11.220516] [    T523] [drm] Initialized panfrost 1.4.0 for ffe40000.gpu on minor 2

On 6.18-rc2 iwlwifi never gets probed

[    0.000000] [      T0] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
[    0.000000] [      T0] Linux version 6.18.0-rc2 (geeko@buildhost) (gcc (SUSE Linux) 15.1.1 20250714, GNU ld (GNU Binutils; SUSE Linux 16) 2.43.1.20241209-160000.2) #1 SMP PREEMPT_DYNAMIC Mon Oct 20 05:45:13 UTC 2025 (f43c94d)
[    0.000000] [      T0] KASLR enabled
[    0.000000] [      T0] Machine model: Khadas VIM3
[    0.000000] [      T0] efi: EFI v2.10 by Das U-Boot
[    0.000000] [      T0] efi: RTPROP=0xefed5040 SMBIOS=0xefefc000 RNG=0xedc4d040 MEMRESERVE=0xe7d43040
[    0.000000] [      T0] random: crng init done
[    0.000000] [      T0] Reserved memory: created CMA memory pool at 0x00000000c9800000, size 480 MiB
[    0.000000] [      T0] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
[    0.000000] [      T0] OF: reserved mem: 0x00000000c9800000..0x00000000e77fffff (491520 KiB) map reusable linux,cma
[    0.000000] [      T0] OF: reserved mem: 0x0000000005000000..0x00000000052fffff (3072 KiB) nomap non-reusable secmon@5000000
[    0.000000] [      T0] OF: reserved mem: 0x0000000005300000..0x00000000072fffff (32768 KiB) nomap non-reusable secmon@5300000
[    0.000000] [      T0] Zone ranges:
[    0.000000] [      T0]   DMA      [mem 0x0000000000000000-0x00000000f4ffffff]
[    0.000000] [      T0]   DMA32    empty
[    0.000000] [      T0]   Normal   empty
[    0.000000] [      T0]   Device   empty
[    0.000000] [      T0] Movable zone start for each node
[    0.000000] [      T0] Early memory node ranges
[    0.000000] [      T0]   node   0: [mem 0x0000000000000000-0x0000000004ffffff]
[    0.000000] [      T0]   node   0: [mem 0x0000000005000000-0x00000000072fffff]
[    0.000000] [      T0]   node   0: [mem 0x0000000007300000-0x00000000efed4fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed5000-0x00000000efed5fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed6000-0x00000000efed6fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed7000-0x00000000efed8fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efed9000-0x00000000efed9fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efeda000-0x00000000efef9fff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efefa000-0x00000000efefbfff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efefc000-0x00000000efefcfff]
[    0.000000] [      T0]   node   0: [mem 0x00000000efefd000-0x00000000f2f0ffff]
[    0.000000] [      T0]   node   0: [mem 0x00000000f2f10000-0x00000000f2f1ffff]
[    0.000000] [      T0]   node   0: [mem 0x00000000f2f20000-0x00000000f4e5afff]
[    0.000000] [      T0]   node   0: [mem 0x00000000f4e5b000-0x00000000f4ffffff]
[    0.000000] [      T0] Initmem setup node 0 [mem 0x0000000000000000-0x00000000f4ffffff]
[    0.000000] [      T0] On node 0, zone DMA: 12288 pages in unavailable ranges
[    0.000000] [      T0] psci: probing for conduit method from DT.
[    0.000000] [      T0] psci: PSCIv1.0 detected in firmware.
[    0.000000] [      T0] psci: Using standard PSCI v0.2 function IDs
[    0.000000] [      T0] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] [      T0] psci: SMC Calling Convention v1.1
[    0.000000] [      T0] RME: RMM doesn't support RSI version 1.0. Supported range: 1.0-0.0
[    0.000000] [      T0] percpu: Embedded 56 pages/cpu s103768 r8192 d117416 u229376
[    0.000000] [      T0] pcpu-alloc: s103768 r8192 d117416 u229376 alloc=56*4096
[    0.000000] [      T0] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
[    0.000000] [      T0] Detected VIPT I-cache on CPU0
[    0.000000] [      T0] CPU features: kernel page table isolation forced ON by KASLR
[    0.000000] [      T0] CPU features: detected: Kernel page table isolation (KPTI)
[    0.000000] [      T0] alternatives: applying boot alternatives
[    0.000000] [      T0] Kernel command line: BOOT_IMAGE=/boot/Image-6.18.0-rc2 root=UUID=6a42b9d0-571c-4394-9ebb-c9a490151bba rd.timeout=15 mitigations=off delayacct
[    0.000000] [      T0] printk: log_buf_len individual max cpu contribution: 32768 bytes
[    0.000000] [      T0] printk: log_buf_len total cpu_extra contributions: 163840 bytes
[    0.000000] [      T0] printk: log_buf_len min size: 262144 bytes
[    0.000000] [      T0] printk: log buffer data + meta data: 524288 + 1835008 = 2359296 bytes
[    0.000000] [      T0] printk: early log buf free: 258624(98%)
[    0.000000] [      T0] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    0.000000] [      T0] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    0.000000] [      T0] software IO TLB: SWIOTLB bounce buffer size adjusted to 3MB
[    0.000000] [      T0] software IO TLB: area num 8.
[    0.000000] [      T0] software IO TLB: mapped [mem 0x00000000f389f000-0x00000000f3c9f000] (4MB)
[    0.000000] [      T0] Built 1 zonelists, mobility grouping on.  Total pages: 1003520
[    0.000000] [      T0] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] [      T0] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] [      T0] ftrace: allocating 46541 entries in 182 pages
[    0.000000] [      T0] ftrace: allocated 182 pages with 5 groups
[    0.000000] [      T0] Dynamic Preempt: voluntary
[    0.000000] [      T0] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] [      T0] rcu:  RCU event tracing is enabled.
[    0.000000] [      T0] rcu:  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=6.
[    0.000000] [      T0]       Trampoline variant of Tasks RCU enabled.
[    0.000000] [      T0]       Rude variant of Tasks RCU enabled.
[    0.000000] [      T0]       Tracing variant of Tasks RCU enabled.
[    0.000000] [      T0] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] [      T0] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] [      T0] RCU Tasks: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.000000] [      T0] RCU Tasks Rude: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.000000] [      T0] RCU Tasks Trace: Setting shift to 3 and lim to 1 rcu_task_cb_adjust=1 rcu_task_cpu_ids=6.
[    0.000000] [      T0] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] [      T0] Root IRQ handler: gic_handle_irq
[    0.000000] [      T0] GIC: Using split EOI/Deactivate mode
[    0.000000] [      T0] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.000000] [      T0] arch_timer: cp15 timer running at 24.00MHz (phys).
[    0.000000] [      T0] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x588fe9dc0, max_idle_ns: 440795202592 ns
[    0.000000] [      T0] sched_clock: 56 bits at 24MHz, resolution 41ns, wraps every 4398046511097ns
[    0.000503] [      T0] Console: colour dummy device 80x25
[    0.000521] [      T0] printk: legacy console [tty0] enabled
[    0.001411] [      T0] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=96000)
[    0.001439] [      T0] pid_max: default: 32768 minimum: 301
[    0.001648] [      T0] LSM: initializing lsm=capability,apparmor,bpf,ima,evm
[    0.002019] [      T0] AppArmor: AppArmor initialized
[    0.002483] [      T0] LSM support for eBPF active
[    0.002778] [      T0] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.002817] [      T0] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.004111] [      T0] spectre-v4 mitigation disabled by command-line option
[    0.005905] [      T1] rcu: Hierarchical SRCU implementation.
[    0.005946] [      T1] rcu:  Max phase no-delay instances is 1000.
[    0.006191] [      T1] Timer migration: 1 hierarchy levels; 8 children per group; 1 crossnode level
[    0.007612] [      T1] Remapping and enabling EFI services.
[    0.008163] [      T1] smp: Bringing up secondary CPUs ...
[    0.008977] [      T0] Detected VIPT I-cache on CPU1
[    0.009184] [      T0] CPU1: Booted secondary processor 0x0000000001 [0x410fd034]
[    0.010567] [      T0] CPU features: detected: Spectre-v2
[    0.010583] [      T0] CPU features: detected: Spectre-v4
[    0.010589] [      T0] CPU features: detected: Spectre-BHB
[    0.010593] [      T0] CPU features: detected: ARM erratum 858921
[    0.010603] [      T0] Detected VIPT I-cache on CPU2
[    0.010737] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.010755] [      T0] arch_timer: CPU2: Trapping CNTVCT access
[    0.010766] [      T0] CPU2: Booted secondary processor 0x0000000100 [0x410fd092]
[    0.011540] [      T0] Detected VIPT I-cache on CPU3
[    0.011638] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.011648] [      T0] arch_timer: CPU3: Trapping CNTVCT access
[    0.011655] [      T0] CPU3: Booted secondary processor 0x0000000101 [0x410fd092]
[    0.012468] [      T0] Detected VIPT I-cache on CPU4
[    0.012568] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.012578] [      T0] arch_timer: CPU4: Trapping CNTVCT access
[    0.012585] [      T0] CPU4: Booted secondary processor 0x0000000102 [0x410fd092]
[    0.013322] [      T0] Detected VIPT I-cache on CPU5
[    0.013423] [      T0] arch_timer: Enabling local workaround for ARM erratum 858921
[    0.013433] [      T0] arch_timer: CPU5: Trapping CNTVCT access
[    0.013440] [      T0] CPU5: Booted secondary processor 0x0000000103 [0x410fd092]
[    0.013531] [      T1] smp: Brought up 1 node, 6 CPUs
[    0.013774] [      T1] SMP: Total of 6 processors activated.
[    0.013788] [      T1] CPU: All CPU(s) started at EL2
[    0.013814] [      T1] CPU features: detected: 32-bit EL0 Support
[    0.013828] [      T1] CPU features: detected: 32-bit EL1 Support
[    0.013844] [      T1] CPU features: detected: CRC32 instructions
[    0.013867] [      T1] CPU features: detected: PMUv3
[    0.013944] [      T1] alternatives: applying system-wide alternatives
[    0.015167] [      T1] CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
[    0.034628] [     T47] node 0 deferred pages initialised in 16ms
[    0.034707] [      T1] Memory: 3332448K/4014080K available (14912K kernel code, 2590K rwdata, 11620K rodata, 7360K init, 725K bss, 184416K reserved, 491520K cma-reserved)
[    0.035701] [      T1] devtmpfs: initialized
[    0.046066] [      T1] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.046136] [      T1] posixtimers hash table entries: 4096 (order: 4, 65536 bytes, linear)
[    0.046203] [      T1] futex hash table entries: 2048 (131072 bytes on 1 NUMA nodes, total 128 KiB, linear).
[    0.050044] [      T1] 2G module region forced by RANDOMIZE_MODULE_REGION_FULL
[    0.050075] [      T1] 0 pages in range for non-PLT usage
[    0.050079] [      T1] 514928 pages in range for PLT usage
[    0.050369] [      T1] pinctrl core: initialized pinctrl subsystem
[    0.051042] [      T1] SMBIOS 3.0 present.
[    0.051064] [      T1] DMI: khadas VIM3/VIM3, BIOS 2024.01-rc4-00039-gce25ceb939 01/01/2024
[    0.051086] [      T1] DMI: Memory slots populated: 0/0
[    0.053164] [      T1] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.054039] [      T1] DMA: preallocated 512 KiB GFP_KERNEL pool for atomic allocations
[    0.054296] [      T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.054596] [      T1] DMA: preallocated 512 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.054660] [      T1] audit: initializing netlink subsys (disabled)
[    0.054823] [     T58] audit: type=2000 audit(0.052:1): state=initialized audit_enabled=0 res=1
[    0.056121] [      T1] thermal_sys: Registered thermal governor 'fair_share'
[    0.056128] [      T1] thermal_sys: Registered thermal governor 'bang_bang'
[    0.056142] [      T1] thermal_sys: Registered thermal governor 'step_wise'
[    0.056153] [      T1] thermal_sys: Registered thermal governor 'user_space'
[    0.056164] [      T1] thermal_sys: Registered thermal governor 'power_allocator'
[    0.056212] [      T1] cpuidle: using governor ladder
[    0.056255] [      T1] cpuidle: using governor menu
[    0.056405] [      T1] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.056525] [      T1] ASID allocator initialised with 32768 entries
[    0.056737] [      T1] Serial: AMBA PL011 UART driver
[    0.063459] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.063859] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.063912] [      T1] /soc/vpu@ff900000: Fixed dependency cycle(s) with /soc/bus@ff600000/hdmi-tx@0
[    0.063949] [      T1] /soc/interrupt-controller@ffc01000: Fixed dependency cycle(s) with /soc/interrupt-controller@ffc01000
[    0.064038] [      T1] /soc/usb@ffe09000: Fixed dependency cycle(s) with /soc/bus@ff800000/i2c@5000/usb-typec@22/connector
[    0.064659] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.065076] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.070294] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.071521] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.072052] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /soc/vpu@ff900000
[    0.072120] [      T1] /soc/vpu@ff900000: Fixed dependency cycle(s) with /soc/bus@ff600000/hdmi-tx@0
[    0.074369] [      T1] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    0.074440] [      T1] /soc/usb@ffe09000: Fixed dependency cycle(s) with /soc/bus@ff800000/i2c@5000/usb-typec@22/connector
[    0.077573] [      T1] /soc/bus@ff600000/hdmi-tx@0: Fixed dependency cycle(s) with /hdmi-connector
[    0.077650] [      T1] /hdmi-connector: Fixed dependency cycle(s) with /soc/bus@ff600000/hdmi-tx@0
[    0.079566] [      T1] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.079589] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 1.00 GiB page
[    0.079602] [      T1] HugeTLB: registered 32.0 MiB page size, pre-allocated 0 pages
[    0.079614] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 32.0 MiB page
[    0.079626] [      T1] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.079637] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 2.00 MiB page
[    0.079648] [      T1] HugeTLB: registered 64.0 KiB page size, pre-allocated 0 pages
[    0.079659] [      T1] HugeTLB: 0 KiB vmemmap can be freed for a 64.0 KiB page
[    0.081445] [      T1] fbcon: Taking over console
[    0.082252] [      T1] iommu: Default domain type: Translated
[    0.082274] [      T1] iommu: DMA domain TLB invalidation policy: strict mode
[    0.084675] [      T1] pps_core: LinuxPPS API ver. 1 registered
[    0.084692] [      T1] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.084714] [      T1] PTP clock support registered
[    0.084750] [      T1] EDAC MC: Ver: 3.0.0
[    0.084846] [      T1] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[    0.084983] [      T1] scmi_core: SCMI protocol bus registered
[    0.085130] [      T1] efivars: Registered efivars operations
[    0.086205] [      T1] NetLabel: Initializing
[    0.086219] [      T1] NetLabel:  domain hash size = 128
[    0.086229] [      T1] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.086306] [      T1] NetLabel:  unlabeled traffic allowed by default
[    0.086327] [      T1] mctp: management component transport protocol core
[    0.086337] [      T1] NET: Registered PF_MCTP protocol family
[    0.086640] [      T1] vgaarb: loaded
[    0.087009] [      T1] clocksource: Switched to clocksource arch_sys_counter
[    0.087671] [      T1] VFS: Disk quotas dquot_6.6.0
[    0.087717] [      T1] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.088417] [      T1] AppArmor: AppArmor Filesystem Enabled
[    0.093700] [      T1] NET: Registered PF_INET protocol family
[    0.093915] [      T1] IP idents hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.127773] [      T1] tcp_listen_portaddr_hash hash table entries: 2048 (order: 3, 32768 bytes, linear)
[    0.127835] [      T1] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.127915] [      T1] TCP established hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    0.128089] [      T1] TCP bind hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    0.128411] [      T1] TCP: Hash tables configured (established 32768 bind 32768)
[    0.128657] [      T1] MPTCP token hash table entries: 4096 (order: 4, 98304 bytes, linear)
[    0.128752] [      T1] UDP hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.128829] [      T1] UDP-Lite hash table entries: 2048 (order: 5, 131072 bytes, linear)
[    0.129104] [      T1] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    0.129148] [      T1] NET: Registered PF_XDP protocol family
[    0.129205] [      T1] PCI: CLS 0 bytes, default 64
[    0.129396] [     T48] Trying to unpack rootfs image as initramfs...
[    0.138099] [      T1] kvm [1]: nv: 568 coarse grained trap handlers
[    0.138500] [      T1] kvm [1]: IPA Size Limit: 40 bits
[    0.140404] [      T1] kvm [1]: vgic interrupt IRQ9
[    0.140465] [      T1] kvm [1]: Hyp nVHE mode initialized successfully
[    0.144840] [      T1] Initialise system trusted keyrings
[    0.144905] [      T1] Key type blacklist registered
[    0.145156] [      T1] workingset: timestamp_bits=46 max_order=20 bucket_order=0
[    0.145904] [      T1] integrity: Platform Keyring initialized
[    0.145930] [      T1] integrity: Machine keyring initialized
[    0.145941] [      T1] Allocating IMA blacklist keyring.
[    0.186578] [      T1] Key type asymmetric registered
[    0.186611] [      T1] Asymmetric key parser 'x509' registered
[    0.186720] [      T1] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 245)
[    0.186931] [      T1] io scheduler mq-deadline registered
[    0.186949] [      T1] io scheduler kyber registered
[    0.187064] [      T1] io scheduler bfq registered
[    0.187831] [      T1] irq_meson_gpio: 100 to 8 gpio interrupt mux initialized
[    0.193712] [      T1] ledtrig-cpu: registered to indicate activity on CPUs
[    0.200362] [      T1] soc soc0: Amlogic Meson G12B (A311D) Revision 29:b (10:2) Detected
[    0.201799] [      T1] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    0.210450] [      T1] Serial: AMBA driver
[    0.211406] [      T1] ff803000.serial: ttyAML0 at MMIO 0xff803000 (irq = 14, base_baud = 1500000) is a meson_uart
[    0.211454] [      T1] printk: legacy console [ttyAML0] enabled
[    0.579974] [     T48] Freeing initrd memory: 23072K
[    0.596452] [      T1] ffd24000.serial: ttyAML6 at MMIO 0xffd24000 (irq = 15, base_baud = 1500000) is a meson_uart
[    1.833547] [      T1] serial serial0: tty port ttyAML6 registered
[    1.839565] [      T1] msm_serial: driver initialized
[    1.847374] [      T1] mousedev: PS/2 mouse device common for all mice
[    1.851410] [      T1] meson-sm: secure-monitor enabled
[    1.855333] [      T1] hid: raw HID events driver (C) Jiri Kosina
[    1.861687] [     T82] watchdog: NMI not fully supported
[    1.865872] [     T82] watchdog: Hard watchdog permanently disabled
[    1.867408] [      T1] drop_monitor: Initializing network drop monitor service
[    1.879113] [      T1] NET: Registered PF_INET6 protocol family
[    1.885448] [      T1] Segment Routing with IPv6
[    1.888755] [      T1] RPL Segment Routing with IPv6
[    1.893446] [      T1] In-situ OAM (IOAM) with IPv6
[    1.903427] [      T1] registered taskstats version 1
[    1.934253] [      T1] zswap: loaded using pool zstd
[    1.934369] [      T1] page_owner is disabled
[    1.937734] [      T1] Key type .fscrypt registered
[    1.942017] [      T1] Key type fscrypt-provisioning registered
[    1.948232] [      T1] Key type big_key registered
[    2.008936] [      T1] Key type encrypted registered
[    2.008992] [      T1] AppArmor: AppArmor sha256 policy hashing enabled
[    2.014525] [      T1] ima: secureboot mode disabled
[    2.019050] [      T1] ima: No TPM chip found, activating TPM-bypass!
[    2.040795] [      T1] ima: Allocated hash algorithm: sha256
[    2.046192] [      T1] ima: No architecture policies found
[    2.051424] [      T1] evm: Initialising EVM extended attributes:
[    2.057166] [      T1] evm: security.selinux
[    2.061149] [      T1] evm: security.SMACK64 (disabled)
[    2.066090] [      T1] evm: security.SMACK64EXEC (disabled)
[    2.071375] [      T1] evm: security.SMACK64TRANSMUTE (disabled)
[    2.077095] [      T1] evm: security.SMACK64MMAP (disabled)
[    2.082382] [      T1] evm: security.apparmor
[    2.086454] [      T1] evm: security.ima
[    2.090094] [      T1] evm: security.capability
[    2.094341] [      T1] evm: HMAC attrs: 0x1
[    2.111082] [     T48] simple-framebuffer f4e5b000.framebuffer: [drm] Registered 1 planes with drm panic
[    2.114682] [     T48] [drm] Initialized simpledrm 1.0.0 for f4e5b000.framebuffer on minor 0
[    2.125198] [     T48] Console: switching to colour frame buffer device 90x36
[    2.130606] [     T48] simple-framebuffer f4e5b000.framebuffer: [drm] fb0: simpledrmdrmfb frame buffer device
[    2.172492] [      T1] clk: Disabling unused clocks
[    2.172879] [      T1] PM: genpd: Disabling unused power domains
[    2.187117] [      T1] Freeing unused kernel memory: 7360K
[    2.232240] [      T1] Checked W+X mappings: passed, no W+X pages found
[    2.233150] [      T1] Run /init as init process
[    2.237331] [      T1]   with arguments:
[    2.237337] [      T1]     /init
[    2.237342] [      T1]   with environment:
[    2.237346] [      T1]     HOME=/
[    2.237350] [      T1]     TERM=linux
[    2.251522] [      T1] systemd[1]: System time advanced to built-in epoch: Thu 2025-07-31 14:32:25 UTC
[    2.310633] [      T1] systemd[1]: Successfully made /usr/ read-only.
[    2.319091] [      T1] systemd[1]: systemd 257.7+suse.19.ga0dfd5de4c running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE -SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[    2.354231] [      T1] systemd[1]: Detected architecture arm64.
[    2.356597] [      T1] systemd[1]: Running in initrd.
[    2.379214] [      T1] systemd[1]: Hostname set to <linux-g12b>.
[    2.600479] [      T1] systemd[1]: Queued start job for default target Initrd Default Target.
[    2.644193] [      T1] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    2.663166] [      T1] systemd[1]: Expecting device /dev/disk/by-uuid/6a42b9d0-571c-4394-9ebb-c9a490151bba...
[    2.683135] [      T1] systemd[1]: Expecting device /dev/disk/by-uuid/CE59-EAEA...
[    2.699227] [      T1] systemd[1]: Reached target Initrd /usr File System.
[    2.715232] [      T1] systemd[1]: Reached target Path Units.
[    2.727239] [      T1] systemd[1]: Reached target Slice Units.
[    2.739272] [      T1] systemd[1]: Reached target Swaps.
[    2.751224] [      T1] systemd[1]: Reached target Timer Units.
[    2.763657] [      T1] systemd[1]: Listening on Journal Socket (/dev/log).
[    2.779645] [      T1] systemd[1]: Listening on Journal Sockets.
[    2.795577] [      T1] systemd[1]: Listening on udev Control Socket.
[    2.811440] [      T1] systemd[1]: Listening on udev Kernel Socket.
[    2.831237] [      T1] systemd[1]: Reached target Socket Units.
[    2.846782] [      T1] systemd[1]: Starting Create List of Static Device Nodes...
[    2.897543] [      T1] systemd[1]: Starting Journal Service...
[    2.917894] [      T1] systemd[1]: Starting Load Kernel Modules...
[    2.948938] [      T1] systemd[1]: Starting Virtual Console Setup...
[    2.965662] [      T1] systemd[1]: Finished Create List of Static Device Nodes.
[    2.991297] [      T1] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    2.999627] [    T150] systemd-journald[150]: Collecting audit messages is disabled.
[    3.030974] [      T1] systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
[    3.036695] [      T1] systemd[1]: Started Journal Service.
[    3.043247] [    T151] zram: Added device: zram0
[    3.703012] [    T273] raid6: neonx8   gen()  2657 MB/s
[    3.771010] [    T273] raid6: neonx4   gen()  2949 MB/s
[    3.839009] [    T273] raid6: neonx2   gen()  2357 MB/s
[    3.907012] [    T273] raid6: neonx1   gen()  1784 MB/s
[    3.975012] [    T273] raid6: int64x8  gen()  1209 MB/s
[    4.043013] [    T273] raid6: int64x4  gen()  1409 MB/s
[    4.111019] [    T273] raid6: int64x2  gen()  1364 MB/s
[    4.179018] [    T273] raid6: int64x1  gen()  1092 MB/s
[    4.179812] [    T273] raid6: using algorithm neonx4 gen() 2949 MB/s
[    4.251008] [    T273] raid6: .... xor() 2265 MB/s, rmw enabled
[    4.251704] [    T273] raid6: using neon recovery algorithm
[    4.265918] [    T273] xor: measuring software checksum speed
[    4.267560] [    T273]    8regs           :  4038 MB/sec
[    4.272284] [    T273]    32regs          :  4199 MB/sec
[    4.277491] [    T273]    arm64_neon      :  3107 MB/sec
[    4.281410] [    T273] xor: using function: 32regs (4199 MB/sec)
[    4.551724] [    T273] Btrfs loaded, assert=on, zoned=yes, fsverity=yes
[    5.263494] [    T293] input: gpio-keys-polled as /devices/platform/gpio-keys-polled/input/input0
[    5.274235] [    T301] pca953x 0-0020: using no AI
[    5.317556] [    T331] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    5.317948] [    T301] /soc/bus@ff800000/i2c@5000/usb-typec@22/connector: Fixed dependency cycle(s) with /soc/usb@ffe09000
[    5.371526] [    T309] meson-vrtc ff8000a8.rtc: registered as rtc1
[    5.391114] [    T306] dwc3-meson-g12a ffe09000.usb: USB2 ports: 2
[    5.391324] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.391413] [    T306] dwc3-meson-g12a ffe09000.usb: USB3 ports: 0
[    5.411265] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.415323] [     T50] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.419906] [     T51] meson-gx-mmc ffe05000.mmc: Got CD GPIO
[    5.422278] [     T50] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.442280] [     T50] meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
[    5.449631] [     T50] meson-pcie fc000000.pcie: Add PCIe port failed, -16
[    5.458779] [     T50] meson-pcie fc000000.pcie: probe with driver meson-pcie failed with error -16
[    5.503260] [    T317] rtc-hym8563 0-0051: registered as rtc0
[    5.506592] [    T317] rtc-hym8563 0-0051: setting system clock to 2025-10-23T08:55:45 UTC (1761209745)
[    5.522820] [    T295] meson-drm ff900000.vpu: Queued 1 outputs on vpu
[    5.580230] [     T51] meson-gx-mmc ffe03000.mmc: allocated mmc-pwrseq
[    5.589512] [    T157] mmc0: new UHS-I speed SDR104 SDXC card at address 1388
[    5.597129] [    T301] usbcore: registered new interface driver usbfs
[    5.599821] [    T301] usbcore: registered new interface driver hub
[    5.605003] [    T301] usbcore: registered new device driver usb
[    5.613310] [    T305] Console: switching to colour dummy device 80x25
[    5.625728] [    T290] mmcblk0: mmc0:1388 Stora 466 GiB
[    5.649562] [    T305] meson-drm ff900000.vpu: CVBS Output connector not available
[    5.654702] [    T318] dwc2 ff400000.usb: supply vusb_d not found, using dummy regulator
[    5.659365] [    T318] dwc2 ff400000.usb: supply vusb_a not found, using dummy regulator
[    5.663437] [     T10] mmc1: new HS200 MMC card at address 0001
[    5.667212] [    T318] dwc2 ff400000.usb: EPs: 7, dedicated fifos, 712 entries in SPRAM
[    5.674331] [     T10] mmcblk1: mmc1:0001 BJTD4R 29.1 GiB
[    5.680403] [    T305] meson-dw-hdmi ff600000.hdmi-tx: Detected HDMI TX controller v2.01a with HDCP (meson_dw_hdmi_phy)
[    5.688828] [     T10]  mmcblk1: p1 p2 p3
[    5.696297] [    T305] meson-dw-hdmi ff600000.hdmi-tx: registered DesignWare HDMI I2C bus driver
[    5.701094] [     T10] mmcblk1boot0: mmc1:0001 BJTD4R 4.00 MiB
[    5.708375] [    T305] meson-drm ff900000.vpu: bound ff600000.hdmi-tx (ops meson_dw_hdmi_ops [meson_dw_hdmi])
[    5.718988] [     T10] mmcblk1boot1: mmc1:0001 BJTD4R 4.00 MiB
[    5.723360] [    T305] meson-drm ff900000.vpu: DSI transceiver device is disabled
[    5.734431] [     T10] mmcblk1rpmb: mmc1:0001 BJTD4R 4.00 MiB, chardev (234:0)
[    5.736610] [    T305] [drm] Initialized meson 1.0.0 for ff900000.vpu on minor 1
[    5.754254] [    T291] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    5.756542] [    T291] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 1
[    5.764698] [    T291] xhci-hcd xhci-hcd.1.auto: hcc params 0x0228fe64 hci version 0x110 quirks 0x0000808000000010
[    5.774703] [    T291] xhci-hcd xhci-hcd.1.auto: irq 23, io mem 0xff500000
[    5.781503] [    T291] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[    5.787362] [    T291] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned bus number 2
[    5.795599] [    T291] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[    5.803035] [    T291] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.18
[    5.811695] [    T291] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.818262] [     T28] mmc2: new UHS-I speed SDR104 SDIO card at address 0001
[    5.819566] [    T291] usb usb1: Product: xHCI Host Controller
[    5.831981] [    T291] usb usb1: Manufacturer: Linux 6.18.0-rc2 xhci-hcd
[    5.840026] [    T291] usb usb1: SerialNumber: xhci-hcd.1.auto
[    5.846082] [    T291] hub 1-0:1.0: USB hub found
[    5.850042] [    T291] hub 1-0:1.0: 2 ports detected
[    6.347749] [    T305] Console: switching to colour frame buffer device 160x45
[    6.373623] [    T305] meson-drm ff900000.vpu: [drm] fb0: mesondrmfb frame buffer device
[    6.387572] [    T291] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    6.396074] [    T291] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.18
[    6.404869] [    T291] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    6.412742] [    T291] usb usb2: Product: xHCI Host Controller
[    6.418243] [    T291] usb usb2: Manufacturer: Linux 6.18.0-rc2 xhci-hcd
[    6.426335] [    T291] usb usb2: SerialNumber: xhci-hcd.1.auto
[    6.432370] [    T291] hub 2-0:1.0: USB hub found
[    6.436358] [    T291] hub 2-0:1.0: 1 port detected
[    6.842476] [    T385] BTRFS: device fsid 6a42b9d0-571c-4394-9ebb-c9a490151bba devid 1 transid 288771 /dev/mmcblk1p3 (179:11) scanned by mount (385)
[    6.850883] [    T385] BTRFS info (device mmcblk1p3): first mount of filesystem 6a42b9d0-571c-4394-9ebb-c9a490151bba
[    6.860228] [    T385] BTRFS info (device mmcblk1p3): using crc32c (crc32c-lib) checksum algorithm
[    6.885833] [    T385] BTRFS info (device mmcblk1p3): enabling ssd optimizations
[    6.887408] [    T385] BTRFS info (device mmcblk1p3): turning on async discard
[    6.894334] [    T385] BTRFS info (device mmcblk1p3): enabling free space tree
[    7.640767] [    T150] systemd-journald[150]: Received SIGTERM from PID 1 (systemd).
[    7.971200] [      T1] systemd[1]: systemd 257.7+suse.19.ga0dfd5de4c running in system mode (+PAM +AUDIT +SELINUX -APPARMOR +IMA +IPE -SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK -BTF -XKBCOMMON -UTMP +SYSVINIT +LIBARCHIVE)
[    8.001508] [      T1] systemd[1]: Detected architecture arm64.
[    8.312796] [     T28] usb usb1-port1: attempt power cycle
[    8.381404] [      T1] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    8.694777] [      T1] systemd[1]: /usr/lib/systemd/system/frr.service:30: PIDFile= references a path below legacy directory /var/run/, updating /var/run/frr/watchfrr.pid → /run/frr/watchfrr.pid; please update the unit file accordingly.
[    8.981248] [      T1] systemd[1]: initrd-switch-root.service: Deactivated successfully.
[    8.983956] [      T1] systemd[1]: Stopped Switch Root.
[    9.001520] [      T1] systemd[1]: systemd-journald.service: Scheduled restart job, restart counter is at 1.
[    9.007980] [      T1] systemd[1]: Created slice Slice /system/getty.
[    9.028751] [      T1] systemd[1]: Created slice Slice /system/openvpn.
[    9.044710] [      T1] systemd[1]: Created slice Slice /system/serial-getty.
[    9.065445] [      T1] systemd[1]: Created slice Slice /system/systemd-fsck.
[    9.087714] [      T1] systemd[1]: Created slice User and Session Slice.
[    9.107334] [      T1] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    9.131647] [      T1] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    9.155119] [      T1] systemd[1]: Expecting device /dev/disk/by-uuid/CE59-EAEA...
[    9.171074] [      T1] systemd[1]: Expecting device /dev/ttyAML0...
[    9.183121] [      T1] systemd[1]: Reached target Local Encrypted Volumes.
[    9.199147] [      T1] systemd[1]: Stopped target Switch Root.
[    9.211120] [      T1] systemd[1]: Stopped target Initrd File Systems.
[    9.227092] [      T1] systemd[1]: Stopped target Initrd Root File System.
[    9.243125] [      T1] systemd[1]: Reached target Local Integrity Protected Volumes.
[    9.259179] [      T1] systemd[1]: Reached target Remote File Systems.
[    9.275122] [      T1] systemd[1]: Reached target Slice Units.
[    9.287134] [      T1] systemd[1]: Reached target Swaps.
[    9.299157] [      T1] systemd[1]: Reached target Local Verity Protected Volumes.
[    9.315389] [      T1] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    9.332129] [      T1] systemd[1]: Listening on LVM2 poll daemon socket.
[    9.357417] [      T1] systemd[1]: Listening on Process Core Dump Socket.
[    9.373958] [      T1] systemd[1]: Listening on Credential Encryption/Decryption.
[    9.391545] [      T1] systemd[1]: Listening on Network Service Netlink Socket.
[    9.407374] [      T1] systemd[1]: Listening on udev Control Socket.
[    9.423269] [      T1] systemd[1]: Listening on udev Kernel Socket.
[    9.444022] [      T1] systemd[1]: Mounting Huge Pages File System...
[    9.495565] [      T1] systemd[1]: Mounting POSIX Message Queue File System...
[    9.513869] [      T1] systemd[1]: Mounting Kernel Debug File System...
[    9.529792] [      T1] systemd[1]: Mounting Kernel Trace File System...
[    9.547040] [      T1] systemd[1]: Starting Create List of Static Device Nodes...
[    9.566497] [      T1] systemd[1]: Starting Load Kernel Module configfs...
[    9.582624] [      T1] systemd[1]: Starting Load Kernel Module dm_mod...
[    9.602495] [      T1] systemd[1]: Starting Load Kernel Module drm...
[    9.622512] [      T1] systemd[1]: Starting Load Kernel Module fuse...
[    9.640413] [    T437] device-mapper: uevent: version 1.0.3
[    9.640826] [    T437] device-mapper: ioctl: 4.50.0-ioctl (2025-04-28) initialised: dm-devel@lists.linux.dev
[    9.642643] [      T1] systemd[1]: Starting Load Kernel Module loop...
[    9.656512] [      T1] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    9.681553] [      T1] systemd[1]: Starting Journal Service...
[    9.690178] [    T439] fuse: init (API version 7.45)
[    9.703177] [      T1] systemd[1]: Starting Load Kernel Modules...
[    9.723457] [    T440] loop: module loaded
[    9.742587] [      T1] systemd[1]: Starting Generate network units from Kernel command line...
[    9.762697] [      T1] systemd[1]: Starting Remount Root and Kernel File Systems...
[    9.779256] [    T441] systemd-journald[441]: Collecting audit messages is disabled.
[    9.823789] [      T1] systemd[1]: Starting Load udev Rules from Credentials...
[    9.844530] [    T449] BTRFS info (device mmcblk1p3 state M): use zstd compression, level 2
[    9.846675] [      T1] systemd[1]: Starting Coldplug All udev Devices...
[    9.883173] [      T1] systemd[1]: Started Journal Service.
[   10.143680] [    T441] systemd-journald[441]: Received client request to flush runtime journal.
[   10.156809] [     T28] usb usb1-port1: unable to enumerate USB device
[   11.176960] [    T533] cpu cpu0: EM: created perf domain
[   11.210657] [    T533] cpufreq: cpufreq_policy_online: CPU2: Running at unlisted initial frequency: 999999 kHz, changing to: 1000000 kHz
[   11.218947] [    T533] cpu cpu2: EM: created perf domain
[   11.222707] [    T519] mc: Linux media interface: v0.10
[   11.223758] [    T533] energy_model: updating cpu0 cpu_cap=449 old capacity=512
[   11.241127] [    T523] debugfs: 'ff800280.cec' already exists in 'regmap'
[   11.246579] [    T528] etnaviv etnaviv: bound ff100000.npu (ops gpu_ops [etnaviv])
[   11.250561] [    T528] etnaviv-gpu ff100000.npu: model: GC8000, revision: 7120
[   11.257284] [    T528] etnaviv-gpu ff100000.npu: etnaviv has been instantiated on a NPU, for which the UAPI is still experimental
[   11.291630] [    T528] [drm] Initialized etnaviv 1.4.0 for etnaviv on minor 0
[   11.292742] [    T519] videodev: Linux video capture interface: v2.00
[   11.332791] [    T496] meson8b-dwmac ff3f0000.ethernet: IRQ eth_wake_irq not found
[   11.341193] [    T496] meson8b-dwmac ff3f0000.ethernet: IRQ eth_lpi not found
[   11.347988] [    T496] meson8b-dwmac ff3f0000.ethernet: IRQ sfty not found
[   11.354652] [    T496] meson8b-dwmac ff3f0000.ethernet: PTP uses main clock
[   11.361595] [    T496] meson8b-dwmac ff3f0000.ethernet: User ID: 0x11, Synopsys ID: 0x37
[   11.369044] [    T496] meson8b-dwmac ff3f0000.ethernet:      DWMAC1000
[   11.374855] [    T496] meson8b-dwmac ff3f0000.ethernet: DMA HW capability register supported
[   11.383131] [    T496] meson8b-dwmac ff3f0000.ethernet: RX Checksum Offload Engine supported
[   11.391216] [    T496] meson8b-dwmac ff3f0000.ethernet: COE Type 2
[   11.397151] [    T496] meson8b-dwmac ff3f0000.ethernet: TX Checksum insertion supported
[   11.404729] [    T496] meson8b-dwmac ff3f0000.ethernet: Wake-Up On Lan supported
[   11.416508] [    T496] meson8b-dwmac ff3f0000.ethernet: Normal descriptors
[   11.421082] [    T496] meson8b-dwmac ff3f0000.ethernet: Ring mode enabled
[   11.427520] [    T496] meson8b-dwmac ff3f0000.ethernet: Enable RX Mitigation via HW Watchdog Timer
[   11.453415] [    T515] panfrost ffe40000.gpu: clock rate = 24000000
[   11.454903] [    T515] panfrost ffe40000.gpu: error -ENODEV: _opp_set_regulators: no regulator (mali) found
[   11.460690] [    T519] meson_vdec: module is from the staging directory, the quality is unknown, you have been warned.
[   11.507684] [    T515] panfrost ffe40000.gpu: mali-g52 id 0x7212 major 0x0 minor 0x0 status 0x0
[   11.511590] [    T515] panfrost ffe40000.gpu: features: 00000000,00000df7, issues: 00000000,00000400
[   11.520313] [    T515] panfrost ffe40000.gpu: Features: L2:0x07110206 Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
[   11.532868] [    T515] panfrost ffe40000.gpu: shader_present=0x3 l2_present=0x1
[   11.589314] [    T497] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   11.589976] [    T515] [drm] Initialized panfrost 1.4.0 for ffe40000.gpu on minor 2

I then made some changes to the meson glue driver so it won't try to map the ELBI registers.

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 787469d1b396..404c4d9e1900 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -109,10 +109,6 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
  {
  	struct dw_pcie *pci = &mp->pci;
  
-	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
-
  	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
  	if (IS_ERR(mp->cfg_base))
  		return PTR_ERR(mp->cfg_base);

And to the device tree so the designware driver would handle the DBI registers (I know this breaks DT bindings, but it's for testing).

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index dcc927a9da80..ca455f634834 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -138,7 +138,7 @@ pcie: pcie@fc000000 {
  			reg = <0x0 0xfc000000 0x0 0x400000>,
  			      <0x0 0xff648000 0x0 0x2000>,
  			      <0x0 0xfc400000 0x0 0x200000>;
-			reg-names = "elbi", "cfg", "config";
+			reg-names = "dbi", "cfg", "config";
  			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
  			#interrupt-cells = <1>;
  			interrupt-map-mask = <0 0 0 0>;

With the patch on 6.18-rc2 it fails later with ASPM.

[    5.362080] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.400163] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.421350] [     T50] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.428902] [     T50] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.436367] [     T50] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
[    5.485658] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.491449] [     T50] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
[    5.512122] [     T50] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
[    5.515375] [     T50] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.521523] [     T50] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    5.528847] [     T50] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
[    5.536237] [     T50] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
[    5.543415] [     T50] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.543432] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.543441] [     T50] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.543448] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.569461] [     T50] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.587641] [     T50] pci 0000:00:00.0: supports D1
[    5.591578] [     T50] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.603775] [     T50] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
[    5.614373] [     T50] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    5.621353] [     T50] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    5.621374] [     T50] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    5.623252] [     T50] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.651205] [     T50] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2
[    5.664912] [     T50] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
[    5.706596] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.748181] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.796864] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.798178] [     T50] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
[    5.806100] [     T50] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
[    5.806382] [     T50] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
[    5.863079] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.904553] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.946013] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.987492] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.987517] [     T50] pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
[    6.028979] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    6.080320] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    6.081421] [     T50] pci 0000:01:00.0: BAR 0: error updating (high 0x00000000 != 0xffffffff)
[    6.131210] [     T50] meson-pcie fc000000.pcie: error: wait linkup timeout
[    6.132324] [     T50] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    6.138215] [     T50] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    6.145683] [     T50] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    6.151953] [     T50] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
[    6.165037] [     T50] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    6.165782] [     T50] pcieport 0000:00:00.0: PME: Signaling with IRQ 25
[    6.181556] [     T50] pcieport 0000:00:00.0: AER: enabled with IRQ 25
[   11.500464] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.543334] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.544875] [    T491] iwlwifi 0000:01:00.0: of_irq_parse_pci: failed with rc=134
[   11.593524] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.636355] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.680033] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.721230] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.722728] [    T491] iwlwifi 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
[   11.773976] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.816771] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.859334] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.901868] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.944393] [    T491] meson-pcie fc000000.pcie: error: wait linkup timeout
[   11.945931] [    T491] iwlwifi 0000:01:00.0: HW_REV=0xFFFFFFFF, PCI issues?
[   11.952685] [    T491] iwlwifi 0000:01:00.0: probe with driver iwlwifi failed with error -5

Booting with the patch and pcie_aspm=off made the PCIe card work again.

[    0.000000] [      T0] Kernel command line: BOOT_IMAGE=/boot/Image-6.18.0-rc2-160001.218-default root=UUID=6a42b9d0-571c-4394-9ebb-c9a490151bba rd.timeout=15 mitigations=off delayacct pcie_aspm=off
[    5.306734] [     T48] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
[    5.316622] [     T48] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
[    5.321311] [     T48] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
[    5.331124] [     T48] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
[    5.340136] [     T48] meson-pcie fc000000.pcie: iATU: unroll T, 4 ob, 4 ib, align 64K, limit 4G
[    5.389671] [     T48] meson-pcie fc000000.pcie: error: wait linkup timeout
[    5.395682] [     T48] meson-pcie fc000000.pcie: PCIe Gen.2 x1 link up
[    5.408784] [     T48] meson-pcie fc000000.pcie: PCI host bridge to bus 0000:00
[    5.412271] [     T48] pci_bus 0000:00: root bus resource [bus 00-ff]
[    5.419606] [     T48] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff]
[    5.426684] [     T48] pci_bus 0000:00: root bus resource [mem 0xfc700000-0xfdffffff]
[    5.434093] [     T48] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400 PCIe Root Port
[    5.441392] [     T48] pci 0000:00:00.0: ROM [mem 0x00000000-0x0000ffff pref]
[    5.448118] [     T48] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.453979] [     T48] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    5.460845] [     T48] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    5.467161] [     T48] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff pref]
[    5.467973] [     T48] pci 0000:00:00.0: supports D1
[    5.486588] [     T48] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    5.539676] [     T48] pci 0000:01:00.0: [8086:2725] type 00 class 0x028000 PCIe Endpoint
[    5.543309] [     T48] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    5.543367] [     T48] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    5.543384] [     T48] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    5.549364] [     T48] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    5.581794] [     T48] pci 0000:00:00.0: bridge window [mem 0xfc700000-0xfc7fffff]: assigned
[    5.613019] [     T48] pci 0000:00:00.0: ROM [mem 0xfc800000-0xfc80ffff pref]: assigned
[    5.616489] [     T48] pci 0000:01:00.0: BAR 0 [mem 0xfc700000-0xfc703fff 64bit]: assigned
[    5.628803] [     T48] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    5.634557] [     T48] pci 0000:00:00.0:   bridge window [mem 0xfc700000-0xfc7fffff]
[    5.649790] [     T48] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    5.663909] [     T48] pci_bus 0000:00: resource 5 [mem 0xfc700000-0xfdffffff]
[    5.663917] [     T48] pci_bus 0000:01: resource 1 [mem 0xfc700000-0xfc7fffff]
[    5.664513] [     T48] pcieport 0000:00:00.0: PME: Signaling with IRQ 24
[    5.692363] [     T48] pcieport 0000:00:00.0: AER: enabled with IRQ 24
[   11.233785] [    T523] iwlwifi 0000:01:00.0: enabling device (0000 -> 0002)
[   11.261273] [    T523] iwlwifi 0000:01:00.0: Detected crf-id 0x400410, cnv-id 0x400410 wfpm id 0x80000000
[   11.271641] [    T523] iwlwifi 0000:01:00.0: PCI dev 2725/0024, rev=0x420, rfid=0x10d000
[   11.271658] [    T523] iwlwifi 0000:01:00.0: Detected Intel(R) Wi-Fi 6E AX210 160MHz
[   11.421478] [     T43] iwlwifi 0000:01:00.0: loaded firmware version 89.af655058.0 ty-a0-gf-a0-89.ucode op_mode iwlmvm

> #regzbot ^introduced: v6.18-rc1


