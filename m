Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4E6392E62
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhE0MzM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235714AbhE0MzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 08:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B984D6109F;
        Thu, 27 May 2021 12:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622120018;
        bh=mnHenbEzMbQdhDrGu816+dyeKu927RlHNDgNBf8bfNk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T2Q+xyFZywvya0fPBfvK4sRdbR/bde8Rq8P4FN21AACPVaQSQsdEc0x2+0v5r+abP
         3/8E7TEJSHcMhmUgcHo1bhdAA9AfzEMLppzT6/0P8DePbBmTljtDkX4NEtYRaHLEM1
         Gnn3YP4aa748IT6RrSs7VU9Pqy8c4Xvink86bWS+UgwCuEehm3hOhTqBJaoQ8WPXJq
         ulYWtbHvYOw84jAR1SH3F2sv+RGThyTfyzG8N3saQSkF5BsBVg+8LW53nliUGD6EFQ
         5/RBGn2iLBX38fmxUgOxq5fMNgVhtClQMCVzqiJ/tPC3LfS/b2F3cV49KGjPHavT/f
         X+zziZDTtPkzw==
Date:   Thu, 27 May 2021 13:53:28 +0100
From:   Will Deacon <will@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
        peterz@infradead.org, benh@kernel.crashing.org,
        joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
        chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
        Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
        sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
        mpe@ellerman.id.au,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        bskeggs@redhat.com, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Thierry Reding <treding@nvidia.com>,
        intel-gfx@lists.freedesktop.org, matthew.auld@intel.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Jianxiong Gao <jxgao@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        Dan Williams <dan.j.williams@intel.com>,
        linuxppc-dev@lists.ozlabs.org, jani.nikula@linux.intel.com,
        Rob Herring <robh+dt@kernel.org>, rodrigo.vivi@intel.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        boris.ostrovsky@oracle.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        jgross@suse.com, Nicolas Boichat <drinkcat@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
        Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
Subject: Re: [PATCH v7 14/15] dt-bindings: of: Add restricted DMA pool
Message-ID: <20210527125328.GA22352@willie-the-truck>
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-15-tientzu@chromium.org>
 <20210526121322.GA19313@willie-the-truck>
 <20210526155321.GA19633@willie-the-truck>
 <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
 <20210527113456.GA22019@willie-the-truck>
 <CALiNf2_Qk5DmZSJO+jv=m5V-VFtmL9j0v66UY6qKmM-2pr3tRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALiNf2_Qk5DmZSJO+jv=m5V-VFtmL9j0v66UY6qKmM-2pr3tRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 08:48:59PM +0800, Claire Chang wrote:
> On Thu, May 27, 2021 at 7:35 PM Will Deacon <will@kernel.org> wrote:
> >
> > On Thu, May 27, 2021 at 07:29:20PM +0800, Claire Chang wrote:
> > > On Wed, May 26, 2021 at 11:53 PM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Wed, May 26, 2021 at 01:13:22PM +0100, Will Deacon wrote:
> > > > > On Tue, May 18, 2021 at 02:42:14PM +0800, Claire Chang wrote:
> > > > > > @@ -138,4 +160,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > > > > >             memory-region = <&multimedia_reserved>;
> > > > > >             /* ... */
> > > > > >     };
> > > > > > +
> > > > > > +   pcie_device: pcie_device@0,0 {
> > > > > > +           memory-region = <&restricted_dma_mem_reserved>;
> > > > > > +           /* ... */
> > > > > > +   };
> > > > >
> > > > > I still don't understand how this works for individual PCIe devices -- how
> > > > > is dev->of_node set to point at the node you have above?
> > > > >
> > > > > I tried adding the memory-region to the host controller instead, and then
> > > > > I see it crop up in dmesg:
> > > > >
> > > > >   | pci-host-generic 40000000.pci: assigned reserved memory node restricted_dma_mem_reserved
> > > > >
> > > > > but none of the actual PCI devices end up with 'dma_io_tlb_mem' set, and
> > > > > so the restricted DMA area is not used. In fact, swiotlb isn't used at all.
> > > > >
> > > > > What am I missing to make this work with PCIe devices?
> > > >
> > > > Aha, looks like we're just missing the logic to inherit the DMA
> > > > configuration. The diff below gets things working for me.
> > >
> > > I guess what was missing is the reg property in the pcie_device node.
> > > Will update the example dts.
> >
> > Thanks. I still think something like my diff makes sense, if you wouldn't mind including
> > it, as it allows restricted DMA to be used for situations where the PCIe
> > topology is not static.
> >
> > Perhaps we should prefer dev->of_node if it exists, but then use the node
> > of the host bridge's parent node otherwise?
> 
> Sure. Let me add in the next version.

Brill, thanks! I'll take it for a spin once it lands on the list.

Will
