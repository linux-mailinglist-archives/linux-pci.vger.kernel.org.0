Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC6E1E0305
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 23:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbgEXV2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 17:28:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:34177 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388250AbgEXV2M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 May 2020 17:28:12 -0400
IronPort-SDR: 9ZftHyakhb3tLuBZqDHAzpBBn5cRqv88ZkeHOaRGU28ZJSNobzTb2whFkQbZVGBTxjO5sbZKEX
 f0iPXfW4EKmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 14:28:11 -0700
IronPort-SDR: q0OVgiPtBcxQTvSaN3wCptIVNUgQULGQrQadpAo0Pcec/Ek0PcE/DF3wNVhdLQSRNmL/pZ9le7
 OlcuIgLz7gMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="254928550"
Received: from tjrondo-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.20.235])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2020 14:28:10 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 2/5] PCI/AER: Remove redundant dev->aer_cap checks.
Date:   Sun, 24 May 2020 14:27:53 -0700
Message-Id: <d5ccc7a060ec9cdc234bdae7df8a0a4410f13f42.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

pcie_aer_get_firmware_first() includes check for dev->aer_cap.
So remove redundant dev->aer_cap checks.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 7c4294454df0..5f5ffe2f0986 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -322,9 +322,6 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
-	if (!dev->aer_cap)
-		return -EIO;
-
 	return pcie_capability_set_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AER_FLAGS);
 }
 EXPORT_SYMBOL_GPL(pci_enable_pcie_error_reporting);
@@ -349,13 +346,9 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
 
 int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
 {
-	int pos;
+	int pos = dev->aer_cap;
 	u32 status, sev;
 
-	pos = dev->aer_cap;
-	if (!pos)
-		return -EIO;
-
 	if (pcie_aer_get_firmware_first(dev))
 		return -EIO;
 
@@ -372,13 +365,9 @@ EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
 
 void pci_aer_clear_fatal_status(struct pci_dev *dev)
 {
-	int pos;
+	int pos = dev->aer_cap;
 	u32 status, sev;
 
-	pos = dev->aer_cap;
-	if (!pos)
-		return;
-
 	if (pcie_aer_get_firmware_first(dev))
 		return;
 
-- 
2.17.1

