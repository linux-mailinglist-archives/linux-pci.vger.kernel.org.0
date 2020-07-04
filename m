Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559772144C7
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jul 2020 12:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgGDKZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jul 2020 06:25:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6817 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726178AbgGDKZm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 4 Jul 2020 06:25:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ABEB3CC1F95175055864;
        Sat,  4 Jul 2020 18:25:39 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sat, 4 Jul 2020
 18:25:33 +0800
Subject: Re: [PATCH 2/2] PCI/AER: Fix deadlock triggered by AER and sriov
 enable routine
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <20200630235853.GA3500801@bjorn-Precision-5520>
CC:     <linux-pci@vger.kernel.org>, <f.fangjian@huawei.com>,
        <huangdaode@huawei.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <Okaya@kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Christoph Hellwig <hch@lst.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <fade5ccd-c80f-9bee-5710-87c855f4a649@hisilicon.com>
Date:   Sat, 4 Jul 2020 18:25:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200630235853.GA3500801@bjorn-Precision-5520>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for reviewing this.


On 2020/7/1 7:58, Bjorn Helgaas wrote:
> [+cc Ben, Sinan, Jakub, Christoph, Sathy]
>
> On Wed, Feb 05, 2020 at 05:18:09PM +0800, Yicong Yang wrote:
>> When enabling VF of pci device by sysfs, we hold device_lock
>> first in sriov_enable() and then pci_bus_sem in pci_device_add().
>> But when AER invoked, we hold pci_bus_sem first in
>> pcie_do_recovery() and then device_lock subsequently.
>> The inconsistent order will lead to deadlock as reported [1].
>>
>> when adding VF by sysfs:
>> sriov_numvfs_store()
>> 	device_lock()
>> 		...
>> 		sriov_enable()
>> 			...
>> 			pci_device_add()
>> 				down_write(&pci_bus_sem)
>> when invoking aer routine:
>> pcie_do_recovery()
>> 	...
>> 	pci_walk_bus()
>> 		down_read(&pci_bus_sem)
>> 		report_*()
>> 			...
>> 			device_lock()
>>
>> Add pci_lock_and_walk_bus(), which locks the devices on the bus first
>> using pci_bus_lock() and then walk the bus with specific callback.
>> Use pci_lock_and_walk_bus() in pcie_do_recovery() and remove
>> device_lock() in report_*() callbacks. Then the lock order will be
>> consistent with that in the sriov enable routine.
>> User space access to the configuration space of the devices on the bus
>> will also be blocked in the error recovery routine. The device should
>> be unreachable during error recovery.
> Did you consider Ben's response [1]?  He suggested that the SR-IOV
> side maybe shouldn't take the device_lock before doing something that
> can take the pci_bus_sem.

We take pci_bus_sem in pdev->driver->sriov_configure() to add device to
the pci_bus, seems we cannot avoid taking it or we'll met what mentioned
in commit 17530e71e016 [2]. Or am I missed something?

sriov_numvfs_store()
	device_lock()
	pdev->driver->sriov_configure()
		...
		pci_device_add()
			down_write(&pci_bus_sem)

> The device_lock() in sriov_numvfs_store() was added by 17530e71e016
> ("PCI: Protect pci_driver->sriov_configure() usage with
> device_lock()") [2].  The commit log says we must provide exclusion vs
> the driver's ->remove() method, usually by using device_lock().
>
> Maybe this patch is doing the right thing by acquiring all the
> device_locks in the subtree on the AER side.
>
> But I do feel a little queasy about pci_device_add() and
> pci_bus_add_device() and pci_bus_sem being held while holding
> device_lock.  Maybe the device addition should be done by a separate
> thread or something.

I haven't found other routines(please tell me if there is) besides SR-IOV
enable holding device_lock while calling pci_device_add(), pci_bus_add_device()
or holding pci_bus_sem. So I think we only need to put VF's device addition
to another thread, and then release the device_lock. And I have something
uncertain: 

1. If we put the device addition into another thread and avoid holding
device_lock and pci_bus_sem at the same time, I think it's still necessary
to make sure PF won't be removed(through sysfs) before we call
pci_device_add() for VF.
2. Furthermore, if we start a new thread for VF device addition, users may be
not able to get synchronous results of whether sriov enable succeed or not,
as they may check the return value of sriov_numvfs written.

Please let me know if I understand it correctly. Seems all prefer to solve
this issue at SR-IOV side, and no one suggests to adjust the lock order.

Thanks,
Yicong

>
> [1] https://lore.kernel.org/linux-pci/a1c90cfb9ce4062b4823c6647d7709baf1c5534f.camel@kernel.crashing.org/
> [2] https://git.kernel.org/linus/17530e71e016
>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=203981
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/pci/bus.c      |  8 ++++++++
>>  drivers/pci/pci.c      |  4 ++--
>>  drivers/pci/pci.h      |  4 ++++
>>  drivers/pci/pcie/err.c | 18 +++++-------------
>>  4 files changed, 19 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 8e40b3e..eb29273 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -411,6 +411,14 @@ void pci_walk_bus(struct pci_bus *top, int (*cb)(struct pci_dev *, void *),
>>  }
>>  EXPORT_SYMBOL_GPL(pci_walk_bus);
>>  
>> +void pci_lock_and_walk_bus(struct pci_bus *top,
>> +		int (*cb)(struct pci_dev *, void *), void *userdata)
>> +{
>> +	pci_bus_lock(top);
>> +	pci_walk_bus(top, cb, userdata);
>> +	pci_bus_unlock(top);
>> +}
>> +
>>  struct pci_bus *pci_bus_get(struct pci_bus *bus)
>>  {
>>  	if (bus)
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 78c99ef..94a7f91 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5150,7 +5150,7 @@ static bool pci_bus_resetable(struct pci_bus *bus)
>>  }
>>  
>>  /* Lock devices from the top of the tree down */
>> -static void pci_bus_lock(struct pci_bus *bus)
>> +void pci_bus_lock(struct pci_bus *bus)
>>  {
>>  	struct pci_dev *dev;
>>  
>> @@ -5162,7 +5162,7 @@ static void pci_bus_lock(struct pci_bus *bus)
>>  }
>>  
>>  /* Unlock devices from the bottom of the tree up */
>> -static void pci_bus_unlock(struct pci_bus *bus)
>> +void pci_bus_unlock(struct pci_bus *bus)
>>  {
>>  	struct pci_dev *dev;
>>  
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index a0a53bd..8f8cd53 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -39,6 +39,8 @@ int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct *vmai,
>>  int pci_probe_reset_function(struct pci_dev *dev);
>>  int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
>>  int pci_bus_error_reset(struct pci_dev *dev);
>> +void pci_bus_lock(struct pci_bus *bus);
>> +void pci_bus_unlock(struct pci_bus *bus);
>>  
>>  #define PCI_PM_D2_DELAY         200
>>  #define PCI_PM_D3_WAIT          10
>> @@ -286,6 +288,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
>>  
>>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>>  void pci_disable_bridge_window(struct pci_dev *dev);
>> +void pci_lock_and_walk_bus(struct pci_bus *top,
>> +		int (*cb)(struct pci_dev *, void *), void *userdata);
>>  struct pci_bus *pci_bus_get(struct pci_bus *bus);
>>  void pci_bus_put(struct pci_bus *bus);
>>  
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index b0e6048..ce0ef5c 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -50,7 +50,6 @@ static int report_error_detected(struct pci_dev *dev,
>>  	pci_ers_result_t vote;
>>  	const struct pci_error_handlers *err_handler;
>>  
>> -	device_lock(&dev->dev);
>>  	if (!pci_dev_set_io_state(dev, state) ||
>>  		!dev->driver ||
>>  		!dev->driver->err_handler ||
>> @@ -71,7 +70,6 @@ static int report_error_detected(struct pci_dev *dev,
>>  	}
>>  	pci_uevent_ers(dev, vote);
>>  	*result = merge_result(*result, vote);
>> -	device_unlock(&dev->dev);
>>  	return 0;
>>  }
>>  
>> @@ -90,7 +88,6 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
>>  	pci_ers_result_t vote, *result = data;
>>  	const struct pci_error_handlers *err_handler;
>>  
>> -	device_lock(&dev->dev);
>>  	if (!dev->driver ||
>>  		!dev->driver->err_handler ||
>>  		!dev->driver->err_handler->mmio_enabled)
>> @@ -100,7 +97,6 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
>>  	vote = err_handler->mmio_enabled(dev);
>>  	*result = merge_result(*result, vote);
>>  out:
>> -	device_unlock(&dev->dev);
>>  	return 0;
>>  }
>>  
>> @@ -109,7 +105,6 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
>>  	pci_ers_result_t vote, *result = data;
>>  	const struct pci_error_handlers *err_handler;
>>  
>> -	device_lock(&dev->dev);
>>  	if (!dev->driver ||
>>  		!dev->driver->err_handler ||
>>  		!dev->driver->err_handler->slot_reset)
>> @@ -119,7 +114,6 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
>>  	vote = err_handler->slot_reset(dev);
>>  	*result = merge_result(*result, vote);
>>  out:
>> -	device_unlock(&dev->dev);
>>  	return 0;
>>  }
>>  
>> @@ -127,7 +121,6 @@ static int report_resume(struct pci_dev *dev, void *data)
>>  {
>>  	const struct pci_error_handlers *err_handler;
>>  
>> -	device_lock(&dev->dev);
>>  	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
>>  		!dev->driver ||
>>  		!dev->driver->err_handler ||
>> @@ -138,7 +131,6 @@ static int report_resume(struct pci_dev *dev, void *data)
>>  	err_handler->resume(dev);
>>  out:
>>  	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
>> -	device_unlock(&dev->dev);
>>  	return 0;
>>  }
>>  
>> @@ -200,9 +192,9 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>>  
>>  	pci_dbg(dev, "broadcast error_detected message\n");
>>  	if (state == pci_channel_io_frozen)
>> -		pci_walk_bus(bus, report_frozen_detected, &status);
>> +		pci_lock_and_walk_bus(bus, report_frozen_detected, &status);
>>  	else
>> -		pci_walk_bus(bus, report_normal_detected, &status);
>> +		pci_lock_and_walk_bus(bus, report_normal_detected, &status);
>>  
>>  	if (state == pci_channel_io_frozen &&
>>  	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
>> @@ -211,7 +203,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast mmio_enabled message\n");
>> -		pci_walk_bus(bus, report_mmio_enabled, &status);
>> +		pci_lock_and_walk_bus(bus, report_mmio_enabled, &status);
>>  	}
>>  
>>  	if (status == PCI_ERS_RESULT_NEED_RESET) {
>> @@ -222,14 +214,14 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>>  		 */
>>  		status = PCI_ERS_RESULT_RECOVERED;
>>  		pci_dbg(dev, "broadcast slot_reset message\n");
>> -		pci_walk_bus(bus, report_slot_reset, &status);
>> +		pci_lock_and_walk_bus(bus, report_slot_reset, &status);
>>  	}
>>  
>>  	if (status != PCI_ERS_RESULT_RECOVERED)
>>  		goto failed;
>>  
>>  	pci_dbg(dev, "broadcast resume message\n");
>> -	pci_walk_bus(bus, report_resume, &status);
>> +	pci_lock_and_walk_bus(bus, report_resume, &status);
>>  
>>  	pci_aer_clear_device_status(dev);
>>  	pci_cleanup_aer_uncorrect_error_status(dev);
>> -- 
>> 2.8.1
>>
> .
>

