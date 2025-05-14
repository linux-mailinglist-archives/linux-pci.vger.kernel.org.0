Return-Path: <linux-pci+bounces-27757-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41188AB75FA
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 21:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E820A865DA6
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB42293474;
	Wed, 14 May 2025 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="alXMp7sj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E033293464;
	Wed, 14 May 2025 19:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747251278; cv=none; b=Fqc6YE/flI8/p3+4peAqJTaMVkUrPahfAJ6H0Jj54v7xsps8vP2VWfC28dIK6Vk4dqM8xB8EdLuQqrK1Ysvx8QpBP9yHS8cF8eTPCagSca3J9FVI2R4DroFNYKQ3F2Ep3yhE+MXWjiewKGUoElF38dgSmuppcdR8i0S6wT3EMCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747251278; c=relaxed/simple;
	bh=s4QaK/a9MnnNl0w/we4occOHkkx2Oi4zoKvN8gfZ7pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Itrch50d4BmXsdeff6NpidT02udzO+qV2mc7iMKmhZlH4DCRYpxPQq87SrxmRBdId7SGMy8JntOICcBV1zkUH/wIiscORPtIMEfS2+ASpR9GhpUyg4D/4Qz1AuHRAEQAk/PHBdU8bSFSWUUXawd2AY5hLBNdS7fzEZZoXA/R4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=alXMp7sj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301E1C4CEED;
	Wed, 14 May 2025 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747251278;
	bh=s4QaK/a9MnnNl0w/we4occOHkkx2Oi4zoKvN8gfZ7pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=alXMp7sjE7jtJNChcR7w0/J10J2dexexcJwdBkXbO8zOe9mqBS/UpDV6BRltWbTSf
	 gOkFNU7urAUVSuWgRz4mtfVa2Ps4qBYp8I2O3NibdgjgOSmyEzxVNLmNsVFLfcQHAo
	 krN/SQ5saVEX411pd1Oxn57U+Sr8TPREkN+2g9DikGWpanYIi7/Rj8bsCZ/f/STzLE
	 5salBgqy4CntfsN2QbGVTo94sh2XSzCjJHspdYgMhWzqI31hlLVus/wRhZj4JahNMa
	 67WPaqRUhXu3GQgMZ1vaA230caRH3CEy1pwkG5i1g72aolkv4CHTn2ud1vfH/Px4sA
	 iRMxK/wvf7EYQ==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Mario Limonciello <mario.limonciello@amd.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>
Subject: [PATCH v2 2/3] PCI: Put PCIe ports with downstream devices into D3 at hibernate
Date: Wed, 14 May 2025 14:34:05 -0500
Message-ID: <20250514193406.3998101-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250514193406.3998101-1-superm1@kernel.org>
References: <20250514193406.3998101-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

For the suspend flow PCIe ports that have downstream devices are put into
the appropriate D3 state when children are not in D0. For the hibernate
flow, PCIe ports with downstream devices stay in D0 however. This can
lead to PCIe ports that are remained powered on needlessly during
hibernate.

Adjust the pci_pm_poweroff_noirq() to follow the same flow as
pci_pm_suspend_noirq() in that PCIe ports that are power manageable should
without downstream devices in D0 should be put into their appropriate
sleep state.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-driver.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0c5bdb8c2c07b..57eb129d57244 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1141,6 +1141,8 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1204,8 +1206,35 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	if (!pci_dev->state_saved) {
+		pci_save_state(pci_dev);
+
+		/*
+		 * If the device is a bridge with a child in D0 below it,
+		 * it needs to stay in D0, so check skip_bus_pm to avoid
+		 * putting it into a low-power state in that case.
+		 */
+		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
+			pci_prepare_to_sleep(pci_dev);
+	}
+
+	if (pci_dev->current_state == PCI_D0) {
+		pci_dev->skip_bus_pm = true;
+		/*
+		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
+		 * downstream device is in D0, so avoid changing the power state
+		 * of the parent bridge by setting the skip_bus_pm flag for it.
+		 */
+		if (pci_dev->bus->self)
+			pci_dev->bus->self->skip_bus_pm = true;
+	}
+
+	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
+		pci_dbg(pci_dev, "PCI PM: Skipped\n");
+		goto Fixup;
+	}
+
+	pci_pm_set_unknown_state(pci_dev);
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1214,6 +1243,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
@@ -1223,10 +1253,15 @@ static int pci_pm_restore_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	pci_power_t prev_state = pci_dev->current_state;
+	bool skip_bus_pm = pci_dev->skip_bus_pm;
 
 	pci_pm_default_resume_early(pci_dev);
 	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
+	if (!skip_bus_pm && prev_state == PCI_D3cold)
+		pci_pm_bridge_power_up_actions(pci_dev);
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return 0;
 
-- 
2.43.0


