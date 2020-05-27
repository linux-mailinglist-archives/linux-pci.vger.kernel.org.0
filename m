Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED01E34BF
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 03:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgE0Bb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 21:31:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:41569 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgE0BbZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 21:31:25 -0400
IronPort-SDR: 5IffN1pzqW0sLvxqlaf43Ux9xvM6E+sVP0MMj9W0jW5HHnCYDuZvyB6M93wD/PPxaV5feQT3Zy
 2v+a+1ZB+Nbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 18:31:21 -0700
IronPort-SDR: oWuNtWRlFd0Vj6tKVlEOh7CUkO3QN5UyX9xK8LsWnnRoulkmj92dHw0rFRyfPl5QYfbMYRhxC3
 jhkjPnpBscPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="270284626"
Received: from zalvear-mobl.amr.corp.intel.com (HELO [10.254.67.58]) ([10.254.67.58])
  by orsmga006.jf.intel.com with ESMTP; 26 May 2020 18:31:20 -0700
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     Yicong Yang <yangyicong@hisilicon.com>, bhelgaas@google.com
Cc:     jay.vosburgh@canonical.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <18609.1588812972@famine>
 <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com>
 <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
 <8dd2233c-a636-59fa-4c6e-5da08556d09e@hisilicon.com>
 <d59e5312-9f0b-f6b2-042a-363022989b8f@linux.intel.com>
 <d7a392e0-4be0-1afb-b917-efa03e2ea2fb@hisilicon.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f9a46300-ef4b-be19-b8cf-bcb876c75d62@linux.intel.com>
Date:   Tue, 26 May 2020 18:31:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <d7a392e0-4be0-1afb-b917-efa03e2ea2fb@hisilicon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 5/21/20 7:56 PM, Yicong Yang wrote:
> 
> 
> On 2020/5/22 3:31, Kuppuswamy, Sathyanarayanan wrote:
>>
>>
>> On 5/21/20 3:58 AM, Yicong Yang wrote:
>>> On 2020/5/21 1:04, Kuppuswamy, Sathyanarayanan wrote:
>>>>
>>>>
>>>> On 5/20/20 1:28 AM, Yicong Yang wrote:
>>>>> On 2020/5/7 11:32, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>>>
>>>>>> If there are non-hotplug capable devices connected to a given
>>>>>> port, then during the fatal error recovery(triggered by DPC or
>>>>>> AER), after calling reset_link() function, we cannot rely on
>>>>>> hotplug handler to detach and re-enumerate the device drivers
>>>>>> in the affected bus. Instead, we will have to let the error
>>>>>> recovery handler call report_slot_reset() for all devices in
>>>>>> the bus to notify about the reset operation. Although this is
>>>>>> only required for non hot-plug capable devices, doing it for
>>>>>> hotplug capable devices should not affect the functionality.
>>>>>>
>>>>>> Along with above issue, this fix also applicable to following
>>>>>> issue.
>>>>>>
>>>>>> Commit 6d2c89441571 ("PCI/ERR: Update error status after
>>>>>> reset_link()") added support to store status of reset_link()
>>>>>> call. Although this fixed the error recovery issue observed if
>>>>>> the initial value of error status is PCI_ERS_RESULT_DISCONNECT
>>>>>> or PCI_ERS_RESULT_NO_AER_DRIVER, it also discarded the status
>>>>>> result from report_frozen_detected. This can cause a failure to
>>>>>> recover if _NEED_RESET is returned by report_frozen_detected and
>>>>>> report_slot_reset is not invoked.
>>>>>>
>>>>>> Such an event can be induced for testing purposes by reducing the
>>>>>> Max_Payload_Size of a PCIe bridge to less than that of a device
>>>>>> downstream from the bridge, and then initiating I/O through the
>>>>>> device, resulting in oversize transactions.  In the presence of DPC,
>>>>>> this results in a containment event and attempted reset and recovery
>>>>>> via pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not
>>>>>> invoked, and the device does not recover.
>>>>>>
>>>>>> [original patch is from jay.vosburgh@canonical.com]
>>>>>> [original patch link https://lore.kernel.org/linux-pci/18609.1588812972@famine/]
>>>>>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>>>>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>>> ---
>>>>>>     drivers/pci/pcie/err.c | 19 +++++++++++++++----
>>>>>>     1 file changed, 15 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>>>> index 14bb8f54723e..db80e1ecb2dc 100644
>>>>>> --- a/drivers/pci/pcie/err.c
>>>>>> +++ b/drivers/pci/pcie/err.c
>>>>>> @@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>>>>         pci_dbg(dev, "broadcast error_detected message\n");
>>>>>>         if (state == pci_channel_io_frozen) {
>>>>>>             pci_walk_bus(bus, report_frozen_detected, &status);
>>>>>> -        status = reset_link(dev);
>>>>>> -        if (status != PCI_ERS_RESULT_RECOVERED) {
>>>>>> +        status = PCI_ERS_RESULT_NEED_RESET;
>>>>>> +    } else {
>>>>>> +        pci_walk_bus(bus, report_normal_detected, &status);
>>>>>> +    }
>>>>>> +
>>>>>> +    if (status == PCI_ERS_RESULT_NEED_RESET) {
>>>>>> +        if (reset_link) {
>>>>>> +            if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
>>>>>
>>>>> we'll call reset_link() only if link is frozen. so it may have problem here.
>>>> you mean before this change right?
>>>> After this change, reset_link() will be called as long as status is
>>>> PCI_ERS_RESULT_NEED_RESET.
>>>
>>> Yes. I think we should reset the link only if the io is blocked as before. There's
>>> no reason to reset a normal link.
>> Currently, only AER and DPC driver uses pcie_do_recovery() call. So the
>> possible reset_link options are dpc_reset_link() and aer_root_reset().
>>
>> In dpc_reset_link() case, the link is already disabled and hence we
>> don't need to do another reset. In case of aer_root_reset() it
>> uses pci_bus_error_reset() to reset the slot.
> 
> Not exactly. In pci_bus_error_reset(), we call pci_slot_reset() only if it's
> hotpluggable. But we always call pci_bus_reset() to perform a secondary bus
> reset for the bridge. That's what I think is unnecessary for a normal link,
> and that's what reset link indicates us to do. The slot reset is introduced
> in the process only to solve side effects. (c4eed62a2143, PCI/ERR: Use slot reset if available)

IIUC, pci_bus_reset() will do slot reset if its supported (hot-plug
capable slots). If its not supported then it will attempt secondary
bus reset. So secondary bus reset will be attempted only if slot
reset is not supported.

Since reported_error_detected() requests us to do reset, we will have
to attempt some kind of reset before we call ->slot_reset() right?
What is the side effect in calling secondary bus reset?

> 
> PCI_ERS_RESULT_NEED_RESET indicates that the driver
> wants a platform-dependent slot reset and its ->slot_reset() method to be called then.
> I don't think it's same as slot reset mentioned above, which is only for hotpluggable
> ones.
What you think is the correct reset implementation ? Is it something
like this?

if (hotplug capable)
    try_slot_reset()
else
    do_nothing()
> 
> Previously, if link is normal and the driver reports PCI_ERS_RESULT_NEED_RESET,
> we'll only call ->slot_reset() without slot reset in reset_link(). Maybe it's better
> to perform just like before.
> 
> Thanks.
> 
> 
>>>
>>> Furthermore, PCI_ERS_RESULT_NEED_RESET means device driver requires a slot reset rather
>>> than a link reset, so it maybe improper to use it to judge whether a link reset is needed.
>>> We decide whether to do a link reset only by the io state.
>>>
>>> Thanks,
>>> Yicong
>>>
>>>
>>>>>
>>>>> Thanks,
>>>>> Yicong
>>>>>
>>>>>
>>>>>> +                status = PCI_ERS_RESULT_DISCONNECT;
>>>>>> +        } else {
>>>>>> +            if (pci_bus_error_reset(dev))
>>>>>> +                status = PCI_ERS_RESULT_DISCONNECT;
>>>>>> +        }
>>>>>> +
>>>>>> +        if (status == PCI_ERS_RESULT_DISCONNECT) {
>>>>>>                 pci_warn(dev, "link reset failed\n");
>>>>>>                 goto failed;
>>>>>>             }
>>>>>> -    } else {
>>>>>> -        pci_walk_bus(bus, report_normal_detected, &status);
>>>>>>         }
>>>>>>           if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>>>>
>>>> .
>>>>
>>>
>> .
>>
> 
