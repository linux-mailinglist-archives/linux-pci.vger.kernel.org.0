Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D6E2F3AF5
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 20:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406859AbhALToW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 14:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406832AbhALToW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 14:44:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C191AC061794
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 11:43:41 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id p22so3652496edu.11
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqTQJ5UvLcvmtBDYfIDORZQJUT0UH4UANqjUOFrGQx4=;
        b=WF1OzPmAZJkzxEb4nOPcxbcsApIEOI3LDWJb3GU0e7EIv/bes8IdPe7IYYOINlO/tH
         FW1Kp12lt4ew+dWP1fOg6PLJCg0AlQr4v6aGI4ROTwfxLktbpljhRmQf9ULxwmIKIKjr
         /Mn1de00DqoMjeKDCwyykplvHcr9dgctLM+W4f1nDWQRZvcR/7c3M9wRHbkzQ15iparo
         1oJhYsctI9Ak1m4GuqBbCYS/Ucm0/8u12MZrcpX0O7SNG5ZWr8LPLCianJ4lmYSpO0K0
         PSUNOX8Ipf8qOueBOQYta0ekvzb0QwpsHCrvlyQ/2MDkTAzsITbVGwUAk3eoJn2vEdyV
         Fewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqTQJ5UvLcvmtBDYfIDORZQJUT0UH4UANqjUOFrGQx4=;
        b=VWqInrME4YuVWgR2Cl+6Yok6RJH8F8sczpawMbHWmXonXXiAEn5jnySGKy8FhCe4ty
         cjNpncHOMt0lFM0oR1qqMBxB6z8WclRlJEYVdMW50YdkQob03w4HmvRcGUAjk+2CE6pE
         jkIZoj93ut8VVK8y437aXGjERy5grjBlw1LupEM3+C2EiPxKnSpFinwprrl+vGvLIrL8
         sLix3c9DF3VeCoshsB8jixbmnbijhw4g91v2JDB4XjJUUT5mfPAg2q/0vgkG9lUhymdN
         mz6p+41oGtvpzP4zcyvMsTllkatKMh069Kvn7+dYnLCLYoaLuqPqJgfUWu4m5N74DOAQ
         6WxQ==
X-Gm-Message-State: AOAM532i+z2hKTAltjt5M2y6v2DBcaWNnmtBbjZUj1O1D0PfTCZOQL/H
        JQIUcqKfTVm9GG8Iq8TTdlXSBN5fmsaeEKHk/9gRe2wlo8p16Q==
X-Google-Smtp-Source: ABdhPJzBZAylUKGZ1a6WQhvHt4zB0wYOrhfzk8SvaOhM4K4tPabTdBHdeY/92Ym/O6vIJH+jYCk7C9L/A3XsJaBhjTA=
X-Received: by 2002:a05:6402:1684:: with SMTP id a4mr583584edv.348.1610480620432;
 Tue, 12 Jan 2021 11:43:40 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com>
 <20210111225121.820014-3-ben.widawsky@intel.com> <20210112184355.00007632@Huawei.com>
In-Reply-To: <20210112184355.00007632@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 12 Jan 2021 11:43:31 -0800
Message-ID: <CAPcyv4hcppMZ2L8W8arUKmbCo0r=_yZggrnsj3w-Jgszjn=ZoA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/16] cxl/acpi: Add an acpi_cxl module for the CXL interconnect
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com,
        "Moore, Robert" <robert.moore@intel.com>,
        "Kaneda, Erik" <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 10:44 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Mon, 11 Jan 2021 14:51:06 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> > From: Vishal Verma <vishal.l.verma@intel.com>
> >
> > Add an acpi_cxl module to coordinate the ACPI portions of the CXL
> > (Compute eXpress Link) interconnect. This driver binds to ACPI0017
> > objects in the ACPI tree, and coordinates access to the resources
> > provided by the ACPI CEDT (CXL Early Discovery Table).
> >
> > It also coordinates operations of the root port _OSC object to notify
> > platform firmware that the OS has native support for the CXL
> > capabilities of endpoints.
> >
> > Note: the actbl1.h changes are speculative. The expectation is that they
> > will arrive through the ACPICA tree in due time.
>
> I would pull the ACPICA changes out into a precursor patch.


>
> >
> > Cc: Ben Widawsky <ben.widawsky@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> Hi,
>
> I think it would be good to also add CEDT to the list in drivers/acpi/tables.c
> so that we can dump it from /sys/firmware/acpi/tables/ and potentially
> override it from an initrd.

ACPICA changes will eventually come through the ACPI tree not this patch set.


>
> https://elixir.bootlin.com/linux/v5.11-rc3/source/drivers/acpi/tables.c#L482
> Can be very helpful whilst debugging.  Related to that, anyone know if anyone
> has acpica patches so we can have iasl -d work on the table?  Would probably
> be useful but I'd rather not duplicate work if it's already done.
>

The supplemental tables described here:

https://www.uefi.org/acpi

...do eventually make there way into ACPICA. Added Bob and Erik in
case they can comment on when CEDT and CDAT support will be picked up.

> A few minor things inline
>
> Jonathan
>
> > ---
> >  drivers/Kconfig       |  1 +
> >  drivers/Makefile      |  1 +
> >  drivers/cxl/Kconfig   | 36 ++++++++++++++++
> >  drivers/cxl/Makefile  |  5 +++
> >  drivers/cxl/acpi.c    | 97 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/acpi.h    | 15 +++++++
> >  include/acpi/actbl1.h | 50 ++++++++++++++++++++++
> >  7 files changed, 205 insertions(+)
> >  create mode 100644 drivers/cxl/Kconfig
> >  create mode 100644 drivers/cxl/Makefile
> >  create mode 100644 drivers/cxl/acpi.c
> >  create mode 100644 drivers/cxl/acpi.h
> >
> > diff --git a/drivers/Kconfig b/drivers/Kconfig
> > index dcecc9f6e33f..62c753a73651 100644
> > --- a/drivers/Kconfig
> > +++ b/drivers/Kconfig
> > @@ -6,6 +6,7 @@ menu "Device Drivers"
> >  source "drivers/amba/Kconfig"
> >  source "drivers/eisa/Kconfig"
> >  source "drivers/pci/Kconfig"
> > +source "drivers/cxl/Kconfig"
> >  source "drivers/pcmcia/Kconfig"
> >  source "drivers/rapidio/Kconfig"
> >
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index fd11b9ac4cc3..678ea810410f 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -73,6 +73,7 @@ obj-$(CONFIG_NVM)           += lightnvm/
> >  obj-y                                += base/ block/ misc/ mfd/ nfc/
> >  obj-$(CONFIG_LIBNVDIMM)              += nvdimm/
> >  obj-$(CONFIG_DAX)            += dax/
> > +obj-$(CONFIG_CXL_BUS)                += cxl/
> >  obj-$(CONFIG_DMA_SHARED_BUFFER) += dma-buf/
> >  obj-$(CONFIG_NUBUS)          += nubus/
> >  obj-y                                += macintosh/
> > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > new file mode 100644
> > index 000000000000..68da926ba5b1
> > --- /dev/null
> > +++ b/drivers/cxl/Kconfig
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +menuconfig CXL_BUS
> > +     tristate "CXL (Compute Express Link) Devices Support"
> > +     help
> > +       CXL is a bus that is electrically compatible with PCI-E, but layers
>
> For consistency with Kconfig in driver/pci probably better to spell PCI Express
> throughout.

Sure.

>
> > +       three protocols on that signalling (CXL.io, CXL.cache, and CXL.mem).
> > +       The CXL.cache protocol allows devices to hold cachelines locally, the
> > +       CXL.mem protocol allows devices to be fully coherent memory targets,
> > +       the CXL.io protocol is equivalent to PCI-E. Say 'y' to enable support
> > +       for the configuration and management of devices supporting these
> > +       protocols.
> > +
> > +if CXL_BUS
> > +
> > +config CXL_BUS_PROVIDER
> > +     tristate
> > +
> > +config CXL_ACPI
> > +     tristate "CXL ACPI: Platform Support"
> > +     depends on ACPI
> > +     default CXL_BUS
> > +     select CXL_BUS_PROVIDER
> > +     help
> > +       Say 'y/m' to enable a driver (named "cxl_acpi.ko" when built
> > +       as a module) that will enable support for CXL.mem endpoint
> > +       devices. In general, CXL Platform Support is a prerequisite
> > +       for any CXL device driver that wants to claim ownership of a
> > +       component register space. By default platform firmware assumes
> > +       Linux is unaware of CXL capabilities and requires explicit
> > +       opt-in. This platform component also mediates resources
> > +       described by the CEDT (CXL Early Discovery Table).  See
> > +       Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL 2.0
> > +       specification.
> > +
> > +       If unsure say 'm'
> > +endif
> > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > new file mode 100644
> > index 000000000000..d38cd34a2582
> > --- /dev/null
> > +++ b/drivers/cxl/Makefile
> > @@ -0,0 +1,5 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> > +
> > +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> > +cxl_acpi-y := acpi.o
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > new file mode 100644
> > index 000000000000..0f1ba9b3f1ed
> > --- /dev/null
> > +++ b/drivers/cxl/acpi.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> > +#include <linux/platform_device.h>
> > +#include <linux/list_sort.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/list.h>
> > +#include <linux/acpi.h>
> > +#include <linux/sort.h>
> > +#include <linux/pci.h>
>
> Trivial: For includes I'm fairly sure general convention (as much as there
> is one is to do alphabetical order, not reverse xmas tree).

No, there's no guidance for this in coding-style so it's one of those
maintainer preference items.

>
> > +#include "acpi.h"
> > +
> > +/*
> > + * If/when CXL support is defined by other platform firmware the kernel
> > + * will need a mechanism to select between the platform specific version
> > + * of this routine, until then, hard-code ACPI assumptions
> > + */
> > +int cxl_bus_acquire(struct pci_dev *pdev)
> > +{
> > +     struct acpi_device *adev;
> > +     struct pci_dev *root_port;
> > +     struct device *root;
> > +
> > +     root_port = pcie_find_root_port(pdev);
> > +     if (!root_port)
> > +             return -ENXIO;
> > +
> > +     root = root_port->dev.parent;
> > +     if (!root)
> > +             return -ENXIO;
> > +
> > +     adev = ACPI_COMPANION(root);
> > +     if (!adev)
> > +             return -ENXIO;
> > +
> > +     /* TODO: OSC enabling */
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(cxl_bus_acquire);
> > +
> > +static void acpi_cedt_put_table(void *table)
> > +{
> > +     acpi_put_table(table);
> > +}
> > +
> > +static int cxl_acpi_probe(struct platform_device *pdev)
> > +{
> > +     struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> > +     struct cxl_acpi_desc *acpi_desc;
> > +     struct device *dev = &adev->dev;
> > +     struct acpi_table_header *tbl;
> > +     acpi_status status;
> > +     acpi_size sz;
> > +     int rc;
> > +
> > +     status = acpi_get_table(ACPI_SIG_CEDT, 0, &tbl);
> > +     if (ACPI_FAILURE(status)) {
> > +             dev_err(dev, "failed to find CEDT at startup\n");
> > +             return 0;
> > +     }
> > +
> > +     rc = devm_add_action_or_reset(dev, acpi_cedt_put_table, tbl);
> > +     if (rc)
> > +             return rc;
> > +
> > +     sz = tbl->length;
> > +     dev_info(dev, "found CEDT at startup: %lld bytes\n", sz);
>
> Is this useful?  At least for my normal acpi boot I'll see CEDT in the list of
> detected ACPI tables early in boot.  This provides less info than that
> print already has.

Agree.
