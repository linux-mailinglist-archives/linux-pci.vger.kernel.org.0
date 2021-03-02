Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1032B269
	for <lists+linux-pci@lfdr.de>; Wed,  3 Mar 2021 04:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242894AbhCCB6U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Mar 2021 20:58:20 -0500
Received: from mail-eopbgr750055.outbound.protection.outlook.com ([40.107.75.55]:46660
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351721AbhCBRta (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Mar 2021 12:49:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PYq5dQgSgxNrt1LtipO+G7loctiaKT3P8yj/RXhvqAXpVHb7b0pMILM2ge0yfrB7Ss/B9tNThe2bWE0IyYHF/EE0j2iGEGTfQ4hLD91QT6yHveV4gQpm0HkIq2ODZjHtngFwzwPT2sCpnYvM/eujvW+ZOOZRDobrNQtMYLEuJuoky/jkA8ArwCz8t+k6IgfRnoW1yExdDMh9dNhoqtQgFWZpvtgxr7Uh1WyhgI79ZqYPAZ7m80uge1vD86FUPo93N4IAu6A750lIw7NX8z5yJz/zogZE1uHMItGIrarFePa+z3rmHAUPHt2Jkdq3cBxyfC7SoQCgXd9tvXctaaWblg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJBU7clAM4iCsesrX8227gNGd/nCvD24GC6RZIDZawI=;
 b=DZ9OETbbFkI8NtS+t5bZ8nQrQmzQgbh7oZVJSSM9daELQrYy5sMp9jQ7+CQTVRQVhZMsr9Hr1Avguzo5V/0BlVkNsvnYxV7IYJ+GTJaXdlplIx++1gphbWypsHKmE65EcdahHpjgBaO82lxsrpngzHWcGY9zMxQMoyM43rZbCAENepPkyIwELwMfEkKa9EKutQkhpbi6j9E8e/vDhxK0wKEm8zB6espWt29vVa5ZdwJupVWJSfgoESk0JJiARK836sCbY5q95HtGlaKJyvpePc6+xfcy6e1jVzPlm//hl184NkHZ9ooR7DpcAkIdaLtaXCSZolbPwoyux52hhN0XXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJBU7clAM4iCsesrX8227gNGd/nCvD24GC6RZIDZawI=;
 b=OQvFMTXU96IVrpZThgDjpNLliWG0HWBojUNc71BG48KhnJwfckstI1S8EG5LY4Fzj29sV9YeCyWU8LKYm6RaxekA8zouNA0Bm1LcO7vFApCVCxaD5TByVZdEIY5LK4q63Rrvh/jloLp7znSPpIQ14ciO5y29sH9dVkdN14DQvZM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4615.namprd12.prod.outlook.com (2603:10b6:a03:96::21)
 by BYAPR12MB3271.namprd12.prod.outlook.com (2603:10b6:a03:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Tue, 2 Mar
 2021 17:48:27 +0000
Received: from BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::5cbd:c5a8:779:9672]) by BYAPR12MB4615.namprd12.prod.outlook.com
 ([fe80::5cbd:c5a8:779:9672%7]) with mapi id 15.20.3890.029; Tue, 2 Mar 2021
 17:48:26 +0000
Subject: Re: Remapping BOs and registers post BAR movements [was - Re:
 Question about supporting AMD eGPU hot plug case]
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org
References: <20210302164944.GA424771@bjorn-Precision-5520>
 <81cc1a93-3a77-7ef7-c9f9-6083c1c313f7@amd.com>
 <5c2b2379-9961-c6f6-b343-b874cc22260f@amd.com>
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <6685096d-3c01-7f5a-58c5-70d139b61f6e@amd.com>
Date:   Tue, 2 Mar 2021 12:48:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5c2b2379-9961-c6f6-b343-b874cc22260f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:607a:fb7a:f58f:4c94]
X-ClientProxiedBy: YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::26) To BYAPR12MB4615.namprd12.prod.outlook.com
 (2603:10b6:a03:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:607a:fb7a:f58f:4c94] (2607:fea8:3edf:49b0:607a:fb7a:f58f:4c94) by YT1PR01CA0147.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Tue, 2 Mar 2021 17:48:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba3500f3-903e-4685-87d9-08d8dda361ef
X-MS-TrafficTypeDiagnostic: BYAPR12MB3271:
X-MS-Exchange-MinimumUrlDomainAge: github.com#4893
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3271DAE01DAFFBBAB83E0791EA999@BYAPR12MB3271.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ACvZBYt4cFLxD+3pvcFztT3/GKDzc2Hm3aeIb3lQG2eFUjXFmNz3TkA/Yr7IbDSSSqNW4PtPlCd7ywmCcY2N372h9nReTv1KJ9owERiv16qfb4JVdl0RqUZeJMxW/uc8n07En/EQw4ihT8RuNoiu2kmbpLR3Bb3bKwB+zIzngJP9yNE1m47QGAq4llYMLsqv4RL6eyWssP4TlFiAWu/hE4sYsUPowyYbfJ1abrYvqK6NJUMeavPIPkaDhXD4Pr+39i3Z6XQSW0YxngZKtLAtxvqwUf2PbTnBhBQKZNBf0rAvB2e9Z1kuk869iDPqusM4Uo2+V2K0X5kmeOZZkpWVYO7IuhmD+yEKvuVbF1pj4HE/RjapI01F7spjpnV7vcQHQPnBnVrHXDVxVP9lK/1vdz2Kdnu/4KJ2f8FElaWhE67cWbBR/QUfR0NbmitmDj+Y87uWzhGAK9JULftPlLGntlXIGSZmq1FZ+gEkikT0rBwNS6M0f8giGAzWOI4eOltpvYR53u2ewl1jOyEIJiByQpBi4ODkKSDjQaoJd3uB/kN2vBwOwCNG16MKqNkXBSDmWk72VQAuDIZSas9j6GmECfNlvD7W354Kbisk1UwffQaD/DpdiZR5UoJ1h2x9qXHrW4b9rR2QanwD+7G+Gk+8WZbnJkYzaQhG4fT0boRpfgASFECRmgcPPuQd+9Ut7p3w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4615.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(54906003)(316002)(110136005)(2616005)(45080400002)(5660300002)(53546011)(478600001)(4326008)(966005)(36756003)(44832011)(86362001)(186003)(31696002)(66556008)(66476007)(8936002)(6486002)(66946007)(8676002)(83380400001)(31686004)(2906002)(66574015)(16526019)(52116002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZDhFbnZTK3RFZitlTXQwQzlwMkNIbUh0RGJIS3ZobHZkUi9PUi9EazNkbm82?=
 =?utf-8?B?MkQwRWdiMG9GaUNacWFZSnpJVGwxRlQ4NWFzTi83TEtqb3FrMlJETXFWK014?=
 =?utf-8?B?Ui92NUYzRWgxa1F6U1U1REVpOG9WeVRpVUNCbDh6OHh4dVR0NGVlUStrOGcr?=
 =?utf-8?B?Vzk0RUV4ZmRWdVl2Y3JOT1ZsRnYwTDZsVnY3ZEJMcVlNa2FpVisvSFJoUlR4?=
 =?utf-8?B?Ukw3Z25XL0RvUDN0TTI0RkNUdmYyYTNwanR0N0JLeWUwU29Mb3BkeTFxaUto?=
 =?utf-8?B?S1pkZnZNOEsrZXg2TUhNOE8xVXZCaW84MUpIOWxoTHpFQ3lqa0VYRmhSRFE0?=
 =?utf-8?B?MkRGaGhIL0gyWjRsMzdtZzZTb2wrNDFOT0RJWFZ5VktKdjRVMDdwUEd3NEUz?=
 =?utf-8?B?THRqVzd2azZqVDZkY25WME9OOFI0dzhETCsrcnZEZGdCMStFZGUzL3FxaUxI?=
 =?utf-8?B?K3AxNSsxTlpSWElkWGxGSEhBaG0wb1dlNmpWMUVTZktNS1dFVGNEVEFkejZF?=
 =?utf-8?B?cVRCV21Qc1NSU25OVWNuM0VXRVFGa3NJNEZVbVM1eHJVek5mUmhLTEdGOU55?=
 =?utf-8?B?UmFxMW1pNFo2SjJzcTM1WGNVbVdBMHZCODNucXBzdGY5NnlMTDE1WVhpanNG?=
 =?utf-8?B?Ukk0QUw3Nm1TczVZZHFlSXVmVjVFWU0rb3Q2b2JwNFNjV3VYWlE0RkIzWC9C?=
 =?utf-8?B?NUVXVHdvVUtXYU5LUzBURzEreTZac1pMaHQ1ZVZ5c3M2TEFLSkNCbnlycm9t?=
 =?utf-8?B?OVh2TWUxVFhydmdVY3NXYVZsZ0ljVFk4L0JGMEowTUJaYlVLK1FSVkZEckVy?=
 =?utf-8?B?TlBxL1ZRTXI3VkMyNkwwNGEzYW9nMzl5ZFFnVVVhMDEzdDg2QUlJNzd0amtR?=
 =?utf-8?B?dzgvSHZjL0I5bUtJd2N5cjJjYnZheXJFSzZ5c2Z5MkxQZ0JEMThnbmNjWnNH?=
 =?utf-8?B?K0d0WUV5OHdiTkIxbXEzMzJoangyMUdUbjRPVVc2ZUpraDZiNDdJdVNZWUFu?=
 =?utf-8?B?c0RsZkcwcHJ3dHJnbGVQbWRRMGlaelpVcnA1NmZDc3NSNHBZUk9uQzhkZGU3?=
 =?utf-8?B?MERnb3lFd0pZVXFVZEIvZ3BlN1pKMSs1Vk1wTFpvRTlQQ01tTFAvbXZqbDUx?=
 =?utf-8?B?Q1huclJLblU2WHpDR2hYYlJIdXo2K1N0Z0owRnl4c3hmNXA3T2dabG4yUlJH?=
 =?utf-8?B?dk1IWFAwb2hyL0xZNkVvTWlqZENwRHJTMmU1L0Zjd29Ed2hBcXFzYjBPKzZQ?=
 =?utf-8?B?QWUyNmI2aHM4K25MWk9JTWVWb3B4Lzd6VU1JMTRMTGZicVdSVEI5ZHVZRzR4?=
 =?utf-8?B?SDM3aU9nZERNc1ZIQk8zZmNidnpDUndRZG5aa285Mk1yZEZlNFBOTmVhNDhm?=
 =?utf-8?B?ZUZhZE9nVk5NaEFtUnBqVEJyTXArNll1SXpncDVLaGNyV08rTGlZb0pMR0R6?=
 =?utf-8?B?UkMwR2l0blloR0lCQXFNM041WHRqSi96MzRBUXFUWTlTYWkyR2wwK2JSTzM2?=
 =?utf-8?B?UHFJb1pDeHRxdlJZUTVYdHNHY0tEazhFVDRmNW96bDNNeDhweU83M1RMWlp6?=
 =?utf-8?B?NjUxei92NytJR3F1VjN3N2YvcHd5TCs1NXdKRFd2YWZZakEwb0V0Zm0wT291?=
 =?utf-8?B?MEhCUUc4dVZ3Z1dYTzVUcjY4cmoyNGszSnc1emxPS3l0SklEU3N5RS9lOExS?=
 =?utf-8?B?RDdoQTBublVXZUhXYlArV1lsNDlrOGNGN25tQ1NicGwxMThkSC9jdi9QbVkz?=
 =?utf-8?B?TFhUcmdSdk5jUHFzZmhONXh0UkRLMHg2RTlKbW90SVZZZWJ4L3lhb0dDc2E0?=
 =?utf-8?B?SnA2WHBVQVJTd2NRdFZGY3IrYmYyVXhkeU9XeXpJWWRQalVqQXduZmJrRU1Z?=
 =?utf-8?Q?Z6ESvSQMflplf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3500f3-903e-4685-87d9-08d8dda361ef
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 17:48:26.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwrMn6ZoAvNJJq2Zupf/b/1qUJUbzsjXlue0qQZqCOvLmwGXjIrF7nUeThME0hGBlYPwdF7DiJMk2YDNRddSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3271
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adding PCI mailing list per Bjorn's advise (sorry, skipped the address 
last time).

On 2021-03-02 12:22 p.m., Christian König wrote:
> Hi Andrey,
> 
>> Can you elaborate more why you need such a lock on a global level and not
>> enough per driver (per device more specifically) local lock acquired in
>> rescan_preapare (before BARs shuffling starts) and released in 
>> rescan_done
>> (after BARs shuffling done) ? 
> 
> because this adds inter device dependencies.
> 
> E.g. when we have device A, B and C and each is taking it's own lock we 
> end up with 3 locks.
> 
> If those device have inter dependencies on their own, for example 
> because of DMA-buf we will end up in quite a locking mess.
> 
> Apart from that if we don't always keep the order A, B, C but instead 
> end up with A, C, B lockdep will certainly start to complain.
> 
> Regards,
> Christian.

But as far as I understand those locks are agnostic to each other - each 
lock is taken only by it's respective device and not by others. So I 
don't see deadlock danger here but, I do suspect lockdep might throw a 
false warning...

Andrey

> 
> Am 02.03.21 um 18:16 schrieb Andrey Grodzovsky:
>> Per Bjorn's advise adding PCI mailing list.
>>
>> Christian, please reply on top of this mail and not on top the 
>> earlier, original one.
>>
>> Andrey
>>
>> On 2021-03-02 11:49 a.m., Bjorn Helgaas wrote:
>>> Please add linux-pci@vger.kernel.org to the cc list.  There's a lot of
>>> useful context in this thread and it needs to be archived.
>>> On Tue, Mar 02, 2021 at 11:37:25AM -0500, Andrey Grodzovsky wrote:
>>>> Adding Sergei and Bjorn since you are suggesting some PCI related 
>>>> changes.
>>>>
>>>> On 2021-03-02 6:28 a.m., Christian König wrote:
>>>>> Yeah, I'm thinking about that as well for quite a while now.
>>>>>
>>>>> I'm not 100% sure what Sergei does in his patch set will work for 
>>>>> us. He
>>>>> basically tells the driver to stop any processing then shuffle around
>>>>> the BARs and then tells him to start again.
>>>>>
>>>>> Because of the necessity to reprogram bridges there isn't much 
>>>>> other way
>>>>> how to do this, but we would need something like taking a lock,
>>>>> returning and dropping the lock later on. If you do this for multiple
>>>>> drivers at the same time this results in a locking nightmare.
>>>>>
>>>>> What we need instead is a upper level PCI layer rw-lock which we can
>>>>> take on the read side in the driver, similar to our internal reset 
>>>>> lock.
>>>>
>>>>
>>>> Can you elaborate more why you need such a lock on a global level 
>>>> and not
>>>> enough per driver (per device more specifically) local lock acquired in
>>>> rescan_preapare (before BARs shuffling starts) and released in 
>>>> rescan_done
>>>> (after BARs shuffling done) ?
>>>>
>>>> Andrey
>>>>
>>>>
>>>>>
>>>>> Wiring up changing the mapping is the smaller problem in that picture.
>>>>>
>>>>> Christian.
>>>>>
>>>>> Am 01.03.21 um 22:14 schrieb Andrey Grodzovsky:
>>>>>> Hi, I started looking into actual implementation for this, as
>>>>>> reference point I am using Sege's NVME implementations (see 
>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FYADRO-KNS%2Flinux%2Fcommit%2F58c375df086502538706ee23e8ef7c8bb5a4178f&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C44bc68a68feb4b71836c08d8dd9b306a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637503005898302093%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nuTptAjGewG2T7tXOQr2h%2Bdr42lyg3m1%2Bfv0mJzd8tw%3D&amp;reserved=0) 
>>>>>>
>>>>>> and our own amdgpu_device_resize_fb_bar. Our use case being more
>>>>>> complicated then NVME's arises some questions or thoughts:
>>>>>>
>>>>>> Before the PCI core will move the BARs (VRAM and registers) we have
>>>>>> to stop the HW and SW and then unmap all MMIO mapped entitles in the
>>>>>> driver. This includes, registers of all types and  VRAM placed BOs
>>>>>> with CPU visibility. My concern is how to prevent accesses to all
>>>>>> MMIO ranges between iounmap in rescan_preapare and ioremap in
>>>>>> rescan_done. For register accesses we are again back to same issue
>>>>>> we had with device unplug and GPU reset we are discussing with Denis
>>>>>> now. So here at least as first solution just to confirm the feature
>>>>>> works I can introduce low level (in register accessors) RW locking
>>>>>> to avoid access until all register access driver pointers are
>>>>>> remapped post BARs move. What more concerns me is how to - In
>>>>>> rescan_preapare: collect all CPU accessible BOs placed in VRAM (i
>>>>>> can use amdgpu specific list like I currently use for device
>>>>>> unplug), lock them to prevent any further use of them, unpin them
>>>>>> (and unmap). In rescan_preapare: remap them back and unlock them for
>>>>>> further use. Also, there is a difference between kernel BOs where
>>>>>> indeed iounmap, ioremap should be enough and user space mapped BOs
>>>>>> where it seems like in hot unplug, we need in rescan_preapare to
>>>>>> only unamp them, in between drop new page faults with VM_FAULT_RETRY
>>>>>> and post rescan_done allow page faults to go through to refill all
>>>>>> the user page tables with updated MMIO addresses.
>>>>>>
>>>>>> Let me know your thoughts.
>>>>>>
>>>>>> Andrey
>>>>>>
>>>>>> On 2021-02-26 4:03 p.m., Andrey Grodzovsky wrote:
>>>>>>>
>>>>>>> On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
>>>>>>>> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>>>>>>>>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>>>>>>>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>>>>>>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>>> ...
>>>>>>>>>>> Are you saying that even without hot-plugging, while both nvme
>>>>>>>>>>> and
>>>>>>>>>>> AMD
>>>>>>>>>>> card are present
>>>>>>>>>>> right from boot, you still get BARs moving and MMIO ranges
>>>>>>>>>>> reassigned
>>>>>>>>>>> for NVME BARs
>>>>>>>>>>> just because amdgpu driver will start resize of AMD card BARs 
>>>>>>>>>>> and
>>>>>>>>>>> this
>>>>>>>>>>> will trigger NVMEs BARs move to
>>>>>>>>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>>>>>>>>> Yes. Unconditionally, because it is unknown beforehand if NVMe's
>>>>>>>>>> BAR
>>>>>>>>>> movement will help. In this particular case BAR movement is not
>>>>>>>>>> needed,
>>>>>>>>>> but is done anyway.
>>>>>>>>>>
>>>>>>>>>> BARs are not moved one by one, but the kernel releases all the
>>>>>>>>>> releasable ones, and then recalculates a new BAR layout to fit 
>>>>>>>>>> them
>>>>>>>>>> all. Kernel's algorithm is different from BIOS's, so NVME has
>>>>>>>>>> appeared
>>>>>>>>>> at a new place.
>>>>>>>>>>
>>>>>>>>>> This is triggered by following:
>>>>>>>>>> - at boot, if BIOS had assigned not every BAR;
>>>>>>>>>> - during pci_resize_resource();
>>>>>>>>>> - during pci_rescan_bus() -- after a pciehp event or a manual via
>>>>>>>>>> sysfs.
>>>>>>>>> By manual via sysfs you mean something like this - 'echo 1 >
>>>>>>>>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>>>>>>>>> /sys/bus/pci/rescan ' ? I am looking into how most reliably 
>>>>>>>>> trigger
>>>>>>>>> PCI
>>>>>>>>> code to call my callbacks even without having external PCI cage 
>>>>>>>>> for
>>>>>>>>> GPU
>>>>>>>>> (will take me some time to get it).
>>>>>>>> Yeah, this is our way to go when a device can't be physically 
>>>>>>>> removed
>>>>>>>> or unpowered remotely. With just a bit shorter path:
>>>>>>>>
>>>>>>>>     sudo sh -c 'echo 1 > 
>>>>>>>> /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>>>>>>>>     sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
>>>>>>>>
>>>>>>>> Or, just a second command (rescan) is enough: a BAR movement 
>>>>>>>> attempt
>>>>>>>> will be triggered even if there were no changes in PCI topology.
>>>>>>>>
>>>>>>>> Serge
>>>>>>>
>>>>>>>
>>>>>>> Ok, able to trigger stub callbacks call after doing rescan from
>>>>>>> sysfs. Also I see BARs movement
>>>>>>>
>>>>>>> [ 1860.968036] amdgpu 0000:09:00.0: BAR 0: assigned [mem
>>>>>>> 0xc0000000-0xcfffffff 64bit pref]
>>>>>>> [ 1860.968050] amdgpu 0000:09:00.0: BAR 0 updated: 0xe0000000 ->
>>>>>>> 0xc0000000
>>>>>>> [ 1860.968054] amdgpu 0000:09:00.0: BAR 2: assigned [mem
>>>>>>> 0xd0000000-0xd01fffff 64bit pref]
>>>>>>> [ 1860.968068] amdgpu 0000:09:00.0: BAR 2 updated: 0xf0000000 ->
>>>>>>> 0xd0000000
>>>>>>> [ 1860.968071] amdgpu 0000:09:00.0: BAR 5: assigned [mem
>>>>>>> 0xf0100000-0xf013ffff]
>>>>>>> [ 1860.968078] amdgpu 0000:09:00.0: BAR 5 updated: 0xfce00000 ->
>>>>>>> 0xf0100000
>>>>>>>
>>>>>>> As expected, after the move the device becomes unresponsive as
>>>>>>> unmap/ioremap wasn't done.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>
> 
