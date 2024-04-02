Return-Path: <linux-pci+bounces-5577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B6E896066
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 01:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 822EE284068
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 23:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB65E15ADA1;
	Tue,  2 Apr 2024 23:48:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9058ACC;
	Tue,  2 Apr 2024 23:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101733; cv=none; b=OGTOrPIFp0vYfvwDEUclhAGGBVwxhzxM2fJXT51lN6DhsOMed9PC2z6Hgoo/N/vwHbowFbgVaphKZIguthjNA5/BYcI0A0WNPCVk+SUBQ8ardCrUoeXVttr+n/hZiaHTbzf2AbaGAbpkHfP4NZJ/ahDDuF9BVhjkJyyyvO05qGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101733; c=relaxed/simple;
	bh=txOwHcR78CzPM7E4N7ociHGgG8Ud5fgzufGn8dDpzIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7iXKhHtOZahhozz2C69lpPlnbjyC1WMznSEGljzZywcRyevOF49PbEsAO41el98mHfqBB1qMcVHQdoTAn6GgbKaVHDk9TlnAJ0IVWa6mOjiq0p25+NwLYiYFQUoEjRhpSmDB1qvj2Lvp2e2KHkp0+T80qP3jG3gk15r0Hrgl30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7010EC433F1;
	Tue,  2 Apr 2024 23:48:53 +0000 (UTC)
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
Subject: [PATCH v3 3/4] PCI: Create new reset method to force SBR for CXL
Date: Tue,  2 Apr 2024 16:45:31 -0700
Message-ID: <20240402234848.3287160-4-dave.jiang@intel.com>
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

CXL spec r3.1 8.1.5.2
By default Secondary Bus Reset (SBR) is masked for CXL ports. Introduce a
new PCI reset method "cxl_bus" to force SBR on CXL ports by setting
the unmask SBR bit in the CXL DVSEC port control register before performing
the bus reset and restore the original value of the bit post reset. The
new reset method allows the user to intentionally perform SBR on a CXL
device without needing to set the "Unmask SBR" bit via a user tool.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- move cxl_port_dvsec() to previous patch. (Dan)
- add pci_cfg_access_lock() for the bridge. (Dan)
- Change cxl_bus_force method to cxl_bus. (Dan)
---
 drivers/pci/pci.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  2 +-
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 00eddb451102..3989c8888813 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4982,6 +4982,49 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return pci_parent_bus_reset(dev, probe);
 }
 
+static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
+{
+	struct pci_dev *bridge;
+	int dvsec;
+	int rc;
+	u16 reg, val;
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
+	pci_cfg_access_lock(bridge);
+	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	if (rc) {
+		rc = -ENOTTY;
+		goto out;
+	}
+
+	if (!(reg & PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR)) {
+		val = reg | PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR;
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL,
+				      val);
+	} else {
+		val = reg;
+	}
+
+	rc = pci_reset_bus_function(dev, probe);
+
+	if (reg != val)
+		pci_write_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, reg);
+
+out:
+	pci_cfg_access_unlock(bridge);
+	return rc;
+}
+
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -5066,6 +5109,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
+	{ cxl_reset_bus_function, .name = "cxl_bus" },
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


