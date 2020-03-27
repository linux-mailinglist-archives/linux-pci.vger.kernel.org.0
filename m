Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB64A195947
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgC0OwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 10:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0OwO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Mar 2020 10:52:14 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55483206F1;
        Fri, 27 Mar 2020 14:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585320733;
        bh=2ShgrdvsL+rAfA5d6A+vg33qHtqsZp31UtCfbY/XKmk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jOIZSsD4M8N/LW4RTzouiPKpjD1ZpgYPuAErp0ovpnrp9/P1/rUNEdw4acVqST7+3
         OCX/AQ1JUPwEWeOcckH0P9DY3IPVX75NU/GYfnIDqTqN7ZqFIK0P0g818aKp1S7WoX
         T8cyEXMKtliNyC33jatQkvUIvNL+27ihEI2gUqNg=
Date:   Fri, 27 Mar 2020 09:52:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: cadence: Use "dma-ranges" instead of
 "cdns,no-bar-match-nbits" property
Message-ID: <20200327145211.GA30095@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327104727.4708-3-kishon@ti.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 27, 2020 at 04:17:26PM +0530, Kishon Vijay Abraham I wrote:
> Cadence PCIe core dirver (host mode) uses "cdns,no-bar-match-nbits"
> property to configure the number of bits passed through from PCIe
> address to internal address in Inbound Address Translation register.

s/dirver/driver/

I love this series, thanks a lot for doing this!

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
