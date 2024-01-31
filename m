Return-Path: <linux-pci+bounces-2854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21184346C
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 04:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6507D1F257C2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 03:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F95FC17;
	Wed, 31 Jan 2024 03:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bTqW5keB"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301A10793;
	Wed, 31 Jan 2024 03:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706670974; cv=fail; b=f7Uy2DpfAxu58fdi5F5+wpNl6RZSfHxWnYRmZoSj/huLZpkOcLrmCzc6uyvMUH31aDdX3aOO7uclkg/dDVVQ/IS/fsgUfXcY2pbx/DdUOiQjm3WCeEFIakaFNCJkLdP8sJJbzZDtArvxaMUE3RS5D3fjEmiGS/cs61so8RpCsJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706670974; c=relaxed/simple;
	bh=I4QH/gjtlV2BMchHqGDwKj+9eDQ4sHpOduGiPZhtPgQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c1YNeISw3fs4/6cnyJ0U7S99Cku7BiUSc9Lxe11I94TNP39wgyTCfe6wh8wh44OAgTX5tU2ISZDMpOywVAtDSh8ThMqFyWTuscajemUhq49PeiKwbXH+c/T9bCjLrFX9OGs9oy1HdRxUTQUfMYmB6wk96vOFbFGEj2GFQpJa0Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bTqW5keB; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPRcC0RtliXstr37L4FG/veF+QxPf8YXogiFEPRQ2Y3Cj7fPsTthJaRWU7foFff7PI8e0M/SEiJkv5+09KdIMzmsA5hbc2SYfA89iLZkge8JC0r517aXSX/PS9waRL6X18nq5I6IId+F1OaA5fcsMhGDfG6lm77Jm4miIiZ2gpO673RHtxaCB2SHjERIBHFTOzQ3lLllUNv1Vu5kynBdnGWk6DH13OwPC8PFTpFxOiaPMSQUq2PPiQrSTNM/KMlsA8B5iap70n/Ao7bA93BPKRB7xlRBAJ0f98RbseHW0ULhBtx1aEHxvj+mnux217KME+PiUM0uPx7uJ/2PaHDu5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxHBJCf/2kz/IFsDhw/6k/TUh5G3EeRMrFQDtTaGfC4=;
 b=MB/zIsWPkbCbqRi5+SE4ox5TmyGqG369Ijs0XeKZA9mm9FlbnOMjYdNQvI2JSVaqTPJ7Ryn9IKgIJQF6hXwCjJW6ipjkmHxUAMq1l1mRrrv3W/QzxkqaC2p+RqvhY1WgEylZMMKvKY99M3KABKslpkxeJHwNlrtVz3wahGu46IHb2SWLrGlhCHygIFikfrFOPbBaolWv+sYS5CFFNl4gnRtVZmz0PrHz0Ao4yoh0gJZL2evxQScC+vTYEHssaKYqtYRut40kZCbmM7mbwy4BxCJyjIVwms4ajRoQ8FWaAsXpJJMduw7Rs2a6QnuYcemIA5mm7/kkuJZ3cp3hxFUxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxHBJCf/2kz/IFsDhw/6k/TUh5G3EeRMrFQDtTaGfC4=;
 b=bTqW5keB8QqodDoVMWUBGX8LwtSTuZsPbSuuwrYHMlY+9COBGZBFX+YkMYeqBoPf+vFTiWL5bJclbf5HVZoDlA/GPmSzXRt0abpDBg/BeWbzCLQdAb6Rpj9irUVPUNp/C2TyTggE628cBCMJe4peB5Ti3Fu0z4sGMVTve1Q25bXT51jLripcsZacunu/v9C81V66fwxzqiHwie7afcCYaWj1CJ92urpNTnyEusnzxYXdSpGxq34g7/shs3FVWOp1WCn+upDWJ7fkX+cLp8xC8ctd5vzV0dR4nNGntW5zDV9ry1COn27K7L+eO9AfAIRDfn14M2Hb5nrQvyJxbclyKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 03:16:08 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::55f7:f35f:a684:bf3c%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 03:16:08 +0000
Message-ID: <0c9d7bab-1da7-4ac5-891a-62e28db8d60a@nvidia.com>
Date: Wed, 31 Jan 2024 08:45:58 +0530
User-Agent: Mozilla Thunderbird
From: Vidya Sagar <vidyas@nvidia.com>
Subject: Re: [PATCH V4] PCI/MSI: Fix MSI hwirq truncation
To: bhelgaas@google.com, rdunlap@infradead.org,
 ilpo.jarvinen@linux.intel.com, tglx@linutronix.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240111052814.713016-1-vidyas@nvidia.com>
 <20240115135649.708536-1-vidyas@nvidia.com>
 <23c5fac1-ebf1-4e5d-9691-7b87060b0df3@nvidia.com>
Content-Language: en-US
In-Reply-To: <23c5fac1-ebf1-4e5d-9691-7b87060b0df3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXP287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::33) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|DM4PR12MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0f5ee2-8f42-46f1-b34e-08dc220af7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V/2yMTeAI2WQGAl0dQJEkiE2x3JuOkPzyXL/5Ekh2nl7LNP67ce5BMz9TGdxj2eIaaj+lNmp0TrjI6DSRtVqolaWy43TK9esAwKOtIekwKyUXVV9e6o1lOKT0hhmnnnxzd7tAzO+3R/liPwvbzbFChLqmFVVDNqsV462E6+/hFOKSag31Di2omeU07X2NItCjhozHLOdyajZCRJEcJv1kU1kqRmwYYSVm9sjVXXQVMYkU5urChtNO9ybow55Yz1KPeos84HcevR9KYBhQWStNgMEMJbblLgiiDcH+hRLBudg7WQshPIAWkH1FCd9yKROwGHtWByMo36jpgwjJf9h3UY2Wi9mVqySeV9rWrNpoRF5VvU8I7hMF4jFz4hyTIrIKfCjTxWCpxkibcJV+IoQrva1rDKoyPEsfdW1WE3/HVf+/gNuHpGEPdqup7CLYicrl65RYZCJS+jjDjOVpof9chghxQemI9bivRGrqaT995pAxqiGWXJ5MEcuwJ+K4Bl+W7GTsLW8XZlJJfRb9PoDImXxtfLlZ1lfVtv511dsvB7RxmnHFcZU7pp4Z22UD3bOM+C1z24PmjUTDpqXFqINsfIGuRSpiNs8WK4HVJ5OEk4e7D6crDZGAMmJcUFh1uFJRdhIQB/Bhf+ylKDuRjgncQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(41300700001)(66946007)(4326008)(8676002)(8936002)(2906002)(5660300002)(31696002)(86362001)(66556008)(66476007)(316002)(36756003)(38100700002)(53546011)(6506007)(6512007)(478600001)(6486002)(6666004)(83380400001)(26005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2JMRVF2R2pNejd1RVdnMndmSjNaR3NDVkNpY2ppUm5FMkdtSWozU3hReU9z?=
 =?utf-8?B?OG5LcHVjc3RxakpTZTdNU3Y0dXRvWk9ab21ycEUzUUZvbjk2bmZKd2t6Qi8v?=
 =?utf-8?B?NS9WdnlWWlI0SmthQU1Ea2lMMm1BMnBXekFaVUhHU1BpM3NnblJxY0l3c3o5?=
 =?utf-8?B?Y0V5ZVUwWnZHcUFZbFhBd1luN0NuQk9EWmVNZmdOSWFGTWtVeVNQazlRWFR1?=
 =?utf-8?B?NDBpRUQzd3JMS255NzA2SFA0Q1EzNGJhTmdZcVZGaFg4bVdRbTVsTmU4dmQx?=
 =?utf-8?B?ZVVWb0Z2T2krem1uVEMvUy9aYUs5TnVUZitrMnQ5WWpEbkJkb3RBaXdTQmhY?=
 =?utf-8?B?R0lJVExaakQ3aDgwZjFJSmw2NTFEUWh6UmxGcFBkcjgxT1NreTRzMDYxd3RI?=
 =?utf-8?B?K2xIMlI0cFYxbytUVG85SStPeEhtcVRSWU5hdDJYUk4xOEZ5MkJGRVJkWERx?=
 =?utf-8?B?OSs5RU9EV2Zvejd4WHFPWjJRY2F0ZkR0bDlDc3pDdC90ak5uLzlBUGpxeldF?=
 =?utf-8?B?dXUwemQ2ODN5Uy96L3BJZkRvRUV5cEpBZFRxbm1nSUdTYnkwTGttZU9PeE1J?=
 =?utf-8?B?SXhGUmFKcGkvZkd0SUFNZ0VoZWpKamFIWVplcy9IVUY1a0tqK1dqZGlqK2FX?=
 =?utf-8?B?NEUvNVNSVVlaRHc4R1pIZ2Z1TFU3UGt0SnhyTHR2VFJLTnlLekJYcTRKclE3?=
 =?utf-8?B?WURXS1dFWXQvczg0YThxV2hMYWxsb3lyVko2bDd4ZjM0Q1J5NDdqVjJQZVFj?=
 =?utf-8?B?WTg4ek9rNVQ2M1QyVXE1Qlh1ZTNlQ3E5UGdxVUI3K3dVdCtKeGwzWVBhZ3ZG?=
 =?utf-8?B?YStaUEI1Z25xSDZoSGNsV0QvZXhmcXNwc1U3dHFvT0dwL01ESkMxYTVtNE5n?=
 =?utf-8?B?b2FENXYvY2tnNHM1cWtKYlNUajFsMWZhUkZGOW9SdGovSFdtZ3BWdk1LUWRj?=
 =?utf-8?B?VHk1ZU1SUmhEMzh5RUp3RjBRZk1NTjBsTlhtWWE5NS9CZWNuNUJVM0VJQkxT?=
 =?utf-8?B?WDVjRTdMM2s5ZGNxdHdHa3ZjeTUwQ2w4MTEzVGtzRmQxbUNiVXBSRE8xREFM?=
 =?utf-8?B?RUlEZ2FQVWxBVWlNMVpBRWlpSDNIMm1oMitsMUNZblRvUENLeHNXaktrU2tC?=
 =?utf-8?B?YWxNM093OEhDM1VDZTg4R0U4LzFJN1FWeit5N1d5R0hwdzh6ODIzb3hEVlFx?=
 =?utf-8?B?WmFoRkcwa2daaVovWXJGMzgvMU5aZTc4MGxOYnhNRUNGZS9wT0hQaTdGS0l3?=
 =?utf-8?B?aWRUTDFRVitEVjZldDFjMzA0VmlZMDVIZDMrcVBCS0ZkRjJGUlBOYVRtZ0tI?=
 =?utf-8?B?cGZqMENQOEFLNFRTd3V3TEtuemROb1JmYlFweHo1bFczTmJ1MDFpN284RUMw?=
 =?utf-8?B?MFB1c2pBOEF5NnlhRDI3Z1dVZlFqcEdxS1RSSFI1eldsU244SmhUWU5US20r?=
 =?utf-8?B?WVhCYlB3SFNCcHJXUkxsSEVEQWZaaytVMmdKdkgyRUZXVjN5Q0pFMWR6TUxu?=
 =?utf-8?B?c3hUcXlpVUh0bk92eEpWdHQ0VzQrcnE3TEpmTVVGQ3I1ODM3amN5R09sOExT?=
 =?utf-8?B?VFNKcHpYdVMzeDdBbEVyY1QwcVFCbWtBNWcvV05yU25JcDgwUmFYaENnKzJX?=
 =?utf-8?B?Z1poMThqMG45M0FTZjlJNzFvczYrOU1tRjZRcVdjdmxJM3hLVjU4bzZMbFZG?=
 =?utf-8?B?SHJxOHZFcWhaMzI5Ri8xY2NyRklpRXNlY2RValJidE80M2wwRitodG9UcFdh?=
 =?utf-8?B?UWVaOWQ2aUhMVGxCWEE5dk9IL09qR2FmRE1IWjM0aitwMFhldDVWMENVK0Iv?=
 =?utf-8?B?MnNuL01ObllLM0V1Zm1yNkpuRXptenlpUzZOKzEwZ2cwYmVJSkVrcmlvOTRk?=
 =?utf-8?B?b05YbVQxTGpJdkNNLzhuMzdrbGl6VVcxMjZRbFVBRk1tSDBTRjhjZW42eFc2?=
 =?utf-8?B?Q3R6NFNETlpmczRXelAyalVOQzZlT2oxVzFTQXcxZFdCbUFlSnN6SkhXNHBv?=
 =?utf-8?B?NHB3aUczclVqNlY5MnNLNGx1Rk1UVGZkSE9xa0l4Nk0rZ3RYNWNCK3IwbEo2?=
 =?utf-8?B?Z3ZUWVBCNjhYUGhxOHFPRnVXOTZsWEgwb212czdDZTB1ZkpYLzkxUGQzVHUz?=
 =?utf-8?Q?vf+HNdY90KlcJM5ITdfAGRZcD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0f5ee2-8f42-46f1-b34e-08dc220af7b8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:16:08.4409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a/rqEIeqJBWirAIokzQRqN8xI8iVcioXib+s2X/E+Yr/Ivj/aNoybf7HzQPaAGQcmWXFOfzDuZPpt3JmuRAH0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087

Hi Thomas,
Sorry to bother you.
Would you mind giving an Ack to this patch?

Thanks,
Vidya Sagar

On 1/23/2024 9:31 PM, Vidya Sagar wrote:
> Hi Thomas,
> Does this patch look fine to you?
> If yes, would you mind giving an Ack?
> 
> Thanks,
> Vidya Sagar
> 
> On 1/15/2024 7:26 PM, Vidya Sagar wrote:
>> While calculating the hwirq number for an MSI interrupt, the higher
>> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
>> number gets truncated because of the shifted value casting to return
>> type of pci_domain_nr() which is 'int'. This for example is resulting
>> in same hwirq number for devices 0019:00:00.0 and 0039:00:00.0.
>>
>> So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
>> it to calculate hwirq number. Please note that this fixes the issue only
>> on 64-bit systems and doesn't change the behavior in 32-bit systems i.e.
>> the 32-bit systems continue to have the issue. Since the issue surfaces
>> only if there are too many PCIe controllers in the system which usually
>> is the case in modern server systems and they don't tend to run 32-bit
>> kernels.
>>
>> Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy 
>> irqdomain")
>> Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V4:
>> * Added extra information in the change log about the impact of this 
>> patch
>>    in a 32-bit system as suggested by Thomas
>>
>> V3:
>> * Addressed review comments from Thomas Gleixner
>> * Added Tested-By: Shanker Donthineni <sdonthineni@nvidia.com>
>>
>> V2:
>> * Added Fixes tag
>>
>>   drivers/pci/msi/irqdomain.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>> index c8be056c248d..cfd84a899c82 100644
>> --- a/drivers/pci/msi/irqdomain.c
>> +++ b/drivers/pci/msi/irqdomain.c
>> @@ -61,7 +61,7 @@ static irq_hw_number_t 
>> pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>>       return (irq_hw_number_t)desc->msi_index |
>>           pci_dev_id(dev) << 11 |
>> -        (pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
>> +        ((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 27;
>>   }
>>   static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,

