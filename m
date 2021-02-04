Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1ED30EC86
	for <lists+linux-pci@lfdr.de>; Thu,  4 Feb 2021 07:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhBDGcI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Feb 2021 01:32:08 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12122 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhBDGcG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 Feb 2021 01:32:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DWTDb1Fdqz1640g;
        Thu,  4 Feb 2021 14:29:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 14:31:01 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <bhelgaas@google.com>,
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        <sean.v.kelley@intel.com>, <Jonathan.Cameron@huawei.com>,
        <refactormyself@gmail.com>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 1/1] PCI/AER: Change to use helper pcie_aer_is_native() in some places
Date:   Thu, 4 Feb 2021 14:28:47 +0800
Message-ID: <1612420127-6447-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use helper function pcie_aer_is_native() in some places to keep
the code tidy. No function changes.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 drivers/pci/pcie/aer.c          | 4 ++--
 drivers/pci/pcie/err.c          | 2 +-
 drivers/pci/pcie/portdrv_core.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 77b0f2c..03212d0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1397,7 +1397,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	 */
 	aer = root ? root->aer_cap : 0;
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (pcie_aer_is_native(dev) && aer) {
 		/* Disable Root's interrupt in response to error messages */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
@@ -1417,7 +1417,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
 	}
 
-	if ((host->native_aer || pcie_ports_native) && aer) {
+	if (pcie_aer_is_native(dev) && aer) {
 		/* Clear Root Error Status */
 		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
 		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 510f31f..1d6cfb9 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -237,7 +237,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	 * this status.  In that case, the signaling device may not even be
 	 * visible to the OS.
 	 */
-	if (host->native_aer || pcie_ports_native) {
+	if (pcie_aer_is_native(dev)) {
 		pcie_clear_device_status(bridge);
 		pci_aer_clear_nonfatal_status(bridge);
 	}
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index e1fed664..1e6a690 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -222,7 +222,7 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 #ifdef CONFIG_PCIEAER
 	if (dev->aer_cap && pci_aer_available() &&
-	    (pcie_ports_native || host->native_aer)) {
+	    pcie_aer_is_native(dev)) {
 		services |= PCIE_PORT_SERVICE_AER;
 
 		/*
-- 
2.8.1

