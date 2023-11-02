Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D507DEB71
	for <lists+linux-pci@lfdr.de>; Thu,  2 Nov 2023 04:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjKBDiH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Nov 2023 23:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjKBDiG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Nov 2023 23:38:06 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7629F
        for <linux-pci@vger.kernel.org>; Wed,  1 Nov 2023 20:38:03 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-49d0ae5eb7bso220672e0c.0
        for <linux-pci@vger.kernel.org>; Wed, 01 Nov 2023 20:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698896282; x=1699501082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2HYB5MQFKIRkO0DflYcFCKWn7p/ZGUrpfZG5KxyE7I=;
        b=GldD5xAVrNpkeZPv5G3BnZ1zkgqYRlJguvvaabpIa83aDgqPbbfG3fo7JucFaEzk4H
         cprIL9InkC70yoaLNxwFMF4HKVW5TtSAq8ye3G+ovdXvQjqzGOi08VAFNQxOsSa+bi3l
         su7I6pq7rpcNogrHS1YUN+76FVx5XcE0YxQK+l0nu5jizrEd259hm2upBo5g4+74vWeT
         +9OKQpBTLZw4zGdzYZaN0jONQbyTKAj2oHWi3OTCw6hbAN5cYGo8oYjAcFTjqMWt2SMj
         JtHVkxIEyiAeNcoT8BOySWM6Jk1p6qbID6ZR4sB4tw9yRVSLjUJYLX+nrpOu68RgALqF
         1Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698896282; x=1699501082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2HYB5MQFKIRkO0DflYcFCKWn7p/ZGUrpfZG5KxyE7I=;
        b=aKchxwt+pLO7UYpTRm2fwzB4aa8YsaCfnqPVMNUoKTFGVPbkeEXaIvuTeRIqtEx36K
         Mj7E0okmeq8cPHitr5U9nm747lHdeVmpUWUoufaYnraj96JHb0wqunSmQoBAvStZlrLy
         pkUA6QU2tHPVfiVzuY3+VmfynudFue2ZD2ogOZiUcbrfPQadw/Um2/9QyxvEaPCVYpFh
         Acgg1GfHWsU/NfofFtc/jf6+RDCA9Mc/Ft4pILBDZSIRa4vt6tLVc5NR85qeyAZJ/OvU
         5egM816pTjAPm9cDWaTk1KQUiEwAmKPZdopDkbMaPd2O4Sfx470sQsHejRlOcO7W/U2O
         YEhA==
X-Gm-Message-State: AOJu0YzXwHEg6mZ7GHLaxAKMOEG3DUeqye3LpJdtikBIFkKAhSrFI6qX
        BZl/7MUwf0SMJLNdxkOsN5pJeICck1SGTHThYvg=
X-Google-Smtp-Source: AGHT+IFyWKVSvmtshUJ8o+bmPWLdZ0Jmf6yPurF7H05N2fxuENZaVxk/DML0Dk62rNuFmS1Z0xP3BlSpHsTo79B9g9Q=
X-Received: by 2002:a1f:1f06:0:b0:495:c464:a2fe with SMTP id
 f6-20020a1f1f06000000b00495c464a2femr15663404vkf.2.1698896281786; Wed, 01 Nov
 2023 20:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <85ca95ae8e4d57ccf082c5c069b8b21eb141846e.1698668982.git.lukas@wunner.de>
In-Reply-To: <85ca95ae8e4d57ccf082c5c069b8b21eb141846e.1698668982.git.lukas@wunner.de>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Thu, 2 Nov 2023 13:37:35 +1000
Message-ID: <CAKmqyKOGb0G1B2LZmft=y=spdmAFpxjPxjVe8m9gWAcoLmvorg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Compile pci-sysfs.c only if CONFIG_SYSFS=y
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Krzysztof Wilczynski <kwilczynski@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 30, 2023 at 10:32=E2=80=AFPM Lukas Wunner <lukas@wunner.de> wro=
te:
>
> It is possible to enable CONFIG_PCI but disable CONFIG_SYSFS and for
> space-constrained devices such as routers, such a configuration may
> actually make sense.
>
> However pci-sysfs.c is compiled even if CONFIG_SYSFS is disabled,
> unnecessarily increasing the kernel's size.
>
> To rectify that:
>
> * Move pci_mmap_fits() to mmap.c.  It is not only needed by
>   pci-sysfs.c, but also proc.c.
>
> * Move pci_dev_type to probe.c and make it private.  It references
>   pci_dev_attr_groups in pci-sysfs.c.  Make that public instead for
>   consistency with pci_dev_groups, pcibus_groups and pci_bus_groups,
>   which are likewise public and referenced by struct definitions in
>   pci-driver.c and probe.c.
>
> * Define pci_dev_groups, pci_dev_attr_groups, pcibus_groups and
>   pci_bus_groups to NULL if CONFIG_SYSFS is disabled.  Provide empty
>   static inlines for pci_{create,remove}_legacy_files() and
>   pci_{create,remove}_sysfs_dev_files().
>
> Result:
>
> vmlinux size is reduced by 122996 bytes in my arm 32-bit test build.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  drivers/pci/Makefile    |  4 ++--
>  drivers/pci/mmap.c      | 29 +++++++++++++++++++++++++++++
>  drivers/pci/pci-sysfs.c | 29 +----------------------------
>  drivers/pci/pci.h       | 18 ++++++++++++++----
>  drivers/pci/probe.c     |  4 ++++
>  5 files changed, 50 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index cc8b4e01e29d..96f4759f2bd3 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -4,7 +4,7 @@
>
>  obj-$(CONFIG_PCI)              +=3D access.o bus.o probe.o host-bridge.o=
 \
>                                    remove.o pci.o pci-driver.o search.o \
> -                                  pci-sysfs.o rom.o setup-res.o irq.o vp=
d.o \
> +                                  rom.o setup-res.o irq.o vpd.o \
>                                    setup-bus.o vc.o mmap.o setup-irq.o
>
>  obj-$(CONFIG_PCI)              +=3D msi/
> @@ -12,7 +12,7 @@ obj-$(CONFIG_PCI)             +=3D pcie/
>
>  ifdef CONFIG_PCI
>  obj-$(CONFIG_PROC_FS)          +=3D proc.o
> -obj-$(CONFIG_SYSFS)            +=3D slot.o
> +obj-$(CONFIG_SYSFS)            +=3D pci-sysfs.o slot.o
>  obj-$(CONFIG_ACPI)             +=3D pci-acpi.o
>  endif
>
> diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
> index 4504039056d1..8da3347a95c4 100644
> --- a/drivers/pci/mmap.c
> +++ b/drivers/pci/mmap.c
> @@ -11,6 +11,8 @@
>  #include <linux/mm.h>
>  #include <linux/pci.h>
>
> +#include "pci.h"
> +
>  #ifdef ARCH_GENERIC_PCI_MMAP_RESOURCE
>
>  static const struct vm_operations_struct pci_phys_vm_ops =3D {
> @@ -50,3 +52,30 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int =
bar,
>  }
>
>  #endif
> +
> +#if (defined(CONFIG_SYSFS) || defined(CONFIG_PROC_FS)) && \
> +    (defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE))
> +
> +int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct=
 *vma,
> +                 enum pci_mmap_api mmap_api)
> +{
> +       resource_size_t pci_start =3D 0, pci_end;
> +       unsigned long nr, start, size;
> +
> +       if (pci_resource_len(pdev, resno) =3D=3D 0)
> +               return 0;
> +       nr =3D vma_pages(vma);
> +       start =3D vma->vm_pgoff;
> +       size =3D ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> +       if (mmap_api =3D=3D PCI_MMAP_PROCFS) {
> +               pci_resource_to_user(pdev, resno, &pdev->resource[resno],
> +                                    &pci_start, &pci_end);
> +               pci_start >>=3D PAGE_SHIFT;
> +       }
> +       if (start >=3D pci_start && start < pci_start + size &&
> +           start + nr <=3D pci_start + size)
> +               return 1;
> +       return 0;
> +}
> +
> +#endif
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 2321fdfefd7d..44ed30df08c3 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1022,29 +1022,6 @@ void pci_remove_legacy_files(struct pci_bus *b)
>  #endif /* HAVE_PCI_LEGACY */
>
>  #if defined(HAVE_PCI_MMAP) || defined(ARCH_GENERIC_PCI_MMAP_RESOURCE)
> -
> -int pci_mmap_fits(struct pci_dev *pdev, int resno, struct vm_area_struct=
 *vma,
> -                 enum pci_mmap_api mmap_api)
> -{
> -       unsigned long nr, start, size;
> -       resource_size_t pci_start =3D 0, pci_end;
> -
> -       if (pci_resource_len(pdev, resno) =3D=3D 0)
> -               return 0;
> -       nr =3D vma_pages(vma);
> -       start =3D vma->vm_pgoff;
> -       size =3D ((pci_resource_len(pdev, resno) - 1) >> PAGE_SHIFT) + 1;
> -       if (mmap_api =3D=3D PCI_MMAP_PROCFS) {
> -               pci_resource_to_user(pdev, resno, &pdev->resource[resno],
> -                                    &pci_start, &pci_end);
> -               pci_start >>=3D PAGE_SHIFT;
> -       }
> -       if (start >=3D pci_start && start < pci_start + size &&
> -                       start + nr <=3D pci_start + size)
> -               return 1;
> -       return 0;
> -}
> -
>  /**
>   * pci_mmap_resource - map a PCI resource into user memory space
>   * @kobj: kobject for mapping
> @@ -1660,7 +1637,7 @@ static const struct attribute_group pcie_dev_attr_g=
roup =3D {
>         .is_visible =3D pcie_dev_attrs_are_visible,
>  };
>
> -static const struct attribute_group *pci_dev_attr_groups[] =3D {
> +const struct attribute_group *pci_dev_attr_groups[] =3D {
>         &pci_dev_attr_group,
>         &pci_dev_hp_attr_group,
>  #ifdef CONFIG_PCI_IOV
> @@ -1677,7 +1654,3 @@ static const struct attribute_group *pci_dev_attr_g=
roups[] =3D {
>  #endif
>         NULL,
>  };
> -
> -const struct device_type pci_dev_type =3D {
> -       .groups =3D pci_dev_attr_groups,
> -};
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5ecbcf041179..aedaf4e51146 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -31,8 +31,6 @@ bool pcie_cap_has_rtctl(const struct pci_dev *dev);
>
>  /* Functions internal to the PCI core code */
>
> -int pci_create_sysfs_dev_files(struct pci_dev *pdev);
> -void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
>  void pci_cleanup_rom(struct pci_dev *dev);
>  #ifdef CONFIG_DMI
>  extern const struct attribute_group pci_dev_smbios_attr_group;
> @@ -152,7 +150,7 @@ static inline int pci_proc_detach_bus(struct pci_bus =
*bus) { return 0; }
>  /* Functions for PCI Hotplug drivers to use */
>  int pci_hp_add_bridge(struct pci_dev *dev);
>
> -#ifdef HAVE_PCI_LEGACY
> +#if defined(CONFIG_SYSFS) && defined(HAVE_PCI_LEGACY)
>  void pci_create_legacy_files(struct pci_bus *bus);
>  void pci_remove_legacy_files(struct pci_bus *bus);
>  #else
> @@ -185,10 +183,22 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
>         return (dev->no_d1d2 || parent_dstates);
>
>  }
> +
> +#ifdef CONFIG_SYSFS
> +int pci_create_sysfs_dev_files(struct pci_dev *pdev);
> +void pci_remove_sysfs_dev_files(struct pci_dev *pdev);
>  extern const struct attribute_group *pci_dev_groups[];
> +extern const struct attribute_group *pci_dev_attr_groups[];
>  extern const struct attribute_group *pcibus_groups[];
> -extern const struct device_type pci_dev_type;
>  extern const struct attribute_group *pci_bus_groups[];
> +#else
> +static inline int pci_create_sysfs_dev_files(struct pci_dev *pdev) { ret=
urn 0; }
> +static inline void pci_remove_sysfs_dev_files(struct pci_dev *pdev) { }
> +#define pci_dev_groups NULL
> +#define pci_dev_attr_groups NULL
> +#define pcibus_groups NULL
> +#define pci_bus_groups NULL
> +#endif
>
>  extern unsigned long pci_hotplug_io_size;
>  extern unsigned long pci_hotplug_mmio_size;
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ed6b7f48736a..500ac154fdfb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2307,6 +2307,10 @@ static void pci_release_dev(struct device *dev)
>         kfree(pci_dev);
>  }
>
> +static const struct device_type pci_dev_type =3D {
> +       .groups =3D pci_dev_attr_groups,
> +};
> +
>  struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
>  {
>         struct pci_dev *dev;
> --
> 2.40.1
>
