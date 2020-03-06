Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23B2717B6BC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 07:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725847AbgCFGcf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 01:32:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:13269 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbgCFGcf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 01:32:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 22:32:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="241085666"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.252.200.198]) ([10.252.200.198])
  by orsmga003.jf.intel.com with ESMTP; 05 Mar 2020 22:32:33 -0800
Subject: Re: [PATCH v17 11/12] PCI/DPC: Add Error Disconnect Recover (EDR)
 support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, Olof Johansson <olof@lixom.net>
References: <20200306034718.GA117283@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <5384cf38-4b33-f95b-4bb9-b82f0dc63a1f@linux.intel.com>
Date:   Thu, 5 Mar 2020 22:32:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306034718.GA117283@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/5/2020 7:47 PM, Bjorn Helgaas wrote:
> [+cc Olof for pcie_ports=dpc-native question]
> 
> On Tue, Mar 03, 2020 at 06:36:34PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
>> +void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
>> +{
>> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
>> +	acpi_status astatus;
>> +
>> +	if (!adev) {
>> +		pci_dbg(pdev, "No valid ACPI node, so skip EDR init\n");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Per the Downstream Port Containment Related Enhancements ECN to
>> +	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-6, EDR support
>> +	 * can only be enabled if DPC is controlled by firmware.
>> +	 *
>> +	 * TODO: Remove dependency on ACPI FIRMWARE_FIRST bit to
>> +	 * determine ownership of DPC between firmware or OS.
>> +	 * Per the Downstream Port Containment Related Enhancements
>> +	 * ECN to the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
>> +	 * OS can use bit 7 of _OSC control field to negotiate control
>> +	 * over DPC Capability.
>> +	 */
>> +	if (!pcie_aer_get_firmware_first(pdev) || pcie_ports_dpc_native) {
>> +		pci_dbg(pdev, "OS handles AER/DPC, so skip EDR init\n");
>> +		return;
>> +	}
>> +
>> +	astatus = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
>> +					      edr_handle_event, pdev);
> 
> I think this is still problematic.  You mentioned Alex's work [1,2].
> We do need to revisit those patches, but I don't really want to defer
> *this* question of the EDR notify handler.  Negotiating support of
> AER/DPC/EDR is already complicated, and I don't want to complicate it
> even more by merging something we already know is not quite right.
> 
> I don't understand your comment that "EDR can only be enabled if DPC
> is controlled by firmware."  I don't see anything in table 4-6 to that
> effect.  The only mention of EDR there is to say that the OS can
> access the DPC capability in the EDR processing window, i.e., after
> the OS receives the EDR notification and before it clears DPC Trigger
> Status.

Please check the following spec reference (from table 4-6).

     If control of this feature was requested and denied, firmware is
     responsible for initializing Downstream Port Containment Extended
     Capability Structures per firmware policy. Further, the OS is
     permitted to read or write DPC Control and Status registers of a
     port while processing an Error Disconnect Recover notification from
     firmware on that port.

It specifies firmware is expected to use EDR notification *only* when 
the control of DPC is requested and denied ( which means firmware owns 
the DPC). Although it does not explicitly state that we should install 
EDR notification handler only if firmware owns DPC, it mentions that EDR 
notification is only used if firmware owns DPC. So why should we install 
it if its not going to be used when OS owns DPC.

Also check the following reference from section 2 of EDR ECN. It also 
clarifies EDR feature is only used when firmware owns DPC.

     PCIe Base Specification suggests that Downstream Port Containment
     may be controlled either by the Firmware or the Operating System. It
     also suggests that the Firmware retain ownership of Downstream Port
     Containment if it also owns AER. When the Firmware owns Downstream
     Port Containment, *it is expected to use the new “Error Disconnect
     Recover” notification to alert OSPM of a Downstream Port Containment
     event*.


> 
> EDR is a general ACPI feature that is not PCI-specific.  For EDR on
> PCI devices, OS support is advertised via _OSC *Support* (table 4-4),
> which says:
> 
>    Error Disconnect Recover Supported
> 
>    The OS sets this bit to 1 if it supports Error Disconnect Recover
>    notification on PCI Express Host Bridges, Root Ports and Switch
>    Downstream Ports. Otherwise, the OS sets this bit to 0.
> 
> I think that means that if we set the "Error Disconnect Recover
> Supported" _OSC bit (OSC_PCI_EDR_SUPPORT), we must install a handler
> for EDR notifications.  We set OSC_PCI_EDR_SUPPORT whenever
> CONFIG_PCIE_EDR=y, so I think we should install the notify handler
> here unconditionally (since this file is compiled only when
> CONFIG_PCIE_EDR=y).

Although spec does not provide any restrictions on when to install EDR 
notification, it provides reference that notification is only used if 
firmware owns DPC. So when OS owns DPC, there is no need to install them 
at all.

Although installing them when OS owns DPC should not affect anything, it 
also opens up a additional way for firmware to mess up things. For 
example, consider a case when firmware gives OS control of DPC, but 
still sends EDR notification to OS. Although its unrealistic, I am just 
giving an example.

> 
> I don't think we should even test pcie_ports_dpc_native here.  If we
> told the platform we can handle EDR notifications, we should be
> prepared to get them, regardless of whether the user booted with
> "pcie_ports=dpc-native".

As per the command line parameter documentation, setting 
pcie_ports=dpc-native means, we will be using native PCIe service for 
DPC. So if DPC is handled by OS, as per my argument mentioned above (EDR 
is only useful if
DPC handled by firmware), there is no use in installing EDR notification.

https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L3642

dpc-native - Use native PCIe service for DPC only.

> 
> It's conceivable that pcie_ports_dpc_native should make us do
> something different in the notify handler after we *get* a
> notification, but I doubt we should even worry about that.
> 
> IIUC, pcie_ports_dpc_native exists because Linux DPC originally worked
> even if the OS didn't have control of AER.  eed85ff4c0da7 ("PCI/DPC:
> Enable DPC only if AER is available") meant that if Linux didn't have
> control of AER, DPC no longer worked.  "pcie_ports=dpc-native" is
> basically a way to get that previous behavior of Linux DPC regardless
> of AER control.
> 
> I don't think that issue applies to EDR.  There's no concept of an OS
> "enabling" or "being granted control of" EDR.  The OS merely
> advertises that "yes, I'm prepared to handle EDR notifications".
> AFAICT, the ECR says nothing about EDR support being conditional on OS
> control of AER or DPC.  The notify *handler* might need to do
> different things depending on whether we have AER or DPC control, but
> the handler itself should be registered regardless.
> 
> [1] https://lore.kernel.org/linux-pci/20181115231605.24352-1-mr.nuke.me@gmail.com/
> [2] https://lore.kernel.org/linux-pci/20190326172343.28946-1-mr.nuke.me@gmail.com/
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
