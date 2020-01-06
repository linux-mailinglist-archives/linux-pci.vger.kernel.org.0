Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC7ED131B8D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2020 23:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFWhY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jan 2020 17:37:24 -0500
Received: from mga01.intel.com ([192.55.52.88]:28167 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgAFWhY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jan 2020 17:37:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 14:37:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="210925889"
Received: from unknown (HELO skalakox.lm.intel.com) ([10.232.116.60])
  by orsmga007.jf.intel.com with ESMTP; 06 Jan 2020 14:37:23 -0800
From:   Sushma Kalakota <sushmax.kalakota@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: [PATCH 1/2] PCI: vmd: Add device id for VMD device 8086:4C3D
Date:   Mon,  6 Jan 2020 15:41:21 -0700
Message-Id: <20200106224122.3231-2-sushmax.kalakota@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106224122.3231-1-sushmax.kalakota@intel.com>
References: <20200106224122.3231-1-sushmax.kalakota@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for this VMD device which supports the bus
restriction mode.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Sushma Kalakota <sushmax.kalakota@intel.com>
---
 drivers/pci/controller/vmd.c | 2 ++
 include/linux/pci_ids.h      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 212842263f55..2b192e72f550 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -868,6 +868,8 @@ static const struct pci_device_id vmd_ids[] = {
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_4C3D),
+		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
 		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2302d133af6f..8b3bc4b545b9 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2957,6 +2957,7 @@
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
 #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
 #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
+#define PCI_DEVICE_ID_INTEL_VMD_4C3D	0x4c3d
 #define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
 #define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
 #define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
-- 
2.17.1

