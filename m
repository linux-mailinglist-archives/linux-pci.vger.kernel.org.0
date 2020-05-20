Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9D61DBAA0
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgETREi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 13:04:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:41831 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgETREa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 May 2020 13:04:30 -0400
IronPort-SDR: oAatfq2e2if+0VvXLVy39JWc9aLewljZReNKZ89T9QKknf4oc72q9jCsbbUc6vvUyIDPyRCFj9
 hBDLV/iMJxQw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 10:04:27 -0700
IronPort-SDR: pdyaneSE1SvFnjbNJYj7WcmrqJFzGGDCv+m7p2ndD56MwaYdM7hDKuQLI0Isy44nsaoySN/B36
 BeHx6RP12Ovg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,414,1583222400"; 
   d="scan'208";a="264752424"
Received: from kskolet-mobl1.amr.corp.intel.com (HELO [10.255.228.207]) ([10.255.228.207])
  by orsmga003.jf.intel.com with ESMTP; 20 May 2020 10:04:26 -0700
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     Yicong Yang <yangyicong@hisilicon.com>, bhelgaas@google.com
Cc:     jay.vosburgh@canonical.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com
References: <18609.1588812972@famine>
 <f4bbacd3af453285271c8fc733652969e11b84f8.1588821160.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <2569c75c-41a6-d0f3-ee34-0d288c4e0b61@linux.intel.com>
Date:   Wed, 20 May 2020 10:04:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dbb211ba-a5f1-0e4f-64c9-6eb28cd1fb7f@hisilicon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/20/20 1:28 AM, Yicong Yang wrote:
> On 2020/5/7 11:32, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
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
>>
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
>>   drivers/pci/pcie/err.c | 19 +++++++++++++++----
>>   1 file changed, 15 insertions(+), 4 deletions(-)
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
> 
> we'll call reset_link() only if link is frozen. so it may have problem here.
you mean before this change right?
After this change, reset_link() will be called as long as status is
PCI_ERS_RESULT_NEED_RESET.
> 
> Thanks,
> Yicong
> 
> 
>> +				status = PCI_ERS_RESULT_DISCONNECT;
>> +		} else {
>> +			if (pci_bus_error_reset(dev))
>> +				status = PCI_ERS_RESULT_DISCONNECT;
>> +		}
>> +
>> +		if (status == PCI_ERS_RESULT_DISCONNECT) {
>>   			pci_warn(dev, "link reset failed\n");
>>   			goto failed;
>>   		}
>> -	} else {
>> -		pci_walk_bus(bus, report_normal_detected, &status);
>>   	}
>>   
>>   	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
> 
