Return-Path: <linux-pci+bounces-39702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEE0C1CA42
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 19:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F3184E5E08
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E20354AF3;
	Wed, 29 Oct 2025 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SVSaYA3R"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11593546F5;
	Wed, 29 Oct 2025 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760627; cv=none; b=dPh/8gXwz34sJLyRAVEb1hiSqzKq1m+Rqp218bvGeHyhUHrSuq4xcE4yQ0uDbfyn1BGFO7smAF3Fa+5BmHIC+eSdPWAIVpR3FwdnYazyiFBvTi4CE/HNCqCJvPMyly6Osy3PrVIM/PO+2opBHaQPBUD/kM8S9fb900yqdK5G1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760627; c=relaxed/simple;
	bh=gaQ6PhWIvkF7IvK5kYE/g8/88NuFUu8QFhhiMCw+Mjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFH2k+xMnvMaU6fs0qD2HqG75L9NZPTcyrSWAEAJwz8lO5OX2d4F0npuRp5oDrNLZ3dOuckt6ZeidESVqR/zLPmP3duTvIeQWOYXi4WehKXzRkNNVbaqudNIceYAWCAt7wbbOlrDt15m7sqCSBxJwgX+8z8CpxBzw7MetZdpuUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SVSaYA3R; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760622;
	bh=gaQ6PhWIvkF7IvK5kYE/g8/88NuFUu8QFhhiMCw+Mjg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SVSaYA3Rlj4kq+syR9xCMMFpfJ6Gy8VgB6noI32UIkHwf8SWJQB+Sd7+SU2I8+SBj
	 iLLIQ/5Ntb+QJt809FRiRI0AXLVtYReKLOLhKhMEQsBaZVIxBwVTWZoqS+1rL7dsVv
	 2hU8c6CKvXxteB3iB26MEabpREtagXK9pz7knd6Yua7yTVIyO+6NdCHGM9Wluvu3/9
	 19d7Vm3dErM8RqVZiI+EBvdXFaKHCDO/EX/EDt03FbJ4WH695mB8Pck66GPW1UFY2u
	 RoNZhvEe4l/HONVUK9kBkHVzKxnC+8Ig5ge5LPb8NlUzMgKaw5SWq2x65NdTS6uHWq
	 FoSLV5OBFaSUw==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C567B17E13F9;
	Wed, 29 Oct 2025 18:57:02 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 21057480062; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:44 +0100
Subject: [PATCH v4 5/9] PCI: dw-rockchip: Add helper function for
 controller mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-5-ce2e1b0692d2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1954;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=gaQ6PhWIvkF7IvK5kYE/g8/88NuFUu8QFhhiMCw+Mjg=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW3feJBw5VJVIAUNbSIQ1BUn2NdGO2FxA
 PdWqXC9j3d88YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVtAAoJENju1/PI
 O/qaYWkQAIIfCyKZgR2sek5kFYRGVB2I28xxykuPxKo93XHAkAA1sYFvmdCdyR46uXlZUJxBOTd
 7aC31QgE13T62P8HrFlulEgUlhUBAypWDSKtbmayN+pmTmXPPYcG/Q7jVeCfleZObo8pZ92LPdU
 MRLYZSZ8wZb4Bqkj33xjV1uQjwGVoLklHVCFFRM3URLuCx6dedaE+lxYa4HpTmtCcg3OuwiMrGX
 ELOVl5uwZUvC5ZlBUf6aL6QW/+uWr0Kf8cZxfYvX/nYvUNbYt78h0poibhYSLuL4zC2VncdVSyL
 ctVOM+gY1o0auMWJ1Ol5ilbnr/qinvRcYtkBQPfMTRTJmWKb2ouf2OJPN5SlpBfLSqGFGjMoxgO
 K+3Q1y+8nxU5CiuQXDlorw65TrGT6TDexokpsaOfuoMIh1VazaGg15js6tx0wxcqM/3KpUr1tfb
 WZWG0qYIXNOKR0TLfWRaiwgulgfzoN8W7R/GvTjUL257pfauJg+7/XrjAvHPwo02Jesss/ugCu+
 A5nejRcUJArnvdBxXbUijfJzN11vyCY4OnfoVx16Kh6HBXeTg53KhmDx9ItaQn6Z5WYeo+9+vyJ
 JIMqs4YHlIU63h0XdF3KTxuXAI7fT/kLejZG6WgdZDz1nI8A+x40WMW120PT7UAupMs5OIDcEHX
 m7625g8mwhLPrHhrRMKUvnw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplication and improve readability by introducing a new
function to setup the controller mode.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 45586a964ead..5c8d30e15a44 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -523,6 +523,11 @@ static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pci
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 }
 
+static void rockchip_pcie_set_controller_mode(struct rockchip_pcie *rockchip, u32 mode)
+{
+	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_SET_MODE(mode), PCIE_CLIENT_GENERAL_CON);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
@@ -546,9 +551,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	}
 
 	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
-	rockchip_pcie_writel_apb(rockchip,
-				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
-				 PCIE_CLIENT_GENERAL_CON);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_RC);
 
 	pp = &rockchip->pci.pp;
 	pp->ops = &rockchip_pcie_host_ops;
@@ -590,9 +593,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	}
 
 	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, PCIE_LTSSM_APP_DLY2_EN);
-	rockchip_pcie_writel_apb(rockchip,
-				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
-				 PCIE_CLIENT_GENERAL_CON);
+	rockchip_pcie_set_controller_mode(rockchip, PCIE_CLIENT_MODE_EP);
 
 	rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
 	rockchip->pci.ep.page_size = SZ_64K;

-- 
2.51.0


