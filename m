Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4353949FFF9
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 19:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiA1SOV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 13:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbiA1SOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 13:14:20 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D1C06173B
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 10:14:20 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id e28so6893011pfj.5
        for <linux-pci@vger.kernel.org>; Fri, 28 Jan 2022 10:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kn6MF/WyMxLuLgF5XCbpALm+QhqWelMuNxlnWedV6Uo=;
        b=Wpv604qDygLbDrSUjDA0ubwbK9c5U9bwwrY9azy00mMXet7c9XgAy8mXknhvnYnSfL
         gEXPwh8uRYM4enVg8MGvsxvYAPqqQt19uSkFphunSc+jhW+TflM02AiXo+ul4YNnvVLn
         CTA5FjukgMzDZEwkrNoea8I4DJv9+XUIjkryHcZDeREex0JBx8MZ+Js/yo/73QuIGXrO
         +BwzoShYsbCM80PI/Epv33WFjmUjumnZyx9rqzxQqSZ4lyFUAfwsJgYYC3aB3CZo93RK
         CGE5C3BF1pjdVI4tUVGjUmUcNh3cc02JHmrvmneAIAvO1M6ls8DmG7cWq41+H5ACHcIZ
         onCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kn6MF/WyMxLuLgF5XCbpALm+QhqWelMuNxlnWedV6Uo=;
        b=2YnM5qf6M3/Mj5i/O+npEN9aX+VFeewa2tNPNgz4WMXK9n4wPirHF9jELSSLTFZDe5
         KhLmUHC3r/8X9V5Tetx4sW5MHGugorD4lX2Y+hjoCadjNgQ9kyixsYK+A6Ou25O8Wxrx
         vYCfhFTmgMeTMN3b5wIx6Yo6tfuzwZd88QwmGoaIFfsGcxrvH3ZlwrB9IiWrfV9XV28f
         /R9kP3i0FJr+gnyd0saaFCyFNO7maJrTSAaTYh/ayL+QIYxUFjqwDcaDtHqmx6HX8iQ5
         WzSdX4TBDmkn46AyNYyRHllA0aNQiAUbjLYeSvGXAQsA66lp4HbihyO3o9JA/4q8nht1
         ELuw==
X-Gm-Message-State: AOAM531ieem6363sbxYsVbF7UpZq8kmYdIpd1BmsyGRV4lYJcYJQqul+
        xMoThQZ7fcfgXQ2l4JBf9EJnVlO1i6pcyVppkaynqw==
X-Google-Smtp-Source: ABdhPJx0/bRzUnqVnUPUV5CuhEu/Y4Wqc8hp11+SIC2mhe+7sjH4jwyUH2ao0E46c9iuLRQ5KpCVTih/W+woIoxEl+E=
X-Received: by 2002:a63:550f:: with SMTP id j15mr7432513pgb.40.1643393659851;
 Fri, 28 Jan 2022 10:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-2-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-2-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 28 Jan 2022 10:14:09 -0800
Message-ID: <CAPcyv4h53gj9vETFcj_RebW+Zt=q+1yOmMo9CpyzHdABanpPRg@mail.gmail.com>
Subject: Re: [PATCH v3 01/14] cxl/region: Add region creation ABI
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Regions are created as a child of the decoder that encompasses an
> address space with constraints. Regions have a number of attributes that
> must be configured before the region can be activated.
>
> The ABI is not meant to be secure, but is meant to avoid accidental
> races. As a result, a buggy process may create a region by name that was
> allocated by a different process. However, multiple processes which are
> trying not to race with each other shouldn't need special
> synchronization to do so.
>
> // Allocate a new region name
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
>
> // Create a new region by name
> echo $region > /sys/bus/cxl/devices/decoder0.0/create_region

Were I someone coming in cold to this the immediate question about
this example would be "what if userspace races to create the region?".
How about showing the example that this interface requires looping
until the kernel returns success in case userspace races itself to
create the next region? I think this would work for that purpose.

---

while
region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
! echo $region > /sys/bus/cxl/devices/decoder0.0/create_region
do true; done

---

> // Region now exists in sysfs
> stat -t /sys/bus/cxl/devices/decoder0.0/$region
>
> // Delete the region, and name
> echo $region > /sys/bus/cxl/devices/decoder0.0/delete_region
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since v2:
> - Rename 'region' variables to 'cxlr'
> - Update ABI docs for possible actual upstream version
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl       |  24 ++
>  .../driver-api/cxl/memory-devices.rst         |  11 +
>  drivers/cxl/core/Makefile                     |   1 +
>  drivers/cxl/core/core.h                       |   3 +
>  drivers/cxl/core/port.c                       |  16 ++
>  drivers/cxl/core/region.c                     | 208 ++++++++++++++++++
>  drivers/cxl/cxl.h                             |   9 +
>  drivers/cxl/region.h                          |  38 ++++
>  tools/testing/cxl/Kbuild                      |   1 +
>  9 files changed, 311 insertions(+)
>  create mode 100644 drivers/cxl/core/region.c
>  create mode 100644 drivers/cxl/region.h
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7c2b846521f3..dcc728458936 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -163,3 +163,27 @@ Description:
>                 memory (type-3). The 'target_type' attribute indicates the
>                 current setting which may dynamically change based on what
>                 memory regions are activated in this decode hierarchy.
> +
> +What:          /sys/bus/cxl/devices/decoderX.Y/create_region
> +Date:          August, 2021

Maybe move this to January, 2022?

> +KernelVersion: v5.18
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +               Creates a new CXL region. Writing a value of the form
> +               "regionX.Y:Z" will create a new uninitialized region that will
> +               be mapped by the CXL decoderX.Y.

"Write a value of the form 'regionX.Y:Z' to instantiate a new region
within the decode range bounded by decoderX.Y."

> +               Reading from this node will
> +               return a newly allocated region name. In order to create a
> +               region (writing) you must use a value returned from reading the
> +               node.

"The value written must match the current value returned from reading
this attribute. This behavior lets the kernel arbitrate racing
attempts to create a region. The thread that fails to write loops and
tries the next value."

> +               subsequently configured and bound to a region driver before they
> +               can be used.
> +
> +What:          /sys/bus/cxl/devices/decoderX.Y/delete_region
> +Date:          August, 2021
> +KernelVersion: v5.18
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +               Deletes the named region. A region must be unbound from the
> +               region driver before being deleted.

....why does it need to be unbound first? device_unregister() triggers
device_release_driver()?

Side note: I am more and more thinking that even though the BIOS may
try to lock some configurations down, if the system owner wants the
region deleted the kernel should probably do everything in its power
to oblige and override the BIOS including secondary bus resets to get
the decoders unlocked. I.e. either the driver needs to hide the delete
region attribute for locked regions, or it needs to give as much power
to root as someone who has physical access and can rip out devices
that are decoding locked ranges. Something we can discuss later, but
every 'disable' and 'delete' interface requires answering the question
"what about 'locked' configs and hot-remove?".

> +               region in the form "regionX.Y:Z". The region's name, allocated
> +               by reading create_region, will also be released.
> diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
> index db476bb170b6..66ddc58a21b1 100644
> --- a/Documentation/driver-api/cxl/memory-devices.rst
> +++ b/Documentation/driver-api/cxl/memory-devices.rst
> @@ -362,6 +362,17 @@ CXL Core
>  .. kernel-doc:: drivers/cxl/core/mbox.c
>     :doc: cxl mbox
>
> +CXL Regions
> +-----------
> +.. kernel-doc:: drivers/cxl/region.h
> +   :identifiers:
> +
> +.. kernel-doc:: drivers/cxl/core/region.c
> +   :doc: cxl core region
> +
> +.. kernel-doc:: drivers/cxl/core/region.c
> +   :identifiers:
> +
>  External Interfaces
>  ===================
>
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 6d37cd78b151..39ce8f2f2373 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -4,6 +4,7 @@ obj-$(CONFIG_CXL_BUS) += cxl_core.o
>  ccflags-y += -I$(srctree)/drivers/cxl
>  cxl_core-y := port.o
>  cxl_core-y += pmem.o
> +cxl_core-y += region.o
>  cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index efbaa851929d..35fd08d560e2 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -10,6 +10,9 @@ extern const struct device_type cxl_memdev_type;
>
>  extern struct attribute_group cxl_base_attribute_group;
>
> +extern struct device_attribute dev_attr_create_region;
> +extern struct device_attribute dev_attr_delete_region;
> +
>  struct cxl_send_command;
>  struct cxl_mem_query_commands;
>  int cxl_query_cmd(struct cxl_memdev *cxlmd,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 631dec0fa79e..0826208b2bdf 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -215,6 +215,8 @@ static struct attribute_group cxl_decoder_base_attribute_group = {
>  };
>
>  static struct attribute *cxl_decoder_root_attrs[] = {
> +       &dev_attr_create_region.attr,
> +       &dev_attr_delete_region.attr,
>         &dev_attr_cap_pmem.attr,
>         &dev_attr_cap_ram.attr,
>         &dev_attr_cap_type2.attr,
> @@ -267,11 +269,23 @@ static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
>         NULL,
>  };
>
> +static int delete_region(struct device *dev, void *arg)
> +{
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> +
> +       return cxl_delete_region(cxld, dev_name(dev));
> +}
> +
>  static void cxl_decoder_release(struct device *dev)
>  {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
>         struct cxl_port *port = to_cxl_port(dev->parent);
>
> +       device_for_each_child(&cxld->dev, cxld, delete_region);

This is too late. Regions should be deleted before the decoder is
unregistered, and I think it happens naturally due to the root port
association with memdevs. I.e. a root decoder is unregistered by its
parent port being unregistered which is triggered by cxl_acpi
->remove(). That ->remove() event triggers all memdevs to disconnect,
albeit in a workqueue. So as long as cxl_acpi ->remove flushes that
workqueue then it knows that all memdevs have triggered ->remove().

If the behavior of a region is that it gets deleted upon the last
memdev being unmapped from it then there should not be any regions to
clean up at decoder release time.

> +
> +       dev_WARN_ONCE(dev, !ida_is_empty(&cxld->region_ida),
> +                     "Lost track of a region");
> +
>         ida_free(&port->decoder_ida, cxld->id);
>         kfree(cxld);
>  }
> @@ -1194,6 +1208,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>         cxld->target_type = CXL_DECODER_EXPANDER;
>         cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
>
> +       ida_init(&cxld->region_ida);
> +
>         return cxld;
>  err:
>         kfree(cxld);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> new file mode 100644
> index 000000000000..1a448543db0d
> --- /dev/null
> +++ b/drivers/cxl/core/region.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */

Happy New Year! Let's go to 2022 here.

> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
> +#include <region.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +/**
> + * DOC: cxl core region
> + *
> + * Regions are managed through the Linux device model. Each region instance is a
> + * unique struct device. CXL core provides functionality to create, destroy, and
> + * configure regions. This is all implemented here. Binding a region
> + * (programming the hardware) is handled by a separate region driver.
> + */

Somewhat information lite, how about:

"CXL Regions represent mapped memory capacity in system physical
address space. Whereas the CXL Root Decoders identify the bounds of
potential CXL Memory ranges, Regions represent the active mapped
capacity by the HDM Decoder Capability structures throughout the Host
Bridges, Switches, and Endpoints in the topology."

> +
> +static void cxl_region_release(struct device *dev);
> +
> +static const struct device_type cxl_region_type = {
> +       .name = "cxl_region",
> +       .release = cxl_region_release,
> +};
> +
> +static ssize_t create_region_show(struct device *dev,
> +                                 struct device_attribute *attr, char *buf)
> +{
> +       struct cxl_port *port = to_cxl_port(dev->parent);
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       int rc;
> +
> +       if (dev_WARN_ONCE(dev, !is_root_decoder(dev),
> +                         "Invalid decoder selected for region.")) {
> +               return -ENODEV;
> +       }

This can go, it's already the case that this attribute is only listed
in 'cxl_decoder_root_attrs'

> +       rc = ida_alloc(&cxld->region_ida, GFP_KERNEL);

This looks broken. What if userspace does:

region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
region=$(cat /sys/bus/cxl/devices/decoder0.0/create_region)
echo $region > /sys/bus/cxl/devices/decoder0.0/create_region

...i.e. it should only advance to create a new name after the previous
one was instantiated / confirmed via a write.

Also, sysfs values are world readable by default, so non-root can burn
up region_ida.

> +       if (rc < 0) {
> +               dev_err(&cxld->dev, "Couldn't get a new id\n");
> +               return rc;
> +       }
> +
> +       return sysfs_emit(buf, "region%d.%d:%d\n", port->id, cxld->id, rc);
> +}
> +
> +static ssize_t create_region_store(struct device *dev,
> +                                  struct device_attribute *attr,
> +                                  const char *buf, size_t len)
> +{
> +       struct cxl_port *port = to_cxl_port(dev->parent);
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       int decoder_id, port_id, region_id;
> +       struct cxl_region *cxlr;
> +       ssize_t rc;
> +
> +       if (sscanf(buf, "region%d.%d:%d", &port_id, &decoder_id, &region_id) != 3)
> +               return -EINVAL;

With the proposed change above to cache the current 'next' region name
this can just be something like:

sysfs_streq(buf, cxld->next);

> +
> +       if (decoder_id != cxld->id)
> +               return -EINVAL;
> +
> +       if (port_id != port->id)
> +               return -EINVAL;
> +
> +       cxlr = cxl_alloc_region(cxld, region_id);
> +       if (IS_ERR(cxlr))
> +               return PTR_ERR(cxlr);
> +
> +       rc = cxl_add_region(cxld, cxlr);
> +       if (rc) {
> +               kfree(cxlr);

...'add' failures usually require a put_device(), are you sure kfree()
is correct here.

> +               return rc;
> +       }
> +
> +       return len;
> +}
> +DEVICE_ATTR_RW(create_region);
> +
> +static ssize_t delete_region_store(struct device *dev,
> +                                  struct device_attribute *attr,
> +                                  const char *buf, size_t len)
> +{
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       int rc;
> +
> +       rc = cxl_delete_region(cxld, buf);

I would have expected symmetry with cxl_add_region() i.e. convert @buf
to @cxlr and keep the function signatures between add and delete
aligned.

> +       if (rc)
> +               return rc;
> +
> +       return len;
> +}
> +DEVICE_ATTR_WO(delete_region);
> +
> +struct cxl_region *to_cxl_region(struct device *dev)
> +{
> +       if (dev_WARN_ONCE(dev, dev->type != &cxl_region_type,
> +                         "not a cxl_region device\n"))
> +               return NULL;
> +
> +       return container_of(dev, struct cxl_region, dev);
> +}
> +EXPORT_SYMBOL_GPL(to_cxl_region);
> +
> +static void cxl_region_release(struct device *dev)
> +{
> +       struct cxl_decoder *cxld = to_cxl_decoder(dev->parent);
> +       struct cxl_region *cxlr = to_cxl_region(dev);
> +
> +       ida_free(&cxld->region_ida, cxlr->id);
> +       kfree(cxlr);
> +}
> +
> +struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld, int id)
> +{
> +       struct cxl_region *cxlr;
> +
> +       cxlr = kzalloc(sizeof(*cxlr), GFP_KERNEL);
> +       if (!cxlr)
> +               return ERR_PTR(-ENOMEM);

To keep symmetry with other device object allocations in the cxl/core
I would expect to see the device_initialize() dev->type and dev->bus
setup occur here as well.

> +
> +       cxlr->id = id;
> +
> +       return cxlr;
> +}
> +
> +/**
> + * cxl_add_region - Adds a region to a decoder
> + * @cxld: Parent decoder.
> + * @cxlr: Region to be added to the decoder.
> + *
> + * This is the second step of region initialization. Regions exist within an
> + * address space which is mapped by a @cxld. That @cxld must be a root decoder,
> + * and it enforces constraints upon the region as it is configured.
> + *
> + * Return: 0 if the region was added to the @cxld, else returns negative error
> + * code. The region will be named "regionX.Y.Z" where X is the port, Y is the
> + * decoder id, and Z is the region number.
> + */
> +int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *cxlr)
> +{
> +       struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +       struct device *dev = &cxlr->dev;
> +       int rc;
> +
> +       device_initialize(dev);
> +       dev->parent = &cxld->dev;
> +       device_set_pm_not_required(dev);
> +       dev->bus = &cxl_bus_type;
> +       dev->type = &cxl_region_type;
> +       rc = dev_set_name(dev, "region%d.%d:%d", port->id, cxld->id, cxlr->id);
> +       if (rc)
> +               goto err;
> +
> +       rc = device_add(dev);
> +       if (rc)
> +               goto err;
> +
> +       dev_dbg(dev, "Added to %s\n", dev_name(&cxld->dev));
> +
> +       return 0;
> +
> +err:
> +       put_device(dev);

Here is that put_device() I was expecting, that kfree() earlier was a
double-free it seems.

Also, I would have expected a devm action to remove this. Something like:

struct cxl_port *port = to_cxl_port(cxld->dev.parent);

cxl_device_lock(&port->dev);
if (port->dev.driver)
    devm_cxl_add_region(port->uport, cxld, id);
else
    rc = -ENXIO;
cxl_device_unlock(&port->dev);

...then no matter what you know the region will be unregistered when
the root port goes away.

> +       return rc;
> +}
> +
> +static struct cxl_region *cxl_find_region_by_name(struct cxl_decoder *cxld,
> +                                                 const char *name)
> +{
> +       struct device *region_dev;
> +
> +       region_dev = device_find_child_by_name(&cxld->dev, name);
> +       if (!region_dev)
> +               return ERR_PTR(-ENOENT);
> +
> +       return to_cxl_region(region_dev);
> +}
> +
> +/**
> + * cxl_delete_region - Deletes a region
> + * @cxld: Parent decoder
> + * @region_name: Named region, ie. regionX.Y:Z
> + */
> +int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
> +{
> +       struct cxl_region *cxlr;
> +
> +       device_lock(&cxld->dev);

cxl_device_lock()

...if the lock is needed, but I don't see why the lock is needed?

> +
> +       cxlr = cxl_find_region_by_name(cxld, region_name);
> +       if (IS_ERR(cxlr)) {
> +               device_unlock(&cxld->dev);
> +               return PTR_ERR(cxlr);
> +       }
> +
> +       dev_dbg(&cxld->dev, "Requested removal of %s from %s\n",
> +               dev_name(&cxlr->dev), dev_name(&cxld->dev));
> +
> +       device_unregister(&cxlr->dev);
> +       device_unlock(&cxld->dev);

This would need to change to devm_release_action() of course if the
add side changes to devm_cxl_add_region().

> +
> +       put_device(&cxlr->dev);
> +
> +       return 0;
> +}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 13fb06849199..b9f0099c1f39 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -221,6 +221,7 @@ enum cxl_decoder_type {
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
>   * @target_lock: coordinate coherent reads of the target list
> + * @region_ida: allocator for region ids.
>   * @nr_targets: number of elements in @target
>   * @target: active ordered target list in current decoder configuration
>   */
> @@ -236,6 +237,7 @@ struct cxl_decoder {
>         enum cxl_decoder_type target_type;
>         unsigned long flags;
>         seqlock_t target_lock;
> +       struct ida region_ida;
>         int nr_targets;
>         struct cxl_dport *target[];
>  };
> @@ -323,6 +325,13 @@ struct cxl_ep {
>         struct list_head list;
>  };
>
> +bool is_cxl_region(struct device *dev);
> +struct cxl_region *to_cxl_region(struct device *dev);
> +struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld,
> +                                   int interleave_ways);
> +int cxl_add_region(struct cxl_decoder *cxld, struct cxl_region *cxlr);
> +int cxl_delete_region(struct cxl_decoder *cxld, const char *region);
> +
>  static inline bool is_cxl_root(struct cxl_port *port)
>  {
>         return port->uport == port->dev.parent;
> diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
> new file mode 100644
> index 000000000000..eb1249e3c1d4
> --- /dev/null
> +++ b/drivers/cxl/region.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2021 Intel Corporation. */
> +#ifndef __CXL_REGION_H__
> +#define __CXL_REGION_H__
> +
> +#include <linux/uuid.h>
> +
> +#include "cxl.h"
> +
> +/**
> + * struct cxl_region - CXL region
> + * @dev: This region's device.
> + * @id: This regions id. Id is globally unique across all regions.

s/regions/region's/

> + * @list: Node in decoder's region list.
> + * @res: Resource this region carves out of the platform decode range.
> + * @config: HDM decoder program config
> + * @config.size: Size of the region determined from LSA or userspace.
> + * @config.uuid: The UUID for this region.
> + * @config.interleave_ways: Number of interleave ways this region is configured for.
> + * @config.interleave_granularity: Interleave granularity of region
> + * @config.targets: The memory devices comprising the region.
> + */
> +struct cxl_region {
> +       struct device dev;
> +       int id;
> +       struct list_head list;
> +       struct resource *res;
> +
> +       struct {
> +               u64 size;
> +               uuid_t uuid;
> +               int interleave_ways;
> +               int interleave_granularity;
> +               struct cxl_memdev *targets[CXL_DECODER_MAX_INTERLEAVE];
> +       } config;

Why a sub-struct?

> +};
> +
> +#endif
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 82e49ab0937d..3fe6d34e6d59 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -46,6 +46,7 @@ cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o
>  cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> +cxl_core-y += $(CXL_CORE_SRC)/region.o
>  cxl_core-y += config_check.o
>
>  obj-m += test/
> --
> 2.35.0
>
