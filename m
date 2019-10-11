Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A783ED3D10
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2019 12:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbfJKKOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Oct 2019 06:14:04 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64034 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJKKOE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Oct 2019 06:14:04 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id bbdde877b9a3fecb; Fri, 11 Oct 2019 12:14:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Drake <drake@endlessm.com>
Cc:     rafael@kernel.org, bhelgaas@google.com,
        mathias.nyman@linux.intel.com, linux@endlessm.com,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: also apply D3 delay when leaving D3cold
Date:   Fri, 11 Oct 2019 12:14:01 +0200
Message-ID: <261805141.5tZyQaKU0z@kreacher>
In-Reply-To: <20190927090202.1468-1-drake@endlessm.com>
References: <20190927090202.1468-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday, September 27, 2019 11:02:02 AM CEST Daniel Drake wrote:
> This delay is needed to fix resume from s2idle of the XHCI controller on
> AMD Ryzen SoCs, where a 20ms delay is required (this will be quirked
> in a followup patch), to avoid this failure:
> 
>   xhci_hcd 0000:03:00.4: WARN: xHC restore state timeout
>   xhci_hcd 0000:03:00.4: PCI post-resume error -110!
> 
> The D3 delay is already being performed in a runtime resume from D3cold,
> through the following sequence of events:
> 
>      pci_pm_runtime_resume
>   -> pci_restore_standard_config
>   -> pci_set_power_state(D0)
>   -> __pci_start_power_transition
>   -> pci_platform_power_transition
>   -> pci_update_current_state
> 
> At this point, the device has been set to D0 at the platform level,
> so pci_update_current_state() reads pmcsr and updates dev->current_state
> to D3hot. Now when we reach pci_raw_set_power_state() the D3 delay will
> be applied.
> 
> However, the D3cold resume from s2idle path is somewhat different, and
> we arrive at the same function without hitting pci_update_current_state()
> along the way:
>      pci_pm_resume_noirq
>   -> pci_pm_default_resume_early
>   -> pci_power_up
>   -> pci_raw_set_power_state
> 
> As dev->current_state is D3cold, the D3 delay is skipped and the XHCI
> controllers fail to be powered up.
> 
> Apply the D3 delay in the s2idle resume case too, in order to fix
> USB functionality after resume.
> 
> Link: http://lkml.kernel.org/r/CAD8Lp47Vh69gQjROYG69=waJgL7hs1PwnLonL9+27S_TcRhixA@mail.gmail.com
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e7982af9a5d8..ab15fa5eda2c 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -883,7 +883,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>  	 * Mandatory power management transition delays; see PCI PM 1.1
>  	 * 5.6.1 table 18
>  	 */
> -	if (state == PCI_D3hot || dev->current_state == PCI_D3hot)
> +	if (state == PCI_D3hot || dev->current_state == PCI_D3hot
> +			|| dev->current_state == PCI_D3cold)
>  		pci_dev_d3_sleep(dev);
>  	else if (state == PCI_D2 || dev->current_state == PCI_D2)
>  		udelay(PCI_PM_D2_DELAY);
> 

So I think that we can use pci_restore_standard_config() in the system resume
patch too, which should address the issue as well.

Basically, there is no reason for the PM-runtime and system-wide resume code
paths to be different in that respect.

Something like this (untested):

---
 drivers/pci/pci-driver.c |   11 ++---------
 drivers/pci/pci.c        |   13 -------------
 drivers/pci/pci.h        |    1 -
 3 files changed, 2 insertions(+), 23 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -521,13 +521,6 @@ static int pci_restore_standard_config(s
 
 #ifdef CONFIG_PM_SLEEP
 
-static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
-{
-	pci_power_up(pci_dev);
-	pci_restore_state(pci_dev);
-	pci_pme_restore(pci_dev);
-}
-
 /*
  * Default "suspend" method for devices that have no driver provided suspend,
  * or not even a driver at all (second part).
@@ -938,7 +931,7 @@ static int pci_pm_resume_noirq(struct de
 	 * pointless, so avoid doing that.
 	 */
 	if (!(pci_dev->skip_bus_pm && pm_suspend_no_platform()))
-		pci_pm_default_resume_early(pci_dev);
+		pci_restore_standard_config(pci_dev);
 
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
@@ -1213,7 +1206,7 @@ static int pci_pm_restore_noirq(struct d
 			return error;
 	}
 
-	pci_pm_default_resume_early(pci_dev);
+	pci_restore_standard_config(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -959,19 +959,6 @@ void pci_refresh_power_state(struct pci_
 }
 
 /**
- * pci_power_up - Put the given device into D0 forcibly
- * @dev: PCI device to power up
- */
-void pci_power_up(struct pci_dev *dev)
-{
-	if (platform_pci_power_manageable(dev))
-		platform_pci_set_power_state(dev, PCI_D0);
-
-	pci_raw_set_power_state(dev, PCI_D0);
-	pci_update_current_state(dev, PCI_D0);
-}
-
-/**
  * pci_platform_power_transition - Use platform to change device power state
  * @dev: PCI device to handle.
  * @state: State to put the device into.
Index: linux-pm/drivers/pci/pci.h
===================================================================
--- linux-pm.orig/drivers/pci/pci.h
+++ linux-pm/drivers/pci/pci.h
@@ -85,7 +85,6 @@ struct pci_platform_pm_ops {
 int pci_set_platform_pm(const struct pci_platform_pm_ops *ops);
 void pci_update_current_state(struct pci_dev *dev, pci_power_t state);
 void pci_refresh_power_state(struct pci_dev *dev);
-void pci_power_up(struct pci_dev *dev);
 void pci_disable_enabled_device(struct pci_dev *dev);
 int pci_finish_runtime_suspend(struct pci_dev *dev);
 void pcie_clear_root_pme_status(struct pci_dev *dev);




