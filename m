Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8309F1AF
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 19:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfH0RdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 13:33:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:62460 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730339AbfH0Rck (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 13:32:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 10:32:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="171269805"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2019 10:32:38 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v8 5/8] PCI/AER: Allow clearing Error Status Register in FF mode
Date:   Tue, 27 Aug 2019 10:29:27 -0700
Message-Id: <7d641d35fe98cd95e92c0236bd151fa779be4ab6.1566865502.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1566865502.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1566865502.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification r3.2 Downstream Port Containment
Related Enhancements ECN, sec 4.5.1, table 4-6, Error Disconnect
Recover (EDR) support allows OS to handle error recovery and
clearing Error Registers even in FF mode. So remove FF mode checks in
pci_cleanup_aer_uncorrect_error_status(), pci_aer_clear_fatal_status()
and pci_cleanup_aer_error_status_regs() functions.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Keith Busch <keith.busch@intel.com>
---
 drivers/pci/pcie/aer.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47d04fe..e1509bb900c5 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -383,9 +383,6 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
 	/* Clear status bits for ERR_NONFATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
@@ -406,9 +403,6 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
 	if (!pos)
 		return;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return;
-
 	/* Clear status bits for ERR_FATAL errors only */
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
 	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
@@ -430,9 +424,6 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	if (!pos)
 		return -EIO;
 
-	if (pcie_aer_get_firmware_first(dev))
-		return -EIO;
-
 	port_type = pci_pcie_type(dev);
 	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
 		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
@@ -455,7 +446,8 @@ void pci_aer_init(struct pci_dev *dev)
 	if (dev->aer_cap)
 		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
 
-	pci_cleanup_aer_error_status_regs(dev);
+	if (!pcie_aer_get_firmware_first(dev))
+		pci_cleanup_aer_error_status_regs(dev);
 }
 
 void pci_aer_exit(struct pci_dev *dev)
-- 
2.21.0

