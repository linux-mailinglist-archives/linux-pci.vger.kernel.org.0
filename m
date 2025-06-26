Return-Path: <linux-pci+bounces-30804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CBBAEA510
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72AEE1C420A2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAB22EF2A6;
	Thu, 26 Jun 2025 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ziydn1LJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8992ECE80;
	Thu, 26 Jun 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961750; cv=none; b=BZEedQGNbzfVMxHVETPuEwB6m/HULzHlaRleZ9XYBxKhxRB/gywVrpLs7yWBk49Wk5m/o2JliKOLXM9P5fJZaw344AH14CNB1E4p7AO6zQ9/4xR5TUslGMTHEIEMfNNrMs16DvOfqaqCFS4/QcwknrMFq3Qs86/9ufuUrrRLTTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961750; c=relaxed/simple;
	bh=+EAQlblP0d7jGYyj+x1+5IGIR2s09xZawcBVk29N8fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bWyeeTAFgr6mhHfSLyReRSKN3mFa3vwKnjpjiN8SEYNRDg7A3n4U/3x5bJ8YLRFiBFpjc/9yNDW8KayjzmKgCPHtNPG3+gbFVd0+e+Zc+mtyTuOAZt6txLp9RidZdsNRAUX7AO6TMUw3ufV2m4FxIVykfrqK6zygIRuiGxIP1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ziydn1LJ; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0753966E9B7;
	Thu, 26 Jun 2025 20:15:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961746;
	bh=+EAQlblP0d7jGYyj+x1+5IGIR2s09xZawcBVk29N8fw=;
	h=From:Subject:Date;
	b=Ziydn1LJpmk3qTCZnpBDNmFIlnmTzUy5FYADu8zKxvtvXRhv0sRQGYG5prjYku6Zx
	 PHh1VvJsGjO1MBkEJ2KF8pVuMpx+CYykwcfABMpphH9H02Vzj/4612+ddv3DtOCVvv
	 VsoWLshvgeS0nZLIdBZt+BY312zmNnHDKnEf1nFxs9OI7l/+3binutPFjvlcrZrgUl
	 5QWbyooZJZHJgyVHRRcIHWhSYzAibQ2xc7k+peWGzq9/9vhU5LvUvKfLDwWbKYABTV
	 Jb+f61ztzmyk3woY7lK/cRBzxWGvEwj5DYu0sPum4nSTTQdf2IWyGkLOQuJl+pdRIU
	 veVkF2jRupmIQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v2 5/9] PM: Make pm_runtime_force_resume() work with
 DPM_FLAG_SMART_SUSPEND
Date: Thu, 26 Jun 2025 20:04:41 +0200
Message-ID: <22766435.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTELtlwpycCpv0Vcuy8QanEK65EXpXLDYHJklsvPFyrHxl+avjRHDMJ7Pn1w8r8jjwxdARbdK2l6HvrQpU6gOIgHwqnc6mWfuAcVkm0fjKgXKtQhSdxCxnuVXrmGsTXIoZNtqbmO2vNuBJTcPUJZcz8R30PgE7bGEL3PWfdNzVLoVYs7Qoda0OTfmBJ3NatDBgLvJuvPlRG2dcl26WhHZbi4RyoYzmp2r7+bO7YpOn26wkYi1BZUkbAIVk0I3hYwmbSrEOMnYl/hve4oRCJ1F8R5clMEE2pVXAf8o49/YUaNEHtTh2A9QXrvEf9flQXInm5SNV3s2dtsBWqHjVykY5tzpv44XIDGvyWuPM26oHOX0wO0KJH4q3IH+BpbMJ/rG5o0lruCpEgxT21TjstRd/f04r9ftBHsUBCmkKIvNk5y+ebU/D6nF0OBGF7CzMTKDSFICLq926YdZLGUTZ2+ZCCAIKrd7WWF9UxV26WwRFVLjfdKV1Neib6VJCEDgreJGrtqL9gKjy6Qr0c8dIwihivyO6+eGkFthkyLsBs4k1zyP+N+/2FYLJIDCirhBVWS0/U3Riao0MLY57sp6b8lmybEFnDv9tU2vLk+I5bbONaDo2iRrVSglwprGkB/7evTGYQBEHCtOaTHJjh+QjmlcCvleAf2tW/Y+0Hchb1JJXLMxw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Curently, drivers using pm_runtime_force_suspend/resume() cannot set
DPM_FLAG_SMART_SUSPEND because the devices with that flag set may need
to be resumed during system-wide resume regardless of whether or not
they have power.needs_force_resume set.  That can happen due to a
dependency resolved at the beginning of a system-wide resume transition
(for instance, a bus type or PM domain has decided to resume a
subordinate device with DPM_FLAG_SMART_SUSPEND and its parent and
suppliers also need to be resumed).

To overcome this limitation, modify pm_runtime_force_resume() to check
the device's power.smart_suspend flag (which is set for devices with
DPM_FLAG_SMART_SUSPEND set that meet some additional requirements) and
the device's runtime PM status in addition to power.needs_force_resume.
Also change it to clear power.smart_suspend to ensure that it will not
handle the same device twice during one transition.

The underlying observation is that there are two cases in which the
device needs to be resumed by pm_runtime_force_resume().  One of them
is when the device has power.needs_force_resume set, which means that
pm_runtime_force_suspend() has suspended it and decided that it should
be resumed during the subsequent system resume.  The other one is when
power.smart_suspend is set and the device's runtume PM status is
RPM_ACTIVE.

Update kerneldoc comments in accordance with the code changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

v1 -> v2:
   * Added R-by from Ulf.
   * Corresponds to patch [3/9] in v1.

---
 drivers/base/power/runtime.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1962,10 +1962,6 @@
  * sure the device is put into low power state and it should only be used during
  * system-wide PM transitions to sleep states.  It assumes that the analogous
  * pm_runtime_force_resume() will be used to resume the device.
- *
- * Do not use with DPM_FLAG_SMART_SUSPEND as this can lead to an inconsistent
- * state where this function has called the ->runtime_suspend callback but the
- * PM core marks the driver as runtime active.
  */
 int pm_runtime_force_suspend(struct device *dev)
 {
@@ -2014,20 +2010,28 @@
  * pm_runtime_force_resume - Force a device into resume state if needed.
  * @dev: Device to resume.
  *
- * Prior invoking this function we expect the user to have brought the device
- * into low power state by a call to pm_runtime_force_suspend(). Here we reverse
- * those actions and bring the device into full power, if it is expected to be
- * used on system resume.  In the other case, we defer the resume to be managed
- * via runtime PM.
+ * This function expects that either pm_runtime_force_suspend() has put the
+ * device into a low-power state prior to calling it, or the device had been
+ * runtime-suspended before the preceding system-wide suspend transition and it
+ * was left in suspend during that transition.
+ *
+ * The actions carried out by pm_runtime_force_suspend(), or by a runtime
+ * suspend in general, are reversed and the device is brought back into full
+ * power if it is expected to be used on system resume, which is the case when
+ * its needs_force_resume flag is set or when its smart_suspend flag is set and
+ * its runtime PM status is "active".
+ *
+ * In other cases, the resume is deferred to be managed via runtime PM.
  *
- * Typically this function may be invoked from a system resume callback.
+ * Typically, this function may be invoked from a system resume callback.
  */
 int pm_runtime_force_resume(struct device *dev)
 {
 	int (*callback)(struct device *);
 	int ret = 0;
 
-	if (!dev->power.needs_force_resume)
+	if (!dev->power.needs_force_resume && (!dev_pm_smart_suspend(dev) ||
+	    pm_runtime_status_suspended(dev)))
 		goto out;
 
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
@@ -2041,8 +2045,20 @@
 	}
 
 	pm_runtime_mark_last_busy(dev);
+
 out:
+	/*
+	 * The smart_suspend flag can be cleared here because it is not going
+	 * to be necessary until the next system-wide suspend transition that
+	 * will update it again.
+	 */
+	dev->power.smart_suspend = false;
+	/*
+	 * Also clear needs_force_resume to make this function skip devices that
+	 * have been seen by it once.
+	 */
 	dev->power.needs_force_resume = false;
+
 	pm_runtime_enable(dev);
 	return ret;
 }




