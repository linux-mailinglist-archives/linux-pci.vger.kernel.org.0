Return-Path: <linux-pci+bounces-44052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1FCF52FB
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 19:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D13A3002FF3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 18:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522C033A9CC;
	Mon,  5 Jan 2026 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebI+ijbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCAB335572
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767636536; cv=none; b=oFwYdYb9zYEkL6F4JZJdCyNOGRsSmc99oR4P+Z4/iP1aob2LSCWV9g1lx6CrtoPQRawcoftuY3oCsg+qIw7HQ1ZWa98bOlzpjLd+eUDbXkpW/wVZ7zv14kAK1i9QIYUQkPZe9qEB+6F3RWSB0PyqRks63v1XVH4n7c8h+KX2AHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767636536; c=relaxed/simple;
	bh=lkPrL+pR093lymW39hhIyYAn2c3AnvDhe7DdkRle8jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kttPxHHiTALSF0n6jV+ILbndjdC06L+C1j7fIrMTHsxhxH6bvzV2QcZW07Oj1OG9O4cOI5JlaPBCa1B3hU5v3x8aMi5ievHgK4Gy5T756FMQHDjmgAuDVuQ1BQfVeN7YbROJ8hZ3XShKnbgVGjq6bitm22L4/3IU7BusP3ciOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebI+ijbd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66E2C4AF0B
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767636535;
	bh=lkPrL+pR093lymW39hhIyYAn2c3AnvDhe7DdkRle8jo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ebI+ijbdrmCaYe+5hA+4Sb6qtBEToT/Jngwm1ylXfLzuT+B0xBmBLaEfATppGGerQ
	 oHihjEmQyCDAF6l+5m7HgfNfRXiA8aMSRROX13UMiyPIV+1C0/6DON+rkmExyFrkyL
	 Nb+sKNLrRYy0a9cfWlV70CbJSIoKN9evhwi0O06Ix7DZsHMCfTlDCYu63yEzvcAOuE
	 t/GrEooUiK6mmLJWtfgul2utjz83RyVTznMDwUpvhq9EvkViNRYWSypQpBTevycP88
	 h5k68HVsfBT/lR/8HKIb/hafu8zAx294v//ovH+vGLf/Io5mz/4R/2kL5hc+sbZVfP
	 6uZxC24rXp8IA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-3e0f19a38d0so151379fac.0
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 10:08:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcf3UQBbAKvpuBG+zXHj2th7wwhWTyUQBrdkdAJP5E44E3G1xifcYMryz/L1Dzw3ZBIS6AnSdybPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ4fi59HXakUNPMpjGpWoYSdLFtvnXhUdAjO7bSpXHTuMtZsty
	/UFMheN9wR+WMDzB8or7TNTn18ZvEAQ/EMsIS3uXiL1Nr6UkFGiGaD2LeS3CIijCnOa7BCeWGmv
	2StecU25X1t+XEMbgrUW9gBnHEfpuA1Y=
X-Google-Smtp-Source: AGHT+IE72e8H9jfTf8cEfj+JLx+mwDAFCjkAW4MuVapdljSZE/hSN+HQC2lNI8AsEJCzfIXJiFdBimbTL2R7qCpw2P0=
X-Received: by 2002:a05:6820:6582:b0:657:5629:2cef with SMTP id
 006d021491bc7-65f479d9510mr133819eaf.4.1767636534934; Mon, 05 Jan 2026
 10:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105101705.36703-1-lpieralisi@kernel.org>
In-Reply-To: <20260105101705.36703-1-lpieralisi@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 5 Jan 2026 19:08:44 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jLftD-A4HDfTvo0xBenBuxg-jRS-abAB7LKYtTWXpbng@mail.gmail.com>
X-Gm-Features: AQt7F2okhhoNq9IAs0n85ibXEhGypJaFqS2BdPp4J5GQ6Fqs1vJt6s73RV0JHLI
Message-ID: <CAJZ5v0jLftD-A4HDfTvo0xBenBuxg-jRS-abAB7LKYtTWXpbng@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PCI: IRQ: Fix INTx GSIs signedness
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 11:17=E2=80=AFAM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> In ACPI Global System Interrupts (GSIs) are described using a 32-bit
> value.
>
> ACPI/PCI legacy interrupts (INTx) parsing code treats GSIs as 'int', whic=
h
> poses issues if the GSI interrupt value is a 32-bit value with the MSB se=
t
> (as required in some interrupt configurations - eg ARM64 GICv5 systems)
> because acpi_pci_link_allocate_irq() treats a negative gsi return value
> as a failed GSI allocation (and acpi_irq_get_penalty() would trigger
> an out-of-bounds array dereference if the 'irq' param is a negative
> value).
>
> Fix ACPI/PCI legacy INTx parsing by converting variables representing
> GSIs from 'int' to 'u32' bringing the code in line with the ACPI
> specification and fixing the current parsing issue.
>
> Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
> v1 -> v2:
>         - Reworded commit log
>         - Added Bjorn's review tag
> v1: https://lore.kernel.org/lkml/20251231092615.3014761-1-lpieralisi@kern=
el.org
>
>  drivers/acpi/pci_irq.c      | 19 ++++++++++--------
>  drivers/acpi/pci_link.c     | 39 ++++++++++++++++++++++++-------------
>  drivers/xen/acpi.c          | 13 +++++++------
>  include/acpi/acpi_drivers.h |  2 +-
>  4 files changed, 44 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index ad81aa03fe2f..c416942ff3e2 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -188,7 +188,7 @@ static int acpi_pci_irq_check_entry(acpi_handle handl=
e, struct pci_dev *dev,
>          * the IRQ value, which is hardwired to specific interrupt inputs=
 on
>          * the interrupt controller.
>          */
> -       pr_debug("%04x:%02x:%02x[%c] -> %s[%d]\n",
> +       pr_debug("%04x:%02x:%02x[%c] -> %s[%u]\n",
>                  entry->id.segment, entry->id.bus, entry->id.device,
>                  pin_name(entry->pin), prt->source, entry->index);
>
> @@ -384,7 +384,7 @@ static inline bool acpi_pci_irq_valid(struct pci_dev =
*dev, u8 pin)
>  int acpi_pci_irq_enable(struct pci_dev *dev)
>  {
>         struct acpi_prt_entry *entry;
> -       int gsi;
> +       u32 gsi;
>         u8 pin;
>         int triggering =3D ACPI_LEVEL_SENSITIVE;
>         /*
> @@ -422,18 +422,21 @@ int acpi_pci_irq_enable(struct pci_dev *dev)
>                         return 0;
>         }
>
> +       rc =3D -ENODEV;
> +
>         if (entry) {
>                 if (entry->link)
> -                       gsi =3D acpi_pci_link_allocate_irq(entry->link,
> +                       rc =3D acpi_pci_link_allocate_irq(entry->link,
>                                                          entry->index,
>                                                          &triggering, &po=
larity,
> -                                                        &link);
> -               else
> +                                                        &link, &gsi);
> +               else {
>                         gsi =3D entry->index;
> -       } else
> -               gsi =3D -1;
> +                       rc =3D 0;
> +               }
> +       }
>
> -       if (gsi < 0) {
> +       if (rc < 0) {
>                 /*
>                  * No IRQ known to the ACPI subsystem - maybe the BIOS /
>                  * driver reported one, then use it. Exit in any case.
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index bed7dc85612e..b91b039a3d20 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -448,7 +448,7 @@ static int acpi_isa_irq_penalty[ACPI_MAX_ISA_IRQS] =
=3D {
>         /* >IRQ15 */
>  };
>
> -static int acpi_irq_pci_sharing_penalty(int irq)
> +static int acpi_irq_pci_sharing_penalty(u32 irq)
>  {
>         struct acpi_pci_link *link;
>         int penalty =3D 0;
> @@ -474,7 +474,7 @@ static int acpi_irq_pci_sharing_penalty(int irq)
>         return penalty;
>  }
>
> -static int acpi_irq_get_penalty(int irq)
> +static int acpi_irq_get_penalty(u32 irq)
>  {
>         int penalty =3D 0;
>
> @@ -528,7 +528,7 @@ static int acpi_irq_balance =3D -1;   /* 0: static, 1=
: balance */
>  static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  {
>         acpi_handle handle =3D link->device->handle;
> -       int irq;
> +       u32 irq;
>         int i;
>
>         if (link->irq.initialized) {
> @@ -598,44 +598,53 @@ static int acpi_pci_link_allocate(struct acpi_pci_l=
ink *link)
>         return 0;
>  }
>
> -/*
> - * acpi_pci_link_allocate_irq
> - * success: return IRQ >=3D 0
> - * failure: return -1
> +/**
> + * acpi_pci_link_allocate_irq(): Retrieve a link device GSI
> + *
> + * @handle: Handle for the link device
> + * @index: GSI index
> + * @triggering: pointer to store the GSI trigger
> + * @polarity: pointer to store GSI polarity
> + * @name: pointer to store link device name
> + * @gsi: pointer to store GSI number
> + *
> + * Returns:
> + *     0 on success with @triggering, @polarity, @name, @gsi initialized=
.
> + *     -ENODEV on failure
>   */
>  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *trigg=
ering,
> -                              int *polarity, char **name)
> +                              int *polarity, char **name, u32 *gsi)
>  {
>         struct acpi_device *device =3D acpi_fetch_acpi_dev(handle);
>         struct acpi_pci_link *link;
>
>         if (!device) {
>                 acpi_handle_err(handle, "Invalid link device\n");
> -               return -1;
> +               return -ENODEV;
>         }
>
>         link =3D acpi_driver_data(device);
>         if (!link) {
>                 acpi_handle_err(handle, "Invalid link context\n");
> -               return -1;
> +               return -ENODEV;
>         }
>
>         /* TBD: Support multiple index (IRQ) entries per Link Device */
>         if (index) {
>                 acpi_handle_err(handle, "Invalid index %d\n", index);
> -               return -1;
> +               return -ENODEV;
>         }
>
>         mutex_lock(&acpi_link_lock);
>         if (acpi_pci_link_allocate(link)) {
>                 mutex_unlock(&acpi_link_lock);
> -               return -1;
> +               return -ENODEV;
>         }
>
>         if (!link->irq.active) {
>                 mutex_unlock(&acpi_link_lock);
>                 acpi_handle_err(handle, "Link active IRQ is 0!\n");
> -               return -1;
> +               return -ENODEV;
>         }
>         link->refcnt++;
>         mutex_unlock(&acpi_link_lock);
> @@ -647,7 +656,9 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, in=
t index, int *triggering,
>         if (name)
>                 *name =3D acpi_device_bid(link->device);
>         acpi_handle_debug(handle, "Link is referenced\n");
> -       return link->irq.active;
> +       *gsi =3D link->irq.active;
> +
> +       return 0;
>  }
>
>  /*
> diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
> index d2ee605c5ca1..eab28cfe9939 100644
> --- a/drivers/xen/acpi.c
> +++ b/drivers/xen/acpi.c
> @@ -89,11 +89,11 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>                                                   int *trigger_out,
>                                                   int *polarity_out)
>  {
> -       int gsi;
> +       u32 gsi;
>         u8 pin;
>         struct acpi_prt_entry *entry;
>         int trigger =3D ACPI_LEVEL_SENSITIVE;
> -       int polarity =3D acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC ?
> +       int ret, polarity =3D acpi_irq_model =3D=3D ACPI_IRQ_MODEL_GIC ?
>                                       ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
>
>         if (!dev || !gsi_out || !trigger_out || !polarity_out)
> @@ -105,17 +105,18 @@ int xen_acpi_get_gsi_info(struct pci_dev *dev,
>
>         entry =3D acpi_pci_irq_lookup(dev, pin);
>         if (entry) {
> +               ret =3D 0;
>                 if (entry->link)
> -                       gsi =3D acpi_pci_link_allocate_irq(entry->link,
> +                       ret =3D acpi_pci_link_allocate_irq(entry->link,
>                                                          entry->index,
>                                                          &trigger, &polar=
ity,
> -                                                        NULL);
> +                                                        NULL, &gsi);
>                 else
>                         gsi =3D entry->index;
>         } else
> -               gsi =3D -1;
> +               ret =3D -ENODEV;
>
> -       if (gsi < 0)
> +       if (ret < 0)
>                 return -EINVAL;
>
>         *gsi_out =3D gsi;
> diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
> index b14d165632e7..402b97d12138 100644
> --- a/include/acpi/acpi_drivers.h
> +++ b/include/acpi/acpi_drivers.h
> @@ -51,7 +51,7 @@
>
>  int acpi_irq_penalty_init(void);
>  int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *trigg=
ering,
> -                              int *polarity, char **name);
> +                              int *polarity, char **name, u32 *gsi);
>  int acpi_pci_link_free_irq(acpi_handle handle);
>
>  /* ACPI PCI Device Binding */
> --

Applied as 6.19-rc material, thanks!

