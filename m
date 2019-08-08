Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357A486CD0
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 23:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbfHHV64 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 17:58:56 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:50579 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHV64 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 17:58:56 -0400
Received: from 79.184.254.29.ipv4.supernova.orange.pl (79.184.254.29) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 198204becd846193; Thu, 8 Aug 2019 23:58:52 +0200
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
Subject: [PATCH v3 2/2] nvme-pci: Allow PCI bus-level PM to be used if ASPM is disabled
Date:   Thu, 08 Aug 2019 23:58:38 +0200
Message-ID: <4856352.pThfM6cRGE@kreacher>
In-Reply-To: <2184247.yL3mcj2FRQ@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM> <20190731221956.GB15795@localhost.localdomain> <2184247.yL3mcj2FRQ@kreacher>
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
call to nvme_suspend() so as to instruct the PCI bus type to leave
devices handled by the nvme driver in D0 during suspend-to-idle.
That was done with the assumption that ASPM would transition the
device's PCIe link into a low-power state when the device became
inactive.  However, if ASPM is disabled for the device, its PCIe
link will stay in L0 and in that case commit d916b1be94b6 is likely
to cause the energy used by the system while suspended to increase.

Namely, if the device in question works in accordance with the PCIe
specification, putting it into D3hot causes its PCIe link to go to
L1 or L2/L3 Ready, which is lower-power than L0.  Since the energy
used by the system while suspended depends on the state of its PCIe
link (as a general rule, the lower-power the state of the link, the
less energy the system will use), putting the device into D3hot
during suspend-to-idle should be more energy-efficient that leaving
it in D0 with disabled ASPM.

For this reason, avoid leaving NVMe devices with disabled ASPM in D0
during suspend-to-idle.  Instead, shut them down entirely and let
the PCI bus type put them into D3.

Fixes: d916b1be94b6 ("nvme-pci: use host managed power state for suspend")
Link: https://lore.kernel.org/linux-pm/2763495.NmdaWeg79L@kreacher/T/#t
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3:
  * Modify the changelog to describe the rationale for this patch in
    a less confusing and more convincing way.

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
+	    !pcie_aspm_enabled(pdev)) {
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



