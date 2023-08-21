Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0128978313E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 21:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjHUT03 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 15:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHUT03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 15:26:29 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDDFE3;
        Mon, 21 Aug 2023 12:26:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDKura9GhxyaQ29B/2bPxSwg/CqOXfBE9oTnws3I+YdYBXPLKs0kVrBcvqQxfnODk3A7CZ1a8cwELoqKLIkeQbUA3tPVpm19twlB0BGR1Xl8ScGXUOqY57zU9oUCWPh37bTlRsqGwxPNwrfsQv4r+8XD9PEm7rMfTFkpLAA/xELBtw3JBNGn1wTQMUcHE9hToLJGwc33CK12EBM1QMlRuhlB1rrU8uriID0WGVbAeAIP58zj1cF3MLshcShP3cJRcH0BH4GztIW6/qSVylAJxdO2cDssOoul71bJqpvcWCe3IOakSn8033C1xPUgb4fMH0jc2gFtzWnwK2USEmNhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziBSwAdJ4ENdsPwS9mMbYqi0+NGvtAnwWjw+EHDcx14=;
 b=gePgGiyv+WR29ns7eB2IktUr4vaczll5X4hHfBwKOQrQvu39Ju2pUhrxyPwCBSMh8fJKPM33TJMM/w6RPFjKZ6FYIxKBU3fXULAK3p9/GXugejyf9KyriqYnZFzNqJQ/yOzHyLqenWrjAIUvNtjW1WFPvAFk3wLcsEET78eQO6GcsRojKzg6BE9FBm8C5uF7GCBBeCwR5nNTCHb7TkCTLEmlg1OvD12AAOn/oxi1CuUDeZHzFKGdKoarfPp0MQsyFK8ejTx3MoQ0RKKEIedzg/58Jv6Tk+wrEJqxcHtZcX1Qljtvkg4El9xBMNpmcvxLdVMHhsIJWIFssYuXBhOWYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziBSwAdJ4ENdsPwS9mMbYqi0+NGvtAnwWjw+EHDcx14=;
 b=QpHIkLhL742c7jsCGMnNEQ4kTV7Io97ZADhbRrtp3yIoUDyT84lBYkeFqc12O0WrIlgUdPM+1mGU7lwHDWHHWE8l+3PEF8256lqywMrtn4KWSYI3knV/uiXXaubk7rtF28cFFHfexr2yCq2ioDzdcBcW4JjjxrVJeP/HpzL8Z9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 19:26:25 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 19:26:25 +0000
Message-ID: <1ff59c88-4777-4c8c-89ad-8d5030c3c8c1@amd.com>
Date:   Mon, 21 Aug 2023 14:26:22 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14.c 4/4] PCI: ACPI: Limit the Intel specific opt-in to
 D3 to 2024
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20230818194027.27559-1-mario.limonciello@amd.com>
 <20230818194027.27559-5-mario.limonciello@amd.com>
 <CAJZ5v0j_tmW1uWZF7ShK=fwnVGjjy8CSf7DJErJdSaD_dgW8WQ@mail.gmail.com>
 <2bec7ee5-2ead-4c46-b6eb-f4d7a2249293@amd.com>
 <CAJZ5v0jpWJC_9VEkXckZAPwcJESDvwncx3WzbLZn8a42U-zU1Q@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jpWJC_9VEkXckZAPwcJESDvwncx3WzbLZn8a42U-zU1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0149.namprd11.prod.outlook.com
 (2603:10b6:806:131::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: a790e610-3a8e-49fb-41dc-08dba27c8244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bo2qvLutNRQPM3WuBLkCmVWlt40g93/gDrP90t5nbIF27aUrLXkC9CVXvOdW9n1+4XwS0rj8DjXZyCxWsYHJn9pvfU0KkDPdQq4pDsmAp+NWUaWkdViNLKk+EDw30Gh1ISr78LCMBHtY6XQXDJCKjpfNMxWhhc4gtfwi7KAWspfwcVWQGomBZrXPIUtcTmNXqpMp2xtLDilGSPy8/5pD09yuH3OpLsrUDwYwOMATHxIXfOub7A2DFSau1NK3ZES7QnR+vmUNVXIUlVTsKvtkz2w1GxLmn3eowRTmHEIkivvLHu4qcFWdF7RwdhUfPbeJaLsbTymch0G+EU0XQKsSalrwFmjLZvhvOvGK5bZIdcCL6JeD9x+kHJ2CadKtrj7830EAejENU8XETx93LiV1bJpteDG/rcEkoLZdEJYByZZfGuh2ojjCGIc+NqPv3gj01NFDnBehxLZsLLq6TriZf7bcI5CJ+lQCWIsC4i7KaMDPKiT5mMKj15QbybXuGtOHoNVb464hJRYpmin4PwfwR/zRrbnJkX5/E3svVla20EjNpVZ/rIwg+lEWbdJJI2ygEO33XCYn5nqJPFBORFuP1eW/DBxiey7ZDyKow7YeqDBcQcmnDW6WgYO6A8mPQ3NIverkuDWfZ6Q0j/uEAVvjEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(1800799009)(451199024)(186009)(38100700002)(66556008)(66946007)(41300700001)(6916009)(54906003)(6666004)(53546011)(316002)(6486002)(6506007)(66476007)(26005)(8676002)(4326008)(8936002)(2616005)(5660300002)(6512007)(83380400001)(2906002)(86362001)(31696002)(36756003)(478600001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHY4ZGFzNWEzZkx4Nkp4QmVGTW52bjJwaVFlbXpjS3UxWmVnMmJ3NFBZM0oy?=
 =?utf-8?B?Ti92WVRzSmhEelRnS1BvNVpEN3J0bHdRK0hteTVHUGRwLzRRUlZFNmRCbGRI?=
 =?utf-8?B?ckNaU3BjYmFIbHlOU2ZZWDFEN21wSE5vV0FvRWZrT3M5amJTeEZic3MyaExQ?=
 =?utf-8?B?NEFzemFJTG9kTXhHTGlXazhjTnhuLzJtOUhYRUppUjBING5MaVJqdklrTmhI?=
 =?utf-8?B?blk2K1N5SzltSW85d043QnhmN01HYkFwbkE3RDlrWUg0MGNXVmdTNzIwT1VI?=
 =?utf-8?B?cTVMbUl4THNZaWcyby8vUWxnUkNoTzhKdFFJWGRPWEtqQituS0pSd1VjSGly?=
 =?utf-8?B?ZUFHTmRvSTB5MFdvNllCeW1uQXM2b1lpZUFUbGZXTEVkQUhxUVk3dFhadjJT?=
 =?utf-8?B?bGNSK0pVdHoyWWdONUtQVTk3R01GMUhVMWh3dWVlMmVZWVc2OWtsSEwxNUd3?=
 =?utf-8?B?d0pHYmROVWdvK1JCWmpqU2drOFEzSktyTEFnZENOa3FScDZwZmlkZHBFSDNR?=
 =?utf-8?B?NXdsM24rOWlpVUdMMENCc3ArL1VPM21EVmR1d2Q0NXdkWnA2OFNlU2ZaeDhU?=
 =?utf-8?B?eGpYcDhlTmpzaHJPeTE3TFpaRXNLeFdadkxYRjRkT0c0ZnhZeUhvMnQ0UDdk?=
 =?utf-8?B?R2FvY0puN2pMbHJSQjl1em1Ta1Z4NzI0aEJRODlNd2xYZ0xMSlRSaVNaU0Nl?=
 =?utf-8?B?TnRUWmQzR0g0QlY5NGRoM2VNTjkwbHZtNUl2V1dPVisvMmNCVEZKYm5VSzgw?=
 =?utf-8?B?WWkxOENvR0ZxQkJ0Ukp1L1BQYWxITHR3T1FlRnV6elpqbUE5OWlJOU5Tc2ZV?=
 =?utf-8?B?bE1ibkF1cGRRdHJad3cwNzkwdUYxRlRhTDV6VGYrTW9RSHorVitKV0ljWTEv?=
 =?utf-8?B?WGlyU0ExaEFXS2VJeCtxUUQ2SlREc3FIY3d2UktETjNmOUc0WUhoK1dNS3hl?=
 =?utf-8?B?TDFSaVN6N2ZSdXFEUlM0TWx1WDErMDBxVE1yMEN0SXFNRk83REl6cnZ0NVh0?=
 =?utf-8?B?QW1IUW9BWmE3YnROZ1pDNUIxc3J0NzMxL3U4ZUhvZUNwQWVGb0FJbkE5TGp6?=
 =?utf-8?B?bmF6dzdKVFlKNFlnUFlNb0RUenBWQ1VkVnRGbzJMcW1Ba0tkTUVUU1ZTdFcz?=
 =?utf-8?B?L1k2MVNDRW9QaGxCWFpKUnJGOFI3enIzTnVqK2kvWkNtQTRZdzNzWnVwUzdk?=
 =?utf-8?B?MDJZV3ZWRWRBQWRNajNuUFJWTGFUanFnN3ZMdVc1TFlXUk1Hdkc0YzhXWm5j?=
 =?utf-8?B?Vzlic21GZG9EUmtkZGxIK0xiUEI1V1VzS2ljWTQ3RXo1emxxbTdwQWk1U0N3?=
 =?utf-8?B?R0R5Qm1JK0QwdDRQT21zcnFFQ0psR3JUaE9tSzFodm80N3NKOWdIMUgwOTh5?=
 =?utf-8?B?THl3bFRTb0FyS1RIY3lEV21XREVqNGRxNHUyQm4wK20xK2pQMUJIR0FyR3h4?=
 =?utf-8?B?RmFDLzhoR0NBTFRKQno1K0x5SHo2VzNCc1ZPdjF1ZVpaOUxIdzQ5M3c3NHZR?=
 =?utf-8?B?Mm45SzVyVGlnckh1TEdWam9XV25yT0hzVXhUV1JCVDhpZW9iTlpZYW5oMXg3?=
 =?utf-8?B?TmRwK05jd1ZDNDlVb3NmQVpjSXh6VTJoZ3o4dlJqaEluTTZSMExaMkJBdThu?=
 =?utf-8?B?UUdxNUhkRXJnKzI3YUZaTnl0L0pmZVRMWlhnNVQwY2dOZnl3MEVoWlh6L2dD?=
 =?utf-8?B?SXJLM2lhUXM3RTVnRG5Hdk92eDdjQkVnbGhmeUhYanBEL2NSajk5dVpzOUZQ?=
 =?utf-8?B?SnV3d0NTeENwMlRUZjFPU0ErbndSaHBqQ1lDNEtKZVVwRnVTdURkeWE1L3Vs?=
 =?utf-8?B?Nk5ZRGNub3JMTEpVZkdxSEhwbkNEMDdFWXpuWUhBMmlTVWtzdEJzZkR6N0Vn?=
 =?utf-8?B?b3dpWGkyYTZnSnBqZm95UnRobnEyVXoreU5peDVkL1pCUkpjQmoyTFl5NW15?=
 =?utf-8?B?OXpCdGV4UUFYa3E2dzhQYzdsQk5pd1o3M0M1UEcvMlJRSjY4MFNxTnJpUkVk?=
 =?utf-8?B?cG1BQ2ViQk5GbkY0dm1ESmNYNDUwalJ6Mk9lNkhoeHFSeTlhcFhlZ1FxMHFX?=
 =?utf-8?B?NUFIcE5Ba3Rub1AwTmQzM2h0UWQzVW1LOHFTclZQVE9BdS82VG9KWFFiMHFp?=
 =?utf-8?Q?qoSJdiqSNsPyfQvqx71a0cW35?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a790e610-3a8e-49fb-41dc-08dba27c8244
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 19:26:24.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijdX9pum7bD9xw2s1o/M7nZjqde1YF21jtKtdJ+TCkKhTmvCP9otMrTooBIu+7Csqlb9PVnIj6JODUjSSHFsqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/21/2023 2:24 PM, Rafael J. Wysocki wrote:
> On Mon, Aug 21, 2023 at 9:18 PM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
>>
>>
>>
>> On 8/21/2023 1:46 PM, Rafael J. Wysocki wrote:
>>> On Fri, Aug 18, 2023 at 9:40 PM Mario Limonciello
>>> <mario.limonciello@amd.com> wrote:
>>>>
>>>> Intel systems that need to have PCIe ports in D3 for low power idle
>>>> specify this by constraints on the ACPI PNP0D80 device. As this information
>>>> is queried by acpi_pci_bridge_d3(), limit the DMI BIOS year check to stop
>>>> at 2024. This will allow future systems to rely on the constraints check
>>>> and ACPI checks to set up policy like non-Intel systems do.
>>>
>>> So I'm not sure about the value of this change.
>>>
>>> The behavior is made Intel-specific in [14a 1/1] and it will be that
>>> way at least for some time.  This change only sets the date after
>>> which it won't be Intel-specific any more, but for what reason
>>> exactly?
>>>
>>> And why is 2024 the cut-off year (and not 2025, for example)?
>>
>> No particular reason other than it's a few kernel cycles to get this
>> tested and working or revert it if it's a bad idea after all.
>>
>>>
>>> If Intel platforms continue to be OK with putting all PCIe ports into
>>> D3hot beyond 2024, why restrict the kernel from doing so on them?
>>
>> OK let me try to explain my thought process.
>>
>> The reason that root ports were put into D3 on Intel systems was that
>> it's required for the system to get into the deepest state.
>>
>> At the time that it was introduced there wasn't a way for the firmware
>> to express this desire for root ports that were not power manageable by
>> ACPI.
>>
>> Constraints are a good way to express it, so by limiting the Intel
>> hardcode to a number of years gets everyone onto the same codepaths.
> 
> Assuming that the will be used in future systems, but that is beyond
> the control of anyone involved here I think.
> 
>> But that being said - if you would rather keep Intel as hardcode forever
>> this patch can be dropped from the series.
> 
> This change can be made at any time and I don't see a particular
> reason for making it right now.

OK, then after Bjorn reviews the other patches of 14.a and 14.c I'll 
drop this patch.

Thanks!
