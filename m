Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946783ECBBD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 01:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhHOXLD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 19:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:52112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229814AbhHOXLD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 19:11:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A20D61251;
        Sun, 15 Aug 2021 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629069032;
        bh=skriyEpHw6LYKqfD8RGIATW7kPXI6c7SBxwYbLU9Yuw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZqR/Qxx+HJAm+C765qX8+867sPGjrgzdExlAU7FkmUiy0Y8c6WEVV5qC4/9B1p1CF
         2t90+L8z5LMYSP6Gf4fI5PW9RYml8vRJf7MI5JZhW3gfVsXmLXkTymPi3CAYyRepnC
         4L3Ci9cYYaWLWQKsQTmEX7t+hEJDEbV3AX9Moo94+wSKCs/ck5PLw6plySnQTWAeZq
         M9YnW169SVOiJw4Lh/IFUcWHuodDzJbMHS/fQNgVm5zOkaAINZKCgW0o3pmZEvTqvW
         qhlJl/w5J1450Ez9eO9zX/2Fx1uJlAQmWNuQ9LOyfVUQd5CVKqeO7Quj6kBNfvm1f2
         kevsUA3rnXscg==
Received: by pali.im (Postfix)
        id 1DB3E98C; Mon, 16 Aug 2021 01:10:30 +0200 (CEST)
Date:   Mon, 16 Aug 2021 01:10:29 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: aardvark: Fix masking MSI interrupts
Message-ID: <20210815231029.4qtejl5mwvc7o5vc@pali>
References: <20210815103624.19528-1-pali@kernel.org>
 <20210815103624.19528-3-pali@kernel.org>
 <87zgtizly3.wl-maz@kernel.org>
 <20210815173659.2mjug3jffp6a4ybg@pali>
 <D64971ED-5502-4A7B-8176-B4FBF00CD80B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D64971ED-5502-4A7B-8176-B4FBF00CD80B@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sunday 15 August 2021 22:55:01 Marc Zyngier wrote:
> On 15 August 2021 18:36:59 BST, "Pali Rohár" <pali@kernel.org> wrote:
> >On Sunday 15 August 2021 17:56:04 Marc Zyngier wrote:
> >> On Sun, 15 Aug 2021 11:36:23 +0100,
> >> Pali Rohár <pali@kernel.org> wrote:
> >> > 
> >> > Masking of individual MSI interrupts is done via PCIE_MSI_MASK_REG
> >> > register. At the driver probe time mask all MSI interrupts and then let
> >> > kernel IRQ chip code to unmask particular MSI interrupt when needed.
> >> > 
> >> > Signed-off-by: Pali Rohár <pali@kernel.org>
> >> > Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
> >> > ---
> >> >  drivers/pci/controller/pci-aardvark.c | 44 ++++++++++++++++++++++++---
> >> >  1 file changed, 40 insertions(+), 4 deletions(-)
> >> > 
> >> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> >> > index bacfccee44fe..96580e1e4539 100644
> >> > --- a/drivers/pci/controller/pci-aardvark.c
> >> > +++ b/drivers/pci/controller/pci-aardvark.c
> >> > @@ -480,12 +480,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >> >  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
> >> >  	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
> >> >  
> >> > -	/* Disable All ISR0/1 Sources */
> >> > +	/* Disable All ISR0/1 and MSI Sources */
> >> >  	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
> >> >  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
> >> > -
> >> > -	/* Unmask all MSIs */
> >> > -	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
> >> > +	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
> >> >  
> >> >  	/* Unmask summary MSI interrupt */
> >> >  	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
> >> > @@ -1026,6 +1024,40 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
> >> >  	return -EINVAL;
> >> >  }
> >> >  
> >> > +static void advk_msi_irq_mask(struct irq_data *d)
> >> > +{
> >> > +	struct advk_pcie *pcie = d->domain->host_data;
> >> > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> >> > +	u32 mask;
> >> > +
> >> > +	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
> >> > +	mask |= BIT(hwirq);
> >> > +	advk_writel(pcie, mask, PCIE_MSI_MASK_REG);
> >> 
> >> This isn't atomic, and will results in corruption when two MSIs are
> >> masked/unmasked concurrently.
> >
> >Does it mean that also current implementation of masking legacy
> >interrupt is incorrect?
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-aardvark.c?h=v5.13#n874
> 
> Yes, that's completely busted. If you have configuration registers that are shared between interrupts and that the HW doesn't provide set/clear accessors so that it can cope with such races, you need mutual exclusion.

I see... I did not think about it in this patch as I used same pattern
as was already used for legacy interrupts...

I will this issue for both MSI and legacy interrupts.

Anyway, it looks like that exactly same issue is in pcie-uniphier.c and
pci-ftpci100.c drivers:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-uniphier.c?h=v5.13#n171
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-ftpci100.c?h=v5.13#n270

> You'd think people would have worked that one out.... 60 years ago?
> 
>         M.
> 
> Jazz is not dead, it just smells funny
