Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE3487E4B
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiAGVcT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:32:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46336 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiAGVcT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 16:32:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6829861FAD;
        Fri,  7 Jan 2022 21:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C5C36AE5;
        Fri,  7 Jan 2022 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641591137;
        bh=+t2R3Ohhw3NiS9KLcOjXJS2woaFIxKyK3u0Q/DHZ/GM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i65h0dWbwVgUwYFF4nVDOEanxTZdVhPWXcj0DbHGipm3udK+Oqgll1aYjtVA2ZxPX
         TlpJ4x1lw+jYMF+HZe58TFTsCLpbr0X/5/DZCCorrBar8mm86mvQ7uTY3+HFajuT0j
         dIflf78nw+evvXuJm1frhlgXN+pyK8xGsqA2ygyjxxTnzhIHEeJ7qnYmO87IZv2GsS
         PyRUc1Jg8oj7XJdNDQoGkM/U/xPdMudNhN2AnOUdVuEao/MOLMcvAhkQZQp6zxS7qz
         xklgfwPqW0FO0bJ5Xs964TS5niJrz7qsI1tjOiAsPR7Qkf07FGhYMdfrOAQzAob+Sv
         Heq3GD6eOELpg==
Date:   Fri, 7 Jan 2022 15:32:16 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] PCI: mvebu: Disallow mapping interrupts on
 emulated bridges
Message-ID: <20220107213216.GA403555@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211125124605.25915-6-pali@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 25, 2021 at 01:45:55PM +0100, Pali Rohár wrote:
> Interrupt support on mvebu emulated bridges is not implemented yet.

Is this mvebu-specific, or is aardvar also affected?

> So properly indicate return value to callers that they cannot request
> interrupts from emulated bridge.

Pet peeve: descriptions that say "do this *properly*".  As though the
previous authors were just ignorant or intentionally did something
*improperly* :)

> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/controller/pci-mvebu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
> index 19c6ee298442..a3df352d440e 100644
> --- a/drivers/pci/controller/pci-mvebu.c
> +++ b/drivers/pci/controller/pci-mvebu.c
> @@ -705,6 +705,15 @@ static struct pci_ops mvebu_pcie_ops = {
>  	.write = mvebu_pcie_wr_conf,
>  };
>  
> +static int mvebu_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	/* Interrupt support on mvebu emulated bridges is not implemented yet */
> +	if (dev->bus->number == 0)
> +		return 0; /* Proper return code 0 == NO_IRQ */
> +
> +	return of_irq_parse_and_map_pci(dev, slot, pin);

Is this something that could be done with a .read_base() op, e.g.,
make PCI_INTERRUPT_PIN contain zero (PCI_INTERRUPT_UNKNOWN)?

> +}
> +
>  static resource_size_t mvebu_pcie_align_resource(struct pci_dev *dev,
>  						 const struct resource *res,
>  						 resource_size_t start,
> @@ -1119,6 +1128,7 @@ static int mvebu_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = pcie;
>  	bridge->ops = &mvebu_pcie_ops;
>  	bridge->align_resource = mvebu_pcie_align_resource;
> +	bridge->map_irq = mvebu_pcie_map_irq;

I assume this means INTx doesn't work for some devices?  Which ones?
I guess anything on the root bus?  But INTx for devices *below* these
emulated Root Ports *does* work?

>  	return pci_host_probe(bridge);
>  }
> -- 
> 2.20.1
> 
