Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2802B6E7E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 20:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbgKQTUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 14:20:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:31769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726719AbgKQTUh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Nov 2020 14:20:37 -0500
IronPort-SDR: G7lj8OJv7aCXduf9p7smnjISbNpg7N8kVwMqk7quH/i2m3c29/WUWrqkxKkbaQxMFp14dKpOfr
 9GkFFCV+YY0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168417201"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168417201"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:36 -0800
IronPort-SDR: d+B4LD2/hOGLhKmyJStD+JUynMwnabVR0psrbcRHuvivvBwZb2nhILGXK0NxtDZoS6tpW2fsvh
 q4SmgQh+hRsw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="533931679"
Received: from rojasmor-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.255.231.24])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:20:35 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v11 01/16] AER: aer_root_reset() non-native handling
Date:   Tue, 17 Nov 2020 11:19:39 -0800
Message-Id: <20201117191954.1322844-2-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117191954.1322844-1-sean.v.kelley@intel.com>
References: <20201117191954.1322844-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If an OS has not been granted AER control via _OSC, then
the OS should not make changes to PCI_ERR_ROOT_COMMAND and
PCI_ERR_ROOT_STATUS related registers. Per section 4.5.1 of
the System Firmware Intermediary (SFI) _OSC and DPC Updates
ECN [1], this bit also covers these aspects of the PCI
Express Advanced Error Reporting. Based on the above and
earlier discussion [2], make the following changes:

Add a check for the native case (i.e., AER control via _OSC)

Note that the current "clear, reset, enable" order suggests that the
reset might cause errors that we should ignore. Lacking historical
context, these will be retained.

[1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
    2020, affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/14076
[2] https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precision-5520/

Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..6fe2d4ef0635 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1361,23 +1361,26 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	u32 reg32;
 	int rc;
 
-
-	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	if (pcie_aer_is_native(dev)) {
+		/* Disable Root's interrupt in response to error messages */
+		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	}
 
 	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset\n");
+	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
 
-	/* Clear Root Error Status */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
+	if (pcie_aer_is_native(dev)) {
+		/* Clear Root Error Status */
+		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
+		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
 
-	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+		/* Enable Root Port's interrupt in response to error messages */
+		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	}
 
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
-- 
2.29.2

