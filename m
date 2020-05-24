Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8371E032E
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 23:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388380AbgEXVci (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 17:32:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:9322 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388341AbgEXVch (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 May 2020 17:32:37 -0400
IronPort-SDR: 3u3pCgHvk5Y3+AYxtVLbw0xCvhDM0/ZhRqXqHYNUTONmbdHCYu/qzIGZTZG4F7Ch0f6NR6cCY1
 kdfYrcalKgww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 14:32:37 -0700
IronPort-SDR: XnCXhDvYZTds7OVsIp0e7fhm2dVK1cKFELNJ3/53gr/u+eGjsGRr0HeJ1Vhhjr8YxsrPExNx6s
 Fx8mocju/WWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="467875393"
Received: from tjrondo-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.20.235])
  by fmsmga006.fm.intel.com with ESMTP; 24 May 2020 14:32:36 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 2/5] PCI/AER: Remove redundant dev->aer_cap checks.
Date:   Sun, 24 May 2020 14:32:31 -0700
Message-Id: <d5ccc7a060ec9cdc234bdae7df8a0a4410f13f42.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590355824.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

