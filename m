Return-Path: <linux-pci+bounces-34052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2772CB26AE0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 17:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59143A90D3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Aug 2025 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ADA20B803;
	Thu, 14 Aug 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qA+oPf5F"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE91E555;
	Thu, 14 Aug 2025 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184923; cv=none; b=G1QdgMU3gjVwgR04v8YycNjTj/LdcS1v60sKWpIIf5hIRglmlqK0NbU4DoIoNJY0ayJQ5HGE/Y1jQCPEymj+HDPeu+6Lm1FN/wFYd3Sdc/pAZqwI/21zKhdFeZw8Ke4a8zpkqDSujpyAIyXGp7lAlxizIY+L4XoUZaIrYadgG14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184923; c=relaxed/simple;
	bh=moW5SI2CE69IW+4yh1G1lKy2mihZtHEKrVslOxCjRoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl847gSpm5Ify9xKJw8gWGVsvsZ/U3QPKKNxzz2ngddHEJ5MR6jPmOKTRfy2ySOamj8cZF19uj+kQTye4E3VzfFrixvwSJpDCq8fxjQ6CAdzFN51pj6BImg3EzwlmjbrJdD57iFmdTG+8TMDTdC6+glFkKayFJMV95QyUaTBJD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qA+oPf5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A818C4CEF1;
	Thu, 14 Aug 2025 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755184923;
	bh=moW5SI2CE69IW+4yh1G1lKy2mihZtHEKrVslOxCjRoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qA+oPf5F4oizM5Jlzpx9mg2XSZC9Sj0biaUgb0ERva7kQCctz9Xys51s7BR+Hw6RN
	 JbsRGOT391Avmgks+DVlyBJI1nAQITCum4wX59LITCCZT38jcXw4ikYRjt4S3c4WeX
	 ruKKs+ydr41sbsQNg4Wi8EsV1bNyPrVYVFWQG0Wut0fsPhNt+BYaiDGd88JTXMVmrN
	 K0SxyFCs6ihCf/Fnr1lZcNen/vdOrtQ4ORpkJzIsIh7Mo6l6G1cVaZhR1PdeTsGE4c
	 hWgAjne3djADBdYpyXC+IPeSoPK2Q1Yn+xbe4E/tfaXtvhiRZYTIHIMbswnAYn/0fB
	 6oo75cQ/UdNrA==
From: Niklas Cassel <cassel@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 05/13] PCI: imx6: Drop superfluous pci_epc_features initialization
Date: Thu, 14 Aug 2025 17:21:24 +0200
Message-ID: <20250814152119.1562063-20-cassel@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814152119.1562063-15-cassel@kernel.org>
References: <20250814152119.1562063-15-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=cassel@kernel.org; h=from:subject; bh=moW5SI2CE69IW+4yh1G1lKy2mihZtHEKrVslOxCjRoE=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDLm/vvWwH28edPRnO/fOiJfpXK/Lr9mo+LFuctYufxed 03s2T6PjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk8kVGhlm8XyZFBDFwrime yP9jv9vjDdNndOde1inOXcIe6NE+p5zhn1GTw9N7/F+eincyP/P8HvVZx9/1nvvv8xpHre03vuJ 14AQA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

struct pci_epc_features has static storage duration, so all struct members
are zero initialized implicitly. Thus, remove explicit zero initialization
of struct members.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..7ee21fac81a6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1387,9 +1387,7 @@ static int imx_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 }
 
 static const struct pci_epc_features imx8m_pcie_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
-	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
@@ -1398,9 +1396,7 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
 };
 
 static const struct pci_epc_features imx8q_pcie_epc_features = {
-	.linkup_notifier = false,
 	.msi_capable = true,
-	.msix_capable = false,
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_3] = { .type = BAR_RESERVED, },
 	.bar[BAR_5] = { .type = BAR_RESERVED, },
-- 
2.50.1


