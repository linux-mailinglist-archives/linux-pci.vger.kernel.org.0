Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5DA3BC2F3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 21:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhGETGm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 15:06:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhGETGm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Jul 2021 15:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D07161978;
        Mon,  5 Jul 2021 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625511844;
        bh=o012umLuvyjggdb73nB1nx1kOYsPv1SNeUIs18hDcAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRwf1cGaUQnGNSK48BMiS8/L53RP5G/QW+0L7WarqJg3vdXhPi76IMHEfxJBcIPa3
         O/IVWGS61Gw63qZ6P/lu+E1G7lOjBRQgMMYZUlxciRBcXpXeaEm0Nt8VlI20vyORW0
         5Yt77iWQoVMzfxA0eNrndYooJS41ndFVzjZWCxmusBkktvSuT3rDjxcvXFg+FyE3zq
         Tiys8WKwLxyKU0wwkmXs/VX0V/xsNc/cZvd76dhCDw80UkiEfPmHKQyUCziEG4n9+X
         zngjj2Bp6GquWJbjoHo8XOCLo60dYdheBX5hvWTEA+kb21c5xQf9Khdj2j/E3DZMQq
         mzeeqFIjv4raA==
Date:   Mon, 5 Jul 2021 20:03:52 +0100
From:   Will Deacon <will@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Claire Chang <tientzu@chromium.org>,
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
        rodrigo.vivi@intel.com, thomas.hellstrom@linux.intel.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH v15 06/12] swiotlb: Use is_swiotlb_force_bounce for
 swiotlb data bouncing
Message-ID: <20210705190352.GA19461@willie-the-truck>
References: <20210624155526.2775863-7-tientzu@chromium.org>
 <YNvMDFWKXSm4LRfZ@Ryzen-9-3900X.localdomain>
 <CALiNf2-a-haQN0-4+gX8+wa++52-0CnO2O4BEkxrQCxoTa_47w@mail.gmail.com>
 <20210630114348.GA8383@willie-the-truck>
 <YNyUQwiagNeZ9YeJ@Ryzen-9-3900X.localdomain>
 <20210701074045.GA9436@willie-the-truck>
 <ea28db1f-846e-4f0a-4f13-beb67e66bbca@kernel.org>
 <20210702135856.GB11132@willie-the-truck>
 <0f7bd903-e309-94a0-21d7-f0e8e9546018@arm.com>
 <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Nathan,

I may have just spotted something in these logs...

On Fri, Jul 02, 2021 at 10:55:17PM -0700, Nathan Chancellor wrote:
> [    2.340956] pci 0000:0c:00.1: Adding to iommu group 4
> [    2.340996] pci 0000:0c:00.2: Adding to iommu group 4
> [    2.341038] pci 0000:0c:00.3: Adding to iommu group 4
> [    2.341078] pci 0000:0c:00.4: Adding to iommu group 4
> [    2.341122] pci 0000:0c:00.6: Adding to iommu group 4
> [    2.341163] pci 0000:0d:00.0: Adding to iommu group 4
> [    2.341203] pci 0000:0d:00.1: Adding to iommu group 4
> [    2.361821] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
> [    2.361839] pci 0000:00:00.2: AMD-Vi: Extended features (0x206d73ef22254ade):
> [    2.361846]  PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    2.361861] AMD-Vi: Interrupt remapping enabled
> [    2.361865] AMD-Vi: Virtual APIC enabled
> [    2.361870] AMD-Vi: X2APIC enabled
> [    2.362272] AMD-Vi: Lazy IO/TLB flushing enabled

So at this point, the AMD IOMMU driver does:

	swiotlb        = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;

where 'swiotlb' is a global variable indicating whether or not swiotlb
is in use. It's picked up a bit later on by pci_swiotlb_late_init(), which
will call swiotlb_exit() if 'swiotlb' is false.

Now, that used to work fine, because swiotlb_exit() clears
'io_tlb_default_mem' to NULL, but now with the restricted DMA changes, I
think that all the devices which have successfully probed beforehand will
have stale pointers to the freed structure in their 'dev->dma_io_tlb_mem'
field.

Will
