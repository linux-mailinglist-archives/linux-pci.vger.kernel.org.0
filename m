Return-Path: <linux-pci+bounces-30963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF0DAEBFEA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D47AB7B7755
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4162ED855;
	Fri, 27 Jun 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="ScfXtIgc"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507612EA73B;
	Fri, 27 Jun 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052588; cv=none; b=mXMODHhXfYCBz9JtOQYMKeaMdJcOqEjWQBo6/y4NCi2nG1NEMemDRuk5mmueFXg36NImp/TatKWTaoysAYNA7rzEBhNbbwzJrC4bWHJp+dFGtKmwNcHtvT0uFXziMmsopEuAwiPns1pzmahnhlSPd4IJ+yGZQTOYXYIXxKI9uNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052588; c=relaxed/simple;
	bh=MgvBlsJ/DMHt8Kgss7r5bAK9n/TKokfeGfDfe9EF2Cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3Vr7BjjMcqxGdAJF9Sl+bfysHI9r9FmzNo//Ec5RNIQ6GNWjPqrE5l9hi5MS+dtYoxnzD+tdegWkINjWbdsYbC8/pEpU/n3+vtP3k3AVC7RMUVmrtn4oQrMAjLdYXV33H1KbMITBUvQRf8qvdky6zdAg5zDobJ42nWWhDb4IJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=ScfXtIgc; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3C64D66DE73;
	Fri, 27 Jun 2025 21:29:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052579;
	bh=MgvBlsJ/DMHt8Kgss7r5bAK9n/TKokfeGfDfe9EF2Cs=;
	h=From:Subject:Date;
	b=ScfXtIgcniBKJCRD6/jR6NPHvN3ymKFg3nXCoH9oeiqRFFu2mysOlTbzNv3TC2e5H
	 ECNr/4t1w7k7Hb/kqyleHGHV8nvkZRCYzrgZieldudZyoyE1xNwKRPMFDitC82vpYu
	 4sd1Y2ug6wwlDWMWmmoIMvL7ynE0yywu6+vaoGHsne9kx8Qic5k+i6RUT/E5TfNW4M
	 xCqL1b3HeLrmGapamReavUgrLYDE2NdwmBNKeewJA1jhAvggNQiPNa/7jLimKdgD6t
	 KSKwn7KJIzINCTtVhKezJkyb4O0NvmEWdzoeVmx1gAwgY8vCNfyC2OV1dlDvkutanF
	 KUDAq2o/WJTIQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v3 5/9] PM: Check power.needs_force_resume in
 pm_runtime_force_suspend()
Date: Fri, 27 Jun 2025 21:19:31 +0200
Message-ID: <1855933.VLH7GnMWUR@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGrSjjgwBeoPV1BTemn5ImVCZpPTZb07vPRCPpCLNITJNQNwAJrBW+NvQ9gHfopUGw7eKCZUx2JvTkH7ndztXO95C/5NZYx0U0uzSGwSElzY3a0yFW5y/ST6sLyUL+pkZNb6zBf5QQDeWSHMTwFL5SzhnW4lYOV2aXUoJnPKm0KcXRLQpgIKgvtcuh9kc8szEcWaDKkWT6ZvZMLezK4NKUrQ0LRPHVUG/J8XldG2aWmsAAgiz8DIA4tSCjGi3syq1aAO8pJ5+EOuYaRvLcxgtvWWEpF/MWy84RxjOnkuHVdyEMV6Ug0G9LNrdrQ+TwE0ATvvO2S6WiA1+7Yw5g2H305qA3a5DTQAvMd3eX+r2ot7uQ3ewr5YpzXFKNcEw6iJmgF/z80Tl0DJuIvKrx/skYubFlkRkxVgInSftqTC9/smZ8b/Zc87Etbyx6N4IpG54GWJiQHYtbFBn5XlMlJyzSMmMHzVrVNGybamftIk6F6UReKpk5MQ5tpnv1/cBDfJjs/mGWUvwOKYxKTl1d/VBP8j1AhrJDSY0fhxhH9k70EyNQkgYXdqtH1XlEEx3xHz0iHo2upVSoUaQrw8eMN5K6fUBQAwrZjytd7U0lXqnv8gT3taluTb9ituKSzpUrqMK1uEBIvHKLK9J/eUb6skljGXkpIxi3eN2utClqwFhVk7Q
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a power.needs_force_resume check to pm_runtime_force_suspend() so
it need not rely on the runtime PM status of the device when deciding
whether or not to return early.

With the new check in place, pm_runtime_force_suspend() will also skip
devices with the runtime PM status equal to RPM_ACTIVE if they have
power.needs_force_resume set, so it won't need to change the RPM
status of the device to RPM_SUSPENDED in addition to setting
power.needs_force_resume in the case when pm_runtime_need_not_resume()
return false.

That allows the runtime PM status update to be removed from
pm_runtime_force_resume(), so the runtime PM status remains unchanged
between the pm_runtime_force_suspend() and pm_runtime_force_resume()
calls.

This change potentially unbreaks drivers that call pm_runtime_force_suspend()
from their ->remove() callbacks because currently, if the device being
unbound from its driver has a parent with enabled runtime PM and/or
(possibly) device links respecting runtime PM to suppliers, and it is
RPM_ACTIVE when the remove takes place, pm_runtime_force_suspend() will
not drop the parent's child count and the suppliers' runtime PM usage
counters after force-suspending the device unless pm_runtime_need_not_resume()
returns 'true' for it.  Moreover, because pm_runtime_force_suspend()
changes the device's runtime PM status to RPM_SUSPENDED, in the above
case pm_runtime_reinit() will not cause those counters to drop, so they
will remain nonzero forever effectively preventing the devices in
question from runtime-suspending going forward.

This change is also needed for pm_runtime_force_suspend() to work
with PCI PM and ACPI PM after subsequent changes.  Namely, say
DPM_FLAG_SMART_SUSPEND is set for a PCI device and its driver uses
pm_runtime_force_suspend() as its ->suspend() callback.  If
pm_runtime_force_suspend() changed the runtime PM status of the
device to RPM_SUSPENDED, pci_pm_suspend_noirq() would skip the
device due to the dev_pm_skip_suspend() check.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
   * Update changelog (explanation why it potentially unbreaks some drivers and
     why the subsequent changes depend on it).
   * Reorder (it was [4/9] previously).

v1 -> v2: Corresponds to patch [2/9] (that was posted as [0/9] by mistake) in v1.

---
 drivers/base/power/runtime.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1969,7 +1969,7 @@
 	int ret;
 
 	pm_runtime_disable(dev);
-	if (pm_runtime_status_suspended(dev))
+	if (pm_runtime_status_suspended(dev) || dev->power.needs_force_resume)
 		return 0;
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
@@ -1984,15 +1984,16 @@
 	/*
 	 * If the device can stay in suspend after the system-wide transition
 	 * to the working state that will follow, drop the children counter of
-	 * its parent, but set its status to RPM_SUSPENDED anyway in case this
-	 * function will be called again for it in the meantime.
+	 * its parent and the usage counters of its suppliers.  Otherwise, set
+	 * power.needs_force_resume to let pm_runtime_force_resume() know that
+	 * the device needs to be taken care of and to prevent this function
+	 * from handling the device again in case the device is passed to it
+	 * once more subsequently.
 	 */
-	if (pm_runtime_need_not_resume(dev)) {
+	if (pm_runtime_need_not_resume(dev))
 		pm_runtime_set_suspended(dev);
-	} else {
-		__update_runtime_status(dev, RPM_SUSPENDED);
+	else
 		dev->power.needs_force_resume = true;
-	}
 
 	return 0;
 
@@ -2033,12 +2034,6 @@
 	    pm_runtime_status_suspended(dev)))
 		goto out;
 
-	/*
-	 * The value of the parent's children counter is correct already, so
-	 * just update the status of the device.
-	 */
-	__update_runtime_status(dev, RPM_ACTIVE);
-
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	dev_pm_disable_wake_irq_check(dev, false);




