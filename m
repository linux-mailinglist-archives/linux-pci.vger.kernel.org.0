Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2075434B94F
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 21:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhC0U3Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 27 Mar 2021 16:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhC0U3I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 27 Mar 2021 16:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 714E361934;
        Sat, 27 Mar 2021 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616876947;
        bh=t3YCJEd2YPJjPW/VVlG0IFWi7wn9Hjx67R3VG5hzcl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OVgsxOpRvQIxqPE+tVlAfHUdu4Ht9oWDHCLAsjOE+vmFKOWwLTVll1/pMalxxguzz
         2ABiCxzQfFjMsFbKs2dU1YJOawTUQHpaZ4upIfCNQyEdjgxPdF4BJGNrBSRdLmzubC
         MrIO4ZKx6Zwh+dcpDQPtcptA5fgGib+YCGrJbfpR+O5i7Qivb1uDlQdJ5vV8dqLpbI
         p6Sc1hHEyjZFotDKbVpYjg+CT5IffrUtBP88CF1gWk6yteub0wDpelOOuv47JyeJo1
         O0UK0jSAQSrvNT3blPK/jMLrwouakf5paB4o//qwQmiJrbGHv+QsiV3eRlqictBVn1
         j1cI2jkt4CQKQ==
Received: by pali.im (Postfix)
        id F180A95D; Sat, 27 Mar 2021 21:29:04 +0100 (CET)
Date:   Sat, 27 Mar 2021 21:29:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, youlin.pei@mediatek.com,
        chuanjia.liu@mediatek.com, qizhong.cheng@mediatek.com,
        sin_jieyang@mediatek.com, drinkcat@chromium.org,
        Rex-BC.Chen@mediatek.com, anson.chuang@mediatek.com,
        Krzysztof Wilczyski <kw@linux.com>
Subject: Re: [v9,5/7] PCI: mediatek-gen3: Add MSI support
Message-ID: <20210327202904.nvn7tfodmc2xw23l@pali>
References: <20210324030510.29177-1-jianjun.wang@mediatek.com>
 <20210324030510.29177-6-jianjun.wang@mediatek.com>
 <20210327192837.4rr46oeiuokritlc@pali>
 <87o8f4fkkh.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8f4fkkh.wl-maz@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 27 March 2021 19:44:30 Marc Zyngier wrote:
> On Sat, 27 Mar 2021 19:28:37 +0000,
> Pali Rohár <pali@kernel.org> wrote:
> > 
> > On Wednesday 24 March 2021 11:05:08 Jianjun Wang wrote:
> > > +static void mtk_pcie_msi_handler(struct mtk_pcie_port *port, int set_idx)
> > > +{
> > > +	struct mtk_msi_set *msi_set = &port->msi_sets[set_idx];
> > > +	unsigned long msi_enable, msi_status;
> > > +	unsigned int virq;
> > > +	irq_hw_number_t bit, hwirq;
> > > +
> > > +	msi_enable = readl_relaxed(msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET);
> > > +
> > > +	do {
> > > +		msi_status = readl_relaxed(msi_set->base +
> > > +					   PCIE_MSI_SET_STATUS_OFFSET);
> > > +		msi_status &= msi_enable;
> > > +		if (!msi_status)
> > > +			break;
> > > +
> > > +		for_each_set_bit(bit, &msi_status, PCIE_MSI_IRQS_PER_SET) {
> > > +			hwirq = bit + set_idx * PCIE_MSI_IRQS_PER_SET;
> > > +			virq = irq_find_mapping(port->msi_bottom_domain, hwirq);
> > > +			generic_handle_irq(virq);
> > > +		}
> > > +	} while (true);
> > 
> > Hello!
> > 
> > Just a question, cannot this while-loop cause block of processing other
> > interrupts?
> 
> This is a level interrupt. You don't have much choice but to handle it
> immediately, although an alternative would be to mask it and deal with
> it in a thread. And since Linux doesn't deal with interrupt priority,
> a screaming interrupt is never a good thing.

I see. Something like "interrupt priority" (which does not exist?) would
be needed to handle it.

> > I have done tests with different HW (aardvark) but with same while(true)
> > loop logic. One XHCI PCIe controller was sending MSI interrupts too fast
> > and interrupt handler with this while(true) logic was in infinite loop.
> > During one IRQ it was calling infinite many times generic_handle_irq()
> > as HW was feeding new and new MSI hwirq into status register.
> 
> Define "too fast".

Fast - next interrupt comes prior checking if while(true)-loop should stop.

> If something in the system is able to program the
> XHCI device in such a way that it causes a screaming interrupt, that's
> the place to look for problems, and probably not in the interrupt
> handling itself, which does what it is supposed to do.
> 
> > But this is different HW, so it can have different behavior and does not
> > have to cause above issue.
> > 
> > I have just spotted same code pattern for processing MSI interrupts...
> 
> This is a common pattern that you will find in pretty much any
> interrupt handling/demuxing, and is done this way when the cost of
> taking the exception is high compared to that of handling it.

And would not help if while(true)-loop is replaced by loop with upper
limit of iterations? Or just call only one iteration?

> Which is pretty much any of the badly designed, level-driving,
> DW-inspired, sorry excuse for MSI implementations that are popular on
> low-end ARM SoCs.

Ok. So thank you for information!

> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
