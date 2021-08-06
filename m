Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6CE3E2636
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 10:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235706AbhHFIfl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 04:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230402AbhHFIfl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Aug 2021 04:35:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 533FB6103B;
        Fri,  6 Aug 2021 08:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628238925;
        bh=r/jt/bwS5Mu+/PWPG2JP24q/2RTJtkOEgqxhzR31BDk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eaM/i86fYsCSOGI9sCP6jL/YQnVwy3LrX02kWKRFynQAQ1x3XXuKG3kXkrny7Hrfi
         jT0zmDXS18TxM5nUIFQ866rh7WVgEr+SMI4Y7g/z5GI5cNQEjKiwMrtoL01//qG6QW
         PGHrDu+bPa6IdQY5SoBie4C7ZAf+zU6Q61vGPm2CYdLWdm3Zx8CV51nyE71p0zZNO7
         qYiQarMUU0bVqtb97xRTBYBhO/Fl40o028Je6l5hqHrJs4SApZGxVLR+evTq5MOnHm
         rsQLE8DbAukKr4ebrhNbfcQfeudNHwExcLEIwiBjWtaKP5otkwquNdfsXGmM5wQ6nm
         Oa1I5kj8GLxHw==
Received: by pali.im (Postfix)
        id 02027768; Fri,  6 Aug 2021 10:35:22 +0200 (CEST)
Date:   Fri, 6 Aug 2021 10:35:22 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI: aardvark: Correctly clear and unmask all MSI
 interrupts
Message-ID: <20210806083522.arnxu7cikgzn73b4@pali>
References: <20210625090319.10220-1-pali@kernel.org>
 <20210625090319.10220-7-pali@kernel.org>
 <fb3a7ef15397292692b6d5dd0d2e439e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb3a7ef15397292692b6d5dd0d2e439e@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 06 August 2021 09:32:24 Marc Zyngier wrote:
> On 2021-06-25 10:03, Pali Rohár wrote:
> > Define a new macro PCIE_MSI_ALL_MASK and use it for masking, unmasking
> > and
> > clearing all MSI interrupts.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c
> > b/drivers/pci/controller/pci-aardvark.c
> > index 0e81d89f307d..7cad6d989f6c 100644
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
> > @@ -470,19 +471,22 @@ static void advk_pcie_setup_hw(struct advk_pcie
> > *pcie)
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
> > +
> > +	/* Unmask summary MSI interrupt */
> > +	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> > +	reg &= ~PCIE_ISR0_MSI_INT_PENDING;
> > +	advk_writel(pcie, reg, PCIE_ISR0_MASK_REG);
> > 
> >  	/* Enable summary interrupt for GIC SPI source */
> >  	reg = PCIE_IRQ_ALL_MASK & (~PCIE_IRQ_ENABLE_INTS_MASK);
> > @@ -1177,7 +1181,7 @@ static void advk_pcie_handle_msi(struct advk_pcie
> > *pcie)
> > 
> >  	msi_mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
> >  	msi_val = advk_readl(pcie, PCIE_MSI_STATUS_REG);
> > -	msi_status = msi_val & ~msi_mask;
> > +	msi_status = msi_val & ((~msi_mask) & PCIE_MSI_ALL_MASK);
> > 
> >  	for (msi_idx = 0; msi_idx < MSI_IRQ_NUM; msi_idx++) {
> >  		if (!(BIT(msi_idx) & msi_status))
> 
> This still begs the question: why would you ever enable all
> MSIs the first place? They should be enabled on request only.

This is going to be fixed in followup patches. Just Lorenzo asked to
send smaller patch series, so I have to split that followup fix into
the next round.

>         M.
> -- 
> Jazz is not dead. It just smells funny...
