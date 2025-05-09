Return-Path: <linux-pci+bounces-27507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E28C4AB144B
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 15:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AF04C6531
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA51291176;
	Fri,  9 May 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="FuouKjOx"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E9015E96;
	Fri,  9 May 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795854; cv=none; b=ZysvIzWY3cSBIhgaRdF1m3cfjMX6mXwlHzaj6ndLqX1XnUjbUCCk1MEF2OiUmqhND1AbbVrNgTysT0DMBpX0unxtpWaTKS4cAZmoEDqp+mux9wa+k5zU0jwiNHSkZucsVsMAmpA6YZo301L7OtE5H0rJ6qDUfDNq3fcY1XI1q9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795854; c=relaxed/simple;
	bh=nnWev/U6mk3QsQ2rja9jL5cKPG13InXpkNQFhMAK3iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4mmivIoXpuRH0A14d+bYCibHwpQ0RniDQOq/+LCIORZWF3sAS7Ee2z5qHMxp2SOtMgntRrIpL4k83WytECvm1vSPBUcyD3nU7UPBNG7wNs8YiK6KIrLAruyvL+aZy9iyKgdqVKMj3hZcQf+1vd7EjGRXoBL6ptvMctNJWIv6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=FuouKjOx; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 69C06666CB4;
	Fri,  9 May 2025 15:04:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746795843;
	bh=nnWev/U6mk3QsQ2rja9jL5cKPG13InXpkNQFhMAK3iE=;
	h=From:Subject:Date;
	b=FuouKjOxm3JvSM8LnUfSs8dI44/XTTirlRNwQoSkt3RjKp+01YCUvTrtXg3C44OGb
	 2WZcZ1CinJ1U/vvo1uTjEJRfnzH7LuXx8bd1bSYxqpAm87uhDv/AkbNxn6PE478CwM
	 kXUvGR8XaCSzCB3/TQ9FC/2QcRvYxO1DeBIPH1cQ0v4UWz0XONONQrZZ2n2IW+xFoV
	 wI0DLsMKoTgNV8K4gmBbi9e1kF3eP3EvlunvZxoXjqX10w8nDXQHqnN+uP0eAxsqtZ
	 iFC3UBEwjAorh5nJ38TLz+Zec1AbUJWjhhHEhmCPIQCy9Ryaq2nzXWE6xGYaTUar7x
	 KGTHzOe5oWXEw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Linux PCI <linux-pci@vger.kernel.org>,
 x86 Maintainers <x86@kernel.org>, intel-xe@lists.freedesktop.org,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Thomas =?ISO-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v1 2/3] PM: sleep: Introduce pm_suspend_in_progress()
Date: Fri, 09 May 2025 15:02:27 +0200
Message-ID: <2020901.PYKUYFuaPT@rjwysocki.net>
In-Reply-To: <5903743.DvuYhMxLoT@rjwysocki.net>
References: <5903743.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppedvudejrdduudegrdefgedrudelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddujedruddugedrfeegrdduledphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomheprhhjfiesrhhjfiihshhotghkihdrnhgvthdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopehhvghlghgrrghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdh
X-DCC--Metrics: v370.home.net.pl 1024; Body=10 Fuz1=10 Fuz2=10

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Introduce pm_suspend_in_progress() to be used for checking if a system-
wide suspend or resume transition is in progress, instead of comparing
pm_suspend_target_state directly to PM_SUSPEND_ON, and use it where
applicable.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

The only change in this patch that depends in the [1/3] is in
kernel/power/main.c and it is not relevant for PCI/x86 and xe.

---
 arch/x86/pci/fixup.c        |    4 ++--
 drivers/base/power/wakeup.c |    2 +-
 drivers/gpu/drm/xe/xe_pm.c  |    2 +-
 include/linux/suspend.h     |    5 +++++
 kernel/power/main.c         |    4 ++--
 5 files changed, 11 insertions(+), 6 deletions(-)

--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -970,13 +970,13 @@
 	struct pci_dev *rp;
 
 	/*
-	 * PM_SUSPEND_ON means we're doing runtime suspend, which means
+	 * If system suspend is not in progress, we're doing runtime suspend, so
 	 * amd-pmc will not be involved so PMEs during D3 work as advertised.
 	 *
 	 * The PMEs *do* work if amd-pmc doesn't put the SoC in the hardware
 	 * sleep state, but we assume amd-pmc is always present.
 	 */
-	if (pm_suspend_target_state == PM_SUSPEND_ON)
+	if (!pm_suspend_in_progress())
 		return;
 
 	rp = pcie_find_root_port(dev);
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -337,7 +337,7 @@
 	if (!dev || !dev->power.can_wakeup)
 		return -EINVAL;
 
-	if (pm_suspend_target_state != PM_SUSPEND_ON)
+	if (pm_suspend_in_progress())
 		dev_dbg(dev, "Suspicious %s() during system transition!\n", __func__);
 
 	ws = wakeup_source_register(dev, dev_name(dev));
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -641,7 +641,7 @@
 
 	return dev->power.runtime_status == RPM_SUSPENDING ||
 		dev->power.runtime_status == RPM_RESUMING ||
-		pm_suspend_target_state != PM_SUSPEND_ON;
+		pm_suspend_in_progress();
 #else
 	return false;
 #endif
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -298,6 +298,11 @@
 static inline void s2idle_wake(void) {}
 #endif /* !CONFIG_SUSPEND */
 
+static inline bool pm_suspend_in_progress(void)
+{
+	return pm_suspend_target_state != PM_SUSPEND_ON;
+}
+
 /* struct pbe is used for creating lists of pages that should be restored
  * atomically during the resume from disk, because the page frames they have
  * occupied before the suspend are in use.
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -613,8 +613,8 @@
 
 bool pm_debug_messages_should_print(void)
 {
-	return pm_debug_messages_on && (hibernation_in_progress() ||
-		pm_suspend_target_state != PM_SUSPEND_ON);
+	return pm_debug_messages_on && (pm_suspend_in_progress() ||
+		hibernation_in_progress());
 }
 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 




