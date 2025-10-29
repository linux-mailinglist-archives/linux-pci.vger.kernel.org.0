Return-Path: <linux-pci+bounces-39708-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E5240C1CA0C
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90EB534C6DF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED7B3563C2;
	Wed, 29 Oct 2025 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IaYzqsF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0852F8BEE;
	Wed, 29 Oct 2025 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761760632; cv=none; b=hjxtvE6g0cb4RCavNzCTtPbfUTqqMRFc9KyOP+81f8E/FGiCa0XC6zikSVdUm1TWoyY0vP6Xo1Akeef94nhtQcFBle3rWP3HbgHgf7pB4uGaPHSbAoafTNX+x1EkYVGZitU35KHdu/kiGTlDVyQSXaOg/mRdrV2vADPqcPRQDbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761760632; c=relaxed/simple;
	bh=PIWbCQVMLO0czKmSk54OiAydafyyJJiqIu+dfGb7c8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crHqUNfGtSiOCYuPbkrov9A4EhbantB56x+OWLpD/u/xLFlrquGqOlWbRnxKNsUNuE1/j1XWKXR55uajaYFyrqVZxPF7qk+OcVpS3xwbOWGcfjRFP/gT2caBvzekYGq4REyybB10ArGPrneaAR8owBQMgKBTLiIG9bSSG3Z8q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IaYzqsF7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1761760627;
	bh=PIWbCQVMLO0czKmSk54OiAydafyyJJiqIu+dfGb7c8Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IaYzqsF7TCa2rwrQEf08gFu9l0zxMAj77yNREbGLKJSspPg9nw1AzKE6fxobygUd8
	 +L1tHQsh1EVMtz+hIYyMhfX7pPD9aDk7ljkF0xU5sf6VScGPX4nv+xJAQLXtye22cK
	 IuUhvs2aP0UIy3EkZMpoJ+04jzQr6egSvNUX352hX+55ASg1UrmZUfZ+KJmAlwRbxS
	 ia09ik60qmaOGAfzQzh4KNflrw57Cedjmw9CNXMyNz0HIXXLHlESd+mK8dAy+JFve7
	 2+woAtJQ88p0YOjzNeF8KxtOndGwLKCgnb7FonYc3TXQ0JdgyCO8AYKIkxbNV+Tr+j
	 TQJXbqf7cr32g==
Received: from jupiter.universe (dyndsl-091-248-085-053.ewe-ip-backbone.de [91.248.85.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 63C2817E1423;
	Wed, 29 Oct 2025 18:57:07 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 1FBFC480055; Wed, 29 Oct 2025 18:57:02 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Wed, 29 Oct 2025 18:56:43 +0100
Subject: [PATCH v4 4/9] PCI: dw-rockchip: Add helper function for enhanced
 LTSSM control mode
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-rockchip-pcie-system-suspend-v4-4-ce2e1b0692d2@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2489;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=PIWbCQVMLO0czKmSk54OiAydafyyJJiqIu+dfGb7c8Q=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkCVW0oCjxq418OHByOeSI3S7y61NUnIPR7a
 mx8V+8rLxpwyokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpAlVtAAoJENju1/PI
 O/qa4PgP+QFeVp8gqhGnqA8uz6mf2ojDd1Qa8C48wxy9ixGhMgrqKQ8GJaVVhku3ImLZ1dZrrDk
 nONU6XPkMtJ0nia+NfID0iymRJQQaMdlZfrPoJwt1Astj5RsCVWQWUxsHEjPfdXLAbdVys7P6p4
 Ks3lSS4nfhep5obHN38Jfs+7EHHoFL7qeGQZFRVEiCNECMno9lDfMiPw6w7yNzKaBf+Bqw6mp+9
 EoCrkIQQfYGOQL8GVgw/wsRg2J/1pR+OERZBZH+sTSCeDhEcOhN58bziLIee0rh3+2hV+XUbKJD
 d19PlL/zjF8uND9Jc0DOMtOrQTghjXleSszN03JS4qoWZjI0R87/WXfjcpq7yzNpz+WkKK4LBrS
 fcR61eSfgbseVYwrItSkD2j8zoVOs1uUz/2qeVT6LjjhiWBrGP/tmZbmcYlBUT1N24pqo5Y3H27
 Ik/VNkYG7NJ3QwWehqak2N0+0hWw5dzljlS4Utudc6pVZd+whlVqY5FP4qnlIWPnfzbVA2lk9Vs
 korQzc/wpKz3VnQUN1fG/YDsUJls48f8rEZjuzaREv+gTx39+ctGDTXpHL6HQt35SJRPsQ78Uau
 ytocMmYVhuwnt7rwom7bFyz6x4D3dYUInsqw7DAHIpGxsOX5ItHAf5AAFCq1m44iBHbfA5htu2e
 /0IJUh2xO5eaqjOiVur4kdA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Remove code duplocation and improve readability by introducing a new
function to setup the enhanced LTSSM mode.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 8e584016e244..45586a964ead 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -511,13 +511,24 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
+static void rockchip_pcie_enable_enhanced_ltssm_control_mode(struct rockchip_pcie *rockchip,
+							     u32 flags)
+{
+	u32 val;
+
+	/* Enable the enhanced control mode of signal app_ltssm_enable */
+	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
+	if (flags)
+		val |= FIELD_PREP_WM16(flags, 1);
+	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
+}
+
 static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 				      struct rockchip_pcie *rockchip)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie_rp *pp;
 	int irq, ret;
-	u32 val;
 
 	if (!IS_ENABLED(CONFIG_PCIE_ROCKCHIP_DW_HOST))
 		return -ENODEV;
@@ -534,10 +545,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 		return ret;
 	}
 
-	/* LTSSM enable control mode */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
-
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, 0);
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
 				 PCIE_CLIENT_GENERAL_CON);
@@ -581,14 +589,7 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 		return ret;
 	}
 
-	/*
-	 * LTSSM enable control mode, and automatically delay link training on
-	 * hot reset/link-down reset.
-	 */
-	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1) |
-	      FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
-	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
-
+	rockchip_pcie_enable_enhanced_ltssm_control_mode(rockchip, PCIE_LTSSM_APP_DLY2_EN);
 	rockchip_pcie_writel_apb(rockchip,
 				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
 				 PCIE_CLIENT_GENERAL_CON);

-- 
2.51.0


