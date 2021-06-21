Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893563AEA23
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 15:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhFUNj7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 09:39:59 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:58842 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhFUNj6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 09:39:58 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 15LDbbfa102899;
        Mon, 21 Jun 2021 08:37:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1624282657;
        bh=eE1F45aQZUGB7cb7ntkCmVTYy4JwRVis9ZghTxExECc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=c6CsiRKSud77lgXQVNyzN6UtPJS5lOE/nJx8FTwmN75pkLJQj1QkOWICVTGTp+C9f
         cWiny+c+0GZxtvBMZZyNSRsfra/rLT2q/oj4tInA7YSE1JB1D/Op4MNPNpr6DQ6Avo
         2tAi8paxd2WaZhz695aukBIwIGrapTo0fPeNhAho=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 15LDbbVK129469
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jun 2021 08:37:37 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 21
 Jun 2021 08:37:37 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 21 Jun 2021 08:37:37 -0500
Received: from [10.250.235.194] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 15LDbVc6017708;
        Mon, 21 Jun 2021 08:37:33 -0500
Subject: Re: [PATCH v2 2/5] PCI: endpoint: Replace spinlock with mutex
To:     Vidya Sagar <vidyas@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Athani Nadeem Ladkhan <nadeem@cadence.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Krishna Thota <kthota@nvidia.com>
References: <20200212112514.2000-1-kishon@ti.com>
 <20200212112514.2000-3-kishon@ti.com>
 <901293cd-e67a-04a4-d61e-37a105c33d15@nvidia.com>
 <36aa4b00-0b3f-011a-4ade-1f79df983157@ti.com>
 <c5e5a847-fd2f-6a52-1587-03ac4f1c7ec4@nvidia.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <5ce3b55b-3695-379a-1726-bf48aff3b4b9@ti.com>
Date:   Mon, 21 Jun 2021 19:07:31 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c5e5a847-fd2f-6a52-1587-03ac4f1c7ec4@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya Sagar,

On 21/06/21 3:08 pm, Vidya Sagar wrote:
> 
> 
> On 6/21/2021 10:44 AM, Kishon Vijay Abraham I wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hi Vidya Sagar,
>>
>> On 11/06/21 3:22 pm, Vidya Sagar wrote:
>>> Hi Kishon,
>>> Apologies for bringup it up this late.
>>> I'm wondering if there was any issue which this patch tried to address?
>>
>> There was one function pci_epc_linkup() which was expected to be invoked
>> in interrupt context (basically when the LINKUP interrupt is raised).
>> But after it was moved to use atomic notifier, all the EPC core APIs
>> were replaced to use mutex.
>>> Actually, "The pci_epc_ops is not intended to be invoked from interrupt
>>> context" isn't true in case of Tegra194. We do call
>>> dw_pcie_ep_init_notify() API from threaded irq service routine and it
>>> eventually calls mutext_lock() of pci_epc_get_features() which is
>>> reusulting in the following warning log.
>>> BUG: sleeping function called from invalid context at
>>> kernel/locking/mutex.c:
>>> Would like hear your comments on it.
> After reviewing the logs and code again, I think it was my mistake to
> come to early conclusion that it was because of calling mutex_lock() in
> the atomic context. It is clear now.
> 
> I would like to understand the reason behind putting locks in the epc
> core driver before calling ops.

There could be two different functions trying to configure endpoint
controller (could be a multi-function endpoint) and the framework should
guarantee the hardware is not accessed by both the functions simultaneously.

> I believe the ops callers should implement lock if they are concurrently
> accessing the ops instead of adding a global lock in the epc core.
This can only protect within a function and not across multiple functions.
> This would help in scenarios like the one below.
> 
>     We have a performance oriented endpoint function driver which calls
> map, unmap & raise_irq ops from softirq context and because of
> mutex_lock(), we can't do that now. epc core driver should not restrict
> the function drivers to use only non-atomic functions.

Not sure what exactly the function driver does but can't map/unmap be
done for a big block once to optimize and operate on that buffer? I'd
assume you are having a custom driver on the host side too?

Thanks
Kishon

> 
> Thanks,
> Vidya Sagar
>>
>> I don't think it is ideal to initialize EPC in interrupt context (unless
>> there is a specific reason for it). EPC initialization can be moved to
>> bottom half similar to how commands are handled after LINKUP.
> 
>>
>> Thanks
>> Kishon
>>
>>>
>>> Thanks,
>>> Vidya Sagar
>>>
>>> On 2/12/2020 4:55 PM, Kishon Vijay Abraham I wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> The pci_epc_ops is not intended to be invoked from interrupt context.
>>>> Hence replace spin_lock_irqsave and spin_unlock_irqrestore with
>>>> mutex_lock and mutex_unlock respectively.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>    drivers/pci/endpoint/pci-epc-core.c | 82
>>>> +++++++++++------------------
>>>>    include/linux/pci-epc.h             |  6 +--
>>>>    2 files changed, 34 insertions(+), 54 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/endpoint/pci-epc-core.c
>>>> b/drivers/pci/endpoint/pci-epc-core.c
>>>> index 2f6436599fcb..e51a12ed85bb 100644
>>>> --- a/drivers/pci/endpoint/pci-epc-core.c
>>>> +++ b/drivers/pci/endpoint/pci-epc-core.c
>>>> @@ -120,7 +120,6 @@ const struct pci_epc_features
>>>> *pci_epc_get_features(struct pci_epc *epc,
>>>>                                                       u8 func_no)
>>>>    {
>>>>           const struct pci_epc_features *epc_features;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>                   return NULL;
>>>> @@ -128,9 +127,9 @@ const struct pci_epc_features
>>>> *pci_epc_get_features(struct pci_epc *epc,
>>>>           if (!epc->ops->get_features)
>>>>                   return NULL;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           epc_features = epc->ops->get_features(epc, func_no);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return epc_features;
>>>>    }
>>>> @@ -144,14 +143,12 @@ EXPORT_SYMBOL_GPL(pci_epc_get_features);
>>>>     */
>>>>    void pci_epc_stop(struct pci_epc *epc)
>>>>    {
>>>> -       unsigned long flags;
>>>> -
>>>>           if (IS_ERR(epc) || !epc->ops->stop)
>>>>                   return;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           epc->ops->stop(epc);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_epc_stop);
>>>>
>>>> @@ -164,7 +161,6 @@ EXPORT_SYMBOL_GPL(pci_epc_stop);
>>>>    int pci_epc_start(struct pci_epc *epc)
>>>>    {
>>>>           int ret;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR(epc))
>>>>                   return -EINVAL;
>>>> @@ -172,9 +168,9 @@ int pci_epc_start(struct pci_epc *epc)
>>>>           if (!epc->ops->start)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           ret = epc->ops->start(epc);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return ret;
>>>>    }
>>>> @@ -193,7 +189,6 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8
>>>> func_no,
>>>>                         enum pci_epc_irq_type type, u16 interrupt_num)
>>>>    {
>>>>           int ret;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>                   return -EINVAL;
>>>> @@ -201,9 +196,9 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8
>>>> func_no,
>>>>           if (!epc->ops->raise_irq)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           ret = epc->ops->raise_irq(epc, func_no, type, interrupt_num);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return ret;
>>>>    }
>>>> @@ -219,7 +214,6 @@ EXPORT_SYMBOL_GPL(pci_epc_raise_irq);
>>>>    int pci_epc_get_msi(struct pci_epc *epc, u8 func_no)
>>>>    {
>>>>           int interrupt;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>                   return 0;
>>>> @@ -227,9 +221,9 @@ int pci_epc_get_msi(struct pci_epc *epc, u8
>>>> func_no)
>>>>           if (!epc->ops->get_msi)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           interrupt = epc->ops->get_msi(epc, func_no);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           if (interrupt < 0)
>>>>                   return 0;
>>>> @@ -252,7 +246,6 @@ int pci_epc_set_msi(struct pci_epc *epc, u8
>>>> func_no, u8 interrupts)
>>>>    {
>>>>           int ret;
>>>>           u8 encode_int;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>>               interrupts > 32)
>>>> @@ -263,9 +256,9 @@ int pci_epc_set_msi(struct pci_epc *epc, u8
>>>> func_no, u8 interrupts)
>>>>
>>>>           encode_int = order_base_2(interrupts);
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           ret = epc->ops->set_msi(epc, func_no, encode_int);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return ret;
>>>>    }
>>>> @@ -281,7 +274,6 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msi);
>>>>    int pci_epc_get_msix(struct pci_epc *epc, u8 func_no)
>>>>    {
>>>>           int interrupt;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>                   return 0;
>>>> @@ -289,9 +281,9 @@ int pci_epc_get_msix(struct pci_epc *epc, u8
>>>> func_no)
>>>>           if (!epc->ops->get_msix)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           interrupt = epc->ops->get_msix(epc, func_no);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           if (interrupt < 0)
>>>>                   return 0;
>>>> @@ -311,7 +303,6 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
>>>>    int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u16
>>>> interrupts)
>>>>    {
>>>>           int ret;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>>               interrupts < 1 || interrupts > 2048)
>>>> @@ -320,9 +311,9 @@ int pci_epc_set_msix(struct pci_epc *epc, u8
>>>> func_no, u16 interrupts)
>>>>           if (!epc->ops->set_msix)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           ret = epc->ops->set_msix(epc, func_no, interrupts - 1);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return ret;
>>>>    }
>>>> @@ -339,17 +330,15 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
>>>>    void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no,
>>>>                           phys_addr_t phys_addr)
>>>>    {
>>>> -       unsigned long flags;
>>>> -
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>                   return;
>>>>
>>>>           if (!epc->ops->unmap_addr)
>>>>                   return;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           epc->ops->unmap_addr(epc, func_no, phys_addr);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_epc_unmap_addr);
>>>>
>>>> @@ -367,7 +356,6 @@ int pci_epc_map_addr(struct pci_epc *epc, u8
>>>> func_no,
>>>>                        phys_addr_t phys_addr, u64 pci_addr, size_t
>>>> size)
>>>>    {
>>>>           int ret;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>                   return -EINVAL;
>>>> @@ -375,9 +363,9 @@ int pci_epc_map_addr(struct pci_epc *epc, u8
>>>> func_no,
>>>>           if (!epc->ops->map_addr)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           ret = epc->ops->map_addr(epc, func_no, phys_addr, pci_addr,
>>>> size);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return ret;
>>>>    }
>>>> @@ -394,8 +382,6 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
>>>>    void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no,
>>>>                          struct pci_epf_bar *epf_bar)
>>>>    {
>>>> -       unsigned long flags;
>>>> -
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>>               (epf_bar->barno == BAR_5 &&
>>>>                epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
>>>> @@ -404,9 +390,9 @@ void pci_epc_clear_bar(struct pci_epc *epc, u8
>>>> func_no,
>>>>           if (!epc->ops->clear_bar)
>>>>                   return;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           epc->ops->clear_bar(epc, func_no, epf_bar);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
>>>>
>>>> @@ -422,7 +408,6 @@ int pci_epc_set_bar(struct pci_epc *epc, u8
>>>> func_no,
>>>>                       struct pci_epf_bar *epf_bar)
>>>>    {
>>>>           int ret;
>>>> -       unsigned long irq_flags;
>>>>           int flags = epf_bar->flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
>>>> @@ -437,9 +422,9 @@ int pci_epc_set_bar(struct pci_epc *epc, u8
>>>> func_no,
>>>>           if (!epc->ops->set_bar)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, irq_flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           ret = epc->ops->set_bar(epc, func_no, epf_bar);
>>>> -       spin_unlock_irqrestore(&epc->lock, irq_flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return ret;
>>>>    }
>>>> @@ -460,7 +445,6 @@ int pci_epc_write_header(struct pci_epc *epc, u8
>>>> func_no,
>>>>                            struct pci_epf_header *header)
>>>>    {
>>>>           int ret;
>>>> -       unsigned long flags;
>>>>
>>>>           if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
>>>>                   return -EINVAL;
>>>> @@ -468,9 +452,9 @@ int pci_epc_write_header(struct pci_epc *epc, u8
>>>> func_no,
>>>>           if (!epc->ops->write_header)
>>>>                   return 0;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           ret = epc->ops->write_header(epc, func_no, header);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return ret;
>>>>    }
>>>> @@ -487,8 +471,6 @@ EXPORT_SYMBOL_GPL(pci_epc_write_header);
>>>>     */
>>>>    int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf)
>>>>    {
>>>> -       unsigned long flags;
>>>> -
>>>>           if (epf->epc)
>>>>                   return -EBUSY;
>>>>
>>>> @@ -500,9 +482,9 @@ int pci_epc_add_epf(struct pci_epc *epc, struct
>>>> pci_epf *epf)
>>>>
>>>>           epf->epc = epc;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           list_add_tail(&epf->list, &epc->pci_epf);
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>
>>>>           return 0;
>>>>    }
>>>> @@ -517,15 +499,13 @@ EXPORT_SYMBOL_GPL(pci_epc_add_epf);
>>>>     */
>>>>    void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf)
>>>>    {
>>>> -       unsigned long flags;
>>>> -
>>>>           if (!epc || IS_ERR(epc) || !epf)
>>>>                   return;
>>>>
>>>> -       spin_lock_irqsave(&epc->lock, flags);
>>>> +       mutex_lock(&epc->lock);
>>>>           list_del(&epf->list);
>>>>           epf->epc = NULL;
>>>> -       spin_unlock_irqrestore(&epc->lock, flags);
>>>> +       mutex_unlock(&epc->lock);
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
>>>>
>>>> @@ -604,7 +584,7 @@ __pci_epc_create(struct device *dev, const struct
>>>> pci_epc_ops *ops,
>>>>                   goto err_ret;
>>>>           }
>>>>
>>>> -       spin_lock_init(&epc->lock);
>>>> +       mutex_init(&epc->lock);
>>>>           INIT_LIST_HEAD(&epc->pci_epf);
>>>>           ATOMIC_INIT_NOTIFIER_HEAD(&epc->notifier);
>>>>
>>>> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
>>>> index 36644ccd32ac..9dd60f2e9705 100644
>>>> --- a/include/linux/pci-epc.h
>>>> +++ b/include/linux/pci-epc.h
>>>> @@ -88,7 +88,7 @@ struct pci_epc_mem {
>>>>     * @mem: address space of the endpoint controller
>>>>     * @max_functions: max number of functions that can be configured in
>>>> this EPC
>>>>     * @group: configfs group representing the PCI EPC device
>>>> - * @lock: spinlock to protect pci_epc ops
>>>> + * @lock: mutex to protect pci_epc ops
>>>>     * @notifier: used to notify EPF of any EPC events (like linkup)
>>>>     */
>>>>    struct pci_epc {
>>>> @@ -98,8 +98,8 @@ struct pci_epc {
>>>>           struct pci_epc_mem              *mem;
>>>>           u8                              max_functions;
>>>>           struct config_group             *group;
>>>> -       /* spinlock to protect against concurrent access of EP
>>>> controller */
>>>> -       spinlock_t                      lock;
>>>> +       /* mutex to protect against concurrent access of EP
>>>> controller */
>>>> +       struct mutex                    lock;
>>>>           struct atomic_notifier_head     notifier;
>>>>    };
>>>>
>>>> -- 
>>>> 2.17.1
>>>>
