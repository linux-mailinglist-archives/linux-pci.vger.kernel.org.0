Return-Path: <linux-pci+bounces-30959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D1AEBFD3
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 813B6565BF5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A2B2EBBA2;
	Fri, 27 Jun 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="QIlaSYzt"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530D12E8E0D;
	Fri, 27 Jun 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052587; cv=none; b=MAf3f8P8jtLlC8BqnlbiIK8YZqIx528pF3MVb3BFe8tMk44/W12CGTQIrrBq48+Iy8z1m8P/ZFtBKlyscP3n6M44WBgjgE2CZlDVWmkxleyE+qzcJk2qjopJBbPn1iFX9EMwWWmY6O6rh6wVe8A7e0QLRp4EitWgq6Ul1lLwAOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052587; c=relaxed/simple;
	bh=a2L73IVnYApL3PZy8r0onUfV0iQqjgiEAGOn3ixCw9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2iN4sdFXRy5lJIiB4+OrAiUlFbw9hop16CMkvAWSd5IRRAyMU47wVVNpHdkADKeyq62hF7tLctZW25DlfLMfpjd21TUyX7qb8s5ZcYn05JjKlJWeD1DEsm8urC1dxH6M84CG0pSZ6CFYhzjUmXaw9/p+ahJ9YC9hsSwKE9MmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=QIlaSYzt; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E904566DE54;
	Fri, 27 Jun 2025 21:29:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052576;
	bh=a2L73IVnYApL3PZy8r0onUfV0iQqjgiEAGOn3ixCw9g=;
	h=From:Subject:Date;
	b=QIlaSYztmcXGzRz1G9aBnRT8nV/D2Rd1vW7pHl4djBkga7K5AehYXCXG3BMCsgD0i
	 ymQkshdz1JqMlUF193rkBDsmfuV279fWHVqgwwDY7gPMa65T+MVINNvN51Mv7iJEyv
	 hnV5OLa/+q1UcoMDvZdi+H6126ahsczlKpdjwkuM0by/5t8IdFoM6lBV+oO5CscNaC
	 8QCvoD/FKcmy66B+wqH3bmsrmZJd1g4APqsyr2zBJ9KGhvoGYRUmncVQMfzx80ezPg
	 JnX2yeCBrgTtxFLg1x/+sFJrFNNKI1KUrGcvRbi5hfHvm8Po6LJZk55XFYD8hxTag6
	 EzJtUco2KWBrQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v3 7/9] PM: sleep: Add strict_midlayer flag to struct dev_pm_info
Date: Fri, 27 Jun 2025 21:23:42 +0200
Message-ID: <24017035.6Emhk5qWAg@rjwysocki.net>
In-Reply-To: <5018768.GXAFRqVoOG@rjwysocki.net>
References: <5018768.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTGrSjjgwBeoPV1BTemn5ImVCZpPTZb07vPRCPpCLNITJNQNwAJrBW+NvQ9gHfopUGw7eKCZUx2JvTkH7ndztXO95C/5NZYx0U0uzSGwSElzY3a0yFW5y/ST6sLyUL+pkZNb6zBf5QQDeWSHMTwFL5SzhnW4lYOV2aXUoJnPKm0KcXRLQpgIKgvtcuh9kc8szEcWaDKkWT6ZvZMLezK4NKUrQ0LRPHVUG/J8XldG2aWmsAAgiz8DIA4tSCjGi3syq1aAO8pJ5+EOuYaRvLcxgtvWWEpF/MWy84RxjOnkuHVdyEMV6Ug0G9LNrdrQ+TwE0ATvvO2S6WiA1+7Yw5g2H305hobAL8FSJDxMfEWWRBWjiEx+AxTY/1jy9QvpQSCjCN7bFW6ite67jRSc+0gg4zn+E0CTtw/+d+72HDvJbBOcCq5R6JkaZaFtE36LVj4SdfbMjERgAMspgSO5WGZcv8/E63fgot3pidAjTLt0UDaeYOqmeSU+/Zcy9Qxj2tO8Hqag7m1i4jvh7w6zT4HZDwLLxrvBkFMwTVRUawLfu3magXCXqsCuDtQPWxSi1BW62l2pUviEkSG3Sry9HXt32X6BJWl9CXIAttcLiyP7ll6GeidKhjgher1fw3Cm7nn1YKLOssCEEpv5DCUTolaZBj92uXBq5iswkugW3vYe1UawMg
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new flag, called strict_midlayer, to struct dev_pm_info, along
with helper functions for updating and reading its value, to allow
middle layer code that provides proper callbacks for device suspend-
resume during system-wide PM transitions to let pm_runtime_force_suspend()
and and pm_runtime_force_resume() know that they should only invoke
runtime PM callbacks coming from the device's driver.

Namely, if this flag is set, pm_runtime_force_suspend() and
and pm_runtime_force_resume() will invoke runtime PM callbacks
provided by the device's driver directly with the assumption that
they have been called via a middle layer callback for device suspend
or resume, respectively.

For instance, acpi_general_pm_domain provides specific
callback functions for system suspend, acpi_subsys_suspend(),
acpi_subsys_suspend_late() and acpi_subsys_suspend_noirq(), and
it does not expect its runtime suspend callback function,
acpi_subsys_runtime_suspend(), to be invoked at any point during
system suspend. In particular, it does not expect that function
to be called from within any of the system suspend callback functions
mentioned above which would happen if a device driver collaborating
with acpi_general_pm_domain used pm_runtime_force_suspend() as its
callback function for any system suspend phase later than "prepare".

The new flag allows this expectation of acpi_general_pm_domain to
be formally expressed, which is going to be done subsequently.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Add a kerneldoc comment for dev_pm_set_strict_midlayer() (Bjorn).
   * Update changelog (minor tweaks).

v1 -> v2:
   * Rename dev_pm_strict_midlayer() to dev_pm_set_strict_midlayer().
   * Add dev_pm_strict_midlayer_is_set() and use it in get_callback()
     because pm_runtime_force_suspend() can be used in driver remove
     callbacks and so it needs to work with CONFIG_PM_SLEEP unset.

---
 drivers/base/power/runtime.c |   21 +++++++++++++++++++--
 include/linux/device.h       |   27 +++++++++++++++++++++++++++
 include/linux/pm.h           |    1 +
 3 files changed, 47 insertions(+), 2 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1958,6 +1958,23 @@
 	pm_request_idle(link->supplier);
 }
 
+static pm_callback_t get_callback(struct device *dev, size_t cb_offset)
+{
+	/*
+	 * Setting power.strict_midlayer means that the middle layer
+	 * code does not want its runtime PM callbacks to be invoked via
+	 * pm_runtime_force_suspend() and pm_runtime_force_resume(), so
+	 * return a direct pointer to the driver callback in that case.
+	 */
+	if (dev_pm_strict_midlayer_is_set(dev))
+		return __rpm_get_driver_callback(dev, cb_offset);
+
+	return __rpm_get_callback(dev, cb_offset);
+}
+
+#define GET_CALLBACK(dev, callback) \
+		get_callback(dev, offsetof(struct dev_pm_ops, callback))
+
 /**
  * pm_runtime_force_suspend - Force a device into suspend state if needed.
  * @dev: Device to suspend.
@@ -1984,7 +2001,7 @@
 	if (pm_runtime_status_suspended(dev) || dev->power.needs_force_resume)
 		return 0;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
+	callback = GET_CALLBACK(dev, runtime_suspend);
 
 	dev_pm_enable_wake_irq_check(dev, true);
 	ret = callback ? callback(dev) : 0;
@@ -2046,7 +2063,7 @@
 	    pm_runtime_status_suspended(dev)))
 		goto out;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_resume);
+	callback = GET_CALLBACK(dev, runtime_resume);
 
 	dev_pm_disable_wake_irq_check(dev, false);
 	ret = callback ? callback(dev) : 0;
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -879,6 +879,33 @@
 #endif
 }
 
+/*
+ * dev_pm_set_strict_midlayer - Update the device's power.strict_midlayer flag
+ * @dev: Target device.
+ * @val: New flag value.
+ *
+ * When set, power.strict_midlayer means that the middle layer power management
+ * code (typically, a bus type or a PM domain) does not expect its runtime PM
+ * suspend callback to be invoked at all during system-wide PM transitions and
+ * it does not expect its runtime PM resume callback to be invoked at any point
+ * when runtime PM is disabled for the device during system-wide PM transitions.
+ */
+static inline void dev_pm_set_strict_midlayer(struct device *dev, bool val)
+{
+#ifdef CONFIG_PM_SLEEP
+	dev->power.strict_midlayer = val;
+#endif
+}
+
+static inline bool dev_pm_strict_midlayer_is_set(struct device *dev)
+{
+#ifdef CONFIG_PM_SLEEP
+	return dev->power.strict_midlayer;
+#else
+	return false;
+#endif
+}
+
 static inline void device_lock(struct device *dev)
 {
 	mutex_lock(&dev->mutex);
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -683,6 +683,7 @@
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
+	bool			strict_midlayer:1;
 #else
 	bool			should_wakeup:1;
 #endif




