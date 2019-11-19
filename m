Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1804101ED1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 09:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbfKSI5g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 03:57:36 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbfKSI5f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 03:57:35 -0500
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 3D2A6EF9CA4D3193E1C4;
        Tue, 19 Nov 2019 16:57:33 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 16:57:32 +0800
Received: from [127.0.0.1] (10.40.49.11) by dggeme758-chm.china.huawei.com
 (10.3.19.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Nov 2019 16:57:24 +0800
Subject: Re: [PATCH] PCI/AER: Fix AER/sysfs sriov_numvfs deadlock in
 pcie_do_recovery()
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linuxarm@huawei.com>
References: <20191114223951.GA2419@google.com>
From:   Jay Fang <f.fangjian@huawei.com>
Message-ID: <bdfaaa34-3d3d-ad9a-4e24-4be97e85d216@huawei.com>
Date:   Tue, 19 Nov 2019 16:57:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191114223951.GA2419@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.49.11]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme758-chm.china.huawei.com (10.3.19.104)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019/11/15 6:39, Bjorn Helgaas wrote:
> Just FYI, "git am" complained:
> 
>   Applying: PCI/AER: Fix AER/sysfs sriov_numvfs deadlock in pcie_do_recovery()
>   error: corrupt patch at line 10
>   Patch failed at 0001 PCI/AER: Fix AER/sysfs sriov_numvfs deadlock in pcie_do_recovery()
> 
> It applied fine by hand, and I didn't figure out what the problem was,
> so just FYI.
> 
> On Fri, Sep 06, 2019 at 10:33:58AM +0800, Jay Fang wrote:
>> A deadlock triggered by a NONFATAL AER event during a sysfs "sriov_numvfs"
>> operation:
> 
> How often does this happen?  Always?  Only when an AER event races
> with the sysfs write?
Although not very frequent,the impact is fatal. This bug is very
necessary to be fixed.

> 
>>   enable one VF
>>   # echo 1 > /sys/devices/pci0000:74/0000:74:00.0/0000:75:00.0/sriov_numvfs
>>
>>   The sysfs "sriov_numvfs" side is:
>>
>>     sriov_numvfs_store
>>       device_lock                         # hold the device_lock
>>         ...
>>         pci_enable_sriov
>>           sriov_enable
>>             ...
>>             pci_device_add
>>               down_write(&pci_bus_sem)    # wait for the pci_bus_sem
>>
>>   The AER side is:
>>
>>     pcie_do_recovery
>>       pci_walk_bus
>>         down_read(&pci_bus_sem)           # hold the pci_bus_sem
>>           report_resume
>>             device_lock                   # wait for device_unlock()
>>
>> The calltrace is as below:
>> [  258.411464] INFO: task kworker/0:1:13 blocked for more than 120 seconds.
>> [  258.418139]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
>> [  258.424379] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  258.432172] kworker/0:1     D    0    13      2 0x00000028
>> [  258.437640] Workqueue: events aer_recover_work_func
>> [  258.442496] Call trace:
>> [  258.444933]  __switch_to+0xb4/0x1b8
>> [  258.448409]  __schedule+0x1ec/0x720
>> [  258.451884]  schedule+0x38/0x90
>> [  258.455012]  schedule_preempt_disabled+0x20/0x38
>> [  258.459610]  __mutex_lock.isra.1+0x150/0x518
>> [  258.463861]  __mutex_lock_slowpath+0x10/0x18
>> [  258.468112]  mutex_lock+0x34/0x40
>> [  258.471413]  report_resume+0x1c/0x78
>> [  258.474973]  pci_walk_bus+0x58/0xb0
>> [  258.478451]  pcie_do_recovery+0x18c/0x248
>> [  258.482445]  aer_recover_work_func+0xe0/0x118
>> [  258.486783]  process_one_work+0x1e4/0x468
>> [  258.490776]  worker_thread+0x40/0x450
>> [  258.494424]  kthread+0x128/0x130
>> [  258.497639]  ret_from_fork+0x10/0x1c
>> [  258.501329] INFO: task flr.sh:4534 blocked for more than 120 seconds.
>> [  258.507742]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
>> [  258.513980] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> [  258.521774] flr.sh          D    0  4534   4504 0x00000000
>> [  258.527235] Call trace:
>> [  258.529671]  __switch_to+0xb4/0x1b8
>> [  258.533146]  __schedule+0x1ec/0x720
>> [  258.536619]  schedule+0x38/0x90
>> [  258.539749]  rwsem_down_write_failed+0x14c/0x210
>> [  258.544347]  down_write+0x48/0x60
>> [  258.547648]  pci_device_add+0x1a0/0x290
>> [  258.551469]  pci_iov_add_virtfn+0x190/0x358
>> [  258.555633]  sriov_enable+0x24c/0x480
>> [  258.559279]  pci_enable_sriov+0x14/0x28
>> [  258.563101]  hisi_zip_sriov_configure+0x64/0x100 [hisi_zip]
>> [  258.568649]  sriov_numvfs_store+0xc4/0x190
>> [  258.572728]  dev_attr_store+0x18/0x28
>> [  258.576375]  sysfs_kf_write+0x3c/0x50
>> [  258.580024]  kernfs_fop_write+0x114/0x1d8
>> [  258.584018]  __vfs_write+0x18/0x38
>> [  258.587404]  vfs_write+0xa4/0x1b0
>> [  258.590705]  ksys_write+0x60/0xd8
>> [  258.594007]  __arm64_sys_write+0x18/0x20
>> [  258.597914]  el0_svc_common+0x5c/0x100
>> [  258.601646]  el0_svc_handler+0x2c/0x80
>> [  258.605381]  el0_svc+0x8/0xc
>> [  379.243461] INFO: task kworker/0:1:13 blocked for more than 241 seconds.
>> [  379.250134]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
>> [  379.256373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>
>> Using the same locking order is a good way to solve this AB->BA kind of
>> deadlock. Adjust the locking order of the AER side, taking device_lock
>> firstly and then the pci_bus_sem, to make sure it's locking order is the
>> same as the sriov side. This patch solves the above deadlock issue only
>> with little changes.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203981
>> Signed-off-by: Jay Fang <f.fangjian@huawei.com>
>> ---
>>  drivers/pci/pcie/err.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 773197a..dcc8638 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -50,7 +50,6 @@ static int report_error_detected(struct pci_dev *dev,
>> 	pci_ers_result_t vote;
>> 	const struct pci_error_handlers *err_handler;
>>
>> -	device_lock(&dev->dev);
>> 	if (!pci_dev_set_io_state(dev, state) ||
>> 		!dev->driver ||
>> 		!dev->driver->err_handler ||
>> @@ -71,7 +70,6 @@ static int report_error_detected(struct pci_dev *dev,
>> 	}
>> 	pci_uevent_ers(dev, vote);
>> 	*result = merge_result(*result, vote);
>> -	device_unlock(&dev->dev);
>> 	return 0;
>>  }
>>
>> @@ -90,7 +88,6 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
>> 	pci_ers_result_t vote, *result = data;
>> 	const struct pci_error_handlers *err_handler;
>>
>> -	device_lock(&dev->dev);
>> 	if (!dev->driver ||
>> 		!dev->driver->err_handler ||
>> 		!dev->driver->err_handler->mmio_enabled)
>> @@ -100,7 +97,6 @@ static int report_mmio_enabled(struct pci_dev *dev, void *data)
>> 	vote = err_handler->mmio_enabled(dev);
>> 	*result = merge_result(*result, vote);
>>  out:
>> -	device_unlock(&dev->dev);
>> 	return 0;
>>  }
>>
>> @@ -109,7 +105,6 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
>> 	pci_ers_result_t vote, *result = data;
>> 	const struct pci_error_handlers *err_handler;
>>
>> -	device_lock(&dev->dev);
>> 	if (!dev->driver ||
>> 		!dev->driver->err_handler ||
>> 		!dev->driver->err_handler->slot_reset)
>> @@ -119,7 +114,6 @@ static int report_slot_reset(struct pci_dev *dev, void *data)
>> 	vote = err_handler->slot_reset(dev);
>> 	*result = merge_result(*result, vote);
>>  out:
>> -	device_unlock(&dev->dev);
>> 	return 0;
>>  }
>>
>> @@ -127,7 +121,6 @@ static int report_resume(struct pci_dev *dev, void *data)
>>  {
>> 	const struct pci_error_handlers *err_handler;
>>
>> -	device_lock(&dev->dev);
>> 	if (!pci_dev_set_io_state(dev, pci_channel_io_normal) ||
>> 		!dev->driver ||
>> 		!dev->driver->err_handler ||
>> @@ -138,7 +131,6 @@ static int report_resume(struct pci_dev *dev, void *data)
>> 	err_handler->resume(dev);
>>  out:
>> 	pci_uevent_ers(dev, PCI_ERS_RESULT_RECOVERED);
>> -	device_unlock(&dev->dev);
>> 	return 0;
>>  }
>>
>> @@ -198,6 +190,8 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>> 		dev = dev->bus->self;
>> 	bus = dev->subordinate;
>>
>> +	device_lock(&dev->dev);
>> +
>> 	pci_dbg(dev, "broadcast error_detected message\n");
>> 	if (state == pci_channel_io_frozen)
>> 		pci_walk_bus(bus, report_frozen_detected, &status);
>> @@ -231,12 +225,14 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>> 	pci_dbg(dev, "broadcast resume message\n");
>> 	pci_walk_bus(bus, report_resume, &status);
>>
>> +	device_unlock(&dev->dev);
> 
> IIUC, previously this path took pci_bus_sem several times (each time
> we call pci_walk_bus()), and then took the device_lock for each device
> visited by pci_walk_bus().
> 
> After this patch, we would hold the device lock for a single device
> (the root of the hierarchy walked by pci_walk_bus()) while we call
> pci_walk_bus() several times.
> 
> Unless I'm missing something, that means we never acquire the
> device_lock for the devices *visited* by pci_walk_bus() at all.
> 
> That doesn't sound like a safe change.  If it is safe, you should
> explain why in the commit log.
> 
Thanks. You are right.

>> 	pci_aer_clear_device_status(dev);
>> 	pci_cleanup_aer_uncorrect_error_status(dev);
>> 	pci_info(dev, "AER: Device recovery successful\n");
>> 	return;
>>
>>  failed:
>> +	device_unlock(&dev->dev);
>> 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
>>
>> 	/* TODO: Should kernel panic here? */
> 
> Bjorn
> 
> .
> 

