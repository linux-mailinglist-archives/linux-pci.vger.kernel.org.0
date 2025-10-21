Return-Path: <linux-pci+bounces-38910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E5FBF747F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED9B18826F6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A319C342C80;
	Tue, 21 Oct 2025 15:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jNriKDcw"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716A242D7C
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 15:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059575; cv=none; b=Q0yRVj5Kyd+A6tME6r4Id+676wVLJbEWQH2qRpRmGRdRENsgY2v+jn+95di2/zQ55yLaN1GQ2qrfklZ7xqT5ZKP9qDHGSECgtdWIym5/L86sEpy7XxUAyRP+NDCX/GmyluBRlEC21saMSiayZ5URVymSBC71QftBEsH5qTNkLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059575; c=relaxed/simple;
	bh=q06UQi3vYM3fbII6MB23STx+/ixel5+SwD5+6zv2igA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pf5mLqZcR39rpwmXQYRpbY/eLxjdfMK+pOgUzdGoGiOFJkX10pxI0BFAdb646QYdsHCCeVebMQCxvePDqOGz41/s+kQ7WAu0bLM6llgy5YOV9x0GvATcFV4Jymo33G9C5S1l4MseX1rd8G4N47Viskt204AqH91vBm8QfNmrv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jNriKDcw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2f95faef-b5eb-4c6a-857e-5cf02f5850b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761059570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9EERUM1c+FAiaCFLM+DCPch7pvjG3et6PiGGO8KQ9m8=;
	b=jNriKDcw6ikdwIB5GRBxtMfVn60xwrvJ1M3QwksWRVxni9vC2YLvBrD1OX5RFb6+pjr6Z4
	QlK8HBpph8gptmOabiY8lUTjcTn5/IfbRh31GehCjqTlMGRCe2Dhzcsoh8mswRkjGh3uZy
	JLURsZHFcCP9b9/tz2QrV++JCU/FW4Y=
Date: Tue, 21 Oct 2025 11:12:42 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: pcie-xilinx-dma-pl: Fix off-by-one INTx IRQ handling
To: Stefan Roese <stefan.roese@mailbox.org>, linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <mani@kernel.org>,
 Ravi Kumar Bandi <ravib@amazon.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
 Michal Simek <michal.simek@amd.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20251021133958.802464-1-stefan.roese@mailbox.org>
 <c174f938-d1ec-4f5f-a838-e7ebd3c43818@linux.dev>
 <3613d83d-7a35-4b1a-bf0c-8c7e0b03198f@linux.dev>
 <966bcd8f-5742-4888-a57b-92769e76fc43@mailbox.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <966bcd8f-5742-4888-a57b-92769e76fc43@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/21/25 11:10, Stefan Roese wrote:
> Hi Sean,
> 
> On 10/21/25 17:04, Sean Anderson wrote:
>> On 10/21/25 10:59, Sean Anderson wrote:
>>> On 10/21/25 09:39, Stefan Roese wrote:
>>>> While testing with NVMe drives connected to the Versal QDMA PL PCIe RP
>>>> on our platform I noticed that with MSI disabled (e.g. via pci=nomsi)
>>>> the NVMe interrupts are not delivered to the host CPU resulting in
>>>> timeouts while probing.
>>>>
>>>> Debugging has shown, that the hwirq numbers passed to this device driver
>>>> (1...4, 1=INTA etc) need to get adjusted to match the numbers in the
>>>> controller registers bits (0...3). This patch now correctly matches the
>>>> hwirq number to the PCIe controller register bits.
>>>>
>>>> Signed-off-by: Stefan Roese <stefan.roese@mailbox.org>
>>>> Cc: Sean Anderson <sean.anderson@linux.dev>
>>>
>>> I assume I'm CC'd because of commit 02a370c4fc0f ("PCI: xilinx-nwl: Fix
>>> off-by-one in INTx IRQ handler"), which does the exact opposite of this
>>> patch.
> 
> Correct. PCI legacy interrupts are rarely used as it seems lately.
> 
>>> And I'm rather confused as to how you determined that hwirq is
>>> one-based, since it seems to come directly from
>>>
>>>     for_each_set_bit(i, &val, PCI_NUM_INTX)
>>>         generic_handle_domain_irq(port->intx_domain, i);
>>>
>>> which is zero-based.
>>
>> OK, upon re-reading the patch it looks like you also adjusted the above
>> hunk to be one-based. After this patch the drivers adds one just to
>> subtract it off again.
>>
>> So why do the interrupts need to be one-based and not zero-based?
> 
> My testing / debugging showed, that hwirq as an input to these
> functions is always 1 in my case. My assumption was, that this is
> because of these defines in include/linux/pci.h:
> 
> /**
>  * enum pci_interrupt_pin - PCI INTx interrupt values
>  * @PCI_INTERRUPT_UNKNOWN: Unknown or unassigned interrupt
>  * @PCI_INTERRUPT_INTA: PCI INTA pin
>  * @PCI_INTERRUPT_INTB: PCI INTB pin
>  * @PCI_INTERRUPT_INTC: PCI INTC pin
>  * @PCI_INTERRUPT_INTD: PCI INTD pin
>  *
>  * Corresponds to values for legacy PCI INTx interrupts, as can be found in the
>  * PCI_INTERRUPT_PIN register.
>  */
> enum pci_interrupt_pin {
>     PCI_INTERRUPT_UNKNOWN,
>     PCI_INTERRUPT_INTA,
>     PCI_INTERRUPT_INTB,
>     PCI_INTERRUPT_INTC,
>     PCI_INTERRUPT_INTD,
> };
> 
> So 0 is unknown and 1 is INTA.
> 
> I might have gotten something totally wrong this patch with these
> changes enables PCIe INTx generation on my Versal platform.
>

Maybe you need to set intx_domain_ops.xlate to pci_irqd_intx_xlate?

--Sean

>>
>>>
>>>> Cc: Manivannan Sadhasivam <mani@kernel.org>
>>>> Cc: Ravi Kumar Bandi <ravib@amazon.com>
>>>> Cc: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
>>>> Cc: Michal Simek <michal.simek@amd.com>
>>>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>> ---
>>>>   drivers/pci/controller/pcie-xilinx-dma-pl.c | 21 ++++++++++++++++++---
>>>>   1 file changed, 18 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>>> index 84888eda990b2..5cca9d018bc89 100644
>>>> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>>> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
>>>> @@ -331,7 +331,12 @@ static void xilinx_mask_intx_irq(struct irq_data *data)
>>>>       unsigned long flags;
>>>>       u32 mask, val;
>>>>   -    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
>>>> +    /*
>>>> +     * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>>>> +     * In the controller regs this is represented in bits 0...3, so we need
>>>> +     * to subtract 1 here
>>>> +     */
>>>> +    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
>>>>       raw_spin_lock_irqsave(&port->lock, flags);
>>>>       val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>>       pcie_write(port, (val & (~mask)), XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>> @@ -344,7 +349,12 @@ static void xilinx_unmask_intx_irq(struct irq_data *data)
>>>>       unsigned long flags;
>>>>       u32 mask, val;
>>>>   -    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT);
>>>> +    /*
>>>> +     * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>>>> +     * In the controller regs this is represented in bits 0...3, so we need
>>>> +     * to subtract 1 here
>>>> +     */
>>>> +    mask = BIT(data->hwirq + XILINX_PCIE_DMA_IDRN_SHIFT - 1);
>>>>       raw_spin_lock_irqsave(&port->lock, flags);
>>>>       val = pcie_read(port, XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>>       pcie_write(port, (val | mask), XILINX_PCIE_DMA_REG_IDRN_MASK);
>>>> @@ -620,8 +630,13 @@ static irqreturn_t xilinx_pl_dma_pcie_intx_flow(int irq, void *args)
>>>>       val = FIELD_GET(XILINX_PCIE_DMA_IDRN_MASK,
>>>>               pcie_read(port, XILINX_PCIE_DMA_REG_IDRN));
>>>>   +    /*
>>>> +     * INTx hwirq: 1=INTA, 2=INTB, 3=INTC, 4=INTD
>>>> +     * In the controller regs this is represented in bits 0...3, so we need
>>>> +     * to add 1 here again for the registered handler
>>>> +     */
>>>>       for_each_set_bit(i, &val, PCI_NUM_INTX)
>>>> -        generic_handle_domain_irq(port->intx_domain, i);
>>>> +        generic_handle_domain_irq(port->intx_domain, i + 1);
>>>>       return IRQ_HANDLED;
>>>>   }
>>>>   
> 


