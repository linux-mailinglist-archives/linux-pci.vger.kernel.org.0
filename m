Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAEE3AC3D5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhFRG2q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 02:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFRG2L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Jun 2021 02:28:11 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9639C06175F
        for <linux-pci@vger.kernel.org>; Thu, 17 Jun 2021 23:26:01 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id z4so6772668qts.4
        for <linux-pci@vger.kernel.org>; Thu, 17 Jun 2021 23:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4gmwVrd4ipCgh7Pt4U3qK6zM5RZFqVsfT+5m/JaTNY=;
        b=b3TOMvQ1kXF7QuAFyHdOkvmT8LXOEbUEDAbnT1VD77ESf6dWqJqkel2pij6H8qazUH
         qeKiHzooTElNu69H2pMv9jI9D4woaiXlDH7E4nc1glsurOz9EYewwC9YHW+cnkiHTax7
         tbypLVBnZif7y60KH97lEwI+rEiH+ILoO0+Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4gmwVrd4ipCgh7Pt4U3qK6zM5RZFqVsfT+5m/JaTNY=;
        b=pmXYrNhZGFNkl8463QlK8k7fzJVaM3/SHxuGrUbv/99aJbb54GhCBWcjo0ElkS0We3
         jUh0mltZ44n21NO4OmBNYqqNgNwotn7jK3j0ZK25i4odLuLrFvN0qADcOpSmB/jvQpML
         tOyo576W9sfZhr1rB9CoSQ5bcvUaOZEvYrygwGuzQOdXF7oJU26dGija03QBdX7+KGbg
         U6zR+JY8bVsB2GjR7jmNPyHQ9DOomxVMLrkjKMmLQFNqK6Lie+KR901OxBV3AhhbuKr3
         M1KdLw+gZEH6ebfe3W9S6pybTSnq+tgfYVlQffXWaBf3LIdEchY4q2dSKhZlHR4DEJOB
         ZWzA==
X-Gm-Message-State: AOAM530Q9CgtrmkSUI+jiE5LX2MeZfrVDGrtghK2JsTOaBvB8UDFFXYu
        YYrb+HnTMhcIC8yHWFvleZTHKvpYx6XMDA==
X-Google-Smtp-Source: ABdhPJzyselRUH75sio1puFUY8T6rtU3svJ05ex2riTrc7SYG8hXbBmExuok9kAdiYUmAN2dSYlC9A==
X-Received: by 2002:ac8:7c9c:: with SMTP id y28mr8961122qtv.192.1623997560869;
        Thu, 17 Jun 2021 23:26:00 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id b10sm3390179qkh.45.2021.06.17.23.25.59
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 23:26:00 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id g142so8369577qke.4
        for <linux-pci@vger.kernel.org>; Thu, 17 Jun 2021 23:25:59 -0700 (PDT)
X-Received: by 2002:a02:384b:: with SMTP id v11mr1842282jae.90.1623997548077;
 Thu, 17 Jun 2021 23:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210617062635.1660944-1-tientzu@chromium.org>
 <20210617062635.1660944-2-tientzu@chromium.org> <alpine.DEB.2.21.2106171434480.24906@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2106171434480.24906@sstabellini-ThinkPad-T480s>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 18 Jun 2021 14:25:37 +0800
X-Gmail-Original-Message-ID: <CALiNf29SJ0jXirWVDhJw4BUNvkjUeGPyGNJK9m8c30OPX41=5Q@mail.gmail.com>
Message-ID: <CALiNf29SJ0jXirWVDhJw4BUNvkjUeGPyGNJK9m8c30OPX41=5Q@mail.gmail.com>
Subject: Re: [PATCH v13 01/12] swiotlb: Refactor swiotlb init functions
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
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
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 7:30 AM Stefano Stabellini
<sstabellini@kernel.org> wrote:
>
> On Thu, 17 Jun 2021, Claire Chang wrote:
> > Add a new function, swiotlb_init_io_tlb_mem, for the io_tlb_mem struct
> > initialization to make the code reusable.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> > Tested-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/dma/swiotlb.c | 50 ++++++++++++++++++++++----------------------
> >  1 file changed, 25 insertions(+), 25 deletions(-)
> >
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index 52e2ac526757..47bb2a766798 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -168,9 +168,28 @@ void __init swiotlb_update_mem_attributes(void)
> >       memset(vaddr, 0, bytes);
> >  }
> >
> > -int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> > +static void swiotlb_init_io_tlb_mem(struct io_tlb_mem *mem, phys_addr_t start,
> > +                                 unsigned long nslabs, bool late_alloc)
> >  {
> > +     void *vaddr = phys_to_virt(start);
> >       unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> > +
> > +     mem->nslabs = nslabs;
> > +     mem->start = start;
> > +     mem->end = mem->start + bytes;
> > +     mem->index = 0;
> > +     mem->late_alloc = late_alloc;
> > +     spin_lock_init(&mem->lock);
> > +     for (i = 0; i < mem->nslabs; i++) {
> > +             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > +             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > +             mem->slots[i].alloc_size = 0;
> > +     }
> > +     memset(vaddr, 0, bytes);
> > +}
> > +
> > +int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> > +{
> >       struct io_tlb_mem *mem;
> >       size_t alloc_size;
> >
> > @@ -186,16 +205,8 @@ int __init swiotlb_init_with_tbl(char *tlb, unsigned long nslabs, int verbose)
> >       if (!mem)
> >               panic("%s: Failed to allocate %zu bytes align=0x%lx\n",
> >                     __func__, alloc_size, PAGE_SIZE);
> > -     mem->nslabs = nslabs;
> > -     mem->start = __pa(tlb);
> > -     mem->end = mem->start + bytes;
> > -     mem->index = 0;
> > -     spin_lock_init(&mem->lock);
> > -     for (i = 0; i < mem->nslabs; i++) {
> > -             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > -             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > -             mem->slots[i].alloc_size = 0;
> > -     }
> > +
> > +     swiotlb_init_io_tlb_mem(mem, __pa(tlb), nslabs, false);
> >
> >       io_tlb_default_mem = mem;
> >       if (verbose)
> > @@ -282,8 +293,8 @@ swiotlb_late_init_with_default_size(size_t default_size)
> >  int
> >  swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
> >  {
> > -     unsigned long bytes = nslabs << IO_TLB_SHIFT, i;
> >       struct io_tlb_mem *mem;
> > +     unsigned long bytes = nslabs << IO_TLB_SHIFT;
> >
> >       if (swiotlb_force == SWIOTLB_NO_FORCE)
> >               return 0;
> > @@ -297,20 +308,9 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
> >       if (!mem)
> >               return -ENOMEM;
> >
> > -     mem->nslabs = nslabs;
> > -     mem->start = virt_to_phys(tlb);
> > -     mem->end = mem->start + bytes;
> > -     mem->index = 0;
> > -     mem->late_alloc = 1;
> > -     spin_lock_init(&mem->lock);
> > -     for (i = 0; i < mem->nslabs; i++) {
> > -             mem->slots[i].list = IO_TLB_SEGSIZE - io_tlb_offset(i);
> > -             mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
> > -             mem->slots[i].alloc_size = 0;
> > -     }
> > -
> > +     memset(mem, 0, sizeof(*mem));
> > +     swiotlb_init_io_tlb_mem(mem, virt_to_phys(tlb), nslabs, true);
> >       set_memory_decrypted((unsigned long)tlb, bytes >> PAGE_SHIFT);
> > -     memset(tlb, 0, bytes);
>
> This is good for swiotlb_late_init_with_tbl. However I have just noticed
> that mem could also be allocated from swiotlb_init_with_tbl, in which
> case the zeroing is missing. I think we need another memset in
> swiotlb_init_with_tbl as well. Or maybe it could be better to have a
> single memset at the beginning of swiotlb_init_io_tlb_mem instead. Up to
> you.

swiotlb_init_with_tbl uses memblock_alloc to allocate the io_tlb_mem
and memblock_alloc[1] will do memset in memblock_alloc_try_nid[2], so
swiotlb_init_with_tbl is also good.
I'm happy to add the memset in swiotlb_init_io_tlb_mem if you think
it's clearer and safer.

[1] https://elixir.bootlin.com/linux/v5.13-rc6/source/include/linux/memblock.h#L407
[2] https://elixir.bootlin.com/linux/v5.13-rc6/source/mm/memblock.c#L1555
