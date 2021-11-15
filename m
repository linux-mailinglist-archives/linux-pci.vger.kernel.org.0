Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E252F45099A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 17:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhKOQae (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 11:30:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231639AbhKOQad (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 15 Nov 2021 11:30:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36E5960235;
        Mon, 15 Nov 2021 16:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636993656;
        bh=4JbhaJa+WKgNpMtMZdbDTrTF43/5Tpkk286u8m+D2q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DiziJVtUjHRR5a2WuY01BjtVns2jwsr+GsL2MyTH00JvwAMa2/A/181Jxnj/ccGC9
         3h71mVzPIfFbKi9dFWK1mF4nEbD67jENiphimWiwftNmwTGTQBwc68KhQRDl3tcHdT
         hJ9ceH21hBj6XbgPcxcvKXqqhkz0THLwsCf4UiTRrv4vHj2sP1s2HAP+V34um2DSjC
         nMeO0s0qOOsSrf7GsLCCvfe0HKyy99+Lw8jqP1N6vL7QJ2vwvhrJvwar3FUkbMGbbO
         XHm2yWdmxjmxpnBlsSWqmSejYZ7lYffxoRlfu2a4bS5hpslqhehXw82nMSkhDfNy9N
         zQP0VQWA3MBLg==
Date:   Mon, 15 Nov 2021 10:27:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        lenb@kernel.org, rjw@rjwysocki.net, bhelgaas@google.com,
        zhangliguang@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: Re: [RFC PATCH v3] ACPI: Move sdei_init and ghes_init ahead
Message-ID: <20211115162734.GA1566887@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115064415.29933-1-xueshuai@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The subject says *what* the patch does, but doesn't give any clue
about *why* we want this.

On Mon, Nov 15, 2021 at 02:44:15PM +0800, Shuai Xue wrote:
> On an ACPI system, ACPI is initialised very early from a
> subsys_initcall(), while SDEI is not ready until a subsys_initcall().

This sentence sounds like it's setting up a contrast between ACPI init
and SDEI init, but apparently both are subsys_initcall(), so this
doesn't actually say what the difference is.

> More seriously, the kernel is able to handle and report errors until the
> GHES is initialised by device_initcall().

Did you mean "unable"?  Or do you really mean the kernel can handle
errors until GHES is initialized, but can't handle errors *after* GHES
is initialized?

> Consequently, when an error occurs during the kernel booting, the
> phyiscal sdei dispatcher in firmware fails to dispatch error events. All
> errors that occurred before GHES initialization are missed and there is
> no chance to report and find them again.

s/phyiscal/physical/
s/sdei/SDEI/

This doesn't explain how something in the kernel can prevent the
dispatcher in firmware from doing something.  Maybe the firmware emits
an event and the kernel isn't listening?

What is SDEI?  Please provide a citation to whatever spec is relevant.

> In this patch, move sdei_init and ghes_init as far ahead as possible,
> right after acpi_hest_init().

Please be explicit about what the dependencies are here.  Is there
something in sdei_init() that depends on acpi_hest_init()?  If so,
what is it specifically?

Similarly, does ghes_init() depend on something in sdei_init()?

> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> ---
> Changelog v2 -> v3:
> Fix compile error in X86
> Reported-by: kernel test robot<lkp@intel.com>
> ---
>  drivers/acpi/apei/ghes.c    | 3 +--
>  drivers/acpi/pci_root.c     | 8 +++++++-
>  drivers/firmware/arm_sdei.c | 9 +--------
>  include/acpi/apei.h         | 2 ++
>  include/linux/arm_sdei.h    | 2 ++
>  5 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 0c8330ed1ffd..4200369503b8 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1457,7 +1457,7 @@ static struct platform_driver ghes_platform_driver = {
>  	.remove		= ghes_remove,
>  };
>  
> -static int __init ghes_init(void)
> +int __init ghes_init(void)
>  {
>  	int rc;
>  
> @@ -1499,4 +1499,3 @@ static int __init ghes_init(void)
>  err:
>  	return rc;
>  }
> -device_initcall(ghes_init);
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index ab2f7dfb0c44..7658ae509377 100644
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
> @@ -946,6 +946,12 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
>  void __init acpi_pci_root_init(void)
>  {
>  	acpi_hest_init();
> +	#ifdef CONFIG_ARM_SDE_INTERFACE
> +	sdei_init();
> +	#endif 
> +	#ifdef CONFIG_ACPI_APEI_GHES
> +	ghes_init();
> +	#endif 

I love to replace initcalls with explicit calls.  You provided stubs
below, so why the #ifdefs here?

>  	if (acpi_pci_disabled)
>  		return;
>  
> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index a7e762c352f9..606520be326e 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -1059,7 +1059,7 @@ static bool __init sdei_present_acpi(void)
>  	return true;
>  }
>  
> -static int __init sdei_init(void)
> +int __init sdei_init(void)
>  {
>  	struct platform_device *pdev;
>  	int ret;
> @@ -1080,13 +1080,6 @@ static int __init sdei_init(void)
>  	return ret;
>  }
>  
> -/*
> - * On an ACPI system SDEI needs to be ready before HEST:GHES tries to register
> - * its events. ACPI is initialised from a subsys_initcall(), GHES is initialised
> - * by device_initcall(). We want to be called in the middle.
> - */
> -subsys_initcall_sync(sdei_init);

Ugh.  It's really good to get rid of this sort of implicit ordering.

>  int sdei_event_handler(struct pt_regs *regs,
>  		       struct sdei_registered_event *arg)
>  {
> diff --git a/include/acpi/apei.h b/include/acpi/apei.h
> index ece0a8af2bae..155a0fe417c6 100644
> --- a/include/acpi/apei.h
> +++ b/include/acpi/apei.h
> @@ -27,8 +27,10 @@ extern int hest_disable;
>  extern int erst_disable;
>  #ifdef CONFIG_ACPI_APEI_GHES
>  extern bool ghes_disable;
> +int __init ghes_init(void);
>  #else
>  #define ghes_disable 1
> +static inline int ghes_init(void) { return 0; }

I think the only reason ghes_init() returns int is because that's what
initcall_t requires.  If ghes_init() is no longer an initcall and
nobody looks at its return value, it should return void instead.

Same with sdei_init().

>  #endif
>  
>  #ifdef CONFIG_ACPI_APEI
> diff --git a/include/linux/arm_sdei.h b/include/linux/arm_sdei.h
> index 0a241c5c911d..983b7404bff9 100644
> --- a/include/linux/arm_sdei.h
> +++ b/include/linux/arm_sdei.h
> @@ -46,9 +46,11 @@ int sdei_unregister_ghes(struct ghes *ghes);
>  /* For use by arch code when CPU hotplug notifiers are not appropriate. */
>  int sdei_mask_local_cpu(void);
>  int sdei_unmask_local_cpu(void);
> +int __init sdei_init(void);
>  #else
>  static inline int sdei_mask_local_cpu(void) { return 0; }
>  static inline int sdei_unmask_local_cpu(void) { return 0; }
> +static inline int sdei_init(void) { return 0; }
>  #endif /* CONFIG_ARM_SDE_INTERFACE */
>  
>  
> -- 
> 2.20.1.12.g72788fdb
> 
