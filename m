Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6403F3DDEFA
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 20:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhHBSPe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 14:15:34 -0400
Received: from mail-mw2nam12on2085.outbound.protection.outlook.com ([40.107.244.85]:38504
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhHBSPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Aug 2021 14:15:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BscDPr1FehXy5zjukLtGi482657HplAx2cdonmB/cSxt2ViAtkefXVqN5aOOhtwh5mdHIYjmzR0f4pLSgNMwY0wppGIbKFbn+02DtxReJniUGjRajx9ICp7qAyJbeaZOd4mbZAZ7SxIJzsc4+BN35xRWlS2GJfK88e42OQa5w2Toyt0tU/Q9rmySCTxOqu7lBdZj/+T2Hosr4mZWprhXYKmvU5YQoT6vq/dP7ygEVZy0VVNcA9AfMh7cFOE3cEsOAEHYpJMlDKzlG+tv8cTwmbPKb71+y9j1IJ8d4wsA0SQJITK5sjSfnohaOAOnV5eY1kuhrfhirHzRANbouSqNUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX0q3PD0bmQp7CVZb9QiClvA7r54RKw7aiEXH5ichFE=;
 b=K9wHhOLLw653jS7JFGwQYK+MO+ZVzlF0ahVdErbU2/Thn8iUh5z8ikzvatv7248h99ODr1T4+f4pzfAQ3NBMZ/8QjQwgAcTazLtsmMwRFx7z7LvmbJdRrCueUSf2sx98SopASJywMpxS2TcYGJGhbM2jQRP1sLOtVgBlKRPAAkUdEDqqFyoKgpNvFFB7zKbJ3u+U9ClDbE304UMKDBdRHcONu3/8VnjBTvY5W5jI1UBYC6W5fR4DiiLEFsFdk0KF6KYRo89fThP2mThN/cq3gevzEIgQpPBW9RNaax5d/uaMKSWINeGqc+THiveK1k9sEignQ8LADhUoXqRTWTYAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX0q3PD0bmQp7CVZb9QiClvA7r54RKw7aiEXH5ichFE=;
 b=cOoG3OE7Mz5Dh1cK3pIFxwz1pG6bepYKtTiQj1M//jIXPbG5jCh26M/v4OgsTcyYCaERjQNguxz//U0H33HkX9mlvpxi8UIYs7sSQh8kRquY5PkkmJCZxe9hysiSNMEPLCDb2u2SBTTFAkm7y9i1QDgxDYVGXO2Zs7RrbmKUX+o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5103.namprd12.prod.outlook.com (2603:10b6:5:392::13)
 by DM6PR12MB5535.namprd12.prod.outlook.com (2603:10b6:5:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Mon, 2 Aug
 2021 18:15:22 +0000
Received: from DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822]) by DM4PR12MB5103.namprd12.prod.outlook.com
 ([fe80::18ea:5df5:f06e:f822%3]) with mapi id 15.20.4373.026; Mon, 2 Aug 2021
 18:15:22 +0000
Subject: Re: [PATCH 2/4] thunderbolt: Handle INTR when Disable ISR auto clear
 bit set
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     andreas.noever@gmail.com, michael.jamet@intel.com,
        bhelgaas@google.com, YehezkelShB@gmail.com,
        Basavaraj.Natikar@amd.com, linux-usb@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <1627909100-83338-1-git-send-email-Sanju.Mehta@amd.com>
 <1627909100-83338-3-git-send-email-Sanju.Mehta@amd.com>
 <YQgNx/YiPVFEZrDb@lahna>
From:   Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <ffe7a358-a3a8-5b6b-55da-f088316deff1@amd.com>
Date:   Mon, 2 Aug 2021 23:45:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <YQgNx/YiPVFEZrDb@lahna>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR0101CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::15) To DM4PR12MB5103.namprd12.prod.outlook.com
 (2603:10b6:5:392::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.32.35] (165.204.159.242) by PN1PR0101CA0053.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 18:15:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fd288f3-038f-4d48-6986-08d955e17e1b
X-MS-TrafficTypeDiagnostic: DM6PR12MB5535:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB55357FFBB42A0380C667CE24E5EF9@DM6PR12MB5535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BDicZrs8hZ2ELvLlURnrucUHw67vTRFNcDQouCanBWPCLGLPfjMklRr9ZZtFo7umKTLL8KhlYb4Ivie4vZY5/nyOvgiqRR0X8QE5izH8+Hfr2eR9JP3Wkd9Qkou0ELujvTBLGk/cMWN6JcIgapoL1B2xf9D+W8LEMQ94lnJpVm+8gfQt7mKLRZTaKue3SsEqwcpnvk0LCfYoA7d1XVDuuWeBJF590C9gKTvNNhyXB4N4vlgoZSAIUDOwA0DTqIdVXlApvTFZLfnW2TRFhY/suwnmUNMAV6WJYRUyWk7NwnbY/cpiqUoNAvngsXfcnIbp7vs44qMnHUga6Ml5erpDT8YhWZJGMvqRjCoWoLL+grQm+VXOSSiinOLiRivwbkX3Yzk03SP2zgnoFoS1ZvrztS3zjy79Ssl7JnIvpaFuFZcF6h+eN7Gk3x8Kl+NdOykmlD+XcgR6U3n4upH+wdLdpySOxAzneAZ3SuGMQSHputfLbEsWdhCKsNkA43syoZtdsF44jav9Agmoa5ox2hniZp4LCKOljNw6MauDVispX/2RRfZpjd0QLu87vsCusJUa7FF+L2KQ2ui2a5e2F0GJvSnWyKgxNephG5b6g6OeUR1l9hXCULkaqPkHM42l8AAUp+WDH2x1vWXQRYEnnOrDKeRmVArz1H0/J2tHQEOnQDk3pijcig4pIXnCU0Ro9UBhUw7opwimRRzxVlVJ+H+H5/5QWSYClnYtfZl0KVzDEBc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5103.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(26005)(186003)(53546011)(2616005)(956004)(316002)(6666004)(38100700002)(16576012)(31696002)(110136005)(4326008)(2906002)(508600001)(6486002)(83380400001)(66946007)(31686004)(8676002)(8936002)(5660300002)(66476007)(6636002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXJrZkU5VzRvSUE5MzNUS2hLaURodG9reUVzV2JmS09Ka3pHRHZuWXZmRElY?=
 =?utf-8?B?WkQxa3ZWV1dzNHpEU1VkYmpTQWh5YVErcnRGWlRSU0RmN3JoN2t5OFFGemxq?=
 =?utf-8?B?Q05jM292c2lGck5PU2ZWM0hvUXk4MmlxTVBjSTNPemMwYU4xVllPbHA1alNY?=
 =?utf-8?B?RXdCVC8yTzVkTkdRRVBOUk9mYlU2ZmgycDdUN0ZhRFZQQ1F3bEhTYXF2aC82?=
 =?utf-8?B?bmVZd3g3aldOd3VMS1lyT0Z6b2ZqV2QzalJyajNqYjQxcGRXWTZjRjhuRXBt?=
 =?utf-8?B?T1VKNk5iK0JrSnhZVkRLRzBMbWpVL3czZmxHTWd6Y2l4alNVTkcrQUdrR2RU?=
 =?utf-8?B?YmVVVnlJMXJQazA1V3IwRlk4MHRzTHZhaE5BNXhpTFhPVUlvZ3krL05tQzBB?=
 =?utf-8?B?eVBSUy9rdkRESVNtTlY4MkExT0g1a0hVSDJ2aXltRUJQMnNPY1JGNU1NU3Uv?=
 =?utf-8?B?ZVFRWkl4aEtsWGhRR1JNa056L0M2WHVDVEEwZmRyYWhsdmhMaS95R3NiRWVk?=
 =?utf-8?B?WmdsSWw1ejcrTTdkOFpEY0VaUkxEcGFKNC9XVVM3RlRsWHkzMHRyZnFTWjFG?=
 =?utf-8?B?SFZxZ09veGRRdkw1dnB0TURDUGJPcUlTZzV5U1gzWkNLZGtFWEMvdWxEY2Q5?=
 =?utf-8?B?ZXVsOUxyRGU2bDhJWndST2xsbkRiTnNEVHcvSkdxZGY4VFl5NVowa3ZES09w?=
 =?utf-8?B?UUZua1QwYVpkTjZ1aWJBaWpsTElmTWZMalF4eHk3NUdkeXN0S3NZS1krUXM3?=
 =?utf-8?B?MnZGRlZiYTJLczRoUU1tSjZUbG11VzV4ektERCtZYUNVVEZTSUFIWDBCN2NP?=
 =?utf-8?B?MCtIWDlMRFZPbnhiVXJ3RVZSN0JQSVNkUy9jV2trM2d0bDVyM2NWR09GS3Bm?=
 =?utf-8?B?cGNuSVhNL3l3OTkrWnp5Snp3azROUTI2bmh3WEh1RkpURStsN2Qzam11eEtU?=
 =?utf-8?B?eVpNNHBvQXBnR2ppMDhoVUxNWk8zUHFXOWprR1cwMzE5ZG1vaWdHRDRXcXVS?=
 =?utf-8?B?MjZ2MW1RbCtLcjhldk1CL21oWkxzcGlSY1VMVTFCTmk3RENxNnMyU2NoaXJZ?=
 =?utf-8?B?V0gzK0J0U2x5ZGVySnk3Y2RaN1Zmb2pSdS90R2pJcGhVTFEyM1NjMUtFZkZU?=
 =?utf-8?B?aUdmZ1MwYWJhUTRKUzZnaWQxOEdxSDJuYy9qWHVoMUZPQzFQSHRFdGpod3dZ?=
 =?utf-8?B?bmdwZXlyNjdxRjAvYlBPbklPMmdtbS9ub2FHYU95a0t5R3hvODFsbDFoSmtB?=
 =?utf-8?B?bmUzcE9VQ1A4NGNhalBxZm42U1NINDcxckI0QzBVM2gyM3Rxd252bFluV2g5?=
 =?utf-8?B?TUxkM3hQZVE2c1A1M3ZsTHVKdWVYalQ4Q3VVY1Mwc3RINUticUVhNmRmZXF6?=
 =?utf-8?B?RC9RNDFwbWpVOHVSZXQvM0VkSkhzeloyTTZtemFkM3lRMWQwTmdkZEFxNXcw?=
 =?utf-8?B?MUZQYUh5NXdsdkdkMlNMSkh3bTFQVHpTTVp5RDFuYVVmSzZoMmRPY1JGako2?=
 =?utf-8?B?MU1CcTRBTFpBM3RSdGFuWGV4VFQvZ1gxdnNVaFdGZU5DNVk0WUFDTS84OFhM?=
 =?utf-8?B?VDYyVmhxOXFXcXRlVHZFU0RlbkhUVmlGdG5lNWZmaElHZDRqbVpIVEUvMDFU?=
 =?utf-8?B?SUJnbjdrWTdkUC9MeHloMi8xYmVpejhaUCtjTTh5d3A2cGRKZCtyRXBtcXlo?=
 =?utf-8?B?bWF5eTVQdFU5bkhVZVdwZEppNXNmQ1pwZ3h2bHFmSkV1TncrTTZOeHNUL3NK?=
 =?utf-8?Q?voPpC2275rAXpUN7phxcnTdiRnZ8UMoOJkm2UD7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd288f3-038f-4d48-6986-08d955e17e1b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 18:15:22.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HLeJ9X1ThoqlzzsjoDK4NdfL1Q571/dhD+SrpWutbSpS3MJFsQWICadIdIE52o6dRnn1zGlhc0+2x7c6m+Oe/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5535
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 8/2/2021 8:52 PM, Mika Westerberg wrote:
> [CAUTION: External Email]
> 
> Hi,
> 
> On Mon, Aug 02, 2021 at 07:58:18AM -0500, Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> when the "Disable ISR Auto-Clear" bit is set, the Tx/Rx ring
>> interrupt status is not cleared. Hence handling it by setting
>> the "Interrupt status clear" register to clear the
>> corresponding Tx/Rx ring interrupt.
> 
> I think REG_DMA_MISC_INT_AUTO_CLEAR which is bit 2 in that register is
> actually Intel specific and not the same as in the USB4 spec bit 17. I
> guess the AMD controller works fine as is if this bit (2) is not set? If
> that's the case we can simply limit this behavior for Intel controllers.
> 

Yes, you are right Mika. With bit 17 it's working for us and we didn't
wanted to break Intel's functionality , hence we added this change which
works for both :).

Yes, as you suggested, we can limit this to Intel controllers.

Will send the changes accordingly.

Thanks,
Sanjay

>>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
>> ---
>>  drivers/thunderbolt/nhi.c   | 26 +++++++++++++++++++++++++-
>>  include/linux/thunderbolt.h |  1 +
>>  2 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>> index d7d9c4b..63bbabf 100644
>> --- a/drivers/thunderbolt/nhi.c
>> +++ b/drivers/thunderbolt/nhi.c
>> @@ -74,7 +74,11 @@ static void ring_interrupt_active(struct tb_ring *ring, bool active)
>>               if (!(misc & REG_DMA_MISC_INT_AUTO_CLEAR)) {
>>                       misc |= REG_DMA_MISC_INT_AUTO_CLEAR;
>>                       iowrite32(misc, ring->nhi->iobase + REG_DMA_MISC);
>> -             }
>> +                     misc = ioread32(ring->nhi->iobase + REG_DMA_MISC);
>> +                     if (misc & REG_DMA_MISC_INT_AUTO_CLEAR)
>> +                             ring->nhi->is_intr_autoclr = true;
>> +             } else
>> +                     ring->nhi->is_intr_autoclr = true;
>>
>>               ivr_base = ring->nhi->iobase + REG_INT_VEC_ALLOC_BASE;
>>               step = index / REG_INT_VEC_ALLOC_REGS * REG_INT_VEC_ALLOC_BITS;
>> @@ -377,11 +381,31 @@ void tb_ring_poll_complete(struct tb_ring *ring)
>>  }
>>  EXPORT_SYMBOL_GPL(tb_ring_poll_complete);
>>
>> +static void check_and_clear_intr_status(struct tb_ring *ring, int int_pos)
>> +{
>> +     u32 value;
>> +
>> +     if (!ring->nhi->is_intr_autoclr) {
>> +             value = ioread32(ring->nhi->iobase
>> +                                      + REG_RING_NOTIFY_BASE
>> +                                      + 4 * (int_pos / 32));
>> +             iowrite32(value, ring->nhi->iobase
>> +                       + (REG_RING_NOTIFY_BASE + 8)
>> +                       + 4 * (int_pos / 32));
>> +     }
>> +}
>> +
>>  static irqreturn_t ring_msix(int irq, void *data)
>>  {
>>       struct tb_ring *ring = data;
>>
>>       spin_lock(&ring->nhi->lock);
>> +
>> +     if (ring->is_tx)
>> +             check_and_clear_intr_status(ring, 0);
>> +     else
>> +             check_and_clear_intr_status(ring, ring->nhi->hop_count);
>> +
>>       spin_lock(&ring->lock);
>>       __ring_interrupt(ring);
>>       spin_unlock(&ring->lock);
>> diff --git a/include/linux/thunderbolt.h b/include/linux/thunderbolt.h
>> index e7c96c3..bbe7c7e 100644
>> --- a/include/linux/thunderbolt.h
>> +++ b/include/linux/thunderbolt.h
>> @@ -478,6 +478,7 @@ struct tb_nhi {
>>       struct tb_ring **rx_rings;
>>       struct ida msix_ida;
>>       bool going_away;
>> +     bool is_intr_autoclr;
>>       struct work_struct interrupt_work;
>>       u32 hop_count;
>>  };
>> --
>> 2.7.4
