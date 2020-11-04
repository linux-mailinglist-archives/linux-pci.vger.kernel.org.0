Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A924F2A70E4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 00:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgKDXAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 18:00:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:56873 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730766AbgKDXAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 18:00:36 -0500
IronPort-SDR: pmNFUc+vmZA5/CAupVPBo2CGkYqlqRq5R1r7o2KmXI6Mg7wAFjOyQZqMzce6ln92b+Re3e66OA
 I9wNV/DuuWAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="169404364"
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="169404364"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:00:35 -0800
IronPort-SDR: 1ZAvSP+uA/DPn75+cuUFzXSZbyY027P3S4H1+MuPIPfACs0uZudoUTg+MtvVDb2HBVpi8+Fy6+
 VJsCButS9g1A==
X-IronPort-AV: E=Sophos;i="5.77,451,1596524400"; 
   d="scan'208";a="529124050"
Received: from lvasam-pc.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.38.163])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 15:00:34 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH V2] AER: aer_root_reset() non-native handling
Date:   Wed,  4 Nov 2020 15:00:17 -0800
Message-Id: <20201104230017.303053-1-sean.v.kelley@intel.com>
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
Changes since V1 [1]:

Noted lack of historical context on isolation of both the
pci_bus_error_reset() and the clearing of Root Error Status. In fact,
the call to aer_enable_rootport() likewise disables system error generation
in response to error messages around the clearing of the error status. So
retained the wrapping of the  "clear, reset, enable".

[1] https://lore.kernel.org/linux-pci/20201030223443.165783-1-sean.v.kelley@intel.com/

Thanks,

Sean
---
 drivers/pci/pcie/aer.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..6d4f70ec8546 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1358,26 +1358,29 @@ static int aer_probe(struct pcie_device *dev)
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
+	int rc = 0;
 	u32 reg32;
-	int rc;
-

-	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	if (pcie_aer_is_native(dev)) {
+		/* Disable Root's interrupt in response to error messages */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	}

 	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset\n");
+	pci_info(dev, "Root Port link has been reset (%d)\n", rc);

-	/* Clear Root Error Status */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
+	if (pcie_aer_is_native(dev)) {
+		/* Clear Root Error Status */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);

-	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+		/* Enable Root Port's interrupt in response to error messages */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	}

 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
--
2.29.2

