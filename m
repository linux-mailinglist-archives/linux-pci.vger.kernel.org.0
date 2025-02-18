Return-Path: <linux-pci+bounces-21759-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E55A3A891
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 21:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B9237A3C9D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAC61C5D6E;
	Tue, 18 Feb 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="DPriTzos"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8A1B87EB;
	Tue, 18 Feb 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910064; cv=none; b=DIbrHWJb7kP4UJzt+uukzfiy9SO9w7hraSQhtDJ73PCckGXeTx8Nq0YdPTUHyBYzLNqV+pUfAM7hyXPs6OGmLZc9r4IlbUBR4JrURt+X8gSkQAqPXl8qEWww8/chaggc2lc3g081Mp28rpvYVlvgtX2/Q8G4jFArFqbTme49P70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910064; c=relaxed/simple;
	bh=UWFsr3S0ZAgFS9MM5N1gmI7f6CQaZdj255B5JhS38vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/ZSlCxYOV1gsN7q29lKa1IMZzYxUYUokbAvmPXLO/OCjblSQ1Hd/KsqmU/nJyoutaSNSLRiHVfe8lwgfcwcOrRyi60BLYKqS2ZVmmL4rvrKObjEM37SNKfya9Z//OUk2N4UejyB10cc+bBHQwmIDVe63YlIqt23n3SjzB4EXc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=DPriTzos; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 94f45c07a1466cf7; Tue, 18 Feb 2025 21:20:53 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8243996554D;
	Tue, 18 Feb 2025 21:20:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739910053;
	bh=UWFsr3S0ZAgFS9MM5N1gmI7f6CQaZdj255B5JhS38vA=;
	h=From:Subject:Date;
	b=DPriTzosChgGQHpRb1su/rfJv5R61RicnUG8ClheZYbArXGTpjFeT8ywm+IVaFnRj
	 I2p/ErygndMJU9uaTMOiZcCfUrLVl9hCfm5DUG1btOOjeHyCSrX3wneDCfyvF77Got
	 gzarq64qOawW9tUrgedIseETMdCirsM6UcnJkqvWAHfTwtDVS9eRTp1xqvhj2XJRgt
	 imToXamddZfpulfOOBXcW1PTje3B92yy3fQehWea2IO0MTJQUPr39FAQq+Gi7u1/HV
	 spp8BQVUrobjF/mOPZK7vmFxnMd7KDeaLz8aOvY8zfKLl1x/A9yGe3xBmANVLDzctF
	 QT2hj3igMOLUQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/4] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
Date: Tue, 18 Feb 2025 21:16:48 +0100
Message-ID: <1914558.tdWV9SEqCh@rjwysocki.net>
In-Reply-To: <12612706.O9o76ZdvQC@rjwysocki.net>
References: <12612706.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhi
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

A recent discussion has revealed that using DPM_FLAG_SMART_SUSPEND
unconditionally is generally problematic because it may lead to
situations in which the device's runtime PM information is internally
inconsistent or does not reflect its real state [1].

For this reason, change the handling of DPM_FLAG_SMART_SUSPEND so that
it is only taken into account if it is consistently set by the drivers
of all devices having any PM callbacks throughout dependency graphs in
accordance with the following rules:

 - The "smart suspend" feature is only enabled for devices whose drivers
   ask for it (that is, set DPM_FLAG_SMART_SUSPEND) and for devices
   without PM callbacks unless they have never had runtime PM enabled.

 - The "smart suspend" feature is not enabled for a device if it has not
   been enabled for the device's parent unless the parent does not take
   children into account or it has never had runtime PM enabled.

 - The "smart suspend" feature is not enabled for a device if it has not
   been enabled for one of the device's suppliers taking runtime PM into
   account unless that supplier has never had runtime PM enabled.

Namely, introduce a new device PM flag called smart_suspend that is only
set if the above conditions are met and update all DPM_FLAG_SMART_SUSPEND
users to check power.smart_suspend instead of directly checking the
latter.

At the same time, drop the power.set_active flage introduced recently
in commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status
of parents and children") because it is now sufficient to check
power.smart_suspend along with the dev_pm_skip_resume() return value
to decide whether or not pm_runtime_set_active() needs to be called
for the device.

Link: https://lore.kernel.org/linux-pm/CAPDyKFroyU3YDSfw_Y6k3giVfajg3NQGwNWeteJWqpW29BojhQ@mail.gmail.com/  [1]
Fixes: 7585946243d6 ("PM: sleep: core: Restrict power.set_active propagation")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

v1 -> v2:
   * Add helper function for reading power.smart_suspend() (Ulf), add the R-by.
   * Rearrange conditionals in device_prepare_smart_suspend() so that the checks
     involving locking are done last.

---
 drivers/acpi/device_pm.c  |    4 +-
 drivers/base/power/main.c |   63 +++++++++++++++++++++++++++++++++++-----------
 drivers/mfd/intel-lpss.c  |    2 -
 drivers/pci/pci-driver.c  |    6 +---
 include/linux/device.h    |    5 +++
 include/linux/pm.h        |    2 -
 6 files changed, 60 insertions(+), 22 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1161,7 +1161,7 @@
  */
 int acpi_subsys_suspend(struct device *dev)
 {
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
+	if (!dev_pm_smart_suspend(dev) ||
 	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
 		pm_runtime_resume(dev);
 
@@ -1320,7 +1320,7 @@
  */
 int acpi_subsys_poweroff(struct device *dev)
 {
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
+	if (!dev_pm_smart_suspend(dev) ||
 	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
 		pm_runtime_resume(dev);
 
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -656,15 +656,13 @@
 	 * so change its status accordingly.
 	 *
 	 * Otherwise, the device is going to be resumed, so set its PM-runtime
-	 * status to "active" unless its power.set_active flag is clear, in
+	 * status to "active" unless its power.smart_suspend flag is clear, in
 	 * which case it is not necessary to update its PM-runtime status.
 	 */
-	if (skip_resume) {
+	if (skip_resume)
 		pm_runtime_set_suspended(dev);
-	} else if (dev->power.set_active) {
+	else if (dev_pm_smart_suspend(dev))
 		pm_runtime_set_active(dev);
-		dev->power.set_active = false;
-	}
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1282,14 +1280,8 @@
 	      dev->power.may_skip_resume))
 		dev->power.must_resume = true;
 
-	if (dev->power.must_resume) {
-		if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
-			dev->power.set_active = true;
-			if (dev->parent && !dev->parent->power.ignore_children)
-				dev->parent->power.set_active = true;
-		}
+	if (dev->power.must_resume)
 		dpm_superior_set_must_resume(dev);
-	}
 
 Complete:
 	complete_all(&dev->power.completion);
@@ -1797,6 +1789,49 @@
 	return error;
 }
 
+static void device_prepare_smart_suspend(struct device *dev)
+{
+	struct device_link *link;
+	int idx;
+
+	/*
+	 * The "smart suspend" feature is enabled for devices whose drivers ask
+	 * for it and for devices without PM callbacks unless runtime PM is
+	 * disabled and enabling it is blocked for them.
+	 *
+	 * However, if "smart suspend" is not enabled for the device's parent
+	 * or any of its suppliers that take runtime PM into account, it cannot
+	 * be enabled for the device either.
+	 */
+	dev->power.smart_suspend = (dev->power.no_pm_callbacks ||
+		dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) &&
+		!pm_runtime_blocked(dev);
+
+	if (!dev_pm_smart_suspend(dev))
+		return;
+
+	if (dev->parent && !dev_pm_smart_suspend(dev->parent) &&
+	    !dev->parent->power.ignore_children && !pm_runtime_blocked(dev->parent)) {
+		dev->power.smart_suspend = false;
+		return;
+	}
+
+	idx = device_links_read_lock();
+
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
+		if (!(link->flags | DL_FLAG_PM_RUNTIME))
+			continue;
+
+		if (!dev_pm_smart_suspend(link->supplier) &&
+		    !pm_runtime_blocked(link->supplier)) {
+			dev->power.smart_suspend = false;
+			break;
+		}
+	}
+
+	device_links_read_unlock(idx);
+}
+
 /**
  * device_prepare - Prepare a device for system power transition.
  * @dev: Device to handle.
@@ -1858,6 +1893,7 @@
 		pm_runtime_put(dev);
 		return ret;
 	}
+	device_prepare_smart_suspend(dev);
 	/*
 	 * A positive return value from ->prepare() means "this device appears
 	 * to be runtime-suspended and its state is fine, so if it really is
@@ -2033,6 +2069,5 @@
 
 bool dev_pm_skip_suspend(struct device *dev)
 {
-	return dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) &&
-		pm_runtime_status_suspended(dev);
+	return dev_pm_smart_suspend(dev) && pm_runtime_status_suspended(dev);
 }
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -480,7 +480,7 @@
 
 static int resume_lpss_device(struct device *dev, void *data)
 {
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+	if (!dev_pm_smart_suspend(dev))
 		pm_runtime_resume(dev);
 
 	return 0;
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -812,8 +812,7 @@
 	 * suspend callbacks can cope with runtime-suspended devices, it is
 	 * better to resume the device from runtime suspend here.
 	 */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    pci_dev_need_resume(pci_dev)) {
+	if (!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) {
 		pm_runtime_resume(dev);
 		pci_dev->state_saved = false;
 	} else {
@@ -1151,8 +1150,7 @@
 	}
 
 	/* The reason to do that is the same as in pci_pm_suspend(). */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    pci_dev_need_resume(pci_dev)) {
+	if (!dev_pm_smart_suspend(dev) || pci_dev_need_resume(pci_dev)) {
 		pm_runtime_resume(dev);
 		pci_dev->state_saved = false;
 	} else {
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1025,6 +1025,11 @@
 	return !!(dev->power.driver_flags & flags);
 }
 
+static inline bool dev_pm_smart_suspend(struct device *dev)
+{
+	return dev->power.smart_suspend;
+}
+
 static inline void device_lock(struct device *dev)
 {
 	mutex_lock(&dev->mutex);
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -680,8 +680,8 @@
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 	bool			async_in_progress:1;	/* Owned by the PM core */
+	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
-	bool			set_active:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
 #else
 	bool			should_wakeup:1;




