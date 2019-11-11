Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B3F7930
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKKQxL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 11:53:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:29003 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKQxK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Nov 2019 11:53:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 08:53:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="193989229"
Received: from jderrick-mobl.amr.corp.intel.com ([10.232.115.143])
  by orsmga007.jf.intel.com with ESMTP; 11 Nov 2019 08:53:09 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Keith Busch <kbusch@kernel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/2] PCI: vmd: Add bus 224-255 restriction decode
Date:   Mon, 11 Nov 2019 09:53:01 -0700
Message-Id: <20191111165302.29636-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191111165302.29636-1-jonathan.derrick@intel.com>
References: <20191111165302.29636-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD bus restrictions are required when IO fabric is multiplexed such
that VMD cannot use the entire bus range. This patch adds another bus
restriction decode bit that can be set by firmware to restrict the VMD
bus range from 224-255.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a35d3f3..db00a71 100644
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
+			case(1):
+				vmd->busn_start = 128;
+				break;
+			case(2):
+				vmd->busn_start = 224;
+				break;
+			case(3):
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

