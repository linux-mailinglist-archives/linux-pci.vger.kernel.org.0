Return-Path: <linux-pci+bounces-41590-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B04CBC6D951
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 10:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D3374F8ADC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB2732F745;
	Wed, 19 Nov 2025 08:59:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F2B32F742;
	Wed, 19 Nov 2025 08:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542740; cv=none; b=IiQCyz0KmDpXV5DUSfS5+Cx1USTqPxgenIkvoFipOymMzTWMIZinvkFftWutfxOGfQ1zJz5UIWjhc0/vUTDFdNKb2pJ6Az+jfGEgB7w/l118wNxdCAc2+6KV5ERwlpojbU+6I8Nf0VttrFB7Et++JlPIAszBXgPpNNOt/rvgc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542740; c=relaxed/simple;
	bh=pmzNbhnerjQ6nTAtpcMY6dtHILNg80J3lOP1vhbuUhM=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=py7YJOXy4TGyy6LZ5S+9gRGfrfFVZtNtvqIrVyEvih6vW/8hWY1fQr7Wq3pwMjfOybd+ms6jGlhUwN1M5kDQ7nTL3sCcV3FTpJNSdqMoZm3w1BhJ09Dl2O1/KA9AaT2EeptjXqWWn+Sy6Din6USdegkOWbsRMvQcnCTA8kl9IaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 5F1E02C000B0;
	Wed, 19 Nov 2025 09:58:56 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 36BA4D5EC; Wed, 19 Nov 2025 09:58:56 +0100 (CET)
Message-ID: <094f2aad64418710daf0940112abe5a0afdc6bce.1763483367.git.lukas@wunner.de>
In-Reply-To: <cover.1763483367.git.lukas@wunner.de>
References: <cover.1763483367.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 19 Nov 2025 09:50:01 +0100
Subject: [PATCH v2 1/3] PCI/PM: Reinstate clearing state_saved in legacy and
 !pm codepaths
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When a PCI device is suspended, it is normally the PCI core's job to save
Config Space and put the device into a low power state.  However drivers
are allowed to assume these responsibilities.  When they do, the PCI core
can tell by looking at the state_saved flag in struct pci_dev:  The flag
is cleared before commencing the suspend sequence and it is set when
pci_save_state() is called.  If the PCI core finds the flag set late in
the suspend sequence, it refrains from calling pci_save_state() itself.

But there are two corner cases where the PCI core neglects to clear the
flag before commencing the suspend sequence:

* If a driver has legacy PCI PM callbacks, pci_legacy_suspend() neglects
  to clear the flag.  The (stale) flag is subsequently queried by
  pci_legacy_suspend() itself and pci_legacy_suspend_late().

* If a device has no driver or its driver has no PCI PM callbacks,
  pci_pm_freeze() neglects to clear the flag.  The (stale) flag is
  subsequently queried by pci_pm_freeze_noirq().

The flag may be set prior to suspend if the device went through error
recovery:  Drivers commonly invoke pci_restore_state() + pci_save_state()
to restore Config Space after reset.

The flag may also be set if drivers call pci_save_state() on probe to
allow for recovery from subsequent errors.

The result is that pci_legacy_suspend_late() and pci_pm_freeze_noirq()
don't call pci_save_state() and so the state that will be restored on
resume is the one recorded on last error recovery or on probe, not the one
that the device had on suspend.  If the two states happen to be identical,
there's no problem.

Reinstate clearing the flag in pci_legacy_suspend() and pci_pm_freeze().
The two functions used to do that until commit 4b77b0a2ba27 ("PCI: Clear
saved_state after the state has been restored") deemed it unnecessary
because it assumed that it's sufficient to clear the flag on resume in
pci_restore_state().  The commit seemingly did not take into account that
pci_save_state() and pci_restore_state() are not only used by power
management code, but also for error recovery.

Devices without driver or whose driver has no PCI PM callbacks may be in
runtime suspend when pci_pm_freeze() is called.  Their state has already
been saved, so don't clear the flag to skip a pointless pci_save_state()
in pci_pm_freeze_noirq().

None of the drivers with legacy PCI PM callbacks seem to use runtime PM,
so clear the flag unconditionally in their case.

Fixes: 4b77b0a2ba27 ("PCI: Clear saved_state after the state has been restored")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v2.6.32+
---
 drivers/pci/pci-driver.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 302d61783f6c..327b21c48614 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -629,6 +629,8 @@ static int pci_legacy_suspend(struct device *dev, pm_message_t state)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	struct pci_driver *drv = pci_dev->driver;
 
+	pci_dev->state_saved = false;
+
 	if (drv && drv->suspend) {
 		pci_power_t prev = pci_dev->current_state;
 		int error;
@@ -1036,6 +1038,8 @@ static int pci_pm_freeze(struct device *dev)
 
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
+		if (!pm_runtime_suspended(dev))
+			pci_dev->state_saved = false;
 		return 0;
 	}
 
-- 
2.51.0


