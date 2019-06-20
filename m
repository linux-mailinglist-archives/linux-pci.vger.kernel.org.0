Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D414DB84
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFTUlM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 16:41:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:48180 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfFTUk7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 16:40:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 13:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,398,1557212400"; 
   d="scan'208";a="311788176"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga004.jf.intel.com with ESMTP; 20 Jun 2019 13:40:56 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 7/7] PCI: Skip Enhanced Allocation (EA) initialization for VF device
Date:   Thu, 20 Jun 2019 13:38:48 -0700
Message-Id: <6ecc59da77bbcacbee63230f121b9af5758f59e9.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1561061640.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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
index 8abc843b1615..c299ab470351 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2986,6 +2986,13 @@ void pci_ea_init(struct pci_dev *dev)
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

