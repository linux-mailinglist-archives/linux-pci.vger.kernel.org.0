Return-Path: <linux-pci+bounces-21672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9242FA38D21
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 21:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3935E16E51B
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 20:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C079239066;
	Mon, 17 Feb 2025 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cpEFtdSX"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47D219A8A;
	Mon, 17 Feb 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823604; cv=none; b=F5hFKCM3B8PrI1jgZx1XHWbuz1msjy5DI/JWmKz76FmkMRD72hQH8yyeGWmnBIY6RK6GbEDdTV06/NK3Q5pFILvR0R7z0juM4IczgwGQ666RdXsklQHCdhV/zSVJ5dpsmLo/B1QeA1ckquQQHuRs608S+ZWxLkp1gFKrXoDGLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823604; c=relaxed/simple;
	bh=VGPxZ+UZjJjw8SEv0KgowUz43qF+U/wYeXYgZBnh1kc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFTcSv3+HL7EPXxFvGrb+FesErgE+L5nrXOkRwWVyCApB88jEQxON/qlU4IMeyy0L/b3sZg5+SGRlLJBjes5adUkac3+YEzGC7SZtrVCwpcrLdCBB0PQ2BFqsYhKtHPesJ/nCKAczQ76491Q5vRCa0D2u9GC+3EK5swqf9iIO44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cpEFtdSX; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 2a51783161226919; Mon, 17 Feb 2025 21:19:59 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D891A9100B0;
	Mon, 17 Feb 2025 21:19:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739823599;
	bh=VGPxZ+UZjJjw8SEv0KgowUz43qF+U/wYeXYgZBnh1kc=;
	h=From:Subject:Date;
	b=cpEFtdSXfOtC8SqUKToccmhl9nwVkQvr2n9gMzI7Yl71Om8FHLEQ/n4hJU9hbaRBq
	 pAy9eCqWwbRtmly/16tayNc8gYGDCq2GW/QH/nl7nnQ4QAr9BOl2XwaZNv6qTwRyRj
	 VAIZVaysGNoHoNRFCbk2mKwZekQxzKf+ZUv4M1w72W7MV+u1KnI/UAv9Tq+i4TM+oM
	 nQjw4/0qFm+nMRdc7cDn5bm5p8TNl1gipeQRwR6M8X1OfIt5NNcED/3o47uRT6ST08
	 8k9fg+SkbNjy2NvALALZKVH/hmX8iC/LHHjrO54G/iMlxHpEhErpQoovUDgM9lCWX5
	 Q9DGCfRPocqNQ==
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
Subject: [PATCH v1 2/3] PM: runtime: Introduce pm_runtime_blocked()
Date: Mon, 17 Feb 2025 21:16:43 +0100
Message-ID: <8497121.T7Z3S40VBb@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehleefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihesvhhgvghrrdhkvghrnhgvlhdrohh
X-DCC--Metrics: v370.home.net.pl 1024; Body=12 Fuz1=12 Fuz2=12

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce a new helper function called pm_runtime_blocked() for
checking the power.last_status value indicating whether or not the
enabling of runtime PM for the given device has been blocked (which
happens in the "prepare" phase of system-wide suspend if runtime
PM is disabled for the given device at that point and has never
been enabled so far).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
 extern void __pm_runtime_disable(struct device *dev, bool regular);
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
 




