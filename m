Return-Path: <linux-pci+bounces-7018-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432688B9F1A
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565691C22067
	for <lists+linux-pci@lfdr.de>; Thu,  2 May 2024 16:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD0C16FF41;
	Thu,  2 May 2024 16:58:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941CC16D4C0;
	Thu,  2 May 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669138; cv=none; b=JrzjvTPcYUwHRntc8B6d9ZVeUPVxhtdv+QRvGvhBE9jR/1yDe1gYK30bPtp97qExmvrG0O1zgTpe+y09xFyCDRFASPyWl4WKWa7YaudPbZyqWNmXf33f3NVJll3JncHwWlAXGLKPac0TSsVADqvddr41VnAvgkTed6QnWIkYYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669138; c=relaxed/simple;
	bh=E8TSeNpSssxlD5NtqvS08OfVEpGPBjORPSCWK19j++Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GsuopuQIrl8NHqDQTeDXWYm7Gh6yZzZnOutzBOpwetRmmk3L2/rMj5vUGzN7MTubHftPKoMm7ZhWSpOig/Kkd1NU+UJsY+xxvg2BX94rVsLGYNbpAECnDK3PEtg3dWJBDCUEG2ML8HK2RoPY+kzKRkdeW/QpnQUj8zOdzIrNIpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125F4C113CC;
	Thu,  2 May 2024 16:58:58 +0000 (UTC)
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
Subject: [PATCH v6 4/5] PCI: Create new reset method to force SBR for CXL
Date: Thu,  2 May 2024 09:57:33 -0700
Message-ID: <20240502165851.1948523-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502165851.1948523-1-dave.jiang@intel.com>
References: <20240502165851.1948523-1-dave.jiang@intel.com>
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/pci/pci.c   | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  2 +-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3484bf283707..0ec2b04dbceb 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4983,6 +4983,43 @@ static int pci_reset_bus_function(struct pci_dev *dev, bool probe)
 	return pci_parent_bus_reset(dev, probe);
 }
 
+static int cxl_reset_bus_function(struct pci_dev *dev, bool probe)
+{
+	struct pci_dev *bridge;
+	u16 dvsec, reg, val;
+	int rc;
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
+	rc = pci_read_config_word(bridge, dvsec + PCI_DVSEC_CXL_PORT_CTL, &reg);
+	if (rc)
+		return -ENOTTY;
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
+	return rc;
+}
+
 void pci_dev_lock(struct pci_dev *dev)
 {
 	/* block PM suspend, driver probe, etc. */
@@ -5067,6 +5104,7 @@ static const struct pci_reset_fn_method pci_reset_fn_methods[] = {
 	{ pci_af_flr, .name = "af_flr" },
 	{ pci_pm_reset, .name = "pm" },
 	{ pci_reset_bus_function, .name = "bus" },
+	{ cxl_reset_bus_function, .name = "cxl_bus" },
 };
 
 static ssize_t reset_method_show(struct device *dev,
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e4e7b175af54..b06c1c0ec9bd 100644
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


