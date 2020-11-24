Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA12C2F2D
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403979AbgKXRtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 12:49:02 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42414 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgKXRtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 12:49:02 -0500
Received: from 89-64-86-188.dynamic.chello.pl (89.64.86.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.520)
 id 93fb59caca3e8d53; Tue, 24 Nov 2020 18:48:59 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PM: Re-enable ACPI GPE if it's already enabled
Date:   Tue, 24 Nov 2020 18:48:58 +0100
Message-ID: <2176101.IjXNKL1iO1@kreacher>
In-Reply-To: <90E54BA3-FC3A-4538-ACD0-4C4DDF570C7C@canonical.com>
References: <20201124073619.771940-1-kai.heng.feng@canonical.com> <CAJZ5v0iJ_x5oXL9gG_TvCriNnPwzZYvGkkEK6_HWrH4fmCqBxQ@mail.gmail.com> <90E54BA3-FC3A-4538-ACD0-4C4DDF570C7C@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday, November 24, 2020 6:31:56 PM CET Kai-Heng Feng wrote:
> 
> > On Nov 24, 2020, at 22:00, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > 
> > On Tue, Nov 24, 2020 at 8:36 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >> 
> >> Dell Precision 5550 fails to detect Thunderbolt device hotplug events,
> >> once the Thunderbolt device and its root port are runtime-suspended to
> >> D3cold.
> >> 
> >> While putting the entire hierarchy to D3cold, the root port ACPI GPE is
> >> enabled via acpi_pci_propagate_wakeup() when suspending Thunderbolt
> >> bridges/switches. So when putting the root port to D3cold as last step,
> >> ACPI GPE is untouched as it's already enabled.
> >> 
> >> However, platform may need PCI devices to be in D3hot or PME enabled
> >> prior enabling GPE to make it work.
> > 
> > What platforms and why.
> 
> Dell Precision 5550. Its thunderbolt port can't detect newly plugged thunderbolt devices.

OK

> > 
> >> So re-enable ACPI GPE to address this.
> >> 
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/acpi/device_pm.c | 13 ++++++-------
> >> 1 file changed, 6 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> >> index 94d91c67aeae..dc25d9d204ae 100644
> >> --- a/drivers/acpi/device_pm.c
> >> +++ b/drivers/acpi/device_pm.c
> >> @@ -757,11 +757,10 @@ static int __acpi_device_wakeup_enable(struct acpi_device *adev,
> >> 
> >>        mutex_lock(&acpi_wakeup_lock);
> >> 
> >> -       if (wakeup->enable_count >= max_count)
> >> -               goto out;
> >> -
> >> -       if (wakeup->enable_count > 0)
> >> -               goto inc;
> >> +       if (wakeup->enable_count > 0) {
> >> +               acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
> >> +               acpi_disable_wakeup_device_power(adev);
> >> +       }
> > 
> > An event occurring at this point may be lost after this patch.
> 
> Yes, so this approach is not optimal.
> 
> > 
> > It looks like you are trying to work around a hardware issue.  
> 
> Windows doesn't have this issue. So I don't think it's hardware issue.

Windows may exercise the hardware in a different way.

> > Can you
> > please describe that issue in detail?
> 
> The GPE used by Thunderbolt root port, was previously enabled by Thunderbolt switches/bridges.

This shouldn't matter, because enabling a GPE means flipping its bit in the
"enable" register.  There's no dependency between that and the devices below
the port.

There may be dependency there for enabling the device wakeup power, however.

> So when the GPE is already enabled when Thunderbolt root port is suspended.
> However, the GPE needs to be enabled after root port is suspended, and that's the approach this patch takes.

No, it is not.

It still enables the GPE and the device wakeup power before putting the port
into D3.  Please see pci_finish_runtime_suspend() for details.

However, it enables wakeup for after putting the subordinate device(s) into D3hot
which may matter in theory.

> Is there any actual hardware benefits from acpi_pci_propagate_wakeup()?

Yes, there is AFAICS.

> If there's no actual device benefits from it, we can remove it and only enable GPE for the root port.
> Otherwise we need to quirk off Thunderbolt bridges/switches, since their native PME just work without the need to enable root port GPE.

Can you please check if the alternative (untested) patch below still helps?

---
 drivers/acpi/device_pm.c |   40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

Index: linux-pm/drivers/acpi/device_pm.c
===================================================================
--- linux-pm.orig/drivers/acpi/device_pm.c
+++ linux-pm/drivers/acpi/device_pm.c
@@ -749,7 +749,7 @@ static void acpi_pm_notify_work_func(str
 static DEFINE_MUTEX(acpi_wakeup_lock);
 
 static int __acpi_device_wakeup_enable(struct acpi_device *adev,
-				       u32 target_state, int max_count)
+				       u32 target_state)
 {
 	struct acpi_device_wakeup *wakeup = &adev->wakeup;
 	acpi_status status;
@@ -757,15 +757,26 @@ static int __acpi_device_wakeup_enable(s
 
 	mutex_lock(&acpi_wakeup_lock);
 
-	if (wakeup->enable_count >= max_count)
-		goto out;
-
+	/*
+	 * If the device wakeup power is already enabled, disable it and enable
+	 * it again in case it depends on the configuration of subordinate
+	 * devices and the conditions have changed since it was enabled last
+	 * time.
+	 */
 	if (wakeup->enable_count > 0)
-		goto inc;
+		acpi_disable_wakeup_device_power(adev);
 
 	error = acpi_enable_wakeup_device_power(adev, target_state);
-	if (error)
+	if (error) {
+		if (wakeup->enable_count > 0) {
+			acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
+			wakeup->enable_count = 0;
+		}
 		goto out;
+	}
+
+	if (wakeup->enable_count > 0)
+		goto inc;
 
 	status = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
 	if (ACPI_FAILURE(status)) {
@@ -778,7 +789,10 @@ static int __acpi_device_wakeup_enable(s
 			  (unsigned int)wakeup->gpe_number);
 
 inc:
-	wakeup->enable_count++;
+	if (wakeup->enable_count < INT_MAX)
+		wakeup->enable_count++;
+	else
+		acpi_handle_info(adev->handle, "Wakeup enable count out of bounds!\n");
 
 out:
 	mutex_unlock(&acpi_wakeup_lock);
@@ -799,7 +813,7 @@ out:
  */
 static int acpi_device_wakeup_enable(struct acpi_device *adev, u32 target_state)
 {
-	return __acpi_device_wakeup_enable(adev, target_state, 1);
+	return __acpi_device_wakeup_enable(adev, target_state);
 }
 
 /**
@@ -829,8 +843,7 @@ out:
 	mutex_unlock(&acpi_wakeup_lock);
 }
 
-static int __acpi_pm_set_device_wakeup(struct device *dev, bool enable,
-				       int max_count)
+static int __acpi_pm_set_device_wakeup(struct device *dev, bool enable)
 {
 	struct acpi_device *adev;
 	int error;
@@ -850,8 +863,7 @@ static int __acpi_pm_set_device_wakeup(s
 		return 0;
 	}
 
-	error = __acpi_device_wakeup_enable(adev, acpi_target_system_state(),
-					    max_count);
+	error = __acpi_device_wakeup_enable(adev, acpi_target_system_state());
 	if (!error)
 		dev_dbg(dev, "Wakeup enabled by ACPI\n");
 
@@ -865,7 +877,7 @@ static int __acpi_pm_set_device_wakeup(s
  */
 int acpi_pm_set_device_wakeup(struct device *dev, bool enable)
 {
-	return __acpi_pm_set_device_wakeup(dev, enable, 1);
+	return __acpi_pm_set_device_wakeup(dev, enable);
 }
 EXPORT_SYMBOL_GPL(acpi_pm_set_device_wakeup);
 
@@ -876,7 +888,7 @@ EXPORT_SYMBOL_GPL(acpi_pm_set_device_wak
  */
 int acpi_pm_set_bridge_wakeup(struct device *dev, bool enable)
 {
-	return __acpi_pm_set_device_wakeup(dev, enable, INT_MAX);
+	return __acpi_pm_set_device_wakeup(dev, enable);
 }
 EXPORT_SYMBOL_GPL(acpi_pm_set_bridge_wakeup);
 



