Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133523125A3
	for <lists+linux-pci@lfdr.de>; Sun,  7 Feb 2021 16:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhBGP4v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Feb 2021 10:56:51 -0500
Received: from verein.lst.de ([213.95.11.211]:38553 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhBGP4u (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 7 Feb 2021 10:56:50 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3732F68B02; Sun,  7 Feb 2021 16:56:02 +0100 (CET)
Date:   Sun, 7 Feb 2021 16:56:01 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nouveau@lists.freedesktop.org,
        x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        akpm@linux-foundation.org, benh@kernel.crashing.org,
        bskeggs@redhat.com, bhelgaas@google.com, bp@alien8.de,
        boris.ostrovsky@oracle.com, hch@lst.de, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, hpa@zytor.com, mingo@kernel.org,
        mingo@redhat.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, jgross@suse.com,
        konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        matthew.auld@intel.com, mpe@ellerman.id.au, rppt@kernel.org,
        paulus@samba.org, peterz@infradead.org, robin.murphy@arm.com,
        rodrigo.vivi@intel.com, sstabellini@kernel.org,
        bauerman@linux.ibm.com, tsbogend@alpha.franken.de,
        tglx@linutronix.de, ulf.hansson@linaro.org, joe.jin@oracle.com,
        thomas.lendacky@amd.com
Subject: Re: [PATCH RFC v1 5/6] xen-swiotlb: convert variables to arrays
Message-ID: <20210207155601.GA25111@lst.de>
References: <20210203233709.19819-1-dongli.zhang@oracle.com> <20210203233709.19819-6-dongli.zhang@oracle.com> <20210204084023.GA32328@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204084023.GA32328@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 04, 2021 at 09:40:23AM +0100, Christoph Hellwig wrote:
> So one thing that has been on my mind for a while:  I'd really like
> to kill the separate dma ops in Xen swiotlb.  If we compare xen-swiotlb
> to swiotlb the main difference seems to be:
> 
>  - additional reasons to bounce I/O vs the plain DMA capable
>  - the possibility to do a hypercall on arm/arm64
>  - an extra translation layer before doing the phys_to_dma and vice
>    versa
>  - an special memory allocator
> 
> I wonder if inbetween a few jump labels or other no overhead enablement
> options and possibly better use of the dma_range_map we could kill
> off most of swiotlb-xen instead of maintaining all this code duplication?

So I looked at this a bit more.

For x86 with XENFEAT_auto_translated_physmap (how common is that?)
pfn_to_gfn is a nop, so plain phys_to_dma/dma_to_phys do work as-is.

xen_arch_need_swiotlb always returns true for x86, and
range_straddles_page_boundary should never be true for the
XENFEAT_auto_translated_physmap case.

So as far as I can tell the mapping fast path for the
XENFEAT_auto_translated_physmap can be trivially reused from swiotlb.

That leaves us with the next more complicated case, x86 or fully cache
coherent arm{,64} without XENFEAT_auto_translated_physmap.  In that case
we need to patch in a phys_to_dma/dma_to_phys that performs the MFN
lookup, which could be done using alternatives or jump labels.
I think if that is done right we should also be able to let that cover
the foreign pages in is_xen_swiotlb_buffer/is_swiotlb_buffer, but
in that worst case that would need another alternative / jump label.

For non-coherent arm{,64} we'd also need to use alternatives or jump
labels to for the cache maintainance ops, but that isn't a hard problem
either.


