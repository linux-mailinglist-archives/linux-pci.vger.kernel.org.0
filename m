Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FE12D31B4
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 19:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgLHSFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 13:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730935AbgLHSFy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Dec 2020 13:05:54 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70AC061749;
        Tue,  8 Dec 2020 10:05:13 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id q16so18486811edv.10;
        Tue, 08 Dec 2020 10:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eoyi+3MUIGifT5DnQ9TJ/Uhm31LOkg8jFevEuUkGILM=;
        b=gmINxisOT36YGsX1cADz0W/Xs1mWEbHCebcs5YH2MwF4lDEoDFBg1xjGBdkvp1OPu/
         J4uchQ0XNWxK6NIj7htZC9sDml8+3zDAqFBYUHueXaI5hCab+y+bCE1D9qa+8PkDgFWD
         621Mqb+e7osHy4fsN7I0tfIAYnNEqRlW6QjbyGiDoK6V/f7wzCZxdrekPwfCACJ7QdiF
         3+lWqGvOdeWD5n7lUk127Td4KWHcOdpPKS0cLV5oVCuT3p5i/HoEcwpq9QAEhyUxe/7X
         jbLa6Yr1xvOVj6JX8DShsQwOI6yeANBnFS0S4nU1T7J2XPPrQ7QrVqvMJ7Bptp7ZjjWF
         T8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eoyi+3MUIGifT5DnQ9TJ/Uhm31LOkg8jFevEuUkGILM=;
        b=ZhKgDXP4a/C31tUj8P5fKr1R3NKzog3aVucoPFgGStMu2uleTMKo6yASOB/+h+cAuK
         N+c1E9Z0wzJlpeUdjOa2JqgBhAKmF0eMnD/I4PLR/hnjPOmAVEOzgRhSjX8VMMAT/BQM
         C2jSUYu+1MQJGru148JJAO5RgWBdwIHKJ4Zcp/KvuvmiAKVdyQ8AScZtSDyFy1lqpYM8
         xtDaFa6Y+ebs0oLR2NFDZTgCzjiluJjDB0BonZkYbHJedvSwiu3QVzwi+0FR4ZPXuTz7
         /YssR5DDt4HtDN8I3varcTbjCsVdb/7z6tZPtxTHDAJRvyfDb81nHEFV3SqUiSWSARcz
         EBGw==
X-Gm-Message-State: AOAM530gWk3rFDHQsXUrHOGO+eZfNsfOHsYiWKBk1Vvlnm487W6XwLkD
        rU/4rngH0ta3LflYePVsawjw6gcHVdTWPA==
X-Google-Smtp-Source: ABdhPJx+CCp0rL7POIkGR++gxBEWbjJMcwm3KwfYJzWaCrRzwkEj90L7IG6tPuSue0GccJtNq3+Gbw==
X-Received: by 2002:a50:b205:: with SMTP id o5mr25935190edd.304.1607450711562;
        Tue, 08 Dec 2020 10:05:11 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id w17sm17428554edu.90.2020.12.08.10.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 10:05:10 -0800 (PST)
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20201208164004.GA2377933@bjorn-Precision-5520>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <a65139b9-3b06-0562-7b6e-9a438aecff66@gmail.com>
Date:   Tue, 8 Dec 2020 19:05:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208164004.GA2377933@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/8/20 5:40 PM, Bjorn Helgaas wrote:

[...]

>> The R-Car PCIe controller is capable of handling L0s/L1 link states.
> 
> Minor wording nit: L0s seems irrelevant to this patch.

Of course.

> All PCIe functions are required to support the Power Management
> Capability (PCIe r5.0, sec 7.5.2), and that in turn requires D0,
> D3hot, and D3cold support, and D3hot requires L1 (sec 5.2).
> 
> So saying this device "is capable of handling L1" really doesn't tell
> us anything, and it glosses over the fact that it doesn't do it
> *correctly* and requires help from the driver to work around this
> hardware defect.

I see.

> Does this problem occur in both these cases?
> 
>    1) When ASPM enters L1, and
> 
>    2) When software writes PCI_PM_CTRL to put the device in D3hot?
> 
> IIUC both cases require the link to go to L1.  I guess the same
> software workaround applies to both cases?

Yes

[...]

>> +#ifdef CONFIG_ARM
>> +static int rcar_pcie_aarch32_abort_handler(unsigned long addr,
>> +		unsigned int fsr, struct pt_regs *regs)
>> +{
>> +	u32 pmsr;
>> +
>> +	if (!pcie_base || !__clk_is_enabled(pcie_bus_clk))
>> +		return 1;
>> +
>> +	pmsr = readl(pcie_base + PMSR);
>> +
>> +	/*
>> +	 * Test if the PCIe controller received PM_ENTER_L1 DLLP and
>> +	 * the PCIe controller is not in L1 link state. If true, apply
>> +	 * fix, which will put the controller into L1 link state, from
>> +	 * which it can return to L0s/L0 on its own.
>> +	 */
>> +	if ((pmsr & PMEL1RX) && ((pmsr & PMSTATE) != PMSTATE_L1)) {
>> +		writel(L1IATN, pcie_base + PMCTLR);
>> +		while (!(readl(pcie_base + PMSR) & L1FAEG))
>> +			;
>> +		writel(L1FAEG | PMEL1RX, pcie_base + PMSR);
>> +		return 0;
>> +	}
>> +
>> +	return 1;
> 
> I have no insight into how these abort handlers work.  Looks awfully
> kludgy to me, but if it's the only way and the ARM folks are on board
> with it, I can't object.
> 
> I guess the other alternative would be to have a quirk to stop
> advertising ASPM L1 support and D1/D2/D3hot support.  Obviously that
> may give up some power savings.
> 
> If people aren't comfortable with the reliability or maintainability
> of this approach in the upstream kernel, there's always the option of
> the users who need it carrying this as an out-of-tree patch.

I would highly prefer to be able to use mainline Linux as-is, without 
carrying any extra patches, so BSP is not an option.

>> +}
>> +
>> +static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst = {
>> +	{ .compatible = "renesas,pcie-r8a7779" },
>> +	{ .compatible = "renesas,pcie-r8a7790" },
>> +	{ .compatible = "renesas,pcie-r8a7791" },
>> +	{ .compatible = "renesas,pcie-rcar-gen2" },
>> +	{},
>> +};
> 
> Why do we need another copy of these, as opposed to doing something
> with of_device_get_match_data(), e.g., like brcm_pcie_probe() does?

This is not a copy, but as subset of SoCs which are affected by this 
problem.

>> +static int __init rcar_pcie_init(void)
>> +{
>> +	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
>> +#ifdef CONFIG_ARM_LPAE
>> +		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>> +				"asynchronous external abort");
>> +#else
>> +		hook_fault_code(22, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>> +				"imprecise external abort");
>> +#endif
>> +	}
>> +
>> +	return platform_driver_register(&rcar_pcie_driver);
>> +}
>> +device_initcall(rcar_pcie_init);
>> +#else
>>   builtin_platform_driver(rcar_pcie_driver);
>> +#endif
> 
> Is the device_initcall() vs builtin_platform_driver() something
> related to the hook_fault_code()?  What would break if this were
> always builtin_platform_driver()?

rcar_pcie_init() would not be called before probe.
