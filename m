Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62948220976
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 12:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730969AbgGOKEV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 06:04:21 -0400
Received: from mx.socionext.com ([202.248.49.38]:44653 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgGOKES (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 06:04:18 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 15 Jul 2020 19:04:16 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id D7A7860060;
        Wed, 15 Jul 2020 19:04:16 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 15 Jul 2020 19:04:16 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 80C131A0507;
        Wed, 15 Jul 2020 19:04:16 +0900 (JST)
Received: from [10.212.4.153] (unknown [10.212.4.153])
        by yuzu.css.socionext.com (Postfix) with ESMTP id CA66912012E;
        Wed, 15 Jul 2020 19:04:15 +0900 (JST)
Subject: Re: [PATCH v5 2/6] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?WWFtYWRhLCBNYXNhaGlyby/lsbHnlLAg55yf5byY?= 
        <yamada.masahiro@socionext.com>, Marc Zyngier <maz@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
References: <1592469493-1549-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592469493-1549-3-git-send-email-hayashi.kunihiko@socionext.com>
 <20200714132727.GA13061@e121166-lin.cambridge.arm.com>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <293ed6fe-6e73-f664-c26e-0aef744ce933@socionext.com>
Date:   Wed, 15 Jul 2020 19:04:13 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714132727.GA13061@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 2020/07/14 22:27, Lorenzo Pieralisi wrote:
> On Thu, Jun 18, 2020 at 05:38:09PM +0900, Kunihiko Hayashi wrote:
>> The misc interrupts consisting of PME, AER, and Link event, is handled
>> by INTx handler, however, these interrupts should be also handled by
>> MSI handler.
> 
> Define what you mean please.

AER/PME signals are assigned to the same signal as MSI by internal logic,
that is, AER/PME and MSI are assigned to the same GIC interrupt number.
So it's necessary to modify the code to call the misc handler from MSI handler.

I'll rewrite it next.

> 
>> This adds the function uniphier_pcie_misc_isr() that handles misc
>> interrupts, which is called from both INTx and MSI handlers.
>> This function detects PME and AER interrupts with the status register,
>> and invoke PME and AER drivers related to MSI.
>>
>> And this sets the mask for misc interrupts from INTx if MSI is enabled
>> and sets the mask for misc interrupts from MSI if MSI is disabled.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Jingoo Han <jingoohan1@gmail.com>
>> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>> ---
>>   drivers/pci/controller/dwc/pcie-uniphier.c | 57 ++++++++++++++++++++++++------
>>   1 file changed, 46 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>> index a5401a0..5ce2479 100644
>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>> @@ -44,7 +44,9 @@
>>   #define PCL_SYS_AUX_PWR_DET		BIT(8)
>>   
>>   #define PCL_RCV_INT			0x8108
>> +#define PCL_RCV_INT_ALL_INT_MASK	GENMASK(28, 25)
>>   #define PCL_RCV_INT_ALL_ENABLE		GENMASK(20, 17)
>> +#define PCL_RCV_INT_ALL_MSI_MASK	GENMASK(12, 9)
>>   #define PCL_CFG_BW_MGT_STATUS		BIT(4)
>>   #define PCL_CFG_LINK_AUTO_BW_STATUS	BIT(3)
>>   #define PCL_CFG_AER_RC_ERR_MSI_STATUS	BIT(2)
>> @@ -167,7 +169,15 @@ static void uniphier_pcie_stop_link(struct dw_pcie *pci)
>>   
>>   static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>>   {
>> -	writel(PCL_RCV_INT_ALL_ENABLE, priv->base + PCL_RCV_INT);
>> +	u32 val;
>> +
>> +	val = PCL_RCV_INT_ALL_ENABLE;
>> +	if (pci_msi_enabled())
>> +		val |= PCL_RCV_INT_ALL_INT_MASK;
>> +	else
>> +		val |= PCL_RCV_INT_ALL_MSI_MASK;
>> +
>> +	writel(val, priv->base + PCL_RCV_INT);
>>   	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>>   }
>>   
>> @@ -231,32 +241,56 @@ static const struct irq_domain_ops uniphier_intx_domain_ops = {
>>   	.map = uniphier_pcie_intx_map,
>>   };
>>   
>> -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
>> +static void uniphier_pcie_misc_isr(struct pcie_port *pp, bool is_msi)
>>   {
>> -	struct pcie_port *pp = irq_desc_get_handler_data(desc);
>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>   	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>> -	struct irq_chip *chip = irq_desc_get_chip(desc);
>> -	unsigned long reg;
>> -	u32 val, bit, virq;
>> +	u32 val, virq;
>>   
>> -	/* INT for debug */
>>   	val = readl(priv->base + PCL_RCV_INT);
>>   
>>   	if (val & PCL_CFG_BW_MGT_STATUS)
>>   		dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
>> +
>>   	if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
>>   		dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
>> -	if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>> -		dev_dbg(pci->dev, "Root Error\n");
>> -	if (val & PCL_CFG_PME_MSI_STATUS)
>> -		dev_dbg(pci->dev, "PME Interrupt\n");
>> +
>> +	if (is_msi) {
>> +		if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
>> +			dev_dbg(pci->dev, "Root Error Status\n");
>> +
>> +		if (val & PCL_CFG_PME_MSI_STATUS)
>> +			dev_dbg(pci->dev, "PME Interrupt\n");
>> +
>> +		if (val & (PCL_CFG_AER_RC_ERR_MSI_STATUS |
>> +			   PCL_CFG_PME_MSI_STATUS)) {
>> +			virq = irq_linear_revmap(pp->irq_domain, 0);
> 
> I think this is wrong. pp->irq_domain is the DWC MSI domain, how do
> you know that hwirq 0 *is* the AER/PME interrupt ?

When AER/PME drivers are probed, AER/PME interrupts are registered
as MSI-0.

The pcie_message_numbers() function refers the following fields of
PCI registers,

   - PCI_EXP_FLAGS_IRQ (for PME)
   - PCI_ERR_ROOT_AER_IRQ (for AER)

and decides AER/PME interrupts numbers in MSI domain.
Initial values of both fields are 0, so these interrupts are set to MSI-0.

However, pcie_uniphier driver doesn't know that these interrupts are MSI-0.
Surely using 0 here is wrong.
I think that the method to get virq for AER/PME from pcieport is needed.

>
> It just *works* in this case because the port driver probes and alloc
> MSIs before any PCI device has a chance to do it and actually I think
> this is just wrong also because hwirq 0 *is* usable by devices but
> it can't be used because current code takes it for the PME/AER interrupt
> (which AFAICS is an internal signal disconnected from the DWC MSI
> interrupt controller).

AER/PME interrupts are with IRQF_SHARED, so hwirq 0 can share
any PCI device, however, the multiple handlers might be called
with other factor, so I don't think it is desiable.

> 
> I think this extra glue logic should be separate MSI domain
> otherwise there is no way you can reliably look-up the virq
> corresponding to AER/PME.

Ok, however, it seems that there is no way to get virq for AER/PME
from pcieport in pcie/portdrv_core.c.

When I try to separate AER/PME interrtups from MSI domain,
how should I get virq for AER/PME?

> 
> How does it work in HW ? Is the root port really sending a memory
> write to raise an IRQ or it just signal the IRQ through internal
> logic ? I think the root port MSI handling is different from the
> DWC logic and should be treated separately.

The internal logic assigns the same signal as MSI interrupt
to AER/PME interrupts.

The MSI handler checks internal status register PCL_RCV_INT,
and know if the signal is AER or PME interrupt. MSI memory write
isn't used for the signal.

Since DWC MSI handler doesn't have a method to check the internal
status register, I added callback .msi_host_isr() to DWC MSI handler
in patch 1/6.

Thank you,

---
Best Regards
Kunihiko Hayashi
