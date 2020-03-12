Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AA18357D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 16:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgCLPxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 11:53:14 -0400
Received: from ns.iliad.fr ([212.27.33.1]:59468 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgCLPxO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 11:53:14 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 362C221081;
        Thu, 12 Mar 2020 16:53:12 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 1DD28208EC;
        Thu, 12 Mar 2020 16:53:12 +0100 (CET)
Subject: Re: [PATCH 4/5] pci: handled return value of platform_get_irq
 correctly
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Aman Sharma <amanharitsh123@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Mans Rullgard <mans@mansr.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20200312141102.GA93224@google.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <b145096e-8628-c551-4846-2eb5ce0334f6@free.fr>
Date:   Thu, 12 Mar 2020 16:53:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312141102.GA93224@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Thu Mar 12 16:53:12 2020 +0100 (CET)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/03/2020 15:11, Bjorn Helgaas wrote:

> [+cc another Marc]

Doh! I should indeed have CCed maz and tglx.

> On Thu, Mar 12, 2020 at 10:53:06AM +0100, Marc Gonzalez wrote:
>
>> On 11/03/2020 20:19, Aman Sharma wrote:
>>
>>> diff --git a/drivers/pci/controller/pcie-tango.c b/drivers/pci/controller/pcie-tango.c
>>> index 21a208da3f59..18c2c4313eb5 100644
>>> --- a/drivers/pci/controller/pcie-tango.c
>>> +++ b/drivers/pci/controller/pcie-tango.c
>>> @@ -273,9 +273,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
>>>  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
>>>  
>>>  	virq = platform_get_irq(pdev, 1);
>>> -	if (virq <= 0) {
>>> +	if (virq < 0) {
>>>  		dev_err(dev, "Failed to map IRQ\n");
>>> -		return -ENXIO;
>>> +		return virq;
>>>  	}
>>>  
>>>  	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);
>>
>> Weee, here we go again :-)
>>
>> https://patchwork.kernel.org/patch/11066455/
>> https://patchwork.kernel.org/patch/10006651/
>>
>> Last time around, my understanding was that, going forward,
>> the best solution was:
>>
>> 	virq = platform_get_irq(...)
>> 	if (virq <= 0)
>> 		return virq ? : -ENODEV;
>>
>> i.e. map 0 to -ENODEV, pass other errors as-is, remove the dev_err
>>
>> @Bjorn/Lorenzo did you have a change of heart?
> 
> Yes.  In 10006651 (Oct 20, 2017), I thought:
> 
>   irq = platform_get_irq(pdev, 0);
>   if (irq <= 0)
>     return -ENODEV;
> 
> was fine.  In 11066455 (Aug 7, 2019), I said I thought I was wrong and
> that:
> 
>   platform_get_irq() is a generic interface and we have to be able to
>   interpret return values consistently.  The overwhelming consensus
>   among platform_get_irq() callers is to treat "irq < 0" as an error,
>   and I think we should follow suit.
>   ...
>   I think the best pattern is:
> 
>     irq = platform_get_irq(pdev, i);
>     if (irq < 0)
>       return irq;
> 
> I still think what I said in 2019 is the right approach.  I do see
> your comment in 10006651 about this pattern:
> 
>   if (virq <= 0)
>     return virq ? : -ENODEV;
> 
> but IMHO it's too complicated for general use.  Admittedly, it's not
> *very* complicated, but it's a relatively unusual C idiom and I
> stumble over it every time I see it.

FTR, omitting the middle operand is a GNU extension.
https://gcc.gnu.org/onlinedocs/gcc/Conditionals.html
The valid C idiom would be virq ? virq : -ENODEV

> If 0 is a special case I think
> it should be mapped to a negative error in arch-specific code, which I
> think is what Linus T suggested in [1].

Lorenzo, being both PCI maintainer and ARM employee should be in a
good position to change the arch-specific code for arm and arm64?

> I think there's still a large consensus that "irq < 0" is the error
> case.  In the tree today we have about 1400 callers of
> platform_get_irq() and platform_get_irq_byname() [2].  Of those,
> almost 900 check for "irq < 0" [3], while only about 150 check for
> "irq <= 0" [4] and about 15 use some variant of a "irq ? : -ENODEV"
> pattern.
> 
> The bottom line is that in drivers/pci, I'd like to see either a
> single style or a compelling argument for why some checks should be
> "irq < 0" and others should be "irq <= 0".
> 
> [1] https://yarchive.net/comp/linux/zero.html
> [2] $ git grep "=.*platform_get_irq" | wc -l
>     1422
> [3] $ git grep -A4 "=.*platform_get_irq" | grep "<\s*0" | wc -l
>     894
> [4] $ git grep -A4 "=.*platform_get_irq" | grep "<=\s*0" | wc -l
>     151
> [5] $ git grep -A4 "=.*platform_get_irq" | grep "return.*?.*:.*;" | wc -l
>     15

Interesting stats, thanks.

Regards.
