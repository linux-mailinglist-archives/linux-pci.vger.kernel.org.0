Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3CC26824B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 03:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbgINBhP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 13 Sep 2020 21:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgINBhO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 13 Sep 2020 21:37:14 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F00C06174A;
        Sun, 13 Sep 2020 18:37:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nw23so20863274ejb.4;
        Sun, 13 Sep 2020 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CWbGez4tVYufRlwYoBuZ3LjrKpHnYT6iwOovAEwsAXI=;
        b=COoQvQkxwM6rEU//w5x37BVRYOCsafM3V9wyEXiCiKPiaKXguQsoL12Av7ZwZcjElw
         QpWsvQ0tVzvyb9ztSq+OQ/rAPci9CmjfOyncetH682moHuCS8fCcuFw8JzxJPM/Rw3Ov
         TOU62KWhY63vmSFZ8aDuu9jP+2oNnysJrIFmHylDQky50SJePsGP4TD4HN4Wt/A19eoY
         3u1GXNtSNvZJewc9XR5Gs/3838HkJURQu767YQGlnwJMOhPYVVhhaXN5gBMXy2nnIAGh
         0+Vk/AmNnfEXlfD7agD4TOVB1QglynD//dzX5pQTabAj9kkB/hd2xgwDj6iIZH4YYxf+
         4ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CWbGez4tVYufRlwYoBuZ3LjrKpHnYT6iwOovAEwsAXI=;
        b=GQTq/n/nLNzCR+7bvSD3Jfybd7h9EAC5raz5jLZA4tQnmBR6hnCKDNfAW2wcwYOeXK
         K2ws80LUjBwlO8xJOMmvNJsg2aoBZFcrKgUdlgPObwJzV3+HGtCm2FiEa5Q2VdSjHyGp
         ppViRKUG0kDQwmE9qr7qNcJBcAXNGhkFNOZ8uuMY3io98sqevLQ9bJeME5uo9seQg1S0
         dJEqNwwzAbDN8hPmLk748CSQraptwg7b0bsdDnIiD3jsGU9yhyzLG7yOLcw9C/bljCPF
         InTbKW7joNZCkxeed3P4xMXaRqtS7/JGiv16a1TM1tw+C/CFGKtFVzT1Dv2djY+OIRd+
         LymQ==
X-Gm-Message-State: AOAM531jx4+CiV8l4T/P45PgVgX8wZzHQfO+t8d70csqqcQULHo9+nSO
        oSxP6pBke6BLQaE+MwD91ZvV4b4ShpQ=
X-Google-Smtp-Source: ABdhPJwA1LhZ4Ym6S67OldylbalbxUiotoICTchYb4tZdhgL75IvQa7WfQiH5HMOvef8dTsaQRvIhg==
X-Received: by 2002:a17:906:7cb:: with SMTP id m11mr12756086ejc.41.1600047432029;
        Sun, 13 Sep 2020 18:37:12 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id l7sm6486462ejc.25.2020.09.13.18.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Sep 2020 18:37:11 -0700 (PDT)
From:   Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20200913172207.GA1194428@bjorn-Precision-5520>
Message-ID: <67f2451d-720d-1bd9-7628-6a9171f799d3@gmail.com>
Date:   Mon, 14 Sep 2020 03:36:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200913172207.GA1194428@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/13/20 7:22 PM, Bjorn Helgaas wrote:

[...]

>> The R-Car PCIe controller is capable of handling L0s/L1 link states.
>> While the controller can enter and exit L0s link state, and exit L1
>> link state, without any additional action from the driver, to enter
>> L1 link state, the driver must complete the link state transition by
>> issuing additional commands to the controller.
> 
> So IIUC an R-Car Root Port can't enter L1 without help from the
> driver?  That *sounds* like a hardware defect, since ASPM is supposed
> to be "hardware-autonomous" once configured.

The driver needs to complete the switch from L0 to L1 link state, yes.

>> The problem is, this transition is not atomic. The controller sets
>> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
>> the PCIe card, but then the controller enters some sort of inbetween
>> state. The driver must detect this condition and complete the link
>> state transition, by setting L1IATN bit in PMCTLR and waiting for
>> the link state transition to complete.
>>
>> If a PCIe access happens inside of this window, where the controller
>> is inbetween L0 and L1 link states, the access generates a fault and
>> the ARM 'imprecise external abort' handler is invoked.
> 
> Let me see if I understand this.
> 
>   1) Endpoint sends PM_ENTER_L1
>   2) R-Car Root Port receives PM_ENTER_L1, sets PMEL1RX
>   3) R-Car driver does something to complete transition to L1
> 
> And if the Endpoint driver does an MMIO access between 2) and 3), it
> causes an external abort?

Yes, because the link is in this inbetween state. So you need 3) to
complete that transition.

> I couldn't find anything in the R-Car driver today that completes the
> transition to L1.

That's because this patch adds it.

> And the MMIO access will immediately bring the link back to L0, won't
> it?

Yes

> Is there any benefit to L1 at all for this Root Port?  If it can't
> enter L1 and just stays in the in-between state until some event that
> will bring it *out* of L1, maybe we just need a quirk to stop
> advertising support for L1 in the first place.

Power saving I would say.

>> Just like other PCI controller drivers, here we hook the fault handler,
>> perform the fixup to help the controller enter L1 link state, and then
>> restart the instruction which triggered the fault. Since the controller
>> is in L1 link state now, the link can exit from L1 link state to L0 and
>> successfully complete the access.
>>
>> Note that this fixup is applicable only to Aarch32 R-Car controllers,
>> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit
>> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
> 
> TFA?  This doesn't seem to be an upstream Linux commit; can you give a
> more specific reference?

This is the Trusted Firmware from ARM, in this case it behaves similar
to ACPI. See e.g.:

https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
