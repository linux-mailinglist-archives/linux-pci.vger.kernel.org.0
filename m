Return-Path: <linux-pci+bounces-36586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C559B8C63D
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C101BC0C85
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412D72F9DAB;
	Sat, 20 Sep 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pnC/sOZh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465634BA2A;
	Sat, 20 Sep 2025 10:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758365828; cv=none; b=HTC02LOe6ykC4wZXGg3sxih6dqFAbmZiY9zbK4Zp+mGhBMUzjEVeDtza16s88gIvY80k8tfNVTrCLNP+xfauhlvOnZCKhagirppXUWJ4DGKJxOVpDlWcj0j5iBl1W8t7laIOe0bFWx5IIxEKykf19zBmLIkng0uNVjyp64GZ/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758365828; c=relaxed/simple;
	bh=CwmX9QH4WahCWy8Y+rHldwTQMUa6Sdi7J55G3rWruXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWPs7nEvts3d+/JjTuG4zbraW/n+h4PLY+Wvk4mlqgndUKl6pOjF1cK6bxIHVfffc/zu+Xnyrfpz53M5oF8A0QLLprhdKawK58WOqhdV7TuoqIGoAEIIvc6OUT6AMPC1wUjvkSJ/BhGH5NAI/5a+j7UMOON9sZpotPGoynGsp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pnC/sOZh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88964C4CEEB;
	Sat, 20 Sep 2025 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758365827;
	bh=CwmX9QH4WahCWy8Y+rHldwTQMUa6Sdi7J55G3rWruXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pnC/sOZhINNDP0F+Hy88F0epwpLTwyEViqyrJzGTgMK1vCJzPNN7cTo7Xzl2PwO8c
	 UqvYHXFGO6kFrmwBsmnZ0c1FO6eH5c3kTef6Ihw+UBT1UdN/whMEA1djt6l8MEQ1pl
	 UvCp4tcq16Y/uhkNOet6Vr1JEAhEI1C/8vA0XNHGA7q3Vuq9xMjlYmOHF9BA818HRi
	 YWXFiKqbNGH8wAsHGpTIcr4d3/NDVflHXVTr6njfDvWj/5ei6KjXc2y3hE6eYdX0sN
	 XRNOq4HISQOPydyLi1nYHKBge5dmv2vKCuHGYkq6XaREStv7xcumibs56wEzte9jhT
	 CGJuUocc1KTPg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v2 1/3] PM: runtime: Add auto-cleanup macros for "resume and get"
 operations
Date: Sat, 20 Sep 2025 12:54:58 +0200
Message-ID: <3388279.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
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

To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
those cases.

Simply put, a piece of code like below:

	pm_runtime_get_sync(dev);
	.....
	pm_runtime_put(dev);
	return 0;

can be transformed with CLASS() like:

	CLASS(pm_runtime_get_active, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

(note the new resume error handling).

In all of the cases in which runtime PM is known to be enabled for the
given device or it can be regarded as operational (and so it can be
accessed) with runtime PM disabled, a piece of code like:

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	.....
	pm_runtime_put(dev);
	return 0;

can be simplified with CLASS() like:

	CLASS(pm_runtime_get_active, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

(see pm_runtime_put() call is gone).

However, if the device cannot be accessed unless runtime PM has been
enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
needs to be used, that is (in the context of the example above):

	CLASS(pm_runtime_get_active_enabled, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

When the original code calls pm_runtime_put_autosuspend(), use
CLASS(pm_runtime_get_active_enabled_auto) variant, instead.
For example, a piece of code like:

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;
	.....
	pm_runtime_put_autosuspend(dev);
	return 0;

will become:

	CLASS(pm_runtime_get_active_enabled_auto, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
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

	CLASS(pm_runtime_get_active_enabled, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Rename the new classes and the new static inline helper.
   * Add two classes for handling disabled runtime PM.
   * Expand the changelog.
   * Adjust the subject.

---
 drivers/base/power/runtime.c |    2 +
 include/linux/pm_runtime.h   |   70 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

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
@@ -533,6 +534,32 @@ static inline int pm_runtime_resume_and_
 }
 
 /**
+ * pm_runtime_get_active_dev - Resume a device and bump up its usage counter.
+ * @dev: Target device.
+ * @rpmflags: Additional runtime PM flags to combine with RPM_GET_PUT.
+ *
+ * Resume @dev synchronously and if that is successful, increment its runtime
+ * PM usage counter.
+ *
+ * Return:
+ * * 0 if the runtime PM usage counter of @dev has been incremented.
+ * * Negative error code otherwise.
+ */
+static inline struct device *pm_runtime_get_active_dev(struct device *dev,
+						       int rpmflags)
+{
+	int ret;
+
+	ret = __pm_runtime_resume(dev, RPM_GET_PUT | rpmflags);
+	if (ret < 0) {
+		pm_runtime_put_noidle(dev);
+		return ERR_PTR(ret);
+	}
+
+	return dev;
+}
+
+/**
  * pm_runtime_put - Drop device usage counter and queue up "idle check" if 0.
  * @dev: Target device.
  *
@@ -606,6 +633,49 @@ static inline int pm_runtime_put_autosus
 	return __pm_runtime_put_autosuspend(dev);
 }
 
+/*
+ * The way to use the classes defined below is to define a class variable and
+ * use it going forward for representing the target device until it goes out of
+ * the scope.  For example:
+ *
+ * CLASS(pm_runtime_get_active, active_dev)(dev);
+ * if (IS_ERR(active_dev))
+ *         return PTR_ERR(active_dev);
+ *
+ * ... do something with active_dev (which is guaranteed to never suspend) ...
+ */
+DEFINE_CLASS(pm_runtime_get_active, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
+	     pm_runtime_get_active_dev(dev, RPM_TRANSPARENT), struct device *dev)
+
+DEFINE_CLASS(pm_runtime_get_active_auto, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
+	     pm_runtime_get_active_dev(dev, RPM_TRANSPARENT), struct device *dev)
+
+/*
+ * The following two classes are analogous to the two classes defined above,
+ * respectively, but they produce an error pointer if runtime PM has been
+ * disabled for the given device.
+ *
+ * They should be used in the cases when a device with runtime PM disabled is
+ * not regarded as operational and so it cannot be accessed.  The classes
+ * defined above should be used in all of the other cases.
+ */
+DEFINE_CLASS(pm_runtime_get_active_enabled, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put(_T),
+	     pm_runtime_get_active_dev(dev, 0), struct device *dev)
+
+DEFINE_CLASS(pm_runtime_get_active_enabled_auto, struct device *,
+	     if (!IS_ERR_OR_NULL(_T)) pm_runtime_put_autosuspend(_T),
+	     pm_runtime_get_active_dev(dev, 0), struct device *dev)
+
+/*
+ * The following two classes are analogous to the two classes defined above,
+ * respectively, but they transparently handle devices with runtime PM disabled.
+ *
+ * They can be used when it is known that runtime PM has been enabled for the
+ * given device.
+ */
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




