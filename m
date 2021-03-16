Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0349D33D586
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 15:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbhCPOKW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 10:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236008AbhCPOKI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Mar 2021 10:10:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FFC06174A;
        Tue, 16 Mar 2021 07:10:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id x13so7505349wrs.9;
        Tue, 16 Mar 2021 07:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Ym7C+v+G+nHYA0RKhBciTW1at/iqABpVo+V3RR3W7w=;
        b=Vyo+juz38tvRQTnW+gpQFSmoqWw9bgG3p09EYc69VfW9scY10FxVrehbA09dQNEYVI
         dSZ3YA9P2rnbpY82djmntu/4qBvY3ih24Q7SjDZ12PLwjIWxi2a9z2QZCYYi9IbsQ6sP
         8Qah34E7tU9MotFkJhBiX7KvKxfoLwzqqjQitOxFjPBn3tADFb1r4+2xLSzHMPZBVYZI
         Bc/enutC7eN1Y4J+BVPV3QdWYAPwQmTf2j9iQjyS9if5YDwoXS7xfHTZKZQuE4g2oOVn
         6y4FJ98hGBKHx/HxYwpbFOA+3uPaI2LBqYN+JiROsh9SE+JSQkeacBwlKZrF4Pw1OGwF
         Y73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Ym7C+v+G+nHYA0RKhBciTW1at/iqABpVo+V3RR3W7w=;
        b=d6jAc3X/FEOGca4TB526RJY+8maNwf1MmCM8buRDaxKSRjm6sz//Z+g+DmSt6FFxco
         Xug/EihEu8JGu+CUzyX/4SApdsaV1BJIJvgkeyGj+M3DNf80XHg2z0lYdPIAD0Q/CrAE
         wZgJyHSkZH0k10ebRHJ+E2zWb1tEgW3mHUSH1ZQjud5M6bmSg58OzhNHl0tRQr9SrXv2
         8QJkwh3vLCOWgJst7LmFy+TNfnG7+Kfr83gJphSm8Spl8JAPy1O378aNG2mXLaP4aysl
         kSGkOwbjwyx1A3ntDWpoSVeTKOLejr1cAFZuLNUMr3Ca9wiYXa9Bl6ISkN+Q5Fh2QEJc
         ef8Q==
X-Gm-Message-State: AOAM532qONpo5+CKndGSmim01/TxOywcXDG8YfMJLp8ImcPcqokcbsPI
        JycnO7OFP7Yeouc9no7Zdc2z8s7Ge1U=
X-Google-Smtp-Source: ABdhPJwJnTh6pU7UtZmhnYooD/dc7Thfe4HSGgzD6CTj7siYIVAY4ZabwQ4+i80UIWrtdgR7FjHKXg==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr5283025wrr.30.1615903806343;
        Tue, 16 Mar 2021 07:10:06 -0700 (PDT)
Received: from [192.168.2.202] (p5487b93a.dip0.t-ipconnect.de. [84.135.185.58])
        by smtp.gmail.com with ESMTPSA id o11sm22274687wrq.74.2021.03.16.07.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Mar 2021 07:10:05 -0700 (PDT)
Subject: Re: [PATCH v2] PCI: Run platform power transition on initial D0 entry
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210314000439.3138941-1-luzmaximilian@gmail.com>
 <CAJZ5v0hY=NgKAU+N_kaya=q3Vk6SnkRTfXuiiP0ttoxHq+pRTA@mail.gmail.com>
 <781f0963-4ce6-74c9-e884-1e57f1ff9673@gmail.com>
 <CAJZ5v0g+wkyzrD120yiyyBFjVO=LYS3j0WK1Fi-j+LS5fwgqZg@mail.gmail.com>
From:   Maximilian Luz <luzmaximilian@gmail.com>
Message-ID: <821c10e8-ef19-4d2e-5ea2-a1964ef58d67@gmail.com>
Date:   Tue, 16 Mar 2021 15:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g+wkyzrD120yiyyBFjVO=LYS3j0WK1Fi-j+LS5fwgqZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/16/21 2:36 PM, Rafael J. Wysocki wrote:
> On Mon, Mar 15, 2021 at 7:28 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>
>> On 3/15/21 4:34 PM, Rafael J. Wysocki wrote:
>>> On Sun, Mar 14, 2021 at 1:06 AM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>>>>
>>>> On some devices and platforms, the initial platform (e.g. ACPI) power
>>>> state is not in sync with the power state of the PCI device.
>>>>
>>>> This seems like it is, for all intents and purposes, an issue with the
>>>> device firmware (e.g. ACPI). On some devices, specifically Microsoft
>>>> Surface Books 2 and 3, we encounter ACPI code akin to the following
>>>> power resource, corresponding to a PCI device:
>>>>
>>>>       PowerResource (PRP5, 0x00, 0x0000)
>>>>       {
>>>>           // Initialized to zero, i.e. off. There is no logic for checking
>>>>           // the actual state dynamically.
>>>>           Name (_STA, Zero)
>>>>
>>>>           Method (_ON, 0, Serialized)
>>>>           {
>>>>               // ... code omitted ...
>>>>               _STA = One
>>>>           }
>>>>
>>>>           Method (_OFF, 0, Serialized)
>>>>           {
>>>>               // ... code omitted ...
>>>>               _STA = Zero
>>>>           }
>>>>       }
>>>>
>>>> This resource is initialized to 'off' and does not have any logic for
>>>> checking its actual state, i.e. the state of the corresponding PCI
>>>> device. The stored state of this resource can only be changed by running
>>>> the (platform/ACPI) power transition functions (i.e. _ON and _OFF).
>>>
>>> Well, there is _STA that returns "off" initially, so the OS should set
>>> the initial state of the device to D3cold and transition it into D0 as
>>> appropriate (i.e. starting with setting all of the power resources
>>> used by it to "on").
>>>
>>>> This means that, at boot, the PCI device power state is out of sync with
>>>> the power state of the corresponding ACPI resource.
>>>>
>>>> During initial bring-up of a PCI device, pci_enable_device_flags()
>>>> updates its PCI core state (from initially 'unknown') by reading from
>>>> its PCI_PM_CTRL register. It does, however, not check if the platform
>>>> (here ACPI) state is in sync with/valid for the actual device state and
>>>> needs updating.
>>>
>>> Well, that's inconsistent.
>>>
>>> Also, it is rather pointless to update the device's power state at
>>> this point, because nothing between this point and the later
>>> do_pci_enable_device() call in this function requires its
>>> current_state to be up to date AFAICS.
>>>
>>> Have you tried to drop the power state update from
>>> pci_enable_device_flags()?  [Note that we're talking about relatively
>>> old code here and it looks like that code is not necessary any more.]
>>
>> I had not tried this before, as I assumed the comment was still
>> relevant. I did test that now and it works! I can't detect any
>> regressions.
>>
>> Do you want to send this in or should I do that?
> 
> I'll post it, thanks!

Thank you!

Feel free to add my tested-by tag.

Regards,
Max
