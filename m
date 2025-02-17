Return-Path: <linux-pci+bounces-21673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB7A38D25
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 21:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711E83B2E58
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C523908B;
	Mon, 17 Feb 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="pdu7kBJX"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5C2376F9;
	Mon, 17 Feb 2025 20:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823604; cv=none; b=NAAL/+5rsHHe0F+pHOLz6dMpS1/XTPoQrSSoeePzxPb/iSaikh4apwFrmPawNEMWq64n9aL/0qOAA+P1njzxXh5rwkBd5w2YnRVsy50X6xFFvws4En9A6xqKhjSAorTczHNHvY9uyqZrcIyo9T4PLdoGr4878d6w1FL66QNwF74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823604; c=relaxed/simple;
	bh=/iN7NRf7A6v8rajbgsWwV6unFpcBInCBdNQmcN5sn98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a44kHuHh139pDmTpvjgyWPdrf/KcB7BIX5E9gYYt+Tro4sOWlLx+kNmCXB792qVy8NssbtjmS9pFjWTUDpZyC74qAI9+OFQwkPXYR7HumB/8EfwTUWA4hGiFQzJYVib3ckj10NE0ch9WTkmoGmDIJW20g8qApJuuLTL+2m72KTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=pdu7kBJX; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 4129ec6773cf2060; Mon, 17 Feb 2025 21:20:00 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id B76299100B0;
	Mon, 17 Feb 2025 21:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739823600;
	bh=/iN7NRf7A6v8rajbgsWwV6unFpcBInCBdNQmcN5sn98=;
	h=From:Subject:Date;
	b=pdu7kBJXCAr60bE0mTtX8JmIksI/Ay4kXuBzLJVR4q7FMRgF3znZ5qbyayUkmTBat
	 RIU5k6QATHm0HCwr+adXns9tLpdISN7Ql6PCnuruQylpsDEAFIUDtCWycc9bDf0GPq
	 Bbfa3wnE1KMml+e5l8LjmiOAiC9+F//IOL7Ozz4f7EAIGyOWtlv2CKp/fUqVVwxhHN
	 wVKZgcvci+5NN3QQ9Sct1jla+FSfV2MrLH9cjUhvLixKQHLsqjSq+Rv9KyRGllSt7d
	 L/DqUjpuKXtIIQS7WNgSA2haWd0Sd+VJL4Qx8lohYDEMa3FiiOYMqoLpDykiUCV+Ls
	 Hdn1eaIgSYAiw==
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
Subject: [PATCH v1 1/3] PM: Block enabling of runtime PM during system suspend
Date: Mon, 17 Feb 2025 21:14:19 +0100
Message-ID: <2984234.e9J7NaK4W3@rjwysocki.net>
In-Reply-To: <4966939.GXAFRqVoOG@rjwysocki.net>
References: <4966939.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehleefgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If device_prepare() runs on a device that has never had runtime
PM enabled so far, it may reasonably assume that runtime PM will
not be enabled for that device during the system suspend-resume
cycle currently in progress, but this has never been guaranteed.

To verify this assumption, make device_prepare() arrange for
triggering a device warning accompanied by a call trace dump if
runtime PM is enabled for such a device after it has returned.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c    |    9 +++++++++
 drivers/base/power/runtime.c |   24 ++++++++++++++++++++++++
 include/linux/pm.h           |    1 +
 include/linux/pm_runtime.h   |    6 +++++-
 4 files changed, 39 insertions(+), 1 deletion(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1109,6 +1109,8 @@
 	device_unlock(dev);
 
 out:
+	/* If enabling runtime PM for the device is blocked, unblock it. */
+	pm_runtime_unblock(dev);
 	pm_runtime_put(dev);
 }
 
@@ -1815,6 +1817,13 @@
 	 * it again during the complete phase.
 	 */
 	pm_runtime_get_noresume(dev);
+	/*
+	 * If runtime PM is disabled for the device at this point and it has
+	 * never been enabled so far, it should not be enabled until this system
+	 * suspend-resume cycle is complete, so prepare to trigger a warning on
+	 * subsequent attempts to enable it.
+	 */
+	pm_runtime_block_if_disabled(dev);
 
 	if (dev->power.syscore)
 		return 0;
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1460,6 +1460,26 @@
 }
 EXPORT_SYMBOL_GPL(pm_runtime_barrier);
 
+void pm_runtime_block_if_disabled(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+
+	if (dev->power.disable_depth && dev->power.last_status == RPM_INVALID)
+		dev->power.last_status = RPM_BLOCKED;
+
+	spin_unlock_irq(&dev->power.lock);
+}
+
+void pm_runtime_unblock(struct device *dev)
+{
+	spin_lock_irq(&dev->power.lock);
+
+	if (dev->power.last_status == RPM_BLOCKED)
+		dev->power.last_status = RPM_INVALID;
+
+	spin_unlock_irq(&dev->power.lock);
+}
+
 void __pm_runtime_disable(struct device *dev, bool check_resume)
 {
 	spin_lock_irq(&dev->power.lock);
@@ -1518,6 +1538,10 @@
 	if (--dev->power.disable_depth > 0)
 		goto out;
 
+	if (dev->power.last_status == RPM_BLOCKED) {
+		dev_warn(dev, "Attempt to enabled runtime PM when it is blocked\n");
+		dump_stack();
+	}
 	dev->power.last_status = RPM_INVALID;
 	dev->power.accounting_timestamp = ktime_get_mono_fast_ns();
 
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -597,6 +597,7 @@
 	RPM_RESUMING,
 	RPM_SUSPENDED,
 	RPM_SUSPENDING,
+	RPM_BLOCKED,
 };
 
 /*
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -77,8 +77,10 @@
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
+extern void pm_runtime_block_if_disabled(struct device *dev);
+extern void pm_runtime_unblock(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
-extern void __pm_runtime_disable(struct device *dev, bool check_resume);
+extern void __pm_runtime_disable(struct device *dev, bool regular);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
@@ -271,6 +273,8 @@
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
+static inline void pm_runtime_block_if_disabled(struct device *dev) {}
+static inline void pm_runtime_unblock(struct device *dev) {}
 static inline void pm_runtime_enable(struct device *dev) {}
 static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}




