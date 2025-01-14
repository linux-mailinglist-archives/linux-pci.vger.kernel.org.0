Return-Path: <linux-pci+bounces-19742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E6A10D16
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293FD16963E
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 17:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A038E1B2199;
	Tue, 14 Jan 2025 17:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fidGrNYR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069431D63F8;
	Tue, 14 Jan 2025 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874559; cv=none; b=UjZMMHnuyiPA/qSo4rDHkCbbRRfIZXTCPfAs6zYn5hCU8Szbe0kOziMvcL3n1vOqHniW/8+aQPfKt8t9jY1hVCjxBDdpli9c0ITNX7uug9Zh71y48zPmmTW0X9pfIyYXwg57RsP75xd6nR6ZiDWXm39dYw7/ShEh9T3ObqgOwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874559; c=relaxed/simple;
	bh=ggZFsm9wBAcbdZnkGIV7EGJ0wyT9a+GuGk67HWpEVpY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nF7K1xUrLMoAUSJgsTGHDXwUOGavbPKj2KoeOVkaWy/OS5wGMuWfZutSCiQ/Sm8hJRtnhU4UcOip+cjeW0S/cCiVpUwr08p8ZXDJKfcwTsz2qZMbpagiSjhEBBWmwLo6EPtkepqQmuncK7PYjEOgM+hTmGXwDVE3yyvp7QL/tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fidGrNYR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736874558; x=1768410558;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggZFsm9wBAcbdZnkGIV7EGJ0wyT9a+GuGk67HWpEVpY=;
  b=fidGrNYR3rf75soqynfXbKCwuI065r5uXrba4zg9am1/NkjJR8P5WYyh
   Kwv7IrwtIOqw4sdEjDluiB7MCG0ZQ+8VlHqRMc+tsubbUv4L7fofProZD
   rszldXXWweBhnmeFEWQmmBKnV5K2IcFyt5Ip/gNt/Knmk/yB/1tWBfCj5
   l22pVXtXEhS+TZ66chF6A/n9aiQEvGCUxOFwUW7NbMcQpUhAew5DXteNN
   F/z1kw5gN2nw7RZX4I9P8WCTFkm4Zh7pDu788BwaVPYNsuOYPfFCgJRSY
   0QYKmqqWfGuh4BqnT3+2859a52WXNxxsex7msw3i9yBfcjNz1Rwp/omor
   A==;
X-CSE-ConnectionGUID: jbMd59V9Sq2HASGsu/yfpg==
X-CSE-MsgGUID: UjkPI/J0Q42dOIZ3/fwSuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="36465786"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="36465786"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:17 -0800
X-CSE-ConnectionGUID: R8xOEQe/ScGx571nK2q+ew==
X-CSE-MsgGUID: qz15C2F5SReIC4nxqZeJRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="105452762"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 09:09:13 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9 3/8] PCI: Add defines for TLP Header/Prefix log sizes
Date: Tue, 14 Jan 2025 19:08:35 +0200
Message-Id: <20250114170840.1633-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
References: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add defines for AER and DPC capabilities TLP Header Logging register
sizes (PCIe r6.2, sec 7.8.4 / 7.9.14) and replace literals with them.

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 10 ++++++----
 drivers/pci/pcie/tlp.c |  2 +-
 drivers/pci/quirks.c   |  6 ++++--
 include/linux/aer.h    |  9 ++++++++-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b6ef7efa3c1..0674d8c89bfa 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -215,18 +215,18 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
 				first_error == i ? " (First)" : "");
 	}
 
-	if (pdev->dpc_rp_log_size < 4)
+	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG)
 		goto clear_status;
 	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG, &tlp_log);
 	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
 		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
 
-	if (pdev->dpc_rp_log_size < 5)
+	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG + 1)
 		goto clear_status;
 	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
 	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
 
-	for (i = 0; i < pdev->dpc_rp_log_size - 5; i++) {
+	for (i = 0; i < pdev->dpc_rp_log_size - PCIE_STD_NUM_TLP_HEADERLOG - 1; i++) {
 		pci_read_config_dword(pdev,
 			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
 		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
@@ -404,7 +404,9 @@ void pci_dpc_init(struct pci_dev *pdev)
 	if (!pdev->dpc_rp_log_size) {
 		pdev->dpc_rp_log_size =
 				FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
-		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
+		if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG ||
+		    pdev->dpc_rp_log_size > PCIE_STD_NUM_TLP_HEADERLOG + 1 +
+					    PCIE_STD_MAX_TLP_PREFIXLOG) {
 			pci_err(pdev, "RP PIO log size %u is invalid\n",
 				pdev->dpc_rp_log_size);
 			pdev->dpc_rp_log_size = 0;
diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
index 3f053cc62290..4cc76bd1867a 100644
--- a/drivers/pci/pcie/tlp.c
+++ b/drivers/pci/pcie/tlp.c
@@ -28,7 +28,7 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where,
 
 	memset(tlp_log, 0, sizeof(*tlp_log));
 
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < PCIE_STD_NUM_TLP_HEADERLOG; i++) {
 		ret = pci_read_config_dword(dev, where + i * 4,
 					    &tlp_log->dw[i]);
 		if (ret)
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 76f4df75b08a..84487615e1d1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -12,6 +12,7 @@
  * file, where their drivers can use them.
  */
 
+#include <linux/aer.h>
 #include <linux/align.h>
 #include <linux/bitfield.h>
 #include <linux/types.h>
@@ -6233,8 +6234,9 @@ static void dpc_log_size(struct pci_dev *dev)
 		return;
 
 	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) == 0) {
-		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
-		dev->dpc_rp_log_size = 4;
+		pci_info(dev, "Overriding RP PIO Log Size to %d\n",
+			 PCIE_STD_NUM_TLP_HEADERLOG);
+		dev->dpc_rp_log_size = PCIE_STD_NUM_TLP_HEADERLOG;
 	}
 }
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 190a0a2061cd..4ef6515c3205 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -16,10 +16,17 @@
 #define AER_CORRECTABLE			2
 #define DPC_FATAL			3
 
+/*
+ * AER and DPC capabilities TLP Logging register sizes (PCIe r6.2, sec 7.8.4
+ * & 7.9.14).
+ */
+#define PCIE_STD_NUM_TLP_HEADERLOG     4
+#define PCIE_STD_MAX_TLP_PREFIXLOG     4
+
 struct pci_dev;
 
 struct pcie_tlp_log {
-	u32 dw[4];
+	u32 dw[PCIE_STD_NUM_TLP_HEADERLOG];
 };
 
 struct aer_capability_regs {
-- 
2.39.5


