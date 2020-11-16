Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0FF2B5445
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 23:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgKPW0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 17:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbgKPW0C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 17:26:02 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840B5C0613CF
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2020 14:26:00 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id t142so4273110oot.7
        for <linux-pci@vger.kernel.org>; Mon, 16 Nov 2020 14:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O3Ee3hL72yJwbvWCP8NEYwOfyvlcB4Y3Qu03tpTswGY=;
        b=gZhiRwcUab2c/M9JJ8zoV9RT8tGZSTmM1sQzPL9keb6fxT/k+cKOmmnJg0LFfNggbA
         nAXWC2hz2dDZXennIofCvTTS8wvjJzuod/n7B7/12qmwKrF7ak//izNb5OV6CDnmCx3t
         J65eCX4klbD3y22bn5svMvemvHEhQe5nSV3lyJQd1Ws1jBWN1+SA8Qe0+EbNgyyhnjGr
         2b6N0DLVfqfuDC27gQTI5vq7iK6eNW8UGdfmHBOUh2GW5OLPt71r/9+18Kip9W67xNRa
         yZxMzDynyyRcv6K2VfAl9cBB1mvcu2KnCnyo4+co43y2gsNNjm2/g4cEuTNF8PhQayUD
         B0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O3Ee3hL72yJwbvWCP8NEYwOfyvlcB4Y3Qu03tpTswGY=;
        b=bQ1dt+k8d/u3cZTuznK0mR1ajw+aySSyZh+x15JUgTkwV+qViyZu1gZgFPApDsDJrD
         /am+/BLD9k1iyj/WJrt+t+a5znR6LKwrAhhveCcyXOeDuXppQVIoPoUtfFJKzy7XPy2h
         fuvHhCAuawzaoerStdM9eNqUlpWYblIYbfFb4Wc+uzHi9GOEfec5+wOW5v0vU2+2vxG7
         2ylcNwCP93FmLo/Am6AVOKsRoCcnZsE1flj7pQ5042TkaeA3wU+9XteHTKHb5S6H2aTI
         WiphQ4jZrvGVtbf28vQ1ezQ3x35kjaEhaNS4xpMIUFgti7CKsfwEJQoi1pSyNnAMpA3l
         09lA==
X-Gm-Message-State: AOAM532bLjxe5MkOSgtdHb48r/DNuPFHcBSTGaSvA4UFRSuFZnupcI0v
        DYA9mUW1DIHzHBwXyNzVrZQ=
X-Google-Smtp-Source: ABdhPJx349osT37terNKIowtwIG+3xtBGqionX+NWBrWEQfc3RzkFTXNBc9Rcb7YKegQLss+K8+aPA==
X-Received: by 2002:a4a:c018:: with SMTP id v24mr1106973oop.2.1605565559713;
        Mon, 16 Nov 2020 14:25:59 -0800 (PST)
Received: from [100.71.96.87] ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id w14sm5324840oou.16.2020.11.16.14.25.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2020 14:25:58 -0800 (PST)
Subject: Re: [PATCH v2] Expose PCIe SSD Status LED Management DSM in sysfs
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20201110153735.58587-1-stuart.w.hayes@gmail.com>
 <20201113213842.GA1135242@bjorn-Precision-5520> <X68Ub0rSmUlrRXkm@kroah.com>
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <371228ef-7b31-0c70-c9a4-a0f0082da920@gmail.com>
Date:   Mon, 16 Nov 2020 16:25:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <X68Ub0rSmUlrRXkm@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 11/13/20 5:19 PM, Greg Kroah-Hartman wrote:
> On Fri, Nov 13, 2020 at 03:38:42PM -0600, Bjorn Helgaas wrote:
>> [+cc Christoph, Dan, Greg (for "one value per file" question below)]
>>
>> On Tue, Nov 10, 2020 at 09:37:35AM -0600, Stuart Hayes wrote:
>>> This patch will expose the PCIe SSD Status LED Management interface in
>>> sysfs for devices that have the relevant _DSM method, per the "_DSM
>>> additions for PCIe SSD Status LED Management" ECN to the PCI Firmware
>>> Specification revision 3.2.
>>>
>>> The interface is exposed in two sysfs files, ssdleds_supported_states (RO)
>>> and ssdleds_current_state (RW).
>>>
>>> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
>>> ---
>>>
>>> v2: made PCI_SSDLEDS dependent on PCI and ACPI
>>>     remove unused variable
>>>     warn if call to sysfs_create_group fails
>>>     include header file with function prototypes
>>>     change logical OR to bitwise
>>>
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-pci |  14 ++
>>>  drivers/pci/Kconfig                     |   7 +
>>>  drivers/pci/Makefile                    |   1 +
>>>  drivers/pci/pci-ssdleds.c               | 194 ++++++++++++++++++++++++
>>>  drivers/pci/pci-sysfs.c                 |   1 +
>>>  drivers/pci/pci.h                       |  11 ++
>>>  6 files changed, 228 insertions(+)
>>>  create mode 100644 drivers/pci/pci-ssdleds.c
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>>> index 77ad9ec3c801..18ca73b764ac 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>>> @@ -366,3 +366,17 @@ Contact:	Heiner Kallweit <hkallweit1@gmail.com>
>>>  Description:	If ASPM is supported for an endpoint, these files can be
>>>  		used to disable or enable the individual power management
>>>  		states. Write y/1/on to enable, n/0/off to disable.
>>> +
>>> +What:		/sys/bus/pci/devices/.../ssdleds_supported_states
>>> +Date:		October 2020
>>> +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
>>> +Description:	If the device supports the ACPI _DSM method to control the
>>> +		PCIe SSD LED states, ssdleds_supported_states (read only)
>>> +		will show the LED states that are supported by the _DSM.
>>> +
>>> +What:		/sys/bus/pci/devices/.../ssdleds_current_state
>>> +Date:		October 2020
>>> +Contact:	Stuart Hayes <stuart.w.hayes@gmail.com>
>>> +Description:	If the device supports the ACPI _DSM method to control the
>>> +		PCIe SSD LED states, ssdleds_current_state will show or set
>>> +		the current LED states that are active.
>>> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
>>> index 0c473d75e625..48049866145f 100644
>>> --- a/drivers/pci/Kconfig
>>> +++ b/drivers/pci/Kconfig
>>> @@ -182,6 +182,13 @@ config PCI_LABEL
>>>  	def_bool y if (DMI || ACPI)
>>>  	select NLS
>>>  
>>> +config PCI_SSDLEDS
>>> +	def_bool y if (ACPI && PCI)
> 
> That only should be set if the machine can not boot without it.
> 
> For a blinky light, that's not the case.
> 
> And why isn't this code using the existing LED subsystem?  Don't create
> random new driver-specific sysfs files that do things the existing class
> drivers do please.
>

I did consider the LED subsystem, but I don't think it is a great match.

In spite of the name, this _DSM doesn't directly control individual LEDs--it
sets the state(s) of the PCI port to which an SSD may be connected, so that
it may be conveyed to the user... a processor (or at least some logic) will
decide how to show which states are active, probably by setting combinations
of LEDs to certain colors or blink patterns, or possibly on some other type
of display.  On the system I have, changing the active state(s) sends a
message via IPMI to an embedded processor, which will decide the colors
and/or flashing pattern of the LEDs.  So brightness/color/blinking are not
controlled, or even known, by the OS.

Also, not all of the states will necessarily always be available.  For
example, you may only be able to set the "rebuild" state when a drive is
actually connected to the pci port that has this _DSM, while the "locate"
state might be available all the time.  Since there's no notification
if/when the supported states change, I believe that would mean, to implement
this using the LED subsystem, the driver would have to register an "LED"
with the LED subsystem for each possible state, and either make reads or
writes to that state fail if it isn't supported.

But I will re-write this using the LED subsystem if you think it's a better
fit (though I don't think so).

> 
>>> +static int ssdleds_dsm_get(struct device *dev, char *buf, u64 dsm_func)
>>> +{
>>> +	acpi_handle handle;
>>> +	union acpi_object *out_obj;
>>> +	struct pci_ssdleds_dsm_output *dsm_output;
>>> +
>>> +	handle = ACPI_HANDLE(dev);
>>> +	if (!handle)
>>> +		return -ENODEV;
>>> +
>>> +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_ssdleds_dsm_guid, 0x1,
>>> +				      dsm_func, NULL, ACPI_TYPE_BUFFER);
>>> +	if (!out_obj)
>>> +		return -EIO;
>>> +
>>> +	if (out_obj->buffer.length < 8) {
>>> +		ACPI_FREE(out_obj);
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	dsm_output = (struct pci_ssdleds_dsm_output *)out_obj->buffer.pointer;
>>> +	if (dsm_output->status != 0) {
>>> +		ACPI_FREE(out_obj);
>>> +		return -EIO;
>>> +	}
>>> +
>>> +	scnprintf(buf, PAGE_SIZE, "%#x\n", dsm_output->state);
>>
>> Similarly, I would consider returning dsm_output->state and moving the
>> scnprintf() so the sysfs-specific stuff is in the caller.
>>
>> It looks like you just expose the hex value that encodes things like:
>>
>>   OK
>>   Locate
>>   Fail
>>   Rebuild
>>   ...
>>
>> The hex value is sort of a pain to interpret, especially since the PCI
>> specs are not public.  Maybe consider decoding it?  If you did decode
>> it, that might be a way to reduce this to a single file instead of
>> having both "supported_states" and "current_state" -- the single file
>> could list all the supported states, with the current states
>> highlighted somehow.
>>
>> Not sure if that would run afoul of the sysfs "one value per file"
>> rule.  CC'd Greg in case he wants to chime in.
> 
> That's a valid way of displaying options for a sysfs file that can
> be specific unique values.
> 

Thanks--I used hex to keep it a single value.

I'll try to find a way to highlight the current states as suggested so I can
keep this to a single file.

> 
>>> +static struct device_attribute ssdleds_attr_current = {
>>> +	.attr = {.name = "ssdleds_current_state", .mode = 0644},
>>> +	.show = ssdleds_current_show,
>>> +	.store = ssdleds_current_store,
>>> +};
>>
>> Can these use DEVICE_ATTR_RW() and friends?
> 
> They should, never open-code something like this.
> 
>>
>>> +static struct device_attribute ssdleds_attr_supported = {
>>> +	.attr = {.name = "ssdleds_supported_states", .mode = 0444},
>>> +	.show = ssdleds_supported_show,
>>> +};
> 
> DEVICE_ATTR_RO();
> 
>>> +
>>> +static struct attribute *ssdleds_attributes[] = {
>>> +	&ssdleds_attr_current.attr,
>>> +	&ssdleds_attr_supported.attr,
>>> +	NULL,
>>> +};
>>> +
>>> +static const struct attribute_group ssdleds_attr_group = {
>>> +	.attrs = ssdleds_attributes,
>>> +	.is_visible = ssdleds_attr_visible,
>>> +};
> 
> ATTRIBUTE_GROUPS()?
> 
>>> +void pci_create_ssdleds_files(struct pci_dev *pdev)
>>> +{
>>> +	if (sysfs_create_group(&pdev->dev.kobj, &ssdleds_attr_group))
>>> +		pci_warn(pdev, "Unable to create ssdleds attributes\n");
> 
> You just raced userspace and lost.  Just add this to the default groups
> for the device and the core will handle it all for you automatically.
> 
> Hint, when you find yourself calling a sysfs_*() call from driver code,
> that's a huge flag that you are doing something wrong.
> 
>>> +void pci_remove_ssdleds_files(struct pci_dev *pdev)
>>> +{
>>> +	sysfs_remove_group(&pdev->dev.kobj, &ssdleds_attr_group);
>>> +}
>>
>> I'm not a real sysfs expert, but I *think* that if you follow the
>> pattern in pci_dev_attr_groups[] in pci-sysfs.c, you won't need these
>> create/remove functions.
> 
> Yes, that is true.
> 
> thanks,
> 
> greg k-h
> 

I will try to incorporate the remainder of the feedback, thanks for taking
time to look a this.
