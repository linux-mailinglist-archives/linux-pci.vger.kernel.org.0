Return-Path: <linux-pci+bounces-30964-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C80AEBFEF
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 262C47B7A39
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB92EE29D;
	Fri, 27 Jun 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="vQScK1/W"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506EC2EA72F;
	Fri, 27 Jun 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052588; cv=none; b=DUJInpWSAJzCn5C9R9wNSqD+LrZBwJx+PoSf1xaCUZaLDcBdfbb3M97GxG+joMOLx1OmNmZTnksDNPOrLWhEqP3WQTVH3EH7Q1NrxuDY1PHpmTwzdfO0XWmWmHBMJmhwura0B/Zwj0OpdwKfCu+3EyOtIEaTebM0jYtt+6tSqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052588; c=relaxed/simple;
	bh=qomG2jEgH2N5lQ6ECtla5SnH6Y+Dt64taWawObq9AZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iH+bqWiIFM35RGJ53q3rYXoBgNxW8VpXkgNK33AMQrWqFvAwaZgE9/H36Wgr55PX7RRaZoXdi5BLytiXTBXGJCGO3W/WaECKR39q7sAuAmHbLKMjXWObYX3yNF40JbxhBjiuAfeddsrh4lnoXGT5fgqJ0iO5dl4kvXZUcFh8Coc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=vQScK1/W; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0D62266DF42;
	Fri, 27 Jun 2025 21:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052582;
	bh=qomG2jEgH2N5lQ6ECtla5SnH6Y+Dt64taWawObq9AZw=;
	h=From:Subject:Date;
	b=vQScK1/WZIGw6eW5u3ZmmFvgUUro02zcDYT3XuwAv7YkqYQRCaYUcnqjLGjJwjFot
	 Pikk4oFa3den575z9ooTOjzFA4cOjiw0klK5LH7wFS3TT8Lb35jOYzReOj4RUSgfa7
	 i45NmmKrLvL6URYJXv7y0OB4CRs4S0fWJhND3nqgMn/fB3busLtjAdDeLpUAAs1gKr
	 JkoN6FRmrBP4/fiJLIVAJepV6LHkmslL0wey+eoWG4D49KQI7mnXDqji3V0uc8d42V
	 FllYRiEK9mNjTIo7WRcWMr+9S04l1nXSeLdma6gVJKzWHUg4cYo5XfBsuhIOiTdRV3
	 ElS4rTSAvaK7Q==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v3 2/9] PM: Move two sleep-related functions under CONFIG_PM_SLEEP
Date: Fri, 27 Jun 2025 21:08:48 +0200
Message-ID: <3384523.aeNJFYEL58@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGrSjjgwBeoPV1BTemn5ImVCZpPTZb07vPRCPpCLNITJNQNwAJrBW+NvQ9gHfopUGw7eKCZUx2JvTkH7ndztXO95C/5NZYx0U0uzSGwSElzY3a0yFW5y/ST6sLyUL+pkZNb6zBf5QQDeWSHMTwFL5SzhnW4lYOV2aXUoJnPKm0KcXRLQpgIKgvtcuh9kc8szEcWaDKkWT6ZvZMLezK4NKUrQ0LRPHVUG/J8XldG2aWmsAAgiz8DIA4tSCjGi3syq1aAO8pJ5+EOuYaRvLcxgtvWWEpF/MWy84RxjOnkuHVdyEMV6Ug0G9LNrdrQ+TwE0ATvvO2S6WiA1+7Yw5g2H305Ka/9/AB20Ji8aYocbnvXnSgVE3yuoI/x8dRBi9lwenVlKYIMrlt/oq4QrEwNVvyUKN1kfois/E/YdcEuMI1szrw2gRCq67RS+aNItPgKlX9D+K+blGIPc1BT5T7VZaDtt8o/iEv9+0CIKWFBDIPmpHXh6SlJ4oq1SUu2GgVARUSjO4jCvR44E41RGFQdvahxbMkK8S/MnAJzZlzuq8z1GfLsus4biOc+6aEm/tpC3fevcfY8d/eaPO9KShfPhteoNsJyq0nyVlKE2AuxIKYSuLg3o0/XZlSh+TZ/TATCbsMI/j9wpC1A2J+KBSEP6dj7qiO4EnlhEGF+LSd3m3ollA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since pm_runtime_force_resume() and pm_runtime_need_not_resume() are only
needed for handling system-wide PM transitions, there is no reason to
compile them in if CONFIG_PM_SLEEP is unset.

Accordingly, move them under CONFIG_PM_SLEEP and make the static
inline stub for pm_runtime_force_resume() return an error to indicate
that it should not be used outside CONFIG_PM_SLEEP.

Putting pm_runtime_force_resume() also allows subsequent changes to
be more straightforward because this function is going to access a
device PM flag that is only defined when CONFIG_PM_SLEEP is set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Reorder (previosly it was patch [3/9].

v1 -> v2:
   * Keep pm_runtime_force_suspend() under CONFIG_PM (Ulf).
   * Update changelog.
   * Corresponds to patch [4/9] in v1.

---
 drivers/base/power/runtime.c |   18 +++++++++++-------
 include/linux/pm_runtime.h   |   16 ++++++++++++----
 2 files changed, 23 insertions(+), 11 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1946,13 +1946,6 @@
 	pm_request_idle(link->supplier);
 }
 
-bool pm_runtime_need_not_resume(struct device *dev)
-{
-	return atomic_read(&dev->power.usage_count) <= 1 &&
-		(atomic_read(&dev->power.child_count) == 0 ||
-		 dev->power.ignore_children);
-}
-
 /**
  * pm_runtime_force_suspend - Force a device into suspend state if needed.
  * @dev: Device to suspend.
@@ -2014,6 +2007,8 @@
 }
 EXPORT_SYMBOL_GPL(pm_runtime_force_suspend);
 
+#ifdef CONFIG_PM_SLEEP
+
 /**
  * pm_runtime_force_resume - Force a device into resume state if needed.
  * @dev: Device to resume.
@@ -2057,3 +2052,12 @@
 	return ret;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_force_resume);
+
+bool pm_runtime_need_not_resume(struct device *dev)
+{
+	return atomic_read(&dev->power.usage_count) <= 1 &&
+		(atomic_read(&dev->power.child_count) == 0 ||
+		 dev->power.ignore_children);
+}
+
+#endif /* CONFIG_PM_SLEEP */
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -66,9 +66,7 @@
 
 extern int pm_generic_runtime_suspend(struct device *dev);
 extern int pm_generic_runtime_resume(struct device *dev);
-extern bool pm_runtime_need_not_resume(struct device *dev);
 extern int pm_runtime_force_suspend(struct device *dev);
-extern int pm_runtime_force_resume(struct device *dev);
 
 extern int __pm_runtime_idle(struct device *dev, int rpmflags);
 extern int __pm_runtime_suspend(struct device *dev, int rpmflags);
@@ -257,9 +255,7 @@
 
 static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
 static inline int pm_generic_runtime_resume(struct device *dev) { return 0; }
-static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
 static inline int pm_runtime_force_suspend(struct device *dev) { return 0; }
-static inline int pm_runtime_force_resume(struct device *dev) { return 0; }
 
 static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
 {
@@ -330,6 +326,18 @@
 
 #endif /* !CONFIG_PM */
 
+#ifdef CONFIG_PM_SLEEP
+
+bool pm_runtime_need_not_resume(struct device *dev);
+int pm_runtime_force_resume(struct device *dev);
+
+#else /* !CONFIG_PM_SLEEP */
+
+static inline bool pm_runtime_need_not_resume(struct device *dev) {return true; }
+static inline int pm_runtime_force_resume(struct device *dev) { return -ENXIO; }
+
+#endif /* CONFIG_PM_SLEEP */
+
 /**
  * pm_runtime_idle - Conditionally set up autosuspend of a device or suspend it.
  * @dev: Target device.




