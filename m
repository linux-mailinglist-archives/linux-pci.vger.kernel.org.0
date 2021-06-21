Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66563AF6C0
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 22:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhFUUWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 16:22:07 -0400
Received: from verein.lst.de ([213.95.11.211]:43813 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhFUUWG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Jun 2021 16:22:06 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AC60868B05; Mon, 21 Jun 2021 22:19:46 +0200 (CEST)
Date:   Mon, 21 Jun 2021 22:19:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
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
Subject: Re: [PATCH v13 01/12] swiotlb: Refactor swiotlb init functions
Message-ID: <20210621201946.GA13822@lst.de>
References: <20210617062635.1660944-1-tientzu@chromium.org> <20210617062635.1660944-2-tientzu@chromium.org> <alpine.DEB.2.21.2106171434480.24906@sstabellini-ThinkPad-T480s> <CALiNf29SJ0jXirWVDhJw4BUNvkjUeGPyGNJK9m8c30OPX41=5Q@mail.gmail.com> <741a34cc-547c-984d-8af4-2f309880acfa@amd.com> <20210618143212.GA19284@lst.de> <alpine.DEB.2.21.2106211052270.24906@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2106211052270.24906@sstabellini-ThinkPad-T480s>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 10:59:20AM -0700, Stefano Stabellini wrote:
> Just as a clarification: I was referring to the zeroing of "mem" in
> swiotlb_late_init_with_tbl and swiotlb_init_with_tbl. While it looks
> like Tom and Christoph are talking about the zeroing of "tlb".

Indeed. 

> 
> The zeroing of "mem" is required as some fields of struct io_tlb_mem
> need to be initialized to zero. While the zeroing of "tlb" is not
> required except from the point of view of not leaking sensitive data as
> Christoph mentioned.
> 
> Either way, Claire's v14 patch 01/12 looks fine to me.

Agreed.
