Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACB1CBE13
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 08:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728821AbgEIGfE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 02:35:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4365 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbgEIGfE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 May 2020 02:35:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id ED15481B88DF56C8D873;
        Sat,  9 May 2020 14:35:01 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 14:34:58 +0800
Subject: Re: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
To:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <12115.1588207324@famine>
 <18897ceb-2263-1101-ae43-918a66794e14@linux.intel.com>
 <d72b2b0c-6842-3d76-5b13-2fbb3d25d73f@linux.intel.com>
 <14682.1588279297@famine>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <cda002d3-74ce-80cc-7e16-eeb32a980fe1@hisilicon.com>
Date:   Sat, 9 May 2020 14:35:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <14682.1588279297@famine>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jay, Kuppuswamy

On 2020/5/1 4:41, Jay Vosburgh wrote:
> "Kuppuswamy, Sathyanarayanan" wrote:
>
>> Hi Jay,
>>
>> On 4/29/20 6:15 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>
>>> On 4/29/20 5:42 PM, Jay Vosburgh wrote:
>>>>     Commit 6d2c89441571 ("PCI/ERR: Update error status after
>>>> reset_link()"), introduced a regression, as pcie_do_recovery will
>>>> discard the status result from report_frozen_detected.  This can cause a
>>>> failure to recover if _NEED_RESET is returned by report_frozen_detected
>>>> and report_slot_reset is not invoked.
>>>>
>>>>     Such an event can be induced for testing purposes by reducing
>>>> the Max_Payload_Size of a PCIe bridge to less than that of a device
>>>> downstream from the bridge, and then initating I/O through the device,
>>>> resulting in oversize transactions.  In the presence of DPC, this
>>>> results in a containment event and attempted reset and recovery via
>>>> pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not invoked,
>>>> and the device does not recover.
>>> I think this issue is related to the issue discussed in following
>>> thread (DPC non-hotplug support).
>>>
>>> https://lkml.org/lkml/2020/3/28/328
>>>
>>> If my assumption is correct, you are dealing with devices which are
>>> not hotplug capable. If the devices are hotplug capable then you don't
>>> need to proceed to report_slot_reset(), since hotplug handler will
>>> remove/re-enumerate the devices correctly.
> 	Correct, this particular device (a network card) is in a
> non-hotplug slot.
>
>> Can you check whether following fix works for you?
> 	Yes, it does.
>
> 	I fixed up the whitespace and made a minor change to add braces
> in what look like the correct places around the "if (reset_link)" block;
> the patch I tested with is below.  I'll also install this on another
> machine with hotplug capable slots to test there as well.
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 14bb8f54723e..db80e1ecb2dc 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	pci_dbg(dev, "broadcast error_detected message\n");
>  	if (state == pci_channel_io_frozen) {
>  		pci_walk_bus(bus, report_frozen_detected, &status);
> -		status = reset_link(dev);
> -		if (status != PCI_ERS_RESULT_RECOVERED) {
> +		status = PCI_ERS_RESULT_NEED_RESET;
> +	} else {
> +		pci_walk_bus(bus, report_normal_detected, &status);
> +	}
> +
> +	if (status == PCI_ERS_RESULT_NEED_RESET) {
> +		if (reset_link) {
> +			if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
> +				status = PCI_ERS_RESULT_DISCONNECT;
> +		} else {
> +			if (pci_bus_error_reset(dev))
> +				status = PCI_ERS_RESULT_DISCONNECT;
> +		}
> +

The PCI_ERS_RESULT_NEED_RESET may indicate that the driver requires a *slot* reset.
With this patch, seems later slot reset broadcast may not be performed.

    if (status == PCI_ERS_RESULT_NEED_RESET) {
        status = PCI_ERS_RESULT_RECOVERED;
        pci_dbg(dev, "broadcast slot_reset message\n");
        pci_walk_bus(bus, report_slot_reset, &status);
    }

One minor question, currently the callers of pcie_do_recovery() will always pass a
reset_link pointer, so is the condition necessary?

Yicong

> +		if (status == PCI_ERS_RESULT_DISCONNECT) {
>  			pci_warn(dev, "link reset failed\n");
>  			goto failed;
>  		}
> -	} else {
> -		pci_walk_bus(bus, report_normal_detected, &status);
>  	}
>  
>  	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>
>
> 	-J
>
>> This includes support for bus_reset in recovery function itself.
>>
>> index 14bb8f54723e..c9eaab68ab7a 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -165,13 +165,23 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>        pci_dbg(dev, "broadcast error_detected message\n");
>>        if (state == pci_channel_io_frozen) {
>>        if (state == pci_channel_io_frozen) {
>>                pci_walk_bus(bus, report_frozen_detected, &status);
>> -               status = reset_link(dev);
>> -               if (status != PCI_ERS_RESULT_RECOVERED) {
>> +               status = PCI_ERS_RESULT_NEED_RESET;
>> +       } else {
>> +               pci_walk_bus(bus, report_normal_detected, &status);
>> +       }
>> +
>> +       if (status == PCI_ERS_RESULT_NEED_RESET) {
>> +               if (reset_link)
>> +                       if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
>> +                               status = PCI_ERS_RESULT_DISCONNECT;
>> +               else
>> +                       if (pci_bus_error_reset(dev))
>> +                               status = PCI_ERS_RESULT_DISCONNECT;
>> +
>> +               if (status == PCI_ERS_RESULT_DISCONNECT) {
>>                        pci_warn(dev, "link reset failed\n");
>>                        goto failed;
>>                }
>> -       } else {
>> -               pci_walk_bus(bus, report_normal_detected, &status);
>>        }
>>
>>        if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>
>>
>>>>     Inspection shows a similar path is plausible for a return of
>>>> _CAN_RECOVER and the invocation of report_mmio_enabled.
>>>>
>>>>     Resolve this by preserving the result of report_frozen_detected if
>>>> reset_link does not return _DISCONNECT.
>>>>
>>>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>>>
>>>> ---
>>>>   drivers/pci/pcie/err.c | 11 +++++++++--
>>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index 14bb8f54723e..e4274562f3a0 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -164,10 +164,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev
>>>> *dev,
>>>>       pci_dbg(dev, "broadcast error_detected message\n");
>>>>       if (state == pci_channel_io_frozen) {
>>>> +        pci_ers_result_t status2;
>>>> +
>>>>           pci_walk_bus(bus, report_frozen_detected, &status);
>>>> -        status = reset_link(dev);
>>>> -        if (status != PCI_ERS_RESULT_RECOVERED) {
>>>> +        /* preserve status from report_frozen_detected to
>>>> +         * insure report_mmio_enabled or report_slot_reset are
>>>> +         * invoked even if reset_link returns _RECOVERED.
>>>> +         */
>>>> +        status2 = reset_link(dev);
>>>> +        if (status2 != PCI_ERS_RESULT_RECOVERED) {
>>>>               pci_warn(dev, "link reset failed\n");
>>>> +            status = status2;
>>>>               goto failed;
>>>>           }
>>>>       } else {
>>>>
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com
> .
>

