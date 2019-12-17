Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1226A122B8B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 13:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfLQMct (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Dec 2019 07:32:49 -0500
Received: from foss.arm.com ([217.140.110.172]:35370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbfLQMcs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Dec 2019 07:32:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 053A531B;
        Tue, 17 Dec 2019 04:32:48 -0800 (PST)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FF5B3F718;
        Tue, 17 Dec 2019 04:32:47 -0800 (PST)
Date:   Tue, 17 Dec 2019 12:32:44 +0000
From:   Andrew Murray <andrew.murray@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 06/13] PCI: cadence: Allow pci_host_bridge to have custom
 pci_ops
Message-ID: <20191217123243.GC24359@e119886-lin.cambridge.arm.com>
References: <20191209092147.22901-1-kishon@ti.com>
 <20191209092147.22901-7-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209092147.22901-7-kishon@ti.com>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 02:51:40PM +0530, Kishon Vijay Abraham I wrote:
> Certain platforms like TI's J721E allows only 32-bit configuration
> space access. In such cases pci_generic_config_read and
> pci_generic_config_write cannot be used. Add support in Cadence core
> to let pci_host_bridge have custom pci_ops.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 7 ++++---
>  drivers/pci/controller/cadence/pcie-cadence.h      | 8 ++++++++
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 0929554f5a81..2efc33b1cade 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -12,8 +12,8 @@
>  
>  #include "pcie-cadence.h"
>  
> -static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> -				      int where)
> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where)
>  {
>  	struct pci_host_bridge *bridge = pci_find_host_bridge(bus);
>  	struct cdns_pcie_rc *rc = pci_host_bridge_priv(bridge);
> @@ -289,7 +289,8 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	list_splice_init(&resources, &bridge->windows);
>  	bridge->dev.parent = dev;
>  	bridge->busnr = pcie->bus;
> -	bridge->ops = &cdns_pcie_host_ops;
> +	if (!bridge->ops)
> +		bridge->ops = &cdns_pcie_host_ops;
>  	bridge->map_irq = of_irq_parse_and_map_pci;
>  	bridge->swizzle_irq = pci_common_swizzle;
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 5171d0da37da..c879dd3d2893 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -472,11 +472,19 @@ static inline bool cdns_pcie_is_link_up(struct cdns_pcie *pcie)
>  
>  #ifdef CONFIG_PCIE_CADENCE_HOST
>  int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
> +void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
> +			       int where);

The commit message doesn't explain why this change in visibility is needed).

>  #else
>  static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  {
>  	return 0;
>  }
> +
> +static inline void __iomem *cdns_pci_map_bus(struct pci_bus *bus,
> +					     unsigned int devfn,
> +					     int where)
> +{

This still needs to return something right?

Thanks,

Andrew Murray

> +}
>  #endif
>  
>  #ifdef CONFIG_PCIE_CADENCE_EP
> -- 
> 2.17.1
> 
