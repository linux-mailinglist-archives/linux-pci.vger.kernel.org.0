Return-Path: <linux-pci+bounces-12123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D2695D1DB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 17:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA34EB276EB
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06518BC0F;
	Fri, 23 Aug 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyGkbCpL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299718BC0A;
	Fri, 23 Aug 2024 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427636; cv=none; b=tPmp8LKAsUfRm7sZEyysfcJFXNTJh++pZxHJoKjLnB9zdPgqJDO5Mtev0h9QgEErbE+G1LlAVz2Wa0T/ty8pX0lF53WxpsPobRT0kHgp1cyymTSgOi3rWjVLzilgveTaPzyp270q0F5UfbKhV14bD15VevwF///C9Ka/NjNF0Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427636; c=relaxed/simple;
	bh=Tf2S1xZWRnKKEhmKPhTMu3cUntZAGi9lxHNWOj+Eg7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XMlvMta91vTUbzIjUXdAlAYdGOiWeEev5tqrFdmaKEH1Jeq6yyAqeedDYkLNWn9sEsaKs/rbCA8cWjzBHvOppkh3JoYmavWkBsxZaseyXoJD8ugc+oOFuD4L+XTVrPyOTmOos1iPNxTsv7ftoDlgEGvkZU3yfNGQXqIbqepAbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyGkbCpL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1096C32786;
	Fri, 23 Aug 2024 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427635;
	bh=Tf2S1xZWRnKKEhmKPhTMu3cUntZAGi9lxHNWOj+Eg7M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jyGkbCpLjSAcgqHp/4ohcmkiyOA1570jvoeBmu0ks1eh9kdzdPEDTZzh5ZkL2pW8l
	 e0aEjegyBVghlQF7Wu9G3sno61tOE9y5njtnzrUasApAkA9gKu4f8IOUfnBVGt4Hny
	 XR+7Ub2VF2O6jvmPWUr3Z/t84U714UbaAOyMipUHORejPFGnTar7R79TzcLu/6t5pp
	 Oy89yC0ZD5UAwYDQn+fEi6e5vDQaNzZohd9AhxwTB1Q442b5pN8BcYjxnXZUVR3RbX
	 pUebBFH4UTU7HCo5YlHdviAHNBlYLN4ygmaKFGZKdoGsHzzb2IaAmzqTcCNDGeSBMw
	 J8l0fKmmbdIUg==
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
Subject: [PATCH v5 1/5] PCI: Use an enum for reset type in pci_dev_wait()
Date: Fri, 23 Aug 2024 10:40:19 -0500
Message-ID: <20240823154023.360234-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240823154023.360234-1-superm1@kernel.org>
References: <20240823154023.360234-1-superm1@kernel.org>
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
v4->v5:
 * Add static assert and PCI_DEV_WAIT_MAX
v3->v4:
 * Use index-based array initialization format for pci_reset_types
 * Fix LKP reported sparse issue
---
 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.c        | 30 ++++++++++++++++++++----------
 drivers/pci/pci.h        | 12 +++++++++++-
 drivers/pci/pcie/dpc.c   |  2 +-
 4 files changed, 33 insertions(+), 13 deletions(-)

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
index ffaaca0978cbc..1e219057a5069 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -181,6 +181,16 @@ static int __init pcie_port_pm_setup(char *str)
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
+static_assert(ARRAY_SIZE(pci_reset_types) == PCI_DEV_WAIT_MAX);
+
 /**
  * pci_bus_max_busnr - returns maximum PCI bus number of given bus' children
  * @bus: pointer to PCI bus structure to search
@@ -1279,7 +1289,7 @@ void pci_resume_bus(struct pci_bus *bus)
 		pci_walk_bus(bus, pci_resume_one, NULL);
 }
 
-static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
+static int pci_dev_wait(struct pci_dev *dev, enum pci_reset_type reset_type, int timeout)
 {
 	int delay = 1;
 	bool retrain = false;
@@ -1317,7 +1327,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (delay > timeout) {
 			pci_warn(dev, "not ready %dms after %s; giving up\n",
-				 delay - 1, reset_type);
+				 delay - 1, pci_reset_types[reset_type]);
 			return -ENOTTY;
 		}
 
@@ -1330,7 +1340,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 				}
 			}
 			pci_info(dev, "not ready %dms after %s; waiting\n",
-				 delay - 1, reset_type);
+				 delay - 1, pci_reset_types[reset_type]);
 		}
 
 		msleep(delay);
@@ -1339,10 +1349,10 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
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
@@ -4536,7 +4546,7 @@ int pcie_flr(struct pci_dev *dev)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_FLR, PCIE_RESET_READY_POLL_MS);
 }
 EXPORT_SYMBOL_GPL(pcie_flr);
 
@@ -4603,7 +4613,7 @@ static int pci_af_flr(struct pci_dev *dev, bool probe)
 	 */
 	msleep(100);
 
-	return pci_dev_wait(dev, "AF_FLR", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_AF_FLR, PCIE_RESET_READY_POLL_MS);
 }
 
 /**
@@ -4648,7 +4658,7 @@ static int pci_pm_reset(struct pci_dev *dev, bool probe)
 	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, csr);
 	pci_dev_d3_sleep(dev);
 
-	return pci_dev_wait(dev, "PM D3hot->D0", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(dev, PCI_DEV_WAIT_D3HOT_D0, PCIE_RESET_READY_POLL_MS);
 }
 
 /**
@@ -4822,7 +4832,7 @@ static int pci_bus_max_d3cold_delay(const struct pci_bus *bus)
  * Return 0 on success or -ENOTTY if the first device on the secondary bus
  * failed to become accessible.
  */
-int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, char *reset_type)
+int pci_bridge_wait_for_secondary_bus(struct pci_dev *dev, enum pci_reset_type reset_type)
 {
 	struct pci_dev *child __free(pci_dev_put) = NULL;
 	int delay;
@@ -4959,7 +4969,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev)
 			      __builtin_return_address(0));
 	pcibios_reset_secondary_bus(dev);
 
-	return pci_bridge_wait_for_secondary_bus(dev, "bus reset");
+	return pci_bridge_wait_for_secondary_bus(dev, PCI_DEV_WAIT_BUS_RESET);
 }
 EXPORT_SYMBOL_GPL(pci_bridge_secondary_bus_reset);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 79c8398f39384..be06c38342c76 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,16 @@
 
 #include <linux/pci.h>
 
+enum pci_reset_type {
+	PCI_DEV_WAIT_FLR,
+	PCI_DEV_WAIT_AF_FLR,
+	PCI_DEV_WAIT_D3HOT_D0,
+	PCI_DEV_WAIT_BUS_RESET,
+	PCI_DEV_WAIT_RESUME,
+	PCI_DEV_WAIT_DPC,
+	PCI_DEV_WAIT_MAX,
+};
+
 /* Number of possible devfns: 0.0 to 1f.7 inclusive */
 #define MAX_NR_DEVFNS 256
 
@@ -137,7 +147,7 @@ void pci_msi_init(struct pci_dev *dev);
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


