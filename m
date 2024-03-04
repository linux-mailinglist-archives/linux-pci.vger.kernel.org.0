Return-Path: <linux-pci+bounces-4397-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF87F86FCBE
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392D71F20F2C
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933A1B7F3;
	Mon,  4 Mar 2024 09:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BfJ+oBzf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA451B5BB;
	Mon,  4 Mar 2024 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709543314; cv=none; b=n2Fl60uPaBhIYmpqZ6yV3iBJDyFtdFyJN3C3d1PmPOqoH1NhlJbXi/ibPPACbW8V+UhldrmuIJrf+LhKG0JAJdIdBejATwIA0VJ31+O4EgJ1jsAhXBD1Oskkv8Hp7njKv096XFLDoHfOmCajbSvASP1qH1lkuoS+oprfHS03rso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709543314; c=relaxed/simple;
	bh=EA6ZR3Erkc94kHJhtNv8APoWSvKBml3K5BTGuia7NoM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gl4Qv1m2hWK0PHwer3kJkSIgSMOpk19o6M3sNHT5ADChTwO7TSUkw3SONpf/njV3eovOHLCv8TRCltTfaYWmwWyftAcrY395ksnoyBKihR5ou4MDxoMgoWCn4z40nklQB8OchGpxqWVAaYGmy93lI1C6lPofLnJcEoRYC2vz54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BfJ+oBzf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709543313; x=1741079313;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EA6ZR3Erkc94kHJhtNv8APoWSvKBml3K5BTGuia7NoM=;
  b=BfJ+oBzfv5oTzDpbOtO9Z9DDf3ymd/FnmZ73kiU5349Y8zSne3dQSgp3
   NV/W5IRzenSiYAa+n6eGT/2epNdhvO666c+8MBgFOxbE4FzQ2mW+z4knq
   gjbEXLz1b8S0JmWEYR9kaxEeSVXNHt4SgeT6bSn7iZMz6YVqe9KbCLgJH
   EDFqOaPrT9/dS+A+regZgZObVuTKou837101/dPF8wONqv3vvqnbRPiqz
   8vb7Xc+ZfQJXWWdAzZzk7Bh3WHHGCQd6+pvbkxTRLVX/KjLy+77PcTSQr
   VCuVCrDlKRzLElChvZGM+dX58MiLUo0qp8JoD6/lV8OXnOfWsilexBnjr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7840688"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7840688"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 01:08:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="32092854"
Received: from unknown (HELO ply01-vm-store.amr.corp.intel.com) ([10.238.153.201])
  by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2024 01:08:27 -0800
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
To: bhelgaas@google.com,
	lukas@wunner.de
Cc: Smita.KoralahalliChannabasappa@amd.com,
	ilpo.jarvinen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kbusch@kernel.org,
	Ethan Zhao <haifeng.zhao@linux.intel.com>
Subject: [PATCH pci-next] pci/edr: Ignore Surprise Down error on hot removal
Date: Mon,  4 Mar 2024 04:08:19 -0500
Message-Id: <20240304090819.3812465-1-haifeng.zhao@linux.intel.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per PCI firmware spec r3.3 sec 4.6.12, for firmware first mode DPC
handling path, FW should clear UC errors logged by port and bring link
out of DPC, but because of ambiguity of wording in the spec, some BIOSes
doesn't clear the surprise down error and the error bits in pci status,
still notify OS to handle it. thus following trick is needed in EDR when
double reporting (hot removal interrupt && dpc notification) is hit.

https://patchwork.kernel.org/project/linux-pci/patch/20240207181854.
121335-1-Smita.KoralahalliChannabasappa@amd.com/

Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
---
 drivers/pci/pci.h      | 1 +
 drivers/pci/pcie/dpc.c | 9 +++++----
 drivers/pci/pcie/edr.c | 3 +++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 50134b5e3235..3787bb32e724 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -443,6 +443,7 @@ void pci_save_dpc_state(struct pci_dev *dev);
 void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
+bool dpc_handle_surprise_removal(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
 #else
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 98b42e425bb9..be79f205e04c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -319,8 +319,10 @@ static void pci_clear_surpdn_errors(struct pci_dev *pdev)
 	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
 }
 
-static void dpc_handle_surprise_removal(struct pci_dev *pdev)
+bool  dpc_handle_surprise_removal(struct pci_dev *pdev)
 {
+	if (!dpc_is_surprise_removal(pdev))
+		return false;
 	if (!pcie_wait_for_link(pdev, false)) {
 		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
 		goto out;
@@ -338,6 +340,7 @@ static void dpc_handle_surprise_removal(struct pci_dev *pdev)
 out:
 	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 	wake_up_all(&dpc_completed_waitqueue);
+	return true;
 }
 
 static bool dpc_is_surprise_removal(struct pci_dev *pdev)
@@ -362,10 +365,8 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
 	 * of async removal and should be ignored by software.
 	 */
-	if (dpc_is_surprise_removal(pdev)) {
-		dpc_handle_surprise_removal(pdev);
+	if (dpc_handle_surprise_removal(pdev))
 		return IRQ_HANDLED;
-	}
 
 	dpc_process_error(pdev);
 
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index 5f4914d313a1..556edfb2696a 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -184,6 +184,9 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 		goto send_ost;
 	}
 
+	if (dpc_handle_surprise_removal(edev))
+		goto send_ost;
+
 	dpc_process_error(edev);
 	pci_aer_raw_clear_status(edev);
 

base-commit: a66f2b4a4d365dc4bac35576f3a9d4f5982f1d63
-- 
2.31.1


