Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F242046E799
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 12:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhLILbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 06:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhLILbl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 06:31:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF04C061746;
        Thu,  9 Dec 2021 03:28:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 02BEACE25AD;
        Thu,  9 Dec 2021 11:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFF2C004DD;
        Thu,  9 Dec 2021 11:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639049284;
        bh=YuTVc0t94cbpvLs4mLvsGGUtRGZGrbgNbCZEu9G82uM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B+pe+vFHKfbubH8018U6gvVAsdFtIirIJCalN6EhI4dyZJ5JuEpDxz94hQsRwMhxH
         /LYK2S5dCya/YfVqPTcj2kEJyQDB9P0JeCFJenA84rjfekgx4pm6Sobg8M85+fS4Ho
         ZV+DVEUsWTsEj41LEp0SNrpevaRBj42pAILAAidD4x0BtqP/7b/S2tQK5tPymtbkal
         biH19t/d5PXxleFP3651kY+5HH3EsTbJKMcc6l/tYHoZKtru/qS44e43kHoxCcR7QP
         c+GMcraWIIhbCXItNTHBxxj8b+6sAHqvuF0rGPiNCa1aYY8LbBV26klBHnEEpUJyf9
         q61U0NO4MNGKQ==
Received: by pali.im (Postfix)
        id 08C1E111E; Thu,  9 Dec 2021 12:28:00 +0100 (CET)
Date:   Thu, 9 Dec 2021 12:28:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     bpeled@marvell.com, kostap@marvell.com, nadavh@marvell.com,
        stefanc@marvell.com, oferh@marvell.com,
        Marc St-Amand <mstamand@ciena.com>, mw@semihalf.com,
        jaz@semihalf.com
Cc:     thomas.petazzoni@bootlin.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, andrew@lunn.ch, robh+dt@kernel.org
Subject: Re: =?utf-8?B?W+KAnVBBVENI4oCdIHY=?= =?utf-8?Q?2?= 1/5] PCI:
 armada8k: Disable LTSSM on link down interrupts
Message-ID: <20211209112800.mhdi3oeko5eamfj4@pali>
References: <1618406454-7953-1-git-send-email-bpeled@marvell.com>
 <1618406454-7953-2-git-send-email-bpeled@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618406454-7953-2-git-send-email-bpeled@marvell.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 14 April 2021 16:20:50 bpeled@marvell.com wrote:
> From: Ben Peled <bpeled@marvell.com>
> 
> When a PCI link down condition is detected, the link training state
> machine must be disabled immediately.
> 
> Signed-off-by: Marc St-Amand <mstamand@ciena.com>
> Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
> Signed-off-by: Ben Peled <bpeled@marvell.com>
> ---
>  drivers/pci/controller/dwc/pcie-armada8k.c | 38 ++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
> index 13901f3..b2278b1 100644
> --- a/drivers/pci/controller/dwc/pcie-armada8k.c
> +++ b/drivers/pci/controller/dwc/pcie-armada8k.c
> @@ -54,6 +54,10 @@ struct armada8k_pcie {
>  #define PCIE_INT_C_ASSERT_MASK		BIT(11)
>  #define PCIE_INT_D_ASSERT_MASK		BIT(12)
>  
> +#define PCIE_GLOBAL_INT_CAUSE2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x24)
> +#define PCIE_GLOBAL_INT_MASK2_REG	(PCIE_VENDOR_REGS_OFFSET + 0x28)
> +#define PCIE_INT2_PHY_RST_LINK_DOWN	BIT(1)
> +
>  #define PCIE_ARCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x50)
>  #define PCIE_AWCACHE_TRC_REG		(PCIE_VENDOR_REGS_OFFSET + 0x54)
>  #define PCIE_ARUSER_REG			(PCIE_VENDOR_REGS_OFFSET + 0x5C)
> @@ -193,6 +197,11 @@ static void armada8k_pcie_establish_link(struct armada8k_pcie *pcie)
>  	       PCIE_INT_C_ASSERT_MASK | PCIE_INT_D_ASSERT_MASK;
>  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK1_REG, reg);
>  
> +	/* Also enable link down interrupts */
> +	reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
> +	reg |= PCIE_INT2_PHY_RST_LINK_DOWN;
> +	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, reg);
> +
>  	if (!dw_pcie_link_up(pci)) {
>  		/* Configuration done. Start LTSSM */
>  		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
> @@ -230,6 +239,35 @@ static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
>  	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG);
>  	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE1_REG, val);
>  
> +	val = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG);
> +
> +	if (PCIE_INT2_PHY_RST_LINK_DOWN & val) {
> +		u32 ctrl_reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
> +		/*
> +		 * The link went down. Disable LTSSM immediately. This
> +		 * unlocks the root complex config registers. Downstream
> +		 * device accesses will return all-Fs
> +		 */

Hello! This looks like some issue with PCIe HW. Does it mean that if
LTSSM is not disabled then Root Complex stuck or crash during processing
config requests from CPU? Or what else happens?

Could you provide more details what is the exact issue described in this
comment? And is there any Marvell errata about this particular "disable
LTSSM immediately" issue?

> +		ctrl_reg &= ~(PCIE_APP_LTSSM_EN);
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_CONTROL_REG, ctrl_reg);
> +		/*
> +		 * Mask link down interrupts. They can be re-enabled once
> +		 * the link is retrained.
> +		 */
> +		ctrl_reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG);
> +		ctrl_reg &= ~PCIE_INT2_PHY_RST_LINK_DOWN;
> +		dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_MASK2_REG, ctrl_reg);
> +		/*
> +		 * At this point a worker thread can be triggered to
> +		 * initiate a link retrain. If link retrains were
> +		 * possible, that is.
> +		 */
> +		dev_dbg(pci->dev, "%s: link went down\n", __func__);
> +	}
> +
> +	/* Now clear the second interrupt cause. */
> +	dw_pcie_writel_dbi(pci, PCIE_GLOBAL_INT_CAUSE2_REG, val);
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.7.4
> 
