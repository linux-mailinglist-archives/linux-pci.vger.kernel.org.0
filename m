Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABBF57033
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 20:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZSBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 14:01:25 -0400
Received: from mga07.intel.com ([134.134.136.100]:1255 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbfFZSBZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 14:01:25 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 11:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,420,1557212400"; 
   d="scan'208";a="164032950"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2019 11:01:22 -0700
Date:   Wed, 26 Jun 2019 11:01:22 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org
Subject: Re: [PATCH 08/25] memremap: validate the pagemap type passed to
 devm_memremap_pages
Message-ID: <20190626180122.GB4605@iweiny-DESK2.sc.intel.com>
References: <20190626122724.13313-1-hch@lst.de>
 <20190626122724.13313-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626122724.13313-9-hch@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 02:27:07PM +0200, Christoph Hellwig wrote:
> Most pgmap types are only supported when certain config options are
> enabled.  Check for a type that is valid for the current configuration
> before setting up the pagemap.  For this the usage of the 0 type for
> device dax gets replaced with an explicit MEMORY_DEVICE_DEVDAX type.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/dax/device.c     |  1 +
>  include/linux/memremap.h |  8 ++++++++
>  kernel/memremap.c        | 22 ++++++++++++++++++++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index 8465d12fecba..79014baa782d 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -468,6 +468,7 @@ int dev_dax_probe(struct device *dev)
>  	dev_dax->pgmap.ref = &dev_dax->ref;
>  	dev_dax->pgmap.kill = dev_dax_percpu_kill;
>  	dev_dax->pgmap.cleanup = dev_dax_percpu_exit;
> +	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
>  	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 995c62c5a48b..0c86f2c5ac9c 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -45,13 +45,21 @@ struct vmem_altmap {
>   * wakeup is used to coordinate physical address space management (ex:
>   * fs truncate/hole punch) vs pinned pages (ex: device dma).
>   *
> + * MEMORY_DEVICE_DEVDAX:
> + * Host memory that has similar access semantics as System RAM i.e. DMA
> + * coherent and supports page pinning. In contrast to
> + * MEMORY_DEVICE_FS_DAX, this memory is access via a device-dax
> + * character device.
> + *
>   * MEMORY_DEVICE_PCI_P2PDMA:
>   * Device memory residing in a PCI BAR intended for use with Peer-to-Peer
>   * transactions.
>   */
>  enum memory_type {
> +	/* 0 is reserved to catch uninitialized type fields */
>  	MEMORY_DEVICE_PRIVATE = 1,
>  	MEMORY_DEVICE_FS_DAX,
> +	MEMORY_DEVICE_DEVDAX,
>  	MEMORY_DEVICE_PCI_P2PDMA,
>  };
>  
> diff --git a/kernel/memremap.c b/kernel/memremap.c
> index 6e1970719dc2..abda62d1e5a3 100644
> --- a/kernel/memremap.c
> +++ b/kernel/memremap.c
> @@ -157,6 +157,28 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
>  	pgprot_t pgprot = PAGE_KERNEL;
>  	int error, nid, is_ram;
>  
> +	switch (pgmap->type) {
> +	case MEMORY_DEVICE_PRIVATE:
> +		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
> +			WARN(1, "Device private memory not supported\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		break;
> +	case MEMORY_DEVICE_FS_DAX:
> +		if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
> +		    IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
> +			WARN(1, "File system DAX not supported\n");
> +			return ERR_PTR(-EINVAL);
> +		}
> +		break;
> +	case MEMORY_DEVICE_DEVDAX:
> +	case MEMORY_DEVICE_PCI_P2PDMA:
> +		break;
> +	default:
> +		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
> +		break;
> +	}
> +
>  	if (!pgmap->ref || !pgmap->kill || !pgmap->cleanup) {
>  		WARN(1, "Missing reference count teardown definition\n");
>  		return ERR_PTR(-EINVAL);
> -- 
> 2.20.1
> 
> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
