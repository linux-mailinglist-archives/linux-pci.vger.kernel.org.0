Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AC4BEA9E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 20:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiBUS13 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 13:27:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiBUSYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 13:24:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC3BC16;
        Mon, 21 Feb 2022 10:18:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B9BBB816FE;
        Mon, 21 Feb 2022 18:18:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E65AC340F3;
        Mon, 21 Feb 2022 18:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645467493;
        bh=S1vGtwS4KykF+yhuJ99zcf6yhoG3r8pnEHQDaWwXoEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iv92DACRUb9jOK97wiMS5YG7jJJF3+v9mqjsuKQnQeeReq0Uk3tV1wH+AF5O/d5OA
         z5ZDHpRgco6/OTXPllyZCP4QV1utNCL/9psS6ET40UPq051mCv89a1Id4smsHlAMma
         xgLoU7aPCdRISP6k/tsbN7TwV++22kDMP3Thu+Ylz4DkahAJZAnzVy2pHoLE+unAj1
         rw5xqJtmfEvzTLXXmuZydoPkSujMsK9Q4TTqDT3z9XHu1hWQNBvu9nSnm7aOd5zRci
         2uGtxTrfBZl8At1dJUTHyNwpfx8NYOQLfwfYeHizK0XQ5tE/le2OegTdec7JNBhHWC
         N4EXMMt3f+WKA==
Date:   Mon, 21 Feb 2022 11:18:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     helgaas@kernel.org, rafael@kernel.org, bp@alien8.de,
        tony.luck@intel.com, james.morse@arm.com, lenb@kernel.org,
        rjw@rjwysocki.net, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 1/2] ACPI: APEI: explicit init HEST and GHES in
 apci_init
Message-ID: <YhPXX+CSoK++9MP6@dev-arch.archlinux-ax161>
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
 <20220122052618.1074-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122052618.1074-1-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Shuai,

On Sat, Jan 22, 2022 at 01:26:17PM +0800, Shuai Xue wrote:
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
>     ghes_init()
>         sdei_init()
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c    | 19 ++++++++-----------
>  drivers/acpi/bus.c          |  2 ++
>  drivers/acpi/pci_root.c     |  3 ---
>  drivers/firmware/Kconfig    |  1 +
>  drivers/firmware/arm_sdei.c | 13 ++-----------
>  include/acpi/apei.h         |  4 +++-
>  include/linux/arm_sdei.h    |  2 ++
>  7 files changed, 18 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c5c9acc6254..aadc0a972f18 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1457,33 +1457,35 @@ static struct platform_driver ghes_platform_driver = {
>  	.remove		= ghes_remove,
>  };
>  
> -static int __init ghes_init(void)
> +void __init ghes_init(void)
>  {
>  	int rc;
>  
> +	sdei_init();
> +
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
> @@ -1494,9 +1496,4 @@ static int __init ghes_init(void)
>  		pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
>  	else
>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
> -
> -	return 0;
> -err:
> -	return rc;
>  }
> -device_initcall(ghes_init);
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07f604832fd6..3f403db20f69 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1331,6 +1331,8 @@ static int __init acpi_init(void)
>  
>  	pci_mmcfg_late_init();
>  	acpi_iort_init();
> +	acpi_hest_init();
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
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 75cb91055c17..ad114d9cdf8e 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -40,6 +40,7 @@ config ARM_SCPI_POWER_DOMAIN
>  config ARM_SDE_INTERFACE
>  	bool "ARM Software Delegated Exception Interface (SDEI)"
>  	depends on ARM64
> +	select ACPI_APEI_GHES

As the kernel test robot pointed out [1], you cannot do this.
CONFIG_ACPI_APEI_GHES is a user selectable symbol that has dependencies,
which 'select' completely overrides, resulting in build failures when
CONFIG_ACPI_APEI is not enabled.

If CONFIG_ARM_SDE_INTERFACE truly requires CONFIG_ACPI_APEI_GHES, you
should have "depends on ACPI_APEI_GHES".

If CONFIG_ARM_SDE_INTERFACE soft depends on CONFIG_ACPI_APEI_GHES for
functionality but can work without it, you could use
"imply ACPI_APEI_GHES", which will enable CONFIG_ACPI_APEI_GHES if its
dependencies are met.

I noticed the same error with Alpine Linux's aarch64 configuration [2]
if you wanted a quick configuration to test with.

[1]: https://lore.kernel.org/r/202202151504.jWpZGPaH-lkp@intel.com/
[2]: https://git.alpinelinux.org/aports/plain/community/linux-edge/config-edge.aarch64

Cheers,
Nathan

>  	help
>  	  The Software Delegated Exception Interface (SDEI) is an ARM
>  	  standard for registering callbacks from the platform firmware
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
