Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F743ECB90
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 23:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhHOVzd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 15 Aug 2021 17:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230077AbhHOVzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 17:55:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E274E6138B;
        Sun, 15 Aug 2021 21:55:02 +0000 (UTC)
Received: from 109-170-232-56.xdsl.murphx.net ([109.170.232.56] helo=[127.0.0.1])
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mFO5s-005A7t-R6; Sun, 15 Aug 2021 22:55:00 +0100
Date:   Sun, 15 Aug 2021 22:55:01 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     =?ISO-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: aardvark: Fix masking MSI interrupts
User-Agent: K-9 Mail for Android
In-Reply-To: <20210815173659.2mjug3jffp6a4ybg@pali>
References: <20210815103624.19528-1-pali@kernel.org> <20210815103624.19528-3-pali@kernel.org> <87zgtizly3.wl-maz@kernel.org> <20210815173659.2mjug3jffp6a4ybg@pali>
Message-ID: <D64971ED-5502-4A7B-8176-B4FBF00CD80B@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 109.170.232.56
X-SA-Exim-Rcpt-To: pali@kernel.org, lorenzo.pieralisi@arm.com, thomas.petazzoni@bootlin.com, bhelgaas@google.com, robh@kernel.org, kw@linux.com, kabel@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 15 August 2021 18:36:59 BST, "Pali Rohár" <pali@kernel.org> wrote:
>On Sunday 15 August 2021 17:56:04 Marc Zyngier wrote:
>> On Sun, 15 Aug 2021 11:36:23 +0100,
>> Pali Rohár <pali@kernel.org> wrote:
>> > 
>> > Masking of individual MSI interrupts is done via PCIE_MSI_MASK_REG
>> > register. At the driver probe time mask all MSI interrupts and then let
>> > kernel IRQ chip code to unmask particular MSI interrupt when needed.
>> > 
>> > Signed-off-by: Pali Rohár <pali@kernel.org>
>> > Cc: stable@vger.kernel.org # f21a8b1b6837 ("PCI: aardvark: Move to MSI handling using generic MSI support")
>> > ---
>> >  drivers/pci/controller/pci-aardvark.c | 44 ++++++++++++++++++++++++---
>> >  1 file changed, 40 insertions(+), 4 deletions(-)
>> > 
>> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
>> > index bacfccee44fe..96580e1e4539 100644
>> > --- a/drivers/pci/controller/pci-aardvark.c
>> > +++ b/drivers/pci/controller/pci-aardvark.c
>> > @@ -480,12 +480,10 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>> >  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_REG);
>> >  	advk_writel(pcie, PCIE_IRQ_ALL_MASK, HOST_CTRL_INT_STATUS_REG);
>> >  
>> > -	/* Disable All ISR0/1 Sources */
>> > +	/* Disable All ISR0/1 and MSI Sources */
>> >  	advk_writel(pcie, PCIE_ISR0_ALL_MASK, PCIE_ISR0_MASK_REG);
>> >  	advk_writel(pcie, PCIE_ISR1_ALL_MASK, PCIE_ISR1_MASK_REG);
>> > -
>> > -	/* Unmask all MSIs */
>> > -	advk_writel(pcie, ~(u32)PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
>> > +	advk_writel(pcie, PCIE_MSI_ALL_MASK, PCIE_MSI_MASK_REG);
>> >  
>> >  	/* Unmask summary MSI interrupt */
>> >  	reg = advk_readl(pcie, PCIE_ISR0_MASK_REG);
>> > @@ -1026,6 +1024,40 @@ static int advk_msi_set_affinity(struct irq_data *irq_data,
>> >  	return -EINVAL;
>> >  }
>> >  
>> > +static void advk_msi_irq_mask(struct irq_data *d)
>> > +{
>> > +	struct advk_pcie *pcie = d->domain->host_data;
>> > +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
>> > +	u32 mask;
>> > +
>> > +	mask = advk_readl(pcie, PCIE_MSI_MASK_REG);
>> > +	mask |= BIT(hwirq);
>> > +	advk_writel(pcie, mask, PCIE_MSI_MASK_REG);
>> 
>> This isn't atomic, and will results in corruption when two MSIs are
>> masked/unmasked concurrently.
>
>Does it mean that also current implementation of masking legacy
>interrupt is incorrect?
>
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pci-aardvark.c?h=v5.13#n874

Yes, that's completely busted. If you have configuration registers that are shared between interrupts and that the HW doesn't provide set/clear accessors so that it can cope with such races, you need mutual exclusion.

You'd think people would have worked that one out.... 60 years ago?

        M.

Jazz is not dead, it just smells funny
