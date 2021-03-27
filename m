Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CEE34B91D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 20:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhC0T3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 15:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhC0T2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Mar 2021 15:28:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6761761984;
        Sat, 27 Mar 2021 19:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616873320;
        bh=wCnLXRJnoXnToeP+RQYUH5Bypi+1WeuwPi/OXoLDisw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVt6NCGU0mQHdwaDTQY1PSp+lqJUSv1OwY+d4C+y3QlmblU9TtG29gRg5JMPqK24u
         S/AtJDE2VVPrXSV4vFM/kXzYz1c0pXLtN/D4Z6RAmq9Y0Q5dWezInkNygT+IxqbfHB
         pD3/4qRipDqUXJGz2HxSh12Od1NU20nsNh1v/jIVkwwdLzJ02PMJnZSZ0d9MAXs90u
         bIfeqKa55tVHueKBRfvJA4DN8nofrM8e0baSkHXYNXoDl1qi+vqB8Hdngcxr2RV9PI
         Uce+puhZytHYpzlMEi1NecafV1NGQtrX8yT+5p5nza2+NdkW/YvzXfPStqvbqHYwPn
         Lu4gKr5j5wBDw==
Received: by pali.im (Postfix)
        id B5EFE95D; Sat, 27 Mar 2021 20:28:37 +0100 (CET)
Date:   Sat, 27 Mar 2021 20:28:37 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com,
        Krzysztof Wilczyski <kw@linux.com>
Subject: Re: [v9,5/7] PCI: mediatek-gen3: Add MSI support
Message-ID: <20210327192837.4rr46oeiuokritlc@pali>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
 <20210324030510.29177-6-jianjun.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324030510.29177-6-jianjun.wang@mediatek.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 24 March 2021 11:05:08 Jianjun Wang wrote:
> +static void mtk_pcie_msi_handler(struct mtk_pcie_port *port, int set_idx)
> +{
> +	struct mtk_msi_set *msi_set = &port->msi_sets[set_idx];
> +	unsigned long msi_enable, msi_status;
> +	unsigned int virq;
> +	irq_hw_number_t bit, hwirq;
> +
> +	msi_enable = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
> +
> +	do {
> +		msi_status = readl_relaxed(msi_set->base +
> +					   PCIE_MSI_SET_STATUS_OFFSET);
> +		msi_status &= msi_enable;
> +		if (!msi_status)
> +			break;
> +
> +		for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
> +			hwirq = bit + set_idx * PCIE_MSI_IRQS_PER_SET;
> +			virq = irq_find_mapping(port->msi_bottom_domain, hwirq);
> +			generic_handle_irq(virq);
> +		}
> +	} while (true);

Hello!

Just a question, cannot this while-loop cause block of processing other
interrupts?

I have done tests with different HW (aardvark) but with same while(true)
loop logic. One XHCI PCIe controller was sending MSI interrupts too fast
and interrupt handler with this while(true) logic was in infinite loop.
During one IRQ it was calling infinite many times generic_handle_irq()
as HW was feeding new and new MSI hwirq into status register.

But this is different HW, so it can have different behavior and does not
have to cause above issue.

I have just spotted same code pattern for processing MSI interrupts...

> +}
> +
>  static void mtk_pcie_irq_handler(struct irq_desc *desc)
>  {
>  	struct mtk_pcie_port *port = irq_desc_get_handler_data(desc);
> @@ -405,6 +673,14 @@ static void mtk_pcie_irq_handler(struct irq_desc *desc)
>  		generic_handle_irq(virq);
>  	}
>  
> +	irq_bit = PCIE_MSI_SHIFT;
> +	for_each_set_bit_from(irq_bit, &status, PCIE_MSI_SET_NUM +
> +			      PCIE_MSI_SHIFT) {
> +		mtk_pcie_msi_handler(port, irq_bit - PCIE_MSI_SHIFT);
> +
> +		writel_relaxed(BIT(irq_bit), port->base + PCIE_INT_STATUS_REG);
> +	}
> +
>  	chained_irq_exit(irqchip, desc);
>  }
>  
> -- 
> 2.25.1
> 
