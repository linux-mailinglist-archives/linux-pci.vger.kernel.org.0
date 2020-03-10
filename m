Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC3E5180964
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 21:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJUns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 16:43:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:36264 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJUns (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Mar 2020 16:43:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 13:43:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="236174271"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 10 Mar 2020 13:43:46 -0700
Received: from [10.7.201.16] (skuppusw-desk.jf.intel.com [10.7.201.16])
        by linux.intel.com (Postfix) with ESMTP id 7F4AE58010D;
        Tue, 10 Mar 2020 13:43:46 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Austin.Bolen@dell.com, helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200310193257.GA170043@google.com>
 <38277b0f6c2e4c5d88e741b7354c72d1@AUSX13MPC107.AMER.DELL.COM>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <8289f9b3-b9eb-6a80-1271-3db9aeef5161@linux.intel.com>
Date:   Tue, 10 Mar 2020 13:41:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <38277b0f6c2e4c5d88e741b7354c72d1@AUSX13MPC107.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 3/10/20 1:06 PM, Austin.Bolen@dell.com wrote:
> On 3/10/2020 2:33 PM, Bjorn Helgaas wrote:
>> [EXTERNAL EMAIL]
>>
>> On Tue, Mar 10, 2020 at 06:14:20PM +0000, Austin.Bolen@dell.com wrote:
>>> On 3/9/2020 11:28 PM, Kuppuswamy, Sathyanarayanan wrote:
>>>> On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:
>>>>> [+cc Austin, tentative Linux patches on this git branch:
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/pcie?h=review/edr]
>>>>>
>>>>> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>>>
>>>>>> As per PCI firmware specification r3.2 System Firmware Intermediary
>>>>>> (SFI) _OSC and DPC Updates ECR
>>>>>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
>>>>>> Event Handling Implementation Note", page 10, Error Disconnect Recover
>>>>>> (EDR) support allows OS to handle error recovery and clearing Error
>>>>>> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
>>>>>> which allows clearing AER registers without FF mode checks.
>>>>> I see that this ECR was released as an ECN a few days ago:
>>>>> https://members.pcisig.com/wg/PCI-SIG/document/14076
>>>>> Regrettably the title in the PDF still says "ECR" (the rendered title
>>>>> *page* says "ENGINEERING CHANGE NOTIFICATION", but some metadata
>>>>> buried in the file says "ECR - SFI _OSC Support and DPC Updates".
>>> I'll see if PCI-SIG can update the metadata and repost.
>> If that's possible, it would be nice to update the metadata for the
>> "Downstream Port Containment related Enhancements" ECN as well.  That
>> one currently says "ECR - CardBus Header Proposal", which means that's
>> what's in the window title bar and icons in the panel.
> Sure, I'll check.
>
>>>>> Anyway, I think I see the note you refer to (now on page 12):
>>>>>
>>>>>       IMPLEMENTATION NOTE
>>>>>       DPC Event Handling
>>>>>
>>>>>       The flow chart below documents the behavior when firmware maintains
>>>>>       control of AER and DPC and grants control of PCIe Hot-Plug to the
>>>>>       operating system.
>>>>>
>>>>>       ...
>>>>>
>>>>>       Capture and clear device AER status. OS may choose to offline
>>>>>       devices3, either via SW (not load driver) or HW (power down device,
>>>>>       disable Link5,6,7). Otherwise process _HPX, complete device
>>>>>       enumeration, load drivers
>>>>>
>>>>> This clearly suggests that the OS should clear device AER status.
>>>>> However, according to the intro text, firmware has retained control of
>>>>> AER, so what gives the OS the right to clear AER status?
>>>>>
>>>>> The Downstream Port Containment Related Enhancements ECN (sec 4.5.1,
>>>>> table 4-6) contains an exception that allows the OS to read/write
>>>>> DPC registers during recovery.  But
>>>>>
>>>>>       - that is for *DPC* registers, not for AER registers, and
>>>>>
>>>>>       - that exception only applies between OS receipt of the EDR
>>>>>         notification and OS release of DPC by clearing the DPC Trigger
>>>>>         Status bit.
>>>>>
>>>>> The flowchart in the SFI ECN shows the OS releasing DPC before
>>>>> clearing AER status:
>>>>>
>>>>>       - Receive EDR notification
>>>>>
>>>>>       - Cleanup - Notify and unload child drivers below Port
>>>>>
>>>>>       - Bring Port out of DPC, clear port error status, assign bus numbers
>>>>>         to child devices.
>>>>>
>>>>>         I assume this box includes clearing DPC error status and clearing
>>>>>         Trigger Status?  They seem to be out of order in the box.
>>> OS clears the DPC Trigger Status bit which will bring port below it out
>>> of containment. Then OS will clear the "port" error status bits (i.e.,
>>> the AER and DPC status bits in the root port or downstream port that
>>> triggered containment). I don't think it would hurt to do this two steps
>>> in reverse order but don't think it is necessary. Note that error status
>>> bits for devices below the port in containment are cleared later after
>>> f/w has a chance to log them.
>> Maybe I'm misreading the DPC enhancements ECN.  I think it says the OS
>> can read/write DPC registers until it clears the DPC Trigger Status.
>> If the OS clears Trigger Status first, my understanding is that we're
>> now out of the EDR notification processing window and the OS is not
>> permitted to write DPC registers.
>>
>> If it's OK for the OS to clear Trigger Status before clearing DPC
>> error status, what is the event that determines when the OS may no
>> longer read/write the DPC registers?
> I think there are a few different registers to consider... DPC Control,
> DPC Status, various AER registers, and the RP PIO registers. At this
> point in the flow, the firmware has already had a chance to read all of
> them and so it really doesn't matter the order the OS does those two
> things. The firmware isn't going to get notified again until _OST so by
> then both operation will be done and system firmware will have no idea
> which order the OS did them in, nor will it care.  But since the
> existing normative text specifies and order, I would just follow that.
I think the correct order is to clear the port error status *before clearing
the DPC status trigger*.

Please check the following spec reference (change to 4.5.1 Table 4-6)

the OS is permitted to read or write DPC Control and Status registers of a
port while processing an Error Disconnect Recover notification from firmware
on that port. Error Disconnect Recover notification processing begins 
with the
Error Disconnect Recover notify from Firmware, and *ends when the OS 
releases
DPC by clearing the DPC Trigger Status bit*.Firmware can read DPC Trigger
Status bit to determine the ownership of DPC Control and Status 
registers. Firmware
is not permitted to write to DPC Control and Status registers if DPC 
Trigger Status is
set i.e. the link is in DPC state. *Outside of the Error Disconnect 
Recover notification
processing window, the OS is not permitted to modify DPC Control or 
Status registers*;
only firmware is allowed to.

Since the EDR processing window ends with clearing DPC Trigger status 
bit, OS needs to
clear DPC and AER registers before it ends.

Austin,

I think the order needs to be reversed in the implementation note.
>
>>>>>       - Evaluate _OST
>>>>>
>>>>>       - Capture and clear device AER status.
>>>>>
>>>>>         This seems suspect to me.  Where does it say the OS is
>>>>>         allowed to write AER status when firmware retains control
>>>>>         of AER?
>>>>>
>>>>> This patch series does things in this order:
>>>>>
>>>>>       - Receive EDR notification (edr_handle_event(), edr.c)
>>>>>
>>>>>       - Read, log, and clear DPC error regs (dpc_process_error(),
>>>>>         dpc.c).
>>>>>
>>>>>         This also clears AER uncorrectable error status when the
>>>>>         relevant HEST entries do not have the FIRMWARE_FIRST bit
>>>>>         set.  I think this is incorrect: the test should be based
>>>>>         the _OSC negotiation for AER ownership, not on the HEST
>>>>>         entries.  But this problem pre-dates this patch series.
>>>>>
>>>>>       - Clear AER status (pci_aer_raw_clear_status(), aer.c).
>>>>>
>>>>>         This is at least inside the EDR recovery window, but again,
>>>>>         I don't see where it says the OS is allowed to write the
>>>>>         AER status.
>>>> Implementation note is the only reference we have regarding
>>>> clearing the AER registers.
>>>>
>>>> But since the spec says both DPC and AER needs to be always
>>>> controlled together by the either OS or firmware, and when
>>>> firmware relinquishes control over DPC registers in EDR
>>>> notification window, we can assume that we also have control over
>>>> AER registers.
>>>>
>>>> But I agree that is not explicitly spelled out any where outside
>>>> the implementation note.
>> This is all quite unsatisfying since implementation notes are not
>> normative.  I would far rather reference actual spec text.
> Yes, the change I mention below would be to add normative text.
>
>>>> Austin,
>>>>
>>>> May be ECN (section 4.5.1, table 4-6) needs to be updated to add
>>>> this clarification.
>>> Sure we can update to section 4.5.1, table 4-6 to indicate when OS
>>> can clear the AER status bits. It will just follow what's done in
>>> the implementation note so I think it's acceptable to follow
>>> implementation guidance for now.
>> There are no events after the "clear device AER status" box.  That
>> seems to mean the OS can write the AER status registers at any time.
>> But the whole implementation note assumes firmware maintains control
>> of AER.
>>
> In this model the OS doesn't own DPC or AER but the model allows OS to
> touch both DPC and AER registers at certain times.  I would view
> ownership in this case as who is the primary owner and not who is the
> sole entity allowed to access the registers.
>
> For the normative text describing when OS clears the AER bits following
> the informative flow chart, it could say that OS clears AER as soon as
> possible after OST returns and before OS processes _HPX and loading
> drivers.  Open to other suggestions as well.
I think its better to have another handshake between OS and
firmware to avoid unnecessary races.
>
>>>>>       - Attempt recovery (pcie_do_recovery(), err.c)
>>>>>
>>>>>       - Clear DPC Trigger Status (dpc_reset_link(), dpc.c)
>>>>>
>>>>>       - Evaluate _OST (acpi_send_edr_status(), edr.c)
>>>>>
>>>>> What am I missing?

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

