Return-Path: <linux-pci+bounces-37110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E44BA4A17
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96F37BC7AE
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CA0296BBE;
	Fri, 26 Sep 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W41rJvup"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D36261B7F;
	Fri, 26 Sep 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904075; cv=none; b=EMBfP55rRU4UM4U7P3oQhHcPJ5/yDv7hcb06Ze0ORMUBy6QpeqzTEIduCGd32EvoE0M7tWj13KE/k5cI/k4/7pKZuBQyWbXe3QIjfLXLEzTxK71q2KIGCEEex2wTJFyBJ80FtQx3y1OsxH14pYAhkPEwGLvkSkYZ5r5WZJxG5l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904075; c=relaxed/simple;
	bh=teMC0tMk1mLM4Of0idpMUE3tdsOJWZSq9BD6q7gznoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GU3mm6hnmG6z0p/8bkJPzT10qawM6cO1xRNQVmsFNId0gh7MzPkGzD014/HEXChhgcAC/KNtvBGr80qq0Sr2NoZXeeenkXr79BkOQv7Tk9gHYSikhgLIY5XOapuaJikq3+eWRLiS+Ig2GWYSv+Rns4fKkjzXw+dUTC6eDvmBFdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W41rJvup; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D07C4CEF4;
	Fri, 26 Sep 2025 16:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904075;
	bh=teMC0tMk1mLM4Of0idpMUE3tdsOJWZSq9BD6q7gznoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W41rJvupOXbqPvxGyRp7j5AeAfrhejdE0HwU9ZmzdSh5mEVveCxWRFFFbR0lr2gSJ
	 Y1tkKKU27yX4JyhxZIkzyRwwm2OQfVAkMDcMUodgr46zeaPfy7sKsErwtLmMcO79tk
	 JT8edlZZKWEFHp9lzBRqrj0WpLr6UIf6m9jWmgmIZVx0s48nEGRhvPT+jQUEayPVpW
	 wfwDoqESldskL+bf5KPBTxmr1XE1OV40kmu02x7TyDr1qddgSIaR7eRJjos6ZE4oti
	 wIohqrHZDRdpjedNgZbiOeaGSiDqIs0/Krkd0R2ufn8evPhSoeIXGAZn4ZIadAS2uS
	 xXllXCIsMJ/lA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>
Subject:
 [PATCH v4 1/3] PM: runtime: Add auto-cleanup macros for "resume and get"
 operations
Date: Fri, 26 Sep 2025 17:47:14 +0200
Message-ID: <2238241.irdbgypaU6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is generally useful to be able to automatically drop a device's
runtime PM usage counter incremented by runtime PM operations that
resume a device and bump up its usage counter [1].

To that end, add guard definition macros allowing pm_runtime_put()
and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
those cases.

Simply put, a piece of code like below:

	pm_runtime_get_sync(dev);
	.....
	pm_runtime_put(dev);
	return 0;

can be transformed with guard() like:

	guard(pm_runtime_active)(dev);
	.....
	return 0;

(see the pm_runtime_put() call is gone).

However, it is better to do proper error handling in the majority of
cases, so doing something like this instead of the above is recommended:

	ACQUIRE(pm_runtime_active_try, pm)(dev);
	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
		return -ENXIO;
	.....
	return 0;

In all of the cases in which runtime PM is known to be enabled for the
given device or the device can be regarded as operational (and so it can
be accessed) with runtime PM disabled, a piece of code like:

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	.....
	pm_runtime_put(dev);
	return 0;

can be changed as follows:

	ACQUIRE(pm_runtime_active_try, pm)(dev);
	ret = ACQUIRE_ERR(pm_runtime_active_try, &pm);
	if (ret < 0)
		return ret;
	.....
	return 0;

(again, see the pm_runtime_put() call is gone).

Still, if the device cannot be accessed unless runtime PM has been
enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
needs to be used, that is (in the context of the example above):

	ACQUIRE(pm_runtime_active_try_enabled, pm)(dev);
	ret = ACQUIRE_ERR(pm_runtime_active_try_enabled, &pm);
	if (ret < 0)
		return ret;
	.....
	return 0;

When the original code calls pm_runtime_put_autosuspend(), use one
of the "auto" guard variants, pm_runtime_active_auto/_try/_enabled,
so for example, a piece of code like:

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	.....
	pm_runtime_put_autosuspend(dev);
	return 0;

will become:

	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
	if (ret < 0)
		return ret;
	.....
	return 0;

Note that the cases in which the return value of pm_runtime_get_sync()
is checked can also be handled with the help of the new class macros.
For example, a piece of code like:

	ret = pm_runtime_get_sync(dev);
	if (ret < 0) {
		pm_runtime_put(dev);
		return ret;
	}
	.....
	pm_runtime_put(dev);
	return 0;

can be rewritten as:

	ACQUIRE(pm_runtime_active_auto_try_enabled, pm)(dev);
	ret = ACQUIRE_ERR(pm_runtime_active_auto_try_enabled, &pm);
	if (ret < 0)
		return ret;
	.....
	return 0;

or pm_runtime_get_active_try can be used if transparent handling of
disabled runtime PM is desirable.

Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
Link: https://lore.kernel.org/linux-pm/20250926150613.000073a4@huawei.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Use guard definition macros instead of raw DEFINE_CLASS() (Jonathan)
   * Change pm_runtime_get_active() helper definition to return an int instead
     of a pointer
   * Update changelog to match the new code

v2 -> v3:
   * Two more class definitions for the case in which resume errors can be
     neglected.
   * Update of new code comments (for more clarity).
   * Changelog update.

v1 -> v2:
   * Rename the new classes and the new static inline helper.
   * Add two classes for handling disabled runtime PM.
   * Expand the changelog.
   * Adjust the subject.

---
 drivers/base/power/runtime.c |    2 +
 include/linux/pm_runtime.h   |   44 ++++++++++++++++++++++++++++++++++---------
 2 files changed, 37 insertions(+), 9 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -796,6 +796,8 @@ static int rpm_resume(struct device *dev
 		if (dev->power.runtime_status == RPM_ACTIVE &&
 		    dev->power.last_status == RPM_ACTIVE)
 			retval = 1;
+		else if (rpmflags & RPM_TRANSPARENT)
+			goto out;
 		else
 			retval = -EACCES;
 	}
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -21,6 +21,7 @@
 #define RPM_GET_PUT		0x04	/* Increment/decrement the
 					    usage_count */
 #define RPM_AUTO		0x08	/* Use autosuspend_delay */
+#define RPM_TRANSPARENT	0x10	/* Succeed if runtime PM is disabled */
 
 /*
  * Use this for defining a set of PM operations to be used in all situations
@@ -511,6 +512,19 @@ static inline int pm_runtime_get_sync(st
 	return __pm_runtime_resume(dev, RPM_GET_PUT);
 }
 
+static inline int pm_runtime_get_active(struct device *dev, int rpmflags)
+{
+	int ret;
+
+	ret = __pm_runtime_resume(dev, RPM_GET_PUT | rpmflags);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ret;
+	}
+
+	return 0;
+}
+
 /**
  * pm_runtime_resume_and_get - Bump up usage counter of a device and resume it.
  * @dev: Target device.
@@ -521,15 +535,7 @@ static inline int pm_runtime_get_sync(st
  */
 static inline int pm_runtime_resume_and_get(struct device *dev)
 {
-	int ret;
-
-	ret = __pm_runtime_resume(dev, RPM_GET_PUT);
-	if (ret < 0) {
-		pm_runtime_put_noidle(dev);
-		return ret;
-	}
-
-	return 0;
+	return pm_runtime_get_active(dev, 0);
 }
 
 /**
@@ -606,6 +612,26 @@ static inline int pm_runtime_put_autosus
 	return __pm_runtime_put_autosuspend(dev);
 }
 
+DEFINE_GUARD(pm_runtime_active, struct device *,
+	     pm_runtime_get_sync(_T), pm_runtime_put(_T));
+DEFINE_GUARD(pm_runtime_active_auto, struct device *,
+	     pm_runtime_get_sync(_T), pm_runtime_put_autosuspend(_T));
+/*
+ * Use the following guards with ACQUIRE()/ACQUIRE_ERR().
+ *
+ * The difference between the "_try" and "_try_enabled" variants is that the
+ * former do not produce an error when runtime PM is disabled for the given
+ * device.
+ */
+DEFINE_GUARD_COND(pm_runtime_active, _try,
+		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
+DEFINE_GUARD_COND(pm_runtime_active, _try_enabled,
+		  pm_runtime_resume_and_get(_T))
+DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
+		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
+DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
+		  pm_runtime_resume_and_get(_T))
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




