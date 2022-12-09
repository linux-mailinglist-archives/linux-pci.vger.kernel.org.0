Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067EE648A1F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 22:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiLIVgH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 16:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLIVgG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 16:36:06 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9AB9231A;
        Fri,  9 Dec 2022 13:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670621764; x=1702157764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s2h6JZMK+y38C+V9uwWf7kAgtdvviKyiyV98RMVMr9g=;
  b=E6DGkjpp1YufNswfWm4UiOWIW/xOiw72/MONz7Kp07DCH+Qn2Phplaoi
   TuBEeXrbLcR6i8Iag02M9lBW0X31ff779SXzVldBdPVBlhXEr9E6C4XCu
   70bs2KcQILxrYDwuGQpr/2MbIedfM+GyyjpeirhaDlGvnAn8nFmeUlS35
   Y6ymrKrV6AOytasjZRUzUE32N3v1FkgInaIIyZb+IBfxdP3JrLnyQsi0t
   Lf9jQg1v1eDSd73kPmNVh6nIoxdrJPODyM7hnUXIejp3juUQK4+wcCebd
   DpyhQ98PScR3rmjsEM+u9QUU/arbxaT0EkIw1qAu79RJ07PMSU7CkHWpQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="316254279"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="316254279"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2022 13:36:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10556"; a="771982240"
X-IronPort-AV: E=Sophos;i="5.96,232,1665471600"; 
   d="scan'208";a="771982240"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2022 13:36:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p3l2D-007CBs-11;
        Fri, 09 Dec 2022 23:35:57 +0200
Date:   Fri, 9 Dec 2022 23:35:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 4/4] x86/PCI: Fix log message typo
Message-ID: <Y5OqPSV2RDdkAITE@smile.fi.intel.com>
References: <Y5OBupWBghHfvG/h@smile.fi.intel.com>
 <20221209205131.GA1726524@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209205131.GA1726524@bhelgaas>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 02:51:31PM -0600, Bjorn Helgaas wrote:
> On Fri, Dec 09, 2022 at 08:43:06PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 08, 2022 at 01:03:41PM -0600, Bjorn Helgaas wrote:

...

> > Wondering if we can change printk(KERN_LVL) to pr_lvl() in this file.
> 
> Sure!  How about this?

LGTM, you can add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
to it if you wish.

> commit 7058cdb558d5 ("x86/PCI: Use pr_info() when possible")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Dec 9 14:41:27 2022 -0600
> 
>     x86/PCI: Use pr_info() when possible
>     
>     Use pr_info() and similar when possible.  No functional change intended.
>     
>     Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

I prefer @linux.intel.com.

>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index 83dfea9e9894..ea2eb2ec90e2 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -1,4 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> +
> +#define pr_fmt(fmt) "PCI: " fmt
> +
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
>  #include <linux/init.h>
> @@ -37,15 +40,15 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
>  
>  static int __init set_ignore_seg(const struct dmi_system_id *id)
>  {
> -	printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
> +	pr_info("%s detected: ignoring ACPI _SEG\n", id->ident);
>  	pci_ignore_seg = true;
>  	return 0;
>  }
>  
>  static int __init set_no_e820(const struct dmi_system_id *id)
>  {
> -	printk(KERN_INFO "PCI: %s detected: not clipping E820 regions from _CRS\n",
> -	       id->ident);
> +	pr_info("%s detected: not clipping E820 regions from _CRS\n",
> +	        id->ident);
>  	pci_use_e820 = false;
>  	return 0;
>  }
> @@ -231,10 +234,9 @@ void __init pci_acpi_crs_quirks(void)
>  	else if (pci_probe & PCI_USE__CRS)
>  		pci_use_crs = true;
>  
> -	printk(KERN_INFO "PCI: %s host bridge windows from ACPI; "
> -	       "if necessary, use \"pci=%s\" and report a bug\n",
> -	       pci_use_crs ? "Using" : "Ignoring",
> -	       pci_use_crs ? "nocrs" : "use_crs");
> +	pr_info("%s host bridge windows from ACPI; if necessary, use \"pci=%s\" and report a bug\n",
> +	        pci_use_crs ? "Using" : "Ignoring",
> +	        pci_use_crs ? "nocrs" : "use_crs");
>  
>  	/* "pci=use_e820"/"pci=no_e820" on the kernel cmdline takes precedence */
>  	if (pci_probe & PCI_NO_E820)
> @@ -242,19 +244,17 @@ void __init pci_acpi_crs_quirks(void)
>  	else if (pci_probe & PCI_USE_E820)
>  		pci_use_e820 = true;
>  
> -	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> -	       pci_use_e820 ? "Using" : "Ignoring");
> +	pr_info("%s E820 reservations for host bridge windows\n",
> +	        pci_use_e820 ? "Using" : "Ignoring");
>  	if (pci_probe & (PCI_NO_E820 | PCI_USE_E820))
> -		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
> +		pr_info("Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
>  }
>  
>  #ifdef	CONFIG_PCI_MMCONFIG
>  static int check_segment(u16 seg, struct device *dev, char *estr)
>  {
>  	if (seg) {
> -		dev_err(dev,
> -			"%s can't access PCI configuration "
> -			"space under this host bridge.\n",
> +		dev_err(dev, "%s can't access configuration space under this host bridge\n",
>  			estr);
>  		return -EIO;
>  	}
> @@ -264,9 +264,7 @@ static int check_segment(u16 seg, struct device *dev, char *estr)
>  	 * just can't access extended configuration space of
>  	 * devices under this host bridge.
>  	 */
> -	dev_warn(dev,
> -		 "%s can't access extended PCI configuration "
> -		 "space under this bridge.\n",
> +	dev_warn(dev, "%s can't access extended configuration space under this bridge\n",
>  		 estr);
>  
>  	return 0;
> @@ -421,9 +419,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  		root->segment = domain = 0;
>  
>  	if (domain && !pci_domains_supported) {
> -		printk(KERN_WARNING "pci_bus %04x:%02x: "
> -		       "ignored (multiple domains not supported)\n",
> -		       domain, busnum);
> +		pr_warn("pci_bus %04x:%02x: ignored (multiple domains not supported)\n",
> +		        domain, busnum);
>  		return NULL;
>  	}
>  
> @@ -491,7 +488,7 @@ int __init pci_acpi_init(void)
>  	if (acpi_noirq)
>  		return -ENODEV;
>  
> -	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
> +	pr_info("Using ACPI for IRQ routing\n");
>  	acpi_irq_penalty_init();
>  	pcibios_enable_irq = acpi_pci_irq_enable;
>  	pcibios_disable_irq = acpi_pci_irq_disable;
> @@ -503,7 +500,7 @@ int __init pci_acpi_init(void)
>  		 * also do it here in case there are still broken drivers that
>  		 * don't use pci_enable_device().
>  		 */
> -		printk(KERN_INFO "PCI: Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
> +		pr_info("Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
>  		for_each_pci_dev(dev)
>  			acpi_pci_irq_enable(dev);
>  	}

-- 
With Best Regards,
Andy Shevchenko


