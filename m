Return-Path: <linux-pci+bounces-12058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8995C421
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 596FBB20CC7
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316DC49654;
	Fri, 23 Aug 2024 04:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoUosSTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D2481DA;
	Fri, 23 Aug 2024 04:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387156; cv=none; b=gsW1R7j1BDSiHpxu+16t26VncEHNp83tMv6E2ENsOlSzTV5smLcwbGnJjVh6F9nDLOKp1Fw3/J1yOiCDB2wWxM++38sS28xXkNPnhhavPeJRp9GMtkcP8WaDPXKnwb2iJxFP9l9EEMkQrafDknxCg+F9TkTrGASezwM9xMWugTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387156; c=relaxed/simple;
	bh=0sL7dvmOd/DrdQHOQnY94UEhfSdGHNz/sBxQOe72fXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H4eyIlsZ+Y0z2O/1qHsFz90gmru/SGuembbWUIUCYXIDledWuDkWOlVhcmt7wcinHNDaRWLwqu/p+85KiD6dVP3wy0pplZz3K8rYZ0lFRifcoRgjR4t4TQBu0dmDEfjni/LrCiwUZCaOdT/TgcOgEV+5ExwqlCRxyVVrLroJj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoUosSTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711BFC4AF0E;
	Fri, 23 Aug 2024 04:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387155;
	bh=0sL7dvmOd/DrdQHOQnY94UEhfSdGHNz/sBxQOe72fXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoUosSTEucLe0YwexNf7dYI5VfZWZVBwBybYoHM+RnWuYFuTeFW/qolExBRb4SXAk
	 XtNVEIgYCgY8ToZhpwohHOm9d/Ij77oNC2F4uYJRNPFd0QLRmVwev9BxQ6cPsHI5po
	 7DbPNYkS4ZiChM9F2z77A6eHFeiVcm2QBtMK4eFpIcgmhFbvOfP1g1t3Hul/B4hTqG
	 shY0YU8BhSyUzZBW3k8WRZizo/UEZv6n/yuKcwFhxnoNjDVvlJU+RNek9GBWzm86lE
	 SBdahko9DAVNSXLHmgmct8RjbooXNOq+I7FUCPgn+bnWXQGRmxR1KOTuQj7Uflt6Xq
	 kssxoA0fcmaIw==
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
	Daniel Drake <drake@endlessos.org>,
	Gary Li <Gary.Li@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 1/5] PCI: Use an enum for reset type in pci_dev_wait()
Date: Thu, 22 Aug 2024 23:25:03 -0500
Message-ID: <20240823042508.1057791-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823042508.1057791-1-superm1@kernel.org>
References: <20240823042508.1057791-1-superm1@kernel.org>
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
v3->v4:
 * Use index-based array initialization format for pci_reset_types
 * Fix LKP reported sparse issue
---
 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.c        | 29 +++++++++++++++++++----------
 drivers/pci/pci.h        | 11 ++++++++++-
 drivers/pci/pcie/dpc.c   |  2 +-
 4 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index f412ef73a6e4b..ac3cfbfa137d9 100644
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
index ffaaca0978cbc..e4a7f5dfe6bf4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -181,6 +181,15 @@ static int __init pcie_port_pm_setup(char *str)
 }
 __setup("pcie_port_pm=", pcie_port_pm_setup);
 
+static const char * const pci_reset_types[] = {
+	[PCI_DEV_WAIT_FLR] = "FLR",
+	[PCI_DEV_WAIT_AF_FLR] = "AF_FLR",
+	[PCI_DEV_WAIT_D3HOT_D0] = "PM D3HOT->D0",
+	[PCI_DEV_WAIT_BUS_RESET] = "bus reset",
+	[PCI_DEV_WAIT_RESUME] = "resume",
+	[PCI_DEV_WAIT_DPC] = "DPC",
+};
+
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
@@ -1279,7 +1288,7 @@ void pci_resume_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int timeout)
 {
 	int delay = 1;
 	bool retrain = false;
@@ -1317,7 +1326,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
+				 delay - 1, pci_reset_types[reset_type]);
 			return -ENOTTY;
 		}
 
@@ -1330,7 +1339,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 				}
 			}
 			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
+				 delay - 1, pci_reset_types[reset_type]);
 		}
 
 		msleep(delay);
@@ -1339,10 +1348,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
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
@@ -4536,7 +4545,7 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_FLR, PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4603,7 +4612,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_AF_FLR, PCIE_RESET_READY_POLL_MS);
 }
 
 /**
@@ -4648,7 +4657,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_D3HOT_D0, PCIE_RESET_READY_POLL_MS);
 }
 
 /**
@@ -4822,7 +4831,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * Return 0 on success or -ENOTTY if the first device on the secondary bus
  * failed to become accessible.
  */
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, enum pci_reset_type reset_type)
 {
 	struct pci_dev *child __free(pci_dev_put) = NULL;
 	int delay;
@@ -4959,7 +4968,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 			      __builtin_return_address(0));
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
+	return pci_bridge_wait_for_secondary_bus(dev, PCI_DEV_WAIT_BUS_RESET);
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f39384..477257e843952 100644
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
 
@@ -137,7 +146,7 @@ void pci_msi_init(struct pci_dev *dev);
 void pci_msix_init(struct pci_dev *dev);
 bool pci_bridge_d3_possible(struct pci_dev *dev);
 void pci_bridge_d3_update(struct pci_dev *dev);
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type);
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, enum pci_reset_type reset_type);
 
 static inline void pci_wakeup_event(struct pci_dev *dev)
 {
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 2b6ef7efa3c11..95cd985244729 100644
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


