Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E4392CB5
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 13:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbhE0LbV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 07:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhE0LbT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 07:31:19 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FE1C061761
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 04:29:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 22so327885pfv.11
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XepQkdRFyf5QwVg1KdPLbhegPooaNHd/1JiifJ+YyHM=;
        b=J39qajy3UJ3qAzWqGeZGEnwMoSI9LW5BjibS8fd+Acudu4FxBAXa2OhDGjuMcgqW0/
         wo/z5L5WO21v6biwP7ZKEgtIJf223PVujpTOF4zDsL3aPOmxJx+dxaS3A0oSwB4zv/i6
         Jb0bh8tNiRStD2FZiusMVkFxa8G1teBBpM9vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XepQkdRFyf5QwVg1KdPLbhegPooaNHd/1JiifJ+YyHM=;
        b=DAgeRtO4PCGxiJurTE24Q9qVLYaCGjT5Njz6NbpiotSlBdRHNQAn52kX6QSE/PEWl1
         vhyt58VGWEksNo6v8d8026sRyZl87K/p4ofqzEwcUCaOE4AJqcOmlTWkjskL6/AF6HBZ
         4qxjCJ5bt0KmA0HDV3+leBuAyGko2m6Y6c3XPUAle6Fx211a6wbn8Qvc3TW9OErfxXeE
         P5n32AuZEFpZIJurYiXKsESg3otWnbcVwLVIdklP94YGZYdAnAnqDf1hnFOJnhFPMWy4
         QvB5gYv3xK2JmS0FmaSkbg3T5a09P7JX1XWV5iTdDdGnOHbDsZh0w3OIlGwSKeZ/0lAA
         NxxA==
X-Gm-Message-State: AOAM530ZU6gTVBreTL+EkRgOCC3RLf30eTiux/g/Dg0HooY5zhdHEIX8
        7dckipUtz2Nlns29AwzmYrSE/H0hMmEs0Q==
X-Google-Smtp-Source: ABdhPJxpgTzM8BZ+6p+2lc/8mvkbN3WdMCdLZA5S40FHMYKGPGKSXnItwuLLB0ACAL62cyY3ts4TjQ==
X-Received: by 2002:a65:5181:: with SMTP id h1mr3298038pgq.330.1622114984788;
        Thu, 27 May 2021 04:29:44 -0700 (PDT)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com. [209.85.215.175])
        by smtp.gmail.com with ESMTPSA id i8sm1641720pgt.58.2021.05.27.04.29.42
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 04:29:44 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 6so3468277pgk.5
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 04:29:42 -0700 (PDT)
X-Received: by 2002:a05:6e02:e42:: with SMTP id l2mr2536928ilk.189.1622114971302;
 Thu, 27 May 2021 04:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-15-tientzu@chromium.org> <20210526121322.GA19313@willie-the-truck>
 <20210526155321.GA19633@willie-the-truck>
In-Reply-To: <20210526155321.GA19633@willie-the-truck>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 27 May 2021 19:29:20 +0800
X-Gmail-Original-Message-ID: <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
Message-ID: <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
Subject: Re: [PATCH v7 14/15] dt-bindings: of: Add restricted DMA pool
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
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

On Wed, May 26, 2021 at 11:53 PM Will Deacon <will@kernel.org> wrote:
>
> On Wed, May 26, 2021 at 01:13:22PM +0100, Will Deacon wrote:
> > On Tue, May 18, 2021 at 02:42:14PM +0800, Claire Chang wrote:
> > > @@ -138,4 +160,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > >             memory-region = <&multimedia_reserved>;
> > >             /* ... */
> > >     };
> > > +
> > > +   pcie_device: pcie_device@0,0 {
> > > +           memory-region = <&restricted_dma_mem_reserved>;
> > > +           /* ... */
> > > +   };
> >
> > I still don't understand how this works for individual PCIe devices -- how
> > is dev->of_node set to point at the node you have above?
> >
> > I tried adding the memory-region to the host controller instead, and then
> > I see it crop up in dmesg:
> >
> >   | pci-host-generic 40000000.pci: assigned reserved memory node restricted_dma_mem_reserved
> >
> > but none of the actual PCI devices end up with 'dma_io_tlb_mem' set, and
> > so the restricted DMA area is not used. In fact, swiotlb isn't used at all.
> >
> > What am I missing to make this work with PCIe devices?
>
> Aha, looks like we're just missing the logic to inherit the DMA
> configuration. The diff below gets things working for me.

I guess what was missing is the reg property in the pcie_device node.
Will update the example dts.
