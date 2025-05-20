Return-Path: <linux-pci+bounces-28121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D84FABDECC
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148617A2F4F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FA425F960;
	Tue, 20 May 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6zbErAj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C2F1AF0C8;
	Tue, 20 May 2025 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747754639; cv=none; b=kwd5fM3fSFad3jdJQd3Y2HKs+lYglQAjBfEyuwWf6ZLil17oPGQ7FuecU6Dn1DaoHhae4Mled2ckcn1wCIe0GrAgpaEL23R7SRPMukwZvOE/frnb5ZwQ/LTJsMm+PpvEe1seB+gLYu90sNpc5TvKMzitzI6eAQzw67WwNX1OtMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747754639; c=relaxed/simple;
	bh=xHCm3UhoDYa2v9e+5nIaZq2Jb82Z3T+hUAeKAk7buOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q7QsMzIOW0p3XMufhEhJpUP7U2pGUtB70hXoEh4tKhoWUfVaejKVfZ31Swbmk+xShigO1982K4cH5rVRIOdG1UkNtj0qDJpnsyx2J74Y5xr1L74fV9o+oqZnNZ+Mbp9gk6e2FoIAZvYEfvzTmx8AnqSZeGYtVt9qbFFHAuCzYwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6zbErAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D8AC4CEEF;
	Tue, 20 May 2025 15:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747754638;
	bh=xHCm3UhoDYa2v9e+5nIaZq2Jb82Z3T+hUAeKAk7buOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q6zbErAj1tnRf0n7QbCTp/r4qRNsrWkWoEWoVO3nZkq65cQpbqhwgG9seU2dZG8uH
	 h8qX9fKSh9g824hpofrNw/iauk6+PhGSlkW+zf7BQhNILrdy3XvBrHSKmeIM42zH39
	 nknLSRAjPsC9ardWhS+/7hhLj91Z0tbA/pWeKh4iyGQtY/xWxYAtg0TK90baOSDY9o
	 KSnacF/CYMU00pXhLO14iexzwBsqcK2WXh9yTRY+2W7ZEnqGH8k+llW/QnGAryThCx
	 rGQ1ICSZcVq+N76AjIXcCh2NJ//JUCkiqc7b3+LPUGfFSKzbf8IzG8VpqT4vQbDd9P
	 4lfe1a0Ino8EQ==
Message-ID: <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
Date: Tue, 20 May 2025 10:23:57 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
To: Raag Jadav <raag.jadav@intel.com>, Denis Benato <benato.denis96@gmail.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 lukas@wunner.de, aravind.iddamsetty@linux.intel.com
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/2025 4:48 AM, Raag Jadav wrote:
> On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wrote:
>> On 5/19/25 12:41, Raag Jadav wrote:
>>> On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
>>>> If error status is set on an AER capable device, most likely either the
>>>> device recovery is in progress or has already failed. Neither of the
>>>> cases are well suited for power state transition of the device, since
>>>> this can lead to unpredictable consequences like resume failure, or in
>>>> worst case the device is lost because of it. Leave the device in its
>>>> existing power state to avoid such issues.
>>>>
>>>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>>>> ---
>>>>
>>>> v2: Synchronize AER handling with PCI PM (Rafael)
>>>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>>>      Elaborate "why" (Bjorn)
>>>> v4: Rely on error status instead of device status
>>>>      Condense comment (Lukas)
>>> Since pci_aer_in_progress() is changed I've not included Rafael's tag with
>>> my understanding of this needing a revisit. If this was a mistake, please
>>> let me know.
>>>
>>> Denis, Mario, does this fix your issue?
>>>
>> Hello,
>>
>> Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL
> 
> Thanks for the test. It seems there's no hotplug event this time around
> and endpoint device is still intact without any PCI related failure.
> 
> Also,
> 
> amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
> 
> Which means whatever you're facing is either not related to this patch,
> or at best exposed some nasty side-effect that's not handled correctly
> by the driver.
> 
> I'd say amdgpu folks would be of better help for your case.
> 
> Raag

So according to the logs Denis shared with v4 
(https://pastebin.com/1uBEA1FL) the GPU should have been going to BOCO. 
This stands for "Bus off Chip Off"

amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm

If it's going to D3hot - that's not going to be BOCO, it should be going 
to D3cold.

Denis, can you redo your logs with out Raag's patch patch and set 
CONFIG_PCI_DEBUG to compare?  The 6.14.6 log you shared already 
(https://pastebin.com/kLZtibcD) also chooses BOCO but I'm suspecting 
picks D3cold like it should.

> 
>>>> More discussion on [1].
>>>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>>>>
>>>>   drivers/pci/pci.c      |  9 +++++++++
>>>>   drivers/pci/pcie/aer.c | 13 +++++++++++++
>>>>   include/linux/aer.h    |  2 ++
>>>>   3 files changed, 24 insertions(+)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 4d7c9f64ea24..a20018692933 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -9,6 +9,7 @@
>>>>    */
>>>>   
>>>>   #include <linux/acpi.h>
>>>> +#include <linux/aer.h>
>>>>   #include <linux/kernel.h>
>>>>   #include <linux/delay.h>
>>>>   #include <linux/dmi.h>
>>>> @@ -1539,6 +1540,14 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>>>   	   || (state == PCI_D2 && !dev->d2_support))
>>>>   		return -EIO;
>>>>   
>>>> +	/*
>>>> +	 * If error status is set on an AER capable device, it is not well
>>>> +	 * suited for power state transition. Leave it in its existing power
>>>> +	 * state to avoid issues like unpredictable resume failure.
>>>> +	 */
>>>> +	if (pci_aer_in_progress(dev))
>>>> +		return -EIO;
>>>> +
>>>>   	pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>>   	if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>>>   		pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>> index a1cf8c7ef628..617fbac0d38a 100644
>>>> --- a/drivers/pci/pcie/aer.c
>>>> +++ b/drivers/pci/pcie/aer.c
>>>> @@ -237,6 +237,19 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>>>   }
>>>>   EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>>>   
>>>> +bool pci_aer_in_progress(struct pci_dev *dev)
>>>> +{
>>>> +	int aer = dev->aer_cap;
>>>> +	u32 cor, uncor;
>>>> +
>>>> +	if (!pcie_aer_is_native(dev))
>>>> +		return false;
>>>> +
>>>> +	pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &cor);
>>>> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor);
>>>> +	return cor || uncor;
>>>> +}
>>>> +
>>>>   static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>>>   {
>>>>   	int rc;
>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>> index 02940be66324..e6a380bb2e68 100644
>>>> --- a/include/linux/aer.h
>>>> +++ b/include/linux/aer.h
>>>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>>>>   #if defined(CONFIG_PCIEAER)
>>>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>>   int pcie_aer_is_native(struct pci_dev *dev);
>>>> +bool pci_aer_in_progress(struct pci_dev *dev);
>>>>   #else
>>>>   static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>>   {
>>>>   	return -EINVAL;
>>>>   }
>>>>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>>>>   #endif
>>>>   
>>>>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>> -- 
>>>> 2.34.1
>>>>


