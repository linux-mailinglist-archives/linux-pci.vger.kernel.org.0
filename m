Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77782B88FB
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 01:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgKSARk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 19:17:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:23260 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKSARk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 19:17:40 -0500
IronPort-SDR: rOM0dF1zMSKYTdaDmRXQxGKVFJR9jrljXRmtan0rIOqDNvJGZ2CtpHzXzRq3uNjdodnbgSLPGm
 UfC7A4T5B/Kg==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="171305805"
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="171305805"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 16:17:38 -0800
IronPort-SDR: WkNLjActaftn3S33vHtSNX+0spN//6sH8osv7Nk+VHGbETzOlKxQuwItZMRQlvkKSM56Y2bKU2
 0UQedZQ8Covg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,488,1596524400"; 
   d="scan'208";a="532952519"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2020 16:17:35 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id BDE67580689;
        Wed, 18 Nov 2020 16:17:35 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, rafael@kernel.org, len.brown@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: Add save/restore of Precision Time Measurement capability
Date:   Wed, 18 Nov 2020 16:18:21 -0800
Message-Id: <20201119001822.31617-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI subsystem does not currently save and restore the configuration
space for the Precision Time Measurement (PTM) PCIe extended capability
leading to the feature returning disabled on S3 resume. This has been
observed on Intel Coffee Lake desktops. Add save/restore of the PTM control
register. This saves the PTM Enable, Root Select, and Effective Granularity
bits.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e578d34095e9..6fd4ae910a88 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1539,6 +1539,44 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
 	pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++);
 }
 
+static void pci_save_ptm_state(struct pci_dev *dev)
+{
+	int ptm;
+	struct pci_cap_saved_state *save_state;
+	u16 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!ptm)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state) {
+		pci_err(dev, "no suspend buffer for PTM\n");
+		return;
+	}
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, cap);
+}
+
+static void pci_restore_ptm_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	int ptm;
+	u16 *cap;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_PTM);
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!save_state || !ptm)
+		return;
+
+	cap = (u16 *)&save_state->cap.data[0];
+	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, *cap);
+}
+
 /**
  * pci_save_state - save the PCI configuration space of a device before
  *		    suspending
@@ -1566,6 +1604,7 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
+	pci_save_ptm_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1677,6 +1716,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_vc_state(dev);
 	pci_restore_rebar_state(dev);
 	pci_restore_dpc_state(dev);
+	pci_restore_ptm_state(dev);
 
 	pci_aer_clear_status(dev);
 	pci_restore_aer_state(dev);
@@ -3332,6 +3372,10 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev)
 	if (error)
 		pci_err(dev, "unable to allocate suspend buffer for LTR\n");
 
+	error = pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_PTM, sizeof(u16));
+	if (error)
+		pci_err(dev, "unable to allocate suspend buffer for PTM\n");
+
 	pci_allocate_vc_save_buffers(dev);
 }
 
-- 
2.20.1

