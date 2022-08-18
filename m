Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32960598E01
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346043AbiHRU1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346007AbiHRU1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 16:27:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2E12D09;
        Thu, 18 Aug 2022 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=pYW7sT3jh29AWNhJvTI8IlA/O24S5q/YAiEWOzJFAt8=; b=LB
        OZg4+L7ld0yvUo5vbEosaxy60S2JN+n31F0W6bAtTFxLs6MQHJpgBz+L31v9WbvWlpUf41AMDwhhO
        XYWuUBnJkNcFq8kiK1vx0Jh6LC0lDUoHRL5aQkgtR97Kc66Rn6kcDbYfQVzbLwD8fwFAnvozum9Dv
        LGhS1mJtgGWliC0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oOm6u-00DqE5-L3; Thu, 18 Aug 2022 22:27:24 +0200
Date:   Thu, 18 Aug 2022 22:27:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] PCI: mvebu: Implement support for interrupts on
 emulated bridge
Message-ID: <Yv6grNn5BDFjctFP@lunn.ch>
References: <20220817230036.817-1-pali@kernel.org>
 <20220817230036.817-3-pali@kernel.org>
 <Yv6YOZ2FuTn8D5qS@lunn.ch>
 <20220818200737.7w2wqh62arfrskks@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818200737.7w2wqh62arfrskks@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 18, 2022 at 10:07:37PM +0200, Pali Rohár wrote:
> On Thursday 18 August 2022 21:51:21 Andrew Lunn wrote:
> > > -static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
> > > +static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
> > > +{
> > > +	struct mvebu_pcie_port *port = arg;
> > > +	struct device *dev = &port->pcie->pdev->dev;
> > > +	u32 cause, unmask, status;
> > > +
> > > +	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
> > > +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > > +	status = cause & unmask;
> > > +
> > > +	/* "error" interrupt handler does not process INTX interrupts */
> > > +	status &= ~(PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> > > +		    PCIE_INT_INTX(2) | PCIE_INT_INTX(3));
> > 
> > Just for my understanding...
> > 
> > There are two interrupts
> 
> yes
> 
> > but the status information what those
> > interrupts actually mean are all packed into one register?
> 
> yes
> 
> for masking individual interrupt events there is just one shared
> register for both "intx" and "error" interrupt source.
> 
> and also there is also just one shared "cause" register which says which
> individual interrupt events happened.
> 
> > I assume reading the clause register does not clear set bits?
> 
> yes, reading does not clear any interrupt event.
> 
> > Otherwise there
> > would be a race condition.
> 
> > Are these actually level interrupts
> 
> yes
> 
> > and in order to clear them you need to poke some other register?
> 
> to clear individual interrupt event you have to write corresponding 1b
> bit into that cause register.
> 
> so if interrupts events BIT(24), BIT(16) and BIT(17) happened and
> BIT(24), BIT(25), BIT(26), BIT(27) and BIT(16) are unmasked then CPU
> receives two interrupts (one for intx:24-27 and one for err:16). kernel
> will call interrupt handlers for both intx and err (possible also in
> parallel if it unmasked on different CPUs) and each handler just clears
> events which process. So writing BIT(16) into cause register clears only
> event 16 and all other (24-27, 17) are still active. And level interrupt
> (the correct one intx or err) is then triggered again.

Thanks for the explanation.

I don't know enough about PCI to be able to give a meaningful
Reviewed-by, so i will leave that to the PCI maintainer. But the DT
bits look good to me.

     Andrew
