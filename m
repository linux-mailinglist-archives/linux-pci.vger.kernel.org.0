Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9243D7BDF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhG0RJO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jul 2021 13:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhG0RJN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jul 2021 13:09:13 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F04C061757;
        Tue, 27 Jul 2021 10:09:12 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id e19so23156297ejs.9;
        Tue, 27 Jul 2021 10:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u6wMsy8+y8oQrtqNJJtbV1/vSxSFUv+XxeMD016+Vw0=;
        b=IoLhVfnPP71L5X+lowoj4eQjg7VxjSMdb4NupC1xLD49iATF3NfmzVPUSIN7J1xi5a
         nEAPqPJHiPXBvyVHfku0mWpQ8847aRQLbs7NG0CHLoHqM6bhEa2GDGPVa42iP+gUFTIh
         04st3PRftfIF+fEVqOd4/U/T/7FppvqRyU+zLfW+XzsVp/WWRQt83Fz2BEtC0KcILO0o
         MzzhCe4Im2xcaStWiLkhzI0J5LdUGfrcM5A/XJOw7zHMTDERkxEdDqmIQ3jTw1v71Ffu
         sgB2CALLX8ta6t64Zw9GOlf9jalTrIQstpHO2A0QwCwsThSdLhruDGXwvI5FLNP7yy1r
         fg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6wMsy8+y8oQrtqNJJtbV1/vSxSFUv+XxeMD016+Vw0=;
        b=bhkTbOTileZWZEnEeKsEolCfHfH4HYcBMHsLFyBEnNYaohKlWsA9vE18ODoQvH7GPT
         +mfYlwDk6MvE6JzCM+vje2uDgdUFQrjZRvrZrmsTSG26wq92mB/PWKMMQOmWW1bigbOc
         Zj53zG3AHjOqXKZq1DViiU/omIoiPj8ASSrq0zHsNXvL4nt+dWIYNPmhuQmgEoMcK+n2
         VJzxwtdMjz2jDpA2bkOw1MMHNNhDiV16+bEsRGyQA5fxH0ArD78mrobkNtoQjLRdhm5I
         JdtgFch78+I6a/A2v+X82aP/czzlQnQzUcgjJSw9VJcOTn0MOy4uoQ5iFOGNSBlI7f8j
         rOjw==
X-Gm-Message-State: AOAM5336o2MdZ6eWK1uujjyU8Xw8tZECM3DZUcsv83eq7QaqKpjQCH1I
        hIw5KTd1214WEg0lLd1BiAujfhgNW9Y=
X-Google-Smtp-Source: ABdhPJz3LMJ3OyOT/s3HqviWh0gvPjrsrZQYi0NyweiOFXLp78tL1CF+bTVqLUqzScJEPVS39ue+LQ==
X-Received: by 2002:a17:906:8602:: with SMTP id o2mr5090290ejx.162.1627405751337;
        Tue, 27 Jul 2021 10:09:11 -0700 (PDT)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id d19sm1431558eds.54.2021.07.27.10.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 10:09:10 -0700 (PDT)
Subject: Re: [PATCH V6] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20210726174925.GA624246@bjorn-Precision-5520>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <88b82ef7-3e6e-fd3c-4d18-d497f7c1998c@gmail.com>
Date:   Tue, 27 Jul 2021 19:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210726174925.GA624246@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/26/21 7:49 PM, Bjorn Helgaas wrote:
> On Mon, Jul 26, 2021 at 04:47:54PM +0200, Geert Uytterhoeven wrote:
[...]
>>>> The R-Car PCIe controller is capable of handling L0s/L1 link states.
>>>> While the controller can enter and exit L0s link state, and exit L1
>>>> link state, without any additional action from the driver, to enter
>>>> L1 link state, the driver must complete the link state transition by
>>>> issuing additional commands to the controller.
>>>>
>>>> The problem is, this transition is not atomic. The controller sets
>>>> PMEL1RX bit in PMSR register upon reception of PM_ENTER_L1 DLLP from
>>>> the PCIe card, but then the controller enters some sort of inbetween
>>>> state. The driver must detect this condition and complete the link
>>>> state transition, by setting L1IATN bit in PMCTLR and waiting for
>>>> the link state transition to complete.
>>>>
>>>> If a PCIe access happens inside this window, where the controller
>>>> is between L0 and L1 link states, the access generates a fault and
>>>> the ARM 'imprecise external abort' handler is invoked.
>>>>
>>>> Just like other PCI controller drivers, here we hook the fault handler,
>>>> perform the fixup to help the controller enter L1 link state, and then
>>>> restart the instruction which triggered the fault. Since the controller
>>>> is in L1 link state now, the link can exit from L1 link state to L0 and
>>>> successfully complete the access.
>>>>
>>>> While it was suggested to disable L1 link state support completely on
>>>> the controller level, this would not prevent the L1 link state entry
>>>> initiated by the link partner. This happens e.g. in case a PCIe card
>>>> enters D3Hot state, which could be initiated from pci_set_power_state()
>>>> if the card indicates D3Hot support, which in turn means link must enter
>>>> L1 state. So instead, fix up the L1 link state after all.
>>>>
>>>> Note that this fixup is applicable only to Aarch32 R-Car controllers,
>>>> the Aarch64 R-Car perform the same fixup in TFA, see TFA commit [1]
>>>> 0969397f2 ("rcar_gen3: plat: Prevent PCIe hang during L1X config access")
>>>> [1] https://github.com/ARM-software/arm-trusted-firmware/commit/0969397f295621aa26b3d14b76dd397d22be58bf
>>>
>>> This patch is horribly ugly but it's working around a horrible
>>> hardware problem, and I don't have any better suggestions, so I guess
>>> we don't really have much choice.
>>>
>>> I do think the commit log is a bit glib:
>>>
>>>    - "The R-Car PCIe controller is capable of handling L0s/L1 link
>>>      states."  AFAICT every PCIe device is required to handle L0 and L1
>>>      without software assistance.  So saying R-Car is "capable" puts a
>>>      better face on this than seems warranted.
>>>
>>>      L0s doesn't seem relevant at all; at least it doesn't seem to play
>>>      a role in the patch.  There's no such thing as "returning to L0s"
>>>      as mentioned in the comment below; L0s is only reachable from L0.
>>>      Returns from L1 only go to L0 (PCIe r5.0, fig 5-1).
>>>
>>>    - "The problem is, this transition is not atomic."  I think the
>>>      *problem* is the hardware is broken in the first place.  This
>>>      transition is supposed to be invisible to software.
>>>
>>>    - "Just like other PCI controller drivers ..." suggests that this is
>>>      an ordinary situation that we shouldn't be concerned about.  This
>>>      patch may be the best we can do to work around a bad hardware
>>>      defect, but it's definitely not ordinary.
>>>
>>>      I think the other hook_fault_code() uses are for reporting
>>>      legitimate PCIe errors, which most controllers log and turn
>>>      into ~0 data responses without generating an abort or machine
>>>      check, not things caused by hardware defects, so they're not
>>>      really comparable.
>>>
>>> Has Renesas documented this as an erratum?  Will future devices
>>> require additions to rcar_pcie_abort_handler_of_match[]?
>>>
>>> It'd be nice if the commit log mentioned the user-visible effect of
>>> this problem.  I guess it does mention external aborts -- I assume you
>>> see those when downstream devices go to D3hot or when ASPM puts the
>>> link in L1?  And the abort results in a reboot?
>>>
>>> To be clear, I'm not objecting to the patch.  It's a hardware problem
>>> and we should work around it as best we can.
>>
>> Cool! So what's missing for this patch, which we have been polishing
>> for almost one year, to be applied, so innocent people can no longer
>> lock up an R-Car system just by inserting an ubiquitous Intel Ethernet
>> card, and suspending the system?
> 
> Nothing missing from my point of view, so if Lorenzo is OK with it,
> he'll apply it.  If I were applying it, I would make the commit log
> something like this:
> 
>    When the link is in L1, hardware should return it to L0
>    automatically whenever a transaction targets a component on the
>    other end of the link (PCIe r5.0, sec 5.2).
> 
>    The R-Car PCIe controller doesn't handle this transition correctly.
>    If the link is not in L0, an MMIO transaction targeting a downstream
>    device fails, and the controller reports an ARM imprecise external
>    abort.
> 
>    Work around this by hooking the abort handler so the driver can
>    detect this situation and help the hardware complete the link state
>    transition.
> 
>    When the R-Car controller receives a PM_ENTER_L1 DLLP from the
>    downstream component, it sets PMEL1RX bit in PMSR register, but then
>    the controller enters some sort of in-between state.  A subsequent
>    MMIO transaction will fail, resulting in the external abort.  The
>    abort handler detects this condition and completes the link state
>    transition by setting the L1IATN bit in PMCTLR and waiting for the
>    link state transition to complete.

OK, should I submit V7 and just copy-paste this commit message in, or 
wait for Lorenzo to provide clear direction ?

> I assume that on the PCIe side, there must be an error like
> Unsupported Request or Malformed TLP, and the R-Car controller is
> logging that and turning it into the ARM external abort?
> 
> I didn't see a clear response to Pali's question about what happens if
> there's no MMIO access, e.g., what if the downstream device initiates
> a DMA or MSI transaction?

If the link is in this state, the packet won't reach the root complex, 
so nothing happens. And I don't see a good way to fix that option.
