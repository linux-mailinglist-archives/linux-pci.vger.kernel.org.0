Return-Path: <linux-pci+bounces-35031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FADB39FA2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F58F188FCC3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253A314B92;
	Thu, 28 Aug 2025 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="j+rmkRlA"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF49314A8B;
	Thu, 28 Aug 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389668; cv=none; b=hS5xz+LY+T8hYdtMtD8qAju/AzDKAjGFJVUw6cOQN7Iwct0HX8MCdZGxdZ6flLBOuk/2Bwkv9oOZzizQE8W++Eiju0TlrRqBBsQ6XVaGkcEKMKEtnpX7EV/O7zXSno3d2ihCsSbZe90hIglOD7cHsr2/G8BxQJjocLpvT2wHcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389668; c=relaxed/simple;
	bh=uN0drnFLGHFFBfcUuEdBDC/ZBct1KNpo6/5Kpg9dR1s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wd9X0t4d8+Vq8nHMUD89om4FNXYUYO55Kn7DUvEch9XC/jT9jc/mNpb8ehDJyQ29LgixRCFbfYedpgTKtNOk01vgF8lVHiD6EI4UxobmnZL1lrI2RKvlvv+RLtaVpydcSli9WqO7Ltyj46hYxyO5REXFv1CmXsoQd5oop/lYsyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=j+rmkRlA; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rK
	I7JtXjLg6JBO5xGv23pxIRhfzGIHc5RWwBJJ2bE6I=; b=j+rmkRlAe1vnPkEZ2F
	xgv0sNczJSpd/rmBpSAv/8JJ7fTKYPETyMmPKo+WgSbvlsVYkbuMCwiUbFFn1bc6
	yfztIOXmaedic5fu3RUsKJgyKi/o2h4P/qXnG86EwDTrceAVvj87oYnIQXgNB5wH
	k33K3id1vzNu0wXorA7gcWSaU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wAXJYwNYbBoRejWEw--.829S4;
	Thu, 28 Aug 2025 22:00:47 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	cassel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 10/13] PCI: qcom: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:48 +0800
Message-Id: <20250828135951.758100-11-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250828135951.758100-1-18255117159@163.com>
References: <20250828135951.758100-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXJYwNYbBoRejWEw--.829S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxAryrXFyxtFWfKF1fJrW8JFb_yoW7JF1Upw
	1Ikwn7JFn7AF409r98Aa1DWr1FkFWkur42k3W3tanF93Z7AF9Fga98t3ZxKF1xJFWIqFy5
	G3yUAFW7GF1akrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zNjg48UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwy3o2iwWuaYfQAAsa

Qcom PCIe common code contains complex bit manipulation for 16GT/s
equalization and lane margining configuration. These functions use
multiple read-modify-write sequences with manual bit masking and
field preparation, leading to verbose and error-prone code.

Refactor equalization and lane margining setup using
dw_pcie_*_dword(). The helper simplifies multi-field
configuration by combining clear and set operations in a single call.
Initialize local variables to zero before field insertion to ensure
unused bits are cleared appropriately.

This change reduces code complexity by ~40% in affected functions
while improving readability. Centralizing bit manipulation ensures
consistent handling of register fields across Qcom PCIe implementations
and provides a solid foundation for future 16GT/s enhancements.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-qcom-common.c | 62 +++++++++----------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index 3aad19b56da8..f3a365daac8a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -19,30 +19,29 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
 	 * determines the data rate for which these equalization settings are
 	 * applied.
 	 */
-	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
-	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
-			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
+	reg = FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
+			 GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
+	dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
+				    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL |
+				    GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
+				    reg);
 
-	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
-	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
-		GEN3_EQ_FMDC_N_EVALS |
-		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
-		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
-	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
-		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
-		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
-		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
-	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
+	reg = FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
+	      FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
+	      FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
+	      FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
+	dw_pcie_clear_and_set_dword(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF,
+				    GEN3_EQ_FMDC_T_MIN_PHASE23 |
+				    GEN3_EQ_FMDC_N_EVALS |
+				    GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
+				    GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA,
+				    reg);
 
-	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
-	reg &= ~(GEN3_EQ_CONTROL_OFF_FB_MODE |
-		GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
-		GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
-		GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
-	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
+	dw_pcie_clear_dword(pci, GEN3_EQ_CONTROL_OFF,
+			    GEN3_EQ_CONTROL_OFF_FB_MODE |
+			    GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
+			    GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
+			    GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC);
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
 
@@ -50,16 +49,15 @@ void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
 {
 	u32 reg;
 
-	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
-	reg &= ~(MARGINING_MAX_VOLTAGE_OFFSET |
-		MARGINING_NUM_VOLTAGE_STEPS |
-		MARGINING_MAX_TIMING_OFFSET |
-		MARGINING_NUM_TIMING_STEPS);
-	reg |= FIELD_PREP(MARGINING_MAX_VOLTAGE_OFFSET, 0x24) |
-		FIELD_PREP(MARGINING_NUM_VOLTAGE_STEPS, 0x78) |
-		FIELD_PREP(MARGINING_MAX_TIMING_OFFSET, 0x32) |
-		FIELD_PREP(MARGINING_NUM_TIMING_STEPS, 0x10);
-	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
+	reg = FIELD_PREP(MARGINING_MAX_VOLTAGE_OFFSET, 0x24) |
+	      FIELD_PREP(MARGINING_NUM_VOLTAGE_STEPS, 0x78) |
+	      FIELD_PREP(MARGINING_MAX_TIMING_OFFSET, 0x32) |
+	      FIELD_PREP(MARGINING_NUM_TIMING_STEPS, 0x10);
+	dw_pcie_clear_and_set_dword(pci, GEN4_LANE_MARGINING_1_OFF,
+				    MARGINING_MAX_VOLTAGE_OFFSET |
+				    MARGINING_NUM_VOLTAGE_STEPS |
+				    MARGINING_MAX_TIMING_OFFSET |
+				    MARGINING_NUM_TIMING_STEPS, reg);
 
 	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
 	reg |= MARGINING_IND_ERROR_SAMPLER |
-- 
2.49.0


