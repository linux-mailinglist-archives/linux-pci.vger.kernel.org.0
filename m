Return-Path: <linux-pci+bounces-38106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E98EBDC2CB
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 04:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D535118A1E98
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 02:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A13B30E0E6;
	Wed, 15 Oct 2025 02:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G+JW9PZX"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3016330C62D;
	Wed, 15 Oct 2025 02:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496135; cv=none; b=D4ZVySe8kr0mO6IitD1nklp7/TbxoegksZIl30MOQ+h3w2DCaArUybmslE10weoSg14Z042DwqBKqA6TxUPmdmheahR/5kTr2cPEXFvr9noAsc6zVvujMntjcv0/rAmOBIaZuUEoVKmySyMgNUhdCj18iZySNk64HBoph35X56M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496135; c=relaxed/simple;
	bh=YQa9RsgEa3ZlgQ8VU6lGwoNzg6W2PqAlfAvfnoDxIZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mj3Etgzg0zu+O9brlhzGjKTLfXtRFU74L5HFXMj1tUIUS2jVpndji7xz2JFUf9cqxBd4/gjB0BXP91T7+sn0aNlpQ0DOBw9D0/T/VHN+QVjfsixB1joOsMBjq7rOH3CW3wCm6ZCudPHFQvDA21IEuVygZD2UIY4JQVJ1s7klbTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G+JW9PZX; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760496124; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dYRTCsecZgOZe4YT1CnRQjDKcgxee9MQp0sCUsi3x6Y=;
	b=G+JW9PZXmU1jHR4f99p4TaSzY/LZ34a+Hmv/9FBu5CrvoAF0371+OSYvbv5nmDZjeZiffNDRp7eLu9fV3S7M1tMZPx+VqvIGNlzkcldpVSdKZSNvJ/V7pkmNF/I6KAXdmzVNHNHzwwa7C/+6k+YRieekwuQCipwTDX/+j2IIS1E=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WqEYD6y_1760496123 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 15 Oct 2025 10:42:03 +0800
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
	tianruidong@linux.alibaba.com,
	lukas@wunner.de
Subject: [PATCH v6 3/5] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Wed, 15 Oct 2025 10:41:57 +0800
Message-Id: <20251015024159.56414-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
References: <20251015024159.56414-1-xueshuai@linux.alibaba.com>
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

  pcieport 0015:00:00.0: EDR: EDR event received
  pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
  pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
  pcieport 0015:00:00.0: AER: broadcast error_detected message
  pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
  pcieport 0015:00:00.0: AER: broadcast resume message
  pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
  pcieport 0015:00:00.0: AER: device recovery successful
  pcieport 0015:00:00.0: EDR: DPC port successfully recovered
  pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80

AER status registers are sticky and Write-1-to-clear. If the link recovered
after hot reset, we can still safely access AER status and TLP header of the
error device. In such case, report fatal errors which helps to figure out the
error root case.

After this patch, the logs like:

  pcieport 0015:00:00.0: EDR: EDR event received
  pcieport 0015:00:00.0: EDR: Reported EDR dev: 0015:00:00.0
  pcieport 0015:00:00.0: DPC: containment event, status:0x200d, ERR_FATAL received from 0015:01:00.0
  pcieport 0015:00:00.0: AER: broadcast error_detected message
  vfio-pci 0015:01:00.0: PCIe Bus Error: severity=Uncorrectable (Fatal), type=Transaction Layer, (Receiver ID)
  pcieport 0015:00:00.0: pciehp: Slot(21): Link Down/Up ignored
  vfio-pci 0015:01:00.0:   device [144d:a80a] error status/mask=00001000/00400000
  vfio-pci 0015:01:00.0:    [12] TLP                    (First)
  vfio-pci 0015:01:00.0: AER:   TLP Header: 0x4a004010 0x00000040 0x01000000 0xffffffff
  pcieport 0015:00:00.0: AER: broadcast mmio_enabled message
  pcieport 0015:00:00.0: AER: broadcast resume message
  pcieport 0015:00:00.0: AER: device recovery successful
  pcieport 0015:00:00.0: EDR: DPC port successfully recovered
  pcieport 0015:00:00.0: EDR: Status for 0015:00:00.0: 0x80

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pci.h      |  4 +++-
 drivers/pci/pcie/aer.c | 18 +++++++++++-------
 drivers/pci/pcie/dpc.c |  2 +-
 drivers/pci/pcie/err.c | 11 +++++++++++
 4 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6b0c55bed15b..3eccef2d25a3 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -739,8 +739,10 @@ struct aer_err_info {
 	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
-int aer_get_device_error_info(struct aer_err_info *info, int i);
+int aer_get_device_error_info(struct aer_err_info *info, int i,
+			      bool link_healthy);
 void aer_print_error(struct aer_err_info *info, int i);
+int aer_add_error_device(struct aer_err_info *e_info, struct pci_dev *dev);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
 		      unsigned int tlp_len, bool flit,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 0b5ed4722ac3..aaea9902cbb7 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -978,7 +978,7 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
  * @e_info: pointer to error info
  * @dev: pointer to pci_dev to be added
  */
-static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
+int aer_add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
 {
 	int i = e_info->error_dev_num;
 
@@ -1068,7 +1068,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
 
 	if (is_error_source(dev, e_info)) {
 		/* List this device */
-		if (add_error_device(e_info, dev)) {
+		if (aer_add_error_device(e_info, dev)) {
 			/* We cannot handle more... Stop iteration */
 			pci_err(dev, "Exceeded max supported (%d) devices with errors logged\n",
 				AER_MAX_MULTI_ERR_DEVICES);
@@ -1382,12 +1382,14 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
  * aer_get_device_error_info - read error status from dev and store it to info
  * @info: pointer to structure to store the error record
  * @i: index into info->dev[]
+ * @link_healthy: link is healthy or not
  *
  * Return: 1 on success, 0 on error.
  *
  * Note that @info is reused among all error devices. Clear fields properly.
  */
-int aer_get_device_error_info(struct aer_err_info *info, int i)
+int aer_get_device_error_info(struct aer_err_info *info, int i,
+			      bool link_healthy)
 {
 	struct pci_dev *dev;
 	int type, aer;
@@ -1415,10 +1417,12 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
+		info->level = KERN_WARNING;
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-		   info->severity == AER_NONFATAL) {
+		   info->severity == AER_NONFATAL ||
+		   (info->severity == AER_FATAL && link_healthy)) {
 
 		/* Link is still healthy for IO reads */
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
@@ -1427,7 +1431,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 			&info->mask);
 		if (!(info->status & ~info->mask))
 			return 0;
-
+		info->level = KERN_ERR;
 		/* Get First Error Pointer */
 		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
 		info->first_error = PCI_ERR_CAP_FEP(aercc);
@@ -1451,11 +1455,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 
 	/* Report all before handling them, to not lose records by reset etc. */
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info, i))
+		if (aer_get_device_error_info(e_info, i, false))
 			aer_print_error(e_info, i);
 	}
 	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
-		if (aer_get_device_error_info(e_info, i))
+		if (aer_get_device_error_info(e_info, i, false))
 			handle_error_source(e_info->dev[i], e_info);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f6069f621683..21c4e8371279 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -284,7 +284,7 @@ struct pci_dev *dpc_process_error(struct pci_dev *pdev)
 		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
 			 status);
 		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
-		    aer_get_device_error_info(&info, 0)) {
+		    aer_get_device_error_info(&info, 0, false)) {
 			aer_print_error(&info, 0);
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index bebe4bc111d7..4e65eac809d1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -215,6 +215,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	struct aer_err_info info;
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -253,6 +254,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
+
+		/* Link recovered, report fatal errors of RCiEP or EP */
+		if (state == pci_channel_io_frozen &&
+		    (type == PCI_EXP_TYPE_ENDPOINT || type == PCI_EXP_TYPE_RC_END)) {
+			aer_add_error_device(&info, dev);
+			info.severity = AER_FATAL;
+			if (aer_get_device_error_info(&info, 0, true))
+				aer_print_error(&info, 0);
+			pci_dev_put(dev);
+		}
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
-- 
2.39.3


