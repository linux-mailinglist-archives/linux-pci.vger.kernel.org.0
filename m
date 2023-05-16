Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6962E7044F1
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 07:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjEPF7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 01:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjEPF7U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 01:59:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C3D40EC;
        Mon, 15 May 2023 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684216751; x=1715752751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QNL0Q4ixECAp72yv2Prm4lhm6brOEysrOMff6IkHi6o=;
  b=Y108G7OOw72WOqdDjRg63wFHFLW97Xbl9lvqcva2rZlYzHOXEIttZLlJ
   ZGSqddSHXa45GioLrTC6xk8hOxO9Bdc82HDACQ8OIUjqzyLbEcyjt6347
   49JKahHYb5uoJ0EAfdaWflicvr5eHJEZ8ZEivVVIEoa3wqi1kXujIRpoS
   FmrTh2G0CV+EkCi43W8kdZx0butrldG5NIgfFN9iVeV350tys/Du6UYRS
   AAYjQ3Ois2HQCJvYDPpkIR8ssE7hHMWlOD6ilPcwrAXrcCGzIfmqiUbcw
   0n3But3qpN7SsloyI5lusa2yh3XFxOx+E3J6GYIFyPkoZ7tzMYlzjAd0b
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="331752493"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="331752493"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 22:59:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="875486991"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="875486991"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2023 22:59:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 31A1E618; Tue, 16 May 2023 08:59:18 +0300 (EEST)
Date:   Tue, 16 May 2023 08:59:18 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI: Only put >= 2015 root ports into D3 on Intel
Message-ID: <20230516055918.GS66750@black.fi.intel.com>
References: <20230515231515.1440-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515231515.1440-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+Rafael

Hi Mario,

On Mon, May 15, 2023 at 06:15:15PM -0500, Mario Limonciello wrote:
> Using an XHCI device to wakeup the system from s2idle fails when
> that XHCI device is connected to a USB-C port for an AMD USB4
> router.
> 
> Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during
> suspend") all root port go into D3 during s2idle.
> When the root ports are in D3 over s2idle it's not possible for the
> platform firmware to properly identify the wakeup source.
> 
> As a user presses a key on a keyboard the APU will exit
> hardware sleep, but no wake source will be active so the kernel will
> let the APU enter back into a hardware sleep state.
> 
> Here is an example of that sequence of events.  The USB keyboard was
> pressed after 11.9 seconds, and then a GPIO was triggered after
> another 12 seconds.
> ```
> PM: suspend-to-idle
> ACPI: EC: ACPI EC GPE status set
> ACPI: PM: Rearming ACPI SCI for wakeup
> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> Timekeeping suspended for 11.985 seconds
> PM: Triggering wakeup from IRQ 9
> ACPI: EC: ACPI EC GPE status set
> ACPI: EC: ACPI EC GPE dispatched
> ACPI: EC: ACPI EC work flushed
> ACPI: EC: ACPI EC work flushed
> ACPI: PM: Rearming ACPI SCI for wakeup
> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> PM: Triggering wakeup from IRQ 9
> ACPI: EC: ACPI EC GPE status set
> ACPI: PM: Rearming ACPI SCI for wakeup
> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> Timekeeping suspended for 12.916 seconds
> PM: Triggering wakeup from IRQ 9
> PM: Triggering wakeup from IRQ 7
> ACPI: EC: ACPI EC GPE status set
> ACPI: EC: ACPI EC GPE dispatched
> ACPI: EC: ACPI EC work flushed
> ACPI: PM: Wakeup after ACPI Notify sync
> PM: resume from suspend-to-idle
> ```
> 
> If the root ports are in D0 during s2idle, then the wake source is
> properly identified and an IRQ is active for the root port, waking
> the system up.
> 
> Here is the same sequence with root ports in D0.  The USB keyboard
> was pressed after 11 seconds.
> ```
> PM: suspend-to-idle
> ACPI: EC: ACPI EC GPE status set
> ACPI: PM: Rearming ACPI SCI for wakeup
> amd_pmc AMDI0007:00: SMU idlemask s0i3: 0x8fff9eb5
> Timekeeping suspended for 11.138 seconds
> PM: Triggering wakeup from IRQ 9
> ACPI: PM: ACPI non-EC GPE wakeup
> PM: resume from suspend-to-idle
> PM: Triggering wakeup from IRQ 40
> ```
> 
> Comparing registers between Linux and Windows 11 this behavior to put root
> ports into D3 at suspend is unique to Linux. Windows does not put the
> root ports into D3 over Modern Standby.

Are you sure this is the case? Leaving the root port in D0 would mean
its power resource is left on and that would leave the whole USB4 domain
on consuming quite a lot of power. The root ports involved are supposed
to support PME from the D3hot/cold (this is what they advertise in their
config spaces) which should allow the OS to move the port into low power
states. Of course the PME from D3cold in general needs some ACPI support
(typically a GPE) in the BIOS.

> As this policy change to put root ports into D3 if they're manufactured
> after 2015 was originally introduced for Intel systems narrow it down to
> only apply there.
> 
> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5ede93222bc1..7d1b078b8d40 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3010,12 +3010,17 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  		if (dmi_check_system(bridge_d3_blacklist))
>  			return false;
>  
> +#ifdef CONFIG_X86
>  		/*
> -		 * It should be safe to put PCIe ports from 2015 or newer
> -		 * to D3.
> +		 * It should be safe to put PCIe ports from Intel systems
> +		 * from 2015 or newer to D3.
> +		 * Windows 11 does not do this over Modern Standby and this is
> +		 * known to cause problems with s2idle on some AMD systems.
>  		 */
> -		if (dmi_get_bios_year() >= 2015)
> +		if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&

Can't we then check here AMD case instead? Then generic case would be to
support according what the port announces.

> +		    dmi_get_bios_year() >= 2015)
>  			return true;
> +#endif
>  		break;
>  	}
>  
> -- 
> 2.34.1
