Return-Path: <linux-pci+bounces-38311-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A00BE2493
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B6A1887089
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 09:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147DE3009CE;
	Thu, 16 Oct 2025 09:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj9TzT0A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF08E2DC760;
	Thu, 16 Oct 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760605476; cv=none; b=q73Of+ArdECLsOT9I2SsbqDI9FR21aEbQEoiXT/0TS0WFOc6klfygVzSKQZB1Ypn/ETCTp1VKL1OrXF0EI7uGeRjrAU7+I261kaSDnMYYTBqznWtdqGNf0ELZEfLs5oxG53Be1voYq5e5fpDRfPHmCjy7foyfT/UHZBjLMkzz84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760605476; c=relaxed/simple;
	bh=+lWpPiGYgIsj4CL7weoN8PdEGbyE8TzjYmObhr7nNbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=janyGNvqgeRp3IFI1b5mfewN2MC8AxaTejicddcWn2//vhC7kbq2OXl9g21+JjZk/xJVliRD8zgg2Sp20vqLPOjKz04uy+uteI53JMdnTcC0SM72Bfljl7QumVTOVwiKFfSssclB9D+cblssxqUv/Rsif5LO9XK64iaff5RCudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj9TzT0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1058C4CEF1;
	Thu, 16 Oct 2025 09:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760605475;
	bh=+lWpPiGYgIsj4CL7weoN8PdEGbyE8TzjYmObhr7nNbA=;
	h=From:To:Cc:Subject:Date:From;
	b=Pj9TzT0AlasKWSmm2NeAMCofrPObdVRGipvxqqyYgXfize+/9whtSJT8M2u/uN8wF
	 7a9m72xg9WK3i6EO6qxlcYG5Qjy2JTAEOlGAhm3EeeERq4Z7LTPETVW/RqrPfT9pQM
	 LM1THAyUbLCe3blKMosls3+L4BldpdSqCymlT2FRGQ81AP4QnBhGFYtd0y+973F0U8
	 diIUY7uTDVJOOLr7+l01jKkD0POvizO5VRXU0FkObwwQQzyssH2a7Zqe05YTieJamS
	 OM4dMuhfdrlXLsQwFJRj/D3WamMk1chivdzaV/icwaeUYeCQeZ1Pm+GOXa/5eHs6fs
	 Ze07tGQo3IRFg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v2] PCI: dw-rockchip: Disable L1 substates
Date: Thu, 16 Oct 2025 11:04:22 +0200
Message-ID: <20251016090422.451982-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2709; i=cassel@kernel.org; h=from:subject; bh=+lWpPiGYgIsj4CL7weoN8PdEGbyE8TzjYmObhr7nNbA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDI+bBW7H2mmu/iL+dml7il6tU1XA8/cu7Owb+miRqVpl gVXciX7O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRzQaMDHcveHt4earZVtgZ n9lx5IC4svs+4S91u5jqZM0uBFw0cGD471LT/GSVf+zB5d9qDE+9uvN6S3TU3kVRzK9lFbe+CzU uZwQA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The L1 substates support requires additional steps to work, see e.g.
section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0.

These steps are currently missing from the driver.

While this has always been a problem when using e.g.
CONFIG_PCIEASPM_POWER_SUPERSAVE=y, the problem became more apparent after
commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
devicetree platforms"), which enabled ASPM also for
CONFIG_PCIEASPM_DEFAULT=y.

Disable L1 substates until proper support is added.

Cc: stable@vger.kernel.org
Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
Changes since v1:
-Remove superfluous dw_pcie_readl_dbi()

 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3e2752c7dd09..84f882abbca5 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -200,6 +200,25 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
 
+/*
+ * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
+ * needed to support L1 substates. Currently, not a single rockchip platform
+ * performs these steps, so disable L1 substates until there is proper support.
+ */
+static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
+{
+	u32 cap, l1subcap;
+
+	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (cap) {
+		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
+		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
+			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
+			      PCI_L1SS_CAP_PCIPM_L1_2);
+		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
+	}
+}
+
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 {
 	u32 cap, lnkcap;
@@ -264,6 +283,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
+	rockchip_pcie_disable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 
 	return 0;
@@ -301,6 +321,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
+	rockchip_pcie_disable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
 
-- 
2.51.0


