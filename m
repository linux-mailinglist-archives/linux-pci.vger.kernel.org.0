Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 080F68E853
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfHOJc7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 05:32:59 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43506 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfHOJc6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 05:32:58 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CC91E544B11F095A93BF;
        Thu, 15 Aug 2019 17:32:53 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Thu, 15 Aug 2019
 17:32:50 +0800
Subject: Re: [PATCH v2] pciehp: fix a race between pciehp and removing
 operations by sysfs
To:     Lukas Wunner <lukas@wunner.de>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1565008378-4733-1-git-send-email-wangxiongfeng2@huawei.com>
 <20190811080703.qfnlzfutgamoxzti@wunner.de>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <b824a676-f612-defb-3ccc-f848c261adfe@huawei.com>
Date:   Thu, 15 Aug 2019 17:32:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190811080703.qfnlzfutgamoxzti@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/8/11 16:07, Lukas Wunner wrote:
> On Mon, Aug 05, 2019 at 08:32:58PM +0800, Xiongfeng Wang wrote:
>> When we remove a slot by sysfs.
>> 'pci_stop_and_remove_bus_device_locked()' will be called. This function
>> will get the global mutex lock 'pci_rescan_remove_lock', and remove the
>> slot. If the irq thread 'pciehp_ist' is still running, we will wait
>> until it exits.
>>
>> If a pciehp interrupt happens immediately after we remove the slot by
>> sysfs, but before we free the pciehp irq in
>> 'pci_stop_and_remove_bus_device_locked()'. 'pciehp_ist' will hung
>> because the global mutex lock 'pci_rescan_remove_lock' is held by the
>> sysfs operation. But the sysfs operation is waiting for the pciehp irq
>> thread 'pciehp_ist' ends. Then a hung task occurs.
>>
>> So this two kinds of operation, removing the slot triggered by pciehp
>> interrupt and removing through 'sysfs', should not be excuted at the
>> same time. This patch add a global variable to mark that one of these
>> operations is under processing. When this variable is set,  if another
>> operation is requested, it will be rejected.
> 
> It seems this patch involves an ABI change wherein "remove" as documented
> in Documentation/ABI/testing/sysfs-bus-pci may now fail and need a retry,
> possibly breaking existing scripts which write to this file.  ABI changes
> are fairly problematic.
> 
> The return value -EWOULDBLOCK (which is identical to -EAGAIN) might be
> more appropriate than -EINVAL.
> 
> Another problem is that this patch only addresses deadlocks occurring
> because of a "remove" via sysfs and a simultaneous surprise removal
> (or button press removal).  However the same kind of deadlock may
> occur because of two simultaneous surprise removals if one of the
> two devices is a parent of the other.  It would be better to have
> a solution which addresses all types of deadlocks caused by the
> pci_rescan_remove_lock().  I provided you with a suggestion in this
> e-mail:
> 
> https://lore.kernel.org/linux-pci/20190805114053.srbngho3wbziy2uy@wunner.de/
> 
>    "What you can do is add a flag to struct pci_dev (or the priv_flags
>     embedded therein) to indicate that a device is about to be removed.
>     Set this flag on all children of the device being removed before
>     acquiring pci_lock_rescan_remove() and avoid taking that lock in
>     pciehp_unconfigure_device() if the flag is set on the hotplug port.
> 
>     But again, that approach is just a band-aid and the real fix is to
>     unbind devices without holding the lock."

This similar dead lock also exists when AER events and remove via sysfs
happens at the same time. The calltrace is as follows.

[ 2541.494130] INFO: task kworker/86:1:603 blocked for more than 120 seconds.
[ 2541.507844]       Tainted: G        W  OE     4.19.30-vhulk1903.5.1.h163.eulerosv3r1.aarch64 #2
[ 2541.525188] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2541.540799] kworker/86:1    D    0   603      2 0x00000028
[ 2541.551742] Workqueue: events aer_isr
[ 2541.559040] Call trace:
[ 2541.563914]  __switch_to+0x94/0xe8
[ 2541.570691]  __schedule+0x430/0xda0
[ 2541.577640]  schedule+0x2c/0x88
[ 2541.583897]  schedule_preempt_disabled+0x14/0x20
[ 2541.593098]  __mutex_lock.isra.1+0x1fc/0x540
[ 2541.601607]  __mutex_lock_slowpath+0x24/0x30
[ 2541.610116]  mutex_lock+0x80/0xa8
[ 2541.616720]  pci_lock_rescan_remove+0x20/0x28
[ 2541.625403]  pcie_do_fatal_recovery+0x48/0x230
[ 2541.634258]  handle_error_source+0xb4/0xc8
[ 2541.642419]  aer_isr+0x208/0x3b8
[ 2541.648849]  process_one_work+0x1b4/0x3f8
[ 2541.656837]  worker_thread+0x54/0x470
[ 2541.664134]  kthread+0x134/0x138
[ 2541.670564]  ret_from_fork+0x10/0x18
[ 2541.677711] INFO: task bash:42546 blocked for more than 120 seconds.
[ 2541.690379]       Tainted: G        W  OE     4.19.30-vhulk1903.5.1.h163.eulerosv3r1.aarch64 #2
[ 2541.707721] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2541.723331] bash            D    0 42546  42544 0x00000200
[ 2541.734267] Call trace:
[ 2541.739138]  __switch_to+0x94/0xe8
[ 2541.745914]  __schedule+0x430/0xda0
[ 2541.752862]  schedule+0x2c/0x88
[ 2541.759120]  schedule_timeout+0x224/0x448
[ 2541.767108]  wait_for_common+0x198/0x2a0
[ 2541.774923]  wait_for_completion+0x28/0x38
[ 2541.783085]  __flush_work+0x128/0x280
[ 2541.790381]  flush_work+0x24/0x30
[ 2541.796985]  aer_remove+0x54/0x118
[ 2541.803761]  pcie_port_remove_service+0x3c/0x58
[ 2541.812790]  device_release_driver_internal+0x1b4/0x250
[ 2541.823204]  device_release_driver+0x28/0x38
[ 2541.831714]  bus_remove_device+0xd4/0x160
[ 2541.839703]  device_del+0x128/0x348
[ 2541.846652]  device_unregister+0x24/0x78
[ 2541.854468]  remove_iter+0x48/0x58
[ 2541.861243]  device_for_each_child+0x6c/0xb8
[ 2541.869752]  pcie_port_device_remove+0x2c/0x48
[ 2541.878607]  pcie_portdrv_remove+0x5c/0x68
[ 2541.886769]  pci_device_remove+0x48/0xd8
[ 2541.894585]  device_release_driver_internal+0x1b4/0x250
[ 2541.904998]  device_release_driver+0x28/0x38
[ 2541.913508]  pci_stop_bus_device+0x84/0xb8
[ 2541.921669]  pci_stop_and_remove_bus_device_locked+0x24/0x40
[ 2541.932949]  remove_store+0xa4/0xb8
[ 2541.939899]  dev_attr_store+0x44/0x60
[ 2541.947196]  sysfs_kf_write+0x58/0x80
[ 2541.954493]  kernfs_fop_write+0xe8/0x1f0
[ 2541.962308]  __vfs_write+0x60/0x190
[ 2541.969257]  vfs_write+0xac/0x1c0
[ 2541.975860]  ksys_write+0x6c/0xd8
[ 2541.982463]  __arm64_sys_write+0x24/0x30
[ 2541.990279]  el0_svc_common+0xa0/0x180
[ 2541.997749]  el0_svc_handler+0x38/0x78
[ 2542.005219]  el0_svc+0x8/0xc

I am not sure if this method can fix this issue. When the AER events occurs,
if we find the device is being removed, we can abort the AER recovery process.
But if the AER event occurs first and the remove via sysfs happens later,
after the remove via sysfs returns, the pci device is rescaned.
Or we should reject the remove via sysfs.
I think we need a way to differentiate remove because of AER and remove via sysfs.

Thanks,
Xiongfeng

> 
> Thanks,
> 
> Lukas
> 
> .
> 

