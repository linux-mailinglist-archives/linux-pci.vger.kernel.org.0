Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBD2195949
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 15:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgC0OyU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 10:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0OyU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Mar 2020 10:54:20 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D68C22072F;
        Fri, 27 Mar 2020 14:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585320859;
        bh=pIVAXzGjPus1GSIAlrpfJFjfmgqMlJOHNrnr56A0+18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vrz+jfuvAIzj2pNqw3tVwvvXDbSYrFHAJaXe9St3JOLvsg0wxvrYJYY6ZYoxacp0/
         D+mTqg476mg5iZiAflQP9j5VcAvvUBW9c4v56AU3bsnV+Q7OpE3/fMLOYAUXFnOypN
         1/G8ujiLuyS2xGXIowquaQisShI+FhGYJzUxUtk8=
Date:   Fri, 27 Mar 2020 09:54:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] PCI: Cadence: Remove using
 "cdns,max-outbound-regions" DT property
Message-ID: <20200327145417.GA30341@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327104727.4708-4-kishon@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update subject to match capitalization of others:

  PCI: cadence: Remove "cdns,max-outbound-regions" DT property

On Fri, Mar 27, 2020 at 04:17:27PM +0530, Kishon Vijay Abraham I wrote:
> "cdns,max-outbound-regions" device tree property provides the
> maximum number of outbound regions supported by the Host PCIe
> controller. However the outbound regions are configured based
> on what is populated in the "ranges" DT property.

Looks like this is missing a blank line here?  Or it should be
rewrapped as part of the above paragraph?  I think the below makes
more sense as a separate paragraph, though.

Again, thanks for doing this; this is a great cleanup.

> Avoid using two properties for configuring outbound regions and
> use only "ranges" property instead.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 6 ------
>  drivers/pci/controller/cadence/pcie-cadence.h      | 2 --
>  2 files changed, 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 60f912a657b9..8f72967f298f 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -140,9 +140,6 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  	for_each_of_pci_range(&parser, &range) {
>  		bool is_io;
>  
> -		if (r >= rc->max_regions)
> -			break;
> -
>  		if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_MEM)
>  			is_io = false;
>  		else if ((range.flags & IORESOURCE_TYPE_BITS) == IORESOURCE_IO)
> @@ -221,9 +218,6 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
>  	pcie = &rc->pcie;
>  	pcie->is_rc = true;
>  
> -	rc->max_regions = 32;
> -	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
> -
>  	if (!of_pci_dma_range_parser_init(&parser, np))
>  		if (of_pci_range_parser_one(&parser, &range))
>  			rc->no_bar_nbits = ilog2(range.size);
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index a2b28b912ca4..6bd89a21bb1c 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -251,7 +251,6 @@ struct cdns_pcie {
>   * @bus_range: first/last buses behind the PCIe host controller
>   * @cfg_base: IO mapped window to access the PCI configuration space of a
>   *            single function at a time
> - * @max_regions: maximum number of regions supported by the hardware
>   * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
>   *                translation (nbits sets into the "no BAR match" register)
>   * @vendor_id: PCI vendor ID
> @@ -262,7 +261,6 @@ struct cdns_pcie_rc {
>  	struct resource		*cfg_res;
>  	struct resource		*bus_range;
>  	void __iomem		*cfg_base;
> -	u32			max_regions;
>  	u32			no_bar_nbits;
>  	u16			vendor_id;
>  	u16			device_id;
> -- 
> 2.17.1
> 
