Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864833F4D0C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Aug 2021 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhHWPKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Aug 2021 11:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:48212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhHWPKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Aug 2021 11:10:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9AB66138B;
        Mon, 23 Aug 2021 15:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629731370;
        bh=f3rsW+0LyIsVSAKVx1eEOAVgIHq6gwAh3gFMIEplg1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gqh5izcSoZ2LNx7RYh+fCMopNprAIy9ZYHnzOE1/lQ6xTgoC7YJX+cdgammbxiRxp
         1H+kKkkczgensxFtYgOQszupalH2jlae09uScfPqhxf5zSZHMsKG+2xp4QiDp/ElV1
         Bi+zeJqf3dwNh+0ROtvP2dX2DO1yBUldSehHWIhOEOl8iHq0limfHH31GIbBcVTf6R
         LA8TlVRWu/23DXTqQDkA9ZNWrVLa6z5zZsyuA5SBIPURXzDGhwIb7OzmsNn4nA9VyZ
         ivWkW6/mltWbUKU6z7F7SzHyMCZB9J3Qz2PWehkqHclSWofffKdwLUiPxbnq3+rLEV
         zFvL40kAxK/Ng==
Received: by pali.im (Postfix)
        id C08A5FC2; Mon, 23 Aug 2021 17:09:27 +0200 (CEST)
Date:   Mon, 23 Aug 2021 17:09:27 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: uniphier: Serialize INTx masking/unmasking
Message-ID: <20210823150927.jhobzfxy6e4s663r@pali>
References: <1629717500-19396-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1629717500-19396-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Marc (who originally reported this issue)

On Monday 23 August 2021 20:18:20 Kunihiko Hayashi wrote:
> The condition register PCI_RCV_INTX is used in irq_mask(), irq_unmask()
> and irq_ack() callbacks. Accesses to register can occur at the same time
> without a lock.
> Add a lock into each callback to prevent the issue.
> 
> Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
> Suggested-by: Pali Rohár <pali@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> The previous patch is as follows:
> https://lore.kernel.org/linux-pci/1629370566-29984-1-git-send-email-hayashi.kunihiko@socionext.com/
> 
> Changes in the previous patch:
> - Change the subject and commit message
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
