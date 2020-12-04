Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E67B2CE89D
	for <lists+linux-pci@lfdr.de>; Fri,  4 Dec 2020 08:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgLDH2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Dec 2020 02:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727452AbgLDH2C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Dec 2020 02:28:02 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BE3C061A52
        for <linux-pci@vger.kernel.org>; Thu,  3 Dec 2020 23:27:21 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id 7so7291742ejm.0
        for <linux-pci@vger.kernel.org>; Thu, 03 Dec 2020 23:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BXC5TlClpEYD+ovag2sPsKnI5l3hMBu0GjCYfSOMwGw=;
        b=prKjsdHPYCxJJqHauap7GHxj8cUD4UZ4BJLiDyP/AKstEGcTtxxVcK2c7p1LOyoJYc
         IPc/ldFb9mNo/PZNd+gV0Gg3k8Wonrpv9vAqVT5p0bbyf6HIFU7qsY+Ajh1cj90o7RiM
         8CgNv1hJEpkp2wloKsZ/vlegxNbAiH9FFSDE4ndgPCxOkNVb6xYRDm3mZ0JNQ77Mlih8
         cig1x/quX2RZJW4dMhAZGkhg+LxFTTWjEMhcZgSgLmqEOy1+6lrftlvZeEgMXYdFHzYW
         5rgTljOxRy0kVnQf1xEhrWCRj6W9VdL0noV2a8D3jgcuZkqeY7Glfh5yTJdTqkmufdpf
         3Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BXC5TlClpEYD+ovag2sPsKnI5l3hMBu0GjCYfSOMwGw=;
        b=aN1lm95MXPdO9SSUkaabCcCm23QUUsM/n6vZf1lRkNE4HKWzqF/VMeUKwOIjdBx0rp
         qGM6eNgMK6cjptuOOswi8hBNpBL0RJPhu3/7tatZXFf2FcbesLdvJxNL7HV2WuRpxB4c
         CZFYgBGIm6XzPxymp/QYgUJyEqehdAUCzk4iQLbJ8HHMNmUexfk+uhfBBoInJAxJih+2
         OV2Whpr+ojYOv8oJHnCy5DthkrWlZxeYbr2mZfZCLPBIAY5TSBCWgupfQxcVx8VdbSWw
         hV74vD1dD2LTE7tSMx4lPLI29FRDDFqQeo4RLh/QWFMvIrFbiGZuR+XOID9+sG2rZkN8
         mRww==
X-Gm-Message-State: AOAM531xVR5P1YVnGaLdhVs4lK8Jj0eq0N7jp6z78ocvjA0EFyEKXQGf
        SGdovnw/1h/d0jihI8qSLHRFUdEpO/vpPwUMwT6eJA==
X-Google-Smtp-Source: ABdhPJzekZGbtL3sNCqugLoNgopQxbPQGpO4ciaZcRnBZ7Es//BOqGrdxV7PmhF14coDCTwuGolHsmyeCkKw5BDslvg=
X-Received: by 2002:a17:906:edb2:: with SMTP id sa18mr5658315ejb.264.1607066840004;
 Thu, 03 Dec 2020 23:27:20 -0800 (PST)
MIME-Version: 1.0
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-4-ben.widawsky@intel.com> <20201117144935.00006dee@Huawei.com>
 <CAPcyv4h1NQ_ctMAUv1Sc37uh6Mqnm-VL_+woKKAATGOuLCC0Uw@mail.gmail.com>
In-Reply-To: <CAPcyv4h1NQ_ctMAUv1Sc37uh6Mqnm-VL_+woKKAATGOuLCC0Uw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 3 Dec 2020 23:27:16 -0800
Message-ID: <CAPcyv4j7iiJ7BMTiHKrtccH7K_mzvA67nNEcq8yT6k93bPnqow@mail.gmail.com>
Subject: Re: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 3, 2020 at 11:22 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Tue, Nov 17, 2020 at 6:50 AM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Tue, 10 Nov 2020 21:43:50 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >
> > > From: Dan Williams <dan.j.williams@intel.com>
> > >
> > > The CXL.mem protocol allows a device to act as a provider of "System
> > > RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> > > was attached to the typical CPU memory controller.
> > >
> > > The memory range exported by the device may optionally be described by
> > > the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> > > provision persistent memory capacity from one, or more, CXL.mem devices.
> > >
> > > A pre-requisite for Linux-managed memory-capacity provisioning is this
> > > cxl_mem driver that can speak the "type-3 mailbox" protocol.
> > >
> > > For now just land the driver boiler-plate and fill it in with
> > > functionality in subsequent commits.
> > >
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> >
> > I've tried to avoid repeats, so mostly this is me moaning about naming!
> >
> > Jonathan
> >
> > > ---
> > >  drivers/cxl/Kconfig  | 20 +++++++++++
> > >  drivers/cxl/Makefile |  2 ++
> > >  drivers/cxl/mem.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/pci.h    | 15 ++++++++
> > >  4 files changed, 119 insertions(+)
> > >  create mode 100644 drivers/cxl/mem.c
> > >  create mode 100644 drivers/cxl/pci.h
> > >
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index dd724bd364df..15548f5c77ff 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -27,4 +27,24 @@ config CXL_ACPI
> > >         resources described by the CEDT (CXL Early Discovery Table)
> > >
> > >         Say 'y' to enable CXL (Compute Express Link) drivers.
> > > +
> > > +config CXL_MEM
> > > +        tristate "CXL.mem Device Support"
> > > +        depends on PCI && CXL_BUS_PROVIDER != n
> > > +        default m if CXL_BUS_PROVIDER
> > > +        help
> > > +          The CXL.mem protocol allows a device to act as a provider of
> > > +          "System RAM" and/or "Persistent Memory" that is fully coherent
> > > +          as if the memory was attached to the typical CPU memory
> > > +          controller.
> > > +
> > > +          Say 'y/m' to enable a driver named "cxl_mem.ko" that will attach
> > > +          to CXL.mem devices for configuration, provisioning, and health
> > > +          monitoring, the so called "type-3 mailbox". Note, this driver
> > > +          is required for dynamic provisioning of CXL.mem attached
> > > +          memory, a pre-requisite for persistent memory support, but
> > > +          devices that provide volatile memory may be fully described by
> > > +          existing platform firmware memory enumeration.
> > > +
> > > +          If unsure say 'n'.
> > >  endif
> > > diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> > > index d38cd34a2582..97fdffb00f2d 100644
> > > --- a/drivers/cxl/Makefile
> > > +++ b/drivers/cxl/Makefile
> > > @@ -1,5 +1,7 @@
> > >  # SPDX-License-Identifier: GPL-2.0
> > >  obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
> > > +obj-$(CONFIG_CXL_MEM) += cxl_mem.o
> > >
> > >  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
> > >  cxl_acpi-y := acpi.o
> > > +cxl_mem-y := mem.o
> > > diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> > > new file mode 100644
> > > index 000000000000..aa7d881fa47b
> > > --- /dev/null
> > > +++ b/drivers/cxl/mem.c
> > > @@ -0,0 +1,82 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/io.h>
> > > +#include "acpi.h"
> > > +#include "pci.h"
> > > +
> > > +struct cxl_mem {
> > > +     void __iomem *regs;
> > > +};
> > > +
> > > +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
> > > +{
> > > +     int pos;
> > > +
> > > +     pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> > > +     if (!pos)
> > > +             return 0;
> > > +
> > > +     while (pos) {
> > > +             u16 vendor, id;
> > > +
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
> > > +             pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> > > +             if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
> > > +                     return pos;
> > > +
> > > +             pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> >
> > This is good generic code and wouldn't cause much backport effort (even if needed
> > to bring in a local copy), so perhaps make it a generic function and move to
> > core PCI code?
> >
> > Mind you I guess that can happen the 'second' time someone wants to find a DVSEC.
> >
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct cxl_mem *cxlm;
> > > +     int rc, regloc;
> > > +
> > > +     rc = cxl_bus_prepared(pdev);
> > > +     if (rc != 0) {
> > > +             dev_err(dev, "failed to acquire interface\n");
> > > +             return rc;
> > > +     }
> > > +
> > > +     regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> > > +     if (!regloc) {
> > > +             dev_err(dev, "register location dvsec not found\n");
> > > +             return -ENXIO;
> > > +     }
> > > +
> > > +     cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
> > > +     if (!cxlm)
> > > +             return -ENOMEM;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void cxl_mem_remove(struct pci_dev *pdev)
> > > +{
> > > +}
> >
> > I'd bring this in only when needed in later patch.
> >
> > > +
> > > +static const struct pci_device_id cxl_mem_pci_tbl[] = {
> > > +     /* PCI class code for CXL.mem Type-3 Devices */
> > > +     { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> > > +       PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
> > > +     { /* terminate list */ },
> > > +};
> > > +MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> > > +
> > > +static struct pci_driver cxl_mem_driver = {
> > > +     .name                   = KBUILD_MODNAME,
> > > +     .id_table               = cxl_mem_pci_tbl,
> > > +     .probe                  = cxl_mem_probe,
> > > +     .remove                 = cxl_mem_remove,
> > > +};
> > > +
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_AUTHOR("Intel Corporation");
> > > +module_pci_driver(cxl_mem_driver);
> > > +MODULE_IMPORT_NS(CXL);
> > > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > > new file mode 100644
> > > index 000000000000..beb03921e6da
> > > --- /dev/null
> > > +++ b/drivers/cxl/pci.h
> > > @@ -0,0 +1,15 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> > > +#ifndef __CXL_PCI_H__
> > > +#define __CXL_PCI_H__
> > > +
> > > +#define PCI_CLASS_MEMORY_CXL 0x050210
> > > +
> > > +#define PCI_EXT_CAP_ID_DVSEC 0x23
> > > +#define PCI_DVSEC_VENDOR_CXL 0x1E98
> >
> > Hmm. The magic question of what to call a vendor ID that isn't a vendor
> > ID but just a magic number that talks like a duck and quacks like a duck
> > (for anyone wondering what I'm talking about, there is a nice bit of legal
> > boilerplate on this in the CXL spec)
> >
> > This name is definitely not accurate however.
> >
> > PCI_UNIQUE_VALUE_CXL maybe?  It is used for other things than DVSEC (VDMs etc),
> > though possibly this is the only software visible use.
>
> Finally working my way back through this review to make the changes.
> If 0x1E98 becomes visible to software somewhere else then this can
> become something like the following:
>
> #define PCI_DVSEC_VENDOR_CXL PCI_UNIQUE_VALUE_CXL
>
> ...or whatever the generic name is, but this field per the
> specification is the DVSEC-vendor-id and calling it
> PCI_UNIQUE_VALUE_CXL does not have any basis in the spec.
>
> I will rename it though to:
>
> PCI_DVSEC_VENDOR_ID_CXL
>
> ...since include/linux/pci_ids.h includes the _ID_ part.
>
> >
> >
> > > +#define PCI_DVSEC_VENDOR_OFFSET      0x4
> > > +#define PCI_DVSEC_ID_OFFSET  0x8
> >
> > Put a line break here perhaps and maybe a spec reference to where to find
> > the various DVSEC IDs.
>
> Ok.
>
> >
> > > +#define PCI_DVSEC_ID_CXL     0x0
> >
> > That's definitely a confusing name as well.
>
> Yeah, should be PCI_DVSEC_DEVICE_ID_CXL

Actually, no, the spec calls this the "DVSEC id" so PCI_DVSEC_ID_CXL
seems suitable to me. This is from:

Table 126. PCI Express DVSEC Register Settings for CXL Device

In the CXL 2.0 Specification.
