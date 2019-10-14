Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DF0D6096
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 12:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731728AbfJNKvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 06:51:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48649 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731449AbfJNKve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Oct 2019 06:51:34 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 9c378dd1878789af; Mon, 14 Oct 2019 12:51:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: PM: Consolidate runtime resume and system resume paths
Date:   Mon, 14 Oct 2019 12:51:31 +0200
Message-ID: <3118349.722IRLjr4b@kreacher>
In-Reply-To: <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
References: <20190927090202.1468-1-drake@endlessm.com> <4883845.KNzyzeMIEj@kreacher> <CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

There is an arbitrary difference between the system resume and
runtime resume code paths for PCI devices regarding the delay to
apply when switching the devices from D3cold to D0.

Namely, pci_restore_standard_config() used in the runtime resume
code path calls pci_set_power_state() which in turn invokes
__pci_start_power_transition() to power up the device through the
platform firmware and that function applies the transition delay
(as per PCI Express Base Specification Revision 2.0, Section 6.6.1).
However, pci_pm_default_resume_early() used in the system resume
code path calls pci_power_up() which doesn't apply the delay at
all and that causes issues to occur during resume from
suspend-to-idle on some systems where the delay is required.

Since there is no reason for that difference to exist, modify
pci_pm_default_resume_early() to invoke pci_restore_standard_config()
instead of pci_power_up() and drop the latter, but in order to
prevent the ACPI power state values (cached by the ACPI layer) from
becoming stale in some cases during resume from suspend-to-RAM
(ACPI S3), as per commit cc2893b6af52 ("PCI: Ensure we re-enable
devices on resume"), refresh the ACPI power state information in
pci_pm_default_resume_early() in that case.

[Note that while this change should take the issue originally
 addressed by commit cc2893b6af52 ("PCI: Ensure we re-enable devices
 on resume") into account in a generally safer way, an alternative
 would be to make pci_power_up() use __pci_start_power_transition()
 instead of calling platform_pci_set_power_state() directly.]

Fixes: db288c9c5f9d ("PCI / PM: restore the original behavior of pci_set_power_state()")
Reported-by: Daniel Drake <drake@endlessm.com> 
Tested-by: Daniel Drake <drake@endlessm.com> 
Link: https://lore.kernel.org/linux-pm/CAD8Lp44TYxrMgPLkHCqF9hv6smEurMXvmmvmtyFhZ6Q4SE+dig@mail.gmail.com/T/#m21be74af263c6a34f36e0fc5c77c5449d9406925
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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



