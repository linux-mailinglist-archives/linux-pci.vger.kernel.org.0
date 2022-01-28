Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED44949FA64
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 14:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242119AbiA1NMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 08:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242032AbiA1NMx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 08:12:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18084C061714;
        Fri, 28 Jan 2022 05:12:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC69561CE5;
        Fri, 28 Jan 2022 13:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4E09C340E0;
        Fri, 28 Jan 2022 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643375572;
        bh=hnZj3GRXwJPT+qraKTLHubkxinTpbxOy1C5HyBFo+bo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=oG5u1pRW8K5zAnc1YjAEN5OwaQDE1tTLCcwVXf58QzkVeo/UrI+knhSTK8WQQmlK5
         0dDX/FsoIFPOpZuTdNoGtb0y2557VPbpTdhKIzqrRhwq4+78Iikna14SfliOab4E/y
         bINXa5iRSVvDNKFho2QebokIebk1lROgFqblXyI/NVl6B6K7RKV1IHRIV0j/R78HZn
         3O8Cv5aRejatYFZB4i/0iiS1D5DaAS7u0PfWAUmE2Pb1bQ8eXNpZUu+KyR+JmY6zre
         kKgk1AcHg2T1JpgyveFCzKEPeqITARaeXxFP1jVzoXOVdJ58DTii07cI8meiW3Pl7A
         Rqgq8Pugx06XQ==
Date:   Fri, 28 Jan 2022 07:12:50 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     "qizhong.cheng" <qizhong.cheng@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, chuanjia.liu@mediatek.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH] PCI: mediatek: Change MSI interrupt processing sequence
Message-ID: <20220128131250.GA200007@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r18s5jbn.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 08:57:16AM +0000, Marc Zyngier wrote:
> On Thu, 27 Jan 2022 21:21:00 +0000,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Wed, Jan 26, 2022 at 11:37:58AM +0800, qizhong.cheng wrote:
> > > On Tue, 2022-01-25 at 17:21 +0000, Marc Zyngier wrote:
> > > > On 2022-01-25 16:57, Bjorn Helgaas wrote:
> > > > > On Sun, Jan 23, 2022 at 11:33:06AM +0800, qizhong cheng wrote:
> > > > > > As an edge-triggered interrupts, its interrupt status should
> > > > > > be cleared before dispatch to the handler of device.
> > > > > 
> > > > > I'm not an IRQ expert, but the reasoning that "we should clear
> > > > > the MSI interrupt status before dispatching the handler because
> > > > > MSI is an edge-triggered interrupt" doesn't seem completely
> > > > > convincing because your code will now look like this:
> > > > > 
> > > > >   /* Clear the INTx */
> > > > >   writel(1 << bit, port->base + PCIE_INT_STATUS);
> > > > >   generic_handle_domain_irq(port->irq_domain, bit - INTX_SHIFT);
> > > > >   ...
> > > > > 
> > > > >   /* Clear MSI interrupt status */
> > > > >   writel(MSI_STATUS, port->base + PCIE_INT_STATUS);
> > > > >   generic_handle_domain_irq(port->inner_domain, bit);
> > > > > 
> > > > > You clear interrupt status before dispatching the handler for
> > > > > *both* level-triggered INTx interrupts and edge-triggered MSI
> > > > > interrupts.
> > > > > 
> > > > > So it doesn't seem that simply being edge-triggered is the
> > > > > critical factor here.
> > > > 
> > > > This is the usual problem with these half-baked implementations.
> > > > The signalling to the primary interrupt controller is level, as
> > > > they take a multitude of input and (crucially) latch the MSI
> > > > edges. Effectively, this is an edge-to-level converter, with all
> > > > the problems that this creates.
> > > > 
> > > > By clearing the status *after* the handling, you lose edges that
> > > > have been received and coalesced after the read of the status
> > > > register. By clearing it *before*, you are acknowledging the
> > > > interrupts early, and allowing them to be coalesced independently
> > > > of the ones that have been received earlier.
> > > > 
> > > > This is however mostly an educated guess. Someone with access to
> > > > the TRM should verify this.
> > > 
> > > Yes, as Maz said, we save the edge-interrupt status so that it
> > > becomes a level-interrupt. This is similar to an edge-to-level
> > > converter, so we need to clear it *before*. We found this problem
> > > through a lot of experiments and tested this patch.
> > 
> > I thought there might be other host controllers with similar design,
> > so I looked at all the other drivers and tried to figure out whether
> > any others had similar problems.
> > 
> > The ones below look suspicious to me because they all clear some sort
> > of status register *after* handling an MSI.  Can you guys take a look
> > and make sure they are working correctly?
> > 
> >   keembay_pcie_msi_irq_handler
> >     status = readl(pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS)
> >     if (status & MSI_CTRL_INT)
> >       dw_handle_msi_irq
> > 	generic_handle_domain_irq
> >       writel(status, pcie->apb_base + PCIE_REGS_INTERRUPT_STATUS)
> > 
> >   spear13xx_pcie_irq_handler
> >     status = readl(&app_reg->int_sts)
> >     if (status & MSI_CTRL_INT)
> >       dw_handle_msi_irq
> > 	generic_handle_domain_irq
> >     writel(status, &app_reg->int_clr)
> 
> I think these two are fine.
> 
> The top level interrupt is only a level signal that the is something
> to process. The only thing that is unclear is what the effect of
> writing to that status register if MSIs are pending at that point. A
> sane implementation would just ignore the write.
> 
> The actual processing is done in dw_handle_msi_irq(), reading the
> PCIE_MSI_INTR0_STATUS register. This same register is then used to Ack
> the interrupt, one bit at a time, as interrupts are handled (see
> dw_pci_bottom_ack). Ack taking place before the handling, it makes it
> safe for edge delivery.
> 
> >   advk_pcie_handle_int
> >     isr0_status = advk_readl(pcie, PCIE_ISR0_REG)
> >     if (isr0_status & PCIE_ISR0_MSI_INT_PENDING)
> >       advk_pcie_handle_msi
> >         advk_readl(pcie, PCIE_MSI_STATUS_REG)
> > 	advk_writel(pcie, BIT(msi_idx), PCIE_MSI_STATUS_REG)
> > 	generic_handle_irq
> > 	advk_writel(pcie, PCIE_ISR0_MSI_INT_PENDING, PCIE_ISR0_REG)
> 
> Same thing, I guess. It is just that the Ack has been open-coded.
> 
> >   mtk_pcie_irq_handler
> >     status = readl_relaxed(pcie->base + PCIE_INT_STATUS_REG)
> >     for_each_set_bit_from(irq_bit, &status, ...)
> >       mtk_pcie_msi_handler
> >         generic_handle_domain_irq
> >       writel_relaxed(BIT(irq_bit), pcie->base + PCIE_INT_STATUS_REG)
> 
> Similar thing. The PCIE_MSI_SET_STATUS register is read first, and
> then written back in the ack callback.

Thanks a lot for taking a look at these, Marc!  Is there anything we
can do to make all these drivers/pci/controller/* drivers more
consistent and easier to review?  I found it very difficult to look
across all of them and find similar design patterns.

Bjorn
