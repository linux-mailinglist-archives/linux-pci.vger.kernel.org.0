Return-Path: <linux-pci+bounces-21760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62945A3A893
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 21:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A816FC2B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 20:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6D71C6FED;
	Tue, 18 Feb 2025 20:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="GYhb5TsL"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E121B9E1;
	Tue, 18 Feb 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910064; cv=none; b=WJz2HvZl4cYclZOERrAbtdTd21DviXYn0aASDM4k3LKshiyMF3JFe6HN7V/ntxWnSDDxr6NAkW41cYCjNgRzXeQKtelMLep9u4gWQD32lq//b9+znb1t0QWizHhxUXfgZci2V+jDkcRa0KeMrqOUgNzLiRmaFkEP4oxKP+vh1vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910064; c=relaxed/simple;
	bh=ehbbhur3xJOIzDNh17ILpSUkzLXRzagOxKu96FYhXDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5Oj4EGWDwO0uZysP1tqQIf1J9ovnDmFNObjYHZLs6PIuvLcAJEE0Dwnnjd+mlABKVt/Ur/yyhzi/xbRG+JdO//vUinuff/G82CnJo3A+d73SRnOKk4MnKzQrTfqq+JgDYBR1VGqD4/vFn2vcSICzWnCroo7LFoJPJpE4tZjtI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=GYhb5TsL; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id dd35bb12e63d55d5; Tue, 18 Feb 2025 21:20:54 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 70AD496554D;
	Tue, 18 Feb 2025 21:20:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739910054;
	bh=ehbbhur3xJOIzDNh17ILpSUkzLXRzagOxKu96FYhXDg=;
	h=From:Subject:Date;
	b=GYhb5TsLajwqp67HlS8mIaGrrupbIWs8tFGXBXvjlVFMolipIubG11CsMR10QjRSH
	 mD49f38fo80Hek1yrCqQ/+k6f+FSg4hcW2ThalqiuuJcIHCRep0csnRCBh4Dg2knk1
	 X7NM/NG9cYkWvR2HsAZRfrOzytExNfLPTzcr/dPOfheZkPe4gpkj1IWeC+z5z30Bxp
	 J99Ps+YdXfeSkshj+dogNYfLkF7+DC9p/l9/FFG1tdBMdmaiepyuF0Ddmy+297La58
	 kQ58qvjfje+2D3jCnYaKDXmtymfJJhJhSpPlhd/rtoAOroLiXpbsLZNTR+3NtYkQcA
	 A+xr7OKHvqK1A==
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
Subject: [PATCH v2 2/4] PM: runtime: Introduce pm_runtime_blocked()
Date: Tue, 18 Feb 2025 21:13:09 +0100
Message-ID: <4632087.LvFx2qVVIh@rjwysocki.net>
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

Introduce a new helper function called pm_runtime_blocked()
for checking the power.last_status value indicating whether or not
enabling runtime PM for the given device has been blocked (which
happens in the "prepare" phase of system-wide suspend if runtime
PM is disabled for the given device at that point).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

v1 -> v2: Add the R-by, no other changes.

---
 drivers/base/power/runtime.c |   17 +++++++++++++++++
 include/linux/pm_runtime.h   |    2 ++
 2 files changed, 19 insertions(+)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1555,6 +1555,23 @@
 }
 EXPORT_SYMBOL_GPL(pm_runtime_enable);
 
+bool pm_runtime_blocked(struct device *dev)
+{
+	bool ret;
+
+	/*
+	 * dev->power.last_status is a bit field, so in case it is updated via
+	 * RMW, read it under the spin lock.
+	 */
+	spin_lock_irq(&dev->power.lock);
+
+	ret = dev->power.last_status == RPM_BLOCKED;
+
+	spin_unlock_irq(&dev->power.lock);
+
+	return ret;
+}
+
 static void pm_runtime_disable_action(void *data)
 {
 	pm_runtime_dont_use_autosuspend(data);
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -81,6 +81,7 @@
 extern void pm_runtime_unblock(struct device *dev);
 extern void pm_runtime_enable(struct device *dev);
 extern void __pm_runtime_disable(struct device *dev, bool check_resume);
+extern bool pm_runtime_blocked(struct device *dev);
 extern void pm_runtime_allow(struct device *dev);
 extern void pm_runtime_forbid(struct device *dev);
 extern void pm_runtime_no_callbacks(struct device *dev);
@@ -277,6 +278,7 @@
 static inline void pm_runtime_unblock(struct device *dev) {}
 static inline void pm_runtime_enable(struct device *dev) {}
 static inline void __pm_runtime_disable(struct device *dev, bool c) {}
+static inline bool pm_runtime_blocked(struct device *dev) { return true; }
 static inline void pm_runtime_allow(struct device *dev) {}
 static inline void pm_runtime_forbid(struct device *dev) {}
 




