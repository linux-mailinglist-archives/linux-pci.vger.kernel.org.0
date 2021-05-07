Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ECE3762D1
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhEGJ2a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 05:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236161AbhEGJ2a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 05:28:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5512D61458;
        Fri,  7 May 2021 09:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620379650;
        bh=csddv0C3kpCopbm0HPZCluNx22VYvpHDPZOkOnBwaCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k0QqSVCduhRhkQ6kBFwsukaidpe2bkA3lQnDV3S55gDyFAvF0qnykR1hc9r6xPzt0
         tNSEYj1/LIb74hbd9Bq0d093i4C+gs2ov5S5RA19iauJ+Bi/PczsJ6MCdQKSkc6GtG
         tCLCZaZx2LUkXsnSK7QC3z5ubdfIeDwC+dxe2JFpNVuG8psYmMfeF2P5vyoqDr0CDy
         W7pklW//gUNs2wZzXCOA6XI+b4TbptTq3GwFMqX/ceRkjLH47f6cn5K1VmwIl0Yic2
         oCMuEwsdveCfrYuDojtxA7l2Bydm/VBifT5tPRt5z9cKGcg9OgOUAaXRpr5SodHWdf
         WjuSyDBX1gQuQ==
Received: by pali.im (Postfix)
        id 8C88C7E0; Fri,  7 May 2021 11:27:27 +0200 (CEST)
Date:   Fri, 7 May 2021 11:27:27 +0200
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
Subject: Re: [PATCH 14/42] PCI: aardvark: Don't mask irq when mapping
Message-ID: <20210507092727.mavcwkwu3qcgzyw5@pali>
References: <20210506153153.30454-1-pali@kernel.org>
 <20210506153153.30454-15-pali@kernel.org>
 <87eeeiq4rc.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eeeiq4rc.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 07 May 2021 10:20:39 Marc Zyngier wrote:
> On Thu, 06 May 2021 16:31:25 +0100,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > By default, all Legacy INTx interrupts are masked, so there is no need to
> > mask this interrupt during irq_map callback.
> 
> What guarantees that they are actually masked? I would actually assume
> that the HW is in an unknown state at boot time.

Function advk_pcie_setup_hw() during driver probing mask all INTx interrupts:

    advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);

Individual INTx interrupts can be unmasked by PCIE_ISR1_INTX_ASSERT(val).
Macro PCIE_ISR1_ALL_MASK contains all bits from PCIE_ISR1_INTX_ASSERT(val).

> Thanks,
> 
> 	M.
> 
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <kabel@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index 2aced8c9ae9f..08f1157e1c5e 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -940,7 +940,6 @@ static int advk_pcie_irq_map(struct irq_domain *h,
> >  {
> >  	struct advk_pcie *pcie = h->host_data;
> >  
> > -	advk_pcie_irq_mask(irq_get_irq_data(virq));
> >  	irq_set_status_flags(virq, IRQ_LEVEL);
> >  	irq_set_chip_and_handler(virq, &pcie->irq_chip,
> >  				 handle_level_irq);
> > -- 
> > 2.20.1
> > 
> > 
> 
> -- 
> Without deviation from the norm, progress is not possible.
