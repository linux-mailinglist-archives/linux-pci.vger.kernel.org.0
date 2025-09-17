Return-Path: <linux-pci+bounces-36322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBEFB7DBB5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 391E61712D8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 06:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD222BD037;
	Wed, 17 Sep 2025 06:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wXFckUrH"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA642773FE;
	Wed, 17 Sep 2025 06:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090847; cv=none; b=cn4D63MeVJrMWiE+AoW8pPgP7Np+pNUA3pz/foimh5nOgOVG/MFCi1b7Y2LOKmyHlAgScZpP69ErlJYMZ9iRaV92dZYtO//5Z0ufPDzPllLZPEHQV5hzpIS+fhfhARrKhUZGe9jv5yHqQKA+cDEi/Ekwt4D01h/F3jkdRcFgzbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090847; c=relaxed/simple;
	bh=XXIkW+I/HACkFSg+vyalgKlv0SyRuXkZlq8vs4C89eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiDpfn6jDBMcc7J7WefzhVW/C2Vt1uefqWiUB8fw3qq80PLcH/r8KwkSUW6FuWSZP+/FfhXZpbIGX21R4y+lc6fgwKV3nsxdXmwxNPelHOFN7TjBOIh+9o9JhbeSgaH3EYx91EwXwipsW7nXeze9567+X433EJ1iQiR9kWemvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wXFckUrH; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758090837; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Emk4LUrexpA6A1Qi+VgIagLLTTIpl1Z6BSUpE7Nvp4M=;
	b=wXFckUrHhE1QmJmfvSU8rfXL2oWvOl+e/QrkoPFPXqP9EpdPhie3pcBBaVoAfY5UHbVVmJ8ZXIWDWfX3uHQ9hHe365wiEYhe5XElWaRd4AdaaUbEpMeMS+6Xn3HYlb2F2KeYMy2KVBgVACbCr3XgIkt/myrWzeBUQWuXepvzBZg=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoBL8KZ_1758090836 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Sep 2025 14:33:56 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: bhelgaas@google.com,
	mahesh@linux.ibm.com,
	mani@kernel.org,
	Jonathan.Cameron@huawei.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: oohall@gmail.com,
	xueshuai@linux.alibaba.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 3/3] PCI/AER: Report fatal errors of RCiEP and EP if link recoverd
Date: Wed, 17 Sep 2025 14:33:52 +0800
Message-Id: <20250917063352.19429-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250917063352.19429-1-xueshuai@linux.alibaba.com>
References: <20250917063352.19429-1-xueshuai@linux.alibaba.com>
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
 drivers/pci/pci.h      |  3 ++-
 drivers/pci/pcie/aer.c | 11 +++++++----
 drivers/pci/pcie/dpc.c |  2 +-
 drivers/pci/pcie/err.c | 11 +++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index de2f07cefa72..b8d364545e7d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -629,7 +629,8 @@ struct aer_err_info {
 	struct pcie_tlp_log tlp;	/* TLP Header */
 };
 
-int aer_get_device_error_info(struct aer_err_info *info, int i);
+int aer_get_device_error_info(struct aer_err_info *info, int i,
+			      bool link_healthy);
 void aer_print_error(struct aer_err_info *info, int i);
 
 int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e286c197d716..157ad7fb44a0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1351,12 +1351,14 @@ EXPORT_SYMBOL_GPL(aer_recover_queue);
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
@@ -1387,7 +1389,8 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
 		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
-		   info->severity == AER_NONFATAL) {
+		   info->severity == AER_NONFATAL ||
+		   (info->severity == AER_FATAL && link_healthy)) {
 
 		/* Link is still healthy for IO reads */
 		pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS,
@@ -1420,11 +1423,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
 
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
index de6381c690f5..744d77ee7271 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -196,6 +196,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	struct pci_dev *bridge;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	struct aer_err_info info;
 
 	/*
 	 * If the error was detected by a Root Port, Downstream Port, RCEC,
@@ -223,6 +224,15 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
+
+		info.dev[0] = dev;
+		info.level = KERN_ERR;
+		info.severity = AER_FATAL;
+		/* Link recovered, report fatal errors of RCiEP or EP */
+		if ((type == PCI_EXP_TYPE_ENDPOINT ||
+		     type == PCI_EXP_TYPE_RC_END) &&
+		    aer_get_device_error_info(&info, 0, true))
+			aer_print_error(&info, 0);
 	} else {
 		pci_walk_bridge(bridge, report_normal_detected, &status);
 	}
@@ -259,6 +269,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	if (host->native_aer || pcie_ports_native) {
 		pcie_clear_device_status(dev);
 		pci_aer_clear_nonfatal_status(dev);
+		pci_aer_clear_fatal_status(dev);
 	}
 
 	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
-- 
2.39.3


