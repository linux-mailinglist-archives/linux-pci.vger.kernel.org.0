Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E805C3791F6
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 17:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhEJPGs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 11:06:48 -0400
Received: from verein.lst.de ([213.95.11.211]:60398 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233942AbhEJPEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 May 2021 11:04:13 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B33867373; Mon, 10 May 2021 17:02:57 +0200 (CEST)
Date:   Mon, 10 May 2021 17:02:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, nouveau@lists.freedesktop.org,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: Re: [PATCH v6 04/15] swiotlb: Add restricted DMA pool
 initialization
Message-ID: <20210510150256.GC28066@lst.de>
References: <20210510095026.3477496-1-tientzu@chromium.org> <20210510095026.3477496-5-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510095026.3477496-5-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/slab.h>
> +#endif

I don't think any of this belongs into swiotlb.c.  Marking
swiotlb_init_io_tlb_mem non-static and having all this code in a separate
file is probably a better idea.

> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> +				    struct device *dev)
> +{
> +	struct io_tlb_mem *mem = rmem->priv;
> +	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
> +
> +	if (dev->dma_io_tlb_mem)
> +		return 0;
> +
> +	/* Since multiple devices can share the same pool, the private data,
> +	 * io_tlb_mem struct, will be initialized by the first device attached
> +	 * to it.
> +	 */

This is not the normal kernel comment style.

> +#ifdef CONFIG_ARM
> +		if (!PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
> +			kfree(mem);
> +			return -EINVAL;
> +		}
> +#endif /* CONFIG_ARM */

And this is weird.  Why would ARM have such a restriction?  And if we have
such rstrictions it absolutely belongs into an arch helper.

> +		swiotlb_init_io_tlb_mem(mem, rmem->base, nslabs, false);
> +
> +		rmem->priv = mem;
> +
> +#ifdef CONFIG_DEBUG_FS
> +		if (!debugfs_dir)
> +			debugfs_dir = debugfs_create_dir("swiotlb", NULL);
> +
> +		swiotlb_create_debugfs(mem, rmem->name, debugfs_dir);

Doesn't the debugfs_create_dir belong into swiotlb_create_debugfs?  Also
please use IS_ENABLEd or a stub to avoid ifdefs like this.
