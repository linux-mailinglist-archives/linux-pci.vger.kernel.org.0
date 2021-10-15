Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E1F42F81C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 18:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241292AbhJOQbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 12:31:41 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3986 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbhJOQbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 12:31:40 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWBTb6rkGz67lSs;
        Sat, 16 Oct 2021 00:25:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:29:31 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 17:29:31 +0100
Date:   Fri, 15 Oct 2021 17:29:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 06/10] cxl/pci: Add @base to cxl_register_map
Message-ID: <20211015172930.00007f21@Huawei.com>
In-Reply-To: <CAPcyv4hP5ohs10-xC+h=QOH7yiUXji55ubwVG1XfMA006tjR8A@mail.gmail.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
        <20211010042056.GJ3114988@iweiny-DESK2.sc.intel.com>
        <CAPcyv4hP5ohs10-xC+h=QOH7yiUXji55ubwVG1XfMA006tjR8A@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 13 Oct 2021 15:53:20 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sat, Oct 9, 2021 at 9:21 PM Ira Weiny <ira.weiny@intel.com> wrote:
> >
> > On Sat, Oct 09, 2021 at 09:44:29AM -0700, Dan Williams wrote:  
> > > In addition to carrying @barno, @block_offset, and @reg_type, add @base
> > > to keep all map/unmap parameters in one object. The helpers
> > > cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
> > > at map and unmap time.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  drivers/cxl/cxl.h |    1 +
> > >  drivers/cxl/pci.c |   31 ++++++++++++++++---------------
> > >  2 files changed, 17 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index a6687e7fd598..7cd16ef144dd 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -140,6 +140,7 @@ struct cxl_device_reg_map {
> > >  };
> > >
> > >  struct cxl_register_map {
> > > +     void __iomem *base;
> > >       u64 block_offset;
> > >       u8 reg_type;
> > >       u8 barno;
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 9f006299a0e3..b42407d067ac 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -306,8 +306,7 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
> > >       return 0;
> > >  }
> > >
> > > -static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
> > > -                                       struct cxl_register_map *map)
> > > +static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
> > >  {
> > >       void __iomem *addr;
> > >       int bar = map->barno;
> > > @@ -318,24 +317,27 @@ static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
> > >       if (pci_resource_len(pdev, bar) < offset) {
> > >               dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > >                       &pdev->resource[bar], (unsigned long long)offset);
> > > -             return NULL;
> > > +             return -ENXIO;
> > >       }
> > >
> > >       addr = pci_iomap(pdev, bar, 0);
> > >       if (!addr) {
> > >               dev_err(dev, "failed to map registers\n");
> > > -             return addr;
> > > +             return -ENOMEM;
> > >       }
> > >
> > >       dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
> > >               bar, offset);
> > >
> > > -     return addr;
> > > +     map->base = addr + map->block_offset;
> > > +     return 0;
> > >  }
> > >
> > > -static void cxl_pci_unmap_regblock(struct pci_dev *pdev, void __iomem *base)
> > > +static void cxl_unmap_regblock(struct pci_dev *pdev,
> > > +                            struct cxl_register_map *map)
> > >  {
> > > -     pci_iounmap(pdev, base);
> > > +     pci_iounmap(pdev, map->base - map->block_offset);  
> >
> > I know we need to get these in soon.  But I think map->base should be 'base'
> > and map->block_offset should be handled in cxl_probe_regs() rather than
> > subtract it here..  
> 
> But why? The goal of the cxl_register_map cleanups is to reduce the
> open-coding for details that can just be passed around in a @map
> instance. Once cxl_map_regblock() sets up @base there's little reason
> to consider the hardware regblock details.

I agree with Ira to the extent that this was a little confusing.   Perhaps it is worth
a comment at the structure definition to make the relationship of block_offset
and base clear?

Jonathan

> 
> > Either way this is cleaner than what it was.
> >
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>  
> 
> Thanks!

