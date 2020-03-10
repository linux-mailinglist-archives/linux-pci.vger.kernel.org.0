Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D37A917EFA8
	for <lists+linux-pci@lfdr.de>; Tue, 10 Mar 2020 05:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCJE2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Mar 2020 00:28:14 -0400
Received: from mga14.intel.com ([192.55.52.115]:51283 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgCJE2O (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Mar 2020 00:28:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 21:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,535,1574150400"; 
   d="scan'208";a="388790217"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.254.5.112]) ([10.254.5.112])
  by orsmga004.jf.intel.com with ESMTP; 09 Mar 2020 21:28:13 -0700
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Austin Bolen <austin_bolen@dell.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
References: <20200310024017.GA231196@google.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <de0cd5cc-9b59-882c-e40a-9bf00d20fbd4@linux.intel.com>
Date:   Mon, 9 Mar 2020 21:28:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310024017.GA231196@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On 3/9/2020 7:40 PM, Bjorn Helgaas wrote:
> [+cc Austin, tentative Linux patches on this git branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/tree/drivers/pci/pcie?h=review/edr]
> 
> On Tue, Mar 03, 2020 at 06:36:32PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per PCI firmware specification r3.2 System Firmware Intermediary
>> (SFI) _OSC and DPC Updates ECR
>> (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
>> Event Handling Implementation Note", page 10, Error Disconnect Recover
>> (EDR) support allows OS to handle error recovery and clearing Error
>> Registers even in FF mode. So create new API pci_aer_raw_clear_status()
>> which allows clearing AER registers without FF mode checks.
> 
> I see that this ECR was released as an ECN a few days ago:
> https://members.pcisig.com/wg/PCI-SIG/document/14076
> Regrettably the title in the PDF still says "ECR" (the rendered title
> *page* says "ENGINEERING CHANGE NOTIFICATION", but some metadata
> buried in the file says "ECR - SFI _OSC Support and DPC Updates".
> 
> Anyway, I think I see the note you refer to (now on page 12):
> 
>    IMPLEMENTATION NOTE
>    DPC Event Handling
> 
>    The flow chart below documents the behavior when firmware maintains
>    control of AER and DPC and grants control of PCIe Hot-Plug to the
>    operating system.
> 
>    ...
> 
>    Capture and clear device AER status. OS may choose to offline
>    devices3, either via SW (not load driver) or HW (power down device,
>    disable Link5,6,7). Otherwise process _HPX, complete device
>    enumeration, load drivers
> 
> This clearly suggests that the OS should clear device AER status.
> However, according to the intro text, firmware has retained control of
> AER, so what gives the OS the right to clear AER status?
> 
> The Downstream Port Containment Related Enhancements ECN (sec 4.5.1,
> table 4-6) contains an exception that allows the OS to read/write
> DPC registers during recovery.  But
> 
>    - that is for *DPC* registers, not for AER registers, and
> 
>    - that exception only applies between OS receipt of the EDR
>      notification and OS release of DPC by clearing the DPC Trigger
>      Status bit.
> 
> The flowchart in the SFI ECN shows the OS releasing DPC before
> clearing AER status:
> 
>    - Receive EDR notification
> 
>    - Cleanup - Notify and unload child drivers below Port
> 
>    - Bring Port out of DPC, clear port error status, assign bus numbers
>      to child devices.
> 
>      I assume this box includes clearing DPC error status and clearing
>      Trigger Status?  They seem to be out of order in the box.
> 
>    - Evaluate _OST
> 
>    - Capture and clear device AER status.
> 
>      This seems suspect to me.  Where does it say the OS is allowed to
>      write AER status when firmware retains control of AER?
> 
> This patch series does things in this order:
> 
>    - Receive EDR notification (edr_handle_event(), edr.c)
> 
>    - Read, log, and clear DPC error regs (dpc_process_error(), dpc.c).
> 
>      This also clears AER uncorrectable error status when the relevant
>      HEST entries do not have the FIRMWARE_FIRST bit set.  I think this
>      is incorrect: the test should be based the _OSC negotiation for
>      AER ownership, not on the HEST entries.  But this problem
>      pre-dates this patch series.
> 
>    - Clear AER status (pci_aer_raw_clear_status(), aer.c).
> 
>      This is at least inside the EDR recovery window, but again, I
>      don't see where it says the OS is allowed to write the AER status.

Implementation note is the only reference we have regarding clearing the
AER registers.

But since the spec says both DPC and AER needs to be always controlled
together by the either OS or firmware, and when firmware relinquishes
control over DPC registers in EDR notification window, we can assume
that we also have control over AER registers.

But I agree that is not explicitly spelled out any where outside the
implementation note.


Austin,

May be ECN (section 4.5.1, table 4-6) needs to be updated to add this
clarification.

> 
>    - Attempt recovery (pcie_do_recovery(), err.c)
> 
>    - Clear DPC Trigger Status (dpc_reset_link(), dpc.c)
> 
>    - Evaluate _OST (acpi_send_edr_status(), edr.c)
> 
> What am I missing?
> 
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/pci/pci.h      |  2 ++
>>   drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----
>>   2 files changed, 20 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>> index e57e78b619f8..c239e6dd2542 100644
>> --- a/drivers/pci/pci.h
>> +++ b/drivers/pci/pci.h
>> @@ -655,6 +655,7 @@ extern const struct attribute_group aer_stats_attr_group;
>>   void pci_aer_clear_fatal_status(struct pci_dev *dev);
>>   void pci_aer_clear_device_status(struct pci_dev *dev);
>>   int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
>> +int pci_aer_raw_clear_status(struct pci_dev *dev);
>>   #else
>>   static inline void pci_no_aer(void) { }
>>   static inline void pci_aer_init(struct pci_dev *d) { }
>> @@ -665,6 +666,7 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>   {
>>   	return -EINVAL;
>>   }
>> +int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>>   #endif
>>   
>>   #ifdef CONFIG_ACPI
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index c0540c3761dc..41afefa562b7 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -420,7 +420,16 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>   		pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
>>   }
>>   
>> -int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>> +/**
>> + * pci_aer_raw_clear_status - Clear AER error registers.
>> + * @dev: the PCI device
>> + *
>> + * NOTE: Allows clearing error registers in both FF and
>> + * non FF modes.
>> + *
>> + * Returns 0 on success, or negative on failure.
>> + */
>> +int pci_aer_raw_clear_status(struct pci_dev *dev)
>>   {
>>   	int pos;
>>   	u32 status;
>> @@ -433,9 +442,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>   	if (!pos)
>>   		return -EIO;
>>   
>> -	if (pcie_aer_get_firmware_first(dev))
>> -		return -EIO;
>> -
>>   	port_type = pci_pcie_type(dev);
>>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>>   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
>> @@ -451,6 +457,14 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>   	return 0;
>>   }
>>   
>> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>> +{
>> +	if (pcie_aer_get_firmware_first(dev))
>> +		return -EIO;
>> +
>> +	return pci_aer_raw_clear_status(dev);
>> +}
>> +
>>   void pci_save_aer_state(struct pci_dev *dev)
>>   {
>>   	struct pci_cap_saved_state *save_state;
>> -- 
>> 2.25.1
>>

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
