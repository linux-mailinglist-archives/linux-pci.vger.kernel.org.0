Return-Path: <linux-pci+bounces-16108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BFD9BE1BF
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 10:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 438B6B227CE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B69E1DE88E;
	Wed,  6 Nov 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dA+D8MA+"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB371D9337;
	Wed,  6 Nov 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883843; cv=none; b=aSC95aOcOBum6RlRZslH15nHWbstqrTCouvZKjFcRQoV870s8yfYdBEhebXOBSYsjsuwSWGjEtxAd5zdxV07IIgtkYCABSV9SO6Ye+ZlWawaHRJJh6NC9q7VlgejLHRuC5EI9FaeiErI6i1Z4YtMwIcSKM748qPt99gs+leDcrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883843; c=relaxed/simple;
	bh=6cwVqwRy1wuBgGHHjAPhRk6T+e2OlsLMv98lUlJ1Mvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnwdGR8R28rCh9T+BMzTBlklAUzdQlFVx1FWpWkz0mxBeWV5wrX907zRDbft1/iRMBiKq8PLJmetiwJUYm63vH568BuYJ+aQKI8nJd7aqvTwFKQJjtdvaTRhycWR5HKhfbN59VnSRS4+3qdVa9PsplUwdhj+zMh/cr2mk2oLL30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dA+D8MA+; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730883833; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Z+sxZ++Zk/sXquFko87mDs4djKewv/tiZai6wAuYD2I=;
	b=dA+D8MA+u1EivGpXdqXtyxoSMEr7sdEvK2Q91Iw0WLcnsqZBnMtDo+EMXdhtPVduAuG79J2riXn4LwiQkWU2hyGraoQ6RvYa3PKabkN76WXW3iul17I183rhjUOJWm31cYBIg0PMqkyZS15Ne/qV2OQsXiQUodp5sLmo84V5VmM=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WIqmpDn_1730883831 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 17:03:52 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: bhelgaas@google.com,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	xueshuai@linux.alibaba.com
Subject: [RFC PATCH v1 2/2] PCI/AER: report fatal errors of RCiEP and EP if link recoverd
Date: Wed,  6 Nov 2024 17:03:39 +0800
Message-ID: <20241106090339.24920-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241106090339.24920-1-xueshuai@linux.alibaba.com>
References: <20241106090339.24920-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AER driver has historically avoided reading the configuration space of an
endpoint or RCiEP that reported a fatal error, considering the link to that
device unreliable. Consequently, when a fatal error occurs, the AER and DPC
drivers do not report specific error types, resulting in logs like:

[  245.281980] pcieport 0000:30:03.0: EDR: EDR event received
[  245.287466] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
[  245.295372] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
[  245.300849] pcieport 0000:30:03.0: AER: broadcast error_detected message
[  245.307540] nvme nvme0: frozen state error detected, reset controller
[  245.722582] nvme 0000:34:00.0: ready 0ms after DPC
[  245.727365] pcieport 0000:30:03.0: AER: broadcast slot_reset message

But, if the link recovered after hot reset, we can safely access AER status of
the error device. In such case, report fatal error which helps to figure out the
error root case.

After this patch, the logs like:

[  414.356755] pcieport 0000:30:03.0: EDR: EDR event received
[  414.362240] pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
[  414.370148] pcieport 0000:30:03.0: DPC: ERR_FATAL detected
[  414.375642] pcieport 0000:30:03.0: AER: broadcast error_detected message
[  414.382335] nvme nvme0: frozen state error detected, reset controller
[  414.645413] pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
[  414.788016] nvme 0000:34:00.0: ready 0ms after DPC
[  414.796975] nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
[  414.807312] nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
[  414.815305] nvme 0000:34:00.0:    [ 4] DLP                    (First)
[  414.821768] pcieport 0000:30:03.0: AER: broadcast slot_reset message

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pcie/err.c |  6 +++++
 3 files changed, 57 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0866f79aec54..143f960a813d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -505,6 +505,7 @@ struct aer_err_info {
 };
 
 int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
+int aer_get_device_fatal_error_info(struct pci_dev *dev, struct aer_err_info *info);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 #endif	/* CONFIG_PCIEAER */
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 13b8586924ea..0c1e382ce117 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1252,6 +1252,56 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	return 1;
 }
 
+/**
+ * aer_get_device_fatal_error_info - read fatal error status from EP or RCiEP
+ * and store it to info
+ * @dev: pointer to the device expected to have a error record
+ * @info: pointer to structure to store the error record
+ *
+ * Return 1 on success, 0 on error.
+ *
+ * Note that @info is reused among all error devices. Clear fields properly.
+ */
+int aer_get_device_fatal_error_info(struct pci_dev *dev, struct aer_err_info *info)
+{
+	int type = pci_pcie_type(dev);
+	int aer = dev->aer_cap;
+	u32 aercc;
+
+	pci_info(dev, "type :%d\n", type);
+
+	/* Must reset in this function */
+	info->status = 0;
+	info->tlp_header_valid = 0;
+	info->severity = AER_FATAL;
+
+	/* The device might not support AER */
+	if (!aer)
+		return 0;
+
+
+	if (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END) {
+		/* Link is healthy for IO reads now */
+		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
+			&info->status);
+		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_MASK,
+			&info->mask);
+		if (!(info->status & ~info->mask))
+			return 0;
+
+		/* Get First Error Pointer */
+		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
+		info->first_error = PCI_ERR_CAP_FEP(aercc);
+
+		if (info->status & AER_LOG_TLP_MASKS) {
+			info->tlp_header_valid = 1;
+			pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG, &info->tlp);
+		}
+	}
+
+	return 1;
+}
+
 static inline void aer_process_err_devices(struct aer_err_info *e_info)
 {
 	int i;
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..a74ae6a55064 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -196,6 +196,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	struct aer_err_info info;
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -223,6 +224,10 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
+
+		/* Link recovered, report fatal errors on RCiEP or EP */
+		if (aer_get_device_fatal_error_info(dev, &info))
+			aer_print_error(dev, &info);
 	} else {
 		pci_walk_bridge(bridge, report_normal_detected, &status);
 	}
@@ -259,6 +264,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.39.3


