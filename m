Return-Path: <linux-pci+bounces-39700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C170C1CA3F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 293014E596F
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3025354AD1;
	Wed, 29 Oct 2025 17:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TcNwTjRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A71DF994;
	Wed, 29 Oct 2025 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760626; cv=none; b=YnVrDlShzSjr3MInWjpaU0fxqxD80cxB5F4UGQ/1fQkw/EDzt1dGz/9H8QnAGpz0v+PydOuMCDjb96Zq1/Q9JsCrThS42xsRJIaEjVtBxI/MoiO1hTrDm8SxIZrtkCa0ahCVC7QhZnKJOYiLkimJYIYIl0jNWiPOE/Tn+wpMlOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760626; c=relaxed/simple;
	bh=KOwiUHfMn1x26g5AuHjur/7d23DIKlmVDPD29Tb+wwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uBDKk2+KUzCaddxi6xUM02FKEKvFMIdFOy96YcJJScGtTYn+l97hlo1waQlGXDlYHw5K1kZR0GZ2WTCYY9yf84YZJ5YUeu5csKGrGxQDo6ltVZ6aif7A4ENfgvQi5xrrinxhhSnk8APJBbSFVhv2LUbWblEklmV2OubRh/mkAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TcNwTjRy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760622;
	bh=KOwiUHfMn1x26g5AuHjur/7d23DIKlmVDPD29Tb+wwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TcNwTjRy5FgQpxQtD5LVNsR5bAo3cC0l2MJlPVwGrkVSzIs1ObsdrAuWeP13poSH2
	 2usb1qfzTxgZy0xZXuYYTBImuHmqPlXLF4FRWiTTm6n7ZhLMj8gCDaAVAJwMS1RHKf
	 QmLd2MTrbzNjeKcgAGXxlkFYJ9cxp3DUZVSg6UTjo93uNGCqI3KihHduu+uFB2yHQw
	 6qZ7cQpFnxPaBKTOx1yO6yufNIJY1qc9yNzoxH4je/tfIReXG6ovznlkgpomx4Pt8L
	 Zkz/Z7Yc8jA+m4P9iePSRcu1QySILJyJULQfK8AXo4qUqJ8yAuhIyei00cB0HTzHqw
	 bfWTu2K/xmHZw==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 94E5F17E12D5;
	Wed, 29 Oct 2025 18:57:02 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 1DA9148003D; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:40 +0100
Subject: [PATCH v4 1/9] PCI: dw-rockchip: Rename rockchip_pcie_get_ltssm
 function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-1-ce2e1b0692d2@collabora.com>
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
In-Reply-To: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=KOwiUHfMn1x26g5AuHjur/7d23DIKlmVDPD29Tb+wwI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW07kSfM27DEyFgIygv3KfKbO7g4Y5RUS
 0FkVNHVfQzUD4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVtAAoJENju1/PI
 O/qa+8MP/0gXB/ghhIbwUxROpOWVF/mYgegB29+5ohKIbDKB0PqmmYUeh4J0jL17eXRBTBit0h4
 S7harhCtKIf8HBElCKUOSeu1OkJ1o5b1qu9ibdQz7dXNrNLIdu5AFCTSL4IR5opwgy2ziVUsWOU
 SlpbP9fKLTsSKwnqS7ihg87CA1/tZFGd4XA/MN1ovRoPrzG/LdR6JOlpeoribtBrOtSJ71aHVDm
 miaHJSqxGRH1/pVzzjDGVDWQmo4NGMDfwcFchGr9uBOlhycRuwJFXtuR8H9RYEONQK3JufzziqE
 62+AijWrjKJlr/0LLK7EjzHYgVbbyVRU7relSc7uG+PB5z1u1WDzKAL+qZlxX9We3YvW/MVYp2o
 vQcBryrzZ8cvSTbDXg2fr12t+KdkMeAtTKPjhbXfCgfZKSD5E1mivIVb1IAitX2EcXVaMD6XZVF
 55ptG+9io6a2XPxSKSEa/BUpfTcEWf6Xq65LOlaL5x2X+MJrU1PYoVPd2w3EgBFSumZRa3wBvQn
 Zw5d4joGTlBTt4VffuH91dbDsnK7y9yueikTPbeIKE8smAyZ8p6V+yUF1il3sP5F83iovwg+3Ub
 IBBpwlG9PlSq6gwaA240uQo+EROea1Oi4K3P5dBui+8/d5yGwFbbED+yPC3Ebi98/Ag7HOuy9XN
 YA0QoKdai/wwndt/Z3fowsA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Rename rockchip_pcie_get_ltssm to rockchip_pcie_get_ltssm_status_reg
to avoid confusion after introducing the .get_ltssm operation support,
which requires further processing of the register.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 3e2752c7dd09..58427db1cc65 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -175,7 +175,7 @@ static int rockchip_pcie_init_irq_domain(struct rockchip_pcie *rockchip)
 	return 0;
 }
 
-static u32 rockchip_pcie_get_ltssm(struct rockchip_pcie *rockchip)
+static u32 rockchip_pcie_get_ltssm_status_reg(struct rockchip_pcie *rockchip)
 {
 	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
 }
@@ -195,7 +195,7 @@ static void rockchip_pcie_disable_ltssm(struct rockchip_pcie *rockchip)
 static bool rockchip_pcie_link_up(struct dw_pcie *pci)
 {
 	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
-	u32 val = rockchip_pcie_get_ltssm(rockchip);
+	u32 val = rockchip_pcie_get_ltssm_status_reg(rockchip);
 
 	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
 }
@@ -460,7 +460,7 @@ static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_status_reg(rockchip));
 
 	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
 		if (rockchip_pcie_link_up(pci)) {
@@ -487,7 +487,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
 
 	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
-	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
+	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm_status_reg(rockchip));
 
 	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
 		dev_dbg(dev, "hot reset or link-down reset\n");

-- 
2.51.0


