Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18EF7E08A4
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345390AbjKCTAK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 15:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjKCTAG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 15:00:06 -0400
Received: from bee.tesarici.cz (bee.tesarici.cz [IPv6:2a03:3b40:fe:2d4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFADD51;
        Fri,  3 Nov 2023 11:59:54 -0700 (PDT)
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bee.tesarici.cz (Postfix) with ESMTPSA id F2F4F19457D;
        Fri,  3 Nov 2023 19:59:50 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
        t=1699037991; bh=2X3978fiyf86cEJ5+RXIPYOu8hRy4Jy4zMNc86QDZf4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=abNuYzyaS5QxEYL9NMfH+Nmbuy4G7HoKPsgJX0rOT5Ejarh1eA5C9drjyau8l2XpD
         5C2ZAtsFDYM48EzJYDhYmK+Oo5JsOmBfTKqZ8d7eSTYAYAmVJ7/sLZxZVg22hmNUvS
         +jF9ti6yBEx2SgluKXxZHI/7KxY5ofI4Gmy6VYQlVp1FaqI+wqK0lKvLE54rnFNhDu
         ucY5cvfAeEl3BJmuuCxCyJcy5pJqp0ozI6usiF6VvUyneMRmuhhMIYoaGZuV4FyUdG
         4LXqhDHgdv2YLkEsadXaNne9aN2qJp7TmUayd4xXXIzqnVl2ME0RK1wENoECTfdrL/
         t6eEmmD2sbffw==
Date:   Fri, 3 Nov 2023 19:59:49 +0100
From:   Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: Memory corruption with CONFIG_SWIOTLB_DYNAMIC=y
Message-ID: <20231103195949.0af884d0@meshulam.tesarici.cz>
In-Reply-To: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
References: <104a8c8fedffd1ff8a2890983e2ec1c26bff6810.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Niklas,

thank you for your report. This is some great analysis!

On Fri, 03 Nov 2023 16:13:03 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> Hi Swiotlb Maintainers,
> 
> With s390 slated to use dma-iommu.c I was experimenting with
> CONFIG_SWIOTLB_DYNAMIC but was getting errors all over the place.
> Debugging this I've managed to narrow things down to what I believe is
> a memory corruption issue caused by overrunning the entire transient
> memory pool allocated by swiotlb. In my test this happens on the
> iommu_dma_map_page(), swiotlb_tbl_map_single() path when handling
> untrusted PCI devices.
> 
> I've seen this happen only for transient pools when:
> *  allocation size >=PAGE_SIZE and,
> *  the original address of the mapping is not page aligned. 
> 
> The overrun can be seen clearly by adding a simple "tlb_addr +
> alloc_size > pool->end' overrun check to swiotlb_tbl_map_single() and
> forcing PCI test devices to be untrusted. With that in place while an
> NVMe fio work load runs fine TCP/IP tests on a Mellanox ConnectX-4 VF
> reliably trigger the overrun check and with a debug print produce
> output like the following:
> 
> software IO TLB:
> 	transient:1
> 	index:1
> 	dma_get_min_align_mask(dev):0
> 	orig_addr:ac0caebe
> 	tlb_addr=a4d0f800
> 	start:a4d0f000
> 	end:a4d10000
> 	pool_size:4096
> 	alloc_size:4096
> 	offset:0
> 
> The complete code used for this test is available on my
> git.kernel.org[0] repository but it's bascially v6.6 + iommu/next (for
> s390 DMA API) + 2 trivial debug commits.
> 
> For further analysis I've worked closely with Halil Pasic.
> 
> The reason why we think this is happening seems twofold. Under a
> certain set of circumstances in the function swiotlb_find_slots():
> 1) the allocated transient pool can not fit the required bounce buffer,

I am aware that this can happen. It's in fact why the index returned by
swiotlb_search_pool_area() is checked in swiotlb_find_slots().

> and
> 2) the invocation of swiotlb_pool_find_slots() finds "a suitable
> slot" even though it should fail.

This needs fixing.

> The reason for 2), i.e. swiotlb_pool_find_slots() thinking there is a
> suitable bounce buffer in the pool is that for transient pools pool-
> >slots[i].list end up nonsensical, because swiotlb_init_io_tlb_pool(),  
> among other places in swiotlb, assumes that the nslabs of the pool is a
> multiple of IO_TLB_SEGSIZE

Ah... Yes, the transient pool size must also be a multiple of segment
size, but it is not enforced.

This reminds me of my debugging session that resulted in commit
aabd12609f91 ("swiotlb: always set the number of areas before
allocating the pool") and this conversation:

https://lore.kernel.org/linux-iommu/20230629074403.7f8ed9d6@meshulam.tesarici.cz/

> The reason for 1) is a bit more convoluted and not entirely understood
> by us. We are certain though that the function swiotlb_find_slots()
> allocates a pool with nr_slots(alloc_size), where this alloc_size is
> the alloc_size from swiotlb_tbl_map_single() + swiotlb_align_offset(),
> but for alignment reasons some slots may get "skipped over" in
> swiotlb_area_find_slots() causing the picked slots to overrun the
> allocation.

Yes, this can happen.

> Not sure how to properly fix this as the different alignment
> requirements get pretty complex quickly. So would appreciate your
> input.

I don't think it's possible to improve the allocation logic without
modifying the page allocator and/or the DMA atomic pool allocator to
take additional constraints into account.

I had a wild idea back in March, but it would require some intrusive
changes in the mm subsystem. Among other things, it would make memory
zones obsolete. I mean, people may actually like to get rid of DMA,
DMA32 and NORMAL, but you see how many nasty bugs were introduced even
by a relatively small change in SWIOTLB. Replacing memory zones with a
system based on generic physical allocation constraints would probably
blow up the universe. ;-)

Petr T
