Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8372E906E
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 21:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJ2UAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 16:00:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:32665 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbfJ2UAX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 16:00:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 13:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,245,1569308400"; 
   d="scan'208";a="202963403"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 29 Oct 2019 13:00:22 -0700
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id 0AA915804A2;
        Tue, 29 Oct 2019 13:00:22 -0700 (PDT)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v9 5/8] PCI/AER: Allow clearing Error Status Register in
 FF mode
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <20191028232251.GA205542@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <be6df02f-a14f-d80e-0fa2-ff34f19cbcb9@linux.intel.com>
Date:   Tue, 29 Oct 2019 12:58:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191028232251.GA205542@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 10/28/19 4:22 PM, Bjorn Helgaas wrote:
> On Thu, Oct 03, 2019 at 04:39:01PM -0700, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> As per PCI firmware specification r3.2 Downstream Port Containment
>> Related Enhancements ECN, sec 4.5.1, table 4-6,
> That table adds bit 7, "DPC config control" to the _OSC control field
> and talks about modifying registers in the DPC capability.
>
> It doesn't say anything about firmware-first or about the OS modifying
> registers in the AER capability.  But this patch doesn't do anything
> related to DPC or _OSC.

Expectation of clearing AER registers is not explicitly mentioned in 
above DPC ECN. But it
has been clarified in the following update to this ECN.

Please check the implementation note in page 10 of
https://members.pcisig.com/wg/PCI-SIG/document/previewpdf/13563.

It  specifies that in EDR mode, firmware expects OS to clear error 
registers (Check for
following string "Bring Portout of DPC, clear port error status, assign 
bus numbers to child
devices").

I will include this ECN reference in follow up update.

>
>> Error Disconnect
>> Recover (EDR) support allows OS to handle error recovery and
>> clearing Error Registers even in FF mode. So remove FF mode checks in
>> pci_cleanup_aer_uncorrect_error_status(), pci_aer_clear_fatal_status()
>> and pci_cleanup_aer_error_status_regs() functions.
>>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> Acked-by: Keith Busch <keith.busch@intel.com>
>> ---
>>   drivers/pci/pcie/aer.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>> index b45bc47d04fe..e1509bb900c5 100644
>> --- a/drivers/pci/pcie/aer.c
>> +++ b/drivers/pci/pcie/aer.c
>> @@ -383,9 +383,6 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>>   	if (!pos)
>>   		return -EIO;
>>   
>> -	if (pcie_aer_get_firmware_first(dev))
>> -		return -EIO;
>> -
>>   	/* Clear status bits for ERR_NONFATAL errors only */
>>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
>> @@ -406,9 +403,6 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>>   	if (!pos)
>>   		return;
>>   
>> -	if (pcie_aer_get_firmware_first(dev))
>> -		return;
>> -
>>   	/* Clear status bits for ERR_FATAL errors only */
>>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
>>   	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
>> @@ -430,9 +424,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>>   	if (!pos)
>>   		return -EIO;
>>   
>> -	if (pcie_aer_get_firmware_first(dev))
>> -		return -EIO;
>> -
>>   	port_type = pci_pcie_type(dev);
>>   	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
>>   		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
>> @@ -455,7 +446,8 @@ void pci_aer_init(struct pci_dev *dev)
>>   	if (dev->aer_cap)
>>   		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
>>   
>> -	pci_cleanup_aer_error_status_regs(dev);
>> +	if (!pcie_aer_get_firmware_first(dev))
>> +		pci_cleanup_aer_error_status_regs(dev);
> This effectively moves the "if (pcie_aer_get_firmware_first())" check
> from pci_cleanup_aer_error_status_regs() into one of the callers.  But
> there are two other callers: pci_aer_init() and pci_restore_state().
> Do they need the change, or do you want to cleanup the AER error
> registers there, but not here?
Good catch. I have added this check to pci_aer_init(). But it needs to 
be added to
pci_restore_state() as well. Instead of moving the checks to the caller, 
If you agree,
I could change the API to pci_cleanup_aer_error_status_regs(struct 
pci_dev *dev, bool skip_ff_check) and
let the caller decide whether they want skip the check or not.
>
>>   }
>>   
>>   void pci_aer_exit(struct pci_dev *dev)
>> -- 
>> 2.21.0
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

