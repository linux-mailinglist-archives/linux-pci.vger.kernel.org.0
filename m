Return-Path: <linux-pci+bounces-4491-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BF6871569
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 06:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C9E1C219CE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 05:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863A84CE0E;
	Tue,  5 Mar 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CbUAv+fa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699132AE95;
	Tue,  5 Mar 2024 05:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709617803; cv=none; b=hzMSn7JIh2mGQfPJJngD7boSdW7ZZI9SDXLePIu8Tt/RigB6RJ1QrvWIuu0SsCocluEf/wbqJoKWx2KQ3YURFz8gfpS7H0igdu2Qi7XYdIQdytnXLf9misLG6Nd8RbPKRo3jOS1vnUlZ7cKQkacYPZ8x3vT8Di+MBVH9zj+189I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709617803; c=relaxed/simple;
	bh=Pkqe3GM976isWWk+iOe4Ijfs1E4DlP3P9wNnfOkdZbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koO/Us8jD4ePzYuia/VyA8EkLwVLNt//PWsCu4PROMN0rs/Oswv3M5znG837ETi+LqOciFkpLWxDTuZYFEyfDzbuXHzSPEMLhw8RZzqlVKqvg4RQByRbrrZDQlOJlt5X0ZswPkn+mArPN/ccEsy3Wvhld/2FbPGt11gQTdHZy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CbUAv+fa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709617801; x=1741153801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Pkqe3GM976isWWk+iOe4Ijfs1E4DlP3P9wNnfOkdZbU=;
  b=CbUAv+faNHumpNjRh9Hex7iUO3yMGtZRtVQ2jS1ULQg65HtRdhDAavsP
   ow4G0dOT5WbIGuS+iA0dW7t3ILpRJapwt+hH4lxu/XrFxzTA4UnIdg3uY
   w2twQ9V9bBOrNBUhraLwdcVfuqEuSk28ouVi3dPd6uxUoerJmooPIsmeR
   l94d9X++jQhLB3b+gEfQFGSI5tewwRptwF8BHxTmKGa4H+eT3sdjficuO
   n2NGGRDSnW/FM9DRoeQVzn3g+At6JBRKLk5K7fBJ4hLcRHHjsOe9NUAbZ
   K6oaap3mgA+Mg3c8UJMA6HdoMKabS0fC+jwn8JFLByCoFFVxEFCaHMrGb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="14731670"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14731670"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:50:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="13800839"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.124.229.115]) ([10.124.229.115])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 21:49:58 -0800
Message-ID: <60ffa11f-6c07-4a27-8229-eeab172529e2@linux.intel.com>
Date: Tue, 5 Mar 2024 13:49:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot
 removal
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 bhelgaas@google.com, lukas@wunner.de
Cc: Smita.KoralahalliChannabasappa@amd.com, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kbusch@kernel.org
References: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
 <71acbf58-a05d-4842-bc6b-c4e66e1a2b58@linux.intel.com>
 <f3eea050-53f9-4e4f-9694-06560a406db8@linux.intel.com>
 <589fd9ae-5695-45c5-8772-cb3c736b3d4d@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <589fd9ae-5695-45c5-8772-cb3c736b3d4d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/5/2024 12:04 PM, Kuppuswamy Sathyanarayanan wrote:
> On 3/4/24 6:29 PM, Ethan Zhao wrote:
>> On 3/5/2024 4:10 AM, Kuppuswamy Sathyanarayanan wrote:
>>> On 3/4/24 1:08 AM, Ethan Zhao wrote:
>>>> Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
>>>> handling path, FW should clear UC errors logged by port and bring link
>>>> out of DPC, but because of ambiguity of wording in the spec, some BIOSes
>>>> doesn't clear the surprise down error and the error bits in pci status,
>>> As Lukas mentioned, please include the hardware and BIOS version
>>> where you see this issue.
>> Reproduced on "Hardware name: Intel Corporation ArcherCity/ArcherCity,
>>   BIOS EGSDCRB1.86B.0107.D20.2310211929 10/21/2023"
>>
>>>> still notify OS to handle it. thus following trick is needed in EDR when
>>>> double reporting (hot removal interrupt && dpc notification) is hit.
>>> EDR notification is generally used when a firmware wants OS to invalidate
>>> or recover the error state of child devices when handling a containment event.
>>> Since this DPC event is a side effect of async removal, there is no recovery
>>> involved. So there is no value in firmware notifying the OS via an ACPI notification
>>> and then OS ignoring it.
>>>
>>> If you check the PCIe firmware spec, sec 4.6.12, IMPLEMENTATION NOTE, it
>>> recommends firmware to ignore the DPC due to hotplug surprise.
>> My understanding is the same, let firmware to ignore the errors and bring
>> it out of DPC.
>>
>> But due to the wording like:
>> "FW should not issue Notify(0xF) to avoid doule reporting. FW should clear
>> *other* UC errors logged by port(if any) and bring link out of DPC if it has
>> entered DPC."
>>
> "Since surprise hot remove event is signaled to OS via hot plug interrupt, FW should
> not issue Notify(0xF) to avoid double reporting. FW should clear other UC errors logged
> by port (if any) and bring link out of DPC if it has entered DPC."
>
>
> Above statement is a note about how to treat DPC triggered due to async
> removal. Since OS already gets notification via DLLSC change (hotplug interrupt),
> there is no need for reporting again using EDR notification. I think the flow
> chart is very clear about handling the hotplug related error case. Also the
> note "Clear other UC errors" means it also includes "Surprise Down" error.

Agree. some BIOS writers might misunderstand that as leave "Surprise Down"
error to OS for specicial treatment.

Thanks,
Ethan

>
>> Some BIOS writers have different understanding, wouldn't clear the surprise
>> down error.
>>
>> Thanks,
>> Ethan
>>
>>>> https://patchwork.kernel.org/project/linux-pci/patch/20240207181854.
>>>> 121335-1-Smita.KoralahalliChannabasappa@amd.com/
>>>>
>>>> Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
>>>> ---
>>>>    drivers/pci/pci.h      | 1 +
>>>>    drivers/pci/pcie/dpc.c | 9 +++++----
>>>>    drivers/pci/pcie/edr.c | 3 +++
>>>>    3 files changed, 9 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
>>>> index 50134b5e3235..3787bb32e724 100644
>>>> --- a/drivers/pci/pci.h
>>>> +++ b/drivers/pci/pci.h
>>>> @@ -443,6 +443,7 @@ void pci_save_dpc_state(struct pci_dev *dev);
>>>>    void pci_restore_dpc_state(struct pci_dev *dev);
>>>>    void pci_dpc_init(struct pci_dev *pdev);
>>>>    void dpc_process_error(struct pci_dev *pdev);
>>>> +bool dpc_handle_surprise_removal(struct pci_dev *pdev);
>>>>    pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>>>>    bool pci_dpc_recovered(struct pci_dev *pdev);
>>>>    #else
>>>> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
>>>> index 98b42e425bb9..be79f205e04c 100644
>>>> --- a/drivers/pci/pcie/dpc.c
>>>> +++ b/drivers/pci/pcie/dpc.c
>>>> @@ -319,8 +319,10 @@ static void pci_clear_surpdn_errors(struct pci_dev *pdev)
>>>>        pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
>>>>    }
>>>>    -static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>> +bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>>    {
>>>> +    if (!dpc_is_surprise_removal(pdev))
>>>> +        return false;
>>>>        if (!pcie_wait_for_link(pdev, false)) {
>>>>            pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
>>>>            goto out;
>>>> @@ -338,6 +340,7 @@ static void dpc_handle_surprise_removal(struct pci_dev *pdev)
>>>>    out:
>>>>        clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
>>>>        wake_up_all(&dpc_completed_waitqueue);
>>>> +    return true;
>>>>    }
>>>>      static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>>>> @@ -362,10 +365,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
>>>>         * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
>>>>         * of async removal and should be ignored by software.
>>>>         */
>>>> -    if (dpc_is_surprise_removal(pdev)) {
>>>> -        dpc_handle_surprise_removal(pdev);
>>>> +    if (dpc_handle_surprise_removal(pdev))
>>>>            return IRQ_HANDLED;
>>>> -    }
>>>>          dpc_process_error(pdev);
>>>>    diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
>>>> index 5f4914d313a1..556edfb2696a 100644
>>>> --- a/drivers/pci/pcie/edr.c
>>>> +++ b/drivers/pci/pcie/edr.c
>>>> @@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>>>>            goto send_ost;
>>>>        }
>>>>    +    if (dpc_handle_surprise_removal(edev))
>>>> +        goto send_ost;
>>>> +
>>>>        dpc_process_error(edev);
>>>>        pci_aer_raw_clear_status(edev);
>>>>   
>>>> base-commit: a66f2b4a4d365dc4bac35576f3a9d4f5982f1d63

