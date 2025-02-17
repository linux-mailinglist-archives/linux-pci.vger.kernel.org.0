Return-Path: <linux-pci+bounces-21671-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFD6A38D1D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 21:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CD01889ACC
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E45234970;
	Mon, 17 Feb 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UgZAcIse"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB45149C41;
	Mon, 17 Feb 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823603; cv=none; b=OlH5I9R5T0jVEEViT6CEW+5Jufz31wnctjoMM6WO+bMGTNoWpvPPRRkxQq6dZMrx4HK3s187DT3sRrDtFZFSsSiTdFMjnOOMA6RmgxXnrqUPt5TdIQ6wqv3vZteKQVJjdufzZ3KVGOMY8Rkj85gbPML+GO6r+HLO4eufdw/vvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823603; c=relaxed/simple;
	bh=/YPL+Qdj5nQduva774o+9werrMjy/VnTRhIWBdp51IY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jW15XPLRUIctmAMhgvePBrj/Ra6oPUJSEAwayXmjdy6K61zG2ZsXn4Vh5N+PbuYAruToCjpQdgcCJBb716nn5sC0mWpdMJi66qdapR1dSKhdXP6VIrFMQdatyXzye//gx2ENqKJK6FFT637jITOLP5cNbXnXctTcAxS3mbySf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UgZAcIse; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 2349e9a2f8523f5c; Mon, 17 Feb 2025 21:19:58 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id DD39E9100B0;
	Mon, 17 Feb 2025 21:19:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739823598;
	bh=/YPL+Qdj5nQduva774o+9werrMjy/VnTRhIWBdp51IY=;
	h=From:Subject:Date;
	b=UgZAcIseRHmcvWA9lqNRWIUhtqmltkrpQElTb7JwiseKC00S1azy4uLecGc22JKbb
	 T3i8v00K70VF9jCHNFfPE+zftOV9O9ArCJQEsVbz0TBVtugH3ehpF/nrGXZB+WcVv0
	 L75iqbrb2HIoJZD2ICtjivFnSAxdtpnb1veCpgfvHAhMH4x3iRZXrZeA0q0+3Sof6V
	 /ojoIPzvpZ6yG/ZmNYMLcjl81W/viR8RJkjdZGQjOe+NYMksH9uBpwMfNA1xv0vf/x
	 mnyH0KFdAUXQVZi1HRnJs9LjnyyhXrs+xpSZwWMFw+yB0GNNQKZFt3OkCSOoK6gx8C
	 AiceuAiIL91mg==
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
Subject: [PATCH v1 3/3] PM: sleep: Use DPM_FLAG_SMART_SUSPEND conditionally
Date: Mon, 17 Feb 2025 21:19:41 +0100
Message-ID: <2000822.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <4966939.GXAFRqVoOG@rjwysocki.net>
References: <4966939.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehleefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddvpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhi
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
---
 drivers/acpi/device_pm.c  |    6 +---
 drivers/base/power/main.c |   63 +++++++++++++++++++++++++++++++++++-----------
 drivers/mfd/intel-lpss.c  |    2 -
 drivers/pci/pci-driver.c  |    6 +---
 include/linux/pm.h        |    2 -
 5 files changed, 55 insertions(+), 24 deletions(-)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1161,8 +1161,7 @@
  */
 int acpi_subsys_suspend(struct device *dev)
 {
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
+	if (!dev->power.smart_suspend || acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
 		pm_runtime_resume(dev);
 
 	return pm_generic_suspend(dev);
@@ -1320,8 +1319,7 @@
  */
 int acpi_subsys_poweroff(struct device *dev)
 {
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
+	if (!dev->power.smart_suspend || acpi_dev_needs_resume(dev, ACPI_COMPANION(dev)))
 		pm_runtime_resume(dev);
 
 	return pm_generic_poweroff(dev);
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
+	else if (dev->power.smart_suspend)
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
+	if (!dev->power.smart_suspend)
+		return;
+
+	if (dev->parent && !pm_runtime_blocked(dev->parent) &&
+	    !dev->parent->power.ignore_children && !dev->parent->power.smart_suspend) {
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
+		if (!pm_runtime_blocked(link->supplier) &&
+		    !link->supplier->power.smart_suspend) {
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
+	return dev->power.smart_suspend && pm_runtime_status_suspended(dev);
 }
--- a/drivers/mfd/intel-lpss.c
+++ b/drivers/mfd/intel-lpss.c
@@ -480,7 +480,7 @@
 
 static int resume_lpss_device(struct device *dev, void *data)
 {
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND))
+	if (!dev->power.smart_suspend)
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
+	if (!dev->power.smart_suspend || pci_dev_need_resume(pci_dev)) {
 		pm_runtime_resume(dev);
 		pci_dev->state_saved = false;
 	} else {
@@ -1151,8 +1150,7 @@
 	}
 
 	/* The reason to do that is the same as in pci_pm_suspend(). */
-	if (!dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND) ||
-	    pci_dev_need_resume(pci_dev)) {
+	if (!dev->power.smart_suspend || pci_dev_need_resume(pci_dev)) {
 		pm_runtime_resume(dev);
 		pci_dev->state_saved = false;
 	} else {
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




