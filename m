Return-Path: <linux-pci+bounces-20499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 696D3A2122A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 20:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 016E63A664B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AE31D61B1;
	Tue, 28 Jan 2025 19:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="BRQeWsY1"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CA01E1A16;
	Tue, 28 Jan 2025 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738092294; cv=none; b=ECxaEcNLoy8xeFLBkZViPqX8UTN/GjYd+RTD4a3MZpNqGnz2N9ZHksM9T8LdlczDJV8PsePRdcgM+OLCSlIRyUzk9zl17hP/4w0QGcN/ITDO+h/Y/iAuJ/8NHBauEU7UWjkN9dhF3HKdyxTEazJSOi65Txbya+SmxAMgXnL4cNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738092294; c=relaxed/simple;
	bh=0/zwL7RIh3wh/UroJ77L3c3Pm+GTkDsiRNFuxhryXo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXRDGcEw4qS2uI2e9cQv/ozJRgWCKtUY8LiJepw1Gw15Csf6WUIYLP9HOfY3HSEoegUTN3Z/YPMWU3J8o8dNQY+zrquzxdZNDWkzXfR/c1J0d4w0eGg7uABC4yGFoq68futFobtIO75V/1pFoRUKNQCgWxTE/ty5tkrbi/qx+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=BRQeWsY1; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id ae53d34fe11408ef; Tue, 28 Jan 2025 20:24:43 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 253EB8A2CB3;
	Tue, 28 Jan 2025 20:24:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1738092283;
	bh=0/zwL7RIh3wh/UroJ77L3c3Pm+GTkDsiRNFuxhryXo8=;
	h=From:Subject:Date;
	b=BRQeWsY1mVefj8qwg8ylVXqsKHdSrI2zogJ1ARFYsO6aeKiJLnCYJS9li9Y+Adc0L
	 oYZRl3ua5kn+Snrazz98a+Q30ARBJovRW8Req/4PSo1Z1h2xeFep0iPM2iaeKTTcNY
	 SSDUlrshb2tBnr9DxenhHITxwOjQ8UafUwZoiKUFNdOPoI8uqz0tf1AJq7N+3tRKkT
	 ZIOsJOeFVW1zvj3DGu69A3B6UKTOYbNovMLT3WvqzEd8r8FRivc/ZIox+osp5XsVkh
	 SiaofaDppG72IKHtxhP9SgX0z1NTO1SLSMA23GBwyevnKc3EVxNhUGoMrbz0ZHxlC1
	 i7ygEJdLeHbRA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kevin Xie <kevin.xie@starfivetech.com>
Subject:
 [PATCH v1] PM: sleep: core: Synchronize runtime PM status of parents and
 children
Date: Tue, 28 Jan 2025 20:24:41 +0100
Message-ID: <12619233.O9o76ZdvQC@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepledprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrhhnsehrohiflhgrnhgurdhhrghrvhgrrhgurdgvughupdhrtghpthhtohephhgvlhhgrggrsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphgtihe
X-DCC--Metrics: v370.home.net.pl 1024; Body=9 Fuz1=9 Fuz2=9

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the
resume phase") overlooked the case in which the parent of a device with
DPM_FLAG_SMART_SUSPEND set did not use that flag and could be runtime-
suspended before a transition into a system-wide sleep state.  In that
case, if the child is resumed during the subsequent transition from
that state into the working state, its runtime PM status will be set to
RPM_ACTIVE, but the runtime PM status of the parent will not be updated
accordingly, even though the parent will be resumed too, because of the
dev_pm_skip_suspend() check in device_resume_noirq().

Address this problem by tracking the need to set the runtime PM status
to RPM_ACTIVE during system-wide resume transitions for devices with
DPM_FLAG_SMART_SUSPEND set and all of the devices depended on by them.

Fixes: 6e176bf8d461 ("PM: sleep: core: Do not skip callbacks in the resume phase")
Closes: https://lore.kernel.org/linux-pm/Z30p2Etwf3F2AUvD@hovoldconsulting.com/
Reported-by: Johan Hovold <johan@kernel.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   29 ++++++++++++++++++++---------
 include/linux/pm.h        |    1 +
 2 files changed, 21 insertions(+), 9 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -656,13 +656,15 @@
 	 * so change its status accordingly.
 	 *
 	 * Otherwise, the device is going to be resumed, so set its PM-runtime
-	 * status to "active", but do that only if DPM_FLAG_SMART_SUSPEND is set
-	 * to avoid confusing drivers that don't use it.
+	 * status to "active" unless its power.set_active flag is clear, in
+	 * which case it is not necessary to update its PM-runtime status.
 	 */
-	if (skip_resume)
+	if (skip_resume) {
 		pm_runtime_set_suspended(dev);
-	else if (dev_pm_skip_suspend(dev))
+	} else if (dev->power.set_active) {
 		pm_runtime_set_active(dev);
+		dev->power.set_active = false;
+	}
 
 	if (dev->pm_domain) {
 		info = "noirq power domain ";
@@ -1189,18 +1191,24 @@
 	return PMSG_ON;
 }
 
-static void dpm_superior_set_must_resume(struct device *dev)
+static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
 {
 	struct device_link *link;
 	int idx;
 
-	if (dev->parent)
+	if (dev->parent) {
 		dev->parent->power.must_resume = true;
+		if (set_active)
+			dev->parent->power.set_active = true;
+	}
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
 		link->supplier->power.must_resume = true;
+		if (set_active)
+			link->supplier->power.set_active = true;
+	}
 
 	device_links_read_unlock(idx);
 }
@@ -1278,8 +1286,11 @@
 	      dev->power.may_skip_resume))
 		dev->power.must_resume = true;
 
-	if (dev->power.must_resume)
-		dpm_superior_set_must_resume(dev);
+	if (dev->power.must_resume) {
+		dev->power.set_active = dev->power.set_active ||
+			dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
+		dpm_superior_set_must_resume(dev, dev->power.set_active);
+	}
 
 Complete:
 	complete_all(&dev->power.completion);
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -683,6 +683,7 @@
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
 	bool			async_in_progress:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
+	bool			set_active:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
 #else
 	bool			should_wakeup:1;




