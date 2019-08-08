Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792CA85F49
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 12:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389864AbfHHKKo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 06:10:44 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47900 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389756AbfHHKKo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 06:10:44 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id a5993c00402c74dd; Thu, 8 Aug 2019 12:10:41 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-nvme <linux-nvme@lists.infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v2 2/2] nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled
Date:   Thu, 08 Aug 2019 12:10:06 +0200
Message-ID: <1870928.r7tBYyfqdz@kreacher>
In-Reply-To: <1921165.pTveHRX1Co@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

One of the modifications made by commit d916b1be94b6 ("nvme-pci: use
host managed power state for suspend") was adding a pci_save_state()
call to nvme_suspend() in order to prevent the PCI bus-level PM from
being applied to the suspended NVMe devices, but if ASPM is not
enabled for the target NVMe device, that causes its PCIe link to stay
up and the platform may not be able to get into its optimum low-power
state because of that.

For example, if ASPM is disabled for the NVMe drive (PC401 NVMe SK
hynix 256GB) in my Dell XPS13 9380, leaving it in D0 during
suspend-to-idle prevents the SoC from reaching package idle states
deeper than PC3, which is way insufficient for system suspend.

To address this shortcoming, make nvme_suspend() check if ASPM is
enabled for the target device and fall back to full device shutdown
and PCI bus-level PM if that is not the case.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#t
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2:
  * Move the PCI/PCIe ASPM changes to a separate patch.
  * Do not add a redundant ndev->last_ps == U32_MAX check in nvme_suspend().

---
 drivers/nvme/host/pci.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/nvme/host/pci.c
===================================================================
--- linux-pm.orig/drivers/nvme/host/pci.c
+++ linux-pm/drivers/nvme/host/pci.c
@@ -2846,7 +2846,7 @@ static int nvme_resume(struct device *de
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 
-	if (pm_resume_via_firmware() || !ctrl->npss ||
+	if (ndev->last_ps == U32_MAX ||
 	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
 		nvme_reset_ctrl(ctrl);
 	return 0;
@@ -2859,6 +2859,8 @@ static int nvme_suspend(struct device *d
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 	int ret = -EBUSY;
 
+	ndev->last_ps = U32_MAX;
+
 	/*
 	 * The platform does not remove power for a kernel managed suspend so
 	 * use host managed nvme power settings for lowest idle power if
@@ -2866,8 +2868,14 @@ static int nvme_suspend(struct device *d
 	 * shutdown.  But if the firmware is involved after the suspend or the
 	 * device does not support any non-default power states, shut down the
 	 * device fully.
+	 *
+	 * If ASPM is not enabled for the device, shut down the device and allow
+	 * the PCI bus layer to put it into D3 in order to take the PCIe link
+	 * down, so as to allow the platform to achieve its minimum low-power
+	 * state (which may not be possible if the link is up).
 	 */
-	if (pm_suspend_via_firmware() || !ctrl->npss) {
+	if (pm_suspend_via_firmware() || !ctrl->npss ||
+	    !pcie_aspm_enabled_mask(pdev)) {
 		nvme_dev_disable(ndev, true);
 		return 0;
 	}
@@ -2880,7 +2888,6 @@ static int nvme_suspend(struct device *d
 	    ctrl->state != NVME_CTRL_ADMIN_ONLY)
 		goto unfreeze;
 
-	ndev->last_ps = 0;
 	ret = nvme_get_power_state(ctrl, &ndev->last_ps);
 	if (ret < 0)
 		goto unfreeze;



