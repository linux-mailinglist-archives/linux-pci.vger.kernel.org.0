Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0AF9915
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 19:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbfKLStn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 13:49:43 -0500
Received: from mga03.intel.com ([134.134.136.65]:15388 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfKLStn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Nov 2019 13:49:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2019 10:49:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,297,1569308400"; 
   d="scan'208";a="198183592"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.117.44])
  by orsmga008.jf.intel.com with ESMTP; 12 Nov 2019 10:49:42 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 1/2] PCI: vmd: Add bus 224-255 restriction decode
Date:   Tue, 12 Nov 2019 05:47:52 -0700
Message-Id: <1573562873-96828-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573562873-96828-1-git-send-email-jonathan.derrick@intel.com>
References: <1573562873-96828-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD bus restrictions are required when IO fabric is multiplexed such
that VMD cannot use the entire bus range. This patch adds another bus
restriction decode bit that can be set by firmware to restrict the VMD
bus range to between 224-255.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a35d3f3..15302a1 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -602,16 +602,30 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 
 	/*
 	 * Certain VMD devices may have a root port configuration option which
-	 * limits the bus range to between 0-127 or 128-255
+	 * limits the bus range to between 0-127, 128-255, or 224-255
 	 */
 	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
-		u32 vmcap, vmconfig;
-
-		pci_read_config_dword(vmd->dev, PCI_REG_VMCAP, &vmcap);
-		pci_read_config_dword(vmd->dev, PCI_REG_VMCONFIG, &vmconfig);
-		if (BUS_RESTRICT_CAP(vmcap) &&
-		    (BUS_RESTRICT_CFG(vmconfig) == 0x1))
-			vmd->busn_start = 128;
+		u16 reg16;
+
+		pci_read_config_word(vmd->dev, PCI_REG_VMCAP, &reg16);
+		if (BUS_RESTRICT_CAP(reg16)) {
+			pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG,
+					     &reg16);
+
+			switch (BUS_RESTRICT_CFG(reg16)) {
+			case 1:
+				vmd->busn_start = 128;
+				break;
+			case 2:
+				vmd->busn_start = 224;
+				break;
+			case 3:
+				pci_err(vmd->dev, "Unknown Bus Offset Setting\n");
+				return -ENODEV;
+			default:
+				break;
+			}
+		}
 	}
 
 	res = &vmd->dev->resource[VMD_CFGBAR];
-- 
1.8.3.1

