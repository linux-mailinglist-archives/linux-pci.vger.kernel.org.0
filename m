Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAA23D37CC
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 11:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhGWIzw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 04:55:52 -0400
Received: from mx.socionext.com ([202.248.49.38]:34561 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231262AbhGWIzv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 04:55:51 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Jul 2021 18:36:23 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id D133820142B4;
        Fri, 23 Jul 2021 18:36:23 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Fri, 23 Jul 2021 18:36:23 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id A4BF8B632B;
        Fri, 23 Jul 2021 18:36:23 +0900 (JST)
Received: from [10.212.29.159] (unknown [10.212.29.159])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id D418AB1D52;
        Fri, 23 Jul 2021 18:36:21 +0900 (JST)
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
 <17c6eeee-692f-2e9a-5827-34f6939a21a6@socionext.com>
 <20210723083702.nvhurkgbzbvrrmv3@pali>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <660e8597-bb7a-b5a0-e3d4-f108a211ae76@socionext.com>
Date:   Fri, 23 Jul 2021 18:36:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210723083702.nvhurkgbzbvrrmv3@pali>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Pali,

On 2021/07/23 17:37, Pali Rohár wrote:
> On Friday 23 July 2021 15:59:12 Kunihiko Hayashi wrote:
>> Hi Pali,
>>
>> On 2021/07/23 2:26, Pali Rohár wrote:
>>> On Friday 23 July 2021 01:54:10 Kunihiko Hayashi wrote:
>>>> On 2021/07/18 9:51, Pali Rohar wrote:
>>>>>>> IMO this should be modelled with a separate IRQ domain and chip for
>>>>>>> the root port (yes this implies describing the root port in the dts
>>>>>>> file with a separate msi-parent).
>>>>>>>
>>>>>>> This series as it stands is a kludge.
>>>>>>
>>>>>> I see. However I need some time to consider the way to separate IRQ domain.
>>>>>> Is there any idea or example to handle PME/AER with IRQ domain?
>>>>>
>>>>> Seems that you are dealing with very similar issues as me with aardvark
>>>>> driver.
>>>>>
>>>>> As an inspiration look at my aardvark patch which setup separate IRQ
>>>>> domain for PME, AER and HP interrupts:
>>>>> https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/
>>>>>
>>>>> Thanks to custom driver map_irq function, it is not needed to describe
>>>>> root port with separate msi-parent in DTS.
>>>>
>>>> I need to understand your solution, though, this might be the same situation as my driver.
>>>
>>> I think it is very very similar as aardvark also returns zero as hw irq
>>> number (and it is not possible to change it).
>>>
>>> So simple solution for you is also to register separate IRQ domain for
>>> Root Port Bridge and then re-trigger interrupt with number 0 (which you
>>> wrote that is default) as:
>>>
>>>       virq = irq_find_mapping(priv->irq_domain, 0);
>>>       generic_handle_irq(virq);
>>>
>>> in your uniphier_pcie_misc_isr() function.
>>
>> I'm not sure "register separate IRQ domain for Root Port Bridge".
>> Do you mean that your suggestion is to create new IRQ domain, and add this domain to root port?
> 
> Yes.
> 
>> Or could you show me something example?
> 
> I have already sent link to patch above which it implements for
> pci-aardvark.c driver.
> 
> https://lore.kernel.org/linux-pci/20210506153153.30454-32-pali@kernel.org/

Thank you for the example.

> In device prove callback register domain by irq_domain_add_linear().
> In bridge map_irq() callback use irq_create_mapping() for Root Port
> device (and otherwise default of_irq_parse_and_map_pci()). And in
> uniphier_pcie_misc_isr() retrigger interrupt into new domain.

I understand it late.
The main point is to replace bridge->map_irq() with private own map_irq().

> 
>> The re-trigger part is the same method as v5 patch I wrote.
> 
> Just you need to specify that new/private IRQ domain into
> irq_find_mapping() call.

I'll try to replace the events with new IRQ domain.

Thank you,

---
Best Regards
Kunihiko Hayashi
