Return-Path: <linux-pci+bounces-10057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 410AD92CFBD
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 12:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64B2E1C23AC9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66B818784E;
	Wed, 10 Jul 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ul/DvtK2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A018D13AD22;
	Wed, 10 Jul 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720608314; cv=none; b=AkIYdZTxhaKAEIDktLUO+sPDk1dfzS5KDk1qIu8Z1ieifotcdJJeYvISUZJ5yK1lZijpllZXTyl895mNuQAoQeKn3se9rO/tzLuro3SJhrS/z8Ed5ztt1EAClK0fX7ujh5Ufv9UTr2qWBqwurlySnhw4CY20zki6x3xG4sMvrWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720608314; c=relaxed/simple;
	bh=LE/oYnTYJnZzNSZjVdRZsuFUBrpiaPaP6arHr61Ezs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoOM2yd5+b7fpm2A1BmwzgCbtMxjBpcaT9GnjrRmO9cQlLhJubgZHxKppTHDzL6ugZQwlM8kn9zSyH7SnmiIaqpYkgCUjH2bjHFVLf80i+InfoSIs+jTEy/6xcclM28n4cJqr05WT4phEJBB9rDw4ybEkF8MHf8bDCmg8B1sy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ul/DvtK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBE4C32781;
	Wed, 10 Jul 2024 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720608314;
	bh=LE/oYnTYJnZzNSZjVdRZsuFUBrpiaPaP6arHr61Ezs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ul/DvtK2rX+5FMBNGck+kBMzIRGpz4orkB2r1kF3F5/H/AeS899Ul9hgipFnF2Lsm
	 fqhIZOiv0leypARDaRmv+aZkXZtcOvdUsj+5wap2S1ZSPRJLotPgXA81bc6A5UAr0z
	 z5VHQSdaDORQpwUmL9AwWVjobHdkprOWnNJAWDyejM5upkZwlW91BAuftToNssIxV9
	 EPNxe6DUirVuysfk8vJy1WkTXiFl6rFYV46XNiVG+oPrdlwGwMZBTH8vZCI8bMMe5G
	 /7D7ufOL9UNFYDutNSZl10IpjTK0gCefF+Rg+k1DThhxQ1VVYHUolVBiV04f72Jh8X
	 OofIXEtB5nDgQ==
Date: Wed, 10 Jul 2024 12:45:06 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
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
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Subject: Re: [PATCH v6 11/17] ACPI: RISC-V: Initialize GSI mapping structures
Message-ID: <Zo5mMiWbEtKEeZ2r@lpieralisi>
References: <20240601150411.1929783-1-sunilvl@ventanamicro.com>
 <20240601150411.1929783-12-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601150411.1929783-12-sunilvl@ventanamicro.com>

On Sat, Jun 01, 2024 at 08:34:05PM +0530, Sunil V L wrote:
> RISC-V has PLIC and APLIC in MADT as well as namespace devices.
> Initialize the list of those structures using MADT and namespace devices
> to create mapping between the ACPI handle and the GSI ranges. This will
> be used later to add dependencies.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  arch/riscv/include/asm/irq.h |  22 ++++++
>  drivers/acpi/riscv/init.c    |   2 +
>  drivers/acpi/riscv/init.h    |   4 +
>  drivers/acpi/riscv/irq.c     | 142 +++++++++++++++++++++++++++++++++++
>  4 files changed, 170 insertions(+)
>  create mode 100644 drivers/acpi/riscv/init.h
> 
> diff --git a/arch/riscv/include/asm/irq.h b/arch/riscv/include/asm/irq.h
> index 8e10a94430a2..44a0b128c602 100644
> --- a/arch/riscv/include/asm/irq.h
> +++ b/arch/riscv/include/asm/irq.h
> @@ -16,4 +16,26 @@ void riscv_set_intc_hwnode_fn(struct fwnode_handle *(*fn)(void));
>  
>  struct fwnode_handle *riscv_get_intc_hwnode(void);
>  
> +#ifdef CONFIG_ACPI
> +
> +enum riscv_irqchip_type {
> +	ACPI_RISCV_IRQCHIP_INTC		= 0x00,
> +	ACPI_RISCV_IRQCHIP_IMSIC	= 0x01,
> +	ACPI_RISCV_IRQCHIP_PLIC		= 0x02,
> +	ACPI_RISCV_IRQCHIP_APLIC	= 0x03,
> +};
> +
> +int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
> +			    u32 *id, u32 *nr_irqs, u32 *nr_idcs);
> +struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi);
> +
> +#else
> +static inline int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
> +					  u32 *id, u32 *nr_irqs, u32 *nr_idcs)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_ACPI */
> +
>  #endif /* _ASM_RISCV_IRQ_H */
> diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
> index 5f7571143245..22db97f7a772 100644
> --- a/drivers/acpi/riscv/init.c
> +++ b/drivers/acpi/riscv/init.c
> @@ -6,7 +6,9 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include "init.h"
>  
>  void __init acpi_riscv_init(void)
>  {
> +	riscv_acpi_init_gsi_mapping();
>  }
> diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
> new file mode 100644
> index 000000000000..0b9a07e4031f
> --- /dev/null
> +++ b/drivers/acpi/riscv/init.h
> @@ -0,0 +1,4 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#include <linux/init.h>
> +
> +void __init riscv_acpi_init_gsi_mapping(void);
> diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> index f56e103a501f..0473428e8d1e 100644
> --- a/drivers/acpi/riscv/irq.c
> +++ b/drivers/acpi/riscv/irq.c
> @@ -7,6 +7,21 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/sort.h>
> +#include <linux/irq.h>
> +
> +#include "init.h"
> +
> +struct riscv_ext_intc_list {
> +	acpi_handle handle;
> +	u32 gsi_base;
> +	u32 nr_irqs;
> +	u32 nr_idcs;
> +	u32 id;
> +	u32 type;
> +	struct list_head list;
> +};
> +
> +LIST_HEAD(ext_intc_list);
>  
>  static int irqchip_cmp_func(const void *in0, const void *in1)
>  {
> @@ -30,3 +45,130 @@ void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
>  		return;
>  	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
>  }
> +
> +static void riscv_acpi_update_gsi_handle(u32 gsi_base, acpi_handle handle)
> +{
> +	struct riscv_ext_intc_list *ext_intc_element;
> +	struct list_head *i, *tmp;
> +
> +	list_for_each_safe(i, tmp, &ext_intc_list) {
> +		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
> +		if (gsi_base == ext_intc_element->gsi_base) {
> +			ext_intc_element->handle = handle;
> +			return;
> +		}
> +	}
> +
> +	acpi_handle_err(handle, "failed to find the GSI mapping entry\n");
> +}
> +
> +int riscv_acpi_get_gsi_info(struct fwnode_handle *fwnode, u32 *gsi_base,
> +			    u32 *id, u32 *nr_irqs, u32 *nr_idcs)
> +{
> +	struct riscv_ext_intc_list *ext_intc_element;
> +	struct list_head *i, *tmp;
> +
> +	list_for_each_safe(i, tmp, &ext_intc_list) {
> +		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
> +		if (ext_intc_element->handle == ACPI_HANDLE_FWNODE(fwnode)) {
> +			*gsi_base = ext_intc_element->gsi_base;
> +			*id = ext_intc_element->id;
> +			*nr_irqs = ext_intc_element->nr_irqs;
> +			if (nr_idcs)
> +				*nr_idcs = ext_intc_element->nr_idcs;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +struct fwnode_handle *riscv_acpi_get_gsi_domain_id(u32 gsi)
> +{
> +	struct riscv_ext_intc_list *ext_intc_element;
> +	struct acpi_device *adev;
> +	struct list_head *i, *tmp;
> +
> +	list_for_each_safe(i, tmp, &ext_intc_list) {
> +		ext_intc_element = list_entry(i, struct riscv_ext_intc_list, list);
> +		if (gsi >= ext_intc_element->gsi_base &&
> +		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs)) {
> +			adev = acpi_fetch_acpi_dev(ext_intc_element->handle);
> +			if (!adev)
> +				return NULL;
> +
> +			return acpi_fwnode_handle(adev);
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int __init riscv_acpi_register_ext_intc(u32 gsi_base, u32 nr_irqs, u32 nr_idcs,
> +					       u32 id, u32 type)
> +{
> +	struct riscv_ext_intc_list *ext_intc_element;
> +
> +	ext_intc_element = kzalloc(sizeof(*ext_intc_element), GFP_KERNEL);
> +	if (!ext_intc_element)
> +		return -ENOMEM;
> +
> +	ext_intc_element->gsi_base = gsi_base;
> +	ext_intc_element->nr_irqs = nr_irqs;
> +	ext_intc_element->nr_idcs = nr_idcs;
> +	ext_intc_element->id = id;
> +	list_add_tail(&ext_intc_element->list, &ext_intc_list);
> +	return 0;
> +}
> +
> +static acpi_status __init riscv_acpi_create_gsi_map(acpi_handle handle, u32 level,
> +						    void *context, void **return_value)
> +{
> +	acpi_status status;
> +	u64 gbase;
> +
> +	if (!acpi_has_method(handle, "_GSB")) {
> +		acpi_handle_err(handle, "_GSB method not found\n");
> +		return AE_OK;
> +	}
> +
> +	status = acpi_evaluate_integer(handle, "_GSB", NULL, &gbase);
> +	if (ACPI_FAILURE(status)) {
> +		acpi_handle_err(handle, "failed to evaluate _GSB method\n");
> +		return AE_OK;
> +	}
> +
> +	riscv_acpi_update_gsi_handle((u32)gbase, handle);
> +	return AE_OK;
> +}
> +
> +static int __init riscv_acpi_aplic_parse_madt(union acpi_subtable_headers *header,
> +					      const unsigned long end)
> +{
> +	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
> +
> +	return riscv_acpi_register_ext_intc(aplic->gsi_base, aplic->num_sources, aplic->num_idcs,
> +					    aplic->id, ACPI_RISCV_IRQCHIP_APLIC);
> +}
> +
> +static int __init riscv_acpi_plic_parse_madt(union acpi_subtable_headers *header,
> +					     const unsigned long end)
> +{
> +	struct acpi_madt_plic *plic = (struct acpi_madt_plic *)header;
> +
> +	return riscv_acpi_register_ext_intc(plic->gsi_base, plic->num_irqs, 0,
> +					    plic->id, ACPI_RISCV_IRQCHIP_PLIC);
> +}
> +
> +void __init riscv_acpi_init_gsi_mapping(void)
> +{
> +	/* There can be either PLIC or APLIC */
> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_PLIC, riscv_acpi_plic_parse_madt, 0) > 0) {
> +		acpi_get_devices("RSCV0001", riscv_acpi_create_gsi_map, NULL, NULL);
> +		return;
> +	}
> +
> +	if (acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, riscv_acpi_aplic_parse_madt, 0) > 0)
> +		acpi_get_devices("RSCV0002", riscv_acpi_create_gsi_map, NULL, NULL);
> +}

I don't know if it is needed in RISC-V - it is a question - but how would you
resolve a GSI mapping before the ACPI intepreter is initialized ?

This model relies on the _GSB method to be called on the interrupt controller
device to discover the GSI range it actually covers, I was wondering how this
works for "devices" (eg components described in static table, eg timers)
that require a GSI mapping before you are able to retrieve the required
information from the namespace devices.

Thanks,
Lorenzo

