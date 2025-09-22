Return-Path: <linux-pci+bounces-36688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F471B91F4D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2455142505C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA70F2E8B76;
	Mon, 22 Sep 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DsG0jomU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7FC2E8B6F;
	Mon, 22 Sep 2025 15:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555210; cv=none; b=uN0o8wm6T7j/oJVi9uZ2WtBjUBwYoyBP5EbrFloTLJ3Ed3HkN04L1l9BGwIq7Brv1r9oMgxjFx1u62vp3JdmTA8iRnn8YvFOozUp5yzkvgn0IIezs5+O429bMIzCylhdPfTifFNZ8eH/WCOwso4MHkVi/yGFhJTvzz960KWV1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555210; c=relaxed/simple;
	bh=8AJxPrUrT8Y5UvfAyE95s6mhMSCa3aX/7RCx12ybYKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKyWKpO1v7y2w7mmxixRRCn4PPCodtoE36Ij1G2ErEbpi8jYfpOlmnLeVQzgzMdOHeTpNpkFhcr2F2lfCYJBOUXr61alviAinPOh25vT0g3dRXhhelq3Wvs/Mn6twJsYWmi6ktzhC4On58eQD29oGTi8rmEUR0uL3T1MX1z1iIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DsG0jomU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EADC4CEF7;
	Mon, 22 Sep 2025 15:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555209;
	bh=8AJxPrUrT8Y5UvfAyE95s6mhMSCa3aX/7RCx12ybYKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DsG0jomUQOO9aot8CQ6Vka/7oa14xh9nY8wICcw6N8zXLjNQbME8PFO3Z7bjU33Wp
	 3FzX3XmdeRTMVCfR/2sGWZETbaKQAsFzZOTMJXcdiusRfS77H+i03zjnW4RwNbrFH7
	 dZIXuA4VXcvmi0APxArhFnQ1HgcR+wzpYyl+qp3Qh38zWI//BEcDEV/yz5ZNPJVB0p
	 iN8CKAgYDPaMzsKlpGjJ36ayfQSqaGeGiz6YRNco0A+7NWkjw2cCtdBR4XEEBimN5x
	 5zCXMu0hpb7TJUeVTK5RUGLjMF1QnxubsT7qBQMV5Wv071+ynMWpk4zY+jBlAViB7B
	 AS2XfISEfxCog==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v3 1/3] PM: runtime: Add auto-cleanup macros for "resume and get"
 operations
Date: Mon, 22 Sep 2025 17:30:43 +0200
Message-ID: <2399578.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12763087.O9o76ZdvQC@rafael.j.wysocki>
References: <12763087.O9o76ZdvQC@rafael.j.wysocki>
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

can be transformed with CLASS(pm_runtime_get_sync) like:

	guard(pm_runtime_get_sync)(dev);
	.....
	return 0;

(see pm_runtime_put() call is gone).

However, it is better to do proper error handling in the majority of
cases, so doing something like this instead of the above is recommended:

	CLASS(pm_runtime_get_active, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
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

can be simplified with CLASS() like:

	CLASS(pm_runtime_get_active, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

(again, see pm_runtime_put() call is gone).

Still, if the device cannot be accessed unless runtime PM has been
enabled for it, the CLASS(pm_runtime_get_active_enabled) variant
needs to be used, that is (in the context of the example above):

	CLASS(pm_runtime_get_active_enabled, pm)(dev);
	if (IS_ERR(pm))
		return PTR_ERR(pm);
	.....
	return 0;

When the original code calls pm_runtime_put_autosuspend(), use one
of the "auto" class variants, CLASS(pm_runtime_get_active_auto) or
CLASS(pm_runtime_get_active_enabled_auto), so for example, a piece
of code like:

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

or CLASS(pm_runtime_get_active) can be used if transparent handling of
disabled runtime PM is desirable.

Link: https://lore.kernel.org/linux-pm/878qimv24u.wl-tiwai@suse.de/ [1]
Co-developed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

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
 include/linux/pm_runtime.h   |   82 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

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
@@ -606,6 +633,61 @@ static inline int pm_runtime_put_autosus
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
+ *
+ * If an error occurs, the runtime PM usage counter of dev will not be
+ * incremented, so using these classes without error handling is not
+ * recommended.
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
+ * They should be used only when runtime PM may be disabled for the given device
+ * and if that happens, the device is not regarded as operational and so it
+ * cannot be accessed.  The classes defined above should be used instead in all
+ * of the other cases.
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
+ * The following classes may be used instead of the above if resume failures can
+ * be neglected.  However, such cases are not expected to be prevalent, so using
+ * one of these classes should always be regarded as an exception and explained
+ * in an adjacent code comment.
+ */
+DEFINE_CLASS(pm_runtime_get_sync, struct device *,
+	     if (_T) pm_runtime_put(_T),
+	     ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
+
+DEFINE_CLASS(pm_runtime_get_sync_auto, struct device *,
+	     if (_T) pm_runtime_put_autosuspend(_T),
+	     ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
+
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.
  * @dev: Target device.




