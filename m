Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0EF6A51CA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Feb 2023 04:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjB1DZs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Feb 2023 22:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1DZr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Feb 2023 22:25:47 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF303241C5;
        Mon, 27 Feb 2023 19:25:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmWr4PbuVfLEzg+NpA7MaCdeUdnDEpqfk7FZJHwuJrVXUycx+0L3w8a1uvLSUbyaU46CmX6diZ4DRvJPEZKuevxPAzZkYBw9TXsRYApRkyBnxemQNbr7Gl623nlEGGjNcVObAmpPQF9PI/VDeVpsv3UMnemeFRac2cuzyjQN8uRKg2GfeiFsgykwAp3PAy/NwXqsNH25ZSQXk9KrMb8OJv61pHp8hhPczTo+Qf9ACmmwONLmrQyGZRxqY8vKFS8E8Kw4FmTASp/De/NIqGSAasIQt9QFRiIS+N7tmec2Iuve/5iPyINO8g7ubJPx8SGW8YWaYIm7nPECnZC7K6Matw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4F+SDNkUWHszznYCkBVnc6nR6TJGb1TstnXvydpMbLw=;
 b=IwYU0OP5uVy2RTmWSp/uiMsZ+8UWCzkPSFj53U24+dNOa/dUpnFNaPsXnTjcryBWzUn4imZ/nMbrh5X95Odw8vqjMlYNbx9lO0Laugxh8xQYBH4KuXey+6tas1j6BRiwUfHxE3KXFXx94k/kWaL7D5j/xL0jfe8TycIdISZBWiqYbmgMVcGFohLLgrKDVcyZNzXaU5Nw8uWxMaT+d+/8XXLdbuF/7UCP76/UKGukPChEd0kGCxRj1zVimwvY+l1riaafN7EOfkPoNqV8e3pUdp+v6CqMBh+PLyHZ2kA/IDIJ3d0Q6s8YEd3KPWau7Ydk5DIUfQK2Z1Yrvi3fEon6ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4F+SDNkUWHszznYCkBVnc6nR6TJGb1TstnXvydpMbLw=;
 b=SwLr/3pYRDdLEWaO2RrRV5OOP1a3tAw3pOaZB35smr9gV2rzG/UQ8gUqkVW7cClplhFdzlbPm0TNbl8asPXKvd5B/Xtg/uk1SJRTCikJdK99Avak2o3KgeiQoWHLpzl7+5TDqRB+VfWlq31VTHb8DGWBa/uPs4K8C6Ei0vllV1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 CO1PR01MB6581.prod.exchangelabs.com (2603:10b6:303:f4::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.29; Tue, 28 Feb 2023 03:25:41 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::fc8b:5e5e:a850:7f0a%6]) with mapi id 15.20.6134.029; Tue, 28 Feb 2023
 03:25:41 +0000
Message-ID: <b05e7ef4-f5f4-9519-f0c1-04dfee74996f@os.amperecomputing.com>
Date:   Tue, 28 Feb 2023 08:55:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/2] PCI/ATS: Add a helper function to configure ATS STU
 of a PF.
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        joro@8bytes.org, bhelgaas@google.com, robin.murphy@arm.com,
        will@kernel.org
Cc:     jean-philippe@linaro.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
References: <20230227132151.1907480-1-gankulkarni@os.amperecomputing.com>
 <20230227132151.1907480-2-gankulkarni@os.amperecomputing.com>
 <b7a71cca-8223-7346-c024-edc80a106042@linux.intel.com>
 <e80adfa5-b51a-a1ae-f582-58eaa4a5be68@os.amperecomputing.com>
 <47a88e5f-ee56-9c4b-e134-e018cd6dc49e@linux.intel.com>
From:   Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
In-Reply-To: <47a88e5f-ee56-9c4b-e134-e018cd6dc49e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:610:76::32) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR01MB6824:EE_|CO1PR01MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: d42988f8-f654-49dc-c054-08db193b782d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dt5r54Xa1cmH6C/Ru1tnojhLn5afPt1ZVja754n58mGbx0X3T5Adn0xqcvrG70m/8b2BgVgmmM8LQiHnF1Sn1b4WG+IyZf7U2AfFscidSfZu4BV8yFuQdCz1VGzI+KX9U8xnhvjC6/hyTkPOj4gYH7NzT5yOZdFs8JqJKMbhgrqscFfoOT9Ye3f28C25kRHtK9paz5dAI/jO2bf60h5HvvAgXiRQ0iT3wWtedP1I2eLSwVL4Is3oS5jRMVFOXN3hIHVUmcVsZLgB9Izm9bF/c4EkIOyDgIxeWNlrYsH5pWzvBoOPMHOt3/Pxvh8ECk2GBsivCaMwzRESfgEmFndMdX2h9XfFNYHtBPpQ7g9fzbheznewLIxeuZ4FPb95I6ngW+QYK1WvaN7Bqjna7Sjd7CiqTONNAtRpuV9q7JNfF4vMk05YDj3lWihg62iP0Hyl4UzgEj9/ecQTsOzStvdGLuBvyi7ZmV3nvmX8mv1PWYwqNaaUQGijB3xgCgVrg+y5j+DDbsGB/xkaGkXUUezCod68Xqys/JUCf4vnlmCTCZmC7ePTUo5BYI1Yo9t4rhNVvwIZHaiI6tuKnlw2sdyAJ4h46VCQYhcwujTF3G0imqaIFqZqkOQGIpgI5gsqfV8ie5fKFvXf5Isb3aXlW7XT3fGFgbd1ceNTMME65ZI4XvfynXZ2CUYGt11NN8LoXiiD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39850400004)(136003)(396003)(366004)(346002)(451199018)(186003)(2906002)(38100700002)(83380400001)(8936002)(66476007)(8676002)(41300700001)(7416002)(4326008)(5660300002)(107886003)(66946007)(66556008)(6512007)(6666004)(53546011)(6506007)(478600001)(26005)(2616005)(966005)(316002)(31696002)(31686004)(86362001)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJtdjB1WTFLUmdWNld3UWZZeDFPWHkveEY3T3RlS2l1bEVZSWJrdTgzK3JP?=
 =?utf-8?B?UEJiRWZGMVFoMWU3UGhBK3dLeXlOdnoyczhhQ3I0aGNFa09mZ2xDanI2QUxD?=
 =?utf-8?B?UFRzY0FrSTNxVlR0SWEvQjlEK3hqWHV5SlEwdHY4SytwS0NnTFU5S1E3Szk5?=
 =?utf-8?B?enJMT1BCT1lzYkRBUEZ5ZTJGYWt2MEFMK3RCTkljbU9VcHNGSDh2VGh6M0F6?=
 =?utf-8?B?WDcvY2NRRi9oMEp3VnorYndaUDJSQ0V0ck1tdHBLQ0UzZzJUTEs4RDk5M2xh?=
 =?utf-8?B?Lzg3UTNyRDdCSDkrckNzVFlOTFBIOC9kNWdoTHFyVS9oQ0hiQ1diRlRwTDZ6?=
 =?utf-8?B?aE9PS0JUaSt3Rit1STZMRmw0Z2dQTDJ6WmhjRExGeU0vRStzM3J6QlZBamFS?=
 =?utf-8?B?Z0Nqa3c3WVRHS0lpL1pHWk5zSTNucW4wemRkenlYYXdLSkJHV0RwN0I1YXBw?=
 =?utf-8?B?YXVQZ0UwOHprSDlRSDlvTndxMjR1R2MzTFh0U0dVdndxMFdhdzgwOTZSdXc4?=
 =?utf-8?B?MThJY3RXT2pKQ3NZYm52SGJ5YkdvcUpnWHE0VUFaK2ZOOXZZb0hMZ2NHYlA3?=
 =?utf-8?B?ZGNiaVBuWjdlbTM1K2FjV0JUWGtEUmhrZVh1SmdMSHZSWnFtR1V0dkpvdUR3?=
 =?utf-8?B?TmxRM0oxbXNlN2NjYTAzKzFvcHJRTHp1UFJoS0VjcnRlY3B6M3EweHdBMlhQ?=
 =?utf-8?B?YUZOUk4rb0RiamRrc2s3ZmZ6UTJ1MmZ5QmtHUzVLZWdGTTV5SDlya2NRRDBk?=
 =?utf-8?B?aWx2bVV1dFhsR3I4RlZua0g5TnBhOGpzTWZpbGZOQVl2YWtHZFU0VFh1Z0U4?=
 =?utf-8?B?OXdjQ2FHL1BzQlJRKzBINW0xUWhnYUxTZUdTckZzUmlpSStTdEpnK0xTZU5H?=
 =?utf-8?B?bDhHam5WazE5ckVvV3liWXRyNzNJaDZ5eXhPcGxaWGZHK2tWdlBoNy92ZXB0?=
 =?utf-8?B?b1F6eFZWOUxOTi82RzJ4K3B5Y0pNZE81RTMvU1dYbDhHSzhmYmhqMWcyeVFS?=
 =?utf-8?B?Q01MRnhkK2g0L3Z1OWpnMEJ1ZXFsTjhjMEZhREJBdWp3c2JybC9mSFR6NXFK?=
 =?utf-8?B?M21MOHIzRmd0RStyZFlsM2lFT3pFNWRJQy8wTTIxWVprd00vekc2WE9wU01M?=
 =?utf-8?B?N1J6NGNndThNYVl4K3J2c3ZVZ0VYMy9wYmtwZlY2Ym5nTFRPTlFRQjlLaGQw?=
 =?utf-8?B?TTZ5L2dQUTNwUjFTMEEwcHRLQ2svZ0NlK0RweFJPTFlkYzQ1aTNvMVZTSGE2?=
 =?utf-8?B?UmQyY2xjTkdTckdvV29Ed2Y4enlZaWZUOFdpOWN3YlZJT2hIZzFNUy9STjJU?=
 =?utf-8?B?M29tYUQ5bmV4THJGSnFmdEdPNms3VVhmL0REOThlUllpNGs0QXI2ZmpUL3ZY?=
 =?utf-8?B?T1IzSFBhSUsvTW8wNzZ5cWVIOXRHbWtXbUlFMXhzRFlGKzNQWHl4Z1ZPTlN1?=
 =?utf-8?B?cWptREpKTkpqa21YZElQMGlXOUwwQ2kvd3daM3hqTTB5U2RSanVWNFl4TzU5?=
 =?utf-8?B?Q3lYSmZ0SGlTMVdyaGdIcExlZUVpMDBvQzVxNzY0a2FkQUZVYnY2TGJiUkov?=
 =?utf-8?B?eWNDc2h5NGl4R081RHpZSlVVTDhmQUtGa3BXMDMzN3hBclpWT1FMU2JXMStK?=
 =?utf-8?B?QmxMVUV2TVl2ZVFvTThzZnh1RWZPb0trb3N3ZGpHbWJ3NEJWYU0xTUVheS92?=
 =?utf-8?B?RVg2OWJxQlpFNjhEQ3QvQjN1ZFJXazVLRFowdkMwTnh6U3gyVlp3RHB0YTNM?=
 =?utf-8?B?dVRWZGpBRFdMNXl5K0NXcyt4NGlaZzZjYzF4bGhBNFYwd2s4dUdEZWZXanZ1?=
 =?utf-8?B?R3JkVGNWa1A3M0VJU1dDcFV3UU5uTzAxUWJJclg1aG1ydFJyQjNpUEZLeGNF?=
 =?utf-8?B?Wi93YnR1OVhUY0tWTnlVMGNldVNVUWkrVVhxN3hBWlkwLzJnM3piZW9oRXIr?=
 =?utf-8?B?ZndlUUlXQ0Irc2FFRm9KcFNUYXFkNCs0OUdZZjM1VktzRVN1dGNvbk1XOGlS?=
 =?utf-8?B?RUJXS0w4UGZLdkpleG0rUEpCMHQ4d0xJNnIwY3p1WkpiTjNhR2JuNnlweUYx?=
 =?utf-8?B?L0VYQjFuTEFNYWUvQ3FvS25SUnVSSElhaWRnNkhJV3BiM1picFR0NDE0WTJ6?=
 =?utf-8?B?dDEwZytMaFBhK2NkWng0M1c1ZTkranFHaDFMY1BLYVY5Z3h4cFN2cTZEWUxP?=
 =?utf-8?Q?xkCYk3/Hs4DAhnli6uX9PqqDDhIAR9fQt3kgmwQcmDcW?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d42988f8-f654-49dc-c054-08db193b782d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 03:25:41.3866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KUGuE5l2FBYg44yImy34MNrbajPg1bHKpbI7Py1esue53pTWZm6x2edk1rwgYkuishdYdV9AGgOaCPCuMIieJa+AHMJ9KdvmUuzy2BjVZnttQmNHAXdOpmfOKsZS1dsG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6581
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 28-02-2023 08:38 am, Sathyanarayanan Kuppuswamy wrote:
> 
> 
> On 2/27/23 6:53 PM, Ganapatrao Kulkarni wrote:
>>
>>
>> On 28-02-2023 12:59 am, Sathyanarayanan Kuppuswamy wrote:
>>> Hi,
>>>
>>> On 2/27/23 5:21 AM, Ganapatrao Kulkarni wrote:
>>>> As per PCI specification (PCI Express Base Specification Revision
>>>> 6.0, Section 10.5) both PF and VFs of a PCI EP are permitted to be enabled
>>>> independently for ATS capability, however the STU(Smallest Translation
>>>> Unit) is shared between PF and VFs. For VFs, it is hardwired to Zero and
>>>> the associated PF's value applies to VFs.
>>>>
>>>> In the current code, the STU is being configured while enabling the PF ATS.
>>>> Hence, it is not able to enable ATS for VFs, if it is not enabled on the
>>>> associated PF already.>
>>>> Adding a function pci_ats_stu_configure(), which can be called to
>>>> configure the STU during PF enumeration.
>>>> Latter enumerations of VFs can successfully enable ATS independently.
>>>
>>> Why not enable ATS in PF before enabling it in VF? Just updating STU of
>>> PF and not enabling it seem odd.
>>
>> More details are in PATCH 0/2 and 2/2.
>>
>> Also, This was discussed at
>> https://lore.kernel.org/linux-arm-kernel/20230221154624.GA3701506@bhelgaas/T/
>>
> 
> I agree with Bjorn's comments. It is incorrect to directly configure PF
> registers from VF enable function. It is a buggy fix.
> 
> My question is, why not ensure PF ATS is configured and enabled before enabling
> ATS for VF. Anyway, PF device will be enumerated before VF, right?

Yes, however ATS is not enabled in passthrough.
When ATS is not enabled, this new helper can be called to init STU since 
it is shared with VFs.
> 
>>>
>>>>
>>>> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
>>>> ---
>>>>    drivers/pci/ats.c       | 32 ++++++++++++++++++++++++++++++--
>>>>    include/linux/pci-ats.h |  1 +
>>>>    2 files changed, 31 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>>>> index f9cc2e10b676..70e1982efdb4 100644
>>>> --- a/drivers/pci/ats.c
>>>> +++ b/drivers/pci/ats.c
>>>> @@ -46,6 +46,34 @@ bool pci_ats_supported(struct pci_dev *dev)
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_ats_supported);
>>>>    +/**
>>>> + * pci_ats_stu_configure - Configure STU of a PF.
>>>> + * @dev: the PCI device
>>>> + * @ps: the IOMMU page shift
>>>> + *
>>>> + * Returns 0 on success, or negative on failure.
>>>> + */
>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps)
>>>> +{
>>>> +    u16 ctrl;
>>>> +
>>>> +    if (dev->ats_enabled || dev->is_virtfn)
>>>> +        return 0;
>>>> +
>>>> +    if (!pci_ats_supported(dev))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (ps < PCI_ATS_MIN_STU)
>>>> +        return -EINVAL;
>>>> +
>>>> +    dev->ats_stu = ps;
>>>> +    ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>>>> +    pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
>>>
>>> If you just want to update the STU, don't overwrite other fields.
>>
>> Can be read modify write, but felt not necessary, since all other fields are at default value zero.
> 
> It may not always be true. If there is a case where AMAD and AMAE attribute values are
> configured independently, then your change can overwrite it.
> 
> IMO, since your intention is to update STU, I recommend just updating it.

OK, I will change to it read-modify-write.
> 
>>
>>>
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(pci_ats_stu_configure);
>>>> +
>>>>    /**
>>>>     * pci_enable_ats - enable the ATS capability
>>>>     * @dev: the PCI device
>>>> @@ -68,8 +96,8 @@ int pci_enable_ats(struct pci_dev *dev, int ps)
>>>>            return -EINVAL;
>>>>          /*
>>>> -     * Note that enabling ATS on a VF fails unless it's already enabled
>>>> -     * with the same STU on the PF.
>>>> +     * Note that enabling ATS on a VF fails unless it's already
>>>> +     * configured with the same STU on the PF.
>>>>         */
>>>>        ctrl = PCI_ATS_CTRL_ENABLE;
>>>>        if (dev->is_virtfn) {
>>>> diff --git a/include/linux/pci-ats.h b/include/linux/pci-ats.h
>>>> index df54cd5b15db..9b40eb555124 100644
>>>> --- a/include/linux/pci-ats.h
>>>> +++ b/include/linux/pci-ats.h
>>>> @@ -8,6 +8,7 @@
>>>>    /* Address Translation Service */
>>>>    bool pci_ats_supported(struct pci_dev *dev);
>>>>    int pci_enable_ats(struct pci_dev *dev, int ps);
>>>> +int pci_ats_stu_configure(struct pci_dev *dev, int ps);
>>>
>>> What about dummy declaration for !CONFIG_PCI_ATS case?
>>
>> Thanks, I overlooked else case.
>>>
>>>>    void pci_disable_ats(struct pci_dev *dev);
>>>>    int pci_ats_queue_depth(struct pci_dev *dev);
>>>>    int pci_ats_page_aligned(struct pci_dev *dev);
>>>
>>
>>
>> Thanks,
>> Ganapat
> 

Thanks,
Ganapat
