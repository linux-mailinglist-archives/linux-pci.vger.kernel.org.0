Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97B5920C5B0
	for <lists+linux-pci@lfdr.de>; Sun, 28 Jun 2020 06:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgF1ESW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Jun 2020 00:18:22 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6843 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725844AbgF1ESV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 28 Jun 2020 00:18:21 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A78A4857BACDF39BA519;
        Sun, 28 Jun 2020 12:18:17 +0800 (CST)
Received: from [127.0.0.1] (10.174.187.83) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sun, 28 Jun 2020
 12:18:10 +0800
Subject: Re: [PATCH v3] PCI: Lock the pci_cfg_wait queue for the consistency
 of data
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <bhelgaas@google.com>, <willy@infradead.org>,
        <wangxiongfeng2@huawei.com>, <wanghaibin.wang@huawei.com>,
        <guoheyi@huawei.com>, <yebiaoxiang@huawei.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rjw@rjwysocki.net>, <tglx@linutronix.de>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>,
        James Puthukattukaran <james.puthukattukaran@oracle.com>
References: <20200625232430.GA2739986@bjorn-Precision-5520>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <652a151d-0aa5-cd79-4fec-7c217089c81d@huawei.com>
Date:   Sun, 28 Jun 2020 12:18:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200625232430.GA2739986@bjorn-Precision-5520>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.83]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020/6/26 7:24, Bjorn Helgaas wrote:
> On Wed, Jun 24, 2020 at 06:23:09PM -0500, Bjorn Helgaas wrote:
>> On Tue, Dec 10, 2019 at 11:15:27AM +0800, Xiang Zheng wrote:
>>> 7ea7e98fd8d0 ("PCI: Block on access to temporarily unavailable pci
>>> device") suggests that the "pci_lock" is sufficient, and all the
>>> callers of pci_wait_cfg() are wrapped with the "pci_lock".
>>>
>>> However, since the commit cdcb33f98244 ("PCI: Avoid possible deadlock on
>>> pci_lock and p->pi_lock") merged, the accesses to the pci_cfg_wait queue
>>> are not safe anymore. This would cause kernel panic in a very low chance
>>> (See more detailed information from the below link). A "pci_lock" is
>>> insufficient and we need to hold an additional queue lock while read/write
>>> the wait queue.
>>>
>>> So let's use the add_wait_queue()/remove_wait_queue() instead of
>>> __add_wait_queue()/__remove_wait_queue(). Also move the wait queue
>>> functionality around the "schedule()" function to avoid reintroducing
>>> the deadlock addressed by "cdcb33f98244".
>>
>> I see that add_wait_queue() acquires the wq_head->lock, while
>> __add_wait_queue() does not.
>>
>> But I don't understand why the existing pci_lock is insufficient.  
>> pci_cfg_wait is only used in pci_wait_cfg() and
>> pci_cfg_access_unlock().
>>
>> In pci_wait_cfg(), both __add_wait_queue() and __remove_wait_queue()
>> are called while holding pci_lock, so that doesn't seem like the
>> problem.
>>
>> In pci_cfg_access_unlock(), we have:
>>
>>   pci_cfg_access_unlock
>>     wake_up_all(&pci_cfg_wait)
>>       __wake_up(&pci_cfg_wait, ...)
>>         __wake_up_common_lock(&pci_cfg_wait, ...)
>> 	  spin_lock(&pci_cfg_wait->lock)
>> 	  __wake_up_common(&pci_cfg_wait, ...)
>> 	    list_for_each_entry_safe_from(...)
>> 	      list_add_tail(...)                <-- problem?
>> 	  spin_unlock(&pci_cfg_wait->lock)
>>
>> Is the problem that the wake_up_all() modifies the pci_cfg_wait list
>> without holding pci_lock?
>>
>> If so, I don't quite see how the patch below fixes it.  Oh, wait,
>> maybe I do ... by using add_wait_queue(), we protect the list using
>> the *same* lock used by __wake_up_common_lock.  Is that it?
> 
> Any reaction to the following?  Certainly not as optimized, but also a
> little less magic and more in the mainstream of wait_event/wake_up
> usage.
> 
> I don't claim any real wait queue knowledge and haven't tested it.
> There are only a handful of __add_wait_queue() users compared with
> over 1600 users of wait_event() and variants, and I don't like being
> such a special case.
> 

I think the following patch is OK, even though I prefer mine. :)
I can test your patch on my testcase(with hacked 300ms delay before "curr->func"
in __wake_up_common()). And if James has more efficient testcase or measure for
this problem, then go with James.

> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 79c4a2ef269a..7c2222bddbff 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -205,16 +205,11 @@ static DECLARE_WAIT_QUEUE_HEAD(pci_cfg_wait);
>  
>  static noinline void pci_wait_cfg(struct pci_dev *dev)
>  {
> -	DECLARE_WAITQUEUE(wait, current);
> -
> -	__add_wait_queue(&pci_cfg_wait, &wait);
>  	do {
> -		set_current_state(TASK_UNINTERRUPTIBLE);
>  		raw_spin_unlock_irq(&pci_lock);
> -		schedule();
> +		wait_event(pci_cfg_wait, !dev->block_cfg_access);
>  		raw_spin_lock_irq(&pci_lock);
>  	} while (dev->block_cfg_access);
> -	__remove_wait_queue(&pci_cfg_wait, &wait);
>  }
>  
>  /* Returns 0 on success, negative values indicate error. */
> 
> .
> 

-- 
Thanks,
Xiang

