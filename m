Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32DB409E51
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 22:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240037AbhIMUp7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 16:45:59 -0400
Received: from rosenzweig.io ([138.197.143.207]:46342 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242398AbhIMUp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 16:45:59 -0400
Date:   Mon, 13 Sep 2021 16:43:23 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Marc Zyngier <maz@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <Robin.Murphy@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v3 08/10] PCI: apple: Implement MSI support
Message-ID: <YT+36/qmoO+ZfJXh@sunset>
References: <20210913182550.264165-1-maz@kernel.org>
 <20210913182550.264165-9-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913182550.264165-9-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +static void apple_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	BUILD_BUG_ON(upper_32_bits(DOORBELL_ADDR));
> +
> +	msg->address_hi = upper_32_bits(DOORBELL_ADDR);
> +	msg->address_lo = lower_32_bits(DOORBELL_ADDR);
> +	msg->data = data->hwirq;
> +}
...
> @@ -269,6 +378,14 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
>  
>  	irq_set_chained_handler_and_data(irq, apple_port_irq_handler, port);
>  
> +	/* Configure MSI base address */
> +	writel_relaxed(lower_32_bits(DOORBELL_ADDR), port->base + PORT_MSIADDR);
> +
> +	/* Enable MSIs, shared between all ports */
> +	writel_relaxed(0, port->base + PORT_MSIBASE);
> +	writel_relaxed((ilog2(port->pcie->nvecs) << PORT_MSICFG_L2MSINUM_SHIFT) |
> +		       PORT_MSICFG_EN, port->base + PORT_MSICFG);
> +
>  	return 0;
>  }

I think the BUILD_BUG_ON makes more sense next to configuring the base
address (which only has a 32-bit register, the BUILD_BUG_ON justifies
using writel and not writeq), rather than configuring the message (which
specifies the full 64-bits).
