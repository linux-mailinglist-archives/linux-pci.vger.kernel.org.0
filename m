Return-Path: <linux-pci+bounces-27763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C64AB77E6
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 23:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F422F3ADB02
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 21:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF25828D856;
	Wed, 14 May 2025 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avRYxeJb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39C41F0E47;
	Wed, 14 May 2025 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257941; cv=none; b=EfbRvPDRiXPR8UBIiNmnVSV2NtgyPslL0Cw55Z3O6Ob5EWAWPqwf1QSBkXpgzJ1mwvX/mUCBbDspQKeu7tQ+1LksFNmLi6gL0j8TN+T1hIWMVohyFogLjjwDJiScnG6fgtLKrfhhAceX84yk8IJHUGe5pbrhUHg0QHYyVa2ZbWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257941; c=relaxed/simple;
	bh=cpzam9QMg2o05WO4i9hkTgnqS0DWyNL0eyxNtT6b6y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1mUcV4nPVAe0FTg0nfVcnU4qRPGYQVzAt6mdgJIDVcH89TGEbaLJOzkmXIPtRXte1R3CJic9SeUTlwA+ADBdWOjzqnINLE9kGF/hHkCL6MmzvfrAxARJobqW4C6EB47KxkORuuWHsIv0CJMeC9msxq32famEp6tL8g9t/lFp08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avRYxeJb; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fcc96b6a64so564576a12.0;
        Wed, 14 May 2025 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747257938; x=1747862738; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cpzam9QMg2o05WO4i9hkTgnqS0DWyNL0eyxNtT6b6y0=;
        b=avRYxeJb70gNBiam3EM3PEa4oOuSECL8g5cLvDLWL4phsNTbCK6NYYbvbfq3vKj/Cu
         GIfx8a5iTchQyoliWYKdE0XJQYt9hIWGE6oZvGXCTnNfy1z10qKQ9hSOaSPb3ORCv49t
         z1tcjdHN2SHKqpOXEkZgXCkmnbx5Tlh4NV+845GLUVoqZzfkkIf1QTF/dxLkpOSvW9WK
         eZ11WPMRqeQx3WSvSmV/4FbSE3pdkmgLem9heYu52ELvcnSWHHMCCE07bJdJd+DXExgG
         ZWchGxt2HfL6yzG5Ahubs6hd13/gwb21jzDd2yGCr5/KxHYgU7rJmQxECwNBgGnEXzU9
         xfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747257938; x=1747862738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cpzam9QMg2o05WO4i9hkTgnqS0DWyNL0eyxNtT6b6y0=;
        b=vyqT2lPAe5xNj4CVBIFRT0vpe4NKw7CmcFqZ83+PQ/AbszPWNmCjREchqa8xX7Z7DS
         G275I1kf5R0VYrIKZh8ECiAxXzinBf/zYCeawILRrXDKMmauJibS6IYEdr6EVnm4EU/d
         NSuthoRDJ09+uYow0TA42xMC9UEm+hyAsI8cg6ny+benOyL7hWfsPrrpjk2lgaYCKHd2
         5dlQwnTcwOemWZBJR8QCUzQ1HUYO4YNykZIn8bPH8tAOxl5Vd8WnWwyYef9QPdZv/AAR
         e69BMDvRl2tGH5WPBx7Mia/228scga0PPeZbVTt0YS7Wzcslj+O2Unr34GLqnng+ICAD
         XD7w==
X-Forwarded-Encrypted: i=1; AJvYcCUedO1EyqN5uFHJk9t6AzsAG5HmY/WzR5OgP1YCAJl8fg95UA8akQaJvZiaYrJ1FrYPCtYNp3FO54hiBac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7xzcSw/CWE76AbTHwdvlNJRF4CQ4MaYzZdGo8GSwEayYwaRrD
	K58kNt1FNT3zTpQRhqno4kKHJ0bulXTXFLedXEVt6/fUt8yVo9gU
X-Gm-Gg: ASbGncud1kjJhEa86NAUubH1r7GYoNVFgU8dNnvzuHSHGV6ikduAwShGEGdCjFsCjyK
	nMV8UNRwxJ6hswRoTE0IG33vP8SpeOxuvVWkBugQTOrOeFJdv0hyhIUpiUk8eirryauw3fatG6A
	ojnRKLpCNNugeG+5uIAwhG1Wfj7yAq4wUDgtIdx8GlFheHPmww9NTsHjwWkt6CYJPx3agmxY6DS
	8sfNORjuaonBeBgwtVS8J8hNLJi5GihD4b83Q5CSM0pwOx7HXGWI+SpEdGJBRgGvwReI5++76+c
	oMatTQ4PRzTSS+yLnhaNLA4HgdkXhCVXjr2KKfy+SuPlHdl3gV3flaLy9q0wD+0=
X-Google-Smtp-Source: AGHT+IGA/ejkxGCh4W/lw4dP+0sAd0GbaKcMoHrkLayhXBddAQtKtk/FZ4vNZ2mS+R82rlBSPL4oIw==
X-Received: by 2002:a05:6402:254b:b0:5f8:e955:241d with SMTP id 4fb4d7f45d1cf-5ff988a5551mr3998097a12.8.1747257937853;
        Wed, 14 May 2025 14:25:37 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d7016b4sm9313385a12.49.2025.05.14.14.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 14:25:37 -0700 (PDT)
Message-ID: <350f35dd-757e-459f-81f7-666a4457e736@gmail.com>
Date: Wed, 14 May 2025 23:25:36 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
To: Mario Limonciello <superm1@kernel.org>, Raag Jadav
 <raag.jadav@intel.com>, rafael@kernel.org, mahesh@linux.ibm.com,
 oohall@gmail.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
 aravind.iddamsetty@linux.intel.com
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <7dbb64ee-3683-4b47-b17d-288447da746e@gmail.com>
 <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <384a2c60-2f25-4a1d-b8a6-3ea4ea34e2c2@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/14/25 21:53, Mario Limonciello wrote:
> On 5/14/2025 11:29 AM, Denis Benato wrote:
>> Hello,
>>
>> Lately I am experiencing a few problems related to either (one of or both) PCI and/or thunderbolt and Mario Limonciello pointed me to this patch.
>>
>> you can follow an example of my problems in this [1] bug report.
>>
>> I tested this patch on top of 6.14.6 and this patch comes with a nasty regression: s2idle resume breaks all my three GPUs, while for example the sound of a YT video resumes fine.
>>
>> You can see the dmesg here: https://pastebin.com/Um7bmdWi
>>
>> I will also say that, on the bright side, this patch makes my laptop behave better on boot as the amdgpu plugged on the thunderbolt port is always enabled on power on, while without this patch it is random if it will be active immediately after laptop has been turned on.
>>
>
> Just for clarity - if you unplug your eGPU enclosure before suspend is everything OK?  IE this patch only has an impact to the USB4/TBT3 PCIe tunnels?
>
Laptop seems to enter and exit s2idle with the thunderbolt amdgpu disconnected using this patch too.

Probably this either unveils a pre-existing thunderbolt bug or creates a new one.  If you need assistance in finding the bug or investigating in any other mean let me know as I want to see this patch merged once it stops regressing sleep with egpu.


I will add that as a visible effect entering and exiting s2idle, even without the egpu connected (so when sleep works), makes the screen backlight to turn off and on rapidly about 6 times and it's a bit "concerning" to see, also I have the impression that it takes slightly longer to enter/exit s2idle.


> The errors after resume in amdgpu /look/ like the device is "missing" from the bus or otherwise not responding.
>
> I think it would be helpful to capture the kernel log with a baseline of 6.14.6 but without this patch for comparison of what this patch is actually causing.
>
I have a dmesg of the same 6.14.6 minus this patch ready: https://pastebin.com/kLZtibcD
>>
>> [1] https://lore.kernel.org/all/965c9753-f14b-4a87-9f6d-8798e09ad6f5@gmail.com/
>>
>> On 5/4/25 11:04, Raag Jadav wrote:
>>
>>> If error flags are set on an AER capable device, most likely either the
>>> device recovery is in progress or has already failed. Neither of the
>>> cases are well suited for power state transition of the device, since
>>> this can lead to unpredictable consequences like resume failure, or in
>>> worst case the device is lost because of it. Leave the device in its
>>> existing power state to avoid such issues.
>>>
>>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>>> ---
>>>
>>> v2: Synchronize AER handling with PCI PM (Rafael)
>>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>>      Elaborate "why" (Bjorn)
>>>
>>> More discussion on [1].
>>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>>>
>>>   drivers/pci/pci.c      | 12 ++++++++++++
>>>   drivers/pci/pcie/aer.c | 11 +++++++++++
>>>   include/linux/aer.h    |  2 ++
>>>   3 files changed, 25 insertions(+)
>>>
>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>> index 4d7c9f64ea24..25b2df34336c 100644
>>> --- a/drivers/pci/pci.c
>>> +++ b/drivers/pci/pci.c
>>> @@ -9,6 +9,7 @@
>>>    */
>>>     #include <linux/acpi.h>
>>> +#include <linux/aer.h>
>>>   #include <linux/kernel.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/dmi.h>
>>> @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>>          || (state == PCI_D2 && !dev->d2_support))
>>>           return -EIO;
>>>   +    /*
>>> +     * If error flags are set on an AER capable device, most likely either
>>> +     * the device recovery is in progress or has already failed. Neither of
>>> +     * the cases are well suited for power state transition of the device,
>>> +     * since this can lead to unpredictable consequences like resume
>>> +     * failure, or in worst case the device is lost because of it. Leave the
>>> +     * device in its existing power state to avoid such issues.
>>> +     */
>>> +    if (pci_aer_in_progress(dev))
>>> +        return -EIO;
>>> +
>>>       pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>       if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>>           pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>> index a1cf8c7ef628..4040770df4f0 100644
>>> --- a/drivers/pci/pcie/aer.c
>>> +++ b/drivers/pci/pcie/aer.c
>>> @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>>   }
>>>   EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>>   +bool pci_aer_in_progress(struct pci_dev *dev)
>>> +{
>>> +    u16 reg16;
>>> +
>>> +    if (!pcie_aer_is_native(dev))
>>> +        return false;
>>> +
>>> +    pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
>>> +    return !!(reg16 & PCI_EXP_AER_FLAGS);
>>> +}
>>> +
>>>   static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>>   {
>>>       int rc;
>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>> index 02940be66324..e6a380bb2e68 100644
>>> --- a/include/linux/aer.h
>>> +++ b/include/linux/aer.h
>>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>>>   #if defined(CONFIG_PCIEAER)
>>>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>   int pcie_aer_is_native(struct pci_dev *dev);
>>> +bool pci_aer_in_progress(struct pci_dev *dev);
>>>   #else
>>>   static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>   {
>>>       return -EINVAL;
>>>   }
>>>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>>>   #endif
>>>     void pci_print_aer(struct pci_dev *dev, int aer_severity,
>

