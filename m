Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A01542CEE1
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 00:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhJMWzg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 18:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJMWzf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 18:55:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A34DC061746
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 15:53:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x130so3788066pfd.6
        for <linux-pci@vger.kernel.org>; Wed, 13 Oct 2021 15:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mD52ke93bZgMN8C2a9gCtqv/RSz+k+TH8msNFSfXTEI=;
        b=111IYqB5RWpR47n+J9LBNzUiwKITM04Su9x8IakTob8UD0Fpo6EPKusY5AgXimwuXb
         377AkSssdJvml0TXvPV9uVNumAo5IC2LMqp7eZ1Xeav/DRvwkTDvkyyTFv+h1tEMp9CC
         De5w7Hi6Y/tPn8BLywbkiorQH3J85/Kq6POg32i6PB4ok63I4v/qWQw1LfGjTeB9ogvY
         PB/HqYOIkMHNUwg5m8gb/6YVP/9LI7I2MdiilPE2t17kf4EuQngM7hSWYHbpa0hBiLJs
         U1rJE4STnZmdmNaj8Wwj6D9PXEQU3peVnr+P/0qnhlMNVYhux01Zo507yBcOgU8hDQb1
         FiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mD52ke93bZgMN8C2a9gCtqv/RSz+k+TH8msNFSfXTEI=;
        b=SElIKKDLrT8cA/5/xszUymbJrzHTOcWE0bMzl27w9QGAlrG5R1cyYk9LFCCpcTyU0K
         bpqDZ9H9Y/ilUCB+wWDzDeutgewtyD9V4emn9UqfX3UewGI8YR4b5NhLYhFjT4nM8tK3
         3lLCYaByfvY4Ajw7WE1AxnBaQnyzC95LyQGi5KtxVgOKMgKmluo+OKwZZiN9qq1PoFM9
         m3qz3t56JIaC20eWUEFCtDxq11W4PVExS5LfljokBtVmv5gWy2z7VA2Vg3AlRI0IMjYf
         W075AwMYIak18amBbLNZhHvq3kz1pani9pjwnZKc1G8K/x6VGO3HeUD3JOqNUQ+7bXrm
         1r1Q==
X-Gm-Message-State: AOAM530eXD+awAgdRdsbz8xu3x3PLKCTpiGWfHaZ9MNX4ETSrl6c5Yxt
        LNE107f9e6z5vA9iDRYajwoBKKjCJUeemZihjRHMMg==
X-Google-Smtp-Source: ABdhPJzUs+C9Y/nPSblGHzVkRKNZwUBEduOOiELpNCPsaOpR5gHLldCoGaAsU4ZIsdGNciujcHSWWgt+DEurN/y2eTo=
X-Received: by 2002:a05:6a00:140e:b0:444:b077:51ef with SMTP id
 l14-20020a056a00140e00b00444b07751efmr1680391pfu.61.1634165611611; Wed, 13
 Oct 2021 15:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211010042056.GJ3114988@iweiny-DESK2.sc.intel.com>
In-Reply-To: <20211010042056.GJ3114988@iweiny-DESK2.sc.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Oct 2021 15:53:20 -0700
Message-ID: <CAPcyv4hP5ohs10-xC+h=QOH7yiUXji55ubwVG1XfMA006tjR8A@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] cxl/pci: Add @base to cxl_register_map
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 9, 2021 at 9:21 PM Ira Weiny <ira.weiny@intel.com> wrote:
>
> On Sat, Oct 09, 2021 at 09:44:29AM -0700, Dan Williams wrote:
> > In addition to carrying @barno, @block_offset, and @reg_type, add @base
> > to keep all map/unmap parameters in one object. The helpers
> > cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
> > at map and unmap time.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/cxl.h |    1 +
> >  drivers/cxl/pci.c |   31 ++++++++++++++++---------------
> >  2 files changed, 17 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index a6687e7fd598..7cd16ef144dd 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -140,6 +140,7 @@ struct cxl_device_reg_map {
> >  };
> >
> >  struct cxl_register_map {
> > +     void __iomem *base;
> >       u64 block_offset;
> >       u8 reg_type;
> >       u8 barno;
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 9f006299a0e3..b42407d067ac 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -306,8 +306,7 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
> >       return 0;
> >  }
> >
> > -static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
> > -                                       struct cxl_register_map *map)
> > +static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
> >  {
> >       void __iomem *addr;
> >       int bar = map->barno;
> > @@ -318,24 +317,27 @@ static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
> >       if (pci_resource_len(pdev, bar) < offset) {
> >               dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> >                       &pdev->resource[bar], (unsigned long long)offset);
> > -             return NULL;
> > +             return -ENXIO;
> >       }
> >
> >       addr = pci_iomap(pdev, bar, 0);
> >       if (!addr) {
> >               dev_err(dev, "failed to map registers\n");
> > -             return addr;
> > +             return -ENOMEM;
> >       }
> >
> >       dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
> >               bar, offset);
> >
> > -     return addr;
> > +     map->base = addr + map->block_offset;
> > +     return 0;
> >  }
> >
> > -static void cxl_pci_unmap_regblock(struct pci_dev *pdev, void __iomem *base)
> > +static void cxl_unmap_regblock(struct pci_dev *pdev,
> > +                            struct cxl_register_map *map)
> >  {
> > -     pci_iounmap(pdev, base);
> > +     pci_iounmap(pdev, map->base - map->block_offset);
>
> I know we need to get these in soon.  But I think map->base should be 'base'
> and map->block_offset should be handled in cxl_probe_regs() rather than
> subtract it here..

But why? The goal of the cxl_register_map cleanups is to reduce the
open-coding for details that can just be passed around in a @map
instance. Once cxl_map_regblock() sets up @base there's little reason
to consider the hardware regblock details.

> Either way this is cleaner than what it was.
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thanks!
