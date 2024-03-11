Return-Path: <linux-pci+bounces-4732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EE987899F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 21:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 850ECB2117E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Mar 2024 20:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EDB3CF6A;
	Mon, 11 Mar 2024 20:41:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E23F56B8B;
	Mon, 11 Mar 2024 20:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189714; cv=none; b=tSOFNBp4oyStQfRAtzsbOTO1nd8aNKPk4AyvoXXaGRbCv8FxuI/boyZok6QqEKtIunub6tGiHqcOp2ItTaw1SmqsBqQYkTx9HsN6cSI5SSURZ4MRbNgQmU5GvUjZV1BH6hXYfjQAZ7F6gKCB3xlHAxqeYGzczpe043KwuDnHoXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189714; c=relaxed/simple;
	bh=gQkvogTXTJXdtwfjRc93KO/6V5RnUn+v3H/uvVxi+1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/YfdaHXbVIt/09iyajBsgTCJVyo1O1OmLhyoUxowes5dk8/r9dGrWdOsufTAXpYEnQv24xoOI0tcZvruG8P5I1V/++thPlmo/C/NaRcU4KL+c1/AjoL4+shtYitGS+Y73wOXU+zwwRW9SJVW49mdPLiHJhGzETZLXRF0l05KrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77531C433C7;
	Mon, 11 Mar 2024 20:41:53 +0000 (UTC)
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
Subject: [PATCH 2/3] PCI: Create new reset method to force SBR for CXL
Date: Mon, 11 Mar 2024 13:39:54 -0700
Message-ID: <20240311204132.62757-3-dave.jiang@intel.com>
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

CXL spec r3.1 8.1.5.2
By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
new PCI reset method "cxl_bus_force" to force SBR on CXL ports by setting
the unmask SBR bit in the CXL DVSEC port control register before performing
the bus reset and restore the original value of the bit post reset.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pci.c   | 52 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/pci.h |  2 +-
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5e5550f54053..bbda7781f0f8 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5353,6 +5353,12 @@ static bool is_cxl_device(struct pci_dev *dev)
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
@@ -5362,8 +5368,7 @@ static bool is_cxl_port_sbr_masked(struct pci_dev *dev)
 	/*
 	 * No DVSEC found, must not be CXL port.
 	 */
-	dvsec = pci_find_dvsec_capability(dev, PCI_DVSEC_VENDOR_ID_CXL,
-					  CXL_DVSEC_PCIE_PORT);
+	dvsec = cxl_port_dvsec(dev);
 	if (!dvsec)
 		return false;
 
@@ -5402,6 +5407,48 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return pci_parent_bus_reset(dev, probe);
 }
 
+static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
+{
+	struct pci_dev *port_pdev;
+	int dvsec;
+	int rc;
+	u16 reg, val;
+
+	if (!is_cxl_device(dev))
+		return -ENODEV;
+
+	port_pdev = dev->bus->self;
+	if (!port_pdev)
+		return -ENODEV;
+
+	dvsec = cxl_port_dvsec(port_pdev);
+	if (!dvsec)
+		return -ENODEV;
+
+	if (probe)
+		return 0;
+
+	rc = pci_read_config_word(port_pdev, dvsec + CXL_DVSEC_PORT_CONTROL,
+				  &reg);
+	if (rc)
+		return -ENXIO;
+
+	if (!(reg & CXL_DVSEC_PORT_CONTROL_UNMASK_SBR)) {
+		val = reg | CXL_DVSEC_PORT_CONTROL_UNMASK_SBR;
+		pci_write_config_word(port_pdev,
+				      dvsec + CXL_DVSEC_PORT_CONTROL, val);
+	} else {
+		val = reg;
+	}
+
+	rc = pci_reset_bus_function(dev, probe);
+
+	if (reg != val)
+		pci_write_config_word(port_pdev, dvsec + CXL_DVSEC_PORT_CONTROL, reg);
+
+	return rc;
+}
+
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -5486,6 +5533,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
+	{ cxl_reset_bus_function, .name = "cxl_bus_force" },
 };
 
 static ssize_t reset_method_show(struct device *dev,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ab0d13672da..20c862c6b20f 100644
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


