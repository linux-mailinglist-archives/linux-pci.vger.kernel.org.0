Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD47A3AABD4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 08:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhFQG2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 02:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhFQG2x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jun 2021 02:28:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8DAC06175F
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 23:26:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 69so2381372plc.5
        for <linux-pci@vger.kernel.org>; Wed, 16 Jun 2021 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2FafqXgYHBid0ZBe1+1JDcoq2ITMR3qeR/772URNKQ=;
        b=IVV/5fAzJUboV2IX/WhvyfcG+Tda0hKqJwIbJhxk8/euHe8sF9QY7sPB101n4t3pq0
         xCibs0rYhiNNqIGSKpxDHiRDbTJYqM6ZAdTvt7xU72VktjPhLVAhBUBErzgE8kE16i9D
         Mr8MI74zoNL4jiAa52zvQRyTf9JTWT/AWijSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T2FafqXgYHBid0ZBe1+1JDcoq2ITMR3qeR/772URNKQ=;
        b=BQH5RJb/9pDveBvAGcNvlKDndOd+eY2YrC3X2hWMi9TmZd9TSKukIMIUQHkC3ksJPg
         mnIe3ArV0CLJnqXNX924GulPH2EwKwNuxatBx4zdao/BKFH0F61dC1eP8W5PFuUImZ3z
         jK6eFHp2EUYQJtoDULhWdzURZ8G/ypULfTH/Mj6vWjKGUKoO0UMbW1TmBSbYjEpe59do
         AVoY9YdSgNhb1QEL0G1VIF9+BQG+gz626/3BGNtDy9E64BRqMcLOBOSYcTUMKiCHRADP
         OUdFdRX926EfXSg0X5PoMxHbrxwcYgFtUYEV7w7X0ynNk3Co8m4+PUJAx3bEDAkdyRkW
         bglg==
X-Gm-Message-State: AOAM532bPbLSbEDhOqBuBsGhh6MHbYnv2tGJYHOb4nzxcDKm1qRD+Z5R
        HDy9b/CIhOoEjlVuGiRVmaxc3w==
X-Google-Smtp-Source: ABdhPJy0c6CkeYmIknk2P7/qxll1LLLQMygbBdhbTcld1tRPD8L5OQgaDNVXxbwz0PNAcGxSRbzFDA==
X-Received: by 2002:a17:90b:502:: with SMTP id r2mr15134236pjz.18.1623911205862;
        Wed, 16 Jun 2021 23:26:45 -0700 (PDT)
Received: from localhost ([2401:fa00:95:205:e349:a6ae:d3d0:1621])
        by smtp.gmail.com with UTF8SMTPSA id i128sm4164159pfc.142.2021.06.16.23.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 23:26:45 -0700 (PDT)
From:   Claire Chang <tientzu@chromium.org>
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
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        tientzu@chromium.org, daniel@ffwll.ch, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        jani.nikula@linux.intel.com, jxgao@google.com,
        joonas.lahtinen@linux.intel.com, linux-pci@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, matthew.auld@intel.com,
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com
Subject: [PATCH v13 00/12] Restricted DMA
Date:   Thu, 17 Jun 2021 14:26:23 +0800
Message-Id: <20210617062635.1660944-1-tientzu@chromium.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series implements mitigations for lack of DMA access control on
systems without an IOMMU, which could result in the DMA accessing the
system memory at unexpected times and/or unexpected addresses, possibly
leading to data leakage or corruption.

For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
not behind an IOMMU. As PCI-e, by design, gives the device full access to
system memory, a vulnerability in the Wi-Fi firmware could easily escalate
to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
full chain of exploits; [2], [3]).

To mitigate the security concerns, we introduce restricted DMA. Restricted
DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
specially allocated region and does memory allocation from the same region.
The feature on its own provides a basic level of protection against the DMA
overwriting buffer contents at unexpected times. However, to protect
against general data leakage and system memory corruption, the system needs
to provide a way to restrict the DMA to a predefined memory region (this is
usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).

[1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
[1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
[2] https://blade.tencent.com/en/advisories/qualpwn/
[3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
[4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132

v13:
- Fix xen-swiotlb issues
  - memset in patch 01/12
  - is_swiotlb_force_bounce in patch 06/12
- Fix the dts example typo in reserved-memory.txt
- Add Stefano and Will's Tested-by tag from v12

v12:
Split is_dev_swiotlb_force into is_swiotlb_force_bounce (patch 06/12) and
is_swiotlb_for_alloc (patch 09/12)
https://lore.kernel.org/patchwork/cover/1447254/

v11:
- Rebase against swiotlb devel/for-linus-5.14
- s/mempry/memory/g
- exchange the order of patch 09/12 and 10/12
https://lore.kernel.org/patchwork/cover/1447216/

v10:
Address the comments in v9 to
  - fix the dev->dma_io_tlb_mem assignment
  - propagate swiotlb_force setting into io_tlb_default_mem->force
  - move set_memory_decrypted out of swiotlb_init_io_tlb_mem
  - move debugfs_dir declaration into the main CONFIG_DEBUG_FS block
  - add swiotlb_ prefix to find_slots and release_slots
  - merge the 3 alloc/free related patches
  - move the CONFIG_DMA_RESTRICTED_POOL later
https://lore.kernel.org/patchwork/cover/1446882/

v9:
Address the comments in v7 to
  - set swiotlb active pool to dev->dma_io_tlb_mem
  - get rid of get_io_tlb_mem
  - dig out the device struct for is_swiotlb_active
  - move debugfs_create_dir out of swiotlb_create_debugfs
  - do set_memory_decrypted conditionally in swiotlb_init_io_tlb_mem
  - use IS_ENABLED in kernel/dma/direct.c
  - fix redefinition of 'of_dma_set_restricted_buffer'
https://lore.kernel.org/patchwork/cover/1445081/

v8:
- Fix reserved-memory.txt and add the reg property in example.
- Fix sizeof for of_property_count_elems_of_size in
  drivers/of/address.c#of_dma_set_restricted_buffer.
- Apply Will's suggestion to try the OF node having DMA configuration in
  drivers/of/address.c#of_dma_set_restricted_buffer.
- Fix typo in the comment of drivers/of/address.c#of_dma_set_restricted_buffer.
- Add error message for PageHighMem in
  kernel/dma/swiotlb.c#rmem_swiotlb_device_init and move it to
  rmem_swiotlb_setup.
- Fix the message string in rmem_swiotlb_setup.
https://lore.kernel.org/patchwork/cover/1437112/

v7:
Fix debugfs, PageHighMem and comment style in rmem_swiotlb_device_init
https://lore.kernel.org/patchwork/cover/1431031/

v6:
Address the comments in v5
https://lore.kernel.org/patchwork/cover/1423201/

v5:
Rebase on latest linux-next
https://lore.kernel.org/patchwork/cover/1416899/

v4:
- Fix spinlock bad magic
- Use rmem->name for debugfs entry
- Address the comments in v3
https://lore.kernel.org/patchwork/cover/1378113/

v3:
Using only one reserved memory region for both streaming DMA and memory
allocation.
https://lore.kernel.org/patchwork/cover/1360992/

v2:
Building on top of swiotlb.
https://lore.kernel.org/patchwork/cover/1280705/

v1:
Using dma_map_ops.
https://lore.kernel.org/patchwork/cover/1271660/

Claire Chang (12):
  swiotlb: Refactor swiotlb init functions
  swiotlb: Refactor swiotlb_create_debugfs
  swiotlb: Set dev->dma_io_tlb_mem to the swiotlb pool used
  swiotlb: Update is_swiotlb_buffer to add a struct device argument
  swiotlb: Update is_swiotlb_active to add a struct device argument
  swiotlb: Use is_swiotlb_force_bounce for swiotlb data bouncing
  swiotlb: Move alloc_size to swiotlb_find_slots
  swiotlb: Refactor swiotlb_tbl_unmap_single
  swiotlb: Add restricted DMA alloc/free support
  swiotlb: Add restricted DMA pool initialization
  dt-bindings: of: Add restricted DMA pool
  of: Add plumbing for restricted DMA pool

 .../reserved-memory/reserved-memory.txt       |  36 ++-
 drivers/base/core.c                           |   4 +
 drivers/gpu/drm/i915/gem/i915_gem_internal.c  |   2 +-
 drivers/gpu/drm/nouveau/nouveau_ttm.c         |   2 +-
 drivers/iommu/dma-iommu.c                     |  12 +-
 drivers/of/address.c                          |  33 +++
 drivers/of/device.c                           |   3 +
 drivers/of/of_private.h                       |   6 +
 drivers/pci/xen-pcifront.c                    |   2 +-
 drivers/xen/swiotlb-xen.c                     |   4 +-
 include/linux/device.h                        |   4 +
 include/linux/swiotlb.h                       |  51 +++-
 kernel/dma/Kconfig                            |  14 +
 kernel/dma/direct.c                           |  59 +++--
 kernel/dma/direct.h                           |   8 +-
 kernel/dma/swiotlb.c                          | 250 +++++++++++++-----
 16 files changed, 387 insertions(+), 103 deletions(-)

-- 
2.32.0.288.g62a8d224e6-goog

