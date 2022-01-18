Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9546492C9F
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 18:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiARRms (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 12:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiARRmr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 12:42:47 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F972C061574;
        Tue, 18 Jan 2022 09:42:47 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j2so1346951edj.8;
        Tue, 18 Jan 2022 09:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=LJBah5TPCtlSy6jUjVCMfbjWTRq/kIHwth+3ffSQM9w=;
        b=M64d84jfLOuPjH23oIkcjTmHvtt1BJhlWcY8UJCnToVw7+RPM28obIGMj8esOHK9XS
         8StkhoARotxfN7emdP/CGYbKzGnInlMBC/Ms/RWGerncY5DE1ZkzDHnNwyrYSPZLqn4f
         stAp3048XWvzkouCET1K9zAQ5XJBbFWAJLSbXPqZy8eTj4cBCGrDWidTsmGuVNBL/29T
         mSQ/V6f4P2AuvSCvj9kvr7VT2C6ndAANeLQjFltI2xH3cPhEsp0B6TDYx3xAnAkemqHH
         wBwO/VrlmT+8Vj+tpEPlfFLfGeb+4PXyGZvd6EJSFS9V6tHK2ObWtVPQ0+/R3XAaI7LD
         WG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=LJBah5TPCtlSy6jUjVCMfbjWTRq/kIHwth+3ffSQM9w=;
        b=nwi5gQtqVykKWQHMesYDJJRl87HNTZjKaBEjv6HVm5uQR5M3AXaiLa/ZqoEek1QE3T
         hvhqqsP8/npro0XqQff/+r/FEOFSVrLMyQzBSVPK7iSimhjlO2c7dNWaKiYKL9RzXOY9
         KwD2kI7szIZIqPElCMMN+mrMC/VFNelWlUc/q/wWuKUvWOxnuGNdYrlnpf6/JFGDlSLO
         cIMDzC0miMIlevFA4ClDIGmXuG4nYwpdQDvifSEj4rSWXQkMhooZyPOKOwf9DjzmSwtP
         f75XO2uxcscG/K1kQ+6uVCkp5i+UzVYftKOlhbP9MN5/QHCRcRWHgkEn/NWFBGNUNEte
         IeZw==
X-Gm-Message-State: AOAM533dAjrJwdZGpign20KO9tTEW7SOvBqh8xtGjDHGDP7zlhY2WwdA
        AdJam3OO+u3Egt7xxpEWWs+paCqY/0A=
X-Google-Smtp-Source: ABdhPJwS9TfHtPr84jSa1Tnmzq5lwn/653DR0pWm0CdiZFsENBlS62HQVaFWVaVMXhIrFdhxwMy3Jw==
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr20369259ejc.313.1642527765916;
        Tue, 18 Jan 2022 09:42:45 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2f:5b00:40:c8de:1522:b86f? (p200300ea8f2f5b000040c8de1522b86f.dip0.t-ipconnect.de. [2003:ea:8f2f:5b00:40:c8de:1522:b86f])
        by smtp.googlemail.com with ESMTPSA id z19sm161048edd.78.2022.01.18.09.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 09:42:45 -0800 (PST)
Message-ID: <46bbb2e4-4d51-990b-1ca4-f7fdfda9489d@gmail.com>
Date:   Tue, 18 Jan 2022 18:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <cadbd4eb-40bb-1fa8-1e00-dc95dab62295@gmail.com>
 <CAJZ5v0gH3xK3g01S0CLe235QTF6=A0EB+Zwuv50=WaJaRsCT+w@mail.gmail.com>
 <28e851d8-50cf-ee58-b340-1138a37990f6@gmail.com>
 <CAJZ5v0jKBSxHXf_N8BgtiOYnoxz9UUCZP8UwAHcFt_-6z4TozQ@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
In-Reply-To: <CAJZ5v0jKBSxHXf_N8BgtiOYnoxz9UUCZP8UwAHcFt_-6z4TozQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.01.2022 18:11, Rafael J. Wysocki wrote:
> On Tue, Jan 18, 2022 at 5:57 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 18.01.2022 17:28, Rafael J. Wysocki wrote:
>>> On Mon, Jan 17, 2022 at 11:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> Currently PCI core forbids RPM and requires opt-in from userspace,
>>>> apart from few drivers calling pm_runtime_allow(). Reason is that some
>>>> early ACPI PM implementations conflict with RPM, see [0].
>>>> Note that as of today pm_runtime_forbid() is also called for non-ACPI
>>>> systems. Maybe it's time to allow RPM per default for non-ACPI systems
>>>> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
>>>> was published in 2011.
>>>>
>>>> [0] https://lkml.org/lkml/2020/11/17/1548
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/pci/pci.c | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>>>> index 428afd459..26e3a500c 100644
>>>> --- a/drivers/pci/pci.c
>>>> +++ b/drivers/pci/pci.c
>>>> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
>>>>         u16 status;
>>>>         u16 pmc;
>>>>
>>>> -       pm_runtime_forbid(&dev->dev);
>>>> +#ifdef CONFIG_ACPI
>>>> +       /* Some early ACPI PM implementations conflict with RPM. */
>>>> +       if (acpi_gbl_FADT.header.revision > 0 &&
>>>> +           acpi_gbl_FADT.header.revision < 5)
>>>> +               pm_runtime_forbid(&dev->dev);
>>>> +#endif
>>>
>>> Well, there are two things here.
>>>
>>> First, there were systems in which ACPI PM was not ready for changing
>>> power states in the S0 system state (ie. run-time) and it was assuming
>>> that power states would only be changed during transitions to sleep
>>> states (S1 - S4) and to S5.  This can be covered by the ACPI revicion
>>> check, but I'm not sure if ACPI 5.0 is the right one.  Why ACPI 5 and
>>> not ACPI 6, for instance?
>>>
>> Just based on the assumption that ACPI 5.0 should be recent enough.
>> We can also go with ACPI 6.
> 
> I know that we can, the question is whether or not we should.
> 
> IOW, there needs to be at least some technical grounds on which to
> assume that a given ACPI release is safe enough.
> 
When ACPI 5 was published the workaround to disable RPM in general
was in place already. I'd assume that the majority of users does not
opt in for RPM, therefore it may be hard to find out whether any
system with ACPI 5 or ACPI 6 suffers from the same problem as the
affected old systems.

>>> Second, there were PCI devices without ACPI PM where the PCI standard
>>> PM didn't work correctly.  This is not related to ACPI at all and I'm
>>> not sure why the ACPI revision check would be sufficient to cover
>>> these cases.
>>>
>> Didn't know that there were such cases. Can you provide any examples or
>> links to reports about such misbehaving devices?
> 
> Admittedly, I don't have a list of them, so I would need to look them
> up and not just in the mailing lists.
> 
>>>>         pm_runtime_set_active(&dev->dev);
>>>>         pm_runtime_enable(&dev->dev);
>>>>         device_enable_async_suspend(&dev->dev);
>>>> --
> 
> Also note that this change will allow PM-runtime to be used on PCI
> devices without drivers by default and that may not be entirely safe
> either.  It didn't work really well in the past IIRC, so I'm wondering
> what's the reason to believe that it will work just fine this time.

>From "Documentation/power/pci.rst":
If a PCI driver implements the runtime PM callbacks and intends to use the
runtime PM framework provided by the PM core and the PCI subsystem, it needs
to decrement the device's runtime PM usage counter in its probe callback
function.  If it doesn't do that, the counter will always be different from
zero for the device and it will never be runtime-suspended.

Having said that I don't see how there can be a RPM-related problem w/o
the driver calling one of the RPM put functions. Maybe some of the problems
in the past were caused by PCI core bugs that have long been fixed.

To reduce the risk we could enable RPM for a certain subset of PCI devices
only in a first step, e.g. for PCIe devices.
