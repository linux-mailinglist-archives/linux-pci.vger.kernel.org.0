Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A703F2D35EA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 23:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgLHWIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 17:08:41 -0500
Received: from mga07.intel.com ([134.134.136.100]:64697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730642AbgLHWIl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 17:08:41 -0500
IronPort-SDR: Ow0DvqHaBadhUZKwf7BR4VPlFLOXjpUuoie/eaVCIz63v7olKEqdSZyDOdNYbOJpXyRF0elfwT
 KLpP/RzF8RPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="238082160"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="238082160"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 14:06:54 -0800
IronPort-SDR: 30DHLwQpeUuMVPS8yd5UTrCG6PKd1p9XMno5WDAOwNsaVyTWQYsngpLvf7SapawTmnp5dN7Ry5
 Nah4YwUaxRHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; 
   d="scan'208";a="542170725"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 08 Dec 2020 14:06:53 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 92A1D58066D;
        Tue,  8 Dec 2020 14:06:53 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, rafael@kernel.org
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Save/restore L1 PM Substate extended capability registers
Date:   Tue,  8 Dec 2020 14:06:24 -0800
Message-Id: <20201208220624.21877-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Intel systems that support ACPI Low Power Idle it has been observed
that the L1 Substate capability can return disabled after a s2idle
cycle. This causes the loss of L1 Substate support during runtime
leading to higher power consumption. Add save/restore of the L1SS
control registers.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..beee3d9952a6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1539,6 +1539,48 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
 	pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
 }
 
+static void pci_save_l1ss_state(struct pci_dev *dev)
+{
+	int l1ss;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state) {
+		pci_err(dev, "no suspend buffer for L1 Substates\n");
+		return;
+	}
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(dev, l1ss + PCI_L1SS_CTL1, cap++);
+	pci_read_config_word(dev, l1ss + PCI_L1SS_CTL1 + 2, cap++);
+	pci_read_config_word(dev, l1ss + PCI_L1SS_CTL2, cap++);
+}
+
+static void pci_restore_l1ss_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int l1ss;
+	u16 *cap;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_L1SS);
+	l1ss = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_L1SS);
+	if (!save_state || !l1ss)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(dev, l1ss + PCI_L1SS_CTL1, *cap++);
+	pci_write_config_word(dev, l1ss + PCI_L1SS_CTL1 + 2, *cap++);
+	pci_write_config_word(dev, l1ss + PCI_L1SS_CTL2, *cap++);
+}
+
 /**
  * pci_save_state - save the PCI configuration space of a device before
  *		    suspending
@@ -1563,6 +1605,7 @@ int pci_save_state(struct pci_dev *dev)
 	if (i != 0)
 		return i;
 
+	pci_save_l1ss_state(dev);
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
@@ -1670,6 +1713,7 @@ void pci_restore_state(struct pci_dev *dev)
 	 */
 	pci_restore_ltr_state(dev);
 
+	pci_restore_l1ss_state(dev);
 	pci_restore_pcie_state(dev);
 	pci_restore_pasid_state(dev);
 	pci_restore_pri_state(dev);
@@ -3332,6 +3376,11 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_L1SS,
+					    3 * sizeof(u16));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for L1 Substates\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 
-- 
2.20.1

