Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BE61F6F0F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgFKU4T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 16:56:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKU4T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Jun 2020 16:56:19 -0400
Received: from localhost (mobile-166-170-222-206.mycingular.net [166.170.222.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 139C82073E;
        Thu, 11 Jun 2020 20:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591908978;
        bh=I7VTRYMygcoRkETikINL4G9/wiU/fdFp/taCs3SNdu0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sVtjv5WYQd2qsXrOK+GJ7G1REPZUXHv9KFx3qk9I1rX8KACvKhdM4y+KKXrQorpXx
         CTFHrMrA4dj4IDP44dJIQU1v9u3VJjjd0E43X016IJo0qutrI8ajWueXjvjQ5Robkb
         ZyHJ47Uku1P0EEZDSG4xg+kvUYFZcjbrHZiReP5A=
Date:   Thu, 11 Jun 2020 15:56:16 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v8 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200611205616.GA1607864@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591622338-22652-3-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 08, 2020 at 06:48:58PM +0530, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.

> +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *dev_id)
> +{
> +	struct xilinx_cpm_pcie_port *port = dev_id;
> +	struct device *dev = port->dev;
> +	struct irq_data *d;
> +
> +	d = irq_domain_get_irq_data(port->cpm_domain, irq);
> +
> +	switch (d->hwirq) {
> +	case XILINX_CPM_PCIE_INTR_CORRECTABLE:
> +	case XILINX_CPM_PCIE_INTR_NONFATAL:
> +	case XILINX_CPM_PCIE_INTR_FATAL:
> +		cpm_pcie_clear_err_interrupts(port);
> +		fallthrough;
> +
> +	default:
> +		if (intr_cause[d->hwirq].str)
> +			dev_warn(dev, "%s\n", intr_cause[d->hwirq].str);
> +		else
> +			dev_warn(dev, "Unknown interrupt\n");

Maybe include d->hwirq in the "Unknown interrupt" message?

I assume if we take the default case, there's no need to clear the
interrupt?

> +	}
> +
> +	return IRQ_HANDLED;
> +}

> +static int xilinx_cpm_setup_irq(struct xilinx_cpm_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	int i, irq;
> +
> +	port->irq = platform_get_irq(pdev, 0);
> +	if (port->irq < 0) {
> +		dev_err(dev, "Unable to find misc IRQ line\n");

platform_get_irq() already prints an error message; you probably don't
need another.

> +		return port->irq;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(intr_cause); i++) {
> +		int err;
> +
> +		if (!intr_cause[i].str)
> +			continue;
> +
> +		irq = irq_create_mapping(port->cpm_domain, i);
> +		if (WARN_ON(irq <= 0))

I'm not a huge fan of WARN_ON() inside "if" statements, but ... OK.

Why do these all need to be WARN_ON() instead of dev_warn()?

> +			return -ENXIO;
> +
> +		err = devm_request_irq(dev, irq, xilinx_cpm_pcie_intr_handler,
> +				       0, intr_cause[i].sym, port);
> +		if (WARN_ON(err))
> +			return err;
> +	}
> +
> +	port->intx_irq = irq_create_mapping(port->cpm_domain,
> +					    XILINX_CPM_PCIE_INTR_INTX);
> +	if (WARN_ON(port->intx_irq <= 0))
> +		return -ENXIO;
> +
> +	/* Plug the INTx chained handler */
> +	irq_set_chained_handler_and_data(port->intx_irq,
> +					 xilinx_cpm_pcie_intx_flow, port);
