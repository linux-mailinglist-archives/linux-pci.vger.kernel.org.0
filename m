Return-Path: <linux-pci+bounces-11367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1474B9494E4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F041C2187D
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5EB18D63D;
	Tue,  6 Aug 2024 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="EXtYiU/c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B0381AA
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959707; cv=none; b=OdpUF4JKXVie/ILzJY1NvnXfbTDtjLWuXFVkj3SzzYlbAFXnDLvV+PrANq76fIsMbzB8THF6Oe2tfyrMyE7EZHTk3yTnqjxS/ewlRnTWzZCVW1VQRi2Rd9nsrAqaKpouDMP/ipxvxyL+2s+P+dlyQewHL7MuuZ1lOkmqbGW5dfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959707; c=relaxed/simple;
	bh=V7axy5oxuBi+4AERzv0nTWdYoYSpAyyW3qH1wkMHRP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOGe/COAnWDe/pqO71TaT2esDdRstgOlYqV4sC2/Y9hbOKlf591UIWYK+kRN8IHSXyCV9nBHJhzsO3UFLNJxlhPbZ4Jatpfsfs90QCa3PppHDHRHdlLm0kTl8hNn1GkAoyTZvKkRRwWY5rCIAJ0vWQOpBxjhvbeVwUnsfimipDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=EXtYiU/c; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39b3c36d247so3433345ab.3
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 08:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722959705; x=1723564505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YGt/wjYo222OhPFmccSx6ThVZz+Izlc098ZQzrSAG8=;
        b=EXtYiU/c3/q3D4AEObKfVu+gBsvYOOp1MZL+YfrxfrpnP/JMxpmZCYkvHo0in0ICw9
         9BpuiqqwuRhlyki7rWNr/w2g94e0YJVYZw7AC54aZqPRml1XQYCAPijJaQ90ELl+Vrwr
         JL4wV0L5VzTRb6Brxlm2BRHF9nacm0t8vIdp+4NIz7VSfhbBiZiTdjM05A314P+p+yBa
         FQ2zecMg3fasuyoJEx2lcmUJBTwOJTYKl5cvP4CobF4SHDZtb+d1BueIVm6kIT6gGb9U
         Utq1bMrHZB5KPLQg0Ycde5tU+0yQ4U4hYrEBtKfSoWoiC2lXosXZKJUZ3Y7reLjnFzDt
         WiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959705; x=1723564505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YGt/wjYo222OhPFmccSx6ThVZz+Izlc098ZQzrSAG8=;
        b=v2lJg32+Jm8s8tZ78WIuMzjxy1s4S9VBr6K10IyymbBQWeCXA3NH/jJcnrgqBlji8Y
         RLfs+3ShUQf8UhfzEUlLySCixXbHRok1Ay8VoK2rvsZZeelbduk046IDIgJq2dF5jxAG
         zdL9FERKopItfJdoU0cNgqA4+GzaOGq/eL+QtorF4DNcqr2C9ZUxwKx6XN4s/zIvV40m
         TjSQjNmVYynpWPKrh8g7C1Si3jrPs3w+e6hV/jsiQO+X0GQHoRQghoaQSCp7i1UF6L6m
         z9CB5XY7Qe7oTxFvxJ8ml8SySO/qBLoNLaqk0PAfzzP/4tltfuNHUVKDQz7QIsNN5d7S
         RcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCy8CpJ31FpP6Jfy63r8jBV7mUtpZuCMgin4X17lUxdUt8uH1vWEUoOhKOrljK2OJYUq7lKuI+kdIgIT4NIGSZRYa8+M3dLSq1
X-Gm-Message-State: AOJu0YxWye1xU+ln3IjF22aZXWf3EiEH11N086mvTECen4YiSJQSTJFV
	tv5t4xXTunq2WSVBmoaqgszj8y+6q6Jla2o4C8/NatnZJDDGiSwg+ofXGYjm7hE3cfz3D5uqdan
	sOnf8kZ7/C3V2lTjkGMy8wYha/K+riolCXbj+42UrGzZkxm3oO44=
X-Google-Smtp-Source: AGHT+IFRQkuAAHgh/EsFWAb8TmrhK12DCRX1CVtn+L9OrfgAKSE7RGRF2MjbSwJgKdxgAQsqi0R98pCqTvk4tf8kIYQ=
X-Received: by 2002:a05:6e02:1ca2:b0:383:6af0:eb0d with SMTP id
 e9e14a558f8ab-39b1fc36ab0mr214645195ab.26.1722959705121; Tue, 06 Aug 2024
 08:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729142241.733357-1-sunilvl@ventanamicro.com> <20240729142241.733357-17-sunilvl@ventanamicro.com>
In-Reply-To: <20240729142241.733357-17-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Aug 2024 21:24:53 +0530
Message-ID: <CAAhSdy2EERGy2siE4mCCGNN2ydfiKiMGwrsYts=bb52WAViYwg@mail.gmail.com>
Subject: Re: [PATCH v7 16/17] irqchip/riscv-aplic: Add ACPI support
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
> Add ACPI support in APLIC drivers. Use the mapping created early during
> boot to get the details about the APLIC.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/irqchip/irq-riscv-aplic-direct.c | 22 +++++---
>  drivers/irqchip/irq-riscv-aplic-main.c   | 69 ++++++++++++++++--------
>  drivers/irqchip/irq-riscv-aplic-main.h   |  1 +
>  drivers/irqchip/irq-riscv-aplic-msi.c    |  9 +++-
>  4 files changed, 69 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-aplic-direct.c b/drivers/irqchip/i=
rq-riscv-aplic-direct.c
> index 4a3ffe856d6c..34540a0ca4da 100644
> --- a/drivers/irqchip/irq-riscv-aplic-direct.c
> +++ b/drivers/irqchip/irq-riscv-aplic-direct.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2022 Ventana Micro Systems Inc.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/cpu.h>
> @@ -189,17 +190,22 @@ static int aplic_direct_starting_cpu(unsigned int c=
pu)
>  }
>
>  static int aplic_direct_parse_parent_hwirq(struct device *dev, u32 index=
,
> -                                          u32 *parent_hwirq, unsigned lo=
ng *parent_hartid)
> +                                          u32 *parent_hwirq, unsigned lo=
ng *parent_hartid,
> +                                          struct aplic_priv *priv)
>  {
>         struct of_phandle_args parent;
> +       unsigned long hartid;
>         int rc;
>
> -       /*
> -        * Currently, only OF fwnode is supported so extend this
> -        * function for ACPI support.
> -        */
> -       if (!is_of_node(dev->fwnode))
> -               return -EINVAL;
> +       if (!is_of_node(dev->fwnode)) {
> +               hartid =3D acpi_get_ext_intc_parent_hartid(priv->id, inde=
x);
> +               if (hartid =3D=3D INVALID_HARTID)
> +                       return -ENODEV;
> +
> +               *parent_hartid =3D hartid;
> +               *parent_hwirq =3D RV_IRQ_EXT;
> +               return 0;
> +       }
>
>         rc =3D of_irq_parse_one(to_of_node(dev->fwnode), index, &parent);
>         if (rc)
> @@ -237,7 +243,7 @@ int aplic_direct_setup(struct device *dev, void __iom=
em *regs)
>         /* Setup per-CPU IDC and target CPU mask */
>         current_cpu =3D get_cpu();
>         for (i =3D 0; i < priv->nr_idcs; i++) {
> -               rc =3D aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &h=
artid);
> +               rc =3D aplic_direct_parse_parent_hwirq(dev, i, &hwirq, &h=
artid, priv);
>                 if (rc) {
>                         dev_warn(dev, "parent irq for IDC%d not found\n",=
 i);
>                         continue;
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq=
-riscv-aplic-main.c
> index 28dd175b5764..8357c5f9921a 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -4,8 +4,10 @@
>   * Copyright (C) 2022 Ventana Micro Systems Inc.
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/bitfield.h>
>  #include <linux/irqchip/riscv-aplic.h>
> +#include <linux/irqchip/riscv-imsic.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
> @@ -125,39 +127,50 @@ static void aplic_init_hw_irqs(struct aplic_priv *p=
riv)
>         writel(0, priv->regs + APLIC_DOMAINCFG);
>  }
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id aplic_acpi_match[] =3D {
> +       { "RSCV0002", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, aplic_acpi_match);
> +
> +#endif
> +
>  int aplic_setup_priv(struct aplic_priv *priv, struct device *dev, void _=
_iomem *regs)
>  {
>         struct device_node *np =3D to_of_node(dev->fwnode);
>         struct of_phandle_args parent;
>         int rc;
>
> -       /*
> -        * Currently, only OF fwnode is supported so extend this
> -        * function for ACPI support.
> -        */
> -       if (!np)
> -               return -EINVAL;
> -
>         /* Save device pointer and register base */
>         priv->dev =3D dev;
>         priv->regs =3D regs;
>
> -       /* Find out number of interrupt sources */
> -       rc =3D of_property_read_u32(np, "riscv,num-sources", &priv->nr_ir=
qs);
> -       if (rc) {
> -               dev_err(dev, "failed to get number of interrupt sources\n=
");
> -               return rc;
> -       }
> +       if (np) {
> +               /* Find out number of interrupt sources */
> +               rc =3D of_property_read_u32(np, "riscv,num-sources", &pri=
v->nr_irqs);
> +               if (rc) {
> +                       dev_err(dev, "failed to get number of interrupt s=
ources\n");
> +                       return rc;
> +               }
>
> -       /*
> -        * Find out number of IDCs based on parent interrupts
> -        *
> -        * If "msi-parent" property is present then we ignore the
> -        * APLIC IDCs which forces the APLIC driver to use MSI mode.
> -        */
> -       if (!of_property_present(np, "msi-parent")) {
> -               while (!of_irq_parse_one(np, priv->nr_idcs, &parent))
> -                       priv->nr_idcs++;
> +               /*
> +                * Find out number of IDCs based on parent interrupts
> +                *
> +                * If "msi-parent" property is present then we ignore the
> +                * APLIC IDCs which forces the APLIC driver to use MSI mo=
de.
> +                */
> +               if (!of_property_present(np, "msi-parent")) {
> +                       while (!of_irq_parse_one(np, priv->nr_idcs, &pare=
nt))
> +                               priv->nr_idcs++;
> +               }
> +       } else {
> +               rc =3D riscv_acpi_get_gsi_info(dev->fwnode, &priv->gsi_ba=
se, &priv->id,
> +                                            &priv->nr_irqs, &priv->nr_id=
cs);
> +               if (rc) {
> +                       dev_err(dev, "failed to find GSI mapping\n");
> +                       return rc;
> +               }
>         }
>
>         /* Setup initial state APLIC interrupts */
> @@ -184,7 +197,11 @@ static int aplic_probe(struct platform_device *pdev)
>          * If msi-parent property is present then setup APLIC MSI
>          * mode otherwise setup APLIC direct mode.
>          */
> -       msi_mode =3D of_property_present(to_of_node(dev->fwnode), "msi-pa=
rent");
> +       if (is_of_node(dev->fwnode))
> +               msi_mode =3D of_property_present(to_of_node(dev->fwnode),=
 "msi-parent");
> +       else
> +               msi_mode =3D imsic_acpi_get_fwnode(NULL) ? 1 : 0;
> +
>         if (msi_mode)
>                 rc =3D aplic_msi_setup(dev, regs);
>         else
> @@ -192,6 +209,11 @@ static int aplic_probe(struct platform_device *pdev)
>         if (rc)
>                 dev_err(dev, "failed to setup APLIC in %s mode\n", msi_mo=
de ? "MSI" : "direct");
>
> +#ifdef CONFIG_ACPI
> +       if (!acpi_disabled)
> +               acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
> +#endif
> +
>         return rc;
>  }
>
> @@ -204,6 +226,7 @@ static struct platform_driver aplic_driver =3D {
>         .driver =3D {
>                 .name           =3D "riscv-aplic",
>                 .of_match_table =3D aplic_match,
> +               .acpi_match_table =3D ACPI_PTR(aplic_acpi_match),
>         },
>         .probe =3D aplic_probe,
>  };
> diff --git a/drivers/irqchip/irq-riscv-aplic-main.h b/drivers/irqchip/irq=
-riscv-aplic-main.h
> index 4393927d8c80..9fbf45c7b4f7 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.h
> +++ b/drivers/irqchip/irq-riscv-aplic-main.h
> @@ -28,6 +28,7 @@ struct aplic_priv {
>         u32                     gsi_base;
>         u32                     nr_irqs;
>         u32                     nr_idcs;
> +       u32                     id;

This "id" is only used for ACPI so better call it "acpi_id".

>         void __iomem            *regs;
>         struct aplic_msicfg     msicfg;
>  };
> diff --git a/drivers/irqchip/irq-riscv-aplic-msi.c b/drivers/irqchip/irq-=
riscv-aplic-msi.c
> index 028444af48bd..f5020241e0ed 100644
> --- a/drivers/irqchip/irq-riscv-aplic-msi.c
> +++ b/drivers/irqchip/irq-riscv-aplic-msi.c
> @@ -157,6 +157,7 @@ static const struct msi_domain_template aplic_msi_tem=
plate =3D {
>  int aplic_msi_setup(struct device *dev, void __iomem *regs)
>  {
>         const struct imsic_global_config *imsic_global;
> +       struct irq_domain *msi_domain;
>         struct aplic_priv *priv;
>         struct aplic_msicfg *mc;
>         phys_addr_t pa;
> @@ -239,8 +240,14 @@ int aplic_msi_setup(struct device *dev, void __iomem=
 *regs)
>                  * IMSIC and the IMSIC MSI domains are created later thro=
ugh
>                  * the platform driver probing so we set it explicitly he=
re.
>                  */
> -               if (is_of_node(dev->fwnode))
> +               if (is_of_node(dev->fwnode)) {
>                         of_msi_configure(dev, to_of_node(dev->fwnode));
> +               } else {
> +                       msi_domain =3D irq_find_matching_fwnode(imsic_acp=
i_get_fwnode(dev),
> +                                                             DOMAIN_BUS_=
PLATFORM_MSI);
> +                       if (msi_domain)
> +                               dev_set_msi_domain(dev, msi_domain);
> +               }
>         }
>
>         if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN, &aplic=
_msi_template,
> --
> 2.43.0
>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

