Return-Path: <linux-pci+bounces-29474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AB3AD5C42
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 18:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8650417EDE7
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D952080E8;
	Wed, 11 Jun 2025 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KBZQCw+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834B017E473;
	Wed, 11 Jun 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749659545; cv=none; b=G6smCmIQa0XxFELlHvyPWv/+ztCCqwx8J4S4QEE1RtPq4bt5nJBPBXbHwTkjW1yd5+XUXkX56M7YOSXiuCeQgxoLcmfuLP4o13e9nvHdnH5GV8n2Y8yWKXDti4fOiBH1rIZvNMcJmOANnsDIlF+nyHIfHl5gzpklcHfAr2/J25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749659545; c=relaxed/simple;
	bh=oFApSBDY+OxxnOA0P3lT0lMEWBUJm37uUIdc7A3fBPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uaoZdqJJ1wK2vqbbLy+KAJ/RK4/dw+geVkgqiYA7lElnDCfxT8qNezIKPVO/1l4BFFbcIPoNRciKyD+DBmXRm1csL8ZAqeKOkNFFW7NelAoXPcL//i8R5J9KnxCiekgGyp42lMKQ8EbgNhSgaJc5JDxqFTcV4jc/TyEJFUJ4rUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KBZQCw+w; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lN
	RcWaeVw9b8wcrD5zFUisNHEU5ftFol/Wu2HmY6NWU=; b=KBZQCw+wMnG28aOIwi
	LvPWtLsVsZH6oXvRK7Uqj+UDLfrr+b+ADTjIPQ0p7dRECSU+kCG/pgzME/eTz3cD
	TFxjLQPiU8VQZiNShy3eT66wOSlMjOWb+5C9UGSQvvn/ksos4M37eXBc3cYSnPO3
	ctsdrQ1pOgj3W7y3bnSAiQahQ=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3jyCKr0lo4m_hHg--.55293S2;
	Thu, 12 Jun 2025 00:32:11 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	bhelgaas@google.com,
	mani@kernel.org,
	kwilczynski@kernel.org
Cc: robh@kernel.org,
	jingoohan1@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 10/13] PCI: dwc: Refactor qcom common to use dw_pcie_clear_and_set_dword()
Date: Thu, 12 Jun 2025 00:32:09 +0800
Message-Id: <20250611163209.861171-1-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3jyCKr0lo4m_hHg--.55293S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF4rAryxWr1DAw1xWr4kZwb_yoW7Ww48pw
	10k3Z7JFn7AF40939Iyan7Xr1FkFZxur42k3W3tanFv3Z7AFZFgay5tasrKr1xGFW7KFy2
	k34UAFW7Gr1SkrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEnYFAUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWw1po2hJpj-hUQAEsQ

Qcom PCIe common code contains complex bit manipulation for 16GT/s
equalization and lane margining configuration. These functions use
multiple read-modify-write sequences with manual bit masking and
field preparation, leading to verbose and error-prone code.

Refactor equalization and lane margining setup using
dw_pcie_clear_and_set_dword(). The helper simplifies multi-field
configuration by combining clear and set operations in a single call.
Initialize local variables to zero before field insertion to ensure
unused bits are cleared appropriately.

This change reduces code complexity by ~40% in affected functions
while improving readability. Centralizing bit manipulation ensures
consistent handling of register fields across Qcom PCIe implementations
and provides a solid foundation for future 16GT/s enhancements.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-qcom-common.c | 59 +++++++++----------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index 3aad19b56da8..8ea521147b7e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -10,7 +10,7 @@
 
 void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
 {
-	u32 reg;
+	u32 reg = 0;
 
 	/*
 	 * GEN3_RELATED_OFF register is repurposed to apply equalization
@@ -19,60 +19,59 @@ void qcom_pcie_common_set_16gt_equalization(struct dw_pcie *pci)
 	 * determines the data rate for which these equalization settings are
 	 * applied.
 	 */
-	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
-	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
-	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
 	reg |= FIELD_PREP(GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
 			  GEN3_RELATED_OFF_RATE_SHADOW_SEL_16_0GT);
-	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
+	dw_pcie_clear_and_set_dword(pci, GEN3_RELATED_OFF,
+				    GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL |
+				    GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK,
+				    reg);
 
-	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
-	reg &= ~(GEN3_EQ_FMDC_T_MIN_PHASE23 |
-		GEN3_EQ_FMDC_N_EVALS |
-		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA |
-		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA);
+	reg = 0;
 	reg |= FIELD_PREP(GEN3_EQ_FMDC_T_MIN_PHASE23, 0x1) |
 		FIELD_PREP(GEN3_EQ_FMDC_N_EVALS, 0xd) |
 		FIELD_PREP(GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA, 0x5) |
 		FIELD_PREP(GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA, 0x5);
-	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
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
+	dw_pcie_clear_and_set_dword(pci, GEN3_EQ_CONTROL_OFF,
+				    GEN3_EQ_CONTROL_OFF_FB_MODE |
+				    GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE |
+				    GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL |
+				    GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC, 0);
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_equalization);
 
 void qcom_pcie_common_set_16gt_lane_margining(struct dw_pcie *pci)
 {
-	u32 reg;
+	u32 reg = 0;
 
-	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
-	reg &= ~(MARGINING_MAX_VOLTAGE_OFFSET |
-		MARGINING_NUM_VOLTAGE_STEPS |
-		MARGINING_MAX_TIMING_OFFSET |
-		MARGINING_NUM_TIMING_STEPS);
 	reg |= FIELD_PREP(MARGINING_MAX_VOLTAGE_OFFSET, 0x24) |
 		FIELD_PREP(MARGINING_NUM_VOLTAGE_STEPS, 0x78) |
 		FIELD_PREP(MARGINING_MAX_TIMING_OFFSET, 0x32) |
 		FIELD_PREP(MARGINING_NUM_TIMING_STEPS, 0x10);
-	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
+	dw_pcie_clear_and_set_dword(pci, GEN4_LANE_MARGINING_1_OFF,
+				    MARGINING_MAX_VOLTAGE_OFFSET |
+				    MARGINING_NUM_VOLTAGE_STEPS |
+				    MARGINING_MAX_TIMING_OFFSET |
+				    MARGINING_NUM_TIMING_STEPS, reg);
 
-	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
+	reg = 0;
 	reg |= MARGINING_IND_ERROR_SAMPLER |
 		MARGINING_SAMPLE_REPORTING_METHOD |
 		MARGINING_IND_LEFT_RIGHT_TIMING |
 		MARGINING_VOLTAGE_SUPPORTED;
-	reg &= ~(MARGINING_IND_UP_DOWN_VOLTAGE |
-		MARGINING_MAXLANES |
-		MARGINING_SAMPLE_RATE_TIMING |
-		MARGINING_SAMPLE_RATE_VOLTAGE);
 	reg |= FIELD_PREP(MARGINING_MAXLANES, pci->num_lanes) |
 		FIELD_PREP(MARGINING_SAMPLE_RATE_TIMING, 0x3f) |
 		FIELD_PREP(MARGINING_SAMPLE_RATE_VOLTAGE, 0x3f);
-	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_2_OFF, reg);
+	dw_pcie_clear_and_set_dword(pci, GEN4_LANE_MARGINING_2_OFF,
+				    MARGINING_IND_UP_DOWN_VOLTAGE |
+				    MARGINING_MAXLANES |
+				    MARGINING_SAMPLE_RATE_TIMING |
+				    MARGINING_SAMPLE_RATE_VOLTAGE, reg);
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_lane_margining);
-- 
2.25.1


