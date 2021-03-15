Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB633C5A4
	for <lists+linux-pci@lfdr.de>; Mon, 15 Mar 2021 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhCOS2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Mar 2021 14:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbhCOS2U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Mar 2021 14:28:20 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF98C06174A;
        Mon, 15 Mar 2021 11:28:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id p8so67935877ejb.10;
        Mon, 15 Mar 2021 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sWH8WDgGlaNtTmRGXREl8G3caLX0Z/BKwZJMmT4Npt8=;
        b=SOyZiIs4cssntaov+S0QFOm1CYOv7efw1R6VQZ/H7W4CGNmuV+4ofIrqKSRoBvjQJv
         YBcVZdPKGbbXZ/Bd4M2c1JoohRnI8sn4G3rGbR+Z5NIQb9DAnqgaEk7IqYOdkf7V56pg
         Ld6MARS1dVjgPTFf8VfGwMTvzh2mX2XeUJfhJu6kHspqNv+ocG9NCByRroDhmjhncxdu
         EVeAE3CWymnBTliV0xLkF12mKTeyCqK5T7NVcyKrNPJ+I8i8Uoe7ohuq8d4RaeusbvzP
         8t/O4hDb/TxRPdy0lK0aOqZfQmt/R2CxXIwCiAzxirvTRa6K+nGMVwjQjLJsUX5v/ubX
         ZO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWH8WDgGlaNtTmRGXREl8G3caLX0Z/BKwZJMmT4Npt8=;
        b=GJnRvxfoF0AWY7mJmumY4WYn57xuc9ocDZa3DHNMJtolGYlY92wC7ukh/KZ85ZwOES
         WFdvfzSi4T0kgGSQGKwRgHfV2xM8Ryy9U5cRLEhydXTh2utiBKk635bb7AgB11LbaeFR
         TjQBhoUpIjg7uKgggE4CfA0jeYLWPaT7QgD4KADbR+LQ9zRbt9RaSSwKalwgY9nMqgp1
         lzscJ3caOl3zg6klVvXPRfR5r3jKhogeH/NjSR9V0NXRa9TdLRT0Li3GV4J12d0522OP
         vUV4dbj6dmOACJOu7ICSuUgvMvCY/RQcZDX2Xhwuej7u7DusSzozlMJZJsL8+XGwWHVX
         qkuA==
X-Gm-Message-State: AOAM531IVY0V6ymx/CZD2/BfV1aaTbBI2bmZPkT4QkvyqlcaHL5cbatk
        WYSjGKaHwb4RIekHBkKlBZfdVYFgUlwVLA==
X-Google-Smtp-Source: ABdhPJwdiAjGStmqehcnj69o5tip/LQIH5t0xGu6+rOCIsJ/G5rIDbb5JpG8uBOJK79qsFhZ438C2g==
X-Received: by 2002:a17:906:a8a:: with SMTP id y10mr25969284ejf.288.1615832898235;
        Mon, 15 Mar 2021 11:28:18 -0700 (PDT)
Received: from [10.16.0.11] ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id o6sm8719202edw.24.2021.03.15.11.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 11:28:17 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: Run platform power transition on initial D0 entry
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210314000439.3138941-1-luzmaximilian@gmail.com>
 <CAJZ5v0hY=NgKAU+N_kaya=q3Vk6SnkRTfXuiiP0ttoxHq+pRTA@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <781f0963-4ce6-74c9-e884-1e57f1ff9673@gmail.com>
Date:   Mon, 15 Mar 2021 19:28:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hY=NgKAU+N_kaya=q3Vk6SnkRTfXuiiP0ttoxHq+pRTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/15/21 4:34 PM, Rafael J. Wysocki wrote:
> On Sun, Mar 14, 2021 at 1:06 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> On some devices and platforms, the initial platform (e.g. ACPI) power
>> state is not in sync with the power state of the PCI device.
>>
>> This seems like it is, for all intents and purposes, an issue with the
>> device firmware (e.g. ACPI). On some devices, specifically Microsoft
>> Surface Books 2 and 3, we encounter ACPI code akin to the following
>> power resource, corresponding to a PCI device:
>>
>>      PowerResource (PRP5, 0x00, 0x0000)
>>      {
>>          // Initialized to zero, i.e. off. There is no logic for checking
>>          // the actual state dynamically.
>>          Name (_STA, Zero)
>>
>>          Method (_ON, 0, Serialized)
>>          {
>>              // ... code omitted ...
>>              _STA = One
>>          }
>>
>>          Method (_OFF, 0, Serialized)
>>          {
>>              // ... code omitted ...
>>              _STA = Zero
>>          }
>>      }
>>
>> This resource is initialized to 'off' and does not have any logic for
>> checking its actual state, i.e. the state of the corresponding PCI
>> device. The stored state of this resource can only be changed by running
>> the (platform/ACPI) power transition functions (i.e. _ON and _OFF).
> 
> Well, there is _STA that returns "off" initially, so the OS should set
> the initial state of the device to D3cold and transition it into D0 as
> appropriate (i.e. starting with setting all of the power resources
> used by it to "on").
> 
>> This means that, at boot, the PCI device power state is out of sync with
>> the power state of the corresponding ACPI resource.
>>
>> During initial bring-up of a PCI device, pci_enable_device_flags()
>> updates its PCI core state (from initially 'unknown') by reading from
>> its PCI_PM_CTRL register. It does, however, not check if the platform
>> (here ACPI) state is in sync with/valid for the actual device state and
>> needs updating.
> 
> Well, that's inconsistent.
> 
> Also, it is rather pointless to update the device's power state at
> this point, because nothing between this point and the later
> do_pci_enable_device() call in this function requires its
> current_state to be up to date AFAICS.
> 
> Have you tried to drop the power state update from
> pci_enable_device_flags()?  [Note that we're talking about relatively
> old code here and it looks like that code is not necessary any more.]

I had not tried this before, as I assumed the comment was still
relevant. I did test that now and it works! I can't detect any
regressions.

Do you want to send this in or should I do that?

> Either it should be possible to do that and all should work, or there
> is a good reason to make current_state reflect the real current power
> state of the device upfront, but then that should be done by putting
> it into D0 diractly at that point rather than later.
> 
> Calling pci_power_up(dev) instead of pci_set_power_state(dev, PCI_D0)
> when current_state is already 0 only pokes at the power resources,
> because pci_raw_set_power_state() will do nothing then, but that is a
> rather less-than-straightforward way of doing this.  Moreover, the
> ordering of actions mandated by the spec is to set power resources to
> "on" first and then write to the PMCSR, not the other way around.

I don't know much about the PCI core (let alone spec), so that seemed
like the least intrusive way to fix this for me.

Thanks!
Max
