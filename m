Return-Path: <linux-pci+bounces-19361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1230A033A1
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 00:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40F4F3A5318
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 23:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2A21E0DCE;
	Mon,  6 Jan 2025 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="YOBsl6G9"
X-Original-To: linux-pci@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010008.outbound.protection.outlook.com [52.103.68.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6BAEEB3;
	Mon,  6 Jan 2025 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736207758; cv=fail; b=l8is8+mQ26s1XHNpsiSKKJVDZEJdnfBFxvn/smCKyCsZg82JpN5hkPNcFWByWGsMUQ5y8HdeUTwktzfMjPLtco7C1uWtH8G2dvUIdlqsrWQfIFynubXOFVl0kx1ehtUPbMR4polJsdon0oTlWDmiKr4PYyHCPe0qHsIU94AvFaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736207758; c=relaxed/simple;
	bh=TBnNHJfU70NtJ0DjYO+lFTM+Bj7SygmF9PQv0CMNTyM=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AJGVf66tCARFVMm3W+4buC8SFC6IB8F4CaU+ja4ZJq1hgYq+eJeyWW2rURP+tdSl6gudupYidVyNShuGWzF+WGtVHLNcC1gligkpbo5i9Rla7tXvtfqs2yD1tPabVRyhALv/swQdQiczfXVkcAvf6akkf+V7q4irVvnhnwYbDcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=YOBsl6G9; arc=fail smtp.client-ip=52.103.68.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKq42iipPmHfNqEd0buXT21+ti32jwRcSZGsGcBpcMvvjfahMTjLz0TR8HaPp5WSfozl6wiaVvcwMxM6CsHe9zzBJ/S7peBiA6VOl2wk7OZMftg95wlLWZKLZiBSZVRQCDkoCDp+FvLnzPIekitpzNrvZ01ZW0avLWXxgwCT8CPnMLzfJ1FcQmzZFv+b5hyr0oCuVnqGIbAfljmaQbCsukO6yWrPRRMNndj532u6ylNegv6Nv8WoLUlFBatIpNHO9EBMwe4lSPB05W/7086/ZlEdQqFI1+YEc95REVRpTc6IGvV3qgZzzNki2zWXyc5Zo9xq3XJfynsMvPoDGwhKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2IMmEJosVTKoYYlPdAUvogcK00oBq8yWHDF6U1wp/s=;
 b=VPgfCSKvmgvOwaUn9x1y9V26kYS7if+ZT1EIeBu6RDUv5Tr1h804f3YfJPBg/W7dg4hjgnJBgZmPoJXvDeQR1+rvgi+kyFYeSnU7VIq3uhD+dp4O6YnZFRZiwzZMCx9vdLcvkUdBMcjB5UN1QD0tyPb26Ye25jG9m92DWgF2UXALMo+2TJ29/EojTKXVuoJalker8EUm9hBI/u6T56WTCD/5mHs8LtY0WqdYMJKnhmFA1vRrDL8b+n7UnrkrdGDLntTreuwKB6s4hmisVP+xc+9xQKqzSAGkOllNm6nO4rmQHzawnrZNidN4Va9pz3raHlRyT5iEEf6egSndfqiLCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2IMmEJosVTKoYYlPdAUvogcK00oBq8yWHDF6U1wp/s=;
 b=YOBsl6G9qv3nz9VOoDa1PUqXrfwt7PBEpbqxahd0PiRJF4QRRKhDdmjYc9cuJZf4bTNVmzqyzVC5Y6kADDEcMEz9o+num1RKWjT/XfQ3yul4AJjN7n+w6k4cWQUhk/JkonpBn/3fjS1gT1zosCasQAvlzoBHUZ9sSwD8biRrwwUtUW8C6PritjJK3nBDdGFG+Gjc58wWvxz2eOWfOelWvRx2m+YCBxaplFB61RAsAT3Hh/rO8Z+V77bIoAMadHRxiyg8GKD7T056Leg6Clq6H9e5tcWu64OcHXW7EdXuLkH/qmx7gPQ5V499NgAyXQ1Asl8rqo5MwtYteywIRmavcA==
Received: from PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fb::11)
 by MA0PR01MB5727.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:48::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Mon, 6 Jan
 2025 23:55:47 +0000
Received: from PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc57:de35:cc59:cc4f]) by PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::fc57:de35:cc59:cc4f%4]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 23:55:47 +0000
Message-ID:
 <PN2PR01MB9523B10F2CB04FCCC6C4D7AAFE102@PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 7 Jan 2025 07:55:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: pci: Add Sophgo SG2042 PCIe host
From: Chen Wang <unicorn_wang@outlook.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Chen Wang <unicornxw@gmail.com>
Cc: kw@linux.com, u.kleine-koenig@baylibre.com, aou@eecs.berkeley.edu,
 arnd@arndb.de, bhelgaas@google.com, conor+dt@kernel.org, guoren@kernel.org,
 inochiama@outlook.com, krzk+dt@kernel.org, lee@kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, pbrobinson@gmail.com, robh@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
References: <20241210173350.GA3222084@bhelgaas>
 <BM1PR01MB2116EB0657EA6E231AB75BD5FE062@BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BM1PR01MB2116EB0657EA6E231AB75BD5FE062@BM1PR01MB2116.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:fb::11)
X-Microsoft-Original-Message-ID:
 <d851522a-1950-48dd-b1ce-bd3f5f626606@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN2PR01MB9523:EE_|MA0PR01MB5727:EE_
X-MS-Office365-Filtering-Correlation-Id: 966132b0-e0f6-45f7-d8ec-08dd2eada3aa
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|8060799006|6090799003|5072599009|19110799003|461199028|10035399004|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejdmdCt3RkNXTzdqSXQwTTJINjlqMnZ4aGI2TEtaNzU4V1l4UjI1bXZFNndu?=
 =?utf-8?B?RmdIb0hwZDVqTHdsTk1XY1pWZytpTk9SRGZIY0hVZjlBcDMxZEJLZ1RhZ0o1?=
 =?utf-8?B?VDBKYVBFOXlCOW1wM3pWV09tRzJyNkpFK2FTc1RTN1NIU0RPbEhheTFjOHND?=
 =?utf-8?B?OVRBbmNMZFZFVmJYSTY0R2hZWmlqZVVLSzhkdjdFQVNkdkUvS3RPYWdGWHFl?=
 =?utf-8?B?K0QyMTkvQktqY2dNSHFxZE1Da1U3a3cwUmtldmFKd0tvaHlwVW5ZaGlWcUNB?=
 =?utf-8?B?OGtDWll6UU5FcmhlU3A1eXFuRTRSdldRdUpMS2dzTWRidVF1UHpDVlExRHUy?=
 =?utf-8?B?Yy9zaHZzMUhsR3RtbVdxQ2hxZElXa0EyTFZ2M1l0R082TGNmSVdsenArN3Ri?=
 =?utf-8?B?alBnZFQ5UlkwOFd0SC9Gb0tCaTBnOEJJTVJLa0gvdnJUUCt0NmJSeEtMM0Fn?=
 =?utf-8?B?S1p4SjQ4WjNBTis2NUdkYWZEOCsvZVdOUXloWWNTS0pEVTcwY001emV3a2sv?=
 =?utf-8?B?TWI5MmZLM3JVekhJOGpqSWQ4bmhqN1plRGJobVY0UW0zK3lMazl3L3JSRWh3?=
 =?utf-8?B?R1dBS1piMGN5aU1QS2ZtZ2VHUURCQUJaUXduMXdUY2JzWjNzQ0tIdHc4T2tE?=
 =?utf-8?B?eElOU015Y2Q1Y0RjNndFRmFZQXoxa0d2OFg2V0hUN2NDWHBDcE5YTWxoYlll?=
 =?utf-8?B?cnZTcjdleTZnREllQm5Pd0plMDN3S1NvT3FLbC9KNG9wQkR1NDdjeWhsMGxR?=
 =?utf-8?B?SGk4NEpzSVg5VVV1Vkx0eS9sVUNzRE9pV2dhdE9Ib0pkQUxQVlhuN1VqdmFu?=
 =?utf-8?B?a1RWdkdwdVc1N1NVNkJWTVYzWHc0WXh1V09ZVUt1dWt1bjY3KzFsTzFRZmZQ?=
 =?utf-8?B?S09sbzUyaVp2VkU0YTRKNXExMjR2SXduVk1KUWRST1BPcU1BVVVGN01peEdU?=
 =?utf-8?B?VVJydFhPdEw1c3hQMFpTNnd1SWdCRzFQNStDU0pKUllaaEFtQlRVLzdXVFNn?=
 =?utf-8?B?aEwzRDlyL0tPM3MzdzJlaDZMSmtuRklzYmNuK3ZqL0tvbExTbDUvcVRnMUVJ?=
 =?utf-8?B?T1FZWnZ1WmdiU0hqbXdURHVRcEV4N2FRcTZ3VHYwaDRiYXNMYkpMSHRLK2JS?=
 =?utf-8?B?TUlkWTg0R0M3T3lUdS9KWm96Q29KeEFOeWpUeHRSU1JVNHk1RklrVDVFZHAy?=
 =?utf-8?B?T3A3Z285cHZVS1V1dG1JQy9zMDFMUDZWN2ZxMTVVMTRESXZ3VzB6UlRXZlhZ?=
 =?utf-8?B?akpUVStJSEsyYkdDWXRZWDBBbWI4MDFmNHRuOUc4S1BwRUsxbEgzc1U1ZFFM?=
 =?utf-8?B?cWVLdzUzOCtLeUVTRXBYbVc2Q2E4aDdvTHBMREN6MGRHaVgzWkIwY3VaLzlY?=
 =?utf-8?B?S0tzcG55eW1VODA3Qi9Bdm5UcEkyN1ZiZHhDQ25QY1hRUmVaZ1o4dW05bUxu?=
 =?utf-8?B?aUdyYll1RTZOTGRmc2NnSWp2MnBYaGczc09RTzhreWVtVmZmbjMvN0FWTXlS?=
 =?utf-8?B?clp3NW1sbCtCdFFXYi9kR2ZLRVpZSVFwMmwyWmMraUFSK203aXF5dEZTR2Q0?=
 =?utf-8?B?Z05VdUlCWC85cEhjYnFFR0tQaXFUTVBvL1VZVzZXYm0zdXltMjU3VFZWTGND?=
 =?utf-8?Q?c3e7n75F9WJ7vYW1jK/HXE1V+cRPqko0hvjAbAeGTSFo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czlkWnFDM1lYaTVmc3JRZDlMTm8ydkR6Q1N0alVueUJrRWhCV3dTdS9ERTNt?=
 =?utf-8?B?QURmd21Wc2xNUEhtdXVtYVpTOWpDaEhlYkRwUFhiaWpFVHY1UjhZaWdOTk55?=
 =?utf-8?B?MlNMZmNXakhuUmhCNEtZaTIwcEEzR3ExSHBwY3ZSd2tZWjFLREkrVWtUanQ1?=
 =?utf-8?B?MHBkYndLUTM4cUFLR25WL0xNbktRY096dVA3aHZ5M1ZoaUtBVkZrK3psU1Zv?=
 =?utf-8?B?L2JQR3pBSjZUL1pJQ25sWnV2Ui91bk9VUzRTTU5iYXJRRDVMSkpFU2dyeTd0?=
 =?utf-8?B?MGhycFZNajVSK1N3WGhOaHNsNWQ1TW9FQ0tpbC9FQlVoWWhtZlB2Njh6L1pX?=
 =?utf-8?B?ZCtISEduc01ITlh0WVFQUnd0Z1JFSXhhL1JCT1B2OThocVFFWk5KT29iZGNV?=
 =?utf-8?B?eWxYNlQ3eUZlazVoOE9YZWlYWG1yZ3NjdWsvdGIzcGVESTV5V2lLZVp6b0hG?=
 =?utf-8?B?TXVEdWkraSs3cWphcnNjTUh6WmF6VVpmWm5TUE5MWWNzWG4rckVPcmpaVWpx?=
 =?utf-8?B?azQxV3NQSk1DVzlNcHgzcWw1WHNQNkRoTlNMV2tzU3UvakFGYmdSdEZaN2tC?=
 =?utf-8?B?OGRma0MyN2xMQ0doZjUvS0FBemszVDR0S1ZXSmhLMFJGL0JISW1hQUN2bUtP?=
 =?utf-8?B?S1VFSWVsbVk5bmVWRzErUUJQYUZhc3lTeGVjY0ZCSVl4ZUxuYkl5OXlUUGxw?=
 =?utf-8?B?VmhyV0hrczJyak5kSUlmb3BQSkFuZE4xWkNjbEozem1RSUlIajh4MExBQkxP?=
 =?utf-8?B?NmtjcVdQaURQN0NNRHRVV2FwN2I2R2I1QTFIVS8wNlM5N2hqQUZvT2lSMk9E?=
 =?utf-8?B?NWY2SlNMOU16SC9ITTBYTUI0UEtDd3Mwa1dLM3lGRlNodGZ1THEveVBNMlNY?=
 =?utf-8?B?ZnExWms0V1Jla2VmWUwwQjNNblNnNk5LM3lFZFdhRXV3TXVyejZycDduR0JT?=
 =?utf-8?B?Wi9SNXFzR0NpUitrV3Y0RFV2RDlSejZIOE95Ukh2QWRxM2xOT1RHczd1Ymc1?=
 =?utf-8?B?SGZpYXVVYUo2dTNoZzFYWEQ1dld3VVdGaW92V1RMc3F1TUVwL2dYeDNzdCt3?=
 =?utf-8?B?T0dkMUtpMmFFVkFnSkZlUTFSbnZpeHhSTzdBUVdXa0hyMG8xMWc1SjVFQzZa?=
 =?utf-8?B?SGs3ZkVwK0xENUFUbEhrOW52eUVRSUZNUHlpZlFpWDBnZ1JjdmQ4NXNmdFc4?=
 =?utf-8?B?OXR0UlROTjB1elk0Mk9WN1NkWlpZQVVpVVZta0dFZGVMajdLUUNRRy9mUTFi?=
 =?utf-8?B?Ym9hNFZWSFA1ckp5K2Y5V1B1Y2QzdzJhRC9EdjVocS9RaEREaXdjTXJIc1VB?=
 =?utf-8?B?Y0dyMDdQbWphdW44V2hFT1V2RDhwSk5KdUZZWTgzZjdsTmY2TmVUWk1IM05k?=
 =?utf-8?B?eWhxbkdpZWI1UHlFblRQSzVyR0R6NVV1K2NtZmkwczE2TDMwLzJnVXZ6OTRy?=
 =?utf-8?B?ODhQM1VucDRnTmlrTTMxRkZjSEVhUkF5WkJxSUdsNDRpWE5uUlhrZVBOUlJW?=
 =?utf-8?B?b3JCVEtGY0dEZTJ3R3JTUGxTUXNna1ByODdYUWs4K09nSUE4UFhmaEkzYzFW?=
 =?utf-8?B?VGZjQW5RVE1yTW9OZk0veWphTE80aFljSis4SGx4REREbUhqTG83M3RrRnJO?=
 =?utf-8?B?RURxSWV6S0pxWDVQQjlNMjh4YXBob2hucFdGbTJBSHZJM2FBc1U5RFVEbyt0?=
 =?utf-8?B?TlU4c0QyUXlTZjZHa0llVEd2am9FZEFEYUQ1RFBuODVlbHcreVZGRU1ZLzNC?=
 =?utf-8?Q?9aTuCctOmBv+AzqIqNylj5jDk20i0tkw/DvuXyk?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966132b0-e0f6-45f7-d8ec-08dd2eada3aa
X-MS-Exchange-CrossTenant-AuthSource: PN2PR01MB9523.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 23:55:46.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5727

Hello & Happy New Year, Bjorn

On 2024/12/19 10:34, Chen Wang wrote:
> hello ~
>
> On 2024/12/11 1:33, Bjorn Helgaas wrote:
>> On Mon, Dec 09, 2024 at 03:19:38PM +0800, Chen Wang wrote:
>>> Add binding for Sophgo SG2042 PCIe host controller.
>>> +  sophgo,pcie-port:
> [......]
>>> +      The Cadence IP has two modes of operation, selected by a 
>>> strap pin.
>>> +
>>> +      In the single-link mode, the Cadence PCIe core instance 
>>> associated
>>> +      with Link0 is connected to all the lanes and the Cadence PCIe 
>>> core
>>> +      instance associated with Link1 is inactive.
>>> +
>>> +      In the dual-link mode, the Cadence PCIe core instance associated
>>> +      with Link0 is connected to the lower half of the lanes and the
>>> +      Cadence PCIe core instance associated with Link1 is connected to
>>> +      the upper half of the lanes.
>> I assume this means there are two separate Root Ports, one for Link0
>> and a second for Link1?
>>
>>> +      SG2042 contains 2 Cadence IPs and configures the Cores as below:
>>> +
>>> +                     +-- Core(Link0) <---> pcie_rc0 
>>> +-----------------+
>>> +                     | |                 |
>>> +      Cadence IP 1 --+                                | 
>>> cdns_pcie0_ctrl |
>>> +                     | |                 |
>>> +                     +-- Core(Link1) <---> disabled 
>>> +-----------------+
>>> +
>>> +                     +-- Core(Link0) <---> pcie_rc1 
>>> +-----------------+
>>> +                     | |                 |
>>> +      Cadence IP 2 --+                                | 
>>> cdns_pcie1_ctrl |
>>> +                     | |                 |
>>> +                     +-- Core(Link1) <---> pcie_rc2 
>>> +-----------------+
>>> +
>>> +      pcie_rcX is pcie node ("sophgo,sg2042-pcie-host") defined in 
>>> DTS.
>>> +      cdns_pcie0_ctrl is syscon node ("sophgo,sg2042-pcie-ctrl") 
>>> defined in DTS
>>> +
>>> +      cdns_pcieX_ctrl contains some registers shared by pcie_rcX, 
>>> even two
>>> +      RC(Link)s may share different bits of the same register. For 
>>> example,
>>> +      cdns_pcie1_ctrl contains registers shared by link0 & link1 
>>> for Cadence IP 2.
>> An RC doesn't have a Link.  A Root Port does.
>>
>>> +      "sophgo,pcie-port" is defined to flag which core(link) the rc 
>>> maps to, with
>>> +      this we can know what registers(bits) we should use.
>>> +
>>> +  sophgo,syscon-pcie-ctrl:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      Phandle to the PCIe System Controller DT node. It's required to
>>> +      access some MSI operation registers shared by PCIe RCs.
>> I think this probably means "shared by PCIe Root Ports", not RCs.
>> It's unlikely that this hardware has multiple Root Complexes.
>
> hi, Bjorn,
>
> I just double confirmed with sophgo engineers, they told me that the 
> actual PCIe design is that there is only one root port under a host 
> bridge. I am sorry that my original description and diagram may not 
> make this clear, so please allow me to introduce this historical 
> background in detail again. Please read it patiently :):
>
> The IP provided by Cadence contains two independent cores (called 
> "links" according to the terminology of their manual, the first one is 
> called link0 and the second one is called link1). Each core 
> corresponds to a host bridge, and each host bridge has only one root 
> port, and their configuration registers are completely independent. 
> That is to say，one cadence IP encapsulates two independent host 
> bridges. SG2042 integrates two Cadence IPs, so there can actually be 
> up to four host bridges.
>
>
> Taking a Cadence IP as an example, the two host bridges can be 
> connected to different lanes through configuration, which has been 
> described in the original message. At present, the configuration of 
> SG2042 is to let core0 (link0) in the first ip occupy all lanes in the 
> ip, and let core0 (link0) and core1 (link1) in the second ip each use 
> half of the lanes in the ip. So in the end we only use 3 cores, that's 
> why 3 host bridge nodes are configured in dts.
>
>
> Because the configurations of these links are independent, the story 
> ends here, but unfortunately, sophgo engineers defined some new 
> register files to add support for their msi controller inside pcie. 
> The problem is they did not separate these register files according to 
> link0 and link1. These new register files are "cdns_pcie0_ctrl" / 
> "cdns_pcie1_ctrl" in the original picture and dts, where the register 
> of "cdns_pcie0_ctrl" is shared by link0 and link1 of the first ip, and 
> "cdns_pcie1_ctrl" is shared by link0 and link1 of the second ip. 
> According to my new description, "cdns_pcieX_ctrl" is not shared by 
> root ports, they are shared by host bridge/rc.
>
>
> Because the register design of "cdns_pcieX_ctrl" is not strictly 
> segmented according to link0 and link1, in pcie host bridge driver 
> coding we must know whether the host bridge corresponds to link0 or 
> link1 in the ip, so the "sophgo,link-id" attribute is introduced.
>
>
> Now I think it is not appropriate to change it to "sophgo,pcie-port". 
> The reason is that as mentioned above, there is only one root port 
> under each host bridge in the cadence ip. Link0 and link1 are actually 
> used to distinguish the two host bridges in one ip.
>
> So I suggest to keep the original "sophgo,link-id" and with the prefix 
> because the introduction of this attribute is indeed caused by the 
> private design of sophgo.
>
> Any other good idea please feel free let me know.
>
> Thansk,
>
> Chen
>
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - reg-names
>>> +  - vendor-id
>>> +  - device-id
>>> +  - sophgo,syscon-pcie-ctrl
>>> +  - sophgo,pcie-port
>> It looks like vendor-id and device-id apply to PCI devices, i.e.,
>> things that will show up in lspci, I assume Root Ports in this case.
>> Can we make this explicit in the DT, e.g., something like this?
>>
>>    pcie@62000000 {
>>      compatible = "sophgo,sg2042-pcie-host";
>>      port0: pci@0,0 {
>>        vendor-id = <0x1f1c>;
>>        device-id = <0x2042>;
>>      };
> As I mentioned above, there is actually only one root port under a 
> host bridge, so I think it is unnecessary to introduce the port subnode.
> In addition, I found that it is also allowed to directly add the 
> vendor-id and device-id properties directly under the host bridge, see 
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-host-bridge.yaml
> And refer to the dts for those products using cadence ip: 
> arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>
> In this way, when executing lspci, the vendor id and device id will 
> appear in the line corresponding to the pci brdge device.
>
> [......]
>
I see that you haven't replied since my last reply, so I will continue 
to modify the code as I described. If you have any comments, please let 
me know, thank you.

Regards,

Chen

>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

