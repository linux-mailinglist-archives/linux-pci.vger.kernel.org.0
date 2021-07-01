Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8406F3B8E44
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 09:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234877AbhGAHn2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 03:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhGAHn2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Jul 2021 03:43:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BF8F61490;
        Thu,  1 Jul 2021 07:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625125258;
        bh=V3O+3W7jB9kkeE64PRRWE2Y3UpoZf8XatBMI8/4BWL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F47xX0udIB6iAhzJO4OCoYXustVjtbNDusBM6+5rMT4M3Jwb59Ij6VbvwwiLyzT6q
         lVI9XKD0neOgmCNGZhPOuPRmgvUtcJwOJudRhNq8QU0qAxfZtInwaJU1ov8QiZuLeT
         DSyGO4DRrv/TOQGPwoVHvv2mYwNhMKcCDaJwQuNmTPf97jcrOnjcpDKJmqwAzkdem5
         hHvVa4UcTux22+QKhFYM3yrVmN1Vb2rSgrqmfY6qt7l9uLrocYxekS5t84/HB7q0FV
         t30L31wv/VRZpgr/tSPS/Ve7LY6CjYBHT4Q7WRQAtBhB8uvBHYNybLCcdlqWGz6LE7
         dIvbEvT0BuNHw==
Date:   Thu, 1 Jul 2021 08:40:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, grant.likely@arm.com,
        xypron.glpk@gmx.de, Thierry Reding <treding@nvidia.com>,
        mingo@kernel.org, bauerman@linux.ibm.com, peterz@infradead.org,
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
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <20210701074045.GA9436@willie-the-truck>
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-7-tientzu@chromium.org>
 <YNvMDFWKXSm4LRfZ@Ryzen-9-3900X.localdomain>
 <CALiNf2-a-haQN0-4+gX8+wa++52-0CnO2O4BEkxrQCxoTa_47w@mail.gmail.com>
 <20210630114348.GA8383@willie-the-truck>
 <YNyUQwiagNeZ9YeJ@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNyUQwiagNeZ9YeJ@Ryzen-9-3900X.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 30, 2021 at 08:56:51AM -0700, Nathan Chancellor wrote:
> On Wed, Jun 30, 2021 at 12:43:48PM +0100, Will Deacon wrote:
> > On Wed, Jun 30, 2021 at 05:17:27PM +0800, Claire Chang wrote:
> > > `BUG: unable to handle page fault for address: 00000000003a8290` and
> > > the fact it crashed at `_raw_spin_lock_irqsave` look like the memory
> > > (maybe dev->dma_io_tlb_mem) was corrupted?
> > > The dev->dma_io_tlb_mem should be set here
> > > (https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/pci/probe.c#n2528)
> > > through device_initialize.
> > 
> > I'm less sure about this. 'dma_io_tlb_mem' should be pointing at
> > 'io_tlb_default_mem', which is a page-aligned allocation from memblock.
> > The spinlock is at offset 0x24 in that structure, and looking at the
> > register dump from the crash:
> > 
> > Jun 29 18:28:42 hp-4300G kernel: RSP: 0018:ffffadb4013db9e8 EFLAGS: 00010006
> > Jun 29 18:28:42 hp-4300G kernel: RAX: 00000000003a8290 RBX: 0000000000000000 RCX: ffff8900572ad580
> > Jun 29 18:28:42 hp-4300G kernel: RDX: ffff89005653f024 RSI: 00000000000c0000 RDI: 0000000000001d17
> > Jun 29 18:28:42 hp-4300G kernel: RBP: 000000000a20d000 R08: 00000000000c0000 R09: 0000000000000000
> > Jun 29 18:28:42 hp-4300G kernel: R10: 000000000a20d000 R11: ffff89005653f000 R12: 0000000000000212
> > Jun 29 18:28:42 hp-4300G kernel: R13: 0000000000001000 R14: 0000000000000002 R15: 0000000000200000
> > Jun 29 18:28:42 hp-4300G kernel: FS:  00007f1f8898ea40(0000) GS:ffff890057280000(0000) knlGS:0000000000000000
> > Jun 29 18:28:42 hp-4300G kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Jun 29 18:28:42 hp-4300G kernel: CR2: 00000000003a8290 CR3: 00000001020d0000 CR4: 0000000000350ee0
> > Jun 29 18:28:42 hp-4300G kernel: Call Trace:
> > Jun 29 18:28:42 hp-4300G kernel:  _raw_spin_lock_irqsave+0x39/0x50
> > Jun 29 18:28:42 hp-4300G kernel:  swiotlb_tbl_map_single+0x12b/0x4c0
> > 
> > Then that correlates with R11 holding the 'dma_io_tlb_mem' pointer and
> > RDX pointing at the spinlock. Yet RAX is holding junk :/
> > 
> > I agree that enabling KASAN would be a good idea, but I also think we
> > probably need to get some more information out of swiotlb_tbl_map_single()
> > to see see what exactly is going wrong in there.
> 
> I can certainly enable KASAN and if there is any debug print I can add
> or dump anything, let me know!

I bit the bullet and took v5.13 with swiotlb/for-linus-5.14 merged in, built
x86 defconfig and ran it on my laptop. However, it seems to work fine!

Please can you share your .config?

Will
