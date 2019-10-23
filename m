Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B03FDE1662
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbfJWJkf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 05:40:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729191AbfJWJkf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:40:35 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 54D6B99A478B06500BF9;
        Wed, 23 Oct 2019 17:40:31 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 23 Oct 2019
 17:40:22 +0800
Subject: Re: Kernel panic while doing vfio-pci hot-plug/unplug test
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <alex.williamson@redhat.com>,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        Guoheyi <guoheyi@huawei.com>,
        yebiaoxiang <yebiaoxiang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20191018135846.GA161054@google.com>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <2e7293dc-eb27-bce3-c209-e0ba15409f16@huawei.com>
Date:   Wed, 23 Oct 2019 17:40:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191018135846.GA161054@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.224.57]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for your reply!

On 2019/10/18 21:58, Bjorn Helgaas wrote:
> [+cc Matthew]
> 
> On Wed, Oct 16, 2019 at 09:36:23PM +0800, Xiang Zheng wrote:
>> Hi all,
>>
>> Recently I encountered a kernel panic while doing vfio-pci hot-plug/unplug test repeatly on my Arm-KVM virtual machines.
>> See the call stack below:
>>
>> [66628.697280] vfio-pci 0000:06:03.5: enabling device (0000 -> 0002)
>> [66628.809290] vfio-pci 0000:06:03.1: enabling device (0000 -> 0002)
>> [66628.921283] vfio-pci 0000:06:02.7: enabling device (0000 -> 0002)
>> [66629.029280] vfio-pci 0000:06:03.6: enabling device (0000 -> 0002)
>> [66629.137338] vfio-pci 0000:06:03.2: enabling device (0000 -> 0002)
>> [66629.249285] vfio-pci 0000:06:03.7: enabling device (0000 -> 0002)
>> [66630.237261] Unable to handle kernel read from unreadable memory at virtual address ffff802dac469000
>> [66630.246266] Mem abort info:
>> [66630.249047]   ESR = 0x8600000d
>> [66630.252088]   Exception class = IABT (current EL), IL = 32 bits
>> [66630.257981]   SET = 0, FnV = 0
>> [66630.261022]   EA = 0, S1PTW = 0
>> [66630.264150] swapper pgtable: 4k pages, 48-bit VAs, pgdp = 00000000fb16886e
>> [66630.270992] [ffff802dac469000] pgd=0000203fffff6803, pud=00e8002d80000f11
>> [66630.277751] Internal error: Oops: 8600000d [#1] SMP
>> [66630.282606] Process qemu-kvm (pid: 37201, stack limit = 0x00000000d8f19858)
>> [66630.289537] CPU: 41 PID: 37201 Comm: qemu-kvm Kdump: loaded Tainted: G           OE     4.19.36-vhulk1907.1.0.h453.eulerosv2r8.aarch64 #1
>> [66630.301822] Hardware name: Huawei TaiShan 2280 V2/BC82AMDDA, BIOS 0.88 07/24/2019
>> [66630.309270] pstate: 80400089 (Nzcv daIf +PAN -UAO)
>> [66630.314042] pc : 0xffff802dac469000
>> [66630.317519] lr : __wake_up_common+0x90/0x1a8
>> [66630.321768] sp : ffff00027746bb00
>> [66630.325067] x29: ffff00027746bb00 x28: 0000000000000000
>> [66630.330355] x27: 0000000000000000 x26: ffff0000092755b8
>> [66630.335643] x25: 0000000000000000 x24: 0000000000000000
>> [66630.340930] x23: 0000000000000003 x22: ffff00027746bbc0
>> [66630.346219] x21: 000000000954c000 x20: ffff0001f542bc6c
>> [66630.351506] x19: ffff0001f542bb90 x18: 0000000000000000
>> [66630.356793] x17: 0000000000000000 x16: 0000000000000000
>> [66630.362081] x15: 0000000000000000 x14: 0000000000000000
>> [66630.367368] x13: 0000000000000000 x12: 0000000000000000
>> [66630.372655] x11: 0000000000000000 x10: 0000000000000bb0
>> [66630.377942] x9 : ffff00027746ba50 x8 : ffff80367ff6ca10
>> [66630.383229] x7 : ffff802e20d59200 x6 : 000000000000003f
>> [66630.388517] x5 : ffff00027746bbc0 x4 : ffff802dac469000
>> [66630.393806] x3 : 0000000000000000 x2 : 0000000000000000
>> [66630.399093] x1 : 0000000000000003 x0 : ffff0001f542bb90
>> [66630.404381] Call trace:
>> [66630.406818]  0xffff802dac469000
>> [66630.409945]  __wake_up_common_lock+0xa8/0x1a0
>> [66630.414283]  __wake_up+0x40/0x50
>> [66630.417499]  pci_cfg_access_unlock+0x9c/0xd0
>> [66630.421752]  pci_try_reset_function+0x58/0x78
>> [66630.426095]  vfio_pci_ioctl+0x478/0xdb8 [vfio_pci]
>> [66630.430870]  vfio_device_fops_unl_ioctl+0x44/0x70 [vfio]
>> [66630.436158]  do_vfs_ioctl+0xc4/0x8c0
>> [66630.439718]  ksys_ioctl+0x8c/0xa0
>> [66630.443018]  __arm64_sys_ioctl+0x28/0x38
>> [66630.446925]  el0_svc_common+0x78/0x130
>> [66630.450657]  el0_svc_handler+0x38/0x78
>> [66630.454389]  el0_svc+0x8/0xc
>> [66630.457260] Code: 00000000 00000000 00000000 00000000 (ac46d000)
>> [66630.463325] kernel fault(0x1) notification starting on CPU 41
>> [66630.469044] kernel fault(0x1) notification finished on CPU 41
>>
>> The chance to reproduce this problem is very small. We had an initial analysis of this problem,
>> and found it was caused by the illegal value of the 'curr->func' in the __wake_up_common() function.
>>
>> I cannot image how 'curr->func' can be wrote to 0xffff802dac469000. Is there any problem about
>> concurrent competition between the pci_wait_cfg() function and the wake_up_all() function?
> 
> I haven't heard of a problem there, but that doesn't mean there isn't
> one.
> 
> The fact that pci_wait_cfg() uses __add_wait_queue() (not
> add_wait_queue(), which does more locking) makes me a little
> suspicious.  Most of the other callers of __add_wait_queue() acquire
> the wait_queue lock themselves, but pci_wait_cfg() doesn't.
> 
> This was added by 7ea7e98fd8d0 ("PCI: Block on access to temporarily
> unavailable pci device"), and the commit log suggests that the
> pci_lock is sufficient.  All callers of pci_wait_cfg() do hold
> pci_lock, and the "pci_cfg_wait" queue is private, but ...
> pci_cfg_access_unlock() calls wake_up_all(&pci_cfg_wait) *without*
> holding pci_lock.  That path leads to __wake_up_common_lock(), which
> depends on wq_head->lock, which pci_wait_cfg() doesn't use.

Yes, we was also suspicious about this point and had a further analysis of this problem.
We found that the "pci_cfg_wait" queue was empty when the "curr->func" callback function
was called:

crash> p pci_cfg_wait.head
$2 = {
  next = 0xffff0000092755b8 <pci_cfg_wait+8>,
  prev = 0xffff0000092755b8 <pci_cfg_wait+8>
}
crash> p &(pci_cfg_wait.head)
$3 = (struct list_head *) 0xffff0000092755b8 <pci_cfg_wait+8>
crash>

The "ps" command also shows that there was no processes on "UN" state at that time.

According to the above two clues, we finally reached a conclusion: there must be two processes,
'A' was calling pci_wait_cfg() and 'B' was calling __wake_up_common(). And there is a very
small chance that 'A' called __remove_wait_queue() before 'B' called the "curr->func", after
'B' got the queue entry "curr". Since the queue entry was a local variable, it would be
invalid after pci_wait_cfg() returned and eventually we got an invalid value of "curr->func".

In order to verify this conclusion, we add a delay(e.g. 300ms) before calling "curr->func"
in the __wake_up_common() function. Then this problem can be easily reproduced.

> 
> pci_cfg_access_unlock() originally *did* hold pci_lock while calling
> wake_up_all(), but I changed that with cdcb33f98244 ("PCI: Avoid
> possible deadlock on pci_lock and p->pi_lock") without understanding
> both sides of the wait_queue locking issue.

Before your change was merged, any operations to the "pci_cfg_wait" was safe because they all
did hold pci_lock. So the pci_lock was sufficient.

> 
> But I still don't understand enough to know whether this is actually
> the problem or to propose a fix.

I think we need to fix it. A simple solution is to use add_wait_queue()/remove_wait_queue()
instead of __add_wait_queue()/__remove_wait_queue() and this works for me. What do you think?

> 
> Bjorn
> 
> .
> 

-- 

Thanks,
Xiang

