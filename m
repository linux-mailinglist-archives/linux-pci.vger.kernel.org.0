Return-Path: <linux-pci+bounces-11365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F43949479
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 17:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A39289773
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2024 15:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E8115E8B;
	Tue,  6 Aug 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="EPSPNpfh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C32AE90
	for <linux-pci@vger.kernel.org>; Tue,  6 Aug 2024 15:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957947; cv=none; b=Y6I7WihaXt3/8AMtAIevrxk4VZ32F1xYuAoStacPFKxsNRNKc4OERE3cAalw4ElFFlIQfbuOKqOJLmi97AEM5teq3Wlm2ZljIqoA7LJu4Tz+TaM2XXuHgu3JrhqkTVT7vSJWYE9H+WkGGhGMxZcIuRv8IqlNgYmapSElE3EWpDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957947; c=relaxed/simple;
	bh=900LQubH8X088PQcoK6a0R1nFpSkYEOfMMzBW84XtcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odime726iBIrMV4daUpVtIaflrJE7RB7yY3onUeB9CYOLRQz40wwO1Swqu0g4UbbYlmHM7JNz3s1voF99KfghMwxUETzpu2P2OwJrpae2QlMf5WkrTwM/mjRqEoJCWBLpLe1hIiBBdRk6Td8RMcaWuChtm3nMBFYs/sjBNH8yTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=EPSPNpfh; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81fb80d3887so29953639f.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 08:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1722957945; x=1723562745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hSFaWzu7k5+i7urG/rB+QN7qlxFaVHDeVcWBVMpJHI=;
        b=EPSPNpfh2KnZAHOggU9OhZc2/HdqN0qQUSLkujWLKpg5flqKEGW2Ay/ZbKhs0ahw/Z
         IcVjGMeCYEFATUeRAIICeoLwNQCbuWoD4rcHU06Kkqn9M1qklxTwsnEl9HYBcUfHvXcm
         PXSLkiFK4A8ipp73EFdhhYv2jImqA0tRLlgrWZufrGygMpdTYHNXehYxfKFSQnDel8LU
         Flm6qQgfiRQzT90F43Sb/dfa0LXGGxUOBlikQavPbx+AvGpFkNFZNWdqHU7Fi3rw2nyO
         +rh/DTf+aWq6/LN/IUkN59qy7ogUmD9r/xfRKPQmrOfdFRfo0xdYQE5bTcEO2P2nel+m
         +7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722957945; x=1723562745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2hSFaWzu7k5+i7urG/rB+QN7qlxFaVHDeVcWBVMpJHI=;
        b=vIWt4bFeqzSgVP6SihQULkcmM5AP52l6MAftVQUk4FkHlpZJ3g316YDJCzNhzFGM+i
         h9cjop2gMQDHLfhRvvlIyJ1n49U7TK1CmaP+Bc14lD0yG7xlSfWz8VIGnTXyeuqL+Y4B
         yZFUs2t5QNYsFEhC9OODGxocI8Hh6Naji/TH/mK/CmYiRoLgqsQ94/433aCfgmx5mO2D
         lU0WYxWhu53TGXYTpPUWnBfvjGrFYr7f166tVVoS2RQOZbl9svuaGLcFAfzJBPRipw81
         6qbeqOlm5FZv9mPw1KJpuJI7xJoeSJs7PW8P9MNLDaWANTAfpj/fJ9DajPPYl+yB1AuJ
         uZkg==
X-Forwarded-Encrypted: i=1; AJvYcCV8zfCP7R8//dgRxUoe8lTkJ6INFqVPVA+0HXPTc5bVLPlLcjuoBRb+mnWT/SSvx0PgrbfVrCQVf4Ug/3Dw1HN+ZxM/hUgzhMgL
X-Gm-Message-State: AOJu0Yx/gqT8sCsRaaqSRKFxpVJDL7oxtkESLOObwZZnLJz1mjdu/js0
	E96eLQXlk86C+t4w4tRHA3w/xkCBOh/6t4kgOMpEb70RkVn+jIXbraFZJrAUCdv6Dc00xbpKZJG
	+ZFC3EV/jG81Ji0vkstNth3Id004RQ9PWb+dhtg==
X-Google-Smtp-Source: AGHT+IFRjj14ZK3zQwhUJXXLBufMqLIkirrDvsuwso/YZ1pLiuKaOUUkzxwFjczveLiPrX3RKPs/9rVwHlLGeDyxf6w=
X-Received: by 2002:a05:6e02:1645:b0:39b:375a:f8b7 with SMTP id
 e9e14a558f8ab-39b375afc45mr146160275ab.23.1722957945281; Tue, 06 Aug 2024
 08:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240729142241.733357-1-sunilvl@ventanamicro.com> <20240729142241.733357-15-sunilvl@ventanamicro.com>
In-Reply-To: <20240729142241.733357-15-sunilvl@ventanamicro.com>
From: Anup Patel <anup@brainfault.org>
Date: Tue, 6 Aug 2024 20:55:34 +0530
Message-ID: <CAAhSdy2ATNkx4cpMLpVrBUbxSG+WVbOFpMA8LQcMAE2jGSs4ng@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] irqchip/riscv-imsic-state: Create separate
 function for DT
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
> While populating IMSIC global structure, many fields are initialized
> using DT properties. Make the code which uses DT properties as separate
> function so that it is easier to add ACPI support later. No
> functionality added/changed.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  drivers/irqchip/irq-riscv-imsic-state.c | 97 ++++++++++++++-----------
>  1 file changed, 55 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/ir=
q-riscv-imsic-state.c
> index 5479f872e62b..f9e70832863a 100644
> --- a/drivers/irqchip/irq-riscv-imsic-state.c
> +++ b/drivers/irqchip/irq-riscv-imsic-state.c
> @@ -510,6 +510,60 @@ static int __init imsic_matrix_init(void)
>         return 0;
>  }
>
> +static int __init imsic_populate_global_dt(struct fwnode_handle *fwnode,
> +                                          struct imsic_global_config *gl=
obal,
> +                                          u32 *nr_parent_irqs)
> +{
> +       int rc;
> +
> +       /* Find number of guest index bits in MSI address */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,guest-inde=
x-bits",
> +                                 &global->guest_index_bits);
> +       if (rc)
> +               global->guest_index_bits =3D 0;
> +
> +       /* Find number of HART index bits */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,hart-index=
-bits",
> +                                 &global->hart_index_bits);
> +       if (rc) {
> +               /* Assume default value */
> +               global->hart_index_bits =3D __fls(*nr_parent_irqs);
> +               if (BIT(global->hart_index_bits) < *nr_parent_irqs)
> +                       global->hart_index_bits++;
> +       }
> +
> +       /* Find number of group index bits */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-bits",
> +                                 &global->group_index_bits);
> +       if (rc)
> +               global->group_index_bits =3D 0;
> +
> +       /*
> +        * Find first bit position of group index.
> +        * If not specified assumed the default APLIC-IMSIC configuration=
.
> +        */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-shift",
> +                                 &global->group_index_shift);
> +       if (rc)
> +               global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
> +
> +       /* Find number of interrupt identities */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> +                                 &global->nr_ids);
> +       if (rc) {
> +               pr_err("%pfwP: number of interrupt identities not found\n=
", fwnode);
> +               return rc;
> +       }
> +
> +       /* Find number of guest interrupt identities */
> +       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-=
ids",
> +                                 &global->nr_guest_ids);
> +       if (rc)
> +               global->nr_guest_ids =3D global->nr_ids;
> +
> +       return 0;
> +}
> +
>  static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
>                                           u32 index, unsigned long *harti=
d)
>  {
> @@ -578,50 +632,9 @@ static int __init imsic_parse_fwnode(struct fwnode_h=
andle *fwnode,
>                 return -EINVAL;
>         }
>
> -       /* Find number of guest index bits in MSI address */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,guest-inde=
x-bits",
> -                                 &global->guest_index_bits);
> +       rc =3D imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
>         if (rc)
> -               global->guest_index_bits =3D 0;
> -
> -       /* Find number of HART index bits */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,hart-index=
-bits",
> -                                 &global->hart_index_bits);
> -       if (rc) {
> -               /* Assume default value */
> -               global->hart_index_bits =3D __fls(*nr_parent_irqs);
> -               if (BIT(global->hart_index_bits) < *nr_parent_irqs)
> -                       global->hart_index_bits++;
> -       }
> -
> -       /* Find number of group index bits */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-bits",
> -                                 &global->group_index_bits);
> -       if (rc)
> -               global->group_index_bits =3D 0;
> -
> -       /*
> -        * Find first bit position of group index.
> -        * If not specified assumed the default APLIC-IMSIC configuration=
.
> -        */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,group-inde=
x-shift",
> -                                 &global->group_index_shift);
> -       if (rc)
> -               global->group_index_shift =3D IMSIC_MMIO_PAGE_SHIFT * 2;
> -
> -       /* Find number of interrupt identities */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-ids",
> -                                 &global->nr_ids);
> -       if (rc) {
> -               pr_err("%pfwP: number of interrupt identities not found\n=
", fwnode);
>                 return rc;
> -       }
> -
> -       /* Find number of guest interrupt identities */
> -       rc =3D of_property_read_u32(to_of_node(fwnode), "riscv,num-guest-=
ids",
> -                                 &global->nr_guest_ids);
> -       if (rc)
> -               global->nr_guest_ids =3D global->nr_ids;
>
>         /* Sanity check guest index bits */
>         i =3D BITS_PER_LONG - IMSIC_MMIO_PAGE_SHIFT;
> --
> 2.43.0
>

