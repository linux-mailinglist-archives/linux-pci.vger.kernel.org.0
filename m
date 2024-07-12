Return-Path: <linux-pci+bounces-10213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85E930049
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 20:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7232B1C20BA1
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D1B17CA0B;
	Fri, 12 Jul 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxvLccrG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312517C9FF;
	Fri, 12 Jul 2024 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807973; cv=none; b=FCxRhGzKmfSx02YchcgqRZog9VKIa1KXCnhqcCmIPtaUJQv6dkVgYJmgqbyRW8jqnTJbhNIZRmgjrciFbXF9aK4S3IWFRlyens1+qO+dIlObR4+a28OELgO15CUK6xycEQ0Ii/da/So8eWYll99NRkzLctrThs2V8LivCCBbwbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807973; c=relaxed/simple;
	bh=ew5pNI3HWPmom56HlNUgJiu2Xg17zI+AJEeyLfo4fo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQa9sMsp7/XN7D97XnrW/hUmL1oq+iYancFC1VOQvAmpdE0YSy5mwXpfc0TtMUvIo+bwr/NhjocfReU7ioqGK23rq2I7vsOLyyHCh+LZhFx8SNt9HRtVkFCA3SY5KTsQChxvf4harjVKNaRBQlSapsZa9P9xOWAoXuG1KU1sGGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxvLccrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF050C4AF1B;
	Fri, 12 Jul 2024 18:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720807973;
	bh=ew5pNI3HWPmom56HlNUgJiu2Xg17zI+AJEeyLfo4fo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxvLccrGlo88juCdz6pXviETrsp2Xr2qqTdQnQpbrpu8nrbzhUQFq3495fDSKHmic
	 0ar+Wht+9tnskwZre+oPUh/P/3FrBEOByO+WY9vN86E3BfFdQiXUsnuYhmbVyDrDvH
	 LUU9elXs3jO8ApIdTptHBKBzzaJforN4pEOL0xJed01Zm6wRErWB4BQ1bRX6j5Lk6h
	 BALew+f/W0uO50Xu9q5WXEt0yLEjMBIfOwTSRfVIrBTsF7Z+cjviPBqqYYUkPLynIa
	 eKj9HjviF1kbtiB76pdi5zp6QwCQx/46GQ3ZmlOzyzbZcH12mXjgCZDUM+8iUc+KgS
	 wI3GTm7cHf8BA==
From: superm1@kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 1/5] PCI: Use an enum for reset type in pci_dev_wait()
Date: Fri, 12 Jul 2024 13:12:42 -0500
Message-ID: <20240712181246.811044-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712181246.811044-1-superm1@kernel.org>
References: <20240712181246.811044-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

A string is passed to all callers of pci_dev_wait() which is utilized
to demonstrate what kind of reset happened when there was a problem.

This doesn't allow making the behavior for different reset types
conditional though. Lay some plumbing to allow making comparisons of
reset types with integers instead. No functional changes.

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.c        | 29 +++++++++++++++++++----------
 drivers/pci/pci.h        | 11 ++++++++++-
 drivers/pci/pcie/dpc.c   |  2 +-
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index af2996d0d17ff..ff97d08741df7 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -572,7 +572,7 @@ static void pci_pm_bridge_power_up_actions(struct pci_dev *pci_dev)
 {
 	int ret;
 
-	ret = pci_bridge_wait_for_secondary_bus(pci_dev, "resume");
+	ret = pci_bridge_wait_for_secondary_bus(pci_dev, PCI_DEV_WAIT_RESUME);
 	if (ret) {
 		/*
 		 * The downstream link failed to come up, so mark the
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 35fb1f17a589c..115361a08d9e3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -181,6 +181,15 @@ static int __init pcie_port_pm_setup(char *str)
 }
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
+const char * const pci_reset_types[] = {
+	"FLR",
+	"AF_FLR",
+	"PM D3HOT->D0",
+	"bus reset",
+	"resume",
+	"DPC",
+};
+
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
@@ -1250,7 +1259,7 @@ void pci_resume_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int timeout)
 {
 	int delay = 1;
 	bool retrain = false;
@@ -1288,7 +1297,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
+				 delay - 1, pci_reset_types[reset_type]);
 			return -ENOTTY;
 		}
 
@@ -1301,7 +1310,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 				}
 			}
 			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
+				 delay - 1, pci_reset_types[reset_type]);
 		}
 
 		msleep(delay);
@@ -1310,10 +1319,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 	if (delay > PCI_RESET_WAIT)
 		pci_info(dev, "ready %dms after %s\n", delay - 1,
-			 reset_type);
+			 pci_reset_types[reset_type]);
 	else
 		pci_dbg(dev, "ready %dms after %s\n", delay - 1,
-			reset_type);
+			pci_reset_types[reset_type]);
 
 	return 0;
 }
@@ -4465,7 +4474,7 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_FLR, PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4532,7 +4541,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_AF_FLR, PCIE_RESET_READY_POLL_MS);
 }
 
 /**
@@ -4577,7 +4586,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_D3HOT_D0, PCIE_RESET_READY_POLL_MS);
 }
 
 /**
@@ -4751,7 +4760,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * Return 0 on success or -ENOTTY if the first device on the secondary bus
  * failed to become accessible.
  */
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, enum pci_reset_type reset_type)
 {
 	struct pci_dev *child;
 	int delay;
@@ -4885,7 +4894,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 {
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
+	return pci_bridge_wait_for_secondary_bus(dev, PCI_DEV_WAIT_BUS_RESET);
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fd44565c47562..88f54d22118dc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,15 @@
 
 #include <linux/pci.h>
 
+enum pci_reset_type {
+	PCI_DEV_WAIT_FLR,
+	PCI_DEV_WAIT_AF_FLR,
+	PCI_DEV_WAIT_D3HOT_D0,
+	PCI_DEV_WAIT_BUS_RESET,
+	PCI_DEV_WAIT_RESUME,
+	PCI_DEV_WAIT_DPC,
+};
+
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
@@ -94,7 +103,7 @@ void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, enum pci_reset_type reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a668820696dc0..306efc399e503 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -174,7 +174,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
-	if (pci_bridge_wait_for_secondary_bus(pdev, "DPC")) {
+	if (pci_bridge_wait_for_secondary_bus(pdev, PCI_DEV_WAIT_DPC)) {
 		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
 		ret = PCI_ERS_RESULT_DISCONNECT;
 	} else {
-- 
2.43.0


