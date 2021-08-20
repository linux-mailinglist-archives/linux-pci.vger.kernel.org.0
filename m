Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9BF93F321B
	for <lists+linux-pci@lfdr.de>; Fri, 20 Aug 2021 19:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbhHTRQo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Aug 2021 13:16:44 -0400
Received: from out0.migadu.com ([94.23.1.103]:18748 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232240AbhHTRQl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 13:16:41 -0400
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1629479761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/um8cGImJu7UaKiwo05KQmx0tqr9Tudb/l1VOAYosQc=;
        b=i0WO3+jnw6j/EAdfH6hi8Xx8tV6SwX8P4JaPWMFvOLnqW6Szh6bKF00dta7rIdhcG6PiT8
        T0oArjZQL0P6HREbCWlxsE9ArkRifMcSeZSPepeBnaVsYM/nYji24ikaPrzTeYzTNaesLd
        oVDjKWbYKvnsoR1uuWFxhRsk5CgC1pM=
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [PATCH] PCI: VMD: ACPI: Make ACPI companion lookup work for VMD bus
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jon Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <11834551.O9o76ZdvQC@kreacher>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Wendy Wang <wendy.wang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        David Box <david.e.box@linux.intel.com>
Date:   Fri, 20 Aug 2021 12:15:57 -0500
Message-Id: <97334947-BE92-4A9C-839E-5A789F431553@linux.dev>
References: <11834551.O9o76ZdvQC@kreacher>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: jonathan.derrick@linux.dev
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> On Aug 20, 2021, at 11:12 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:=

>=20
> =EF=BB=BFFrom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>=20
> On some systems, in order to get to the deepest low-power state of
> the platform (which may be necessary to save significant enough
> amounts of energy while suspended to idle. for example), devices on
> the PCI bus exposed by the VMD driver need to be power-managed via
> ACPI.  However, the layout of the ACPI namespace below the VMD
> controller device object does not reflect the layout of the PCI bus
> under the VMD host bridge, so in order to identify the ACPI companion
> objects for the devices on that bus, it is necessary to use a special
> _ADR encoding on the ACPI side.  In other words, acpi_pci_find_companion()=

> does not work for these devices, so it needs to be amended with a
> special lookup logic specific to the VMD bus.
>=20
> Address this issue by allowing the VMD driver to temporarily install
> an ACPI companion lookup hook containing the code matching the devices
> on the VMD PCI bus with the corresponding objects in the ACPI
> namespace.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Tested-by: Wendy Wang <wendy.wang@intel.com>
> ---
> drivers/pci/controller/vmd.c |   48 ++++++++++++++++++++++++++
> drivers/pci/host-bridge.c    |    1=20
> drivers/pci/pci-acpi.c       |   78 ++++++++++++++++++++++++++++++++++++++=
+++++
> include/linux/pci-acpi.h     |    3 +
> 4 files changed, 130 insertions(+)
>=20
> Index: linux-pm/drivers/pci/controller/vmd.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pci/controller/vmd.c
> +++ linux-pm/drivers/pci/controller/vmd.c
> @@ -11,6 +11,7 @@
> #include <linux/module.h>
> #include <linux/msi.h>
> #include <linux/pci.h>
> +#include <linux/pci-acpi.h>
> #include <linux/pci-ecam.h>
> #include <linux/srcu.h>
> #include <linux/rculist.h>
> @@ -447,6 +448,49 @@ static struct pci_ops vmd_ops =3D {
>   .write        =3D vmd_pci_write,
> };
>=20
> +#ifdef CONFIG_ACPI
> +static struct acpi_device *vmd_acpi_find_companion(struct pci_dev *pci_de=
v)
> +{
> +    struct pci_host_bridge *bridge;
> +    u32 busnr, addr;
> +
> +    if (pci_dev->bus->ops !=3D &vmd_ops)
> +        return NULL;
Can we use is_vmd(pci_dev->bus)?

> +
> +    bridge =3D pci_find_host_bridge(pci_dev->bus);
> +    busnr =3D pci_dev->bus->number - bridge->bus->number;
This is just the bus->number - vmd->busn_start, correct?


> +    addr =3D (busnr << 24) | ((u32)pci_dev->devfn << 16) | 0x8000FFFFU;
So the descriptor assumes busnr < 128 and requires an appropriately sized CFG=
BAR. Client is typically limited to 32 sub device buses but I=E2=80=99m not c=
ertain if enterprise will ever need > 128 (256 is allowed).

> +
> +    dev_dbg(&pci_dev->dev, "Looking for ACPI companion (address 0x%x)\n",=

> +        addr);
> +
> +    return acpi_find_child_device(ACPI_COMPANION(bridge->dev.parent), add=
r,
> +                      false);
> +}
> +
> +static bool hook_installed;
> +
> +static void vmd_acpi_begin(void)
> +{
> +    if (pci_acpi_set_companion_lookup_hook(vmd_acpi_find_companion))
> +        return;
> +
> +    hook_installed =3D true;
> +}
> +
> +static void vmd_acpi_end(void)
> +{
> +    if (!hook_installed)
> +        return;
> +
> +    pci_acpi_clear_companion_lookup_hook();
> +    hook_installed =3D false;
> +}
> +#else
> +static inline void vmd_acpi_begin(void) { }
> +static inline void vmd_acpi_end(void) { }
> +#endif /* CONFIG_ACPI */
> +
> static void vmd_attach_resources(struct vmd_dev *vmd)
> {
>   vmd->dev->resource[VMD_MEMBAR1].child =3D &vmd->resources[1];
> @@ -747,6 +791,8 @@ static int vmd_enable_domain(struct vmd_
>   if (vmd->irq_domain)
>       dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
>=20
> +    vmd_acpi_begin();
> +
>   pci_scan_child_bus(vmd->bus);
>   pci_assign_unassigned_bus_resources(vmd->bus);
>=20
> @@ -760,6 +806,8 @@ static int vmd_enable_domain(struct vmd_
>=20
>   pci_bus_add_devices(vmd->bus);
>=20
> +    vmd_acpi_end();
> +
>   WARN(sysfs_create_link(&vmd->dev->dev.kobj, &vmd->bus->dev.kobj,
>                  "domain"), "Can't create symlink to domain\n");
>   return 0;
> Index: linux-pm/drivers/pci/host-bridge.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pci/host-bridge.c
> +++ linux-pm/drivers/pci/host-bridge.c
> @@ -23,6 +23,7 @@ struct pci_host_bridge *pci_find_host_br
>=20
>   return to_pci_host_bridge(root_bus->bridge);
> }
> +EXPORT_SYMBOL_GPL(pci_find_host_bridge);
>=20
> struct device *pci_get_host_bridge_device(struct pci_dev *dev)
> {
> Index: linux-pm/drivers/pci/pci-acpi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/drivers/pci/pci-acpi.c
> +++ linux-pm/drivers/pci/pci-acpi.c
> @@ -1159,6 +1159,72 @@ void acpi_pci_remove_bus(struct pci_bus
> }
>=20
> /* ACPI bus type */
> +
> +
> +DEFINE_STATIC_KEY_FALSE(pci_acpi_companion_lookup_key);
> +static DEFINE_MUTEX(pci_acpi_companion_lookup_mtx);
> +static struct acpi_device *(*pci_acpi_find_companion_hook)(struct pci_dev=
 *);
Wouldn=E2=80=99t a hook list be a better structure? Or is that too heavy han=
ded for the purpose?

> +
> +/**
> + * pci_acpi_set_companion_lookup_hook - Set ACPI companion lookup callbac=
k.
> + * @func: ACPI companion lookup callback pointer or NULL.
> + *
> + * Set a special ACPI companion lookup callback for PCI devices whose com=
panion
> + * objects in the ACPI namespace have _ADR with non-standard bus-device-f=
unction
> + * encodings.
> + *
> + * Return 0 on success or a negative error code on failure (in which case=
 no
> + * changes are made).
> + *
> + * The caller is responsible for the appropriate ordering of the invocati=
ons of
> + * this function with respect to the enumeration of the PCI devices needi=
ng the
> + * callback installed by it.
> + */
> +int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct=
 pci_dev *))
> +{
> +    int ret;
> +
> +    if (!func)
> +        return -EINVAL;
> +
> +    mutex_lock(&pci_acpi_companion_lookup_mtx);
> +
> +    if (pci_acpi_find_companion_hook) {
> +        ret =3D -EBUSY;
> +    } else {
> +        pci_acpi_find_companion_hook =3D func;
> +        static_branch_enable(&pci_acpi_companion_lookup_key);
> +        ret =3D 0;
> +    }
> +
> +    mutex_unlock(&pci_acpi_companion_lookup_mtx);
> +
> +    return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_set_companion_lookup_hook);
> +
> +/**
> + * pci_acpi_clear_companion_lookup_hook - Clear ACPI companion lookup cal=
lback.
> + *
> + * Clear the special ACPI companion lookup callback previously set by
> + * pci_acpi_set_companion_lookup_hook().  Block until the last running in=
stance
> + * of the callback returns before clearing it.
> + *
> + * The caller is responsible for the appropriate ordering of the invocati=
ons of
> + * this function with respect to the enumeration of the PCI devices needi=
ng the
> + * callback cleared by it.
> + */
> +void pci_acpi_clear_companion_lookup_hook(void)
> +{
> +    mutex_lock(&pci_acpi_companion_lookup_mtx);
> +
> +    pci_acpi_find_companion_hook =3D NULL;
> +    static_branch_disable(&pci_acpi_companion_lookup_key);
> +
> +    mutex_unlock(&pci_acpi_companion_lookup_mtx);
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_clear_companion_lookup_hook);
> +
> static struct acpi_device *acpi_pci_find_companion(struct device *dev)
> {
>   struct pci_dev *pci_dev =3D to_pci_dev(dev);
> @@ -1166,6 +1232,18 @@ static struct acpi_device *acpi_pci_find
>   bool check_children;
>   u64 addr;
>=20
> +    if (static_branch_unlikely(&pci_acpi_companion_lookup_key)) {
> +        mutex_lock(&pci_acpi_companion_lookup_mtx);
> +
> +        adev =3D pci_acpi_find_companion_hook ?
> +            pci_acpi_find_companion_hook(pci_dev) : NULL;
> +
> +        mutex_unlock(&pci_acpi_companion_lookup_mtx);
> +
> +        if (adev)
> +            return adev;
> +    }
> +
>   check_children =3D pci_is_bridge(pci_dev);
>   /* Please ref to ACPI spec for the syntax of _ADR */
>   addr =3D (PCI_SLOT(pci_dev->devfn) << 16) | PCI_FUNC(pci_dev->devfn);
> Index: linux-pm/include/linux/pci-acpi.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-pm.orig/include/linux/pci-acpi.h
> +++ linux-pm/include/linux/pci-acpi.h
> @@ -122,6 +122,9 @@ static inline void pci_acpi_add_edr_noti
> static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
> #endif /* CONFIG_PCIE_EDR */
>=20
> +int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct=
 pci_dev *));
> +void pci_acpi_clear_companion_lookup_hook(void);
> +
> #else    /* CONFIG_ACPI */
> static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
