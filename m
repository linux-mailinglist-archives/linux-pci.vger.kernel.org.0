Return-Path: <linux-pci+bounces-21572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642CFA379DF
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 03:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60EDC3AF078
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 02:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3FB154BFE;
	Mon, 17 Feb 2025 02:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Se8OLfCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3FD46BF;
	Mon, 17 Feb 2025 02:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760156; cv=none; b=QMXQ1l7+95WYSBYSQjqFob4DHLMNHdIeYMm+YGyTPsQdnGecMGNQcN71oOeajjKxvLQoJx+bsISBXsZyuIe8GkMJpcA1b3CbSNkjX019disNA4RctxtKl3QeIxER1yoA1kM34vyLC3VxAPV0GqAxPCvtG9sM+bwYfRae5qoepYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760156; c=relaxed/simple;
	bh=U+tJmfZFSw5WO9VLWYb8TlgTMa4spMwOZvxpzIiYWVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XIQVwkR69pBvNqKAACeIbfY3IGdXKWVfGrUeKYfaUNWctcc2NlFYnYHTu4MKqJmhMCzFvki+zVjvEJ/YvACN+3lflg/HZHxwea7LAogyNilidxoIAAw6r8x6fZ2r5W/oG3oZWWKDkiC8p1RyYbCnTD91RB+uI4kVUmidNNJchPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Se8OLfCs; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739760146; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EsTzvn9sAqOfuNe2IfnTEyGdjTW3CA2dmeyuPIDjTPY=;
	b=Se8OLfCsA9ECKNcJh8bonZaN9ROtC1xn3OBtaVJ9ucTTKzDcA9KfmZBr6pnLNzhn3ufMZ/dGjaPGlL1oNi3x6LmTZjlVs543IgtaDcECyEti2ksuviood1wfvS/yk68r8tF/G2s+Pbefx6yPx75fR7eWeF7jGI3llB0QnCJwzSI=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPYBR3X_1739760144 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 10:42:25 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bhelgaas@google.com,
	kbusch@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	Jonathan.Cameron@huawei.com,
	terry.bowman@amd.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v4 3/3] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Mon, 17 Feb 2025 10:42:18 +0800
Message-ID: <20250217024218.1681-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
References: <20250217024218.1681-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AER driver has historically avoided reading the configuration space of
an endpoint or RCiEP that reported a fatal error, considering the link to
that device unreliable. Consequently, when a fatal error occurs, the AER
and DPC drivers do not report specific error types, resulting in logs like:

  pcieport 0000:30:03.0: EDR: EDR event received
  pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
  pcieport 0000:30:03.0: DPC: ERR_FATAL detected
  pcieport 0000:30:03.0: AER: broadcast error_detected message
  nvme nvme0: frozen state error detected, reset controller
  nvme 0000:34:00.0: ready 0ms after DPC
  pcieport 0000:30:03.0: AER: broadcast slot_reset message

AER status registers are sticky and Write-1-to-clear. If the link recovered
after hot reset, we can still safely access AER status of the error device.
In such case, report fatal errors which helps to figure out the error root
case.

After this patch, the logs like:

  pcieport 0000:30:03.0: EDR: EDR event received
  pcieport 0000:30:03.0: DPC: containment event, status:0x0005 source:0x3400
  pcieport 0000:30:03.0: DPC: ERR_FATAL detected
  pcieport 0000:30:03.0: AER: broadcast error_detected message
  nvme nvme0: frozen state error detected, reset controller
  pcieport 0000:30:03.0: waiting 100 ms for downstream link, after activation
  nvme 0000:34:00.0: ready 0ms after DPC
  nvme 0000:34:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Data Link Layer, (Receiver ID)
  nvme 0000:34:00.0:   device [144d:a804] error status/mask=00000010/00504000
  nvme 0000:34:00.0:    [ 4] DLP                    (First)
  pcieport 0000:30:03.0: AER: broadcast slot_reset message

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pci.h      |  3 ++-
 drivers/pci/pcie/aer.c | 11 +++++++----
 drivers/pci/pcie/dpc.c |  2 +-
 drivers/pci/pcie/err.c |  9 +++++++++
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 870d2fbd6ff2..e852fa58b250 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -549,7 +549,8 @@ struct aer_err_info {
 	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
-int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
+int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info,
+			      bool link_healthy);
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 508474e17183..bfb67db074f0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1197,12 +1197,14 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
  * aer_get_device_error_info - read error status from dev and store it to info
  * @dev: pointer to the device expected to have a error record
  * @info: pointer to structure to store the error record
+ * @link_healthy: link is healthy or not
  *
  * Return 1 on success, 0 on error.
  *
  * Note that @info is reused among all error devices. Clear fields properly.
  */
-int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
+int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info,
+			      bool link_healthy)
 {
 	int type = pci_pcie_type(dev);
 	int aer = dev->aer_cap;
@@ -1226,7 +1228,8 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-		   info->severity == AER_NONFATAL) {
+		   info->severity == AER_NONFATAL ||
+		   (info->severity == AER_FATAL && link_healthy)) {
 
 		/* Link is still healthy for IO reads */
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
@@ -1258,11 +1261,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 
 	/* Report all before handle them, not to lost records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info->dev[i], e_info, false))
 			aer_print_error(e_info->dev[i], e_info);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info->dev[i], e_info))
+		if (aer_get_device_error_info(e_info->dev[i], e_info, false))
 			handle_error_source(e_info->dev[i], e_info);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index ea3ea989afa7..2d3dd831b755 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -303,7 +303,7 @@ struct pci_dev *dpc_process_error(struct pci_dev *pdev)
 		dpc_process_rp_pio_error(pdev);
 	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
 		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		 aer_get_device_error_info(pdev, &info)) {
+		 aer_get_device_error_info(pdev, &info, false)) {
 		aer_print_error(pdev, &info);
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 31090770fffc..462577b8d75a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -196,6 +196,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	struct aer_err_info info;
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -223,6 +224,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
+
+		info.severity = AER_FATAL;
+		/* Link recovered, report fatal errors of RCiEP or EP */
+		if ((type == PCI_EXP_TYPE_ENDPOINT ||
+		     type == PCI_EXP_TYPE_RC_END) &&
+		    aer_get_device_error_info(dev, &info, true))
+			aer_print_error(dev, &info);
 	} else {
 		pci_walk_bridge(bridge, report_normal_detected, &status);
 	}
@@ -259,6 +267,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.39.3


