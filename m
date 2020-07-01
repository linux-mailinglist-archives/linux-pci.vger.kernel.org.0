Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B92101E8
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jul 2020 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGACSc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Jun 2020 22:18:32 -0400
Received: from mx.socionext.com ([202.248.49.38]:48253 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgGACSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 30 Jun 2020 22:18:32 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 01 Jul 2020 11:18:30 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 5330B180B81;
        Wed,  1 Jul 2020 11:18:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 1 Jul 2020 11:18:30 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id DA0EF1A0507;
        Wed,  1 Jul 2020 11:18:29 +0900 (JST)
Received: from [10.213.31.247] (unknown [10.213.31.247])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 4D2D4120BB6;
        Wed,  1 Jul 2020 11:18:29 +0900 (JST)
Subject: Re: [PATCH v5 2/6] PCI: uniphier: Add misc interrupt handler to
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
References: <1592469493-1549-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592469493-1549-3-git-send-email-hayashi.kunihiko@socionext.com>
 <87v9jcet5h.wl-maz@kernel.org>
 <c09ceb2f-0bf3-a5de-f918-1ccd0dba1e0a@socionext.com>
 <2a2bb86a4afcbd60d3399953b5af8b69@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <95adf862-6c52-ddb9-b96a-e278a1925053@socionext.com>
Date:   Wed, 1 Jul 2020 11:18:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2a2bb86a4afcbd60d3399953b5af8b69@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2020/06/30 22:23, Marc Zyngier wrote:
> On 2020-06-29 10:49, Kunihiko Hayashi wrote:
>> Hi Marc,
>>
>> On 2020/06/27 18:48, Marc Zyngier wrote:
>>> On Thu, 18 Jun 2020 09:38:09 +0100,
>>> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:
>>>>
>>>> The misc interrupts consisting of PME, AER, and Link event, is handled
>>>> by INTx handler, however, these interrupts should be also handled by
>>>> MSI handler.
>>>>
>>>> This adds the function uniphier_pcie_misc_isr() that handles misc
>>>> interrupts, which is called from both INTx and MSI handlers.
>>>> This function detects PME and AER interrupts with the status register,
>>>> and invoke PME and AER drivers related to MSI.
>>>>
>>>> And this sets the mask for misc interrupts from INTx if MSI is enabled
>>>> and sets the mask for misc interrupts from MSI if MSI is disabled.
>>>>
>>>> Cc: Marc Zyngier <maz@kernel.org>
>>>> Cc: Jingoo Han <jingoohan1@gmail.com>
>>>> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>> ---
>>>>   drivers/pci/controller/dwc/pcie-uniphier.c | 57 ++++++++++++++++++++++++------
>>>>   1 file changed, 46 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>>>> index a5401a0..5ce2479 100644
>>>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>>>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>>>> @@ -44,7 +44,9 @@
>>>>   #define PCL_SYS_AUX_PWR_DET        BIT(8)
>>>>     #define PCL_RCV_INT            0x8108
>>>> +#define PCL_RCV_INT_ALL_INT_MASK    GENMASK(28, 25)
>>>>   #define PCL_RCV_INT_ALL_ENABLE        GENMASK(20, 17)
>>>> +#define PCL_RCV_INT_ALL_MSI_MASK    GENMASK(12, 9)
>>>>   #define PCL_CFG_BW_MGT_STATUS        BIT(4)
>>>>   #define PCL_CFG_LINK_AUTO_BW_STATUS    BIT(3)
>>>>   #define PCL_CFG_AER_RC_ERR_MSI_STATUS    BIT(2)
>>>> @@ -167,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
>>>>     static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>>>>   {
>>>> -    writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
>>>> +    u32 val;
>>>> +
>>>> +    val = PCL_RCV_INT_ALL_ENABLE;
>>>> +    if (pci_msi_enabled())
>>>> +        val |= PCL_RCV_INT_ALL_INT_MASK;
>>>> +    else
>>>> +        val |= PCL_RCV_INT_ALL_MSI_MASK;
>>>
>>> Does this affect endpoints? Or just the RC itself?
>>
>> These interrupts are asserted by RC itself, so this part affects only RC.
>>
>>>> +
>>>> +    writel(val, priv->base + PCL_RCV_INT);
>>>>       writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>>>>   }
>>>>   @@ -231,32 +241,56 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
>>>>       .map = uniphier_pcie_intx_map,
>>>>   };
>>>>   -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
>>>> +static void uniphier_pcie_misc_isr(struct pcie_port *pp, bool is_msi)
>>>>   {
>>>> -    struct pcie_port *pp = irq_desc_get_handler_data(desc);
>>>>       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>       struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>>> -    struct irq_chip *chip = irq_desc_get_chip(desc);
>>>> -    unsigned long reg;
>>>> -    u32 val, bit, virq;
>>>> +    u32 val, virq;
>>>>   -    /* INT for debug */
>>>>       val = readl(priv->base + PCL_RCV_INT);
>>>>         if (val & PCL_CFG_BW_MGT_STATUS)
>>>>           dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
>>>> +
>>>>       if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>>>>           dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
>>>> -    if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>>>> -        dev_dbg(pci->dev, "Root Error\n");
>>>> -    if (val & PCL_CFG_PME_MSI_STATUS)
>>>> -        dev_dbg(pci->dev, "PME Interrupt\n");
>>>> +
>>>> +    if (is_msi) {
>>>> +        if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>>>> +            dev_dbg(pci->dev, "Root Error Status\n");
>>>> +
>>>> +        if (val & PCL_CFG_PME_MSI_STATUS)
>>>> +            dev_dbg(pci->dev, "PME Interrupt\n");
>>>> +
>>>> +        if (val & (PCL_CFG_AER_RC_ERR_MSI_STATUS |
>>>> +               PCL_CFG_PME_MSI_STATUS)) {
>>>> +            virq = irq_linear_revmap(pp->irq_domain, 0);
>>>> +            generic_handle_irq(virq);
>>>> +        }
>>>> +    }
>>>
>>> Please have two handlers: one for interrupts that are from the RC,
>>> another for interrupts coming from the endpoints.
>> I assume that this handler treats interrupts from the RC only and
>> this is set on the member ".msi_host_isr" added in the patch 1/6.
>> I think that the handler for interrupts coming from endpoints should be
>> treated as a normal case (after calling .msi_host_isr in
>> dw_handle_msi_irq()).
> 
> It looks pretty odd that you end-up dealing with both from the
> same "parent" interrupt. I guess this is in keeping with the
> rest of the DW PCIe hacks... :-/

It might be odd, however, in case of UniPhier SoC,
both MSI interrupts from endpoints and PME/AER interrupts from RC are
asserted by same "parent" interrupt. In other words, PME/AER interrupts
are notified using the parent interrupt for MSI.

MSI interrupts are treated as child interrupts with reference to
the status register in DW core. This is handled in a for-loop in
dw_handle_msi_irq().

PME/AER interrupts are treated with reference to the status register
in UniPhier glue layer, however, this couldn't be handled in the same way
directly.

So I'm trying to add .msi_host_isr function to handle this
with reference to the SoC-specific registers.

This exported function asserts MSI-0 as a shared child interrupt.
As a result, PME/AER are registered like the followings in dmesg:

    pcieport 0000:00:00.0: PME: Signaling with IRQ 25
    pcieport 0000:00:00.0: AER: enabled with IRQ 25

And these interrupts are shared as MSI-0:

    # cat /proc/interrupts | grep 25:
     25:          0          0          0          0   PCI-MSI   0 Edge      PCIe PME, aerdrv

This might be a special case, though, I think that this is needed to handle
interrupts from RC sharing MSI parent.
  
> It is for Lorenzo to make up his mind about this anyway.

I'd like to Lorenzo's opinion, too.

Thank you,

---
Best Regards
Kunihiko Hayashi
