Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B23F3391
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbhHTSYh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 20 Aug 2021 14:24:37 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:42497 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbhHTSYW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Aug 2021 14:24:22 -0400
Received: by mail-ot1-f44.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so15800744otk.9;
        Fri, 20 Aug 2021 11:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pFJ+Gb9ZsPjVbe6cqhZLnx6QI8ngTVhG0+BL+TVZ0+0=;
        b=Xk81l9/b4s7qPHBFM6Ipk8ElGIrZ2LRUXUGKGlWnRhf0BSTTvXBN99vAN5/tESJJXb
         IfwX+goh+vQLxSKtb3t+9QjI29CVPjHuolOjzl7WTpJ6Y2u5LMsOADYZTebfgsFOJjMX
         YYTWr11+cKNy9B727FDV5bsrzAlaiaRCyrYpeNgb5E7LDT6laP+zORqsXdquNcHyfIN8
         e8lBa3IkkC7zm7/hkb2SjgUKkkKJiFv95T/Sycxs1YRFYGa9em8era/OYpLnkl1Pi945
         vl5MFCFlP3LyaBGAmqXlqeIwjWHy5SQchRljq4LE119Xsrvq4wwFnDOg60hPobs8i8k0
         Zhdg==
X-Gm-Message-State: AOAM532lzxI1MNyTUtBhDTZ4hQN/dgDCW1cc66ZKu2EetmuWvqyxzmIQ
        Kk/iTeHF1BirDGTU+fGi+JEMQpMQ84GIxaeyaOQ=
X-Google-Smtp-Source: ABdhPJzep2zIdswm9VSgCpBnJM7vUsJIkKq9qWmAjd1tkMuwBNWLgzByr9Nfgf1QpvnTzodAEu0NKTuhzPJaYm9+/XE=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr4066023oie.71.1629483823426;
 Fri, 20 Aug 2021 11:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <11834551.O9o76ZdvQC@kreacher> <97334947-BE92-4A9C-839E-5A789F431553@linux.dev>
In-Reply-To: <97334947-BE92-4A9C-839E-5A789F431553@linux.dev>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Aug 2021 20:23:32 +0200
Message-ID: <CAJZ5v0gr6qxuJh7AHU=4zUGZeVDRHfmVk2nagWM8aynY6qJNrg@mail.gmail.com>
Subject: Re: [PATCH] PCI: VMD: ACPI: Make ACPI companion lookup work for VMD bus
To:     Jon Derrick <jonathan.derrick@linux.dev>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Box <david.e.box@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 20, 2021 at 7:16 PM Jon Derrick <jonathan.derrick@linux.dev> wrote:
>
>
>
> > On Aug 20, 2021, at 11:12 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > ﻿From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > On some systems, in order to get to the deepest low-power state of
> > the platform (which may be necessary to save significant enough
> > amounts of energy while suspended to idle. for example), devices on
> > the PCI bus exposed by the VMD driver need to be power-managed via
> > ACPI.  However, the layout of the ACPI namespace below the VMD
> > controller device object does not reflect the layout of the PCI bus
> > under the VMD host bridge, so in order to identify the ACPI companion
> > objects for the devices on that bus, it is necessary to use a special
> > _ADR encoding on the ACPI side.  In other words, acpi_pci_find_companion()
> > does not work for these devices, so it needs to be amended with a
> > special lookup logic specific to the VMD bus.
> >
> > Address this issue by allowing the VMD driver to temporarily install
> > an ACPI companion lookup hook containing the code matching the devices
> > on the VMD PCI bus with the corresponding objects in the ACPI
> > namespace.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Tested-by: Wendy Wang <wendy.wang@intel.com>
> > ---
> > drivers/pci/controller/vmd.c |   48 ++++++++++++++++++++++++++
> > drivers/pci/host-bridge.c    |    1
> > drivers/pci/pci-acpi.c       |   78 +++++++++++++++++++++++++++++++++++++++++++
> > include/linux/pci-acpi.h     |    3 +
> > 4 files changed, 130 insertions(+)
> >
> > Index: linux-pm/drivers/pci/controller/vmd.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/controller/vmd.c
> > +++ linux-pm/drivers/pci/controller/vmd.c
> > @@ -11,6 +11,7 @@
> > #include <linux/module.h>
> > #include <linux/msi.h>
> > #include <linux/pci.h>
> > +#include <linux/pci-acpi.h>
> > #include <linux/pci-ecam.h>
> > #include <linux/srcu.h>
> > #include <linux/rculist.h>
> > @@ -447,6 +448,49 @@ static struct pci_ops vmd_ops = {
> >   .write        = vmd_pci_write,
> > };
> >
> > +#ifdef CONFIG_ACPI
> > +static struct acpi_device *vmd_acpi_find_companion(struct pci_dev *pci_dev)
> > +{
> > +    struct pci_host_bridge *bridge;
> > +    u32 busnr, addr;
> > +
> > +    if (pci_dev->bus->ops != &vmd_ops)
> > +        return NULL;
> Can we use is_vmd(pci_dev->bus)?

Sure.

> > +
> > +    bridge = pci_find_host_bridge(pci_dev->bus);
> > +    busnr = pci_dev->bus->number - bridge->bus->number;
> This is just the bus->number - vmd->busn_start, correct?

Yes, it is, but vmd is not known here AFAICS.

>
> > +    addr = (busnr << 24) | ((u32)pci_dev->devfn << 16) | 0x8000FFFFU;
> So the descriptor assumes busnr < 128 and requires an appropriately sized CFGBAR. Client is typically limited to 32 sub device buses but I’m not certain if enterprise will ever need > 128 (256 is allowed).

It actually assumes busnr < 32.

Well, that's what the formula is, but I need to return NULL if > 31.

I'm not expecting the ACPI objects to be present on servers even.

> > +
> > +    dev_dbg(&pci_dev->dev, "Looking for ACPI companion (address 0x%x)\n",
> > +        addr);
> > +
> > +    return acpi_find_child_device(ACPI_COMPANION(bridge->dev.parent), addr,
> > +                      false);
> > +}
> > +
> > +static bool hook_installed;
> > +
> > +static void vmd_acpi_begin(void)
> > +{
> > +    if (pci_acpi_set_companion_lookup_hook(vmd_acpi_find_companion))
> > +        return;
> > +
> > +    hook_installed = true;
> > +}
> > +
> > +static void vmd_acpi_end(void)
> > +{
> > +    if (!hook_installed)
> > +        return;
> > +
> > +    pci_acpi_clear_companion_lookup_hook();
> > +    hook_installed = false;
> > +}
> > +#else
> > +static inline void vmd_acpi_begin(void) { }
> > +static inline void vmd_acpi_end(void) { }
> > +#endif /* CONFIG_ACPI */
> > +
> > static void vmd_attach_resources(struct vmd_dev *vmd)
> > {
> >   vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
> > @@ -747,6 +791,8 @@ static int vmd_enable_domain(struct vmd_
> >   if (vmd->irq_domain)
> >       dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
> >
> > +    vmd_acpi_begin();
> > +
> >   pci_scan_child_bus(vmd->bus);
> >   pci_assign_unassigned_bus_resources(vmd->bus);
> >
> > @@ -760,6 +806,8 @@ static int vmd_enable_domain(struct vmd_
> >
> >   pci_bus_add_devices(vmd->bus);
> >
> > +    vmd_acpi_end();
> > +
> >   WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
> >                  "domain"), "Can't create symlink to domain\n");
> >   return 0;
> > Index: linux-pm/drivers/pci/host-bridge.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/host-bridge.c
> > +++ linux-pm/drivers/pci/host-bridge.c
> > @@ -23,6 +23,7 @@ struct pci_host_bridge *pci_find_host_br
> >
> >   return to_pci_host_bridge(root_bus->bridge);
> > }
> > +EXPORT_SYMBOL_GPL(pci_find_host_bridge);
> >
> > struct device *pci_get_host_bridge_device(struct pci_dev *dev)
> > {
> > Index: linux-pm/drivers/pci/pci-acpi.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pci-acpi.c
> > +++ linux-pm/drivers/pci/pci-acpi.c
> > @@ -1159,6 +1159,72 @@ void acpi_pci_remove_bus(struct pci_bus
> > }
> >
> > /* ACPI bus type */
> > +
> > +
> > +DEFINE_STATIC_KEY_FALSE(pci_acpi_companion_lookup_key);
> > +static DEFINE_MUTEX(pci_acpi_companion_lookup_mtx);
> > +static struct acpi_device *(*pci_acpi_find_companion_hook)(struct pci_dev *);
> Wouldn’t a hook list be a better structure? Or is that too heavy handed for the purpose?

It might, but would that list ever contain more than 1 entry?  If not,
then it would be a redundant complication IMO.

> > +
> > +/**
> > + * pci_acpi_set_companion_lookup_hook - Set ACPI companion lookup callback.
> > + * @func: ACPI companion lookup callback pointer or NULL.
> > + *
> > + * Set a special ACPI companion lookup callback for PCI devices whose companion
> > + * objects in the ACPI namespace have _ADR with non-standard bus-device-function
> > + * encodings.
> > + *
> > + * Return 0 on success or a negative error code on failure (in which case no
> > + * changes are made).
> > + *
> > + * The caller is responsible for the appropriate ordering of the invocations of
> > + * this function with respect to the enumeration of the PCI devices needing the
> > + * callback installed by it.
> > + */
> > +int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *))
> > +{
> > +    int ret;
> > +
> > +    if (!func)
> > +        return -EINVAL;
> > +
> > +    mutex_lock(&pci_acpi_companion_lookup_mtx);
> > +
> > +    if (pci_acpi_find_companion_hook) {
> > +        ret = -EBUSY;
> > +    } else {
> > +        pci_acpi_find_companion_hook = func;
> > +        static_branch_enable(&pci_acpi_companion_lookup_key);
> > +        ret = 0;
> > +    }
> > +
> > +    mutex_unlock(&pci_acpi_companion_lookup_mtx);
> > +
> > +    return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pci_acpi_set_companion_lookup_hook);
> > +
> > +/**
> > + * pci_acpi_clear_companion_lookup_hook - Clear ACPI companion lookup callback.
> > + *
> > + * Clear the special ACPI companion lookup callback previously set by
> > + * pci_acpi_set_companion_lookup_hook().  Block until the last running instance
> > + * of the callback returns before clearing it.
> > + *
> > + * The caller is responsible for the appropriate ordering of the invocations of
> > + * this function with respect to the enumeration of the PCI devices needing the
> > + * callback cleared by it.
> > + */
> > +void pci_acpi_clear_companion_lookup_hook(void)
> > +{
> > +    mutex_lock(&pci_acpi_companion_lookup_mtx);
> > +
> > +    pci_acpi_find_companion_hook = NULL;
> > +    static_branch_disable(&pci_acpi_companion_lookup_key);
> > +
> > +    mutex_unlock(&pci_acpi_companion_lookup_mtx);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_acpi_clear_companion_lookup_hook);
> > +
> > static struct acpi_device *acpi_pci_find_companion(struct device *dev)
> > {
> >   struct pci_dev *pci_dev = to_pci_dev(dev);
> > @@ -1166,6 +1232,18 @@ static struct acpi_device *acpi_pci_find
> >   bool check_children;
> >   u64 addr;
> >
> > +    if (static_branch_unlikely(&pci_acpi_companion_lookup_key)) {
> > +        mutex_lock(&pci_acpi_companion_lookup_mtx);
> > +
> > +        adev = pci_acpi_find_companion_hook ?
> > +            pci_acpi_find_companion_hook(pci_dev) : NULL;
> > +
> > +        mutex_unlock(&pci_acpi_companion_lookup_mtx);
> > +
> > +        if (adev)
> > +            return adev;
> > +    }
> > +
> >   check_children = pci_is_bridge(pci_dev);
> >   /* Please ref to ACPI spec for the syntax of _ADR */
> >   addr = (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> > Index: linux-pm/include/linux/pci-acpi.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/pci-acpi.h
> > +++ linux-pm/include/linux/pci-acpi.h
> > @@ -122,6 +122,9 @@ static inline void pci_acpi_add_edr_noti
> > static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
> > #endif /* CONFIG_PCIE_EDR */
> >
> > +int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
> > +void pci_acpi_clear_companion_lookup_hook(void);
> > +
> > #else    /* CONFIG_ACPI */
> > static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> > static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
