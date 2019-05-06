Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8C152A7
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2019 19:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEFRWS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 May 2019 13:22:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:31140 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbfEFRWR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 May 2019 13:22:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 10:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="230014473"
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by orsmga001.jf.intel.com with ESMTP; 06 May 2019 10:22:15 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v2 3/5] PCI/ATS: Skip VF ATS initialization if PF does not implement it
Date:   Mon,  6 May 2019 10:20:05 -0700
Message-Id: <21d93b3312418c1e28aeec238ef855c72efeb96a.1557162861.git.sathyanarayanan.kuppuswamy@linux.intel.com>
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

If PF does not implement ATS and VF implements/uses it, it might lead to
runtime issues. Also, as per spec r4.0, sec 9.3.7.8, PF should implement
ATS if VF implements it. So add additional check to confirm given device
aligns with the spec.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/ats.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index e7a904e347c3..718e6f414680 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -19,6 +19,7 @@
 void pci_ats_init(struct pci_dev *dev)
 {
 	int pos;
+	struct pci_dev *pdev;
 
 	if (pci_ats_disabled())
 		return;
@@ -27,6 +28,17 @@ void pci_ats_init(struct pci_dev *dev)
 	if (!pos)
 		return;
 
+	/*
+	 * Per PCIe r4.0, sec 9.3.7.8, if VF implements Address Translation
+	 * Services (ATS) Extended Capability then corresponding PF should
+	 * also implement it.
+	 */
+	if (dev->is_virtfn) {
+		pdev = pci_physfn(dev);
+		if (!pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ATS))
+			return;
+	}
+
 	dev->ats_cap = pos;
 }
 
-- 
2.20.1

