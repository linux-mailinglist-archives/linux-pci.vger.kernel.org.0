Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C45956CC0D
	for <lists+linux-pci@lfdr.de>; Sun, 10 Jul 2022 02:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiGJAHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Jul 2022 20:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGJAHF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 9 Jul 2022 20:07:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511F6E08C;
        Sat,  9 Jul 2022 17:07:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E204260F70;
        Sun, 10 Jul 2022 00:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC609C3411C;
        Sun, 10 Jul 2022 00:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657411623;
        bh=ev0wpT1Fow6jashmyifaklOng5uSQZOjioBBkAcnd/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gulwSkTOKzSbFDQ6hA4Jhnm00H3WZLW/SIjWOrc0g0rHi7A7mxO+943Q6JMF/rwXx
         5YHffNdxD+jkgqGx94r1Rn5uHvzEo9EGHfF4AoGKUjSxycVqT7QDcnig81mu6ZgFIt
         VFOY8ROjOEaAroi+tBY8cPyeUUBtuXd+cmQvCN2hCh5PhZ65fMHnYiA5QTOnKB+Ujr
         4DnSY7c+HnkI32R4WHSm1nU0w6ws1w864IBf+yajapD1J5C+Gk5TWan8OceYBzvwFE
         dygzsnMDdRJmoOXtrMAMDnFDsWHF30PcBrhgfib7DRpWDHezZtrCfkvb5/6yn48EoP
         pafIoqkts5gKw==
Received: by pali.im (Postfix)
        id 116BCAFA; Sun, 10 Jul 2022 02:07:00 +0200 (CEST)
Date:   Sun, 10 Jul 2022 02:06:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] PCI: mvebu: Use devm_request_irq() for registering
 interrupt handler
Message-ID: <20220710000659.vxmlsvoin26tdiqw@pali>
References: <20220709143151.qhoa7vjcidxadrvt@pali>
 <20220709234430.GA489657@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220709234430.GA489657@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday 09 July 2022 18:44:30 Bjorn Helgaas wrote:
> [+cc Marc, since he commented on this]
> 
> On Sat, Jul 09, 2022 at 04:31:51PM +0200, Pali Rohár wrote:
> > On Friday 01 July 2022 16:29:41 Pali Rohár wrote:
> > > On Thursday 23 June 2022 11:27:47 Bjorn Helgaas wrote:
> > > > On Tue, May 24, 2022 at 02:28:17PM +0200, Pali Rohár wrote:
> > > > > Same as in commit a3b69dd0ad62 ("Revert "PCI: aardvark: Rewrite IRQ code to
> > > > > chained IRQ handler"") for pci-aardvark driver, use devm_request_irq()
> > > > > instead of chained IRQ handler in pci-mvebu.c driver.
> > > > >
> > > > > This change fixes affinity support and allows to pin interrupts from
> > > > > different PCIe controllers to different CPU cores.
> > > > 
> > > > Several other drivers use irq_set_chained_handler_and_data().  Do any
> > > > of them need similar changes?  The commit log suggests that using
> > > > chained IRQ handlers breaks affinity support.  But perhaps that's not
> > > > the case and the real culprit is some other difference between mvebu
> > > > and the other drivers.
> > > 
> > > And there is another reason to not use irq_set_chained_handler_and_data
> > > and instead use devm_request_irq(). Armada XP has some interrupts
> > > shared and it looks like that irq_set_chained_handler_and_data() API
> > > does not handle shared interrupt sources too.
> > > 
> > > I can update commit message to mention also this fact.
> > 
> > Anything needed from me to improve this fix?
> 
> My impression from Marc's response [1] was that this patch would
> "break the contract the kernel has with userspace" and he didn't think
> this was acceptable.  But maybe I'm not understanding it correctly.

This is argument which Marc use when he does not have any argument.

Support for dedicated INTx into pci-mvebu.c was introduced just recently
and I used irq_set_chained_handler_and_data() just because I thought it
is a good idea and did not know about all those issues with it. So there
cannot be any breakage by this patch.

I already converted other pci-aardvark.c driver to use
irq_set_chained_handler_and_data() API because wanted it... But at the
end _that conversion_ caused breakage of afinity support and so this
conversion had to be reverted:
https://lore.kernel.org/linux-pci/20220515125815.30157-1-pali@kernel.org/#t

Based on his past decisions, above suggestions which cause _real_
breakage and his expressions like mvebu should be put into the trash,
I'm not going to listen him anymore. The only breaking is done by him.


There are two arguments why to not use irq_set_chained_handler_and_data:

1) It does not support afinity and therefore has negative performance
   impact on Armada platforms with more CPUs and more PCIe ports.

2) It does not support shared interrupts and therefore it will break
   hardware on which interrupt lines are shares (mostly Armada XP).

So these issues have to be fixed and currently I see only option to
switch irq_set_chained_handler_and_data() to devm_request_irq() which I
did in this fixup patch.

> In any event, I'm waiting for you to continue that discussion.  Maybe
> there's an argument for doing this even though it breaks some
> userspace expectations.  If so, that should be acknowledged and
> explained.  Or maybe there's an alternative implementation.  Marc
> gave a link to some suggestions [2], which I haven't looked into, but
> maybe you could.

Once Marc fix/implement that alternative implementation in his codebase
then we can continue discuss this direction. Until that happens I think
there is no other way, at least I do not see them.

And I'm not going to work again any patch for him and his codebase as he
explicitly expressed that is against any improvements in mvebu drivers
and is rejecting (my) patches. This is just waste of my time. So sorry.

> [1] https://lore.kernel.org/r/874k0bf7f7.wl-maz@kernel.org
> [2] https://lore.kernel.org/all/20220502102137.764606ee@thinkpad/
> 
> > > > > Fixes: ec075262648f ("PCI: mvebu: Implement support for legacy INTx interrupts")
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > > ---
> > > > > Hello Bjorn! This is basically same issue as for pci-aardvark.c:
> > > > > https://lore.kernel.org/linux-pci/20220515125815.30157-1-pali@kernel.org/#t
> > > > > 
> > > > > I tested this patch with pci=nomsi in cmdline (to force kernel to use
> > > > > legacy intx instead of MSI) on A385 and checked that I can set affinity
> > > > > via /proc/irq/XX/smp_affinity file for every mvebu pcie controller to
> > > > > different CPU and legacy interrupts from different cards/controllers
> > > > > were handled by different CPUs.
> > > > > 
> > > > > I think that this is important on Armada XP platforms which have many
> > > > > independent PCIe controllers (IIRC up to 10) and many cores (up to 4).
> > > > > ---
> > > > >  drivers/pci/controller/pci-mvebu.c | 30 +++++++++++++++++-------------
> > > > >  1 file changed, 17 insertions(+), 13 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> > > > > index 8f76d4bda356..de67ea39fea5 100644
> > > > > --- a/drivers/pci/controller/pci-mvebu.c
> > > > > +++ b/drivers/pci/controller/pci-mvebu.c
> > > > > @@ -1017,16 +1017,13 @@ static int mvebu_pcie_init_irq_domain(struct mvebu_pcie_port *port)
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > -static void mvebu_pcie_irq_handler(struct irq_desc *desc)
> > > > > +static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
> > > > >  {
> > > > > -	struct mvebu_pcie_port *port = irq_desc_get_handler_data(desc);
> > > > > -	struct irq_chip *chip = irq_desc_get_chip(desc);
> > > > > +	struct mvebu_pcie_port *port = arg;
> > > > >  	struct device *dev = &port->pcie->pdev->dev;
> > > > >  	u32 cause, unmask, status;
> > > > >  	int i;
> > > > >  
> > > > > -	chained_irq_enter(chip, desc);
> > > > > -
> > > > >  	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
> > > > >  	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > > >  	status = cause & unmask;
> > > > > @@ -1040,7 +1037,7 @@ static void mvebu_pcie_irq_handler(struct irq_desc *desc)
> > > > >  			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
> > > > >  	}
> > > > >  
> > > > > -	chained_irq_exit(chip, desc);
> > > > > +	return status ? IRQ_HANDLED : IRQ_NONE;
> > > > >  }
> > > > >  
> > > > >  static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> > > > > @@ -1490,9 +1487,20 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > > > >  				mvebu_pcie_powerdown(port);
> > > > >  				continue;
> > > > >  			}
> > > > > -			irq_set_chained_handler_and_data(irq,
> > > > > -							 mvebu_pcie_irq_handler,
> > > > > -							 port);
> > > > > +
> > > > > +			ret = devm_request_irq(dev, irq, mvebu_pcie_irq_handler,
> > > > > +					       IRQF_SHARED | IRQF_NO_THREAD,
> > > > > +					       port->name, port);
> > > > > +			if (ret) {
> > > > > +				dev_err(dev, "%s: cannot register interrupt handler: %d\n",
> > > > > +					port->name, ret);
> > > > > +				irq_domain_remove(port->intx_irq_domain);
> > > > > +				pci_bridge_emul_cleanup(&port->bridge);
> > > > > +				devm_iounmap(dev, port->base);
> > > > > +				port->base = NULL;
> > > > > +				mvebu_pcie_powerdown(port);
> > > > > +				continue;
> > > > > +			}
> > > > >  		}
> > > > >  
> > > > >  		/*
> > > > > @@ -1599,7 +1607,6 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> > > > >  
> > > > >  	for (i = 0; i < pcie->nports; i++) {
> > > > >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > > > > -		int irq = port->intx_irq;
> > > > >  
> > > > >  		if (!port->base)
> > > > >  			continue;
> > > > > @@ -1615,9 +1622,6 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> > > > >  		/* Clear all interrupt causes. */
> > > > >  		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > > > >  
> > > > > -		if (irq > 0)
> > > > > -			irq_set_chained_handler_and_data(irq, NULL, NULL);
> > > > > -
> > > > >  		/* Remove IRQ domains. */
> > > > >  		if (port->intx_irq_domain)
> > > > >  			irq_domain_remove(port->intx_irq_domain);
> > > > > -- 
> > > > > 2.20.1
> > > > > 
