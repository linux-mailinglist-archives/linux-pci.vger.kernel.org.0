Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83BB2C794D
	for <lists+linux-pci@lfdr.de>; Sun, 29 Nov 2020 14:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgK2NGw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 Nov 2020 08:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2NGw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 Nov 2020 08:06:52 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97A7C0613D2;
        Sun, 29 Nov 2020 05:06:11 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id n24so9374179edb.4;
        Sun, 29 Nov 2020 05:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8ozyxPkGPRLOCY4epEaLOpOsyLKUOueRcL5FH3Vv3/8=;
        b=ZmcOr77zVJRsSj82yYGfOvtadmiXd4o0fx50M8S02caC3WGSZSGvp+XOHV5K4du69K
         LGlttJWxamoE5i+1YyHwpvzP7yuZO9ilRO7gG6/lm5ijxw3gHN9pW7MSdeTXlyl5o7/x
         0SyK1aeVpEl/iS9iK17bmnft+3O0ZP4lt40m92ma/jcJ/0RgzDcWDLo04/XvMt0bAoEX
         kmM5H2nGHZ/HRgbFOdhD0Q8cvvTOewHA9gxrrloCE7GwIk5txidf8s1v3wvQeX4CCm43
         ksGefa55aQ4CmBTCSC2ZjbYln4p5rssJvUhNCLe4y/w4XUfMyLczyhjEDFeHxbpwO+Ir
         HTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ozyxPkGPRLOCY4epEaLOpOsyLKUOueRcL5FH3Vv3/8=;
        b=iyRw5c8uLQ2TwHMUVAIB3rzhX3x5rLPMMSQeZShNbei5x47tFeuzlJg6Ysf9HNlrHu
         GohXg5e7ja1QrgwGsVHJNRhlYADVMsEIaWaiuNo8fj4ZkHPFJS4r4ztcIbV1uBUkXbF4
         md5v4qzy3oFFUWRcppKPTspYj1RXyFqripdJLuMJfoCWnXG3QsEfNnh8vsdBwv8/8pme
         BU0Jrtnlp9Xwod4A1+hyTNGti/V8q4QGPlVygvthpr6UuH0cLH25I7/YLgVubVhlrMAj
         E8gKSBqKWqI0cIdRxvRtILQXMNc+MeegznBN9oEy0s2aqxCfGZRQ1leIzpteiOjtfk1Y
         /ZOg==
X-Gm-Message-State: AOAM530nnHpekXS0WH6O2HwcXrgKLR4Wf+RxUu+aw+82n756cB2ESryP
        8F+TKUG0RPH0ZVtZzdmnZl8+okxyFMP6uw==
X-Google-Smtp-Source: ABdhPJytY2KngnmcztguyMY+9nYNz3lusXsRTcJY7xB9HAtluK9KvfdcbtztpXwGSiIEnl7pqx/I2Q==
X-Received: by 2002:a05:6402:21a:: with SMTP id t26mr17400269edv.173.1606655170148;
        Sun, 29 Nov 2020 05:06:10 -0800 (PST)
Received: from [192.168.1.4] (ip-89-176-112-137.net.upcbroadband.cz. [89.176.112.137])
        by smtp.gmail.com with ESMTPSA id lj14sm3363089ejb.16.2020.11.29.05.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 05:06:09 -0800 (PST)
Subject: Re: [PATCH V4] PCI: rcar: Add L1 link state fix into data abort hook
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20201016120416.7008-1-marek.vasut@gmail.com>
 <20201119173553.GB23852@e121166-lin.cambridge.arm.com>
From:   Marek Vasut <marek.vasut@gmail.com>
Message-ID: <57358982-ef8c-ed91-c011-00b8a48c4ebd@gmail.com>
Date:   Sun, 29 Nov 2020 14:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119173553.GB23852@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/20 6:35 PM, Lorenzo Pieralisi wrote:
>> +#ifdef CONFIG_ARM
>> +/*
>> + * Here we keep a static copy of the remapped PCIe controller address.
>> + * This is only used on aarch32 systems, all of which have one single
>> + * PCIe controller, to provide quick access to the PCIe controller in
>> + * the L1 link state fixup function, called from the ARM fault handler.
>> + */
>> +static void __iomem *pcie_base;
>> +/*
>> + * Static copy of bus clock pointer, so we can check whether the clock
>> + * is enabled or not.
>> + */
>> +static struct clk *pcie_bus_clk;
>> +#endif
> 
> Don't think you can have multiple host bridges in a given platform,
> if it is a possible configuration this won't work.

Correct, all the affected platforms have only one host bridge.

>>   static inline struct rcar_msi *to_rcar_msi(struct msi_controller *chip)
>>   {
>>   	return container_of(chip, struct rcar_msi, chip);
>> @@ -804,6 +820,12 @@ static int rcar_pcie_get_resources(struct rcar_pcie_host *host)
>>   	}
>>   	host->msi.irq2 = i;
>>   
>> +#ifdef CONFIG_ARM
>> +	/* Cache static copy for L1 link state fixup hook on aarch32 */
>> +	pcie_base = pcie->base;
>> +	pcie_bus_clk = host->bus_clk;
>> +#endif
>> +
>>   	return 0;
>>   
>>   err_irq2:
>> @@ -1050,4 +1072,58 @@ static struct platform_driver rcar_pcie_driver = {
>>   	},
>>   	.probe = rcar_pcie_probe,
>>   };
>> +
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
> 
> I suppose a fault on multiple cores can happen simultaneously, if it
> does this may not work well either - I assume all config/io/mem would
> trigger a fault.
> 
> As I mentioned in my reply to v1, is there a chance we can move
> this quirk into config accessors (if the PM_ENTER_L1_DLLP is
> subsequent to a write into PMCSR to programme a D state) ?

I don't think we can, since the userspace can do such a config space 
write with e.g. setpci and then this fixup is still needed.

> Config access is serialized but I suspect as I said above that this
> triggers on config/io/mem alike.
> 
> Just asking to try to avoid a fault handler if possible.

See above, I doubt we can fully avoid this workaround.

[...]
