Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCAF4BFD4F
	for <lists+linux-pci@lfdr.de>; Tue, 22 Feb 2022 16:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiBVPq2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Feb 2022 10:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiBVPq1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Feb 2022 10:46:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DFCB163D70;
        Tue, 22 Feb 2022 07:46:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65B1B1042;
        Tue, 22 Feb 2022 07:46:01 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED12E3F5A1;
        Tue, 22 Feb 2022 07:45:59 -0800 (PST)
Date:   Tue, 22 Feb 2022 15:45:53 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     robh+dt@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 10/11] PCI: mvebu: Implement support for legacy INTx
 interrupts
Message-ID: <20220222154553.GA19919@lpieralisi>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-11-pali@kernel.org>
 <20220211171917.GA740@lpieralisi>
 <20220211175202.gku5pkwn5wmjo5al@pali>
 <20220216234039.stxv5ndd6ai23sbb@pali>
 <20220222102057.GA17238@lpieralisi>
 <20220222105129.jg5kwmhvhggsv72n@pali>
 <20220222152409.GA18799@lpieralisi>
 <20220222154226.mwu7d3silgmwzeqc@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222154226.mwu7d3silgmwzeqc@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 22, 2022 at 04:42:26PM +0100, Pali Rohár wrote:
> On Tuesday 22 February 2022 15:24:09 Lorenzo Pieralisi wrote:
> > On Tue, Feb 22, 2022 at 11:51:29AM +0100, Pali Rohár wrote:
> > > On Tuesday 22 February 2022 10:21:06 Lorenzo Pieralisi wrote:
> > > > On Thu, Feb 17, 2022 at 12:40:39AM +0100, Pali Rohár wrote:
> > > > > On Friday 11 February 2022 18:52:02 Pali Rohár wrote:
> > > > > > On Friday 11 February 2022 17:19:17 Lorenzo Pieralisi wrote:
> > > > > > > On Wed, Jan 12, 2022 at 04:18:13PM +0100, Pali Rohár wrote:
> > > > > > > > This adds support for legacy INTx interrupts received from other PCIe
> > > > > > > > devices and which are reported by a new INTx irq chip.
> > > > > > > > 
> > > > > > > > With this change, kernel can distinguish between INTA, INTB, INTC and INTD
> > > > > > > > interrupts.
> > > > > > > > 
> > > > > > > > Note that for this support, device tree files has to be properly adjusted
> > > > > > > > to provide "interrupts" or "interrupts-extended" property with intx
> > > > > > > > interrupt source, "interrupt-names" property with "intx" string and also
> > > > > > > > 'interrupt-controller' subnode must be defined.
> > > > > > > > 
> > > > > > > > If device tree files do not provide these nodes then driver would work as
> > > > > > > > before.
> > > > > > > 
> > > > > > > Nit: this information is not useful. DT rules are written in DT
> > > > > > > bindings, not in kernel commit logs. All I am saying is that firmware
> > > > > > > developers should not have to read this log to write firmware.
> > > > > > 
> > > > > > It was not intended for firmware developers, but for reviewers of this
> > > > > > patch to understand, what is happening in code and that with old DT
> > > > > > files this patch does not change driver behavior (= work as before).
> > > > > > 
> > > > > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > > > > ---
> > > > > > > >  drivers/pci/controller/pci-mvebu.c | 185 +++++++++++++++++++++++++++--
> > > > > > > >  1 file changed, 177 insertions(+), 8 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > > > > > > index 1e90ab888075..dbb6ecb4cb70 100644
> > > > > > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > > > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > > > > > @@ -54,9 +54,10 @@
> > > > > > > >  	 PCIE_CONF_ADDR_EN)
> > > > > > > >  #define PCIE_CONF_DATA_OFF	0x18fc
> > > > > > > >  #define PCIE_INT_CAUSE_OFF	0x1900
> > > > > > > > +#define PCIE_INT_UNMASK_OFF	0x1910
> > > > > > > 
> > > > > > > Nit: I understand it is tempting but here you are redefining or better
> > > > > > > giving a proper label to a register. Separate patch please.
> > > > > > 
> > > > > > Ok!
> > > > > > 
> > > > > > > > +#define  PCIE_INT_INTX(i)		BIT(24+i)
> > > > > > > >  #define  PCIE_INT_PM_PME		BIT(28)
> > > > > > > > -#define PCIE_MASK_OFF		0x1910
> > > > > > > 
> > > > > > > See above.
> > > > > > > 
> > > > > > > > -#define  PCIE_MASK_ENABLE_INTS          0x0f000000
> > > > > > > > +#define  PCIE_INT_ALL_MASK		GENMASK(31, 0)
> > > > > > > >  #define PCIE_CTRL_OFF		0x1a00
> > > > > > > >  #define  PCIE_CTRL_X1_MODE		0x0001
> > > > > > > >  #define  PCIE_CTRL_RC_MODE		BIT(1)
> > > > > > > > @@ -110,6 +111,9 @@ struct mvebu_pcie_port {
> > > > > > > >  	struct mvebu_pcie_window iowin;
> > > > > > > >  	u32 saved_pcie_stat;
> > > > > > > >  	struct resource regs;
> > > > > > > > +	struct irq_domain *intx_irq_domain;
> > > > > > > > +	raw_spinlock_t irq_lock;
> > > > > > > > +	int intx_irq;
> > > > > > > >  };
> > > > > > > >  
> > > > > > > >  static inline void mvebu_writel(struct mvebu_pcie_port *port, u32 val, u32 reg)
> > > > > > > > @@ -235,7 +239,7 @@ static void mvebu_pcie_setup_wins(struct mvebu_pcie_port *port)
> > > > > > > >  
> > > > > > > >  static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> > > > > > > >  {
> > > > > > > > -	u32 ctrl, lnkcap, cmd, dev_rev, mask;
> > > > > > > > +	u32 ctrl, lnkcap, cmd, dev_rev, unmask;
> > > > > > > >  
> > > > > > > >  	/* Setup PCIe controller to Root Complex mode. */
> > > > > > > >  	ctrl = mvebu_readl(port, PCIE_CTRL_OFF);
> > > > > > > > @@ -288,10 +292,30 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
> > > > > > > >  	/* Point PCIe unit MBUS decode windows to DRAM space. */
> > > > > > > >  	mvebu_pcie_setup_wins(port);
> > > > > > > >  
> > > > > > > > -	/* Enable interrupt lines A-D. */
> > > > > > > > -	mask = mvebu_readl(port, PCIE_MASK_OFF);
> > > > > > > > -	mask |= PCIE_MASK_ENABLE_INTS;
> > > > > > > > -	mvebu_writel(port, mask, PCIE_MASK_OFF);
> > > > > > > > +	/* Mask all interrupt sources. */
> > > > > > > > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> > > > > > > > +
> > > > > > > > +	/* Clear all interrupt causes. */
> > > > > > > > +	mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > > > > > > > +
> > > > > > > > +	if (port->intx_irq <= 0) {
> > > > > > > > +		/*
> > > > > > > > +		 * When neither "summary" interrupt, nor "intx" interrupt was
> > > > > > > > +		 * specified in DT then unmask all legacy INTx interrupts as in
> > > > > > > > +		 * this case driver does not provide a way for masking and
> > > > > > > > +		 * unmasking of individual legacy INTx interrupts. In this case
> > > > > > > > +		 * all interrupts, including legacy INTx are reported via one
> > > > > > > > +		 * shared GIC source and therefore kernel cannot distinguish
> > > > > > > > +		 * which individual legacy INTx was triggered. These interrupts
> > > > > > > > +		 * are shared, so it should not cause any issue. Just
> > > > > > > > +		 * performance penalty as every PCIe interrupt handler needs to
> > > > > > > > +		 * be called when some interrupt is triggered.
> > > > > > > > +		 */
> > > > > > > 
> > > > > > > This comment applies to current mainline right (ie it describes how
> > > > > > > current mainline handles INTx) ? IMO you should split it out in a
> > > > > > > separate patch.
> > > > > > 
> > > > > > This above comment describe what happens in if-branch when intx_irq is
> > > > > > not set (as written in comment "when intx interrupt was not specified in
> > > > > > DT"). You are right that this is also the behavior in the current
> > > > > > mainline.
> > > > > > 
> > > > > > I'm not sure if this comment can be split out as support for "intx"
> > > > > > interrupt is in this patch.
> > > > > > 
> > > > > > > I understand it is hard but a patch is a logical _change_, this
> > > > > > > comment is a change per se, it is a clarification on current
> > > > > > > behaviour.
> > > > > > 
> > > > > > Ok, I could try to split this comment into two patches, but part about
> > > > > > if-branch comment needs to stay in "this" patch.
> > > > > 
> > > > > I have done it locally.
> > > > > 
> > > > > Let me know when I should resend this patch series and I will include
> > > > > into it also these changes.
> > > > 
> > > > Hi,
> > > > 
> > > > yes please resend it and I will merge it.
> > > 
> > > Done!
> > > https://lore.kernel.org/linux-pci/20220222104625.28461-1-pali@kernel.org/T/#u
> > 
> > Can you rebase it please on top of my pci/mvebu branch ?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
> > 
> > Forgive me, I forgot to mention that, thanks.
> > 
> > Lorenzo
> 
> Ok! I rebased V3 on top of c3bd7dc553eea5a3595ca3aa0adee9bf83622a1f
> (pci/mvebu branch in your repo), fixed conflicts and pushed to my git
> repo https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/
> as commit 42402f0cfc362ffb0b7e464f420d6ead342dab2b (lpieralisi-pci-mvebu
> branch). It is enough? Or do you want me to resend it via emails?

You need to re-send it to linux-pci ML, I only apply patches posted
there, sorry for the churn, thanks.

Lorenzo
