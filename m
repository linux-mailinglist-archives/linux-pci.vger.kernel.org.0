Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727B6008E2
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJQIlG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 04:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiJQIlE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 04:41:04 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::60b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA762AC57;
        Mon, 17 Oct 2022 01:41:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1Q39AuZiwj8Vzj3ua44E73UMyARECBalLWf2n1X1lS6WgKDxnRF6zZTUAF98WEV6/LhSiwAh6jMgyVpR9chvXJJFbR4vcvpqFoUYZRBDWfzqyvQBTRIGYoRMOYpWvQebyPe9URT5jGkb7bP1mIrzC/y/WRjOmMJtTGyhhKC2m3wVsEXLAIbVEa1R8E/DBtra5Bs0PSXAmU+AWxS2HYQ6+uuQgQ+RezLoLq3axpiROKmBjR0iXyCDm+EXxF7VfS273O9RC2parVr/I5zOmQ4y5vX9vWXCn8Mofw7pmwQHFJxeDJCHYVIL06tdVhzUXxjvmZdc78ECCVy4L5A2V7mGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv8+sT8PlgiS0DW75BHidnhBW5DMEVkxi9p2F3KRqPE=;
 b=P5C3rqOcCZphcR3f3uN9QE/cOBz3rLk+vkQ7kS2qD9dko6gi38BXoW7JXyFvshepCRnfZNbS3vrriJGqkZB5wDd4/lc4hAdSsKLfyjvmUR0//G21EvJLH+K+hWR6TAJ1QmNGfPKuxzp8YD2/4OISPTOxZmS63Z3+csBhy1GPXs3yw4MCAhrv1iVvnpJ8N2fWs+mh/hkCRyJPi/h/+I02O3OZVyB+eT2fU3lLU4HS1sbfzf25m38DuzwG3/HxLD5ZKQEpVPBAZIyz/Bs5dOBNpVgytFWgRZEqR8MnYFoDL+uUXrtih0ywZyurkBBLcAhIw0MBlCnTdLBayu7AE8FM7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv8+sT8PlgiS0DW75BHidnhBW5DMEVkxi9p2F3KRqPE=;
 b=HqHWLQ0fzBbtqjczVMnVTMMxtIlR+xpC4UPE/KThP3zKht6x9S09Spy4Z94iYvsg5/RNEDyfohncFUbID3JPZfCLbjPuqTC7xrhekZP+qvr/PubSJs1rjo58P9WZhObmv12H90slyNNrFNUwRHf/X78EXAJiLQlr3rgmpjDwGCT1PCGEdBr6yNGeF8ol22q5fCHe0xIiNEIeTvKeaKcCoLXU2GV3doEGztJl6191jAtsXkyxQwXeengPNie7NK8VDHrJqW5NYtnTXIjhW6IC8E1rXGTDfYC2H78NigAuYXsdI2qNvjshEOAP8ntMCCxiqiRYcdZD8jQVpZz4MmIh0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MW4PR12MB7167.namprd12.prod.outlook.com (2603:10b6:303:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.20; Mon, 17 Oct
 2022 08:41:01 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::c0e5:f111:3e59:7c66%5]) with mapi id 15.20.5723.033; Mon, 17 Oct 2022
 08:41:01 +0000
Message-ID: <0571554f-ee19-39ba-c0ce-bab544ebfde2@nvidia.com>
Date:   Mon, 17 Oct 2022 09:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro
Content-Language: en-US
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928121911.14994-1-pali@kernel.org>
 <220b0fe7-8b7b-cf9b-e28d-d9d81647fb80@nvidia.com>
 <20221011161638.ycxpg3ox2wv63vym@pali>
 <18a48407-9fd7-175d-0c7f-5702b077f13d@nvidia.com>
 <Y00HiWT+N6Fo9KVD@lpieralisi>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <Y00HiWT+N6Fo9KVD@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0217.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::6) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MW4PR12MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: 11e8580f-98f9-4411-22d3-08dab01b51bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /9mA1v/kKNTIQrlLiwvxyTVPYExtVujt1cDLaqZM0M/mdpEek4dbkld9qFllIp0t10geoBEPAP82A4Z3XJX4Oa2fvDagEk00SmTFz7jYtFjOsXR3PFD+dGYcMBXVyhjwynv1kNsr2W5G4r4hdQSoUoblemgy/KURyNLTyD7sYFBWxD1M2XxESYQCmnztfCd7b2IaABRnaBFH3kzpFzUOe0qmj4HzYRSxL2HILrVXC2SR90sHN1KyM9A/tfqNL9OLuOfs9OCvpBZL5O1zkrYsmw7r8pmhbJ/W+EzkTAguD7ZVi78De2dMwPxGZ8IBQTJcQnD1WNR+/3XMvuA47z/G046MSqGpCpattvO2r5dn6GofFILMxTiMqxSFKeAtZWhsM28KH6MCSrBmcZpU11kHmrhYJ4C2Q3jvONKGtd6WKp0YfA34H98gk2pWWyn3zQxb/4bXhdejGmxBcKIT+j7eHfRJV4qZkevUixdC91NCTse9jw+JmBEbuX9mLmBAea8yYj8jBupLyORJrBIqEdgTl23FUMAZh8JtkZ3o0FFtCoYxBBgEoz7FqgpXCfmaIsOcNv8VpSJHWomei/FmRJHGo6dNCvDm40WCUvxLYuiLCV6t5HZ3VYgNbOL5zntpK1fquayF8gx8Lg1TBLi7nlsjAsrnh576uQl/sSxf5KH5re1OhQiZC/yZjWKLlEMjfdbrnR0UD2VEoYPIQ7oPfruEbNygF0ud1SVUDoU18kqeDDurpQUUxAeRmzimly3lN9scQTHiMTgwPQhpbB7d2laRkp3t7nlHCZrdc/outX8wzuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(136003)(39860400002)(396003)(346002)(451199015)(8936002)(31686004)(2906002)(38100700002)(5660300002)(66556008)(83380400001)(2616005)(6666004)(186003)(66476007)(36756003)(86362001)(4326008)(8676002)(41300700001)(316002)(478600001)(6512007)(66574015)(53546011)(31696002)(6506007)(66946007)(6486002)(54906003)(6916009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MFQrV3k3SFgwRUh2em8zY0hSWHJGbklHdHpYQ2NGUkJvbUZNenRoZFUzUnNm?=
 =?utf-8?B?cEpucnpKSnZTVW1xbWd4SGMycE0vbjNYSVM3bDlobDM1aU90WFBCZDl5OWdD?=
 =?utf-8?B?elVYYkxOMytvaHBuZnRBaFNmNjN2OGliVTNXYjR5eHJnWE1MWGlNYUdDNitm?=
 =?utf-8?B?VllRUXV5VktaYkVjQy81NUV3QW5oYmo2SXk1VjAxL1NDbEwzTXAveXpMa3FQ?=
 =?utf-8?B?ME5rdjNzbTNsRUJiODdsdmN5TnF5bkxkTTZvb0pBTDhVOWM0aHlHNXl6OXU5?=
 =?utf-8?B?alpsTU1CRUErM1Q3cTI1TXdkNlJZY1FrRHg0dGpGeHpzajVhODJNZldLSlIw?=
 =?utf-8?B?TXh3R29JcFFvYUFFQ1dVQXBydk9RWVZWa1BXOWJOdW95VGNXVlJ2N1FteXdD?=
 =?utf-8?B?citxYndYYTFUTG9BbmRJWkJrQUM5NDNDVnFGY0NjQjZ4STJvV3Avdk4yMmg3?=
 =?utf-8?B?ZHJoUk81bjdNZnEwYjFVWW1PbHBDaEVjWUJZd0Z5WDFXanVDMUZGRlJQWkNN?=
 =?utf-8?B?SXZZL3I1bnZvL1NhMzF1d1p3WDMwKzFUaVZDV01wTE5vTk9TV05TZEhkUzFS?=
 =?utf-8?B?RGVTWTJneW9HaWVCamRWeC9XOUhlQWgyak10bEhKblhHRTZTM0hCOVpCMWRY?=
 =?utf-8?B?ODJlZjR2ZmFULzduZDZXak1VeWljRjBTMDVJRWVxU1FsUlhHenloKzl2Qzht?=
 =?utf-8?B?aWF4Q3JHdHRQSXphclljU3RLbEo5bHRsNjMzSE93aWwxTGZsVmhOVnYyNCtK?=
 =?utf-8?B?bWFjSG03TmpiNUZlbWNEbjlZZ3l4b3VTV2FzKzVNQ2Z0d3l0YWtZNGdiQ3RE?=
 =?utf-8?B?U0hyZVZZVnVtcXVzNHp2d2FMRkszUUYvMkdJWnlJWWl6NGNNTFVsZWp2aU4r?=
 =?utf-8?B?cktsbzkwd0pvOGVDaHRjTnJqY1dJaFZ3R1Z5Z3ExZWNTSzR4Y2J2ZlkxNUpK?=
 =?utf-8?B?ZHlYdTRsNm0wT250d3E3eklKRU5MVHEyb3hrOGFUTlNENVBpT1lKVUV4VDVV?=
 =?utf-8?B?SmhuZklEMHpsNHhxQkdnbGZBU3k4aW5FVjBPMDBpdnp1akJxU254SHRjanJj?=
 =?utf-8?B?eEx0elB5WnpteHhSNTRIVDFJdHZXQ3d5aHJrakRONHR0VjA4aHBzSEd3YWN5?=
 =?utf-8?B?bEJlL1BmSWt2MllrYkFRSXVWdk5TanJMSEJIWXN6cStUcFYxUlc3Y2FaSmtM?=
 =?utf-8?B?YVYvdVViWDdYNDhqVWU5cExnS1dtZW05akcwUThFWkxEbkpaQUtaaEpYTldK?=
 =?utf-8?B?TVZvMExFeEpxTEhsQXFKenozaGMwd1BSVlptL3c0M3RvOTh5NEFhcGNsZG5v?=
 =?utf-8?B?ODFzR243cWhoa25zWnp1OGdzaW54WitNYlU2aDJabE1hSG9NQlU1UDNhbEJq?=
 =?utf-8?B?NDNYWXlGaldlaW1jb1I4VmlQcTFwY3EwRDNTL0ZUTFp4UE45bWhMMFFJT0V1?=
 =?utf-8?B?TzU1dnFuZ1d3WUZydklRUkpsMGJUYmpQZFJueWJ3YWtrWWk2bXBWYTlQbTNJ?=
 =?utf-8?B?YUpIMkYvRzJSeFNPOUlodUg1NGV3S29RMmFzVXBRNHY3VmNlYmZKaDc2MkFI?=
 =?utf-8?B?OEtnZmZ5YUdnSmZUR0tQd3Zac2lwaFBIVmZyU0Q4SksxYjgrQUdxRDhRM2ZQ?=
 =?utf-8?B?SVdmMXlTYTNuZXV5SVpldS9KVEFkUTFiOVhSb2VFR0FkRGRYL0Y5NTVWQm54?=
 =?utf-8?B?WmpyRDdKNS9TMVRScnhqYWY0VVVIcHRENWt4Rzl3elg3WnY2NkRKVmY0YXps?=
 =?utf-8?B?NDUxNU9YR1BqTUFmSGoreUlTWDdSdkptYzBnUTFKcmg3cDJpT1poZjh2djRn?=
 =?utf-8?B?cDROT1QxRHpxYWNOY2l0ZHBhaTFxenhPZFZvdEZwOUY3bHNLS1ZGYk5SSkVy?=
 =?utf-8?B?RlU3Ukwrb0N2L0VVTFQ0aVRsdFdaakl0M1l4SldKQkx6WkU4WkoxL1NtUXNM?=
 =?utf-8?B?YnIxUGFFN21KZGhONTR5dC85bjgzTjZEYnZobUVMWjdiQ3NldnhTZG45UVBZ?=
 =?utf-8?B?TjROWFVNTjlGOUF0THd2U3ZaLzkxc252Y1crczdzZTl0aHU5d294NkNvRndX?=
 =?utf-8?B?b0ZQZ2lIMVB5NjhOa25OL3FIYnhsSkh5dTFoRzBMTUErVy9yYTVqZkFZNFNn?=
 =?utf-8?B?OENrRXR5ajhWSkRZNTQ5RWYyaWNKV1Fua2pkZURwWFYxaDZUNXlUZ2tXck16?=
 =?utf-8?Q?87NGhB7BZtywu3RS5LWBStO3aBYyelj6gUgMfwOKoCms?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e8580f-98f9-4411-22d3-08dab01b51bf
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 08:41:01.1088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgFsrTo7OoQVwEIAo1dRgCcZ5FnqqamNBkTjqRSr9EOJPy2W1GKU+szI3SI9dBCGSg1rnAu8PvwK1mSsI+p/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7167
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 17/10/2022 08:43, Lorenzo Pieralisi wrote:
> On Tue, Oct 11, 2022 at 05:47:50PM +0100, Jon Hunter wrote:
>>
>> On 11/10/2022 17:16, Pali Rohár wrote:
>>
>> ...
>>
>>> I see, this is stupid mistake. PCIe config read and write operations
>>> needs to be 4-byte aligned, so normally it is done by calculating 4-byte
>>> aligned base address and then using appropriate cpu load/store
>>> instruction to access just defined size/offset of 4-byte config space
>>> register.
>>>
>>> pci-tegra.c is using common helper functions pci_generic_config_read()
>>> and pci_generic_config_write(), which expects final address with offset,
>>> and not 4-byte aligned address.
>>>
>>> I'm not sure what should be the proper fix, but for me it looks like
>>> that pci_generic_config_read() and pci_generic_config_write() could be
>>> adjusted to handle it.
>>>
>>> In any case, above patch is a regressions and I see there two options
>>> for now:
>>>
>>> 1) Reverting that patch
>>>
>>> 2) Adding "offset |= where & 0x3;" after the PCI_CONF1_EXT_ADDRESS()
>>>      macro to set also lower 2 bits of accessed register.
>>>
>>> Jon, Lorenzo, what do you think? Could you test if 2) is working fine?
>>
>>
>> I tested 'offset |= where & 0xff' which is essentially the same as the above
>> and that is working and so I am sure that the above works too. However, I do
>> wonder if reverting is simpler because we already have a '&
>> ~PCI_CONF1_ENABLE' and now adding '| where & 0x3' seems to diminish the
>> value of this change.
> 
> Hi Jon,
> 
> it is unfortunate but I think we should proceed with a revert, please
> send it and I shall ask Bjorn to send it for one of the upcoming -rcX.

I have sent a revert for this change.

Thanks
Jon

-- 
nvpublic
