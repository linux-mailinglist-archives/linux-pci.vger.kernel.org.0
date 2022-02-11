Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495EE4B2CB7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Feb 2022 19:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242106AbiBKSVq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Feb 2022 13:21:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241157AbiBKSVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Feb 2022 13:21:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71E7113A;
        Fri, 11 Feb 2022 10:21:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B6911042;
        Fri, 11 Feb 2022 10:21:44 -0800 (PST)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B72F33F70D;
        Fri, 11 Feb 2022 10:21:42 -0800 (PST)
Date:   Fri, 11 Feb 2022 18:21:37 +0000
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
Message-ID: <20220211182137.GA2492@lpieralisi>
References: <20220105150239.9628-1-pali@kernel.org>
 <20220112151814.24361-1-pali@kernel.org>
 <20220112151814.24361-11-pali@kernel.org>
 <20220211171917.GA740@lpieralisi>
 <20220211175202.gku5pkwn5wmjo5al@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220211175202.gku5pkwn5wmjo5al@pali>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 11, 2022 at 06:52:02PM +0100, Pali Rohár wrote:

[...]

> > > @@ -1121,6 +1247,21 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
> > >  		port->io_attr = -1;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Old DT bindings do not contain "intx" interrupt
> > > +	 * so do not fail probing driver when interrupt does not exist.
> > > +	 */
> > > +	port->intx_irq = of_irq_get_byname(child, "intx");
> > > +	if (port->intx_irq == -EPROBE_DEFER) {
> > > +		ret = port->intx_irq;
> > > +		goto err;
> > > +	}
> > > +	if (port->intx_irq <= 0) {
> > > +		dev_warn(dev, "%s: legacy INTx interrupts cannot be masked individually, "
> > > +			      "%pOF does not contain intx interrupt\n",
> > > +			 port->name, child);
> > 
> > Here you end up with a new warning on existing firmware. Is it
> > legitimate ? I would remove the dev_warn().
> 
> I added this warning in v2 because Marc wanted it.
> 
> Should I (again) remove it in v3?

No, I asked a question and gave an opinion, I appreciate Marc's concern
so leave it (ie not everyone running a new kernel with new warnings on
existing firmware would be happy - maybe it is a good way of forcing a
firmware upgrade, you will tell me).

Lorenzo

> > Rob certainly has more insightful advice on this.
> > 
> > Thanks,
> > Lorenzo
> > 
> > > +	}
> > > +
> > >  	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
> > >  	if (reset_gpio == -EPROBE_DEFER) {
> > >  		ret = reset_gpio;
> > > @@ -1317,6 +1458,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > >  
> > >  	for (i = 0; i < pcie->nports; i++) {
> > >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > > +		int irq = port->intx_irq;
> > >  
> > >  		child = port->dn;
> > >  		if (!child)
> > > @@ -1344,6 +1486,22 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
> > >  			continue;
> > >  		}
> > >  
> > > +		if (irq > 0) {
> > > +			ret = mvebu_pcie_init_irq_domain(port);
> > > +			if (ret) {
> > > +				dev_err(dev, "%s: cannot init irq domain\n",
> > > +					port->name);
> > > +				pci_bridge_emul_cleanup(&port->bridge);
> > > +				devm_iounmap(dev, port->base);
> > > +				port->base = NULL;
> > > +				mvebu_pcie_powerdown(port);
> > > +				continue;
> > > +			}
> > > +			irq_set_chained_handler_and_data(irq,
> > > +							 mvebu_pcie_irq_handler,
> > > +							 port);
> > > +		}
> > > +
> > >  		/*
> > >  		 * PCIe topology exported by mvebu hw is quite complicated. In
> > >  		 * reality has something like N fully independent host bridges
> > > @@ -1448,6 +1606,7 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> > >  
> > >  	for (i = 0; i < pcie->nports; i++) {
> > >  		struct mvebu_pcie_port *port = &pcie->ports[i];
> > > +		int irq = port->intx_irq;
> > >  
> > >  		if (!port->base)
> > >  			continue;
> > > @@ -1458,7 +1617,17 @@ static int mvebu_pcie_remove(struct platform_device *pdev)
> > >  		mvebu_writel(port, cmd, PCIE_CMD_OFF);
> > >  
> > >  		/* Mask all interrupt sources. */
> > > -		mvebu_writel(port, 0, PCIE_MASK_OFF);
> > > +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_UNMASK_OFF);
> > > +
> > > +		/* Clear all interrupt causes. */
> > > +		mvebu_writel(port, ~PCIE_INT_ALL_MASK, PCIE_INT_CAUSE_OFF);
> > > +
> > > +		if (irq > 0)
> > > +			irq_set_chained_handler_and_data(irq, NULL, NULL);
> > > +
> > > +		/* Remove IRQ domains. */
> > > +		if (port->intx_irq_domain)
> > > +			irq_domain_remove(port->intx_irq_domain);
> > >  
> > >  		/* Free config space for emulated root bridge. */
> > >  		pci_bridge_emul_cleanup(&port->bridge);
> > > -- 
> > > 2.20.1
> > > 
