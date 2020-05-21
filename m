Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB79C1DCB88
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 12:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgEUK6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 06:58:21 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4834 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727864AbgEUK6V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 06:58:21 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A83EBD3A61E79073949C;
        Thu, 21 May 2020 18:58:18 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 21 May 2020
 18:58:13 +0800
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>, <bhelgaas@google.com>
References: <18609.1588812972@famine>
 <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com>
 <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
CC:     <jay.vosburgh@canonical.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <8dd2233c-a636-59fa-4c6e-5da08556d09e@hisilicon.com>
Date:   Thu, 21 May 2020 18:58:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/5/21 1:04, Kuppuswamy, Sathyanarayanan wrote:
>
>
> On 5/20/20 1:28 AM, Yicong Yang wrote:
>> On 2020/5/7 11:32, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>
>>> If there are non-hotplug capable devices connected to a given
>>> port, then during the fatal error recovery(triggered by DPC or
>>> AER), after calling reset_link() function, we cannot rely on
>>> hotplug handler to detach and re-enumerate the device drivers
>>> in the affected bus. Instead, we will have to let the error
>>> recovery handler call report_slot_reset() for all devices in
>>> the bus to notify about the reset operation. Although this is
>>> only required for non hot-plug capable devices, doing it for
>>> hotplug capable devices should not affect the functionality.
>>>
>>> Along with above issue, this fix also applicable to following
>>> issue.
>>>
>>> Commit 6d2c89441571 ("PCI/ERR: Update error status after
>>> reset_link()") added support to store status of reset_link()
>>> call. Although this fixed the error recovery issue observed if
>>> the initial value of error status is PCI_ERS_RESULT_DISCONNECT
>>> or PCI_ERS_RESULT_NO_AER_DRIVER, it also discarded the status
>>> result from report_frozen_detected. This can cause a failure to
>>> recover if _NEED_RESET is returned by report_frozen_detected and
>>> report_slot_reset is not invoked.
>>>
>>> Such an event can be induced for testing purposes by reducing the
>>> Max_Payload_Size of a PCIe bridge to less than that of a device
>>> downstream from the bridge, and then initiating I/O through the
>>> device, resulting in oversize transactions.  In the presence of DPC,
>>> this results in a containment event and attempted reset and recovery
>>> via pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not
>>> invoked, and the device does not recover.
>>>
>>> [original patch is from jay.vosburgh@canonical.com]
>>> [original patch link https://lore.kernel.org/linux-pci/18609.1588812972@famine/]
>>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>> ---
>>>   drivers/pci/pcie/err.c | 19 +++++++++++++++----
>>>   1 file changed, 15 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>> index 14bb8f54723e..db80e1ecb2dc 100644
>>> --- a/drivers/pci/pcie/err.c
>>> +++ b/drivers/pci/pcie/err.c
>>> @@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>>       pci_dbg(dev, "broadcast error_detected message\n");
>>>       if (state == pci_channel_io_frozen) {
>>>           pci_walk_bus(bus, report_frozen_detected, &status);
>>> -        status = reset_link(dev);
>>> -        if (status != PCI_ERS_RESULT_RECOVERED) {
>>> +        status = PCI_ERS_RESULT_NEED_RESET;
>>> +    } else {
>>> +        pci_walk_bus(bus, report_normal_detected, &status);
>>> +    }
>>> +
>>> +    if (status == PCI_ERS_RESULT_NEED_RESET) {
>>> +        if (reset_link) {
>>> +            if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED)
>>
>> we'll call reset_link() only if link is frozen. so it may have problem here.
> you mean before this change right?
> After this change, reset_link() will be called as long as status is
> PCI_ERS_RESULT_NEED_RESET.

Yes. I think we should reset the link only if the io is blocked as before. There's
no reason to reset a normal link.

Furthermore, PCI_ERS_RESULT_NEED_RESET means device driver requires a slot reset rather
than a link reset, so it maybe improper to use it to judge whether a link reset is needed.
We decide whether to do a link reset only by the io state.

Thanks,
Yicong


>>
>> Thanks,
>> Yicong
>>
>>
>>> +                status = PCI_ERS_RESULT_DISCONNECT;
>>> +        } else {
>>> +            if (pci_bus_error_reset(dev))
>>> +                status = PCI_ERS_RESULT_DISCONNECT;
>>> +        }
>>> +
>>> +        if (status == PCI_ERS_RESULT_DISCONNECT) {
>>>               pci_warn(dev, "link reset failed\n");
>>>               goto failed;
>>>           }
>>> -    } else {
>>> -        pci_walk_bus(bus, report_normal_detected, &status);
>>>       }
>>>         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>
> .
>

