Return-Path: <linux-pci+bounces-21031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7599BA2D7DF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 18:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089F7167195
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2025 17:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D95C190665;
	Sat,  8 Feb 2025 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="CH4YCom1"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8B241103;
	Sat,  8 Feb 2025 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739037280; cv=none; b=EvJzfg3gVNEepqGxBkAuZ3mOUrNPDZdM2+4cYbFt/uP/O56b0LlxM2lnIMbtiT4WMplETM6zNBQSsZ1qqit1b+qGvwqB+FmPOEbEC6KcL9oI4wv12SDjR57tmYA1brx9cElTnHYvyPVKuytdy8hkERVV0bml46uuO2WmjqoQHCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739037280; c=relaxed/simple;
	bh=osB0eZEerqD0Z2PkEFhT54AKRNrkP7WKvuM52SiXxw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E1Yygk91EceHms9AoeORclvpX1FvNwHpGBoa3irTkpPy7bZYD7G6uhFUVW4h95+yFuf3GZyCS0yBEoRMGcxIuRLXzwY+PcrAVGCoQGEo/QkS/MPQiN8m9TnMymZG7mbZmZhA4Wh7kT1KpLj9vERUKmJfSXfajos19hLVYqkzgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=CH4YCom1; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.1)
 id 8adf9df2f880b954; Sat, 8 Feb 2025 18:54:28 +0100
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5DB576B8D61;
	Sat,  8 Feb 2025 18:54:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1739037268;
	bh=osB0eZEerqD0Z2PkEFhT54AKRNrkP7WKvuM52SiXxw4=;
	h=From:Subject:Date;
	b=CH4YCom1GM3oRXIWfFQUe2sOEm2Kks+CmgiBE8SvWe+asGgcWSLJIyjZtlbr6Kbfv
	 iAdYoGJNXR998mQDhdwgoijY6VYVqdyqOqS+W9CuWIgljarVNCJC5a33HYC7ErkKmq
	 /RTkDa39VQf3F9jg2pZy2bMPtbSObYQSYXJgS2Wi1PISQwz4Y9olxij8e6BgFpv+R0
	 bAylHBCAVF8iTsrMDfFDG5cAHWyAxK/CdBirAeKLBK3myE4lx2cvUXhF6aktxeSX9u
	 CRETibjCS10G30WviNQN5S2tGjNpw3i/sN4xm/CkOSc15kWM5Ck6c8icT8f5GRzCCN
	 9ThtogxkPUqYQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Bjorn Helgaas <helgaas@kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Johan Hovold <johan@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Kevin Xie <kevin.xie@starfivetech.com>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v1] PM: sleep: core: Restrict power.set_active propagation
Date: Sat, 08 Feb 2025 18:54:28 +0100
Message-ID: <6137505.lOV4Wx5bFT@rjwysocki.net>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvdekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeegfffhudejlefhtdegffekteduhfethffhieettefhkeevgfdvgfefieekiefgheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtvghrnhesrhhofihlrghnugdrhhgrrhhvrghrugdrvgguuhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of
parents and children") exposed an issue related to simple_pm_bus_pm_ops
that uses pm_runtime_force_suspend() and pm_runtime_force_resume() as
bus type PM callbacks for the noirq phases of system-wide suspend and
resume.

The problem is that pm_runtime_force_suspend() does not distinguish
runtime-suspended devices from devices for which runtime PM has never
been enabled, so if it sees a device with runtime PM status set to
RPM_ACTIVE, it will assume that runtime PM is enabled for that device
and so it will attempt to suspend it with the help of its runtime PM
callbacks which may not be ready for that.  As it turns out, this 
causes simple_pm_bus_runtime_suspend() to crash due to a NULL pointer
dereference.

Another problem related to the above commit and simple_pm_bus_pm_ops is
that setting runtime PM status of a device handled by the latter to
RPM_ACTIVE will actually prevent it from being resumed because
pm_runtime_force_resume() only resumes devices with runtime PM status
set to RPM_SUSPENDED.

To mitigate these issues, do not allow power.set_active to propagate
beyond the parent of the device with DPM_FLAG_SMART_SUSPEND set that
will need to be resumed, which should be a sufficient stop-gap for the
time being, but they will need to be properly addressed in the future
because in general during system-wide resume it is necessary to resume
all devices in a dependency chain in which at least one device is going
to be resumed.

Fixes: 3775fc538f53 ("PM: sleep: core: Synchronize runtime PM status of parents and children")
Closes: https://lore.kernel.org/linux-pm/1c2433d4-7e0f-4395-b841-b8eac7c25651@nvidia.com/
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1191,24 +1191,18 @@
 	return PMSG_ON;
 }
 
-static void dpm_superior_set_must_resume(struct device *dev, bool set_active)
+static void dpm_superior_set_must_resume(struct device *dev)
 {
 	struct device_link *link;
 	int idx;
 
-	if (dev->parent) {
+	if (dev->parent)
 		dev->parent->power.must_resume = true;
-		if (set_active)
-			dev->parent->power.set_active = true;
-	}
 
 	idx = device_links_read_lock();
 
-	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node) {
+	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
 		link->supplier->power.must_resume = true;
-		if (set_active)
-			link->supplier->power.set_active = true;
-	}
 
 	device_links_read_unlock(idx);
 }
@@ -1287,9 +1281,12 @@
 		dev->power.must_resume = true;
 
 	if (dev->power.must_resume) {
-		dev->power.set_active = dev->power.set_active ||
-			dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND);
-		dpm_superior_set_must_resume(dev, dev->power.set_active);
+		if (dev_pm_test_driver_flags(dev, DPM_FLAG_SMART_SUSPEND)) {
+			dev->power.set_active = true;
+			if (dev->parent && !dev->parent->power.ignore_children)
+				dev->parent->power.set_active = true;
+		}
+		dpm_superior_set_must_resume(dev);
 	}
 
 Complete:




