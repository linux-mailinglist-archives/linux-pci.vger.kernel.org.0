Return-Path: <linux-pci+bounces-30806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E05C9AEA51A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C783C567F09
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92E72EFD81;
	Thu, 26 Jun 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="nhCthqqc"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F322EF2B1;
	Thu, 26 Jun 2025 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961751; cv=none; b=bAr7/YzTeF6uqL1TQ89pcTvhMvmYIO87iddnQE56n8bsAFB/ReHYQxB4nCjgGwcpUeNj0Nt/wBe82vkk2m0usmgr/wcHkrEW+VALq0aqgjCOVJ+1OREqWRJBqMcLj0KMrYu8qvZwCRXZULlf1qZ2pgtm57DLEujKxaYYzNWNPlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961751; c=relaxed/simple;
	bh=PJrgWVYKWZ93M4KLNAshqneFdjWCJOCZsMnfHs8MpBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5LucY/igPiXhBVZF2/NK9vam4Jsq7xFO0Zjb5nEY9rSaFn5BwFYlpEH4nNq8oxsky4rMQQK12eMKfrs9ankhVYkKRhf8wfV6yR6Sii5PabhwRm/tpNzb659bSJ/dKu1Uik50f12e98CKoOL5q8l+FKLa2f1Y65FeiHDwv1qfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=nhCthqqc; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1358566E981;
	Thu, 26 Jun 2025 20:15:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961748;
	bh=PJrgWVYKWZ93M4KLNAshqneFdjWCJOCZsMnfHs8MpBw=;
	h=From:Subject:Date;
	b=nhCthqqc3r2FNyZeKy5bycJcttgqNs6a6Oe7X5ahA6A4y5QS/F2ciAI2uiTEbC5ri
	 IjBJMXvvLN9A595zFosMvcKy2n9XarXhSyPujX0KUak7I+H5qpi770hIVV6SzrcHT1
	 cuK8sVWqL9h9B03KiFNvMVwYURSbEX9aSf1QK9ftEz0C7bstsBaTad0YLZzCkYxIdq
	 lfEjzd8JVhDSqg9kjohbel/gtu2XespATIdjfeI9g6VFG48Np3KOZNMpbsPcM7hhTj
	 if1Ev3eD/WgXKB1d+kKYs7DkenmhxWiWqJfpT8oVdb/ggEtXkRU4tI0U3g5z0TE1Mc
	 AHhq63Gyu5niQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v2 3/9] PM: Move two sleep-related functions under CONFIG_PM_SLEEP
Date: Thu, 26 Jun 2025 20:01:29 +0200
Message-ID: <8567953.T7Z3S40VBb@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFa3M0f04p6hhLyiTVM7rZOcnSqOhT2amPzAoUQYOO+wQ5EdLo0jLcyIjI8b6ghCFqrfH/H49FBgk9zSNAmZVjVmEo/07TYi8hVwSs/HFwMJkisiIHnXAlt0cX8tuInKjbgKryqLCjuMExvs3KJn+fRxmENHGFMbcS2Tcy6P4n1FKBZM45bsYPgRuUUscncS4PHFOQM/6rWZzfskfwzXmJKW4NcLVfzCfST7CEFDH9kAJ1o5fdqYhz/o7TmfNYeiGZTNZ+2v02CFbhpDaX3YgEQq5iXsX6JqBuXRA8cqidHILuNucN2hqUJ/vYcWY0MAUe5nTWWds+DjqWriS8S5QNaINc8tHgxmD8VxhCtFJhjqhO8WT8/h4Cmt2zwWv010EW5Wx+3qR2eRXB0Z9OgwHYfomo7Gl/eCgeBgMJAQYuBv9+N+jCpFtdpRIkNRwBdelhW+NxizUBksxaVOOeYUMoPiFKWqClmc5u/oIkDe4GZYDYHpo1T1YWbBQfbS5IYwvQCDmN/31+ih8EIDqKZ/MYeLU5Ag76zMl3PJrbeEjavp5xHaRbF+kYu4QG4h098lSL0xFTyuxnxDKtmDcclR9t17a4BJyJtXu1O3Aw6XxsLc8GkgpRgh7DJSu58qlX/sY8D2z6J+b9KfFG9eGHaLQpJ6Ggv+txPci8FaoQQ0vlb4w
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since pm_runtime_force_resume() and pm_runtime_need_not_resume() are only
needed for handling system-wide PM transitions, there is no reason to
compile them in if CONFIG_PM_SLEEP is unset.

Accordingly, move them under CONFIG_PM_SLEEP and make the static
inline stub for pm_runtime_force_resume() return an error to indicate
that it should not be used outside CONFIG_PM_SLEEP.

Putting pm_runtime_force_resume() under CONFIG_PM_SLEEP also allows
subsequent changes to be more straightforward because this function is
going to access a device PM flag that is only defined when CONFIG_PM_SLEEP
is set.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

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




