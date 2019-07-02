Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055AA5D9C7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 02:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGCAxR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 20:53:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbfGCAxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 20:53:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1D9420B1F;
        Tue,  2 Jul 2019 23:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562110648;
        bh=jOXGGlTtxKxUoZb4qZ8/SnpaBt3eFan28kHr8Q3ujSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q2qrTeTkiRv5BRUDGvR3KhEh7eRJEcJV/t9TQjTGVbuVFXawgLXl4iKY3PIevY1a5
         gzCV0UqSy1wvthVyN7TclqnAc0jI/1yVcQ6qv1iUVY+xZEv9PREZDKygNkw6UMvMRn
         r95Dz0RFbhYpgjUd1w35MEmic7ObUfs9KbbT5ab8=
Date:   Tue, 2 Jul 2019 18:37:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: Fix missing check for dma_virt_ops
Message-ID: <20190702233726.GG128603@google.com>
References: <20190702173544.21950-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702173544.21950-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 11:35:44AM -0600, Logan Gunthorpe wrote:
> Drivers that use dma_virt_ops were meant to be rejected when testing
> compatibility for P2PDMA.
> 
> This check got inadvertantly dropped in one of the later versions of the
> original patchset, so add it back.
> 
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to pci/peer-to-peer for v5.3, thanks!

> ---
>  drivers/pci/p2pdma.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index a4994aa3acc0..ab48babdf214 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -487,6 +487,14 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  		return -1;
>  
>  	for (i = 0; i < num_clients; i++) {
> +		if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
> +		    clients[i]->dma_ops == &dma_virt_ops) {
> +			if (verbose)
> +				dev_warn(clients[i],
> +					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
> +			return -1;
> +		}
> +
>  		pci_client = find_parent_pci_dev(clients[i]);
>  		if (!pci_client) {
>  			if (verbose)
> @@ -765,7 +773,7 @@ int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
>  	 * p2pdma mappings are not compatible with devices that use
>  	 * dma_virt_ops. If the upper layers do the right thing
>  	 * this should never happen because it will be prevented
> -	 * by the check in pci_p2pdma_add_client()
> +	 * by the check in pci_p2pdma_distance_many()
>  	 */
>  	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
>  			 dev->dma_ops == &dma_virt_ops))
> -- 
> 2.20.1
> 
