Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85902421096
	for <lists+linux-pci@lfdr.de>; Mon,  4 Oct 2021 15:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbhJDNsw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Oct 2021 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238747AbhJDNsa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Oct 2021 09:48:30 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3EC019F75
        for <linux-pci@vger.kernel.org>; Mon,  4 Oct 2021 06:11:04 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l13so15766034qtv.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Oct 2021 06:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=paHHKoo/ZYW/alWLfZ/j7TCYl/PNWAJKpM5YE1NlK5U=;
        b=CiiZvoWKp3sR9ox9MwLe/aAoWn+zgVzIzoK5stQ+lLZ8DkbvPmGdAvlduR2gk+UfNV
         1P2afMJH7vV6IAPbHYW+Rc1sS/roPklW+dTBpRVIRTDMTOlufRxRg1g/8y1JoQ+dMbuv
         LGIfCJ9SBJ35Rx0zUSTT/N81gMCEGHaUh1bP29Efovspabd/frzknJ1uGremi9e7FwxS
         GxHlxz3fbXPf+Zsfi7b0EtSOmVd90ItpDxGwUFntNisS3pwBHUIyI3Rc56o8RcowEZMy
         Mw89sHmlOIvN3XWdOUkQFS1bSP5hsGSdPYoFBcbynXIPZSK0aKIKspXPBzoXODDrSrLW
         RE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=paHHKoo/ZYW/alWLfZ/j7TCYl/PNWAJKpM5YE1NlK5U=;
        b=YyrKdrnK7E3RF6sBRqo7LvcUlmwQYRLLFwrXfSb3zEDk77G874IxgWe3CCEY5jg7Uq
         oAKbTvpukG+Bvpz6eAUkp7vM4i11VRDYjnIoPW2dQHLSPNJIbuOM8UAjahhGR4v/iis/
         p+CQotRQiLy+DsHu8K0w1CjzeOUEsP2zboR2xoK+l7FlTJlBw1pOeMnK11rIbFd4xtTd
         qN5kvqHHTSL/4tMWOIc87uHrW4iwQVAWuHJ4VRq4DnfcQtslFnfTcfkCxjWj1NhU1FBX
         QzplS7Cuiwwdf+XHo0gHrcuLULWelCszNtC9fO57Prp1FebBZKRVxQVvwHwKARG3UTMc
         Jlrw==
X-Gm-Message-State: AOAM532zbVa/UFkGMcZkO6inQCDk7dTn6zFnIp8lARkx4JYujdckW5uz
        nFYdBLsjSk9jSL2R/4Y67fCnlg==
X-Google-Smtp-Source: ABdhPJxQOmTNv7SjQ0A/T+hfHtxMzsOyyvatzsxt2GOAUZRpJkhppd32O3vVCO/+XaAwlscFA5pPQw==
X-Received: by 2002:ac8:7594:: with SMTP id s20mr12950198qtq.158.1633353063650;
        Mon, 04 Oct 2021 06:11:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id t8sm7785072qkt.117.2021.10.04.06.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 06:11:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mXNkE-00ATWh-9x; Mon, 04 Oct 2021 10:11:02 -0300
Date:   Mon, 4 Oct 2021 10:11:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Alistair Popple <apopple@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
Message-ID: <20211004131102.GU3544071@ziepe.ca>
References: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
 <20210929230543.GB3544071@ziepe.ca>
 <32ce26d7-86e9-f8d5-f0cf-40497946efe9@deltatee.com>
 <20210929233540.GF3544071@ziepe.ca>
 <f9a83402-3d66-7437-ca47-77bac4108424@deltatee.com>
 <20210930003652.GH3544071@ziepe.ca>
 <20211001134856.GN3544071@ziepe.ca>
 <4fdd337b-fa35-a909-5eee-823bfd1e9dc4@deltatee.com>
 <20211001174511.GQ3544071@ziepe.ca>
 <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <809be72b-efb2-752c-31a6-702c8a307ce7@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 04, 2021 at 08:58:35AM +0200, Christian König wrote:
> I'm not following this discussion to closely, but try to look into it from
> time to time.
> 
> Am 01.10.21 um 19:45 schrieb Jason Gunthorpe:
> > On Fri, Oct 01, 2021 at 11:01:49AM -0600, Logan Gunthorpe wrote:
> > 
> > > In device-dax, the refcount is only used to prevent the device, and
> > > therefore the pages, from going away on device unbind. Pages cannot be
> > > recycled, as you say, as they are mapped linearly within the device. The
> > > address space invalidation is done only when the device is unbound.
> > By address space invalidation I mean invalidation of the VMA that is
> > pointing to those pages.
> > 
> > device-dax may not have a issue with use-after-VMA-invalidation by
> > it's very nature since every PFN always points to the same
> > thing. fsdax and this p2p stuff are different though.
> > 
> > > Before the invalidation, an active flag is cleared to ensure no new
> > > mappings can be created while the unmap is proceeding.
> > > unmap_mapping_range() should sequence itself with the TLB flush and
> > AFIAK unmap_mapping_range() kicks off the TLB flush and then
> > returns. It doesn't always wait for the flush to fully finish. Ie some
> > cases use RCU to lock the page table against GUP fast and so the
> > put_page() doesn't happen until the call_rcu completes - after a grace
> > period. The unmap_mapping_range() does not wait for grace periods.
> 
> Wow, wait a second. That is quite a boomer. At least in all GEM/TTM based
> graphics drivers that could potentially cause a lot of trouble.
> 
> I've just double checked and we certainly have the assumption that when
> unmap_mapping_range() returns the pte is gone and the TLB flush completed in
> quite a number of places.
> 
> Do you have more information when and why that can happen?

There are two things to keep in mind, flushing the PTEs from the HW
and serializing against gup_fast.

If you start at unmap_mapping_range() the page is eventually
discovered in zap_pte_range() and the PTE cleared. It is then passed
into __tlb_remove_page() which puts it on the batch->pages list

The page free happens in tlb_batch_pages_flush() via
free_pages_and_swap_cache()

The tlb_batch_pages_flush() happens via zap_page_range() ->
tlb_finish_mmu(), presumably after the HW has wiped the TLB's on all
CPUs. On x86 this is done with an IPI and also serializes gup fast, so
OK

The interesting case is CONFIG_MMU_GATHER_RCU_TABLE_FREE which doesn't
rely on IPIs anymore to synchronize with gup-fast.

In this configuration it means when unmap_mapping_range() returns the
TLB will have been flushed, but no serialization with GUP fast was
done.

This is OK if the GUP fast cannot return the page at all. I assume
this generally describes the DRM caes?

However, if the GUP fast can return the page then something,
somewhere, needs to serialize the page free with the RCU as the GUP
fast can be observing the old PTE before it was zap'd until the RCU
grace expires.

Relying on the page ref being !0 to protect GUP fast is not safe
because the page ref can be incr'd immediately upon page re-use.

Interestingly I looked around for this on PPC and I only found RCU
delayed freeing of the page table level, not RCU delayed freeing of
pages themselves.. I wonder if it was missed? 

There is a path on PPC (tlb_remove_table_sync_one) that triggers an
IPI but it looks like an exception, and we wouldn't need the RCU at
all if we used IPI to serialize GUP fast...

It makes logical sense if the RCU also frees the pages on
CONFIG_MMU_GATHER_RCU_TABLE_FREE so anything returnable by GUP fast
must be refcounted and freed by tlb_batch_pages_flush(), not by the
caller of unmap_mapping_range().

If we expect to allow the caller of unmap_mapping_range() to free then
CONFIG_MMU_GATHER_RCU_TABLE_FREE can't really exist, we always need to
trigger a serializing IPI during tlb_batch_pages_flush()

AFAICT, at least

Jason
