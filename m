Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF51240ADE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Aug 2020 17:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgHJPz7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 11:55:59 -0400
Received: from ale.deltatee.com ([204.191.154.188]:44430 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgHJPz7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Aug 2020 11:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XEqKUiVfxomqHi8g1dJEjLvH6rWRfG4EZIPSyY5VGCY=; b=GMSsA3D02x2XNR9p9TxEECVP9Z
        kwoL9Eupx8pUjqBJNshBTnjVPDopY8hnVh0u+uWLujzAoDVhQxqs76PRMFMBnymdrNGTC/Qv/b/bl
        avC4jqkmbrW18m+T6AYYY6msEYfJQTmhT49HcroQaM9E2HEglrcIacAiU2uGeR9ghQUx1BjKgfeSi
        0/uRGhT7WImOUg5cweuALjEF2K1JJk/rZlzpK+l5tdzw5EWr/YrVP8hnTwsozr84mM+fnvSgLJTI+
        6iaADONzfcwXiPUg52YmNs+3VjTg+P3RjbPiVmy6nB3UFfKw7hDLHCNy19b1UJAewCxuHcUrBiZ3q
        9cK4fqcg==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1k5A9V-0002Mv-3y; Mon, 10 Aug 2020 09:55:58 -0600
To:     Christoph Hellwig <hch@lst.de>, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
References: <20200810124843.1532738-1-hch@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d1e55a10-382f-ba3e-62dd-fee675a80561@deltatee.com>
Date:   Mon, 10 Aug 2020 09:55:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200810124843.1532738-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: willy@infradead.org, linux-pci@vger.kernel.org, bhelgaas@google.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,NICE_REPLY_A autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: fix build without dma ops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2020-08-10 6:48 a.m., Christoph Hellwig wrote:
> My commit to make dma ops support optional missed the reference in
> the p2pdma code.  And while the build bot didn't manage to find a config
> where this can happen, Matthew did.  Fix this by replacing two IS_ENABLED
> checks with ifdefs.

Makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>





> Fixes: 2f9237d4f6d ("dma-mapping: make support for dma ops optional")
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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
> 
