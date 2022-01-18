Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BACF492BB5
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jan 2022 17:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346609AbiARQ5H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jan 2022 11:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346692AbiARQ5A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jan 2022 11:57:00 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5FDC061746;
        Tue, 18 Jan 2022 08:57:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q9-20020a7bce89000000b00349e697f2fbso7452424wmj.0;
        Tue, 18 Jan 2022 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=3K/95Tr7NFfXY766OIyHEJtN60jqTqQwOTYglwJ5IRE=;
        b=iQyqpUlT1sO/rgjA4N/jf6Q5Mz5ON3C8YQANxqo1PZsEMHk5tIZ7ZBND54wpeJPPlg
         WXbAbQzSrmXLBoyW3bX7GlmlPA9+v7SxrE1XeNj7w+yDzxnNHUtP22QlLvkv+b+uSpo1
         RQIB5pS0n+Alt8LdLgJru9yEwuvYcpmamKNeU02R/cWTAY1SMwiq3/Lh2Hq0H+KH/Q8J
         7UvPw2yhzx3MRkcc4vpxK7Pf6UsFTgn9jXUlG+3uIaYC5sZKPO/BfMXFVZajri6oE/Nu
         QLcz5KQS0kzBvwrSh32T37m54ztzDxrQiySAUGyWun0zwXjFcN07hFghgtNc4329dSAg
         M3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=3K/95Tr7NFfXY766OIyHEJtN60jqTqQwOTYglwJ5IRE=;
        b=zwLSzAlRyS2VzdAwk+b569S1Mxu9tKNi1dfMSbAV/v19pi9oZZNg7FqovTpAMwoefQ
         E+Kkj63QrAjY2X4U7J/Dqs1jGlkCDDfOw9Y/9j8oE1bH3D43nadie8ybCdX6tFcYopQf
         EBrLxJlWFqfVOctWs9hDKdyvX5zbMI8daOu2ZKBKurY40hRfZPIaWsD9AHeSmf0Qlg8q
         DXHZqh3w5eyNNiNuHqh2OpNuG9FRK7ndyVX+kAdtIxCBGrX5IGqL+kXF+M94CfJZaN5P
         3ybX1sfJDNbNYMkHKjEQ9oz+qAVlKcQ3JJpcIDxZTVoWGImprZcWQ+dueYgtE6CrOUHr
         dinw==
X-Gm-Message-State: AOAM531eMa7lhIvQU10HADqRkJm7RB9MNrIiMnq1PLYSyrCLL4EmQrUQ
        LFL5CSdlv7GwOKmiFg1cKdI=
X-Google-Smtp-Source: ABdhPJy995IKAvSVhk9rS9t/RLh5b3PukUiSgvG2qY5fO9GmbISzCHO/vG4KvBUASt9ub8Vo4yoDVQ==
X-Received: by 2002:adf:9d8f:: with SMTP id p15mr3110419wre.156.1642525018692;
        Tue, 18 Jan 2022 08:56:58 -0800 (PST)
Received: from ?IPV6:2003:ea:8f2f:5b00:40:c8de:1522:b86f? (p200300ea8f2f5b000040c8de1522b86f.dip0.t-ipconnect.de. [2003:ea:8f2f:5b00:40:c8de:1522:b86f])
        by smtp.googlemail.com with ESMTPSA id a6sm16782576wrq.22.2022.01.18.08.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:56:58 -0800 (PST)
Message-ID: <28e851d8-50cf-ee58-b340-1138a37990f6@gmail.com>
Date:   Tue, 18 Jan 2022 17:56:54 +0100
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH] PCI: Forbid RPM on ACPI systems before 5.0 only
In-Reply-To: <CAJZ5v0gH3xK3g01S0CLe235QTF6=A0EB+Zwuv50=WaJaRsCT+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 18.01.2022 17:28, Rafael J. Wysocki wrote:
> On Mon, Jan 17, 2022 at 11:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Currently PCI core forbids RPM and requires opt-in from userspace,
>> apart from few drivers calling pm_runtime_allow(). Reason is that some
>> early ACPI PM implementations conflict with RPM, see [0].
>> Note that as of today pm_runtime_forbid() is also called for non-ACPI
>> systems. Maybe it's time to allow RPM per default for non-ACPI systems
>> and recent enough ACPI versions. Let's allow RPM from ACPI 5.0 which
>> was published in 2011.
>>
>> [0] https://lkml.org/lkml/2020/11/17/1548
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/pci/pci.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 428afd459..26e3a500c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3101,7 +3101,12 @@ void pci_pm_init(struct pci_dev *dev)
>>         u16 status;
>>         u16 pmc;
>>
>> -       pm_runtime_forbid(&dev->dev);
>> +#ifdef CONFIG_ACPI
>> +       /* Some early ACPI PM implementations conflict with RPM. */
>> +       if (acpi_gbl_FADT.header.revision > 0 &&
>> +           acpi_gbl_FADT.header.revision < 5)
>> +               pm_runtime_forbid(&dev->dev);
>> +#endif
> 
> Well, there are two things here.
> 
> First, there were systems in which ACPI PM was not ready for changing
> power states in the S0 system state (ie. run-time) and it was assuming
> that power states would only be changed during transitions to sleep
> states (S1 - S4) and to S5.  This can be covered by the ACPI revicion
> check, but I'm not sure if ACPI 5.0 is the right one.  Why ACPI 5 and
> not ACPI 6, for instance?
> 
Just based on the assumption that ACPI 5.0 should be recent enough.
We can also go with ACPI 6.

> Second, there were PCI devices without ACPI PM where the PCI standard
> PM didn't work correctly.  This is not related to ACPI at all and I'm
> not sure why the ACPI revision check would be sufficient to cover
> these cases.
> 
Didn't know that there were such cases. Can you provide any examples or
links to reports about such misbehaving devices?

>>         pm_runtime_set_active(&dev->dev);
>>         pm_runtime_enable(&dev->dev);
>>         device_enable_async_suspend(&dev->dev);
>> --
>> 2.34.1
>>

