Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268E33BC5BA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jul 2021 06:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhGFEvd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jul 2021 00:51:33 -0400
Received: from verein.lst.de ([213.95.11.211]:59053 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhGFEvd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Jul 2021 00:51:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 25C5068BEB; Tue,  6 Jul 2021 06:48:49 +0200 (CEST)
Date:   Tue, 6 Jul 2021 06:48:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20210706044848.GA13640@lst.de>
References: <YNvMDFWKXSm4LRfZ@Ryzen-9-3900X.localdomain> <CALiNf2-a-haQN0-4+gX8+wa++52-0CnO2O4BEkxrQCxoTa_47w@mail.gmail.com> <20210630114348.GA8383@willie-the-truck> <YNyUQwiagNeZ9YeJ@Ryzen-9-3900X.localdomain> <20210701074045.GA9436@willie-the-truck> <ea28db1f-846e-4f0a-4f13-beb67e66bbca@kernel.org> <20210702135856.GB11132@willie-the-truck> <0f7bd903-e309-94a0-21d7-f0e8e9546018@arm.com> <YN/7xcxt/XGAKceZ@Ryzen-9-3900X.localdomain> <20210705190352.GA19461@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705190352.GA19461@willie-the-truck>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 05, 2021 at 08:03:52PM +0100, Will Deacon wrote:
> So at this point, the AMD IOMMU driver does:
> 
> 	swiotlb        = (iommu_default_passthrough() || sme_me_mask) ? 1 : 0;
> 
> where 'swiotlb' is a global variable indicating whether or not swiotlb
> is in use. It's picked up a bit later on by pci_swiotlb_late_init(), which
> will call swiotlb_exit() if 'swiotlb' is false.
> 
> Now, that used to work fine, because swiotlb_exit() clears
> 'io_tlb_default_mem' to NULL, but now with the restricted DMA changes, I
> think that all the devices which have successfully probed beforehand will
> have stale pointers to the freed structure in their 'dev->dma_io_tlb_mem'
> field.

Yeah.  I don't think we can do that anymore, and I also think it is
a bad idea to start with.
