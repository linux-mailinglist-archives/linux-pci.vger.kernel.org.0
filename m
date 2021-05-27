Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C4A392F77
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 15:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbhE0N00 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 09:26:26 -0400
Received: from verein.lst.de ([213.95.11.211]:38952 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236306AbhE0N0W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 09:26:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A8FB568AFE; Thu, 27 May 2021 15:24:42 +0200 (CEST)
Date:   Thu, 27 May 2021 15:24:42 +0200
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
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Subject: Re: [PATCH v7 02/15] swiotlb: Refactor swiotlb_create_debugfs
Message-ID: <20210527132442.GA26160@lst.de>
References: <20210518064215.2856977-1-tientzu@chromium.org> <20210518064215.2856977-3-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518064215.2856977-3-tientzu@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 18, 2021 at 02:42:02PM +0800, Claire Chang wrote:
>  struct io_tlb_mem *io_tlb_default_mem;
> +static struct dentry *debugfs_dir;
>  
>  /*
>   * Max segment that we can provide which (if pages are contingous) will
> @@ -662,18 +663,30 @@ EXPORT_SYMBOL_GPL(is_swiotlb_active);
>  
>  #ifdef CONFIG_DEBUG_FS
>  
> +static void swiotlb_create_debugfs(struct io_tlb_mem *mem, const char *name)
>  {
>  	if (!mem)
> +		return;

I don't think this check makes much sense here.

> +}
> +
> +static int __init swiotlb_create_default_debugfs(void)
> +{
> +	struct io_tlb_mem *mem = io_tlb_default_mem;
> +
> +	if (mem) {
> +		swiotlb_create_debugfs(mem, "swiotlb");
> +		debugfs_dir = mem->debugfs;
> +	} else {
> +		debugfs_dir = debugfs_create_dir("swiotlb", NULL);
> +	}

This also looks rather strange.  I'd much rather create move the
directory creation of out swiotlb_create_debugfs.  E.g. something like:

static void swiotlb_create_debugfs_file(struct io_tlb_mem *mem)
{
	debugfs_create_ulong("io_tlb_nslabs", 0400, mem->debugfs, &mem->nslabs);
	debugfs_create_ulong("io_tlb_used", 0400, mem->debugfs, &mem->used);
}

static int __init swiotlb_init_debugfs(void)
{
	debugfs_dir = debugfs_create_dir("swiotlb", NULL);
	if (io_tlb_default_mem) {
		io_tlb_default_mem->debugfs = debugfs_dir;
		swiotlb_create_debugfs_files(io_tlb_default_mem);
	}
	return 0;
}
late_initcall(swiotlb_init_debugfs);

...

static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
                                    struct device *dev)
{
	...
		mem->debugfs = debugfs_create_dir(rmem->name, debugfs_dir);
		swiotlb_create_debugfs_files(mem->debugfs);

			
}
