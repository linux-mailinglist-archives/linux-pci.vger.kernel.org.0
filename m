Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79574A55F9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 05:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiBAE65 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 23:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiBAE64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 23:58:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA035C061714
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 20:58:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso1269273pjm.4
        for <linux-pci@vger.kernel.org>; Mon, 31 Jan 2022 20:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UW73ADbyQLu7YdYQIibXelAkLmUMMebCP4sdSICcX1s=;
        b=W5cZBVlDlTzyUznoAbCZuAxmNhytQ0VrSYt+y6aV80CF8oLBDDgdTWlHMYalldOymM
         xWLWxw3m+N2QPIlcznS+C3QMDqvYGO9fhNUmXs8xIpPb5a4wOpEH13S5y5/yB7IPu8Vj
         VJTBFztuzky0tzoHMUMAgBZnJJXDKls+VQlBsOrSzyUHtp0QsGLloZxr1i2U/XZsv6ps
         0QQh1UIBm2ih8aj3jopb+SDPkgdJdOtaOcD+RAA3mJuccYJxyLMJnO8NEjWvpX+lnyzR
         SuLV2DoYW3qzJ6XqAV6oAAvIbpBjB1WoHmnvGebYU5cGhY1ex1mZZ8JXiJfdQEYCsjUZ
         7gSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UW73ADbyQLu7YdYQIibXelAkLmUMMebCP4sdSICcX1s=;
        b=A2U+A09lOC7CvXbo7HryMpJ54SczIP+fdvYaS+GFQNzHqXILWk+g4sPdIqXcHhWA1h
         e2p1ukWjjkTGUd/R5UHiPRmmd/zBgVIBidR3kDqTaHSLA4ov/OwCFhRGNzhen2brqadg
         /91gYkIh3LyFu74unsi+5MtM6TfQNL27XKus43UAX+1Mm3Xx3xns7JHXHAz4/CIEjony
         J4K22efsiEVXdJgybMWqIfqIk0dWS+XsNvBJ51t2NyGRLdX3nBvLSDUwT0wWIGNJsjc4
         JOZe7rjsR39nrbhXV6z/j6ZRtMBmImn6ubWRikQ889hoxE0VFf6Zw/Plfr33Ed1OXqzd
         qjDQ==
X-Gm-Message-State: AOAM532xn4GalRylZkcQgAQuuQHY/7JeDTyYJ+HlP8y0abh/geRIp5ds
        Dfm8IK26abSuOvKJ5+qaTbE6zh7qm5TTVUYzSQAqSw==
X-Google-Smtp-Source: ABdhPJyXOeR3KzFnohpu/h7369f2N3sAwM5T+C3fTeNJLfoM+jyNK53+wVDUevl69CbdlcEIkhsxbI3PQyruYug5KEM=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr23413046ply.34.1643691536088;
 Mon, 31 Jan 2022 20:58:56 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298423561.3018233.8938479363856921038.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201002435.oodbf3xuhb7xknus@intel.com>
In-Reply-To: <20220201002435.oodbf3xuhb7xknus@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 31 Jan 2022 20:58:48 -0800
Message-ID: <CAPcyv4heQk4LyTOQmU_orK97xgwY4s1fDBsQZv_bqCHwLah4zQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/40] cxl/core/hdm: Add CXL standard decoder
 enumeration to the core
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 31, 2022 at 4:24 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-23 16:30:35, Dan Williams wrote:
> > Unlike the decoder enumeration for "root decoders" described by platform
> > firmware, standard coders can be enumerated from the component registers
>                      ^ decoders
>
> > space once the base address has been identified (via PCI, ACPI, or
> > another mechanism).
> >
> > Add common infrastructure for HDM (Host-managed-Device-Memory) Decoder
> > enumeration and share it between host-bridge, upstream switch port, and
> > cxl_test defined decoders.
> >
> > The locking model for switch level decoders is to hold the port lock
> > over the enumeration. This facilitates moving the dport and decoder
> > enumeration to a 'port' driver. For now, the only enumerator of decoder
> > resources is the cxl_acpi root driver.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> I authored some parts of this patch, not sure how much percentage-wise. If it
> was intentional to drop me, that's fine - just checking.

It was a patch that was not original to the first series, but yeah I
copied some bits out of that series. I'll add you as Co-developed-by
on the resend.

>
> Some comments below.
>
> Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
>
> > ---
> >  drivers/cxl/acpi.c            |   43 ++-----
> >  drivers/cxl/core/Makefile     |    1
> >  drivers/cxl/core/core.h       |    2
> >  drivers/cxl/core/hdm.c        |  247 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c       |   65 ++++++++---
> >  drivers/cxl/core/regs.c       |    5 -
> >  drivers/cxl/cxl.h             |   33 ++++-
> >  drivers/cxl/cxlmem.h          |    8 +
> >  tools/testing/cxl/Kbuild      |    4 +
> >  tools/testing/cxl/test/cxl.c  |   29 +++++
> >  tools/testing/cxl/test/mock.c |   50 ++++++++
> >  tools/testing/cxl/test/mock.h |    3
> >  12 files changed, 436 insertions(+), 54 deletions(-)
> >  create mode 100644 drivers/cxl/core/hdm.c
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 259441245687..8c2ced91518b 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -168,10 +168,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       struct device *host = root_port->dev.parent;
> >       struct acpi_device *bridge = to_cxl_host_bridge(host, match);
> >       struct acpi_pci_root *pci_root;
> > -     int single_port_map[1], rc;
> > -     struct cxl_decoder *cxld;
> >       struct cxl_dport *dport;
> > +     struct cxl_hdm *cxlhdm;
> >       struct cxl_port *port;
> > +     int rc;
> >
> >       if (!bridge)
> >               return 0;
> > @@ -200,37 +200,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       rc = devm_cxl_port_enumerate_dports(host, port);
> >       if (rc < 0)
> >               return rc;
> > -     if (rc > 1)
> > -             return 0;
> > -
> > -     /* TODO: Scan CHBCR for HDM Decoder resources */
> > -
> > -     /*
> > -      * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> > -      * Structure) single ported host-bridges need not publish a decoder
> > -      * capability when a passthrough decode can be assumed, i.e. all
> > -      * transactions that the uport sees are claimed and passed to the single
> > -      * dport. Disable the range until the first CXL region is enumerated /
> > -      * activated.
> > -      */
> > -     cxld = cxl_switch_decoder_alloc(port, 1);
> > -     if (IS_ERR(cxld))
> > -             return PTR_ERR(cxl);
> > -
> >       cxl_device_lock(&port->dev);
> > -     dport = list_first_entry(&port->dports, typeof(*dport), list);
> > -     cxl_device_unlock(&port->dev);
> > +     if (rc == 1) {
> > +             rc = devm_cxl_add_passthrough_decoder(host, port);
> > +             goto out;
> > +     }
> >
> > -     single_port_map[0] = dport->port_id;
> > +     cxlhdm = devm_cxl_setup_hdm(host, port);
> > +     if (IS_ERR(cxlhdm)) {
> > +             rc = PTR_ERR(cxlhdm);
> > +             goto out;
> > +     }
> >
> > -     rc = cxl_decoder_add(cxld, single_port_map);
> > +     rc = devm_cxl_enumerate_decoders(host, cxlhdm);
> >       if (rc)
> > -             put_device(&cxld->dev);
> > -     else
> > -             rc = cxl_decoder_autoremove(host, cxld);
> > +             dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
> >
> > -     if (rc == 0)
> > -             dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
> > +out:
> > +     cxl_device_unlock(&port->dev);
> >       return rc;
> >  }
> >
> > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > index 91057f0ec763..6d37cd78b151 100644
> > --- a/drivers/cxl/core/Makefile
> > +++ b/drivers/cxl/core/Makefile
> > @@ -8,3 +8,4 @@ cxl_core-y += regs.o
> >  cxl_core-y += memdev.o
> >  cxl_core-y += mbox.o
> >  cxl_core-y += pci.o
> > +cxl_core-y += hdm.o
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index e0c9aacc4e9c..1a50c0fc399c 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -14,6 +14,8 @@ struct cxl_mem_query_commands;
> >  int cxl_query_cmd(struct cxl_memdev *cxlmd,
> >                 struct cxl_mem_query_commands __user *q);
> >  int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
> > +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> > +                                resource_size_t length);
> >
> >  int cxl_memdev_init(void);
> >  void cxl_memdev_exit(void);
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > new file mode 100644
> > index 000000000000..802048dc2046
> > --- /dev/null
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -0,0 +1,247 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> > +#include <linux/device.h>
> > +#include <linux/delay.h>
> > +
> > +#include "cxlmem.h"
> > +#include "core.h"
> > +
> > +/**
> > + * DOC: cxl core hdm
> > + *
> > + * Compute Express Link Host Managed Device Memory, starting with the
> > + * CXL 2.0 specification, is managed by an array of HDM Decoder register
> > + * instances per CXL port and per CXL endpoint. Define common helpers
> > + * for enumerating these registers and capabilities.
> > + */
> > +
> > +static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> > +                        int *target_map)
> > +{
> > +     int rc;
> > +
> > +     rc = cxl_decoder_add_locked(cxld, target_map);
> > +     if (rc) {
> > +             put_device(&cxld->dev);
> > +             dev_err(&port->dev, "Failed to add decoder\n");
> > +             return rc;
> > +     }
> > +
> > +     rc = cxl_decoder_autoremove(&port->dev, cxld);
> > +     if (rc)
> > +             return rc;
> > +
> > +     dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
> > +
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
> > + * single ported host-bridges need not publish a decoder capability when a
> > + * passthrough decode can be assumed, i.e. all transactions that the uport sees
> > + * are claimed and passed to the single dport. Disable the range until the first
> > + * CXL region is enumerated / activated.
> > + */
> > +int devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
> > +{
> > +     struct cxl_decoder *cxld;
> > +     struct cxl_dport *dport;
> > +     int single_port_map[1];
> > +
> > +     cxld = cxl_switch_decoder_alloc(port, 1);
> > +     if (IS_ERR(cxld))
> > +             return PTR_ERR(cxld);
> > +
> > +     device_lock_assert(&port->dev);
> > +
> > +     dport = list_first_entry(&port->dports, typeof(*dport), list);
> > +     single_port_map[0] = dport->port_id;
> > +
> > +     return add_hdm_decoder(port, cxld, single_port_map);
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
>
> Hmm, this makes me realize I need to modify the region driver to not care about
> finding decoder resources for a passthrough decoder.

Why would a passthrough decoder not have passthrough resources?

> > +
> > +static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> > +{
> > +     u32 hdm_cap;
> > +
> > +     hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> > +     cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> > +     cxlhdm->target_count =
> > +             FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> > +     if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> > +             cxlhdm->interleave_mask |= GENMASK(11, 8);
> > +     if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> > +             cxlhdm->interleave_mask |= GENMASK(14, 12);
> > +}
> > +
> > +static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> > +                                       void __iomem *crb)
> > +{
> > +     struct cxl_register_map map;
> > +     struct cxl_component_reg_map *comp_map = &map.component_map;
> > +
> > +     cxl_probe_component_regs(&port->dev, crb, comp_map);
> > +     if (!comp_map->hdm_decoder.valid) {
> > +             dev_err(&port->dev, "HDM decoder registers invalid\n");
> > +             return IOMEM_ERR_PTR(-ENXIO);
> > +     }
> > +
> > +     return crb + comp_map->hdm_decoder.offset;
> > +}
> > +
> > +/**
> > + * devm_cxl_setup_hdm - map HDM decoder component registers
> > + * @port: cxl_port to map
> > + */
>
> This got messed up on the fixup. You need @host and @port at this point. It'd be
> pretty cool if we could skip straight to not @host arg.

I'll fixup the inter-patch dpc breakage again, I think I may have
edited a local copy of this file as part of the rebase, and botched
the resend.

I otherwise could not see a way to skip the temporary state without
shipping devm abuse in the middle of series (leaking object
allocations until release)

>
> > +struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port)
> > +{
> > +     void __iomem *crb, __iomem *hdm;
> > +     struct device *dev = &port->dev;
> > +     struct cxl_hdm *cxlhdm;
> > +
> > +     cxlhdm = devm_kzalloc(host, sizeof(*cxlhdm), GFP_KERNEL);
> > +     if (!cxlhdm)
> > +             return ERR_PTR(-ENOMEM);
> > +
> > +     cxlhdm->port = port;
> > +     crb = devm_cxl_iomap_block(host, port->component_reg_phys,
> > +                                CXL_COMPONENT_REG_BLOCK_SIZE);
> > +     if (!crb) {
> > +             dev_err(dev, "No component registers mapped\n");
> > +             return ERR_PTR(-ENXIO);
> > +     }
>
> Does this work if the port is operating in passthrough decoder mode? Is the idea
> to just not call this thing if so?

Per the spec there are always component registers in a CXL port, there
just may not be an HDM Decoder Capability structure in that set of
component registers. See 8.2.5.12.
