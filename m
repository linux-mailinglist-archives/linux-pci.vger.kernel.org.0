Return-Path: <linux-pci+bounces-39704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56846C1CA4B
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AAD604E6727
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DCD354ADA;
	Wed, 29 Oct 2025 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OVW3/Hss"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510262D5940;
	Wed, 29 Oct 2025 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760627; cv=none; b=WY8fxpdJ8hvAeNDYzF2zBQAy/8H2q4UCinutv+jXYi1KhIhIc0P/Mqy29nmV4Yg5Qxl5x9nFTGksbfrY6ztN1JtMzopq+nfRn7yBAjYmHMsZQpWb4mynN/zwnG/iDku/9hCzCZMSfoNH5XWDu1M75i5rKsJ/hxYYTwsaP092j+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760627; c=relaxed/simple;
	bh=PuyVfSl398NT/6ecyLhz+ySqbYBIDyiLnSHsDsbjgnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BUQ3te49uX+/hcsiMb2TcioSx+Ztq3AUQ/6PPvF8g0bRa948iZtMVMRifq02nKYPZgR+7OJUUCHuDTwcteTpAHqL3yboOnEGOBEky91YqDCf6QlxkvLieUdMeLY8D4wPLye7ehu/w198kMMYSKLGNR5WsSaSqMNjV9VK/WuNPyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OVW3/Hss; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760622;
	bh=PuyVfSl398NT/6ecyLhz+ySqbYBIDyiLnSHsDsbjgnw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OVW3/HssUYIRIN6T0VzeMzq27aBBExEMMAF1Aut8MLTeyz103S9F2ozyP3TrP07Fs
	 8U/jT0ru5u3SBdQMS9tz1CbtMpxCSY/9mM7lPQK0fu15Wn184cHZc0n5ShPh/tovVv
	 TQNAFe2MncWhPpNQ4VKCWCQCTM2ssQ9zmZknxWMmKZovbfxa2zFUI8zJ0i4NEuKlLy
	 65SYthHmso0Q0Tnz8ZX2I9PfPZwXlwWcdVcVw6saDlkF7eFrgqGvtqNXISvAGA7tG9
	 OX02lB/EJMJw/LBWI8bUrhHZ/hkyVeli2QEXtFH9FS16sCWJfg7HR74Qxm/ZI9OC2C
	 pVnGLnC3HVoSw==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 69DBA17E0FC7;
	Wed, 29 Oct 2025 18:57:02 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 1E062480048; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:41 +0100
Subject: [PATCH v4 2/9] PCI: dw-rockchip: Support get_ltssm operation
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-2-ce2e1b0692d2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1643;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=PuyVfSl398NT/6ecyLhz+ySqbYBIDyiLnSHsDsbjgnw=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW28H/21LLERHjkq71fIYPt6/SEpljoWa
 BB5CDQXS5JngIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVtAAoJENju1/PI
 O/qaVLcQAJp8e92zwlTDz6wMa+kwBneL72FSfp7tTJ6Em5BGqGUFX9yESNKiTFPHJYweHs9BHvF
 2QQo/waZGNExHAD5gRNVXBySRO6IWHlHgQ2LRrMD31MdMR/CvISeo5o9J5ZWCieG6oVXgGnPER6
 6EYRcrfDS0AYmk6bVsTQhTmUfeoWRjD0P2OBv4YseEMMnQZ8u1spKu9THXIO+IMdKSHoTGN8NEp
 NjVNjSqjLdUgkM3Ib78GmXhApCs94oFxA679a8vyBkcIqbaNrjr+1ittAoeW4A7ylIKTERqSGpG
 cUN+g9cVaACEdt7N2Bon6FUxomSL8QNv+fGwYueFCezjP/Y38gAc5INLJAAmV2UHt3f0vETs91Q
 z2936iltjMbwabUlOAhj5KycF6NGwPIgUbga71SxLFTk1osW8sD+X4lnmoWUXadY+TyltfhrMNg
 w6BhAD++3321oR2sibCNlvjEE7ljbk0pmSnFTGA81CnaP322i9rprD6cfpuVTHy8yIsM6a5u1hf
 lW4hTtrUFeP/J7GagYr/ilVjBKsB138AwZFx1KAVlpYFGsrDoO4WxfsAPLy06+B9E5ksf13MATr
 ClswZmNkLabrmX3FH6WQbaNim1QOWcBN2YHiw8Y4FKy/nnCmE4NKkhR+8RSYC6JN9nHXLC0bnrS
 8Fyea40atVBsk4dW3ErAklA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Implement .get_ltssm operation function pointer, which will be needed
for system suspend support. As the driver used to have a function
called rockchip_pcie_get_ltssm() with different behavior the new
function is named rockchip_pcie_get_ltssm_state(), so that issues
can easily be detected when porting patches.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 58427db1cc65..e3d7792f7819 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -180,6 +180,14 @@ static u32 rockchip_pcie_get_ltssm_status_reg(struct rockchip_pcie *rockchip)
 	return rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_LTSSM_STATUS);
 }
 
+static u32 rockchip_pcie_get_ltssm_state(struct dw_pcie *pci)
+{
+	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
+	u32 val = rockchip_pcie_get_ltssm_status_reg(rockchip);
+
+	return FIELD_GET(PCIE_LTSSM_STATUS_MASK, val);
+}
+
 static void rockchip_pcie_enable_ltssm(struct rockchip_pcie *rockchip)
 {
 	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_ENABLE_LTSSM,
@@ -446,6 +454,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = rockchip_pcie_link_up,
 	.start_link = rockchip_pcie_start_link,
 	.stop_link = rockchip_pcie_stop_link,
+	.get_ltssm = rockchip_pcie_get_ltssm_state,
 };
 
 static irqreturn_t rockchip_pcie_rc_sys_irq_thread(int irq, void *arg)

-- 
2.51.0


