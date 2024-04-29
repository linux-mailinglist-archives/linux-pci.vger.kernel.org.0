Return-Path: <linux-pci+bounces-6814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A35728B65CE
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 00:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF7EBB213A5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 22:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5813AEE;
	Mon, 29 Apr 2024 22:36:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F363364;
	Mon, 29 Apr 2024 22:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714430179; cv=none; b=nvboBtFLvw+b5KqLqPD6esCkUz8MEH5SyoCK7uFEc9aMTmTo4OgCMPRNDSEWG9Si1T9Vb14wSFl753Ks0aIVOP6ZcC/gUWxJxSvBvH866ea1y12hxpKP58jdVy9ZjnmIJ9t1FUjG811l3veax+3K7OsFgTP+A/NdeC+/vWU47Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714430179; c=relaxed/simple;
	bh=0Kf+BXQhJU/PXAg39me+l75SyKvYmPMh+wUMQ6ceJOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0AHFpj2DcLe2XFPB24QcK7BXnxdK0RGEg28fSe0JIbJ1t3HFcx1NauHIgU7QJJ5zEdtiPqvSVJ8Mu+5iz9uZCmZ3P322va08wUa/7WvRtvyDV/ddejE4/0EM9Stb7/ENfdiPAVGXmnts+A3Tf0pHO/c8a4vswiwLBxbPiZstaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC78C4AF18;
	Mon, 29 Apr 2024 22:36:18 +0000 (UTC)
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
	lukas@wunner.de,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v5 2/4] PCI: Add check for CXL Secondary Bus Reset
Date: Mon, 29 Apr 2024 15:35:30 -0700
Message-ID: <20240429223610.1341811-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429223610.1341811-1-dave.jiang@intel.com>
References: <20240429223610.1341811-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per CXL spec r3.1 8.1.5.2, Secondary Bus Reset (SBR) is masked unless the
"Unmask SBR" bit is set. Add a check to the PCI secondary bus reset
path to fail the CXL SBR request if the "Unmask SBR" bit is clear in
the CXL Port Control Extensions register by returning -ENOTTY.

Otherwise when the "Unmask SBR" bit is set to 0 (default), the bus_reset
would appear to have executed successfully. However the operation is
actually masked. The intention is to inform the user that SBR for the CXL
device is masked and will not go through.

If the "Unmask SBR" bit is set to 1, then the bus reset will execute
successfully.

Add the locking of the upstream bridge in pci_reset_function() to ensure
the locking order of locking the bridge then locking the device. The
bridge configuration needs to be consistent for a CXL device. This should
not impact PCI devices.

Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Add locking of upstream bridge.
---
 drivers/pci/pci.c             | 57 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  5 +++
 2 files changed, 62 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..d33228088b0a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+static u16 cxl_port_dvsec(struct pci_dev *dev)
+{
+	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
+					 PCI_DVSEC_CXL_PORT);
+}
+
+static bool cxl_sbr_masked(struct pci_dev *dev)
+{
+	u16 dvsec, reg;
+	int rc;
+
+	/*
+	 * No DVSEC found, either is not a CXL port, or not connected in which
+	 * case mask state is a nop (CXL r3.1 sec 9.12.3 "Enumerating CXL RPs
+	 * and DSPs"
+	 */
+	dvsec = cxl_port_dvsec(dev);
+	if (!dvsec)
+		return false;
+
+	rc = pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	if (rc || PCI_POSSIBLE_ERROR(reg))
+		return false;
+
+	/*
+	 * CXL spec r3.1 8.1.5.2
+	 * When 0, SBR bit in Bridge Control register of this Port has no effect.
+	 * When 1, the Port shall generate hot reset when SBR bit in Bridge
+	 * Control gets set to 1.
+	 */
+	if (reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)
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
+	if (bridge && cxl_sbr_masked(bridge)) {
+		if (probe)
+			return 0;
+
+		return -ENOTTY;
+	}
+
 	rc = pci_dev_reset_slot_function(dev, probe);
 	if (rc != -ENOTTY)
 		return rc;
@@ -5245,11 +5290,20 @@ void pci_init_reset_methods(struct pci_dev *dev)
  */
 int pci_reset_function(struct pci_dev *dev)
 {
+	struct pci_dev *bridge;
 	int rc;
 
 	if (!pci_reset_supported(dev))
 		return -ENOTTY;
 
+	bridge = pci_upstream_bridge(dev);
+	/*
+	 * If there's no upstream bridge, then no locking is needed since there is no
+	 * upstream bridge configuration to hold consistent.
+	 */
+	if (bridge)
+		pci_dev_lock(bridge);
+
 	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
@@ -5258,6 +5312,9 @@ int pci_reset_function(struct pci_dev *dev)
 	pci_dev_restore(dev);
 	pci_dev_unlock(dev);
 
+	if (bridge)
+		pci_dev_unlock(bridge);
+
 	return rc;
 }
 EXPORT_SYMBOL_GPL(pci_reset_function);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a39193213ff2..d61fa43662e3 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1148,4 +1148,9 @@
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		0x00ff0000
 #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX	0xff000000
 
+/* Compute Express Link (CXL) */
+#define PCI_DVSEC_CXL_PORT				3
+#define PCI_DVSEC_CXL_PORT_CTL				0x0c
+#define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
+
 #endif /* LINUX_PCI_REGS_H */
-- 
2.44.0


