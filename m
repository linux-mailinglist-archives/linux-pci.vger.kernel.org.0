Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DA33F182E
	for <lists+linux-pci@lfdr.de>; Thu, 19 Aug 2021 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhHSL3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Aug 2021 07:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:56720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231210AbhHSL3q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 19 Aug 2021 07:29:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45DBE610D2;
        Thu, 19 Aug 2021 11:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629372550;
        bh=A7r+csymhYMGfcbq2KwxlTUQKlQXRKL2+USLxiLcJfU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WAh1lKewT/u6UyP5EyuSQZNrpLQMxqMwfAdWNqC/PbBcn9pQRixOeRr26w3vJTqEN
         tJgZTHWTOmonxVMnj19cjybfkOwowYJdS+JNSgQ/chfIz9EM5RpViuD6q89CYd31jc
         dp7pFNdZTk8DQ4cQrYGv8mOvmSumiouY2uDXV5VLjUbdKjZAHU3pz2X8+A5hFRIMJQ
         HtJQs4B5BGpAyyPISdv2mggP8HwY3fsifiKsusa+cphLf0FA7rdEN2nliTYA9bMItw
         7v3EJg6aNugSIqA3pceKra1x5VjmLLEu3mewzC+DJHeauxJ3tF2K29+Ya8ZdTxnxHo
         f6JYpMDwrJsug==
Date:   Thu, 19 Aug 2021 06:29:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?B?V2lsY3p577+977+977+9c2tp?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Pali =?utf-8?B?Um9o77+977+977+9cg==?= <pali@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: uniphier: Take lock in INTX irq_{mask,unmask,ack}
 callbacks
Message-ID: <20210819112908.GA3188927@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1629370566-29984-1-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Possibly update subject to be more descriptive, along lines of:

  Serialize INTx masking/unmasking

On Thu, Aug 19, 2021 at 07:56:06PM +0900, Kunihiko Hayashi wrote:
> The same condition register PCI_RCV_INTX is used in irq_mask(),
> irq_unmask() and irq_ack() callbacks. Accesses to register can occur at the
> same time without lock.
> This introduces a lock into the callbacks to prevent the issue.

Rewrap into a single paragraph or add blank line between paragraphs.

s/This introduces/Add/ to make this an imperative description of what
you want this patch to do.  No need for "This" since the context is
obvious.

> Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
> Suggested-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index ebe43e9..5075714 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -186,12 +186,17 @@ static void uniphier_pcie_irq_ack(struct irq_data *d)
>  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	unsigned long flags;
>  	u32 val;
>  
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
>  	val = readl(priv->base + PCL_RCV_INTX);
>  	val &= ~PCL_RCV_INTX_ALL_STATUS;
>  	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
>  	writel(val, priv->base + PCL_RCV_INTX);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
>  static void uniphier_pcie_irq_mask(struct irq_data *d)
> @@ -199,12 +204,17 @@ static void uniphier_pcie_irq_mask(struct irq_data *d)
>  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	unsigned long flags;
>  	u32 val;
>  
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
>  	val = readl(priv->base + PCL_RCV_INTX);
>  	val &= ~PCL_RCV_INTX_ALL_MASK;
>  	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
>  	writel(val, priv->base + PCL_RCV_INTX);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
>  static void uniphier_pcie_irq_unmask(struct irq_data *d)
> @@ -212,12 +222,17 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
>  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
>  	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> +	unsigned long flags;
>  	u32 val;
>  
> +	raw_spin_lock_irqsave(&pp->lock, flags);
> +
>  	val = readl(priv->base + PCL_RCV_INTX);
>  	val &= ~PCL_RCV_INTX_ALL_MASK;
>  	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
>  	writel(val, priv->base + PCL_RCV_INTX);
> +
> +	raw_spin_unlock_irqrestore(&pp->lock, flags);
>  }
>  
>  static struct irq_chip uniphier_pcie_irq_chip = {
> -- 
> 2.7.4
> 
