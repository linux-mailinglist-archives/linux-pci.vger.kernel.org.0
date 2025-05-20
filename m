Return-Path: <linux-pci+bounces-28131-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D57ABE1BC
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 19:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B70F1BC00AD
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95933276054;
	Tue, 20 May 2025 17:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5Od2F/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD335893;
	Tue, 20 May 2025 17:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747761729; cv=none; b=il2Svaei3wxZ55PFNZx5PGgsq7oCIVrc/oqzTXzMNq16n6F5Y/X41Qpw6ZddN7xNegbTSfrFCOhHvMl5Pb6BMbBXNNX2QQJnJ8LUKrj315YINgYOHrJYo3tbSGoXukUekaBvhZ7r5VAfaO1sxRkfUsqFm2SKd//QfghF4irA2rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747761729; c=relaxed/simple;
	bh=4tQcLsfpU5PWw/IzdXbOwqd2wS+RlrCxDYiohJMayDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VtoqlFGmxzLkH99k+UduSa56iO2HASvoOcDkzUWFtZsLUwvJiGMjYgG6fBQUcNA8GHvbp5RRY1WAt7jAoFFm78ryYxdeO36WzXyy9O7nDm1Sx2LQv91FxdhJH+54EZigubFkLNgOpEruEWxtcCDlEJSCcYwZ+REqsjR/cHFE5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5Od2F/y; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a36c2d3104so1757867f8f.1;
        Tue, 20 May 2025 10:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747761726; x=1748366526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4tQcLsfpU5PWw/IzdXbOwqd2wS+RlrCxDYiohJMayDw=;
        b=c5Od2F/yHEzjEys/bXYgVbVc4zDU0mkhtPbO9qKUGDVMa45Oaf/5gdNIrpMK9leTxl
         0pmYMSPMkirOA1I92L0f2q9CIx3JVvJdi+FdPEpuIKbK5BeWz0SFIgMiyozwvU2/e3pb
         06NlexEGGcQEZgg7ZLWjCfdOhmgFFQZS+GiSmUi/PTERWdvYvv9tlZXGjITliebxSdQ/
         HxR60TeWxBbSPEZnf981kFqh0+ISdR4VC+fOxVYFAFgsYu2mTU6rPUp5NGYMc3PFDvwJ
         wRmOiah7yFyKvSPFI8lGFRDMAFhndKGoupz//v4aFJyeuVMOrc+28DMT7ZvvmPyWkAJD
         rFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747761726; x=1748366526;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4tQcLsfpU5PWw/IzdXbOwqd2wS+RlrCxDYiohJMayDw=;
        b=IhXyXE0cy/1Yxcu3mEK7JH7XOB08sgdtievAILJp/qGXzx8qeHDKbXOA0FWlHYabqa
         r2xvKIhp8UjUCtS/SMoHbNIfnyS7zecoIF3iVGuRrquNMCI4oH94PpkrSaJR+6OdfkOU
         ogHEcmZ6tPHcGGBlPVgZpdnDhrSkpb2NH1yqgUuM2R1dzBP88hl4jWf003JA1hYuZ1JI
         ntalfsb44mH2AuXyYFT12OlLQMvp5mwPqIrgHKHOIPElmAwbePvG36eGDmVIRZVY+oSm
         4ViPcebpq1jnhSLObWvFuoKMTa4eioZPdSn6CwcepRsoCsumEJvoAg9W8Ozk6lBQCn/O
         VHrg==
X-Forwarded-Encrypted: i=1; AJvYcCV5oKwGgC+qrib9WV7OY9HftLgkziKGUrRYmbMqKe4CD91dGEP918D0b6MDopCewiprc4rbisYMVgrXdN4=@vger.kernel.org, AJvYcCWerclaZueql4omFytcxO8SzpX0Im9zf/bq568g5Pu3DSTVNYupjt0Mnh8LyoUDe8stiFf36xuLJLc=@vger.kernel.org, AJvYcCX38JH/dRXTZVn8Q4goCdrb1DtfdTmetN94OI6eDKz6TuNnOo+DRWybY2VU8uhBjuTXAaYjI5JT1k04@vger.kernel.org
X-Gm-Message-State: AOJu0YymnZT4ORtKN9IQW0cYqNwFqi3tDt1lSVEWCf3zISfWJOznGiL7
	TySI1yZcNgYxq8gQ5wDobzjP0MTPUPXZsLRHZo85EKke5YprzaGANS5T
X-Gm-Gg: ASbGncuXOJpSnu7vnKIbsTIfPGeWGfGYeLr5PC1L1AMRkwnynmt5fFpxpvEHqw+7p/9
	khyW/5gOgQscK48b7N/+kAnxj7OcvbBg1nj+MyCFDbR/WnBwlSt7GXs8Hx7oIqOr4bB9fczcYqL
	LHwzpcPySHte/PJGt6owLN1H1O4T0WW4xfjwwn/9qU3KlRnDNc4m/bWP4W2sMLD9WV3SMYavhXB
	SVDenbrmeSiMFV/1icNkq3JTy607xMwI524EMqQMXf3mekxFEP5eZpGB+R1ZnEJfLuSa30DW9Oc
	AqXo60YCA+YZGjK3X5DLsNAyWPnG5LcW5R9EHPLCaS5309e/cu6H9QtTCcIDfiFNJqWlERQbwg=
	=
X-Google-Smtp-Source: AGHT+IFRhd0lSGq+MvkC82Ucw+R/6mi4DD+3ATdFcakN/aGOoWrgKwEJ3BoJi7BHh+DMSro2KqDuTw==
X-Received: by 2002:a5d:5848:0:b0:39c:1ef6:4364 with SMTP id ffacd0b85a97d-3a35c821a72mr16962975f8f.14.1747761725566;
        Tue, 20 May 2025 10:22:05 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.99.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f062c7sm40263375e9.14.2025.05.20.10.22.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 10:22:05 -0700 (PDT)
Message-ID: <ee1117cf-6367-4e9a-aa85-ccfc6c63125d@gmail.com>
Date: Tue, 20 May 2025 19:22:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PCI: Prevent power state transition of erroneous
 device
To: Mario Limonciello <superm1@kernel.org>, Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, mahesh@linux.ibm.com, oohall@gmail.com,
 bhelgaas@google.com, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
 lukas@wunner.de, aravind.iddamsetty@linux.intel.com
References: <20250519102808.4130271-1-raag.jadav@intel.com>
 <aCsK743YSuahPtnH@black.fi.intel.com>
 <85ed0b91-c84f-4d24-8e19-a8cb3ba02b14@gmail.com>
 <aCxP6vQ8Ep9LftPv@black.fi.intel.com>
 <a8c83435-4c91-495c-950c-4d12b955c54c@kernel.org>
 <aCyj9nbnIRet93O-@black.fi.intel.com>
 <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <552d75b2-2736-419f-887e-ce2692616578@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/20/25 17:49, Mario Limonciello wrote:
> On 5/20/2025 10:47 AM, Raag Jadav wrote:
>> On Tue, May 20, 2025 at 10:23:57AM -0500, Mario Limonciello wrote:
>>> On 5/20/2025 4:48 AM, Raag Jadav wrote:
>>>> On Mon, May 19, 2025 at 11:42:31PM +0200, Denis Benato wrote:
>>>>> On 5/19/25 12:41, Raag Jadav wrote:
>>>>>> On Mon, May 19, 2025 at 03:58:08PM +0530, Raag Jadav wrote:
>>>>>>> If error status is set on an AER capable device, most likely either the
>>>>>>> device recovery is in progress or has already failed. Neither of the
>>>>>>> cases are well suited for power state transition of the device, since
>>>>>>> this can lead to unpredictable consequences like resume failure, or in
>>>>>>> worst case the device is lost because of it. Leave the device in its
>>>>>>> existing power state to avoid such issues.
>>>>>>>
>>>>>>> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
>>>>>>> ---
>>>>>>>
>>>>>>> v2: Synchronize AER handling with PCI PM (Rafael)
>>>>>>> v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
>>>>>>>       Elaborate "why" (Bjorn)
>>>>>>> v4: Rely on error status instead of device status
>>>>>>>       Condense comment (Lukas)
>>>>>> Since pci_aer_in_progress() is changed I've not included Rafael's tag with
>>>>>> my understanding of this needing a revisit. If this was a mistake, please
>>>>>> let me know.
>>>>>>
>>>>>> Denis, Mario, does this fix your issue?
>>>>>>
>>>>> Hello,
>>>>>
>>>>> Unfortunately no, I have prepared a dmesg but had to remove the bootup process because it was too long of a few kb: https://pastebin.com/1uBEA1FL
>>>>
>>>> Thanks for the test. It seems there's no hotplug event this time around
>>>> and endpoint device is still intact without any PCI related failure.
>>>>
>>>> Also,
>>>>
>>>> amdgpu 0000:09:00.0: PCI PM: Suspend power state: D3hot
>>>>
>>>> Which means whatever you're facing is either not related to this patch,
>>>> or at best exposed some nasty side-effect that's not handled correctly
>>>> by the driver.
>>>>
>>>> I'd say amdgpu folks would be of better help for your case.
>>>>
>>>> Raag
>>>
>>> So according to the logs Denis shared with v4
>>> (https://pastebin.com/1uBEA1FL) the GPU should have been going to BOCO. This
>>> stands for "Bus off Chip Off"
>>>
>>> amdgpu 0000:09:00.0: amdgpu: Using BOCO for runtime pm
>>>
>>> If it's going to D3hot - that's not going to be BOCO, it should be going to
>>> D3cold.
>>
>> Yes, because upstream port is in D0 for some reason (might be this patch
>> but not sure) and so will be the root port.
>>
>> pcieport 0000:07:00.0: PCI PM: Suspend power state: D0
>> pcieport 0000:07:00.0: PCI PM: Skipped
>>
>> and my best guess is the driver is not able to cope with the lack of D3cold.
>
> Yes; if the driver is configured to expect BOCO (D3cold) if it doesn't get it, chaos ensues.
>
> I guess let's double check the behavior with CONFIG_PCI_DEBUG to verify this patch is what is changing that upstream port behavior.


This is the very same exact kernel, minus the patch in question:  https://pastebin.com/rwMYgG7C


Both previous kernel and this one have CONFIG_PCI_DEBUG=y.

Removed the initial bootup sequence to be able to use pastebin.

>
>>
>> Raag
>>
>>> Denis, can you redo your logs with out Raag's patch patch and set
>>> CONFIG_PCI_DEBUG to compare?  The 6.14.6 log you shared already
>>> (https://pastebin.com/kLZtibcD) also chooses BOCO but I'm suspecting picks
>>> D3cold like it should.
>>>
>>>>
>>>>>>> More discussion on [1].
>>>>>>> [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
>>>>>>>
>>>>>>>    drivers/pci/pci.c      |  9 +++++++++
>>>>>>>    drivers/pci/pcie/aer.c | 13 +++++++++++++
>>>>>>>    include/linux/aer.h    |  2 ++
>>>>>>>    3 files changed, 24 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>>>>> index 4d7c9f64ea24..a20018692933 100644
>>>>>>> --- a/drivers/pci/pci.c
>>>>>>> +++ b/drivers/pci/pci.c
>>>>>>> @@ -9,6 +9,7 @@
>>>>>>>     */
>>>>>>>    #include <linux/acpi.h>
>>>>>>> +#include <linux/aer.h>
>>>>>>>    #include <linux/kernel.h>
>>>>>>>    #include <linux/delay.h>
>>>>>>>    #include <linux/dmi.h>
>>>>>>> @@ -1539,6 +1540,14 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
>>>>>>>           || (state == PCI_D2 && !dev->d2_support))
>>>>>>>            return -EIO;
>>>>>>> +    /*
>>>>>>> +     * If error status is set on an AER capable device, it is not well
>>>>>>> +     * suited for power state transition. Leave it in its existing power
>>>>>>> +     * state to avoid issues like unpredictable resume failure.
>>>>>>> +     */
>>>>>>> +    if (pci_aer_in_progress(dev))
>>>>>>> +        return -EIO;
>>>>>>> +
>>>>>>>        pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>>>>>>>        if (PCI_POSSIBLE_ERROR(pmcsr)) {
>>>>>>>            pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
>>>>>>> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
>>>>>>> index a1cf8c7ef628..617fbac0d38a 100644
>>>>>>> --- a/drivers/pci/pcie/aer.c
>>>>>>> +++ b/drivers/pci/pcie/aer.c
>>>>>>> @@ -237,6 +237,19 @@ int pcie_aer_is_native(struct pci_dev *dev)
>>>>>>>    }
>>>>>>>    EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
>>>>>>> +bool pci_aer_in_progress(struct pci_dev *dev)
>>>>>>> +{
>>>>>>> +    int aer = dev->aer_cap;
>>>>>>> +    u32 cor, uncor;
>>>>>>> +
>>>>>>> +    if (!pcie_aer_is_native(dev))
>>>>>>> +        return false;
>>>>>>> +
>>>>>>> +    pci_read_config_dword(dev, aer + PCI_ERR_COR_STATUS, &cor);
>>>>>>> +    pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &uncor);
>>>>>>> +    return cor || uncor;
>>>>>>> +}
>>>>>>> +
>>>>>>>    static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>>>>>>>    {
>>>>>>>        int rc;
>>>>>>> diff --git a/include/linux/aer.h b/include/linux/aer.h
>>>>>>> index 02940be66324..e6a380bb2e68 100644
>>>>>>> --- a/include/linux/aer.h
>>>>>>> +++ b/include/linux/aer.h
>>>>>>> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>>>>>>>    #if defined(CONFIG_PCIEAER)
>>>>>>>    int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>>>>>>>    int pcie_aer_is_native(struct pci_dev *dev);
>>>>>>> +bool pci_aer_in_progress(struct pci_dev *dev);
>>>>>>>    #else
>>>>>>>    static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>>>>>>>    {
>>>>>>>        return -EINVAL;
>>>>>>>    }
>>>>>>>    static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>>>>>>> +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
>>>>>>>    #endif
>>>>>>>    void pci_print_aer(struct pci_dev *dev, int aer_severity,
>>>>>>> -- 
>>>>>>> 2.34.1
>>>>>>>
>>>
>

