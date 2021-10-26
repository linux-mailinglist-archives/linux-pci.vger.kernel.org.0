Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183F43B30A
	for <lists+linux-pci@lfdr.de>; Tue, 26 Oct 2021 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhJZNRS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Oct 2021 09:17:18 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34669 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJZNRS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Oct 2021 09:17:18 -0400
Received: by mail-oi1-f172.google.com with SMTP id w193so847424oie.1;
        Tue, 26 Oct 2021 06:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPN8L2jX6Nco49lUubWlVKZG7LZSldfvtFfxWeGXbNA=;
        b=bUzhTgrQ5Rdk49QBX9hpGaZgPmPga3eMqCyf6VrvD5Ufc3OehEAyqC9stGglsg/A3q
         xI4/CnKBx24pBaFdVyN1H5EFWKVLltRmBVuyDPnLLCCouNYD9vOPUe9AeTwAimUhDFVB
         /MNnlgKH1Xnq+KbYZhY/f6KYb0rHZyrsP6/wPzs/tEsgroOvW984a+053koIvHJZo01M
         2decbRPQq1AFA+xHGEA6RQRSePUfOfffP6siJgsbeoN9fACG03IEeAcumDkkL8S06ZbD
         A6/e+ktJTQLy1g3PofPfnXf0+tBDDnONxvmgynLGYlvp0Zaaq3ERI0Gn0FXOeiCFJlDG
         ka5w==
X-Gm-Message-State: AOAM533JnqO+aHayJ+U34X+xygcD0QZSwkTvK8QDGBCmTcTMBQhwVRQv
        JdpCnCXaTuzusg/Yp6zqNLIgwvVcgXQeB2w12cn+1HTk
X-Google-Smtp-Source: ABdhPJxHStW+YF/bxjfqNV/7TMKIMqO+XToazdK7i4TI1rcKW4Not9y8Zrrin3yOcL4dprCRT3f0PywukIPFA9L2kZY=
X-Received: by 2002:a05:6808:1286:: with SMTP id a6mr24500110oiw.51.1635254094204;
 Tue, 26 Oct 2021 06:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <YW5OdIyFkTYo0h3W@Dennis-MBP.local>
In-Reply-To: <YW5OdIyFkTYo0h3W@Dennis-MBP.local>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 15:14:37 +0200
Message-ID: <CAJZ5v0g=+_fATmSrLWiTirmr0MkihKpy7wp-9aFpWVK_RLhp6g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: MCFG: Consolidate the separate PCI MCFG table
 entry list
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 19, 2021 at 6:50 AM Xuesong Chen
<xuesong.chen@linux.alibaba.com> wrote:
>
> The PCI MCFG entry list is discrete on x86 and other arches like ARM64
> in current implementation, this list variable can be consolidated for
> unnecessary duplication and other purposes, for example, we can remove
> some of the arch-specific codes in the APEI/EINJ module and re-implement
> it in a more common arch-agnostic way.
>
> To reduce the redundancy, it:
>   - Moves the "struct pci_mmcfg_region" definition from
>     arch/x86/include/asm/pci_x86.h to include/linux/pci.h, where it
>     can be shared across arches.
>
>   - Moves pci_mmcfg_list (a list of pci_mmcfg_region structs) from
>     arch/x86/pci/mmconfig-shared.c to drivers/pci/pci.c, where it can
>     be shared across arches.
>
>   - On x86 (which does not enable CONFIG_ACPI_MCFG), pci_mmcfg_list is
>     built in arch/x86/pci/mmconfig-shared.c as before.
>
>   - Removes the "struct mcfg_entry" from drivers/acpi/pci_mcfg.c.
>
>   - Replaces pci_mcfg_list (previously a list of mcfg_entry structs)
>     in drivers/acpi/pci_mcfg.c with the newly-shared pci_mmcfg_list (a
>     list of pci_mmcfg_region structs).
>
>   - On ARM64 (which does enable CONFIG_ACPI_MCFG), pci_mmcfg_list is
>     built in drivers/acpi/pci_mcfg.c.
>
> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

I'm guessing that I'm expected to pick up this one?

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Rafael. J. Wysocki <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
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
> -       struct list_head list;
> -       struct resource res;
> -       u64 address;
> -       char __iomem *virt;
> -       u16 segment;
> -       u8 start_bus;
> -       u8 end_bus;
> -       char name[PCI_MMCFG_RESOURCE_NAME_LEN];
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
>         if (cfg->res.parent)
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
> -       struct list_head        list;
> -       phys_addr_t             addr;
> -       u16                     segment;
> -       u8                      bus_start;
> -       u8                      bus_end;
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
>                     const struct pci_ecam_ops **ecam_ops)
>  {
>         const struct pci_ecam_ops *ops = &pci_generic_ecam_ops;
>         struct resource *bus_res = &root->secondary;
>         u16 seg = root->segment;
> -       struct mcfg_entry *e;
> +       struct pci_mmcfg_region *e;
>         struct resource res;
>
>         /* Use address from _CBA if present, otherwise lookup MCFG */
> @@ -233,10 +223,10 @@ int pci_mcfg_lookup(struct acpi_pci_root *root, struct resource *cfgres,
>         /*
>          * We expect the range in bus_res in the coverage of MCFG bus range.
>          */
> -       list_for_each_entry(e, &pci_mcfg_list, list) {
> -               if (e->segment == seg && e->bus_start <= bus_res->start &&
> -                   e->bus_end >= bus_res->end) {
> -                       root->mcfg_addr = e->addr;
> +       list_for_each_entry(e, &pci_mmcfg_list, list) {
> +               if (e->segment == seg && e->start_bus <= bus_res->start &&
> +                   e->end_bus >= bus_res->end) {
> +                       root->mcfg_addr = e->address;
>                 }
>
>         }
> @@ -268,7 +258,7 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
>  {
>         struct acpi_table_mcfg *mcfg;
>         struct acpi_mcfg_allocation *mptr;
> -       struct mcfg_entry *e, *arr;
> +       struct pci_mmcfg_region *e, *arr;
>         int i, n;
>
>         if (header->length < sizeof(struct acpi_table_mcfg))
> @@ -285,10 +275,12 @@ static __init int pci_mcfg_parse(struct acpi_table_header *header)
>
>         for (i = 0, e = arr; i < n; i++, mptr++, e++) {
>                 e->segment = mptr->pci_segment;
> -               e->addr =  mptr->address;
> -               e->bus_start = mptr->start_bus_number;
> -               e->bus_end = mptr->end_bus_number;
> -               list_add(&e->list, &pci_mcfg_list);
> +               e->address =  mptr->address;
> +               e->start_bus = mptr->start_bus_number;
> +               e->end_bus = mptr->end_bus_number;
> +               e->res.start = e->address + PCI_MMCFG_BUS_OFFSET(e->start_bus);
> +               e->res.end = e->address + PCI_MMCFG_BUS_OFFSET(e->end_bus + 1) - 1;
> +               list_add(&e->list, &pci_mmcfg_list);
>         }
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
>  #define PCI_RESET_PROBE                true
>  #define PCI_RESET_DO_RESET     false
>
> +#define PCI_MMCFG_BUS_OFFSET(bus)      ((bus) << 20)
> +
> +/* "PCI MMCONFIG %04x [bus %02x-%02x]" */
> +#define PCI_MMCFG_RESOURCE_NAME_LEN (22 + 4 + 2 + 2)
> +
> +/* pci mcfg region */
> +struct pci_mmcfg_region {
> +       struct list_head list;
> +       struct resource res;
> +       u64 address;
> +       char __iomem *virt;
> +       u16 segment;
> +       u8 start_bus;
> +       u8 end_bus;
> +       char name[PCI_MMCFG_RESOURCE_NAME_LEN];
> +};
> +
>  /*
>   * The PCI interface treats multi-function devices as independent
>   * devices.  The slot/function address of each device is encoded
> --
> 1.8.3.1
>
