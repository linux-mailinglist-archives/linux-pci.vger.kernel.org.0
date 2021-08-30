Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592153FB99D
	for <lists+linux-pci@lfdr.de>; Mon, 30 Aug 2021 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237791AbhH3QAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 12:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237857AbhH3QAm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Aug 2021 12:00:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D10A60F56;
        Mon, 30 Aug 2021 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630339188;
        bh=RKKJL2Oa462dloe2S2b4LJnqrOSFWbJ15BpzgjMEaKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxR5WdMPVmngFeWeWo2gCYUQI+j4hJZNKUfhSAHJ5qMH+MD8/366tZOqAEVTd73gy
         aj4IDHh+My+406/Zcu0nw6f2nx3DZJmwEz2dcqTAdsmtOY1Xr3/6LQK1D3+F1HhfKL
         jzBv/27DFJ1cERXdkJXblORGMAk14ucEywveq7AOvfzBN7uS3U2hBR19MrkCSiJ6xM
         u4uOrbieaCo+ecNfTo117zz7ii474eYRIC3px17mUrgDdyHIIPxzTI/0xDd+/TjmAA
         Dlx3KOmpyUM9cURws+wVLTSljB18BoGsXBM1LvlbtUQplrdve3J9fVnHhEg3Oe0uU3
         5agCrqJHMpXYw==
Received: by pali.im (Postfix)
        id C8A537B8; Mon, 30 Aug 2021 17:59:45 +0200 (CEST)
Date:   Mon, 30 Aug 2021 17:59:45 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: uniphier: Fix INTx mask/unmask bit operation
 and remove ack function
Message-ID: <20210830155945.yuirq5tsy2migovk@pali>
References: <1630290158-31264-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1630290158-31264-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1630290158-31264-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 30 August 2021 11:22:37 Kunihiko Hayashi wrote:
> INTX mask and unmask fields in PCL_RCV_INTX register should only be
> set/reset for each bit. Clearing by PCL_RCV_INTX_ALL_MASK should be
> removed.
> 
> INTX status fields in PCL_RCV_INTX register only indicates each INTX
> interrupt status, so the handler can't clear by writing 1 to the field.
> The status is expected to be cleared by the interrupt origin.
> The ack function has no meaning, so should remove it.
> 
> Fixes: 7e6d5cd88a6f ("PCI: uniphier: Add UniPhier PCIe host controller support")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/pci/controller/dwc/pcie-uniphier.c | 16 ----------------
>  1 file changed, 16 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
> index ebe43e9..26f630c 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
> @@ -181,19 +181,6 @@ static void uniphier_pcie_irq_enable(struct uniphier_pcie_priv *priv)
>  	writel(PCL_RCV_INTX_ALL_ENABLE, priv->base + PCL_RCV_INTX);
>  }
>  
> -static void uniphier_pcie_irq_ack(struct irq_data *d)
> -{
> -	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> -	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> -	struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> -	u32 val;
> -
> -	val = readl(priv->base + PCL_RCV_INTX);
> -	val &= ~PCL_RCV_INTX_ALL_STATUS;
> -	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_STATUS_SHIFT);
> -	writel(val, priv->base + PCL_RCV_INTX);
> -}
> -
>  static void uniphier_pcie_irq_mask(struct irq_data *d)
>  {
>  	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
> @@ -202,7 +189,6 @@ static void uniphier_pcie_irq_mask(struct irq_data *d)
>  	u32 val;
>  
>  	val = readl(priv->base + PCL_RCV_INTX);
> -	val &= ~PCL_RCV_INTX_ALL_MASK;
>  	val |= BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
>  	writel(val, priv->base + PCL_RCV_INTX);
>  }
> @@ -215,14 +201,12 @@ static void uniphier_pcie_irq_unmask(struct irq_data *d)
>  	u32 val;
>  
>  	val = readl(priv->base + PCL_RCV_INTX);
> -	val &= ~PCL_RCV_INTX_ALL_MASK;
>  	val &= ~BIT(irqd_to_hwirq(d) + PCL_RCV_INTX_MASK_SHIFT);
>  	writel(val, priv->base + PCL_RCV_INTX);
>  }
>  
>  static struct irq_chip uniphier_pcie_irq_chip = {
>  	.name = "PCI",
> -	.irq_ack = uniphier_pcie_irq_ack,
>  	.irq_mask = uniphier_pcie_irq_mask,
>  	.irq_unmask = uniphier_pcie_irq_unmask,
>  };
> -- 
> 2.7.4
> 
