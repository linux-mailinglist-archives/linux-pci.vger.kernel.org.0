Return-Path: <linux-pci+bounces-8423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9B18FF7AD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 00:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44DA41F2509B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 22:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFC713C820;
	Thu,  6 Jun 2024 22:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK+PwnJj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDECB13AD0F;
	Thu,  6 Jun 2024 22:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713181; cv=none; b=epgk7CSxrY5oBpdRsVWmS8lHYRQQu51IsKT+5t70dAz6r6TkzZxmMHiHFsBmbZ40CHrhPIRwMCKlSk6nh3ij1Ddw/kkY59ukrcl8AWZOd1Z9SekEpsWt2ltgQYAsDYVx4J3JhrCz0if2R8P3YWI6tcxUpvfhdNAQeJk2pBXX8LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713181; c=relaxed/simple;
	bh=daFQuWzgfeqnC7TXF4xUI9j9WgRNKpwZIoXV6lTPUjE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q+b5XwsUl/+Ildt7US9Hd8Qb7GtXlaDItyL5BLz/2SNJ8ZGJVpmS8smcQbNC+5eim6I0Owa6LIAyBbiF0yHwsIu2PNNbslwk5my4enl7M6JG/kvq3+qZ3sqK6zekG9FOTXMzYfLa6h507scIr6UgvIHhvXYSSkre8VcIabhI+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK+PwnJj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BAB4C2BD10;
	Thu,  6 Jun 2024 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717713181;
	bh=daFQuWzgfeqnC7TXF4xUI9j9WgRNKpwZIoXV6lTPUjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LK+PwnJjXqoZt992WhL0w2L5rQE+D9pKZYxQ10gmWFdOHhG/8B7hSkSxDdUeNNxSi
	 td4Omshq+Nk5/6dnAGHVWQIc4JsTh3Tje1PHODNOM1pRqep6nb5iw2WANxyDqjYk5V
	 Q35x5GgmWPGftZsty1E9HuL7k66gsRv/ESprd3mdN1JaFFKHNsKAaD7/iTEJiUd3S9
	 nhylpoE+lznac5AySsOeh1um8dF8ptOWYND0Pl4l2xcmZM9O9eyVoCUqbxokg1UP32
	 QdfNERvREsMJrymv4hLpFOIxaZtc8yg5oWyyLJZsAJalv3I8ZJj4qIyDqNpNStYRQn
	 BuENN4Ov08mTw==
Date: Thu, 6 Jun 2024 17:32:59 -0500
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
Subject: Re: [PATCH v6 11/17] ACPI: RISC-V: Initialize GSI mapping structures
Message-ID: <20240606223259.GA822964@bhelgaas>
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

From a long ways away, this looks like "map a GSI to an interrupt
controller described either via MADT or namespace" plus a little bit
of RISC-V stuff.

That first part, mapping GSI to interrupt controller, is generic and
other arches need to do the same thing.  It would be nice if every
arch didn't have to roll their own list of (handle, gsi_base, nr_irqs)
tuples.  And it might clarify the whole concept of GSI, which is
conceptually very simple but gets muddied by all the magic stuff
around it.

This is probably just wishful thinking and not actionable feedback.

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
> -- 
> 2.40.1
> 

