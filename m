Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1C339DC5C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhFGM3p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 08:29:45 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:46917 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhFGM3p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 08:29:45 -0400
Received: by mail-ot1-f54.google.com with SMTP id 66-20020a9d02c80000b02903615edf7c1aso16454751otl.13;
        Mon, 07 Jun 2021 05:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPQe+hdgcprD1EduTo3WZSqMf4DmiJ01RfeTehXxcCo=;
        b=Iexpt2P7qHm1/bGs8biFjQaTmkSMkJFoF4AIJC7emjBe55mPwN6B9v8MXzQmM9BSbG
         8HTZChTanoH3JaNWOzD7d/3SbkjfmcmP0H1ZFIDvxju/sUHhuVNg+fcz9M/o/FV/nhyv
         vldSYNx6Neml78kFtVETcnlhcZ0/R9n0E1pu4oV+owqCWL8wG/OQn024bSFD7ltowA9O
         bruojOzK+YOV8o/YOwqluNCC+VO97AAtKiwkEpanS/6VUzIJ3M2jzWYoBgeI5Kv7AxQk
         o+bjKeSARA1ECnbel+GOqMfn4Ax2Q/QhHy1NBR6k4tEYnr58OOOiGz4KAdQypQ1OTyjZ
         qKEA==
X-Gm-Message-State: AOAM531Ya+SYT8oDLh3DmUF8cN2If/F+Y9D2fy1c30WEs7D2cZhViRKL
        U50kaV5Gqhjt2hvT1NZoafcMI+55zeWYwxFaSP4=
X-Google-Smtp-Source: ABdhPJyOsDN+ZFBEhBk2s+InrkvIX7iQzter0VTBRaGXhdaMa1ryQZjQbmjxsxu67CjRpu6UxYUj3Mb6CMUkq+we84w=
X-Received: by 2002:a9d:3e53:: with SMTP id h19mr13392995otg.260.1623068873549;
 Mon, 07 Jun 2021 05:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295950449.1109360.5228772194963187441.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162295950449.1109360.5228772194963187441.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:27:42 +0200
Message-ID: <CAJZ5v0gN5-Q2_=p0_6gjjX7tpBMFY-YLy8J9TnAAi9a3Eo4CbQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] cxl/acpi: Introduce cxl_root, the root of a
 cxl_port topology
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 6, 2021 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> While CXL builds upon the PCI software model for enumeration and
> endpoint control, a static platform component is required to bootstrap
> the CXL memory layout. Similar to how ACPI identifies root-level PCI
> memory resources the ACPI identifies the address space and interleave
> configuration for CXL Memory.
>
> In addition to identifying the host bridges, ACPI is responsible for
> enumerating the CXL memory space that can be addressed by downstream
> decoders. This is similar to the requirement for ACPI to publish
> resources reported by _CRS for PCI host bridges. Specifically ACPI
> publishes a table, CXL Early Discovery Table (CEDT), which includes a
> list of CXL Memory resource, CXL Fixed Memory Window Structures (CFMWS).
>
> For now introduce the core infrastructure for a cxl_port hierarchy
> starting with a root level anchor represented by the ACPI0017 device.
>
> Follow on changes model support for the configurable decode capabilities
> of cxl_port instances.
>
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

From the ACPI perspective:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   11 ++
>  drivers/cxl/Kconfig                     |   15 +++
>  drivers/cxl/Makefile                    |    2
>  drivers/cxl/acpi.c                      |   39 ++++++++
>  drivers/cxl/core.c                      |  160 +++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h                       |   23 ++++
>  6 files changed, 250 insertions(+)
>  create mode 100644 drivers/cxl/acpi.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 2fe7490ad6a8..fb996ced7629 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -24,3 +24,14 @@ Description:
>                 (RO) "Persistent Only Capacity" as bytes. Represents the
>                 identically named field in the Identify Memory Device Output
>                 Payload in the CXL-2.0 specification.
> +
> +What:          /sys/bus/cxl/devices/portX/uport
> +Date:          May, 2021
> +KernelVersion: v5.14
> +Contact:       linux-cxl@vger.kernel.org
> +Description:
> +               CXL port objects are enumerated from either a platform firmware
> +               device (ACPI0017 and ACPI0016) or PCIe switch upstream port with
> +               CXL component registers. The 'uport' symlink connects the CXL
> +               portX object to the device that published the CXL port
> +               capability.
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 5483ba92b6da..d2573f6aef91 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -45,4 +45,19 @@ config CXL_MEM_RAW_COMMANDS
>           potential impact to memory currently in use by the kernel.
>
>           If developing CXL hardware or the driver say Y, otherwise say N.
> +
> +config CXL_ACPI
> +       tristate "CXL ACPI: Platform Support"
> +       depends on ACPI
> +       help
> +         Enable support for host managed device memory (HDM) resources
> +         published by a platform's ACPI CXL memory layout description.  See
> +         Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL 2.0
> +         specification, and CXL Fixed Memory Window Structures (CEDT.CFMWS)
> +         (https://www.computeexpresslink.org/spec-landing). The CXL core
> +         consumes these resource to publish the root of a cxl_port decode
> +         hierarchy to map regions that represent System RAM, or Persistent
> +         Memory regions to be managed by LIBNVDIMM.
> +
> +         If unsure say 'm'.
>  endif
> diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
> index d9d282dc15be..a29efb3e8ad2 100644
> --- a/drivers/cxl/Makefile
> +++ b/drivers/cxl/Makefile
> @@ -1,7 +1,9 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_CXL_BUS) += cxl_core.o
>  obj-$(CONFIG_CXL_MEM) += cxl_pci.o
> +obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
>
>  ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
>  cxl_core-y := core.o
>  cxl_pci-y := pci.o
> +cxl_acpi-y := acpi.o
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> new file mode 100644
> index 000000000000..556d25ab6966
> --- /dev/null
> +++ b/drivers/cxl/acpi.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include "cxl.h"
> +
> +static int cxl_acpi_probe(struct platform_device *pdev)
> +{
> +       struct cxl_port *root_port;
> +       struct device *host = &pdev->dev;
> +
> +       root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> +       if (IS_ERR(root_port))
> +               return PTR_ERR(root_port);
> +       dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> +
> +       return 0;
> +}
> +
> +static const struct acpi_device_id cxl_acpi_ids[] = {
> +       { "ACPI0017", 0 },
> +       { "", 0 },
> +};
> +MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
> +
> +static struct platform_driver cxl_acpi_driver = {
> +       .probe = cxl_acpi_probe,
> +       .driver = {
> +               .name = KBUILD_MODNAME,
> +               .acpi_match_table = cxl_acpi_ids,
> +       },
> +};
> +
> +module_platform_driver(cxl_acpi_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 853666d8a9f5..dbbb34618d7d 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -4,6 +4,8 @@
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> +#include <linux/slab.h>
> +#include <linux/idr.h>
>  #include "cxl.h"
>
>  /**
> @@ -13,6 +15,164 @@
>   * point for cross-device interleave coordination through cxl ports.
>   */
>
> +static DEFINE_IDA(cxl_port_ida);
> +
> +static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
> +                           char *buf)
> +{
> +       return sysfs_emit(buf, "%s\n", dev->type->name);
> +}
> +static DEVICE_ATTR_RO(devtype);
> +
> +static struct attribute *cxl_base_attributes[] = {
> +       &dev_attr_devtype.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group cxl_base_attribute_group = {
> +       .attrs = cxl_base_attributes,
> +};
> +
> +static void cxl_port_release(struct device *dev)
> +{
> +       struct cxl_port *port = to_cxl_port(dev);
> +
> +       ida_free(&cxl_port_ida, port->id);
> +       kfree(port);
> +}
> +
> +static const struct attribute_group *cxl_port_attribute_groups[] = {
> +       &cxl_base_attribute_group,
> +       NULL,
> +};
> +
> +static const struct device_type cxl_port_type = {
> +       .name = "cxl_port",
> +       .release = cxl_port_release,
> +       .groups = cxl_port_attribute_groups,
> +};
> +
> +struct cxl_port *to_cxl_port(struct device *dev)
> +{
> +       if (dev_WARN_ONCE(dev, dev->type != &cxl_port_type,
> +                         "not a cxl_port device\n"))
> +               return NULL;
> +       return container_of(dev, struct cxl_port, dev);
> +}
> +
> +static void unregister_dev(void *dev)
> +{
> +       device_unregister(dev);
> +}
> +
> +static void cxl_unlink_uport(void *_port)
> +{
> +       struct cxl_port *port = _port;
> +
> +       sysfs_remove_link(&port->dev.kobj, "uport");
> +}
> +
> +static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
> +{
> +       int rc;
> +
> +       rc = sysfs_create_link(&port->dev.kobj, &port->uport->kobj, "uport");
> +       if (rc)
> +               return rc;
> +       return devm_add_action_or_reset(host, cxl_unlink_uport, port);
> +}
> +
> +static struct cxl_port *cxl_port_alloc(struct device *uport,
> +                                      resource_size_t component_reg_phys,
> +                                      struct cxl_port *parent_port)
> +{
> +       struct cxl_port *port;
> +       struct device *dev;
> +       int rc;
> +
> +       port = kzalloc(sizeof(*port), GFP_KERNEL);
> +       if (!port)
> +               return ERR_PTR(-ENOMEM);
> +
> +       rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
> +       if (rc < 0)
> +               goto err;
> +       port->id = rc;
> +
> +       /*
> +        * The top-level cxl_port "cxl_root" does not have a cxl_port as
> +        * its parent and it does not have any corresponding component
> +        * registers as its decode is described by a fixed platform
> +        * description.
> +        */
> +       dev = &port->dev;
> +       if (parent_port)
> +               dev->parent = &parent_port->dev;
> +       else
> +               dev->parent = uport;
> +
> +       port->uport = uport;
> +       port->component_reg_phys = component_reg_phys;
> +
> +       device_initialize(dev);
> +       device_set_pm_not_required(dev);
> +       dev->bus = &cxl_bus_type;
> +       dev->type = &cxl_port_type;
> +
> +       return port;
> +
> +err:
> +       kfree(port);
> +       return ERR_PTR(rc);
> +}
> +
> +/**
> + * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
> + * @host: host device for devm operations
> + * @uport: "physical" device implementing this upstream port
> + * @component_reg_phys: (optional) for configurable cxl_port instances
> + * @parent_port: next hop up in the CXL memory decode hierarchy
> + */
> +struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +                                  resource_size_t component_reg_phys,
> +                                  struct cxl_port *parent_port)
> +{
> +       struct cxl_port *port;
> +       struct device *dev;
> +       int rc;
> +
> +       port = cxl_port_alloc(uport, component_reg_phys, parent_port);
> +       if (IS_ERR(port))
> +               return port;
> +
> +       dev = &port->dev;
> +       if (parent_port)
> +               rc = dev_set_name(dev, "port%d", port->id);
> +       else
> +               rc = dev_set_name(dev, "root%d", port->id);
> +       if (rc)
> +               goto err;
> +
> +       rc = device_add(dev);
> +       if (rc)
> +               goto err;
> +
> +       rc = devm_add_action_or_reset(host, unregister_dev, dev);
> +       if (rc)
> +               return ERR_PTR(rc);
> +
> +       rc = devm_cxl_link_uport(host, port);
> +       if (rc)
> +               return ERR_PTR(rc);
> +
> +       return port;
> +
> +err:
> +       put_device(dev);
> +       return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_GPL(devm_cxl_add_port);
> +
>  /**
>   * cxl_probe_component_regs() - Detect CXL Component register blocks
>   * @dev: Host device of the @base mapping
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2c47e9cffd44..46c81165c210 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -145,5 +145,28 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>                         struct cxl_device_regs *regs,
>                         struct cxl_register_map *map);
>
> +#define CXL_RESOURCE_NONE ((resource_size_t) -1)
> +
> +/**
> + * struct cxl_port - logical collection of upstream port devices and
> + *                  downstream port devices to construct a CXL memory
> + *                  decode hierarchy.
> + * @dev: this port's device
> + * @uport: PCI or platform device implementing the upstream port capability
> + * @id: id for port device-name
> + * @component_regs_phys: component register capability base address (optional)
> + */
> +struct cxl_port {
> +       struct device dev;
> +       struct device *uport;
> +       int id;
> +       resource_size_t component_reg_phys;
> +};
> +
> +struct cxl_port *to_cxl_port(struct device *dev);
> +struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +                                  resource_size_t component_reg_phys,
> +                                  struct cxl_port *parent_port);
> +
>  extern struct bus_type cxl_bus_type;
>  #endif /* __CXL_H__ */
>
