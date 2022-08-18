Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9BD598D80
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 22:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiHRUMW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 16:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiHRUMG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 16:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8A8D31D2;
        Thu, 18 Aug 2022 13:07:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C3A661445;
        Thu, 18 Aug 2022 20:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2B0C433D6;
        Thu, 18 Aug 2022 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660853260;
        bh=HqRuYKPKoRqwJbJeLclSyLBrd/IVtnMuG7MQd/VevCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jPsTfP/aPrMrzYy/HpSpqIzUeZYAjyghO9GBUtSIE7C0oEeVCPg3kyjMeYnLmDehn
         y/y7rqgCzbcVi8piPG/I3bhmbJtVTps5aj4CHhf9VBd2LiZiK0dByHsk7rA0IktQM+
         ZzFoncm1N2UJKVPqlQv/+ZYSzYxpj3qmNAuJwCimQmUQqp8ZRUQYZTV5M03xRX7/vD
         Ael/mvXjJ+lwloqa1+vlKsYH+xDmqp46EulFfORNGBxQSFF9FsKPf0gqZfG8vrf5re
         17kx56JqBYn0XOPTEjJNc1aZzev6m9zz4M/o0QfNUtNynHIbJF9hp5jf3GCZBZNfq9
         lkWIlrUDb0hVQ==
Received: by pali.im (Postfix)
        id 8AD44622; Thu, 18 Aug 2022 22:07:37 +0200 (CEST)
Date:   Thu, 18 Aug 2022 22:07:37 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <20220818200737.7w2wqh62arfrskks@pali>
References: <20220817230036.817-1-pali@kernel.org>
 <20220817230036.817-3-pali@kernel.org>
 <Yv6YOZ2FuTn8D5qS@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv6YOZ2FuTn8D5qS@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 18 August 2022 21:51:21 Andrew Lunn wrote:
> > -static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
> > +static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
> > +{
> > +	struct mvebu_pcie_port *port = arg;
> > +	struct device *dev = &port->pcie->pdev->dev;
> > +	u32 cause, unmask, status;
> > +
> > +	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
> > +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> > +	status = cause & unmask;
> > +
> > +	/* "error" interrupt handler does not process INTX interrupts */
> > +	status &= ~(PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> > +		    PCIE_INT_INTX(2) | PCIE_INT_INTX(3));
> 
> Just for my understanding...
> 
> There are two interrupts

yes

> but the status information what those
> interrupts actually mean are all packed into one register?

yes

for masking individual interrupt events there is just one shared
register for both "intx" and "error" interrupt source.

and also there is also just one shared "cause" register which says which
individual interrupt events happened.

> I assume reading the clause register does not clear set bits?

yes, reading does not clear any interrupt event.

> Otherwise there
> would be a race condition.

> Are these actually level interrupts

yes

> and in order to clear them you need to poke some other register?

to clear individual interrupt event you have to write corresponding 1b
bit into that cause register.

so if interrupts events BIT(24), BIT(16) and BIT(17) happened and
BIT(24), BIT(25), BIT(26), BIT(27) and BIT(16) are unmasked then CPU
receives two interrupts (one for intx:24-27 and one for err:16). kernel
will call interrupt handlers for both intx and err (possible also in
parallel if it unmasked on different CPUs) and each handler just clears
events which process. So writing BIT(16) into cause register clears only
event 16 and all other (24-27, 17) are still active. And level interrupt
(the correct one intx or err) is then triggered again.

> > +	/*
> > +	 * Old DT bindings do not contain "error" interrupt
> > +	 * so do not fail probing driver when interrupt does not exist.
> > +	 */
> > +	port->error_irq = of_irq_get_byname(child, "error");
> > +	if (port->error_irq == -EPROBE_DEFER) {
> > +		ret = port->error_irq;
> > +		goto err;
> > +	}
> > +	if (port->error_irq <= 0) {
> > +		dev_warn(dev, "%s: interrupts on Root Port are unsupported, "
> 
> Maybe that should be "Error interrupts on Root..." ?
> 
>       Andrew

From PCIe Root Port point of view, it can be _any_ interrupt which can
PCIe Root Port (as PCI device) reports (it does not have to be PCIe AER
- error). Without this support PCIe Root Port cannot trigger or generate
any interrupt. Note that from PCIe point of view, this Marvell Root Port
never generates INTx interrupt. INTx interrupts are generated only by
endpoint devices. Marvell Root Port reports all events via those
_custom_ Marvell interrupts triggered by "error" source. So "error" here
means "Marvell error", not "PCIe error" (e.g. PCIe AER). For example
also PME events are reported via this "error" source. And PME is not
error.
