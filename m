Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7137490EE
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 22:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfFQUKT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 16:10:19 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48464 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbfFQUKT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 16:10:19 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hcxxI-0004rl-Iq; Mon, 17 Jun 2019 14:10:17 -0600
To:     Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, nouveau@lists.freedesktop.org
References: <20190617122733.22432-1-hch@lst.de>
 <20190617122733.22432-17-hch@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e404fb0b-4ed8-34bb-7df8-9b59cb760f53@deltatee.com>
Date:   Mon, 17 Jun 2019 14:10:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617122733.22432-17-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: nouveau@lists.freedesktop.org, linux-mm@kvack.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvdimm@lists.01.org, bskeggs@redhat.com, jgg@mellanox.com, jglisse@redhat.com, dan.j.williams@intel.com, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH 16/25] PCI/P2PDMA: use the dev_pagemap internal refcount
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-06-17 6:27 a.m., Christoph Hellwig wrote:
> The functionality is identical to the one currently open coded in
> p2pdma.c.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

I also did a quick test with the full patch-set to ensure that the setup
and tear down paths for p2pdma still work correctly and it all does.

Thanks,

Logan

> ---
>  drivers/pci/p2pdma.c | 56 ++++----------------------------------------
>  1 file changed, 4 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 48a88158e46a..608f84df604a 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -24,12 +24,6 @@ struct pci_p2pdma {
>  	bool p2pmem_published;
>  };
>  
> -struct p2pdma_pagemap {
> -	struct dev_pagemap pgmap;
> -	struct percpu_ref ref;
> -	struct completion ref_done;
> -};
> -
>  static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> @@ -78,32 +72,6 @@ static const struct attribute_group p2pmem_group = {
>  	.name = "p2pmem",
>  };
>  
> -static struct p2pdma_pagemap *to_p2p_pgmap(struct percpu_ref *ref)
> -{
> -	return container_of(ref, struct p2pdma_pagemap, ref);
> -}
> -
> -static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
> -{
> -	struct p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(ref);
> -
> -	complete(&p2p_pgmap->ref_done);
> -}
> -
> -static void pci_p2pdma_percpu_kill(struct dev_pagemap *pgmap)
> -{
> -	percpu_ref_kill(pgmap->ref);
> -}
> -
> -static void pci_p2pdma_percpu_cleanup(struct dev_pagemap *pgmap)
> -{
> -	struct p2pdma_pagemap *p2p_pgmap =
> -		container_of(pgmap, struct p2pdma_pagemap, pgmap);
> -
> -	wait_for_completion(&p2p_pgmap->ref_done);
> -	percpu_ref_exit(&p2p_pgmap->ref);
> -}
> -
>  static void pci_p2pdma_release(void *data)
>  {
>  	struct pci_dev *pdev = data;
> @@ -153,11 +121,6 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
>  	return error;
>  }
>  
> -static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
> -	.kill		= pci_p2pdma_percpu_kill,
> -	.cleanup	= pci_p2pdma_percpu_cleanup,
> -};
> -
>  /**
>   * pci_p2pdma_add_resource - add memory for use as p2p memory
>   * @pdev: the device to add the memory to
> @@ -171,7 +134,6 @@ static const struct dev_pagemap_ops pci_p2pdma_pagemap_ops = {
>  int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  			    u64 offset)
>  {
> -	struct p2pdma_pagemap *p2p_pgmap;
>  	struct dev_pagemap *pgmap;
>  	void *addr;
>  	int error;
> @@ -194,22 +156,12 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  			return error;
>  	}
>  
> -	p2p_pgmap = devm_kzalloc(&pdev->dev, sizeof(*p2p_pgmap), GFP_KERNEL);
> -	if (!p2p_pgmap)
> +	pgmap = devm_kzalloc(&pdev->dev, sizeof(*pgmap), GFP_KERNEL);
> +	if (!pgmap)
>  		return -ENOMEM;
> -
> -	init_completion(&p2p_pgmap->ref_done);
> -	error = percpu_ref_init(&p2p_pgmap->ref,
> -			pci_p2pdma_percpu_release, 0, GFP_KERNEL);
> -	if (error)
> -		goto pgmap_free;
> -
> -	pgmap = &p2p_pgmap->pgmap;
> -
>  	pgmap->res.start = pci_resource_start(pdev, bar) + offset;
>  	pgmap->res.end = pgmap->res.start + size - 1;
>  	pgmap->res.flags = pci_resource_flags(pdev, bar);
> -	pgmap->ref = &p2p_pgmap->ref;
>  	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
>  	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
>  		pci_resource_start(pdev, bar);
> @@ -223,7 +175,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  	error = gen_pool_add_owner(pdev->p2pdma->pool, (unsigned long)addr,
>  			pci_bus_address(pdev, bar) + offset,
>  			resource_size(&pgmap->res), dev_to_node(&pdev->dev),
> -			&p2p_pgmap->ref);
> +			pgmap->ref);
>  	if (error)
>  		goto pages_free;
>  
> @@ -235,7 +187,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
>  pages_free:
>  	devm_memunmap_pages(&pdev->dev, pgmap);
>  pgmap_free:
> -	devm_kfree(&pdev->dev, p2p_pgmap);
> +	devm_kfree(&pdev->dev, pgmap);
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_add_resource);
> 
