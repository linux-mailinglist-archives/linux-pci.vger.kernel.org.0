Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AD23937B2
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhE0VAV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 17:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhE0VAV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 17:00:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19811613DD;
        Thu, 27 May 2021 20:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622149127;
        bh=7mKeaP5sf26KffqFFQf0USWi7lcQLBtWY2+eESjgleM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PeCbj/aB4i3LwVnhZ8X2TWhMDNIuMmt1f9y3DVfoL5/h4OLccnL0uHts0g6lA66OJ
         LRDLP94ygIvXWGPfk1j0mwIhFbDsvWdWCoKmfB+s6qN9yAoYXAyPc0hfCaWjM3Tjhe
         J0ue8w2Q+7dEwwBB1453NlnKTG0cK0jujHemRMF3X2UZW6E8hbA4A9OZxYZo8wdzV+
         9/uzQhqETwtjU+aEy/jofyozVaLcXp06SwMSO7sMZSTwnIzdCeMHmCv4zJmssG3AZB
         a+3Q4UfGp2hADwvJG45IHJ8u8cZg7LUBe2GXgVenAENHPxvSWZv6pL1D9Wh8o0ZFDW
         EqJ3jVAqIEwhA==
Date:   Thu, 27 May 2021 15:58:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v4] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20210527205845.GA1421476@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159009507306.847224.8502634072429766747.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Daniel, Krzysztof, Jason, Christoph, linux-pci]

On Thu, May 21, 2020 at 02:06:17PM -0700, Dan Williams wrote:
> Close the hole of holding a mapping over kernel driver takeover event of
> a given address range.
> 
> Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> kernel against scenarios where a /dev/mem user tramples memory that a
> kernel driver owns. However, this protection only prevents *new* read(),
> write() and mmap() requests. Established mappings prior to the driver
> calling request_mem_region() are left alone.
> 
> Especially with persistent memory, and the core kernel metadata that is
> stored there, there are plentiful scenarios for a /dev/mem user to
> violate the expectations of the driver and cause amplified damage.
> 
> Teach request_mem_region() to find and shoot down active /dev/mem
> mappings that it believes it has successfully claimed for the exclusive
> use of the driver. Effectively a driver call to request_mem_region()
> becomes a hole-punch on the /dev/mem device.

This idea of hole-punching /dev/mem has since been extended to PCI
BARs via [1].

Correct me if I'm wrong: I think this means that if a user process has
mmapped a PCI BAR via sysfs, and a kernel driver subsequently requests
that region via pci_request_region() or similar, we punch holes in the
the user process mmap.  The driver might be happy, but my guess is the
user starts seeing segmentation violations for no obvious reason and
is not happy.

Apart from the user process issue, the implementation of [1] is
problematic for PCI because the mmappable sysfs attributes now depend
on iomem_init_inode(), an fs_initcall, which means they can't be
static attributes, which ultimately leads to races in creating them.

So I'm raising the question of whether this hole-punch is the right
strategy.

  - Prior to revoke_iomem(), __request_region() was very
    self-contained and really only depended on the resource tree.  Now
    it depends on a lot of higher-level MM machinery to shoot down
    mappings of other tasks.  This adds quite a bit of complexity and
    some new ordering constraints.

  - Punching holes in the address space of an existing process seems
    unfriendly.  Maybe the driver's __request_region() should fail
    instead, since the driver should be prepared to handle failure
    there anyway.

  - [2] suggests that the hole punch protects drivers from /dev/mem
    writers, especially with persistent memory.  I'm not really
    convinced.  The hole punch does nothing to prevent a user process
    from mmapping and corrupting something before the driver loads.

Bjorn

[1] https://git.kernel.org/linus/636b21b50152
[2] https://git.kernel.org/linus/3234ac664a87

> The typical usage of unmap_mapping_range() is part of
> truncate_pagecache() to punch a hole in a file, but in this case the
> implementation is only doing the "first half" of a hole punch. Namely it
> is just evacuating current established mappings of the "hole", and it
> relies on the fact that /dev/mem establishes mappings in terms of
> absolute physical address offsets. Once existing mmap users are
> invalidated they can attempt to re-establish the mapping, or attempt to
> continue issuing read(2) / write(2) to the invalidated extent, but they
> will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
> block those subsequent accesses.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
