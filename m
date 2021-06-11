Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60743A456E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhFKPeZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 11:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbhFKPeZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 11:34:25 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF25C061574
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:32:16 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a6so31636482ioe.0
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=89FDdm5otB6kfSIY1wN8GtI+ciQx5v+glSl+A+k1+x0=;
        b=UdgbVNlCM2Z2m4AZZMvHuq5iZqq6a6B1k1NgNWN8Vbr0FhlXEkOMcXQOmqkTt81W9l
         ZZvZ8qEfilw4IVJQmcyphxlOFoGk0yzalYprjSKjTm0i0iDciVsO4hDbAAQ2CGlI10y9
         ZbSgy3asVidQE8sG2vEkYEnh2JJM0V3DCy6O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=89FDdm5otB6kfSIY1wN8GtI+ciQx5v+glSl+A+k1+x0=;
        b=P0XoQuFt2rTNyCKrbcxMV9Y063+RLTWlDJLCZKSAaVMmqpfYFz4T9uavCQGK0HaDm+
         FSAME6NoulvvDLDXnUZHu8q4nbGEqy9j1G5mZgLQL2zTUXMj+vffOScP+HHugE7gpuNs
         8FZ+E85FDuDOjvJ/MAGP5rZ68WyykqRk/fmPx8YLpnBCK9u6zs384ScXW69QIzZOmm69
         eL5omEAE6f/c8apG4t9mI3Q1YTPVBWVpde1PkA7OU4E9dyExXbAFqSSPYS3hbOC2zVvR
         qSK/RPEQxNNwaqBN7kQwJNlYBQKAjNoLa4uXasTU1SjihktcGLiifYJvmZLPenM3kxgQ
         /+Rw==
X-Gm-Message-State: AOAM5313eVZmF35zWefNd9GVkF6zG6SgiHmWBX87G8lbKZpDuCAoOGwi
        gdr1kIwfZvkAcFrQ7Wv7EUXVJ6/jqBNDug==
X-Google-Smtp-Source: ABdhPJwxd7qh3Wr5kZE5fDfD4i7OyDnZToMyoRn2SIE0uT67QcAfnTlq1vtiHRFp8L3AXJMijuUfoQ==
X-Received: by 2002:a6b:b554:: with SMTP id e81mr3760886iof.163.1623425535476;
        Fri, 11 Jun 2021 08:32:15 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id h7sm3443386ilr.44.2021.06.11.08.32.13
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 08:32:13 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id q3so8323708iop.11
        for <linux-pci@vger.kernel.org>; Fri, 11 Jun 2021 08:32:13 -0700 (PDT)
X-Received: by 2002:a05:6638:151:: with SMTP id y17mr4471864jao.128.1623425522838;
 Fri, 11 Jun 2021 08:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210527125845.1852284-1-tientzu@chromium.org>
 <20210604174818.GC3703@willie-the-truck> <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
In-Reply-To: <CALiNf29=z2uBM1ZA_GTu04iFS2dJwH0npdGvid1PL5KQM_HrxA@mail.gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Fri, 11 Jun 2021 23:31:52 +0800
X-Gmail-Original-Message-ID: <CALiNf29RGoFq7L+t_Bi6TsE-93-=m49DdV6QrVBV=pvoAjKsvw@mail.gmail.com>
Message-ID: <CALiNf29RGoFq7L+t_Bi6TsE-93-=m49DdV6QrVBV=pvoAjKsvw@mail.gmail.com>
Subject: Re: [PATCH v8 00/15] Restricted DMA
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

v9 here: https://lore.kernel.org/patchwork/cover/1445081/

On Mon, Jun 7, 2021 at 11:28 AM Claire Chang <tientzu@chromium.org> wrote:
>
> On Sat, Jun 5, 2021 at 1:48 AM Will Deacon <will@kernel.org> wrote:
> >
> > Hi Claire,
> >
> > On Thu, May 27, 2021 at 08:58:30PM +0800, Claire Chang wrote:
> > > This series implements mitigations for lack of DMA access control on
> > > systems without an IOMMU, which could result in the DMA accessing the
> > > system memory at unexpected times and/or unexpected addresses, possibly
> > > leading to data leakage or corruption.
> > >
> > > For example, we plan to use the PCI-e bus for Wi-Fi and that PCI-e bus is
> > > not behind an IOMMU. As PCI-e, by design, gives the device full access to
> > > system memory, a vulnerability in the Wi-Fi firmware could easily escalate
> > > to a full system exploit (remote wifi exploits: [1a], [1b] that shows a
> > > full chain of exploits; [2], [3]).
> > >
> > > To mitigate the security concerns, we introduce restricted DMA. Restricted
> > > DMA utilizes the existing swiotlb to bounce streaming DMA in and out of a
> > > specially allocated region and does memory allocation from the same region.
> > > The feature on its own provides a basic level of protection against the DMA
> > > overwriting buffer contents at unexpected times. However, to protect
> > > against general data leakage and system memory corruption, the system needs
> > > to provide a way to restrict the DMA to a predefined memory region (this is
> > > usually done at firmware level, e.g. MPU in ATF on some ARM platforms [4]).
> > >
> > > [1a] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_4.html
> > > [1b] https://googleprojectzero.blogspot.com/2017/04/over-air-exploiting-broadcoms-wi-fi_11.html
> > > [2] https://blade.tencent.com/en/advisories/qualpwn/
> > > [3] https://www.bleepingcomputer.com/news/security/vulnerabilities-found-in-highly-popular-firmware-for-wifi-chips/
> > > [4] https://github.com/ARM-software/arm-trusted-firmware/blob/master/plat/mediatek/mt8183/drivers/emi_mpu/emi_mpu.c#L132
> > >
> > > v8:
> > > - Fix reserved-memory.txt and add the reg property in example.
> > > - Fix sizeof for of_property_count_elems_of_size in
> > >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Apply Will's suggestion to try the OF node having DMA configuration in
> > >   drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Fix typo in the comment of drivers/of/address.c#of_dma_set_restricted_buffer.
> > > - Add error message for PageHighMem in
> > >   kernel/dma/swiotlb.c#rmem_swiotlb_device_init and move it to
> > >   rmem_swiotlb_setup.
> > > - Fix the message string in rmem_swiotlb_setup.
> >
> > Thanks for the v8. It works for me out of the box on arm64 under KVM, so:
> >
> > Tested-by: Will Deacon <will@kernel.org>
> >
> > Note that something seems to have gone wrong with the mail threading, so
> > the last 5 patches ended up as a separate thread for me. Probably worth
> > posting again with all the patches in one place, if you can.
>
> Thanks for testing.
>
> Christoph also added some comments in v7, so I'll prepare v9.
>
> >
> > Cheers,
> >
> > Will
