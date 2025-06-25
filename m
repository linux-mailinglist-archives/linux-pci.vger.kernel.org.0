Return-Path: <linux-pci+bounces-30651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6BDAE8EA7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C3BA7A6FAC
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80622E2EF8;
	Wed, 25 Jun 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="biwk2G0k"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D952E06C7;
	Wed, 25 Jun 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879553; cv=none; b=jdiJzDKRx+IOsJ+3NpkR6Dh4GrO9wLKhSBgmAPFT7uDeXozItHcRgMLPNCm0I2uXa91bLHKdhJwPd699eGhmTeZbvo0gT/pTuER1RaNeXtlrnKj2mHGlhq1I5V1EJJgDrE6Yrnk1wahRwBGGTc4BS7+TUBDMoSndtuV25HqGyiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879553; c=relaxed/simple;
	bh=c9On8ljBPBpRJ/9+nmlX6D8ilQ5INGRpXRcdThXexWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnXz72tJAXfiJrMOFu982wIpz+l/h2elJjXAUaIH+mbF1Uo8pYgkyLvF+tvufTFK+bwyad8spbFX/owCcXfsDloV0eLHo+Nz1M9BfVH5QVgo9EHsPP3j6DSVbptwyAuUYWhw2N57qhTuAPsbGrazr5pAsTte1uIJLP8MGRYxkFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=biwk2G0k; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4E66C66E7DE;
	Wed, 25 Jun 2025 21:25:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879543;
	bh=c9On8ljBPBpRJ/9+nmlX6D8ilQ5INGRpXRcdThXexWo=;
	h=From:Subject:Date;
	b=biwk2G0kp7xQx/3X+3GqiGcqKZxYkM0E8dsJUKdoRvJUzdXs1qhPQJUhP+8SJOHhf
	 AFqbBSGg1DdthW8+ETLck4O/YPWMFl4bSwQ9/5JTpThSEHQf1NRC7ZA7WHTbWmANfB
	 N543BFOdgMVVsnnft9FhE5dKg6HU7U/0ZQ7PTcNd+nRJtCRBms/e0otBceGy1BILTG
	 kXSq/KfSXhemmqHieDj/jVNkKkobVV+GHdFhu7Kg76SGrh+qLO2nFcUcV3y9uHEvO5
	 Xn78QrLOMCVThm5M+2ry1hhnZQJXprqBX0UzP6x4ZjhLygvT2GAmc4eZNOP+wdc/2s
	 9ufWEVJdGKaXw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v1 3/9] PM: Make pm_runtime_force_resume() work with
 DPM_FLAG_SMART_SUSPEND
Date: Wed, 25 Jun 2025 21:18:51 +0200
Message-ID: <1847016.VLH7GnMWUR@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFU16MN1onAmfTggu3iKnPYA/STqEnOhMRWZkwNQSI5OpDf+u5DT2NkIXE+Nhe4mqxr9ks7U05Tnfbp21L5zWLAY+X8uGCUnkPai/a2KG4xxKx6eBqQiVngKpLwnPSZjvR8Q4dQfv5MKNDuphWx1Et6P/rcNTpUFGeZ3Ng1C9/8uA5jpLaNlvEnYZjWpU/0SCP+rHDTsSrswgF9Mks70F5evvoz0a/MhrLqsCe8JTvEOP0IBVuaTh/K6p4bcE/yKwFXFB6GIgqfD+zcy9GvwASdPeWl27ugbAiFeVCNlB4LFehOIpnBvg5juGRVEZAUcpiQXLbFVpM3kyVvpaAi61rFnJlhqw0pdzc1mdIsuUwlM0Ndu+7rNtFwwoJepNlkaxTWpRKd2jI2vxQZj6Dx2Fo67Ri1tcuM/ZVpmZFJhFAMPxsURlPACIWG7sQDBa4Y3JxTuBt1RtvmkpdxAgEGDfeUjf+Dn6Az/j368FTJliT7jIy7cnejiwTYQniCOz5T0Wc+ZAkXzQ98goWCiFvxvZN0LgoNfgiKsTlJ6/iexny0jtdnLJMP2fv+RYMJeTkpQMj7en6K7QRlLUPYIVBy11yh9X81ndTjfLyYeDWdCDJ9aYyZtU27fpmr/FRz4LSTiRYbqpJ/tsYRm+J+XFZ91jBcXcyryy5VQQofHSoFI9FlLA
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
---
 drivers/base/power/runtime.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1964,10 +1964,6 @@
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




