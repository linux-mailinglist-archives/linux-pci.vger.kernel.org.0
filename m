Return-Path: <linux-pci+bounces-21761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8BA3A897
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C53018908AC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653F81CEAA3;
	Tue, 18 Feb 2025 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="g7OzTkKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ACD1B87F2;
	Tue, 18 Feb 2025 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910065; cv=none; b=FWSV8Cd1L3PduFs01d5ig2iL75cR7gTcKVtGpkuCMMtPkPH9pUdci8SRLLvx2jA1ktbCqpMSq85eUOcBa9NMzeJw/EGKp/0WQXSSyrky8oSBfCvWCJJ9elKYTWcAcNO85beM9BBLTwqpyv7/T/UZe1qLpYyE7bzcFgs1/tknY3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910065; c=relaxed/simple;
	bh=IAYZ73oZUjA3Og3NA7vq+SF9k6/cmTVsArqXa/W4RBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sw/XK1A+puLyERqjt3M4eGFqzmuUjhCRw92kQXxprHwy2Wbkik60eiGsBkijHu7AqbRbUoScQZzvmEf+JORAqdeBYrHLSgFBd+odYRazbIZifn1xKzpuyjhm+ZySS+fwHnSsJhIY3jektrDCzse2cYzWe+SUbt0oZvAwZkDAKGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=g7OzTkKK; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id b4a096f98544a87d; Tue, 18 Feb 2025 21:20:54 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 4AEB396554D;
	Tue, 18 Feb 2025 21:20:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739910054;
	bh=IAYZ73oZUjA3Og3NA7vq+SF9k6/cmTVsArqXa/W4RBg=;
	h=From:Subject:Date;
	b=g7OzTkKKczDQpO+8x7rcbb2mDSPy8F6kHTree/aSre+R1fS3zi6ozwz2OEtVp2ZBH
	 z0PC7t6hgKQHcvaT4jYEvCAtk5oV/RIEjM59bLMFg5IIOyDQTzn58+5BTJV5E5fxmp
	 Hr2xYJQukpzRuuUjJMQPj5059I+ysSIzin+bXE6VsbINYA0FEcL9ijyHnIVOjbPSxk
	 MPXirI7tSq7k9ib/MNw/OQD7wbSU2g89GKYqnVYMM5TQQeVzDu7Fl0pqpaJy3RsKXE
	 RfldoFTZcTb54KYu2f7LHOy/LDRo3ZusanLxV5RQS2b9hmWxNynXT4SJa7AU9TSNxL
	 IZBrFSh6R8C6A==
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
Subject: [PATCH v2 1/4] PM: Block enabling of runtime PM during system suspend
Date: Tue, 18 Feb 2025 21:11:42 +0100
Message-ID: <6131109.lOV4Wx5bFT@rjwysocki.net>
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

If device_prepare() runs on a device that has never had runtime
PM enabled so far, it may reasonably assume that runtime PM will
not be enabled for that device during the system suspend-resume
cycle currently in progress, but this has never been guaranteed.

To verify this assumption, make device_prepare() arrange for
triggering a device warning accompanied by a call trace dump if
runtime PM is enabled for such a device after it has returned.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

v1 -> v2: Fix a typo in a message and remove an unrelated change (Ulf).

---
 drivers/base/power/main.c    |    9 +++++++++
 drivers/base/power/runtime.c |   24 ++++++++++++++++++++++++
 include/linux/pm.h           |    1 +
 include/linux/pm_runtime.h   |    4 ++++
 4 files changed, 38 insertions(+)

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
+		dev_warn(dev, "Attempt to enable runtime PM when it is blocked\n");
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
@@ -77,6 +77,8 @@
 extern int pm_schedule_suspend(struct device *dev, unsigned int delay);
 extern int __pm_runtime_set_status(struct device *dev, unsigned int status);
 extern int pm_runtime_barrier(struct device *dev);
+extern void pm_runtime_block_if_disabled(struct device *dev);
+extern void pm_runtime_unblock(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
 extern void pm_runtime_allow(struct device *dev);
@@ -271,6 +273,8 @@
 static inline int __pm_runtime_set_status(struct device *dev,
 					    unsigned int status) { return 0; }
 static inline int pm_runtime_barrier(struct device *dev) { return 0; }
+static inline void pm_runtime_block_if_disabled(struct device *dev) {}
+static inline void pm_runtime_unblock(struct device *dev) {}
 static inline void pm_runtime_enable(struct device *dev) {}
 static inline void __pm_runtime_disable(struct device *dev, bool c) {}
 static inline void pm_runtime_allow(struct device *dev) {}




