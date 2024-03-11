Return-Path: <linux-pci+bounces-4731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0FB87899D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 21:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F23B2115B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 20:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2060C56B72;
	Mon, 11 Mar 2024 20:41:48 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051EC56B6F;
	Mon, 11 Mar 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189708; cv=none; b=kW89QuVqEEageQZ3AvAu2qxCzSV7Kh5jywgaXTZkBnJTTRkyAUafbJ2eewJVQhaXP+ebDCLNYVEFAiIAFjCMaZquLc2TOSA2ZFoCxydr/xKIqcExLhFwcGI9gNorVk7ATXaY8iOS5koZDk39WhhCf2pQ0zIYeS33/rDR0ED3vy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189708; c=relaxed/simple;
	bh=2M4ITpyEL+gdUTWCafXQu5fJYPdFIH6LMSuR0+oAl+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzTFGiB8ljoaRHnLSe1GUCGkAjz28z9+Fai9nXXRJiw0loAlIkvLlaa5StXYgGspaSSlEcPxVIXvxy9K9SheA4HU3fHC2e2vDLVAIT00cv5WwvXobJquZX7ZS6mQXOtIia0TK2tIZJcgLVfEwtQc5OYrdyGn8qlKqrFOfegQ4PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0DC5C433C7;
	Mon, 11 Mar 2024 20:41:46 +0000 (UTC)
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
Subject: [PATCH 1/3] PCI: Add check for CXL Secondary Bus Reset
Date: Mon, 11 Mar 2024 13:39:53 -0700
Message-ID: <20240311204132.62757-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240311204132.62757-1-dave.jiang@intel.com>
References: <20240311204132.62757-1-dave.jiang@intel.com>
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
the CXL Port Control Extensions regiser by returning -EPERM.

The expectation is that if a user overrides the "Unmask SBR" via a
user tool such as setpci, they can trigger a bus reset after that.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/cxlpci.h          |  2 --
 drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  7 ++++++
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 711b05d9a370..8d7952d7ca59 100644
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
index c3585229c12a..5e5550f54053 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5347,10 +5347,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+static bool is_cxl_device(struct pci_dev *dev)
+{
+	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
+					 CXL_DVSEC_PCIE_DEVICE);
+}
+
+static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
+{
+	int dvsec;
+	int rc;
+	u16 reg;
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
 	int rc;
 
+	/* If it's a CXL port and the SBR control is masked, fail the SBR */
+	if (is_cxl_device(dev) && dev->bus->self &&
+	    is_cxl_port_sbr_masked(dev->bus->self)) {
+		if (probe)
+			return 0;
+
+		return -EPERM;
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


