Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 268EA137A91
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jan 2020 01:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgAKA0j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 19:26:39 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:49884 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgAKA0i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jan 2020 19:26:38 -0500
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Jan 2020 19:26:37 EST
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 3240BA0359;
        Sat, 11 Jan 2020 00:18:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo05-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo05-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3LBXdJTl0hyx; Sat, 11 Jan 2020 00:18:51 +0000 (UTC)
Received: from mail.gonehiking.org (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        by mailout.easymail.ca (Postfix) with ESMTPA id 2ABC7A035C;
        Sat, 11 Jan 2020 00:18:40 +0000 (UTC)
Received: from [192.168.1.4] (rhapsody.internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id CC3583EEEF;
        Fri, 10 Jan 2020 17:18:39 -0700 (MST)
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
To:     Jerry.Hoemann@hpe.com
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Kairui Song <kasong@redhat.com>, Baoquan He <bhe@redhat.com>,
        linux-pci@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Randy Wright <rwright@hpe.com>
References: <20200110214217.GA88274@google.com>
 <e0194581-4cdd-3629-d9fe-10a1cfd29d03@gonehiking.org>
 <20200110230003.GB1875851@anatevka.americas.hpqcorp.net>
From:   Khalid Aziz <khalid@gonehiking.org>
Autocrypt: addr=khalid@gonehiking.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d2715683-f171-a825-3c0b-678b6c5c1a79@gonehiking.org>
Date:   Fri, 10 Jan 2020 17:18:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110230003.GB1875851@anatevka.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/10/20 4:00 PM, Jerry Hoemann wrote:
> On Fri, Jan 10, 2020 at 03:25:36PM -0700, Khalid Aziz and Shuah Khan wrote:
>> On 1/10/20 2:42 PM, Bjorn Helgaas wrote:
>>> [+cc Deepa (also working in this area)]
>>>
>>> On Thu, Dec 26, 2019 at 03:21:18AM +0800, Kairui Song wrote:
>>>> There are reports about kdump hang upon reboot on some HPE machines,
>>>> kernel hanged when trying to shutdown a PCIe port, an uncorrectable
>>>> error occurred and crashed the system.
>>>
>>> Details?  Do you have URLs for bug reports, dmesg logs, etc?
>>>
>>>> On the machine I can reproduce this issue, part of the topology
>>>> looks like this:
>>>>
>>>> [0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
>>>>           +-01.0-[02]--
>>>>           +-01.1-[05]--
>>>>           +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
>>>>           +-02.1-[0f]--
>>>>           +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array Gen9 Controllers
>>>>
>>>> When shutting down PCIe port 0000:00:02.2 or 0000:00:02.0, the machine
>>>> will hang, depend on which device is reinitialized in kdump kernel.
>>>>
>>>> If force remove unused device then trigger kdump, the problem will never
>>>> happen:
>>>>
>>>>     echo 1 > /sys/bus/pci/devices/0000\:00\:02.2/0000\:07\:00.0/remove
>>>>     echo c > /proc/sysrq-trigger
>>>>
>>>>     ... Kdump save vmcore through network, the NIC get reinitialized and
>>>>     hpsa is untouched. Then reboot with no problem. (If hpsa is used
>>>>     instead, shutdown the NIC in first kernel will help)
>>>>
>>>> The cause is that some devices are enabled by the first kernel, but it
>>>> don't have the chance to shutdown the device, and kdump kernel is not
>>>> aware of it, unless it reinitialize the device.
>>>>
>>>> Upon reboot, kdump kernel will skip downstream device shutdown and
>>>> clears its bridge's master bit directly. The downstream device could
>>>> error out as it can still send requests but upstream refuses it.
>>>
>>> Can you help me understand the sequence of events?  If I understand
>>> correctly, the desired sequence is:
>>>
>>>   - user kernel boots
>>>   - user kernel panics and kexecs to kdump kernel
>>>   - kdump kernel writes vmcore to network or disk
>>>   - kdump kernel reboots
>>>   - user kernel boots
>>>
>>> But the problem is that as part of the kdump kernel reboot,
>>>
>>>   - kdump kernel disables bus mastering for a Root Port
>>>   - device below the Root Port attempts DMA
>>>   - Root Port receives DMA transaction, handles it as Unsupported
>>>     Request, sends UR Completion to device
>>>   - device signals uncorrectable error
>>>   - uncorrectable error causes a crash (Or a hang?  You mention both
>>>     and I'm not sure which it is)
>>>
>>> Is that right so far?
>>>
>>>> So for kdump, let kernel read the correct hardware power state on boot,
>>>> and always clear the bus master bit of PCI device upon shutdown if the
>>>> device is on. PCIe port driver will always shutdown all downstream
>>>> devices first, so this should ensure all downstream devices have bus
>>>> master bit off before clearing the bridge's bus master bit.
>>>>
>>>> Signed-off-by: Kairui Song <kasong@redhat.com>
>>>> ---
>>>>  drivers/pci/pci-driver.c | 11 ++++++++---
>>>>  drivers/pci/quirks.c     | 20 ++++++++++++++++++++
>>>>  2 files changed, 28 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
>>>> index 0454ca0e4e3f..84a7fd643b4d 100644
>>>> --- a/drivers/pci/pci-driver.c
>>>> +++ b/drivers/pci/pci-driver.c
>>>> @@ -18,6 +18,7 @@
>>>>  #include <linux/kexec.h>
>>>>  #include <linux/of_device.h>
>>>>  #include <linux/acpi.h>
>>>> +#include <linux/crash_dump.h>
>>>>  #include "pci.h"
>>>>  #include "pcie/portdrv.h"
>>>>  
>>>> @@ -488,10 +489,14 @@ static void pci_device_shutdown(struct device *dev)
>>>>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>>>>  	 * device to tell it to not continue to do DMA. Don't touch
>>>>  	 * devices in D3cold or unknown states.
>>>> -	 * If it is not a kexec reboot, firmware will hit the PCI
>>>> -	 * devices with big hammer and stop their DMA any way.
>>>> +	 * If this is kdump kernel, also turn off Bus Master, the device
>>>> +	 * could be activated by previous crashed kernel and may block
>>>> +	 * it's upstream from shutting down.
>>>> +	 * Else, firmware will hit the PCI devices with big hammer
>>>> +	 * and stop their DMA any way.
>>>>  	 */
>>>> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
>>>> +	if ((kexec_in_progress || is_kdump_kernel()) &&
>>>> +			pci_dev->current_state <= PCI_D3hot)
>>>>  		pci_clear_master(pci_dev);
>>>
>>> I'm clearly missing something because this will turn off bus mastering
>>> in cases where we previously left it enabled.
>>>
>>> I was assuming the crash was related to a device doing DMA when the
>>> Root Port had bus mastering disabled.  But that must be wrong.
>>>
>>> I'd like to understand the crash/hang better because the quirk
>>> especially is hard to connect to anything.  If the crash is because of
>>> an AER or other PCIe error, maybe another possibility is that we could
>>> handle it better or disable signaling of it or something.
>>>
>>
>> I am not understanding this failure mode either. That code in
>> pci_device_shutdown() was added originally to address this very issue.
>> The patch 4fc9bbf98fd6 ("PCI: Disable Bus Master only on kexec reboot")
>> shut down any errant DMAs from PCI devices as we kexec a new kernel. In
>> this new patch, this is the same code path that will be taken again when
>> kdump kernel is shutting down. If the errant DMA problem was not fixed
>> by clearing Bus Master bit in this path when kdump kernel was being
>> kexec'd, why does the same code path work the second time around when
>> kdump kernel is shutting down? Is there more going on that we don't
>> understand?
>>
> 
>   Khalid,
> 
>   I don't believe we execute that code path in the crash case.
> 
>   The variable kexec_in_progress is set true in kernel_kexec() before calling
>   machine_kexec().  This is the fast reboot case.
> 
>   I don't see kexec_in_progress set true elsewhere.
> 
> 
>   The code path for crash is different.
> 
>   For instance, panic() will call
> 	-> __crash_kexec()  which calls
> 		-> machine_kexec().
> 
>  So the setting of kexec_in_progress is bypassed.
> 

True, but what that means is if it is an errant DMA causing the issue
you are seeing, that errant DMA can happen any time between when we
start booting kdump kernel and until kdump kernel starts shutting down.
Clearing Bus Master bit when kdump kernel is shutting down means kernel
stays vulnerable for significant amount of time. It might be just a
matter of time before errant DMA happens when crash dump is happening
and causes crash dump to be incomplete or hang. Does that make sense?

--
Khalid

