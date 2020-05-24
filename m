Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 092C11E0300
	for <lists+linux-pci@lfdr.de>; Sun, 24 May 2020 23:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbgEXV2M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 24 May 2020 17:28:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:34175 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387830AbgEXV2L (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 24 May 2020 17:28:11 -0400
IronPort-SDR: n1CmASJlyqYdz7N/A4TyUfjCwe3hQpwQiOFRD+h36T1CImritwYY45RNXwMZpIWOI8kmp9pGa3
 ZdRDS3BEErbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2020 14:28:11 -0700
IronPort-SDR: oA1HXYqNRtU5SO0w4M7WMxjZSPVf72bUlJjupsVglW/ALyMQp7I4SftHlMgWZXHjZYNK17x1VX
 2OVoWRXrebIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,431,1583222400"; 
   d="scan'208";a="254928548"
Received: from tjrondo-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.251.20.235])
  by orsmga007.jf.intel.com with ESMTP; 24 May 2020 14:28:09 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 1/5] PCI/AER: Remove redundant pci_is_pcie() checks.
Date:   Sun, 24 May 2020 14:27:52 -0700
Message-Id: <361c622eabe5b845b8092e0bec04a3a2c262cb38.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1590355211.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

