Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D551EF4
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 01:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfFXXJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Jun 2019 19:09:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58549 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbfFXXJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Jun 2019 19:09:41 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id d4c091cf0ca37d7c; Tue, 25 Jun 2019 01:09:37 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
Date:   Tue, 25 Jun 2019 01:09:36 +0200
Message-ID: <2287147.DxjcvLeq6l@kreacher>
In-Reply-To: <CAJZ5v0gGdXmgc_9r2rbiadq4e31hngpjYQ40QoC6C0z19da_hQ@mail.gmail.com>
References: <1668247.RaJIPSxJUN@kreacher> <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com> <CAJZ5v0gGdXmgc_9r2rbiadq4e31hngpjYQ40QoC6C0z19da_hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, June 25, 2019 12:20:26 AM CEST Rafael J. Wysocki wrote:
> On Mon, Jun 24, 2019 at 11:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Mon, Jun 24, 2019 at 2:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On 13/06/2019 22:59, Rafael J. Wysocki wrote:
> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > > > attempted to avoid a problem with devices whose drivers want them to
> > > > stay in D0 over suspend-to-idle and resume, but it did not go as far
> > > > as it should with that.
> > > >
> > > > Namely, first of all, the power state of a PCI bridge with a
> > > > downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
> > > > sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
> > > > transactions on its secondary bus), but that is not actively enforced
> > > > during system-wide PM transitions, so use the skip_bus_pm flag
> > > > introduced by commit d491f2b75237 for that.
> > > >
> > > > Second, the configuration of devices left in D0 (whatever the reason)
> > > > during suspend-to-idle need not be changed and attempting to put them
> > > > into D0 again by force is pointless, so explicitly avoid doing that.
> > > >
> > > > Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
> > > > Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > >
> > > I have noticed a regression in both the mainline and -next branches on
> > > one of our boards when testing suspend. The bisect is point to this
> > > commit and reverting on top of mainline does fix the problem. So far I
> > > have not looked at this in close detail but kernel log is showing ...
> >
> > Can you please collect a log like that, but with dynamic debug in
> > pci-driver.c enabled?
> >
> > Note that reverting this commit is rather out of the question, so we
> > need to get to the bottom of the failure.
> 
> I suspect that there is a problem with the pm_suspend_via_firmware()
> check which returns 'false' on the affected board, but the platform
> actually removes power from devices left in D0 during suspend.
> 
> I guess it would be more appropriate to check something like
> pm_suspend_no_platform() which would return 'true' in the
> suspend-to-idle patch w/ ACPI.

So I wonder if the patch below makes any difference?

---
 drivers/pci/pci-driver.c |    8 ++++----
 include/linux/suspend.h  |   26 ++++++++++++++++++++++++--
 kernel/power/suspend.c   |    3 +++
 3 files changed, 31 insertions(+), 6 deletions(-)

Index: linux-pm/include/linux/suspend.h
===================================================================
--- linux-pm.orig/include/linux/suspend.h
+++ linux-pm/include/linux/suspend.h
@@ -209,8 +209,9 @@ extern int suspend_valid_only_mem(suspen
 
 extern unsigned int pm_suspend_global_flags;
 
-#define PM_SUSPEND_FLAG_FW_SUSPEND	(1 << 0)
-#define PM_SUSPEND_FLAG_FW_RESUME	(1 << 1)
+#define PM_SUSPEND_FLAG_FW_SUSPEND	BIT(0)
+#define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
+#define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
 
 static inline void pm_suspend_clear_flags(void)
 {
@@ -227,6 +228,11 @@ static inline void pm_set_resume_via_fir
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
 }
 
+static inline void pm_set_suspend_no_platform(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
+}
+
 /**
  * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
  *
@@ -268,6 +274,22 @@ static inline bool pm_resume_via_firmwar
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_RESUME);
 }
 
+/**
+ * pm_suspend_no_platform - Check if platform may change device power states.
+ *
+ * To be called during system-wide power management transitions to sleep states
+ * or during the subsequent system-wide transitions back to the working state.
+ *
+ * Return 'true' if the power states of devices remain under full control of the
+ * kernel throughout the system-wide suspend and resume cycle in progress (that
+ * is, if a device is put into a certain power state during suspend, it can be
+ * expected to remain in that state during resume).
+ */
+static inline bool pm_suspend_no_platform(void)
+{
+	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
+}
+
 /* Suspend-to-idle state machnine. */
 enum s2idle_states {
 	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
Index: linux-pm/kernel/power/suspend.c
===================================================================
--- linux-pm.orig/kernel/power/suspend.c
+++ linux-pm/kernel/power/suspend.c
@@ -493,6 +493,9 @@ int suspend_devices_and_enter(suspend_st
 
 	pm_suspend_target_state = state;
 
+	if (state == PM_SUSPEND_TO_IDLE)
+		pm_set_suspend_no_platform();
+
 	error = platform_suspend_begin(state);
 	if (error)
 		goto Close;
Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -870,7 +870,7 @@ static int pci_pm_suspend_noirq(struct d
 			pci_dev->bus->self->skip_bus_pm = true;
 	}
 
-	if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
+	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
 		dev_dbg(dev, "PCI PM: Skipped\n");
 		goto Fixup;
 	}
@@ -925,10 +925,10 @@ static int pci_pm_resume_noirq(struct de
 	/*
 	 * In the suspend-to-idle case, devices left in D0 during suspend will
 	 * stay in D0, so it is not necessary to restore or update their
-	 * configuration here and attempting to put them into D0 again may
-	 * confuse some firmware, so avoid doing that.
+	 * configuration here and attempting to put them into D0 again is
+	 * pointless, so avoid doing that.
 	 */
-	if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
+	if (!(pci_dev->skip_bus_pm && pm_suspend_no_platform()))
 		pci_pm_default_resume_early(pci_dev);
 
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);



