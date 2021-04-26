Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC5D36B71B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Apr 2021 18:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbhDZQoG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Apr 2021 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhDZQoF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Apr 2021 12:44:05 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09844C061574
        for <linux-pci@vger.kernel.org>; Mon, 26 Apr 2021 09:43:23 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id v13so7365845ilj.8
        for <linux-pci@vger.kernel.org>; Mon, 26 Apr 2021 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFKXKq/sKurvSVgvNvGkxgOiMlOZ5bG92GQyZxG6/Ow=;
        b=hQyrvIvY0OkwlUkO65L/o3TMJboyrA/EOLuUe0Pq7KgqeFtR8O9LJWrjeU2EQISYlu
         bJHPBsPqEo2jNERM7Qly7inrbryADiFPyU5whSnn5mfATXbgH1UnC4GjWrov7E7itgl/
         y/vmAUUGiGEmxu0IFynSQLccMWdifgG50rRhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFKXKq/sKurvSVgvNvGkxgOiMlOZ5bG92GQyZxG6/Ow=;
        b=d8ZhKSqNGjfFavfOnJbtZBaDUkAlQRYqN8Pap5mpUIdRjEQZ0gp/9cRwJGBKjinCGA
         527UleQJc5rM+xm4/xjbecb6NNimM9nSs8LZiycpo7+lofJErkW5SmMakJi0Jtq3sV3A
         bQvL7j4aJqDfbc2/miwrD24x8fJ6+DTzuolw6IQFk4gIjx4Khn99/XLOGA4/icEWuByx
         b9/CwDd5VHokuGkkD2F1FL+JgZBsfTHT1KtizU+NA8NFGsUxSrEFhCMLi1FKthiYrHQ5
         Yc+AZ51fo4Gv8Ah+GQwGvtAF5hRjefY1JddXA1p76PlpZ2G9Jhqs/BgobNlz60DPi/9e
         8zJA==
X-Gm-Message-State: AOAM530VM4lELQ6qWKn1C0HGpV2fk1jotmQs8TjN0DXcDrXQt0iBUuNb
        eHMnIhiHzXvCVQ/1QgTSIPPQR/qB8xc7Hg==
X-Google-Smtp-Source: ABdhPJxCqzG9fdwU1gphjuqpgC7aal8m7lhrPN1QXYblgDRqJiwfdqOaBEkNKSEM6Lq/nHzABbBISA==
X-Received: by 2002:a05:6e02:1145:: with SMTP id o5mr13815575ill.61.1619455402086;
        Mon, 26 Apr 2021 09:43:22 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id y8sm164699ilh.68.2021.04.26.09.43.21
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 09:43:21 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id s16so51383951iog.9
        for <linux-pci@vger.kernel.org>; Mon, 26 Apr 2021 09:43:21 -0700 (PDT)
X-Received: by 2002:a92:7307:: with SMTP id o7mr14655769ilc.5.1619455077553;
 Mon, 26 Apr 2021 09:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210422081508.3942748-1-tientzu@chromium.org>
 <20210422081508.3942748-9-tientzu@chromium.org> <1f84aa4c-f966-0986-b5a4-eecbf3b454ec@arm.com>
In-Reply-To: <1f84aa4c-f966-0986-b5a4-eecbf3b454ec@arm.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 27 Apr 2021 00:37:46 +0800
X-Gmail-Original-Message-ID: <CALiNf29N3U5GZKNN90NzjSeQ0WG4dxyRzU97fJ-r9OuChzLWKA@mail.gmail.com>
Message-ID: <CALiNf29N3U5GZKNN90NzjSeQ0WG4dxyRzU97fJ-r9OuChzLWKA@mail.gmail.com>
Subject: Re: [PATCH v5 08/16] swiotlb: Update is_swiotlb_active to add a
 struct device argument
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, grant.likely@arm.com, xypron.glpk@gmx.de,
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
        Jim Quinlan <james.quinlan@broadcom.com>,
        Tomasz Figa <tfiga@chromium.org>, bskeggs@redhat.com,
        Bjorn Helgaas <bhelgaas@google.com>, chris@chris-wilson.co.uk,
        Daniel Vetter <daniel@ffwll.ch>, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, Jianxiong Gao <jxgao@google.com>,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 23, 2021 at 9:31 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-04-22 09:15, Claire Chang wrote:
> > Update is_swiotlb_active to add a struct device argument. This will be
> > useful later to allow for restricted DMA pool.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >   drivers/gpu/drm/i915/gem/i915_gem_internal.c | 2 +-
> >   drivers/gpu/drm/nouveau/nouveau_ttm.c        | 2 +-
> >   drivers/pci/xen-pcifront.c                   | 2 +-
> >   include/linux/swiotlb.h                      | 4 ++--
> >   kernel/dma/direct.c                          | 2 +-
> >   kernel/dma/swiotlb.c                         | 4 ++--
> >   6 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> > index ce6b664b10aa..7d48c433446b 100644
> > --- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> > +++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
> > @@ -42,7 +42,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
> >
> >       max_order = MAX_ORDER;
> >   #ifdef CONFIG_SWIOTLB
> > -     if (is_swiotlb_active()) {
> > +     if (is_swiotlb_active(NULL)) {
> >               unsigned int max_segment;
> >
> >               max_segment = swiotlb_max_segment();
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> > index e8b506a6685b..2a2ae6d6cf6d 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> > @@ -321,7 +321,7 @@ nouveau_ttm_init(struct nouveau_drm *drm)
> >       }
> >
> >   #if IS_ENABLED(CONFIG_SWIOTLB) && IS_ENABLED(CONFIG_X86)
> > -     need_swiotlb = is_swiotlb_active();
> > +     need_swiotlb = is_swiotlb_active(NULL);
> >   #endif
> >
> >       ret = ttm_device_init(&drm->ttm.bdev, &nouveau_bo_driver, drm->dev->dev,
> > diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> > index b7a8f3a1921f..6d548ce53ce7 100644
> > --- a/drivers/pci/xen-pcifront.c
> > +++ b/drivers/pci/xen-pcifront.c
> > @@ -693,7 +693,7 @@ static int pcifront_connect_and_init_dma(struct pcifront_device *pdev)
> >
> >       spin_unlock(&pcifront_dev_lock);
> >
> > -     if (!err && !is_swiotlb_active()) {
> > +     if (!err && !is_swiotlb_active(NULL)) {
> >               err = pci_xen_swiotlb_init_late();
> >               if (err)
> >                       dev_err(&pdev->xdev->dev, "Could not setup SWIOTLB!\n");
> > diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> > index 2a6cca07540b..c530c976d18b 100644
> > --- a/include/linux/swiotlb.h
> > +++ b/include/linux/swiotlb.h
> > @@ -123,7 +123,7 @@ static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
> >   void __init swiotlb_exit(void);
> >   unsigned int swiotlb_max_segment(void);
> >   size_t swiotlb_max_mapping_size(struct device *dev);
> > -bool is_swiotlb_active(void);
> > +bool is_swiotlb_active(struct device *dev);
> >   void __init swiotlb_adjust_size(unsigned long size);
> >   #else
> >   #define swiotlb_force SWIOTLB_NO_FORCE
> > @@ -143,7 +143,7 @@ static inline size_t swiotlb_max_mapping_size(struct device *dev)
> >       return SIZE_MAX;
> >   }
> >
> > -static inline bool is_swiotlb_active(void)
> > +static inline bool is_swiotlb_active(struct device *dev)
> >   {
> >       return false;
> >   }
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 84c9feb5474a..7a88c34d0867 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -495,7 +495,7 @@ int dma_direct_supported(struct device *dev, u64 mask)
> >   size_t dma_direct_max_mapping_size(struct device *dev)
> >   {
> >       /* If SWIOTLB is active, use its maximum mapping size */
> > -     if (is_swiotlb_active() &&
> > +     if (is_swiotlb_active(dev) &&
> >           (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
>
> I wonder if it's worth trying to fold these other conditions into
> is_swiotlb_active() itself? I'm not entirely sure what matters for Xen,
> but for the other cases it seems like they probably only care about
> whether bouncing may occur for their particular device or not (possibly
> they want to be using dma_max_mapping_size() now anyway - TBH I'm
> struggling to make sense of what the swiotlb_max_segment business is
> supposed to mean).

I think leaving those conditions outside of is_swiotlb_active() might
help avoid confusion with is_dev_swiotlb_force() in patch #9? We need
is_dev_swiotlb_force() only because the restricted DMA pool supports
memory allocation, but the default swiotlb doesn't.

>
> Otherwise, patch #9 will need to touch here as well to make sure that
> per-device forced bouncing is reflected correctly.

You're right. Otherwise, is_dev_swiotlb_force is needed here.


>
> Robin.
>
> >               return swiotlb_max_mapping_size(dev);
> >       return SIZE_MAX;
> > diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> > index ffbb8724e06c..1d221343f1c8 100644
> > --- a/kernel/dma/swiotlb.c
> > +++ b/kernel/dma/swiotlb.c
> > @@ -659,9 +659,9 @@ size_t swiotlb_max_mapping_size(struct device *dev)
> >       return ((size_t)IO_TLB_SIZE) * IO_TLB_SEGSIZE;
> >   }
> >
> > -bool is_swiotlb_active(void)
> > +bool is_swiotlb_active(struct device *dev)
> >   {
> > -     return io_tlb_default_mem != NULL;
> > +     return get_io_tlb_mem(dev) != NULL;
> >   }
> >   EXPORT_SYMBOL_GPL(is_swiotlb_active);
> >
> >
