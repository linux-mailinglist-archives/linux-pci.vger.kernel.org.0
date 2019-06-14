Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE8814507A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 02:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbfFNAU4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 20:20:56 -0400
Received: from mga01.intel.com ([192.55.52.88]:65198 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFNAU4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jun 2019 20:20:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jun 2019 17:20:55 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Jun 2019 17:20:55 -0700
Date:   Thu, 13 Jun 2019 17:22:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 13/22] device-dax: use the dev_pagemap internal refcount
Message-ID: <20190614002217.GB783@iweiny-DESK2.sc.intel.com>
References: <20190613094326.24093-1-hch@lst.de>
 <20190613094326.24093-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613094326.24093-14-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 11:43:16AM +0200, Christoph Hellwig wrote:
> The functionality is identical to the one currently open coded in
> device-dax.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/dax/dax-private.h |  4 ---
>  drivers/dax/device.c      | 52 +--------------------------------------
>  2 files changed, 1 insertion(+), 55 deletions(-)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index a45612148ca0..ed04a18a35be 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -51,8 +51,6 @@ struct dax_region {
>   * @target_node: effective numa node if dev_dax memory range is onlined
>   * @dev - device core
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> - * @ref: pgmap reference count (driver owned)
> - * @cmp: @ref final put completion (driver owned)
>   */
>  struct dev_dax {
>  	struct dax_region *region;
> @@ -60,8 +58,6 @@ struct dev_dax {
>  	int target_node;
>  	struct device dev;
>  	struct dev_pagemap pgmap;
> -	struct percpu_ref ref;
> -	struct completion cmp;
>  };
>  
>  static inline struct dev_dax *to_dev_dax(struct device *dev)
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index e23fa1bd8c97..a9d7c90ecf1e 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -14,37 +14,6 @@
>  #include "dax-private.h"
>  #include "bus.h"
>  
> -static struct dev_dax *ref_to_dev_dax(struct percpu_ref *ref)
> -{
> -	return container_of(ref, struct dev_dax, ref);
> -}
> -
> -static void dev_dax_percpu_release(struct percpu_ref *ref)
> -{
> -	struct dev_dax *dev_dax = ref_to_dev_dax(ref);
> -
> -	dev_dbg(&dev_dax->dev, "%s\n", __func__);
> -	complete(&dev_dax->cmp);
> -}
> -
> -static void dev_dax_percpu_exit(void *data)
> -{
> -	struct percpu_ref *ref = data;
> -	struct dev_dax *dev_dax = ref_to_dev_dax(ref);
> -
> -	dev_dbg(&dev_dax->dev, "%s\n", __func__);
> -	wait_for_completion(&dev_dax->cmp);
> -	percpu_ref_exit(ref);
> -}
> -
> -static void dev_dax_percpu_kill(struct dev_pagemap *pgmap)
> -{
> -	struct dev_dax *dev_dax = container_of(pgmap, struct dev_dax, pgmap);
> -
> -	dev_dbg(&dev_dax->dev, "%s\n", __func__);
> -	percpu_ref_kill(pgmap->ref);
> -}
> -
>  static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>  		const char *func)
>  {
> @@ -442,10 +411,6 @@ static void dev_dax_kill(void *dev_dax)
>  	kill_dev_dax(dev_dax);
>  }
>  
> -static const struct dev_pagemap_ops dev_dax_pagemap_ops = {
> -	.kill		= dev_dax_percpu_kill,
> -};
> -
>  int dev_dax_probe(struct device *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
> @@ -463,24 +428,9 @@ int dev_dax_probe(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> -	init_completion(&dev_dax->cmp);
> -	rc = percpu_ref_init(&dev_dax->ref, dev_dax_percpu_release, 0,
> -			GFP_KERNEL);
> -	if (rc)
> -		return rc;
> -
> -	rc = devm_add_action_or_reset(dev, dev_dax_percpu_exit, &dev_dax->ref);
> -	if (rc)
> -		return rc;
> -
> -	dev_dax->pgmap.ref = &dev_dax->ref;

I don't think this exactly correct.  pgmap.ref is a pointer to the dev_dax ref
structure.  Taking it away will cause devm_memremap_pages() to fail AFAICS.

I think you need to change struct dev_pagemap as well:

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f0628660d541..5e2120589ddf 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -90,7 +90,7 @@ struct dev_pagemap {
        struct vmem_altmap altmap;
        bool altmap_valid;
        struct resource res;
-       struct percpu_ref *ref;
+       struct percpu_ref ref;
        void (*kill)(struct percpu_ref *ref);
        struct device *dev;
        void *data;

And all usages of it, right?

Ira

> -	dev_dax->pgmap.ops = &dev_dax_pagemap_ops;
>  	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
> -	if (IS_ERR(addr)) {
> -		devm_remove_action(dev, dev_dax_percpu_exit, &dev_dax->ref);
> -		percpu_ref_exit(&dev_dax->ref);
> +	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> -	}
>  
>  	inode = dax_inode(dax_dev);
>  	cdev = inode->i_cdev;
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
