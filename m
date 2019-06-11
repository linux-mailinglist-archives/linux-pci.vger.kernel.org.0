Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C912416EE
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2019 23:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbfFKVej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jun 2019 17:34:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56100 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387764AbfFKVej (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2019 17:34:39 -0400
Received: from 79.184.253.190.ipv4.supernova.orange.pl (79.184.253.190) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id de0f10f62d208a7f; Tue, 11 Jun 2019 23:34:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] PCI: PM: Avoid possible suspend-to-idle issue
Date:   Tue, 11 Jun 2019 23:34:36 +0200
Message-ID: <1583084.Q78GrOSehU@kreacher>
In-Reply-To: <527F9B70-68AC-4CD4-A3C2-576EA09187DD@canonical.com>
References: <2315917.ZGeXE6pBFC@kreacher> <10983642.dUqMSvAAlD@kreacher> <527F9B70-68AC-4CD4-A3C2-576EA09187DD@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, June 11, 2019 10:39:44 AM CEST Kai-Heng Feng wrote:
> Hi Rafael,
> 
> at 19:02, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > On Friday, May 17, 2019 11:08:50 AM CEST Rafael J. Wysocki wrote:
> >> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>
> >> If a PCI driver leaves the device handled by it in D0 and calls
> >> pci_save_state() on the device in its ->suspend() or ->suspend_late()
> >> callback, it can expect the device to stay in D0 over the whole
> >> s2idle cycle.  However, that may not be the case if there is a
> >> spurious wakeup while the system is suspended, because in that case
> >> pci_pm_suspend_noirq() will run again after pci_pm_resume_noirq()
> >> which calls pci_restore_state(), via pci_pm_default_resume_early(),
> >> so state_saved is cleared and the second iteration of
> >> pci_pm_suspend_noirq() will invoke pci_prepare_to_sleep() which
> >> may change the power state of the device.
> >>
> >> To avoid that, add a new internal flag, skip_bus_pm, that will be set
> >> by pci_pm_suspend_noirq() when it runs for the first time during the
> >> given system suspend-resume cycle if the state of the device has
> >> been saved already and the device is still in D0.  Setting that flag
> >> will cause the next iterations of pci_pm_suspend_noirq() to set
> >> state_saved for pci_pm_resume_noirq(), so that it always restores the
> >> device state from the originally saved data, and avoid calling
> >> pci_prepare_to_sleep() for the device.
> >>
> >> Fixes: 33e4f80ee69b ("ACPI / PM: Ignore spurious SCI wakeups from  
> >> suspend-to-idle")
> >> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> I just found out this patch has a chance to freeze or reboot the system  
> during suspend cycles.
>
> What information do you need to debug?

A few things are missing from your report, like which kernel you have tested
and how exactly you have arrived at the conclusion that this particular commit
is the source of the problem.

Care to provide some details on the above?

Anyway, there are a couple of things that can be done to improve the code
on top of 5.2-rc4.  The appended patch is one of them, so can you please test
it and let me know if it makes any difference?

The rationale here is that firmware in some devices may be confused by attempts
to put the device into D0 if it already is in that power state, so it is better to avoid
doing so.

---
 drivers/pci/pci-driver.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -524,7 +524,6 @@ static void pci_pm_default_resume_early(
 	pci_power_up(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
-	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }
 
 /*
@@ -844,14 +843,12 @@ static int pci_pm_suspend_noirq(struct d
 		/*
 		 * The function is running for the second time in a row without
 		 * going through full resume, which is possible only during
-		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
-		 * device was originally left in D0, so its power state should
-		 * not be changed here and the device register values saved
-		 * originally should be restored on resume again.
+		 * suspend-to-idle in a spurious wakeup case.  The device should
+		 * be in D0 at this point.
 		 */
-		pci_dev->state_saved = true;
+		;
 	} else if (pci_dev->state_saved) {
-		if (pci_dev->current_state == PCI_D0)
+		if (pci_dev->current_state == PCI_D0 && !pm_suspend_via_firmware())
 			pci_dev->skip_bus_pm = true;
 	} else {
 		pci_save_state(pci_dev);
@@ -862,6 +859,9 @@ static int pci_pm_suspend_noirq(struct d
 	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
 		pci_power_name(pci_dev->current_state));
 
+	if (pci_dev->skip_bus_pm)
+		goto Fixup;
+
 	pci_pm_set_unknown_state(pci_dev);
 
 	/*
@@ -909,7 +909,10 @@ static int pci_pm_resume_noirq(struct de
 	if (dev_pm_smart_suspend_and_suspended(dev))
 		pm_runtime_set_active(dev);
 
-	pci_pm_default_resume_early(pci_dev);
+	if (!pci_dev->skip_bus_pm)
+		pci_pm_default_resume_early(pci_dev);
+
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
@@ -1200,6 +1203,7 @@ static int pci_pm_restore_noirq(struct d
 	}
 
 	pci_pm_default_resume_early(pci_dev);
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);



