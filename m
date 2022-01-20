Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0306495242
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 17:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235587AbiATQWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 11:22:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:32950 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376957AbiATQWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 11:22:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66946B81DB4;
        Thu, 20 Jan 2022 16:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1AFC340E0;
        Thu, 20 Jan 2022 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642695763;
        bh=nAL+9EUzWg/VrpxcuKiEa2MCqLsPygZexwnmRgYCpj4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i00f7Xhs2vtYGBvTf0qEya6e2YHNqDbb4NGL5j72h9W5HNKLdKZ7eAB4OlWbqlyeS
         SoTF197WIJJlyHSfZ8VFdC/DkqP98TfpDZNlzTWruh/5mbjaOVIhu8U8n7lvtQdPuT
         FUGoxdXDKEmXnsYORRTTDjxV8djZwrDbrmS5il+T0UEaJ2THUUxm83JMlln/rXHL7W
         FheRqJxYuEu5rfUR3I/5f/+0UWRqk/c/HrCDaUta4meLzGeFWkJONezRNH9T9Q27U3
         pybMMOLnVjxe2TRD+WYdovOjmi4pzy+C4hw1BoAXcNt9bNMqUtScKadqCO5qO7ITl3
         qk41k/gvxbjiA==
Date:   Thu, 20 Jan 2022 10:22:41 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     rafael@kernel.org, bp@alien8.de, tony.luck@intel.com,
        james.morse@arm.com, lenb@kernel.org, rjw@rjwysocki.net,
        bhelgaas@google.com, zhangliguang@linux.alibaba.com,
        zhuo.song@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v6] ACPI: explicit init HEST, SDEI and GHES in apci_init
Message-ID: <20220120162241.GA1047212@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120050522.23689-1-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 01:05:22PM +0800, Shuai Xue wrote:
> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
> the estatus memory pool. On the other hand, ghes_init() relies on
> sdei_init() to detect the SDEI version and (un)register events. The
> dependencies are as follows:
> 
>     ghes_init() => acpi_hest_init() => acpi_bus_init() => acpi_init()
>     ghes_init() => sdei_init()
> 
> HEST is not PCI-specific and initcall ordering is implicit and not
> well-defined within a level.
> 
> Based on above, remove acpi_hest_init() from acpi_pci_root_init() and
> convert ghes_init() and sdei_init() from initcalls to explicit calls in the
> following order:
> 
>     acpi_hest_init()
>     sdei_init()
>     ghes_init()
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>

I didn't suggest the approach; I just reviewed the patch and the
commit log and proposed moving it out of acpi_pci_root_init().  That
doesn't need to be acknowledged.

> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Minor extra "return" below.

> ---
>  drivers/acpi/apei/ghes.c    | 17 +++++++----------
>  drivers/acpi/bus.c          |  4 ++++
>  drivers/acpi/pci_root.c     |  3 ---
>  drivers/firmware/arm_sdei.c | 13 ++-----------
>  include/acpi/apei.h         |  4 +++-
>  include/linux/arm_sdei.h    |  2 ++
>  6 files changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c5c9acc6254..bed4f10cfcb8 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1457,33 +1457,33 @@ static struct platform_driver ghes_platform_driver = {
>  	.remove		= ghes_remove,
>  };
>  
> -static int __init ghes_init(void)
> +void __init ghes_init(void)
>  {
>  	int rc;
>  
>  	if (acpi_disabled)
> -		return -ENODEV;
> +		return;
>  
>  	switch (hest_disable) {
>  	case HEST_NOT_FOUND:
> -		return -ENODEV;
> +		return;
>  	case HEST_DISABLED:
>  		pr_info(GHES_PFX "HEST is not enabled!\n");
> -		return -EINVAL;
> +		return;
>  	default:
>  		break;
>  	}
>  
>  	if (ghes_disable) {
>  		pr_info(GHES_PFX "GHES is not enabled!\n");
> -		return -EINVAL;
> +		return;
>  	}
>  
>  	ghes_nmi_init_cxt();
>  
>  	rc = platform_driver_register(&ghes_platform_driver);
>  	if (rc)
> -		goto err;
> +		return;
>  
>  	rc = apei_osc_setup();
>  	if (rc == 0 && osc_sb_apei_support_acked)
> @@ -1495,8 +1495,5 @@ static int __init ghes_init(void)
>  	else
>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
>  
> -	return 0;
> -err:
> -	return rc;
> +	return;

Unnecessary "return".

>  }
> -device_initcall(ghes_init);
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07f604832fd6..1dcd71df2cd5 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -30,6 +30,7 @@
>  #include <linux/acpi_viot.h>
>  #include <linux/pci.h>
>  #include <acpi/apei.h>
> +#include <linux/arm_sdei.h>

This "arm" looks a little out of place in this supposedly arch-generic
code.  Not really a new thing with this patch, since this #include
already appears in drivers/acpi/apei/ghes.c.  Maybe it's unavoidable.

>  #include <linux/suspend.h>
>  #include <linux/prmt.h>
>  
> @@ -1331,6 +1332,9 @@ static int __init acpi_init(void)
>  
>  	pci_mmcfg_late_init();
>  	acpi_iort_init();
> +	acpi_hest_init();
> +	sdei_init();
> +	ghes_init();
>  	acpi_scan_init();
>  	acpi_ec_init();
>  	acpi_debugfs_init();
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b76db99cced3..6f9e75d14808 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -22,8 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/dmi.h>
>  #include <linux/platform_data/x86/apple.h>
> -#include <acpi/apei.h>	/* for acpi_hest_init() */
> -
>  #include "internal.h"
>  
>  #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
> @@ -943,7 +941,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  
>  void __init acpi_pci_root_init(void)
>  {
> -	acpi_hest_init();
>  	if (acpi_pci_disabled)
>  		return;
>  
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index a7e762c352f9..1e1a51510e83 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1059,14 +1059,14 @@ static bool __init sdei_present_acpi(void)
>  	return true;
>  }
>  
> -static int __init sdei_init(void)
> +void __init sdei_init(void)
>  {
>  	struct platform_device *pdev;
>  	int ret;
>  
>  	ret = platform_driver_register(&sdei_driver);
>  	if (ret || !sdei_present_acpi())
> -		return ret;
> +		return;
>  
>  	pdev = platform_device_register_simple(sdei_driver.driver.name,
>  					       0, NULL, 0);
> @@ -1076,17 +1076,8 @@ static int __init sdei_init(void)
>  		pr_info("Failed to register ACPI:SDEI platform device %d\n",
>  			ret);
>  	}
> -
> -	return ret;
>  }
>  
> -/*
> - * On an ACPI system SDEI needs to be ready before HEST:GHES tries to register
> - * its events. ACPI is initialised from a subsys_initcall(), GHES is initialised
> - * by device_initcall(). We want to be called in the middle.
> - */
> -subsys_initcall_sync(sdei_init);
> -
>  int sdei_event_handler(struct pt_regs *regs,
>  		       struct sdei_registered_event *arg)
>  {
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index ece0a8af2bae..4e60dd73c3bb 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -27,14 +27,16 @@ extern int hest_disable;
>  extern int erst_disable;
>  #ifdef CONFIG_ACPI_APEI_GHES
>  extern bool ghes_disable;
> +void __init ghes_init(void);
>  #else
>  #define ghes_disable 1
> +static inline void ghes_init(void) { }
>  #endif
>  
>  #ifdef CONFIG_ACPI_APEI
>  void __init acpi_hest_init(void);
>  #else
> -static inline void acpi_hest_init(void) { return; }
> +static inline void acpi_hest_init(void) { }
>  #endif
>  
>  int erst_write(const struct cper_record_header *record);
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index 0a241c5c911d..14dc461b0e82 100644
> --- a/include/linux/arm_sdei.h
> +++ b/include/linux/arm_sdei.h
> @@ -46,9 +46,11 @@ int sdei_unregister_ghes(struct ghes *ghes);
>  /* For use by arch code when CPU hotplug notifiers are not appropriate. */
>  int sdei_mask_local_cpu(void);
>  int sdei_unmask_local_cpu(void);
> +void __init sdei_init(void);
>  #else
>  static inline int sdei_mask_local_cpu(void) { return 0; }
>  static inline int sdei_unmask_local_cpu(void) { return 0; }
> +static inline void sdei_init(void) { }
>  #endif /* CONFIG_ARM_SDE_INTERFACE */
>  
>  
> -- 
> 2.20.1.12.g72788fdb
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
