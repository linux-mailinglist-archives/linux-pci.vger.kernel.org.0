Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDBD7571CC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 04:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjGRCeF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jul 2023 22:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGRCeE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jul 2023 22:34:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F6418B;
        Mon, 17 Jul 2023 19:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeCTGtwPQ5qSOvnCsZKvbCofUs9nbY+r7pIeMpsAEKiA0xEEuNxTypgpbmDzbEPqcvX4nOdevvQ6pBLfpzxs8KXMwfm138iTZwX4+t0inqsDTb7l5FWGx0QHiAsm9O1Lpm9Ku9OAM5pm2KZZPAM4vnaEL6X9H38NPWyv6Z8M7rp8Q5+k6OMgTGhGZzRzLVCbXzHfB+Vj+P/PA8wuRzVvXYkztF2bqwS2TSChdUJNnaY40ULsuSxgMHzGPtdKPNqG7QihJe+tijD2k1ifQz+7FR7n+mwVmVj1cEpur9HqyiXHRfaEqz/tSw4jWrLaf5ZzO+eDkiOpO4u78G2/gk/qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMwUcuT+ulU0fn2k12k1X+0tasuzCipXBydt3kRH2VM=;
 b=LK5D0foUcIB5PKTYeDTIMzbiC3XInK8u4qlJ7BkwsVnq+oQLhy5wSHi6Wfp2iSVsXhzYY86GG3J/hlHLjbrS/VutLf77D0d1H2Eq+Ztyrgo3aEmozkhagAiY5NlIiE3qAhFNdFUTlCaWMAbs5BFlaDyNE/zj8Suq1aQZZwQp2Wlj1EpwFrjftsGjQwFWkk+uVPu15/xeiL29m6cyPy6Yd+6aQyk9u8pWSatBSIWt+IiqzQHYI2sy0TSP0fDp4yAYI/PFBF99BZDcUVrmCRtNPZ6H7XITeQnm7O+iLHqzHP85D9vu6FFa4bwEEZvUjPU0GmmkK2AfOghRDEJKxUKLHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMwUcuT+ulU0fn2k12k1X+0tasuzCipXBydt3kRH2VM=;
 b=pVnVPjiU632CoZ/xmXj0CzwxzvYH6mm5ItyX04hnZvQ21jZiloGrAMvcR6ST0kNJquJZhIaBWcyQ+Z6oHGrbxE+Rtdfck3SbCn/c9A3q4NhL5s61yZtPEHpiTWDBOdfNVu/i9Pr4aS6suRL7H8cHQW1ZvHRBxKnoUugJ+D7t8dmlX0XA+qvF9KkWCaDPAKAqhCBuJ28Fw97EDZW79+zmAmtvQz+1rZ50RBjs9MFJodyF7uESf+osVsyD9NswDV9Q0Ge4RVgd1x1N9mHTEHksoxc5cc4ilsLLAFUEpkcOt7JRhiTyfdr6htZbwd6urSCSJ8lULhs5ySJXlksvgdbfkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by SA0PR12MB4414.namprd12.prod.outlook.com (2603:10b6:806:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 02:34:00 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::b1:f0a0:1b20:1bf5%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 02:34:00 +0000
Message-ID: <6bc71b88-1c8c-0c2c-d9e1-22096f928ad5@nvidia.com>
Date:   Tue, 18 Jul 2023 08:03:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20230713213953.GA331829@bhelgaas>
Content-Language: en-US
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <20230713213953.GA331829@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::18) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|SA0PR12MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: bf3175b4-9c64-4068-3358-08db8737715d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKrz7ekFsDt4/opHotD5S8KPQ2gLtVsTYkN5E9K+vNZfYcQGApEvYclNmpVOMz7Q0F/+hg1udF3GFoQYjkyMuJ3AzXK8WoVazghkxBz23dNKa9Jg+hLJy589tm6B3VcZi5IqtS/ag7/WsmT8bl0j09gCuQmZRLgWyx28coBccBId/b7U4MP98+dOFDcI81489qVrS/foRkr58KCBtEVbZBTTeUpLmDV+Gs1ZCXPeJiyciORUUKZ7KFgpInRvKCuW9vuflF3UzT9AcMH0Q7DkWoCtXUtyvIM+86WECvGU/z5TbGuUK/aVsxOIQTKiowuhpNR4QYNt5I01LuwQuhyEi4ANmZfPHX8+pLBZpNAsYMB+m4XRLLWkSVqrOZB4C1d2/9DLUamHGRplC0zPSfvgW/W96kbs6gYVyYQ4vPN/6iiP7tU3MIPcHLC9ZgCz5Hc5Xz+CgJ7K5uYRdwJ5aOaxWk+h3wUkJWzyDize+ahStHhmljvar67R8hydr375hOEHsgaWf0bRcFmsFiJ9TB16gQ9MbiYHYiFe0Cf3zZ5sCYQKiIl2WocSQAyTvSl4lTDIbD1cxZbA2GJKccgq3Cc9vyPiBGNTS0oNJ89EgfvWwJgVZSyDpmbAgVC/d+GHXizMY1pCZrn7RqeGXgZFLL1Rlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(478600001)(6486002)(6666004)(186003)(6506007)(53546011)(26005)(6512007)(36756003)(2906002)(5660300002)(4326008)(41300700001)(66476007)(66946007)(6916009)(7416002)(316002)(8936002)(8676002)(66556008)(38100700002)(86362001)(31696002)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekdtRkwrai91b3NPVlBHMVJTdzZyUVFRclNGRkY5aGk3N0RRQWRlaElTSEh3?=
 =?utf-8?B?VU1waDZHbUJFbjI2RzFDcDd5NEZqSEFGbVRhVysxZXVHNkUxQXJKOTdheU1T?=
 =?utf-8?B?c0pBNnZlbzBBV1YwV0R4T1lLMzBKWHl6d3crTWM4QW5jRlI5M25mc0NPNzZi?=
 =?utf-8?B?dXp6V0lST1BsQ202anhRYnhYamt1bmI3cS81L0huVDBYKzJDZWgzZ2ErMmht?=
 =?utf-8?B?WDBQU0RTTFgxSlFFWXd4S2grUjdTbW4wUE02MUpvMElkdmlNc200NHlFV2pw?=
 =?utf-8?B?dE9EVGFJMlZNTHVaanhieEFLTTdqblBlaitJZXYrSE9zOUg2WnJ4TFFRUkha?=
 =?utf-8?B?bHRtT3JaN0d2YVp6TXJyVmVWcVVtZjFqMmQ4cnZGeEI4TG9hcEJiZTBGd21Q?=
 =?utf-8?B?UUNHYWFJODZ6YU1zTGcvaGpjcnhGZE94SFp2dHBKMVI3UUV3L1JFNzNCTUlB?=
 =?utf-8?B?eUxjcmNyS3ZMZGRlLzNBa295T09lZnpoZ1RadExrVXIyNWtjSDhSNnU1Zm5p?=
 =?utf-8?B?dzVpTnNLVC9Mdzh3K2xpcG9ud3hJczlmaFZxTmd2Uk1ONlY0eVFkSXNoQUU2?=
 =?utf-8?B?dlh6U2VsUDY5bUk5RzhBb09ubzljQjBIU0VWdDZWVWwyTzg0TG1FMUJsQkto?=
 =?utf-8?B?dzBUck4xR1hDUUZYSG0vWjI3RnNVMmx0QmViN0pJcUorKzdXdnFyTXFLSHV4?=
 =?utf-8?B?S2s5SnNYUE83NDBoUHZNU2tHWjh5cXNpVWs1K0Q1RXQ4SVp2dFFQMmZ1TWxt?=
 =?utf-8?B?TkxEd3BRUk5KdEtlU3hNV1l1dXlJOGo5clFCdXpmUm1ETlBxYjlIVEpLQjNH?=
 =?utf-8?B?OTdmK3JSbE91aW1YdmN4QUhQR1d0cURVTVpIenJ6VXhpM3dMejg3S2F2MmNn?=
 =?utf-8?B?eFFONnZTa0E1UTZsempjb0dGenZHY2xXcytxK01CSHdRY2M5OHhwaHRoM3Nu?=
 =?utf-8?B?YXN0ZnF5Q2M5R3lrTVRKK1J5ek81YUsrY0U4UlYwOGdqdFZWZVRNSmZ4UVhm?=
 =?utf-8?B?VWxxWmtZVHdVb3NadS9WU3NkbHB6RVJEemk3ZWxJZXhmN3BiUGtnUXlZTERk?=
 =?utf-8?B?RG1TMU9pd0lwOXhlZms2RWNOYWZJU0dHRHphSnF0VG5JMlNzTmdpTk52NjlH?=
 =?utf-8?B?Z1VrRzJMSnBnQkJhdmdmeE5QZ2Nub1RGdWRwMU0wcHFFbTd6TUt5ZGZWWnRk?=
 =?utf-8?B?dW1zZmRkRkdOY3lKaXh4dG8xNHNKMjkydjcyODBQRUhEL2w1emJDSFdtWXRs?=
 =?utf-8?B?a3l4SzZuTS9sY241R1F0ZjViSzdsZnVmaEcwNjI4dU9RMTROVFprbldXenFr?=
 =?utf-8?B?VXZBWmVHM3RpRkU3OUdkS1M0VktjVmtadHpNR0pnWmVXNDNBemxMT282SXhJ?=
 =?utf-8?B?TmF1aGdqQVh5OEhYRjhydUpUN1R2ZzgvdFhsNnB6ZjliUFMrVm8xS3p5czl5?=
 =?utf-8?B?RzJBcHQ4cXRSTXRmMVMxVUdReHBaNXAyam1zT0dxS2pnMzVpYnhvYkFYeVM2?=
 =?utf-8?B?Q1BNa2JlNWpnZmVvWFNBZU5wK1U4b3cvU250aXhKS2Q0RWhMNEJ1ZllQU1VM?=
 =?utf-8?B?YWM2MlE4M3lyd1g1bHg0WGE2eFh1Z0wvOUZZYzRvQjdXdkhrY0hzY2Y2OTNv?=
 =?utf-8?B?NjZnMDRPc1Z1c0RCeThwOEFER3ZyU2plOTc1S09IZ1o3b0p1YkFCWS9TNFZP?=
 =?utf-8?B?STZVb0JyOTlvVjdYQTE4N3hwS1dlWFNJQTEzZ1gxRVp2eTRlRFB1MkZmNk9L?=
 =?utf-8?B?WkxrbkM2QmV6VlB4WUdSMHluWjdjMnpDVDF5UStyQnBtMzdpT1p2ZWlFbDdx?=
 =?utf-8?B?WVZWejd1VmtSUUFlb1lUYUtYRDJOTm5XaWVGUW1EYlBzWHdZakVweEMzZTZX?=
 =?utf-8?B?Vk5HSTFodC9nVUt0NFRJTFhYbGFZaklSb1JZeUJNRnA2ZGFBRTJhRW9EZUVa?=
 =?utf-8?B?ellYQlE4cTZTUzFUK3dnVG1uUldWekFDOTIwM0xHWndrSjNBTDVaN2dFc2dp?=
 =?utf-8?B?OWFWZ2ZPY2R2cms2SW5HVS9Tbmp0Z1IvOExsT0Y0YjRoUHhwUlFHZTBGZEkw?=
 =?utf-8?B?Vk5DY0ZJd0VlaGxUOVl3Y3dDenVDV3pUN2Q5M3lwL3RreWozQU9CM0N4eVRl?=
 =?utf-8?Q?JxmufjsP44InwS3teThygbYdJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf3175b4-9c64-4068-3358-08db8737715d
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 02:34:00.3648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5g9e5Bdx9rmxxtqK9Nciri+4J2CsiMkdNNeq8YOM5DnaOEB7O6WZJXUksJE/TEkxB2oEBA0XAkBqvLzySLSpng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4414
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/14/2023 3:09 AM, Bjorn Helgaas wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Jun 19, 2023 at 03:56:04PM +0530, Vidya Sagar wrote:
>> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
>> support for 256 Byte payload").
>>
>> Consider a PCIe hierarchy with a PCIe switch and a device connected
>> downstream of the switch that has support for MPS which is the minimum in
>> the hierarchy, and root port programmed with an MPS in its DevCtl register
>> that is greater than the minimum. In this scenario, the default bus
>> configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't configure the
>> MPS settings in the hierarchy correctly resulting in the device with
>> support for minimum MPS in the hierarchy receiving the TLPs of size more
>> than that. Although this can be addressed by appending "pci=pcie_bus_safe"
>> to the kernel command line, it doesn't seem to be a good idea to always
>> have this commandline argument even for the basic functionality to work.
> 
> I think this has some irrelevant detail (IIUC the problem should
> happen even without a switch) and could be more specific (I think the
> problem case is RP MPS=256, EP only supports MPS=128).
The issue is present only if there is a switch.

> 
>> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
>> Byte payload") avoids this requirement and ensures that the basic
>> functionality of the devices irrespective of the hierarchy and the MPS of
>> the devices in the hierarchy.
> 
> "Ensure" is a transitive verb, so "... ensures that the basic
> functionality ..." is missing whatever the object should be.
I think I missed to add 'work' in the end after 'hierarchy'. My bad.
> 
> Maybe something like the following?
> 
>    After 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
>    payload"), we set MPS=256 for tegra194 Root Ports.
> 
>    By default (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*"
>    parameter), Linux configures the MPS of every device to match the
>    upstream bridge, which is impossible if the Root Port has MPS=256
>    and a device only supports MPS=128.
> 
>    This scenario results in uncorrectable Malformed TLP errors if the
>    Root Port sends TLPs with payloads larger than 128 bytes.  These
>    errors can be avoided by using the "pci=pcie_bus_safe" parameter,
>    but it doesn't seem to be a good idea to always have this parameter
>    even for basic functionality to work.
> 
>    Revert 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
>    payload") so the Root Ports default to MPS=128, which all devices
>    support.
> 
>    If peer-to-peer DMA is not required, one can use "pci=pcie_bus_perf"
>    to get the benefit of larger MPS settings.
Thanks, I'll send a new patch with the above commit message.
> 
>> To reap the benefits of having support for higher MPS, optionally, one can
>> always append the kernel command line with "pci=pcie_bus_perf".
>>
>> Fixes: 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte payload")
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V3:
>> * Fixed a build issue
>>
>> V2:
>> * Addressed review comments from Bjorn
>>
>>   drivers/pci/controller/dwc/pcie-tegra194.c | 14 ++------------
>>   1 file changed, 2 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
>> index 4fdadc7b045f..a772faff14b5 100644
>> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
>> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
>> @@ -900,11 +900,6 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
>>                pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>>                                                              PCI_CAP_ID_EXP);
>>
>> -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
>> -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
>> -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
>> -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
>> -
>>        val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
>>        val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
>>        dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
>> @@ -1756,7 +1751,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>        struct device *dev = pcie->dev;
>>        u32 val;
>>        int ret;
>> -     u16 val_16;
>>
>>        if (pcie->ep_state == EP_STATE_ENABLED)
>>                return;
>> @@ -1887,20 +1881,16 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
>>        pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
>>                                                      PCI_CAP_ID_EXP);
>>
>> -     val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
>> -     val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
>> -     val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
>> -     dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
>> -
>>        /* Clear Slot Clock Configuration bit if SRNS configuration */
>>        if (pcie->enable_srns) {
>> +             u16 val_16;
>> +
>>                val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
>>                                           PCI_EXP_LNKSTA);
>>                val_16 &= ~PCI_EXP_LNKSTA_SLC;
>>                dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
>>                                   val_16);
>>        }
>> -
>>        clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
>>
>>        val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
>> --
>> 2.25.1
>>
