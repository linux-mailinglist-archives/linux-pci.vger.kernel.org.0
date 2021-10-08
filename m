Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45E9427315
	for <lists+linux-pci@lfdr.de>; Fri,  8 Oct 2021 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242456AbhJHVdl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Oct 2021 17:33:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230384AbhJHVdl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Oct 2021 17:33:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D186860FC2;
        Fri,  8 Oct 2021 21:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633728705;
        bh=7LO3Du5NKPKNHX+7MCdBoPdXpiDVDXPnQ3xt3O5sRus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TVrxCiOknIgoY7w4A9RcG7RNiD29o1hwFNFzFGHsIBvWrPboeoaIpeeDG+ufSN6lJ
         AkWUN84VbP2SaajtlVvub7umL3U9EUJYDEx+q+PYN+PT6/iD8jsNp69PJcCixPSvDX
         zINGff+vTLgxhvpCDcIlZxDj1UmbJ+lEE7fcK4Sq9MQPzMJyzhLqTdsAzo9ReLey83
         x+5dL2/c1XZno3SMR+dwRjODoZdYtglSMHCc49y4W8loDRK26Hb4+gr+z3BvZoX0yl
         raEJ54zUyHKT0curiYOr/x5gnj0qgDpR8zHpo1BxMEWXtQEPEaB6DH3zzYwQqMRwm0
         PdLFft1QreDNQ==
Date:   Fri, 8 Oct 2021 16:31:43 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jayachandran C <c.jayachandran@gmail.com>,
        Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH v2 1/2] PCI: MCFG: Consolidate the separate PCI MCFG
 table entry list
Message-ID: <20211008213143.GA1373034@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWAD7LRsTCcfTkgJ@Dennis-MBP.local>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jayachandran, Tomasz; not sure if they're still around, but just
in case they have a comment on any reasons for keeping the
pci_mcfg_list list separate.]

On Fri, Oct 08, 2021 at 04:40:12PM +0800, Xuesong Chen wrote:
> The PCI MCFG entry list is discrete on x86 and other architectures like
> arm64 in current implementation, this list variable can be consolidated
> for unnecessary duplication and other purposes, for example, we can remove
> some of the 'arch' specific codes in the APEI/EINJ module and re-implement
> it in a more common arch-agnostic way.

This commit log could be more explicit about what's going on here.

From deciphering the patch, I think it takes advantage of the fact
that struct pci_mmcfg_region and struct mcfg_entry contain basically
the same information, but pci_mmcfg_region contains a little extra
information (a struct resource, a virtual address, and a name).

To reduce the redundancy, it:

  - Moves the "struct pci_mmcfg_region" definition from
    arch/x86/include/asm/pci_x86.h to include/linux/pci.h, where it
    can be shared across arches.

  - Moves pci_mmcfg_list (a list of pci_mmcfg_region structs) from
    arch/x86/pci/mmconfig-shared.c to drivers/pci/pci.c, where it can
    be shared across arches.

  - On x86 (which does not enable CONFIG_ACPI_MCFG), pci_mmcfg_list is
    built in arch/x86/pci/mmconfig-shared.c as before.

  - Removes the "struct mcfg_entry" from drivers/acpi/pci_mcfg.c.

  - Replaces pci_mcfg_list (previously a list of mcfg_entry structs)
    in drivers/acpi/pci_mcfg.c with the newly-shared pci_mmcfg_list (a
    list of pci_mmcfg_region structs).

  - On ARM64 (which does enable CONFIG_ACPI_MCFG), pci_mmcfg_list is
    built in drivers/acpi/pci_mcfg.c.

Does that sound about right?

> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
> ---
>  arch/x86/include/asm/pci_x86.h | 17 +----------------
>  arch/x86/pci/mmconfig-shared.c |  2 --
>  drivers/acpi/pci_mcfg.c        | 34 +++++++++++++---------------------
>  drivers/pci/pci.c              |  2 ++
>  include/linux/pci.h            | 17 +++++++++++++++++
>  5 files changed, 33 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
> index 490411d..1f4257c 100644
> --- a/arch/x86/include/asm/pci_x86.h
> +++ b/arch/x86/include/asm/pci_x86.h
> @@ -146,20 +146,7 @@ static inline int  __init pci_acpi_init(void)
>  extern void pcibios_fixup_irqs(void);
>  
>  /* pci-mmconfig.c */
> -
> -/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
> -#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
> -
> -struct pci_mmcfg_region {
> -	struct list_head list;
> -	struct resource res;
> -	u64 address;
> -	char __iomem *virt;
> -	u16 segment;
> -	u8 start_bus;
> -	u8 end_bus;
> -	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
> -};
> +struct pci_mmcfg_region;
>  
>  extern int __init pci_mmcfg_arch_init(void);
>  extern void __init pci_mmcfg_arch_free(void);
> @@ -174,8 +161,6 @@ extern struct pci_mmcfg_region *__init pci_mmconfig_add(int segment, int start,
>  
>  extern struct list_head pci_mmcfg_list;
>  
> -#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
> -
>  /*
>   * On AMD Fam10h CPUs, all PCI MMIO configuration space accesses must use
>   * %eax.  No other source or target registers may be used.  The following
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 758cbfe..0b961fe6 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -31,8 +31,6 @@
>  static DEFINE_MUTEX(pci_mmcfg_lock);
>  #define pci_mmcfg_lock_held() lock_is_held(&(pci_mmcfg_lock).dep_map)
>  
> -LIST_HEAD(pci_mmcfg_list);
> -
>  static void __init pci_mmconfig_remove(struct pci_mmcfg_region *cfg)
>  {
>  	if (cfg->res.parent)
> diff --git a/drivers/acpi/pci_mcfg.c b/drivers/acpi/pci_mcfg.c
> index 53cab97..d9506b0 100644
> --- a/drivers/acpi/pci_mcfg.c
> +++ b/drivers/acpi/pci_mcfg.c
> @@ -13,14 +13,7 @@
>  #include <linux/pci-acpi.h>
>  #include <linux/pci-ecam.h>
>  
> -/* Structure to hold entries from the MCFG table */
> -struct mcfg_entry {
> -	struct list_head	list;
> -	phys_addr_t		addr;
> -	u16			segment;
> -	u8			bus_start;
> -	u8			bus_end;
> -};
> +extern struct list_head pci_mmcfg_list;
>  
>  #ifdef CONFIG_PCI_QUIRKS
>  struct mcfg_fixup {
> @@ -214,16 +207,13 @@ static void pci_mcfg_apply_quirks(struct acpi_pci_root *root,
>  #endif
>  }
>  
> -/* List to save MCFG entries */
> -static LIST_HEAD(pci_mcfg_list);
> -
>  int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
>  		    const struct pci_ecam_ops **ecam_ops)
>  {
>  	const struct pci_ecam_ops *ops = &pci_generic_ecam_ops;
>  	struct resource *bus_res = &root->secondary;
>  	u16 seg = root->segment;
> -	struct mcfg_entry *e;
> +	struct pci_mmcfg_region *e;
>  	struct resource res;
>  
>  	/* Use address from _CBA if present, otherwise lookup MCFG */
> @@ -233,10 +223,10 @@ int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
>  	/*
>  	 * We expect the range in bus_res in the coverage of MCFG bus range.
>  	 */
> -	list_for_each_entry(e, &pci_mcfg_list, list) {
> -		if (e->segment == seg && e->bus_start <= bus_res->start &&
> -		    e->bus_end >= bus_res->end) {
> -			root->mcfg_addr = e->addr;
> +	list_for_each_entry(e, &pci_mmcfg_list, list) {
> +		if (e->segment == seg && e->start_bus <= bus_res->start &&
> +		    e->end_bus >= bus_res->end) {
> +			root->mcfg_addr = e->address;
>  		}
>  
>  	}
> @@ -268,7 +258,7 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
>  {
>  	struct acpi_table_mcfg *mcfg;
>  	struct acpi_mcfg_allocation *mptr;
> -	struct mcfg_entry *e, *arr;
> +	struct pci_mmcfg_region *e, *arr;
>  	int i, n;
>  
>  	if (header->length < sizeof(struct acpi_table_mcfg))
> @@ -285,10 +275,12 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
>  
>  	for (i = 0, e = arr; i < n; i++, mptr++, e++) {
>  		e->segment = mptr->pci_segment;
> -		e->addr =  mptr->address;
> -		e->bus_start = mptr->start_bus_number;
> -		e->bus_end = mptr->end_bus_number;
> -		list_add(&e->list, &pci_mcfg_list);
> +		e->address =  mptr->address;
> +		e->start_bus = mptr->start_bus_number;
> +		e->end_bus = mptr->end_bus_number;
> +		e->res.start = e->address + PCI_MMCFG_BUS_OFFSET(e->start_bus);
> +		e->res.end = e->address + PCI_MMCFG_BUS_OFFSET(e->end_bus + 1) - 1;
> +		list_add(&e->list, &pci_mmcfg_list);
>  	}
>  
>  #ifdef CONFIG_PCI_QUIRKS
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ce2ab62..899004e 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -47,6 +47,8 @@
>  int pci_pci_problems;
>  EXPORT_SYMBOL(pci_pci_problems);
>  
> +LIST_HEAD(pci_mmcfg_list);
> +
>  unsigned int pci_pm_d3hot_delay;
>  
>  static void pci_pme_list_scan(struct work_struct *work);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6f..71e4c06 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -55,6 +55,23 @@
>  #define PCI_RESET_PROBE		true
>  #define PCI_RESET_DO_RESET	false
>  
> +#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
> +
> +/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
> +#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
> +
> +/* pci mcfg region */
> +struct pci_mmcfg_region {
> +	struct list_head list;
> +	struct resource res;
> +	u64 address;
> +	char __iomem *virt;
> +	u16 segment;
> +	u8 start_bus;
> +	u8 end_bus;
> +	char name[PCI_MMCFG_RESOURCE_NAME_LEN];
> +};
> +
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> -- 
> 1.8.3.1
> 
