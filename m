Return-Path: <linux-pci+bounces-27807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED1AB88F7
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 16:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 085913AB02E
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 14:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05444174A;
	Thu, 15 May 2025 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggcm+5fX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C499519F489;
	Thu, 15 May 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747318295; cv=none; b=WjFjbU+YuOMpTcqcSe4T/2X67YVfUoEvB8inS1dyQbymCGMnhBsr2PTR+8GMkz+nyCJiTcEDKzjPLjxLGdkJbBMEccybOgtFq2Mx6EJCT+hqhH6CwmwFu+ujuNdZBQVSIIAqKgpkAJ/5YD85TPgKLdA92QN5ybyoqM1BKu6VY8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747318295; c=relaxed/simple;
	bh=Dd9MZA8jSl35weW8qqSp7q3NGXUeK6mAA4n71qFDFUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IR7yFUlzs41MAu56LL9juICZUu9dhNzCb5jz3w9Ge5Podyo3Jb5mq6hmlYy9fSQx1diuUdE/qghtUCrHziaj7/R6x5QJJw66tT1QqD1tXy7qcj4KL2HFhTX/WLNddLLnoWxpaDrtMpamzcGafvg3RIUIb2ndMYAbNUhhuaH0gz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggcm+5fX; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-600210e4219so345737a12.0;
        Thu, 15 May 2025 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747318292; x=1747923092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dd9MZA8jSl35weW8qqSp7q3NGXUeK6mAA4n71qFDFUQ=;
        b=ggcm+5fX8VmJ/PZh/n1cHqC75QuZFZF80pN37XzGoJtfLZAaydWY2Q/qclzG6zAXG9
         mPucdcKwjO/ea4bq4tW3iYHXe1PKlZZnpEKosJ8QC70cMGcyneOXtIogx+CxCVkZd7go
         dw4IbRu9QmqaAmWEwTq4p9jZC/Yzwv697frzo2L4WzYhMoDQ90ZXJikXtIRKZKQcNd75
         FZmvTCPMA5F9bDDgsTHzHxVJhFkNkJKmsIJoaKYBjhB8Aew/cBmdENoQOdAdWPxjs/j9
         zf2+lLsWiBRXLxgF3EZndlSBDEFw47Zzh0dLXxh1n7esMmp6bTwXar34RJ2e7Q1UYXrN
         OoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747318292; x=1747923092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dd9MZA8jSl35weW8qqSp7q3NGXUeK6mAA4n71qFDFUQ=;
        b=ZxV+MHSYCTPJyGd/n+jYVJcbPAT0aVse9Vq2lNOV7hgQ10ulFdxP4SwS3SoSpRxrPM
         /1AeV+SI6ZslINUHMzYrRGA/8q6ERCMCQXqEYf0Ivyy7U3lYOFiO4MqeAvT5b6JY+U6J
         ygjNMGSqOZtsp4LrDVQ8ItzBOCWe6zOFRILJhDx9jAHYsTsUfXh3diMbr7HNL4cDMN/8
         QuagXKyaunBST47CVnnvnHqUCr1BbwZqzu6VQpK4Os6epa6Tk6SOQ8ZoHSzvZwwpAKdv
         orHRwaXPuubBg0ahwOG65o7hV0Mj1k8W1cy70vYWoLuGPDIF/dEs5Acp58R0INi6IHi0
         /bdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUM6WDZQI7L7jADg+PaMGoqYVoKK0h/RphA42FdWpPyBDjmG5hBm1/4tU/33b7VHXGy+N3WneNex36FenU=@vger.kernel.org, AJvYcCX5PJDF9tLsL/pe9322oQFCfOvlDyIFDN60WV5PjVMgl8rqzJgO9+JH/Hey1T93MkaCf1spnUqn1YxU@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNZrpeYDpSBbSuk8CeJzsu4B957/jx8a2VIF1Z9ecVlGDuto5
	pXul/BXimTdg0hWZgO10nmClxY8izlgFVCh62XUUIJeqsNxEOAZ2ig6S
X-Gm-Gg: ASbGncuw5xDoLwIBbEUYCqlK3dds4BiyXjmZlBIkLa5F/vcQCZFq+Ouyc0uWqJNJYuq
	qMOazqgDPQhIYZPqb+Yj4/Ic6GbQnnCMM/NMh+/Xmh46/b5rXbTqqbgltyVyLxsXsUGWHI4xDQn
	zDSjdYzrKQBS7d2qHRbW1xxLBGxfzG2cXwZiyPdn+Wnz4HVB8CHN4+TWZhl47lOwdL2kD/fidny
	4gFowt/o1A1QFrgvbQYzfLsMAHx9r0tkD/Irrb0+Wx2djVBUsEN+itw1A5GQDz+iqOUFILElGq4
	53k9hhl+oCZUwdn75P7TAwxCgvOIrw7Z3ckoYAnuTnc5RpcX4D6iEtOnsELeNdg=
X-Google-Smtp-Source: AGHT+IHqgoFQ6uKy6tMVdENoY+gqIxlCZvzE5y4aHnvV19ZTnoiicqbWP6hXgqA+ysVjjXDGsvoykA==
X-Received: by 2002:a17:907:3f0b:b0:ad2:4658:7359 with SMTP id a640c23a62f3a-ad50f6c1097mr391873666b.17.1747318291461;
        Thu, 15 May 2025 07:11:31 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad23fc5328bsm856537266b.40.2025.05.15.07.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 07:11:31 -0700 (PDT)
Message-ID: <54a46e8a-1584-4282-b3a6-09f22e18d4a8@gmail.com>
Date: Thu, 15 May 2025 16:11:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
To: Raag Jadav <raag.jadav@intel.com>
Cc: Mario Limonciello <superm1@kernel.org>, rafael@kernel.org,
 mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
 aravind.iddamsetty@linux.intel.com
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
 <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
 <350f35dd-757e-459f-81f7-666a4457e736@gmail.com>
 <aCXW4c-Ocly4t6yF@black.fi.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <aCXW4c-Ocly4t6yF@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/15/25 13:58, Raag Jadav wrote:
> On Wed, May 14, 2025 at 11:25:36PM +0200, Denis Benato wrote:
>> On 5/14/25 21:53, Mario Limonciello wrote:
>>> On 5/14/2025 11:29 AM, Denis Benato wrote:
>>>> Hello,
>>>>
>>>> Lately I am experiencing a few problems related to either (one of or both) PCI and/or thunderbolt and Mario Limonciello pointed me to this patch.
>>>>
>>>> you can follow an example of my problems in this [1] bug report.
>>>>
>>>> I tested this patch on top of 6.14.6 and this patch comes with a nasty regression: s2idle resume breaks all my three GPUs, while for example the sound of a YT video resumes fine.
>>>>
>>>> You can see the dmesg here: https://pastebin.com/Um7bmdWi
> Thanks for the report. From logs it looks like a hotplug event is triggered
> for presence detect which is disabling the slot and in turn loosing the device
> on resume. The cause of it is unclear though (assuming it is not a manual
> intervention).
No manual intervention: I do "sudo systemctl suspend", wait for the led pattern of sleep and press space. Nothing more than this.

I also noticed that with this patch, while sleeping, the amd gpu has fans on, while this is not the case sleeping without the patch.

>>>> I will also say that, on the bright side, this patch makes my laptop behave better on boot as the amdgpu plugged on the thunderbolt port is always enabled on power on, while without this patch it is random if it will be active immediately after laptop has been turned on.
>>>>
>>> Just for clarity - if you unplug your eGPU enclosure before suspend is everything OK?  IE this patch only has an impact to the USB4/TBT3 PCIe tunnels?
>>>
>> Laptop seems to enter and exit s2idle with the thunderbolt amdgpu disconnected using this patch too.
>>
>> Probably this either unveils a pre-existing thunderbolt bug or creates a new one.  If you need assistance in finding the bug or investigating in any other mean let me know as I want to see this patch merged once it stops regressing sleep with egpu.
> If you're observing this only on thunderbolt port, one experiment I could
> think of is to configure the port power delivery to be always on during suspend
> and observe. Perhaps enable both thunderbolt and PCI logging to help figure out
> what's really happening.
>
I have compiled the kernel with CONFIG_PCI_DEBUG=y and added to kernel cmdline "thunderbolt.dyndbg=+p pm_debug_messages" and here is the dmesg of a failed resume: https://pastebin.com/RsxXQQTm

Please let me know if this is not detailed enough, and how to enable more logging if you need it.
>> I will add that as a visible effect entering and exiting s2idle, even without the egpu connected (so when sleep works), makes the screen backlight to turn off and on rapidly about 6 times and it's a bit "concerning" to see, also I have the impression that it takes slightly longer to enter/exit s2idle.
> Yes, I'm expecting a lot of hidden issues to be surfaced by this patch. Since
> you've confirmed the machine itself is working fine, I'm hoping there are no
> serious regressions.
Except that for thunderbolt nothing major stands out, but once that is solved I would conduct a test about s2idle power consumption because, as noted above, the amdgpu remains on during sleep and it might not be the only component.

Anyway thanks for your work and if you need more info just ask.

Denis

> Raag
>
>>> The errors after resume in amdgpu /look/ like the device is "missing" from the bus or otherwise not responding.
>>>
>>> I think it would be helpful to capture the kernel log with a baseline of 6.14.6 but without this patch for comparison of what this patch is actually causing.
>>>
>> I have a dmesg of the same 6.14.6 minus this patch ready: https://pastebin.com/kLZtibcD
>>>> [1] https://lore.kernel.org/all/965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com/
>>>>
>>>> On 5/4/25 11:04, Raag Jadav wrote:
>>>>
>>>>> If error flags are set on an AER capable device, most likely either the
>>>>> device recovery is in progress or has already failed. Neither of the
>>>>> cases are well suited for power state transition of the device, since
>>>>> this can lead to unpredictable consequences like resume failure, or in
>>>>> worst case the device is lost because of it. Leave the device in its
>>>>> existing power state to avoid such issues.
>>>>>
>>>>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>>>>> ---
>>>>>
>>>>> v2: Synchronize AER handling with PCI PM (Rafael)
>>>>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>>>>      Elaborate "why" (Bjorn)
>>>>>
>>>>> More discussion on [1].
>>>>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>>>>>
>>>>>   drivers/pci/pci.c      | 12 ++++++++++++
>>>>>   drivers/pci/pcie/aer.c | 11 +++++++++++
>>>>>   include/linux/aer.h    |  2 ++
>>>>>   3 files changed, 25 insertions(+)
>>>>>
>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>> index 4d7c9f64ea24..25b2df34336c 100644
>>>>> --- a/drivers/pci/pci.c
>>>>> +++ b/drivers/pci/pci.c
>>>>> @@ -9,6 +9,7 @@
>>>>>    */
>>>>>     #include <linux/acpi.h>
>>>>> +#include <linux/aer.h>
>>>>>   #include <linux/kernel.h>
>>>>>   #include <linux/delay.h>
>>>>>   #include <linux/dmi.h>
>>>>> @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>>>>          || (state == PCI_D2 && !dev->d2_support))
>>>>>           return -EIO;
>>>>>   +    /*
>>>>> +     * If error flags are set on an AER capable device, most likely either
>>>>> +     * the device recovery is in progress or has already failed. Neither of
>>>>> +     * the cases are well suited for power state transition of the device,
>>>>> +     * since this can lead to unpredictable consequences like resume
>>>>> +     * failure, or in worst case the device is lost because of it. Leave the
>>>>> +     * device in its existing power state to avoid such issues.
>>>>> +     */
>>>>> +    if (pci_aer_in_progress(dev))
>>>>> +        return -EIO;
>>>>> +
>>>>>       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>>>       if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>>>>           pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>> index a1cf8c7ef628..4040770df4f0 100644
>>>>> --- a/drivers/pci/pcie/aer.c
>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>> @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>>>>   }
>>>>>   EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>>>>   +bool pci_aer_in_progress(struct pci_dev *dev)
>>>>> +{
>>>>> +    u16 reg16;
>>>>> +
>>>>> +    if (!pcie_aer_is_native(dev))
>>>>> +        return false;
>>>>> +
>>>>> +    pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
>>>>> +    return !!(reg16 & PCI_EXP_AER_FLAGS);
>>>>> +}
>>>>> +
>>>>>   static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>>>>   {
>>>>>       int rc;
>>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>>> index 02940be66324..e6a380bb2e68 100644
>>>>> --- a/include/linux/aer.h
>>>>> +++ b/include/linux/aer.h
>>>>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>>>>>   #if defined(CONFIG_PCIEAER)
>>>>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>>>   int pcie_aer_is_native(struct pci_dev *dev);
>>>>> +bool pci_aer_in_progress(struct pci_dev *dev);
>>>>>   #else
>>>>>   static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>>>   {
>>>>>       return -EINVAL;
>>>>>   }
>>>>>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>>>>>   #endif
>>>>>     void pci_print_aer(struct pci_dev *dev, int aer_severity,

