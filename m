Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA0376384
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 12:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhEGKWl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 06:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:41812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhEGKWi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 06:22:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBB6860C40;
        Fri,  7 May 2021 10:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620382899;
        bh=TZ9sCKTbIqqQ81iNcNTXoW8/zSUzA5koDg2jUaT7G34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hkggX8TkJtaei/NLABJgjcbdtYfSYGUTROHHNCSXY3ZmZJsuoDCED9/C6icfTvfC8
         Ee08oeEh9+GEfP06RQtx4vnVo4wcrKM1EYazgHVhw0usbILahlAjC7kkfgpY0iD0ag
         eXbntBTx2Yx3x7bcirNvIe+VnHG4zDIHxQuW4jtoeurQXsfA01XeJvxPC6JyBJyC6m
         5UT7vHr9xszx7GUPG0DcRgPrOXpHQ0Hu5Djl0ZOcwCeVnzvwZzA0bmG0LMGgkyKIgE
         Cxd/KHnYSzNWJXddAFgEiWcOllt+6AiqAjKsEQyNm+90VOo0yG7+xWAICL+kcFGatJ
         xUDJWLVM8QAqQ==
Received: by pali.im (Postfix)
        id 5873D7E0; Fri,  7 May 2021 12:21:36 +0200 (CEST)
Date:   Fri, 7 May 2021 12:21:36 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/42] PCI: aardvark: Correctly clear and unmask all MSI
 interrupts
Message-ID: <20210507102136.2mlov44cywayzldt@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210506153153.30454-19-pali@kernel.org>
 <87bl9mq20r.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bl9mq20r.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 May 2021 11:19:48 Marc Zyngier wrote:
> On Thu, 06 May 2021 16:31:29 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > Define a new macro PCIE_MSI_ALL_MASK and use it for masking, unmasking and
> > clearing all MSI interrupts.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 498810c00b6d..5e0243b2c473 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -117,6 +117,7 @@
> >  #define PCIE_MSI_ADDR_HIGH_REG			(CONTROL_BASE_ADDR + 0x54)
> >  #define PCIE_MSI_STATUS_REG			(CONTROL_BASE_ADDR + 0x58)
> >  #define PCIE_MSI_MASK_REG			(CONTROL_BASE_ADDR + 0x5C)
> > +#define     PCIE_MSI_ALL_MASK			GENMASK(31, 0)
> >  #define PCIE_MSI_PAYLOAD_REG			(CONTROL_BASE_ADDR + 0x9C)
> >  #define     PCIE_MSI_DATA_MASK			GENMASK(15, 0)
> >  
> > @@ -386,19 +387,22 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  	advk_writel(pcie, reg, PCIE_CORE_CTRL2_REG);
> >  
> >  	/* Clear all interrupts */
> > +	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_STATUS_REG);
> >  	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_REG);
> >  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
> >  	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
> >  
> >  	/* Disable All ISR0/1 Sources */
> > -	reg = PCIE_ISR0_ALL_MASK;
> > -	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
> > -	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
> > -
> > +	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
> >  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
> >  
> >  	/* Unmask all MSIs */
> > -	advk_writel(pcie, 0, PCIE_MSI_MASK_REG);
> > +	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
> 
> I really wonder why you'd unmask all MSIs. Yes, the current code does
> that already, but I'd expect MSIs to be individually unmasked as they
> get enabled by the core code.

Individual unmasking is implemented in later patches in this patch series.

> Thanks,
> 
> 	M.
> 	
> > +
> > +	/* Unmask summary MSI interrupt */
> > +	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> > +	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
> > +	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
> >  
> >  	/* Enable summary interrupt for GIC SPI source */
> >  	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
> > @@ -1049,7 +1053,7 @@ static void advk_pcie_handle_msi(struct advk_pcie *pcie)
> >  
> >  	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
> >  	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
> > -	msi_status = msi_val & ~msi_mask;
> > +	msi_status = msi_val & ((~msi_mask) & PCIE_MSI_ALL_MASK);
> >  
> >  	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
> >  		if (!(BIT(msi_idx) & msi_status))
> > -- 
> > 2.20.1
> > 
> > 
> 
> -- 
> Without deviation from the norm, progress is not possible.
