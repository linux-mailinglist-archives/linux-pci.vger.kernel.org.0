Return-Path: <linux-pci+bounces-20870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2678BA2BF74
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 103CC3AB9A0
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 09:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30476235BFD;
	Fri,  7 Feb 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GHRg1d7P"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595801DE895;
	Fri,  7 Feb 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738920916; cv=none; b=GQfdYPw5HuFQmdy1pICQk8JAMZY5r9Al7pRJ74HaZNO1UIJlmEEOFX/h4YzK7BP87dkm4Y2BPKHn/r3gZj+U3YuOBNy60RV67jdv/9jSMDBhLmktM7LKNcftSxEwmjiGImoYWqKg6O9UVSoQbaqeSTdVZxAHvrD/9fnEI5/xl9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738920916; c=relaxed/simple;
	bh=qIyWAn72UPWU81b9osBKr2+3RaxJgnN9tuASQdBb6Lo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apopz5Ug5cy4DQDkFGuEk+Z3ZWND9H//DyrcRpqg99d7kPqZiF7NoSCkNyf6BrL+/AdZe7bsepQ3JH5SrDpd+nzAKzRVPLE8E7ZWySL0PmUU09rjbkyaB+iMVczc4iRNcVYgdfthcoqCJiTmEoN/19koCL+5soZoVPuZwhWPqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GHRg1d7P; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738920904; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ngX6PfbblGKZrZvn7Una9Ae0lhIGRor/bzr4Vh976DY=;
	b=GHRg1d7PNrKWfZ7OAGnkQN3WZmdoj1ZHT0RfLOnvVVLNRyrv8/15xIRwXyphdoP3O12X9Fi5zIH55xxo0bCLxInxKutGUzg6QU7PwBRUxhXr44WHiEnv5JZ4kzZ6caELJ9YqYVDft7yNRDVeEYDLBzJ0ckKInOel2j7zESSaQd0=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WOyzNDb_1738920903 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 07 Feb 2025 17:35:04 +0800
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
	terry.bowman@amd.com
Subject: [PATCH v3 2/4] PCI/EDR: Rename edev to err_port for edr_handle_event
Date: Fri,  7 Feb 2025 17:34:58 +0800
Message-ID: <20250207093500.70885-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
References: <20250207093500.70885-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acpi_dpc_port_get() locate the port that experienced the containment
event. Rename edev to err_port for clear so that later patch will  avoid
misused err_port in pcie_do_recovery().

No functional changes.

Suggested-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pcie/edr.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index e86298dbbcff..521fca2f40cb 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -150,7 +150,7 @@ static int acpi_send_edr_status(struct pci_dev *pdev, struct pci_dev *edev,
 
 static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 {
-	struct pci_dev *pdev = data, *edev;
+	struct pci_dev *pdev = data, *err_port;
 	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
 	u16 status;
 
@@ -169,36 +169,36 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 * may be that port or a parent of it (PCI Firmware r3.3, sec
 	 * 4.6.13).
 	 */
-	edev = acpi_dpc_port_get(pdev);
-	if (!edev) {
+	err_port = acpi_dpc_port_get(pdev);
+	if (!err_port) {
 		pci_err(pdev, "Firmware failed to locate DPC port\n");
 		return;
 	}
 
-	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(edev));
+	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(err_port));
 
 	/* If port does not support DPC, just send the OST */
-	if (!edev->dpc_cap) {
-		pci_err(edev, FW_BUG "This device doesn't support DPC\n");
+	if (!err_port->dpc_cap) {
+		pci_err(err_port, FW_BUG "This device doesn't support DPC\n");
 		goto send_ost;
 	}
 
 	/* Check if there is a valid DPC trigger */
-	pci_read_config_word(edev, edev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
+	pci_read_config_word(err_port, err_port->dpc_cap + PCI_EXP_DPC_STATUS, &status);
 	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
-		pci_err(edev, "Invalid DPC trigger %#010x\n", status);
+		pci_err(err_port, "Invalid DPC trigger %#010x\n", status);
 		goto send_ost;
 	}
 
-	dpc_process_error(edev);
-	pci_aer_raw_clear_status(edev);
+	dpc_process_error(err_port);
+	pci_aer_raw_clear_status(err_port);
 
 	/*
 	 * Irrespective of whether the DPC event is triggered by ERR_FATAL
 	 * or ERR_NONFATAL, since the link is already down, use the FATAL
 	 * error recovery path for both cases.
 	 */
-	estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
+	estate = pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
 
 send_ost:
 
@@ -207,15 +207,15 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 * to firmware. If not successful, send _OST(0xF, BDF << 16 | 0x81).
 	 */
 	if (estate == PCI_ERS_RESULT_RECOVERED) {
-		pci_dbg(edev, "DPC port successfully recovered\n");
-		pcie_clear_device_status(edev);
-		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
+		pci_dbg(err_port, "DPC port successfully recovered\n");
+		pcie_clear_device_status(err_port);
+		acpi_send_edr_status(pdev, err_port, EDR_OST_SUCCESS);
 	} else {
-		pci_dbg(edev, "DPC port recovery failed\n");
-		acpi_send_edr_status(pdev, edev, EDR_OST_FAILED);
+		pci_dbg(err_port, "DPC port recovery failed\n");
+		acpi_send_edr_status(pdev, err_port, EDR_OST_FAILED);
 	}
 
-	pci_dev_put(edev);
+	pci_dev_put(err_port);
 }
 
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
-- 
2.39.3


