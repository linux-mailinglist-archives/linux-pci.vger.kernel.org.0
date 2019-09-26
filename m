Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2472ABF364
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2019 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfIZMxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 08:53:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfIZMxd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Sep 2019 08:53:33 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7399F222C2
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 12:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569502412;
        bh=SulBQ1ETOKJRPwyLxC3RBSbGJjkCp4pqGn6BT0nXAjo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PDofUudjW/n6OeXbMcjF6TsIekb/Wa/IqsdcCfmYFXgfpdAWO/tPCrSXIKnrvSKig
         0b8rSEF9YQva8LAuTggD2YR6J7QgTHn6z+N+451/C70wQSu2slJnI5XFzMIMOzD/+v
         oOkjqIAaYMc+gOkU6+xSAdnMGMsmjSEsVKyQZfWM=
Received: by mail-qk1-f172.google.com with SMTP id u22so1612517qkk.11
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2019 05:53:32 -0700 (PDT)
X-Gm-Message-State: APjAAAWZ7/ykdjvaCiNYjOHRaNb4HRW//XQME2Cz+jynSWm1d18Uo+ol
        sHautXjy2DMHNm+5Fdv19WUAumO5BOpLjC585w==
X-Google-Smtp-Source: APXvYqwUE9RcbGxD9bpLD6eBdsRB2calHjD+3fmuY9jJY0+d3IxPyQ41OWZzpJS8Jbs0h316UvLumDh038M4IuQJ60Y=
X-Received: by 2002:a37:682:: with SMTP id 124mr3035124qkg.393.1569502411592;
 Thu, 26 Sep 2019 05:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190924214630.12817-1-robh@kernel.org> <20190924214630.12817-12-robh@kernel.org>
 <20190926084718.GA9720@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190926084718.GA9720@e119886-lin.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Sep 2019 07:53:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5cbPd_7Yoo6DvK9LFwf-npChWxRPMq-TtqFSALbXuDw@mail.gmail.com>
Message-ID: <CAL_Jsq+5cbPd_7Yoo6DvK9LFwf-npChWxRPMq-TtqFSALbXuDw@mail.gmail.com>
Subject: Re: [PATCH 11/11] PCI: rcar: Use inbound resources for setup
To:     Andrew Murray <andrew.murray@arm.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Simon Horman <horms@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 26, 2019 at 3:47 AM Andrew Murray <andrew.murray@arm.com> wrote:
>
> On Tue, Sep 24, 2019 at 04:46:30PM -0500, Rob Herring wrote:
> > Now that the helpers provide the inbound resources in the host bridge
> > 'dma_ranges' resource list, convert Renesas R-Car PCIe host bridge to
> > use the resource list to setup the inbound addresses.
> >
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/pci/controller/pcie-rcar.c | 45 +++++++++++-------------------
> >  1 file changed, 16 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
> > index b8d6e86a5539..453c931aaf77 100644
> > --- a/drivers/pci/controller/pcie-rcar.c
> > +++ b/drivers/pci/controller/pcie-rcar.c
> > @@ -1014,16 +1014,16 @@ static int rcar_pcie_get_resources(struct rcar_pcie *pcie)
> >  }
> >
> >  static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
> > -                                 struct of_pci_range *range,
> > +                                 struct resource_entry *entry,
> >                                   int *index)
> >  {
> > -     u64 restype = range->flags;
> > -     u64 cpu_addr = range->cpu_addr;
> > -     u64 cpu_end = range->cpu_addr + range->size;
> > -     u64 pci_addr = range->pci_addr;
> > +     u64 restype = entry->res->flags;
> > +     u64 cpu_addr = entry->res->start;
> > +     u64 cpu_end = entry->res->end;
> > +     u64 pci_addr = entry->res->start - entry->offset;
> >       u32 flags = LAM_64BIT | LAR_ENABLE;
> >       u64 mask;
> > -     u64 size;
> > +     u64 size = resource_size(entry->res);
> >       int idx = *index;
> >
> >       if (restype & IORESOURCE_PREFETCH)
> > @@ -1037,9 +1037,7 @@ static int rcar_pcie_inbound_ranges(struct rcar_pcie *pcie,
> >               unsigned long nr_zeros = __ffs64(cpu_addr);
> >               u64 alignment = 1ULL << nr_zeros;
> >
> > -             size = min(range->size, alignment);
> > -     } else {
> > -             size = range->size;
> > +             size = min(size, alignment);
> >       }
>
> AFAICT the (if cpu_addr > 0) is here because the result of __ffs64 is undefined
> if no bits are set (according to the comment). However by removing the else
> statement we no longer guarantee that nr_zeros is defined.

You might want to read this again...

The 'if (cpu_addr > 0) {' is still there and nr_zeros is only under
that condition. We just init 'size' instead of setting it in the else
clause.

Rob
