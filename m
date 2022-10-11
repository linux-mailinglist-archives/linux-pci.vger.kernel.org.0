Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6588F5FB881
	for <lists+linux-pci@lfdr.de>; Tue, 11 Oct 2022 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJKQsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Oct 2022 12:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJKQsA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Oct 2022 12:48:00 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB93BA572F;
        Tue, 11 Oct 2022 09:47:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsy/D2m87KVkAnjZWOpnPj4zGob/m5N7jyUxoTjbwKDO3z7rg+xwqWCimUDQT5d3abvjz4Bj918h1TlvdYH3R/DJM0E7Sch8m/jU4kQp52owSRe0LFfxc/MqHLkLd8NthUVvnI9YIeIe26ZM8Oho+NUJuuVc05rokErEmTaGJChufhMCTg7saTu4hgQfUiwV/1H2oGNpE8IYX7D6j4rcQxt8y6f1YvYIw8DmK6ZpS8QXxqSghtvIiV5OpYqgx9E/+iS2HDBq57Novirs3ZwbKUWMBr5wRNZXxT10BH4mbG5cw0SiJ//C6f7SvqZZYbRbx+OtyRqGf3qA0jcP29sHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDxqXgRgw+rG0wYW0geQhj7ZzAtjsMZU+Jn9qusPTo0=;
 b=nzwPuzWSiCibOXe270wmtiKSl/EkzLW/w4Tx6K1eY7w3SgJb2V8xICYlBocBeqlh+BWoj0lKqhyTQl1t8nM5DDhq3QxuYs4wrDKCnk4jN+rU5ippGJ3Zv4iYO6aiziZdpLjcmBW7Cc/jhF32F5LstVldR0gsrkfCOdDPY8T8p/SclVMBfZuF+vB8P2IifSigYkSUjHMrnVLP2BB7i0gjP8qblH+MVTGgHSzh+EnG3MFj3fsVyRCKRzDP+8PBN5R0lWh5COwQZYXQPYfkCAFDZU61x36Y8UOJmQaRUHv3W6FxHp4C1/g5QjXxZ5yTCVb0HGcVQDQgqWbN6y5rRZY5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDxqXgRgw+rG0wYW0geQhj7ZzAtjsMZU+Jn9qusPTo0=;
 b=Bqw58rW5zLxhtm0S7mqroHx0BX9yIlNoWosIRE+W3ZF+MApbzcd06cnMfKyvE/BD8beK9mW7YI9UpXnaUoD0TskSQSUkfhmBc+A+jP3MA5BgojTJnzWpGvTOslZlfUeDqeCzajnXv/0Y1MPKyvuXZNzRLESk+JRcj2LT1pIG9dymZOMfYb7E73k41V9mZY1RH94AxJKoIplP1NQxfdMW1fXxsnguaYNvImmXwbqUTl17Q6M6+eLKv4oG1zonryr4Anx+zD4ZYkzFj0efl7yZwfuGlXxygzX46jZ8GLf/Ls12zRBlQjjvOpQfqTA+CDMcCppoLLxEEJltU+RluwAszw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 SN7PR12MB7225.namprd12.prod.outlook.com (2603:10b6:806:2a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 16:47:58 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5709.015; Tue, 11 Oct 2022
 16:47:58 +0000
Message-ID: <18a48407-9fd7-175d-0c7f-5702b077f13d@nvidia.com>
Date:   Tue, 11 Oct 2022 17:47:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928121911.14994-1-pali@kernel.org>
 <220b0fe7-8b7b-cf9b-e28d-d9d81647fb80@nvidia.com>
 <20221011161638.ycxpg3ox2wv63vym@pali>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20221011161638.ycxpg3ox2wv63vym@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR05CA0001.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|SN7PR12MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 6753465f-2e2b-4fdb-6b8d-08daaba859dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xI4OjenwA6gE1XgXKXMLnftAyzeVu+1+TVTUrwqqWxrFOc/ApAy8KsXqitxUh6Y1JHBb9iNPEiVroA12zCxSMYN6hq6eIOV1xoq9v3dRlwLvK9BCvxTPcv5BkPmm1FVnJnXdtZiEAXfOY2eduegjWV5UUEgueZmjQmb0eLnemHhRN4xomoWykQ2cA2cNr4lBSZb4gTvdqmnQlsRPkkIPxa174bsiFoouMkPnLNx4jYDQzqbOWRwXGMnPJZrMEjAteCVokn1/J4a0oDtDEBQG8+flqXI8LgEFYnj/E9wc7v3+ajumWxfoQMiWBIhkPJNESyzda727VUBZkLwugrr01wxpze5foysSHJbFwjFwBxjAKojjJpXDJizFQsEMMCrboWCFnJra3+OAwzU91UreQW0Zdrmu7n8opgH2x6kzzjW+5Ao2ueTZybXKtujzGO7KEO/FAVvOtBa34TfY+bWo9EjXEWCC5K462Hm7NfZ8eQuTmCCDw8b5GeNHmwSNcGCSmzH1JK2ZZ4RZEeiv29yygSwtz7E2/eN8jVurwyt9nQVtfHdV24mLYCaOkGPSmxRws+EhL1WJu+WJxMT8M1RND9ip6pwGqhViLbLFMTaPL0vUrjlG4vD5A2kD5u/Gs5CAjtoJCgQGij/C1YVxyGLmWCLw5FrUTP94+3ST/LZbUVJOLkGSsrTDb66vbRthCYUe1t2W+wXteeoCOqbxRaCO4P877ZO1CentUzEFdWRQHcJhLhpPdCg/UrcUj0x++LaKo9bzLK0LTDgg1A8VsegrL2rT8ONMtRs+x/TIknxDPQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199015)(86362001)(38100700002)(31696002)(4326008)(36756003)(54906003)(6916009)(6486002)(316002)(8676002)(8936002)(6506007)(5660300002)(66556008)(41300700001)(66946007)(6666004)(478600001)(2906002)(186003)(53546011)(66574015)(66476007)(55236004)(83380400001)(2616005)(31686004)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpqekRNbnVZTk5CUUdMV1NSNC94UHdHT2lraXFRV1huWVd5NnVyR3gvOXZY?=
 =?utf-8?B?WC9YWXp3WDdYT0ZQOTU4elNvNGJONFhkN3pFMzVqa2IveitDb2dITnYvanUr?=
 =?utf-8?B?YSt1Y1FjVHd4NFRhZUR0dkpBbWVDcU9TWkZoWGw5V2NXMGgyWDBLM1IzSkU0?=
 =?utf-8?B?NUUwTkdWS0REK2tKRUdoZ2swWGZJMWFBYkIvQzBWdzV5WE1KaWYxWkowSDhC?=
 =?utf-8?B?OUxjWFltVUxFd3NvTUIvNURDZitEMmFZQ09YR3pYUzk2NkRtYzZEcDJna3c2?=
 =?utf-8?B?Y1lqckY0bmJVTXN6Mk9yd3R0L3NoaS9HWlJ6cWlkTERHeGtUbGtsT2RlMVNC?=
 =?utf-8?B?UkhUQ0hlTlNCNG05NlluZVFXamxPaFVxSGJ4aHc3bkF0amZUY1pXdndtRGp5?=
 =?utf-8?B?Slh4T3VWWldtYXhjRW9CdjdjNXhtMDdkRjk0b1dlY2Q1eE95am1leEo5MmVM?=
 =?utf-8?B?SnlobVlBRmVkRE5rdmdrVzhSRHJJVEZFVzBPcXd0R09yelRsdml6ZzZjRmt4?=
 =?utf-8?B?S0J0WTljQkJ1UXMrRFV5cDNVeHNXWGV6VUt5YnZVaWNJSUMvay9IbGtDODVo?=
 =?utf-8?B?STB1ZlRxL0dlanl2djFrOHdNNll1dlBmK0F6OTl0OThwTC9lTzBZcjBTUnhP?=
 =?utf-8?B?TVh6TEpIUXA1bHh6bFRoc2xsT3hBZTVFWVpLK3JtSFJnRVRZRDdHM1FnL0Mw?=
 =?utf-8?B?YjZBdzBCSG5WYWwyamhPaklvZk5nVnMrOEF6aXVSQzJIYXBiUTAwOGs3U004?=
 =?utf-8?B?TjVBWHpxbldPU1BRQ05iUzdLWnpJcnBmaEdyeFM1Sk1VbUZQVVhtOUdyMVAv?=
 =?utf-8?B?alRhNHJuSERaNzMzcDdHVmhaVFlIdHNweWpaUFYwUEhjN002NkpXbnZvOW5w?=
 =?utf-8?B?ZUlId1lWbUl1dGpHTkEyQWpzSzBFRitIbmFCQisrMm14cGF4bVQvYm1neUxY?=
 =?utf-8?B?UFVrdC9mVEs1ZEdIbmN2RUorcTVkWmFJNWN5MG5pN2M1SGkxZG92aDA3UW5Q?=
 =?utf-8?B?VFR2YU10a2poZVF5Y1dzOStiRzB3QTkzTGZRL1pzNlVjZXEydWd2WHE3MkJD?=
 =?utf-8?B?VGJpZHVLNEZBRWdtSnowOHRkU0FIYlNoSDZucEZrSmZva01pYk50Y2lXVE9O?=
 =?utf-8?B?QlZqaHZvTWdMQmFSaHJBY1JWQncvaUczS05PTmRhNVExVUdhNnRpeUFHODhH?=
 =?utf-8?B?eU1pSGRDMm9nemxERzZaWUpsQ0tZNTBlK3E2cUE3YjVrRkZlL1pIMndoaDdO?=
 =?utf-8?B?QU50Z2VGeEUxL3ZWai8vVXZaa0tFRzJUZ2hBNEFGTlVwUHJYTHpBY3cxZDhz?=
 =?utf-8?B?VEFVYTZ5eE5icTVWN0dOSkJBNVV5UjI4d0ozRnlLV1RCMEJuRGc1d3UxM3Nt?=
 =?utf-8?B?dE5GMkdmcUpDMzdZUHppN3dQc3RoeVN1VVJ4UmRPTzdmNDRIU1BaeWhOZnhW?=
 =?utf-8?B?Y0k5cldSUURmOW9lL2NHM3NBUkJzb1Y0eUd1c3J3ODJZRFlQR3dEQVdrK05x?=
 =?utf-8?B?bFRqb20zbVBFRVFOZ2tnYnIvZUxLbzFTb2pVM3J0cVA5VDlvQ0djVmU2U2pl?=
 =?utf-8?B?cFdtcjQ0S3E3T0lJV0Fsdkh3T3NKMFptSFFmYXJ3Y08yYk9sMU8zM1ZEZWRI?=
 =?utf-8?B?NFA4QUExTkdaaUduRER2VVRSYmpjbml1UFREK1EyNDJLYWorYzJRMHNQVFZx?=
 =?utf-8?B?RVNBbHZKNVpzU0JoR1hLQzVqN3BTZGhGUkRXNXByUVVkZ2E5SERzTGtFdFRz?=
 =?utf-8?B?dlRlUElwL3R0OHE2VVlMMjB3dXNoR0V6d3lvbFBsWTJYTE5LVXdkb0tQZGVL?=
 =?utf-8?B?cFBSejlmZVJTVi9hcm9oOU1yL0JFWXJoNmc5SkhWc2d3S3dQQ3RBK2VvM3dE?=
 =?utf-8?B?aFkzSU9OWmM2d1Fwa1ZLZUtQUXdwTUFSSXhMOWw1d3k3S0dRVjd4M2ZRSG05?=
 =?utf-8?B?bzNlYi9CMm5hdW1tcUk3Q2V2WUJrK0dPOE1lQTlSTEtlekNtd2VDNUlwZXlF?=
 =?utf-8?B?RG52RGx3U2VPb1VobCtEMmJ4N0VXR2M3WFUyNU5iVHkwNGlCVHBVeVdldE5k?=
 =?utf-8?B?cjduTUdyM3Z6Y3h6cmQ2NEN0MmlBZjhRbys5Vk0xRjIrcXkrRkJJbnNVMHdi?=
 =?utf-8?B?UktFT1p2Qk9FemsrRlFwWlNWc01NYXBYMEtKK2R6UllFdDRTSTJWd3ZtRW9i?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6753465f-2e2b-4fdb-6b8d-08daaba859dd
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 16:47:57.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EV4eAZ8AaJTYWrOvmBmQafbxSkfV6y1a8PKVylXFGiHUPmTJrTrBQOLLo0wYKI/SXkOgNmxPlTz6qHma1iDytw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7225
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/10/2022 17:16, Pali Rohár wrote:

...

> I see, this is stupid mistake. PCIe config read and write operations
> needs to be 4-byte aligned, so normally it is done by calculating 4-byte
> aligned base address and then using appropriate cpu load/store
> instruction to access just defined size/offset of 4-byte config space
> register.
> 
> pci-tegra.c is using common helper functions pci_generic_config_read()
> and pci_generic_config_write(), which expects final address with offset,
> and not 4-byte aligned address.
> 
> I'm not sure what should be the proper fix, but for me it looks like
> that pci_generic_config_read() and pci_generic_config_write() could be
> adjusted to handle it.
> 
> In any case, above patch is a regressions and I see there two options
> for now:
> 
> 1) Reverting that patch
> 
> 2) Adding "offset |= where & 0x3;" after the PCI_CONF1_EXT_ADDRESS()
>     macro to set also lower 2 bits of accessed register.
> 
> Jon, Lorenzo, what do you think? Could you test if 2) is working fine?


I tested 'offset |= where & 0xff' which is essentially the same as the 
above and that is working and so I am sure that the above works too. 
However, I do wonder if reverting is simpler because we already have a 
'& ~PCI_CONF1_ENABLE' and now adding '| where & 0x3' seems to diminish 
the value of this change.

Cheers
Jon

-- 
nvpublic
