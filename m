Return-Path: <linux-pci+bounces-30961-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 368F1AEBFD6
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6039F166FBD
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A22ECD11;
	Fri, 27 Jun 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cy7oBoSv"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8486B2E92DE;
	Fri, 27 Jun 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052587; cv=none; b=StG0JnpZ+Vxr4E1mOTfNBxxRNTkxUs4ogOfsNXjQUn0hwYqR1HPCI7dxHOLJZd4cCnQoN5PntZBqQOh8+eHRl2ONzgrc8pCGh5yuxngQVMG+Ah7EJawYB8BsyORwfqjFmZsr3Gs1m1zfMxCjNc+SqrCaFmhOYK3sDLP8LYfU3Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052587; c=relaxed/simple;
	bh=Z0N60xq3kCpnv/XjKGtSTa3NRdhZk8CdO9VGmCPoETg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xjak/BfFSTKZkHXOetwASKYHJVSI9/V3J1INouF7N48Lgc4Z/ytUExA4t43bP6L6TlBTTr2kepiK6GUoZO91aIcTKIfCUjIfHFtEPS3MiLV0VtaPHRsgk3tKLhjIqUjJVx2LdoBWJB/f8L19PyXyi6AKPBlvbgqJdBKxXvN4MWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cy7oBoSv; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C4D9166DE8A;
	Fri, 27 Jun 2025 21:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052581;
	bh=Z0N60xq3kCpnv/XjKGtSTa3NRdhZk8CdO9VGmCPoETg=;
	h=From:Subject:Date;
	b=cy7oBoSvAYBHfztWRkfDYCfFz+3E+JuVviX8zuoQwQu/grApsmry0LzplDd2SlOCy
	 QjrirgVHH1xy3rIHeqQGJwlpKy9xGqq/WV18O4k1W3+FosW7ExM3v+lmSAqAjCIHTs
	 FIla5vb5K7XNvYIHWYdlJWm1dPSIAREQosfD4bAjM299S9yImQH8u1dOGDIZQMpZtg
	 YEe22rc4ochQSTq9gES8Kb63yYjlrtmfSQW2TDa5ZO3JxoF+/A24kVCUcut8hjGALn
	 yZLLbPizsjzTeNCFZxyqwyvOOt0QQrpfSB4sf7H8zczhfpQPSwAUUGOq1wFGQvhstR
	 PMrZVWrDApkGA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v3 3/9] PM: Make pm_runtime_force_resume() work with
 DPM_FLAG_SMART_SUSPEND
Date: Fri, 27 Jun 2025 21:15:59 +0200
Message-ID: <3662906.iIbC2pHGDl@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGrSjjgwBeoPV1BTemn5ImVCZpPTZb07vPRCPpCLNITJNQNwAJrBW+NvQ9gHfopUGw7eKCZUx2JvTkH7ndztXO95C/5NZYx0U0uzSGwSElzY3a0yFW5y/ST6sLyUL+pkZNb6zBf5QQDeWSHMTwFL5SzhnW4lYOV2aXUoJnPKm0KcXRLQpgIKgvtcuh9kc8szEcWaDKkWT6ZvZMLezK4NKUrQ0LRPHVUG/J8XldG2aWmsAAgiz8DIA4tSCjGi3syq1aAO8pJ5+EOuYaRvLcxgtvWWEpF/MWy84RxjOnkuHVdyEMV6Ug0G9LNrdrQ+TwE0ATvvO2S6WiA1+7Yw5g2H305gslEDzC4qYjPR98sLFkKLIORGzJ+a6iRC4PqBx2XJfBL5VbUkMarbPpAGSLxV5nrbhVZu+BgLG+QIwAWjIxtHQZKqyul0nsdoMPlQuI+34BbIf5IUEXGf/s5wbmIhCg+ettfeT7txWyW53DunSJZt+n2BpRqCSB5HBjgxADJ0aNgcDc4idWZCKEd14ogNps+gnFW/3iXHrnBtRh8CTHXWb8LQ09ge48jhxy+x9yudiztNFDmm7aysKArf1RkA+ocudNePxbW1cHqYMiW2TM0vY9VkvjAGC3ZTTDfkgca1jOeTZEbHIsRuF6nAOympCCOiW1JKjF3iKHi03ojkHCzpQ
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

v2 -> v3: Reorder (it was patch [5/9] in v2).

v1 -> v2:
   * Added R-by from Ulf.
   * Corresponds to patch [3/9] in v1.

---
 drivers/base/power/runtime.c |   38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1957,10 +1957,6 @@
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
@@ -2008,20 +2004,28 @@
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
 
 	/*
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




