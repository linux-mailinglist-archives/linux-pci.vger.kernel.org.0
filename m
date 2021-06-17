Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 423B13ABF6A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 01:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFQXcy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 19:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231476AbhFQXcy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 19:32:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 668C56113E;
        Thu, 17 Jun 2021 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623972646;
        bh=rr/c3XeFS+9sdYq4bUvVJ43Rq1hQvVCPc1yQzRKz0M4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WNUjjRc9qiEKd1v6ch2oCBMCLr//p27BpMcgjvENehNLikMoev5Wqn272QTxx71CW
         3D3qfUT5ju+4mKjQzOKKH9gG669sTY/7NSboz0Exn9xL7XiAsYwisipa8+ZFly/R/o
         DXSq4guI2oTMIWCnLtIfK2u7Aepnlt6Tlb4iaOHXykPvtPc0PDNGmILxhwM/W20xwP
         EkxLcDsLyTSrutO0JMWUgmxdcIo9gQkjJat7Q9uy0cpusxn7iT8yBAyZlIVSiyaPd+
         yrJcoSW9cwD0kiFZO94T+u3eUXoEusH4WrtVqLy3ZnfWy+/EPI7J5AbbnN0JrKQ05d
         sMIO+8CCUsK0g==
Date:   Thu, 17 Jun 2021 16:30:43 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Claire Chang <tientzu@chromium.org>
cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
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
Subject: Re: [PATCH v13 01/12] swiotlb: Refactor swiotlb init functions
In-Reply-To: <20210617062635.1660944-2-tientzu@chromium.org>
Message-ID: <alpine.DEB.2.21.2106171434480.24906@sstabellini-ThinkPad-T480s>
References: <20210617062635.1660944-1-tientzu@chromium.org> <20210617062635.1660944-2-tientzu@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Jun 2021, Claire Chang wrote:
> Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
> initialization to make the code reusable.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>
> ---
>  kernel/dma/swiotlb.c | 50 ++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 52e2ac526757..47bb2a766798 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -168,9 +168,28 @@ void __init swiotlb_update_mem_attributes(void)
>  	memset(vaddr, 0, bytes);
>  }
>  
> -int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> +static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> +				    unsigned long nslabs, bool late_alloc)
>  {
> +	void *vaddr = phys_to_virt(start);
>  	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> +
> +	mem->nslabs = nslabs;
> +	mem->start = start;
> +	mem->end = mem->start + bytes;
> +	mem->index = 0;
> +	mem->late_alloc = late_alloc;
> +	spin_lock_init(&mem->lock);
> +	for (i = 0; i < mem->nslabs; i++) {
> +		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> +		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> +		mem->slots[i].alloc_size = 0;
> +	}
> +	memset(vaddr, 0, bytes);
> +}
> +
> +int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> +{
>  	struct io_tlb_mem *mem;
>  	size_t alloc_size;
>  
> @@ -186,16 +205,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
>  	if (!mem)
>  		panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
>  		      __func__, alloc_size, PAGE_SIZE);
> -	mem->nslabs = nslabs;
> -	mem->start = __pa(tlb);
> -	mem->end = mem->start + bytes;
> -	mem->index = 0;
> -	spin_lock_init(&mem->lock);
> -	for (i = 0; i < mem->nslabs; i++) {
> -		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> -		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> -		mem->slots[i].alloc_size = 0;
> -	}
> +
> +	swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
>  
>  	io_tlb_default_mem = mem;
>  	if (verbose)
> @@ -282,8 +293,8 @@ swiotlb_late_init_with_default_size(size_t default_size)
>  int
>  swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  {
> -	unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
>  	struct io_tlb_mem *mem;
> +	unsigned long bytes = nslabs << IO_TLB_SHIFT;
>  
>  	if (swiotlb_force == SWIOTLB_NO_FORCE)
>  		return 0;
> @@ -297,20 +308,9 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
>  	if (!mem)
>  		return -ENOMEM;
>  
> -	mem->nslabs = nslabs;
> -	mem->start = virt_to_phys(tlb);
> -	mem->end = mem->start + bytes;
> -	mem->index = 0;
> -	mem->late_alloc = 1;
> -	spin_lock_init(&mem->lock);
> -	for (i = 0; i < mem->nslabs; i++) {
> -		mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> -		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> -		mem->slots[i].alloc_size = 0;
> -	}
> -
> +	memset(mem, 0, sizeof(*mem));
> +	swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
>  	set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
> -	memset(tlb, 0, bytes);
 
This is good for swiotlb_late_init_with_tbl. However I have just noticed
that mem could also be allocated from swiotlb_init_with_tbl, in which
case the zeroing is missing. I think we need another memset in
swiotlb_init_with_tbl as well. Or maybe it could be better to have a
single memset at the beginning of swiotlb_init_io_tlb_mem instead. Up to
you.
