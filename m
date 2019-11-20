Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CB110343D
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 07:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfKTGSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 01:18:30 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7149 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726014AbfKTGSa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 01:18:30 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2070099B356093EE0547;
        Wed, 20 Nov 2019 14:18:27 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Nov 2019
 14:18:19 +0800
Subject: Re: [PATCH v2] pci: lock the pci_cfg_wait queue for the consistency
 of data
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <willy@infradead.org>, <wangxiongfeng2@huawei.com>,
        <wanghaibin.wang@huawei.com>, <guoheyi@huawei.com>,
        <yebiaoxiang@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
References: <20191119202305.GA214858@google.com>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <fea7b513-f01d-c059-cb23-7247eb9d712b@huawei.com>
Date:   Wed, 20 Nov 2019 14:18:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191119202305.GA214858@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/11/20 4:23, Bjorn Helgaas wrote:
> On Tue, Nov 19, 2019 at 09:15:45AM +0800, Xiang Zheng wrote:
>> Commit "7ea7e98fd8d0" suggests that the "pci_lock" is sufficient,
>> and all the callers of pci_wait_cfg() are wrapped with the "pci_lock".
>>
>> However, since the commit "cdcb33f98244" merged, the accesses to
>> the pci_cfg_wait queue are not safe anymore. A "pci_lock" is
>> insufficient and we need to hold an additional queue lock while
>> read/write the wait queue.
>>
>> So let's use the add_wait_queue()/remove_wait_queue() instead of
>> __add_wait_queue()/__remove_wait_queue(). Also move the wait queue
>> functionality around the "schedule()" function to avoid reintroducing
>> the deadlock addressed by "cdcb33f98244".
> 
> Procedural nits:
> 
>   - Run "git log --oneline drivers/pci/access.c" and follow the
>     convention, e.g., starts with "PCI: " and first subsequent word is
>     capitalized.
> 
>   - Use conventional commit references, e.g., 7ea7e98fd8d0 ("PCI:
>     Block on access to temporarily unavailable pci device") and
>     cdcb33f98244 ("PCI: Avoid possible deadlock on pci_lock and
>     p->pi_lock")
> 
>   - IIRC you found that this actually caused a panic; please include
>     the lore.kernel.org URL to that report.
> 

Got it, I will address these nits.

> You can wait for a while to see if there are more substantive comments
> to address before posting a v3.
> 

OK.

>> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
>> Cc: Heyi Guo <guoheyi@huawei.com>
>> Cc: Biaoxiang Ye <yebiaoxiang@huawei.com>
>> ---
>>
>> v2:
>>  - Move the wait queue functionality around the "schedule()" function to
>>    avoid reintroducing the deadlock addressed by "cdcb33f98244"
>>
>> ---
>>
>>  drivers/pci/access.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
>> index 2fccb5762c76..09342a74e5ea 100644
>> --- a/drivers/pci/access.c
>> +++ b/drivers/pci/access.c
>> @@ -207,14 +207,14 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>>  {
>>  	DECLARE_WAITQUEUE(wait, current);
>>  
>> -	__add_wait_queue(&pci_cfg_wait, &wait);
>>  	do {
>>  		set_current_state(TASK_UNINTERRUPTIBLE);
>>  		raw_spin_unlock_irq(&pci_lock);
>> +		add_wait_queue(&pci_cfg_wait, &wait);
>>  		schedule();
>> +		remove_wait_queue(&pci_cfg_wait, &wait);
>>  		raw_spin_lock_irq(&pci_lock);
>>  	} while (dev->block_cfg_access);
>> -	__remove_wait_queue(&pci_cfg_wait, &wait);
>>  }
>>  
>>  /* Returns 0 on success, negative values indicate error. */
>> -- 
>> 2.19.1
>>
>>
> 
> .
> 

-- 

Thanks,
Xiang

