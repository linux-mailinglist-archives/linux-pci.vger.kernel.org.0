Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 299A91902DC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCXA0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:60461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbgCXA0Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:25 -0400
IronPort-SDR: FRTHXTBx0vOsgWZgd7Rn4M8xskumLqLuC0eobUxlPCsO5BNKYOfF/5EDh8LhpnIG0hz1wlvt2B
 3h9oZob8zqPA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:24 -0700
IronPort-SDR: sbZi9czyx03WYg3IeGU5/NQ11hmz/5BOGAildBczdKFRdboTtJI+Jai8vDROyed1xFfPjWeZjE
 vY6Duqn0ZarQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692243"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:24 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 06/11] PCI/ERR: Return status of pcie_do_recovery()
Date:   Mon, 23 Mar 2020 17:26:03 -0700
Message-Id: <eb60ec89448769349c6722954ffbf2de163155b5.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per the DPC Enhancements ECN [1], sec 4.5.1, table 4-4, if the OS
supports Error Disconnect Recover (EDR), it must invalidate the software
state associated with child devices of the port without attempting to
access the child device hardware. In addition, if the OS supports DPC, it
must attempt to recover the child devices if the port implements the DPC
Capability. If the OS continues operation, the OS must inform the firmware
of the status of the recovery operation via the _OST method.

Return the result of pcie_do_recovery() so we can report it to firmware via
_OST.

[1] Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
    affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/12888
Link: https://lore.kernel.org/r/a795fe1f1f42f5aa1d334768d4e719d8c147894e.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.h      |  5 +++--
 drivers/pci/pcie/err.c | 10 ++++++----
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3e5efb83e9a2..efbe94096050 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -547,8 +547,9 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 #endif
 
 /* PCI error reporting and recovery */
-void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
-		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
+pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
+			enum pci_channel_state state,
+			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index caeb6f5d9970..7881de20af29 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,9 +146,9 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-void pcie_do_recovery(struct pci_dev *dev,
-		      enum pci_channel_state state,
-		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
+pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
+			enum pci_channel_state state,
+			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -201,11 +201,13 @@ void pcie_do_recovery(struct pci_dev *dev,
 	pci_aer_clear_device_status(dev);
 	pci_cleanup_aer_uncorrect_error_status(dev);
 	pci_info(dev, "device recovery successful\n");
-	return;
+	return status;
 
 failed:
 	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
 	pci_info(dev, "device recovery failed\n");
+
+	return status;
 }
-- 
2.17.1

