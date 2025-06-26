Return-Path: <linux-pci+bounces-30802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B46FCAEA506
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFDC4A7D00
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A622EE5E2;
	Thu, 26 Jun 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="M3LQNQS0"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3511A1E3DC8;
	Thu, 26 Jun 2025 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961748; cv=none; b=uSETGi3QkSx4UjbhQ2xz2guleUVmde2p68nloo/99qcKqJVlpSjlav49AfKMrZqrDsFFuPpR4F5jHyRs+SwCAM+antswtLaaU6gKJMZQkLQnohB8EFd2Vxnss7JoE93RXTxyhrPEzBGh35i6/oLYNs2LyHnbG5X1cWXntCP8J6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961748; c=relaxed/simple;
	bh=AhhL2gmRuY3bgkIz7Ee8tcllJ7eztJMY82zcN8jbQpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oza1+4AqvJSMKns89tYq8L/c/7R3te5/WXmELEXniof4y7ioSuNAMGaLTtd6zBhxOYbYXYW33MhCHQXgU3U6B6OG6j4xWGUww+1uL7soEbsvoNBzfMVjnUYbmRaO4E3UXYdK1JSs0M+XkUUi8rcSR2mb33pI0xYlgCAm8QLD/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=M3LQNQS0; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id EAF0C66E9A9;
	Thu, 26 Jun 2025 20:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961744;
	bh=AhhL2gmRuY3bgkIz7Ee8tcllJ7eztJMY82zcN8jbQpo=;
	h=From:Subject:Date;
	b=M3LQNQS040EY8gwEZDQOVnWqDselx9If+KAl7xXbv14FkpZCQ7yBsaCsDf/lDEVOd
	 82STbqZiAlT/oPxS0xbha9cfupOr9fSnGToSCdg239WjmMGXvDHCAHuXIMnO6KClzG
	 mm/t6h5DhKZgEo/123EFEod6pbfV9+JKefvZda3UttgUdfsr5stu8sThBOfosuzD2K
	 m6QXZL/k78uTt7MQNft/AkFfAYVHT2yoOTzIiG+evZP07vn/eD5ToJJ3PWCcp9ilzb
	 JQI+21Nq2f6cZ3kkiuYp8mfTZBKbprU45hNk93AdVKH+18eJcl4oTO4xskb5J6ub5D
	 QaxKaAZRvxQ/Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v2 7/9] PM: sleep: Add strict_midlayer flag to struct dev_pm_info
Date: Thu, 26 Jun 2025 20:09:19 +0200
Message-ID: <3311786.5fSG56mABF@rjwysocki.net>
In-Reply-To: <5015172.GXAFRqVoOG@rjwysocki.net>
References: <5015172.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTF716g97GLxl5r0PfOIWPAhDchnkSWDAqwBHc32sD+HpU8yKJB8xV8olL9lC0SzkWwWofqH3VgYdVRji5cIw9ZbUY7WKZiWjf3xKrF5n/kFXPdAEOzPBCDRv7/dwAHJIQ0XttMc6iSOqO8REJ6/sQbblDgpzZ3yfiPesShmkNx66bo1AYj8VcmdJw/BBHB050Zj303Yb/wm5mvAwXKjtlQwzCdkCdX+5402uydNZLICOp4E4D8MElAkMJkSAvvY8Q7l6VyWrFK73NizhJc5WdxP07GoEdKSjFDXh87nwem3gX8mTgRruroBzE94AJIHpV56uBgDMbkYtmhRhrGWknT+j/NtoaFRlOHuvfsGf6CS2qMl0YsF55MO4JvU11TjTu2RpDWD2KF6ryS6iCNEEtF2XumFUGFbnJkTWoxm0DiEFLhJ0L+HOcZNx04Fhb2dljDLJ3y5Hn1y5nTKvTrDBmdtCxRJn+1/3q3b6zEx6mGR0TXqNjHylPTFs00VZGXD7OgzcVjVnOj4MoujQaPjFL906kOXwKp2wmanJgyL4v1jAK+APHcX92hQj7+cbcQcvtTwX0rjs3wWBO+Yl5dEuGnyV2lzFjQLFixz/4SHCP4vFtHyZpjJ7yjK1OXiYNm9cxdDi8+dXcb90qZmuGMu0b+nyiypALUQHdxgK3zX2HtGMw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a new flag, called strict_midlayer, to struct dev_pm_info, along
with a helper function for changing its value, to allow middle layer
code that provides proper callbacks for device suspend/resume during
system-wide PM transitions to let pm_runtime_force_suspend() and
and pm_runtime_force_resume() know that they should only invoke runtime
PM callbacks coming from the device's driver.

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

v1 -> v2:
   * Rename dev_pm_strict_midlayer() to dev_pm_set_strict_midlayer().
   * Add dev_pm_strict_midlayer_is_set() and use it in get_callback()
     because pm_runtime_force_suspend() can be used in driver remove
     callbacks and so it needs to work with CONFIG_PM_SLEEP unset.

---
 drivers/base/power/runtime.c |   21 +++++++++++++++++++--
 include/linux/device.h       |   16 ++++++++++++++++
 include/linux/pm.h           |    1 +
 3 files changed, 36 insertions(+), 2 deletions(-)

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
@@ -879,6 +879,22 @@
 #endif
 }
 
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




