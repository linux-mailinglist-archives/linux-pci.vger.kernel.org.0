Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C94433F3A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 21:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbhJSTZs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 15:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230432AbhJSTZs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 15:25:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A9D3561373;
        Tue, 19 Oct 2021 19:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634671415;
        bh=snItbv6jbTowdc0e0WuZ2Lq5Gpyv0yIAvj2ZEybyubo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PUKtgLarTqBpLE01QdJuKqRLAtEdDOyr6bvWt9SSNW4Xqxco0tINYV9Vv892YMlWb
         d8CAAbgoZ7CrNO5WbEa2/ccCdSPEOMwS146Kklul8TvYRHodG5N4H//S7+UcUU1SOx
         7Xqg/yLhQFjOnlPm/s1TZmFsgRcgtIYB+5Y5OGGhY2H92B5PI0AlKYYHoR7mWBG7Ql
         1qtgNm9E9algxWMe4utlcvPsVonl6/oRF9AnaDXT29Vmp5JEYS6nGrMhirCE7qZYTy
         AdO/4hMxON+BxV30ypG7XOSnJyea8RAoVTtc9UsqURjenEiYywigmtbywu+laXHpza
         LGLJY8s5rVhrQ==
Date:   Tue, 19 Oct 2021 14:23:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Xuesong Chen <xuesong.chen@linux.alibaba.com>
Cc:     catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        james.morse@arm.com, will@kernel.org, rafael@kernel.org,
        tony.luck@intel.com, bp@alien8.de, mingo@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH v3 2/2] ACPI: APEI: Filter the PCI MCFG address with an
 arch-agnostic method
Message-ID: <20211019192332.GA2381550@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW5OmSBM4mO1lDHs@Dennis-MBP.local>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Huang in case I'm misinterpreting EINJ resource requests]

On Tue, Oct 19, 2021 at 12:50:33PM +0800, Xuesong Chen wrote:
> The commit d91525eb8ee6 ("ACPI, EINJ: Enhance error injection tolerance
> level") fixes the issue that the ACPI/APEI can not access the PCI MCFG
> address on x86 platform, but this issue can also happen on other
> architectures, for instance, we got below error message on arm64 platform:
> ...
> APEI: Can not request [mem 0x50100000-0x50100003] for APEI EINJ Trigger registers

I'm guessing this address is something in the MCFG area?  I wish we
could also include the matching MCFG info For x86, we put something
like this in the dmesg log, but I guess pci_mcfg.c doesn't do this:

  PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)

> This patch will try to handle this case in a more common way instead of the
> original 'arch' specific solution, which will be beneficial to all the
> APEI-dependent platforms after that.

This actually doesn't say anything about what the patch does or how it
works.  It says "handles this case in a more common way" but with no
details.

The EINJ table contains "injection instructions" that can read or
write "register regions" described by generic address structures (see
ACPI v6.3, sec 18.6.2 and 18.6.3), and __einj_error_trigger() requests
those register regions with request_mem_region() or request_region()
before executing the injections instructions.

IIUC, this patch basically says "if this region is part of the MCFG
area, we don't need to reserve it." That leads to the questions of why
we need to reserve *any* of the areas and why it's safe to simply skip
reserving regions that are part of the MCFG area.

> Signed-off-by: Xuesong Chen <xuesong.chen@linux.alibaba.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Rafael. J. Wysocki <rafael@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> ---
>  arch/x86/pci/mmconfig-shared.c | 28 --------------------------
>  drivers/acpi/apei/apei-base.c  | 45 ++++++++++++++++++++++++++++--------------
>  2 files changed, 30 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-shared.c
> index 0b961fe6..12f7d96 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -605,32 +605,6 @@ static int __init pci_parse_mcfg(struct acpi_table_header *header)
>  	return 0;
>  }
>  
> -#ifdef CONFIG_ACPI_APEI
> -extern int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
> -				     void *data), void *data);
> -
> -static int pci_mmcfg_for_each_region(int (*func)(__u64 start, __u64 size,
> -				     void *data), void *data)
> -{
> -	struct pci_mmcfg_region *cfg;
> -	int rc;
> -
> -	if (list_empty(&pci_mmcfg_list))
> -		return 0;
> -
> -	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> -		rc = func(cfg->res.start, resource_size(&cfg->res), data);
> -		if (rc)
> -			return rc;
> -	}
> -
> -	return 0;
> -}
> -#define set_apei_filter() (arch_apei_filter_addr = pci_mmcfg_for_each_region)
> -#else
> -#define set_apei_filter()
> -#endif
> -
>  static void __init __pci_mmcfg_init(int early)
>  {
>  	pci_mmcfg_reject_broken(early);
> @@ -665,8 +639,6 @@ void __init pci_mmcfg_early_init(void)
>  		else
>  			acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
>  		__pci_mmcfg_init(1);
> -
> -		set_apei_filter();
>  	}
>  }
>  
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index c7fdb12..daae75a 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -21,6 +21,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> +#include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
>  #include <linux/io.h>
> @@ -448,13 +449,34 @@ static int apei_get_nvs_resources(struct apei_resources *resources)
>  	return acpi_nvs_for_each_region(apei_get_res_callback, resources);
>  }
>  
> -int (*arch_apei_filter_addr)(int (*func)(__u64 start, __u64 size,
> -				     void *data), void *data);
> -static int apei_get_arch_resources(struct apei_resources *resources)
> +#ifdef CONFIG_PCI
> +extern struct list_head pci_mmcfg_list;
> +static int apei_filter_mcfg_addr(struct apei_resources *res,
> +			struct apei_resources *mcfg_res)
> +{
> +	int rc = 0;
> +	struct pci_mmcfg_region *cfg;
> +
> +	if (list_empty(&pci_mmcfg_list))
> +		return 0;
> +
> +	apei_resources_init(mcfg_res);
> +	list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> +		rc = apei_res_add(&mcfg_res->iomem, cfg->res.start, resource_size(&cfg->res));
> +		if (rc)
> +			return rc;
> +	}
>  
> +	/* filter the mcfg resource from current APEI's */
> +	return apei_resources_sub(res, mcfg_res);
> +}
> +#else
> +static inline int apei_filter_mcfg_addr(struct apei_resources *res,
> +			struct apei_resources *mcfg_res)
>  {
> -	return arch_apei_filter_addr(apei_get_res_callback, resources);
> +	return 0;
>  }
> +#endif
>  
>  /*
>   * IO memory/port resource management mechanism is used to check
> @@ -486,15 +508,9 @@ int apei_resources_request(struct apei_resources *resources,
>  	if (rc)
>  		goto nvs_res_fini;
>  
> -	if (arch_apei_filter_addr) {
> -		apei_resources_init(&arch_res);
> -		rc = apei_get_arch_resources(&arch_res);
> -		if (rc)
> -			goto arch_res_fini;
> -		rc = apei_resources_sub(resources, &arch_res);
> -		if (rc)
> -			goto arch_res_fini;
> -	}
> +	rc = apei_filter_mcfg_addr(resources, &arch_res);
> +	if (rc)
> +		goto arch_res_fini;
>  
>  	rc = -EINVAL;
>  	list_for_each_entry(res, &resources->iomem, list) {
> @@ -544,8 +560,7 @@ int apei_resources_request(struct apei_resources *resources,
>  		release_mem_region(res->start, res->end - res->start);
>  	}
>  arch_res_fini:
> -	if (arch_apei_filter_addr)
> -		apei_resources_fini(&arch_res);
> +	apei_resources_fini(&arch_res);
>  nvs_res_fini:
>  	apei_resources_fini(&nvs_resources);
>  	return rc;
> -- 
> 1.8.3.1
> 
