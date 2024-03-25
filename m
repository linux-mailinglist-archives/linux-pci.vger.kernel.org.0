Return-Path: <linux-pci+bounces-5135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D941688B5AF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 00:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FFD91F639ED
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 23:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55984FC9;
	Mon, 25 Mar 2024 23:59:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E4384D3F;
	Mon, 25 Mar 2024 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411158; cv=none; b=twuPSgNC2cFyvhwZRWp+eK0WiJke6LOG2/gysu4o5lBbHJ2XwZ48LhdMU2TLNngaXS01KpyGPAwCC27Jf/E7Z4Hn532Qdq51zwN8vCbJ9eqMGJgFPyJodqo8a+u0C8HTZSZC3f9kWoAIwiuaP18+uyER1TFfFR3WqMnu3f0mAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411158; c=relaxed/simple;
	bh=sJsKnYoV1Hlt1lUqxBSXv168upPf3QW9QRynQHgorbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BE2+qAS4IKSmsJsEuv8gedskMw2qeOdCZ2OT9owGXIyBo4lxgpSrOtPHprLCNPVHodHU8OW/7XkEwiSvTBohTVcxk0uhnH4ShE3jzha2Xrq5Zr9xHY1Y8GX0Bu7aJtRTzqQ1MTY7cWy9/AsLyTsXG4+TppLMkXjde+Zlw4OVhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD41C433C7;
	Mon, 25 Mar 2024 23:59:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	bhelgaas@google.com,
	lukas@wunner.de
Subject: [PATCH v2 1/3] PCI: Add check for CXL Secondary Bus Reset
Date: Mon, 25 Mar 2024 16:58:01 -0700
Message-ID: <20240325235914.1897647-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240325235914.1897647-1-dave.jiang@intel.com>
References: <20240325235914.1897647-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per CXL spec r3.1 8.1.5.2, secondary bus reset is masked unless the
"Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
the CXL Port Control Extensions register by returning -ENOTTY.

With the current behavior, the bus_reset would appear to have executed
successfully, however the operation is actually masked if the "Unmask
SBR" bit is set with the default value. The intention is to inform the
user that SBR for the CXL device is masked and will not go through.

The expectation is that if a user overrides the "Unmask SBR" via a
user tool such as setpci then they can trigger a bus reset successfully.

Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Rename is_cxl_device() to pci_is_cxl(). (Lukas)
- Inverse xmas tree var declaration for is_cxl_port_sbr_masked(). (Lukas)
- Return -ENOTTY on error of reset method. (Lukas)
- Use pci_upstream_bridge() instead of dev->bus->self. (Lukas)
- Additional explanation in commit log on behavior. (Lukas)
---
 drivers/cxl/cxlpci.h          |  2 --
 drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  7 ++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 93992a1c8eec..55be4dccbed0 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -13,10 +13,8 @@
  * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
-#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
-#define CXL_DVSEC_PCIE_DEVICE					0
 #define   CXL_DVSEC_CAP_OFFSET		0xA
 #define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
 #define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..259e5d6538bb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+static bool pci_is_cxl(struct pci_dev *dev)
+{
+	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
+					 CXL_DVSEC_PCIE_DEVICE);
+}
+
+static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
+{
+	int dvsec;
+	u16 reg;
+	int rc;
+
+	/*
+	 * No DVSEC found, must not be CXL port.
+	 */
+	dvsec = pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
+					  CXL_DVSEC_PCIE_PORT);
+	if (!dvsec)
+		return false;
+
+	rc = pci_read_config_word(dev, dvsec + CXL_DVSEC_PORT_CONTROL, &reg);
+	if (rc)
+		return true;
+
+	/*
+	 * CXL spec r3.1 8.1.5.2
+	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
+	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
+	 * Control gets set to 1.
+	 */
+	if (reg & CXL_DVSEC_PORT_CONTROL_UNMASK_SBR)
+		return false;
+
+	return true;
+}
+
 static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 {
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
 	int rc;
 
+	/* If it's a CXL port and the SBR control is masked, fail the SBR */
+	if (pci_is_cxl(dev) && bridge && is_cxl_port_sbr_masked(bridge)) {
+		if (probe)
+			return 0;
+
+		return -ENOTTY;
+	}
+
 	rc = pci_dev_reset_slot_function(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..5f2c66987299 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1148,4 +1148,11 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
+/* Compute Express Link (CXL) */
+#define PCI_DVSEC_VENDOR_ID_CXL				0x1e98
+#define CXL_DVSEC_PCIE_DEVICE				0
+#define CXL_DVSEC_PCIE_PORT				3
+#define CXL_DVSEC_PORT_CONTROL				0x0c
+#define  CXL_DVSEC_PORT_CONTROL_UNMASK_SBR		0x00000001
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.44.0


