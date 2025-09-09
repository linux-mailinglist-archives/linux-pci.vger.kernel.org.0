Return-Path: <linux-pci+bounces-35760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FCFB5064C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 21:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F687B13D0
	for <lists+linux-pci@lfdr.de>; Tue,  9 Sep 2025 19:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731993570C2;
	Tue,  9 Sep 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoZPrphD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402603570C1;
	Tue,  9 Sep 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445417; cv=none; b=GgC1xAa6qtBCKNgJ7PtpT78ekkEzd9JpyofNsXAQLfwUNC4o06p9mE9Hv4bHGBAZADxh32CZnlJ7VDuLNDZh2O7cVfeOT6TOtVZHftGoFUXLl/8JoHEPHHb/5+gVLOB0npBtMVLnoMwuzAlSuQn7kfNPT0gJnsKDvnOxJcfwZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445417; c=relaxed/simple;
	bh=HUkDv101M6MYDQNUpF/CsQY8bMggQPgFt3+tysKCUPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rX4irmtoZmqaDjoxB6Rx7yuGKkMcUhtJ9e1T3144Ype9lGniTAGM3pzTtSB3j+DhtOFfilWZ6dPkB7S0k+mhKGPFkp/Dm8T2Ztkx9R/Rif9Z/UwFNpRnlEfmtMudoe7kcWP0nvR+v58o3jvcvyMan/fAYBjMeOIVPoWaWik6DEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoZPrphD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5C1C4CEF4;
	Tue,  9 Sep 2025 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757445416;
	bh=HUkDv101M6MYDQNUpF/CsQY8bMggQPgFt3+tysKCUPY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoZPrphD7NYhQ+z8RfbIxV2R0ZtIq4N4eVScRP56/a4xieg60r9e2n31/toaOJMvJ
	 aswq5scYMFfAq9cdYxkpKKF+ASn01DS8v5ROErzkvNZTyLf3qhe7VL+oN5gl43thBP
	 Ypc4BoAU1u48/2qfuGRkHJMcskYewNCB8dfA4x92dTLqppov4dYUkkcDl4RycyVBA8
	 34tuAaJ+96VzwWRPaGQ7nZXs/COCxl3lSqgFN3kRR4G1Qa2q1OQ67UqptGqgIKbmeE
	 MLoXPqrL9rKxy3Y+BFp5DbnpTnLh2GA0SBy9DLqoK5eZH4VltkIyaxAxDnFh9domYW
	 VxVGi0Oh4KZ3w==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend, aka swsusp)),
	amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
	linux-trace-kernel@vger.kernel.org (open list:TRACING),
	AceLan Kao <acelan.kao@canonical.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	=?UTF-8?q?Merthan=20Karaka=C5=9F?= <m3rthn.k@gmail.com>,
	Eric Naim <dnaim@cachyos.org>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Denis Benato <benato.denis96@gmail.com>
Subject: [PATCH v7 09/12] PCI: Put PCIe bridges with downstream devices into D3 at hibernate
Date: Tue,  9 Sep 2025 14:16:16 -0500
Message-ID: <20250909191619.2580169-10-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909191619.2580169-1-superm1@kernel.org>
References: <20250909191619.2580169-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During suspend, PCIe bridges with downstream devices are transitioned into
a low power state (D3hot or D3cold) depending on platform capabilities.
However, during hibernate, these bridges remain in D0, which can lead to
unnecessary power consumption.

Align the hibernate flow with suspend by updating pci_pm_poweroff_noirq()
to use pci_pm_suspend_noirq_common(). This ensures that PCIe bridges with
active downstream devices are properly transitioned to a low power state
during hibernate.

This change introduces a functional update: the hibernate path will now
invoke pci_save_state(), and — unless bus-level power management is
skipped — will transition the bridge into D3hot or D3cold as appropriate.

Cc: AceLan Kao <acelan.kao@canonical.com>
Cc: Kai-Heng Feng <kaihengf@nvidia.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Denis Benato <benato.denis96@gmail.com>
Cc: Merthan Karakaş <m3rthn.k@gmail.com>
Tested-by: Eric Naim <dnaim@cachyos.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v7:
 * reword commit text
v6:
 * s/port/bridge/
v5:
 * Split out into more patches
 * Rewrite commit
 * Add tag
v4:
 * Use helper even when CONFIG_SUSPEND not set (LKP robot)
 * https://lore.kernel.org/linux-pci/20250616175019.3471583-1-superm1@kernel.org/
v3:
 * Split out common code between suspend_noirq() and poweroff_noirq()
   to a helper function
 * https://lore.kernel.org/linux-pm/20250609024619.407257-1-superm1@kernel.org/T/#me6db0fb946e3d604a8f3d455128844ed802c82bb
---
 drivers/pci/pci-driver.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index c563fd6af979d..5eedfbb0be8a4 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -762,7 +762,7 @@ static void pci_pm_complete(struct device *dev)
 
 #endif /* !CONFIG_PM_SLEEP */
 
-#if defined(CONFIG_SUSPEND)
+#if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATE_CALLBACKS)
 /**
  * pci_pm_suspend_noirq_common
  * @pci_dev: pci device
@@ -808,7 +808,7 @@ static void pci_pm_suspend_noirq_common(struct pci_dev *pci_dev, bool *skip_bus_
 
 	pci_pm_set_unknown_state(pci_dev);
 }
-#endif /* CONFIG_SUSPEND */
+#endif /* CONFIG_SUSPEND || CONFIG_HIBERNATE_CALLBACKS */
 
 #ifdef CONFIG_SUSPEND
 static void pcie_pme_root_status_cleanup(struct pci_dev *pci_dev)
@@ -1164,6 +1164,8 @@ static int pci_pm_poweroff(struct device *dev)
 	    (system_state == SYSTEM_HALT || system_state == SYSTEM_POWER_OFF))
 		device_set_wakeup_enable(dev, false);
 
+	pci_dev->skip_bus_pm = false;
+
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
@@ -1206,6 +1208,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
+	bool skip_bus_pm = false;
 
 	if (dev_pm_skip_suspend(dev))
 		return 0;
@@ -1227,8 +1230,9 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 			return error;
 	}
 
-	if (!pci_dev->state_saved && pci_power_manageable(pci_dev))
-		pci_prepare_to_sleep(pci_dev);
+	pci_pm_suspend_noirq_common(pci_dev, &skip_bus_pm);
+	if (skip_bus_pm)
+		goto Fixup;
 
 	/*
 	 * The reason for doing this here is the same as for the analogous code
@@ -1237,6 +1241,7 @@ static int pci_pm_poweroff_noirq(struct device *dev)
 	if (pci_dev->class == PCI_CLASS_SERIAL_USB_EHCI)
 		pci_write_config_word(pci_dev, PCI_COMMAND, 0);
 
+Fixup:
 	pci_fixup_device(pci_fixup_suspend_late, pci_dev);
 
 	return 0;
-- 
2.43.0


