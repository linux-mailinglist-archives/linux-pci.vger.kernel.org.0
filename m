Return-Path: <linux-pci+bounces-5576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97248896065
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 01:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97E31C21E6F
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 23:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E4415A484;
	Tue,  2 Apr 2024 23:48:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5E758ACC;
	Tue,  2 Apr 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101733; cv=none; b=Ljb9F5mViG7hgXM59WiDfhxAggzxZ8Ozp9f1lXYJ5b5Cty7CBGPH4X1rB0QzSuLh79KwRSRrMgS1uWDyF4zsnMf0mLtoKHRArBDGMwmfXvyy1yf7BHHkYakCkeVXOE4XFXCRQn7vvjv6ktomnHxzufcG3UgSCZWY3c9koBKILKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101733; c=relaxed/simple;
	bh=seGLMMmhioin8O0/jB3zdeVcSR3rQgk6X9PPfNfowVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYcoXNKE5gliyPdNHDxWs0cdmj1VNyl5L1BiqM1EuKnaVbIvdyPZo1dIpfsgPSIzb/+dFwadpCtyXQ2XF6XNKSDf2PM86ufKCxkY+oDTP/z4Z5aUauiWkYqR+SrmU72jCwH8O68fBC487/Mgp3vP6ezqVyWJSB/m26Mk476F0sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6290CC43390;
	Tue,  2 Apr 2024 23:48:52 +0000 (UTC)
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
Subject: [PATCH v3 2/4] PCI: Add check for CXL Secondary Bus Reset
Date: Tue,  2 Apr 2024 16:45:30 -0700
Message-ID: <20240402234848.3287160-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402234848.3287160-1-dave.jiang@intel.com>
References: <20240402234848.3287160-1-dave.jiang@intel.com>
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

When the "Unmask SBR" bit is set to 0 (default), the bus_reset would
appear to have executed successfully. However the operation is actually
masked. The intention is to inform the user that SBR for the CXL device
is masked and will not go through.

If the "Unmask SBR" bit is set to 1, then the bus reset will execute
successfully.

Link: https://lore.kernel.org/linux-cxl/20240220203956.GA1502351@bhelgaas/
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Move and rename PCI_DVSEC_VENDOR_ID_CXL to PCI_VENDOR_ID_CXL.
  Move to pci_ids.h in a different patch. (Bjorn)
- Remove of CXL device checking. (Bjorn)
- Rename defines to PCI_DVSEC_CXL_PORT_*. (Bjorn)
- Fixup SBR define in commit log. (Bjorn)
- Update comment on dvsec not found. (Dan)
- Check return of dvsec value read for error. (Dan)
---
 drivers/pci/pci.c             | 45 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  5 ++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..00eddb451102 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4927,10 +4927,55 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
 }
 
+static int cxl_port_dvsec(struct pci_dev *dev)
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


