Return-Path: <linux-pci+bounces-21571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1945A379DB
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 03:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E083F188F768
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3B15381A;
	Mon, 17 Feb 2025 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wPJhZd1C"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC014F9E2;
	Mon, 17 Feb 2025 02:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739760155; cv=none; b=WKMeRhx7WqzQxW/BNvnPoHU87xeXvQvm1cF+oFA7buUNmf+ITbuNmUBbdbpXbQlVv5UUckA9pXQ3m8O5WybZkM+3DJ5XX72WbH6wiNHf8x85Xuf6khEc29SGJX81O1JY0opcoKUwFXlN/zKlk9eJpIHOgLFmEoeBL79HCt+Zx3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739760155; c=relaxed/simple;
	bh=/P9q9mFWFsGN33zhNoLfBe1UNxTCojjE9uSZROzQxvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNzwQeUkMfzoIIXqSopXE1cEBZlqHM20bRpnlTwOdKn9dov+CStXUVrioTDexo3pefNhZUKyMe0ABnmgg0ycOqDJsmQXPIC3x5jB4f2jz5g5LjpT4VEEubK9boHUPYQo/sE6hxOBGK9iHAkoZIx4cnojLI9SL7slDKuAGRYBT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wPJhZd1C; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739760144; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=J68DzycSDpySGEu0l4V3BzYA3gTtZLcUlEPqklytzBw=;
	b=wPJhZd1Cc9mAE/t0kn2WMLn4Ki1vrnZqfKlwdcaxFW64AiRIIdTSRAd+7wInwK7yWJ1AfN+AiYqXSpNEIclY0QDpisXZg4ouVYvpKhBX9QB9XSz8z1NlXRK4mZvoVjhuh1O4H0T4ohkpJfVFyTk7ueUzY1twCGOEiI3Fkbzlimg=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPYBR2o_1739760143 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 17 Feb 2025 10:42:24 +0800
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
Subject: [PATCH v4 2/3] PCI/DPC: Run recovery on device that detected the error
Date: Mon, 17 Feb 2025 10:42:17 +0800
Message-ID: <20250217024218.1681-3-xueshuai@linux.alibaba.com>
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

The current implementation of pcie_do_recovery() assumes that the
recovery process is executed on the device that detected the error.
However, the DPC driver currently passes the error port that experienced
the DPC event to pcie_do_recovery().

Use the SOURCE ID register to correctly identify the device that
detected the error. When passing the error device, the
pcie_do_recovery() will find the upstream bridge and walk bridges
potentially AER affected. And subsequent patches will be able to
accurately access AER status of the error device.

Should not observe any functional changes.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/dpc.c | 28 ++++++++++++++++++++++++----
 drivers/pci/pcie/edr.c |  7 ++++---
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 01e51db8d285..870d2fbd6ff2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -572,7 +572,7 @@ struct rcec_ea {
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
-void dpc_process_error(struct pci_dev *pdev);
+struct pci_dev *dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 1a54a0b657ae..ea3ea989afa7 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -253,10 +253,20 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	return 1;
 }
 
-void dpc_process_error(struct pci_dev *pdev)
+/**
+ * dpc_process_error - handle the DPC error status
+ * @pdev: the port that experienced the containment event
+ *
+ * Return the device that detected the error.
+ *
+ * NOTE: The device reference count is increased, the caller must decrement
+ * the reference count by calling pci_dev_put().
+ */
+struct pci_dev *dpc_process_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
 	struct aer_err_info info;
+	struct pci_dev *err_dev;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_SOURCE_ID, &source);
@@ -279,6 +289,13 @@ void dpc_process_error(struct pci_dev *pdev)
 		 "software trigger" :
 		 "reserved error");
 
+	if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE ||
+	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE)
+		err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    PCI_BUS_NUM(source), source & 0xff);
+	else
+		err_dev = pci_dev_get(pdev);
+
 	/* show RP PIO error detail information */
 	if (pdev->dpc_rp_extensions &&
 	    reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT &&
@@ -291,6 +308,8 @@ void dpc_process_error(struct pci_dev *pdev)
 		pci_aer_clear_nonfatal_status(pdev);
 		pci_aer_clear_fatal_status(pdev);
 	}
+
+	return err_dev;
 }
 
 static void pci_clear_surpdn_errors(struct pci_dev *pdev)
@@ -346,7 +365,7 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
 
 static irqreturn_t dpc_handler(int irq, void *context)
 {
-	struct pci_dev *err_port = context;
+	struct pci_dev *err_port = context, *err_dev;
 
 	/*
 	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
@@ -357,10 +376,11 @@ static irqreturn_t dpc_handler(int irq, void *context)
 		return IRQ_HANDLED;
 	}
 
-	dpc_process_error(err_port);
+	err_dev = dpc_process_error(err_port);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
+	pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
+	pci_dev_put(err_dev);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 521fca2f40cb..088f3e188f54 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -150,7 +150,7 @@ static int acpi_send_edr_status(struct pci_dev *pdev, struct pci_dev *edev,
 
 static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 {
-	struct pci_dev *pdev = data, *err_port;
+	struct pci_dev *pdev = data, *err_port, *err_dev;
 	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
 	u16 status;
 
@@ -190,7 +190,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 		goto send_ost;
 	}
 
-	dpc_process_error(err_port);
+	err_dev = dpc_process_error(err_port);
 	pci_aer_raw_clear_status(err_port);
 
 	/*
@@ -198,7 +198,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 * or ERR_NONFATAL, since the link is already down, use the FATAL
 	 * error recovery path for both cases.
 	 */
-	estate = pcie_do_recovery(err_port, pci_channel_io_frozen, dpc_reset_link);
+	estate = pcie_do_recovery(err_dev, pci_channel_io_frozen, dpc_reset_link);
 
 send_ost:
 
@@ -216,6 +216,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	}
 
 	pci_dev_put(err_port);
+	pci_dev_put(err_dev);
 }
 
 void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
-- 
2.39.3


