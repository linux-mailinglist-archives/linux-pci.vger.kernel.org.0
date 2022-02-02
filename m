Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D264A6BC3
	for <lists+linux-pci@lfdr.de>; Wed,  2 Feb 2022 07:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbiBBGxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Feb 2022 01:53:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244774AbiBBGwj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Feb 2022 01:52:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75827C06174A
        for <linux-pci@vger.kernel.org>; Tue,  1 Feb 2022 22:04:04 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so4990625pjb.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Feb 2022 22:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T3gpZL/kRMPUrYclU8rJ5X+a6CzAPFGL0NPFRfytNQM=;
        b=uvtjBbcBuGru2IgQrJbx7k0ZwFfHS7yBefGRejIiN081uBfQa9G/eBdboJvc9crUUn
         DzOzsfpKpDQ3jWUDDLS2D6AmhVIVmNDmlFpFfUygx/tUBptjsZru6qXKTEutVAu6BQQj
         Mc4U/w5i2hVnyfoED7an4b2I07jZ2FE+wQ75ujC0bGjtu5IqwuoFA/ExanE3YHkj9o/w
         FKAu5ZCp8pVnW3JTnH8vGOskfyFgvvZZtLp/l/RYBWZFGSWrS76ZsBfv+XfcVfLJnBFg
         E1Gkx4TqBF0qdd0Xk87ycOWZ0l1aIv0X79fRQx4df7b31LzKSmjCXyBmuwqK0yXxdwbd
         BpKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3gpZL/kRMPUrYclU8rJ5X+a6CzAPFGL0NPFRfytNQM=;
        b=HPnC7Jw3d/ResZcJXMIT7OzR2grlOs9ZKdKprmoNw7REIBbLf5iTOkLzVZq0QvA5/g
         xKMTItWmXb+FDfP6/h50HlGrbMCyXLsfbg2NFGOh9qLKlOChNJ6lQoL1ng+wziFQ/4/T
         416FYlk1A+0k0/K4UYf777EGbR3EwZJIjyt89CyFaXTjV9HBHNCdFKb8oOmCjP/PuqTU
         LqXXEdmIBLgwTnhMNiCrq2L0LI9e6wB/KO0siGy1cH8O6hi66l8C5562z+s5N8/E73Co
         Sw0OtGjqLEEifLqBpB7FSXnSXkERkThhuvCrIzgxnPv0UVxP6S4PaE2j/Vs0ZILkvp78
         7v9Q==
X-Gm-Message-State: AOAM531GOyZojq3hQstKJyaYDQLZyghTVlSPoy7rzzZhMU4Xhoy9UP2s
        gBGq2zzSUa1fU4M/Gx/JKriwbnfUJ/FtE188uhqeU99KC2A=
X-Google-Smtp-Source: ABdhPJwvLEgSmb3qD40298L9Bu+cOdnE0KIPS9gwnJkGlbIFxymIe0Wb/GDae8JpVSwIz3sbYWALInzDc9gQ62Zt4wI=
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr29611676pll.147.1643781843670;
 Tue, 01 Feb 2022 22:04:03 -0800 (PST)
MIME-Version: 1.0
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298428940.3018233.18042207990919432824.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20220201173709.jswrzluy6a4lji3m@intel.com>
In-Reply-To: <20220201173709.jswrzluy6a4lji3m@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 1 Feb 2022 22:03:51 -0800
Message-ID: <CAPcyv4g1G8CZRcqw5ccv2Jo-KoJdNg=yLSRwMLpi6eJs2DB7+w@mail.gmail.com>
Subject: Re: [PATCH v3 32/40] cxl/core/port: Add switch port enumeration
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 1, 2022 at 9:37 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 22-01-23 16:31:29, Dan Williams wrote:
> > So far the platorm level CXL resources have been enumerated by the
> > cxl_acpi driver, and cxl_pci has gathered all the pre-requisite
> > information it needs to fire up a cxl_mem driver. However, the first
> > thing the cxl_mem driver will be tasked to do is validate that all the
> > PCIe Switches in its ancestry also have CXL capabilities and an CXL.mem
> > link established.
> >
> > Provide a common mechanism for a CXL.mem endpoint driver to enumerate
> > all the ancestor CXL ports in the topology and validate CXL.mem
> > connectivity.
> >
> > Multiple endpoints may end up racing to establish a shared port in the
> > topology. This race is resolved via taking the device-lock on a parent
> > CXL Port before establishing a new child. The winner of the race
> > establishes the port, the loser simply registers its interest in the
> > port via 'struct cxl_ep' place-holder reference.
> >
> > At endpoint teardown the same parent port lock is taken as 'struct
> > cxl_ep' references are deleted. Last endpoint to drop its reference
> > unregisters the port.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/acpi.c      |   17 --
> >  drivers/cxl/core/port.c |  379 +++++++++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |   20 ++
> >  3 files changed, 400 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 683f2ca32c97..7bd53dc691ec 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -130,21 +130,6 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >       return 0;
> >  }
> >
> > -static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
> > -{
> > -     struct cxl_dport *dport;
> > -
> > -     cxl_device_lock(&port->dev);
> > -     list_for_each_entry(dport, &port->dports, list)
> > -             if (dport->dport == dev) {
> > -                     cxl_device_unlock(&port->dev);
> > -                     return dport;
> > -             }
> > -
> > -     cxl_device_unlock(&port->dev);
> > -     return NULL;
> > -}
> > -
> >  __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
> >                                             struct device *dev)
> >  {
> > @@ -175,7 +160,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
> >       if (!bridge)
> >               return 0;
> >
> > -     dport = find_dport_by_dev(root_port, match);
> > +     dport = cxl_find_dport_by_dev(root_port, match);
> >       if (!dport) {
> >               dev_dbg(host, "host bridge expected and not found\n");
> >               return 0;
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 26c3eb9180cd..cd95d9f8c624 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/idr.h>
> >  #include <cxlmem.h>
> > +#include <cxlpci.h>
> >  #include <cxl.h>
> >  #include "core.h"
> >
> > @@ -267,10 +268,24 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
> >
> > +static void cxl_ep_release(struct cxl_ep *ep)
> > +{
> > +     if (!ep)
> > +             return;
> > +     list_del(&ep->list);
> > +     put_device(ep->ep);
> > +     kfree(ep);
> > +}
> > +
> >  static void cxl_port_release(struct device *dev)
> >  {
> >       struct cxl_port *port = to_cxl_port(dev);
> > +     struct cxl_ep *ep, *_e;
> >
> > +     cxl_device_lock(dev);
> > +     list_for_each_entry_safe(ep, _e, &port->endpoints, list)
> > +             cxl_ep_release(ep);
> > +     cxl_device_unlock(dev);
> >       ida_free(&cxl_port_ida, port->id);
> >       kfree(port);
> >  }
> > @@ -361,6 +376,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
> >       port->component_reg_phys = component_reg_phys;
> >       ida_init(&port->decoder_ida);
> >       INIT_LIST_HEAD(&port->dports);
> > +     INIT_LIST_HEAD(&port->endpoints);
> >
> >       device_initialize(dev);
> >       device_set_pm_not_required(dev);
> > @@ -639,6 +655,369 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
> >
> > +static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
> > +{
> > +     struct cxl_ep *ep;
> > +
> > +     device_lock_assert(&port->dev);
> > +     list_for_each_entry(ep, &port->endpoints, list)
> > +             if (ep->ep == ep_dev)
> > +                     return ep;
> > +     return NULL;
> > +}
> > +
> > +static int add_ep(struct cxl_port *port, struct cxl_ep *new)
> > +{
> > +     struct cxl_ep *dup;
> > +
> > +     cxl_device_lock(&port->dev);
> > +     if (port->dead) {
> > +             cxl_device_unlock(&port->dev);
> > +             return -ENXIO;
> > +     }
> > +     dup = find_ep(port, new->ep);
> > +     if (!dup)
> > +             list_add_tail(&new->list, &port->endpoints);
> > +     cxl_device_unlock(&port->dev);
> > +
> > +     return dup ? -EEXIST : 0;
> > +}
> > +
> > +/**
> > + * cxl_add_ep - register an endpoint's interest in a port
> > + * @port: a port in the endpoint's topology ancestry
> > + * @ep_dev: device representing the endpoint
> > + *
> > + * Intermediate CXL ports are scanned based on the arrival of endpoints.
> > + * When those endpoints depart the port can be destroyed once all
> > + * endpoints that care about that port have been removed.
> > + */
> > +static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
> > +{
> > +     struct cxl_ep *ep;
> > +     int rc;
> > +
> > +     ep = kzalloc(sizeof(*ep), GFP_KERNEL);
> > +     if (!ep)
> > +             return -ENOMEM;
> > +
> > +     INIT_LIST_HEAD(&ep->list);
> > +     ep->ep = get_device(ep_dev);
> > +
> > +     rc = add_ep(port, ep);
> > +     if (rc)
> > +             cxl_ep_release(ep);
> > +     return rc;
> > +}
> > +
> > +struct cxl_find_port_ctx {
> > +     const struct device *dport_dev;
> > +     const struct cxl_port *parent_port;
> > +};
> > +
> > +static int match_port_by_dport(struct device *dev, const void *data)
> > +{
> > +     const struct cxl_find_port_ctx *ctx = data;
> > +     struct cxl_port *port;
> > +
> > +     if (!is_cxl_port(dev))
> > +             return 0;
> > +     if (ctx->parent_port && dev->parent != &ctx->parent_port->dev)
> > +             return 0;
> > +
> > +     port = to_cxl_port(dev);
> > +     return cxl_find_dport_by_dev(port, ctx->dport_dev) != NULL;
> > +}
> > +
> > +static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
> > +{
> > +     struct device *dev;
> > +
> > +     if (!ctx->dport_dev)
> > +             return NULL;
> > +
> > +     dev = bus_find_device(&cxl_bus_type, NULL, ctx, match_port_by_dport);
> > +     if (dev)
> > +             return to_cxl_port(dev);
> > +     return NULL;
> > +}
> > +
> > +static struct cxl_port *find_cxl_port(struct device *dport_dev)
> > +{
> > +     struct cxl_find_port_ctx ctx = {
> > +             .dport_dev = dport_dev,
> > +     };
> > +
> > +     return __find_cxl_port(&ctx);
> > +}
> > +
> > +static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
> > +                                      struct device *dport_dev)
> > +{
> > +     struct cxl_find_port_ctx ctx = {
> > +             .dport_dev = dport_dev,
> > +             .parent_port = parent_port,
> > +     };
> > +
> > +     return __find_cxl_port(&ctx);
> > +}
> > +
> > +static struct device *grandparent(struct device *dev)
> > +{
> > +     if (dev && dev->parent)
> > +             return dev->parent->parent;
> > +     return NULL;
> > +}
> > +
> > +static void delete_switch_port(struct cxl_memdev *cxlmd, struct cxl_port *port,
> > +                            struct list_head *dports)
> > +{
> > +     struct cxl_dport *dport, *_d;
> > +
> > +     dev_dbg(&cxlmd->dev, "delete %s\n", dev_name(&port->dev));
> > +     list_for_each_entry_safe(dport, _d, dports, list) {
> > +             devm_release_action(&port->dev, cxl_dport_unlink, dport);
> > +             devm_release_action(&port->dev, cxl_dport_remove, dport);
> > +             devm_kfree(&port->dev, dport);
> > +     }
> > +     devm_release_action(port->dev.parent, cxl_unlink_uport, port);
> > +     devm_release_action(port->dev.parent, unregister_port, port);
> > +}
>
> I'd drop the cxlmd argument here. Let the caller print the dev_dbg if it wants.

Ok.

>
> > +
> > +static void cxl_remove_ep(void *data)
> > +{
> > +     struct cxl_memdev *cxlmd = data;
> > +     struct device *iter;
> > +
> > +     for (iter = &cxlmd->dev; iter; iter = grandparent(iter)) {
> > +             struct device *dport_dev = grandparent(iter);
> > +             struct cxl_port *port, *parent_port;
> > +             LIST_HEAD(reap_dports);
> > +             struct cxl_ep *ep;
> > +
> > +             if (!dport_dev)
> > +                     break;
> > +
> > +             port = find_cxl_port(dport_dev);
> > +             if (!port || is_cxl_root(port)) {
> > +                     put_device(&port->dev);
> > +                     continue;
>
> Is there ever a case that continue != break for this case? It seems to be this
> deserves a WARN_ON(grandparent(iter)) or some such, but I'd be curious to see if
> my understanding is off.

Recall that while outside the lock we have top-down removal racing
potentially multiple bottom-up removals. So the "!port" case can just
be a race loss, but needs to continue up the chain. The root check
does assume that grandparent goes NULL. WARN_ON() would be a nop here
because if grandparent() for a root dport resolves to !NULL the port
registration would not have worked in the first instance.

I added a comment to delete_switch_port() about the races that can be
happening in this function.

>
> > +             }
> > +
> > +             parent_port = to_cxl_port(port->dev.parent);
> > +             cxl_device_lock(&parent_port->dev);
> > +             if (!parent_port->dev.driver) {
> > +                     cxl_device_unlock(&parent_port->dev);
> > +                     put_device(&port->dev);
> > +                     continue;
>
> Similar to above, the parent_port must still exist at this point and have a
> driver bound, correct?

Not necessarily.

>
> > +             }
> > +
> > +             cxl_device_lock(&port->dev);
> > +             ep = find_ep(port, &cxlmd->dev);
> > +             dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
> > +                     ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
> > +             cxl_ep_release(ep);
> > +             if (ep && !port->dead && list_empty(&port->endpoints) &&
> > +                 !is_cxl_root(parent_port)) {
> > +                     /*
> > +                      * This was the last ep attached to a dynamically
> > +                      * enumerated port. Block new cxl_add_ep() and garbage
> > +                      * collect the port.
> > +                      */
> > +                     port->dead = true;
> > +                     list_splice_init(&port->dports, &reap_dports);
> > +             }
> > +             cxl_device_unlock(&port->dev);
> > +
> > +             if (!list_empty(&reap_dports))
> > +                     delete_switch_port(cxlmd, port, &reap_dports);
>
> I admit I tried to make all this simpler and couldn't figure anything better
> out.

I am working on a unit test to try to stress the above races.

>
> > +             put_device(&port->dev);
> > +             cxl_device_unlock(&parent_port->dev);
> > +     }
> > +}
> > +
> > +static resource_size_t find_component_registers(struct device *dev)
> > +{
> > +     struct cxl_register_map map;
> > +     struct pci_dev *pdev;
> > +
> > +     /*
> > +      * Theoretically, CXL component registers can be hosted on a
>
> I believe this is factually incorrect. The spec requires it be on a PCIe device.
> Does it make sense to introduce a dev_is_cxltest()?

I also consider ACPI devices non-PCIe CXL devices. The ACPI CFMWS
already shows how to bridge PCI enumerable resources into PCIe
enumerable CXL domain, so it's not just cxl_test in that
"Theoretical".

>
> > +      * non-PCI device, in practice, only cxl_test hits this case.
> > +      */
> > +     if (!dev_is_pci(dev))
> > +             return CXL_RESOURCE_NONE;
> > +
> > +     pdev = to_pci_dev(dev);
> > +
> > +     cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> > +     return cxl_regmap_to_base(pdev, &map);
> > +}
> > +
> > +static int add_port_register_ep(struct cxl_memdev *cxlmd,
> > +                             struct device *uport_dev,
> > +                             struct device *dport_dev)
> > +{
> > +     struct cxl_port *port, *parent_port;
> > +     resource_size_t component_reg_phys;
> > +     int rc;
> > +
> > +     parent_port = find_cxl_port(grandparent(dport_dev));
>
> This is confusing (thought correct). dport's parent is a port, and port's parent
> is a port. Logically though, I'd expect a grandparent of a device to be of the
> same type. I wonder if there is some way to straighten that out, or if I'm the
> only one that finds it confusing.

You jumped from PCIe to CXL hierarchy. A dport does not exist on the
cxl_bus_type, it is non-device metadata / a link over to a downstream
switch port device in the PCIe domain. The parent of a downstream
switch port is an upstream switch port. the parent of an upstream
switch port is another downstream switch port.

>
> > +     if (!parent_port) {
> > +             /*
> > +              * The root CXL port is added by the CXL platform driver, fail
> > +              * for now to be re-probed after platform driver attaches.
> > +              */
> > +             if (!grandparent(dport_dev)) {
> > +                     dev_dbg(&cxlmd->dev, "%s is a root dport\n",
> > +                             dev_name(dport_dev));
> > +                     return -ENXIO;
> > +             }
> > +             /* ...otherwise, iterate to create this parent_port */
> > +             return -EAGAIN;
> > +     }
> > +
> > +     cxl_device_lock(&parent_port->dev);
> > +     if (!parent_port->dev.driver) {
> > +             dev_warn(&cxlmd->dev,
> > +                      "port %s:%s disabled, failed to enumerate CXL.mem\n",
> > +                      dev_name(&parent_port->dev), dev_name(uport_dev));
> > +             rc = -ENXIO;
> > +             goto out;
> > +     }
> > +
> > +     port = find_cxl_port_at(parent_port, dport_dev);
>
> Again this is a bit tough on the terminology. A dport's parent is a port, but
> not parent_port. I'd definitely suggest a comment for clarifying that.

A dport_dev's parent is not a cxl_port. CXL devices can't parent PCI
devices. I'll add a comment to levelset what some of these variables
are representing and how "grandparent()" works in that context.

>
> > +     if (!port) {
> > +             component_reg_phys = find_component_registers(uport_dev);
> > +             port = devm_cxl_add_port(&parent_port->dev, uport_dev,
> > +                                      component_reg_phys, parent_port);
> > +             if (!IS_ERR(port))
> > +                     get_device(&port->dev);
> > +     }
> > +out:
> > +     cxl_device_unlock(&parent_port->dev);
> > +
> > +     if (IS_ERR(port))
> > +             rc = PTR_ERR(port);
> > +     else {
> > +             dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
> > +                     dev_name(&port->dev), dev_name(port->uport));
> > +             rc = cxl_add_ep(port, &cxlmd->dev);
> > +             if (rc == -EEXIST) {
> > +                     /*
> > +                      * "can't" happen, but this error code means
> > +                      * something to the caller, so translate it.
> > +                      */
> > +                     rc = -ENXIO;
>
> "can't" should translate to a WARN IMHO.

WARNs are effectively BUG_ONs in some sites. I wouldn't crash the
kernel for this, a driver load error is sufficient.

>
> > +             }
> > +             put_device(&port->dev);
> > +     }
> > +
> > +     put_device(&parent_port->dev);
> > +     return rc;
> > +}
> > +
> > +int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
> > +{
> > +     struct device *dev = &cxlmd->dev;
> > +     struct device *iter;
> > +     int rc;
> > +
> > +     rc = devm_add_action_or_reset(&cxlmd->dev, cxl_remove_ep, cxlmd);
> > +     if (rc)
> > +             return rc;
> > +
> > +     /*
> > +      * Scan for and add all cxl_ports in this device's ancestry.
> > +      * Repeat until no more ports are added. Abort if a port add
> > +      * attempt fails.
> > +      */
> > +retry:
> > +     for (iter = dev; iter; iter = grandparent(iter)) {
> > +             struct device *dport_dev = grandparent(iter);
> > +             struct device *uport_dev;
> > +             struct cxl_port *port;
> > +
> > +             if (!dport_dev)
> > +                     break;
> > +             uport_dev = dport_dev->parent;
> > +             dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
> > +                     dev_name(iter), dev_name(dport_dev),
> > +                     uport_dev ? dev_name(uport_dev) : "'none'");
> > +             if (!uport_dev) {
> > +                     dev_warn(dev, "unexpected topology, no parent for %s\n",
> > +                              dev_name(dport_dev));
> > +                     rc = -ENXIO;
> > +                     break;
> > +             }
> > +
> > +             port = find_cxl_port(dport_dev);
> > +             if (port) {
> > +                     dev_dbg(&cxlmd->dev,
> > +                             "found already registered port %s:%s\n",
> > +                             dev_name(&port->dev), dev_name(port->uport));
> > +                     rc = cxl_add_ep(port, &cxlmd->dev);
> > +
> > +                     /*
> > +                      * If the endpoint already exists in the port's list,
> > +                      * that's ok, it was added on a previous pass.
> > +                      * Otherwise, retry in add_port_register_ep() after
> > +                      * taking the parent_port lock as the current port may
> > +                      * be being reaped.
> > +                      */
> > +                     if (rc && rc != -EEXIST) {
> > +                             put_device(&port->dev);
> > +                             return rc;
> > +                     }
>
> I could use an explanation on how an endpoint could have been added on a
> previous pass. It seems like !list_empty(&ep->list) here would be a bug.

There's a goto retry after every successful port addition, so
subsequent iterations might find some already completed work.

>
> > +
> > +                     if (is_cxl_port(port->dev.parent) &&
> > +                         !is_cxl_root(to_cxl_port(port->dev.parent))) {
> > +                             put_device(&port->dev);
> > +                             continue;
> > +                     }
> > +
> > +                     put_device(&port->dev);
> > +                     break;
> > +             }
> > +
> > +             rc = add_port_register_ep(cxlmd, uport_dev, dport_dev);
> > +             /* port missing, try to add parent */
> > +             if (rc == -EAGAIN)
> > +                     continue;
> > +             /* failed to add ep or port */
> > +             if (rc)
> > +                     return rc;
> > +             /* port added, new descendants possible, start over */
> > +             goto retry;
> > +     }
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
> > +
> > +struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
> > +{
> > +     return find_cxl_port(grandparent(&cxlmd->dev));
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
> > +
> > +struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
> > +                                     const struct device *dev)
> > +{
> > +     struct cxl_dport *dport;
> > +
> > +     cxl_device_lock(&port->dev);
> > +     list_for_each_entry(dport, &port->dports, list)
> > +             if (dport->dport == dev) {
> > +                     cxl_device_unlock(&port->dev);
> > +                     return dport;
> > +             }
> > +
> > +     cxl_device_unlock(&port->dev);
> > +     return NULL;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
> > +
> >  static int decoder_populate_targets(struct cxl_decoder *cxld,
> >                                   struct cxl_port *port, int *target_map)
> >  {
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 7c714e559e95..b71d40b68ccd 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -262,8 +262,10 @@ struct cxl_nvdimm {
> >   * @uport: PCI or platform device implementing the upstream port capability
> >   * @id: id for port device-name
> >   * @dports: cxl_dport instances referenced by decoders
> > + * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
> >   * @decoder_ida: allocator for decoder ids
> >   * @component_reg_phys: component register capability base address (optional)
> > + * @dead: last ep has been removed, force port re-creation
> >   * @depth: How deep this port is relative to the root. depth 0 is the root.
> >   */
> >  struct cxl_port {
> > @@ -271,8 +273,10 @@ struct cxl_port {
> >       struct device *uport;
> >       int id;
> >       struct list_head dports;
> > +     struct list_head endpoints;
> >       struct ida decoder_ida;
> >       resource_size_t component_reg_phys;
> > +     bool dead;
> >       unsigned int depth;
> >  };
> >
> > @@ -292,6 +296,16 @@ struct cxl_dport {
> >       struct list_head list;
> >  };
> >
> > +/**
> > + * struct cxl_ep - track an endpoint's interest in a port
> > + * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
> > + * @list: node on port->endpoints list
> > + */
> > +struct cxl_ep {
> > +     struct device *ep;
> > +     struct list_head list;
> > +};
> > +
> >  static inline bool is_cxl_root(struct cxl_port *port)
> >  {
> >       return port->uport == port->dev.parent;
> > @@ -307,9 +321,15 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >                                  resource_size_t component_reg_phys,
> >                                  struct cxl_port *parent_port);
> >  struct cxl_port *find_cxl_root(struct device *dev);
> > +int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
> > +int cxl_bus_rescan(void);
> > +
> >  struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> >                                    struct device *dport, int port_id,
> >                                    resource_size_t component_reg_phys);
> > +struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
> > +                                     const struct device *dev);
> > +
> >  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> >  bool is_root_decoder(struct device *dev);
> >  bool is_cxl_decoder(struct device *dev);
> >
