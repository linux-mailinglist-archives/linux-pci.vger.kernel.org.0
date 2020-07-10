Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6ED21BA8B
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 18:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbgGJQOa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 12:14:30 -0400
Received: from foss.arm.com ([217.140.110.172]:54820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgGJQO3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 12:14:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E06931B;
        Fri, 10 Jul 2020 09:14:27 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C05113F8F8;
        Fri, 10 Jul 2020 09:14:25 -0700 (PDT)
Date:   Fri, 10 Jul 2020 17:14:20 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Marc Zyngier <maz@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH v5 2/6] PCI: uniphier: Add misc interrupt handler to
 invoke PME and AER
Message-ID: <20200710161420.GA9019@e121166-lin.cambridge.arm.com>
References: <1592469493-1549-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1592469493-1549-3-git-send-email-hayashi.kunihiko@socionext.com>
 <87v9jcet5h.wl-maz@kernel.org>
 <c09ceb2f-0bf3-a5de-f918-1ccd0dba1e0a@socionext.com>
 <2a2bb86a4afcbd60d3399953b5af8b69@kernel.org>
 <95adf862-6c52-ddb9-b96a-e278a1925053@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95adf862-6c52-ddb9-b96a-e278a1925053@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 01, 2020 at 11:18:29AM +0900, Kunihiko Hayashi wrote:

[...]

> > > > >   -static void uniphier_pcie_irq_handler(struct irq_desc *desc)
> > > > > +static void uniphier_pcie_misc_isr(struct pcie_port *pp, bool is_msi)
> > > > >   {
> > > > > -    struct pcie_port *pp = irq_desc_get_handler_data(desc);
> > > > >       struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > >       struct uniphier_pcie_priv *priv = to_uniphier_pcie(pci);
> > > > > -    struct irq_chip *chip = irq_desc_get_chip(desc);
> > > > > -    unsigned long reg;
> > > > > -    u32 val, bit, virq;
> > > > > +    u32 val, virq;
> > > > >   -    /* INT for debug */
> > > > >       val = readl(priv->base + PCL_RCV_INT);
> > > > >         if (val & PCL_CFG_BW_MGT_STATUS)
> > > > >           dev_dbg(pci->dev, "Link Bandwidth Management Event\n");
> > > > > +
> > > > >       if (val & PCL_CFG_LINK_AUTO_BW_STATUS)
> > > > >           dev_dbg(pci->dev, "Link Autonomous Bandwidth Event\n");
> > > > > -    if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> > > > > -        dev_dbg(pci->dev, "Root Error\n");
> > > > > -    if (val & PCL_CFG_PME_MSI_STATUS)
> > > > > -        dev_dbg(pci->dev, "PME Interrupt\n");
> > > > > +
> > > > > +    if (is_msi) {
> > > > > +        if (val & PCL_CFG_AER_RC_ERR_MSI_STATUS)
> > > > > +            dev_dbg(pci->dev, "Root Error Status\n");
> > > > > +
> > > > > +        if (val & PCL_CFG_PME_MSI_STATUS)
> > > > > +            dev_dbg(pci->dev, "PME Interrupt\n");
> > > > > +
> > > > > +        if (val & (PCL_CFG_AER_RC_ERR_MSI_STATUS |
> > > > > +               PCL_CFG_PME_MSI_STATUS)) {
> > > > > +            virq = irq_linear_revmap(pp->irq_domain, 0);
> > > > > +            generic_handle_irq(virq);
> > > > > +        }
> > > > > +    }
> > > > 
> > > > Please have two handlers: one for interrupts that are from the RC,
> > > > another for interrupts coming from the endpoints.
> > > I assume that this handler treats interrupts from the RC only and
> > > this is set on the member ".msi_host_isr" added in the patch 1/6.
> > > I think that the handler for interrupts coming from endpoints should be
> > > treated as a normal case (after calling .msi_host_isr in
> > > dw_handle_msi_irq()).
> > 
> > It looks pretty odd that you end-up dealing with both from the
> > same "parent" interrupt. I guess this is in keeping with the
> > rest of the DW PCIe hacks... :-/
> 
> It might be odd, however, in case of UniPhier SoC,
> both MSI interrupts from endpoints and PME/AER interrupts from RC are
> asserted by same "parent" interrupt. In other words, PME/AER interrupts
> are notified using the parent interrupt for MSI.
> 
> MSI interrupts are treated as child interrupts with reference to
> the status register in DW core. This is handled in a for-loop in
> dw_handle_msi_irq().
> 
> PME/AER interrupts are treated with reference to the status register
> in UniPhier glue layer, however, this couldn't be handled in the same way
> directly.
> 
> So I'm trying to add .msi_host_isr function to handle this
> with reference to the SoC-specific registers.
> 
> This exported function asserts MSI-0 as a shared child interrupt.
> As a result, PME/AER are registered like the followings in dmesg:
> 
>    pcieport 0000:00:00.0: PME: Signaling with IRQ 25
>    pcieport 0000:00:00.0: AER: enabled with IRQ 25
> 
> And these interrupts are shared as MSI-0:
> 
>    # cat /proc/interrupts | grep 25:
>     25:          0          0          0          0   PCI-MSI   0 Edge      PCIe PME, aerdrv
> 
> This might be a special case, though, I think that this is needed to handle
> interrupts from RC sharing MSI parent.

Can you please send me (with this series *applied* of course and if
possible with an endpoint MSI/MSI-X capable enabled):

- full dmesg log
- lspci -vv output
- cat /proc/interrupts

I need to understand how this system HW works before commenting any
further.

> > It is for Lorenzo to make up his mind about this anyway.
> 
> I'd like to Lorenzo's opinion, too.

I am trying to understand how the HW is wired up (and that's what Marc
asked as well) so first things first, please send the logs.

Lorenzo
