Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E48F2A10F2
	for <lists+linux-pci@lfdr.de>; Fri, 30 Oct 2020 23:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbgJ3Weq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Oct 2020 18:34:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:45232 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725791AbgJ3Weq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Oct 2020 18:34:46 -0400
IronPort-SDR: uLCYMrqCohM5ae6V4tRtqwXID2uJq2+YtcExJMq9dE2jb3q+JrJAwkuE2v7fs8URCYX7zu18s9
 1+QBkb6KMl7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="165176478"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="165176478"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 15:34:46 -0700
IronPort-SDR: E2KERoBIA73u1mSIH5D9pwc2LmTUiiDVEFkjwfMpIe5DFfFfN6/mQZvD9Sv6u27QX/BkowLmel
 /kpfgZ4xoB1g==
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; 
   d="scan'208";a="305077169"
Received: from divyameh-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.209.172.53])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 15:34:45 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH] AER: aer_root_reset() non-native handling
Date:   Fri, 30 Oct 2020 15:34:43 -0700
Message-Id: <20201030223443.165783-1-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
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
Express Advanced Error Reporting. Further, the handling of
clear/enable of PCI_ERROR_ROOT_COMMAND when wrapped around
PCI_ERR_ROOT_STATUS should have no effect and be removed.
Based on the above and earlier discussion [2], make the
following changes:

Add a check for the native case (i.e., AER control via _OSC)
Re-order and remove some of the handling:
- clear PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK
- do reset
- clear PCI_ERR_ROOT_STATUS
- enable PCI_ERR_ROOT_COMMAND ROOT_PORT_INTR_ON_MESG_MASK

to this:

- clear PCI_ERR_ROOT_STATUS
- do reset

The current "clear, reset, enable" order suggests that the reset
might cause errors that we should ignore. But I am unable to find a
reference and the clearing of PCI_ERR_ROOT_STATUS does not require them.

[1] System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
    2020, affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/14076
[2] https://lore.kernel.org/linux-pci/20201020162820.GA370938@bjorn-Precision-5520/

Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..bbfb07842d89 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1361,23 +1361,14 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 	u32 reg32;
 	int rc;
 
-
-	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	if (pcie_aer_is_native(dev)) {
+		/* Clear Root Error Status */
+		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
+		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
+	}
 
 	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset\n");
-
-	/* Clear Root Error Status */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
-
-	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	pci_info(dev, "Root Port link has been reset (%d)\n", rc);
 
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
-- 
2.29.2

