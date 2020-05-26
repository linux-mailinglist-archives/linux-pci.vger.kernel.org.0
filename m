Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175961E338E
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 01:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390018AbgEZXSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 19:18:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:56937 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389709AbgEZXSn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 19:18:43 -0400
IronPort-SDR: nNlkgZUM/wU66ITebIFq4Abm+NY/cH6dQ8nvVBew7atrU8RshaXeTH8oThO4x1mO3IFBe+6cEg
 42zfx0HS52vA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 16:18:42 -0700
IronPort-SDR: 0WMRdAa0R1/NaC4gtqe1zVXWIsl1U2dSQ6LHaXpuWmXtBBgtJZEL1wsTI+oyxT3iIcIZsSCPqG
 2U6ycbHI7s4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="291378684"
Received: from zalvear-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.67.58])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 16:18:42 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 2/5] PCI/AER: Remove redundant dev->aer_cap checks.
Date:   Tue, 26 May 2020 16:18:26 -0700
Message-Id: <d5ccc7a060ec9cdc234bdae7df8a0a4410f13f42.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

