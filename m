Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4714B1D0489
	for <lists+linux-pci@lfdr.de>; Wed, 13 May 2020 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgEMBuK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 May 2020 21:50:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4398 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbgEMBuK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 May 2020 21:50:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 73FC533283DC5F6787D9;
        Wed, 13 May 2020 09:50:08 +0800 (CST)
Received: from [10.65.58.147] (10.65.58.147) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 May 2020
 09:50:00 +0800
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <18609.1588812972@famine>
 <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <9908.1589311230@famine>
CC:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ashok.raj@intel.com>,
        liudongdong 00290354 <liudongdong3@huawei.com>,
        Linuxarm <linuxarm@huawei.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <1216d38b-bc0a-b4d5-967f-f5a86d96287c@hisilicon.com>
Date:   Wed, 13 May 2020 09:50:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <9908.1589311230@famine>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.58.147]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/5/13 3:20, Jay Vosburgh wrote:
> sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> If there are non-hotplug capable devices connected to a given
>> port, then during the fatal error recovery(triggered by DPC or
>> AER), after calling reset_link() function, we cannot rely on
>> hotplug handler to detach and re-enumerate the device drivers
>> in the affected bus. Instead, we will have to let the error
>> recovery handler call report_slot_reset() for all devices in
>> the bus to notify about the reset operation. Although this is
>> only required for non hot-plug capable devices, doing it for
>> hotplug capable devices should not affect the functionality.
> 	Yicong,
>
> 	Does the patch below also resolve the issue for you, as with
> your changed version of my original patch?

Yes. It works.


>
> 	-J
>
>> Along with above issue, this fix also applicable to following
>> issue.
>>
>> Commit 6d2c89441571 ("PCI/ERR: Update error status after
>> reset_link()") added support to store status of reset_link()
>> call. Although this fixed the error recovery issue observed if
>> the initial value of error status is PCI_ERS_RESULT_DISCONNECT
>> or PCI_ERS_RESULT_NO_AER_DRIVER, it also discarded the status
>> result from report_frozen_detected. This can cause a failure to
>> recover if _NEED_RESET is returned by report_frozen_detected and
>> report_slot_reset is not invoked.
>>
>> Such an event can be induced for testing purposes by reducing the
>> Max_Payload_Size of a PCIe bridge to less than that of a device
>> downstream from the bridge, and then initiating I/O through the
>> device, resulting in oversize transactions.  In the presence of DPC,
>> this results in a containment event and attempted reset and recovery
>> via pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not
>> invoked, and the device does not recover.
>>
>> [original patch is from jay.vosburgh@canonical.com]
>> [original patch link https://lore.kernel.org/linux-pci/18609.1588812972@famine/]
>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>> drivers/pci/pcie/err.c | 19 +++++++++++++++----
>> 1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 14bb8f54723e..db80e1ecb2dc 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -165,13 +165,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>> 	pci_dbg(dev, "broadcast error_detected message\n");
>> 	if (state == pci_channel_io_frozen) {
>> 		pci_walk_bus(bus, report_frozen_detected, &status);
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
>> +		if (status == PCI_ERS_RESULT_DISCONNECT) {
>> 			pci_warn(dev, "link reset failed\n");
>> 			goto failed;
>> 		}
>> -	} else {
>> -		pci_walk_bus(bus, report_normal_detected, &status);
>> 	}
>>
>> 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>> -- 
>> 2.17.1
>>
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com
> .
>

