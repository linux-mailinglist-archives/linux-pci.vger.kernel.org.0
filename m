Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F0C1E3C32
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 10:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbgE0Igo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 May 2020 04:36:44 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34356 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388025AbgE0Igo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 27 May 2020 04:36:44 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 018C61A06E9;
        Wed, 27 May 2020 10:36:42 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 86C5A1A06FB;
        Wed, 27 May 2020 10:36:38 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 947364024F;
        Wed, 27 May 2020 16:36:33 +0800 (SGT)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com,
        bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: ERR: Don't override the status returned by error_detect()
Date:   Wed, 27 May 2020 16:31:30 +0800
Message-Id: <20200527083130.4137-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
overrode the 'status' returned by the error_detect() call back function,
which is depended on by the next step. This overriding makes the Endpoint
driver's required info (kept in the var status) lost, so it results in the
fatal errors' recovery failed and then kernel panic.

In the e1000e case, the error logs:
pcieport 0002:00:00.0: AER: Uncorrected (Fatal) error received: 0002:01:00.0
e1000e 0002:01:00.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
pcieport 0002:00:00.0: AER: Root Port link has been reset
SError Interrupt on CPU0, code 0xbf000002 -- SError
CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted 5.7.0-rc7-next-20200526 #8
Hardware name: LS1046A RDB Board (DT)
pstate: 80000005 (Nzcv daif -PAN -UAO BTYPE=--)
pc : __pci_enable_msix_range+0x4c8/0x5b8
lr : __pci_enable_msix_range+0x480/0x5b8
sp : ffff80001116bb30
x29: ffff80001116bb30 x28: 0000000000000003
x27: 0000000000000003 x26: 0000000000000000
x25: ffff00097243e0a8 x24: 0000000000000001
x23: ffff00097243e2d8 x22: 0000000000000000
x21: 0000000000000003 x20: ffff00095bd46080
x19: ffff00097243e000 x18: ffffffffffffffff
x17: 0000000000000000 x16: 0000000000000000
x15: ffffb958fa0e9948 x14: ffff00095bd46303
x13: ffff00095bd46302 x12: 0000000000000038
x11: 0000000000000040 x10: ffffb958fa101e68
x9 : ffffb958fa101e60 x8 : 0000000000000908
x7 : 0000000000000908 x6 : ffff800011600000
x5 : ffff00095bd46800 x4 : ffff00096e7f6080
x3 : 0000000000000000 x2 : 0000000000000000
x1 : 0000000000000000 x0 : 0000000000000000
Kernel panic - not syncing: Asynchronous SError Interrupt
CPU: 0 PID: 111 Comm: irq/76-aerdrv Not tainted 5.7.0-rc7-next-20200526 #8

I think it's the expected result that "if the initial value of error
status is PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER
then even after successful recovery (using reset_link()) pcie_do_recovery()
will report the recovery result as failure" which is described in
commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()").

Refer to the Documentation/PCI/pci-error-recovery.rst.
As the error_detect() is mandatory callback if the pci_err_handlers is
implemented, if it return the PCI_ERS_RESULT_DISCONNECT, it means the
driver doesn't want to recover at all;
For the case PCI_ERS_RESULT_NO_AER_DRIVER, if the pci_err_handlers is not
implemented, the failure is more expected.

Fixes: commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/pcie/err.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 14bb8f54723e..84f72342259c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,8 +165,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
-- 
2.17.1

