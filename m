Return-Path: <linux-pci+bounces-21758-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD9A3A88D
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 21:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1481890222
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 20:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489111BE23F;
	Tue, 18 Feb 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="H4334Tr1"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BB21B9E0;
	Tue, 18 Feb 2025 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910064; cv=none; b=Zu5p1FXzXPL1ITlUbynDzFV4OmZn+fE64pqD2AWYgn3x3TvbaC8yD4S/Uo99ho9SO74GN5zRNyqSXTAzsqR5YMovmxAijbNBxZnIUVP771P3ohEeXnJdTDaMAkN32BGxEEhThQrEK7gbpxhfYMnv5Uy1L1DCkiLxScFKdqaJaAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910064; c=relaxed/simple;
	bh=Mi0yeJ0NG7Wggqky6pV4DEQsB94EDemrjJ+/gmx9XZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+BC+pqoZLUA4Pdwh9vW0b5ZBuHO8racwE/PaegqrhhVEu3a2VOLqxt3gkkBwVdKZV67WnSxn0qosY7bxjj+oHm9KIR/Ua180A+KfFRjK9BODVD3FiX6y0jvjDqXr7/cPKlnuVQ4CVUhhdah7e2Bx/svfsbk7ptp8pdsF9H1GmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=H4334Tr1; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4976fd652ffeded7; Tue, 18 Feb 2025 21:20:52 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 8283696554D;
	Tue, 18 Feb 2025 21:20:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739910052;
	bh=Mi0yeJ0NG7Wggqky6pV4DEQsB94EDemrjJ+/gmx9XZY=;
	h=From:Subject:Date;
	b=H4334Tr1mb6uz+bPzXNEwdkp3mwIlrK0St12WEBqEIygqXylgoeXIPeGgmQBfDTE1
	 EIS/mbwrd8cfnzaJZcYvA8SBCluludgvAZxPJoB/JH3MMGPmvvfOejxysg8aB0Ri8G
	 jRhnCQorZkjzZ99NFmNsXPEiLXomoQvkXkKJMNmjVP4ISlohMA0zlxvagtt+6BLv36
	 vVfL9j3w4mE88vBnXjmYnkYwYekEfAaGGCQm0pjcTMysZATXWwM7Bs1AvsXsYLwyPd
	 bMLRp9Bj6+y53eZFT0iR6lscDgwB3BkdkPIURxU8uat1J9c665xMhscsFBOnGtsHN4
	 gQwlJjmucMJJg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jon Hunter <jonathanh@nvidia.com>, Linux ACPI <linux-acpi@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject:
 [PATCH v2 4/4] PM: sleep: Avoid unnecessary checks in
 device_prepare_smart_suspend()
Date: Tue, 18 Feb 2025 21:20:46 +0100
Message-ID: <2978873.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <12612706.O9o76ZdvQC@rjwysocki.net>
References: <12612706.O9o76ZdvQC@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an optimization (on top of previous changes) to avoid calling
pm_runtime_blocked(), which involves acquiring the device's PM spinlock,
for devices with no PM callbacks and runtime PM "blocked".

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c    |   16 +++++++++-------
 drivers/base/power/runtime.c |    9 +++++++--
 include/linux/pm_runtime.h   |    4 ++--
 3 files changed, 18 insertions(+), 11 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1796,16 +1796,14 @@
 
 	/*
 	 * The "smart suspend" feature is enabled for devices whose drivers ask
-	 * for it and for devices without PM callbacks unless runtime PM is
-	 * disabled and enabling it is blocked for them.
+	 * for it and for devices without PM callbacks.
 	 *
 	 * However, if "smart suspend" is not enabled for the device's parent
 	 * or any of its suppliers that take runtime PM into account, it cannot
 	 * be enabled for the device either.
 	 */
-	dev->power.smart_suspend = (dev->power.no_pm_callbacks ||
-		dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) &&
-		!pm_runtime_blocked(dev);
+	dev->power.smart_suspend = dev->power.no_pm_callbacks ||
+		dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
 
 	if (!dev_pm_smart_suspend(dev))
 		return;
@@ -1843,6 +1841,7 @@
 static int device_prepare(struct device *dev, pm_message_t state)
 {
 	int (*callback)(struct device *) = NULL;
+	bool no_runtime_pm;
 	int ret = 0;
 
 	/*
@@ -1858,7 +1857,7 @@
 	 * suspend-resume cycle is complete, so prepare to trigger a warning on
 	 * subsequent attempts to enable it.
 	 */
-	pm_runtime_block_if_disabled(dev);
+	no_runtime_pm = pm_runtime_block_if_disabled(dev);
 
 	if (dev->power.syscore)
 		return 0;
@@ -1893,7 +1892,10 @@
 		pm_runtime_put(dev);
 		return ret;
 	}
-	device_prepare_smart_suspend(dev);
+	/* Do not enable "smart suspend" for devices without runtime PM. */
+	if (!no_runtime_pm)
+		device_prepare_smart_suspend(dev);
+
 	/*
 	 * A positive return value from ->prepare() means "this device appears
 	 * to be runtime-suspended and its state is fine, so if it really is
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1460,14 +1460,19 @@
 }
 EXPORT_SYMBOL_GPL(pm_runtime_barrier);
 
-void pm_runtime_block_if_disabled(struct device *dev)
+bool pm_runtime_block_if_disabled(struct device *dev)
 {
+	bool ret;
+
 	spin_lock_irq(&dev->power.lock);
 
-	if (dev->power.disable_depth && dev->power.last_status == RPM_INVALID)
+	ret = dev->power.disable_depth && dev->power.last_status == RPM_INVALID;
+	if (ret)
 		dev->power.last_status = RPM_BLOCKED;
 
 	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
 }
 
 void pm_runtime_unblock(struct device *dev)
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -77,7 +77,7 @@
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
-extern void pm_runtime_block_if_disabled(struct device *dev);
+extern bool pm_runtime_block_if_disabled(struct device *dev);
 extern void pm_runtime_unblock(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
@@ -274,7 +274,7 @@
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
-static inline void pm_runtime_block_if_disabled(struct device *dev) {}
+static inline bool pm_runtime_block_if_disabled(struct device *dev) { return true; }
 static inline void pm_runtime_unblock(struct device *dev) {}
 static inline void pm_runtime_enable(struct device *dev) {}
 static inline void __pm_runtime_disable(struct device *dev, bool c) {}




