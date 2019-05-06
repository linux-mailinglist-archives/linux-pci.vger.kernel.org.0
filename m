Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D34152AE
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2019 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfEFRW3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 May 2019 13:22:29 -0400
Received: from mga07.intel.com ([134.134.136.100]:31139 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbfEFRWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 13:22:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 10:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="230014478"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2019 10:22:15 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 5/5] PCI: Skip Enhanced Allocation (EA) initalization for VF device
Date:   Mon,  6 May 2019 10:20:07 -0700
Message-Id: <9370d51d14d9cd0ad4101db14e808fa3ab7efcf5.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 766f5779db92..0ba3930e3b54 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2976,6 +2976,13 @@ void pci_ea_init(struct pci_dev *dev)
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
2.20.1

