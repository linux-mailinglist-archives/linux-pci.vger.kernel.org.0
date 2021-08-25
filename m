Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9939D3F6C69
	for <lists+linux-pci@lfdr.de>; Wed, 25 Aug 2021 02:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbhHYABz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Aug 2021 20:01:55 -0400
Received: from mx.socionext.com ([202.248.49.38]:4174 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhHYABz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Aug 2021 20:01:55 -0400
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 25 Aug 2021 09:01:09 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id DFB722086C7B;
        Wed, 25 Aug 2021 09:01:09 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Wed, 25 Aug 2021 09:01:09 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 7BA43C1882;
        Wed, 25 Aug 2021 09:01:09 +0900 (JST)
Received: from [10.212.30.201] (unknown [10.212.30.201])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id E7EFDB62B3;
        Wed, 25 Aug 2021 09:01:08 +0900 (JST)
Subject: Re: [PATCH] PCI: uniphier: Serialize INTx masking/unmasking
To:     Marc Zyngier <maz@kernel.org>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1629717500-19396-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20210823150927.jhobzfxy6e4s663r@pali> <87zgt8p09n.wl-maz@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <f4d13190-facf-55ca-58c5-cd0d68e377d7@socionext.com>
Date:   Wed, 25 Aug 2021 09:01:08 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87zgt8p09n.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2021/08/24 1:57, Marc Zyngier wrote:
> On Mon, 23 Aug 2021 16:09:27 +0100,
> Pali Rohár <pali@kernel.org> wrote:
>>
>> + Marc (who originally reported this issue)
>>
>> On Monday 23 August 2021 20:18:20 Kunihiko Hayashi wrote:
>>> The condition register PCI_RCV_INTX is used in irq_mask(), irq_unmask()
>>> and irq_ack() callbacks. Accesses to register can occur at the same time
>>> without a lock.
>>> Add a lock into each callback to prevent the issue.
>>>
>>> Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
>>> Suggested-by: Pali Rohár <pali@kernel.org>
>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>
>> Acked-by: Pali Rohár <pali@kernel.org>
>>
>>> ---
>>>   drivers/pci/controller/dwc/pcie-uniphier.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> The previous patch is as follows:
>>> https://lore.kernel.org/linux-pci/1629370566-29984-1-git-send-email-hayashi.kunihiko@socionext.com/
>>>
>>> Changes in the previous patch:
>>> - Change the subject and commit message
>>>
>>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>>> index ebe43e9..5075714 100644
>>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>>> @@ -186,12 +186,17 @@ static void uniphier_pcie_irq_ack(struct irq_data *d)
>>>   	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>   	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>> +	unsigned long flags;
>>>   	u32 val;
>>>   
>>> +	raw_spin_lock_irqsave(&pp->lock, flags);
>>> +
>>>   	val = readl(priv->base + PCL_RCV_INTX);
>>>   	val &= ~PCL_RCV_INTX_ALL_STATUS;
>>>   	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
>>>   	writel(val, priv->base + PCL_RCV_INTX);
>>> +
>>> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>>>   }
>>>   
>>>   static void uniphier_pcie_irq_mask(struct irq_data *d)
>>> @@ -199,12 +204,17 @@ static void uniphier_pcie_irq_mask(struct irq_data *d)
>>>   	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>   	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>> +	unsigned long flags;
>>>   	u32 val;
>>>   
>>> +	raw_spin_lock_irqsave(&pp->lock, flags);
>>> +
>>>   	val = readl(priv->base + PCL_RCV_INTX);
>>>   	val &= ~PCL_RCV_INTX_ALL_MASK;
>>>   	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
> 
> This looks extremely suspicious. You clear all the INTX mask bits, and
> only set the one you need. How about the pre-existing bits?

Thanks for pointing out. No need to clear all INTX mask bits.
The pre-existing bits should be preserved.

> 
>>>   	writel(val, priv->base + PCL_RCV_INTX);
>>> +
>>> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>>>   }
>>>   
>>>   static void uniphier_pcie_irq_unmask(struct irq_data *d)
>>> @@ -212,12 +222,17 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
>>>   	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>>>   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>   	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>> +	unsigned long flags;
>>>   	u32 val;
>>>   
>>> +	raw_spin_lock_irqsave(&pp->lock, flags);
>>> +
>>>   	val = readl(priv->base + PCL_RCV_INTX);
>>>   	val &= ~PCL_RCV_INTX_ALL_MASK;
>>>   	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
> 
> And by the same token, this second line is totally useless.
> 
> I think masking/unmasking is broken in this driver, locking or not.

Yes, this second line should be removed, too.
I'll fix this bug and add mask locking.

Thank you,

---
Best Regards
Kunihiko Hayashi
