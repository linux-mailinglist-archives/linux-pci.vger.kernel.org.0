Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729273D34EE
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 08:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhGWGSm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 02:18:42 -0400
Received: from mx.socionext.com ([202.248.49.38]:61222 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234104AbhGWGSl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 02:18:41 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 23 Jul 2021 15:59:13 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id BD40420566E0;
        Fri, 23 Jul 2021 15:59:13 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 23 Jul 2021 15:59:13 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id A338FB6342;
        Fri, 23 Jul 2021 15:59:13 +0900 (JST)
Received: from [10.212.30.170] (unknown [10.212.30.170])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 07BD4B1D52;
        Fri, 23 Jul 2021 15:59:12 +0900 (JST)
Subject: Re: [PATCH v8 3/3] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-arm-kernel@lists.infradead.org
References: <1603848703-21099-4-git-send-email-hayashi.kunihiko@socionext.com>
 <20201124232037.GA595463@bjorn-Precision-5520>
 <20201125102328.GA31700@e121166-lin.cambridge.arm.com>
 <f49a236d-c5f8-c445-f74e-7aa4eea70c3a@socionext.com>
 <20210718005109.6xwe3z7gxhuop5xc@pali>
 <2dfa5ec9-2a33-ae72-3904-999d8b8a2f71@socionext.com>
 <20210722172627.i4n65lrz3j7pduiz@pali>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <17c6eeee-692f-2e9a-5827-34f6939a21a6@socionext.com>
Date:   Fri, 23 Jul 2021 15:59:12 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210722172627.i4n65lrz3j7pduiz@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On 2021/07/23 2:26, Pali Rohár wrote:
> On Friday 23 July 2021 01:54:10 Kunihiko Hayashi wrote:
>> On 2021/07/18 9:51, Pali Rohar wrote:
>>>>> IMO this should be modelled with a separate IRQ domain and chip for
>>>>> the root port (yes this implies describing the root port in the dts
>>>>> file with a separate msi-parent).
>>>>>
>>>>> This series as it stands is a kludge.
>>>>
>>>> I see. However I need some time to consider the way to separate IRQ domain.
>>>> Is there any idea or example to handle PME/AER with IRQ domain?
>>>
>>> Seems that you are dealing with very similar issues as me with aardvark
>>> driver.
>>>
>>> As an inspiration look at my aardvark patch which setup separate IRQ
>>> domain for PME, AER and HP interrupts:
>>> https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/
>>>
>>> Thanks to custom driver map_irq function, it is not needed to describe
>>> root port with separate msi-parent in DTS.
>>
>> I need to understand your solution, though, this might be the same situation as my driver.
> 
> I think it is very very similar as aardvark also returns zero as hw irq
> number (and it is not possible to change it).
> 
> So simple solution for you is also to register separate IRQ domain for
> Root Port Bridge and then re-trigger interrupt with number 0 (which you
> wrote that is default) as:
> 
>      virq = irq_find_mapping(priv->irq_domain, 0);
>      generic_handle_irq(virq);
> 
> in your uniphier_pcie_misc_isr() function.

I'm not sure "register separate IRQ domain for Root Port Bridge".
Do you mean that your suggestion is to create new IRQ domain, and add this domain to root port?
Or could you show me something example?

The re-trigger part is the same method as v5 patch I wrote.

> There is no need to modify DTS. And also no need to use complicated
> logic for finding registered virq number via pcie_port_service_get_irq()
> and uniphier_pcie_port_get_irq() functions.

I see.
GIC interrupt for MSI is handled by the MSI domain by pcie-designware-host.c.
My concern is how to trigger PME/AER event with another IRQ domain.

Thank you,

---
Best Regards
Kunihiko Hayashi
