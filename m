Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC1A2BBA98
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 01:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgKUAKl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 19:10:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:34298 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727780AbgKUAKk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 19:10:40 -0500
IronPort-SDR: /mUY24K1H6WbIhLiNeITPol63a5Aj7CK4z1X5L/J5R/rngbLZPTt4Ko1OiAwOx5pj0SeIEkfyu
 V+YJnz9Qz7SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158601551"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="158601551"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:39 -0800
IronPort-SDR: P6QAU+6hK9Vq4m58OUjefoRrtUrpXFuoW6v+M95LGMqVG0Kqvc7HCr1ldqtCpDdfIUCoMVb15e
 ZTRC1t3qGzYw==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369387285"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.212.171.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:39 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v12 01/15] AER: aer_root_reset() non-native handling
Date:   Fri, 20 Nov 2020 16:10:22 -0800
Message-Id: <20201121001036.8560-2-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121001036.8560-1-sean.v.kelley@intel.com>
References: <20201121001036.8560-1-sean.v.kelley@intel.com>
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

