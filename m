Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43C032C29C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Mar 2021 01:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238060AbhCCUzS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Mar 2021 15:55:18 -0500
Received: from mail-dm6nam12on2051.outbound.protection.outlook.com ([40.107.243.51]:59360
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238875AbhCCQGm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Mar 2021 11:06:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQriRHzs96DTHORspxlDq0WiPTTxAnVH5ZRHbch4WWZscm7b6H/Xy19IWZvhYrnhYzE5kXZ5I0+xb2rQu1oUjBI4/gRC7nrajUwxIkz7jjplX9NEvZbrXWzx/erODDl6cRWHfjfY6BahId348OR4Mc93RD4y7mH719q53BpvxiGI/lMNRM9kObAYoIQvhWOyhSXRDWcRsyiYm22tIJ0/wPBtjK6H1THsLhYsX2oMXyEKMk8y3vBtEwBvRuU5Ixmr0jy7VKK49zUaXRzs2cNZa0iEJ/dOphaxuImCE+qqRPqqy+ijFo0jinIzkat6vErXY8ctrXYux5GgUgixqY7Tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipdggJYV2ZVslegF8DxlCGdonLnHUzGj+52V+LT6eRw=;
 b=A/RTfRS+0CVyDDlnKB/j50AE/cc/ZzwzVODNgY2ZJz8kLnl4JiDAmhQSYp12DgsNoideWAdfYvn7pUu4VNazAXEq7Q2LUoWFzN8rYtR7HQLE8DL7IeZNMuV/4Qn3nXIfhDHSheWq9LqZKRKv0F6yCjK0T3TO9Cz4DoCRXnAkFFGsozVLjNrsHERXZOBQuWmfBlcc1F7wZuv4tWxC3l/K4nc9bA7O3rCkPvr1yxucDpEbCwsX/YNuf81uqbjODsgtXqtnUM4NbGEjdeOBzZ68RD1D9nvIEQB0euH/3YB+nmcUy2LnU+7QJbTnYKUGNWgR1h+l4YuHoEuimWKKieRGYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipdggJYV2ZVslegF8DxlCGdonLnHUzGj+52V+LT6eRw=;
 b=0drF4dyQJT+WY7p//Yubeq4MteX9dz63jtbvZuOcRKWhrHr7pfwYoW+BQ2NVtC0GVWuwnI/yXSR65vJV+U6q1875ZLGqUZbq0fidxu1wiy4PvesEpZWQdZ+yI0NawPqBfXx8oOnsWyG7ld6IS71gup9oEJsXi+ecZFSEyX/FTPc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2653.namprd12.prod.outlook.com (2603:10b6:805:6f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.24; Wed, 3 Mar
 2021 16:05:35 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::29cb:752d:a8a7:24a8%6]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 16:05:35 +0000
Subject: Re: Remapping BOs and registers post BAR movements [was - Re:
 Question about supporting AMD eGPU hot plug case]
From:   Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org
References: <20210302164944.GA424771@bjorn-Precision-5520>
 <81cc1a93-3a77-7ef7-c9f9-6083c1c313f7@amd.com>
 <5c2b2379-9961-c6f6-b343-b874cc22260f@amd.com>
 <6685096d-3c01-7f5a-58c5-70d139b61f6e@amd.com>
Message-ID: <0fda1f26-9b26-faee-8208-0fe1bf644935@amd.com>
Date:   Wed, 3 Mar 2021 11:05:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6685096d-3c01-7f5a-58c5-70d139b61f6e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2607:fea8:3edf:49b0:8fb:5c82:8f60:9be3]
X-ClientProxiedBy: YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24)
 To SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:8fb:5c82:8f60:9be3] (2607:fea8:3edf:49b0:8fb:5c82:8f60:9be3) by YT1PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28 via Frontend Transport; Wed, 3 Mar 2021 16:05:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 51bdb023-e0f9-4bed-ca91-08d8de5e2e05
X-MS-TrafficTypeDiagnostic: SN6PR12MB2653:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2653BD57D25799C67955A55AEA989@SN6PR12MB2653.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tFq+XWCBj/BWJjdFrR+AK7rS51zjRWd2IjOhlKPMK+8/4pb0vtbZ3bKN8g+Cirwe5TEtXRj0HQbSsizcTyMDTxJR9lvn97OUA+sZixlKel+pt+Gcc9dJmlDpd0u9/JroxwShacjz8/IPH7LkhG64PEXE0THURtmuOIaUkXJpAsNUfEkfjfpyyagRoATiOdQaio9O8LMMq9+VUsSWrlTRKy9l74w3P+WGV3nrTJDCX7e4EAzG+TPJG2py7LUkulMyfmeRlpeeXrzD9HDJmUXhpzOYfa1Ks3/PuYol6pciC1hzfJVfzPJ8pEHWf+G22GUuTx+0NRJZ0kHZGhSvGc6d55oBR7vMbz5kbzp7hXM/hSWRah/k46E/9AGCcAYJMUaKdiqcamVjs0GZ4tLj48Mz8JVj64uioZ2Lafwi67RikOrS1eEE4E3psHPVl+vZpYuQaxSy5AwEjU0SfSBjaRASo/4tDQsRW9bHlkkmID1XF8O9aGaYNRVnk6HjbK34/YdazjUzQyC+7L5a19evGU0Vda3uuCbbjUhnEq30VK+40vIoSGp+i6ZGvxd12tmQ2T026YTvv6gx7UPNl8oHddBWMtAsYmkBdlkCdhzNCCpEAfhO53v4NJurHJ4ZpDCEgoygoM/9VQuSlUxPZ1PhfvAE3D6SWKklbbOfT8UA682ybjXojwdgehsEbKWLMFnDid4V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4623.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(8936002)(52116002)(16526019)(186003)(478600001)(966005)(31686004)(66574015)(31696002)(316002)(54906003)(110136005)(4326008)(2906002)(83380400001)(45080400002)(86362001)(36756003)(2616005)(6486002)(66946007)(66476007)(44832011)(8676002)(66556008)(5660300002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NThISERobmlxRTU4eENlVFZ0SDhBVDZGdjJjeVV4VzJFeGdxRXhyU1lsaEp5?=
 =?utf-8?B?OGRMQzZ6MjRFcXFPY0pTSjBYQnl1Y2VTdEhkd1BZL29DRlpoQ0xtQk1ob1RG?=
 =?utf-8?B?R1Rhdm41all2WTZXRU0rWFVoaCtkSmp4S21NUnU3SC9WUjRPekdoZEI5Q2Zs?=
 =?utf-8?B?VUpFM3dLUUZWanBqd0JIWlVsYXNLeFc0U3dGdWVEbzRxcWZZcUMvbUhkVWdM?=
 =?utf-8?B?b2RnK0F3RUJpQUZaTG8zelMwZUxabzBvK3htOXl1bWIxN20yc2U1V2NJQThE?=
 =?utf-8?B?eThGRndjRzM5dDVva0lwR3dxZStJWmpZM0JvS1VIS2dpd3dBNnVEM0pIaFJi?=
 =?utf-8?B?YWQySE1BQ2ErR2RPQnNwVE1sMzJrODhFMUJ5WGFUUkdxQW9NQWtWWWZlcGYy?=
 =?utf-8?B?MHh1M0tRNGlLdUs3eEpKUWpFcmNxNFpnMS8zdEhNbW02Z2tNcVJqSWtWc2N6?=
 =?utf-8?B?VjNIUEdzbWx1ZWI5NDdnNDlWSStlbSt2V0krajFjYVpRbWwvdk5rTDVmRm1M?=
 =?utf-8?B?OEthRCswNXcwbUdxaG51TExVeFhuc28zVUNxTFhhVk0vUnlPS0tCZkdGVHlR?=
 =?utf-8?B?L2ZabTlWSkppL0FZU0IwYWVHUWxCOFZQMDN4ZlpMMlBXRkdGWEFMWUJaN2ZF?=
 =?utf-8?B?TCtraEJ0NW5lRDBhVjhIRHhkNDFRTmlRNEFUbUlvTEpoSnlGbDdKRE1rSkp6?=
 =?utf-8?B?am83Y2NNTnJ1WkVwcVYweUVlMVRNSGxQVjIwWUIxTTNoZGxlNFl6NjZWNGtq?=
 =?utf-8?B?bmZNN3hCanVOOFI2dUdhaFhHbWViVTdNdnJRODFkMDVwdVNqZFh4MThXY25L?=
 =?utf-8?B?K0N1THlXWE1QVVVYSVFXaDYvSFAwQkZmbHA2WnhpK3BsaS8zajg4N0JSZjE5?=
 =?utf-8?B?STR6SFgxWjRvVWg5dFRESDRZSXhSdFpwVlRKUGhLMnpJek90NEl4NElMTXFG?=
 =?utf-8?B?SUFieGxSbXRBZVNkdHN6cUVmek1MT3dacGZ4ZnNIN25SY1U2anJINUEvbGtS?=
 =?utf-8?B?NExvd0xLYi9SRDJZMzdkd0RINjdXRWRUL3djYnRReDZ1eUpFQlVjTTNMQUcr?=
 =?utf-8?B?Q3AzWHNKUHdxeHYwMDdYdXZLSlpMT09pYmxFQjJyeFRvbGFtaVZobXpWQzlu?=
 =?utf-8?B?NXN4eFhaZzhtekZ1amlUeEgvQ2IweUdKVUEwMm9BR3RUWWhIa1hKaUYyZ0Ru?=
 =?utf-8?B?Zk9UK2tKeHBSUSsySGd3cTlUbEdLYkI1aEpDeldWYlo5YTNzcHhDQ1dWQ1B5?=
 =?utf-8?B?SzZuK3VkcTJxTmVkdE50VFprMFdnY2lJbGVtdFR3UTFxYkJkell5UTBsRTRr?=
 =?utf-8?B?Q1JLZmkwZHFiK0R5eDhjNWlyQ244WjcwRjFmVGo0R0VqZ1VXaVV6TDM4Qkpw?=
 =?utf-8?B?MXRydWFhQUc0RXNBZmZKaGtuR1VRMncvdGNwSXkvQWlqVnBPRUVNTENhcFZt?=
 =?utf-8?B?SVl0cjNORllhK1dCcXBnSVBZd1pXaXEyazJHOUVUZ0dwclNOVUx2Wjh6STdT?=
 =?utf-8?B?ZU9USDBmb3ZGUm03TllKeXRiRW1XUE1CaUJ1b0ovcTRjaDJ2eDJYbk5xWVhW?=
 =?utf-8?B?d0tGVy9rZlE0Z1pXUy9tcndFdDlmYTRjTE9xUU5EUkNmTm91ZVN0VDJjNXJO?=
 =?utf-8?B?SnVGR1VFNVVNTm9vdUpyOTgxRWphUkN1SkVXZjlReVBMdzZaUHhYUDJ0YVI4?=
 =?utf-8?B?Y3VlUUxmUDhXaXphR2s1VGRXcm15eFhXdmtYd3J2K2dtcCtLMUFqRzhRKzh6?=
 =?utf-8?B?eWNlejE1QURxTHA5bTBwOTZWWW1aUjdPZ2w2aEtmMGE2aGJWYTdXUkhycHl5?=
 =?utf-8?B?SHpPYnQzUEJKenNyV0poZmRKRHhrMHh4eFhYVTRGWEYrRldscXNKVlNtQW9u?=
 =?utf-8?Q?wxipE7XO2b7+X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51bdb023-e0f9-4bed-ca91-08d8de5e2e05
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 16:05:35.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nH+en61n7y+0c5NZqa0bIkJ/PwK9nJ32JKswPpm8qeqoj6PIfkoDVdGHPHRR8VNz/gmLybdJ9KkKwULJ7wJ/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2653
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping

Andrey

On 2021-03-02 12:48 p.m., Andrey Grodzovsky wrote:
> Adding PCI mailing list per Bjorn's advise (sorry, skipped the address 
> last time).
> 
> On 2021-03-02 12:22 p.m., Christian König wrote:
>> Hi Andrey,
>>
>>> Can you elaborate more why you need such a lock on a global level and 
>>> not
>>> enough per driver (per device more specifically) local lock acquired in
>>> rescan_preapare (before BARs shuffling starts) and released in 
>>> rescan_done
>>> (after BARs shuffling done) ? 
>>
>> because this adds inter device dependencies.
>>
>> E.g. when we have device A, B and C and each is taking it's own lock 
>> we end up with 3 locks.
>>
>> If those device have inter dependencies on their own, for example 
>> because of DMA-buf we will end up in quite a locking mess.
>>
>> Apart from that if we don't always keep the order A, B, C but instead 
>> end up with A, C, B lockdep will certainly start to complain.
>>
>> Regards,
>> Christian.
> 
> But as far as I understand those locks are agnostic to each other - each 
> lock is taken only by it's respective device and not by others. So I 
> don't see deadlock danger here but, I do suspect lockdep might throw a 
> false warning...
> 
> Andrey
> 
>>
>> Am 02.03.21 um 18:16 schrieb Andrey Grodzovsky:
>>> Per Bjorn's advise adding PCI mailing list.
>>>
>>> Christian, please reply on top of this mail and not on top the 
>>> earlier, original one.
>>>
>>> Andrey
>>>
>>> On 2021-03-02 11:49 a.m., Bjorn Helgaas wrote:
>>>> Please add linux-pci@vger.kernel.org to the cc list.  There's a lot of
>>>> useful context in this thread and it needs to be archived.
>>>> On Tue, Mar 02, 2021 at 11:37:25AM -0500, Andrey Grodzovsky wrote:
>>>>> Adding Sergei and Bjorn since you are suggesting some PCI related 
>>>>> changes.
>>>>>
>>>>> On 2021-03-02 6:28 a.m., Christian König wrote:
>>>>>> Yeah, I'm thinking about that as well for quite a while now.
>>>>>>
>>>>>> I'm not 100% sure what Sergei does in his patch set will work for 
>>>>>> us. He
>>>>>> basically tells the driver to stop any processing then shuffle around
>>>>>> the BARs and then tells him to start again.
>>>>>>
>>>>>> Because of the necessity to reprogram bridges there isn't much 
>>>>>> other way
>>>>>> how to do this, but we would need something like taking a lock,
>>>>>> returning and dropping the lock later on. If you do this for multiple
>>>>>> drivers at the same time this results in a locking nightmare.
>>>>>>
>>>>>> What we need instead is a upper level PCI layer rw-lock which we can
>>>>>> take on the read side in the driver, similar to our internal reset 
>>>>>> lock.
>>>>>
>>>>>
>>>>> Can you elaborate more why you need such a lock on a global level 
>>>>> and not
>>>>> enough per driver (per device more specifically) local lock 
>>>>> acquired in
>>>>> rescan_preapare (before BARs shuffling starts) and released in 
>>>>> rescan_done
>>>>> (after BARs shuffling done) ?
>>>>>
>>>>> Andrey
>>>>>
>>>>>
>>>>>>
>>>>>> Wiring up changing the mapping is the smaller problem in that 
>>>>>> picture.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>>> Am 01.03.21 um 22:14 schrieb Andrey Grodzovsky:
>>>>>>> Hi, I started looking into actual implementation for this, as
>>>>>>> reference point I am using Sege's NVME implementations (see 
>>>>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2FYADRO-KNS%2Flinux%2Fcommit%2F58c375df086502538706ee23e8ef7c8bb5a4178f&amp;data=04%7C01%7Candrey.grodzovsky%40amd.com%7C44bc68a68feb4b71836c08d8dd9b306a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637503005898302093%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nuTptAjGewG2T7tXOQr2h%2Bdr42lyg3m1%2Bfv0mJzd8tw%3D&amp;reserved=0) 
>>>>>>>
>>>>>>> and our own amdgpu_device_resize_fb_bar. Our use case being more
>>>>>>> complicated then NVME's arises some questions or thoughts:
>>>>>>>
>>>>>>> Before the PCI core will move the BARs (VRAM and registers) we have
>>>>>>> to stop the HW and SW and then unmap all MMIO mapped entitles in the
>>>>>>> driver. This includes, registers of all types and  VRAM placed BOs
>>>>>>> with CPU visibility. My concern is how to prevent accesses to all
>>>>>>> MMIO ranges between iounmap in rescan_preapare and ioremap in
>>>>>>> rescan_done. For register accesses we are again back to same issue
>>>>>>> we had with device unplug and GPU reset we are discussing with Denis
>>>>>>> now. So here at least as first solution just to confirm the feature
>>>>>>> works I can introduce low level (in register accessors) RW locking
>>>>>>> to avoid access until all register access driver pointers are
>>>>>>> remapped post BARs move. What more concerns me is how to - In
>>>>>>> rescan_preapare: collect all CPU accessible BOs placed in VRAM (i
>>>>>>> can use amdgpu specific list like I currently use for device
>>>>>>> unplug), lock them to prevent any further use of them, unpin them
>>>>>>> (and unmap). In rescan_preapare: remap them back and unlock them for
>>>>>>> further use. Also, there is a difference between kernel BOs where
>>>>>>> indeed iounmap, ioremap should be enough and user space mapped BOs
>>>>>>> where it seems like in hot unplug, we need in rescan_preapare to
>>>>>>> only unamp them, in between drop new page faults with VM_FAULT_RETRY
>>>>>>> and post rescan_done allow page faults to go through to refill all
>>>>>>> the user page tables with updated MMIO addresses.
>>>>>>>
>>>>>>> Let me know your thoughts.
>>>>>>>
>>>>>>> Andrey
>>>>>>>
>>>>>>> On 2021-02-26 4:03 p.m., Andrey Grodzovsky wrote:
>>>>>>>>
>>>>>>>> On 2021-02-26 1:44 a.m., Sergei Miroshnichenko wrote:
>>>>>>>>> On Thu, 2021-02-25 at 13:28 -0500, Andrey Grodzovsky wrote:
>>>>>>>>>> On 2021-02-25 2:00 a.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>> On Wed, 2021-02-24 at 17:51 -0500, Andrey Grodzovsky wrote:
>>>>>>>>>>>> On 2021-02-24 1:23 p.m., Sergei Miroshnichenko wrote:
>>>>>>>>>>>>> ...
>>>>>>>>>>>> Are you saying that even without hot-plugging, while both nvme
>>>>>>>>>>>> and
>>>>>>>>>>>> AMD
>>>>>>>>>>>> card are present
>>>>>>>>>>>> right from boot, you still get BARs moving and MMIO ranges
>>>>>>>>>>>> reassigned
>>>>>>>>>>>> for NVME BARs
>>>>>>>>>>>> just because amdgpu driver will start resize of AMD card 
>>>>>>>>>>>> BARs and
>>>>>>>>>>>> this
>>>>>>>>>>>> will trigger NVMEs BARs move to
>>>>>>>>>>>> allow AMD card BARs to cover full range of VIDEO RAM ?
>>>>>>>>>>> Yes. Unconditionally, because it is unknown beforehand if NVMe's
>>>>>>>>>>> BAR
>>>>>>>>>>> movement will help. In this particular case BAR movement is not
>>>>>>>>>>> needed,
>>>>>>>>>>> but is done anyway.
>>>>>>>>>>>
>>>>>>>>>>> BARs are not moved one by one, but the kernel releases all the
>>>>>>>>>>> releasable ones, and then recalculates a new BAR layout to 
>>>>>>>>>>> fit them
>>>>>>>>>>> all. Kernel's algorithm is different from BIOS's, so NVME has
>>>>>>>>>>> appeared
>>>>>>>>>>> at a new place.
>>>>>>>>>>>
>>>>>>>>>>> This is triggered by following:
>>>>>>>>>>> - at boot, if BIOS had assigned not every BAR;
>>>>>>>>>>> - during pci_resize_resource();
>>>>>>>>>>> - during pci_rescan_bus() -- after a pciehp event or a manual 
>>>>>>>>>>> via
>>>>>>>>>>> sysfs.
>>>>>>>>>> By manual via sysfs you mean something like this - 'echo 1 >
>>>>>>>>>> /sys/bus/pci/drivers/amdgpu/0000\:0c\:00.0/remove && echo 1 >
>>>>>>>>>> /sys/bus/pci/rescan ' ? I am looking into how most reliably 
>>>>>>>>>> trigger
>>>>>>>>>> PCI
>>>>>>>>>> code to call my callbacks even without having external PCI 
>>>>>>>>>> cage for
>>>>>>>>>> GPU
>>>>>>>>>> (will take me some time to get it).
>>>>>>>>> Yeah, this is our way to go when a device can't be physically 
>>>>>>>>> removed
>>>>>>>>> or unpowered remotely. With just a bit shorter path:
>>>>>>>>>
>>>>>>>>>     sudo sh -c 'echo 1 > 
>>>>>>>>> /sys/bus/pci/devices/0000\:0c\:00.0/remove'
>>>>>>>>>     sudo sh -c 'echo 1 > /sys/bus/pci/rescan'
>>>>>>>>>
>>>>>>>>> Or, just a second command (rescan) is enough: a BAR movement 
>>>>>>>>> attempt
>>>>>>>>> will be triggered even if there were no changes in PCI topology.
>>>>>>>>>
>>>>>>>>> Serge
>>>>>>>>
>>>>>>>>
>>>>>>>> Ok, able to trigger stub callbacks call after doing rescan from
>>>>>>>> sysfs. Also I see BARs movement
>>>>>>>>
>>>>>>>> [ 1860.968036] amdgpu 0000:09:00.0: BAR 0: assigned [mem
>>>>>>>> 0xc0000000-0xcfffffff 64bit pref]
>>>>>>>> [ 1860.968050] amdgpu 0000:09:00.0: BAR 0 updated: 0xe0000000 ->
>>>>>>>> 0xc0000000
>>>>>>>> [ 1860.968054] amdgpu 0000:09:00.0: BAR 2: assigned [mem
>>>>>>>> 0xd0000000-0xd01fffff 64bit pref]
>>>>>>>> [ 1860.968068] amdgpu 0000:09:00.0: BAR 2 updated: 0xf0000000 ->
>>>>>>>> 0xd0000000
>>>>>>>> [ 1860.968071] amdgpu 0000:09:00.0: BAR 5: assigned [mem
>>>>>>>> 0xf0100000-0xf013ffff]
>>>>>>>> [ 1860.968078] amdgpu 0000:09:00.0: BAR 5 updated: 0xfce00000 ->
>>>>>>>> 0xf0100000
>>>>>>>>
>>>>>>>> As expected, after the move the device becomes unresponsive as
>>>>>>>> unmap/ioremap wasn't done.
>>>>>>>>
>>>>>>>> Andrey
>>>>>>>>
>>>>>>
>>
