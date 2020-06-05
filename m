Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178BC1EEF8C
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jun 2020 04:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFECg7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 22:36:59 -0400
Received: from mx.socionext.com ([202.248.49.38]:40148 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgFECg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 22:36:59 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 05 Jun 2020 11:36:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 64803605FA;
        Fri,  5 Jun 2020 11:36:56 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 5 Jun 2020 11:36:56 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id CEDE91A01BB;
        Fri,  5 Jun 2020 11:36:08 +0900 (JST)
Received: from [10.213.29.9] (unknown [10.213.29.9])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 5D105120133;
        Fri,  5 Jun 2020 11:36:08 +0900 (JST)
Subject: Re: [PATCH v3 2/6] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
To:     Marc Zyngier <maz@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1591174481-13975-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1591174481-13975-3-git-send-email-hayashi.kunihiko@socionext.com>
 <78af3b11de9c513f9be2a1f42f273f27@kernel.org>
 <2e07d3d3-515b-57e1-0a36-8892bc38bb7b@socionext.com>
 <9cbfdacba32c5e351fd9e14444768666@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <1d98ef53-fe81-6de2-bd65-dd88d6875cb8@socionext.com>
Date:   Fri, 5 Jun 2020 11:36:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <9cbfdacba32c5e351fd9e14444768666@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2020/06/04 19:11, Marc Zyngier wrote:
> On 2020-06-04 10:43, Kunihiko Hayashi wrote:
> 
> [...]
> 
>>>> -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
>>>> +static void uniphier_pcie_misc_isr(struct pcie_port *pp)
>>>>  {
>>>> -    struct pcie_port *pp = irq_desc_get_handler_data(desc);
>>>>      struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>      struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>>> -    struct irq_chip *chip = irq_desc_get_chip(desc);
>>>> -    unsigned long reg;
>>>> -    u32 val, bit, virq;
>>>> +    u32 val, virq;
>>>>
>>>> -    /* INT for debug */
>>>>      val = readl(priv->base + PCL_RCV_INT);
>>>>
>>>>      if (val & PCL_CFG_BW_MGT_STATUS)
>>>>          dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
>>>> +
>>>>      if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>>>>          dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
>>>> -    if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>>>> -        dev_dbg(pci->dev, "Root Error\n");
>>>> -    if (val & PCL_CFG_PME_MSI_STATUS)
>>>> -        dev_dbg(pci->dev, "PME Interrupt\n");
>>>> +
>>>> +    if (pci_msi_enabled()) {
>>>
>>> This checks whether the kernel supports MSIs. Not that they are
>>> enabled in your controller. Is that really what you want to do?
>>
>> The below two status bits are valid when the interrupt for MSI is asserted.
>> That is, pci_msi_enabled() is wrong.
>>
>> I'll modify the function to check the two bits only if this function is
>> called from MSI handler.
>>
>>>
>>>> +        if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
>>>> +            dev_dbg(pci->dev, "Root Error Status\n");
>>>> +            virq = irq_linear_revmap(pp->irq_domain, 0);
>>>> +            generic_handle_irq(virq);
>>>> +        }
>>>> +
>>>> +        if (val & PCL_CFG_PME_MSI_STATUS) {
>>>> +            dev_dbg(pci->dev, "PME Interrupt\n");
>>>> +            virq = irq_linear_revmap(pp->irq_domain, 0);
>>>> +            generic_handle_irq(virq);
>>>> +        }
>>>
>>> These two cases do the exact same thing, calling the same interrupt.
>>> What is the point of dealing with them independently?
>>
>> Both PME and AER are asserted from MSI-0, and each handler checks its own
>> status bit in the PCIe register (aer_irq() in pcie/aer.c and pcie_pme_irq()
>> in pcie/pme.c).
>> So I think this handler calls generic_handle_irq() for the same MSI-0.
> 
> So what is wrong with
> 
>          if (val & (PCL_CFG_AER_RC_ERR_MSI_STATUS |
>                     PCL_CFG_PME_MSI_STATUS)) {
>                  // handle interrupt
>          }
> 
> ?

No problem.
I'll rewrite it in the same way as yours in handling interrupts.

> If you have two handlers for the same interrupt, this is a shared
> interrupt and each handler will be called in turn.
Yes, MSI-0 is shared with PME and AER, and it will be like that.

Thank you,

---
Best Regards
Kunihiko Hayashi
