Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E14360D83
	for <lists+linux-pci@lfdr.de>; Thu, 15 Apr 2021 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhDOPDQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 11:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbhDOPBM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Apr 2021 11:01:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF8C061763
        for <linux-pci@vger.kernel.org>; Thu, 15 Apr 2021 08:00:45 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id e14so37291236ejz.11
        for <linux-pci@vger.kernel.org>; Thu, 15 Apr 2021 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eXenppMlRDUQ3XdUE6tp7seWuh83v/wLWPDlePTYdvs=;
        b=zFqtXN64INKdW9Wp27smv397vK6c+sxT6p8RXlfTxilSGWMk0lFvnhiU26e07+pIUB
         hcc1oQGLMYDGMv2uqKc5a4h+LCVInU16GWEYmM0UB/DYOorY+Gr6w1zhW0UyYG/F5tIL
         FMumVsOyrYxS39j5JsTUwnTakDG/Oh4Oqo2cx49z19e6BfVkXAoPY2vngcWVnZ8xfg9c
         A6ULc0sYXeyw7eT1Lebnm657vKjuivkZnGf7k/hpnqCjcQDEK8EpkFSdnWYD8RMYvnjI
         ZcRBMijcslm925/ak9wkfidh5qTzaJcyGTrFYEXKq2C7AE1WxmWN5XlGQ4TrSUgtIEHa
         0OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eXenppMlRDUQ3XdUE6tp7seWuh83v/wLWPDlePTYdvs=;
        b=Hs4w48uZvof/MoUOKZWYmXWgTUYy0/RA+6anaOD4now7w+oRul0E7vL4V8gK2L42Sb
         D1Bk3Z1pRaswvrLgjq8KxxCTpapgDZRG/19oHNpoU3Uvs7KNmyh6Hz+RbRcv+XqlC/va
         GgP6k7bhZMeQ+FbH2SaUK+PJyMPO/6t7zHmbbexB49RnJKx6PxEwwuPPxkKOF+x4H+Eb
         9Ps6Cvm0UG2AxHxqO3S/lpzHQKwa7OwBes+g+mJPx5UpAId+18/U7i0umskt0OEMAXo/
         /9lJ2pfxjpqCw33FHl3vL1Cl7t82t3WKIQIgKYrKAa9MCtgAAVStvQNReFvlDnEux0dD
         GIFA==
X-Gm-Message-State: AOAM533jpzfFEZK9dOxoRG5QThMP8xzY5CQdvTf8PpmotnzP2Ic/XZoF
        mJDGC6cuwSQqjyTStSJRCi3IJBBtnOQ7juiv2NdqTg==
X-Google-Smtp-Source: ABdhPJwKcD6cFbBQ45jvvBX/yt9qT0Adavqea2M2F5q+zROXwVwkprD4+BjXKKV4lspmITb/ruX30pXWP4W6s0zYNI4=
X-Received: by 2002:a17:906:4fcd:: with SMTP id i13mr3830424ejw.341.1618498843483;
 Thu, 15 Apr 2021 08:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161728746928.2474040.8309331256371634167.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210406183232.00003189@Huawei.com>
In-Reply-To: <20210406183232.00003189@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Apr 2021 08:00:00 -0700
Message-ID: <CAPcyv4jvhc6wgne4r_zgJzB3PgSHgMtHrnsRCvx=F8JxPKfBCw@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] cxl/acpi: Introduce ACPI0017 driver and cxl_root
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 6, 2021 at 10:47 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Thu, 1 Apr 2021 07:31:09 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > While CXL builds upon the PCI software model for dynamic enumeration and
> > control, a static platform component is required to bootstrap the CXL
> > memory layout. In addition to identifying the host bridges ACPI is
> > responsible for enumerating the CXL memory space that can be addressed
> > by decoders. This is similar to the requirement for ACPI to publish
> > resources reported by _CRS for PCI host bridges.
> >
> > Introduce the cxl_root object as an abstract "port" into the CXL.mem
> > address space described by HDM decoders identified by the ACPI
> > CEDT.CHBS.
> >
> > For now just establish the initial boilerplate and sysfs attributes, to
> > be followed by enumeration of the ports within the host bridge.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> A few minor comments inline.
>
> > ---
> >  drivers/cxl/Kconfig  |   14 ++
> >  drivers/cxl/Makefile |    2
> >  drivers/cxl/acpi.c   |   39 ++++++
> >  drivers/cxl/core.c   |  349 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h    |   64 +++++++++
> >  5 files changed, 468 insertions(+)
> >  create mode 100644 drivers/cxl/acpi.c
> >
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 97dc4d751651..fb282af84afd 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -50,4 +50,18 @@ config CXL_MEM_RAW_COMMANDS
> >         potential impact to memory currently in use by the kernel.
> >
> >         If developing CXL hardware or the driver say Y, otherwise say N.
> > +
> > +config CXL_ACPI
> > +     tristate "CXL ACPI: Platform Support"
> > +     depends on ACPI
> > +     help
> > +       Enable support for host managed device memory (HDM) resources
> > +       published by a platform's ACPI CXL memory layout description.
> > +       See Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL
> > +       2.0 specification. The CXL core consumes these resource to
> > +       publish port and address_space objects used to map regions
> > +       that represent System RAM, or Persistent Memory regions to be
> > +       managed by LIBNVDIMM.
> > +
> > +       If unsure say 'm'.
> >  endif
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index 3808e39dd31f..f429ca6b59d9 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,7 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> >  obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> > +obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >
> >  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> >  cxl_core-y := core.o
> >  cxl_mem-y := mem.o
> > +cxl_acpi-y := acpi.o
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > new file mode 100644
> > index 000000000000..d54c2d5de730
> > --- /dev/null
> > +++ b/drivers/cxl/acpi.c
> > @@ -0,0 +1,39 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +#include <linux/platform_device.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/acpi.h>
>
> swap acpi.h that for mod_devicetable.h unless this is going to
> need acpi.h later for something else.

It will need it after patch7, so I'll just leave it as is for now.

[..]
> > +static struct cxl_root *cxl_root_alloc(struct device *parent,
> > +                                    struct cxl_address_space *cxl_space,
> > +                                    int nr_spaces)
> > +{
> > +     struct cxl_root *cxl_root;
> > +     struct cxl_port *port;
> > +     struct device *dev;
> > +     int rc;
> > +
> > +     cxl_root = kzalloc(struct_size(cxl_root, address_space, nr_spaces),
> > +                        GFP_KERNEL);
> > +     if (!cxl_root)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     memcpy(cxl_root->address_space, cxl_space,
> > +            flex_array_size(cxl_root, address_space, nr_spaces));
> > +     cxl_root->nr_spaces = nr_spaces;
> > +
> > +     rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
> > +     if (rc < 0)
> > +             goto err;
> > +     port = &cxl_root->port;
> > +     port->id = rc;
> > +
> > +     /*
> > +      * Root does not have a cxl_port as its parent and it does not
> > +      * have any corresponding component registers it is only a
>
> have any corresponding component registers; it is only a
> .. or you could use two sentences

Sure.

>
> > +      * logical anchor to the first level of actual ports that decode
> > +      * the root address spaces.
> > +      */
> > +     port->port_host = parent;
> > +     port->target_id = -1;
> > +     port->component_regs_phys = -1;
> > +
> > +     dev = &port->dev;
> > +     device_initialize(dev);
> > +     device_set_pm_not_required(dev);
> > +     dev->parent = parent;
> > +     dev->bus = &cxl_bus_type;
> > +     dev->type = &cxl_root_type;
> > +
> > +     return cxl_root;
> > +
> > +err:
> > +     kfree(cxl_root);
> > +     return ERR_PTR(rc);
> > +}
> > +
> > +static struct cxl_address_space_dev *
> > +cxl_address_space_dev_alloc(struct device *parent,
> > +                         struct cxl_address_space *space)
> > +{
> > +     struct cxl_address_space_dev *cxl_asd;
> > +     struct resource *res;
> > +     struct device *dev;
> > +     int rc;
> > +
> > +     cxl_asd = kzalloc(sizeof(*cxl_asd), GFP_KERNEL);
> > +     if (!cxl_asd)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     res = &cxl_asd->res;
> > +     res->name = "CXL Address Space";
> > +     res->start = space->range.start;
> > +     res->end = space->range.end;
> > +     res->flags = IORESOURCE_MEM;
> > +
> > +     rc = insert_resource(&iomem_resource, res);
> > +     if (rc)
> > +             goto err;
> > +
> > +     cxl_asd->address_space = space;
> > +     dev = &cxl_asd->dev;
> > +     device_initialize(dev);
> > +     device_set_pm_not_required(dev);
> > +     dev->parent = parent;
> > +     dev->type = &cxl_address_space_type;
> > +
> > +     return cxl_asd;
> > +
> > +err:
> > +     kfree(cxl_asd);
> > +     return ERR_PTR(rc);
> > +}
> > +
> > +static int cxl_address_space_dev_add(struct device *host,
> > +                                  struct cxl_address_space_dev *cxl_asd,
> > +                                  int id)
> > +{
> > +     struct device *dev = &cxl_asd->dev;
> > +     int rc;
> > +
> > +     rc = dev_set_name(dev, "address_space%d", id);
> > +     if (rc)
> > +             goto err;
> > +
> > +     rc = device_add(dev);
> > +     if (rc)
> > +             goto err;
> > +
> > +     dev_dbg(host, "%s: register %s\n", dev_name(dev->parent),
> > +             dev_name(dev));
> > +
> > +     return devm_add_action_or_reset(host, unregister_dev, dev);
> > +
> > +err:
> > +     put_device(dev);
> This is unusual. The error handling is undoing something this function
> wasn't responsible for.  See below for suggested resolution.
>
> > +     return rc;
> > +}
> > +
> > +struct cxl_root *devm_cxl_add_root(struct device *host,
> > +                                struct cxl_address_space *cxl_space,
> > +                                int nr_spaces)
> > +{
> > +     struct cxl_root *cxl_root;
> > +     struct cxl_port *port;
> > +     struct device *dev;
> > +     int i, rc;
> > +
> > +     cxl_root = cxl_root_alloc(host, cxl_space, nr_spaces);
> > +     if (IS_ERR(cxl_root))
> > +             return cxl_root;
> > +
> > +     port = &cxl_root->port;
> > +     dev = &port->dev;
> > +     rc = dev_set_name(dev, "root%d", port->id);
> > +     if (rc)
> > +             goto err;
> > +
> > +     rc = device_add(dev);
> > +     if (rc)
> > +             goto err;
> > +
> > +     rc = devm_add_action_or_reset(host, unregister_dev, dev);
> > +     if (rc)
> > +             return ERR_PTR(rc);
> > +
> > +     for (i = 0; i < nr_spaces; i++) {
> > +             struct cxl_address_space *space = &cxl_root->address_space[i];
> > +             struct cxl_address_space_dev *cxl_asd;
> > +
> > +             if (!range_len(&space->range))
> > +                     continue;
> > +
> > +             cxl_asd = cxl_address_space_dev_alloc(dev, space);
> > +             if (IS_ERR(cxl_asd))
> > +                     return ERR_CAST(cxl_asd);
> > +
>
> Nothing is done between the dev_alloc() and the dev_add()
> and this is currently in the odd position of doing put_device() in the
> error path of *dev_add() when it wasn't responsible for getting the
> reference it is putting, dev_alloc() did that.

No, you missed the back and forth that Jason and I had about proper
device initialization flows:

https://lore.kernel.org/linux-cxl/161714738634.2168142.10860201861152789544.stgit@dwillia2-desk3.amr.corp.intel.com/

The put_device() is not undoing the dev_alloc(), it is undoing the
dev_alloc() + follow on allocations. Specifically it undoes the
dev_set_name() allocation. That is why the alloc and the add are split
into explicit code paths where the recovery shifts from alloc-unwind
to put_device().

> That suggests to me that we can clean up the oddity by just combining
> cxl_address_space_dev_alloc() and cxl_adress_space_dev_add() into one
>
> alloc_and_add() function (with a better name)

It's not an oddity and alloc_and_add() is an anti-pattern that leads to bugs.

>
> > +             rc = cxl_address_space_dev_add(host, cxl_asd, i);
>
> Lifetime management here seems overly complex.   Why not use host for both
> the alloc and add() devm calls?  I guess there is a good reason
> though so good to have a comment here saying what it is.

I'll add a kernel-doc to cxl_address_space_dev_add() to clarify what
is happening here.
