Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C0B41F37A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 19:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhJARq6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhJARq6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Oct 2021 13:46:58 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0055FC06177E
        for <linux-pci@vger.kernel.org>; Fri,  1 Oct 2021 10:45:13 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id p4so9928519qki.3
        for <linux-pci@vger.kernel.org>; Fri, 01 Oct 2021 10:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CY+QWSave8EGEaNVpceAJQ+ky5w1DWCyy9j7COQnHFM=;
        b=askYTJzym7O5yaOqpeMzKwOj0j6Qwo04kEM179/a3sFhqrYyXzPAu1ifpOhcFl9q0Y
         F/PLEDnH9R02hCpQbyV2Dzb5iXF38C6sxpIDCyRjVSLdg9m4x9mzmxGfikoOrIb4KO5g
         KK7/5+UqT19eZNeA5mH/CtKtbeSKvPvg7bkvpD2k5W8s0SA56gdmbn7g92dyRjv6qzWm
         NApTHpAV13PnJqbcQXh1/icou6aS6s4O8Q5naDdwg2J2VccmTim8IhxnqvDSONGlD1i/
         3CEpYbeXydKMWMWPJCbhj1ViExG40KWNfqcSecJq4GbUKkEnpgalIV0poHVYP2TUwniL
         UMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CY+QWSave8EGEaNVpceAJQ+ky5w1DWCyy9j7COQnHFM=;
        b=I5g95vIh/zRZs52iR2uyFnCuJxsIm2vgfqmuQULMapuxHuR/rL6sFOW3G0Mh/q/C2I
         DSEVLejDbqHB6BJ6Gk2JgoB18IFOl0XrC+h85VvuafDEztsbUCet2hZ2XLiFRo6ma/ZY
         YghdrhQq6KJ0LkHFFihLrmY0lPqjDBxoS7fJIAVzB0ZNC9IXmaIsvJ2EPIUNZDnf/lD0
         +dEoOEum3ewj2eZUdQaNA23w2YDXc/E06P0vrsO9ju3a+ZkLS8AUlPX7cOJ/Hl/Ghl6d
         IejS6hymrjcI4HRyL31xZPxaWK8HBFtIcRVGYZQgPC6lsHfTSDmYR0IO+0sOwNoOhtCU
         HQHQ==
X-Gm-Message-State: AOAM5334fDobUrMzApchaKY6wBVBQzH9iXXa+XFB+bI2IcOaGU/xWywe
        6eKKKXrWm3kI6wwDcx2pIwFJkw==
X-Google-Smtp-Source: ABdhPJx/K6VNm0duCKrTeu/4uI4ViO+0lSC4pUeGkBrnh5E8R/aNPnPsk6AlICpx2DIIm1QpxAom9A==
X-Received: by 2002:a37:8747:: with SMTP id j68mr10365945qkd.165.1633110313062;
        Fri, 01 Oct 2021 10:45:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id w17sm3357837qkf.97.2021.10.01.10.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:45:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mWMat-0097tt-HS; Fri, 01 Oct 2021 14:45:11 -0300
Date:   Fri, 1 Oct 2021 14:45:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
Message-ID: <20211001174511.GQ3544071@ziepe.ca>
References: <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
 <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 01, 2021 at 11:01:49AM -0600, Logan Gunthorpe wrote:

> In device-dax, the refcount is only used to prevent the device, and
> therefore the pages, from going away on device unbind. Pages cannot be
> recycled, as you say, as they are mapped linearly within the device. The
> address space invalidation is done only when the device is unbound.

By address space invalidation I mean invalidation of the VMA that is
pointing to those pages.

device-dax may not have a issue with use-after-VMA-invalidation by
it's very nature since every PFN always points to the same
thing. fsdax and this p2p stuff are different though.

> Before the invalidation, an active flag is cleared to ensure no new
> mappings can be created while the unmap is proceeding.
> unmap_mapping_range() should sequence itself with the TLB flush and

AFIAK unmap_mapping_range() kicks off the TLB flush and then
returns. It doesn't always wait for the flush to fully finish. Ie some
cases use RCU to lock the page table against GUP fast and so the
put_page() doesn't happen until the call_rcu completes - after a grace
period. The unmap_mapping_range() does not wait for grace periods.

This is why for normal memory the put_page is done after the TLB flush
completes, not when unmap_mapping_range() finishes. This ensures that
before the refcount reaches 0 no concurrent GUP fast can still observe
the old PTEs.

> GUP-fast using the same mechanism it does for regular pages. As far as I
> can see, by the time unmap_mapping_range() returns, we should be
> confident that there are no pages left in any mapping (seeing no new
> pages could be added since before the call). 

When viewed under the page table locks this is true, but the 'fast'
walkers like gup_fast and hmm_range_fault can continue to be working
on old data in the ptes because they don't take the page table locks.

They interact with unmap_mapping_range() via the IPI/rcu (gup fast) or
mmu notifier sequence count (hmm_range_fault)

> P2PDMA follows this pattern, except pages are not mapped linearly and
> are returned to the genalloc when their refcount falls to 1. This only
> happens after a VMA is closed which should imply the PTEs have already
> been unlinked from the pages. 

And here is the problem, since the genalloc is being used we now care
that a page should not continue to be accessed by userspace after it
has be placed back into the genalloc. I suppose fsdax has the same
basic issue too.

> Not to say that all this couldn't use a big conceptual cleanup. A
> similar question exists with the single find_special_page() user
> (xen/gntdev) and it's definitely not clear what the differences are
> between the find_special_page() and vmf_insert_mixed() techniques and
> when one should be used over the other. Or could they both be merged to
> use the same technique?

Oh that gntdev stuff is just nonsense. IIRC is trying to delegate
control over a PTE entry itself to the hypervisor.

		/*
		 * gntdev takes the address of the PTE in find_grant_ptes() and
		 * passes it to the hypervisor in gntdev_map_grant_pages(). The
		 * purpose of the notifier is to prevent the hypervisor pointer
		 * to the PTE from going stale.
		 *
		 * Since this vma's mappings can't be touched without the
		 * mmap_lock, and we are holding it now, there is no need for
		 * the notifier_range locking pattern.

I vaugely recall it stuffs in a normal page then has the hypervisor
overwrite the PTE. When it comes time to free the PTE it recovers the
normal page via the 'find_special_page' hack and frees it. Somehow the
hypervisor is also using the normal page for something.

It is all very strange and one shouldn't think about it :|

Jason
