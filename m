Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E326C4F4
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 18:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgIPQOS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 12:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIPQEk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 12:04:40 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B8BC0073DD;
        Wed, 16 Sep 2020 06:52:13 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e23so10475938eja.3;
        Wed, 16 Sep 2020 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=knIMaMUCGrh0edGmjYkoyqXQYs65u/gq3+WHV7EF01I=;
        b=XwjKQCgR26K6dCKqDRqsruE6dmpYaMX+wfKn20Xf5URUuMBQLo/39Kt7rueD4szZa5
         oyVI7R6KQLYWd8WD/4pvkU7YDrfvkm9iXF2bSjcl/ZYqJgDIyGvdmR8Nuu7NUVXzBQ/V
         XLGk2BeV9MBDIK+aecspxpYEcZpdmkL3sFpBE4ygKFaCY2NLqbbhMo4i8W0/lw0ksUEe
         ytQWJDThVoGPPgZPx2nCYivw7cS6IltCHmB+tjlqm1fJqo3LHACpGVhnw3tO7MYr8CDb
         OV/G0kdDgJx77SZg9Nqeae93RwDeUm3+zR1eVjYMcYf8lB9ZVEMl+GNaGTyqqnf1y4nY
         /KwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=knIMaMUCGrh0edGmjYkoyqXQYs65u/gq3+WHV7EF01I=;
        b=HU1ADAvJOnEDl7aUvWUekvHrVbRYqTyEv2pqkdEg3u0nw8iQm27nqTn/JjklQwa5fI
         S9imAseRdoRhQSAfDVa3p4L2UCRMSiRFUwGZ5jZ9bH9RKIcpxTss1jhEgB4b2kC72ujG
         NcNwyDteAE1bWl/IV9IO27fbSpO6rbjKcxcMmzFlibkSATraPmh0Eq6WJr6JqX8PXxcV
         nFzqmpc62CqrZgjVrGmybOojn/Ldgjzo817zqFENVX006/WifQDX0MM7HNqo/9O2PkDC
         vmr5OJfXigJ5JTtEUryekxfQ9nkne8iNscylKUcpg88C1D09oO+G7/itjnaCkHuinHuV
         xagw==
X-Gm-Message-State: AOAM530l1ct45UrFCwjlYqdYCskkjSB9CF23wdAV1VMb/VPM9Yz9YK2E
        t27sXcTSxVCoUcZ4Rw+Wyeg1y2n2+VM=
X-Google-Smtp-Source: ABdhPJwxKq1iydP+/l4cyZ6LCbIUy0E6UMKWWIjNTqgh+Q9F9D8LJMDJeO0wOyMvBF7/QYKcF9tGsQ==
X-Received: by 2002:a17:907:64d:: with SMTP id wq13mr25000244ejb.513.1600264331665;
        Wed, 16 Sep 2020 06:52:11 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id h13sm13143005ejl.77.2020.09.16.06.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 06:52:10 -0700 (PDT)
Subject: Re: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20200914040140.GA1237003@bjorn-Precision-5520>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <22c5e9f0-5333-5b12-6f65-fac0fa2d5e37@gmail.com>
Date:   Wed, 16 Sep 2020 15:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914040140.GA1237003@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/14/20 6:01 AM, Bjorn Helgaas wrote:
> On Mon, Sep 14, 2020 at 03:36:08AM +0200, Marek Vasut wrote:
>> On 9/13/20 7:22 PM, Bjorn Helgaas wrote:
>>
>> [...]
>>
>>>> The R-Car PCIe controller is capable of handling L0s/L1 link states.
>>>> While the controller can enter and exit L0s link state, and exit L1
>>>> link state, without any additional action from the driver, to enter
>>>> L1 link state, the driver must complete the link state transition by
>>>> issuing additional commands to the controller.
>>>
>>> So IIUC an R-Car Root Port can't enter L1 without help from the
>>> driver?  That *sounds* like a hardware defect, since ASPM is supposed
>>> to be "hardware-autonomous" once configured.
>>
>> The driver needs to complete the switch from L0 to L1 link state, yes.
>>
>>>> The problem is, this transition is not atomic. The controller sets
>>>> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
>>>> the PCIe card, but then the controller enters some sort of inbetween
>>>> state. The driver must detect this condition and complete the link
>>>> state transition, by setting L1IATN bit in PMCTLR and waiting for
>>>> the link state transition to complete.
>>>>
>>>> If a PCIe access happens inside of this window, where the controller
>>>> is inbetween L0 and L1 link states, the access generates a fault and
>>>> the ARM 'imprecise external abort' handler is invoked.
>>>
>>> Let me see if I understand this.
>>>
>>>   1) Endpoint sends PM_ENTER_L1
>>>   2) R-Car Root Port receives PM_ENTER_L1, sets PMEL1RX
>>>   3) R-Car driver does something to complete transition to L1
>>>
>>> And if the Endpoint driver does an MMIO access between 2) and 3), it
>>> causes an external abort?
>>
>> Yes, because the link is in this inbetween state. So you need 3) to
>> complete that transition.
>>
>>> I couldn't find anything in the R-Car driver today that completes the
>>> transition to L1.
>>
>> That's because this patch adds it.
> 
> So with this patch, we finish the transition to L1 and immediately
> return to L0.  That must mean that even in this in-between state we
> save some power?

Yes, that's how I understand it from the datasheet.

> And the link may stay in that in-between state indefinitely, until the
> CPU does an MMIO access or the device initiates a DMA?  But it will
> never spend any time in L1 because the link never actually *gets* to
> L1 until some event that will take it back to L0 occurs?

It is in power saving mode as far as I can tell. It only needs this
extra bump to get fully in L1 and then back to L0.

>>> And the MMIO access will immediately bring the link back to L0, won't
>>> it?
>>
>> Yes
>>
>>> Is there any benefit to L1 at all for this Root Port?  If it can't
>>> enter L1 and just stays in the in-between state until some event that
>>> will bring it *out* of L1, maybe we just need a quirk to stop
>>> advertising support for L1 in the first place.
>>
>> Power saving I would say.
>>
>>>> Just like other PCI controller drivers, here we hook the fault handler,
>>>> perform the fixup to help the controller enter L1 link state, and then
>>>> restart the instruction which triggered the fault. Since the controller
>>>> is in L1 link state now, the link can exit from L1 link state to L0 and
>>>> successfully complete the access.
>>>>
>>>> Note that this fixup is applicable only to Aarch32 R-Car controllers,
>>>> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
>>>> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
>>>
>>> TFA?  This doesn't seem to be an upstream Linux commit; can you give a
>>> more specific reference?
>>
>> This is the Trusted Firmware from ARM, in this case it behaves similar
>> to ACPI. See e.g.:
>>
>> https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
> 
> Thanks for that; please include it in the commit log for the next
> version.

OK
