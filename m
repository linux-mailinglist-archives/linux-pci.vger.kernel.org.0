Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAEC3A04ED
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jun 2021 22:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhFHUFl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Jun 2021 16:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234256AbhFHUFk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Jun 2021 16:05:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984FFC061787
        for <linux-pci@vger.kernel.org>; Tue,  8 Jun 2021 13:03:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id k5so27104pjj.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Jun 2021 13:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhI0uZdD+bqC6HZkMksTTcPTgmv+oAlfDoNIYsPwNHQ=;
        b=JMNPFpGGS5lh/0K8ov8txZDzpZm+eKmL3lxLGosvfpE/O6MkoZ6FcjeMZnzhdxqTJ5
         yklstTPDnA/gjDJg5+2AtiQxhNsUF/YsbmgKqRO65xaqvxAw7rGv5m7p1tDkB4T7fi07
         HHoaruGFdVR7uFuX7pAgrLBxePNy4CVWFNPzGIZ8aSLmFgJGuYKrBYJgYHP8TcBLl7hy
         2rKxLz31QknjybMuV53BdOy0+z9CDO3xXtiIKOO2ZsUR1h7U0j37R9U3barg8Sgsh6Ii
         Hcvnsja6vN/uz6rfuDbCNVGGgJNBKx4C6873XxqefJNIvcSW1GFV6QeojWLsX6FgVnaz
         VKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhI0uZdD+bqC6HZkMksTTcPTgmv+oAlfDoNIYsPwNHQ=;
        b=CqZTLw8PpeaOshshKk78cfhdhKGtS9XO7VFcCcXlQE+tylXnNZlzE/M0UfyvLRIiYU
         vPqXqV+Pgx5IwxCY2jbr7Y0Ev1ucvoJ6sBvukiLL70+gWvWOykiq+Gja6/XLaZiIHr/5
         gXbB/Nttq9LYtF9S0ChoDMKE9j1/T5GzYEquu334KGjHt3UqmaxA1Qn8p4po4vyiATKs
         TB6vM0YCXrOyO9/MvmQxh5I89j9TKBcgOFmv5gLZzPAmqb4UvEMUQyKX80VNBrXcd7MI
         /CKSqSMq/HOZ8ksxec9WYia3Uhu+SZa8cym+FxCN5hcpEHI8ytULh+AOFSpeCes3k6Cz
         rtNA==
X-Gm-Message-State: AOAM532Mo6RN+we1dIuQehNSkWNpW99ayg86ILtvlUGZ5fBt3af/sGXV
        FssIdPvuG4ssIfDGpgDUPyxWrsewA10dxE1lzMgO1w==
X-Google-Smtp-Source: ABdhPJzPDn7AoKen5PiDE/efuS/RFGNeIk19LM9QLlTquxcqqZoV1WpmhMPseVBYhHaQYA6G6aRuVOlcBz5lQgwLpVw=
X-Received: by 2002:a17:90a:fc88:: with SMTP id ci8mr6734466pjb.13.1623182625985;
 Tue, 08 Jun 2021 13:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295950449.1109360.5228772194963187441.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210608122836.000018fc@Huawei.com>
In-Reply-To: <20210608122836.000018fc@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 8 Jun 2021 13:03:34 -0700
Message-ID: <CAPcyv4h27dkh4FudzhXMQv8FGwY0b1qm1eDf-vDY6aH1kNZsag@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] cxl/acpi: Introduce cxl_root, the root of a
 cxl_port topology
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 8, 2021 at 4:28 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sat, 5 Jun 2021 23:05:04 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > While CXL builds upon the PCI software model for enumeration and
> > endpoint control, a static platform component is required to bootstrap
> > the CXL memory layout. Similar to how ACPI identifies root-level PCI
> > memory resources the ACPI identifies the address space and interleave
> > configuration for CXL Memory.
> >
> > In addition to identifying the host bridges, ACPI is responsible for
> > enumerating the CXL memory space that can be addressed by downstream
> > decoders. This is similar to the requirement for ACPI to publish
> > resources reported by _CRS for PCI host bridges. Specifically ACPI
> > publishes a table, CXL Early Discovery Table (CEDT), which includes a
> > list of CXL Memory resource, CXL Fixed Memory Window Structures (CFMWS).
> >
> > For now introduce the core infrastructure for a cxl_port hierarchy
> > starting with a root level anchor represented by the ACPI0017 device.
> >
> > Follow on changes model support for the configurable decode capabilities
> > of cxl_port instances.
> >
> > Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Two trivial comments inline.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

Thanks, as always, for taking a look.

> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl |   11 ++
> >  drivers/cxl/Kconfig                     |   15 +++
> >  drivers/cxl/Makefile                    |    2
> >  drivers/cxl/acpi.c                      |   39 ++++++++
> >  drivers/cxl/core.c                      |  160 +++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h                       |   23 ++++
> >  6 files changed, 250 insertions(+)
> >  create mode 100644 drivers/cxl/acpi.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 2fe7490ad6a8..fb996ced7629 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -24,3 +24,14 @@ Description:
> >               (RO) "Persistent Only Capacity" as bytes. Represents the
> >               identically named field in the Identify Memory Device Output
> >               Payload in the CXL-2.0 specification.
> > +
> > +What:                /sys/bus/cxl/devices/portX/uport
> > +Date:                May, 2021
> > +KernelVersion:       v5.14
> > +Contact:     linux-cxl@vger.kernel.org
> > +Description:
> > +             CXL port objects are enumerated from either a platform firmware
> > +             device (ACPI0017 and ACPI0016) or PCIe switch upstream port with
> > +             CXL component registers. The 'uport' symlink connects the CXL
> > +             portX object to the device that published the CXL port
> > +             capability.
>
> Is this a complete list of ABI added? Looks like we also add devtype
> attribute in this series.

devtype is the only missing one, I'll add it.

> Mind you I just realized I didn't document the proposed CDAT file either yet.

Hey, we all need prompts to add documentation. I only remembered to
add these here because you commented on it last time.

> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > index 5483ba92b6da..d2573f6aef91 100644
> > --- a/drivers/cxl/Kconfig
> > +++ b/drivers/cxl/Kconfig
> > @@ -45,4 +45,19 @@ config CXL_MEM_RAW_COMMANDS
> >         potential impact to memory currently in use by the kernel.
> >
> >         If developing CXL hardware or the driver say Y, otherwise say N.
> > +
> > +config CXL_ACPI
> > +     tristate "CXL ACPI: Platform Support"
> > +     depends on ACPI
> > +     help
> > +       Enable support for host managed device memory (HDM) resources
> > +       published by a platform's ACPI CXL memory layout description.  See
> > +       Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL 2.0
> > +       specification, and CXL Fixed Memory Window Structures (CEDT.CFMWS)
> > +       (https://www.computeexpresslink.org/spec-landing). The CXL core
> > +       consumes these resource to publish the root of a cxl_port decode
> > +       hierarchy to map regions that represent System RAM, or Persistent
> > +       Memory regions to be managed by LIBNVDIMM.
> > +
> > +       If unsure say 'm'.
> >  endif
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > index d9d282dc15be..a29efb3e8ad2 100644
> > --- a/drivers/cxl/Makefile
> > +++ b/drivers/cxl/Makefile
> > @@ -1,7 +1,9 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_CXL_BUS) += cxl_core.o
> >  obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> > +obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> >
> >  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> >  cxl_core-y := core.o
> >  cxl_pci-y := pci.o
> > +cxl_acpi-y := acpi.o
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > new file mode 100644
> > index 000000000000..556d25ab6966
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
> > +#include "cxl.h"
> > +
> > +static int cxl_acpi_probe(struct platform_device *pdev)
> > +{
> > +     struct cxl_port *root_port;
> > +     struct device *host = &pdev->dev;
> > +
> > +     root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> > +     if (IS_ERR(root_port))
> > +             return PTR_ERR(root_port);
> > +     dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct acpi_device_id cxl_acpi_ids[] = {
> > +     { "ACPI0017", 0 },
> > +     { "", 0 },
> > +};
> > +MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
> > +
> > +static struct platform_driver cxl_acpi_driver = {
> > +     .probe = cxl_acpi_probe,
> > +     .driver = {
> > +             .name = KBUILD_MODNAME,
> > +             .acpi_match_table = cxl_acpi_ids,
> > +     },
> > +};
> > +
> > +module_platform_driver(cxl_acpi_driver);
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_IMPORT_NS(CXL);
> > diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> > index 853666d8a9f5..dbbb34618d7d 100644
> > --- a/drivers/cxl/core.c
> > +++ b/drivers/cxl/core.c
> > @@ -4,6 +4,8 @@
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/pci.h>
> > +#include <linux/slab.h>
> > +#include <linux/idr.h>
> >  #include "cxl.h"
> >
> >  /**
> > @@ -13,6 +15,164 @@
> >   * point for cross-device interleave coordination through cxl ports.
> >   */
> >
> > +static DEFINE_IDA(cxl_port_ida);
> > +
> > +static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> > +                         char *buf)
> > +{
> > +     return sysfs_emit(buf, "%s\n", dev->type->name);
>
> I guess it's really small so doesn't matter that much, but not so nice
> that we are gaining multiple instances of this same function.
>

This is only the second one unless I'm missing something. I do think
it might be worth placing a common definition in the driver-core.
Although it might be the case that I'm the only one that thinks having
devtype as both an attribute and a uevent variable (DEVTYPE) is
worthwhile. All the other variables in a dev_uevent() appear somewhere
in sysfs, so that's a decent argument in my opinion to make devtype a
core attribute.
