Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52ACA611004
	for <lists+linux-pci@lfdr.de>; Fri, 28 Oct 2022 13:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJ1LuO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Oct 2022 07:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiJ1LuK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Oct 2022 07:50:10 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2067.outbound.protection.outlook.com [40.107.96.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32671CFEE;
        Fri, 28 Oct 2022 04:50:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr55oi5FCtvwIFgy5SO9F588Xtx6K5IYBvf8gSQrjlSWr54TNTTmAVrYYFpiNESYWnF3+AUV1DVziUwL1Sd6gOjMBRfSuNk01cOmt6qCrmbcj/INPmW9ZqecfvxjYAcIFygcV/Zul8IjKnC1TQPV7fSgcPhkmAH5aKZ61g7+v2KRZlq7yGV+VYk8M59hNl7SVqFYe2v/4muuOd1DYnRUvN7dCvfcLlNn+fwo2txJ5B8LXhiJmylSuJ5HbeJusyVoJzJiFyU3N0HAC0iYmT9G5FkmmpMWfKLRzJffDNRHOWn3nedfbdZ4Yi5y5cyUam7n5rxvjXlHiNtT7WgLd9+duA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6i/D3yh4HFUu0nR4FEnuJ2NfaCeEfp9U4JFT/LqfEI=;
 b=N4E/qdZvArGJqrHvCDzaoMfriV+83w5O7AQ6c3+iBP2Nvli05TJNeA/2qIIZJlzdaemdPH/bSyMS0s2O4+/zc0bl0HKxXNl8TE+n8WNBo5OzC2s2L7Nqjec2WBhTGF36jgrV8x//QVGOSgWqn9kg4b569oNwjQrwC0AM4Vwel/JajvCzT4DwoxbQtbcVClYQFOQl5UgbtWfSQ9TvGZ0mlH1PBxky7DQBuWzidxDJmxBcANwkgEBPqfhkS+9ZKgKwzgyTahJ46QkHSXsfQH2GQcrX1oq01hDSPcpa+I9YopXzmfN3NSEBAxZZw8LTLzWfu2hO2pWa2hCJgY7uhhyHgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6i/D3yh4HFUu0nR4FEnuJ2NfaCeEfp9U4JFT/LqfEI=;
 b=N6AgxgnGnVM58I3TbbkmPK1wyYIaly7O/HabnNn29YTOQnfm7NiPM+/x7TmjFwOL5qRS63oyqV5cAp6AxP6lLhsu2NJm8mL1rPbof4a+xQ1e7Y+NTzdjJkrlrS/YbVwtW8KmhQsduIqcEOnG60MADXHZavIiPDCf6WlxmStZv+npLc4+G2hdQMaHv286zvZ2iyvUOwGxDdbaXjaxVJi5QYP0dtwrADwUBRj3W8YJ4HzF8EMB6R2YUbZ7GvJGbOIUD8SE4OMaZTHKFuMelhuBYe0TNgjwQ1ntOBXcmAnW5xLUpInT47uKin6r6laKOrJJHtq+vlEkLFbsCgV9Y33SDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB2900.namprd12.prod.outlook.com (2603:10b6:408:69::18)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Fri, 28 Oct
 2022 11:50:03 +0000
Received: from BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e]) by BN8PR12MB2900.namprd12.prod.outlook.com
 ([fe80::2e44:5abb:8e9e:a72e%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 11:50:03 +0000
Message-ID: <1e4714f8-f535-4972-6304-6f9e7471da09@nvidia.com>
Date:   Fri, 28 Oct 2022 17:19:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH V3 08/21] phy: tegra: p2u: Set ENABLE_L2_EXIT_RATE_CHANGE
 in calibration
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, kishon@ti.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, ffclaire1224@gmail.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
References: <20221013183854.21087-1-vidyas@nvidia.com>
 <20221013183854.21087-9-vidyas@nvidia.com> <Y1vAEh3NRiB5mrM7@matsya>
From:   Vidya Sagar <vidyas@nvidia.com>
In-Reply-To: <Y1vAEh3NRiB5mrM7@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::11) To BN8PR12MB2900.namprd12.prod.outlook.com
 (2603:10b6:408:69::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB2900:EE_|CY5PR12MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 53c90fdd-e1f0-4009-e56d-08dab8da8ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RH7ynH8mhMas+6ZYdV1FRM/5mt/HPfcu7//iLilx0AmXBgjKziEBt4IBq1qmZoxDUY7R7GpOgTr39rSsJHoVGmH5+tUhquVrc1jz5n4wgp1uZeL26zYG3wxHowiXg4RPBkAGFO0C9v7HE8oi5K9pZayGbi0sI3KCFyIs477cj4hB8rIN0v5ERwTxWfVUFvZVmg8eLPNE70ct3Wz4ILRqJEmGSuBSMRanJssA2D5wxZttzIoIWuXucRvJi1HKLaYVaHicnZu7+foQlXFUCK2qABhqEuj7vChMWAlxgOo7vmakY6b3z3unqhmTgXod+fKLYYj75tSK/Ai6dauU2FcDea5YHT1SELOlGWF8Ni3tqjStbtlAVHVHmm9MqbexRz7dCYM8QkYDsSYpRwcll7OJtxHtKHQaddcdp0hUarcYnjv3Fx8K8xQL3Rw/6Dtrpp5jJEBxBbowHnZuNb4WihUMkvM20QtxGsKcQH8x9JZRJECK0F2yRds/THwBPmMD/I4p+PEHwdu6keu2MqtvMJxIE+SrFJZacdIvVFsSzTMIzs/clOL5vIx2xyVmuFpSa1w2Q6D9VyvMcq+6r8gKqz3fFcGEZUurWUmL0gvM8wANyhIiqC93CNiMd/Pxe0lxo64lEw8yp7IwKOx1XldyyAlfjiMBOYKLxEjCc8N/UinX6M33mYl+kEm3UghKsbZ+BIJUE+86OwJQNBeMpPhh384gl4CFqB1jw88VpLkf5+3VlrapY1iUwAJSRKy5SWe9kuv+3aZW4ev9yP+OrqrYonqRY/yL1J7EEQ2jlXMIso+GiZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199015)(41300700001)(31686004)(6486002)(7416002)(5660300002)(8936002)(66946007)(4326008)(66556008)(66476007)(8676002)(6916009)(38100700002)(6506007)(2616005)(6666004)(478600001)(53546011)(26005)(6512007)(316002)(2906002)(86362001)(31696002)(83380400001)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkJyM0JsamVEaGg1elo5dTZDVFpBbi9BRzBQelNzaWZTNG4wWkJaY2tiN0dy?=
 =?utf-8?B?ZHFIT21zc0taVFl3RCtlS2Nqc2wvdTUxSURJRG1YT285U252aWpPL2oyc2E4?=
 =?utf-8?B?clhScDVrR293akIvWCthY3dpSHRzRHo0Rnp5eUVoUDZkSUJuQkZxdWl0ZHo4?=
 =?utf-8?B?RGIwY1pzR1QrNzVYaVd0M0l0ZHdnMVNnSmd5Y2M5YXZKVE9VS2FlYUZqSWZl?=
 =?utf-8?B?Zjl6Z0pSYUJMRmNTMWxLYldmaXk5QkFheDFweW1jR0NCZU5Zcmp3Y1JOTGJz?=
 =?utf-8?B?YkUwTjVNa1pSMXV1UHViRFVqSTM1cE03RkhXa0ZObGZBeTRaOUd1T0xTaFUz?=
 =?utf-8?B?Vm9XYjhiZHZtT0xSUHhnMk9XT1BNYkErMGN5eTNlOFZyc0l4Y3pReG5CTDBE?=
 =?utf-8?B?VWJ0emtKUjgwN2hTOGJzM1BrUDlBRXlueWVidFdnTHlDY0tEeVczUUhabFpV?=
 =?utf-8?B?UXJXaHI5eVhrZkpyZ0RMc3FwVWxtU1VzOVNGYU1jOGFETkdmY0ZHajlOUGdE?=
 =?utf-8?B?b2s3OXRFQnFBbGxYWFRjaUFEVTk4bWR5eVBKS0ZUSDNyaHFQOXc1ZzNIMy9V?=
 =?utf-8?B?SzBrTHBKcmpUWXlyVVU5aUM2bW1zNUhwVWtRUnpEa1RXTHUvWVRIZ1ZwM2wv?=
 =?utf-8?B?QWZqWUJ2NExMRHZERWJzQSs4QnA2SWRtb0dZbzdpMDVmRll1ZmJxNDEyU0hW?=
 =?utf-8?B?WTVrT2NrcTgwSEN1THBiOGlHTCtJY3lRTnRRazk0UVhZM1NqVTMxM0Fkd2lR?=
 =?utf-8?B?bEFET3ArRnpad0pTSGJnUjVJSlFTSlcyaFlRejRjeXVLWnBwOU0xQjZPdENZ?=
 =?utf-8?B?Mlczd001N0h1S1g2a0NNUTg4NGNHWUVoZjNtcTMrV2hkWVVkOS9RdVNZYzZG?=
 =?utf-8?B?SHAwZEt6ZVBZbUhub3FQQzRWZGdOcjlvNEJoOTlvWFJMemx1NTVLZUlLemlQ?=
 =?utf-8?B?emlKVTVyVUs2OHI0OURSWGNkUUNqQWZTbDJEaU5mTkM3ck1iL2ZadEpCWmFp?=
 =?utf-8?B?QkRuYXg1YStzOC85cTZwNk52MVo0YXltMkUvdm8xK0xTNEZUSUpKYVpERWdp?=
 =?utf-8?B?UldzYUY2c2s1eFZ3WUJDKzJZL2F6NWpxeXRMbmdkb0RYdHNUeEFodExFaGlR?=
 =?utf-8?B?eWQ5c1BRNXVKenBMZmhQZStlYTE3Vi9zcStNSHArcTQ0eTNmQ2IxZ3ZrZzVX?=
 =?utf-8?B?dWQzdkVUaW95aWR1c09ZMlh1Y2xSNGRHT1IveXBOVHZwU3IzSFFCMk8wYUFY?=
 =?utf-8?B?bHA4N1ovYTduczg3c2dVUUxhUnpVOTh0VjRlTDBPYmIxRGJWS1hNOTA5RitX?=
 =?utf-8?B?ODBCWFBoNkVCOU1BZEF3SHY5YURNdGpBQmpZejR4MEREUlgrZHN2cWtQRkh3?=
 =?utf-8?B?clgybWJoVkEzdWpROUpqRnppRkg3TTNzZ1A0eW0zZ1BFMTNIWXpHL1F5aG1G?=
 =?utf-8?B?aDV3by9FRmM1TTVmcm1NaHBldnczalV4dEk5aGhEbDlWcm9TNnFzUWtSNXhy?=
 =?utf-8?B?OCs3Ty9VNjI3dVBMcUthT3RjWkhaY1h3VEI5enVoZndNcEluQlM0TXpNWFdB?=
 =?utf-8?B?RkxBQU1wQjhwdU52dVVROWtPckZETkppQ0VTMmV0YXVLbDlCV2tGVm9OUEov?=
 =?utf-8?B?U0VJMGRLVkszVDJydHJuY095RTU4TkErMVU1WHFmbERsLy9wTFVZSitSMEEx?=
 =?utf-8?B?T1dlMDJMaU9oR0RrWGZmc2hrc3JkZ08zREZJbnpZaUVMdW40M1pBM2Y1ODFC?=
 =?utf-8?B?OWt5dngzc3RENVlwVTR5MEc4dEtUSkVtR0pVYlBwRHRKa0N6Y2Zad3NzVWV1?=
 =?utf-8?B?eUcvYzl1YUowbEt3Wit4NUZvWk5JU29oQmZBd21mRXliYUhCdkQ2azd4Yzkx?=
 =?utf-8?B?MzBFOVkzY29RbjhtMHBxMzNhQVY2UDdGQ3F5a3FFeGUxYkd2NkI1M0RRY0p1?=
 =?utf-8?B?Wkcybkg2UUZrK2dsZ25xMlJ0WlVidTRPeS9YekdMdVhjZDRNVXNidDFJT3NZ?=
 =?utf-8?B?V0RZRFFuNXRmTGlrNEtDTEhQZkNDZzBNazJ5UVZrYzdsWUM0SFlRNFd5ei9E?=
 =?utf-8?B?MTk2Sit1VjNWUi9jQ2VZOVEvR1ZSOUQ1aEE4ZzJKN3Y1ZTlBOUFKQ2hvWHVl?=
 =?utf-8?Q?9/oKTn+Z9LFDwEPisS5DYUgjk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53c90fdd-e1f0-4009-e56d-08dab8da8ce4
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 11:50:03.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ+CXneAuUSTd4jqRnjSHxlMxQKRIWwiyZhNCwOqzrqfq0HXXn6gtwfn94o4GsT7xtmbzkQxKvmzNG4LInSETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for the review and yes please go ahead and apply.

Thanks,
Vidya Sagar

On 10/28/2022 5:12 PM, Vinod Koul wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 14-10-22, 00:08, Vidya Sagar wrote:
>> Set ENABLE_L2_EXIT_RATE_CHANGE register bit to request UPHY PLL rate change
>> to Gen1 during initialization. This helps in the below surprise link down
>> cases,
>>    - Surprise link down happens at Gen3/Gen4 link speed.
>>    - Surprise link down happens and external REFCLK is cut off, which causes
>> UPHY PLL rate to deviate to an invalid rate.
> 
> This looks okay to me and I can go ahead and apply, PCI patches can come
> thru PCI tree and whenever ready use .calibrate() ?
> 
>>
>> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
>> ---
>> V3:
>> * Removed "Reported-by: kernel test robot <lkp@intel.com>" based on Bjorn's review comment
>> * Reworded the commit message
>>
>> V2:
>> * Addressed review comment from test bot and Vinod
>>
>>   drivers/phy/tegra/phy-tegra194-p2u.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/phy/tegra/phy-tegra194-p2u.c b/drivers/phy/tegra/phy-tegra194-p2u.c
>> index 1415ca71de38..633e6b747275 100644
>> --- a/drivers/phy/tegra/phy-tegra194-p2u.c
>> +++ b/drivers/phy/tegra/phy-tegra194-p2u.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/phy/phy.h>
>>
>>   #define P2U_CONTROL_CMN                      0x74
>> +#define P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE           BIT(13)
>>   #define P2U_CONTROL_CMN_SKP_SIZE_PROTECTION_EN                       BIT(20)
>>
>>   #define P2U_PERIODIC_EQ_CTRL_GEN3    0xc0
>> @@ -85,8 +86,21 @@ static int tegra_p2u_power_on(struct phy *x)
>>        return 0;
>>   }
>>
>> +static int tegra_p2u_calibrate(struct phy *x)
>> +{
>> +     struct tegra_p2u *phy = phy_get_drvdata(x);
>> +     u32 val;
>> +
>> +     val = p2u_readl(phy, P2U_CONTROL_CMN);
>> +     val |= P2U_CONTROL_CMN_ENABLE_L2_EXIT_RATE_CHANGE;
>> +     p2u_writel(phy, val, P2U_CONTROL_CMN);
>> +
>> +     return 0;
>> +}
>> +
>>   static const struct phy_ops ops = {
>>        .power_on = tegra_p2u_power_on,
>> +     .calibrate = tegra_p2u_calibrate,
>>        .owner = THIS_MODULE,
>>   };
>>
>> --
>> 2.17.1
> 
> --
> ~Vinod
> 
