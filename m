Return-Path: <linux-pci+bounces-30646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49CAE8E90
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6544F4A57E7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F72DECD1;
	Wed, 25 Jun 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="tHS8uBih"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498952690F9;
	Wed, 25 Jun 2025 19:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879551; cv=none; b=rqRLe66PovdFyb2H0wy9cfVVl5hlULzTTtC+NATN0xXQUyEdgzTiljbefPr+jjbjGLfpdHv2m6769LhDufPfK6a3uuldL8i1Ee/T+YvS9UL4/76hDWf8lniqthyTgl4nOEiysJf7wd7ybWm5fhZUWsOKwXxWUYtaC13BdQrrPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879551; c=relaxed/simple;
	bh=zE++/2JityZga9iLFpy6pe5BV7vAimt3PV4RZ20kA5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhIoMm4gE87++MeMO1X5IYlK+Fn+mr5ztWGnIcLOf3frFMeUnQproTD1xEzxhEaleV+YHyb3hglk/nYaTbkfD56ivjNq/BdJtAABWvrxsOlCbSatHT7087rTrCYRjhWw63Da7644GcGUGA9mnXsjA6GWokjxvF4QnTPJt/qeaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=tHS8uBih; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 57B7A66E7C8;
	Wed, 25 Jun 2025 21:25:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879540;
	bh=zE++/2JityZga9iLFpy6pe5BV7vAimt3PV4RZ20kA5s=;
	h=From:Subject:Date;
	b=tHS8uBihxtYbdxsDvYp9ElJEzQvvaGS6iHSpgYkn6BzB1wa7DyJCbpIpxI5WFEtx2
	 Ip/8hKtOSR8x2sh3ctYAJtlTKY7nUgevqJuoQ7Boze4KVu5JA74xVYLEFEsfoQAGBW
	 8pH47LtZDokv6hj+ygKxQM5UR3xQf9wQwOpvvtlruJu6PTGBcO0b8F8zl0lly4xodR
	 ShiTOfw5Du5Y7Ln7cJbRI2FpMfCH6gnLUfOUVD2IydcauyeqrfuAsjetPP2j1bF8Hr
	 zUrhgHGFzKCWHx1rODXXsXjvdto4Dqdxi92nceSKM8ZlMilfZBs+cXqbZ0UA+GTwdU
	 zaP5qTKkzQTmA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v1 7/9] PM: sleep: Add strict_midlayer flag to struct dev_pm_info
Date: Wed, 25 Jun 2025 21:24:17 +0200
Message-ID: <1990775.taCxCBeP46@rjwysocki.net>
In-Reply-To: <22759968.EfDdHjke4D@rjwysocki.net>
References: <22759968.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFf0XyIiSZsZxYER0kz1TDEaXPAxA6gWWkqxbUG6bEHYAAT6v7TovVLR3EubwKjtEYyKmRiDNwmxXjQgb7Fv7X9ZuMdrdZfAsHv0PNIdc3iCuimsCLgXHS3VdwsBDlX+N2aSEHhKkKe4bFtl6F8Z6j2Dip+JGIUOsjjf6wHXknBNzvedAFcMa3I+tP7mmNK0F2ZVMgNSEzPeNupteWTsKw+sVoNy7iibCNpCgtEmjTquEHJKyONjNL/DspJaB9CYI95YPuyjrNfj7djbo9ryKCwSItxPuwAqjcIzTCmlXbMERM6KTV/Uy/Mx0PyilUut5rFF6N5pUFFlP2Rd0dpJHiDJOsb4mTO2v6WLRgxG1fauXA7IvV1JPrYF+3wcUMofxJwhqxbIOxJ3ICeYbvYOCIhu3RpJwm8g2cjnNRXup0t3QPnRmioAbAL1Kq0PsTOu6b/pWJfrqMvLymg6HcGAPTYoB/LPHOTdaNm3H4uE9Ry3LrQKHrgIKglaOsMcyckGO7vGtf5FgqtPXGpkWRSGtBzlY2zMCThfoD9VivGnO3zKlkWZoH2vdLSsIDjB71UUdEM6aWFH3zFKx1DJYxajC4atbWhmeLgFdFc/kD7sGoMKDFWVOvqNVdlPcMBq4gHYnztRFMOHNC32d1XWbJ7Kfe1CnTQWf34R7kdlaoEcVRnwA
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
 drivers/base/power/runtime.c |   21 +++++++++++++++++++--
 include/linux/device.h       |    7 +++++++
 include/linux/pm.h           |    1 +
 3 files changed, 27 insertions(+), 2 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1962,6 +1962,23 @@
 		 dev->power.ignore_children);
 }
 
+static pm_callback_t get_callback(struct device *dev, size_t cb_offset)
+{
+	/*
+	 * Setting power.strict_midlayer means that the middle layer
+	 * code does not want its runtime PM callbacks to be invoked via
+	 * pm_runtime_force_suspend() and pm_runtime_force_resume(), so
+	 * return a direct pointer to the driver callback in that case.
+	 */
+	if (dev->power.strict_midlayer)
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
@@ -1988,7 +2005,7 @@
 	if (pm_runtime_status_suspended(dev) || dev->power.needs_force_resume)
 		return 0;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
+	callback = GET_CALLBACK(dev, runtime_suspend);
 
 	dev_pm_enable_wake_irq_check(dev, true);
 	ret = callback ? callback(dev) : 0;
@@ -2048,7 +2065,7 @@
 	    pm_runtime_status_suspended(dev)))
 		goto out;
 
-	callback = RPM_GET_CALLBACK(dev, runtime_resume);
+	callback = GET_CALLBACK(dev, runtime_resume);
 
 	dev_pm_disable_wake_irq_check(dev, false);
 	ret = callback ? callback(dev) : 0;
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -879,6 +879,13 @@
 #endif
 }
 
+static inline void dev_pm_strict_midlayer(struct device *dev, bool val)
+{
+#ifdef CONFIG_PM_SLEEP
+	dev->power.strict_midlayer = val;
+#endif
+}
+
 static inline void device_lock(struct device *dev)
 {
 	mutex_lock(&dev->mutex);
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -684,6 +684,7 @@
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
 	bool			needs_force_resume:1;
+	bool			strict_midlayer:1;
 #else
 	bool			should_wakeup:1;
 #endif




