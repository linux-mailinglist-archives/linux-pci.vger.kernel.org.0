Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B43F3D3C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2019 02:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfKHBMN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 20:12:13 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:38140 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbfKHBMN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 20:12:13 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 191CBEA3289722D713FD;
        Fri,  8 Nov 2019 09:12:11 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 8 Nov 2019
 09:12:04 +0800
Subject: Re: [PATCH] pci: lock the pci_cfg_wait queue for the consistency of
 data
From:   Xiang Zheng <zhengxiang9@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <bhelgaas@google.com>, <wangxiongfeng2@huawei.com>,
        <wanghaibin.wang@huawei.com>, <guoheyi@huawei.com>,
        <yebiaoxiang@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <tglx@linutronix.de>, <guohanjun@huawei.com>,
        <yangyingliang@huawei.com>
References: <20191028091809.35212-1-zhengxiang9@huawei.com>
 <20191028163041.GA8257@bombadil.infradead.org>
 <14e7d02e-215d-30dc-548c-e605f3ffdf1e@huawei.com>
Message-ID: <5692a244-d6c7-8bd4-c7c4-e4532e7ff07c@huawei.com>
Date:   Fri, 8 Nov 2019 09:12:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <14e7d02e-215d-30dc-548c-e605f3ffdf1e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping...

On 2019/10/29 11:34, Xiang Zheng wrote:
> 
> 
> On 2019/10/29 0:30, Matthew Wilcox wrote:
>> On Mon, Oct 28, 2019 at 05:18:09PM +0800, Xiang Zheng wrote:
>>> Commit "7ea7e98fd8d0" suggests that the "pci_lock" is sufficient,
>>> and all the callers of pci_wait_cfg() are wrapped with the "pci_lock".
>>>
>>> However, since the commit "cdcb33f98244" merged, the accesses to
>>> the pci_cfg_wait queue are not safe anymore. A "pci_lock" is
>>> insufficient and we need to hold an additional queue lock while
>>> read/write the wait queue.
>>>
>>> So let's use the add_wait_queue()/remove_wait_queue() instead of
>>> __add_wait_queue()/__remove_wait_queue().
>>
>> As I said earlier, this reintroduces the deadlock addressed by
>> cdcb33f9824429a926b971bf041a6cec238f91ff
>>
> 
> Thanks Matthew, sorry for that I did not understand the way to reintroduce
> the deadlock and sent this patch. If what I think is right, the possible
> deadlock may be caused by the condition in which there are three processes:
> 
>    *Process*                          *Acquired*         *Wait For*
>    wake_up_all()                      wq_head->lock      pi_lock
>    snbep_uncore_pci_read_counter()    pi_lock            pci_lock
>    pci_wait_cfg()                     pci_lock           wq_head->lock
> 
> These processes suffer from the nested locks.:)
> 
> But for this problem, what do you think about the solution below:
> 
> diff --git a/drivers/pci/access.c b/drivers/pci/access.c
> index 2fccb5762c76..09342a74e5ea 100644
> --- a/drivers/pci/access.c
> +++ b/drivers/pci/access.c
> @@ -207,14 +207,14 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
>  {
>         DECLARE_WAITQUEUE(wait, current);
> 
> -       __add_wait_queue(&pci_cfg_wait, &wait);
>         do {
>                 set_current_state(TASK_UNINTERRUPTIBLE);
>                 raw_spin_unlock_irq(&pci_lock);
> +               add_wait_queue(&pci_cfg_wait, &wait);
>                 schedule();
> +               remove_wait_queue(&pci_cfg_wait, &wait);
>                 raw_spin_lock_irq(&pci_lock);
>         } while (dev->block_cfg_access);
> -       __remove_wait_queue(&pci_cfg_wait, &wait);
>  }
> 
>  /* Returns 0 on success, negative values indicate error. */
> 
> 
> 
>> .
>>
> 

-- 

Thanks,
Xiang

