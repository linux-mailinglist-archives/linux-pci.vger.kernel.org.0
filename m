Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A041C1862
	for <lists+linux-pci@lfdr.de>; Fri,  1 May 2020 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgEAOq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 10:46:58 -0400
Received: from foss.arm.com ([217.140.110.172]:41952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729175AbgEAOqt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 May 2020 10:46:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C94F31FB;
        Fri,  1 May 2020 07:46:48 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 895353F68F;
        Fri,  1 May 2020 07:46:47 -0700 (PDT)
Date:   Fri, 1 May 2020 15:46:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com
Subject: Re: [PATCH v2 2/4] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
Message-ID: <20200501144645.GB7398@e121166-lin.cambridge.arm.com>
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-3-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417114322.31111-3-kishon@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+Robin - to check on dma-ranges intepretation]

I would need RobH and Robin to review this.

Also, An ACK from Tom is required - for the whole series.

On Fri, Apr 17, 2020 at 05:13:20PM +0530, Kishon Vijay Abraham I wrote:
> Cadence PCIe core driver (host mode) uses "cdns,no-bar-match-nbits"
> property to configure the number of bits passed through from PCIe
> address to internal address in Inbound Address Translation register.
> 
> However standard PCI dt-binding already defines "dma-ranges" to
> describe the address range accessible by PCIe controller. Parse
> "dma-ranges" property to configure the number of bits passed
> through from PCIe address to internal address in Inbound Address
> Translation register.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 9b1c3966414b..60f912a657b9 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -206,8 +206,10 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	struct device *dev = rc->pcie.dev;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
> +	struct of_pci_range_parser parser;
>  	struct pci_host_bridge *bridge;
>  	struct list_head resources;
> +	struct of_pci_range range;
>  	struct cdns_pcie *pcie;
>  	struct resource *res;
>  	int ret;
> @@ -222,8 +224,15 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	rc->max_regions = 32;
>  	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
>  
> -	rc->no_bar_nbits = 32;
> -	of_property_read_u32(np, "cdns,no-bar-match-nbits", &rc->no_bar_nbits);
> +	if (!of_pci_dma_range_parser_init(&parser, np))
> +		if (of_pci_range_parser_one(&parser, &range))
> +			rc->no_bar_nbits = ilog2(range.size);
> +
> +	if (!rc->no_bar_nbits) {
> +		rc->no_bar_nbits = 32;
> +		of_property_read_u32(np, "cdns,no-bar-match-nbits",
> +				     &rc->no_bar_nbits);
> +	}
>  
>  	rc->vendor_id = 0xffff;
>  	of_property_read_u16(np, "vendor-id", &rc->vendor_id);
> -- 
> 2.17.1
> 
