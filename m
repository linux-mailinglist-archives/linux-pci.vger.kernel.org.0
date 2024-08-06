Return-Path: <linux-pci+bounces-11369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E09C949512
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 18:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43191F29D29
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2717AE0D;
	Tue,  6 Aug 2024 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="vvx/xbWY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4B16D4DD
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 15:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959966; cv=none; b=hAln3jwioiU964jCa4dB1vpXCa1y77ghoccxtlz7kYaH2v3gGALS8YdN9qbz7TpDwE/VRfkFAnK9FJe+4IQtoYRIan9/9d36iBBtDprhH52tFAKQmogfcBOd+axtPTkQCW7pCUF3ceIK9Zk3WPvMmonik/OBElqeJKJreEqiIW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959966; c=relaxed/simple;
	bh=5IHtW0V6LW9GBudGRdbXzlBXhuGb+QZ5HHx2L0Ot9Ho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FlX1zjuYjpWYODsV2L+ETiRg8m5frBLz2CsFUBLgckLa/AueND6HgFWhocfx2mLN1GzRb6v8g/9/ntKCg8aMvrBIyty3mv3cEkuqFciofXkz8l8hOAmfjoL8GcLPChLj1CSximWJC+ZaAKYe7TMeQ0/uk8J5SConf+wIRAq0Gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=vvx/xbWY; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39b38295008so3041365ab.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 08:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722959964; x=1723564764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NpnkKIJgnuEPhelT1VbXs9Kh1Gjs36WnewQApXQbgY0=;
        b=vvx/xbWYBq1Jk46DOY+KQ0lx5yz4z6OOmZIbLfLqgNWRjFb6VOZkp0DedqHKYMqXcy
         I0Oct8Dwio9akc5zMQ4m8LP20u1Baed0IaHEpfaBXdi41kp1GJBkBLCyYTiTo4Dk/kfw
         TywGGZsqp5wzEy7WEHy1zdJXZhLmJfwzk8TkBg102O2p2S2xXW/f6vltlLT0V6DSHUGT
         l+z4SosobnAvEEKKi82EjsfEu3vW3ZQSb8lsH/UlqYJi+D9tcZg6ah211kXEvWTfvXZ3
         udIp49m6IRmZWpEnmSRnWQ/5hvwQNkJEKrIIjte3fd7YNhrAwcDn65lFA+2q8LCVn3G+
         +wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959964; x=1723564764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NpnkKIJgnuEPhelT1VbXs9Kh1Gjs36WnewQApXQbgY0=;
        b=PklCFe+DQOKVvqHH0l2HhG9cJ7m9paBRfJ4qsBFJQTpiCQeRDZkzYoLBihIVIYQUTr
         z4N4eIaX2bBF354XU2T9MdiERcY6LEovHT5YdsYmV1EA9ytbbPh4n7oB8Vrpigk37rIu
         a04MXg1P6/Oa0ZGu3WrjQpuK6IuLnjO9Q/eXC7ysdJKzARoQE0BBJaeCNEmiY6oSlzw5
         73o9AEzvZexIpXtTOsApYMqbWOIquBpW2wVxJPoohdS/rwZIw1VObvPiSDBuS19dsMrz
         YbUzZ2u6//NcQh3ZjGu50LhJ+P+/RBn5TnzaWIKqttqn1bMUr6fIdMioRNpfX+/4S9E7
         sYqg==
X-Forwarded-Encrypted: i=1; AJvYcCWc1qdeqOcxlb87WPFBW2C/RLc9PIuOb8LwlDWJ0sdrw0N5gHXzCbbMtn2fghX0kiAUzaprvQc4j08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59luEpTIHYj3MimX12pKcfD/WLkvyUFqmgCr8mAy5MNc2i2Vb
	EnpZooYvMGDwUGvbJPgSdTiRAoK55YrMccXuEnnKPv1WFZNetSH6hHp3yk9bYdzPtfcUo7hZ/78
	++Dt8ULyl5qsGBlUYj7Mjl54wiRZrDSj/hdyveg==
X-Google-Smtp-Source: AGHT+IEeGerVMiLX8KrZvRsFQJUPFh+TJy37h32RX7gd08MgDCUq9yw0ABtWpHRrv4tSrL498zUHQgOm2NKeRLhWkAs=
X-Received: by 2002:a92:cccc:0:b0:39a:e984:1caa with SMTP id
 e9e14a558f8ab-39b1fbf65cbmr144360605ab.21.1722959964025; Tue, 06 Aug 2024
 08:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729142241.733357-1-sunilvl@ventanamicro.com> <20240729142241.733357-18-sunilvl@ventanamicro.com>
In-Reply-To: <20240729142241.733357-18-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Aug 2024 21:29:13 +0530
Message-ID: <CAAhSdy1372ZY_irkfZ5-81C3KL+2ap9HkfRKTjGZWVT-nrGoNQ@mail.gmail.com>
Subject: Re: [PATCH v7 17/17] irqchip/sifive-plic: Add ACPI support
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
> Add ACPI support in PLIC driver. Use the mapping created early during
> boot to get details about the PLIC.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 94 ++++++++++++++++++++++++-------
>  1 file changed, 73 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifi=
ve-plic.c
> index 9e22f7e378f5..12d60728329c 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2017 SiFive
>   * Copyright (C) 2018 Christoph Hellwig
>   */
> +#include <linux/acpi.h>
>  #include <linux/cpu.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> @@ -70,6 +71,8 @@ struct plic_priv {
>         unsigned long plic_quirks;
>         unsigned int nr_irqs;
>         unsigned long *prio_save;
> +       u32 gsi_base;
> +       int id;

Same as the other patch, better to call "id" as "acpi_id".

>  };
>
>  struct plic_handler {
> @@ -324,6 +327,10 @@ static int plic_irq_domain_translate(struct irq_doma=
in *d,
>  {
>         struct plic_priv *priv =3D d->host_data;
>
> +       /* For DT, gsi_base is always zero. */
> +       if (fwspec->param[0] >=3D priv->gsi_base)
> +               fwspec->param[0] =3D fwspec->param[0] - priv->gsi_base;
> +
>         if (test_bit(PLIC_QUIRK_EDGE_INTERRUPT, &priv->plic_quirks))
>                 return irq_domain_translate_twocell(d, fwspec, hwirq, typ=
e);
>
> @@ -424,18 +431,37 @@ static const struct of_device_id plic_match[] =3D {
>         {}
>  };
>
> +#ifdef CONFIG_ACPI
> +
> +static const struct acpi_device_id plic_acpi_match[] =3D {
> +       { "RSCV0001", 0 },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, plic_acpi_match);
> +
> +#endif
>  static int plic_parse_nr_irqs_and_contexts(struct platform_device *pdev,
> -                                          u32 *nr_irqs, u32 *nr_contexts=
)
> +                                          u32 *nr_irqs, u32 *nr_contexts=
,
> +                                          u32 *gsi_base, u32 *id)
>  {
>         struct device *dev =3D &pdev->dev;
>         int rc;
>
> -       /*
> -        * Currently, only OF fwnode is supported so extend this
> -        * function for ACPI support.
> -        */
> -       if (!is_of_node(dev->fwnode))
> -               return -EINVAL;
> +       if (!is_of_node(dev->fwnode)) {
> +               rc =3D riscv_acpi_get_gsi_info(dev->fwnode, gsi_base, id,=
 nr_irqs, NULL);
> +               if (rc) {
> +                       dev_err(dev, "failed to find GSI mapping\n");
> +                       return rc;
> +               }
> +
> +               *nr_contexts =3D acpi_get_plic_nr_contexts(*id);
> +               if (WARN_ON(!*nr_contexts)) {
> +                       dev_err(dev, "no PLIC context available\n");
> +                       return -EINVAL;
> +               }
> +
> +               return 0;
> +       }
>
>         rc =3D of_property_read_u32(to_of_node(dev->fwnode), "riscv,ndev"=
, nr_irqs);
>         if (rc) {
> @@ -449,23 +475,29 @@ static int plic_parse_nr_irqs_and_contexts(struct p=
latform_device *pdev,
>                 return -EINVAL;
>         }
>
> +       *gsi_base =3D 0;
> +       *id =3D 0;
> +
>         return 0;
>  }
>
>  static int plic_parse_context_parent(struct platform_device *pdev, u32 c=
ontext,
> -                                    u32 *parent_hwirq, int *parent_cpu)
> +                                    u32 *parent_hwirq, int *parent_cpu, =
u32 id)
>  {
>         struct device *dev =3D &pdev->dev;
>         struct of_phandle_args parent;
>         unsigned long hartid;
>         int rc;
>
> -       /*
> -        * Currently, only OF fwnode is supported so extend this
> -        * function for ACPI support.
> -        */
> -       if (!is_of_node(dev->fwnode))
> -               return -EINVAL;
> +       if (!is_of_node(dev->fwnode)) {
> +               hartid =3D acpi_get_ext_intc_parent_hartid(id, context);
> +               if (hartid =3D=3D INVALID_HARTID)
> +                       return -EINVAL;
> +
> +               *parent_cpu =3D riscv_hartid_to_cpuid(hartid);
> +               *parent_hwirq =3D RV_IRQ_EXT;
> +               return 0;
> +       }
>
>         rc =3D of_irq_parse_one(to_of_node(dev->fwnode), context, &parent=
);
>         if (rc)
> @@ -489,6 +521,8 @@ static int plic_probe(struct platform_device *pdev)
>         u32 nr_irqs, parent_hwirq;
>         struct plic_priv *priv;
>         irq_hw_number_t hwirq;
> +       int id, context_id;
> +       u32 gsi_base;
>
>         if (is_of_node(dev->fwnode)) {
>                 const struct of_device_id *id;
> @@ -498,7 +532,7 @@ static int plic_probe(struct platform_device *pdev)
>                         plic_quirks =3D (unsigned long)id->data;
>         }
>
> -       error =3D plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_con=
texts);
> +       error =3D plic_parse_nr_irqs_and_contexts(pdev, &nr_irqs, &nr_con=
texts, &gsi_base, &id);
>         if (error)
>                 return error;
>
> @@ -509,6 +543,8 @@ static int plic_probe(struct platform_device *pdev)
>         priv->dev =3D dev;
>         priv->plic_quirks =3D plic_quirks;
>         priv->nr_irqs =3D nr_irqs;
> +       priv->gsi_base =3D gsi_base;
> +       priv->id =3D id;
>
>         priv->regs =3D devm_platform_ioremap_resource(pdev, 0);
>         if (WARN_ON(!priv->regs))
> @@ -519,12 +555,22 @@ static int plic_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         for (i =3D 0; i < nr_contexts; i++) {
> -               error =3D plic_parse_context_parent(pdev, i, &parent_hwir=
q, &cpu);
> +               error =3D plic_parse_context_parent(pdev, i, &parent_hwir=
q, &cpu, priv->id);
>                 if (error) {
>                         dev_warn(dev, "hwirq for context%d not found\n", =
i);
>                         continue;
>                 }
>
> +               if (is_of_node(dev->fwnode)) {
> +                       context_id =3D i;
> +               } else {
> +                       context_id =3D acpi_get_plic_context(priv->id, i)=
;
> +                       if (context_id =3D=3D INVALID_CONTEXT) {
> +                               dev_warn(dev, "invalid context id for con=
text%d\n", i);
> +                               continue;
> +                       }
> +               }
> +
>                 /*
>                  * Skip contexts other than external interrupts for our
>                  * privilege level.
> @@ -562,10 +608,10 @@ static int plic_probe(struct platform_device *pdev)
>                 cpumask_set_cpu(cpu, &priv->lmask);
>                 handler->present =3D true;
>                 handler->hart_base =3D priv->regs + CONTEXT_BASE +
> -                       i * CONTEXT_SIZE;
> +                       context_id * CONTEXT_SIZE;
>                 raw_spin_lock_init(&handler->enable_lock);
>                 handler->enable_base =3D priv->regs + CONTEXT_ENABLE_BASE=
 +
> -                       i * CONTEXT_ENABLE_SIZE;
> +                       context_id * CONTEXT_ENABLE_SIZE;
>                 handler->priv =3D priv;
>
>                 handler->enable_save =3D devm_kcalloc(dev, DIV_ROUND_UP(n=
r_irqs, 32),
> @@ -581,8 +627,8 @@ static int plic_probe(struct platform_device *pdev)
>                 nr_handlers++;
>         }
>
> -       priv->irqdomain =3D irq_domain_add_linear(to_of_node(dev->fwnode)=
, nr_irqs + 1,
> -                                               &plic_irqdomain_ops, priv=
);
> +       priv->irqdomain =3D irq_domain_create_linear(dev->fwnode, nr_irqs=
 + 1,
> +                                                  &plic_irqdomain_ops, p=
riv);
>         if (WARN_ON(!priv->irqdomain))
>                 goto fail_cleanup_contexts;
>
> @@ -619,13 +665,18 @@ static int plic_probe(struct platform_device *pdev)
>                 }
>         }
>
> +#ifdef CONFIG_ACPI
> +       if (!acpi_disabled)
> +               acpi_dev_clear_dependencies(ACPI_COMPANION(dev));
> +#endif
> +
>         dev_info(dev, "mapped %d interrupts with %d handlers for %d conte=
xts.\n",
>                  nr_irqs, nr_handlers, nr_contexts);
>         return 0;
>
>  fail_cleanup_contexts:
>         for (i =3D 0; i < nr_contexts; i++) {
> -               if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cp=
u))
> +               if (plic_parse_context_parent(pdev, i, &parent_hwirq, &cp=
u, priv->id))
>                         continue;
>                 if (parent_hwirq !=3D RV_IRQ_EXT || cpu < 0)
>                         continue;
> @@ -644,6 +695,7 @@ static struct platform_driver plic_driver =3D {
>         .driver =3D {
>                 .name           =3D "riscv-plic",
>                 .of_match_table =3D plic_match,
> +               .acpi_match_table =3D ACPI_PTR(plic_acpi_match),
>         },
>         .probe =3D plic_probe,
>  };
> --
> 2.43.0
>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

