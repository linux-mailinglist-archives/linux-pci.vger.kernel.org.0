Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 296F313505A
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 01:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgAIAQO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jan 2020 19:16:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:43048 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbgAIAQO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Jan 2020 19:16:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 16:16:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="217653155"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2020 16:16:12 -0800
Received: from [10.54.74.33] (skuppusw-desk.jf.intel.com [10.54.74.33])
        by linux.intel.com (Postfix) with ESMTP id BC1C25803E3;
        Wed,  8 Jan 2020 16:16:12 -0800 (PST)
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v11 1/8] PCI/ERR: Update error status after reset_link()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com
References: <20200104025414.GA85401@google.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Organization: Intel
Message-ID: <7f7fdfec-5060-bcaa-38c4-6b973149e5cc@linux.intel.com>
Date:   Wed, 8 Jan 2020 16:14:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200104025414.GA85401@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

Thanks for the comments.

On 1/3/20 6:54 PM, Bjorn Helgaas wrote:
> On Fri, Jan 03, 2020 at 05:03:03PM -0800, Kuppuswamy Sathyanarayanan wrote:
>> On 1/3/20 4:34 PM, Bjorn Helgaas wrote:
>>> On Thu, Dec 26, 2019 at 04:39:07PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
>>>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>>
>>>> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery") uses
>>>> reset_link() to recover from fatal errors. But, if the reset is
>>>> successful there is no need to continue the rest of the error recovery
>>>> checks. Also, during fatal error recovery, if the initial value of error
>>>> status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER then
>>>> even after successful recovery (using reset_link()) pcie_do_recovery()
>>>> will report the recovery result as failure. So update the status of
>>>> error after reset_link().
>>> I like the part about updating "status" with the result of
>>> reset_link(), and I split that into its own patch because it
>>> seems like a fix that *can* be separated.
>>>
>>> But I'm not convinced that we should skip the ->slot_reset()
>>> callbacks if the reset_link() was successful.
>> If reset_link() call is successful then the result value will be
>> "PCI_ERS_RESULT_RECOVERED". So even if you proceed with
>> rest of the code, slot_reset() will never get called right ?
> The current code:
>
>          if (state == pci_channel_io_frozen &&
>              reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
>                  goto failed;
>          ...
>          if (status == PCI_ERS_RESULT_NEED_RESET) {
>                  status = PCI_ERS_RESULT_RECOVERED;
>                  pci_walk_bus(bus, report_slot_reset, &status);
>
> doesn't save the result of reset_link(), so if status was
> PCI_ERS_RESULT_NEED_RESET and the reset succeeds, we will call
> ->slot_reset().
>
> After your patch, if "state == pci_channel_io_frozen", we *never* call
> ->slot_reset().
>
> Do you think that matches pci-error-recovery.rst?  It doesn't seem
> like it to me, but perhaps I haven't read it closely enough.
Documentation does not have clear details on what to do with return
value of reset_link() ( step 3). But IMO, if step 3 recovers the device and
returns PCI_ERS_RESULT_RECOVERED then there is no need to proceed
to slot reset (step 4). May be we should update the Documentation ?

Keith,
You have any comments ?
>
>>> According to
>>> Documentation/PCI/pci-error-recovery.rst, we should call
>>> ->slot_reset() after completion of the reset.
>>>
>>> For example, rsxx_err_handler implements ->slot_reset(), but
>>> not ->resume().  If we reset the device, we'll claim success and
>>> return, but we won't call rsxx_slot_reset(), which does a bunch
>>> of important-looking recovery stuff.
>>>
>>> If pci-error-recovery.rst is wrong, we should fix that (after
>>> auditing all the drivers to make sure they match).
>>>
>>>> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
>>>> Cc: Ashok Raj <ashok.raj@intel.com>
>>>> Cc: Keith Busch <keith.busch@intel.com>
>>>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>> Acked-by: Keith Busch <keith.busch@intel.com>
>>>> ---
>>>>    drivers/pci/pcie/err.c | 10 +++++++---
>>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>> index b0e6048a9208..53cd9200ec2c 100644
>>>> --- a/drivers/pci/pcie/err.c
>>>> +++ b/drivers/pci/pcie/err.c
>>>> @@ -204,9 +204,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>>>>    	else
>>>>    		pci_walk_bus(bus, report_normal_detected, &status);
>>>> -	if (state == pci_channel_io_frozen &&
>>>> -	    reset_link(dev, service) != PCI_ERS_RESULT_RECOVERED)
>>>> -		goto failed;
>>>> +	if (state == pci_channel_io_frozen) {
>>>> +		status = reset_link(dev, service);
>>>> +		if (status != PCI_ERS_RESULT_RECOVERED)
>>>> +			goto failed;
>>>> +		goto done;
>>>> +	}
>>>>    	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>>>    		status = PCI_ERS_RESULT_RECOVERED;
>>>> @@ -228,6 +231,7 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
>>>>    	if (status != PCI_ERS_RESULT_RECOVERED)
>>>>    		goto failed;
>>>> +done:
>>>>    	pci_dbg(dev, "broadcast resume message\n");
>>>>    	pci_walk_bus(bus, report_resume, &status);
>>>> -- 
>>>> 2.21.0
>>>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux kernel developer
>>
-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

