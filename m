Return-Path: <linux-pci+bounces-19215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97DA00755
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 10:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DA93A3528
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 09:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2021D151F;
	Fri,  3 Jan 2025 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJPrZvpT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC331C07FB
	for <linux-pci@vger.kernel.org>; Fri,  3 Jan 2025 09:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735898301; cv=none; b=Wu2gpDOdcq+Ig7NVTtRJ0LIOWiM+Gs1GpaoxFJUMiitiq5WgjSNMxxoaqFRUQ/9ZQd0gyiYDFrL3+LGMFqujAmER/ijt4K4jAVdbf3J4z2zMVgsbJOTnsxFT7baqiYS/ilWsU4kOC5ivI6E1FdGDoLcwF9/S06EPBick4qBzLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735898301; c=relaxed/simple;
	bh=K4fzD7ubtKTn0SOctnqu1z25EeAlhR621aiktUmrQIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H2yuAICJIutq9o+CigVG2q5JaMrW/jywB42zYSTgkwFZxopj4QsOcbNV6v7JLLYB8ag2GREWxtsmJIfrXc8xpxC4W5R11rWUgZh41FlFddY/Qw1/F9ISCLTZHsLB/2vKcST88DqtwSW/1PWeBoCIz71aG7LM2AJKBGfqVp1J8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJPrZvpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F10C4CECE;
	Fri,  3 Jan 2025 09:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735898299;
	bh=K4fzD7ubtKTn0SOctnqu1z25EeAlhR621aiktUmrQIc=;
	h=From:To:Cc:Subject:Date:From;
	b=OJPrZvpT6AQbvqgtB9D4+QOFBPxLzaXc67UE8SuqxFAaUxNQjfY2lE3aZAdoJT3ua
	 FWEva1e/bC31mVTvFNwdkSJRyN0YA5GNgFhXLrZ0XiCf5RLb8PNHV9B8d5kTpL3uNY
	 traU8B33VeEVU0iuOdS4NA/lzUdv49Lrfpg6x6mZbTNmfwFV6EmCRFW1VmoZkSLagb
	 2gGOgwHNUzu9oHma897WyBcsDswCUsGwNO8HQ3ARrBTot3ZDj2OZLRRIhhMSxhc32Z
	 Fhn5m5D8uC0hyfglJt0OUcCWF7M7NXrMtbYdY76wfWvd6874gysdaAvvNZHBrkSAb3
	 dI2B4NVH3y3Tw==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] PCI: dw-rockchip: Replace magic values with defines
Date: Fri,  3 Jan 2025 10:58:12 +0100
Message-ID: <20250103095812.2408364-2-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; i=cassel@kernel.org; h=from:subject; bh=K4fzD7ubtKTn0SOctnqu1z25EeAlhR621aiktUmrQIc=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLLt2y58jajKmlB5OyESRcuba8XWTWVN8fJJs5CT+Swa MWEzBy1jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAEykZQ3D//T4eQfuXnyqs9um 8oOhuvGuuMVH1/38+/BQxHvHlS7aO5QYGWb+upyyjEvhgEFAc+fr/R9bPAIqtJqUnKw8C1/m370 QyQsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Replace magic values with existing defines.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index ce4b511bff9b..b65c6ad803c6 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -488,7 +488,8 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	}
 
 	/* unmask DLL up/down indicator */
-	rockchip_pcie_writel_apb(rockchip, 0x20000, PCIE_CLIENT_INTR_MASK_MISC);
+	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
 
 	return ret;
 }
@@ -545,7 +546,8 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	pci_epc_init_notify(rockchip->pci.ep.epc);
 
 	/* unmask DLL up/down indicator and hot reset/link-down reset */
-	rockchip_pcie_writel_apb(rockchip, 0x60000, PCIE_CLIENT_INTR_MASK_MISC);
+	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
 
 	return ret;
 }
-- 
2.47.1


