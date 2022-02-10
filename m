Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF86B4B181F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Feb 2022 23:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbiBJW1W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Feb 2022 17:27:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbiBJW1V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Feb 2022 17:27:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D05C2713;
        Thu, 10 Feb 2022 14:27:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 161DCB8279B;
        Thu, 10 Feb 2022 22:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBB6C004E1;
        Thu, 10 Feb 2022 22:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644532038;
        bh=Z2e6J7u0KguxQ4VI4XSMTqKxHhNT1hD/BMonCIZ8AtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c7gMQ5bc+dR6mVUSipwETblqEwMxp+QoCej3YapKgRmQVsa1i1MC75tiUFuJHFDCu
         fBAaysC4pWOG4Oo0OSJPGdeNNs7LIvDbPANJPD0RJ/bVIntCHvInPFiIPBoynfjhFr
         1zLNE1gl5dpqzf+dd+tE1y9wJvyj1epRHJWm68v0cE+mJ7sOVQi9YDhvh/pi9+P7Bh
         IMLFFbgKijWzHeBUItRdKumvmhNKLnUNomNUl/46W/16wMmKTDR3o+TiGt+7NCoZRL
         DfiqWYGi5HLuIdKT1Jn3Tzp7VJkJllSdDG+cTuo35gMXzpvoQAlkB/ymShFJIJ06gu
         fhTd93OKlUU4w==
Date:   Thu, 10 Feb 2022 16:27:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Joey Corleone <joey.corleone@mail.ru>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        linux-kernel@vger.kernel.org,
        Sergiu Deitsch <sergiu.deitsch@gmail.com>,
        David Spencer <dspencer577@gmail.com>
Subject: Re: [Bug 215533] [BISECTED][REGRESSION] UI becomes unresponsive
 every couple of seconds
Message-ID: <20220210222717.GA658201@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207224540.GA425996@bhelgaas>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Feb 07, 2022 at 04:45:40PM -0600, Bjorn Helgaas wrote:
> On Wed, Jan 26, 2022 at 06:12:50AM -0600, Bjorn Helgaas wrote:
> > On Wed, Jan 26, 2022 at 08:18:12AM +0000, bugzilla-daemon@bugzilla.kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=215533
> > > 
> > > --- Comment #1 from joey.corleone@mail.ru ---
> > > I accidentally sent the report prematurely. So here come my findings:
> > > 
> > > Since 5.16
> > > (1) my system becomes unresponsive every couple of seconds
> > > (micro lags), which makes it more or less unusable.
> > > (2) wrong(?) CPU frequencies are reported. 
> > > 
> > > - 5.15 works fine.
> > > - Starting from some commit in 5.17, it seems (1) is fixed
> > > (unsure), but definitely not (2).
> > > 
> > > I have bisected the kernel between 5.15 and 5.16, and found that
> > > the offending commit is 0e8ae5a6ff5952253cd7cc0260df838ab4c21009
> > > ("PCI/portdrv: Do not setup up IRQs if there are no users").
> > > Bisection log attached.
> > > 
> > > Reverting this commit on linux-git[1] fixes both (1) and (2).
> > > 
> > > Important notes:
> > > - This regression was reported on a DELL XPS 9550 laptop by two
> > > users [2], so it might be related strictly to that model. 
> > > - According to user mallocman, the issue can also be fixed by
> > > reverting the BIOS version of the laptop to v1.12.
> > > - The issue ONLY occurs when AC is plugged in (and stays there
> > > even when I unplug it).
> > > - When booting on battery power, there is no issue at all.
> > > 
> > > You can easily observe the regression via: 
> > > 
> > > watch cat /sys/devices/system/cpu/cpu[0-9]*/cpufreq/scaling_cur_fre
> > > 
> > > As soon as I plug in AC, all frequencies go up to values around
> > > 3248338 and stay there even if I unplug AC. This does not happen
> > > at all when booted on battery power. 
> > > 
> > > Also note: 
> > > - the laptop's fans are not really affected by the high
> > > frequencies.
> > > - setting the governor to "powersave" has no effect on the
> > > frequencies (as compared to when on battery power).
> > > - lowering the maximum frequency manually works, but does not
> > > fix (1).
> > > 
> > > [1] https://aur.archlinux.org/pkgbase/linux-git/ (pulled commits up to
> > > 0280e3c58f92b2fe0e8fbbdf8d386449168de4a8).
> > > [2] https://bbs.archlinux.org/viewtopic.php?id=273330
> 
> I hope we can find a better solution, but since the responsiveness
> issue is a significant regression, I queued up a revert of
> 0e8ae5a6ff59 ("PCI/portdrv: Do not setup up IRQs if there are no
> users") in case we don't find one.

Here's the revert I plan to merge for v5.17.  As mentioned at [3], I
think the problem is a BIOS defect that leaves interrupts enabled when
handing off to the kernel.

Bjorn

[3] https://lore.kernel.org/r/20220208185658.GA489586@bhelgaas


commit b139e2632409 ("Revert "PCI/portdrv: Do not setup up IRQs if there are no users"")
Author: Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon Feb 7 16:33:30 2022 -0600

    Revert "PCI/portdrv: Do not setup up IRQs if there are no users"
    
    This reverts commit 0e8ae5a6ff5952253cd7cc0260df838ab4c21009.
    
    0e8ae5a6ff59 ("PCI/portdrv: Do not setup up IRQs if there are no users")
    reduced usage of IRQs when we don't think we need them.  But several people
    reported unresponsive systems and bisected it to this commit.
    
    Revert 0e8ae5a6ff59 until we figure out a better solution.
    
    Reported-by: Joey Corleone <joey.corleone@mail.ru>
    Reported-by: Sergiu Deitsch <sergiu.deitsch@gmail.com>
    Reported-by: David Spencer <dspencer577@gmail.com>
    Link: https://bugzilla.kernel.org/show_bug.cgi?id=215533
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
    Cc: stable@vger.kernel.org	# v5.16+
    Cc: Jan Kiszka <jan.kiszka@siemens.com>

diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index bda630889f95..604feeb84ee4 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -166,6 +166,9 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
 	int ret, i;
 
+	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
+		irqs[i] = -1;
+
 	/*
 	 * If we support PME but can't use MSI/MSI-X for it, we have to
 	 * fall back to INTx or other interrupts, e.g., a system shared
@@ -314,10 +317,8 @@ static int pcie_device_init(struct pci_dev *pdev, int service, int irq)
  */
 int pcie_port_device_register(struct pci_dev *dev)
 {
-	int status, capabilities, irq_services, i, nr_service;
-	int irqs[PCIE_PORT_DEVICE_MAXSERVICES] = {
-		[0 ... PCIE_PORT_DEVICE_MAXSERVICES-1] = -1
-	};
+	int status, capabilities, i, nr_service;
+	int irqs[PCIE_PORT_DEVICE_MAXSERVICES];
 
 	/* Enable PCI Express port device */
 	status = pci_enable_device(dev);
@@ -330,32 +331,18 @@ int pcie_port_device_register(struct pci_dev *dev)
 		return 0;
 
 	pci_set_master(dev);
-
-	irq_services = 0;
-	if (IS_ENABLED(CONFIG_PCIE_PME))
-		irq_services |= PCIE_PORT_SERVICE_PME;
-	if (IS_ENABLED(CONFIG_PCIEAER))
-		irq_services |= PCIE_PORT_SERVICE_AER;
-	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
-		irq_services |= PCIE_PORT_SERVICE_HP;
-	if (IS_ENABLED(CONFIG_PCIE_DPC))
-		irq_services |= PCIE_PORT_SERVICE_DPC;
-	irq_services &= capabilities;
-
-	if (irq_services) {
-		/*
-		 * Initialize service IRQs. Don't use service devices that
-		 * require interrupts if there is no way to generate them.
-		 * However, some drivers may have a polling mode (e.g.
-		 * pciehp_poll_mode) that can be used in the absence of IRQs.
-		 * Allow them to determine if that is to be used.
-		 */
-		status = pcie_init_service_irqs(dev, irqs, irq_services);
-		if (status) {
-			irq_services &= PCIE_PORT_SERVICE_HP;
-			if (!irq_services)
-				goto error_disable;
-		}
+	/*
+	 * Initialize service irqs. Don't use service devices that
+	 * require interrupts if there is no way to generate them.
+	 * However, some drivers may have a polling mode (e.g. pciehp_poll_mode)
+	 * that can be used in the absence of irqs.  Allow them to determine
+	 * if that is to be used.
+	 */
+	status = pcie_init_service_irqs(dev, irqs, capabilities);
+	if (status) {
+		capabilities &= PCIE_PORT_SERVICE_HP;
+		if (!capabilities)
+			goto error_disable;
 	}
 
 	/* Allocate child services if any */
