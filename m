Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8569C30EE9C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 09:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbhBDIlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 03:41:11 -0500
Received: from verein.lst.de ([213.95.11.211]:54996 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234897AbhBDIlK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 03:41:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 77E4067373; Thu,  4 Feb 2021 09:40:23 +0100 (CET)
Date:   Thu, 4 Feb 2021 09:40:23 +0100
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
Message-ID: <20210204084023.GA32328@lst.de>
References: <20210203233709.19819-1-dongli.zhang@oracle.com> <20210203233709.19819-6-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203233709.19819-6-dongli.zhang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

So one thing that has been on my mind for a while:  I'd really like
to kill the separate dma ops in Xen swiotlb.  If we compare xen-swiotlb
to swiotlb the main difference seems to be:

 - additional reasons to bounce I/O vs the plain DMA capable
 - the possibility to do a hypercall on arm/arm64
 - an extra translation layer before doing the phys_to_dma and vice
   versa
 - an special memory allocator

I wonder if inbetween a few jump labels or other no overhead enablement
options and possibly better use of the dma_range_map we could kill
off most of swiotlb-xen instead of maintaining all this code duplication?
