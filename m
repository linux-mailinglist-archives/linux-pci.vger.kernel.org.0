Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDB6C576F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Mar 2023 21:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjCVUYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Mar 2023 16:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCVUYO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 22 Mar 2023 16:24:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9057772030;
        Wed, 22 Mar 2023 13:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh7pmS/R4RelxDhKyMU+RQnvS2nSTnHKJCDCzC++//ESX25d8HHCznRN9k2z9jJKqjl5MxEFZTvUSaMGPWh0c3QQjlSyAZmdn9XsVo2txkVIOtqW4BLSuQpy2zi2jGCLbxtPYrH090P4h1jWIIT5TMkpP6lTOm6ZvGhhY4ILxTPVJ5hGm6JwlLjT2DWe60K7WVzpDHACUWIHYWVIqXu2xrf36UyFlWFHWP46TMq/tzWRE2lIy2qcPvQsHj7pkCb9OJqdojvuaNA2CqOQD6NkmOz2AwSdxM6PLADoVj2KPPFRdA6LgVtUNhLZOuCNUBGiEhUD6Presj7+X5f61Z3Q7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikLaT3XIkLCGrSAKIeRY/Xm/leRa25RYV8sskybVQDg=;
 b=ecRlYcly3KvYMj2dF0Qud5FgZTWSiokh9kP2c+N1wiThRjKQpK9CBSleQv1ehHLwm6YPdK3kfQk4C4abIHGiGIzx7PcjQqIN2aORq1s2jt4l1Us9g4JPMeZUDIWWZb7wH35rR2BkLVHC2kQNMMXZV3nwlfE1jbwqCRTkohkk/SO76a/DCrjW2bpvZm6uNQI0rzZjYqoKDpM8Ny1ijQE1C/hHYxKJ8BkV4+o0mj3OXhb3173sq8GrLspVzpGnEWuaWf7YzR2WcodOqAKmabhzHnWZFR2CrY5ppgVz80IUJ7N4Q6jog9QHIgZNeUL/5lYMmzZ6YDIYLU3EUKSF7sboSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikLaT3XIkLCGrSAKIeRY/Xm/leRa25RYV8sskybVQDg=;
 b=uE1VtlZqC9Oah1tC0J008Uclh+BhbC1kxfZjx0nonVqdfXw3d7K0+kmjX8Fv90ROgaRV/vQE8IvOll9riANYykSD6qrzqwCsVpzEy8ggXO5E5lKDfd6Uv8fugtCTl3U+/mMfB5uaeEAo5NH9jcj/fWG73bGZ0OEhtZhICI19TVj731WkFWcJbZdcs1HtYlacgltY98NXTGcUaEZ3NUdD0oFRiuf3FJO+Rd87nkNGvviUCW/YhuqoxYK6vI4qIrJ+VPcrSPIOnKFaIz01P/nZaYF+LzoxhOjY0H7pNP+rQr/4rPqAjTLSNvMKual+9kPLvUJUfqLejmNyYU+KEzGI+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Wed, 22 Mar 2023 20:13:09 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::5464:997b:389:4b07%9]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 20:13:09 +0000
Message-ID: <850cd1e0-3481-91b7-17a1-d6b258762503@nvidia.com>
Date:   Wed, 22 Mar 2023 20:13:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
 <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com>
 <20230320205936.wd6pj3trljsduj5c@pali>
 <993ca7dc-1d39-6ae9-1033-838d81aeb076@nvidia.com>
 <3414723d-7d79-809f-e63f-35243d945b50@nvidia.com>
 <20230322172111.a2dfp2eyicuskrez@pali>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20230322172111.a2dfp2eyicuskrez@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::20) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: 538bf516-92a1-48f0-7bcf-08db2b11db35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZRLJvz49xp0zcdID85A71KW5y7350LLHQvZFmbFYtOiaaeCuIsta/NuBD75m3TqPKAKhisnhrtPrXdRWkNxbeXppEDEfI5AbX3BgnNTVkIPLe1W9mxfrMITYZSNeQqk9XZEpl7+L6MI0jz9XZYth8BvpluRo33gjdD3VxnYN66HuasaqS0zxONoLqC51hOBhVApDYwznyrScRKfgEEMyAz1pmW2GuJoYyqpqFYJbYaMMja83hDQ9T71g4rOXtzgRjtKefWpInHhNY6uwMLFpeT1dcydBUQWQW5eY7HZZZPlfarmBIc2S1TJBgnDyv0syfDJJ5BqSr6UDrtBdLfU2tCWSCwOaRqwcoJ9Jq+ejdoVuHU6PG+b7DSSB2eVw8X6QBQyNTXi08wFPxAsOwQO7OmQFbjxxlTTVAZiOB00s4NJhLYgdU/1JavzdzRAMx7FgSR1KBTZF2UzlFHZQlatWARuGwtL6JthRII9IF6/W1Z+Aab4FeMEbOxgxZ0xaXsa1r3cLyH0CyMfs2OAIzZ+wX6MvdQU/qCbx0x9YbIZqrkirOpAv9xi4YHOeEMkU3IPKR1C3uGz15N+gL3PkvkqUr4pLrzW86rgfNupkMoT92nzty6UkwVW+DALqpwHUUGXihd7Iii64F68R8n9JQ+2PgN7VyDQI+GbHfU56iiIscRaVHOJh2fIimDlmG9rYpVTsBpioHC22rCINY7Rr9NwxiXKCgTxRY9pIZMJBHWJNQaKwodbU6YatvF+IOM4Aw1Mzjp18TgCE8wIVH2fI7sUa/RGWwDvHYv+e6ujQ8i66Xs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(39860400002)(346002)(396003)(451199018)(186003)(6666004)(66574015)(478600001)(6486002)(6506007)(31686004)(83380400001)(6512007)(8676002)(53546011)(2616005)(54906003)(316002)(66556008)(66476007)(66946007)(6916009)(5660300002)(41300700001)(8936002)(2906002)(4326008)(38100700002)(31696002)(86362001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFoUHE4YUpLZ2ZzaDFvM2pWK3MwUUV5U1RPN3gwRHFJUkE4cCtaNXJSeTd6?=
 =?utf-8?B?VC9ITWx5RHZkRS9oa3piYktuU0NTSTZzdFhIb0ZzdUVFSy9LTkdKVTVKTnpK?=
 =?utf-8?B?U29BMFByT1gxWWJ2ZEZhckx2K01ZVS8yOXdYUkdJRXp2aVNkclB4UEZUanV0?=
 =?utf-8?B?ZkNJSG9HMlFGUllXcU9hUWZMWDNZMVJVNTN3RnFnRWpNSGpVWGpITDNUUDVU?=
 =?utf-8?B?VGZzbHJaSGVKdTllTmFRdTU0REx1a1JoODNqMDZjWTlUemc5MDRVV2lGTGhU?=
 =?utf-8?B?RFkvSHBsb0g5dzdoZk9xeDVHcy85NE82U1d5Vkk3bm00Nk9WVTlMcTBzYjd2?=
 =?utf-8?B?MEpKdFZSVndLaTVzUHJJN1l4cEVpOUdOeTF1dlZtNE1GZXdTT2lha3NCWW9x?=
 =?utf-8?B?RDlIZU9qMHY2MzhPa3dDUEdqdGROaGduRzhtZk1xME45SlR3SU5kY3lETlo0?=
 =?utf-8?B?bXRjMWFvZUtsMitxdVo5dGx6ejlueFJWTVIzQXVmVGtMTVhUekhaRzRYUU9n?=
 =?utf-8?B?WFA5d1VocmRZcUZ3M1F3a3NHOFNROVNlZnZrbC9PNE5hRjVFYlgrNmhnbytO?=
 =?utf-8?B?TlFIUDBLdFNoaFJtQ0ppOVBrYjZDVXd1YmhMakM3V0NNVEg3cXAzdzRNZFoz?=
 =?utf-8?B?MzQ4UTRBNzFabDl3N1U3OEo3NjhwTVIza3lSSm5OeS96cEx6cDRSRmZKUkFZ?=
 =?utf-8?B?U2NhcllnVVlteU1xTzZnNHBacjNHSGhYcWJEODJWcDFWQWxpMkFYS0xFREFx?=
 =?utf-8?B?RnVVWmdXYWMzTmFQM0tvZC9NWmxmVUtDRElGUnBoRFI0eVlBSmJPNXFXZEZq?=
 =?utf-8?B?aSt1ZlpjZE82cDNDVmRVZWxBVlI2bTB5R0dLeVRDK2tMMS8zSUxxY2wxOVc2?=
 =?utf-8?B?V21RdFl4TEdQUEg0bFJ5d3kyQnlIclc4aURCbzF2dEErcitNU3N0YXNGdjRt?=
 =?utf-8?B?WWcvNGIzaEMvVG9JTmFRYWx3ZDVaZlgwaWxySERrR0l6VFlXUEpzcmR1d1pm?=
 =?utf-8?B?TnRmOENySVZnTmxrT0V1NGVQVWZaYnltNFQyazFIclFGWlpRTmtIQ1N4Nnh6?=
 =?utf-8?B?U3A4dlA3NkR1dEJWRzgvdmEwVUF4bzRFMFN2bWQxUU5KVWdNaFpwNVE4dm40?=
 =?utf-8?B?WGJWZEpDdm9mQ1YvVEdKSFBxendCYVQ2ZzhuQUZHTVdXL3N5SWtOd0xXcy8y?=
 =?utf-8?B?Z2xoVnAzOVRGUDFLdTJVVnhXZDlSbGM3aHRScStyUm5RNW4rN1orRHJxV2NT?=
 =?utf-8?B?YjBsQWp0b3UzaUlNejg4T2ZpLzRvbmN0UGVUQTZPUDlRV3NtUUpadDNHaUpi?=
 =?utf-8?B?SXZZYlIvQ1RLVXJhc2d2TFp1WUZRdDIwN0NaUERTUkF0WEhjVWtUUTFLMzBq?=
 =?utf-8?B?b3FibzZJa0JIeERGZDhGYy9XOWJDQlZiWFBTRmc0Vzd4UmV3OGFzZU1MT2cv?=
 =?utf-8?B?dk9uWDhOd0tHb3RNaEhZQlRUWWFpWTRXLzBNY1hzaVE4UHgwSGtxV3ZoVWhN?=
 =?utf-8?B?bVlRR1k2TXA0bmppVjMzdWYyaFFRaFhOUmZxdUR1MXVFcVFid0RRaFpuUWNL?=
 =?utf-8?B?VkdXeFdFcGdzdkRYbGV5aHp0UGN0UXhobm4wbjUyVFB5VlhZQ1JnNzFna21K?=
 =?utf-8?B?bVgybDBCQ3k2d21mYytkZlpxelB3WGxpazlDODVqOS9LaXRKaGwyb1psU2pK?=
 =?utf-8?B?RzJxMSt5UXJuVlNzUUxsSVRsNUVqY000YndKL0NwQ0tnOTN2OTlxRmxVcVZH?=
 =?utf-8?B?dVl3enRjK3Q4SkhLVVcrYXFLNW1hTDdtSHhydjNFZXMxK0tvYXlpNVBBSDhG?=
 =?utf-8?B?TkxYS2IyZ2FOakZRZGpqRWxzTk1BeTQxa0tvQ3VQd1E0NFIwK0pHNEtOZGtL?=
 =?utf-8?B?WTZ2VXBqZmRsWEN6VFpiOGhuMnBZUDg1U055ZXNuRkpkK0FRV1ZyUm9GUHNP?=
 =?utf-8?B?WGhocjNkQUFoOWNyMWJqZ2t5MG9NeGxFQjhWN2VqOWR1V1dicHNpaElBcFN2?=
 =?utf-8?B?RmFPalkwZlMwVTBsNkdaNFpnbldpYTIrVlBPc2dqNDlKSjJieC9MbXN4RXFN?=
 =?utf-8?B?eC9yTmJ3Qjc4QW5iam9YUlpvdFBnNUQ1TU1rcTdIbElmbW91R0JYRisxSWFi?=
 =?utf-8?B?R1VDR3BGajRQeVV4QUdjQlFmclBOc2tKbXU2eS83dWU2NlE0MDNxeUd2V09J?=
 =?utf-8?B?VkpWaDYybm5RVVFIaTlqWWJMUGU3STFVbWNpR1ZqaUtNNWNxVzl2ZEdiSmhI?=
 =?utf-8?B?NzZEUCtjcjJYWVZZVGg3ZW9GSURnPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538bf516-92a1-48f0-7bcf-08db2b11db35
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 20:13:09.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U34AIBd24RAOCNCs7RZaxEmlisfl9h7T+rk0RXCKE4mBKU8nYeAe9MmYqL6Rwhs3cYLiVgo/rxDYHyvKVQ23DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 22/03/2023 17:21, Pali Rohár wrote:
> On Wednesday 22 March 2023 14:36:23 Jon Hunter wrote:
>> On 21/03/2023 18:44, Jon Hunter wrote:
>>>
>>> On 20/03/2023 20:59, Pali Rohár wrote:
>>>> Hello!
>>>>
>>>> On Monday 20 March 2023 20:26:05 Jon Hunter wrote:
>>>>> Hi Pali,
>>>>>
>>>>> After this change was made we are seeing the following bug
>>>>> report on a Tegra234 Jetson Orin board ...
>>>>>
>>>>> [   17.172346] tegra194-pcie 141a0000.pcie: host bridge
>>>>> /pcie@141a0000 ranges:
>>>>> [   17.172470] tegra194-pcie 141a0000.pcie:      MEM
>>>>> 0x2800000000..0x2b27ffffff -> 0x2800000000
>>>>> [   17.172519] tegra194-pcie 141a0000.pcie:      MEM
>>>>> 0x2b28000000..0x2b2fffffff -> 0x0040000000
>>>>> [   17.172548] tegra194-pcie 141a0000.pcie:       IO
>>>>> 0x003a100000..0x003a1fffff -> 0x003a100000
>>>>> [   17.173449] tegra194-pcie 141a0000.pcie: iATU: unroll T, 8
>>>>> ob, 2 ib, align 64K, limit 32G
>>>>> [   18.279048] tegra194-pcie 141a0000.pcie: Phy link never came up
>>>>> [   19.279285] tegra194-pcie 141a0000.pcie: Phy link never came up
>>>>> [   19.279599] tegra194-pcie 141a0000.pcie: PCI host bridge to
>>>>> bus 0005:00
>>>>> [   19.279613] pci_bus 0005:00: root bus resource [bus 00-ff]
>>>>> [   19.279622] pci_bus 0005:00: root bus resource [mem
>>>>> 0x2800000000-0x2b27ffffff pref]
>>>>> [   19.279631] pci_bus 0005:00: root bus resource [mem
>>>>> 0x2b28000000-0x2b2fffffff] (bus address [0x40000000-0x47ffffff])
>>>>> [   19.279639] pci_bus 0005:00: root bus resource [io
>>>>> 0x200000-0x2fffff] (bus address [0x3a100000-0x3a1fffff])
>>>>> [   19.279687] pci 0005:00:00.0: [10de:229a] type 01 class 0x060400
>>>>> [   19.279886] pci 0005:00:00.0: PME# supported from D0 D3hot
>>>>> [   19.283256] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
>>>>> [   19.283590] pcieport 0005:00:00.0: Adding to iommu group 26
>>>>> [   19.283991] pcieport 0005:00:00.0: PME: Signaling with IRQ 174
>>>>> [   19.284429] pcieport 0005:00:00.0: AER: enabled with IRQ 174
>>>>> [   19.285003] pci_bus 0005:01: busn_res: [bus 01-ff] is released
>>>>> [   19.285591] pci 0005:00:00.0: Removing from iommu group 26
>>>>> [   19.285751] pci_bus 0005:00: busn_res: [bus 00-ff] is released
>>>>> [   19.285870]
>>>>> ==================================================================
>>>>> [   19.293351] BUG: KFENCE: use-after-free read in
>>>>> pci_bus_release_domain_nr+0x10/0x70
>>>>>
>>>>> [   19.302817] Use-after-free read at 0x000000007f3b80eb (in
>>>>> kfence-#115):
>>>>> [   19.309677]  pci_bus_release_domain_nr+0x10/0x70
>>>>> [   19.309691]  dw_pcie_host_deinit+0x28/0x78
>>>>> [   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
>>>>> [   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
>>>>> [   19.309752]  platform_probe+0x90/0xd8
>>>>> [   19.309764]  really_probe+0xb8/0x298
>>>>> [   19.309777]  __driver_probe_device+0x78/0xd8
>>>>> [   19.309788]  driver_probe_device+0x38/0x120
>>>>> [   19.309799]  __device_attach_driver+0x94/0xe0
>>>>> [   19.309812]  bus_for_each_drv+0x70/0xc8
>>>>> [   19.309822]  __device_attach+0xfc/0x188
>>>>> [   19.309833]  device_initial_probe+0x10/0x18
>>>>> [   19.309844]  bus_probe_device+0x94/0xa0
>>>>> [   19.309854]  deferred_probe_work_func+0x80/0xb8
>>>>> [   19.309864]  process_one_work+0x1e0/0x348
>>>>> [   19.309882]  worker_thread+0x48/0x410
>>>>> [   19.309891]  kthread+0xf4/0x110
>>>>> [   19.309904]  ret_from_fork+0x10/0x20
>>>>>
>>>>> [   19.311457] kfence-#115:
>>>>> 0x00000000063a155a-0x00000000ba698da8, size=1072,
>>>>> cache=kmalloc-2k
>>>>>
>>>>> [   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
>>>>> [   19.311562]  __kmem_cache_alloc_node+0x260/0x278
>>>>> [   19.311571]  kmalloc_trace+0x24/0x30
>>>>> [   19.311580]  pci_alloc_bus+0x24/0xa0
>>>>> [   19.311590]  pci_register_host_bridge+0x48/0x4b8
>>>>> [   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
>>>>> [   19.311613]  pci_host_probe+0x18/0xc0
>>>>> [   19.311623]  dw_pcie_host_init+0x2c0/0x568
>>>>> [   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
>>>>> [   19.311647]  platform_probe+0x90/0xd8
>>>>> [   19.311653]  really_probe+0xb8/0x298
>>>>> [   19.311663]  __driver_probe_device+0x78/0xd8
>>>>> [   19.311672]  driver_probe_device+0x38/0x120
>>>>> [   19.311682]  __device_attach_driver+0x94/0xe0
>>>>> [   19.311694]  bus_for_each_drv+0x70/0xc8
>>>>> [   19.311702]  __device_attach+0xfc/0x188
>>>>> [   19.311713]  device_initial_probe+0x10/0x18
>>>>> [   19.311724]  bus_probe_device+0x94/0xa0
>>>>> [   19.311733]  deferred_probe_work_func+0x80/0xb8
>>>>> [   19.311743]  process_one_work+0x1e0/0x348
>>>>> [   19.311753]  worker_thread+0x48/0x410
>>>>> [   19.311763]  kthread+0xf4/0x110
>>>>> [   19.311771]  ret_from_fork+0x10/0x20
>>>>>
>>>>> [   19.311782] freed by task 96 on cpu 10 at 19.285833s:
>>>>> [   19.311799]  release_pcibus_dev+0x30/0x40
>>>>> [   19.311808]  device_release+0x30/0x90
>>>>> [   19.311814]  kobject_put+0xa8/0x120
>>>>> [   19.311832]  device_unregister+0x20/0x30
>>>>> [   19.311839]  pci_remove_bus+0x78/0x88
>>>>> [   19.311850]  pci_remove_root_bus+0x5c/0x98
>>>>> [   19.311860]  dw_pcie_host_deinit+0x28/0x78
>>>>> [   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
>>>>> [   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
>>>>> [   19.311900]  platform_probe+0x90/0xd8
>>>>> [   19.311906]  really_probe+0xb8/0x298
>>>>> [   19.311916]  __driver_probe_device+0x78/0xd8
>>>>> [   19.311926]  driver_probe_device+0x38/0x120
>>>>> [   19.311936]  __device_attach_driver+0x94/0xe0
>>>>> [   19.311947]  bus_for_each_drv+0x70/0xc8
>>>>> [   19.311956]  __device_attach+0xfc/0x188
>>>>> [   19.311966]  device_initial_probe+0x10/0x18
>>>>> [   19.311976]  bus_probe_device+0x94/0xa0
>>>>> [   19.311985]  deferred_probe_work_func+0x80/0xb8
>>>>> [   19.311995]  process_one_work+0x1e0/0x348
>>>>> [   19.312005]  worker_thread+0x48/0x410
>>>>> [   19.312014]  kthread+0xf4/0x110
>>>>> [   19.312022]  ret_from_fork+0x10/0x20
>>>>
>>>> Based on the above trace it looks like a double free of "pp->bridge"
>>>> structure.
>>>>
>>>> Also, which kernel version are you using? Because from above third
>>>> trace it looks like that dw_pcie_host_deinit() calls first
>>>> pci_remove_root_bus() function and then (from first strace) it also
>>>> calls pci_bus_release_domain_nr() function.
>>>
>>>
>>> I have definitely seen this with v6.2. I was doing some more testing and
>>>   now it appears that the issue is somewhat intermittent. So now I am no
>>> longer confident that reverting this change does fix it. The backtrace
>>> made it seem like this is a likely candidate, but I need to do more
>>> testing.
>>
>>
>> OK, so I have done some more testing. I found that if I build the Tegra194
>> PCIe driver into the kernel, then I can reproduce the above 100%. I guess by
>> loading early there is more chance of a probe deferral. With that I verified
>> that the issue is seen on v6.2 (as I previously observed) and on v6.3-rc3.
>> Reverting this commit on top of v6.3-rc3 fixes this and I no longer see the
>> problem.
>>
>> Let me know if you have any thoughts on how to fix this.
> 
> Sorry, but I'm not going to investigate another issue in this area.
> I spent too much time in debugging issues, prepared fixes and the only
> result was simple silence, rejection and proposal to resend emails.
> The only thing which I receive are bug reports from the users and I
> really do not want to repeat reply, hey patch for this was sent to
> mailing list... So I do not see reason why I should look at this issue
> as with high probability result would be same... for which I'm not
> interested.


OK, so I guess we should revert this then?

Cheers
Jon

-- 
nvpublic
