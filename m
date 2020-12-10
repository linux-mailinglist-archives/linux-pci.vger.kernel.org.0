Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF522D5283
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 05:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgLJEEv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 23:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbgLJEEo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 23:04:44 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8B7C061793
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 20:04:03 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id bo9so5344932ejb.13
        for <linux-pci@vger.kernel.org>; Wed, 09 Dec 2020 20:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
        b=V12HS7Wn+bctaIkufygbNwtKV1pkBbE9hHZV8Lf9tSE5VPt6nBit0Nb1HWPIB+8XdO
         UwbjHDBYoCvlSOrafC5rCuQbCx1D+/3PDyFehNe398RSQzHQ1rPu9pgXYXyg3wMVKY7l
         FuBEUYEFzcobG0z1knWel86vWiyTyuA3aX6iyNBGyPUSEugrsJ77EmD5w3Zhr4gllpgD
         NDD0P3wO1Rjasg3bPJKXdNNtxJFUZzyODiRBozAcezwWwmKvGT1tnVg88ssqoLYPKQyE
         vxZa8+AdNxohhjfYmcfYxPAKri7o/zxhpGNApPEe/Ugj0ylq5uh8h/HdVnA0K5L3ljWV
         0UiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aiXzNIBEdezK7LvwdToUmyEveX4RTWL1Q1rKEHzG6GY=;
        b=hrUmItHIZCMHbkuEBCt+1BC/S7RTGeGYSoqBo2laTaL7QLo1cgCUxt3kwXk6Kt96KM
         YX1z7Hbmb2x55Hx//XdDQamrXxvmid9G+jt3F8+AdjisNc6Q8tBmgGOSO2weUhwAKuV3
         YDPNC7xX4K1Y54gj9VCi/GBNQP9227YYRmHn9KvQm1Ml+NRmQ5jzRXnEks+Vakt77/94
         lmgtBhE5HFaxMRQbJFgzTnsC4VRKTLiXzAIBQmLismvapD2M8L4SqHyP3W4MQK1v6gPz
         FeDAYrYYNJyNS9/Is4p5f9+g4ZGJEyENMnbzwCnAI8lnl6eiqvQWLiwO/PNLvQZeIGYm
         kkxg==
X-Gm-Message-State: AOAM531ybr8AcMD9loXrJITjtFIXH74RdsK4lhW0A4dmhufh7XnE63Hd
        optPZYQhuL1j4lsKSvZNzetK9+6WNyKfTBVY5cEsXw==
X-Google-Smtp-Source: ABdhPJz4kqsM2zajOVSAKgswV7LD/u9Of8EB4mcOSELuzl9N3rbE8Zn+Vb136NhMCEF83xMViBOj9nm8pJkMBp6g77Y=
X-Received: by 2002:a17:906:518a:: with SMTP id y10mr4811157ejk.323.1607573042542;
 Wed, 09 Dec 2020 20:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20201106170036.18713-1-logang@deltatee.com> <20201106170036.18713-5-logang@deltatee.com>
 <20201109091258.GB28918@lst.de> <4e336c7e-207b-31fa-806e-c4e8028524a5@deltatee.com>
 <CAPcyv4ifGcrdOtUt8qr7pmFhmecGHqGVre9G0RorGczCGVECQQ@mail.gmail.com> <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
In-Reply-To: <fba1022b-1425-bb79-9af8-fe68e6f2c56e@deltatee.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Dec 2020 20:04:00 -0800
Message-ID: <CAPcyv4hr=kM6--OUdK+6XAAEVzENJmy-uD78yK-p62bW8vbu9g@mail.gmail.com>
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating P2PDMA
 segments in an SGL
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux-foundation.org>,
        Stephen Bates <sbates@raithlin.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 9, 2020 at 6:07 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-12-09 6:22 p.m., Dan Williams wrote:
> > On Mon, Nov 9, 2020 at 8:47 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2020-11-09 2:12 a.m., Christoph Hellwig wrote:
> >>> On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> >>>> We make use of the top bit of the dma_length to indicate a P2PDMA
> >>>> segment.
> >>>
> >>> I don't think "we" can.  There is nothing limiting the size of a SGL
> >>> segment.
> >>
> >> Yes, I expected this would be the unacceptable part. Any alternative ideas?
> >
> > Why is the SG_P2PDMA_FLAG needed as compared to checking the SGL
> > segment-pages for is_pci_p2pdma_page()?
>
> Because the DMA and page segments in the SGL aren't necessarily aligned...
>
> The IOMMU implementations can coalesce multiple pages into fewer DMA
> address ranges, so the page pointed to by sg->page_link may not be the
> one that corresponds to the address in sg->dma_address for a given segment.
>
> If that makes sense -- it's not the easiest thing to explain.

It does...

Did someone already grab, or did you already consider the 3rd
available bit in page_link? AFAICS only SG_CHAIN and SG_END are
reserved. However, if you have a CONFIG_64BIT dependency for
user-directed p2pdma that would seem to allow SG_P2PDMA_FLAG to be
(0x4) in page_link.
