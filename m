Return-Path: <linux-pci+bounces-38211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D220BDE7B5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C17254FE161
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FAB450FE;
	Wed, 15 Oct 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTr4QbiR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877839FCE;
	Wed, 15 Oct 2025 12:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531525; cv=none; b=NP47N9lwK3LJ97u85uGFPhUl2C1rAcTXDzuTKTWdIrj3sjxQcs+qyBoqFWph09QnDAiQtE/4cHcpvoJip62Rv3IOGsU8KrlkVdajW4DPNS1a/LjhYynU1mEeMIhNDoA037D8+4gFwjcKC9PKU+XVU2K/p6wJuEILdME55H5L/bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531525; c=relaxed/simple;
	bh=5N9ifJNPMX7iGbLSPciaEtZ0geP6Y6nlRMPr+SPHcMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=keClJ177wEv8nk77LoYIMLhUcQnd7yB8H5KB/nBCup3zgYgxuGy5Ga6Mzj1Cb57Hr8pn6DIlGXJ1N6tn3hpKSFuHej2G2w83yBxT3WKS7KI9RfnTx/8d37tM/74bm5EeXh+5z3KWK0jxjUfM7tdTfYKuqeuXodVYSidelLizYP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTr4QbiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8DCC4CEFE;
	Wed, 15 Oct 2025 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531524;
	bh=5N9ifJNPMX7iGbLSPciaEtZ0geP6Y6nlRMPr+SPHcMk=;
	h=From:To:Cc:Subject:Date:From;
	b=WTr4QbiR2+wAU+XA9RLxcQ4d16cjQypyoDxU5uyMdPFCK6WNGpcd+MwYgGBSUkoCb
	 Vqf9U1nraCPY04gRPKM1Odeu53nIyMM60pIbFE3tmczScsSRF566VFp3k4aT/umnRO
	 q6D+cjZfWyYHMm7J6BVldqrAHKHAprIPGrHee+A7Z0C+emMQgdnBQgZyypjXrfZfIi
	 zFy9oTgYfJvpyQFmoVV/5nPsYFs9lKC5sbQRr0pwM1Rv6+Baim/zTs3Ysl8Du1B6c4
	 eh/rw2kI8rTpkPgAfkMLtMwx4BXUWhcvJWOFibc2wyVYVDUluLYo9tRnI6eu0roudF
	 rZT7wH5wNbUkA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Niklas Cassel <cassel@kernel.org>,
	stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: dw-rockchip: Disable L1 substates
Date: Wed, 15 Oct 2025 14:31:43 +0200
Message-ID: <20251015123142.392274-2-cassel@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2706; i=cassel@kernel.org; h=from:subject; bh=5N9ifJNPMX7iGbLSPciaEtZ0geP6Y6nlRMPr+SPHcMk=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLeT9GzOtnxsDYucorBuZ8fdh/pt2E6/G1T2nKLZ7/Xn PBbpHh1d0cpC4MYF4OsmCKL7w+X/cXd7lOOK96xgZnDygQyhIGLUwAmsi+A4Z92EsPaku4Jt68r zn31bZWOZ5ltv32w86yfjl/+zt/W3fiNkWFf25zmBqmGX4d/16+KChXyn3925fmz9YIlv2uMqlg OWPMAAA==
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
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3e2752c7dd09..28e0fffe2542 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -200,6 +200,26 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
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
+		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
+	}
+}
+
 static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
 {
 	u32 cap, lnkcap;
@@ -264,6 +284,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
 	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
 					 rockchip);
 
+	rockchip_pcie_disable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 
 	return 0;
@@ -301,6 +322,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar;
 
+	rockchip_pcie_disable_l1sub(pci);
 	rockchip_pcie_enable_l0s(pci);
 	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
 
-- 
2.51.0


