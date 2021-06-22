Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CE53AFCB0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 07:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFVFcQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Jun 2021 01:32:16 -0400
Received: from mail-dm6nam12on2042.outbound.protection.outlook.com ([40.107.243.42]:62816
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229853AbhFVFcQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 01:32:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYPpUZq54p1/1QG6TmZv0IQW+0H3nN98hT17sgD54sxR8qVnpWHd2slHWEC/2L19J4aJo3CsMKwWrCm82hqsv2G11sEyCazRLjzRGv+g7xybbDWZhLyR4hHQDl81hSBl5xA5z0oDfOf9BXaAuV6o/NBJuG20gsE/temWmoiAgOCfh7GEL0tLxUtXaxCK2z4mROok6LLPLDE0Qd328php/dDVR2K/73Bh9y7iBzMvvhRsOrTyh/Qw7ngZn713RcwOepXqBCSMsByJ47hlkx7TJ2VNfqtsxa7X/uJMUadZmG4GYSQ6PAIqcGqA5aaRjMTIjpxqa6g74Oi2HjyP6YZx3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNKWM8gudmVZB7Nc03W6cpFEcwIgWncQDko+svHaOeA=;
 b=I/d8byY8l6mn3ul5+nOcOHOKxfrg5YwVtAjmClRs/4WqOM5QBzjis8PP4qXnsKdk5oaC5wSDHxiDxE5cybAVCt3iwqqyxWvj7mWUnjgQK/A6oc6faS7n9faErSJgK438OW1Ow4MR8DBOx3ZJpdIKhb3gIaSpa6TYg5/e8K8s5YB34CcygsJb+ZTWqOrQXocKcSeMfSH7HpoixUUy7YA/saTSWkMVKDGEDfDP82Bd6oEUf1a23amqP1ajFOVOpO3fRaxX0+4sexPY39oCsIirHEBJxhXDovAbAG44mOqcGWemiFku/aobaqcxS7fResjRwNHQQoQtgQC4tXvdR+Bmbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNKWM8gudmVZB7Nc03W6cpFEcwIgWncQDko+svHaOeA=;
 b=XBInVJGOxiov7M2jBbu68/9KgNAo0lPw9mhFLQmB7WghyYXh9R5x75TuwIxByVT/kyWG04yumIDVEhvAseUKqxECNi7ocvYPMygl9g4tzAX42JdGuFs0wap6Rbwlg+ggFW6fLE2YvS+nB2iIQokK9oVjNRwHE2167dWW7F44ccOu0DExHSyhhk2Ku8Hk3vnHlgdSX2gTjWvub0z9VdlWYrunhxQveAgiYQ1KQDdjdKxzcfB4ZeqdagHcRBsFTqw4pYdkM0zQfoA1nqin7cmcHzSbpwanAz2F4k0NjKm7NKyEYziPNHJ3Gxf+zhTumw60SHZnQEWTpomEFX53eBUDfw==
Received: from DS7PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:3bb::30)
 by BN9PR12MB5083.namprd12.prod.outlook.com (2603:10b6:408:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Tue, 22 Jun
 2021 05:29:59 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::75) by DS7PR03CA0085.outlook.office365.com
 (2603:10b6:5:3bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 22 Jun 2021 05:29:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 05:29:59 +0000
Received: from [10.25.73.60] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Jun
 2021 05:29:56 +0000
Subject: Re: [PATCH v2 2/5] PCI: endpoint: Replace spinlock with mutex
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Athani Nadeem Ladkhan" <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>
References: <20200212112514.2000-1-kishon@ti.com>
 <20200212112514.2000-3-kishon@ti.com>
 <901293cd-e67a-04a4-d61e-37a105c33d15@nvidia.com>
 <36aa4b00-0b3f-011a-4ade-1f79df983157@ti.com>
 <c5e5a847-fd2f-6a52-1587-03ac4f1c7ec4@nvidia.com>
 <5ce3b55b-3695-379a-1726-bf48aff3b4b9@ti.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <0dcc8f8e-4aab-4676-eb95-5f45b5cda1b2@nvidia.com>
Date:   Tue, 22 Jun 2021 10:59:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5ce3b55b-3695-379a-1726-bf48aff3b4b9@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f2775499-35fc-4bb5-8904-08d9353ec73a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5083:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5083F7E39B4B5152A787A57AB8099@BN9PR12MB5083.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Je3I6shRd+uqRXBBTsLGN2exi+hoyBywLLa1mSNWYHD761Y7r9Tr3tfhBY1ojD5GCm4kOIs5uxW2B89YNJSKXTP3w/pfl02Yz9+aw7kZv1REJ0TFXla+tjLMyqAyfC3Z3hSpd/OZOMmRwGHnE0wWQLs5LXmZmyOogaAlIBLE9Jtw+UpfFlTbhXw2UmxOU4LdqzDhLC78EdPLShApw/3oLdUBamgjU1qiDmSgJT+HorBUVmVvel5d+eq6IzoWVxX+/w5+F8VSKXKPajdizkqu2wrFmgh+eDBQNuIdAWPb89cU35F3EUSnX08P64HyRWuD1mfMWef9vYFHzBKeLkKKcK8j28k/zIjdfU8gcgk8mm1OO1SR0XpsQY4jCjO83ZarcUPZEMTD+mMDUeQc86Kubgef2LRRTnX2Wwvu34t/YcwLaqxBnwFY8g2MIwSo5P3kGRTgpbZiDu32Swx/rqZEGyIjuIx8Yj8gRNnZzanWWtMfwdkR4bta8R9aVJfWihpUN0oDP3IfO37uYxyTCtkoYh7F/tVxBH3vthV96AQ4IdPr57CyY7HpHWsfOWT1wVOBK2zSRGkMxw5exWvPmTAGEl/JVhwznimO8w+MQFg4f8o/3aRDfXWzBeJZ/YQVasurtgxB+f89OQx0qpZKlHsfMl1EUzeumnckHR9uW/jaoztJyzYbliIBWee4BHXkfCA
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36840700001)(46966006)(36860700001)(82310400003)(83380400001)(70586007)(107886003)(70206006)(30864003)(53546011)(8936002)(36906005)(86362001)(186003)(316002)(478600001)(31696002)(31686004)(16526019)(5660300002)(8676002)(54906003)(4326008)(16576012)(26005)(47076005)(6916009)(6666004)(36756003)(82740400003)(336012)(356005)(2616005)(2906002)(426003)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 05:29:59.5063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2775499-35fc-4bb5-8904-08d9353ec73a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5083
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 6/21/2021 7:07 PM, Kishon Vijay Abraham I wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Vidya Sagar,
> 
> On 21/06/21 3:08 pm, Vidya Sagar wrote:
>>
>>
>> On 6/21/2021 10:44 AM, Kishon Vijay Abraham I wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> Hi Vidya Sagar,
>>>
>>> On 11/06/21 3:22 pm, Vidya Sagar wrote:
>>>> Hi Kishon,
>>>> Apologies for bringup it up this late.
>>>> I'm wondering if there was any issue which this patch tried to address?
>>>
>>> There was one function pci_epc_linkup() which was expected to be invoked
>>> in interrupt context (basically when the LINKUP interrupt is raised).
>>> But after it was moved to use atomic notifier, all the EPC core APIs
>>> were replaced to use mutex.
>>>> Actually, "The pci_epc_ops is not intended to be invoked from interrupt
>>>> context" isn't true in case of Tegra194. We do call
>>>> dw_pcie_ep_init_notify() API from threaded irq service routine and it
>>>> eventually calls mutext_lock() of pci_epc_get_features() which is
>>>> reusulting in the following warning log.
>>>> BUG: sleeping function called from invalid context at
>>>> kernel/locking/mutex.c:
>>>> Would like hear your comments on it.
>> After reviewing the logs and code again, I think it was my mistake to
>> come to early conclusion that it was because of calling mutex_lock() in
>> the atomic context. It is clear now.
>>
>> I would like to understand the reason behind putting locks in the epc
>> core driver before calling ops.
> 
> There could be two different functions trying to configure endpoint
> controller (could be a multi-function endpoint) and the framework should
> guarantee the hardware is not accessed by both the functions simultaneously.
Not all ops functions need to be protected by the lock. for ex:- 
get/set_msi(x)(), raise_irq(), get_features() don't need to be protected 
by a global lock. So, transferring the synchronization responsibility to 
the controller driver gives an efficient control on locking.

> 
>> I believe the ops callers should implement lock if they are concurrently
>> accessing the ops instead of adding a global lock in the epc core.
> This can only protect within a function and not across multiple functions.
>> This would help in scenarios like the one below.
>>
>>      We have a performance oriented endpoint function driver which calls
>> map, unmap & raise_irq ops from softirq context and because of
>> mutex_lock(), we can't do that now. epc core driver should not restrict
>> the function drivers to use only non-atomic functions.
> 
> Not sure what exactly the function driver does but can't map/unmap be
> done for a big block once to optimize and operate on that buffer? I'd
> assume you are having a custom driver on the host side too?
We implemented a function driver that provides a virtual ethernet 
interface. To complement this, we have a PCIe device driver on the host 
that exposes a virtual ethernet interface in the host system. 
start_xmit() in the function driver of the virtual ethernet interface is 
a soft irq which maps/unmaps each skb buffer dynamically. So, a one time 
static mapping is not possible. Similarly, because of the global lock, 
start_xmit() can not raise_irq() to the host.

Thanks,
Vidya Sagar
> 
> Thanks
> Kishon
> 
>>
>> Thanks,
>> Vidya Sagar
>>>
>>> I don't think it is ideal to initialize EPC in interrupt context (unless
>>> there is a specific reason for it). EPC initialization can be moved to
>>> bottom half similar to how commands are handled after LINKUP.
>>
>>>
>>> Thanks
>>> Kishon
>>>
>>>>
>>>> Thanks,
>>>> Vidya Sagar
>>>>
>>>> On 2/12/2020 4:55 PM, Kishon Vijay Abraham I wrote:
>>>>> External email: Use caution opening links or attachments
>>>>>
>>>>>
>>>>> The pci_epc_ops is not intended to be invoked from interrupt context.
>>>>> Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
>>>>> mutex_lock and mutex_unlock respectively.
>>>>>
>>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>>> ---
>>>>>     drivers/pci/endpoint/pci-epc-core.c | 82
>>>>> +++++++++++------------------
>>>>>     include/linux/pci-epc.h             |  6 +--
>>>>>     2 files changed, 34 insertions(+), 54 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c
>>>>> b/drivers/pci/endpoint/pci-epc-core.c
>>>>> index 2f6436599fcb..e51a12ed85bb 100644
>>>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>>>> @@ -120,7 +120,6 @@ const struct pci_epc_features
>>>>> *pci_epc_get_features(struct pci_epc *epc,
>>>>>                                                        u8 func_no)
>>>>>     {
>>>>>            const struct pci_epc_features *epc_features;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>>                    return NULL;
>>>>> @@ -128,9 +127,9 @@ const struct pci_epc_features
>>>>> *pci_epc_get_features(struct pci_epc *epc,
>>>>>            if (!epc->ops->get_features)
>>>>>                    return NULL;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            epc_features = epc->ops->get_features(epc, func_no);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return epc_features;
>>>>>     }
>>>>> @@ -144,14 +143,12 @@ EXPORT_SYMBOL_GPL(pci_epc_get_features);
>>>>>      */
>>>>>     void pci_epc_stop(struct pci_epc *epc)
>>>>>     {
>>>>> -       unsigned long flags;
>>>>> -
>>>>>            if (IS_ERR(epc) || !epc->ops->stop)
>>>>>                    return;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            epc->ops->stop(epc);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(pci_epc_stop);
>>>>>
>>>>> @@ -164,7 +161,6 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
>>>>>     int pci_epc_start(struct pci_epc *epc)
>>>>>     {
>>>>>            int ret;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR(epc))
>>>>>                    return -EINVAL;
>>>>> @@ -172,9 +168,9 @@ int pci_epc_start(struct pci_epc *epc)
>>>>>            if (!epc->ops->start)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            ret = epc->ops->start(epc);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return ret;
>>>>>     }
>>>>> @@ -193,7 +189,6 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>                          enum pci_epc_irq_type type, u16 interrupt_num)
>>>>>     {
>>>>>            int ret;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>>                    return -EINVAL;
>>>>> @@ -201,9 +196,9 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>            if (!epc->ops->raise_irq)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return ret;
>>>>>     }
>>>>> @@ -219,7 +214,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
>>>>>     int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>>>>>     {
>>>>>            int interrupt;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>>                    return 0;
>>>>> @@ -227,9 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8
>>>>> func_no)
>>>>>            if (!epc->ops->get_msi)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            interrupt = epc->ops->get_msi(epc, func_no);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            if (interrupt < 0)
>>>>>                    return 0;
>>>>> @@ -252,7 +246,6 @@ int pci_epc_set_msi(struct pci_epc *epc, u8
>>>>> func_no, u8 interrupts)
>>>>>     {
>>>>>            int ret;
>>>>>            u8 encode_int;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>>>                interrupts > 32)
>>>>> @@ -263,9 +256,9 @@ int pci_epc_set_msi(struct pci_epc *epc, u8
>>>>> func_no, u8 interrupts)
>>>>>
>>>>>            encode_int = order_base_2(interrupts);
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            ret = epc->ops->set_msi(epc, func_no, encode_int);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return ret;
>>>>>     }
>>>>> @@ -281,7 +274,6 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
>>>>>     int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>>>>>     {
>>>>>            int interrupt;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>>                    return 0;
>>>>> @@ -289,9 +281,9 @@ int pci_epc_get_msix(struct pci_epc *epc, u8
>>>>> func_no)
>>>>>            if (!epc->ops->get_msix)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            interrupt = epc->ops->get_msix(epc, func_no);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            if (interrupt < 0)
>>>>>                    return 0;
>>>>> @@ -311,7 +303,6 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
>>>>>     int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16
>>>>> interrupts)
>>>>>     {
>>>>>            int ret;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>>>                interrupts < 1 || interrupts > 2048)
>>>>> @@ -320,9 +311,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8
>>>>> func_no, u16 interrupts)
>>>>>            if (!epc->ops->set_msix)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return ret;
>>>>>     }
>>>>> @@ -339,17 +330,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>>>>>     void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
>>>>>                            phys_addr_t phys_addr)
>>>>>     {
>>>>> -       unsigned long flags;
>>>>> -
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>>                    return;
>>>>>
>>>>>            if (!epc->ops->unmap_addr)
>>>>>                    return;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            epc->ops->unmap_addr(epc, func_no, phys_addr);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>>>>
>>>>> @@ -367,7 +356,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>                         phys_addr_t phys_addr, u64 pci_addr, size_t
>>>>> size)
>>>>>     {
>>>>>            int ret;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>>                    return -EINVAL;
>>>>> @@ -375,9 +363,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>            if (!epc->ops->map_addr)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr,
>>>>> size);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return ret;
>>>>>     }
>>>>> @@ -394,8 +382,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>>>>     void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>>>>>                           struct pci_epf_bar *epf_bar)
>>>>>     {
>>>>> -       unsigned long flags;
>>>>> -
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>>>                (epf_bar->barno == BAR_5 &&
>>>>>                 epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
>>>>> @@ -404,9 +390,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>            if (!epc->ops->clear_bar)
>>>>>                    return;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            epc->ops->clear_bar(epc, func_no, epf_bar);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
>>>>>
>>>>> @@ -422,7 +408,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>                        struct pci_epf_bar *epf_bar)
>>>>>     {
>>>>>            int ret;
>>>>> -       unsigned long irq_flags;
>>>>>            int flags = epf_bar->flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>>> @@ -437,9 +422,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>            if (!epc->ops->set_bar)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, irq_flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            ret = epc->ops->set_bar(epc, func_no, epf_bar);
>>>>> -       spin_unlock_irqrestore(&epc->lock, irq_flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return ret;
>>>>>     }
>>>>> @@ -460,7 +445,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>                             struct pci_epf_header *header)
>>>>>     {
>>>>>            int ret;
>>>>> -       unsigned long flags;
>>>>>
>>>>>            if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>>                    return -EINVAL;
>>>>> @@ -468,9 +452,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8
>>>>> func_no,
>>>>>            if (!epc->ops->write_header)
>>>>>                    return 0;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            ret = epc->ops->write_header(epc, func_no, header);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return ret;
>>>>>     }
>>>>> @@ -487,8 +471,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
>>>>>      */
>>>>>     int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
>>>>>     {
>>>>> -       unsigned long flags;
>>>>> -
>>>>>            if (epf->epc)
>>>>>                    return -EBUSY;
>>>>>
>>>>> @@ -500,9 +482,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct
>>>>> pci_epf *epf)
>>>>>
>>>>>            epf->epc = epc;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            list_add_tail(&epf->list, &epc->pci_epf);
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>
>>>>>            return 0;
>>>>>     }
>>>>> @@ -517,15 +499,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
>>>>>      */
>>>>>     void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>>>>>     {
>>>>> -       unsigned long flags;
>>>>> -
>>>>>            if (!epc || IS_ERR(epc) || !epf)
>>>>>                    return;
>>>>>
>>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>>> +       mutex_lock(&epc->lock);
>>>>>            list_del(&epf->list);
>>>>>            epf->epc = NULL;
>>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>>> +       mutex_unlock(&epc->lock);
>>>>>     }
>>>>>     EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>>>>>
>>>>> @@ -604,7 +584,7 @@ __pci_epc_create(struct device *dev, const struct
>>>>> pci_epc_ops *ops,
>>>>>                    goto err_ret;
>>>>>            }
>>>>>
>>>>> -       spin_lock_init(&epc->lock);
>>>>> +       mutex_init(&epc->lock);
>>>>>            INIT_LIST_HEAD(&epc->pci_epf);
>>>>>            ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
>>>>>
>>>>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>>>>> index 36644ccd32ac..9dd60f2e9705 100644
>>>>> --- a/include/linux/pci-epc.h
>>>>> +++ b/include/linux/pci-epc.h
>>>>> @@ -88,7 +88,7 @@ struct pci_epc_mem {
>>>>>      * @mem: address space of the endpoint controller
>>>>>      * @max_functions: max number of functions that can be configured in
>>>>> this EPC
>>>>>      * @group: configfs group representing the PCI EPC device
>>>>> - * @lock: spinlock to protect pci_epc ops
>>>>> + * @lock: mutex to protect pci_epc ops
>>>>>      * @notifier: used to notify EPF of any EPC events (like linkup)
>>>>>      */
>>>>>     struct pci_epc {
>>>>> @@ -98,8 +98,8 @@ struct pci_epc {
>>>>>            struct pci_epc_mem              *mem;
>>>>>            u8                              max_functions;
>>>>>            struct config_group             *group;
>>>>> -       /* spinlock to protect against concurrent access of EP
>>>>> controller */
>>>>> -       spinlock_t                      lock;
>>>>> +       /* mutex to protect against concurrent access of EP
>>>>> controller */
>>>>> +       struct mutex                    lock;
>>>>>            struct atomic_notifier_head     notifier;
>>>>>     };
>>>>>
>>>>> --
>>>>> 2.17.1
>>>>>
