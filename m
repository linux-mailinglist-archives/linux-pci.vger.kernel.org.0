Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E218214600B
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 01:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAWApB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 19:45:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:3568 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAWApB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 19:45:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 16:45:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,351,1574150400"; 
   d="scan'208";a="221388033"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jan 2020 16:44:59 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 90BFE58033E;
        Wed, 22 Jan 2020 16:44:59 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v13 2/8] PCI/DPC: Allow dpc_probe() even if firmware first
 mode is enabled
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Keith Busch <keith.busch@intel.com>
References: <20200122231743.GA28442@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <88420093-59aa-b713-c2e3-2872b4c5474b@linux.intel.com>
Date:   Wed, 22 Jan 2020 16:42:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200122231743.GA28442@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 1/22/20 3:17 PM, Bjorn Helgaas wrote:
> On Sat, Jan 18, 2020 at 08:00:31PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per ACPI specification v6.3, sec 5.6.6, Error Disconnect Recover
>> (EDR) notification used by firmware to let OS know about the DPC event
>> and permit OS to perform error recovery when processing the EDR
>> notification.
> I want to clear up some of this description because this is a very
> confusing area and we should follow the spec carefully so we all
> understand each other.
>
>> Also, as per PCI firmware specification r3.2 Downstream
>> Port Containment Related Enhancements ECN, sec 4.5.1, table 4-6, if DPC
>> is controlled by firmware (firmware first mode), it's responsible for
>> initializing Downstream Port Containment Extended Capability Structures
>> per firmware policy.
> The above is actually not what the ECN says.  What it does say is
> this:
>
>    If control of this feature [DPC configuration] was requested and
>    denied, firmware is responsible for initializing Downstream Port
>    Containment Extended Capability Structures per firmware policy.
>
> Neither the PCI Firmware Spec (r3.2) nor the ECN contains any
> reference to "firmware first".  As far as I can tell, "Firmware First"
> is defined by the ACPI spec, and the FIRMWARE_FIRST bit in various
> HEST entries (sec 18.3.2) is what tells us when a device is in
> firmware-first mode.
>
> That's a really long way of saying that from a spec point of view, DPC
> being controlled by firmware does NOT imply anything about
> firmware-first mode.
But current AER and DPC driver uses ACPI FIRMWARE_FIRST bit
(in pcie_aer_get_firmware_first()) to decide whether AER/DPC is
controlled by firmware or OS. That's why I used the term
"firmware first mode" interchangeably with a mode in which
DPC/AER is controlled by firmware.
>
>> And, OS is permitted to read or write DPC Control
>> and Status registers of a port while processing an Error Disconnect
>> Recover (EDR) notification from firmware on that port.
>>
>> Currently, if firmware controls DPC (firmware first mode), OS will not
>> create/enumerate DPC PCIe port services. But, if OS supports EDR
>> feature, then as mentioned in above spec references, it should permit
>> enumeration of DPC driver and also support handling ACPI EDR
>> notification. So as first step, allow dpc_probe() to continue even if
>> firmware first mode is enabled. Also add appropriate checks to ensure
>> device registers are not modified outside EDR notification window in
>> firmware first mode. This is a preparatory patch for adding EDR support.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Acked-by: Keith Busch <keith.busch@intel.com>
>> ---
>>   drivers/pci/pcie/dpc.c | 74 ++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 61 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>> index e06f42f58d3d..c583a90fa90d 100644
>> --- a/drivers/pci/pcie/dpc.c
>> +++ b/drivers/pci/pcie/dpc.c
>> @@ -22,6 +22,7 @@ struct dpc_dev {
>>   	u16			cap_pos;
>>   	bool			rp_extensions;
>>   	u8			rp_log_size;
>> +	bool			edr_enabled; /* EDR mode is supported */
> This needs a better name, or perhaps it should be removed completely.
Any suggestions ? native_mode or firmware_dpc ?
> EDR is not a mode that can be enabled or disabled.  The _OSC "EDR
> supported" bit tells the firmware whether the OS supports EDR
> notification, but there's no corresponding bit that tells the OS
> whether firmware will actually *send* those notifications.
I agree that EDR is not a mode. But with EDR support, DPC driver functions
can be triggered/executed in two contexts.

1. DPC is controlled by OS.
2. Via EDR notification if DPC is controlled by firmware.

Since we want to use same code for both scenarios, we need some method
to detect which context is currently in use.
>
> Also, EDR is an ACPI concept, and dpc.c is a generic driver not
> specific to ACPI, so we should try to avoid polluting it with
> ACPI-isms.
>
>>   };
>>   
>>   static const char * const rp_pio_error_string[] = {
>> @@ -69,6 +70,14 @@ void pci_save_dpc_state(struct pci_dev *dev)
>>   	if (!dpc)
>>   		return;
>>   
>> +	/*
>> +	 * If DPC is controlled by firmware then save/restore tasks are also
>> +	 * controlled by firmware. So skip rest of the function if DPC is
>> +	 * controlled by firmware.
>> +	 */
>> +	if (dpc->edr_enabled)
>> +		return;
> I think this should be something like:
>
>    if (!host->native_dpc)
>      return;
>
> That's what the spec says: if firmware does not grant control of DPC
> to the OS via _OSC, the OS may not read/write the DPC capability.
>
> The usual situation would be that if firmware doesn't grant the OS
> permission to use DPC, we wouldn't use the dpc.c driver at all.
>
> But IIUC, the point of this EDR stuff is that we're adding a case
> where the OS doesn't have permission to use DPC, but we *do* want to
> use parts of dpc.c in limited cases while handling EDR notifications.
Yes, your assumption is correct.
>
> I think you should probably take the DPC-related _OSC stuff from the
> last patch ("PCI/ACPI: Enable EDR support") and move it before this
> patch, so it *only* negotiates DPC ownership, per the ECN.  That would
> probably result in dpc.c being used only if _OSC grants DPC ownership
> to the OS.
Patch titled ("PCI/ACPI: Enable EDR support") exposes EDR support to 
firmware in
_OSC negotiation. So you wanted me to move this patch to the end of the 
series
to make sure we don't expose EDR support until we have necessary code 
changes
in kernel.
>
> Then subsequent patches like this one would relax that slightly and
> allow dpc.c to be used even without DPC ownership, but it would only
> touch the DPC capability in limited cases.
>
>>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
>>   	if (!save_state)
>>   		return;
>> @@ -90,6 +99,14 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>>   	if (!dpc)
>>   		return;
>>   
>> +	/*
>> +	 * If DPC is controlled by firmware then save/restore tasks are also
>> +	 * controlled by firmware. So skip rest of the function if DPC is
>> +	 * controlled by firmware.
>> +	 */
>> +	if (dpc->edr_enabled)
>> +		return;
>> +
>>   	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_DPC);
>>   	if (!save_state)
>>   		return;
>> @@ -291,24 +308,48 @@ static int dpc_probe(struct pcie_device *dev)
>>   	int status;
>>   	u16 ctl, cap;
>>   
>> -	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
>> -		return -ENOTSUPP;
>> -
>>   	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
>>   	if (!dpc)
>>   		return -ENOMEM;
>>   
>>   	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
>>   	dpc->dev = dev;
>> +
>> +	/*
>> +	 * As per PCIe r5.0, sec 6.2.10, implementation note titled
>> +	 * "Determination of DPC Control", to avoid conflicts over whether
>> +	 * platform firmware or the operating system have control of DPC,
>> +	 * it is recommended that platform firmware and operating systems
>> +	 * always link the control of DPC to the control of Advanced Error
>> +	 * Reporting.
>> +	 *
>> +	 * So use AER FF mode check API pcie_aer_get_firmware_first() to decide
>> +	 * whether DPC is controlled by software or firmware.
> AFAICT, this is not what the spec says.  Firmware-first is not what
> tells us whether DPC is controlled by firmware or the OS.  For ACPI
> systems, _OSC tells us whether the OS is allowed control of DPC.
But current DPC/AER driver use FIRMWARE_FIRST bit (in 
pcie_aer_get_firmware_first())
determine firmware/OS ownership.
>
>> +	 * And EDR support
>> +	 * can only be enabled if DPC is controlled by firmware.
>> +	 */
>> +
>> +	if (pcie_aer_get_firmware_first(pdev) && !pcie_ports_dpc_native)
>> +		dpc->edr_enabled = 1;
>> +	/*
>> +	 * If DPC is handled in firmware and ACPI support is not enabled
>> +	 * in OS, skip probe and return error.
>> +	 */
>> +	if (dpc->edr_enabled && !IS_ENABLED(CONFIG_ACPI))
>> +		return -ENODEV;
>> +
>>   	set_service_data(dev, dpc);
>>   
>> -	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>> -					   dpc_handler, IRQF_SHARED,
>> -					   "pcie-dpc", dpc);
>> -	if (status) {
>> -		pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
>> -			 status);
>> -		return status;
>> +	/* Register interrupt handler only if OS controls DPC */
>> +	if (!dpc->edr_enabled) {
>> +		status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>> +						   dpc_handler, IRQF_SHARED,
>> +						   "pcie-dpc", dpc);
>> +		if (status) {
>> +			pci_warn(pdev, "request IRQ%d failed: %d\n", dev->irq,
>> +				 status);
>> +			return status;
>> +		}
>>   	}
>>   
>>   	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
>> @@ -323,9 +364,12 @@ static int dpc_probe(struct pcie_device *dev)
>>   			dpc->rp_log_size = 0;
>>   		}
>>   	}
>> -
>> -	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
>> -	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>> +	if (!dpc->edr_enabled) {
>> +		ctl = (ctl & 0xfff4) |
>> +			(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
>> +		pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL,
>> +				      ctl);
>> +	}
>>   
>>   	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
>>   		 cap & PCI_EXP_DPC_IRQ, FLAG(cap, PCI_EXP_DPC_CAP_RP_EXT),
>> @@ -343,6 +387,10 @@ static void dpc_remove(struct pcie_device *dev)
>>   	struct pci_dev *pdev = dev->port;
>>   	u16 ctl;
>>   
>> +	/* Skip updating DPC registers if DPC is controlled by firmware */
>> +	if (dpc->edr_enabled)
>> +		return;
>> +
>>   	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
>>   	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
>>   	pci_write_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, ctl);
>> -- 
>> 2.21.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

