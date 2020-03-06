Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1449517C878
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 23:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFWoi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 17:44:38 -0500
Received: from mga18.intel.com ([134.134.136.126]:39353 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgCFWoh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 17:44:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 14:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,523,1574150400"; 
   d="scan'208";a="230218213"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2020 14:44:35 -0800
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id EC5925802A3;
        Fri,  6 Mar 2020 14:44:34 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 11/12] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Olof Johansson <olof@lixom.net>
References: <20200306210058.GA210797@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <90e97009-29ae-f807-406d-59cefe7e6d3f@linux.intel.com>
Date:   Fri, 6 Mar 2020 14:42:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200306210058.GA210797@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/6/20 1:00 PM, Bjorn Helgaas wrote:
> On Thu, Mar 05, 2020 at 10:32:33PM -0800, Kuppuswamy, Sathyanarayanan wrote:
>> On 3/5/2020 7:47 PM, Bjorn Helgaas wrote:
>>> On Tue, Mar 03, 2020 at 06:36:34PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> +void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
>>>> +{
>>>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>>>> +	acpi_status astatus;
>>>> +
>>>> +	if (!adev) {
>>>> +		pci_dbg(pdev, "No valid ACPI node, so skip EDR init\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * Per the Downstream Port Containment Related Enhancements ECN to
>>>> +	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-6, EDR support
>>>> +	 * can only be enabled if DPC is controlled by firmware.
>>>> +	 *
>>>> +	 * TODO: Remove dependency on ACPI FIRMWARE_FIRST bit to
>>>> +	 * determine ownership of DPC between firmware or OS.
>>>> +	 * Per the Downstream Port Containment Related Enhancements
>>>> +	 * ECN to the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>>>> +	 * OS can use bit 7 of _OSC control field to negotiate control
>>>> +	 * over DPC Capability.
>>>> +	 */
>>>> +	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native) {
>>>> +		pci_dbg(pdev, "OS handles AER/DPC, so skip EDR init\n");
>>>> +		return;
>>>> +	}
>>>> +
>>>> +	astatus = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
>>>> +					      edr_handle_event, pdev);
>>>
>>> It does not say anything about "EDR notification only being used if
>>> firmware owns DPC."
>>>
>>> We should install an EDR notify handler because we told the firmware
>>> that we support EDR notifications.  I don't think we should make it
>>> any more complicated than that.
I agree with your above statement. Since we told firmware *we support*
EDR notification, we should make that true by installing the notification
handler unconditionally.

But, based on inferences from PCI FW 3.2 ECN-DPC spec, current use case 
of EDR
notification is only to handle error recovery for the case where DPC is 
owned by firmware
and firmware sends EDR event. if you agree with above comment, is it 
alright if we add
the following check in EDR notification handler ?

Although spec does not restrict it, current tested use case of EDR is to 
handle notification
for firmware DPC case.

218         if (!pcie_aer_get_firmware_first(pdev) || 
pcie_ports_dpc_native || (host->native_dpc))
219                 return;



>
>> Also check the following reference from section 2 of EDR ECN. It also
>> clarifies EDR feature is only used when firmware owns DPC.
>>
>>      PCIe Base Specification suggests that Downstream Port Containment
>>      may be controlled either by the Firmware or the Operating System. It
>>      also suggests that the Firmware retain ownership of Downstream Port
>>      Containment if it also owns AER. When the Firmware owns Downstream
>>      Port Containment, *it is expected to use the new “Error Disconnect
>>      Recover” notification to alert OSPM of a Downstream Port Containment
>>      event*.
> The text in section 2 will not become part of the spec, so we can't
> rely on it to tell us how to implement things.  Even if it did, this
> section does not say "OS should only install an EDR notify handler if
> firmware owns DPC."  It just means that if firmware owns DPC, the OS
> will not learn about DPC events directly via DPC interrupts, so
> firmware has to use another mechanism, e.g., EDR, to tell the OS about
> them.
>
> If an OS requests DPC control, it must support both DPC and EDR (sec
> 4.5.2.4).  However, I think an OS may support EDR but not DPC
> (although your patches don't support this configuration).
Any use cases for above configuration ? Current PCI FW 3.2 ECN-DPC
spec does not mention any uses cases where EDR can be used outside
the scope of DPC ?

If required I can add this support. It should be easy to add it. In non 
DPC case,
EDR notification handler would mostly be empty. Please let me know if you
want me add this part of next patch set.

> In that
> case the OS would set the _OSC "EDR Supported" bit, but it would not
> request DPC control.  Then the EDR notify handler would "invalidate
> the software state associated with child devices of the port" (table
> 4-4), but it would not "attempt to recover the child devices of ports
> implementing DPC."
>
>>> EDR is a general ACPI feature that is not PCI-specific.  For EDR
>>> on PCI devices, OS support is advertised via _OSC *Support* (table
>>> 4-4), which says:
>>>
>>>     Error Disconnect Recover Supported
>>>
>>>     The OS sets this bit to 1 if it supports Error Disconnect
>>>     Recover notification on PCI Express Host Bridges, Root Ports
>>>     and Switch Downstream Ports. Otherwise, the OS sets this bit to
>>>     0.
>>>
>>> I think that means that if we set the "Error Disconnect Recover
>>> Supported" _OSC bit (OSC_PCI_EDR_SUPPORT), we must install a
>>> handler for EDR notifications.  We set OSC_PCI_EDR_SUPPORT
>>> whenever CONFIG_PCIE_EDR=y, so I think we should install the
>>> notify handler here unconditionally (since this file is compiled
>>> only when CONFIG_PCIE_EDR=y).
>> Although spec does not provide any restrictions on when to install
>> EDR notification, it provides reference that notification is only
>> used if firmware owns DPC. So when OS owns DPC, there is no need to
>> install them at all.
> I disagree that the spec tells us that EDR is only used when firmware
> owns DPC.
Agreed.
>
> Even if it did, pcie_aer_get_firmware_first() only looks at HEST
> tables.  There *might* be some connection between those and DPC
> ownership, but that's internal to firmware and I think it's just
> asking for trouble if we rely on that connection.
>
>> Although installing them when OS owns DPC should not affect
>> anything, it also opens up a additional way for firmware to mess up
>> things. For example, consider a case when firmware gives OS control
>> of DPC, but still sends EDR notification to OS. Although it's
>> unrealistic, I am just giving an example.
> Can you outline the problem that occurs in this scenario?  It seems
> like the EDR notify handler could still work.  The OS can access DPC
> at any time (not just during the EDR window).
When OS owns DPC and firmware sends  a EDR event, it could
create race between DPC interrupt handler and EDR
event handler. Although from hardware perspective it should
not make difference, since both code paths does the same thing.
>
>>> I don't think we should even test pcie_ports_dpc_native here.  If we
>>> told the platform we can handle EDR notifications, we should be
>>> prepared to get them, regardless of whether the user booted with
>>> "pcie_ports=dpc-native".
>> As per the command line parameter documentation, setting
>> pcie_ports=dpc-native means, we will be using native PCIe service
>> for DPC.  So if DPC is handled by OS, as per my argument mentioned
>> above (EDR is only useful if DPC handled by firmware), there is no
>> use in installing EDR notification.
>>
>> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L3642
>>
>> dpc-native - Use native PCIe service for DPC only.
> It doesn't hurt anything to install a notify handler that never
> receives a notification.  It might be an issue if we tell firmware
> we're prepared for notifications but we don't install a handler.
Agreed. Shall I send another version with this and "static inline" fix ?
>
>>> It's conceivable that pcie_ports_dpc_native should make us do
>>> something different in the notify handler after we *get* a
>>> notification, but I doubt we should even worry about that.
>>>
>>> IIUC, pcie_ports_dpc_native exists because Linux DPC originally worked
>>> even if the OS didn't have control of AER.  eed85ff4c0da7 ("PCI/DPC:
>>> Enable DPC only if AER is available") meant that if Linux didn't have
>>> control of AER, DPC no longer worked.  "pcie_ports=dpc-native" is
>>> basically a way to get that previous behavior of Linux DPC regardless
>>> of AER control.
>>>
>>> I don't think that issue applies to EDR.  There's no concept of an OS
>>> "enabling" or "being granted control of" EDR.  The OS merely
>>> advertises that "yes, I'm prepared to handle EDR notifications".
>>> AFAICT, the ECR says nothing about EDR support being conditional on OS
>>> control of AER or DPC.  The notify *handler* might need to do
>>> different things depending on whether we have AER or DPC control, but
>>> the handler itself should be registered regardless.
>>>
>>> [1] https://lore.kernel.org/linux-pci/20181115231605.24352-1-mr.nuke.me@gmail.com/
>>> [2] https://lore.kernel.org/linux-pci/20190326172343.28946-1-mr.nuke.me@gmail.com/
>>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

