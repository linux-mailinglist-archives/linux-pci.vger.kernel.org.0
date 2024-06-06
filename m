Return-Path: <linux-pci+bounces-8421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F168FF784
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 00:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA351C23DA0
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 22:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C5D13CF9C;
	Thu,  6 Jun 2024 22:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUByc/MS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D7A13C67B;
	Thu,  6 Jun 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717711666; cv=none; b=taVX/VX+oYKjbLx3p6TjOhzS8G9Cos1b2tx1IkovE/YKu2ew/A+j24TfOGeSQIaJier0XOmuUF7o9PrfUx1735odQ+ZtN4/IkJhtXI6PgVey95n7S4D6UH374xo1MJnzZl0hJtyMk37TxiIGATAA9hbkm1HVkxeU9pQg8oqplaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717711666; c=relaxed/simple;
	bh=lmfYmD8PocbYwBIvNsI0krEguZSlXT3D+X8GrfxCwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PMw//j00c0TByjxnH41uAfhv4edYfhbBfxPptwcdpgIFxF0JodYorEE7+CiaB4tALzw0f7cBbtXqNS+OiZi0MeOYn3mf5Cy1DzfGSTkJxym7wzvgiGtlkVWGwlG23K780fHCOVWeEMZQ3zWVPRBj1fLQtmuUlQFnxS1BxBI9XAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUByc/MS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334C5C2BD10;
	Thu,  6 Jun 2024 22:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717711665;
	bh=lmfYmD8PocbYwBIvNsI0krEguZSlXT3D+X8GrfxCwsE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sUByc/MSb83Ptm4NMe1WQeZUXt6PgScwLR/svMCB7dNs0qiSlijFVS7UO74+lbv03
	 V/VgBISdxd7O7DLgDJRA0zJbKk2DMvzD9NAehnW/bCA5WwCkyICdD/ESZ0ydeJ9M+0
	 DeTCL6fwp83ujDPM3nNFEX604YRGmERFIJbZg0AzU9ciGHhhJanRw1jnh7N55xCiUA
	 7k0ej9Ih+hsP8hBcl8cwblI1ztzEl7jkQopNqW7yJ8ml3qYMKNSMqWZZR1iQEvin6U
	 COmTqN/g03o5lQkqp79ziZnYsVODE9WCLQNg2L63OqLzhHsCKN3CtL7KDJknYwIv5X
	 tMPxWpSwNx9fA==
Date: Thu, 6 Jun 2024 17:07:43 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, acpica-devel@lists.linux.dev,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Subject: Re: [PATCH v6 10/17] ACPI: RISC-V: Implement function to reorder
 irqchip probe entries
Message-ID: <20240606220743.GA821335@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601150411.1929783-11-sunilvl@ventanamicro.com>

On Sat, Jun 01, 2024 at 08:34:04PM +0530, Sunil V L wrote:
> ACPI MADT entries for interrupt controllers don't have a way to describe
> the hierarchy. However, the hierarchy is known to the architecture and
> on RISC-V platforms, the MADT sub table types are ordered in the
> incremental order from the root controller which is RINTC. So, add
> architecture function for RISC-V to reorder the interrupt controller
> probing as per the hierarchy as below.

Is this ordering requirement documented anywhere?  I don't see it in
the RISC-V ECRs to the ACPI r6.5 spec.

I guess the implication is that you need to process MADT structures in
order of ascending acpi_madt_type:

  ACPI_MADT_TYPE_RINTC = 24,
  ACPI_MADT_TYPE_IMSIC = 25,
  ACPI_MADT_TYPE_APLIC = 26,
  ACPI_MADT_TYPE_PLIC = 27,

regardless of the order they appear in the MADT?  I.e., process all
the RINTC structures (in order of appearance in MADT), followed by all
the IMSIC structures, then all the APLIC structures, etc?

> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  drivers/acpi/riscv/Makefile |  2 +-
>  drivers/acpi/riscv/irq.c    | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/riscv/irq.c
> 
> diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
> index 877de00d1b50..a96fdf1e2cb8 100644
> --- a/drivers/acpi/riscv/Makefile
> +++ b/drivers/acpi/riscv/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y					+= rhct.o init.o
> +obj-y					+= rhct.o init.o irq.o
>  obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
> diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> new file mode 100644
> index 000000000000..f56e103a501f
> --- /dev/null
> +++ b/drivers/acpi/riscv/irq.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023-2024, Ventana Micro Systems Inc
> + *	Author: Sunil V L <sunilvl@ventanamicro.com>
> + *

Spurious blank line.

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/sort.h>
> +
> +static int irqchip_cmp_func(const void *in0, const void *in1)
> +{
> +	struct acpi_probe_entry *elem0 = (struct acpi_probe_entry *)in0;
> +	struct acpi_probe_entry *elem1 = (struct acpi_probe_entry *)in1;
> +
> +	return (elem0->type > elem1->type) - (elem0->type < elem1->type);
> +}
> +
> +/*
> + * RISC-V irqchips in MADT of ACPI spec are defined in the same order how
> + * they should be probed. Since IRQCHIP_ACPI_DECLARE doesn't define any
> + * order, this arch function will reorder the probe functions as per the
> + * required order for the architecture.

But this comment seems to contradict the commit log.  This comment
says you should process MADT structures in the order they appear in
the MADT.  But if that were the case, you wouldn't need to sort
anything.

Maybe "defined in the order they should be probed" means "in order of
increasing Interrupt Controller structure type value"?

> + */
> +void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
> +{
> +	struct acpi_probe_entry *ape = ap_head;
> +
> +	if (nr == 1 || !ACPI_COMPARE_NAMESEG(ACPI_SIG_MADT, ape->id))
> +		return;
> +	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
> +}
> -- 
> 2.40.1
> 

