Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3D0DD5EB9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 11:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbfJNJW7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 05:22:59 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55009 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730700AbfJNJW6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 05:22:58 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id cf86be6b2ce80331; Mon, 14 Oct 2019 11:22:56 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Daniel Drake <drake@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: also apply D3 delay when leaving D3cold
Date:   Mon, 14 Oct 2019 11:22:56 +0200
Message-ID: <4883845.KNzyzeMIEj@kreacher>
In-Reply-To: <CAD8Lp46NF8rq55g0Mz40Mmz1+KzqrTzziK3oYcmfh=1RUCRzug@mail.gmail.com>
References: <20190927090202.1468-1-drake@endlessm.com> <261805141.5tZyQaKU0z@kreacher> <CAD8Lp46NF8rq55g0Mz40Mmz1+KzqrTzziK3oYcmfh=1RUCRzug@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday, October 14, 2019 8:18:06 AM CEST Daniel Drake wrote:
> On Fri, Oct 11, 2019 at 6:14 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > So I think that we can use pci_restore_standard_config() in the system resume
> > patch too, which should address the issue as well.
> >
> > Basically, there is no reason for the PM-runtime and system-wide resume code
> > paths to be different in that respect.
> 
> Your patch works without modification when combined with
> https://patchwork.kernel.org/patch/11187815/

Great, thanks for the confirmation!

> Can you push this directly or would it be helpful if I update the
> commit message and submit it by email?

It would be prudent if I submitted it properly with a changelog etc.

However, I noticed that it might cause the ACPI power state to get out of sync
during resume from suspend-to-RAM in some (arguably theoretical only) cases.

Specifically, that may happen if the kernel puts a device into D3hot on
suspend and the platform firmware powers it up during system wakeup, because in
that case the pci_update_current_state() in pci_restore_standard_config() will
notice D0 and the pci_set_power_state() in there will not be called, so the
ACPI layer will still hold on to the stale D3hot power state value.

While I still think that both the system resume and runtime resume code paths
should be as similar as reasonably possible, the above needs to be taken into
account IMO, so it is better to retain pci_pm_default_resume_early(), but make
it do a conditional "ACPI power state refresh" and then call
pci_restore_standard_config().

So something like the patch below (can you please test it too?).

---
 drivers/pci/pci-driver.c |    8 +++++---
 drivers/pci/pci.c        |   15 ---------------
 drivers/pci/pci.h        |    1 -
 3 files changed, 5 insertions(+), 19 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -523,9 +523,10 @@ static int pci_restore_standard_config(s
 
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
-	pci_power_up(pci_dev);
-	pci_restore_state(pci_dev);
-	pci_pme_restore(pci_dev);
+	if (pm_resume_via_firmware())
+		pci_refresh_power_state(pci_dev);
+
+	pci_restore_standard_config(pci_dev);
 }
 
 /*
@@ -713,6 +714,7 @@ static void pci_pm_complete(struct devic
 		pci_power_t pre_sleep_state = pci_dev->current_state;
 
 		pci_refresh_power_state(pci_dev);
+		pci_update_current_state(pci_dev, pci_dev->current_state);
 		/*
 		 * On platforms with ACPI this check may also trigger for
 		 * devices sharing power resources if one of those power
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -954,21 +954,6 @@ void pci_refresh_power_state(struct pci_
 {
 	if (platform_pci_power_manageable(dev))
 		platform_pci_refresh_power_state(dev);
-
-	pci_update_current_state(dev, dev->current_state);
-}
-
-/**
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
 }
 
 /**
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



