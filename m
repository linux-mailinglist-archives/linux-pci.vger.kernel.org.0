Return-Path: <linux-pci+bounces-11366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CA894949B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1452841E0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251F2C6BB;
	Tue,  6 Aug 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="qBy1CZIa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0032A1C5
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 15:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958226; cv=none; b=Zf0YO+zKQOiTKn3t5MPHk7oJ0LFdz6gY8bzoGqarFtVTLUhAjonBAYh5nmx6O4FjnbINtMqlRNf4pzIbZFWe64HaBZuPdJ8WByRF3OGWYzo+v8FiEZZ3Fma/egKUe/9YMXfF2R3b11ESgZzP4GR5yZyD2bNpNDuOuoAYscssV9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958226; c=relaxed/simple;
	bh=c0kEpEGQaxZ9gxI/y6kHR/U/wgCixCt8ScbGl1qT0d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TijGMSGK1Cxk6AfcOjIAPmGNA5RD0R3WqRgx6MY+tvACGuq+omE+0WIfHlmucuP/L0ZegEgPDh7n2wyQczQeWnnotCa/gz5/eZV2w2sAsfqUo2CI8aCD2An/BqJATmKaFV1HA/PujoS+P+8uRhlhnY/fBQP5D+ifono25Swi9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=qBy1CZIa; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-81f9339e534so30271239f.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722958224; x=1723563024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVobMjiL55rH3COneIt9qAucAKn8ar7J+EuB8wGOdKM=;
        b=qBy1CZIakDJD40QwK+FiUWMh5r2AYtjR0VeGJC7E0UtXSgZXZK+frsA4CGDne6RhB6
         Q4D/7DhDUXLfVRXt+UhtJRwJ5it7Z3nmY2esH/NejjKaRVID0PwIhhmcKkQLQDiZS1xk
         r8DXBp+HEex9R1l59016Lv8EKoJAtR9C01X4m5Scj4A/cObqzr6KmSTx8a5irQSM6Mla
         6m88r4jnxlftWcS6tEGwYBNSywXj9RNuA+m+2p6G1NV7343dP08IpaF0nxi43M/tgQ9O
         SJ4N/aG0qd6ZDCBma82JbWjYf30SlLr+nNPAU770qPn4H0CkcNKSzIY5j3oUgJa9vika
         i9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722958224; x=1723563024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVobMjiL55rH3COneIt9qAucAKn8ar7J+EuB8wGOdKM=;
        b=pV7r7zeUG4Id0vgMq97UrdmDbFND7Ubxy2AuWNmKuW1b1ed4Ahnh8g/LWUd7wJcYIO
         8HyMTMnR6sC1kk0QlOSbUh2fXXqryFRbjii4rK2Hf+iwkRNFWWxDh+fwEsDCTgTu0xV8
         SiHbI91G0vG8H6zcFN5yUVJyTb0DVNcmFM0lwXYlFmDbv1fYS5hIGn3RZwbXUSSM8z9w
         9R5aGrvQjt90BuMJdQ4A6U+Vh7cEOASDmXWpUoCPo6r8vWZF3/XUfSPQaSay5fg+nKBT
         r4bsSEEjuV+5SqBYexwm/bxLmykSrH8O/1RYOYd+cZ5Rro4vKGdLZbxUNZ/X5Mv3h2Ut
         lYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhtd14WBSvconWhJdMKamMEQMQpkq6/sa7ZkBbRf1tipykz/KBnc2PjAnGTxr22FslNoFhohXgGYoX9V9WkBjOvGDuJrMveyoI
X-Gm-Message-State: AOJu0YxDSntYEg6plIkYia0HdCBUY7s1qk8uSJ+uNSRjPYyQFUHVFtoK
	qaIRPfKPvJPIZ06dYW513aKW9Jw3ff5UpXmMSL3xgbOpfoBNXPio/pKK6yKDfepbS4DC1iobIGE
	mGsWwZvamHtR5bdPaci+nBu31P9pSEV6iDMkc9A==
X-Google-Smtp-Source: AGHT+IG8hV54ypCF9qPjAeEm1XANKOcW4GTRDtrUWp5F1qUg0fCrWwcndr/AO7b9J8Y6gzGn8lneM3wJbNgyuuv5vDY=
X-Received: by 2002:a92:6610:0:b0:399:2c60:9951 with SMTP id
 e9e14a558f8ab-39b1fbf5c86mr166526275ab.20.1722958224272; Tue, 06 Aug 2024
 08:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729142241.733357-1-sunilvl@ventanamicro.com> <20240729142241.733357-16-sunilvl@ventanamicro.com>
In-Reply-To: <20240729142241.733357-16-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Aug 2024 21:00:13 +0530
Message-ID: <CAAhSdy0r++6enRx8m=XfKgacfnVau3_VWcArY93umYe5ET-gQw@mail.gmail.com>
Subject: Re: [PATCH v7 15/17] irqchip/riscv-imsic: Add ACPI support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Samuel Holland <samuel.holland@sifive.com>, 
	Robert Moore <robert.moore@intel.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Atish Kumar Patra <atishp@rivosinc.com>, Drew Fustini <dfustini@tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 7:54=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> RISC-V IMSIC interrupt controller provides IPI and MSI support.
> Currently, DT based drivers setup the IPI feature early during boot but
> defer setting up the MSI functionality. However, in ACPI systems, PCI
> subsystem is probed early and assume MSI controller is already setup.
> Hence, both IPI and MSI features need to be initialized early itself.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup


> ---
>  drivers/irqchip/irq-riscv-imsic-early.c    | 64 +++++++++++++++++++++-
>  drivers/irqchip/irq-riscv-imsic-platform.c | 32 +++++++++--
>  drivers/irqchip/irq-riscv-imsic-state.c    | 57 +++++++++++--------
>  drivers/irqchip/irq-riscv-imsic-state.h    |  2 +-
>  include/linux/irqchip/riscv-imsic.h        |  9 +++
>  5 files changed, 134 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/ir=
q-riscv-imsic-early.c
> index 4fbb37074d29..c5c2e6929a2f 100644
> --- a/drivers/irqchip/irq-riscv-imsic-early.c
> +++ b/drivers/irqchip/irq-riscv-imsic-early.c
> @@ -5,13 +5,16 @@
>   */
>
>  #define pr_fmt(fmt) "riscv-imsic: " fmt
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
>  #include <linux/irqchip/chained_irq.h>
> +#include <linux/irqchip/riscv-imsic.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include <linux/spinlock.h>
>  #include <linux/smp.h>
>
> @@ -182,7 +185,7 @@ static int __init imsic_early_dt_init(struct device_n=
ode *node, struct device_no
>         int rc;
>
>         /* Setup IMSIC state */
> -       rc =3D imsic_setup_state(fwnode);
> +       rc =3D imsic_setup_state(fwnode, NULL);
>         if (rc) {
>                 pr_err("%pfwP: failed to setup state (error %d)\n", fwnod=
e, rc);
>                 return rc;
> @@ -199,3 +202,62 @@ static int __init imsic_early_dt_init(struct device_=
node *node, struct device_no
>  }
>
>  IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
> +
> +#ifdef CONFIG_ACPI
> +
> +static struct fwnode_handle *imsic_acpi_fwnode;
> +
> +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
> +{
> +       return imsic_acpi_fwnode;
> +}
> +
> +static int __init imsic_early_acpi_init(union acpi_subtable_headers *hea=
der,
> +                                       const unsigned long end)
> +{
> +       struct acpi_madt_imsic *imsic =3D (struct acpi_madt_imsic *)heade=
r;
> +       int rc;
> +
> +       imsic_acpi_fwnode =3D irq_domain_alloc_named_fwnode("imsic");
> +       if (!imsic_acpi_fwnode) {
> +               pr_err("unable to allocate IMSIC FW node\n");
> +               return -ENOMEM;
> +       }
> +
> +       /* Setup IMSIC state */
> +       rc =3D imsic_setup_state(imsic_acpi_fwnode, imsic);
> +       if (rc) {
> +               pr_err("%pfwP: failed to setup state (error %d)\n", imsic=
_acpi_fwnode, rc);
> +               return rc;
> +       }
> +
> +       /* Do early setup of IMSIC state and IPIs */
> +       rc =3D imsic_early_probe(imsic_acpi_fwnode);
> +       if (rc) {
> +               irq_domain_free_fwnode(imsic_acpi_fwnode);
> +               imsic_acpi_fwnode =3D NULL;
> +               return rc;
> +       }
> +
> +       rc =3D imsic_platform_acpi_probe(imsic_acpi_fwnode);
> +
> +#ifdef CONFIG_PCI
> +       if (!rc)
> +               pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
> +#endif
> +
> +       if (rc)
> +               pr_err("%pfwP: failed to register IMSIC for MSI functiona=
lity (error %d)\n",
> +                      imsic_acpi_fwnode, rc);
> +
> +       /*
> +        * Even if imsic_platform_acpi_probe() fails, the IPI part of IMS=
IC can
> +        * continue to work. So, no need to return failure. This is simil=
ar to
> +        * DT where IPI works but MSI probe fails for some reason.
> +        */
> +       return 0;
> +}
> +
> +IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
> +                    1, imsic_early_acpi_init);
> +#endif
> diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip=
/irq-riscv-imsic-platform.c
> index 11723a763c10..64905e6f52d7 100644
> --- a/drivers/irqchip/irq-riscv-imsic-platform.c
> +++ b/drivers/irqchip/irq-riscv-imsic-platform.c
> @@ -5,6 +5,7 @@
>   */
>
>  #define pr_fmt(fmt) "riscv-imsic: " fmt
> +#include <linux/acpi.h>
>  #include <linux/bitmap.h>
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
> @@ -348,18 +349,37 @@ int imsic_irqdomain_init(void)
>         return 0;
>  }
>
> -static int imsic_platform_probe(struct platform_device *pdev)
> +static int imsic_platform_probe_common(struct fwnode_handle *fwnode)
>  {
> -       struct device *dev =3D &pdev->dev;
> -
> -       if (imsic && imsic->fwnode !=3D dev->fwnode) {
> -               dev_err(dev, "fwnode mismatch\n");
> +       if (imsic && imsic->fwnode !=3D fwnode) {
> +               pr_err("%pfwP: fwnode mismatch\n", fwnode);
>                 return -ENODEV;
>         }
>
>         return imsic_irqdomain_init();
>  }
>
> +static int imsic_platform_dt_probe(struct platform_device *pdev)
> +{
> +       return imsic_platform_probe_common(pdev->dev.fwnode);
> +}
> +
> +#ifdef CONFIG_ACPI
> +
> +/*
> + *  On ACPI based systems, PCI enumeration happens early during boot in
> + *  acpi_scan_init(). PCI enumeration expects MSI domain setup before
> + *  it calls pci_set_msi_domain(). Hence, unlike in DT where
> + *  imsic-platform drive probe happens late during boot, ACPI based
> + *  systems need to setup the MSI domain early.
> + */
> +int imsic_platform_acpi_probe(struct fwnode_handle *fwnode)
> +{
> +       return imsic_platform_probe_common(fwnode);
> +}
> +
> +#endif
> +
>  static const struct of_device_id imsic_platform_match[] =3D {
>         { .compatible =3D "riscv,imsics" },
>         {}
> @@ -370,6 +390,6 @@ static struct platform_driver imsic_platform_driver =
=3D {
>                 .name           =3D "riscv-imsic",
>                 .of_match_table =3D imsic_platform_match,
>         },
> -       .probe =3D imsic_platform_probe,
> +       .probe =3D imsic_platform_dt_probe,
>  };
>  builtin_platform_driver(imsic_platform_driver);
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index f9e70832863a..73faa64bffda 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -5,6 +5,7 @@
>   */
>
>  #define pr_fmt(fmt) "riscv-imsic: " fmt
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/bitmap.h>
>  #include <linux/interrupt.h>
> @@ -564,18 +565,36 @@ static int __init imsic_populate_global_dt(struct f=
wnode_handle *fwnode,
>         return 0;
>  }
>
> +static int __init imsic_populate_global_acpi(struct fwnode_handle *fwnod=
e,
> +                                            struct imsic_global_config *=
global,
> +                                            u32 *nr_parent_irqs, void *o=
paque)
> +{
> +       struct acpi_madt_imsic *imsic =3D (struct acpi_madt_imsic *)opaqu=
e;
> +
> +       global->guest_index_bits =3D imsic->guest_index_bits;
> +       global->hart_index_bits =3D imsic->hart_index_bits;
> +       global->group_index_bits =3D imsic->group_index_bits;
> +       global->group_index_shift =3D imsic->group_index_shift;
> +       global->nr_ids =3D imsic->num_ids;
> +       global->nr_guest_ids =3D imsic->num_guest_ids;
> +       return 0;
> +}
> +
>  static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
>                                           u32 index, unsigned long *harti=
d)
>  {
>         struct of_phandle_args parent;
>         int rc;
>
> -       /*
> -        * Currently, only OF fwnode is supported so extend this
> -        * function for ACPI support.
> -        */
> -       if (!is_of_node(fwnode))
> -               return -EINVAL;
> +       if (!is_of_node(fwnode)) {
> +               if (hartid)
> +                       *hartid =3D acpi_get_intc_index_hartid(index);
> +
> +               if (!hartid || (*hartid =3D=3D INVALID_HARTID))
> +                       return -EINVAL;
> +
> +               return 0;
> +       }
>
>         rc =3D of_irq_parse_one(to_of_node(fwnode), index, &parent);
>         if (rc)
> @@ -594,12 +613,8 @@ static int __init imsic_get_parent_hartid(struct fwn=
ode_handle *fwnode,
>  static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
>                                           u32 index, struct resource *res=
)
>  {
> -       /*
> -        * Currently, only OF fwnode is supported so extend this
> -        * function for ACPI support.
> -        */
>         if (!is_of_node(fwnode))
> -               return -EINVAL;
> +               return acpi_get_imsic_mmio_info(index, res);
>
>         return of_address_to_resource(to_of_node(fwnode), index, res);
>  }
> @@ -607,20 +622,14 @@ static int __init imsic_get_mmio_resource(struct fw=
node_handle *fwnode,
>  static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
>                                      struct imsic_global_config *global,
>                                      u32 *nr_parent_irqs,
> -                                    u32 *nr_mmios)
> +                                    u32 *nr_mmios,
> +                                    void *opaque)
>  {
>         unsigned long hartid;
>         struct resource res;
>         int rc;
>         u32 i;
>
> -       /*
> -        * Currently, only OF fwnode is supported so extend this
> -        * function for ACPI support.
> -        */
> -       if (!is_of_node(fwnode))
> -               return -EINVAL;
> -
>         *nr_parent_irqs =3D 0;
>         *nr_mmios =3D 0;
>
> @@ -632,7 +641,11 @@ static int __init imsic_parse_fwnode(struct fwnode_h=
andle *fwnode,
>                 return -EINVAL;
>         }
>
> -       rc =3D imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
> +       if (is_of_node(fwnode))
> +               rc =3D imsic_populate_global_dt(fwnode, global, nr_parent=
_irqs);
> +       else
> +               rc =3D imsic_populate_global_acpi(fwnode, global, nr_pare=
nt_irqs, opaque);
> +
>         if (rc)
>                 return rc;
>
> @@ -701,7 +714,7 @@ static int __init imsic_parse_fwnode(struct fwnode_ha=
ndle *fwnode,
>         return 0;
>  }
>
> -int __init imsic_setup_state(struct fwnode_handle *fwnode)
> +int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
>  {
>         u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers =3D 0;
>         struct imsic_global_config *global;
> @@ -742,7 +755,7 @@ int __init imsic_setup_state(struct fwnode_handle *fw=
node)
>         }
>
>         /* Parse IMSIC fwnode */
> -       rc =3D imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mm=
ios);
> +       rc =3D imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mm=
ios, opaque);
>         if (rc)
>                 goto out_free_local;
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/ir=
q-riscv-imsic-state.h
> index 5ae2f69b035b..391e44280827 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.h
> +++ b/drivers/irqchip/irq-riscv-imsic-state.h
> @@ -102,7 +102,7 @@ void imsic_vector_debug_show_summary(struct seq_file =
*m, int ind);
>
>  void imsic_state_online(void);
>  void imsic_state_offline(void);
> -int imsic_setup_state(struct fwnode_handle *fwnode);
> +int imsic_setup_state(struct fwnode_handle *fwnode, void *opaque);
>  int imsic_irqdomain_init(void);
>
>  #endif
> diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/=
riscv-imsic.h
> index faf0b800b1b0..7494952c5518 100644
> --- a/include/linux/irqchip/riscv-imsic.h
> +++ b/include/linux/irqchip/riscv-imsic.h
> @@ -8,6 +8,8 @@
>
>  #include <linux/types.h>
>  #include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/fwnode.h>
>  #include <asm/csr.h>
>
>  #define IMSIC_MMIO_PAGE_SHIFT          12
> @@ -84,4 +86,11 @@ static inline const struct imsic_global_config *imsic_=
get_global_config(void)
>
>  #endif
>
> +#ifdef CONFIG_ACPI
> +int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
> +struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
> +#else
> +static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device =
*dev) { return NULL; }
> +#endif
> +
>  #endif
> --
> 2.43.0
>

