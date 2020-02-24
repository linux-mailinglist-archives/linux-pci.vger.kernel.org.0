Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06814169BCC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 02:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgBXB3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Feb 2020 20:29:12 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50688 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727151AbgBXB3L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Feb 2020 20:29:11 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C5AF8A52A59689D1CE31;
        Mon, 24 Feb 2020 09:29:09 +0800 (CST)
Received: from [127.0.0.1] (10.133.224.57) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 09:29:02 +0800
Subject: Re: Kernel panic while doing vfio-pci hot-plug/unplug test
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mingo@redhat.com>, <peterz@infradead.org>,
        <alex.williamson@redhat.com>,
        Wang Haibin <wanghaibin.wang@huawei.com>,
        Guoheyi <guoheyi@huawei.com>,
        yebiaoxiang <yebiaoxiang@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200222165516.GA206644@google.com>
From:   Xiang Zheng <zhengxiang9@huawei.com>
Message-ID: <ee28a1f8-b928-b888-763c-9ac0f810c7c3@huawei.com>
Date:   Mon, 24 Feb 2020 09:29:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200222165516.GA206644@google.com>
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

On 2020/2/23 0:55, Bjorn Helgaas wrote:
> [+cc Matthew, Thomas]
> 
> On Wed, Oct 16, 2019 at 09:36:23PM +0800, Xiang Zheng wrote:
>> Hi all,
>>
>> Recently I encountered a kernel panic while doing vfio-pci hot-plug/unplug test repeatly on my Arm-KVM virtual machines.
> 
> Did we ever do anything about this panic?  I don't see any resolution
> in the email thread.
> 

I had sent a v3 patch two months ago and wait for more substantive comments to address this problem.
Maybe you missed this email.:)

v3: https://lkml.org/lkml/2019/12/10/36
v2: https://lkml.org/lkml/2019/11/18/977

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
>>
>>
>> -- 
>>
>> Thanks,
>> Xiang
>>
> 
> .
> 

-- 

Thanks,
Xiang

