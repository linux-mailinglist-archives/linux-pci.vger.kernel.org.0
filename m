Return-Path: <linux-pci+bounces-11363-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D0D949469
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B6F02882DB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70442AF15;
	Tue,  6 Aug 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="jHphYok6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB721105
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957769; cv=none; b=f959NUoJPW0v4354or5K19FDOjF2rVFYplCaRkx6JFAsGgv9ovPfDzj5BZDZL1WL9XB6n68oG+8jS7lAS1clkGtE9D7Q+IOst/N0t0KhjV9IvC/ASI6jPHY+805besxu1oApEGP597GKAI15dITmPdl/hMYdUDtd/gW/ntzRUoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957769; c=relaxed/simple;
	bh=XRx9VH/ThNvkQFNhb5kmyBFfJnrqQp5grG+upjC91Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ndOsutLemEmaf/ZQtgrDNmZkaOTkywLpnMyr+An8IM3ZaOYHdmcmQ4lajkRW/L64WP2h00ptjNpBTVmTEJHyjUti0mXI5GJDiNB9ZD+3uzQIVPZfGwOTlAMsKSARoUBVDkZfV8O/UFXNltXsLCCPXVxqy3sWD3Agv1+Z8+abfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=jHphYok6; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-39834949e42so2581045ab.1
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722957766; x=1723562566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZK/SAMkK6qN158OD2MUZR6P1q11CC48toriFO0gX24=;
        b=jHphYok6mSgxH5BY01LX3Dq4lAUcPlQAf6+F8DAMtby714CdHtvhvjbL9UGd5/mRRB
         gvYRMvcavYTpZ5D2YdZLhnqzN+sevDaVE1prxtsxJVBNoo/UXKqwip8JIX4EJTG66lvC
         S6IA9qLRO1QURMHY7b9cqveOkd+QGbpttp1TkMLN6ztNNMy93G0CeX5N2vjEUoI6kH6w
         6m2OkpnG/tyBk90XWaQivM14GoqZU6qAr0iQhM0Sk6A3y0NluHtKY15dLuMJGU65OWPY
         WxuBdI3+Vk2bE2/NbavTp+HeTQaR+eSv3pwfmLw9V6TP+cIIIwnzwH+7F/SDNL1KKOV+
         hw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722957766; x=1723562566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gZK/SAMkK6qN158OD2MUZR6P1q11CC48toriFO0gX24=;
        b=mPPOs7yRj4Dn75/1I/q9cvuRvWyEV9DNuhwDNWieNUTjZFS+5GD61UcY0TExu0jMud
         s24QVEcuXmfitIM/lA6HrVD0tqqgEz5IMXaRp92rsKbIXgLubr5b1qOD+QSf3a16H984
         7vjx+9WWIVe5o9kO0QEdHje0wvJmSyHEjkW27t0wJJiifP4u4f/grPkFGmNMA/Y0VYTq
         ynoY1VwlcbQqA6TJ5m3qElKcvIJBZq1dUPluxE/+sek9VbQVd6O1jlqjxQ/Q02BBq/O4
         /jKMmjZhcS3tbirBvJ02irgpsIJqDvbPGHTEyHBrspRwiYnIgkpU7OC09L46M4IPVNh2
         51pA==
X-Forwarded-Encrypted: i=1; AJvYcCWQX6bVQNOVV3Kb4hMZb2mUtAKEkdAufO1ygjCAYwOxYCxB2bkKC6H7xUCOpIyBiGFXqfUXkfRwGEbXp6d+Gy7RJpkZrwg/GGbC
X-Gm-Message-State: AOJu0YzlLi0QQuv77GhnlMoEwbyV5e3L4iP2baDVge3X4wButMoD8HbR
	vkTNCAudkjB5QUW8I66BCybNG/Dr/p6IhKMa3tyBqhAuzbIWMboY+u8MLRKL89sgaH9qLwNezJ6
	wupZAfX2n7A4KhSH/KVPWGoDfDW+Pyro6yKCGcw==
X-Google-Smtp-Source: AGHT+IGoYopgvARvXhcov69tPNfXLq0wMn0uqHERJincoJcvdaUmpe1P134PN7KjzYlHQPv82EElloRMNkb9vreilnQ=
X-Received: by 2002:a92:6506:0:b0:398:ca2b:2537 with SMTP id
 e9e14a558f8ab-39b1fb6ab2emr164960855ab.3.1722957766329; Tue, 06 Aug 2024
 08:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729142241.733357-1-sunilvl@ventanamicro.com> <20240729142241.733357-14-sunilvl@ventanamicro.com>
In-Reply-To: <20240729142241.733357-14-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Aug 2024 20:52:35 +0530
Message-ID: <CAAhSdy0BMDNZ3ks4xQkT5cyg_Jg8J2yq7+1CzYyNayP+shBHcw@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] irqchip/riscv-intc: Add ACPI support for AIA
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
> The RINTC subtype structure in MADT also has information about other
> interrupt controllers. Save this information and provide interfaces to
> retrieve them when required by corresponding drivers.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/irq.h     | 33 ++++++++++++
>  drivers/irqchip/irq-riscv-intc.c | 90 ++++++++++++++++++++++++++++++++
>  2 files changed, 123 insertions(+)
>
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 44a0b128c602..51d86f0b80d2 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -12,6 +12,8 @@
>
>  #include <asm-generic/irq.h>
>
> +#define INVALID_CONTEXT UINT_MAX
> +
>  void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
>
>  struct fwnode_handle *riscv_get_intc_hwnode(void);
> @@ -28,6 +30,11 @@ enum riscv_irqchip_type {
>  int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
>                             u32 *id, u32 *nr_irqs, u32 *nr_idcs);
>  struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);

I suggest the below renaming to make it explicit that these are RINTC funct=
ions.

> +unsigned long acpi_get_intc_index_hartid(u32 index);

s/acpi_get_intc_index_hartid/acpi_rintc_index_to_hartid/

> +unsigned long acpi_get_ext_intc_parent_hartid(unsigned int plic_id, unsi=
gned int ctxt_idx);

s/acpi_get_ext_intc_parent_hartid/acpi_rintc_ext_parent_to_hartid/

> +unsigned int acpi_get_plic_nr_contexts(unsigned int plic_id);

s/acpi_get_plic_nr_contexts/acpi_rintc_get_plic_nr_contexts/

> +unsigned int acpi_get_plic_context(unsigned int plic_id, unsigned int ct=
xt_idx);

s/acpi_get_plic_context/acpi_rintc_get_plic_context/

> +int __init acpi_get_imsic_mmio_info(u32 index, struct resource *res);

s/acpi_get_imsic_mmio_info/acpi_rintc_get_imsic_mmio_info/

>
>  #else
>  static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, =
u32 *gsi_base,
> @@ -36,6 +43,32 @@ static inline int riscv_acpi_get_gsi_info(struct fwnod=
e_handle *fwnode, u32 *gsi
>         return 0;
>  }
>
> +static inline unsigned long acpi_get_intc_index_hartid(u32 index)
> +{
> +       return INVALID_HARTID;
> +}
> +
> +static inline unsigned long acpi_get_ext_intc_parent_hartid(unsigned int=
 plic_id,
> +                                                           unsigned int =
ctxt_idx)
> +{
> +       return INVALID_HARTID;
> +}
> +
> +static inline unsigned int acpi_get_plic_nr_contexts(unsigned int plic_i=
d)
> +{
> +       return INVALID_CONTEXT;
> +}
> +
> +static inline unsigned int acpi_get_plic_context(unsigned int plic_id, u=
nsigned int ctxt_idx)
> +{
> +       return INVALID_CONTEXT;
> +}
> +
> +static inline int __init acpi_get_imsic_mmio_info(u32 index, struct reso=
urce *res)
> +{
> +       return 0;
> +}
> +
>  #endif /* CONFIG_ACPI */
>
>  #endif /* _ASM_RISCV_IRQ_H */
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv=
-intc.c
> index 47f3200476da..5ddb12ce8b97 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -250,6 +250,85 @@ IRQCHIP_DECLARE(andes, "andestech,cpu-intc", riscv_i=
ntc_init);
>
>  #ifdef CONFIG_ACPI
>
> +struct rintc_data {
> +       union {
> +               u32             ext_intc_id;
> +               struct {
> +                       u32     context_id      : 16,
> +                               reserved        :  8,
> +                               aplic_plic_id   :  8;
> +               };
> +       };
> +       unsigned long           hart_id;
> +       u64                     imsic_addr;
> +       u32                     imsic_size;
> +};
> +
> +static u32 nr_rintc;
> +static struct rintc_data *rintc_acpi_data[NR_CPUS];
> +
> +#define for_each_matching_plic(_plic_id)                               \
> +       unsigned int _plic;                                             \
> +                                                                       \
> +       for (_plic =3D 0; _plic < nr_rintc; _plic++)                     =
 \
> +               if (rintc_acpi_data[_plic]->aplic_plic_id !=3D _plic_id) =
 \
> +                       continue;                                       \
> +               else
> +
> +unsigned int acpi_get_plic_nr_contexts(unsigned int plic_id)
> +{
> +       unsigned int nctx =3D 0;
> +
> +       for_each_matching_plic(plic_id)
> +               nctx++;
> +
> +       return nctx;
> +}
> +
> +static struct rintc_data *get_plic_context(unsigned int plic_id, unsigne=
d int ctxt_idx)
> +{
> +       unsigned int ctxt =3D 0;
> +
> +       for_each_matching_plic(plic_id) {
> +               if (ctxt =3D=3D ctxt_idx)
> +                       return rintc_acpi_data[_plic];
> +
> +               ctxt++;
> +       }
> +
> +       return NULL;
> +}
> +
> +unsigned long acpi_get_ext_intc_parent_hartid(unsigned int plic_id, unsi=
gned int ctxt_idx)
> +{
> +       struct rintc_data *data =3D get_plic_context(plic_id, ctxt_idx);
> +
> +       return data ? data->hart_id : INVALID_HARTID;
> +}
> +
> +unsigned int acpi_get_plic_context(unsigned int plic_id, unsigned int ct=
xt_idx)
> +{
> +       struct rintc_data *data =3D get_plic_context(plic_id, ctxt_idx);
> +
> +       return data ? data->context_id : INVALID_CONTEXT;
> +}
> +
> +unsigned long acpi_get_intc_index_hartid(u32 index)
> +{
> +       return index >=3D nr_rintc ? INVALID_HARTID : rintc_acpi_data[ind=
ex]->hart_id;
> +}
> +
> +int acpi_get_imsic_mmio_info(u32 index, struct resource *res)
> +{
> +       if (index >=3D nr_rintc)
> +               return -1;
> +
> +       res->start =3D rintc_acpi_data[index]->imsic_addr;
> +       res->end =3D res->start + rintc_acpi_data[index]->imsic_size - 1;
> +       res->flags =3D IORESOURCE_MEM;
> +       return 0;
> +}
> +
>  static int __init riscv_intc_acpi_init(union acpi_subtable_headers *head=
er,
>                                        const unsigned long end)
>  {
> @@ -258,6 +337,15 @@ static int __init riscv_intc_acpi_init(union acpi_su=
btable_headers *header,
>         int rc;
>
>         rintc =3D (struct acpi_madt_rintc *)header;
> +       rintc_acpi_data[nr_rintc] =3D kzalloc(sizeof(*rintc_acpi_data[0])=
, GFP_KERNEL);
> +       if (!rintc_acpi_data[nr_rintc])
> +               return -ENOMEM;
> +
> +       rintc_acpi_data[nr_rintc]->ext_intc_id =3D rintc->ext_intc_id;
> +       rintc_acpi_data[nr_rintc]->hart_id =3D rintc->hart_id;
> +       rintc_acpi_data[nr_rintc]->imsic_addr =3D rintc->imsic_addr;
> +       rintc_acpi_data[nr_rintc]->imsic_size =3D rintc->imsic_size;
> +       nr_rintc++;
>
>         /*
>          * The ACPI MADT will have one INTC for each CPU (or HART)
> @@ -277,6 +365,8 @@ static int __init riscv_intc_acpi_init(union acpi_sub=
table_headers *header,
>         rc =3D riscv_intc_init_common(fn, &riscv_intc_chip);
>         if (rc)
>                 irq_domain_free_fwnode(fn);
> +       else
> +               acpi_set_irq_model(ACPI_IRQ_MODEL_RINTC, riscv_acpi_get_g=
si_domain_id);
>
>         return rc;
>  }
> --
> 2.43.0
>

Otherwise, this looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

