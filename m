Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123A4217D44
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 05:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgGHDBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jul 2020 23:01:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:4545 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgGHDBm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Jul 2020 23:01:42 -0400
IronPort-SDR: ywg8kFMVeHRaBPsbtyBImv8Yt9+kf3pCRtnyotr8raXpvLSj/wRhf7bKb0rOnXjoiwuAznpFfs
 DKPyvdCFNEWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="209262496"
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="209262496"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 20:01:41 -0700
IronPort-SDR: 53MXg6JC8/ldzupZuZGVwXnLxqSk67uBstvzQd1c3wfwjTER94izOmkRamS0VnjsQm2vyHA1F+
 iBkP7NG/GuNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,326,1589266800"; 
   d="scan'208";a="279808812"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 07 Jul 2020 20:01:41 -0700
Received: from [10.251.29.218] (kliang2-mobl.ccr.corp.intel.com [10.251.29.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 0DC7B5805A3;
        Tue,  7 Jul 2020 20:01:39 -0700 (PDT)
Subject: Re: [PATCH 1/7] PCI/portdrv: Create a platform device for the perf
 uncore driver
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     peterz@infradead.org, bhelgaas@google.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, olof@lixom.net,
        dan.j.williams@intel.com, ak@linux.intel.com,
        Stephane Eranian <eranian@google.com>
References: <20200707194830.GA372615@bjorn-Precision-5520>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <59a4eb9f-3956-1788-33ed-5cc9911b5b1e@linux.intel.com>
Date:   Tue, 7 Jul 2020 23:01:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200707194830.GA372615@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/7/2020 3:48 PM, Bjorn Helgaas wrote:
> [+cc Stephane in case he has thoughts on the perf driver claim issue]
> 
> On Thu, Jul 02, 2020 at 10:05:11AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> On Snow Ridge server, several performance monitoring counters are added
>> in the Root Port Configuration Space of CPU Complex PCIe Root Ports A,
>> which can be used to collect the performance data between the PCIe
>> devices and the components (in M2IOSF) which are responsible for
>> translating and managing the requests to/from the device. The
>> performance data is very useful for analyzing the performance of the
>> PCIe devices.
>>
>> However, the perf uncore driver cannot be loaded to register a
>> performance monitoring unit (PMU) for the counters, because the PCIe
>> Root Ports device already has a bonded driver portdrv_pci.
>>
>> To enable the uncore PMU support for these counters on the uncore
>> driver, a new solution should be introduced, which has to meet the
>> requirements as below:
>> - must have a reliable way to find the PCIe Root Port device from the
>>    uncore driver;
>> - must be able to access the uncore counters of the PCIe Root Port
>>    device from the uncore driver;
>> - must support hotplug. When the PCIe Root Port device is removed, the
>>    uncore driver has to be notified and unregisters the uncore PMU.
>>
>> A new platform device 'perf_uncore_pcieport' is introduced as part of
>> the new solution, which can facilitate the enabling of the uncore PMU in
>> the uncore driver. The new platform device
>> - is a child device of the PCIe Root Port device. It's allocated when
>>    the PCIe Root Ports A device is probed. (For SNR, the PMU counters are
>>    only located in the configuration space of the PCIe Root Ports A.)
>> - stores its pdev as the private driver data pointer of the PCIe Root
>>    Ports A. The pdev can be easily retrieved to check the existence of
>>    the platform device when removing the PCIe Root Ports A.
>> - is unregistered when the PCIe Root Port A is removed. The remove()
>>    method which is provided in the uncore driver will be invoked. The
>>    uncore PMU will be unregistered as well.
>> - doesn't share any memory and IRQ resources. The uncore driver will
>>    only touch the PMU counters in the configuration space of the PCIe
>>    Root Port A.
> 
> I have to admit this is clever.  I don't really *like* it, but we
> don't have any very good alternatives at the moment.
> 
> I don't like the idea of a list of PCI IDs
> (perf_uncore_pcieport_ids[]) below that must be updated for every
> device that needs something like this.  That PCI ID information is
> normally in the drivers themselves, not in bus-level code like this.
>

I don't want to create a platform device for every single device. So I 
added a check here. Yes, it doesn't look pretty, but I don't have a 
better solution for now.

> And I don't like the way this subverts the device ownership model.
> Now we have several drivers (pciehp, aer, dpc, etc, plus this new perf
> driver) that share the same PCI device.  And we rely on the assumption
> that none of these drivers interferes with the others.
> 
> I think the best way to deal with this would be to incorporate the
> existing portdrv users (pciehp, aer, dpc, etc) directly into the PCI
> core so portdrv would not use pci_register_driver(), leaving the Root
> Port device available for the perf driver to claim it the normal way.
> But realistically I don't know when or even whether this will be done.
> 
> I think Stephane has worked around this problem in a different way,
> IIRC by using pci_get_device() in a perf driver to find Ports of
> interest.  That also subverts the device ownership model, and it
> doesn't work naturally with hotplug, but at least it gets the device
> IDs out of the PCI core and into the driver where they belong.  And
> there's value in solving the same problem in the same way.
> 
> Wait a minute!  You've already used the pci_get_device() strategy
> several times:
> 
>    2b3b76b5ec67 ("perf/x86/intel/uncore: Add Ice Lake server uncore support")
>    fdb64822443e ("perf/x86: Add Intel Tiger Lake uncore support")
>    ee49532b38dd ("perf/x86/intel/uncore: Add IMC uncore support for Snow Ridge")
> 
> So what's really different about *this* situation?  Why would you not
> just continue using the same strategy?
>

There are three different methods (MSR, PCICFG, and MMIO) to access the 
uncore counter, while each counter can only accessed using one of the 
method. Many devices have uncore counters. All counters on the same 
device must be accessed using the same method.

The perf uncore driver abstracts three code paths for the above three 
different methods. Each code path is shared among the devices which have 
the corresponding access method.

The pci_get_device() strategy is used by the device in which counters 
can be accessed by MMIO. Currently, the only such device is the IMC 
(Integrated Memory Controller) device. The problem is that the BAR 
address of the IMC counters is located in the PCI Configuration Space of 
the Configuration Agent (Ubox) device. The perf driver is not supposed 
to bind the Ubox device while accessing the counters in another device, 
the IMC device. So the pci_get_device() is used to retrieve the pci_dev 
of the Ubox. The perf driver reads the BAR address from the Ubox and 
maps it to access the IMC counters.

The counters in the Root Port device are in the PCI configuration space 
of the device. For a device whose counters are in the PCI configuration 
space of itself, the perf driver should probe and bind the device. 
However, the Root Port device is already bound by the portdrv driver.
To maximize the code reuse in the perf driver, a platform device is 
introduced as a child of the Root Port device. So the perf driver can 
probe and bind the platform device in a similar method.

The pci_get_device() strategy may work for the case, but from the 
perspective of the perf driver, I don't thing it's a good solution. We 
have to specially handle the pci_get_device() strategy in the code path 
of the PCICFG access method. Also, it's not a complete solution, e.g. as 
you said it doesn't work naturally with hotplug.


Thanks,
Kan

>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>>   drivers/pci/pcie/portdrv_pci.c | 38 ++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
>> index 3acf151..47e33b2 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -15,6 +15,7 @@
>>   #include <linux/init.h>
>>   #include <linux/aer.h>
>>   #include <linux/dmi.h>
>> +#include <linux/platform_device.h>
>>   
>>   #include "../pci.h"
>>   #include "portdrv.h"
>> @@ -90,6 +91,40 @@ static const struct dev_pm_ops pcie_portdrv_pm_ops = {
>>   #define PCIE_PORTDRV_PM_OPS	NULL
>>   #endif /* !PM */
>>   
>> +static const struct pci_device_id perf_uncore_pcieport_ids[] = {
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x334a) },
>> +	{ },
>> +};
>> +
>> +static void perf_platform_device_register(struct pci_dev *dev)
>> +{
>> +	struct platform_device *pdev;
>> +
>> +	if (!pci_match_id(perf_uncore_pcieport_ids, dev))
>> +		return;
>> +
>> +	pdev = platform_device_alloc("perf_uncore_pcieport", PLATFORM_DEVID_AUTO);
>> +	if (!pdev)
>> +		return;
>> +
>> +	pdev->dev.parent = &dev->dev;
>> +
>> +	if (platform_device_add(pdev)) {
>> +		platform_device_put(pdev);
>> +		return;
>> +	}
>> +
>> +	pci_set_drvdata(dev, pdev);
>> +}
>> +
>> +static void perf_platform_device_unregister(struct pci_dev *dev)
>> +{
>> +	struct platform_device *pdev = pci_get_drvdata(dev);
>> +
>> +	if (pdev)
>> +		platform_device_unregister(pdev);
>> +}
>> +
>>   /*
>>    * pcie_portdrv_probe - Probe PCI-Express port devices
>>    * @dev: PCI-Express port device being probed
>> @@ -113,6 +148,8 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>>   	if (status)
>>   		return status;
>>   
>> +	perf_platform_device_register(dev);
>> +
>>   	pci_save_state(dev);
>>   
>>   	dev_pm_set_driver_flags(&dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE |
>> @@ -142,6 +179,7 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>>   		pm_runtime_dont_use_autosuspend(&dev->dev);
>>   	}
>>   
>> +	perf_platform_device_unregister(dev);
>>   	pcie_port_device_remove(dev);
>>   }
>>   
>> -- 
>> 2.7.4
>>
