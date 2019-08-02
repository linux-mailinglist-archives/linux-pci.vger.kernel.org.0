Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 372F07EF34
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbfHBI0f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Aug 2019 04:26:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37440 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726164AbfHBI0e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Aug 2019 04:26:34 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DD0BF8DE98F471CEA2A0;
        Fri,  2 Aug 2019 16:26:32 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 2 Aug 2019
 16:26:27 +0800
Subject: Re: [PATCH] pciehp: fix a race between pciehp and removing operations
 by sysfs
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1519648875-38196-1-git-send-email-wangxiongfeng2@huawei.com>
 <20190802003618.GJ151852@google.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <0c0512fd-e95a-74be-09c2-1576844d9c97@huawei.com>
Date:   Fri, 2 Aug 2019 16:23:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190802003618.GJ151852@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/8/2 8:36, Bjorn Helgaas wrote:
> On Mon, Feb 26, 2018 at 08:41:15PM +0800, Xiongfeng Wang wrote:
>> From: Xiongfeng Wang <xiongfeng.wang@linaro.com>
>>
>> When I run a stress test about pcie hotplug and removing operations by
>> sysfs, I got a hange task, and the following call trace is printed.
> 
> It's been so long that I'm embarrassed to even respond to this, but
> this patch doesn't apply cleanly to v5.3-rc1.  If this is still a
> problem, would you mind refreshing it and reposting it?  Thanks.

Thanks for your reply. Yes, it's still a problem, but the calltrace
is different. I will refresh it and repost it.

If I use a global flag to mark if any pci device is being rescaned or
removed, the problem is that we can't remove two devices belonging to
two root ports at the same time.
Since a root port produces a pci tree, so I was planning to make the
flag per root port slot. I mean add the flag in 'struct slot'.
 But in some situation, the root port doesn't support hotplug and the
downport below the root port support hotplug. I am not sure if it's
better to add the flag in 'struct pci_dev' of the root port.
Do you have any suggests?
Anyway, I will send the global flag version out.

Thanks,
Xiongfeng

> 
>>  INFO: task kworker/0:2:4413 blocked for more than 120 seconds.
>>        Tainted: P        W  O    4.12.0-rc1 #1
>>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>  kworker/0:2     D    0  4413      2 0x00000000
>>  Workqueue: pciehp-0 pciehp_power_thread
>>  Call trace:
>>  [<ffff0000080861d4>] __switch_to+0x94/0xa8
>>  [<ffff000008bea9c0>] __schedule+0x1b0/0x708
>>  [<ffff000008beaf58>] schedule+0x40/0xa4
>>  [<ffff000008beb33c>] schedule_preempt_disabled+0x28/0x40
>>  [<ffff000008bec1dc>] __mutex_lock.isra.8+0x148/0x50c
>>  [<ffff000008bec5c4>] __mutex_lock_slowpath+0x24/0x30
>>  [<ffff000008bec618>] mutex_lock+0x48/0x54
>>  [<ffff0000084d8188>] pci_lock_rescan_remove+0x20/0x28
>>  [<ffff0000084f87c0>] pciehp_unconfigure_device+0x54/0x1cc
>>  [<ffff0000084f8260>] pciehp_disable_slot+0x4c/0xbc
>>  [<ffff0000084f8370>] pciehp_power_thread+0xa0/0xb8
>>  [<ffff0000080e9ce8>] process_one_work+0x13c/0x3f8
>>  [<ffff0000080ea004>] worker_thread+0x60/0x3e4
>>  [<ffff0000080f0814>] kthread+0x10c/0x138
>>  [<ffff0000080836c0>] ret_from_fork+0x10/0x50
>>  INFO: task bash:31732 blocked for more than 120 seconds.
>>        Tainted: P        W  O    4.12.0-rc1 #1
>>  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>  bash            D    0 31732      1 0x00000009
>>  Call trace:
>>  [<ffff0000080861d4>] __switch_to+0x94/0xa8
>>  [<ffff000008bea9c0>] __schedule+0x1b0/0x708
>>  [<ffff000008beaf58>] schedule+0x40/0xa4
>>  [<ffff000008bee7b4>] schedule_timeout+0x1a0/0x340
>>  [<ffff000008bebb88>] wait_for_common+0x108/0x1bc
>>  [<ffff000008bebc64>] wait_for_completion+0x28/0x34
>>  [<ffff0000080e7594>] flush_workqueue+0x130/0x488
>>  [<ffff0000080e79b0>] drain_workqueue+0xc4/0x164
>>  [<ffff0000080ec3cc>] destroy_workqueue+0x28/0x1f4
>>  [<ffff0000084fa094>] pciehp_release_ctrl+0x34/0xe0
>>  [<ffff0000084f75b0>] pciehp_remove+0x30/0x3c
>>  [<ffff0000084f24d8>] pcie_port_remove_service+0x3c/0x54
>>  [<ffff00000876b1e4>] device_release_driver_internal+0x150/0x1d0
>>  [<ffff00000876b28c>] device_release_driver+0x28/0x34
>>  [<ffff00000876a018>] bus_remove_device+0xe0/0x11c
>>  [<ffff000008766348>] device_del+0x200/0x304
>>  [<ffff00000876646c>] device_unregister+0x20/0x38
>>  [<ffff0000084f2560>] remove_iter+0x44/0x54
>>  [<ffff000008765230>] device_for_each_child+0x4c/0x90
>>  [<ffff0000084f2c98>] pcie_port_device_remove+0x2c/0x48
>>  [<ffff0000084f2f48>] pcie_portdrv_remove+0x60/0x6c
>>  [<ffff0000084e3de4>] pci_device_remove+0x48/0x110
>>  [<ffff00000876b1e4>] device_release_driver_internal+0x150/0x1d0
>>  [<ffff00000876b28c>] device_release_driver+0x28/0x34
>>  [<ffff0000084db028>] pci_stop_bus_device+0x9c/0xac
>>  [<ffff0000084db190>] pci_stop_and_remove_bus_device_locked+0x24/0x3c
>>  [<ffff0000084e5eb0>] remove_store+0x74/0x80
>>  [<ffff000008764680>] dev_attr_store+0x44/0x5c
>>  [<ffff0000082e7e1c>] sysfs_kf_write+0x5c/0x74
>>  [<ffff0000082e7014>] kernfs_fop_write+0xcc/0x1dc
>>  [<ffff0000082602e0>] __vfs_write+0x48/0x13c
>>  [<ffff00000826174c>] vfs_write+0xa8/0x198
>>  [<ffff000008262ce8>] SyS_write+0x54/0xb0
>>  [<ffff000008083730>] el0_svc_naked+0x24/0x28
>>
>> There is a race condition between these two kinds of operations.
>> When the Attention button on a PCIE slot is pressed, 5 seconds later,
>> pciehp_power_thread() will be scheduled on slot->wq. This function will
>> call pciehp_unconfigure_device(), which will try to get a global mutex
>> lock 'pci_rescan_remove_lock'.
>>
>> At the same time, we remove the pcie port by sysfs, which results in
>> pci_stop_and_remove_bus_device_locked() called. This function will get
>> the global mutex lock 'pci_rescan_remove_lock', and then release the
>> struct 'ctrl', which will wait until the work_struct on slot->wq is
>> finished.
>>
>> If pci_stop_and_remove_bus_device_locked() got the mutex lock, and
>> before it drains workqueue slot->wq, pciehp_power_thread() is scheduled
>> on slot->wq and tries to get the mutex lock but failed, so it will just
>> wait. Then pci_stop_and_remove_bus_device_locked() tries to drain workqueue
>> slot->wq and wait until work struct 'pciehp_power_thread()' is finished.
>> Then a hung_task occurs.
>>
>> So this two kinds of operation, removing through attention buttion and
>> removing through /sys/devices/pci***/remove, should not be excuted at the
>> same time. This patch add a global variable to mark that one of these
>> operations is under processing. When this variable is set,  if another
>> operation is requested, it will be rejected.
>>
>> At first, I want to add a flag for each pci slot to record whether a
>> removing operation is under processing. When a bridge is being removed,
>> the flags of all the slots below the bridge need to be checked. But it
>> is hard for us to guarantee the atomic access. So I just use a global
>> flag.
>>
>> Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
>> ---
>>  drivers/pci/hotplug/pciehp_ctrl.c |  7 +++++++
>>  drivers/pci/hotplug/pciehp_hpc.c  | 12 +++++++++++-
>>  drivers/pci/pci-sysfs.c           | 11 +++++++++--
>>  drivers/pci/remove.c              |  6 ++++++
>>  include/linux/pci.h               |  3 +++
>>  5 files changed, 36 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
>> index c684faa..e6fc5d7 100644
>> --- a/drivers/pci/hotplug/pciehp_ctrl.c
>> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
>> @@ -30,6 +30,7 @@ void pciehp_queue_interrupt_event(struct slot *p_slot, u32 event_type)
>>  	info = kmalloc(sizeof(*info), GFP_ATOMIC);
>>  	if (!info) {
>>  		ctrl_err(p_slot->ctrl, "dropped event %d (ENOMEM)\n", event_type);
>> +		slot_being_removed_rescanned = 0;
>>  		return;
>>  	}
>>  
>> @@ -174,6 +175,7 @@ static void pciehp_power_thread(struct work_struct *work)
>>  		mutex_lock(&p_slot->lock);
>>  		p_slot->state = STATIC_STATE;
>>  		mutex_unlock(&p_slot->lock);
>> +		slot_being_removed_rescanned = 0;
>>  		break;
>>  	case ENABLE_REQ:
>>  		mutex_lock(&p_slot->hotplug_lock);
>> @@ -184,6 +186,7 @@ static void pciehp_power_thread(struct work_struct *work)
>>  		mutex_lock(&p_slot->lock);
>>  		p_slot->state = STATIC_STATE;
>>  		mutex_unlock(&p_slot->lock);
>> +		slot_being_removed_rescanned = 0;
>>  		break;
>>  	default:
>>  		break;
>> @@ -202,6 +205,7 @@ static void pciehp_queue_power_work(struct slot *p_slot, int req)
>>  	if (!info) {
>>  		ctrl_err(p_slot->ctrl, "no memory to queue %s request\n",
>>  			 (req == ENABLE_REQ) ? "poweron" : "poweroff");
>> +		slot_being_removed_rescanned = 0;
>>  		return;
>>  	}
>>  	info->p_slot = p_slot;
>> @@ -270,6 +274,7 @@ static void handle_button_press_event(struct slot *p_slot)
>>  		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
>>  			  slot_name(p_slot));
>>  		p_slot->state = STATIC_STATE;
>> +		slot_being_removed_rescanned = 0;
>>  		break;
>>  	case POWEROFF_STATE:
>>  	case POWERON_STATE:
>> @@ -280,10 +285,12 @@ static void handle_button_press_event(struct slot *p_slot)
>>  		 */
>>  		ctrl_info(ctrl, "Slot(%s): Button ignored\n",
>>  			  slot_name(p_slot));
>> +		slot_being_removed_rescanned = 0;
>>  		break;
>>  	default:
>>  		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
>>  			 slot_name(p_slot), p_slot->state);
>> +		slot_being_removed_rescanned = 0;
>>  		break;
>>  	}
>>  }
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 18a42f8..5ef5387 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -608,7 +608,17 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
>>  	if (events & PCI_EXP_SLTSTA_ABP) {
>>  		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
>>  			  slot_name(slot));
>> -		pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
>> +
>> +		if (!test_and_set_bit(0, &slot_being_removed_rescanned))
>> +			pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
>> +		else {
>> +			if (slot->state == BLINKINGOFF_STATE || slot->state == BLINKINGON_STATE)
>> +				pciehp_queue_interrupt_event(slot, INT_BUTTON_PRESS);
>> +			else
>> +				ctrl_info(ctrl, "Slot(%s): Slot operation failed because a remove or"
>> +					" rescan operation is under processing, please try later!\n",
>> +					slot_name(slot));
>> +		}
>>  	}
>>  
>>  	/*
>> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
>> index eb6bee8..9fd1699 100644
>> --- a/drivers/pci/pci-sysfs.c
>> +++ b/drivers/pci/pci-sysfs.c
>> @@ -499,8 +499,15 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
>>  	if (kstrtoul(buf, 0, &val) < 0)
>>  		return -EINVAL;
>>  
>> -	if (val && device_remove_file_self(dev, attr))
>> -		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
>> +	if (val && device_remove_file_self(dev, attr)) {
>> +		if (!test_and_set_bit(0, &slot_being_removed_rescanned)) {
>> +			pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
>> +			slot_being_removed_rescanned = 0;
>> +		} else {
>> +			pr_info("Slot is being removed or rescanned, please try later!\n");
>> +			return -EPERM;
>> +		}
>> +	}
>>  	return count;
>>  }
>>  static struct device_attribute dev_remove_attr = __ATTR(remove,
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 6f072ea..6d36d53 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -4,6 +4,12 @@
>>  #include <linux/pci-aspm.h>
>>  #include "pci.h"
>>  
>> +/*
>> + * When a slot is being hotplug through Attention Button or being
>> + * removed/rescanned through sysfs, this flag is set.
>> + */
>> +unsigned long slot_being_removed_rescanned;
>> +
>>  static void pci_free_resources(struct pci_dev *dev)
>>  {
>>  	int i;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 024a1be..e1711ce 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -846,6 +846,9 @@ enum pcie_bus_config_types {
>>  /* Do NOT directly access these two variables, unless you are arch-specific PCI
>>   * code, or PCI core code. */
>>  extern struct list_head pci_root_buses;	/* List of all known PCI buses */
>> +
>> +extern unsigned long slot_being_removed_rescanned;
>> +
>>  /* Some device drivers need know if PCI is initiated */
>>  int no_pci_devices(void);
>>  
>> -- 
>> 1.7.12.4
>>
> 
> .
> 

