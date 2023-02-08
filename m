Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0234D68EEC5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Feb 2023 13:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjBHMTg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 07:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBHMTf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 07:19:35 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281749574;
        Wed,  8 Feb 2023 04:19:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPamrlrdhyZDHAxJ7gDoieHPpA7QYG84DVKTKAq3A2d0bzMQ22LbsgQmfREHu3n0tC93FTxvwxmiNHhBzNACu0SFZukoHzS+J2Lfy4ZJ6qfYo95fUFvOThXrcV327+/DjCwh+c2P3v/acsz7ETB+JxoN3rh9ZlA3dgsgJOJnoa7y557+EEFTgj1p6+CvxPvq4MQp7+RMTFtP0xJzazAhM7/NaX6sAtkdAofjFNO/LjeSn6iGI8g/vyomNQutGUNq4vcemEYZIk4NRRYCojQN/Mzm1Moaj73Gug1PpKknPSMYxp6CmdCTGqkrBguuhW7DAwyvE2eIUnyBfzz0G50yNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wjy8Mf00EaOCYZaZzDaYkUTUGROKbzf8UjdC2c64XY=;
 b=XP7jiqZSadmSSDCwUntjBz3rxeBLPEa/6eUDh4Iytjo7cidQt9j0MxtNpUZaJWR1aoRv5SAUDdvYWsAmKVFmR/wOvim7RepyorucqMNH0OFV18eJDHlwEXJ02ORHT84WMdeKBKDLx94gwbaGSqAojgtW4ztOgYHXU0DgIE1N80VnMjutbWUxf2DlJWKqxfaWIMOfiGxZK9O0gVsDqTiKEtXGyNsE/ERFfUxz8Uq4Y+1uQ3OVPtyi5T7ZSEC3gFMUmtmY3CtsdI7IMN9g1t7W62hunACvhQh12G1UPxYmcsImXZV53BOTkHYuakMXB0y1aagXogmDvQeg8yRgC5/VpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wjy8Mf00EaOCYZaZzDaYkUTUGROKbzf8UjdC2c64XY=;
 b=lFMYSVzlzlslzzaDr16G4t9mXi+ame3PGkqc/DiaG9oC/HhuOTZkM/q+ItcyCcRhmOWaANxOgWwhf9hsimMZ/D8DFbBaeTjtcexe7tgtggR4eHAPL/JaxuT26/WroSWzRCQ2dvtWmuTUWW0BfwIZDqPCDKa3B7amGe0WjWKVXVBbIkoW8PuPmSSMNiWoaGHaw9CBBV8GiwvErjsUcGoU9hKgE6M7rQYmELqfiH3L5Zs8NHSXxwXrzm6EV0WwQv4F6pQZsHKUIKQp7RlwYqPf/WuJ75gqwnaon02jKyVKN7z5nY8Nt0Tm4dv/Tk6DPKYOqbgOiiBTHVHmJVGjmwFQvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3356.namprd12.prod.outlook.com (2603:10b6:5:38::11) by
 MN0PR12MB5764.namprd12.prod.outlook.com (2603:10b6:208:377::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6064.32; Wed, 8 Feb 2023 12:19:25 +0000
Received: from DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d]) by DM6PR12MB3356.namprd12.prod.outlook.com
 ([fe80::2654:3212:6fa4:ec1d%6]) with mapi id 15.20.6043.028; Wed, 8 Feb 2023
 12:19:25 +0000
Message-ID: <da5b6b73-3243-d492-4b82-77411e4676d9@nvidia.com>
Date:   Wed, 8 Feb 2023 17:49:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC,v14 3/5] PCI / PM: Add support for the PCIe WAKE# signal for
 OF
Content-Language: en-US
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     bhelgaas@google.com, petlozup@nvidia.com,
        rafael.j.wysocki@intel.com, lpieralisi@kernel.org, robh@kernel.org,
        jeffy.chen@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        jonathanh@nvidia.com, dmitry.osipenko@collabora.com,
        viresh.kumar@linaro.org, gregkh@linuxfoundation.org,
        steven.price@arm.com, kw@linux.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        vidyas@nvidia.com
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
 <20230208111645.3863534-4-mmaddireddy@nvidia.com> <Y+OMoKOfduwj2PYp@orome>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
In-Reply-To: <Y+OMoKOfduwj2PYp@orome>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0043.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::14) To DM6PR12MB3356.namprd12.prod.outlook.com
 (2603:10b6:5:38::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3356:EE_|MN0PR12MB5764:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fd1227-b8b9-4029-fc49-08db09ceb79e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVi1rpBipmYpp8DOwNOpj+vMCCSnfWnkda05Fm99bxNuMoVsv7sGF4fVg3jICH/eMQON28LRkBv7qpZKQgU0Flzb5AYD46ovPT+Sj2Z6D75cuVyhZYfbSacTNpa6WE+xF94FFYjUWOZp97dsFnIwfVPXvMdBHfxSnxk58mTrvvYGvK+VYysj0yLgYa3mLcLVYeCEuDbWTV/hKcpzyaJIIzmHwCWQ1BQKJVeQXt/EL1Dd3AFGu2f1Q6hVhTxvARYxYzIT+EF8VgMq8usLgpnOG5mz3IgbmNmMYwWJs2FnLCrmZokWWUBONYbrOar9tjpF5qwmqFYwhAq7/MEm8LKesIkWGefCoB1CoWSzmsUG1FykqG2Lyq08SfYlygoDDsgAcGkbYV2/CqV7Y+qgeADWgjWXWXACmiJOxYn8QNzFM5exQ1aquCnfvzUIZRJL5iq7zjta3R9enLmt/9PjeHyof80+nGJXlUya7cKcCz4q2RYTOFN9we3Joi9oZ4ULFzN1n94hoFmlOvppyDLocldOTdFYTMKJg5SMSShgwn2Jk8twKoKroAFv/bRcYNF/dQlnREiL0FJ8Wbbgwa+Wva3kqUE0QuhlSWL9KJ44uY2/0FYA0TOldTwMjvD7WfRCCH5nyim1xiO0HT3K0NAY1XvwvXyshWGcn3JJnonucePvWvYqWGjXwtv+9Gb+DeuJaGUVJ4+nynz+V4pJYGV0voOmxOZytVedWnLAzTRqQCzSklc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3356.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199018)(5660300002)(7416002)(53546011)(6506007)(26005)(6512007)(186003)(38100700002)(6666004)(83380400001)(107886003)(2616005)(4326008)(8676002)(316002)(66476007)(66556008)(66946007)(31696002)(6916009)(86362001)(8936002)(36756003)(41300700001)(478600001)(6486002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FoVzJ2cmdUZHZ0V2h0MnRmNnpqVzZsdkMwZVVjQ3R1dUhXQlZwbmIxUGZy?=
 =?utf-8?B?cGE4a1JFeFg5WW5ISWlsQ2xDNTh2M3JyYkNNckw3KzdqdTdlOVNOallFdTlN?=
 =?utf-8?B?VDRxTENhUk9ZbGtFMHBBYlMySTdyODNxNDhNdDBCblVQbXo3d3BYTnpvS2oy?=
 =?utf-8?B?ZGZUSVUvK21CSk5keDhuWDZpZVZ6M3dKbktzcXh1clM0QXY1amszbGJvS0VU?=
 =?utf-8?B?alJPUi9PNWV6QjJ2RmdjZmxFUmtId1lDTHJCVXF0ZXNTdkRwdU9kWWUrbW9h?=
 =?utf-8?B?d2t6d0lBN2V5UHNOeExKTnZZejdvcWNZZmVXczYzLy9hYjdXODJFY0hYTG5w?=
 =?utf-8?B?cVY1NDJMQ1lCdnIyOWlIekI1KzhiUEttbUpsQ1BGMTcvaTNac0dEc0UyaTZV?=
 =?utf-8?B?Q244M0RWM1dCYkF0djBEenk5RU5MbTRmMkw0eHNHcWhySWVmbEc5L0EwV2o3?=
 =?utf-8?B?V1pzUjVhczlRNkwrRDJxcHhtWlA3U1RWWGh5T29qY2pTenBXNW1NTWlKZUFX?=
 =?utf-8?B?ZVpwVHpiNzRhcU82aHNIWXNRV1Y1azVUL2tHOVVNSnI2T2ZDZFVuaDdtQ3F1?=
 =?utf-8?B?MXVDZkxvc2NnRGkydiswVTNXMUFhUHpLK0N5NU5Ra0hkMU8vem5MV2J0R3Bi?=
 =?utf-8?B?MUNqN1c1NWR6a0pSV1BjQU5PcGtzTnNhbG0zaGlLTHYxQ1JtV1FqLzdCUCtB?=
 =?utf-8?B?dDcwN1hnOFBuRUc1OEF4ZGxrTS80dkJLLzBjT0JhYW1mTzBtOEM4cHF6VktT?=
 =?utf-8?B?QXFHWDlxc1doUktJTFpoeU9VZ1RCQkZENW9NUWs5cUR3eFlPOTRYb09BUkd2?=
 =?utf-8?B?b01wblErcXV2SW5WQmFSblh5U1MwNnIyYlFXUHZ6Ym9sVUdtcUZtY2x4OER2?=
 =?utf-8?B?SFY5Q1V0UzVya3JnL0l0UitVYzdzMXJRZjNTaHd4Y0UzbElFVDNtK1lWcWJm?=
 =?utf-8?B?a0F0T1FzQ1NvanZZZW14dUFYZHYzWllacEFQUFRvbkxjTTNqeFdzVkRJWUpq?=
 =?utf-8?B?eXBEWEZKOUhFbm1wVkd6SjFSeDd2RVJVZU9TVlREMmEzVWNQZlo5Vk9vMXZE?=
 =?utf-8?B?ZUt4UHIyb280b09nQjdWZ0pjV254Qk9NWjlBcE9pZFlHd28rU1JiVWdCVmJv?=
 =?utf-8?B?Q3Z0VmVtQkRoeTB0Q1UwenNSTlNvclVqbEdKbWVNMG1hT0w3TW9XSlFrcVhy?=
 =?utf-8?B?dVVna0FuSnBDUnZYb2w2QklLRTh1b2hnMjh2eCtQbjJzZXkxcGd4UWM4YVB0?=
 =?utf-8?B?b3U1SW9RS1EvaHc5MnB1R2dNQjZnT2dIcjU1TXc4Z0N5czJoWmN4MldoNHIx?=
 =?utf-8?B?dnhmc0Z0ZjFmRWZLRUl4cFRwcnNNTTNYVU9jSVdnOE9qa0o0VU5Hdm1uQzIw?=
 =?utf-8?B?anlaT1lud2MwbElTVnJyRHRYUjhHNWxSRTNmVDY5bkVFNjRmU2FmQ05ROU4z?=
 =?utf-8?B?cFgwMDd4WmRBZnVOSFduRHhrSW5FK051YUswZlN5SHVzYnZQeERtT2xMU01U?=
 =?utf-8?B?ZGlTK1dWQTdlU3pXMXNCMkwybXRxWXV1Zkd1QzZwNTFuT2VFTlZqYVFsODVP?=
 =?utf-8?B?YjNOOHVlL3ZjenpoWE1hWUZXRFNPREFEU0lxOWJObWQzdllEc1hFZVU3cUp4?=
 =?utf-8?B?eHNLZ1FJZWpZL1JlamxBSmppZFozd0tBNEVBaDY0eEt2N3NjUm1lejI4cWlJ?=
 =?utf-8?B?ZGNZYlJJUGxBMTVKRjRqTFlaaHJYeW1Ub0x2RmpabzR1RFZUaVVreUVUOFRa?=
 =?utf-8?B?Wm1ES3RLY0pLTzZudDVyd005YUhBRXRkTVlqS3UyRU42TkVxajQ3UStwQ3VM?=
 =?utf-8?B?MGpVU29QbHQ2b2pkSmZlN1BxUC9XRjhKdnpxZ1pOcXBqSHBxTnNVWStOY0FZ?=
 =?utf-8?B?WElEbTZqbHBkV2k4MENPejRMSy8vWjFGMTZ5VnRISHRHSzNBUW00UGtYdzl0?=
 =?utf-8?B?MWRJZ0w4M05aNnhyODRENU1iSDAxdSsvY3AzdEMvUWVwRnlINkdCdjBLcTlm?=
 =?utf-8?B?NkRzOUtIRmJHdEM4TXpESTQyWW1vL0JFbWtOdWY0a1ViY1hCcFNkZkMvem9K?=
 =?utf-8?B?T2I0VHc5S1pjWFc4Tzc0Y2c3VWxGbzdzTENkWDZmaVZiQllZRlY0ekhrOUw0?=
 =?utf-8?B?R2x3dy9CYnZzdUNDRVdUNjFiYWxaTS9tRVliakhKN2dmdFRobWUwc2wzdHo3?=
 =?utf-8?B?anc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fd1227-b8b9-4029-fc49-08db09ceb79e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3356.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 12:19:25.5213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHGMd9chsZsKVv9JDscZGFVPj3J+EwvcaDzbI4jBFZxDGeskaIrZzJAAaRncbpB7UaWuMUoNMCV+4BuQAii2gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5764
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2/8/2023 5:20 PM, Thierry Reding wrote:
> On Wed, Feb 08, 2023 at 04:46:43PM +0530, Manikanta Maddireddy wrote:
>> From: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> Add of_pci_setup_wake_irq() to parse the PCIe WAKE# interrupt from the
>> device tree and set the wake irq. Add of_pci_teardown_wake_irq() to clear
>> the wake irq.
>>
>> Call of_pci_setup_wake_irq() in pci_device_probe() to setup PCIe WAKE#
>> interrupt during PCIe Endpoint enumeration.
>>
>> Enable or disable PCIe WAKE# interrupt in platform_pci_set_wakeup().
>>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>>
>> Changes in v14:
>> pci_platform_pm_ops structure is removed in latest kernel, so dropped
>> pci-of driver. Instead, enable wake in platform_pci_set_wakeup().
>>
>> Changes in v13:
>> Fix compiler error reported by kbuild test robot <fengguang.wu@intel.com>
>>
>> Changes in v12:
>> Enable the wake irq in noirq stage to avoid possible irq storm.
>>
>> Changes in v11:
>> Only support 1-per-device PCIe WAKE# pin as suggested.
>>
>> Changes in v10:
>> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
>> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
>>
>> Changes in v9:
>> Fix check error in .cleanup().
>> Move dedicated wakeirq setup to setup() callback and use
>> device_set_wakeup_enable() to enable/disable.
>>
>> Changes in v8:
>> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
>>
>> Changes in v7:
>> Move PCIE_WAKE handling into pci core.
>>
>> Changes in v6:
>> Fix device_init_wake error handling, and add some comments.
>>
>> Changes in v5:
>> Rebase.
>>
>> Changes in v3:
>> Fix error handling.
>>
>> Changes in v2:
>> Use dev_pm_set_dedicated_wake_irq.
>>
>>   drivers/pci/of.c         | 49 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci-driver.c | 10 ++++++++
>>   drivers/pci/pci.c        |  7 ++++++
>>   drivers/pci/pci.h        |  8 +++++++
>>   4 files changed, 74 insertions(+)
>>
>> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
>> index ff897c40ed71..1c348e63f175 100644
>> --- a/drivers/pci/of.c
>> +++ b/drivers/pci/of.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/of_irq.h>
>>   #include <linux/of_address.h>
>>   #include <linux/of_pci.h>
>> +#include <linux/pm_wakeirq.h>
>>   #include "pci.h"
>>   
>>   #ifdef CONFIG_PCI
>> @@ -705,3 +706,51 @@ u32 of_pci_get_slot_power_limit(struct device_node *node,
>>   	return slot_power_limit_mw;
>>   }
>>   EXPORT_SYMBOL_GPL(of_pci_get_slot_power_limit);
>> +
>> +int of_pci_setup_wake_irq(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *ppdev;
> Perhaps "parent" since that's what it is referring to? ppdev is a bit
> vague.
ppdev is already used in of_irq_parse_pci(), I think it mean parent pci_dev.
I see that parent is mostly used for pci_bus parent. Let me know if it 
is fine
to leave it as ppdev or need to rename it.
>
>> +	struct device_node *dn;
>> +	int ret, irq;
>> +
>> +	/* Get the pci_dev of our parent. Hopefully it's a port. */
>> +	ppdev = pdev->bus->self;
>> +	/* Nope, it's a host bridge. */
>> +	if (!ppdev)
>> +		return 0;
>> +
>> +	dn = pci_device_to_OF_node(ppdev);
>> +	if (!dn)
>> +		return 0;
>> +
>> +	irq = of_irq_get_byname(dn, "wakeup");
>> +	if (irq == -EPROBE_DEFER) {
>> +		return irq;
>> +	} else if (irq < 0) {
>> +		/* Ignore other errors, since a missing wakeup is non-fatal. */
>> +		dev_info(&pdev->dev, "cannot get wakeup interrupt: %d\n", irq);
> dev_dbg() maybe? As it is this would add an annoying info message for
> basically every PCI controller on every DT-based board out there.
>
> Thierry
Ack. I will wait for few days for other review this series before 
sending new patch set.

Manikanta
