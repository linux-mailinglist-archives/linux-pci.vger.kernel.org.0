Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFCC990BA8
	for <lists+linux-pci@lfdr.de>; Sat, 17 Aug 2019 02:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfHQAN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 20:13:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:6694 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfHQANZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 20:13:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 17:13:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,395,1559545200"; 
   d="scan'208";a="168195018"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2019 17:13:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 8/8] PCI: Skip Enhanced Allocation (EA) initialization for VF device
Date:   Fri, 16 Aug 2019 17:10:22 -0700
Message-Id: <336c3f97a226f936ee3581b33d40ba00a8a7caa0.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1565997310.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced Allocation
Capability. So skip pci_ea_init() for virtual devices.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1b27b5af3d55..266600a11769 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3025,6 +3025,13 @@ void pci_ea_init(struct pci_dev *dev)
 	int offset;
 	int i;
 
+	/*
+	 * Per PCIe r4.0, sec 9.3.6, VF must not implement Enhanced
+	 * Allocation Capability.
+	 */
+	if (dev->is_virtfn)
+		return;
+
 	/* find PCI EA capability in list */
 	ea = pci_find_capability(dev, PCI_CAP_ID_EA);
 	if (!ea)
-- 
2.21.0

