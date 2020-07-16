Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CE62219A7
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 03:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGPByg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 21:54:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:35107 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgGPByf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 21:54:35 -0400
IronPort-SDR: g+ii3VX9Tcjl3/7n8T6lc8fphK3PATEqvnP93KXQmn/ym4/FqqC/2JEgCHiQ1q2yftSYlS97zK
 H2v0uQpEymbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="136754852"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="136754852"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 18:54:33 -0700
IronPort-SDR: c0QziT+Lm32KtxXwFlbpFjvkgJPqFMIx3dEZubyI2aVkNQlI8FLx4lxEa1PfjL7cVNDWNhbZ5O
 baLPXY0uUEig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="270436087"
Received: from iwenhuan-mobl.amr.corp.intel.com (HELO [10.254.112.107]) ([10.254.112.107])
  by fmsmga008.fm.intel.com with ESMTP; 15 Jul 2020 18:54:33 -0700
Subject: Re: [PATCH v2 1/2] PCI/ERR: Fix fatal error recovery for non-hotplug
 capable devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20200714230803.GA92891@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <f15ffcb5-58f4-e7b7-a182-e4814bad102f@linux.intel.com>
Date:   Wed, 15 Jul 2020 18:54:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714230803.GA92891@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/14/20 4:08 PM, Bjorn Helgaas wrote:
> On Thu, Jun 04, 2020 at 02:50:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> Fatal (DPC) error recovery is currently broken for non-hotplug
>> capable devices. With current implementation, after successful
>> fatal error recovery, non-hotplug capable device state won't be
>> restored properly. You can find related issues in following links.
>>
>> https://lkml.org/lkml/2020/5/27/290
>> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
>> https://lkml.org/lkml/2020/3/28/328
> 
> Can you please convert these all to lore.kernel.org links?  lkml.org
> is not quite as useful or reliable.
Ok. I will fix it in next version.
https://lore.kernel.org/linux-pci/20200527083130.4137-1-
Zhiqiang.Hou@nxp.com/
https://lore.kernel.org/linux-pci/12115.1588207324@famine/
https://lore.kernel.org/linux-
pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
> 
>> Current fatal error recovery implementation relies on hotplug handler
>> for detaching/re-enumerating the affected devices/drivers on DLLSC
>> state changes.
> 
> Can you remind us exactly how this relies on hotplug?  I know it
> *does*, but I can't remember how.  It would sure be nice if we could
> decouple this from pciehp somehow.
In case of platform that supports PCIe native hotplug, once the fatal
error disables the link, we will get DLLSC state change interrupt. On
DLLSC_DOWN event pciehp driver will remove the affected device and
detach the driver.

For platforms that does not support PCIe hotplug, currently the fatal
error recovery is broken. After reset and recovery, the device config
space is not restored properly. And we expect call to ->slot_reset()
fixes this issue.
> 
>> So when dealing with non-hotplug capable devices,
>> recovery code does not restore the state of the affected devices
>> correctly. Correct implementation should call report_slot_reset()
>> function after resetting the link to restore the state of the
>> device/driver.
> 
> We don't restore the state correctly.  What does this look like to the
> user?  Does the device not work?
Device will not be accessible. AFAIK, doing IO should fail.
> 
>> So use PCI_ERS_RESULT_NEED_RESET as error status for successful
>> reset_link() operation and use PCI_ERS_RESULT_DISCONNECT for failure
>> case. PCI_ERS_RESULT_NEED_RESET error state will ensure slot_reset()
>> is called after reset link operation which will also fix the above
>> mentioned issue.
> 
> I think PCI_ERS_RESULT_NEED_RESET results in calling driver
> ->slot_reset() callbacks, right?  Where does the state restoration
> happen?
For fatal errors, since the reset is not triggered by OS, we cannot save
the state of the device before resetting the device. So we assume state
restoration is drivers responsibility and expect drivers to restore the
state in ->slot_reset() call back. But I am not sure whether this is
work for all devices (since this is driver dependent).
For non-fatal errors, slot_reset or bus_reset function will handle the
store/restore of device config space.
> 
> No, I guess it must be something in the hotplug driver that restores
> the state, because you said devices below hotplug-capable ports work
> correctly, but others don't.
For hotplug capable devices, driver is removed and reattached (on DLLSC
state change). So state initialization happens during re-enumeration.

> 
>> [original patch is from jay.vosburgh@canonical.com]
>> [original patch link https://lore.kernel.org/linux-pci/12115.1588207324@famine/]
>> Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>> Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pcie/err.c | 24 ++++++++++++++++++++++--
>>   1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>> index 14bb8f54723e..5fe8561c7185 100644
>> --- a/drivers/pci/pcie/err.c
>> +++ b/drivers/pci/pcie/err.c
>> @@ -165,8 +165,28 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>   	pci_dbg(dev, "broadcast error_detected message\n");
>>   	if (state == pci_channel_io_frozen) {
>>   		pci_walk_bus(bus, report_frozen_detected, &status);
>> -		status = reset_link(dev);
>> -		if (status != PCI_ERS_RESULT_RECOVERED) {
>> +		/*
>> +		 * After resetting the link using reset_link() call, the
>> +		 * possible value of error status is either
>> +		 * PCI_ERS_RESULT_DISCONNECT (failure case) or
>> +		 * PCI_ERS_RESULT_NEED_RESET (success case).
>> +		 * So ignore the return value of report_error_detected()
>> +		 * call for fatal errors. Instead use
>> +		 * PCI_ERS_RESULT_NEED_RESET as initial status value.
>> +		 *
>> +		 * Ignoring the status return value of report_error_detected()
>> +		 * call will also help in case of EDR mode based error
>> +		 * recovery. In EDR mode AER and DPC Capabilities are owned by
>> +		 * firmware and hence report_error_detected() call will possibly
>> +		 * return PCI_ERS_RESULT_NO_AER_DRIVER. So if we don't ignore
>> +		 * the return value of report_error_detected() then
>> +		 * pcie_do_recovery() would report incorrect status after
>> +		 * successful recovery. Ignoring PCI_ERS_RESULT_NO_AER_DRIVER
>> +		 * in non EDR case should not have any functional impact.
> 
> I can't make sense out of the comment.  We already ignore the "status"
> from pci_walk_bus(bus, report_frozen_detected, &status).
Yes, but I am trying to explain why we ignore the status.
> 
> No idea what to make of the second paragraph.  If we make the commit
> log make sense, maybe some summary of that would be useful here.
Following are more details related to second part of comment. Let me
know if it does not makes sense.

In case of EDR mode, pcie_do_recovery() will be triggered by
edr_handle_event(), and AER and DPC capabilities controls are also owned
by firmware. If DPC and AER capabilities are owned by firmware then AER
and DPC PCIe service drivers will not be enumerated and hence
report_frozen_detected() can return PCI_ERS_RESULT_NO_AER_DRIVER as
status. If the report_error_detected() returns
PCI_ERS_RESULT_NO_AER_DRIVER then as per current pcie_do_recovery()
implementation, recovery will be reported as failure.

So ignoring the status of report_error_detected() helps the case of 
recovery triggered by EDR driver.
> 
> I think this code is equivalent and makes the patch much clearer:
Ok. I will change to this logic in next version.
> 
>    status = reset_link(dev);
>    if (status == PCI_ERS_RESULT_RECOVERED) {
>      status = PCI_ERS_RESULT_NEED_RESET;
>    } else {
>      status = PCI_ERS_RESULT_DISCONNECT;
>      goto failed;
>    }

> 
>> +		 */
>> +		status = PCI_ERS_RESULT_NEED_RESET;
>> +		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
>> +			status = PCI_ERS_RESULT_DISCONNECT;
>>   			pci_warn(dev, "link reset failed\n");
>>   			goto failed;
>>   		}
>> -- 
>> 2.17.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
