Return-Path: <linux-pci+bounces-3186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5480084C556
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 08:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 789331C25B8D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 07:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CC81CD3B;
	Wed,  7 Feb 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tFpilawa"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C91200C7;
	Wed,  7 Feb 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289183; cv=fail; b=oB4JBfGm9exUIwozF4gCZmRg0BN2t16j8LH9W7zyTt96MfLy07NN1PKsXQWnJEAzdZD+q50EKEA8aT80nZq6dYKyO9t24d2peKhGPJBwF8HZRjZ07zLCtpN4qemKMDAA0MZPXM0g8U6zZde9jccHUejFBZJ3OuAKLu/GDpDm+jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289183; c=relaxed/simple;
	bh=tK2lzvh0a9cfTmRTqOnKXtJ2Ki7/NQDSwv6rQSSI7Bo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlTg1dccgpoNis1l4U29B1280QBc+yzk/zfpWjia2dZ8ZUbRab/aT1eoxdbUg7y7++6m7ggojR/ixpyLJxPUzHUa42XKuldzRyTbzcV/jlt5y5geYyAB8VB22QA50ZHqOUOGPzU7c8vnciqrW3xTac+G2pDqyZfXEE+s4j3wZHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tFpilawa; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioiKqrNxOjyhG4dXDlLUB1ByrpCYQc/nYoVe3N9vQlYwQI61N1Q+KDcFBk/dyP+jGfiYZKe79rqxn7GuWRVuJdPMdEScjiDGQlaxA583QjZkX6ax+TdTqbkXsrbGRHVIFf1vqHT6MHMQ7RwAGgT2oyHFmlzE1p0zh9JNlBLZzmp2TRX2mNaoYOrAm6LGXQnAi8pmJRCoORS/q40tWktYwp8v1+esRDQnDrPcJsVW4tbLXHwJyAZ/PisiYAoYXICPja8oCdLQnjVk2gNGhI/CKsKFqxfcz0sDHdIn6tbheSTmN8wpr8Pun0TUntIJdzeQxQvssu/Pys7VqCTM28GztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OTNsUhAJLxuwSJWTTf+VxosVOISkM1YC9HoFncuvTI=;
 b=Cf02DFIyvFREGPT4qtzfj6V0Fj5yoSABI4XQqoP0iljD5pb0ztWeF18fxhznKl/OJx78iaAam/iwXYa5jVVDoxTdCMeHWlpO+tPqjmbjjmP/Ur4cjS+bdqhaQ2LvwjFUk4FP808m1dB6mLO4IYYeikckGpgx917v1qBOY+I/7nXwwjov9j56XJQXXS6KS9QagiCxnRwNCtxLPJcyF3aXom4DkCenxkn++nnQDZjbdSEKT52E6Tdrcej99C/uXLj1TwsJCu6MSyfoEbFRtxocebqw0dlQhtS/bp8dDEQEaNL5M1kzmekDD28/wjPGM25uoc/nq4TG+lpnkvoJHQqCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OTNsUhAJLxuwSJWTTf+VxosVOISkM1YC9HoFncuvTI=;
 b=tFpilawalkH5XvQoyt13yQx6IppFziMrKcHQqDmIv/jJ9rLvTXz8DwwMvwWXu+u33xw5sn8SwkLqb2Yg9m9B/n1C1zUPEZgv7Ly7etmHKkW9ohSTCMdaqeyxwMTRyoF8GU1nDgqrWWdMy4IvwRQgXDFMbj608iN13Y2nG4HdVIc7/gwRLK23i3xRXFX3D9uqkBu6e6egtqtxTJLC+nj5g1AouHvh61QoR7AqxTCDTg1YQSf8MKTaSO3/v8rDmMk12zKjoh5E92O8qWOqS7xCbb9F9DoVarzEhhTQNuiupL0fqSczse8I4ulI4BvBcLflZr2d5fUWKZG8kVO9cVsNAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB6674.namprd12.prod.outlook.com (2603:10b6:510:1c1::18)
 by DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Wed, 7 Feb
 2024 06:59:38 +0000
Received: from PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::e85f:6a24:436f:5594]) by PH8PR12MB6674.namprd12.prod.outlook.com
 ([fe80::e85f:6a24:436f:5594%3]) with mapi id 15.20.7270.015; Wed, 7 Feb 2024
 06:59:38 +0000
Message-ID: <cfa789a0-5433-4e17-957f-a3e021a97eed@nvidia.com>
Date: Wed, 7 Feb 2024 12:29:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] PCI/MSI: Fix MSI hwirq truncation
From: Vidya Sagar <vidyas@nvidia.com>
To: bhelgaas@google.com, rdunlap@infradead.org,
 ilpo.jarvinen@linux.intel.com, tglx@linutronix.de
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, sdonthineni@nvidia.com,
 kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20240111052814.713016-1-vidyas@nvidia.com>
 <20240115135649.708536-1-vidyas@nvidia.com>
 <23c5fac1-ebf1-4e5d-9691-7b87060b0df3@nvidia.com>
 <0c9d7bab-1da7-4ac5-891a-62e28db8d60a@nvidia.com>
Content-Language: en-US
In-Reply-To: <0c9d7bab-1da7-4ac5-891a-62e28db8d60a@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0031.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::18) To PH8PR12MB6674.namprd12.prod.outlook.com
 (2603:10b6:510:1c1::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6674:EE_|DM4PR12MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: d73f55c6-efa1-4f85-20d4-08dc27aa5990
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YxCw018hLPiM5/VEdiLJtWdQa8iVigS8lLkJkvG7XDP6mTn0tDWkf1P9Bd7hRdCN1zwMi4WuUNXLt0NL5ZdXmDXThiCVm3Frx5CMyHjPIvR9UPF9w6USS3ipEuNksUH4N0gTwl5h47T+U7PfZYU+LWGH4ei1abrZl3a20M7XfuLQ0jJUnvU9tTxGnCULmr6LEL159exdVbCXWwjzrOlqL8K5s+cg0q7QZ72dKUamEAGzhH1Zh0D5ZbmLUDnTMNU65qgRJ9nPgJuOb9ejZn2RE+QwX7VGmtHML8nXPjaZzuJE9XIh8xJzDFZdhjwKFa3HwjPfoy/9mQvw081SA1GJZFTh2c6vEI1heJ7Ju5FfLnYeUHfPULq5sq/o5vSnTBn/lv+TQbtELMqo6VeUSVAtsQeyKyBYzjb4nAncgJ22bha+ENxn95CVKSCLJuAcNFAJ6q9lWrDEBQZ++iQq1hAnh4cSd8yaExWrerOSDofTU9La8BOciKwJFvQnOTPbobAogTiOeGbpU27unjD9E0VDfp+j0Msq+zt4nPBEUHhxyLMVf6GJZjXlURZp15fStPUHCB/weu+0aksluPtQpr/9o3mocHa8uHJR4n88sAVccnnhpAlNhmmFN+tsxN2yUe0nFWQ9MC0Qm022Fp5/rbpF3g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6674.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(346002)(366004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(316002)(6486002)(86362001)(2616005)(31696002)(478600001)(26005)(31686004)(6506007)(6512007)(83380400001)(6666004)(66556008)(53546011)(66476007)(66946007)(38100700002)(8676002)(4326008)(8936002)(36756003)(5660300002)(2906002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFiUldJS05uN2NWWDU1K2d0M2NvNWtlOGxNeEl5Yy9ZNHpCTkM4aWRPbjhu?=
 =?utf-8?B?Zk1rckY5NkhoUi9vaW5MYUFneW1MWDFiS3pCdVNUbUZZcStNYmx4cTBlaVhn?=
 =?utf-8?B?VFVSYTJMWG5aZW5jR2JtUjhqVWFGRjc4eW40ZjFQV3V3d0ZVWEt0YlVNVVdC?=
 =?utf-8?B?Z1hxOG1QVTJzVk8yZi9ycTV1clRjbWtaOGUxYmFtZGJhT3hmRi85OUl3WDkx?=
 =?utf-8?B?RnZSWnBLVzF5SGdkci9nUXd2ZzV4UWh4UW0zcnV0QWdsajFkdmVzdE5odW9n?=
 =?utf-8?B?N2NjbUVyenVocC9Sd1pzRUI2RWpDM1c2QnRkSnZlNkRscFhIMVRMZ1JvdWo2?=
 =?utf-8?B?MURYOUxMNGdtTHBZc00wNFY0d1pHcmptU3pLWHZyczhOdlRJVGcyYlk5ZTd1?=
 =?utf-8?B?OUlGdktrZ1FJRk1lZXpRQmJCMEhHWEE4QnZGLytyeW9JVkhKQi9saHRIREJn?=
 =?utf-8?B?Y2pMVU9XTjMydTZhbys2RkUzbVF0SmtVZG5ZbnkzMVNZYzU3by9BTXdybWFl?=
 =?utf-8?B?c0tnM2cxSzdsaWZpT00yaVRWZ2hZWTJ6V2tjV29KVzZsbzgySEdjZTZaZ1lY?=
 =?utf-8?B?bklwazVBOHVEZWFBRVpTM0VPeklhODdrU0FkMGxiZERPWDNCUVdyYzVkeDNM?=
 =?utf-8?B?WXhRTkVkQkhsblo1YU1nMTNsQUdBTi9vR3Z4bjBvcWpsWEdqSG1xS1VseGRK?=
 =?utf-8?B?bXdxdHdDbkFjc0hpN3FWR3d2aU9KRFBTK2hlL1dYb2hNWmlOTVhoclY1Vkxx?=
 =?utf-8?B?eDc3MnkxWnpIZU54bXNLaXlISEpmK1hYQzJ2SWpJbStEejZ1bU1iKzFKWUt6?=
 =?utf-8?B?Y2N4MERjUkJZRFZ1Qm1FWWNuTHU1TkxKMlFXc1Y2RmFzMWs1bzZPTDdjQnUz?=
 =?utf-8?B?bG5HYjhycnBwUHR1azZDdWJqYjdzaTNaQ2hwZ3VscFF2VDNXbDBOU295YTNX?=
 =?utf-8?B?anl0Nk5DQ1dpbHdGcUlaekE1V3lDT2Ntc0JaMUZMbks4bW5HWUU3SFFDa3FR?=
 =?utf-8?B?eTgxeU9ZMmhIdUZZMFpVL1MzRkZERXdRQjArTWY0V3R3ek1CODc1aklRb0Jr?=
 =?utf-8?B?d0ljblpoSFBhWEJoRGNLbVVhM01IVFlLTFAxRmNaU2RnekdNVnV5RkdTUXor?=
 =?utf-8?B?eEhxTGZwMFFmZTJzdVl4QldTTkk2bnZZKytOZWJHalQzM2Vpd3l5dnhuQ29q?=
 =?utf-8?B?TjNnbDl2UStYNnBVSWtuMldFczNCREpnM3hzanlVLzFxaHRZZWFxblQ5L0xp?=
 =?utf-8?B?QmtMNHo0MHVnekRuU3ZFOXZzY0RLSWx0SHFmT0NCdHhhSWlBSk4rUlJVd1k1?=
 =?utf-8?B?Nm9kMG1nVmp0N1p6UmZ2MVlNRGMrVm9Ddzhici9TYldkOWU2WUZrTHpzSHZD?=
 =?utf-8?B?SGdwNEpMY3VPeForQUpNeFhnak9SSlcyY0ZnS1RhUEZ1Mnd5UzFzTGhOZXM0?=
 =?utf-8?B?THdaU21LU0F0WUNDMnc3bGRCUnc5UWRtYU84cWJ4emNSRDBFeU9hVVljaHll?=
 =?utf-8?B?eTJHMW1FRm5mSHlkL3NRQ01jYnJVdGdXdC95VzJ5SHJsTWFSVFlRMTRMdEMw?=
 =?utf-8?B?OXBnOE5GdGhoQ3hhZlBlaHErcDZQbVNHTGdZQ3NseDhuOWI5NUJRVHQ1c1o0?=
 =?utf-8?B?Wm5IVld6c09TTGVIRVJnb1FvUlFZc0xVcGRKZEMyNi9vN2RoZ0FWUFlIN3Z0?=
 =?utf-8?B?eXhvN3FPN1g5VzYyVmN6TEZjOHJrRm02ZnJxckxWSlI1dXA2ZTJVWk9acVB3?=
 =?utf-8?B?VGVXTzFaSXBhclZNdUVkM1MxZFFPbFAyb09KSXc2eVUrdzduSEVrWHl1WUNw?=
 =?utf-8?B?WEZNSkRRc0EyZnBLNGFrVDd1eHpZUTV0Y2lUaTUyTDJYdHBTeTVDM0YzRmN1?=
 =?utf-8?B?NDR6a3VaVkdiV3Bob2M3b0RoMDF1VDNtQVM4TjFBc253ZitQdUFmOGFxK3dP?=
 =?utf-8?B?Qll5TXBNVDBhK2JEektYZ2Z5VHBwejlvdTU3WU8zNXRDVWZUVjlwTlYxeElv?=
 =?utf-8?B?OWZqZ0JLenR1WWI2S1B6YWowWWcrdDVKdTRMTThPWVAyV1ZNYlExQTVsa3hw?=
 =?utf-8?B?STBOVXdmbjNYdUpJY095SXVJSW1tUnB0MzlxNDJnSlFEajBWRmxMVVYxRERa?=
 =?utf-8?Q?V4UklFCX3dH54r4AGIlRtohMk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d73f55c6-efa1-4f85-20d4-08dc27aa5990
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6674.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 06:59:38.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VcVVbHv/bNTfjR/VvYbV7g8G7ohYW//0iYF2o9k7o5Ti0hdzo6Y5Q3Xf8O4DHo3/d4YfG55a9wQRjWIosR+qYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278

Hi Thomas / Bjorn,
Can you please guide me on getting this patch merged?

Thanks,
Vidya Sagar

On 1/31/2024 8:45 AM, Vidya Sagar wrote:
> Hi Thomas,
> Sorry to bother you.
> Would you mind giving an Ack to this patch?
> 
> Thanks,
> Vidya Sagar
> 
> On 1/23/2024 9:31 PM, Vidya Sagar wrote:
>> Hi Thomas,
>> Does this patch look fine to you?
>> If yes, would you mind giving an Ack?
>>
>> Thanks,
>> Vidya Sagar
>>
>> On 1/15/2024 7:26 PM, Vidya Sagar wrote:
>>> While calculating the hwirq number for an MSI interrupt, the higher
>>> bits (i.e. from bit-5 onwards a.k.a domain_nr >= 32) of the PCI domain
>>> number gets truncated because of the shifted value casting to return
>>> type of pci_domain_nr() which is 'int'. This for example is resulting
>>> in same hwirq number for devices 0019:00:00.0 and 0039:00:00.0.
>>>
>>> So, cast the PCI domain number to 'irq_hw_number_t' before left shifting
>>> it to calculate hwirq number. Please note that this fixes the issue only
>>> on 64-bit systems and doesn't change the behavior in 32-bit systems i.e.
>>> the 32-bit systems continue to have the issue. Since the issue surfaces
>>> only if there are too many PCIe controllers in the system which usually
>>> is the case in modern server systems and they don't tend to run 32-bit
>>> kernels.
>>>
>>> Fixes: 3878eaefb89a ("PCI/MSI: Enhance core to support hierarchy 
>>> irqdomain")
>>> Tested-by: Shanker Donthineni <sdonthineni@nvidia.com>
>>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>>> ---
>>> V4:
>>> * Added extra information in the change log about the impact of this 
>>> patch
>>>    in a 32-bit system as suggested by Thomas
>>>
>>> V3:
>>> * Addressed review comments from Thomas Gleixner
>>> * Added Tested-By: Shanker Donthineni <sdonthineni@nvidia.com>
>>>
>>> V2:
>>> * Added Fixes tag
>>>
>>>   drivers/pci/msi/irqdomain.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
>>> index c8be056c248d..cfd84a899c82 100644
>>> --- a/drivers/pci/msi/irqdomain.c
>>> +++ b/drivers/pci/msi/irqdomain.c
>>> @@ -61,7 +61,7 @@ static irq_hw_number_t 
>>> pci_msi_domain_calc_hwirq(struct msi_desc *desc)
>>>       return (irq_hw_number_t)desc->msi_index |
>>>           pci_dev_id(dev) << 11 |
>>> -        (pci_domain_nr(dev->bus) & 0xFFFFFFFF) << 27;
>>> +        ((irq_hw_number_t)(pci_domain_nr(dev->bus) & 0xFFFFFFFF)) << 
>>> 27;
>>>   }
>>>   static void pci_msi_domain_set_desc(msi_alloc_info_t *arg,

