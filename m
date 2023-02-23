Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B16A10CD
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 20:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBWTsu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 14:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBWTsr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 14:48:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F8A2699;
        Thu, 23 Feb 2023 11:48:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F47861775;
        Thu, 23 Feb 2023 19:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD32C433D2;
        Thu, 23 Feb 2023 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677181720;
        bh=hDMlJ4mrMn3xHfWUWcjO9FR25t96BbUjPBdSDm11BJw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LHW2fwg5l3mU58E14JJrY2YRQGLFcCnFdi2udgGcLswUpwVqBA8wyDH8c+ZfTByRT
         qquB6Nm1qoDGNKDBHLtHXfdxu3pmtf4Cx1tC5OYuQgdqIJhwqsYP1OExDeN4Aydgg4
         TWkvOQcR8/hRPxvriD6Qmij4Cnb4W0q/I6wp54Ac0wRTCKjbtKZxPi3AZ4iDGIj6z1
         LA0MpXr5Ww/HN/6q/DkfnoFXNFSAcJHBH7U/HkWmtELQNDawaWddenHKOO37Ex2zWz
         WlIgbthq/3JtuqolC+5LGcaRn1PBAWKZbfblzH/MeyIGIsnrVB9QCphETVuoK819jr
         FYeGw0nMcHi1w==
Date:   Thu, 23 Feb 2023 13:48:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Elad Nachman <enachman@marvell.com>
Cc:     thomas.petazzoni@bootlin.com, bhelgaas@google.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        krzysztof.kozlowski+dt@linaro.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] PCI: dwc: support AC5 Legacy PCIe interrupts
Message-ID: <20230223194839.GA3889231@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223180531.15148-6-enachman@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 23, 2023 at 08:05:29PM +0200, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 
> Support message emulation of Legacy PCIe interrupts for Marvell AC5/X.
> These message emulations require writing an additional status register
> with acknowledge bits.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 41 +++++++++++++++-------
>  1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 02481ecadd25..145434c7a9fb 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -46,7 +46,7 @@ struct armada8k_pcie_of_data {
>  	const struct dw_pcie_ops *pcie_ops;
>  };
>  
> -#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is 0x10000 */
> +#define PCIE_VENDOR_REGS_OFFSET		0x8000	/* in ac5 is in another region */
>  
>  #define PCIE_GLOBAL_CONTROL_REG		(PCIE_VENDOR_REGS_OFFSET + 0x0)
>  #define PCIE_APP_LTSSM_EN		BIT(2)
> @@ -61,6 +61,7 @@ struct armada8k_pcie_of_data {
>  
>  #define PCIE_GLOBAL_INT_CAUSE1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x1C)
>  #define PCIE_GLOBAL_INT_MASK1_REG	(PCIE_VENDOR_REGS_OFFSET + 0x20)
> +#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x24)
>  #define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
>  #define PCIE_INT_A_ASSERT_MASK		BIT(9)
>  #define PCIE_INT_B_ASSERT_MASK		BIT(10)
> @@ -267,8 +268,14 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  	 */
>  	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
>  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
> -	if ((PCIE_MSI_MASK_AC5 & val) && (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5))
> -		dw_handle_msi_irq(&pci->pp);
> +	if (pcie->pcie_type == ARMADA8K_PCIE_TYPE_AC5) {
> +		if (PCIE_MSI_MASK_AC5 & val)
> +			dw_handle_msi_irq(&pci->pp);
> +
> +		val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG);
> +		/* Now clear the second interrupt cause. */
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG, val);
> +	}
>  
>  	return IRQ_HANDLED;
>  }
> @@ -307,24 +314,29 @@ static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
>  	return 0;
>  }
>  
> -static u32 ac5_xlate_dbi_reg(u32 reg)
> +static void __iomem *ac5_xlate_dbi_reg(struct dw_pcie *pci,
> +				       void __iomem *base,
> +				       u32 reg)
>  {
>  	/* Handle AC5 ATU access */
>  	if ((reg & ~0xfffff) == PCIE_ATU_ACCESS_MASK_AC5) {
>  		reg &= 0xfffff;
> -		/* ATU registers offset is 0xC00 + 0x200 * n,
> +		/* ATU registers offset is 0xC000 + 0x200 * n,
>  		 * from RFU registers.
>  		 */
> -		reg = 0xc000 | (0x200 * (reg >> 9)) | (reg & 0xff);
> +		reg = (0x200 * (reg >> 9)) | (reg & 0xff);

Is this change from 0xC00 to 0xC000 a bug fix?  This purports to only
add functionality.  A bug fix should be split to its own patch.

The armada8k_pcie_irq_handler() change above looks like it goes with
the commit log, but all this other stuff looks like separate logical
changes that should be in separate patches.

> +		return pci->atu_base + reg;
>  	} else if ((reg & 0xfffff000) == PCIE_VENDOR_REGS_OFFSET) {
>  		/* PCIe RFU registers in A8K are at offset 0x8000 from base
>  		 * (0xf2600000) while in AC5 offset is 0x10000 from base
> -		 * (0x800a0000) therefore need the addition of 0x8000.
> +		 * (0x800a0000) therefore need to be reduced by 0x8000
> +		 * and rebased from dbi2 base, which is set to the PCIe rfu
> +		 * base in the AC5 dts:
>  		 */
> -		reg += PCIE_VENDOR_REGS_OFFSET;
> +		reg -= PCIE_VENDOR_REGS_OFFSET;
> +		return pci->dbi_base2 + reg;
>  	}
> -
> -	return reg;
> +	return base + reg;
>  }
>  
>  static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> @@ -332,14 +344,14 @@ static u32 ac5_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
>  {
>  	u32 val;
>  
> -	dw_pcie_read(base + ac5_xlate_dbi_reg(reg), size, &val);
> +	dw_pcie_read(ac5_xlate_dbi_reg(pci, base, reg), size, &val);
>  	return val;
>  }
>  
>  static void ac5_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
>  			       u32 reg, size_t size, u32 val)
>  {
> -	dw_pcie_write(base + ac5_xlate_dbi_reg(reg), size, val);
> +	dw_pcie_write(ac5_xlate_dbi_reg(pci, base, reg), size, val);
>  }
>  
>  static const struct dw_pcie_ops armada8k_dw_pcie_ops = {
> @@ -418,7 +430,6 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(pci->dbi_base);
>  		goto fail_clkreg;
>  	}
> -
>  	ret = armada8k_pcie_setup_phys(pcie);
>  	if (ret)
>  		goto fail_clkreg;
> @@ -429,6 +440,10 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto disable_phy;
>  
> +	/* backwards compatibility with older dts files: */
> +	if (!pci->dbi_base2)
> +		pci->dbi_base2 = pci->dbi_base;
> +
>  	return 0;
>  
>  disable_phy:
> -- 
> 2.17.1
> 
