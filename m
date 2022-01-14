Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717EF48E96F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 12:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240889AbiANLsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jan 2022 06:48:40 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60410 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbiANLsk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jan 2022 06:48:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 973A261F2C
        for <linux-pci@vger.kernel.org>; Fri, 14 Jan 2022 11:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAA0C36AEA;
        Fri, 14 Jan 2022 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642160919;
        bh=BJ8zRI0mp9+9LRysk1EMVq6AUiHbpE5qi6OPfZYd/ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDSqYVWJSR5kl64oPzqvFSEGXLMf1JVq34hQ1IIo29GOjw70lAg3PuJTWQjgO/oFW
         xagP6zzILGLggMHvC+9k2ybBTeJEU4QVjSbwfd/qPWlNYqUFglQhBzLuiOJVpNPIuQ
         bG+oIBf3pdiNl0yh2OnOCLD9QyizAktg8uawPeNaaH/uvrS3m7GVGrrxYkL2Can/o8
         fv5vNucHMAQZrCqI3ithpSV4e8huYV5rAmg/tkAG5C5jYfocj5mxJIVPi9f6wVmcLZ
         rIjMH9wS869af75BQTNv06TOV+FPVSKddRedZBAd2cYLlfkTtmdZ3CiakRqVuQp642
         VrjRKY9RE9EMg==
Received: by pali.im (Postfix)
        id 6EA6F7D1; Fri, 14 Jan 2022 12:48:36 +0100 (CET)
Date:   Fri, 14 Jan 2022 12:48:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v4 2/2] PCI: xilinx-nwl: Add method to
 init_platform_service_irqs hook
Message-ID: <20220114114836.o5pjxsp6rjdemavr@pali>
References: <20220114075834.1938409-1-sr@denx.de>
 <20220114075834.1938409-3-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220114075834.1938409-3-sr@denx.de>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 14 January 2022 08:58:34 Stefan Roese wrote:
> From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> 
> Add nwl_init_platform_service_irqs() hook to init_platform_service_irqs
> to register the platform-specific Service Errors IRQs for this PCIe
> controller to fully support e.g. AER on this platform.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Pali Rohár <pali@kernel.org>
> Cc: Michal Simek <michal.simek@xilinx.com>

Reviewed-by: Pali Rohár <pali@kernel.org>

> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 414b679175b3..540536bbe3f8 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -24,6 +24,7 @@
>  #include <linux/irqchip/chained_irq.h>
>  
>  #include "../pci.h"
> +#include "../pcie/portdrv.h"
>  
>  /* Bridge core config registers */
>  #define BRCFG_PCIE_RX0			0x00000000
> @@ -806,6 +807,22 @@ static int nwl_pcie_parse_dt(struct nwl_pcie *pcie,
>  	return 0;
>  }
>  
> +static int nwl_init_platform_service_irqs(struct pci_dev *dev, int *irqs,
> +					  int plat_mask)
> +{
> +	struct pci_host_bridge *bridge;
> +	struct nwl_pcie *pcie;
> +
> +	bridge = pci_find_host_bridge(dev->bus);
> +	pcie = pci_host_bridge_priv(bridge);
> +	if (plat_mask & PCIE_PORT_SERVICE_AER) {
> +		irqs[PCIE_PORT_SERVICE_AER_SHIFT] = pcie->irq_misc;
> +		return 0; /* platform-specific service IRQ installed */
> +	}

Just I want to be sure, with this change PME and HP interrupts are not
provided even when plat_mask argument contains them.

> +
> +	return -ENODEV; /* platform-specific service IRQ not installed */
> +}
> +
>  static const struct of_device_id nwl_pcie_of_match[] = {
>  	{ .compatible = "xlnx,nwl-pcie-2.11", },
>  	{}
> @@ -857,6 +874,7 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  
>  	bridge->sysdata = pcie;
>  	bridge->ops = &nwl_pcie_ops;
> +	bridge->init_platform_service_irqs = nwl_init_platform_service_irqs;
>  
>  	if (IS_ENABLED(CONFIG_PCI_MSI)) {
>  		err = nwl_pcie_enable_msi(pcie);
> -- 
> 2.34.1
> 
