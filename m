Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA552572A8
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 22:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZUjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 16:39:15 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40634 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfFZUjO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 16:39:14 -0400
Received: by mail-oi1-f193.google.com with SMTP id w196so154504oie.7
        for <linux-pci@vger.kernel.org>; Wed, 26 Jun 2019 13:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYeWRlp6n/vQnTa+fYFmAoEUxn0NMI33stOLW194NWI=;
        b=kVT6f/J18N4jOGjKVrrG9wNomn8jDVg05k4WFQXf36XrjtMQpEmVpWPIuNysiAbKsx
         n+Z718Sxszq/I1fyvWJXsD01Zp8W0/LbsKFY24ybfeyRgsqfCUshdCH7ZoW7/ONLXJdN
         lD9TT3SmGvQUVxDWCD1qHC1hTkzE10LJ57KQWSYjPlWxqr+J4LzT7uhc9aNdJ7JwhKKB
         kTLAPG10/ZPxQsIMrTIvi7pepmWglKVqEy7PBkHxAU5DIyV7aNyjbNLUdQltXRmZLL9f
         8H0FR7ztfQUo0clbwtw2o44u24imsaxpG3L9ecnsJ6w6WyNKf8/pW5Eab6KslfuserKb
         EmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VYeWRlp6n/vQnTa+fYFmAoEUxn0NMI33stOLW194NWI=;
        b=fFmG07pC40726yoEDi4JS/dTsJ0EDMRZkBmxz9nPdiKWAmL2qJrP+Jsoc+3bOqOKpJ
         rPslenjY5nHCG9xGIGgdG3BNbDKHqjUq+BOTc/Tgef6o+nnSOEVxuncGCMRl3zzvwXrb
         TnJ9dF2xjjvaprEBusl3NzkHZRxQEJFaFLrlkLMBg5kDZzMysn3XHYXW2u5HbhJgW/EV
         4JvoFBZZ97+Qdrkm6iX/BDLVKPJRiuFziimKvpGRu3SbjRmXQDjRdIf9bB6ucGgMp4Lj
         fOyj4u/oYeDXX3Gstm7UV/3Btwdex6EUCWQeSORdWyK7POrIf3lNozrInB3ehRBVaj/w
         mmBg==
X-Gm-Message-State: APjAAAXp3/EkquqVFvqfai3mBiJzqDPjv5PTQNAwHTuUbcLayMVoQiAZ
        L2EXMJMZywCf2306lmS5SBU8TwHbFQNj1nCbAREyLg==
X-Google-Smtp-Source: APXvYqzOW0zZUogI9bpo993SYdjNzW7+XY8OQvRzfJZPA3+Cc3WWKwMsRZL6wtJbO/WerGOW6fDqo9Ufat9fvVAWYZw=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr179462oig.105.1561581553855;
 Wed, 26 Jun 2019 13:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190620161240.22738-1-logang@deltatee.com> <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com> <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com> <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com> <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com> <20190626202107.GA5850@ziepe.ca>
In-Reply-To: <20190626202107.GA5850@ziepe.ca>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 26 Jun 2019 13:39:01 -0700
Message-ID: <CAPcyv4hCNoMeFyOE588=kuNUXaPS-rzaXnF2cN2TFejso1SGRw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 26, 2019 at 1:21 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 26, 2019 at 12:31:08PM -0600, Logan Gunthorpe wrote:
> > > we have a hole behind len where we could store flag.  Preferably
> > > optionally based on a P2P or other magic memory types config
> > > option so that 32-bit systems with 32-bit phys_addr_t actually
> > > benefit from the smaller and better packing structure.
> >
> > That seems sensible. The one thing that's unclear though is how to get
> > the PCI Bus address when appropriate. Can we pass that in instead of the
> > phys_addr with an appropriate flag? Or will we need to pass the actual
> > physical address and then, at the map step, the driver has to some how
> > lookup the PCI device to figure out the bus offset?
>
> I agree with CH, if we go down this path it is a layering violation
> for the thing injecting bio's into the block stack to know what struct
> device they egress&dma map on just to be able to do the dma_map up
> front.
>
> So we must be able to go from this new phys_addr_t&flags to some BAR
> information during dma_map.
>
> For instance we could use a small hash table of the upper phys addr
> bits, or an interval tree, to do the lookup.

Hmm, that sounds like dev_pagemap without the pages.

There's already no requirement that dev_pagemap point to real /
present pages (DEVICE_PRIVATE) seems a straightforward extension to
use it for helping coordinate phys_addr_t in 'struct bio'. Then
Logan's future plans to let userspace coordinate p2p operations could
build on PTE_DEVMAP.
