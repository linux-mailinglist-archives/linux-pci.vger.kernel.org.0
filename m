Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1381B3872C6
	for <lists+linux-pci@lfdr.de>; Tue, 18 May 2021 09:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239234AbhERHDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 03:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbhERHDS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 03:03:18 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947DC061573
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 00:02:01 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id c20so8366163qkm.3
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgyF0OvHzw8KTyadFBcEzsCamkUD+/ukWzei3hnGvkc=;
        b=VO0BvOlWIIiGkUdtOb1VSOWiBrk2KLMr0fiDCPwaBrvrf/j2/7hCX1JlEDcxzMqFmv
         42I6m34flwgfsu+jKFLERtm6bjzporQ7M0BTCF240tpdoJChz4PcESq3XpYvN81Vfxez
         ZW4CMor3EwZRISv4nvwP/XJ/8ZZ+MrGyZniYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgyF0OvHzw8KTyadFBcEzsCamkUD+/ukWzei3hnGvkc=;
        b=ni6oLJUtRDkSSXlSW4AAlaz59nH6R5LtReikrTNgSHt6oP/e+FeYxspIfjFNWSiDHK
         Go498Z8FhP1ew5/h7tLVzHkpK86/9KInmocdtyO/rNsIBKVuuTmS4h5SxIuo9aKdTo++
         viXKDCF/LR0UrlM/WNB6jnPNuw5d5NBxIzq6sNdpEmJ9xyy4tiWMZGrmP/NrST8JAbXs
         i4A/ur/TTtBr5h8fs2Kp3wL6ecCsWfNsNnbUAfb0CqjJ0u6fsuwfZfogPy7aWymVscGs
         3Riuliw/Vp2hqhI6JG2L7XHBcVoYeVL/J0uqlx4eYCZCkTO6a7PRwTV3bcPCGsh3io65
         fVzw==
X-Gm-Message-State: AOAM530J5NHcDski1Zt3j/hjx3kYRK3tmwOoCBmnx7T6YjA8o4ytR348
        94XOgFoAaVMijVBYN+6k8oGoY0Sm2CaW0A==
X-Google-Smtp-Source: ABdhPJxqKW+U8Y5tu83YKrPl/sj+gUmUHgMklKInuB46OSevbXLFcOBLhWkoIZaVk2fiHqweZeDMvQ==
X-Received: by 2002:ae9:ebc6:: with SMTP id b189mr3895190qkg.251.1621321320254;
        Tue, 18 May 2021 00:02:00 -0700 (PDT)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com. [209.85.160.171])
        by smtp.gmail.com with ESMTPSA id h12sm12115250qkj.52.2021.05.18.00.01.59
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 00:02:00 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id t20so6744393qtx.8
        for <linux-pci@vger.kernel.org>; Tue, 18 May 2021 00:01:59 -0700 (PDT)
X-Received: by 2002:a05:6638:10e4:: with SMTP id g4mr3960623jae.90.1621320877050;
 Mon, 17 May 2021 23:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095026.3477496-1-tientzu@chromium.org>
In-Reply-To: <20210510095026.3477496-1-tientzu@chromium.org>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 18 May 2021 14:54:26 +0800
X-Gmail-Original-Message-ID: <CALiNf2-LhQqAX3kJSETOxG4ipu9Nhs97yYiGm0XZKG7vBQ_hNQ@mail.gmail.com>
Message-ID: <CALiNf2-LhQqAX3kJSETOxG4ipu9Nhs97yYiGm0XZKG7vBQ_hNQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] Restricted DMA
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
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

v7: https://lore.kernel.org/patchwork/cover/1431031/

On Mon, May 10, 2021 at 5:50 PM Claire Chang <tientzu@chromium.org> wrote:
>
> From: Claire Chang <tientzu@google.com>
>
> This series implements mitigations for lack of DMA access control on
> systems without an IOMMU, which could result in the DMA accessing the
> system memory at unexpected times and/or unexpected addresses, possibly
> leading to data leakage or corruption.
>
> For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> not behind an IOMMU. As PCI-e, by design, gives the device full access to
> system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> full chain of exploits; [2], [3]).
>
> To mitigate the security concerns, we introduce restricted DMA. Restricted
> DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> specially allocated region and does memory allocation from the same region.
> The feature on its own provides a basic level of protection against the DMA
> overwriting buffer contents at unexpected times. However, to protect
> against general data leakage and system memory corruption, the system needs
> to provide a way to restrict the DMA to a predefined memory region (this is
> usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
>
> [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> [2] https://blade.tencent.com/en/advisories/qualpwn/
> [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
>
> v6:
> Address the comments in v5
>
> v5:
> Rebase on latest linux-next
> https://lore.kernel.org/patchwork/cover/1416899/
>
> v4:
> - Fix spinlock bad magic
> - Use rmem->name for debugfs entry
> - Address the comments in v3
> https://lore.kernel.org/patchwork/cover/1378113/
>
> v3:
> Using only one reserved memory region for both streaming DMA and memory
> allocation.
> https://lore.kernel.org/patchwork/cover/1360992/
>
> v2:
> Building on top of swiotlb.
> https://lore.kernel.org/patchwork/cover/1280705/
>
> v1:
> Using dma_map_ops.
> https://lore.kernel.org/patchwork/cover/1271660/
> *** BLURB HERE ***
>
> Claire Chang (15):
>   swiotlb: Refactor swiotlb init functions
>   swiotlb: Refactor swiotlb_create_debugfs
>   swiotlb: Add DMA_RESTRICTED_POOL
>   swiotlb: Add restricted DMA pool initialization
>   swiotlb: Add a new get_io_tlb_mem getter
>   swiotlb: Update is_swiotlb_buffer to add a struct device argument
>   swiotlb: Update is_swiotlb_active to add a struct device argument
>   swiotlb: Bounce data from/to restricted DMA pool if available
>   swiotlb: Move alloc_size to find_slots
>   swiotlb: Refactor swiotlb_tbl_unmap_single
>   dma-direct: Add a new wrapper __dma_direct_free_pages()
>   swiotlb: Add restricted DMA alloc/free support.
>   dma-direct: Allocate memory from restricted DMA pool if available
>   dt-bindings: of: Add restricted DMA pool
>   of: Add plumbing for restricted DMA pool
>
>  .../reserved-memory/reserved-memory.txt       |  27 ++
>  drivers/gpu/drm/i915/gem/i915_gem_internal.c  |   2 +-
>  drivers/gpu/drm/nouveau/nouveau_ttm.c         |   2 +-
>  drivers/iommu/dma-iommu.c                     |  12 +-
>  drivers/of/address.c                          |  25 ++
>  drivers/of/device.c                           |   3 +
>  drivers/of/of_private.h                       |   5 +
>  drivers/pci/xen-pcifront.c                    |   2 +-
>  drivers/xen/swiotlb-xen.c                     |   2 +-
>  include/linux/device.h                        |   4 +
>  include/linux/swiotlb.h                       |  41 ++-
>  kernel/dma/Kconfig                            |  14 +
>  kernel/dma/direct.c                           |  63 +++--
>  kernel/dma/direct.h                           |   9 +-
>  kernel/dma/swiotlb.c                          | 242 +++++++++++++-----
>  15 files changed, 356 insertions(+), 97 deletions(-)
>
> --
> 2.31.1.607.g51e8a6a459-goog
>
