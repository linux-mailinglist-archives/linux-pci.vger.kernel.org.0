Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51B74CC600
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 20:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiCCT2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 14:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiCCT20 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 14:28:26 -0500
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E504AFD1D;
        Thu,  3 Mar 2022 11:27:39 -0800 (PST)
Received: by mail-yb1-f182.google.com with SMTP id g1so12357027ybe.4;
        Thu, 03 Mar 2022 11:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdHDMFF2kdVDaRtLqe4g+qzFPUAjMQZJkBGYq3TkeN8=;
        b=4iN13Vo5sWjUiWuErSTUtW/d4LA9nAbD4nrfwGmgCEO/quI7xcG9xeiN1BUoR5QhqN
         uZir3Nyeo57zxOVC0q6DYbjOZ20U8QmksoUldmu9vUWP7nqCWA1aFQek+NKU+ubtNDa3
         /7HLnez7qzNjBfLWaQYorBohf54ZOip5ABCHVXhEpb9xTWJ+emwFmvA9BbkmLoXUq4z6
         R+/MBndGsDuGTNPKtq493+b9kdKlFXAtHGTWu/gDWMbW3+zUOzk+YmlS+erTXNUoPrVo
         Ee1egQ51L94uUO95B4Zrm87j3utIH0Z1bPS9oF5TyofFWVIwADkX1pdZRUZ5MQPaDI+J
         p2dg==
X-Gm-Message-State: AOAM533yWEK+TZYArThCCNZWTj4Ejb1krJiz6huPTWecBXSrQEXYTN0W
        p9wu8oHSgnHx1THPioesRQk4thD5hB5Sn1oIt5T5cHe9
X-Google-Smtp-Source: ABdhPJyidoUIHRrRRyGejEbhZFI+Vfca8OZiMi/yIw2X1RjdEdt/4m1HGkDFofV5Asc24uuNz9cy4RSxc/Ay3S1OCh8=
X-Received: by 2002:a25:d7c2:0:b0:628:9d06:457b with SMTP id
 o185-20020a25d7c2000000b006289d06457bmr9396954ybg.137.1646335659111; Thu, 03
 Mar 2022 11:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com> <20220227122546.43307-1-xueshuai@linux.alibaba.com>
In-Reply-To: <20220227122546.43307-1-xueshuai@linux.alibaba.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Mar 2022 20:27:28 +0100
Message-ID: <CAJZ5v0jsPf=o9T0TpB85s0mqfB3Mr72y6BMxPf9ifvNm8XjNkA@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] ACPI: APEI: explicit init HEST and GHES in apci_init
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        luanshi <zhangliguang@linux.alibaba.com>,
        zhuo.song@linux.alibaba.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Feb 27, 2022 at 1:26 PM Shuai Xue <xueshuai@linux.alibaba.com> wrote:
>
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

Applied as 5.18 material along with the [2/2], thanks!

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
>         .remove         = ghes_remove,
>  };
>
> -static int __init ghes_init(void)
> +void __init ghes_init(void)
>  {
>         int rc;
>
> +       sdei_init();
> +
>         if (acpi_disabled)
> -               return -ENODEV;
> +               return;
>
>         switch (hest_disable) {
>         case HEST_NOT_FOUND:
> -               return -ENODEV;
> +               return;
>         case HEST_DISABLED:
>                 pr_info(GHES_PFX "HEST is not enabled!\n");
> -               return -EINVAL;
> +               return;
>         default:
>                 break;
>         }
>
>         if (ghes_disable) {
>                 pr_info(GHES_PFX "GHES is not enabled!\n");
> -               return -EINVAL;
> +               return;
>         }
>
>         ghes_nmi_init_cxt();
>
>         rc = platform_driver_register(&ghes_platform_driver);
>         if (rc)
> -               goto err;
> +               return;
>
>         rc = apei_osc_setup();
>         if (rc == 0 && osc_sb_apei_support_acked)
> @@ -1494,9 +1496,4 @@ static int __init ghes_init(void)
>                 pr_info(GHES_PFX "APEI firmware first mode is enabled by APEI bit.\n");
>         else
>                 pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
> -
> -       return 0;
> -err:
> -       return rc;
>  }
> -device_initcall(ghes_init);
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 07f604832fd6..3f403db20f69 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1331,6 +1331,8 @@ static int __init acpi_init(void)
>
>         pci_mmcfg_late_init();
>         acpi_iort_init();
> +       acpi_hest_init();
> +       ghes_init();
>         acpi_scan_init();
>         acpi_ec_init();
>         acpi_debugfs_init();
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index b76db99cced3..6f9e75d14808 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -22,8 +22,6 @@
>  #include <linux/slab.h>
>  #include <linux/dmi.h>
>  #include <linux/platform_data/x86/apple.h>
> -#include <acpi/apei.h> /* for acpi_hest_init() */
> -
>  #include "internal.h"
>
>  #define ACPI_PCI_ROOT_CLASS            "pci_bridge"
> @@ -943,7 +941,6 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>
>  void __init acpi_pci_root_init(void)
>  {
> -       acpi_hest_init();
>         if (acpi_pci_disabled)
>                 return;
>
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index 75cb91055c17..e5cfb01353d8 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -40,6 +40,7 @@ config ARM_SCPI_POWER_DOMAIN
>  config ARM_SDE_INTERFACE
>         bool "ARM Software Delegated Exception Interface (SDEI)"
>         depends on ARM64
> +       depends on ACPI_APEI_GHES
>         help
>           The Software Delegated Exception Interface (SDEI) is an ARM
>           standard for registering callbacks from the platform firmware
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index a7e762c352f9..1e1a51510e83 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1059,14 +1059,14 @@ static bool __init sdei_present_acpi(void)
>         return true;
>  }
>
> -static int __init sdei_init(void)
> +void __init sdei_init(void)
>  {
>         struct platform_device *pdev;
>         int ret;
>
>         ret = platform_driver_register(&sdei_driver);
>         if (ret || !sdei_present_acpi())
> -               return ret;
> +               return;
>
>         pdev = platform_device_register_simple(sdei_driver.driver.name,
>                                                0, NULL, 0);
> @@ -1076,17 +1076,8 @@ static int __init sdei_init(void)
>                 pr_info("Failed to register ACPI:SDEI platform device %d\n",
>                         ret);
>         }
> -
> -       return ret;
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
>                        struct sdei_registered_event *arg)
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
