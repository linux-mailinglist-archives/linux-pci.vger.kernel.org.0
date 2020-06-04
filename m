Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0B91EE1AA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jun 2020 11:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgFDJnr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Jun 2020 05:43:47 -0400
Received: from mx.socionext.com ([202.248.49.38]:32552 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728082AbgFDJnr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Jun 2020 05:43:47 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 04 Jun 2020 18:43:44 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 506BE60057;
        Thu,  4 Jun 2020 18:43:44 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 4 Jun 2020 18:43:44 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 00BBB1A01BB;
        Thu,  4 Jun 2020 18:43:44 +0900 (JST)
Received: from [10.213.31.56] (unknown [10.213.31.56])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 3708112041F;
        Thu,  4 Jun 2020 18:43:43 +0900 (JST)
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
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <2e07d3d3-515b-57e1-0a36-8892bc38bb7b@socionext.com>
Date:   Thu, 4 Jun 2020 18:43:42 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <78af3b11de9c513f9be2a1f42f273f27@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2020/06/03 20:22, Marc Zyngier wrote:
> On 2020-06-03 09:54, Kunihiko Hayashi wrote:
>> The misc interrupts consisting of PME, AER, and Link event, is handled
>> by INTx handler, however, these interrupts should be also handled by
>> MSI handler.
>>
>> This adds the function uniphier_pcie_misc_isr() that handles misc
>> intterupts, which is called from both INTx and MSI handlers.
> 
> interrupts

Okay, I'll fix it.

>> This function detects PME and AER interrupts with the status register,
>> and invoke PME and AER drivers related to INTx or MSI.
>>
>> And this sets the mask for misc interrupts from INTx if MSI is enabled
>> and sets the mask for misc interrupts from MSI if MSI is disabled.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>  drivers/pci/controller/dwc/pcie-uniphier.c | 53 +++++++++++++++++++++++-------
>>  1 file changed, 42 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c
>> b/drivers/pci/controller/dwc/pcie-uniphier.c
>> index a5401a0..a8dda39 100644
>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>> @@ -44,7 +44,9 @@
>>  #define PCL_SYS_AUX_PWR_DET        BIT(8)
>>
>>  #define PCL_RCV_INT            0x8108
>> +#define PCL_RCV_INT_ALL_INT_MASK    GENMASK(28, 25)
>>  #define PCL_RCV_INT_ALL_ENABLE        GENMASK(20, 17)
>> +#define PCL_RCV_INT_ALL_MSI_MASK    GENMASK(12, 9)
>>  #define PCL_CFG_BW_MGT_STATUS        BIT(4)
>>  #define PCL_CFG_LINK_AUTO_BW_STATUS    BIT(3)
>>  #define PCL_CFG_AER_RC_ERR_MSI_STATUS    BIT(2)
>> @@ -167,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
>>
>>  static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>>  {
>> -    writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
>> +    u32 val;
>> +
>> +    val = PCL_RCV_INT_ALL_ENABLE;
>> +    if (pci_msi_enabled())
>> +        val |= PCL_RCV_INT_ALL_INT_MASK;
>> +    else
>> +        val |= PCL_RCV_INT_ALL_MSI_MASK;
>> +
>> +    writel(val, priv->base + PCL_RCV_INT);
>>      writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>>  }
>>
>> @@ -231,28 +241,48 @@ static const struct irq_domain_ops
>> uniphier_intx_domain_ops = {
>>      .map = uniphier_pcie_intx_map,
>>  };
>>
>> -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
>> +static void uniphier_pcie_misc_isr(struct pcie_port *pp)
>>  {
>> -    struct pcie_port *pp = irq_desc_get_handler_data(desc);
>>      struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>      struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>> -    struct irq_chip *chip = irq_desc_get_chip(desc);
>> -    unsigned long reg;
>> -    u32 val, bit, virq;
>> +    u32 val, virq;
>>
>> -    /* INT for debug */
>>      val = readl(priv->base + PCL_RCV_INT);
>>
>>      if (val & PCL_CFG_BW_MGT_STATUS)
>>          dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
>> +
>>      if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>>          dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
>> -    if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>> -        dev_dbg(pci->dev, "Root Error\n");
>> -    if (val & PCL_CFG_PME_MSI_STATUS)
>> -        dev_dbg(pci->dev, "PME Interrupt\n");
>> +
>> +    if (pci_msi_enabled()) {
> 
> This checks whether the kernel supports MSIs. Not that they are
> enabled in your controller. Is that really what you want to do?

The below two status bits are valid when the interrupt for MSI is asserted.
That is, pci_msi_enabled() is wrong.

I'll modify the function to check the two bits only if this function is
called from MSI handler.

> 
>> +        if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS) {
>> +            dev_dbg(pci->dev, "Root Error Status\n");
>> +            virq = irq_linear_revmap(pp->irq_domain, 0);
>> +            generic_handle_irq(virq);
>> +        }
>> +
>> +        if (val & PCL_CFG_PME_MSI_STATUS) {
>> +            dev_dbg(pci->dev, "PME Interrupt\n");
>> +            virq = irq_linear_revmap(pp->irq_domain, 0);
>> +            generic_handle_irq(virq);
>> +        }
> 
> These two cases do the exact same thing, calling the same interrupt.
> What is the point of dealing with them independently?

Both PME and AER are asserted from MSI-0, and each handler checks its own
status bit in the PCIe register (aer_irq() in pcie/aer.c and pcie_pme_irq()
in pcie/pme.c).
So I think this handler calls generic_handle_irq() for the same MSI-0.

> 
>> +    }
>>
>>      writel(val, priv->base + PCL_RCV_INT);
>> +}
>> +
>> +static void uniphier_pcie_irq_handler(struct irq_desc *desc)
>> +{
>> +    struct pcie_port *pp = irq_desc_get_handler_data(desc);
>> +    struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>> +    struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>> +    struct irq_chip *chip = irq_desc_get_chip(desc);
>> +    unsigned long reg;
>> +    u32 val, bit, virq;
>> +
>> +    /* misc interrupt */
>> +    uniphier_pcie_misc_isr(pp);
> 
> This is a chained handler called outside of a chained_irq_enter/exit
> block. It isn't acceptable.

I got it.
This call should be called in the block.

Thank you,

---
Best Regards
Kunihiko Hayashi
