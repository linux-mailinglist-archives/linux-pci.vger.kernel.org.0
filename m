Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5054A54D5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 02:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiBAB6Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 20:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiBAB6X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 20:58:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E1F0C06173B
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 17:58:23 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id z5so14124832plg.8
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 17:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOq85vyV7CEqxLkhtpykRtk2yfShEJ0VxEv5X412Ne8=;
        b=eUmkZWU0j+YUfFcXcw4K3Rcm+zSTqChKzk2bVbvqXE2ikhXbFj7w9s3S9MipKcP+nF
         iMqAbcqxw6zEEvd+lEA1AAMn0El/62sbzV+wvuO49//mkglx7MKGEkcJAyy+k2n3hopr
         IEDLFTPU0dRW/gTL9dzm2WZbBW7qKJfRo44xE90TNRsSLFAoGgK0490sYz4T2ebwnsZ7
         54HeF1cK3OWhTZCG9bzTMBBTGVfVUcJlV0I8p1sRr5Eq22ERFbFP8S0/K6utv7REyv4O
         Kn79JYLemj7tszs/WFyl5mTU/ax+1v+AO/foSTq/D4IHtyiQf7D0xxLmk4cX7ud0DiV5
         2rjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOq85vyV7CEqxLkhtpykRtk2yfShEJ0VxEv5X412Ne8=;
        b=K462kJ+qlxcvrRxGJEdmPkp92VgMMeu2wIP1Pj3jbjD/LqWsFmp3+QB+pH3cqweid+
         BBf6+dbHKyVR6WXErkncwM2bwf1sQctGNmVY7Lf5r2j8YWAWCQ2BuZUDZys8dv0Q0z70
         /JjK9hn1s42AWB3QykpbuqmRy5sRV9LESzskGrfBCtPgYvygMnXbr12Hj1fe6pjExjUN
         QWUb/zAK97p4wH75H9RD8O3xuAKtdOSYLdmWLkaH444WQeDG99rOsAP41kZ/KPxTlrcO
         Y9FH33yW+pBVijMVXiJOJl+p0Lyc6TQSFF9lenkDvFThBrGoeKsb4XAxEvMZ9nEdSlLH
         XifQ==
X-Gm-Message-State: AOAM533AaKPVXjCtLSSc/CrlaUcEMbfrBgndIhGbwvHItX9ORwhfo3u8
        G0tv6RYymOf983D3Pq1zMSu/0IBvJdLDsXyT7feN9A==
X-Google-Smtp-Source: ABdhPJzwVe4IbDDLvO3pys2V+fygYFcLuCXv4HXPMiTd6DZAXslMsvWR6R7ubiqSbEmQ0fqe215OpMe2rwJb43y9TMU=
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr23956442pll.147.1643680702985;
 Mon, 31 Jan 2022 17:58:22 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298423047.3018233.6769866347542494809.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220131170226.00003bac@Huawei.com>
In-Reply-To: <20220131170226.00003bac@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 17:58:14 -0800
Message-ID: <CAPcyv4iHXch0Fri03zYJDfCVePvFodETEVa7nwSWYikit=cDhw@mail.gmail.com>
Subject: Re: [PATCH v3 21/40] cxl/core: Generalize dport enumeration in the core
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 9:03 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Sun, 23 Jan 2022 16:30:30 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > The core houses infrastructure for decoder resources. A CXL port's
> > dports are more closely related to decoder infrastructure than topology
> > enumeration. Implement generic PCI based dport enumeration in the core,
> > i.e. arrange for existing root port enumeration from cxl_acpi to share
> > code with switch port enumeration which is just amounts to a small
>
> which just amounts

Yup, thanks.

>
> > difference in a pci_walk_bus() invocation once the appropriate 'struct
> > pci_bus' has been retrieved.
> >
> > This also simplifies assumptions about the state of a cxl_port relative
> > to when its dports are populated. Previously threads racing enumeration
> > and port lookup could find the port in partially initialized state with
> > respect to its dports. Now it can assume that the arrival of decoder
> > objects indicates the dport description is stable.
>
> Possibly worth clarifying if that race caused any known bugs, or
> if you just mean it's removal leads to simplifications

Yeah, that point is a bit confusing because what I am comparing is the
difference between this patch series and earlier versions. Upstream
has not enumerated switch ports up to this point, so the difference
between how cxl_acpi registered dports relative to decoders vs this
new common way is not something upstream ever dealt with.

>
> A few additional comment inline.
>
> Jonathan
>
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c            |   71 ++++------------------------
> >  drivers/cxl/core/Makefile     |    1
> >  drivers/cxl/core/pci.c        |  104 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c       |   91 +++++++++++++++++++++---------------
> >  drivers/cxl/cxl.h             |   16 ++----
> >  drivers/cxl/cxlpci.h          |    1
> >  tools/testing/cxl/Kbuild      |    3 +
> >  tools/testing/cxl/mock_acpi.c |   78 -------------------------------
> >  tools/testing/cxl/test/cxl.c  |   67 ++++++++++++++++++--------
> >  tools/testing/cxl/test/mock.c |   45 +++++++-----------
> >  tools/testing/cxl/test/mock.h |    6 ++
> >  11 files changed, 243 insertions(+), 240 deletions(-)
> >  create mode 100644 drivers/cxl/core/pci.c
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 3485ae9d3baf..259441245687 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -130,48 +130,6 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >       return 0;
> >  }
> >
> > -__mock int match_add_root_ports(struct pci_dev *pdev, void *data)
> > -{
> > -     resource_size_t creg = CXL_RESOURCE_NONE;
> > -     struct cxl_walk_context *ctx = data;
> > -     struct pci_bus *root_bus = ctx->root;
> > -     struct cxl_port *port = ctx->port;
> > -     int type = pci_pcie_type(pdev);
> > -     struct device *dev = ctx->dev;
> > -     struct cxl_register_map map;
> > -     u32 lnkcap, port_num;
> > -     int rc;
> > -
> > -     if (pdev->bus != root_bus)
> > -             return 0;
> > -     if (!pci_is_pcie(pdev))
> > -             return 0;
> > -     if (type != PCI_EXP_TYPE_ROOT_PORT)
> > -             return 0;
> > -     if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> > -                               &lnkcap) != PCIBIOS_SUCCESSFUL)
> > -             return 0;
> > -
> > -     /* The driver doesn't rely on component registers for Root Ports yet. */
> > -     rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > -     if (!rc)
> > -             dev_info(&pdev->dev, "No component register block found\n");
> > -
> > -     creg = cxl_regmap_to_base(pdev, &map);
> > -
> > -     port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> > -     rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
> > -     if (rc) {
> > -             ctx->error = rc;
> > -             return rc;
> > -     }
> > -     ctx->count++;
> > -
> > -     dev_dbg(dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
> > -
> > -     return 0;
> > -}
> > -
> >  static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
> >  {
> >       struct cxl_dport *dport;
> > @@ -210,7 +168,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       struct device *host = root_port->dev.parent;
> >       struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> >       struct acpi_pci_root *pci_root;
> > -     struct cxl_walk_context ctx;
> >       int single_port_map[1], rc;
> >       struct cxl_decoder *cxld;
> >       struct cxl_dport *dport;
> > @@ -240,18 +197,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >               return PTR_ERR(port);
> >       dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
> >
> > -     ctx = (struct cxl_walk_context){
> > -             .dev = host,
> > -             .root = pci_root->bus,
> > -             .port = port,
> > -     };
> > -     pci_walk_bus(pci_root->bus, match_add_root_ports, &ctx);
> > -
> > -     if (ctx.count == 0)
> > -             return -ENODEV;
> > -     if (ctx.error)
> > -             return ctx.error;
> > -     if (ctx.count > 1)
> > +     rc = devm_cxl_port_enumerate_dports(host, port);
> > +     if (rc < 0)
> > +             return rc;
> > +     if (rc > 1)
> >               return 0;
> >
> >       /* TODO: Scan CHBCR for HDM Decoder resources */
> > @@ -311,9 +260,9 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> >
> >  static int add_host_bridge_dport(struct device *match, void *arg)
> >  {
> > -     int rc;
> >       acpi_status status;
> >       unsigned long long uid;
> > +     struct cxl_dport *dport;
> >       struct cxl_chbs_context ctx;
> >       struct cxl_port *root_port = arg;
> >       struct device *host = root_port->dev.parent;
> > @@ -342,13 +291,13 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> >               return 0;
> >       }
> >
> > -     device_lock(&root_port->dev);
> > -     rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
> > -     device_unlock(&root_port->dev);
> > -     if (rc) {
> > +     cxl_device_lock(&root_port->dev);
>
> Ah.  This is putting back the cxl_device_lock dropped in previous patch I think...

Correct, rebase error now fixed up.

>
> > +     dport = devm_cxl_add_dport(host, root_port, match, uid, ctx.chbcr);
> > +     cxl_device_unlock(&root_port->dev);
> > +     if (IS_ERR(dport)) {
> >               dev_err(host, "failed to add downstream port: %s\n",
> >                       dev_name(match));
> > -             return rc;
> > +             return PTR_ERR(dport);
> >       }
> >       dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
> >       return 0;
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index a90202ac88d2..91057f0ec763 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -7,3 +7,4 @@ cxl_core-y += pmem.o
> >  cxl_core-y += regs.o
> >  cxl_core-y += memdev.o
> >  cxl_core-y += mbox.o
> > +cxl_core-y += pci.o
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > new file mode 100644
> > index 000000000000..48c9a004ae8e
> > --- /dev/null
> > +++ b/drivers/cxl/core/pci.c
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> > +#include <linux/device.h>
> > +#include <linux/pci.h>
> > +#include <cxlpci.h>
> > +#include <cxl.h>
> > +#include "core.h"
> > +
> > +/**
> > + * DOC: cxl core pci
> > + *
> > + * Compute Express Link protocols are layered on top of PCIe. CXL core provides
> > + * a set of helpers for CXL interactions which occur via PCIe.
> > + */
> > +
> > +struct cxl_walk_context {
> > +     struct pci_bus *bus;
> > +     struct device *host;
> > +     struct cxl_port *port;
> > +     int type;
> > +     int error;
> > +     int count;
> > +};
> > +
> > +static int match_add_dports(struct pci_dev *pdev, void *data)
> > +{
> > +     struct cxl_walk_context *ctx = data;
> > +     struct cxl_port *port = ctx->port;
> > +     struct device *host = ctx->host;
> > +     struct pci_bus *bus = ctx->bus;
> > +     int type = pci_pcie_type(pdev);
> > +     struct cxl_register_map map;
> > +     int match_type = ctx->type;
> > +     struct cxl_dport *dport;
> > +     u32 lnkcap, port_num;
> > +     int rc;
> > +
> > +     if (pdev->bus != bus)
> if (pdev->bus != ctx->bus) seems just as clear to me and the local
> variable bus isn't used elsewhere.
>
> > +             return 0;
> > +     if (!pci_is_pcie(pdev))
> > +             return 0;
> > +     if (type != match_type)
>
>         if (pci_pcie_type(pdev) != ctx->type)
>
> is probably easier to follow than with the local variables.
> (note I've not read the rest of the series yet so this might make
> sense if there are additional changes in here)

No, I think the local variables can go.

>
> > +             return 0;
> > +     if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> > +                               &lnkcap) != PCIBIOS_SUCCESSFUL)
>
> We could take this opportunity to just compare with 0 as we do in lots
> of other places.

Sure.

>
> > +             return 0;
> > +
> > +     rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > +     if (rc)
> > +             dev_dbg(&port->dev, "failed to find component registers\n");
> > +
> > +     port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> > +     cxl_device_lock(&port->dev);
> > +     dport = devm_cxl_add_dport(host, port, &pdev->dev, port_num,
> > +                                cxl_regmap_to_base(pdev, &map));
> > +     cxl_device_unlock(&port->dev);
> > +     if (IS_ERR(dport)) {
> > +             ctx->error = PTR_ERR(dport);
> > +             return PTR_ERR(dport);
> > +     }
> > +     ctx->count++;
> > +
> > +     dev_dbg(&port->dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
> > + * @host: devm context
> > + * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
> > + *
> > + * Returns a positive number of dports enumerated or a negative error
> > + * code.
> > + */
> > +int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)
> > +{
> > +     struct pci_bus *bus = cxl_port_to_pci_bus(port);
> > +     struct cxl_walk_context ctx;
> > +     int type;
> > +
> > +     if (!bus)
> > +             return -ENXIO;
> > +
> > +     if (pci_is_root_bus(bus))
> > +             type = PCI_EXP_TYPE_ROOT_PORT;
> > +     else
> > +             type = PCI_EXP_TYPE_DOWNSTREAM;
> > +
> > +     ctx = (struct cxl_walk_context) {
> > +             .host = host,
> > +             .port = port,
> > +             .bus = bus,
> > +             .type = type,
> > +     };
> > +     pci_walk_bus(bus, match_add_dports, &ctx);
> > +
> > +     if (ctx.count == 0)
> > +             return -ENODEV;
> > +     if (ctx.error)
> > +             return ctx.error;
> > +     return ctx.count;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index c51a10154e29..777de6d91dde 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
>
> ...
>
> >
> > @@ -529,51 +506,87 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
> >       return dup ? -EEXIST : 0;
> >  }
> >
> > +static void cxl_dport_remove(void *data)
> > +{
> > +     struct cxl_dport *dport = data;
> > +     struct cxl_port *port = dport->port;
> > +
> > +     cxl_device_lock(&port->dev);
> > +     list_del_init(&dport->list);
>
> Why _init?

I think at some point I rebased this from something that would look at
the state of ->list at release time, so I wanted to make sure that
list_empty() returned true, but that got simplified along the way, so
this can become plain list_del().

>
> > +     cxl_device_unlock(&port->dev);
> > +     put_device(dport->dport);
>
> For this unwinding, could we do the put_device(dport->dport)
> before the rest.  I don't think we need to hold the reference
> whilst doing the rest of this unwinding and it would more closely
> 'reverse' the setup order below.

True, and ok.
