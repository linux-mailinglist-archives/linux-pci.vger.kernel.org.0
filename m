Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5039837AC2C
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbhEKQns (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhEKQnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:43:47 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BD3C061574
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 09:42:39 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id i13so16614211pfu.2
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I574vs+oxpmw2RaQkdeqT3TmVa8C0vE6HCQzgLmVaEk=;
        b=EO4zcKQD13cnMpJi5k5sqZg36m/uhjFrv+x7tUEK/JnHkDgZTOULzljGCah93D1FN5
         SwmaT+lt9As201TL9V65C0BiJShCnGyDe8UgjgY5Jm1YBpkuQxrN8+e9OJjS8RpeP4ih
         4tasAkIoShr42ndvrMVih2QtviIwqYbb0WQHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I574vs+oxpmw2RaQkdeqT3TmVa8C0vE6HCQzgLmVaEk=;
        b=Ye52Avo9utvIA1F7qWgIZ933JAhWhLmqu/+FcFesVfYIHO4rnudDD9tzWuWCPTCQGV
         zR+vWWZO/8L3W2Elo6DI/yxrTRtHUimr784HCehWiU5n2jWvSKOi7+hBAQSfTmdWDfCw
         bNxPo2Uo4yBBxb11lqmx7FAuSagAl6p5k3kzPJpiFySYWAUSbz9qtRM4fknF6U1o07h8
         ynl76EFI7tJnCd0pCpoMyj30v0mwt5J6/oV4NFz2QLowzjSofrrxh8Ulo/1mYxjNmJGQ
         kyVbTZ2u7nxsZeNXj4QgDOFblP63x157uwQ6P9Fkm+kjNoVbPgAIGZPoQiRZxpmTdxDA
         ldug==
X-Gm-Message-State: AOAM531d7m1rt8sD84QbnjzD/OJ2dT0FAd54L78ipNTVzUjHgZukbgM7
        f1oSdcyvq355rRDRWou3L5zymNgIFmnBEQ==
X-Google-Smtp-Source: ABdhPJzjbaAuXVrcpQrn7QAcGHuyYVacA+EOSpWmOCcPXeyz04NIhk7fUM4I1A0XnBS8SqnsTrVaMw==
X-Received: by 2002:a63:1064:: with SMTP id 36mr32037704pgq.164.1620751358997;
        Tue, 11 May 2021 09:42:38 -0700 (PDT)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com. [209.85.210.179])
        by smtp.gmail.com with ESMTPSA id g6sm14211878pfr.213.2021.05.11.09.42.37
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 09:42:38 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id 10so16627675pfl.1
        for <linux-pci@vger.kernel.org>; Tue, 11 May 2021 09:42:37 -0700 (PDT)
X-Received: by 2002:a92:6804:: with SMTP id d4mr27241366ilc.5.1620751346868;
 Tue, 11 May 2021 09:42:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210510095026.3477496-1-tientzu@chromium.org>
 <20210510095026.3477496-9-tientzu@chromium.org> <20210510150516.GE28066@lst.de>
In-Reply-To: <20210510150516.GE28066@lst.de>
From:   Claire Chang <tientzu@chromium.org>
Date:   Wed, 12 May 2021 00:42:15 +0800
X-Gmail-Original-Message-ID: <CALiNf2-x8Gw0TPLdeRnfPmUTeuK9dsLbDXN4hPnc08y21uuUXQ@mail.gmail.com>
Message-ID: <CALiNf2-x8Gw0TPLdeRnfPmUTeuK9dsLbDXN4hPnc08y21uuUXQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/15] swiotlb: Bounce data from/to restricted DMA pool
 if available
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
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
        nouveau@lists.freedesktop.org, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 10, 2021 at 11:05 PM Christoph Hellwig <hch@lst.de> wrote:
>
> > +static inline bool is_dev_swiotlb_force(struct device *dev)
> > +{
> > +#ifdef CONFIG_DMA_RESTRICTED_POOL
> > +     if (dev->dma_io_tlb_mem)
> > +             return true;
> > +#endif /* CONFIG_DMA_RESTRICTED_POOL */
> > +     return false;
> > +}
> > +
>
> >       /* If SWIOTLB is active, use its maximum mapping size */
> >       if (is_swiotlb_active(dev) &&
> > -         (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE))
> > +         (dma_addressing_limited(dev) || swiotlb_force == SWIOTLB_FORCE ||
> > +          is_dev_swiotlb_force(dev)))
>
> This is a mess.  I think the right way is to have an always_bounce flag
> in the io_tlb_mem structure instead.  Then the global swiotlb_force can
> go away and be replace with this and the fact that having no
> io_tlb_mem structure at all means forced no buffering (after a little
> refactoring).

Will do in the next version.
