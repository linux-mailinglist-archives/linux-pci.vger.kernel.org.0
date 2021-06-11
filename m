Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1113A4597
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhFKPku (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbhFKPku (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:40:50 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F8BC061574
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:38:52 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id l17so2863171qtq.12
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBuYG3h4tzknol76ldpkR8y5ZC6wvonHUnBR2HL9Wtc=;
        b=M4+LxFlHhc172xr0wDyY3Eu6l5zAWJucjpWrnMkz6xoYVmzJVmf2sjGSgMe9ycmELY
         m5ZJiAX1In+iQOKRwQmSpbPtym+qFrQOUCVwhjVtCNr+j5I7ahondcOGDBRXfde7p3O6
         sP5HLhecC4zQN5hX5jVm8CbTc59EB916NxMBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBuYG3h4tzknol76ldpkR8y5ZC6wvonHUnBR2HL9Wtc=;
        b=Xig/Zb1+vc5npRyjrlu9+3KwUZWboU2i22OWEE76iorGKGV7hWVz78lHEAMCb9HJ/j
         IoDaWaJfLeUs0Y55q8FzwVzM4rxduh0CzV8qcno2gODoIkiq1Nq380KuAUmRfBvkicXy
         TlhrRu2HzqPLC8Nj3xeEOfYLZcBvPXiK8mrNYp0f2HJSLi+hVJVQS8HzZqlqyR03hUBi
         KnGs8kA+tMRdDcTx+FKoFbS2rgAj+BQ70UrzDQ3WD3WXSjTRRWI1RKmn3ycG4SE2cBOJ
         mnVjrId5xdnB/tMO9JZXP+zGp+JkJPF6QBM2rhWto31j2xIOCR47bPkKk35Gm0cuxY92
         6MBA==
X-Gm-Message-State: AOAM533zLV/alj2dpEn4pJzk4ND09FxfLw4SSHztjy0GTdruA5/oRsaQ
        anPhU8itmZOgvtoB0vqSIpeEYGIRJZofkw==
X-Google-Smtp-Source: ABdhPJxxIamUGWDvWb8pTUh6c/4PayqacW3DV7bwjw2/KBb5wb9oFstPAXYNy5jtSH5dO2IXnjfFTA==
X-Received: by 2002:a05:622a:3cd:: with SMTP id k13mr4328614qtx.388.1623425931096;
        Fri, 11 Jun 2021 08:38:51 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id l25sm4444118qtr.32.2021.06.11.08.38.50
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:38:50 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id r20so2896931qtp.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:38:50 -0700 (PDT)
X-Received: by 2002:a02:cc2f:: with SMTP id o15mr4521234jap.3.1623425606067;
 Fri, 11 Jun 2021 08:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210611152659.2142983-1-tientzu@chromium.org> <20210611152659.2142983-4-tientzu@chromium.org>
In-Reply-To: <20210611152659.2142983-4-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 11 Jun 2021 23:33:15 +0800
X-Gmail-Original-Message-ID: <CALiNf2_nzP=qLg5Fqvn3kiaMiaR9r+QJhE3pqypW4FPrgo23DQ@mail.gmail.com>
Message-ID: <CALiNf2_nzP=qLg5Fqvn3kiaMiaR9r+QJhE3pqypW4FPrgo23DQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/14] swiotlb: Set dev->dma_io_tlb_mem to the swiotlb
 pool used
To:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
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
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I'm not sure if this would break arch/x86/pci/sta2x11-fixup.c
swiotlb_late_init_with_default_size is called here
https://elixir.bootlin.com/linux/v5.13-rc5/source/arch/x86/pci/sta2x11-fixup.c#L60

On Fri, Jun 11, 2021 at 11:27 PM Claire Chang <tientzu@chromium.org> wrote:
>
> Always have the pointer to the swiotlb pool used in struct device. This
> could help simplify the code for other pools.
>
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  drivers/of/device.c     | 3 +++
>  include/linux/device.h  | 4 ++++
>  include/linux/swiotlb.h | 8 ++++++++
>  kernel/dma/swiotlb.c    | 8 ++++----
>  4 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index c5a9473a5fb1..1defdf15ba95 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -165,6 +165,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
>
>         arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
>
> +       if (IS_ENABLED(CONFIG_SWIOTLB))
> +               swiotlb_set_io_tlb_default_mem(dev);
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 4443e12238a0..2e9a378c9100 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -432,6 +432,7 @@ struct dev_links_info {
>   * @dma_pools: Dma pools (if dma'ble device).
>   * @dma_mem:   Internal for coherent mem override.
>   * @cma_area:  Contiguous memory area for dma allocations
> + * @dma_io_tlb_mem: Pointer to the swiotlb pool used.  Not for driver use.
>   * @archdata:  For arch-specific additions.
>   * @of_node:   Associated device tree node.
>   * @fwnode:    Associated device node supplied by platform firmware.
> @@ -540,6 +541,9 @@ struct device {
>  #ifdef CONFIG_DMA_CMA
>         struct cma *cma_area;           /* contiguous memory area for dma
>                                            allocations */
> +#endif
> +#ifdef CONFIG_SWIOTLB
> +       struct io_tlb_mem *dma_io_tlb_mem;
>  #endif
>         /* arch specific additions */
>         struct dev_archdata     archdata;
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 216854a5e513..008125ccd509 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -108,6 +108,11 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
>         return mem && paddr >= mem->start && paddr < mem->end;
>  }
>
> +static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
> +{
> +       dev->dma_io_tlb_mem = io_tlb_default_mem;
> +}
> +
>  void __init swiotlb_exit(void);
>  unsigned int swiotlb_max_segment(void);
>  size_t swiotlb_max_mapping_size(struct device *dev);
> @@ -119,6 +124,9 @@ static inline bool is_swiotlb_buffer(phys_addr_t paddr)
>  {
>         return false;
>  }
> +static inline void swiotlb_set_io_tlb_default_mem(struct device *dev)
> +{
> +}
>  static inline void swiotlb_exit(void)
>  {
>  }
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 8a3e2b3b246d..29b950ab1351 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -344,7 +344,7 @@ void __init swiotlb_exit(void)
>  static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size,
>                            enum dma_data_direction dir)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>         int index = (tlb_addr - mem->start) >> IO_TLB_SHIFT;
>         phys_addr_t orig_addr = mem->slots[index].orig_addr;
>         size_t alloc_size = mem->slots[index].alloc_size;
> @@ -426,7 +426,7 @@ static unsigned int wrap_index(struct io_tlb_mem *mem, unsigned int index)
>  static int find_slots(struct device *dev, phys_addr_t orig_addr,
>                 size_t alloc_size)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>         unsigned long boundary_mask = dma_get_seg_boundary(dev);
>         dma_addr_t tbl_dma_addr =
>                 phys_to_dma_unencrypted(dev, mem->start) & boundary_mask;
> @@ -503,7 +503,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>                 size_t mapping_size, size_t alloc_size,
>                 enum dma_data_direction dir, unsigned long attrs)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>         unsigned int offset = swiotlb_align_offset(dev, orig_addr);
>         unsigned int i;
>         int index;
> @@ -554,7 +554,7 @@ void swiotlb_tbl_unmap_single(struct device *hwdev, phys_addr_t tlb_addr,
>                               size_t mapping_size, enum dma_data_direction dir,
>                               unsigned long attrs)
>  {
> -       struct io_tlb_mem *mem = io_tlb_default_mem;
> +       struct io_tlb_mem *mem = hwdev->dma_io_tlb_mem;
>         unsigned long flags;
>         unsigned int offset = swiotlb_align_offset(hwdev, tlb_addr);
>         int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
> --
> 2.32.0.272.g935e593368-goog
>
