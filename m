Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6401E3397
	for <lists+linux-pci@lfdr.de>; Wed, 27 May 2020 01:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbgEZXSq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 19:18:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:56936 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389413AbgEZXSm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 26 May 2020 19:18:42 -0400
IronPort-SDR: +jcjAoObwYdDZGbKCjAvavZFRNHWVod61lN7TssOJQcQZ84jkks7xaJsMfPZ197C42lXpEjrR1
 du48DEBv09Ew==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 16:18:42 -0700
IronPort-SDR: mxGvSFyMo67arEAcStGqpHx8ZXKYa6tWg7y27Vl63nQ7RU2KKmYqKgHW7RJ26EnMYhvqYT85B+
 w/Z1BQ2E1eHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,439,1583222400"; 
   d="scan'208";a="291378680"
Received: from zalvear-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.254.67.58])
  by fmsmga004.fm.intel.com with ESMTP; 26 May 2020 16:18:41 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v4 1/5] PCI/AER: Remove redundant pci_is_pcie() checks.
Date:   Tue, 26 May 2020 16:18:25 -0700
Message-Id: <361c622eabe5b845b8092e0bec04a3a2c262cb38.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590534843.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

AER is a PCIe Extended Capability. So checking for dev->aer_cap
will implicitly include check for PCIe device. So remove redundant
pci_is_pcie() checks.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index efc26773cc6d..7c4294454df0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -139,9 +139,6 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 	int pos;
 	u32 reg32;
 
-	if (!pci_is_pcie(dev))
-		return -ENODEV;
-
 	pos = dev->aer_cap;
 	if (!pos)
 		return -ENODEV;
@@ -167,9 +164,6 @@ static int disable_ecrc_checking(struct pci_dev *dev)
 	int pos;
 	u32 reg32;
 
-	if (!pci_is_pcie(dev))
-		return -ENODEV;
-
 	pos = dev->aer_cap;
 	if (!pos)
 		return -ENODEV;
@@ -308,7 +302,7 @@ static void aer_set_firmware_first(struct pci_dev *pci_dev)
 
 int pcie_aer_get_firmware_first(struct pci_dev *dev)
 {
-	if (!pci_is_pcie(dev))
+	if (!dev->aer_cap)
 		return 0;
 
 	if (pcie_ports_native)
@@ -411,9 +405,6 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
 	u32 status;
 	int port_type;
 
-	if (!pci_is_pcie(dev))
-		return -ENODEV;
-
 	pos = dev->aer_cap;
 	if (!pos)
 		return -EIO;
-- 
2.17.1

