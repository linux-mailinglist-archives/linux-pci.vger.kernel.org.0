Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DF32F3DB8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438031AbhALVhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 16:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437002AbhALUl0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 15:41:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C63C061575
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 12:40:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id q22so5430014eja.2
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 12:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ct93Q3jRetKhaczI+6WcmnjHIFRP3Fo82VEGV+KynCk=;
        b=T1cZ3JpkSXggl/Jkc5Ldu1myuVwPhCGRR6lqhbhAHv3xS6v+mjC6VwXUiCcBHC25JI
         sb9pXAcR2De4/gHbvIQK58ATkuAIMTf8m0ZgZE26P2jThxM+b/ywIX6Gu2z+FyH0wWqI
         8DFVg8H/XJthxJXuQvnTjakrBLaohUIK39TJ9dp1Wu2Tev0vDanE1M6tvq6gbTsrMYZi
         fRb5OXVvMxBBACwBd5AVcfcv78E2i85gV9iyy6Vtoj0CfpbmHYeTroe17RJ5ajvbGH6H
         k6CV8KJlnlEiKHnr/nVg+5HGrZtBNr0EowWx6PE5j9SDR6LkSOrpI1J1zsWPXsZ8PQed
         7L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ct93Q3jRetKhaczI+6WcmnjHIFRP3Fo82VEGV+KynCk=;
        b=i9vCipGjmcJ/HX0f1lCROuYvPrhCZWiEuUqXw9j46uo5LALXigafGIytSzt9T+QK80
         yDr+gzkhosU+DpggleodHBAG2p8RtOk1nq2b1N+P7IDrEnyo8nkk3fnpbGLjBYac4yr5
         tFMWzxSdyHayqlaow9J6lLEJtfbvM7ndg9nZowYPXRCByujGIpwWT9RuTT+gaZiD6xAX
         nkFnLYaAJk3BSx3QHfBPKWWKbYVum8J0xMydb7nT5ZLHKVp/UwV9zd+DF+fiTFmxG+vT
         T8xSjLbwXg7/WN7GPsISRlsT42QROMB/N30/F7TP1qAmNOo+J91NxBloWHjBfCMoxe4N
         egRw==
X-Gm-Message-State: AOAM531ihzKmTUbdcJ3gc5G1lHlKl5hfUwmEE+0qo6XoQPnc7G7NP8pg
        NSOKVnsRm0Xe8yCJVGhQ7YAo9JlEVsui5FkU6s1o6g==
X-Google-Smtp-Source: ABdhPJzHdcTzIjQRpyGIEfN0AC0DGdj1ibAM+dEAeusNPr+hYVUdYuvlpZNheWMWFHBf12PCInMSBiFgFRDLAzCahKY=
X-Received: by 2002:a17:907:d8e:: with SMTP id go14mr439401ejc.472.1610484044797;
 Tue, 12 Jan 2021 12:40:44 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-6-ben.widawsky@intel.com> <20210112191342.00006aad@Huawei.com>
 <20210112192115.vhxjz3cr5vwjshwf@intel.com>
In-Reply-To: <20210112192115.vhxjz3cr5vwjshwf@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 12:40:35 -0800
Message-ID: <CAPcyv4iDoFdBn7UkvRpAunLY=TM7vWnH77P3nGKStBfJ9YdwKA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 05/16] cxl/mem: Map memory device registers
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 11:21 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-01-12 19:13:42, Jonathan Cameron wrote:
> > On Mon, 11 Jan 2021 14:51:09 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > All the necessary bits are initialized in order to find and map the
> > > register space for CXL Memory Devices. This is accomplished by using the
> > > Register Locator DVSEC (CXL 2.0 - 8.1.9.1) to determine which PCI BAR to
> > > use, and how much of an offset from that BAR should be added.
> > >
> > > If the memory device registers are found and mapped a new internal data
> > > structure tracking device state is allocated.
> > >
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > Some issues with managed allocations being manually freed in remove.
> > It shouldn't be necessary to do that.
> >
> > > ---
> > >  drivers/cxl/cxl.h |  17 ++++++++
> > >  drivers/cxl/mem.c | 100 +++++++++++++++++++++++++++++++++++++++++++++-
> > >  drivers/cxl/pci.h |  14 +++++++
> > >  3 files changed, 130 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/cxl/cxl.h
> > >
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > new file mode 100644
> > > index 000000000000..d81d0ba4617c
> > > --- /dev/null
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -0,0 +1,17 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/* Copyright(c) 2020 Intel Corporation. */
> > > +
> > > +#ifndef __CXL_H__
> > > +#define __CXL_H__
> > > +
> > > +/**
> > > + * struct cxl_mem - A CXL memory device
> > > + * @pdev: The PCI device associated with this CXL device.
> > > + * @regs: IO mappings to the device's MMIO
> > > + */
> > > +struct cxl_mem {
> > > +   struct pci_dev *pdev;
> > > +   void __iomem *regs;
> > > +};
> > > +
> > > +#endif
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > index 005404888942..8301db34d2ff 100644
> > > --- a/drivers/cxl/mem.c
> > > +++ b/drivers/cxl/mem.c
> > > @@ -5,6 +5,58 @@
> > >  #include <linux/io.h>
> > >  #include "acpi.h"
> > >  #include "pci.h"
> > > +#include "cxl.h"
> > > +
> > > +/**
> > > + * cxl_mem_create() - Create a new &struct cxl_mem.
> > > + * @pdev: The pci device associated with the new &struct cxl_mem.
> > > + * @reg_lo: Lower 32b of the register locator
> > > + * @reg_hi: Upper 32b of the register locator.
> > > + *
> > > + * Return: The new &struct cxl_mem on success, NULL on failure.
> > > + *
> > > + * Map the BAR for a CXL memory device. This BAR has the memory device's
> > > + * registers for the device as specified in CXL specification.
> > > + */
> > > +static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
> > > +                                 u32 reg_hi)
> > > +{
> > > +   struct device *dev = &pdev->dev;
> > > +   struct cxl_mem *cxlm;
> > > +   void __iomem *regs;
> > > +   u64 offset;
> > > +   u8 bar;
> > > +   int rc;
> > > +
> > > +   offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> > > +   bar = (reg_lo >> CXL_REGLOC_BIR_SHIFT) & CXL_REGLOC_BIR_MASK;
> > > +
> > > +   /* Basic sanity check that BAR is big enough */
> > > +   if (pci_resource_len(pdev, bar) < offset) {
> > > +           dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> > > +                   &pdev->resource[bar], (unsigned long long)offset);
> > > +           return NULL;
> > > +   }
> > > +
> > > +   rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
> > > +   if (rc != 0) {
> > > +           dev_err(dev, "failed to map registers\n");
> > > +           return NULL;
> > > +   }
> > > +
> > > +   cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> > > +   if (!cxlm) {
> > > +           dev_err(dev, "No memory available\n");
> > > +           return NULL;
> > > +   }
> > > +
> > > +   regs = pcim_iomap_table(pdev)[bar];
> > > +   cxlm->pdev = pdev;
> > > +   cxlm->regs = regs + offset;
> > > +
> > > +   dev_dbg(dev, "Mapped CXL Memory Device resource\n");
> > > +   return cxlm;
> > > +}
> > >
> > >  static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > >  {
> > > @@ -33,7 +85,8 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > >  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >  {
> > >     struct device *dev = &pdev->dev;
> > > -   int rc, regloc;
> > > +   struct cxl_mem *cxlm;
> > > +   int rc, regloc, i;
> > >
> > >     rc = cxl_bus_acquire(pdev);
> > >     if (rc != 0) {
> > > @@ -41,15 +94,59 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > >             return rc;
> > >     }
> > >
> > > +   rc = pcim_enable_device(pdev);
> > > +   if (rc)
> > > +           return rc;
> > > +
> > >     regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> > >     if (!regloc) {
> > >             dev_err(dev, "register location dvsec not found\n");
> > >             return -ENXIO;
> > >     }
> > > +   regloc += 0xc; /* Skip DVSEC + reserved fields */
> > > +
> > > +   rc = -ENXIO;
> > > +   for (i = regloc; i < regloc + 0x24; i += 8) {
> > > +           u32 reg_lo, reg_hi;
> > > +           u8 reg_type;
> > > +
> > > +           /* "register low and high" contain other bits */
> > > +           pci_read_config_dword(pdev, i, &reg_lo);
> > > +           pci_read_config_dword(pdev, i + 4, &reg_hi);
> > > +
> > > +           reg_type =
> > > +                   (reg_lo >> CXL_REGLOC_RBI_SHIFT) & CXL_REGLOC_RBI_MASK;
> > > +
> > > +           if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> > > +                   rc = 0;
> > > +                   cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
> > > +                   if (!cxlm)
> > > +                           rc = -ENODEV;
> > > +                   break;
> > > +           }
> > > +   }
> > > +
> > > +   if (rc)
> > > +           return rc;
> > >
> > > +   pci_set_drvdata(pdev, cxlm);
> > After below cleanup, not needed yet..
> >
> > >     return 0;
> > >  }
> > >
> > > +static void cxl_mem_remove(struct pci_dev *pdev)
> > > +{
> > > +   struct cxl_mem *cxlm;
> > > +
> > > +   cxlm = pci_get_drvdata(pdev);
> > > +   if (!cxlm)
> > > +           return;
> > > +
> > > +   kfree(cxlm);
> >
> > There is bunch of unwinding here that I'd expect to see in error paths
> > for probe but it's not there...  Which made me wonder.
> > So pcim_iounmap_regions is a managed interface, why are call it by
> > hand?  Same is true of the allocation of cxlm above.  So currently this
> > remove isn't doing anything useful.
> >
> > > +
> > > +   pcim_iounmap_regions(pdev, ~0);
> > > +   pci_set_drvdata(pdev, NULL);
> >
> > This hasn't been needed for a long time. Example of removal of similar...
> > http://patchwork.ozlabs.org/project/netdev/patch/005801ceaec1$6b8d3320$42a79960$%25han@samsung.com/
> >
>
> Thanks. I copy pasted it from a driver that obviously hasn't been updated yet
> :-)
>
> The kfree is still necessary though, right? Earlier in development, I just freed
> it immediately after creation (this patch is obviously not super useful
> functionally, but serves nicely for review).
>
> So we can remove the actual allocation from this patch and move it to later if
> you think it makes a big difference. My preference is to just leave it doing the
> kfree and call it good.

devm obviates the need for a cxl_mem_remove() to undo cxl_mem_probe()
actions. This was all devm clean in v2. The other allocation done in
the probe path is cxl_memdev() allocation, but that is undone by a
devm_add_action_or_reset() to unregister the device along with typical
device reference count rules.
