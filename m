Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDC82477AF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgHQTv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 15:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgHQTvz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Aug 2020 15:51:55 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0766320658;
        Mon, 17 Aug 2020 19:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597693912;
        bh=0rp3HaYyrFqjqOgeBKmXfxkTYZRRN21khxtx5T7t3kM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=svuShRSH9NtUvVZYhoTJxgYctTstz9KTB/SbGbCiWgit7JKJxQbK5mZO8LXoJHoaw
         S4+9fQEsC4V7UBo4p3vOPLNBvtHp/DEDq191ohqem6L8yjfMlZOFdavskrONrzmfuC
         lzg3NBqcbzJU4fZMC00WsmTJdtjtfnHGfXUYNCXA=
Date:   Mon, 17 Aug 2020 14:51:50 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     logang@deltatee.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] PCI/P2PDMA: fix build without dma ops
Message-ID: <20200817195150.GA1437811@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810124843.1532738-1-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 10, 2020 at 02:48:43PM +0200, Christoph Hellwig wrote:
> My commit to make dma ops support optional missed the reference in
> the p2pdma code.  And while the build bot didn't manage to find a config
> where this can happen, Matthew did.  Fix this by replacing two IS_ENABLED
> checks with ifdefs.
> 
> Fixes: 2f9237d4f6d ("dma-mapping: make support for dma ops optional")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied with Logan's reviewed-by to for-linus for v5.9, thanks!

> ---
>  drivers/pci/p2pdma.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 64ebed129dbf5f..f357f9a32b3a57 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -556,13 +556,14 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  		return -1;
>  
>  	for (i = 0; i < num_clients; i++) {
> -		if (IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
> -		    clients[i]->dma_ops == &dma_virt_ops) {
> +#ifdef CONFIG_DMA_VIRT_OPS
> +		if (clients[i]->dma_ops == &dma_virt_ops) {
>  			if (verbose)
>  				dev_warn(clients[i],
>  					 "cannot be used for peer-to-peer DMA because the driver makes use of dma_virt_ops\n");
>  			return -1;
>  		}
> +#endif
>  
>  		pci_client = find_parent_pci_dev(clients[i]);
>  		if (!pci_client) {
> @@ -842,9 +843,10 @@ static int __pci_p2pdma_map_sg(struct pci_p2pdma_pagemap *p2p_pgmap,
>  	 * this should never happen because it will be prevented
>  	 * by the check in pci_p2pdma_distance_many()
>  	 */
> -	if (WARN_ON_ONCE(IS_ENABLED(CONFIG_DMA_VIRT_OPS) &&
> -			 dev->dma_ops == &dma_virt_ops))
> +#ifdef CONFIG_DMA_VIRT_OPS
> +	if (WARN_ON_ONCE(dev->dma_ops == &dma_virt_ops))
>  		return 0;
> +#endif
>  
>  	for_each_sg(sg, s, nents, i) {
>  		paddr = sg_phys(s);
> -- 
> 2.28.0
> 
