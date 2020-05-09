Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC571CC366
	for <lists+linux-pci@lfdr.de>; Sat,  9 May 2020 19:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgEIRzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 May 2020 13:55:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:12245 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgEIRzw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 May 2020 13:55:52 -0400
IronPort-SDR: ea98B2T+53kFY2tNpOtxMbLm1dg5NETRmIgZl96ETtNz1REm3o0eT3ydJb1gi83a+GQta02fO5
 rsYRDwgwMQiw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 10:55:51 -0700
IronPort-SDR: pLn0YEtLaf+QDcD8Vo6LNKiwCq/Ntvm78P5riRcDHB1pHLjnsQLcJ5dDn+gWUHuT/AjFeDdGWK
 QW6TkiftXJHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,372,1583222400"; 
   d="scan'208";a="297262818"
Received: from stnguye1-mobl.amr.corp.intel.com (HELO [10.255.228.45]) ([10.255.228.45])
  by orsmga008.jf.intel.com with ESMTP; 09 May 2020 10:55:51 -0700
Subject: Re: [PATCH] PCI/ERR: Resolve regression in pcie_do_recovery
To:     Yicong Yang <yangyicong@hisilicon.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <12115.1588207324@famine>
 <18897ceb-2263-1101-ae43-918a66794e14@linux.intel.com>
 <d72b2b0c-6842-3d76-5b13-2fbb3d25d73f@linux.intel.com>
 <14682.1588279297@famine>
 <cda002d3-74ce-80cc-7e16-eeb32a980fe1@hisilicon.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <818a6db3-f97e-83cf-83d9-7a0a2bd1dff7@linux.intel.com>
Date:   Sat, 9 May 2020 10:55:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cda002d3-74ce-80cc-7e16-eeb32a980fe1@hisilicon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/8/20 11:35 PM, Yicong Yang wrote:
> Hi Jay, Kuppuswamy
> 
> On 2020/5/1 4:41, Jay Vosburgh wrote:
>> "Kuppuswamy, Sathyanarayanan" wrote:
>>
>>> Hi Jay,
>>>
>>> On 4/29/20 6:15 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>>
>>>> On 4/29/20 5:42 PM, Jay Vosburgh wrote:
>>>>>      Commit 6d2c89441571 ("PCI/ERR: Update error status after
>>>>> reset_link()"), introduced a regression, as pcie_do_recovery will
>>>>> discard the status result from report_frozen_detected.  This can cause a
>>>>> failure to recover if _NEED_RESET is returned by report_frozen_detected
>>>>> and report_slot_reset is not invoked.
>>>>>
>>>>>      Such an event can be induced for testing purposes by reducing
>>>>> the Max_Payload_Size of a PCIe bridge to less than that of a device
>>>>> downstream from the bridge, and then initating I/O through the device,
>>>>> resulting in oversize transactions.  In the presence of DPC, this
>>>>> results in a containment event and attempted reset and recovery via
>>>>> pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not invoked,
>>>>> and the device does not recover.
>>>> I think this issue is related to the issue discussed in following
>>>> thread (DPC non-hotplug support).
>>>>
>>>> https://lkml.org/lkml/2020/3/28/328
>>>>
>>>> If my assumption is correct, you are dealing with devices which are
>>>> not hotplug capable. If the devices are hotplug capable then you don't
>>>> need to proceed to report_slot_reset(), since hotplug handler will
>>>> remove/re-enumerate the devices correctly.
>> 	Correct, this particular device (a network card) is in a
>> non-hotplug slot.
>>
>>> Can you check whether following fix works for you?
>> 	Yes, it does.
>>
>> 	I fixed up the whitespace and made a minor change to add braces
>> in what look like the correct places around the "if (reset_link)" block;
>> the patch I tested with is below.  I'll also install this on another
>> machine with hotplug capable slots to test there as well.
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 14bb8f54723e..db80e1ecb2dc 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	pci_dbg(dev, "broadcast error_detected message\n");
>>   	if (state == pci_channel_io_frozen) {
>>   		pci_walk_bus(bus, report_frozen_detected, &status);
>> -		status = reset_link(dev);
>> -		if (status != PCI_ERS_RESULT_RECOVERED) {
>> +		status = PCI_ERS_RESULT_NEED_RESET;
>> +	} else {
>> +		pci_walk_bus(bus, report_normal_detected, &status);
>> +	}
>> +
>> +	if (status == PCI_ERS_RESULT_NEED_RESET) {
>> +		if (reset_link) {
>> +			if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
>> +				status = PCI_ERS_RESULT_DISCONNECT;
>> +		} else {
>> +			if (pci_bus_error_reset(dev))
>> +				status = PCI_ERS_RESULT_DISCONNECT;
>> +		}
>> +
> 
> The PCI_ERS_RESULT_NEED_RESET may indicate that the driver requires a *slot* reset.
> With this patch, seems later slot reset broadcast may not be performed.
Slot reset wont be performed only if reset_link or pci_bus_error_reset
returns error. Otherwise, we will still call pci_slot_reset later.
> 
>      if (status == PCI_ERS_RESULT_NEED_RESET) {
>          status = PCI_ERS_RESULT_RECOVERED;
>          pci_dbg(dev, "broadcast slot_reset message\n");
>          pci_walk_bus(bus, report_slot_reset, &status);
>      }
> 
> One minor question, currently the callers of pcie_do_recovery() will always pass a
> reset_link pointer, so is the condition necessary?
Yes, currently we don't need it. I added it to cover future use cases.
But we can remove it if not needed.
> 
> Yicong
> 
>> +		if (status == PCI_ERS_RESULT_DISCONNECT) {
>>   			pci_warn(dev, "link reset failed\n");
>>   			goto failed;
>>   		}
>> -	} else {
>> -		pci_walk_bus(bus, report_normal_detected, &status);
>>   	}
>>   
>>   	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>
>>pci_bus_error_reset
>> 	-J
>>
>>> This includes support for bus_reset in recovery function itself.
>>>
>>> index 14bb8f54723e..c9eaab68ab7a 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -165,13 +165,23 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>         pci_dbg(dev, "broadcast error_detected message\n");
>>>         if (state == pci_channel_io_frozen) {
>>>         if (state == pci_channel_io_frozen) {
>>>                 pci_walk_bus(bus, report_frozen_detected, &status);
>>> -               status = reset_link(dev);
>>> -               if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +               status = PCI_ERS_RESULT_NEED_RESET;
>>> +       } else {
>>> +               pci_walk_bus(bus, report_normal_detected, &status);
>>> +       }
>>> +
>>> +       if (status == PCI_ERS_RESULT_NEED_RESET) {
>>> +               if (reset_link)
>>> +                       if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
>>> +                               status = PCI_ERS_RESULT_DISCONNECT;
>>> +               else
>>> +                       if (pci_bus_error_reset(dev))
>>> +                               status = PCI_ERS_RESULT_DISCONNECT;
>>> +
>>> +               if (status == PCI_ERS_RESULT_DISCONNECT) {
>>>                         pci_warn(dev, "link reset failed\n");
>>>                         goto failed;
>>>                 }
>>> -       } else {
>>> -               pci_walk_bus(bus, report_normal_detected, &status);
>>>         }
>>>
>>>         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>>
>>>
>>>>>      Inspection shows a similar path is plausible for a return of
>>>>> _CAN_RECOVER and the invocation of report_mmio_enabled.
>>>>>
>>>>>      Resolve this by preserving the result of report_frozen_detected if
>>>>> reset_link does not return _DISCONNECT.
>>>>>
>>>>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>>>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>>>>
>>>>> ---
>>>>>    drivers/pci/pcie/err.c | 11 +++++++++--
>>>>>    1 file changed, 9 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>>> index 14bb8f54723e..e4274562f3a0 100644
>>>>> --- a/drivers/pci/pcie/err.c
>>>>> +++ b/drivers/pci/pcie/err.c
>>>>> @@ -164,10 +164,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev
>>>>> *dev,
>>>>>        pci_dbg(dev, "broadcast error_detected message\n");
>>>>>        if (state == pci_channel_io_frozen) {
>>>>> +        pci_ers_result_t status2;
>>>>> +
>>>>>            pci_walk_bus(bus, report_frozen_detected, &status);
>>>>> -        status = reset_link(dev);
>>>>> -        if (status != PCI_ERS_RESULT_RECOVERED) {
>>>>> +        /* preserve status from report_frozen_detected to
>>>>> +         * insure report_mmio_enabled or report_slot_reset are
>>>>> +         * invoked even if reset_link returns _RECOVERED.
>>>>> +         */
>>>>> +        status2 = reset_link(dev);
>>>>> +        if (status2 != PCI_ERS_RESULT_RECOVERED) {
>>>>>                pci_warn(dev, "link reset failed\n");
>>>>> +            status = status2;
>>>>>                goto failed;
>>>>>            }
>>>>>        } else {
>>>>>
>> ---
>> 	-Jay Vosburgh, jay.vosburgh@canonical.com
>> .
>>
> 
