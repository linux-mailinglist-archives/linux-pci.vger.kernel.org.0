Return-Path: <linux-pci+bounces-40876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FFEC4D3F8
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 11:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7B3189FA02
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BFE357A5F;
	Tue, 11 Nov 2025 10:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9iQxkNY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39810357A57;
	Tue, 11 Nov 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858290; cv=none; b=Hg94wX6MKhD/YQWadYmAvjpM3ZHt/H3Np81mmF2tUa2moan3tVocyYLJRnSrO/4Ub423A2sCbmh06D5fZqxR7QXAeKhe71ZfY85tEGgUHvnrjGkc8Rzg9TfL+mrL3Sb6vK3eNQ3ciktRk2qB5liqCGtNx3FgdXF7D6NkIuTt4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858290; c=relaxed/simple;
	bh=3dzt9stCeLSwFKMX06lVk4HwAdy/DUcJhFoRjwg4hVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJz6fDi6/mB/YpBepgfkIqg8orLLaq9etTCpzrGaLPLFxqGOzViwDacm45tmF/AmWSs4QUcKcMevsIsNPKxYTJ6cVDS9VpyLhj/tlE/KmvtlPE0hPWuY8dM+2AbRk60ky0QAJ95dO2pusgX/e9/o9uqmHKXKzwtBEld2GbhdgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9iQxkNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4356AC4CEFB;
	Tue, 11 Nov 2025 10:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762858289;
	bh=3dzt9stCeLSwFKMX06lVk4HwAdy/DUcJhFoRjwg4hVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K9iQxkNY0DgRAJ63rQgNjURvSqltif97sxOR+IE/AcB44tB1lY4ysxabyE23Q1F8F
	 1Pw36bcWXXIPCrZAbWz1l8NfKlNNSyl62foBplCdrWLkuhlXgN+GxEgdI5MN1Fcewt
	 8KRhV/HAl8Q++dtw+QhitOMXxPeb4xF7vfKqju2Pwjd2lhI97hq0wr5+mDkSVTWDkE
	 c9quCTFuSIB6lPAKxnPz9xfDEOmgkZbw3BNYGpciKXT+O0DTwJVcu68SzBpJe5wfig
	 xrC/9NVvPuRZ55Pkqs+K3vDLZv+mAvcIQVrep2sOML/gLdd2t8XGuCIZq4P4cLxkeZ
	 to8hGCki1NSXg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 5/6] Revert "PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt"
Date: Tue, 11 Nov 2025 11:51:05 +0100
Message-ID: <20251111105100.869997-13-cassel@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111105100.869997-8-cassel@kernel.org>
References: <20251111105100.869997-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6314; i=cassel@kernel.org; h=from:subject; bh=3dzt9stCeLSwFKMX06lVk4HwAdy/DUcJhFoRjwg4hVs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKFRcXizsun3v1w+rdpRcCi2bomggHlmYG1iXKvPTP0H B2aY0I6SlkYxLgYZMUUWXx/uOwv7nafclzxjg3MHFYmkCEMXJwCMJEjGxj+Fz7fHtkVlc0wvSQ4 /dFlv7NVqgpyBrJzt+V/VfBe4VAYy8hwPn15a3tORUjthaOxIvbXnYVXpB7Zv+UlZzar9appu9+ yAgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

This reverts commit 4581403f67929d02c197cb187c4e1e811c9e762a.

While this fake hotplugging was a nice idea, it has shown that this feature
does not handle PCIe switches correctly:
pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46

During the initial scan, PCI core doesn't see the switch and since the Root
Port is not hot plug capable, the secondary bus number gets assigned as the
subordinate bus number. This means, the PCI core assumes that only one bus
will appear behind the Root Port since the Root Port is not hot plug
capable.

This works perfectly fine for PCIe endpoints connected to the Root Port,
since they don't extend the bus. However, if a PCIe switch is connected,
then there is a problem when the downstream busses starts showing up and
the PCI core doesn't extend the subordinate bus number after initial scan
during boot.

The long term plan is to migrate this driver to the pwrctrl framework,
once it adds proper support for powering up and enumerating PCIe switches.

Cc: stable@vger.kernel.org
Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 58 +-------------------------
 1 file changed, 1 insertion(+), 57 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 28f5f7acb92a..b10e8adc79bb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -55,9 +55,6 @@
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
-#define PARF_INT_ALL_STATUS			0x224
-#define PARF_INT_ALL_CLEAR			0x228
-#define PARF_INT_ALL_MASK			0x22c
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_DBI_BASE_ADDR_V2			0x350
@@ -134,9 +131,6 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
-/* PARF_INT_ALL_{STATUS/CLEAR/MASK} register fields */
-#define PARF_INT_ALL_LINK_UP			BIT(13)
-
 /* PARF_NO_SNOOP_OVERRIDE register fields */
 #define WR_NO_SNOOP_OVERRIDE_EN			BIT(1)
 #define RD_NO_SNOOP_OVERRIDE_EN			BIT(3)
@@ -1604,32 +1598,6 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 				    qcom_pcie_link_transition_count);
 }
 
-static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
-{
-	struct qcom_pcie *pcie = data;
-	struct dw_pcie_rp *pp = &pcie->pci->pp;
-	struct device *dev = pcie->pci->dev;
-	u32 status = readl_relaxed(pcie->parf + PARF_INT_ALL_STATUS);
-
-	writel_relaxed(status, pcie->parf + PARF_INT_ALL_CLEAR);
-
-	if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
-		msleep(PCIE_RESET_CONFIG_WAIT_MS);
-		dev_dbg(dev, "Received Link up event. Starting enumeration!\n");
-		/* Rescan the bus to enumerate endpoint devices */
-		pci_lock_rescan_remove();
-		pci_rescan_bus(pp->bridge->bus);
-		pci_unlock_rescan_remove();
-
-		qcom_pcie_icc_opp_update(pcie);
-	} else {
-		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
-			      status);
-	}
-
-	return IRQ_HANDLED;
-}
-
 static void qcom_pci_free_msi(void *ptr)
 {
 	struct dw_pcie_rp *pp = (struct dw_pcie_rp *)ptr;
@@ -1774,8 +1742,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	struct dw_pcie_rp *pp;
 	struct resource *res;
 	struct dw_pcie *pci;
-	int ret, irq;
-	char *name;
+	int ret;
 
 	pcie_cfg = of_device_get_match_data(dev);
 	if (!pcie_cfg) {
@@ -1932,27 +1899,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "qcom_pcie_global_irq%d",
-			      pci_domain_nr(pp->bridge->bus));
-	if (!name) {
-		ret = -ENOMEM;
-		goto err_host_deinit;
-	}
-
-	irq = platform_get_irq_byname_optional(pdev, "global");
-	if (irq > 0) {
-		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-						qcom_pcie_global_irq_thread,
-						IRQF_ONESHOT, name, pcie);
-		if (ret) {
-			dev_err_probe(&pdev->dev, ret,
-				      "Failed to request Global IRQ\n");
-			goto err_host_deinit;
-		}
-
-		writel_relaxed(PARF_INT_ALL_LINK_UP, pcie->parf + PARF_INT_ALL_MASK);
-	}
-
 	qcom_pcie_icc_opp_update(pcie);
 
 	if (pcie->mhi)
@@ -1960,8 +1906,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_host_deinit:
-	dw_pcie_host_deinit(pp);
 err_phy_exit:
 	list_for_each_entry_safe(port, tmp, &pcie->ports, list) {
 		phy_exit(port->phy);
-- 
2.51.1


