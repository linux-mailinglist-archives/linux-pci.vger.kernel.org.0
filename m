Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDDA392E6F
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 14:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbhE0M5s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235986AbhE0M5l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 08:57:41 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9F6C061763
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 05:56:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y202so512020pfc.6
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t9nQbEpq5kzp2vshpX/2KDY0MEdzNS47SlLJX4RAhzA=;
        b=XnDncQEfy0WK93TP5b5iaOvQy6p3tli5hK7U2lnqkRYfpimdp+9WScU0B/bVffV6lu
         KHvuv/cILlR7hwxjPwG4fSm8TLb0M0uiiQtfQGCy1lJiDeCNSlZdr9ro+4UoS7qK25VN
         Vwx6crrIG7NXb3xhmTS0AaKdDSprMjL64yAgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t9nQbEpq5kzp2vshpX/2KDY0MEdzNS47SlLJX4RAhzA=;
        b=Y6yIdQKUeByVC0YMjZEAihzApySJ4mF/gqjJZF2NufVYtXnaP69kWcxPEb61CQxAJP
         aMiPJbWliFmeO8KB9bARt6Mn+g+g9kh9aCv6wKW9TGEDonmYC9x++LFrja4CbsLbeIqh
         PIS+X3p0lykWa9etMTpWf6dSCjc4zSg7CiXKjQGrKPCaC4BmVYJfo6V8lXClaRc7vNp0
         MvrGkBRWdykrprm2CZAWG8J+S3aHQUqmQxF+XB8OW3VESDjM2CCiigjTMYjWpXIGKFjR
         TXy76ey9D6b360S2qWzjuJ34I+s8wj1LNeOrL5kjNMiTzJUn0V1MZpC9gf+htjGEZHjy
         aYFQ==
X-Gm-Message-State: AOAM5337TPbOA8bpF6zBUWhBFXTPBmp1UAxGhv5Aga2B8DJn0iCwvUME
        AcY1lx82HpeY/hsb7dAiZlyih1/nM9aXbQ==
X-Google-Smtp-Source: ABdhPJwyhy8n1WGWvhoNqX3us1FMqir0idbssbwMh3j6mCmHBdwYDyc8aXj4CtYm9XmMLQ/zmZAc2A==
X-Received: by 2002:a63:b545:: with SMTP id u5mr3572613pgo.261.1622120167355;
        Thu, 27 May 2021 05:56:07 -0700 (PDT)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com. [209.85.210.179])
        by smtp.gmail.com with ESMTPSA id q35sm1216580pja.56.2021.05.27.05.56.06
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 05:56:07 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id d78so496848pfd.10
        for <linux-pci@vger.kernel.org>; Thu, 27 May 2021 05:56:06 -0700 (PDT)
X-Received: by 2002:a92:2907:: with SMTP id l7mr2908573ilg.64.1622119750871;
 Thu, 27 May 2021 05:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-15-tientzu@chromium.org> <20210526121322.GA19313@willie-the-truck>
 <20210526155321.GA19633@willie-the-truck> <CALiNf2_sVXnb97++yWusB5PWz8Pzfn9bCKZc6z3tY4bx6-nW8w@mail.gmail.com>
 <20210527113456.GA22019@willie-the-truck>
In-Reply-To: <20210527113456.GA22019@willie-the-truck>
From:   Claire Chang <tientzu@chromium.org>
Date:   Thu, 27 May 2021 20:48:59 +0800
X-Gmail-Original-Message-ID: <CALiNf2_Qk5DmZSJO+jv=m5V-VFtmL9j0v66UY6qKmM-2pr3tRQ@mail.gmail.com>
Message-ID: <CALiNf2_Qk5DmZSJO+jv=m5V-VFtmL9j0v66UY6qKmM-2pr3tRQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/15] dt-bindings: of: Add restricted DMA pool
To:     Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 27, 2021 at 7:35 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, May 27, 2021 at 07:29:20PM +0800, Claire Chang wrote:
> > On Wed, May 26, 2021 at 11:53 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Wed, May 26, 2021 at 01:13:22PM +0100, Will Deacon wrote:
> > > > On Tue, May 18, 2021 at 02:42:14PM +0800, Claire Chang wrote:
> > > > > @@ -138,4 +160,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
> > > > >             memory-region = <&multimedia_reserved>;
> > > > >             /* ... */
> > > > >     };
> > > > > +
> > > > > +   pcie_device: pcie_device@0,0 {
> > > > > +           memory-region = <&restricted_dma_mem_reserved>;
> > > > > +           /* ... */
> > > > > +   };
> > > >
> > > > I still don't understand how this works for individual PCIe devices -- how
> > > > is dev->of_node set to point at the node you have above?
> > > >
> > > > I tried adding the memory-region to the host controller instead, and then
> > > > I see it crop up in dmesg:
> > > >
> > > >   | pci-host-generic 40000000.pci: assigned reserved memory node restricted_dma_mem_reserved
> > > >
> > > > but none of the actual PCI devices end up with 'dma_io_tlb_mem' set, and
> > > > so the restricted DMA area is not used. In fact, swiotlb isn't used at all.
> > > >
> > > > What am I missing to make this work with PCIe devices?
> > >
> > > Aha, looks like we're just missing the logic to inherit the DMA
> > > configuration. The diff below gets things working for me.
> >
> > I guess what was missing is the reg property in the pcie_device node.
> > Will update the example dts.
>
> Thanks. I still think something like my diff makes sense, if you wouldn't mind including
> it, as it allows restricted DMA to be used for situations where the PCIe
> topology is not static.
>
> Perhaps we should prefer dev->of_node if it exists, but then use the node
> of the host bridge's parent node otherwise?

Sure. Let me add in the next version.

>
> Will
