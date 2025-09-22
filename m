Return-Path: <linux-pci+bounces-36631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEDB8F6BC
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BE117E419
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446082FD7CA;
	Mon, 22 Sep 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqLo6GuX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEB2F90DE;
	Mon, 22 Sep 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758528670; cv=none; b=gKCf9RT+CWgos77SICo5tr1O3xB/Wi6v0SEgJJhNDISWuu3mmOJLYd2HnUf59yJUvbUU0QZs2fc2oSjxeYMcLEKGv/HVrCmBC7Pkrr5Wo3ustOIg4K0/l71YyOVxK9nnIF29uiPNHpxl/UyrybmTmVViDTHVD8pYEzlaeMzN0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758528670; c=relaxed/simple;
	bh=7Ins6AEQ7dDX0vadBpeWn+HbzgGj9qTBdP2W4cvwl0k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dq1H5WDYw/JRtWxB9C+0qrTfe26/5NMevrxSigexU/d0E6V7g6ERdVqmdgjh7bFHdQyxXOuLquVT6+9Z/CZQwo79tsdJuYKgEqryrYv6sZ9UrV5soyC1ANqCHppkW6JPDRt/EVbygiIvxtjdbz56viIzYT4AzBZlqeGC6AaRFmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqLo6GuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D93C4CEF0;
	Mon, 22 Sep 2025 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758528669;
	bh=7Ins6AEQ7dDX0vadBpeWn+HbzgGj9qTBdP2W4cvwl0k=;
	h=From:To:Cc:Subject:Date:From;
	b=QqLo6GuXu6QJb+rOWD9rWuLIXyxuevu77PsCG944IRsO+tLbxyA6ciWQotd1GzSDC
	 T7odxE4YvG7NkcNZY/jREJ5clpzvCzyehb1HRz77apEoglg6dCOyv3APHmf4a3RyRy
	 K5v+bIwBlZ6d1ISRzhaiKvC7HyrnxeK1FcqGuvDBAevxQN1hiU4eUwT1nL4v1KcA+o
	 rpnrUeN/NLMakQPI6Kl1XbKRFQvrjuguTeA4IZaUwVpgby8Cb0OGeKZ7qK3YosM0ty
	 3PuJzWY//qqjPevYfjzERK88Hx8igH5V+8mO/F3eZ+NnlRqVWpiEWRWZbRAuxg047r
	 F8U4dxkegdWPQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] PCI: tegra194: Rename variable 'root_bus' to 'root_port_bus' in tegra_pcie_downstream_dev_to_D0()
Date: Mon, 22 Sep 2025 13:40:57 +0530
Message-ID: <20250922081057.15209-1-mani@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

In tegra_pcie_downstream_dev_to_D0(), PCI devices are transitioned to D0
state. For iterating over the devices, first the downstream bus of the Root
Port is searched from the Root bus. But the name of the variable that holds
the Root Port downstream bus is named as 'root_bus', which is wrong.

So rename the variable to 'root_port_bus'. Also, move the comment on
'bringing the devices to D0' to where the state is set exactly.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 0c0734aa14b6..dac069fb1a16 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1270,7 +1270,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 {
 	struct dw_pcie_rp *pp = &pcie->pci.pp;
-	struct pci_bus *child, *root_bus = NULL;
+	struct pci_bus *child, *root_port_bus = NULL;
 	struct pci_dev *pdev;
 
 	/*
@@ -1283,19 +1283,19 @@ static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 	 */
 
 	list_for_each_entry(child, &pp->bridge->bus->children, node) {
-		/* Bring downstream devices to D0 if they are not already in */
 		if (child->parent == pp->bridge->bus) {
-			root_bus = child;
+			root_port_bus = child;
 			break;
 		}
 	}
 
-	if (!root_bus) {
-		dev_err(pcie->dev, "Failed to find downstream devices\n");
+	if (!root_port_bus) {
+		dev_err(pcie->dev, "Failed to find downstream bus of Root Port\n");
 		return;
 	}
 
-	list_for_each_entry(pdev, &root_bus->devices, bus_list) {
+	/* Bring downstream devices to D0 if they are not already in */
+	list_for_each_entry(pdev, &root_port_bus->devices, bus_list) {
 		if (PCI_SLOT(pdev->devfn) == 0) {
 			if (pci_set_power_state(pdev, PCI_D0))
 				dev_err(pcie->dev,
-- 
2.48.1


