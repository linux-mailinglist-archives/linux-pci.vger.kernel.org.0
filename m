Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1062E20A6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Dec 2020 20:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgLWS7K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Dec 2020 13:59:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:54298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbgLWS7J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Dec 2020 13:59:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0AAA122225;
        Wed, 23 Dec 2020 18:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608749909;
        bh=vLh2hwI5HuBwbica7jhrzWGB4C1u8uENLeADqYz1zP0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i3BYi4+ftGJxXXuiQskbCYWpUaAwk94LoSBVURpDdXd3wscMqTVftY2QIS5w6KvB0
         QZw53KT7FHi0lzITD7KhRVwls2r5OwlRvjYbpaK0OrF0mUJhFcshgLQ2mgeoiRkX2W
         aJ+fKU8J8TRynf3z/nx1WbGupuLrz5NSxLKQMgaIy3KJ7LcBdoXW7AOx04BvnlVRBX
         9woO57e6gWfU3jDC2J5/PEyUxRAwpKDd1QlI8o572YmXg4UojP8q7+7uIKHE5G5zr9
         EnDe6CrtWrvIR0gobOOyuocIsZuIqywUC4pnps+AQRQ1nFjFlXqXYyKwzGnlvOhgQn
         TjwApfAaZ9Wtg==
Date:   Wed, 23 Dec 2020 12:58:27 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Lobakin <alobakin@pm.me>, Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH pci] PCI: dwc: fix inverted condition of DMA mask setup
 warning
Message-ID: <20201223185827.GA312001@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222150708.67983-1-alobakin@pm.me>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 22, 2020 at 03:07:43PM +0000, Alexander Lobakin wrote:
> Commit 660c486590aa ("PCI: dwc: Set 32-bit DMA mask for MSI target
> address allocation") added dma_mask_set() call to explicitly set
> 32-bit DMA mask for MSI message mapping, but for now it throws a
> warning on ret == 0, while dma_set_mask() returns 0 in case of
> success.
> Fix this by inverting the condition.
> 
> Misc: remove redundant braces around single statement.
> 
> Fixes: 660c486590aa ("PCI: dwc: Set 32-bit DMA mask for MSI target address allocation")
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

I joined the string to make it greppable and applied to for-linus for
v5.11, thanks!

Vidya, speak up if this isn't right.  I assume you should have seen
this spurious warning while testing 660c486590aa.

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 516b151e0ef3..fa40cc2e376f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -397,12 +397,11 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  							    pp);
>  
>  			ret = dma_set_mask(pci->dev, DMA_BIT_MASK(32));
> -			if (!ret) {
> +			if (ret)
>  				dev_warn(pci->dev,
>  					 "Failed to set DMA mask to 32-bit. "
>  					 "Devices with only 32-bit MSI support"
>  					 " may not work properly\n");
> -			}
>  
>  			pp->msi_data = dma_map_single_attrs(pci->dev, &pp->msi_msg,
>  						      sizeof(pp->msi_msg),
> -- 
> 2.29.2
> 
> 
