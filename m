Return-Path: <linux-pci+bounces-37853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84008BD02C0
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 15:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D9143B87D3
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A958C2D052;
	Sun, 12 Oct 2025 13:30:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1516132A
	for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 13:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760275817; cv=none; b=tVH/Rg2T48zfVy5gx3M5/HqhlhdNBz2aobetwawQ9egy2GNTZQPTdRlFh3ETDWlhZv+SGP6putIYXRFnf/Re16xSoNsauQK//1HHHrNOdgczmbSBmIVHX0RZtyjMRoz09O1lsy02Hso1uUoiG6hh+p3xwIt4XP0UHpBm8ZRTOHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760275817; c=relaxed/simple;
	bh=aFRK4q7PFYOV+8d+wk4EaLLwsd6HK+q//UWSp5mgjUo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:To:Cc; b=Jzf6EpgDYoCMxTHowyrTp1QJBd3hvVVwW9gkSEf2tbTfhSspcHHkSTighQIiR0RyhKiJf9huCAAJ3+zix/Ia9TG2KftcuU6ZxNacn2o++aFESLx71fF5cPLZP5tEtflpo1HkgcE4kn9h+lIHKTTWh0c6w/x4UXoRbTQpKLx5Cck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id F1551200803C;
	Sun, 12 Oct 2025 15:30:06 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D512D4A12; Sun, 12 Oct 2025 15:30:06 +0200 (CEST)
Message-Id: <070a03221dbec25f478d36d7bc76e0da81985c5d.1760274044.git.lukas@wunner.de>
In-Reply-To: <cover.1760274044.git.lukas@wunner.de>
References: <cover.1760274044.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 12 Oct 2025 15:25:01 +0200
Subject: [PATCH 1/2] PCI: Ensure error recoverability at all times
To: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Riana Tauro <riana.tauro@intel.com>, "Sean C. Dardis" <sean.c.dardis@intel.com>, Farhan Ali <alifm@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Alek Du <alek.du@intel.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>, Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
    Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com, Dave Jiang <dave.jiang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

When the PCI core gained power management support in 2002, it introduced
pci_save_state() and pci_restore_state() helpers to restore Config Space
after a D3hot or D3cold transition, which implies a Soft or Fundamental
Reset (PCIe r7.0 sec 5.8):

  https://git.kernel.org/tglx/history/c/a5287abe398b

In 2006, EEH and AER were introduced to recover from errors by performing
a reset.  Because errors can occur at any time, drivers began calling
pci_save_state() on probe to ensure recoverability.

In 2009, recoverability was foiled by commit c82f63e411f1 ("PCI: check
saved state before restore"):  It amended pci_restore_state() to bail out
if the "state_saved" flag has been cleared.  The flag is cleared by
pci_restore_state() itself, hence a saved state is now allowed to be
restored only once and is then invalidated.  That doesn't seem to make
sense because the saved state should be good enough to be reused.

Soon after, drivers began to work around this behavior by calling
pci_save_state() immediately after pci_restore_state(), see e.g. commit
b94f2d775a71 ("igb: call pci_save_state after pci_restore_state").
Hilariously, two drivers even set the "saved_state" flag to true before
invoking pci_restore_state(), see ipr_reset_restore_cfg_space() and
e1000_io_slot_reset().

Despite these workarounds, recoverability at all times is not guaranteed:
E.g. when a PCIe port goes through a runtime suspend and resume cycle,
the "saved_state" flag is cleared by:

  pci_pm_runtime_resume()
    pci_pm_default_resume_early()
      pci_restore_state()

... and hence on a subsequent AER event, the port's Config Space cannot be
restored.  Riana reports a recovery failure of a GPU-integrated PCIe
switch and has root-caused it to the behavior of pci_restore_state().
Another workaround would be necessary, namely calling pci_save_state() in
pcie_port_device_runtime_resume().

The motivation of commit c82f63e411f1 was to prevent restoring state if
pci_save_state() hasn't been called before.  But that can be achieved by
saving state already on device addition, after Config Space has been
initialized.  A desirable side effect is that devices become recoverable
even if no driver gets bound.  This renders the commit unnecessary, so
revert it.

Reported-by: Riana Tauro <riana.tauro@intel.com> # off-list
Tested-by: Riana Tauro <riana.tauro@intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Proof that removing the check in pci_restore_state() makes no
difference for the PCI core:

* The only relevant invocations of pci_restore_state() are in
  drivers/pci/pci-driver.c
* One invocation is in pci_restore_standard_config(), which is
  always called conditionally on "if (pci_dev->state_saved)".
  So the check at the beginning of pci_restore_state() which
  this patch removes is an unnecessary duplication.
* Another invocation is in pci_pm_default_resume_early(), which
  is called from pci_pm_resume_noirq(), pci_pm_restore_noirq()
  and pci_pm_runtime_resume().  Those functions are only called
  after prior calls to pci_pm_suspend_noirq(), pci_pm_freeze_noirq(),
  and pci_pm_runtime_suspend(), respectively.  And all of them
  call pci_save_state().  So the "if (!dev->state_saved)" check
  in pci_restore_state() never evaluates to true.
* A third invocation is in pci_pm_thaw_noirq().  It is only called
  after a prior call to pci_pm_freeze_noirq(), which invokes
  pci_save_state().  So likewise the "if (!dev->state_saved)" check
  in pci_restore_state() never evaluates to true.

 drivers/pci/bus.c   | 7 +++++++
 drivers/pci/pci.c   | 3 ---
 drivers/pci/probe.c | 2 --
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index f26aec6..4318568 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -358,6 +358,13 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_bridge_d3_update(dev);
 
 	/*
+	 * Save config space for error recoverability.  Clear state_saved
+	 * to detect whether drivers invoked pci_save_state() on suspend.
+	 */
+	pci_save_state(dev);
+	dev->state_saved = false;
+
+	/*
 	 * If the PCI device is associated with a pwrctrl device with a
 	 * power supply, create a device link between the PCI device and
 	 * pwrctrl device.  This ensures that pwrctrl drivers are probed
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b14dd06..2f0da5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1855,9 +1855,6 @@ static void pci_restore_rebar_state(struct pci_dev *pdev)
  */
 void pci_restore_state(struct pci_dev *dev)
 {
-	if (!dev->state_saved)
-		return;
-
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c83e75a..c7c7a3d 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2747,8 +2747,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	pci_reassigndev_resource_alignment(dev);
 
-	dev->state_saved = false;
-
 	pci_init_capabilities(dev);
 
 	/*
-- 
2.51.0


