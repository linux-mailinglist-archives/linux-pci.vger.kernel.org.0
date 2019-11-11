Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66767F792F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfKKQxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 11:53:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:29003 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKQxL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 11:53:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 08:53:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="193989237"
Received: from jderrick-mobl.amr.corp.intel.com ([10.232.115.143])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2019 08:53:10 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/2] PCI: vmd: Add device id for VMD device 8086:9A0B
Date:   Mon, 11 Nov 2019 09:53:02 -0700
Message-Id: <20191111165302.29636-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111165302.29636-1-jonathan.derrick@intel.com>
References: <20191111165302.29636-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds support for this VMD device which supports the bus
restriction mode.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 2 ++
 include/linux/pci_ids.h      | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index db00a71..cec7872 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -868,6 +868,8 @@ static int vmd_resume(struct device *dev)
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
+		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 21a5724..3ad3d52 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3006,6 +3006,7 @@
 #define PCI_DEVICE_ID_INTEL_84460GX	0x84ea
 #define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
 #define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
+#define PCI_DEVICE_ID_INTEL_VMD_9A0B	0x9A0B
 #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152
 
 #define PCI_VENDOR_ID_SCALEMP		0x8686
-- 
1.8.3.1

