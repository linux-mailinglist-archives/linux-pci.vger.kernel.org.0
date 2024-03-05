Return-Path: <linux-pci+bounces-4490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C16871486
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 05:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6061B23FB0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 04:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBAC38F99;
	Tue,  5 Mar 2024 04:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W7GsBcXi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B502940D;
	Tue,  5 Mar 2024 04:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709611445; cv=none; b=INvTLrOWfRJiqmQzzzPLIYib6P+pmRg3bPJPDIfQTF+DKTLduMfqHR5kAjWkBdS+ZNeupnoB6+HSxUz9pDG6WWK4vPkebQwRfwiWdpPp0uJRXhC0jG2x3rq4urwoR9oZkwjAYNwd+/RpsNQfwwoj90GEjkzA8rQp//RQ+g65928=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709611445; c=relaxed/simple;
	bh=sbGj1YUIUtoIFViKUpTWKSPRd2E9akvO6FVkPwD4gOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObOn871ZQzeLjB4Si3mBkhuFQW+uxhJrJ0OVkRcyaGiCtJX/acSxwQU3Qk6bpvChexty42b/x8ZqlihoY8LTtKm/o8HaT0GHFICGo53MoGVz1YHv/QIHdxR+N2Hw4KLgIfvbcHoek6VSqU9cNulqaw73tBpdheRi7/7ovInTq6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W7GsBcXi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709611444; x=1741147444;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sbGj1YUIUtoIFViKUpTWKSPRd2E9akvO6FVkPwD4gOA=;
  b=W7GsBcXi0ptoe0NKrB7PSMHGn7BIZNTwOaC2DDzHd728v5W+CmgCvDNn
   +lTlJFLX+yZdESQoLB32YvVI70QQtvnRxWlJ/sv7ntYj8IjLnlqfY4Z47
   1PJiwoGHcJzbvaf6+HfXheQbx8hWgkxI832RH2zc3zVu/8ZR5TIMYODjN
   p2f1/aVaKIlNQgEfirf8Fs9QioHPb7JdVyhIiB737pFVdGN/Soo3shehT
   2fwzF46oEgsyW1JV9XtnrkjbG/k1EytBuo4hrBgiKVqczq3QZneDJkv6X
   PzJkqqnkawMjZYJr1qadktHVaJSwAQPrxwMkmweSPuRtAs8EtqbewyF1A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7960330"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7960330"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 20:04:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13899186"
Received: from cbrown-mobl1.amr.corp.intel.com (HELO [10.209.66.113]) ([10.209.66.113])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 20:04:02 -0800
Message-ID: <589fd9ae-5695-45c5-8772-cb3c736b3d4d@linux.intel.com>
Date: Mon, 4 Mar 2024 20:04:02 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
Content-Language: en-US
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, bhelgaas@google.com,
 lukas@wunner.de
Cc: Smita.KoralahalliChannabasappa@amd.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
 <71acbf58-a05d-4842-bc6b-c4e66e1a2b58@linux.intel.com>
 <f3eea050-53f9-4e4f-9694-06560a406db8@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <f3eea050-53f9-4e4f-9694-06560a406db8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 3/4/24 6:29 PM, Ethan Zhao wrote:
> On 3/5/2024 4:10 AM, Kuppuswamy Sathyanarayanan wrote:
>> On 3/4/24 1:08 AM, Ethan Zhao wrote:
>>> Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
>>> handling path, FW should clear UC errors logged by port and bring link
>>> out of DPC, but because of ambiguity of wording in the spec, some BIOSes
>>> doesn't clear the surprise down error and the error bits in pci status,
>> As Lukas mentioned, please include the hardware and BIOS version
>> where you see this issue.
>
> Reproduced on "Hardware name: Intel Corporation ArcherCity/ArcherCity,
>  BIOS EGSDCRB1.86B.0107.D20.2310211929 10/21/2023"
>
>>
>>> still notify OS to handle it. thus following trick is needed in EDR when
>>> double reporting (hot removal interrupt && dpc notification) is hit.
>> EDR notification is generally used when a firmware wants OS to invalidate
>> or recover the error state of child devices when handling a containment event.
>> Since this DPC event is a side effect of async removal, there is no recovery
>> involved. So there is no value in firmware notifying the OS via an ACPI notification
>> and then OS ignoring it.
>>
>> If you check the PCIe firmware spec, sec 4.6.12, IMPLEMENTATION NOTE, it
>> recommends firmware to ignore the DPC due to hotplug surprise.
>
> My understanding is the same, let firmware to ignore the errors and bring
> it out of DPC.
>
> But due to the wording like:
> "FW should not issue Notify(0xF) to avoid doule reporting. FW should clear
> *other* UC errors logged by port(if any) and bring link out of DPC if it has
> entered DPC."
>

"Since surprise hot remove event is signaled to OS via hot plug interrupt, FW should
not issue Notify(0xF) to avoid double reporting. FW should clear other UC errors logged
by port (if any) and bring link out of DPC if it has entered DPC."


Above statement is a note about how to treat DPC triggered due to async
removal. Since OS already gets notification via DLLSC change (hotplug interrupt),
there is no need for reporting again using EDR notification. I think the flow
chart is very clear about handling the hotplug related error case. Also the
note "Clear other UC errors" means it also includes "Surprise Down" error.

> Some BIOS writers have different understanding, wouldn't clear the surprise
> down error.
>
> Thanks,
> Ethan
>
>>
>>> https://patchwork.kernel.org/project/linux-pci/patch/20240207181854.
>>> 121335-1-Smita.KoralahalliChannabasappa@amd.com/
>>>
>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>> ---
>>>   drivers/pci/pci.h      | 1 +
>>>   drivers/pci/pcie/dpc.c | 9 +++++----
>>>   drivers/pci/pcie/edr.c | 3 +++
>>>   3 files changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>> index 50134b5e3235..3787bb32e724 100644
>>> --- a/drivers/pci/pci.h
>>> +++ b/drivers/pci/pci.h
>>> @@ -443,6 +443,7 @@ void pci_save_dpc_state(struct pci_dev *dev);
>>>   void pci_restore_dpc_state(struct pci_dev *dev);
>>>   void pci_dpc_init(struct pci_dev *pdev);
>>>   void dpc_process_error(struct pci_dev *pdev);
>>> +bool dpc_handle_surprise_removal(struct pci_dev *pdev);
>>>   pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>>>   bool pci_dpc_recovered(struct pci_dev *pdev);
>>>   #else
>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>> index 98b42e425bb9..be79f205e04c 100644
>>> --- a/drivers/pci/pcie/dpc.c
>>> +++ b/drivers/pci/pcie/dpc.c
>>> @@ -319,8 +319,10 @@ static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>>>       pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
>>>   }
>>>   -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>>> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>   {
>>> +    if (!dpc_is_surprise_removal(pdev))
>>> +        return false;
>>>       if (!pcie_wait_for_link(pdev, false)) {
>>>           pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
>>>           goto out;
>>> @@ -338,6 +340,7 @@ static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>   out:
>>>       clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>>>       wake_up_all(&dpc_completed_waitqueue);
>>> +    return true;
>>>   }
>>>     static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>>> @@ -362,10 +365,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
>>>        * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
>>>        * of async removal and should be ignored by software.
>>>        */
>>> -    if (dpc_is_surprise_removal(pdev)) {
>>> -        dpc_handle_surprise_removal(pdev);
>>> +    if (dpc_handle_surprise_removal(pdev))
>>>           return IRQ_HANDLED;
>>> -    }
>>>         dpc_process_error(pdev);
>>>   diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>>> index 5f4914d313a1..556edfb2696a 100644
>>> --- a/drivers/pci/pcie/edr.c
>>> +++ b/drivers/pci/pcie/edr.c
>>> @@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>>           goto send_ost;
>>>       }
>>>   +    if (dpc_handle_surprise_removal(edev))
>>> +        goto send_ost;
>>> +
>>>       dpc_process_error(edev);
>>>       pci_aer_raw_clear_status(edev);
>>>  
>>> base-commit: a66f2b4a4d365dc4bac35576f3a9d4f5982f1d63
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


