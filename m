Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061564663F9
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 13:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358095AbhLBMyG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 07:54:06 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:57723 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346795AbhLBMyE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 07:54:04 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0UzAa6VZ_1638449438;
Received: from 30.240.117.107(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0UzAa6VZ_1638449438)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 02 Dec 2021 20:50:40 +0800
Message-ID: <12b01448-0ebe-44fc-529a-6a1243acc2e3@linux.alibaba.com>
Date:   Thu, 2 Dec 2021 20:50:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RFC PATCH v4] ACPI: Move sdei_init and ghes_init ahead to handle
 platform errors earlier
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20211126070422.73234-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi, Bjron,

By any chance, could you help review this patch? Any comment are welcomed.

Regards,
Shuai

On 2021/11/26 PM3:04, Shuai Xue wrote:
> On an ACPI system, ACPI is initialised very early from a subsys_initcall(),
> while SDEI is not ready until a subsys_initcall_sync().
> 
> The SDEI driver provides functions (e.g. apei_sdei_register_ghes,
> apei_sdei_unregister_ghes) to register or unregister event callback for
> dispatcher in firmware. When the GHES driver probing, it registers the
> corresponding callback according to the notification type specified by
> GHES. If the GHES notification type is SDEI, the GHES driver will call
> apei_sdei_register_ghes to register event call.
> 
> When the firmware emits an event, it migrates the handling of the event
> into the kernel at the registered entry-point __sdei_asm_handler. And
> finally, the kernel will call the registered event callback and return
> status_code to indicate the status of event handling. SDEI_EV_FAILED
> indicates that the kernel failed to handle the event.
> 
> Consequently, when an error occurs during kernel booting, the kernel is
> unable to handle and report errors until the GHES driver is initialized by
> device_initcall(), in which the event callback is registered. All errors
> that occurred before GHES initialization are missed and there is no chance
> to report and find them again.
> 
> From commit e147133a42cb ("ACPI / APEI: Make hest.c manage the estatus
> memory pool") was merged, ghes_init() relies on acpi_hest_init() to manage
> the estatus memory pool. On the other hand, ghes_init() relies on
> sdei_init() to detect the SDEI version and the framework for registering
> and unregistering events. By the way, I don't figure out why acpi_hest_init
> is called in acpi_pci_root_init, it don't rely on any other thing. May it
> could be moved further, following acpi_iort_init in acpi_init.
> 
> sdei_init() relies on ACPI table which is initialized subsys_initcall():
> acpi_init(), acpi_bus_init(), acpi_load_tables(), acpi_tb_laod_namespace().
> May it should be also moved further, after acpi_load_tables.
> 
> In this patch, move sdei_init and ghes_init as far ahead as possible, right
> after acpi_hest_init().
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c    | 18 ++++++++----------
>  drivers/acpi/pci_root.c     |  5 ++++-
>  drivers/firmware/arm_sdei.c | 13 ++-----------
>  include/acpi/apei.h         |  2 ++
>  include/linux/arm_sdei.h    |  2 ++
>  5 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c8330ed1ffd..b11e46fb4b3d 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1457,27 +1457,26 @@ static struct platform_driver ghes_platform_driver = {
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
> +		pr_info(GHES_PFX "HEST is not found!\n");
> +		return;
>  	case HEST_DISABLED:
>  		pr_info(GHES_PFX "HEST is not enabled!\n");
> -		return -EINVAL;
> +		return;
>  	default:
>  		break;
>  	}
>  
> -	if (ghes_disable) {
> +	if (ghes_disable)
>  		pr_info(GHES_PFX "GHES is not enabled!\n");
> -		return -EINVAL;
> -	}
>  
>  	ghes_nmi_init_cxt();
>  
> @@ -1495,8 +1494,7 @@ static int __init ghes_init(void)
>  	else
>  		pr_info(GHES_PFX "Failed to enable APEI firmware first mode.\n");
>  
> -	return 0;
> +	return;
>  err:
> -	return rc;
> +	ghes_disable = 1;
>  }
> -device_initcall(ghes_init);
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ab2f7dfb0c44..1260bb556184 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -23,7 +23,7 @@
>  #include <linux/dmi.h>
>  #include <linux/platform_data/x86/apple.h>
>  #include <acpi/apei.h>	/* for acpi_hest_init() */
> -
> +#include <linux/arm_sdei.h> /* for sdei_init() */
>  #include "internal.h"
>  
>  #define ACPI_PCI_ROOT_CLASS		"pci_bridge"
> @@ -946,6 +946,9 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  void __init acpi_pci_root_init(void)
>  {
>  	acpi_hest_init();
> +	sdei_init();
> +	ghes_init();
> +
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
> index ece0a8af2bae..7dbd6363fda7 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -27,8 +27,10 @@ extern int hest_disable;
>  extern int erst_disable;
>  #ifdef CONFIG_ACPI_APEI_GHES
>  extern bool ghes_disable;
> +void __init ghes_init(void);
>  #else
>  #define ghes_disable 1
> +static inline void ghes_init(void) { return; }
>  #endif
>  
>  #ifdef CONFIG_ACPI_APEI
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index 0a241c5c911d..9c987188b692 100644
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
> +static inline void sdei_init(void) { return ; }
>  #endif /* CONFIG_ARM_SDE_INTERFACE */
>  
>  
> 
