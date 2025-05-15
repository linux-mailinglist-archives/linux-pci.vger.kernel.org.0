Return-Path: <linux-pci+bounces-27808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D15AB89A1
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 16:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50641BC2E0F
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8AD1EBFE0;
	Thu, 15 May 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2IStRE9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B486D1E7C12;
	Thu, 15 May 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320112; cv=none; b=bWpR1kerlxAP/q8OUEgoOEpLxS2emj06hO+ztb7yc8AeJNZ+paEhvzBAVwdRkKW/IWS3JLREskXYOP5QhygHufbRns4Icj3zYr7/psqa7W08tI/KMCiLT56TnBojRgCKhwWjZsQsZPCg7Ba9Sd85/YCYnpXUwxRnBYTOBPGoomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320112; c=relaxed/simple;
	bh=GQKD8W+HfoucYlyeLM5Jc8z1Le5x9+RIie3hPdXwux0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hs0cqmdU/UXjTzSlTFWlOpyVAksF2j+NBVOE5XYHBXEZziXSQNJQ0g+Nw97/VH3qOiq6NmlfOzJUJO9qChuHwCGtpSzeahEVmdyvHlCJd7nEn5UFN6vE79zb7QuKP+A6HOIP6T9SqcBHM7yR5FDLbzp+hp6kv8QvQfnFMhWVX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2IStRE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D159C4CEE7;
	Thu, 15 May 2025 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747320112;
	bh=GQKD8W+HfoucYlyeLM5Jc8z1Le5x9+RIie3hPdXwux0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q2IStRE9OVo793Krp2GyyQPHGpXBVkBxTuu3jAq5AXNOUhwhk5U5r+TB8IIllMw80
	 oAnG5JrqHPZaTO6gtyUqM360tsG88DciDdz6Iti58UR1mZhap233iomIpO+UZHI6ow
	 6WY7lO3B5XdjYzH+r/siRy1q0KJ5XtBR7gwCv46Q7f3MRAnVPvfuxYBH/yP7xRkQ/f
	 lTqIjGWQppwBenKX7rMKhuTDUNJbw4rJa8A1FNWPeawbP/R2ZzqM+GDza3SJHJ6hkL
	 NFhe1323PTrGGhk7+ytC1GMwImtcoSpSpDlPwX/brMk7uLx4yX03kfSazO5NyDFtQ6
	 O4CaeqksDzJaQ==
Message-ID: <66e377ea-4fd1-40dd-822b-081b56a3e155@kernel.org>
Date: Thu, 15 May 2025 09:41:50 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
To: Denis Benato <benato.denis96@gmail.com>, Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 lukas@wunner.de, aravind.iddamsetty@linux.intel.com
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
 <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
 <350f35dd-757e-459f-81f7-666a4457e736@gmail.com>
 <aCXW4c-Ocly4t6yF@black.fi.intel.com>
 <54a46e8a-1584-4282-b3a6-09f22e18d4a8@gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <54a46e8a-1584-4282-b3a6-09f22e18d4a8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/2025 9:11 AM, Denis Benato wrote:
> 
> On 5/15/25 13:58, Raag Jadav wrote:
>> On Wed, May 14, 2025 at 11:25:36PM +0200, Denis Benato wrote:
>>> On 5/14/25 21:53, Mario Limonciello wrote:
>>>> On 5/14/2025 11:29 AM, Denis Benato wrote:
>>>>> Hello,
>>>>>
>>>>> Lately I am experiencing a few problems related to either (one of or both) PCI and/or thunderbolt and Mario Limonciello pointed me to this patch.
>>>>>
>>>>> you can follow an example of my problems in this [1] bug report.
>>>>>
>>>>> I tested this patch on top of 6.14.6 and this patch comes with a nasty regression: s2idle resume breaks all my three GPUs, while for example the sound of a YT video resumes fine.
>>>>>
>>>>> You can see the dmesg here: https://pastebin.com/Um7bmdWi
>> Thanks for the report. From logs it looks like a hotplug event is triggered
>> for presence detect which is disabling the slot and in turn loosing the device
>> on resume. The cause of it is unclear though (assuming it is not a manual
>> intervention).
> No manual intervention: I do "sudo systemctl suspend", wait for the led pattern of sleep and press space. Nothing more than this.
> 
> I also noticed that with this patch, while sleeping, the amd gpu has fans on, while this is not the case sleeping without the patch.
> 
>>>>> I will also say that, on the bright side, this patch makes my laptop behave better on boot as the amdgpu plugged on the thunderbolt port is always enabled on power on, while without this patch it is random if it will be active immediately after laptop has been turned on.
>>>>>
>>>> Just for clarity - if you unplug your eGPU enclosure before suspend is everything OK?  IE this patch only has an impact to the USB4/TBT3 PCIe tunnels?
>>>>
>>> Laptop seems to enter and exit s2idle with the thunderbolt amdgpu disconnected using this patch too.
>>>
>>> Probably this either unveils a pre-existing thunderbolt bug or creates a new one.  If you need assistance in finding the bug or investigating in any other mean let me know as I want to see this patch merged once it stops regressing sleep with egpu.
>> If you're observing this only on thunderbolt port, one experiment I could
>> think of is to configure the port power delivery to be always on during suspend
>> and observe. Perhaps enable both thunderbolt and PCI logging to help figure out
>> what's really happening.
>>
> I have compiled the kernel with CONFIG_PCI_DEBUG=y and added to kernel cmdline "thunderbolt.dyndbg=+p pm_debug_messages" and here is the dmesg of a failed resume: https://pastebin.com/RsxXQQTm

What's really notable to me about this log is these two lines:

amdgpu 0000:09:00.0: PCI PM: Suspend power state: D0
amdgpu 0000:09:00.0: PCI PM: Skipped

The callpath is basically:

pci_pm_suspend_noirq()
->pci_prepare_to_sleep()
->->pci_set_power_state()
->->->__pci_set_power_state()
->->->->pci_set_low_power_state()

So the new pci_aer_in_progress() flags an error here and causes the dGPU 
in the eGPU enclosure to not go to suspend.

A simple W/A to ignore this could be to ignore when 
pm_suspend_target_state is not PM_SUSPEND_ON in pci_aer_in_progress(), 
but it sounds like it's masking a problem.

> 
> Please let me know if this is not detailed enough, and how to enable more logging if you need it.
>>> I will add that as a visible effect entering and exiting s2idle, even without the egpu connected (so when sleep works), makes the screen backlight to turn off and on rapidly about 6 times and it's a bit "concerning" to see, also I have the impression that it takes slightly longer to enter/exit s2idle.
>> Yes, I'm expecting a lot of hidden issues to be surfaced by this patch. Since
>> you've confirmed the machine itself is working fine, I'm hoping there are no
>> serious regressions.
> Except that for thunderbolt nothing major stands out, but once that is solved I would conduct a test about s2idle power consumption because, as noted above, the amdgpu remains on during sleep and it might not be the only component.
> 
> Anyway thanks for your work and if you need more info just ask.
> 
> Denis
> 
>> Raag
>>
>>>> The errors after resume in amdgpu /look/ like the device is "missing" from the bus or otherwise not responding.
>>>>
>>>> I think it would be helpful to capture the kernel log with a baseline of 6.14.6 but without this patch for comparison of what this patch is actually causing.
>>>>
>>> I have a dmesg of the same 6.14.6 minus this patch ready: https://pastebin.com/kLZtibcD
>>>>> [1] https://lore.kernel.org/all/965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com/
>>>>>
>>>>> On 5/4/25 11:04, Raag Jadav wrote:
>>>>>
>>>>>> If error flags are set on an AER capable device, most likely either the
>>>>>> device recovery is in progress or has already failed. Neither of the
>>>>>> cases are well suited for power state transition of the device, since
>>>>>> this can lead to unpredictable consequences like resume failure, or in
>>>>>> worst case the device is lost because of it. Leave the device in its
>>>>>> existing power state to avoid such issues.
>>>>>>
>>>>>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>>>>>> ---
>>>>>>
>>>>>> v2: Synchronize AER handling with PCI PM (Rafael)
>>>>>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>>>>>       Elaborate "why" (Bjorn)
>>>>>>
>>>>>> More discussion on [1].
>>>>>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>>>>>>
>>>>>>    drivers/pci/pci.c      | 12 ++++++++++++
>>>>>>    drivers/pci/pcie/aer.c | 11 +++++++++++
>>>>>>    include/linux/aer.h    |  2 ++
>>>>>>    3 files changed, 25 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>> index 4d7c9f64ea24..25b2df34336c 100644
>>>>>> --- a/drivers/pci/pci.c
>>>>>> +++ b/drivers/pci/pci.c
>>>>>> @@ -9,6 +9,7 @@
>>>>>>     */
>>>>>>      #include <linux/acpi.h>
>>>>>> +#include <linux/aer.h>
>>>>>>    #include <linux/kernel.h>
>>>>>>    #include <linux/delay.h>
>>>>>>    #include <linux/dmi.h>
>>>>>> @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>>>>>           || (state == PCI_D2 && !dev->d2_support))
>>>>>>            return -EIO;
>>>>>>    +    /*
>>>>>> +     * If error flags are set on an AER capable device, most likely either
>>>>>> +     * the device recovery is in progress or has already failed. Neither of
>>>>>> +     * the cases are well suited for power state transition of the device,
>>>>>> +     * since this can lead to unpredictable consequences like resume
>>>>>> +     * failure, or in worst case the device is lost because of it. Leave the
>>>>>> +     * device in its existing power state to avoid such issues.
>>>>>> +     */
>>>>>> +    if (pci_aer_in_progress(dev))
>>>>>> +        return -EIO;
>>>>>> +
>>>>>>        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>>>>        if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>>>>>            pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
>>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>>> index a1cf8c7ef628..4040770df4f0 100644
>>>>>> --- a/drivers/pci/pcie/aer.c
>>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>>> @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>>>>>    }
>>>>>>    EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>>>>>    +bool pci_aer_in_progress(struct pci_dev *dev)
>>>>>> +{
>>>>>> +    u16 reg16;
>>>>>> +
>>>>>> +    if (!pcie_aer_is_native(dev))
>>>>>> +        return false;
>>>>>> +
>>>>>> +    pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
>>>>>> +    return !!(reg16 & PCI_EXP_AER_FLAGS);
>>>>>> +}
>>>>>> +
>>>>>>    static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>>>>>    {
>>>>>>        int rc;
>>>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>>>> index 02940be66324..e6a380bb2e68 100644
>>>>>> --- a/include/linux/aer.h
>>>>>> +++ b/include/linux/aer.h
>>>>>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>>>>>>    #if defined(CONFIG_PCIEAER)
>>>>>>    int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>>>>    int pcie_aer_is_native(struct pci_dev *dev);
>>>>>> +bool pci_aer_in_progress(struct pci_dev *dev);
>>>>>>    #else
>>>>>>    static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>>>>    {
>>>>>>        return -EINVAL;
>>>>>>    }
>>>>>>    static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>>>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>>>>>>    #endif
>>>>>>      void pci_print_aer(struct pci_dev *dev, int aer_severity,


