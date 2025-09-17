Return-Path: <linux-pci+bounces-36319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26104B7DBBA
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392A617F889
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FBB1E7C2E;
	Wed, 17 Sep 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O3FmQx7P"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEF910F1;
	Wed, 17 Sep 2025 06:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090845; cv=none; b=pfDSLwDAA6JVirx6hSz//y+lHjjEpHqgT6Dqtnqp85aiBBEmOUyYhicXD/KCZMJChNHFaNiJ1ud3BPfJ4r1KORzZNyG+jI61a7XUUsw16Y0T07/4pzHB+sBes48Y/s80nXaPtrIymyMk3Fs8Rd32Z4qYkjqyC7afeve95/pz/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090845; c=relaxed/simple;
	bh=sT0F+Hc66dK4r2beABOLLbf0r0XrWJYnUthBMb1L3sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OubRH/2w98iD7ZLDINauarZ8zEDsLNE1vvBNweC3nO/qW85zeS5ThFCwpycGD0xV7p2paWfHcx3repcPjpTvfrs/9Icr5lSg9p+3XG7PX3sdSY14Hxpep5tsyLs9PKAWE42O3vMw75FFlAt7uk31aCN+95zrYjD2bMb6b6KPyIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O3FmQx7P; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758090836; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=l7cInLt2viFP86GcrWWMRNS3v9Fhvd3HCaJy6F6UZxk=;
	b=O3FmQx7PXpdQlcBNNOnsdbPY5u6UtAc6jnmuIVw14FwKU/LER1rFKNoIIqpiLMYyUGq+mrMtHLJPpzXU/eMgpP1VkcwysDN8cB/qcgxUisREO3YlzsjoB9ou+gBuVhWsKi3riSIohoQiwqyV/xtjDpLf1tHNrnX4nqHooYn03K4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoBL8KM_1758090835 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Sep 2025 14:33:55 +0800
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
Subject: [PATCH v5 2/3] PCI/DPC: Run recovery on device that detected the error
Date: Wed, 17 Sep 2025 14:33:51 +0800
Message-Id: <20250917063352.19429-3-xueshuai@linux.alibaba.com>
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

The current implementation of pcie_do_recovery() assumes that the
recovery process is executed for the device that detected the error.
However, the DPC driver currently passes the error port that experienced
the DPC event to pcie_do_recovery().

Use the SOURCE ID register to correctly identify the device that
detected the error. When passing the error device, the
pcie_do_recovery() will find the upstream bridge and walk bridges
potentially AER affected. And subsequent commits will be able to
accurately access AER status of the error device.

Should not observe any functional changes.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/dpc.c | 25 +++++++++++++++++++++----
 drivers/pci/pcie/edr.c |  7 ++++---
 3 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 34f65d69662e..de2f07cefa72 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -654,7 +654,7 @@ struct rcec_ea {
 void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
-void dpc_process_error(struct pci_dev *pdev);
+struct pci_dev *dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 unsigned int dpc_tlp_log_len(struct pci_dev *dev);
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index bff29726c6a5..f6069f621683 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -260,10 +260,20 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	return 1;
 }
 
-void dpc_process_error(struct pci_dev *pdev)
+/**
+ * dpc_process_error - handle the DPC error status
+ * @pdev: the port that experienced the containment event
+ *
+ * Return: the device that detected the error.
+ *
+ * NOTE: The device reference count is increased, the caller must decrement
+ * the reference count by calling pci_dev_put().
+ */
+struct pci_dev *dpc_process_error(struct pci_dev *pdev)
 {
 	u16 cap = pdev->dpc_cap, status, source, reason, ext_reason;
 	struct aer_err_info info = {};
+	struct pci_dev *err_dev;
 
 	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
 
@@ -279,6 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
 			pci_aer_clear_nonfatal_status(pdev);
 			pci_aer_clear_fatal_status(pdev);
 		}
+		err_dev = pci_dev_get(pdev);
 		break;
 	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE:
 	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE:
@@ -290,6 +301,8 @@ void dpc_process_error(struct pci_dev *pdev)
 				"ERR_FATAL" : "ERR_NONFATAL",
 			 pci_domain_nr(pdev->bus), PCI_BUS_NUM(source),
 			 PCI_SLOT(source), PCI_FUNC(source));
+		err_dev = pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					    PCI_BUS_NUM(source), source & 0xff);
 		break;
 	case PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT:
 		ext_reason = status & PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT;
@@ -304,8 +317,11 @@ void dpc_process_error(struct pci_dev *pdev)
 		if (ext_reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO &&
 		    pdev->dpc_rp_extensions)
 			dpc_process_rp_pio_error(pdev);
+		err_dev = pci_dev_get(pdev);
 		break;
 	}
+
+	return err_dev;
 }
 
 static void pci_clear_surpdn_errors(struct pci_dev *pdev)
@@ -361,7 +377,7 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
 
 static irqreturn_t dpc_handler(int irq, void *context)
 {
-	struct pci_dev *err_port = context;
+	struct pci_dev *err_port = context, *err_dev;
 
 	/*
 	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
@@ -372,10 +388,11 @@ static irqreturn_t dpc_handler(int irq, void *context)
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
index 521fca2f40cb..3f971bb04433 100644
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
 
@@ -215,6 +215,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 		acpi_send_edr_status(pdev, err_port, EDR_OST_FAILED);
 	}
 
+	pci_dev_put(err_dev);
 	pci_dev_put(err_port);
 }
 
-- 
2.39.3


