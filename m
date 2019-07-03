Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2837B5ED98
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 22:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbfGCUcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 16:32:31 -0400
Received: from mga04.intel.com ([192.55.52.120]:60933 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbfGCUcU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 16:32:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 13:32:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,448,1557212400"; 
   d="scan'208";a="158089422"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga008.jf.intel.com with ESMTP; 03 Jul 2019 13:32:18 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 6/8] PCI/AER: Allow clearing Error Status Register in FF mode
Date:   Wed,  3 Jul 2019 13:29:53 -0700
Message-Id: <8ec91f8bd8774d0d1a54d06f1f8f3ef76eee24a3.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1562185606.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
---
 drivers/pci/pcie/aer.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47d04fe..ae5eed084ae5 100644
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
-- 
2.21.0

