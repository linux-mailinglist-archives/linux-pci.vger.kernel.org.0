Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFC16489B1
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 21:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLIUvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 15:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiLIUvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 15:51:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E127A386E;
        Fri,  9 Dec 2022 12:51:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAE2D6226D;
        Fri,  9 Dec 2022 20:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29CCC433D2;
        Fri,  9 Dec 2022 20:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670619094;
        bh=4XvJxrqF3sAgvuSNY4QXlfijdGTscOOPGfOGyD+HURM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DbckalQQrOfTLzdikfJ9WRywkgDNsJXUmtHQ+laCVoXa5lfPSxVI5o0suyNauwR+u
         S3cjQkkNBTFUuYUKczm/hWi3LlNd9rn0KzklJL0CsaGb/L3HvW12Ua4U5xj5Y9PNRs
         a3jghRl/CziOfLMP+9ZSKqDpL5eQPiGjV7cO6BedcIAfehDoGrcl+QLJKytxESigiM
         LXuadSQY3dD7WBJnCS+ZmHsxp3XhfeC4JxXbLKWAxzJwQln1sAICHCuGhqhwEUUq9V
         Uljdf2rm/fchdjKJa3hNvdbAT88IiwWSDv+60YDm589LYkNr0FKRKr8ODjiNShwm2R
         sAhTlCvJ3wr6w==
Date:   Fri, 9 Dec 2022 14:51:31 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
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
Message-ID: <20221209205131.GA1726524@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5OBupWBghHfvG/h@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 08:43:06PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 08, 2022 at 01:03:41PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > Add missing word in the log message:
> > 
> >   - ... so future kernels can this automatically
> >   + ... so future kernels can do this automatically
> 
> ...
> 
> >  	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
> >  	       pci_use_e820 ? "Using" : "Ignoring");
> >  	if (pci_probe & (PCI_NO_E820 | PCI_USE_E820))
> > -		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can this automatically\n");
> > +		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
> 
> Wondering if we can change printk(KERN_LVL) to pr_lvl() in this file.

Sure!  How about this?


commit 7058cdb558d5 ("x86/PCI: Use pr_info() when possible")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri Dec 9 14:41:27 2022 -0600

    x86/PCI: Use pr_info() when possible
    
    Use pr_info() and similar when possible.  No functional change intended.
    
    Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 83dfea9e9894..ea2eb2ec90e2 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -1,4 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) "PCI: " fmt
+
 #include <linux/pci.h>
 #include <linux/acpi.h>
 #include <linux/init.h>
@@ -37,15 +40,15 @@ static int __init set_nouse_crs(const struct dmi_system_id *id)
 
 static int __init set_ignore_seg(const struct dmi_system_id *id)
 {
-	printk(KERN_INFO "PCI: %s detected: ignoring ACPI _SEG\n", id->ident);
+	pr_info("%s detected: ignoring ACPI _SEG\n", id->ident);
 	pci_ignore_seg = true;
 	return 0;
 }
 
 static int __init set_no_e820(const struct dmi_system_id *id)
 {
-	printk(KERN_INFO "PCI: %s detected: not clipping E820 regions from _CRS\n",
-	       id->ident);
+	pr_info("%s detected: not clipping E820 regions from _CRS\n",
+	        id->ident);
 	pci_use_e820 = false;
 	return 0;
 }
@@ -231,10 +234,9 @@ void __init pci_acpi_crs_quirks(void)
 	else if (pci_probe & PCI_USE__CRS)
 		pci_use_crs = true;
 
-	printk(KERN_INFO "PCI: %s host bridge windows from ACPI; "
-	       "if necessary, use \"pci=%s\" and report a bug\n",
-	       pci_use_crs ? "Using" : "Ignoring",
-	       pci_use_crs ? "nocrs" : "use_crs");
+	pr_info("%s host bridge windows from ACPI; if necessary, use \"pci=%s\" and report a bug\n",
+	        pci_use_crs ? "Using" : "Ignoring",
+	        pci_use_crs ? "nocrs" : "use_crs");
 
 	/* "pci=use_e820"/"pci=no_e820" on the kernel cmdline takes precedence */
 	if (pci_probe & PCI_NO_E820)
@@ -242,19 +244,17 @@ void __init pci_acpi_crs_quirks(void)
 	else if (pci_probe & PCI_USE_E820)
 		pci_use_e820 = true;
 
-	printk(KERN_INFO "PCI: %s E820 reservations for host bridge windows\n",
-	       pci_use_e820 ? "Using" : "Ignoring");
+	pr_info("%s E820 reservations for host bridge windows\n",
+	        pci_use_e820 ? "Using" : "Ignoring");
 	if (pci_probe & (PCI_NO_E820 | PCI_USE_E820))
-		printk(KERN_INFO "PCI: Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
+		pr_info("Please notify linux-pci@vger.kernel.org so future kernels can do this automatically\n");
 }
 
 #ifdef	CONFIG_PCI_MMCONFIG
 static int check_segment(u16 seg, struct device *dev, char *estr)
 {
 	if (seg) {
-		dev_err(dev,
-			"%s can't access PCI configuration "
-			"space under this host bridge.\n",
+		dev_err(dev, "%s can't access configuration space under this host bridge\n",
 			estr);
 		return -EIO;
 	}
@@ -264,9 +264,7 @@ static int check_segment(u16 seg, struct device *dev, char *estr)
 	 * just can't access extended configuration space of
 	 * devices under this host bridge.
 	 */
-	dev_warn(dev,
-		 "%s can't access extended PCI configuration "
-		 "space under this bridge.\n",
+	dev_warn(dev, "%s can't access extended configuration space under this bridge\n",
 		 estr);
 
 	return 0;
@@ -421,9 +419,8 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		root->segment = domain = 0;
 
 	if (domain && !pci_domains_supported) {
-		printk(KERN_WARNING "pci_bus %04x:%02x: "
-		       "ignored (multiple domains not supported)\n",
-		       domain, busnum);
+		pr_warn("pci_bus %04x:%02x: ignored (multiple domains not supported)\n",
+		        domain, busnum);
 		return NULL;
 	}
 
@@ -491,7 +488,7 @@ int __init pci_acpi_init(void)
 	if (acpi_noirq)
 		return -ENODEV;
 
-	printk(KERN_INFO "PCI: Using ACPI for IRQ routing\n");
+	pr_info("Using ACPI for IRQ routing\n");
 	acpi_irq_penalty_init();
 	pcibios_enable_irq = acpi_pci_irq_enable;
 	pcibios_disable_irq = acpi_pci_irq_disable;
@@ -503,7 +500,7 @@ int __init pci_acpi_init(void)
 		 * also do it here in case there are still broken drivers that
 		 * don't use pci_enable_device().
 		 */
-		printk(KERN_INFO "PCI: Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
+		pr_info("Routing PCI interrupts for all devices because \"pci=routeirq\" specified\n");
 		for_each_pci_dev(dev)
 			acpi_pci_irq_enable(dev);
 	}
