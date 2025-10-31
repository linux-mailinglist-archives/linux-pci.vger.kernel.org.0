Return-Path: <linux-pci+bounces-39923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E201EC24FFE
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 13:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F88D4F26A6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 12:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEA3311C21;
	Fri, 31 Oct 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="P06jWgOX"
X-Original-To: linux-pci@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazolkn19011057.outbound.protection.outlook.com [52.103.14.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E42E1743
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 12:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761913614; cv=fail; b=uPC1pgcMLw6KhEZgtnG71EOfmEgmoMPL9bnFoNd2geWWfJJRRuTckV38XIzLsC/i7OUiBa5YSagQiRP4AlUeEwaA4DzZG4XmWRCSdc57poYOvPj0XGOoOXG52Vk29gCE6U7KbBjUj1KsX4GYFoADcS8MBuQW4NniGZEclvIsTMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761913614; c=relaxed/simple;
	bh=6eqT7js4ivy8uSQiBrVzU3Y5OPWABiM3Fh/QYNOjazU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rM7A7sDHxcj2O0FUqH1qRgmZuEy+6MAp/pEh/xWgitcQnFpSxSgkW/TlFpVqEk+6hE0PxTxngkLA6ahwdfJ+PuPkPeTrLt20OEyRkv8iZ8mPnHEkqeNBy7ec1eLP6KIFd95AXzfGvXV5wNtOylKH+i1s3N+DrCrH9Yy3y6Mtc6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=P06jWgOX; arc=fail smtp.client-ip=52.103.14.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f4Kb6kQHH7FkHcO9iWSdFW7jeWYgBFdaeFvVDNyoupxlGYNkhyPcCEm148JcKo3s9jY9SiFDMfKTdKfH7+iV+M6wxSep2GcaEVy9JWZacCOPmflNNL2ZhPrBCJFT+O4iR58+Xb2g1NYWKOD1+vICBQyYN3ZaQZX0x+jQ8BcRjJnDfiBFpELf/yLJyTb+RKTSTFYEOMZAk52P1asgT3T4huVvExverJEL7E5PzihtV7em9MM6jcb00xUQdPBLz8MC8Z9tCBz9qt/p13shXUYf2Xtw0I9nrEzOe+Zl8vaofCQYLGJqe/q9eC7tSTaYgy4oPr6riT6TIr3i/Jbjz2uPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivStXU92dxeDbYsyxKKfAZGiaqEGqNGM5JByfQxJOv0=;
 b=lKoRT/cYThYa/K0WTypeRRRVSm49tXEt+XR+hBmR2Kv7FeSA1MdhqRdO65GFTPEyFTKkwcV+khqw0BQBfx9lRd5zvL0AXnGgPzOm6mO18KGSvPHyGmUAAn3Qo7L3KInDwfWWj0WuMJn5WuUd2ZNDVVRhBdXeT3Az905WjFWPTYS1isIslylnVmkTbItwBvWeB9LcuOqtXX4FIISoE2m2wt2owlhS4vAXt2BMGLUGb3vbqZXe4eB+LwDQ44CTKoK+Hz9Tk1wWZV5a3F+cILsyfv3KD8kXCAUEYixUL/sfXl7Z6hB7QuKM3rqqnnRLeZ00FZzTz2sjwMpcD4jlRUM4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivStXU92dxeDbYsyxKKfAZGiaqEGqNGM5JByfQxJOv0=;
 b=P06jWgOXJK7iK8NjqRfbEj+c3xXjpjLjrT/TiMaggDoE1zAFjITUsevzJCClrALO5bZk7iAS54pJK3fTZOTdUoCA+ox0urneSn5tih7q+iS/QMzgP+R/YIcixsZ0aEmkNoEds2ytXPyK7XvlvE3crS4/ILhzhuOr/o+0aPiUzZOADh2F7C1mNg/BAT+t0B6rt5y6JJOQ0cMcgKUgqdk7NvTEV94DFzmjJoMKpaJ/XmXn/zwGdSgzmM1dUacpFItI3WSU2itlwMk+LEBQlAWCgQUW1eEpdwH9oZchBx/kWWnKUX2LWAPFMheWZh0iE141tkpIwKDpDu9I48xAo28qJA==
Received: from DM4PR05MB10270.namprd05.prod.outlook.com (2603:10b6:8:180::11)
 by PH7PR05MB9286.namprd05.prod.outlook.com (2603:10b6:510:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 12:26:49 +0000
Received: from DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c]) by DM4PR05MB10270.namprd05.prod.outlook.com
 ([fe80::76f2:11b4:e433:a65c%5]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 12:26:49 +0000
Message-ID:
 <DM4PR05MB1027077E1F4CD8B1A7EDADF1DC7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>
Date: Fri, 31 Oct 2025 20:26:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251029171542.GA1566240@bhelgaas>
 <DM4PR05MB10270506AAC1FCE53C4915CC2C7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>
 <59baecc0-bc28-4411-bf83-37ff9e7dd193@linaro.org>
Content-Language: en-US
From: Linnaea Lavia <linnaea-von-lavia@live.com>
In-Reply-To: <59baecc0-bc28-4411-bf83-37ff9e7dd193@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::32) To DM4PR05MB10270.namprd05.prod.outlook.com
 (2603:10b6:8:180::11)
X-Microsoft-Original-Message-ID:
 <b6d6172d-4311-475d-bbaf-a2a77f538ce8@live.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR05MB10270:EE_|PH7PR05MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: bb28991b-4d5c-4f3f-5741-08de1878c3ca
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|12121999013|15080799012|8060799015|19110799012|41001999006|23021999003|6090799003|5072599009|461199028|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG5Cc1NWNmpWQ3UvdGxFQ0xSWDg1NDhWSEpHTG9PT291SThxWmpDeWxWemJW?=
 =?utf-8?B?ZFlYQWVvbW8yRXRLcXFYdFdaeHVNUmJ6Y0Fidnd0RVQ1ckgzRTdReXFGMXgy?=
 =?utf-8?B?cFlUMGhaT3BFaEhZa2RhRlpWLzRla0VQTWlZVy9xNWE0Q2NiWFFGQ3lQL29a?=
 =?utf-8?B?dTNvSWJNa3o3Z0QzOUE0VVFLNlhTZ1pnNC9ITlI2aGhCZk9VVDZJYkdKUVgv?=
 =?utf-8?B?ZCsrL3UvbCtGRVR1aUFKejBHYVlmclVrblVsODN4TStLL3NVNU10bnNUYTR2?=
 =?utf-8?B?NjFmWGpZWVJQOUptTnBWUzlPbU9lZk9zUjc0K3djVWdWUGJ5VXYzY3dnUkR2?=
 =?utf-8?B?NjM1cnBDQVNoVkNRemE3eUJnVWlJbHQvOC9BaE50TEJISXk3Skd5K2VVa1Y4?=
 =?utf-8?B?amo1UG92WU5Ic0lYWkpLbDY3d3VjeXVJWnp4V3ZCZWMxQUU3QTVBUk0xUFJo?=
 =?utf-8?B?bEF5UW1VVXBtMmhFWGdkb1cvaGxDY3FjeVRjYkZlbkI0cnJhZngydis2SmRz?=
 =?utf-8?B?MnNqeENzSHhZTkpDeG9STGZNRzRMNm0rVWs5S3dNbytRQTZtYXVoQllJN3Uy?=
 =?utf-8?B?bGRQREV4T1RHY0RRL3VtNXUyUk9QY2s4QldPZm1GclA2NEIyaUlUaVJ2MjV0?=
 =?utf-8?B?MG9sY2phdllzQVA1MU1ZM09odExESFBqcXNDRG9qdFJEUzN6b0Z1Nm1UbGgw?=
 =?utf-8?B?S1RQTkhZbkw2WG5PTElUbFRRZUJWRHRKVnlMY05Gc3pzclc2RFcxR0NLUVlB?=
 =?utf-8?B?Q255eEtMSDNEeUNNNFN6dGVqelZQQWgwWGRycnFFM3ljeldSNUE5NXpCTWIy?=
 =?utf-8?B?MnRJbzRub0JkV2JwemxZZC9ZQ1pDV2piR2lIKzZKNEdtS0ZuSEFVU3pBRng5?=
 =?utf-8?B?N1Y0ZFFNVFBzVXpJc3FRUDkyWVRwenhCMXh3TmsvOEFoVU52aDJJNW9GUC83?=
 =?utf-8?B?MjhQSW9mTmJaMzdEQzYvbEp2eGtVZVRLY0NoTDJZUWVaRjkzTm9zUTBwMlhU?=
 =?utf-8?B?aU5ESGJiWTVnV1lEMlI4VjJuQU5JUWdTTjJTdEhMektnVytJQWc5YjJGSmJt?=
 =?utf-8?B?ZkZVYmNST0w3d0xNNGIyUVRHZkRRL0xwRWlxRWNtYys2OXk4SG5wbHpTbDVx?=
 =?utf-8?B?Zm1lMVpsaS8ySXJSZVI3aUdNcVBvakNkWXF1SGFoa2toczAvS1BPSnJVL25w?=
 =?utf-8?B?VXVZR0Y2YnpaZmRjK3c0VlZOcmsyU3pLcWV4d3diREJHWW9VVk16TG5LMUJl?=
 =?utf-8?B?TzMxMmFzV0Z5MFc3TURjU3E2bmFvVzBjelhBZDFvbGttT1NLVitibGpnS0xC?=
 =?utf-8?B?clB2Ym04QnFJaXNPblpFRDYyUmR6YlA5b296R1RDZnFramZaak9pTTRFNk5y?=
 =?utf-8?B?Ry9nUG9zRFowT0IxallHYU9wUkh1ZENjcmlkbXlrWjN1Rmw3TnJhb2tNcG5O?=
 =?utf-8?B?UERGNzNiMStGeUZBWnRsQXN0TXE5clB4bHJQSGgyK2UwOS9xSlhqWDZLdHhm?=
 =?utf-8?B?ZTRaZ3dNbXNXc0JIcmFUYk9aZEplTzk5MU5tcWdlOTZ6UUNBTDl6VlJKejZ1?=
 =?utf-8?B?MXZDV1R2Y0szNmc2dnpoQTV2d1M3VVoraHB2eE9NNEpuRU45Y25XYktxVkEx?=
 =?utf-8?Q?EBWZO65ztNJk/HjLtbQHezRBXpq6fYilvUTlUnuMZ26k=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZhUkdhL0hBR3NXYW11MDdMc2dhYjQyQjBwOE1uZ3ZDaTNBVlJwTElTZ09i?=
 =?utf-8?B?cEtWbURHNmV0aDZ5d0djS21YRmNoZkpMODdRRDJpY3RHRDVESXpTRkY2SldS?=
 =?utf-8?B?a2hSb24zbEpsdHFZQ2JnbVFBZ0FjekxkbDF3WGpmUWFoUmVmejN2dnpUSSty?=
 =?utf-8?B?SFhpUk5VdnRaV2pzK05yVWtlczVqZzc0ZDRCZllnbFNGMFZhdmZuSGFFa1B0?=
 =?utf-8?B?MjQ4RFk2NUhDUnJWMTk1eHltUGpxMDVHZHpvU1daYVlpeDk1dEZBN2xhTDBn?=
 =?utf-8?B?SDNhaUNoSFRRbXhMa21GYXgyZTJGSkJTWCs2eTc2WmlJZ0FvVEdobTJMbXBi?=
 =?utf-8?B?cHdiWTBPUnBpQWpWZTlJS2lzSjBhYjJJN1lvQ1YzZ1VadW5sYThic3czN0Nv?=
 =?utf-8?B?TzQ1UWxEUTNtdTNjOHRzNXozOVRmbkM3UnBLOGNUMXpiaFVrejVvSFArWlhC?=
 =?utf-8?B?NGRWeDFaaXZrVVNuc2o3Um84VDk0RE91eXJWdGtaN3ZkWkVuMTZBcnN2eWJX?=
 =?utf-8?B?N3RsbzFPUUE3QnJOUHcrY0g4Mk9Va2hrMUs1ekRIa0s4TXNWREVIZ1FvVG5M?=
 =?utf-8?B?S3hhbXRja3NhNDBVVjFtSGg2Nk1oOFdqSWc2a2dxZ2xNNDJPVkhZcGlVWWFE?=
 =?utf-8?B?T1R1OExuV1A2VWlFd2NFRXVzRVJzNGtXUGhsYXByc2NVZ2VTWis4YkRiMmtS?=
 =?utf-8?B?NTFEZWhiS3VCY0FUVXdzQm5HNm1KdTNITEI0NzFJWTB0QkVDZm50SmdjelZH?=
 =?utf-8?B?eTZkZVE0RFZIeEVJMmpiS2h2dUt6KzJtaVJBc3pmMjUvc05YcVdTcWZEZjV5?=
 =?utf-8?B?VkJ1ZlF0a1hMUUxJQTh5WFBYeUY4ODQrOFRvMW4vTTAzSHRXVW8vZWIyMHNr?=
 =?utf-8?B?aUtxSnRmc2MvTkk5Nkg4TytaRmF0V2JJcVdXeHBnNUluZXYwa0hSYWZUUFBV?=
 =?utf-8?B?MGlTWjBGQ1hWZEFKeW5ZVGFSZCtmN2NXNy9oYUtSUjQ3NXg1NE9nZkF3ODNZ?=
 =?utf-8?B?WVFqalVGbG1TZU5RYjhYS3BLdWhHaVBJU0luRXVuZndtSmJrOXcrTHFzTDQv?=
 =?utf-8?B?QjNxVkxKTS9WcjNzdm9TMjZJSzRNbjd2TzBETjZuRVI1VUlYZmxPY25NbUVQ?=
 =?utf-8?B?eHMzdzRrZkdhRHFrMmVjUEtLTU9Ham5lUjVrbWVLRVFlU29rZkRVTTZUalVD?=
 =?utf-8?B?MHFCKzVKVU9EdkUvbU0wUkNBR2MzSTRFMkcvZ3QyYm5HeWhQeUF1NkFQQ1dk?=
 =?utf-8?B?OGpSWTl3WWhJdGd1V2p4Q3Q1MU9VZzNTYlpsdnFCL0E4U2ZreTFrR1p2b2dT?=
 =?utf-8?B?anVCOU1OdTBoeVNTNFZkRFFwMmdEL1NPdUV2bWR4ODJ1TkowUFpMUVQ4ZVdh?=
 =?utf-8?B?bE1VNHNzSGxBd3JKekJ0SkwyODFiWlY5cjUycjh0YWVkeHE4bTIwc3FJNkVn?=
 =?utf-8?B?eWJrZEk0Vy9IOHp6OEJiMlludUgrbHo3aTl6aHBBMWVqYjJHY2llQ1RoeUtv?=
 =?utf-8?B?Zi9FRWxDSFRDRWI4bEM0RzNmc2Y0RGRKSHh3ZEwvTzUvVE5xSWVDRjlzbi9Q?=
 =?utf-8?B?OUFIYmFSYXRLdUpGMXdzWkM5Qk5aNTlwbEpLYWI0NFlZSWEwcnZmUUdzNGo3?=
 =?utf-8?B?WVErZEwvU2szTmd6a3M3TGV4TlphMjJxMlo2MHJxRk1rMXZEWGNvSjYyTkEr?=
 =?utf-8?Q?4bVYvb4FpESqffBtuL4+?=
X-OriginatorOrg: sct-15-20-8534-9-msonline-outlook-d08a8.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bb28991b-4d5c-4f3f-5741-08de1878c3ca
X-MS-Exchange-CrossTenant-AuthSource: DM4PR05MB10270.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 12:26:49.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR05MB9286

On 10/31/2025 4:50 PM, Neil Armstrong wrote:
> On 10/31/25 06:34, Linnaea Lavia wrote:
>> On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
>>> On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
>>>> On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>> index 214ed060ca1b..9cd12924b5cb 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>     * disable both L0s and L1 for now to be safe.
>>>>>     */
>>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>>    /*
>>>>>     * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>>>>
>>>> I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
>>>
>>> Sorry, my fault, I should have made that fixup run earlier, so the
>>> patch should be this instead:
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index 214ed060ca1b..4fc04015ca0c 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>    * disable both L0s and L1 for now to be safe.
>>>    */
>>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>
>> L1 still got enabled
> 
> <snip>
> 
>>
>> The card works just fine. I'm thinking the ASPM issue is probably from the glue driver reporting the link to be down when it's really just in low power state.
> 
> You're probbaly right, the meson_pcie_link_up() not only checks the LTSSM but also the speed, which is probably wrong.
> 
> Can you try removing the test for speed ?
> 
> -                 if (smlh_up && rdlh_up && ltssm_up && speed_okay)
> +                 if (smlh_up && rdlh_up && ltssm_up)
> 
> The other drivers just checks the link, and some only the smlh_up && rdlh_up. So you can also probably drop ltssm_up aswell.
> 

I can confirm that removing the check for ltssm_up and speed_okay made ASPM work.

We still need a solution to the original issue that's preventing the controller from being initialized.

My kernel has the following patch applied, but I think it's not suitable for upstream as this changes device tree bindings for PCIe controller on meson.

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

> Neil
> 
> 


