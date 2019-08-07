Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF08475C
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 10:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfHGI2q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 04:28:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4185 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727755AbfHGI2q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 04:28:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85396DA68E07631ED7F5;
        Wed,  7 Aug 2019 16:28:42 +0800 (CST)
Received: from [127.0.0.1] (10.184.52.56) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 7 Aug 2019
 16:28:32 +0800
Subject: Re: [RFC PATCH] pciehp: use completion to wait irq_thread
 'pciehp_ist'
To:     Lukas Wunner <lukas@wunner.de>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yaohongbo@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>
References: <1562226638-54134-1-git-send-email-wangxiongfeng2@huawei.com>
 <20190806072428.2v7k775tvvgkbloh@wunner.de>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <b522942f-053d-0e05-746d-7702ee9f8e61@huawei.com>
Date:   Wed, 7 Aug 2019 16:28:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190806072428.2v7k775tvvgkbloh@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Lukas

On 2019/8/6 15:24, Lukas Wunner wrote:
> On Thu, Jul 04, 2019 at 03:50:38PM +0800, Xiongfeng Wang wrote:
>> When I use the following command to power on a slot which has been
>> powered off already.
>> echo 1 > /sys/bus/pci/slots/22/power
>> It prints the following error:
>> -bash: echo: write error: No such device
>> But the slot is actually powered on and the devices is probed.
>>
>> In function 'pciehp_sysfs_enable_slot()', we use 'wait_event()' to wait
>> until 'ctrl->pending_events' is cleared in 'pciehp_ist()'. But in some
>> situation, when 'pciehp_ist()' is woken up on a nearby CPU after
>> 'pciehp_request' is called, 'ctrl->pending_events' is cleared before we
>> go into sleep state. 'wait_event()' will check the condition before
>> going into sleep. So we return immediately and '-ENODEV' is return.
>>
>> This patch use struct completion to wait until irq_thread 'pciehp_ist'
>> is completed.
> 
> Thank you, good catch.
> 
> Unfortunately your patch still allows the following race AFAICS:
> 
> * pciehp_ist() is running (e.g. due to a hotplug operation)
> * a request to disable or enable the slot is submitted via sysfs,
>   the completion is reinitialized
> * pciehp_ist() finishes, signals completion
> * the sysfs request returns to user space prematurely
> * pciehp_ist() is run, handles the sysfs request, signals completion again
> 
> I'd suggest something like the below instead, could you give it a whirl
> and see if it reliably fixes the issue for you?

I tested the below patch. It can fix the issue.

I am not sure whether the following sequence will be a problem.
* pciehp_ist() is running, and 'ctrl->pending_events' is cleared
* a request to disable the slot is submitted via sysfs. 'ctrl->pending_events'
  is set and the irq_thread 'pciehp_ist' is waken up. But pciehp_ist() is running.
  So it doesn't take effect. 'ctrl->pending_events' is not cleared until next time
  pciehp_ist() is waken up. So pciehp_sysfs_enable_slot() will wait until next
  pciehp_ist() is waken up. I am not sure how 'irq_wake_thread()' will effect
  the running irq_thread.

How about making the process synchronous instead of waking up the irq_thread ?


Thanks,
Xiongfeng.

> 
> -- >8 --
> 
> Subject: [PATCH] PCI: pciehp: Avoid returning prematurely from sysfs requests
> 
> A sysfs request to enable or disable a PCIe hotplug slot should not
> return before it has been carried out.  That is sought to be achieved
> by waiting until the controller's "pending_events" have been cleared.
> 
> However the IRQ thread pciehp_ist() clears the "pending_events" before
> it acts on them.  If pciehp_sysfs_enable_slot() / _disable_slot() happen
> to check the "pending_events" after they have been cleared but while
> pciehp_ist() is still running, the functions may return prematurely
> with an incorrect return value.
> 
> Fix by introducing an "ist_running" flag which must be false before a
> sysfs request is allowed to return.
> 
> Fixes: 32a8cef274fe ("PCI: pciehp: Enable/disable exclusively from IRQ thread")
> Link: https://lore.kernel.org/linux-pci/1562226638-54134-1-git-send-email-wangxiongfeng2@huawei.com
> Reported-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.19+
> ---
>  drivers/pci/hotplug/pciehp.h      | 2 ++
>  drivers/pci/hotplug/pciehp_ctrl.c | 6 ++++--
>  drivers/pci/hotplug/pciehp_hpc.c  | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 8c51a04b8083..e316bde45c7b 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -72,6 +72,7 @@ extern int pciehp_poll_time;
>   * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
>   *	Link Status register and to the Presence Detect State bit in the Slot
>   *	Status register during a slot reset which may cause them to flap
> + * @ist_running: flag to keep user request waiting while IRQ thread is running
>   * @request_result: result of last user request submitted to the IRQ thread
>   * @requester: wait queue to wake up on completion of user request,
>   *	used for synchronous slot enable/disable request via sysfs
> @@ -101,6 +102,7 @@ struct controller {
>  
>  	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
>  	struct rw_semaphore reset_lock;
> +	unsigned int ist_running;
>  	int request_result;
>  	wait_queue_head_t requester;
>  };
> diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
> index 631ced0ab28a..1ce9ce335291 100644
> --- a/drivers/pci/hotplug/pciehp_ctrl.c
> +++ b/drivers/pci/hotplug/pciehp_ctrl.c
> @@ -368,7 +368,8 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
>  		ctrl->request_result = -ENODEV;
>  		pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
>  		wait_event(ctrl->requester,
> -			   !atomic_read(&ctrl->pending_events));
> +			   !atomic_read(&ctrl->pending_events) &&
> +			   !ctrl->ist_running);
>  		return ctrl->request_result;
>  	case POWERON_STATE:
>  		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
> @@ -401,7 +402,8 @@ int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
>  		mutex_unlock(&ctrl->state_lock);
>  		pciehp_request(ctrl, DISABLE_SLOT);
>  		wait_event(ctrl->requester,
> -			   !atomic_read(&ctrl->pending_events));
> +			   !atomic_read(&ctrl->pending_events) &&
> +			   !ctrl->ist_running);
>  		return ctrl->request_result;
>  	case POWEROFF_STATE:
>  		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index bd990e3371e3..9e2d7688e8cc 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -608,6 +608,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	irqreturn_t ret;
>  	u32 events;
>  
> +	ctrl->ist_running = true;
>  	pci_config_pm_runtime_get(pdev);
>  
>  	/* rerun pciehp_isr() if the port was inaccessible on interrupt */
> @@ -654,6 +655,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  	up_read(&ctrl->reset_lock);
>  
>  	pci_config_pm_runtime_put(pdev);
> +	ctrl->ist_running = false;
>  	wake_up(&ctrl->requester);
>  	return IRQ_HANDLED;
>  }
> 

