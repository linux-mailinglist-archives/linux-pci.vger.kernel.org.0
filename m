Return-Path: <linux-pci+bounces-29191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62AAD171E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 04:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38F173ABA7E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 02:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECD248869;
	Mon,  9 Jun 2025 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gf9fLsel"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E6A2472BD;
	Mon,  9 Jun 2025 02:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749437200; cv=none; b=KjXDFQ4YNim0qoPNTVi+R1JhnrcpWnQpbEl6wBWaRrhZiOkzUb4lz7GvZEhEHUr8OnOLCfTM+Dkdd5Ejo2l152pajZHC7ti2r+TEUn/YAUZq6tVJehOMJ2g5MnS2qV7ntlXm7GZI1Yh3V33T4agPhoWfi74hAqRKvljvNvjJbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749437200; c=relaxed/simple;
	bh=wvLxIFbimkhYugOTUjv3XpoarND1GpGr/k48CafzKdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vALhUgWX3DuzKJqiZRQM6KtzlX6v0TyPB6aMB/p1gBNF1V2Wo7TYQOkzOAE47gROU4GkbnPfPt6zim6J9I5TF3HrtNnbebIrJPNRpESMl3l3w3Irjf7tLIRXFP3zEghKXw9enRHfkl2kWA+flAx5DU+3uf5sCF+abwJdDE5dyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gf9fLsel; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54AB3C4CEEE;
	Mon,  9 Jun 2025 02:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749437200;
	bh=wvLxIFbimkhYugOTUjv3XpoarND1GpGr/k48CafzKdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gf9fLsel6C/015X/FlldEfiTPYrLsuf9jk7ryZBpQAl/Ktw+AgTM10amXdWrU1PSy
	 hv8SY75slNdaPuRc3oVd3scQraOcdU2pLVUwvUCEYLp2iEjytVUhwiO87OJSt3K3LD
	 NfwQw9rBOplR7JybWqIMXq41rGArlXGUnu4mTPRe2h0+FwfOCqK39ukGNiNxQXvGTd
	 10gFdNHVR9K3ZcjSEU2FJVkEW6SSiU609/ZwGNdb8W5p040UaFcRwNqg9tsmwZfRIc
	 QeK4UjafaGTqA4abo4EuZG4YxRVYLzSK7KOjFf0ZM9NWB+xGCu891SDLtJGqK/Q7TY
	 giS+L7akcH/Fg==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	Mario Limonciello <mario.limonciello@amd.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Denis Benato <benato.denis96@gmail.com>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>
Subject: [PATCH v3 2/5] PCI: Put PCIe ports with downstream devices into D3 at hibernate
Date: Sun,  8 Jun 2025 21:46:16 -0500
Message-ID: <20250609024619.407257-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609024619.407257-1-superm1@kernel.org>
References: <20250609024619.407257-1-superm1@kernel.org>
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
v3:
 * Split out common code between suspend_noirq() and poweroff_noirq()
   to a helper function
---
 drivers/pci/pci-driver.c | 92 ++++++++++++++++++++++++++--------------
 1 file changed, 59 insertions(+), 33 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index e3dc26f691069..ab4cfdfc8fbc0 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -844,6 +844,54 @@ static int pci_pm_suspend_late(struct device *dev)
 	return pm_generic_suspend_late(dev);
 }
 
+/**
+ * pci_pm_set_prepare_bus_pm
+ * @pci_dev: pci device
+ *
+ * Prepare the device to go into a low power state by saving state
+ * and configure bus PM policy.
+ *
+ * Return: TRUE for bus PM will be used
+ *         FALSE for bus PM will be skipped
+ */
+static bool pci_pm_set_prepare_bus_pm(struct pci_dev *pci_dev)
+{
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
+	pci_dbg(pci_dev, "PCI PM: Sleep power state: %s\n",
+		pci_power_name(pci_dev->current_state));
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
+		return FALSE;
+	}
+
+	pci_pm_set_unknown_state(pci_dev);
+
+	return TRUE;
+}
+
 static int pci_pm_suspend_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
@@ -878,38 +926,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		}
 	}
 
-	if (!pci_dev->state_saved) {
-		pci_save_state(pci_dev);
-
-		/*
-		 * If the device is a bridge with a child in D0 below it,
-		 * it needs to stay in D0, so check skip_bus_pm to avoid
-		 * putting it into a low-power state in that case.
-		 */
-		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
-			pci_prepare_to_sleep(pci_dev);
-	}
-
-	pci_dbg(pci_dev, "PCI PM: Suspend power state: %s\n",
-		pci_power_name(pci_dev->current_state));
-
-	if (pci_dev->current_state == PCI_D0) {
-		pci_dev->skip_bus_pm = true;
-		/*
-		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
-		 * downstream device is in D0, so avoid changing the power state
-		 * of the parent bridge by setting the skip_bus_pm flag for it.
-		 */
-		if (pci_dev->bus->self)
-			pci_dev->bus->self->skip_bus_pm = true;
-	}
-
-	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
-		pci_dbg(pci_dev, "PCI PM: Skipped\n");
+	if (!pci_pm_set_prepare_bus_pm(pci_dev))
 		goto Fixup;
-	}
-
-	pci_pm_set_unknown_state(pci_dev);
 
 	/*
 	 * Some BIOSes from ASUS have a bug: If a USB EHCI host controller's
@@ -1136,6 +1154,8 @@ static int pci_pm_poweroff(struct device *dev)
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1199,8 +1219,8 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && !pci_has_subordinate(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	if (!pci_pm_set_prepare_bus_pm(pci_dev))
+		goto Fixup;
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1209,6 +1229,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
@@ -1218,10 +1239,15 @@ static int pci_pm_restore_noirq(struct device *dev)
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


