Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7CF13B9ACB
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 05:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhGBDKn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 23:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbhGBDKm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 23:10:42 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1C6C061762;
        Thu,  1 Jul 2021 20:08:09 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 22so9741963oix.10;
        Thu, 01 Jul 2021 20:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vnC0TqPJlyIMqLOncGpr5zl9pmbmcIIyiC4phT6PUIQ=;
        b=rcatVMwnoboRAVBm6z7P2HYmOyqx+HWthzA0HOg5zSVWMr7WIAx3ZVtmMQBABS3jSs
         ll3cBrlaV5N4g4Rvy938v3Mka2o7BKSsLAnp0j9BVKtd6G0HRyhUAM117EPetSB6PYk4
         aIzksvokAZwg7oj60y4L3zka5GOYTYtCADcKKqh9eOpTeqFos+tdtKUeh13pl/ncaATb
         z+gsly2qHHMFdyn0yxdy8vih0i6Y3VD1swKheCHmBE++JlII4Ajp+FJ6942Kfxfr0p9t
         PlSPUBKWfUPw26fCx2/8jDss0gWJ7ZhSbqGnHJzN7Y9CqXNOHLSOGPQ6Z7xfZJI1OXzp
         hIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=vnC0TqPJlyIMqLOncGpr5zl9pmbmcIIyiC4phT6PUIQ=;
        b=kYAob3lfnlaFBXhNcS3y0zVaHzfksgVE2PvdSR/mRXzWDDzsJP/nWrcfZiLzuEVPjY
         2PSY3VWIg7AYnlAD480yiyYiIJZCnDj4Un4uYL9EMyD0k3KYer3O3T7D8Ot43tazIvsh
         vOnhPlAtFQiSRY2fj67SPZsETP13uiXnXcMy44/vijvvQN2xgMJ3cqNbt4P8wqsLpiiU
         dMR9XvpIcTNX93a2TA3h90EpomEV5gxg1PJ/hR5pGVZ8ntC/1gQNJGWd+wk4NJzLRq5J
         ZtuMsdzSUTG3YQpBtl3ajhmWMEoxf005D+QVyyXV6mVCgleQVvG/PZOKk9d4XPBbEtw3
         XTaw==
X-Gm-Message-State: AOAM530lwzQm+/xaxtaEQcpQ8d5Wc/qNzcbG2bHPA0hHqjdzodstgc2R
        MYC6BJN7P0E3BM9vv0/l+Jo=
X-Google-Smtp-Source: ABdhPJxROyx59a65CULGKnIjDKL6LEkceViIozGHO/6JCiILIO/ostWPfjk3TYymGpFPnNGZwku3+w==
X-Received: by 2002:a54:4187:: with SMTP id 7mr2101677oiy.127.1625195289117;
        Thu, 01 Jul 2021 20:08:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l2sm374555otl.27.2021.07.01.20.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 20:08:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Jul 2021 20:08:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        mingo@kernel.org, jxgao@google.com, sstabellini@kernel.org,
        Saravana Kannan <saravanak@google.com>, xypron.glpk@gmx.de,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>, airlied@linux.ie,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        rodrigo.vivi@intel.com, bhelgaas@google.com,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, quic_qiancai@quicinc.com,
        lkml <linux-kernel@vger.kernel.org>, tfiga@chromium.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        thomas.lendacky@amd.com, linuxppc-dev@lists.ozlabs.org,
        bauerman@linux.ibm.com
Subject: Re: [PATCH v15 12/12] of: Add plumbing for restricted DMA pool
Message-ID: <20210702030807.GA2685166@roeck-us.net>
References: <20210624155526.2775863-1-tientzu@chromium.org>
 <20210624155526.2775863-13-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624155526.2775863-13-tientzu@chromium.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 11:55:26PM +0800, Claire Chang wrote:
> If a device is not behind an IOMMU, we look up the device node and set
> up the restricted DMA when the restricted-dma-pool is presented.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>

With this patch in place, all sparc and sparc64 qemu emulations
fail to boot. Symptom is that the root file system is not found.
Reverting this patch fixes the problem. Bisect log is attached.

Guenter

---
# bad: [fb0ca446157a86b75502c1636b0d81e642fe6bf1] Add linux-next specific files for 20210701
# good: [62fb9874f5da54fdb243003b386128037319b219] Linux 5.13
git bisect start 'HEAD' 'v5.13'
# bad: [f63c4fda987a19b1194cc45cb72fd5bf968d9d90] Merge remote-tracking branch 'rdma/for-next'
git bisect bad f63c4fda987a19b1194cc45cb72fd5bf968d9d90
# good: [46bb5dd1d2a63e906e374e97dfd4a5e33934b1c4] Merge remote-tracking branch 'ipsec/master'
git bisect good 46bb5dd1d2a63e906e374e97dfd4a5e33934b1c4
# good: [43ba6969cfb8185353a7a6fc79070f13b9e3d6d3] Merge remote-tracking branch 'clk/clk-next'
git bisect good 43ba6969cfb8185353a7a6fc79070f13b9e3d6d3
# good: [1ca5eddcf8dca1d6345471c6404e7364af0d7019] Merge remote-tracking branch 'fuse/for-next'
git bisect good 1ca5eddcf8dca1d6345471c6404e7364af0d7019
# good: [8f6d7b3248705920187263a4e7147b0752ec7dcf] Merge remote-tracking branch 'pci/next'
git bisect good 8f6d7b3248705920187263a4e7147b0752ec7dcf
# good: [df1885a755784da3ef285f36d9230c1d090ef186] RDMA/rtrs_clt: Alloc less memory with write path fast memory registration
git bisect good df1885a755784da3ef285f36d9230c1d090ef186
# good: [93d31efb58c8ad4a66bbedbc2d082df458c04e45] Merge remote-tracking branch 'cpufreq-arm/cpufreq/arm/linux-next'
git bisect good 93d31efb58c8ad4a66bbedbc2d082df458c04e45
# good: [46308965ae6fdc7c25deb2e8c048510ae51bbe66] RDMA/irdma: Check contents of user-space irdma_mem_reg_req object
git bisect good 46308965ae6fdc7c25deb2e8c048510ae51bbe66
# good: [6de7a1d006ea9db235492b288312838d6878385f] thermal/drivers/int340x/processor_thermal: Split enumeration and processing part
git bisect good 6de7a1d006ea9db235492b288312838d6878385f
# good: [081bec2577cda3d04f6559c60b6f4e2242853520] dt-bindings: of: Add restricted DMA pool
git bisect good 081bec2577cda3d04f6559c60b6f4e2242853520
# good: [bf95ac0bcd69979af146852f6a617a60285ebbc1] Merge remote-tracking branch 'thermal/thermal/linux-next'
git bisect good bf95ac0bcd69979af146852f6a617a60285ebbc1
# good: [3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc] RDMA/core: Always release restrack object
git bisect good 3d8287544223a3d2f37981c1f9ffd94d0b5e9ffc
# bad: [cff1f23fad6e0bd7d671acce0d15285c709f259c] Merge remote-tracking branch 'swiotlb/linux-next'
git bisect bad cff1f23fad6e0bd7d671acce0d15285c709f259c
# bad: [b655006619b7bccd0dc1e055bd72de5d613e7b5c] of: Add plumbing for restricted DMA pool
git bisect bad b655006619b7bccd0dc1e055bd72de5d613e7b5c
# first bad commit: [b655006619b7bccd0dc1e055bd72de5d613e7b5c] of: Add plumbing for restricted DMA pool
