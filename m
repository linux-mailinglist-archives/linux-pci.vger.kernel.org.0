Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394753F84FB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Aug 2021 12:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbhHZKDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Aug 2021 06:03:19 -0400
Received: from mx.socionext.com ([202.248.49.38]:26560 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234682AbhHZKDS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 06:03:18 -0400
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 26 Aug 2021 19:02:31 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id EBBE6205902A;
        Thu, 26 Aug 2021 19:02:30 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 26 Aug 2021 19:02:30 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 9FA85B62B7;
        Thu, 26 Aug 2021 19:02:30 +0900 (JST)
Received: from [10.212.31.206] (unknown [10.212.31.206])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 5908BB62B3;
        Thu, 26 Aug 2021 19:02:14 +0900 (JST)
Subject: Re: [PATCH] PCI: uniphier: Serialize INTx masking/unmasking
To:     Marc Zyngier <maz@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <1629717500-19396-1-git-send-email-hayashi.kunihiko@socionext.com>
 <20210823150927.jhobzfxy6e4s663r@pali> <87zgt8p09n.wl-maz@kernel.org>
 <f4d13190-facf-55ca-58c5-cd0d68e377d7@socionext.com>
 <87o89lq4eb.wl-maz@kernel.org>
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Message-ID: <7a7ed6c9-53b6-0bd9-c8e2-5eea7b5c1c24@socionext.com>
Date:   Thu, 26 Aug 2021 19:02:11 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87o89lq4eb.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

On 2021/08/25 18:07, Marc Zyngier wrote:
> On Wed, 25 Aug 2021 01:01:08 +0100,
> Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:
>>
>> Hi Marc,
>>
>> On 2021/08/24 1:57, Marc Zyngier wrote:
>>> On Mon, 23 Aug 2021 16:09:27 +0100,
>>> Pali Rohár <pali@kernel.org> wrote:
>>>>
>>>> + Marc (who originally reported this issue)
>>>>
>>>> On Monday 23 August 2021 20:18:20 Kunihiko Hayashi wrote:
>>>>> The condition register PCI_RCV_INTX is used in irq_mask(), irq_unmask()
>>>>> and irq_ack() callbacks. Accesses to register can occur at the same time
>>>>> without a lock.
>>>>> Add a lock into each callback to prevent the issue.
>>>>>
>>>>> Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
>>>>> Suggested-by: Pali Rohár <pali@kernel.org>
>>>>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
>>>>
>>>> Acked-by: Pali Rohár <pali@kernel.org>
>>>>
>>>>> ---
>>>>>    drivers/pci/controller/dwc/pcie-uniphier.c | 15 +++++++++++++++
>>>>>    1 file changed, 15 insertions(+)
>>>>>
>>>>> The previous patch is as follows:
>>>>> https://lore.kernel.org/linux-pci/1629370566-29984-1-git-send-email-hayashi.kunihiko@socionext.com/
>>>>>
>>>>> Changes in the previous patch:
>>>>> - Change the subject and commit message
>>>>>
>>>>> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
>>>>> index ebe43e9..5075714 100644
>>>>> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
>>>>> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
>>>>> @@ -186,12 +186,17 @@ static void uniphier_pcie_irq_ack(struct irq_data *d)
>>>>>    	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>>>>>    	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>    	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>>>> +	unsigned long flags;
>>>>>    	u32 val;
>>>>>    +	raw_spin_lock_irqsave(&pp->lock, flags);
>>>>> +
>>>>>    	val = readl(priv->base + PCL_RCV_INTX);
>>>>>    	val &= ~PCL_RCV_INTX_ALL_STATUS;
>>>>>    	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
>>>>>    	writel(val, priv->base + PCL_RCV_INTX);
>>>>> +
>>>>> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>>>>>    }
>>>>>      static void uniphier_pcie_irq_mask(struct irq_data *d)
>>>>> @@ -199,12 +204,17 @@ static void uniphier_pcie_irq_mask(struct irq_data *d)
>>>>>    	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>>>>>    	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>    	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>>>> +	unsigned long flags;
>>>>>    	u32 val;
>>>>>    +	raw_spin_lock_irqsave(&pp->lock, flags);
>>>>> +
>>>>>    	val = readl(priv->base + PCL_RCV_INTX);
>>>>>    	val &= ~PCL_RCV_INTX_ALL_MASK;
>>>>>    	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
>>>
>>> This looks extremely suspicious. You clear all the INTX mask bits, and
>>> only set the one you need. How about the pre-existing bits?
>>
>> Thanks for pointing out. No need to clear all INTX mask bits.
>> The pre-existing bits should be preserved.
>>
>>>
>>>>>    	writel(val, priv->base + PCL_RCV_INTX);
>>>>> +
>>>>> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>>>>>    }
>>>>>      static void uniphier_pcie_irq_unmask(struct irq_data *d)
>>>>> @@ -212,12 +222,17 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
>>>>>    	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>>>>>    	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>>>>>    	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
>>>>> +	unsigned long flags;
>>>>>    	u32 val;
>>>>>    +	raw_spin_lock_irqsave(&pp->lock, flags);
>>>>> +
>>>>>    	val = readl(priv->base + PCL_RCV_INTX);
>>>>>    	val &= ~PCL_RCV_INTX_ALL_MASK;
>>>>>    	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
>>>
>>> And by the same token, this second line is totally useless.
>>>
>>> I think masking/unmasking is broken in this driver, locking or not.
>>
>> Yes, this second line should be removed, too.
> 
> You mean the *first* line, right? The one clearing all the INTx
> bits. If you remove the second line, you won't fix anything.
This is ambiguous. I mean that I will remove the following line:

     	val &= ~PCL_RCV_INTX_ALL_MASK;

So the fixed unmasking code is as follows.

     	val = readl(priv->base + PCL_RCV_INTX);
     	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
     	writel(val, priv->base + PCL_RCV_INTX);

Thank you,

---
Best Regards
Kunihiko Hayashi
