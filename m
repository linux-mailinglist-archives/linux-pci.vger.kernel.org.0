Return-Path: <linux-pci+bounces-37609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A89FBBDF8F
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 14:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D37FC34B374
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 12:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C2527B505;
	Mon,  6 Oct 2025 12:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="R94u915o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7BA27A45C;
	Mon,  6 Oct 2025 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752609; cv=none; b=o2iixzONjevNGb4Sl7FNxWyydW5YO3l0iDbms4rrcVj4wK2bu+Z0Gnp3yRgML6yfgAhmAaGw1eFeLPL89w1auk1NBz2ZwxG2D9RmtIqX2rBa6LEasiGZRFxJYXiDeiVb2lFV/2EZ18TVOTCze/RzxA11t9RJIs9t+aCgLJrQgys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752609; c=relaxed/simple;
	bh=OMcjzqyHYFvX5Cr2mXN6248km4EoR9oE5IXrLXSuDck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hq1bPxmNGSEwbx+S+7wtU3qZZG4KBTnqP/2LnMp5GYQOw2OkapZw/akzfj3X1mhwvLVlb5UMUfOFXpUgctfle7K9vf/ozdUHnaK+BYQ/A3VY3q4ZMq6I7Q2HNDC6m7F1q0JSF6qkf3UbolZ2TgQelqdR73ftQXJsYl4h0dnC5Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=R94u915o; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1759752592; x=1760357392; i=spasswolf@web.de;
	bh=QL8VZtyw0/u7Oq0yLpGopt+0WuV9B2HS01+h5w8UVjM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=R94u915ovAfRv/qUBdXCjbbRrFNYSlNt9EzlYsj+lRuNQE5sjOmE5XDBZg7zTryg
	 GhWJ0Bqr/XSXYxOrXSPhJd1miES3jKFRrvk5Hz/rSg8da07h6iSBNq0okrSIvygvi
	 GoF0obiLijyZoXi+a3CK78iQkL2bOTr2OE5+gCHoBONZ65e332TwUsowNLJWTSFlv
	 b+2XZWKRR8Aad/TPklwH6SF+kMjRPpH/xJYZMTfAnfYde0ugmtDpEeNbh3BFb1uG6
	 5VSzOIktikcDwdUYIZw3PojjfbBzOVQVHfC4ZvAX836RDLLFvbHdSdRLXe7Oyg68K
	 R5EAyuRwv1b8dYNG4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([95.223.134.88]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MLijs-1uoDBX43ge-00J1t8; Mon, 06 Oct 2025 14:09:52 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org
Cc: Bert Karwatzki <spasswolf@web.de>,
	linux-next@vger.kernel.org,
	linux-stable@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [REGRESSION 03/04] Crash during resume of pcie bridge
Date: Mon,  6 Oct 2025 14:09:42 +0200
Message-ID: <20251006120944.7880-4-spasswolf@web.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251006120944.7880-1-spasswolf@web.de>
References: <20251006120944.7880-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m8dS2t/6d4noACAWJlbqVgv+fXwTk6g6gZPWiuU+qDT94px7sO/
 szlPXfCeeGBB3DrT4pAnzh/+mUpzIzOzmFchwMkXnvsJq79PjN/G/j2ZdKBYk97ElODnfYz
 JsS2KpVok4iOr4dXRPdzm/dT4y3EWsx/01oCqqihYWmmzkZ5Eh0aAHU0b8wTCCKjKbOHvN+
 u63N+GwdqI283JFFvBrOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1UyTuLUOY/A=;P2N4qUvBtWyFugn5wXDck97uqyu
 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
 tRNMg2DWu0XJfzkZiqiPaACAGOurPKEFBrerM9

In order to get a working crash I removed some of the monitoring again:

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index bc365c0dbe2f..a984ccd4a2a0 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -514,60 +514,46 @@ static void acpi_bus_notify(acpi_handle handle, u32 =
type, void *data)
=20
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_BUS_CHECK\n", __func__, __LINE__);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_BUS_CHECK event\n");
 		break;
=20
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_CHECK\n", __func__, __LINE_=
_);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_CHECK event\n");
 		break;
=20
 	case ACPI_NOTIFY_DEVICE_WAKE:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_WAKE\n", __func__, __LINE__=
);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_WAKE event\n");
 		return;
=20
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_EJECT_REQUEST\n", __func__, __LINE=
__);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_EJECT_REQUEST event\n");
 		break;
=20
 	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_CHECK_LIGHT\n", __func__, _=
_LINE__);
 		acpi_handle_debug(handle, "ACPI_NOTIFY_DEVICE_CHECK_LIGHT event\n");
 		/* TBD: Exactly what does 'light' mean? */
 		return;
=20
 	case ACPI_NOTIFY_FREQUENCY_MISMATCH:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_FREQUENCY_MISMATCH\n", __func__, _=
_LINE__);
 		acpi_handle_err(handle, "Device cannot be configured due "
 				"to a frequency mismatch\n");
 		return;
=20
 	case ACPI_NOTIFY_BUS_MODE_MISMATCH:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_BUS_MODE_MISMATCH\n", __func__, __=
LINE__);
 		acpi_handle_err(handle, "Device cannot be configured due "
 				"to a bus mode mismatch\n");
 		return;
=20
 	case ACPI_NOTIFY_POWER_FAULT:
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_POWER_FAULT\n", __func__, __LINE__=
);
 		acpi_handle_err(handle, "Device has suffered a power fault\n");
 		return;
=20
 	default:
-		printk(KERN_INFO "%s %d: acpi unknown event type\n", __func__, __LINE__=
);
 		acpi_handle_debug(handle, "Unknown event type 0x%x\n", type);
 		return;
 	}
=20
 	adev =3D acpi_get_acpi_dev(handle);
-	if (adev)
-		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
-	else
-		printk(KERN_INFO "%s %d: adev =3D NULL\n", __func__, __LINE__);
-	=09
=20
 	if (adev && ACPI_SUCCESS(acpi_hotplug_schedule(adev, type)))
 		return;
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 9a7dc432b50d..4e0583274b8f 100644
=2D-- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -539,7 +539,6 @@ static void acpi_pm_notify_handler(acpi_handle handle,=
 u32 val, void *not_used)
 	if (!adev)
 		return;
=20
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	mutex_lock(&acpi_pm_notifier_lock);
=20
 	if (adev->wakeup.flags.notifier_present) {
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 0f6a16856119..5ff343096ece 100644
=2D-- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1167,7 +1167,6 @@ void acpi_os_wait_events_complete(void)
 	 * Make sure the GPE handler or the fixed event handler is not used
 	 * on another CPU after removal.
 	 */
-	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	if (acpi_sci_irq_valid())
 		synchronize_hardirq(acpi_sci_irq);
 	flush_workqueue(kacpid_wq);
@@ -1185,7 +1184,6 @@ static void acpi_hotplug_work_fn(struct work_struct =
*work)
 {
 	struct acpi_hp_work *hpw =3D container_of(work, struct acpi_hp_work, wor=
k);
=20
-	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 	acpi_os_wait_events_complete();
 	acpi_device_hotplug(hpw->adev, hpw->src);
 	kfree(hpw);
@@ -1194,7 +1192,6 @@ static void acpi_hotplug_work_fn(struct work_struct =
*work)
 acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src)
 {
 	struct acpi_hp_work *hpw;
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	acpi_handle_debug(adev->handle,
 			  "Scheduling hotplug event %u for deferred handling\n",
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index d53be7e0388d..065abe56f440 100644
=2D-- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -251,7 +251,6 @@ static int acpi_scan_check_and_detach(struct acpi_devi=
ce *adev, void *p)
 {
 	struct acpi_scan_handler *handler =3D adev->handler;
 	uintptr_t flags =3D (uintptr_t)p;
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	acpi_dev_for_each_child_reverse(adev, acpi_scan_check_and_detach, p);
=20
@@ -315,7 +314,6 @@ static void acpi_scan_check_subtree(struct acpi_device=
 *adev)
 {
 	uintptr_t flags =3D ACPI_SCAN_CHECK_FLAG_STATUS;
=20
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	acpi_scan_check_and_detach(adev, (void *)flags);
 }
=20
@@ -371,7 +369,6 @@ static int acpi_scan_rescan_bus(struct acpi_device *ad=
ev)
 {
 	struct acpi_scan_handler *handler =3D adev->handler;
 	int ret;
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	if (handler && handler->hotplug.scan_dependent)
 		ret =3D handler->hotplug.scan_dependent(adev);
@@ -388,7 +385,6 @@ static int acpi_scan_device_check(struct acpi_device *=
adev)
 {
 	struct acpi_device *parent;
=20
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	acpi_scan_check_subtree(adev);
=20
 	if (!acpi_device_is_present(adev))
@@ -416,24 +412,19 @@ static int acpi_scan_device_check(struct acpi_device=
 *adev)
 static int acpi_scan_bus_check(struct acpi_device *adev)
 {
 	acpi_scan_check_subtree(adev);
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
=20
 	return acpi_scan_rescan_bus(adev);
 }
=20
 static int acpi_generic_hotplug_event(struct acpi_device *adev, u32 type)
 {
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
-		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 		return acpi_scan_bus_check(adev);
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 		return acpi_scan_device_check(adev);
 	case ACPI_NOTIFY_EJECT_REQUEST:
 	case ACPI_OST_EC_OSPM_EJECT:
-		dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 		if (adev->handler && !adev->handler->hotplug.enabled) {
 			dev_info(&adev->dev, "Eject disabled\n");
 			return -EPERM;
@@ -450,7 +441,6 @@ void acpi_device_hotplug(struct acpi_device *adev, u32=
 src)
 	u32 ost_code =3D ACPI_OST_SC_NON_SPECIFIC_FAILURE;
 	int error =3D -ENODEV;
=20
-	dev_info(&adev->dev, "%s %d\n", __func__, __LINE__);
 	lock_device_hotplug();
 	mutex_lock(&acpi_scan_lock);
=20
@@ -476,10 +466,9 @@ void acpi_device_hotplug(struct acpi_device *adev, u3=
2 src)
 		 * There may be additional notify handlers for device objects
 		 * without the .event() callback, so ignore them here.
 		 */
-		if (notify) {
-			dev_info(&adev->dev, "%s %d: calling notify =3D %px\n", __func__, __LI=
NE__, (void *) notify);
+		if (notify)
 			error =3D notify(adev, src);
-		} else
+		else
 			goto out;
 	}
 	switch (error) {
diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 895898c3cd56..27cce7f1b1d3 100644
=2D-- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -142,6 +142,8 @@ EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
  */
 static void pm_runtime_deactivate_timer(struct device *dev)
 {
+	if (!strcmp(dev_name(dev), "0000:00:01.1"))
+		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	if (dev->power.timer_expires > 0) {
 		hrtimer_try_to_cancel(&dev->power.suspend_timer);
 		dev->power.timer_expires =3D 0;
@@ -787,8 +789,6 @@ static int rpm_resume(struct device *dev, int rpmflags=
)
 	struct device *parent =3D NULL;
 	int retval =3D 0;
=20
-	if (!strcmp(dev_name(dev), "0000:00:01.1"))
-		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	trace_rpm_resume(dev, rpmflags);
=20
  repeat:
@@ -815,7 +815,7 @@ static int rpm_resume(struct device *dev, int rpmflags=
)
 	 * future.
 	 */
 	if (!strcmp(dev_name(dev), "0000:00:01.1"))
-		dev_info(dev, "%s %d\n", __func__, __LINE__);
+		dev_info(dev, "%s %d dev =3D %px\n", __func__, __LINE__, dev);
 	dev->power.request =3D RPM_REQ_NONE;
 	if (!dev->power.timer_autosuspends)
 		pm_runtime_deactivate_timer(dev);
@@ -1231,22 +1231,16 @@ int __pm_runtime_resume(struct device *dev, int rp=
mflags)
 {
 	unsigned long flags;
 	int retval;
-	if (!strcmp(dev_name(dev), "0000:00:01.1"))
-		dev_info(dev, "%s %d\n", __func__, __LINE__);
=20
 	might_sleep_if(!(rpmflags & RPM_ASYNC) && !dev->power.irq_safe &&
 			dev->power.runtime_status !=3D RPM_ACTIVE);
=20
-	if (!strcmp(dev_name(dev), "0000:00:01.1"))
-		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	if (rpmflags & RPM_GET_PUT)
 		atomic_inc(&dev->power.usage_count);
=20
-	if (!strcmp(dev_name(dev), "0000:00:01.1"))
-		dev_info(dev, "%s %d\n", __func__, __LINE__);
 	spin_lock_irqsave(&dev->power.lock, flags);
 	if (!strcmp(dev_name(dev), "0000:00:01.1"))
-		dev_info(dev, "%s %d\n", __func__, __LINE__);
+		dev_info(dev, "%s %d dev =3D %px\n", __func__, __LINE__, dev);
 	retval =3D rpm_resume(dev, rpmflags);
 	spin_unlock_irqrestore(&dev->power.lock, flags);
=20
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpi=
php_glue.c
index e56ab308da20..e21255b97251 100644
=2D-- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -484,7 +484,6 @@ static void enable_slot(struct acpiphp_slot *slot, boo=
l bridge)
 	struct pci_dev *dev;
 	struct pci_bus *bus =3D slot->bus;
 	struct acpiphp_func *func;
-	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
=20
 	if (bridge && bus->self && hotplug_is_native(bus->self)) {
 		/*
@@ -495,14 +494,11 @@ static void enable_slot(struct acpiphp_slot *slot, b=
ool bridge)
 		 * as a Thunderbolt host controller.
 		 */
 		for_each_pci_bridge(dev, bus) {
-			dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 			if (PCI_SLOT(dev->devfn) =3D=3D slot->device) {
-				dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 				acpiphp_native_scan_bridge(dev);
 			}
 		}
 	} else {
-		printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 		LIST_HEAD(add_list);
 		int max, pass;
=20
@@ -510,15 +506,12 @@ static void enable_slot(struct acpiphp_slot *slot, b=
ool bridge)
 		max =3D acpiphp_max_busnr(bus);
 		for (pass =3D 0; pass < 2; pass++) {
 			for_each_pci_bridge(dev, bus) {
-				dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 				if (PCI_SLOT(dev->devfn) !=3D slot->device) {
-					printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 					continue;
 				}
=20
 				max =3D pci_scan_bridge(bus, dev, max, pass);
 				if (pass && dev->subordinate) {
-					dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 					check_hotplug_bridge(slot, dev);
 					pcibios_resource_survey_bus(dev->subordinate);
 					__pci_bus_size_bridges(dev->subordinate,
@@ -535,7 +528,6 @@ static void enable_slot(struct acpiphp_slot *slot, boo=
l bridge)
=20
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Assume that newly added devices are powered on already. */
-		dev_info(&dev->dev, "%s %d\n", __func__, __LINE__);
 		if (!pci_dev_is_added(dev))
 			dev->current_state =3D PCI_D0;
 	}
@@ -554,7 +546,6 @@ static void enable_slot(struct acpiphp_slot *slot, boo=
l bridge)
 		}
 		pci_dev_put(dev);
 	}
-	printk(KERN_INFO "%s %d\n", __func__, __LINE__);
 }
=20
 /**
@@ -823,7 +814,6 @@ static void hotplug_event(u32 type, struct acpiphp_con=
text *context)
 	switch (type) {
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* bus re-enumerate */
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_BUS_CHECK\n", __func__, __LINE__);
 		acpi_handle_debug(handle, "Bus check in %s()\n", __func__);
 		if (bridge)
 			acpiphp_check_bridge(bridge);
@@ -834,7 +824,6 @@ static void hotplug_event(u32 type, struct acpiphp_con=
text *context)
=20
 	case ACPI_NOTIFY_DEVICE_CHECK:
 		/* device check */
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_DEVICE_CHECK\n", __func__, __LINE_=
_);
 		acpi_handle_debug(handle, "Device check in %s()\n", __func__);
 		if (bridge) {
 			acpiphp_check_bridge(bridge);
@@ -850,23 +839,19 @@ static void hotplug_event(u32 type, struct acpiphp_c=
ontext *context)
=20
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
-		printk(KERN_INFO "%s %d: ACPI_NOTIFY_EJECT_REQUEST\n", __func__, __LINE=
__);
 		acpi_handle_debug(handle, "Eject request in %s()\n", __func__);
 		acpiphp_disable_and_eject_slot(slot);
 		break;
 	}
=20
 	pci_unlock_rescan_remove();
-	printk(KERN_INFO "%s %d:\n", __func__, __LINE__);
 	if (bridge)
 		put_bridge(bridge);
-	printk(KERN_INFO "%s %d:\n", __func__, __LINE__);
 }
=20
 static int acpiphp_hotplug_notify(struct acpi_device *adev, u32 type)
 {
 	struct acpiphp_context *context;
-	dev_info(&adev->dev, "%s %d: %s =3D %px\n", __func__, __LINE__, __func__=
, (void *) acpiphp_hotplug_notify);
=20
 	context =3D acpiphp_grab_context(adev);
 	if (!context)
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 0888b0d5ec73..d88d6b6ccf5b 100644
=2D-- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -508,8 +508,6 @@ static inline int pm_runtime_get(struct device *dev)
  */
 static inline int pm_runtime_get_sync(struct device *dev)
 {
-	if (!strcmp(dev_name(dev), "0000:00:01.1"))
-		dev_info(dev, "%s\n", __func__);
 	return __pm_runtime_resume(dev, RPM_GET_PUT);
 }
=20
This is the message from 6.17.0-rc6-next-20250917-gpudebug-00028-gf99cf81b=
1da7 crashing,
captured via netconsole:

2025-10-06T04:52:35.932429+02:00 [T248]evmisc-0132 ev_queue_notify_reques:=
 Dispatching Notify on [GPP0] (Device) Value 0x00 (Bus Check) Node 0000000=
069c9623b
2025-10-06T04:52:35.932429+02:00 [T177395]pcieport 0000:00:01.1: acpiphp_c=
heck_bridge 708#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
2025-10-06T04:52:35.932429+02:00 [T177395]pcieport 0000:00:01.1: __pm_runt=
ime_resume 1243 dev =3D ffff97c001c930c8#012 SUBSYSTEM=3Dpci#012 DEVICE=3D=
+pci:0000:00:01.1
2025-10-06T04:52:35.932429+02:00 [177395]pcieport 0000:00:01.1: rpm_resume=
 818 dev =3D ffff97c001c930c8#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:0=
0:01.1
2025-10-06T04:52:35.932429+02:00 [177395]pcieport 0000:00:01.1: pm_runtime=
_deactivate_timer 146#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
2025-10-06T04:52:35.932429+02:00 [177395]pcieport 0000:00:01.1: rpm_resume=
 930#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
2025-10-06T04:52:35.932429+02:00 [177395]pcieport 0000:00:01.1: rpm_resume=
 959#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
2025-10-06T04:52:35.932429+02:00 [177395]pcieport 0000:00:01.1: rpm_resume=
 818 dev =3D ffff97c001c930c8#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:0=
0:01.1
2025-10-06T04:52:35.932429+02:00 [177395]pcieport 0000:00:01.1: pm_runtime=
_deactivate_timer 146#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1
2025-10-06T04:52:35.932429+02:00 [177395]pcieport 0000:00:01.1: rpm_resume=
 965#012 SUBSYSTEM=3Dpci#012 DEVICE=3D+pci:0000:00:01.1

So the crash seems to happen in this part of rpm_resume():

[...]
 skip_parent:

	if (!strcmp(dev_name(dev), "0000:00:01.1"))
		dev_info(dev, "%s %d\n", __func__, __LINE__); // this is the last report=
ed line
	if (dev->power.no_callbacks)
		goto no_callback;	/* Assume success. */

	__update_runtime_status(dev, RPM_RESUMING);

	callback =3D RPM_GET_CALLBACK(dev, runtime_resume);

	dev_pm_disable_wake_irq_check(dev, false);
	retval =3D rpm_callback(callback, dev);
	if (retval) {
		if (!strcmp(dev_name(dev), "0000:00:01.1"))
			dev_info(dev, "%s %d\n", __func__, __LINE__);
		__update_runtime_status(dev, RPM_SUSPENDED);
		pm_runtime_cancel_pending(dev);
		dev_pm_enable_wake_irq_check(dev, false);
	} else {
 no_callback:
		if (!strcmp(dev_name(dev), "0000:00:01.1"))
			dev_info(dev, "%s %d\n", __func__, __LINE__);
[...]

Bert Karwatzki

