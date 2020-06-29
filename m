Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B899320D4D6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgF2TLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 15:11:22 -0400
Received: from mx.socionext.com ([202.248.49.38]:30877 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730760AbgF2TLT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 15:11:19 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 29 Jun 2020 18:49:31 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 83E1060060;
        Mon, 29 Jun 2020 18:49:31 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 29 Jun 2020 18:49:31 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 1653D4031A;
        Mon, 29 Jun 2020 18:49:31 +0900 (JST)
Received: from [10.213.29.155] (unknown [10.213.29.155])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 7654F120455;
        Mon, 29 Jun 2020 18:49:30 +0900 (JST)
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
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <c09ceb2f-0bf3-a5de-f918-1ccd0dba1e0a@socionext.com>
Date:   Mon, 29 Jun 2020 18:49:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <87v9jcet5h.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2020/06/27 18:48, Marc Zyngier wrote:
> On Thu, 18 Jun 2020 09:38:09 +0100,
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:
>>
>> The misc interrupts consisting of PME, AER, and Link event, is handled
>> by INTx handler, however, these interrupts should be also handled by
>> MSI handler.
>>
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
> 
> Does this affect endpoints? Or just the RC itself?

These interrupts are asserted by RC itself, so this part affects only RC.

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
>> +			generic_handle_irq(virq);
>> +		}
>> +	}
> 
> Please have two handlers: one for interrupts that are from the RC,
> another for interrupts coming from the endpoints.
I assume that this handler treats interrupts from the RC only and
this is set on the member ".msi_host_isr" added in the patch 1/6.
I think that the handler for interrupts coming from endpoints should be
treated as a normal case (after calling .msi_host_isr in
dw_handle_msi_irq()).

Thank you,

---
Best Regards
Kunihiko Hayashi
