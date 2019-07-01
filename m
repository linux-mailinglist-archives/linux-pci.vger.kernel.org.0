Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D05E2573DE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 23:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFZVsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 17:48:25 -0400
Received: from mga06.intel.com ([134.134.136.31]:46974 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfFZVsZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 17:48:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 14:48:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="183267604"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga001.fm.intel.com with ESMTP; 26 Jun 2019 14:48:23 -0700
Date:   Wed, 26 Jun 2019 14:48:23 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Message-ID: <20190626214823.GD8399@iweiny-DESK2.sc.intel.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-17-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 02:27:15PM +0200, Christoph Hellwig wrote:
> The functionality is identical to the one currently open coded in
> device-dax.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/dax/dax-private.h |  4 ----
>  drivers/dax/device.c      | 43 ---------------------------------------
>  2 files changed, 47 deletions(-)
> 
> diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
> index b4177aafbbd1..c915889d1769 100644
> --- a/drivers/dax/dax-private.h
> +++ b/drivers/dax/dax-private.h
> @@ -43,8 +43,6 @@ struct dax_region {
>   * @target_node: effective numa node if dev_dax memory range is onlined
>   * @dev - device core
>   * @pgmap - pgmap for memmap setup / lifetime (driver owned)
> - * @ref: pgmap reference count (driver owned)
> - * @cmp: @ref final put completion (driver owned)
>   */
>  struct dev_dax {
>  	struct dax_region *region;
> @@ -52,8 +50,6 @@ struct dev_dax {
>  	int target_node;
>  	struct device dev;
>  	struct dev_pagemap pgmap;
> -	struct percpu_ref ref;
> -	struct completion cmp;
>  };
>  
>  static inline struct dev_dax *to_dev_dax(struct device *dev)
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index b5257038c188..1af823b2fe6b 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -14,36 +14,6 @@
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
> -static void dev_dax_percpu_exit(struct dev_pagemap *pgmap)
> -{
> -	struct dev_dax *dev_dax = container_of(pgmap, struct dev_dax, pgmap);
> -
> -	dev_dbg(&dev_dax->dev, "%s\n", __func__);
> -	wait_for_completion(&dev_dax->cmp);
> -	percpu_ref_exit(pgmap->ref);
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
> @@ -441,11 +411,6 @@ static void dev_dax_kill(void *dev_dax)
>  	kill_dev_dax(dev_dax);
>  }
>  
> -static const struct dev_pagemap_ops dev_dax_pagemap_ops = {
> -	.kill		= dev_dax_percpu_kill,
> -	.cleanup	= dev_dax_percpu_exit,
> -};
> -
>  int dev_dax_probe(struct device *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
> @@ -463,15 +428,7 @@ int dev_dax_probe(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> -	init_completion(&dev_dax->cmp);
> -	rc = percpu_ref_init(&dev_dax->ref, dev_dax_percpu_release, 0,
> -			GFP_KERNEL);
> -	if (rc)
> -		return rc;
> -
> -	dev_dax->pgmap.ref = &dev_dax->ref;
>  	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
> -	dev_dax->pgmap.ops = &dev_dax_pagemap_ops;
>  	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
