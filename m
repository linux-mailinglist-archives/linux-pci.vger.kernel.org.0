Return-Path: <linux-pci+bounces-16996-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096A9D025B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 08:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006021F22404
	for <lists+linux-pci@lfdr.de>; Sun, 17 Nov 2024 07:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA033433A6;
	Sun, 17 Nov 2024 07:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mlU5pD3W"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2032.outbound.protection.outlook.com [40.92.91.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFB383A5;
	Sun, 17 Nov 2024 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731829137; cv=fail; b=m0vLIsfb8zni9H5xqbk47JjxWy28l1qFVIqjw60vYYJ7AhzcWgHh5cPEOtbIX1UGyb1/gAwOafX6Dp1zmkMoi0X+jf/QlaETXvD15VwES3T6DbySpNXh+F14A9m1jfdyMGJ2xK7gJVwT/QTaWBzNhqD1Scex4v9m/3KbXcfIEGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731829137; c=relaxed/simple;
	bh=2MzFM1i2AhuQ+KvnGjVE3+TztOJs3zV64eFovEIhN14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IMUpKYXzCyKBqDi3bb0jzh3CrfzngOP7gERiva76DhMyZmd5J/7b73UkkA8s/dDXNlfR4IOedKgX3rBI2tvEhCmfK1b9fCqHnaSC5XWg/390QUU5n8WbVypFxPWa/gUtGRLVBz8ljRPa8N3W9vNLXEZ4tNO289txW5d4iuNE0Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mlU5pD3W; arc=fail smtp.client-ip=40.92.91.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed6GAJl+c7chNcFfae5WMcZcbHxbnHLbxmgPYxZAr2jW2/er766r5wICaTB5HMYxbRiJ4WHz7guStcfNZvBsNHEOyCXBPQhDYNrBO+OogJaLspoFMlzvcqwtHg1Cr5wM9sIh6YHZ4NsKDuaRuqtbn3X9b0NIBndVD0t8DMGqvZaON7vjYVBzCSCYBRGxVRY908g3o3EliNiS+I1Jy7zCu3k4tGrkyc0wNVwhGSqeaDx6RL+M4ToBsZn8LIT9IkDukswSczUwclzUKSU7z0vHwbzquErJMockcIui+THb1me8c+d/JJ3JqzTvVaypCw3TdvDv1/551BR2lplAYDGv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSd0bc5vBk/3cX79tK0wRwRWIfG/q6PZ8pz5Ox+jLKI=;
 b=jb5cjeOKOTwyzxyKk9CNYk87Fr71cZEq5pykGWl3thFvkAQg/5CvD3G8ct70l3UoXDwM/8cWuBvjwtLne3YIgxnwDz6CMhNmfKyTx+6ljLOOFCBi3OE1047ES+W8KTdw1TVuSq+IgA0wwaEHjh5cZYzd+Qm5mO0cFkj08zCoF7+xSNohq+8XLvrH8j4ukg/5Y1E3NP7YM5uHOmkq7Cqfw5LO4OhhKf8SEeZNOjFRE3T5S9EBWPYtDKTRAXihbhMw0S4o6KnYjEnjCmDnLFZdJ9qJasHVvneTnvjR4k3lzpURADbAQ954co1R6lgWi2DRLtXFkfW+4+4xX3nB8jkX2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSd0bc5vBk/3cX79tK0wRwRWIfG/q6PZ8pz5Ox+jLKI=;
 b=mlU5pD3WwWAEyVtNi943orQx19SWxYDkHlCh2DLnK2DD35e0hAR395q2rxBI89OQggwtNupcBsbvlCeTMMDYJJuKw32YQm8j4g4TW47fwbmo77Cq4vo5k400hERbf59VbMZ6+1M+HuJwPT4uZgtw3wpQeX4EISYFvd618aWu705LDzhphh97nbqKD9lyAwNJ7YoiR5tSxfEAq6NPCtAs1kBRB+T0cM2hw/7LV9wP7nN74Y1fwczizkUDMaAaT0950V2M9t9ed5intKQmIKnOmYeSYmS+K0/1EnyAnlUZkOXUPinfIduooCkEF5LRJ+cmqH0DdfHXhv6PqH1mIINaHg==
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:36::13)
 by GV1PR10MB6417.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.12; Sun, 17 Nov
 2024 07:38:51 +0000
Received: from VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616]) by VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8597:8c28:89af:4616%7]) with mapi id 15.20.8182.004; Sun, 17 Nov 2024
 07:38:51 +0000
Message-ID:
 <VI1PR10MB201646F611CAC37D90C7D1A2CE262@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
Date: Sun, 17 Nov 2024 15:38:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/15] PCI/AER: Add CXL PCIe port correctable error
 support in AER service driver
To: "Bowman, Terry" <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, nifan.cxl@gmail.com, ming4.li@intel.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241113215429.3177981-1-terry.bowman@amd.com>
 <20241113215429.3177981-6-terry.bowman@amd.com> <ZzYo5hNkcIjKAZ4i@wunner.de>
 <7cfb4733-73a6-4a07-8afa-9c432f771bb0@amd.com>
 <VI1PR10MB201607EB59D6C0884A57995CCE242@VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM>
 <21fbec11-94dc-4189-b9a8-041840ebf913@amd.com>
From: Li Ming <ming4.li@outlook.com>
In-Reply-To: <21fbec11-94dc-4189-b9a8-041840ebf913@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0035.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::14) To VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:36::13)
X-Microsoft-Original-Message-ID:
 <7eff24b5-f362-4bb1-bdfb-5839849bf44b@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR10MB2016:EE_|GV1PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf792cb-77c7-4ba8-f24a-08dd06dae117
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|8060799006|19110799003|15080799006|5072599009|36102599003|3412199025|440099028|3430499032;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?KzN0QUVmMzl0aGUxOEdQeEk0c21PZVE0VmVvY3FVSGRYYVdQVk5QZXE1YTYz?=
 =?utf-8?B?TTNOQ0dWUzl4ZUZZcm1UMlFXUUx1MVZxTmZ5eFNNYnFZZW9aV1d0eG42VVBk?=
 =?utf-8?B?a2hzMFk2UklDbjBqem5lMU1MMlFndGNqUlRiMFY3bWx5VmY1Y0txalV2Szdt?=
 =?utf-8?B?TE9nWjJ4cDhna3lyZVpOazFvc0VRcldGaGdmUnZuQy9taWNSN3NCOG1Fbm5a?=
 =?utf-8?B?UzNYVkNQSmdoUFMxNmd5TW85MFludTVWZzdKaXAxK0s2SG1NUE9Jd2RKeUti?=
 =?utf-8?B?NVh2MlAzTnpIeHhjdzFNS1VJeGtRbDFXV05wRkVtUDFnSW5OS0pUVW9OZk10?=
 =?utf-8?B?a0pHQmtHM3hQUVltOGtNam4xSlZMVUVvNksvQnFabFZxTVR2dERxY1MzaGhq?=
 =?utf-8?B?QzQvVzc5M3VMVm5VajMxOW1FNTVjcm4yNGNPRDY5Q3dwYlJUWlpZNEhVYUNK?=
 =?utf-8?B?TUhoS2ZqNGVOZUs4WUtmRmlxK0owOGRqek1aZTdCdUJZdUs3MGszaTl1WWVj?=
 =?utf-8?B?T1pSYWFHMVlJejVGSEp4U1pMKzkvZzdOamJQVk1vbVRIbklJMXZNbTRpTjdB?=
 =?utf-8?B?RXQvanJPYnhIWXdtc0JIRytaRnJFTjBrZm1TKzN0d0Q5b3NNSmVzY3ExaWx4?=
 =?utf-8?B?aHR2VXRHdkJPQ1JPZE1oMmtMK0V5OHRmUStBNHJtUTJrK3ZQVmJNZGtsM2Uz?=
 =?utf-8?B?ang2eXFpcWlWbXRPVlZCQlJWN3VHN1RDT0RJczQzazgzeU9iS1IyNmVLRUN3?=
 =?utf-8?B?S0NMV3hMT2dBcjN5ajk1aERCVlg1TituNUhlSHhhSWpDbmZ2UlJSVFdDVW4y?=
 =?utf-8?B?WWhub3hkSnRJT2JjRlZQVWo4ditSY1FnT3YwQWN4SEc0MC94MHlqVytDTzlx?=
 =?utf-8?B?ZFB0QzNVRzBWSENTR2JRYk1pbkc1Nmt0aHdGWFFudjlYaTFrdmdhT042YjVh?=
 =?utf-8?B?a25mL1RRL3R1SzgwanI2VU4rLy81UE5qL0JHRTU2a1VBcXlVY2l6NFJoK0JH?=
 =?utf-8?B?SVcvOGRIZWZHM0VxYXd4TGhTV3cwMDc2QXNMSlVzU2RTNXVHMWpGaTFVQWhm?=
 =?utf-8?B?YUFub0ZNcHZZNWVzZEpJZHRrYm9BODNHVkZzOTErSks4Qm9LT0ZnM1RhZFYr?=
 =?utf-8?B?bjUzS0E2ZXFjMFVaWTBJWFpEMk1NeE5qcE1ZWDd2UTV5c1lPMm54K1ZIYkdY?=
 =?utf-8?B?S2JHM2lnZ0pJeDdreWtyYkRwSWNwYWN2eWt1andQSWJkQzRRR3BLcXdHQi9W?=
 =?utf-8?B?MC81VzlrWjgyM2ljSm1Kd1dCK2piakhjRC8zcXpWQlFxWGZYc3BVMmNrTkds?=
 =?utf-8?B?RjlFd1RrYm84VG5vMEtBbGNEVWRqVFgybzc1TG9CUklIVmM5R0ZCTUlSRGRy?=
 =?utf-8?B?bHQwcGpsRUNMT2N0UGRwNWNmRjloTE15a09YZlJDM0lGUW9IMGJvQUY5RTBy?=
 =?utf-8?Q?t+bJTo0c?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmVBZTZnenpTeCtWM01PQzU0NDNTSTZFamRBWGVDd0lva3FyMHk5eG9ZZnFQ?=
 =?utf-8?B?TGVZZkpQRlBhSHBFYUExQzlnVjF4T1E2NWJiNmlkd0F0SDdYdWk3bkRmMmtV?=
 =?utf-8?B?Q1RzV1dBaXNOMGxwZ1NtT3ovbjQrdmdQNWZJQ2p2YWR4eCtrSjRzM3phRnBp?=
 =?utf-8?B?QWQ0RWNHY0tqK2l2aS91TDhObkIvUjN4Y3RSMUFJNTRxZGMwNG5PbGFxTG9S?=
 =?utf-8?B?azlYcnVvYmFodVpEV0Y2RVBDZDlsUDlyQUNFZkNNRTdvVHB6dXhVK0FlcFB4?=
 =?utf-8?B?VEZtRVJiV1dNbHpQa1dGNFMvWDUveFpNbENkZUw0ZEt1NlRzVW94cnVPdTVV?=
 =?utf-8?B?d0hSRVc1S1Q3OXBPclM4aHppUVUyejMzZXpSTXBOWkZub1ZINnRjOHVhdFZx?=
 =?utf-8?B?SzhncDJsSGlnaG4wZnRhaFN0NlVVdWhyMkZqQUxLaURESWJib2JSR1R2Zi81?=
 =?utf-8?B?bmdSNTd2aVU4aXEybU5OdWIrb1NjdmNsb3YrNnpEd1hFZ20zRXZwcWFUY2t3?=
 =?utf-8?B?RmZDc3d1WWQvcjZLN2pOQWdxOS9SY0ozTUpPR3VCaFo5SnltZXUxOUVYT1Jm?=
 =?utf-8?B?M1JRdW9YYjF6amloSHRVVHZ6aytDL2xaUTdYU282dmRIeEhGOFF2aEhFL3ZN?=
 =?utf-8?B?N1MrZVUvMkhrNmw1L3Q0YmE4b3NlUS93NGFSeVpJNmxwejhkNWVVRXZyTzRM?=
 =?utf-8?B?eUs1WEQ2MklqU1ZrUEF3elJiQVZRMVN0NDh0T21pcHJhaE5BWWZrcTRUQTNE?=
 =?utf-8?B?YXByMVBRaVoycHB0ZEErT3dySFArTEpsbnNJblI4QUVET0lWV2dYbGg3RnUx?=
 =?utf-8?B?TmhKNE42NGNvdG9CdzhLR1Q5cjRpZ0QrUW41Y2dYVlNDZmxiT0RaVzByMi9j?=
 =?utf-8?B?b2ticTREMU1uR2pLc0psdDl0ZkJKMTRQakx1cks1UnBDTmNKSy8yWi9nc2Fv?=
 =?utf-8?B?SmxTNmdHZkpTSFZpZGlYVm1rem9VblJGUWZpMkM3SGtkUk9LL0E3OW54dlhG?=
 =?utf-8?B?V0xxTGZERXV4ZHkyVjEwa1phb3poeE9HMXMzYUUyWkpLYUkyQ2xkc1hTV2V1?=
 =?utf-8?B?MGVmb2ZWNEtVT0pSeTB1MkRHeVhkZ1dTeCsyVzNMMTNEdk1VR2krYjA5KzFB?=
 =?utf-8?B?ajNNT1BGTVo2U0VxbGJ1dHp3ai81dnNxVFExcUNsMUcrc2hpbkZaVHRBT2Rx?=
 =?utf-8?B?eEkwdFFYZTV0R01aV01LYXR3NkpoOXVBaDNwUmxtUmRob3RKMXUvUVBORzdx?=
 =?utf-8?B?YmZHdVh2ZlpOYjd0UXM2SkxRTFJlTitMSzBsY1B1cDdYOS9kQStnZUt6TVdI?=
 =?utf-8?B?blExY2R2elpYemJMclZtb3Y1R09tOUdNbEpCdlVNQkx5bnRPWkk1UHpNYmls?=
 =?utf-8?B?U2orWTNJaWFScHJBMTdLODNDOGxESVJHNURRWEI2ZHQzL09Qbk1RN0FrUjZL?=
 =?utf-8?B?SzN0Q1piYmp4cDBhbmxFbGNBTVF2aHF2eG9EUzFmK3FrV3dtdGZFcDFzbXU1?=
 =?utf-8?B?Nm40cWRubWFpWm1DdGJxcWNiNGlJay9PUEkvN1NVUGdOMkMydXpwbHBVa1Vw?=
 =?utf-8?B?WDBwdTBZb2xiYXJXeVNkNEpWcmwyU0lNdjA5YmFtUU1qQ0ljU0NGR1BLS0lW?=
 =?utf-8?Q?KIM2z56uX4qJnr5mE8P2q7xkaPLit4+s4DnyaJb2TQLU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf792cb-77c7-4ba8-f24a-08dd06dae117
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB2016.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 07:38:51.1104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6417



On 2024/11/16 3:46, Bowman, Terry wrote:
> 
> 
> On 11/15/2024 8:49 AM, Li Ming wrote:
>>
>> On 2024/11/15 2:41, Bowman, Terry wrote:
>>> Hi Lukas,
>>>
>>> I added comments below.
>>>
>>> On 11/14/2024 10:44 AM, Lukas Wunner wrote:
>>>> On Wed, Nov 13, 2024 at 03:54:19PM -0600, Terry Bowman wrote:
>>>>> @@ -1115,8 +1131,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>>>>>    
>>>>>    static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>>>    {
>>>>> -	cxl_handle_error(dev, info);
>>>>> -	pci_aer_handle_error(dev, info);
>>>>> +	if (is_internal_error(info) && handles_cxl_errors(dev))
>>>>> +		cxl_handle_error(dev, info);
>>>>> +	else
>>>>> +		pci_aer_handle_error(dev, info);
>>>>> +
>>>>>    	pci_dev_put(dev);
>>>>>    }
>>>> If you just do this at the top of cxl_handle_error()...
>>>>
>>>> 	if (!is_internal_error(info))
>>>> 		return;
>>>>
>>>> ...you avoid the need to move is_internal_error() around and the
>>>> patch becomes simpler and easier to review.
>>> If is_internal_error()==0, then pci_aer_handle_error() should be called to process the PCIe error. Your suggestion would require returning a value from cxl_handle_error(). And then more "if" logic would be required for the cxl_handle_error() return value. Should both is_internal_error() and handles_cxl_errors()be moved into cxl_handle_error()? Would give this:
>>>
>>>    static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>>>    {
>>> -	cxl_handle_error(dev, info);
>>> -	pci_aer_handle_error(dev, info);
>>> +	if (!cxl_handle_error(dev, info))
>>> +		pci_aer_handle_error(dev, info);
>>> +
>>>    	pci_dev_put(dev);
>>>    }
>>>
> 
> We could do that. And with that change it might need handles_cxl_errors() renamed
> to something more correct, like handle_cxl_error()?

Yes, the name you mentioned is better.

Ming

> 
> Regards,
> Terry
> 
> 


