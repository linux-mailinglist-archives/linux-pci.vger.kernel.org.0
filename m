Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8B823137B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 22:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgG1UHG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 16:07:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:63207 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbgG1UHF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 16:07:05 -0400
IronPort-SDR: VtdM7z6sunM10H8y5QU1/J6D/Utg/U2/LDhJEUjIJgfUzB4qbnzXGMeMeGaOzht3orosxOyhtq
 NIufSLgu9dJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151287332"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="151287332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 13:07:04 -0700
IronPort-SDR: 9XWzIm+yBQfNrnPV9HJHICmHVOze31hntQjVMnPqa0K7/BcGM4ldrwfOVSSvNGEPaeZHPRxX18
 1rwfsyHru+Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="312756378"
Received: from unknown (HELO nsgsw-wilsonpoint.lm.intel.com) ([10.232.116.124])
  by fmsmga004.fm.intel.com with ESMTP; 28 Jul 2020 13:07:03 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH 2/6] PCI: vmd: Create bus offset configuration helper
Date:   Tue, 28 Jul 2020 13:49:41 -0600
Message-Id: <20200728194945.14126-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728194945.14126-1-jonathan.derrick@intel.com>
References: <20200728194945.14126-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moves the bus offset configuration discovery code to a new helper.
Modifies the bus offset 2-bit decode switch to have a 0 case and a
default error case, just in case the field is expanded in future
hardware.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 53 ++++++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 44b2db789eff..a462719af12a 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -471,6 +471,35 @@ static int vmd_get_phys_offsets(struct vmd_dev *vmd, bool native_hint,
 	return 0;
 }
 
+static int vmd_get_bus_number_start(struct vmd_dev *vmd)
+{
+	struct pci_dev *dev = vmd->dev;
+	u16 reg;
+
+	pci_read_config_word(dev, PCI_REG_VMCAP, &reg);
+	if (BUS_RESTRICT_CAP(reg)) {
+		pci_read_config_word(dev, PCI_REG_VMCONFIG, &reg);
+
+		switch (BUS_RESTRICT_CFG(reg)) {
+		case 0:
+			vmd->busn_start = 0;
+			break;
+		case 1:
+			vmd->busn_start = 128;
+			break;
+		case 2:
+			vmd->busn_start = 224;
+			break;
+		default:
+			pci_err(dev, "Unknown Bus Offset Setting (%d)\n",
+				BUS_RESTRICT_CFG(reg));
+			return -ENODEV;
+		}
+	}
+
+	return 0;
+}
+
 static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 {
 	struct pci_sysdata *sd = &vmd->sysdata;
@@ -506,27 +535,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	 * limits the bus range to between 0-127, 128-255, or 224-255
 	 */
 	if (features & VMD_FEAT_HAS_BUS_RESTRICTIONS) {
-		u16 reg16;
-
-		pci_read_config_word(vmd->dev, PCI_REG_VMCAP, &reg16);
-		if (BUS_RESTRICT_CAP(reg16)) {
-			pci_read_config_word(vmd->dev, PCI_REG_VMCONFIG,
-					     &reg16);
-
-			switch (BUS_RESTRICT_CFG(reg16)) {
-			case 1:
-				vmd->busn_start = 128;
-				break;
-			case 2:
-				vmd->busn_start = 224;
-				break;
-			case 3:
-				pci_err(vmd->dev, "Unknown Bus Offset Setting\n");
-				return -ENODEV;
-			default:
-				break;
-			}
-		}
+		ret = vmd_get_bus_number_start(vmd);
+		if (ret)
+			return ret;
 	}
 
 	res = &vmd->dev->resource[VMD_CFGBAR];
-- 
2.27.0

