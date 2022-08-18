Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B51598CE2
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 21:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbiHRTvc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 15:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234438AbiHRTvb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 15:51:31 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18CD8B980;
        Thu, 18 Aug 2022 12:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=WoNpxThHsB/AIg/LI6tXaaPBhVhciQC5vd6xYrqwv5Q=; b=xASG6ipwpLLNcj5P+2kBITSNI0
        EPfy7+9c0YpmfEOCxpwwhyu/FleN0yW2i3Eed0JD4n0NiEJHpJZoMfJ19M9DrSD7da4YCoxWkU5rM
        Uy9jE/WaoHnIlqC9oLHSd1GMAJ6Rd0rjRGPwJwnn06CEg7omvHjA7BzGZxcizEGbIpy0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oOlY1-00Dpra-DR; Thu, 18 Aug 2022 21:51:21 +0200
Date:   Thu, 18 Aug 2022 21:51:21 +0200
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
Message-ID: <Yv6YOZ2FuTn8D5qS@lunn.ch>
References: <20220817230036.817-1-pali@kernel.org>
 <20220817230036.817-3-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817230036.817-3-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> -static irqreturn_t mvebu_pcie_irq_handler(int irq, void *arg)
> +static irqreturn_t mvebu_pcie_error_irq_handler(int irq, void *arg)
> +{
> +	struct mvebu_pcie_port *port = arg;
> +	struct device *dev = &port->pcie->pdev->dev;
> +	u32 cause, unmask, status;
> +
> +	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
> +	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
> +	status = cause & unmask;
> +
> +	/* "error" interrupt handler does not process INTX interrupts */
> +	status &= ~(PCIE_INT_INTX(0) | PCIE_INT_INTX(1) |
> +		    PCIE_INT_INTX(2) | PCIE_INT_INTX(3));

Just for my understanding...

There are two interrupts, but the status information what those
interrupts actually mean are all packed into one register? I assume
reading the clause register does not clear set bits? Otherwise there
would be a race condition. Are these actually level interrupts, and in
order to clear them you need to poke some other register?

> +	/*
> +	 * Old DT bindings do not contain "error" interrupt
> +	 * so do not fail probing driver when interrupt does not exist.
> +	 */
> +	port->error_irq = of_irq_get_byname(child, "error");
> +	if (port->error_irq == -EPROBE_DEFER) {
> +		ret = port->error_irq;
> +		goto err;
> +	}
> +	if (port->error_irq <= 0) {
> +		dev_warn(dev, "%s: interrupts on Root Port are unsupported, "

Maybe that should be "Error interrupts on Root..." ?

      Andrew
