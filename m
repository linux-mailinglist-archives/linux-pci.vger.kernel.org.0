Return-Path: <linux-pci+bounces-28271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33337AC0BC1
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 14:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAE73AADB3
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC2222FF2B;
	Thu, 22 May 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxFyp0Pw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1192135CB
	for <linux-pci@vger.kernel.org>; Thu, 22 May 2025 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747917608; cv=none; b=t9rZKT6lY7vOc2b+OhksCOJ8mKXmfx6UJnkbyqiqXCJGxPbO2frNxt7Vbx2VA9XXdJlnOSsTQXoOAunbLuoux+UemnRwsFBrnRE4JyeiKviGGvZVagKOuUxJCM0CjmIpmUrs0V639XWnA2aI23SPf/OkOAsTLd4qG1VaJnCiPjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747917608; c=relaxed/simple;
	bh=dIFmpsAhMvCplcUfGCTOY0heRVtKxZ1RNz40PxK8rOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I4LVKt3eNdSv+rbunlEAXgt7RRrStNU1CRPMzZsz2rQ+ZXC207PZqhXBGTTkxIghYB5jiMaRC5z4c6gNI+F+s7vFM4VmaxjtxDwyZPxdKrz5xVfFrdsOkHJlZx3MerwcXsrWxrFWFlKsUtRkMgYfOCP+csaxPGbGa4aYnQhpk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxFyp0Pw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FF2C4CEE4;
	Thu, 22 May 2025 12:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747917607;
	bh=dIFmpsAhMvCplcUfGCTOY0heRVtKxZ1RNz40PxK8rOk=;
	h=From:To:Cc:Subject:Date:From;
	b=nxFyp0PwZTmRg83D1Vmmh/ZmyrjdXltyLFpuIVGyrQkxQO6Km0FRL4NpEGGEVHKIP
	 w1tLszf6o3IpPne4hxLm49xKOCbP4pWWs+C+kXBgg4kU/7O2Pr8plog5//wbd4MnrS
	 nX+SgixA8xLvDOUfCO4D67Rb2cQ6GeeNGEg3+0OXwUaLLnov/zY0LVtKfsds843w8/
	 KfthzZFTuAIIEYQ6uwJs7zMGLoHsq+ZIXH4bY+1wMzvJ4uiVr6iA4z07qvZj2uRJGo
	 VQ7sjEqPx/xIsVHkTtfCd9hGAWdrWbVYRecaRvjlGXYQQ1vqEgvjebkKhs1LdvWZ8V
	 l3cPr3nqTJBmw==
From: Niklas Cassel <cassel@kernel.org>
To: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH] PCI: dw-rockchip: Delay link training after hot reset in EP mode
Date: Thu, 22 May 2025 14:39:59 +0200
Message-ID: <20250522123958.1518205-2-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3121; i=cassel@kernel.org; h=from:subject; bh=ZYXfFcQXDiFwjrTUi2n35UtRuclFuX1gTrMksp86lBY=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDL0peVOfwo++dH/xZEkw9+pYrfqzyZMiD+ikTfHNGeXU fMZ8aL6jlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExEh5nhv7dRmMyUWUYZtZu+ r3XzevN+8+I/yj0NunNVZbwn7pk1y5aRoSt4a/AK72KtVYFBSSKSkwS+r/0l3MtyYvWL/owK/o1 KzAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

RK3588 TRM, section "11.6.1.3.3 Hot Reset and Link-Down Reset" states that:
"""
If you want to delay link re-establishment (after reset) so that you can
reprogram some registers through DBI, you must set app_ltssm_enable =0
immediately after core_rst_n as shown in above. This can be achieved by
enable the app_dly2_en, and end-up the delay by assert app_dly2_done.
"""

I.e. setting app_dly2_en will automatically deassert app_ltssm_enable on
a hot reset, and setting app_dly2_done will re-assert app_ltssm_enable,
re-enabling link training.

When receiving a hot reset/link-down IRQ when running in EP mode, we will
call dw_pcie_ep_linkdown(), which will call the .link_down() callback in
the currently bound endpoint function (EPF) drivers.

The callback in an EPF driver can theoretically take a long time to
complete, so make sure that the link is not re-established until after
dw_pcie_ep_linkdown() (which calls the .link_down() callback(s)
synchronously).

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index c4bd7e0abdf0..05b8e4cbd30b 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -61,6 +61,8 @@
 
 /* Hot Reset Control Register */
 #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
+#define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
+#define  PCIE_LTSSM_APP_DLY2_DONE	BIT(3)
 #define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
 
 /* LTSSM Status Register */
@@ -487,7 +489,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	struct rockchip_pcie *rockchip = arg;
 	struct dw_pcie *pci = &rockchip->pci;
 	struct device *dev = pci->dev;
-	u32 reg;
+	u32 reg, val;
 
 	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
@@ -498,6 +500,10 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
 		dev_dbg(dev, "hot reset or link-down reset\n");
 		dw_pcie_ep_linkdown(&pci->ep);
+		/* Stop delaying link training. */
+		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
+		rockchip_pcie_writel_apb(rockchip, val,
+					 PCIE_CLIENT_HOT_RESET_CTRL);
 	}
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
@@ -585,8 +591,11 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* LTSSM enable control mode */
-	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+	/*
+	 * LTSSM enable control mode, and automatically delay link training on
+	 * hot reset/link-down reset.
+	 */
+	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
 	/*
-- 
2.49.0


