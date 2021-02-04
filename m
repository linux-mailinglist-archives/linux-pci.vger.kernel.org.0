Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1228030ED5D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 08:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234068AbhBDHag (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 02:30:36 -0500
Received: from verein.lst.de ([213.95.11.211]:54722 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232977AbhBDHaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Feb 2021 02:30:35 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD16068AFE; Thu,  4 Feb 2021 08:29:47 +0100 (CET)
Date:   Thu, 4 Feb 2021 08:29:47 +0100
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
        thomas.lendacky@amd.com, Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH RFC v1 2/6] swiotlb: convert variables to arrays
Message-ID: <20210204072947.GA29812@lst.de>
References: <20210203233709.19819-1-dongli.zhang@oracle.com> <20210203233709.19819-3-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203233709.19819-3-dongli.zhang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 03, 2021 at 03:37:05PM -0800, Dongli Zhang wrote:
> This patch converts several swiotlb related variables to arrays, in
> order to maintain stat/status for different swiotlb buffers. Here are
> variables involved:
> 
> - io_tlb_start and io_tlb_end
> - io_tlb_nslabs and io_tlb_used
> - io_tlb_list
> - io_tlb_index
> - max_segment
> - io_tlb_orig_addr
> - no_iotlb_memory
> 
> There is no functional change and this is to prepare to enable 64-bit
> swiotlb.

Claire Chang (on Cc) already posted a patch like this a month ago,
which looks much better because it actually uses a struct instead
of all the random variables. 
