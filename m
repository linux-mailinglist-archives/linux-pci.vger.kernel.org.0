Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95A31D3F01
	for <lists+linux-pci@lfdr.de>; Thu, 14 May 2020 22:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgENUgS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 May 2020 16:36:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:51661 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgENUgS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 May 2020 16:36:18 -0400
IronPort-SDR: Kr8moFJSQEHA3eT73cJVvDMQdPKfEOulGCaZX4vRYFninq45S8ekYOVD1j6Mt76olLOdz66f1i
 KYGgblmuVZ6A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 13:36:10 -0700
IronPort-SDR: HV+kHQ5Ogs960O8wFt2vPmpkBM5xDpfibolAbWTRvN3DWjKvI7fgnx1b4Qo59Fp4QlfNpthB3a
 2AK2fAtTDLFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,392,1583222400"; 
   d="scan'208";a="307212706"
Received: from aruizmcc-mobl2.amr.corp.intel.com (HELO [10.254.64.168]) ([10.254.64.168])
  by FMSMGA003.fm.intel.com with ESMTP; 14 May 2020 13:36:09 -0700
Subject: Re: [PATCH v1 1/1] PCI/ERR: Handle fatal error recovery for
 non-hotplug capable devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, jay.vosburgh@canonical.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200513224449.GA347443@bjorn-Precision-5520>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <7217c72f-d13c-9128-4824-ed73aebc8abc@linux.intel.com>
Date:   Thu, 14 May 2020 13:36:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513224449.GA347443@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 5/13/20 3:44 PM, Bjorn Helgaas wrote:
> On Wed, May 06, 2020 at 08:32:59PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
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
> 
> Apparently this fixes a bug.  Can you include a link to a problem
> report?  The above is a description of a *solution*, but it's hard to
> understand without starting with the problem itself.

Let me add the problem description to the commit log in next version.

Adding it here for discussion.

Current pcie_do_recovery() implementation has following three issues:

1. Fatal (DPC) error recovery is currently broken for non-hotplug
capable devices. Current DPC recovery implementation relies on hotplug
handler for detaching/re-enumerating the affected devices/drivers on
DLLSC state changes. So when dealing with non-hotplug capable devices,
recovery code does not restore the state of the affected devices
correctly. Correct implementation should call report_mmio_enabled() and
report_slot_reset() functions after reseting the link/device which is
currently missing.

2. For non-fatal errors if report_error_detected() or
report_mmio_enabled() functions requests PCI_ERS_RESULT_NEED_RESET then
current pcie_do_recovery() implementation does not do the requested
explicit device reset, instead just calls the report_slot_reset() on all
affected devices. Notifying about the reset via report_slot_reset()
without doing the actual device reset is incorrect.

3. For fatal errors, pcie_do_recovery() function currently completely
ignores the status result of report_error_detected() call. After calling
reset_link() function then status value gets updated to either
PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_RECOVERED, and the initial
value returned from report_error_detected() is totally ignored. For
solving the issue # 1, we need to update the status only if reset_link()
call failed and returns PCI_ERS_RESULT_DISCONNECT. Otherwise recovery
handler should proceed to call report_mmio_enabled() and
report_slot_reset().


> 
> The above talks about reset_link(), which is only used in the
> io_frozen case.  In that case, I think the only thing this patch
> changes is that when reset_link() fails, we'll return with
> PCI_ERS_RESULT_DISCONNECT instead of whatever reset_link()
> returned.
Yes, if reset_link() is successful then we let pcie_do_recovery()
proceed to call report_slot_reset() with initial status value returned
from report_error_detected() function call.
> 
> What this patch *does* change is that in the normal_detected case, we
> previously never called reset_link() but now we will if an
> .error_detected() callback requested it.
yes, as highlighted in issue # 1 this patch adds support to call
reset_link() if report_error_detected() function requests it.
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
> 
> Sorry, I'm not following this explanation.  IIUC this fixes a bug when
> the channel is frozen and .error_detected() returns NEED_RESET.
> 
> In that case, the current code does:
> 
>    * state == io_frozen
>    * .error_detected() returns status == NEED_RESET
>    * status = reset_link()
>    * if status != RECOVERED, we return status
>    * otherwise status == RECOVERED
>    * we do not call report_slot_reset()
>    * we return RECOVERED
> 
> It does seem like we *should* call the .slot_reset() callbacks, but
> the only time we return recovery failure is if reset_link() failed.
> 
> I can certainly understand if drivers don't recover when we reset
> their device but don't call their .slot_reset() callback.  Is that
> what this fixes?
> 
> After the patch,
> 
>    * state == io_frozen
>    * .error_detected() returns status == NEED_RESET
>    * we set status = NEED_RESET (doesn't change anything in this case)
>    * we call reset_link()
>    * if reset_link() failed, we return DISCONNECT
>    * otherwise continue with status == NEED_RESET
>    * we *do* call report_slot_reset()
>    * we return whatever .slot_reset() returned
> 
> I think the change to call .slot_reset() makes sense, but that's not
> at all clear from the commit log.  Am I understanding the behavior
> correctly?
Yes, your understanding is correct. I hope above mentioned error
description clarifies it.
> 
>> Such an event can be induced for testing purposes by reducing the
>> Max_Payload_Size of a PCIe bridge to less than that of a device
>> downstream from the bridge, and then initiating I/O through the
>> device, resulting in oversize transactions.  In the presence of DPC,
>> this results in a containment event and attempted reset and recovery
>> via pcie_do_recovery.  After 6d2c89441571 report_slot_reset is not
>> invoked, and the device does not recover.
> 
> Use "pcie_do_recovery()" and "report_slot_reset()" (including the
> parentheses) to follow convention.  Also fix other occurrences above.
will fix it in next version.
> 
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
>> +				status = PCI_ERS_RESULT_DISCONNECT;
>> +		} else {
>> +			if (pci_bus_error_reset(dev))
>> +				status = PCI_ERS_RESULT_DISCONNECT;
> 
> As far as I can tell, there is no caller of pcie_do_recovery() where
> reset_link is NULL, so this call of pci_bus_error_reset() looks like
> dead code.
Yes, I will remove the if (reset_link) check.
> 
> We did not previously check whether reset_link was NULL, and this
> patch changes nothing that could result in it being NULL.
> 
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
>> -- 
>> 2.17.1
>>
