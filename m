Return-Path: <linux-pci+bounces-5136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A684988B69F
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 02:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2555B22EE3
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 23:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2256D8527A;
	Mon, 25 Mar 2024 23:59:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044DD339BF;
	Mon, 25 Mar 2024 23:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711411159; cv=none; b=s7XU3ra7IHAECAgocxVW8bQoIivd4lvvhsKrHMQCRNVaQMECZ48pvOvPva6JPQuPNKTMpCmlrGRWidu+TtH9J/R9RFXejO+rwC4tlBfk89JqAiWMKGQ9nLmRQ7S9ekMOzVxXZblnC+4Gie4p+IiJPYgTk5lASdv4sXgvVkJQYtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711411159; c=relaxed/simple;
	bh=0Rr0vRNDhPrYuFzBtu/cR/zTP20PLb4+1GfnCGCP0hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ0ytB8jWIf1wR8WibRJLcFMMLw5rLVO/VqqkAMa9GFlObpCyCHILuYVWgrFOdOhhm/svjh6ncYZrtRt42zK/uDVWXJDWjHpj8NbRkpHM4esXI0OKfPGkIdVJSPsmc2am/EZghTIV0bgSoBUm2dO6lqUmFAYfPcsDLqVYmjYTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7232C433F1;
	Mon, 25 Mar 2024 23:59:18 +0000 (UTC)
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
Subject: [PATCH v2 2/3] PCI: Create new reset method to force SBR for CXL
Date: Mon, 25 Mar 2024 16:58:02 -0700
Message-ID: <20240325235914.1897647-3-dave.jiang@intel.com>
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

CXL spec r3.1 8.1.5.2
By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
new PCI reset method "cxl_bus_force" to force SBR on CXL ports by setting
the unmask SBR bit in the CXL DVSEC port control register before performing
the bus reset and restore the original value of the bit post reset. The
new reset method allows the user to intentionally perform SBR on a CXL
device without needing to set the "Unmask SBR" bit via a user tool.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Use pci_upstream_bridge() instead of dev->bus->self.
- Return -ENOTTY as error for reset function
---
 drivers/pci/pci.c   | 52 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h |  2 +-
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 259e5d6538bb..cbcad8f0880d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4933,6 +4933,12 @@ static bool pci_is_cxl(struct pci_dev *dev)
 					 CXL_DVSEC_PCIE_DEVICE);
 }
 
+static int cxl_port_dvsec(struct pci_dev *dev)
+{
+	return pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
+					 CXL_DVSEC_PCIE_PORT);
+}
+
 static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
 {
 	int dvsec;
@@ -4942,8 +4948,7 @@ static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
 	/*
 	 * No DVSEC found, must not be CXL port.
 	 */
-	dvsec = pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
-					  CXL_DVSEC_PCIE_PORT);
+	dvsec = cxl_port_dvsec(dev);
 	if (!dvsec)
 		return false;
 
@@ -4982,6 +4987,48 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return pci_parent_bus_reset(dev, probe);
 }
 
+static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
+{
+	struct pci_dev *bridge;
+	int dvsec;
+	int rc;
+	u16 reg, val;
+
+	if (!pci_is_cxl(dev))
+		return -ENOTTY;
+
+	bridge = pci_upstream_bridge(dev);
+	if (!bridge)
+		return -ENOTTY;
+
+	dvsec = cxl_port_dvsec(bridge);
+	if (!dvsec)
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	rc = pci_read_config_word(bridge, dvsec + CXL_DVSEC_PORT_CONTROL,
+				  &reg);
+	if (rc)
+		return -ENOTTY;
+
+	if (!(reg & CXL_DVSEC_PORT_CONTROL_UNMASK_SBR)) {
+		val = reg | CXL_DVSEC_PORT_CONTROL_UNMASK_SBR;
+		pci_write_config_word(bridge,
+				      dvsec + CXL_DVSEC_PORT_CONTROL, val);
+	} else {
+		val = reg;
+	}
+
+	rc = pci_reset_bus_function(dev, probe);
+
+	if (reg != val)
+		pci_write_config_word(bridge, dvsec + CXL_DVSEC_PORT_CONTROL, reg);
+
+	return rc;
+}
+
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -5066,6 +5113,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
+	{ cxl_reset_bus_function, .name = "cxl_bus_force" },
 };
 
 static ssize_t reset_method_show(struct device *dev,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 16493426a04f..235f37715a43 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -51,7 +51,7 @@
 			       PCI_STATUS_PARITY)
 
 /* Number of reset methods used in pci_reset_fn_methods array in pci.c */
-#define PCI_NUM_RESET_METHODS 7
+#define PCI_NUM_RESET_METHODS 8
 
 #define PCI_RESET_PROBE		true
 #define PCI_RESET_DO_RESET	false
-- 
2.44.0


