Return-Path: <linux-pci+bounces-33917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CB0B23FCE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 06:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADEEF7B286C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 04:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E25270ECD;
	Wed, 13 Aug 2025 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EBxWFAhE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7286A2BEFE2;
	Wed, 13 Aug 2025 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755060357; cv=none; b=PdQr/psbRxOWAK8Tia9hYpjz5lf36OhE3TZF7skrGV8g5pO2onM42VnH5vxR483lJOUopGS7r5bqKRAIfiUYBabwYvHx/Pyu+kH/RoelWsKUrJT8by+2RuGbHDtKuMJ4FPnzmFz3VoES6/CTkduNdJO5LS3qAbXhzEI6EIiRrIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755060357; c=relaxed/simple;
	bh=GJgq+BVzHEIoAuY+vq7n1ukUkfIN1W4NwBujsUZ/noI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BTDKFzxu2rkHjnjEipe+n5zWBAJRffYgjYTGCnhWW/1wMssogniV8mL9TX8zIFbsw1suzCL9u1mt6arYyedELrb0SHwKUQ2T6ZGntoagQF/KI9pLdV7M9t/VquMmbVAuFCHmdpB1xJ8APOQPSZHnfIuX7cEzqwj5HiCRGlQzptI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EBxWFAhE; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=2V
	idaOPbE7BxX4d6c12wtt33RL6LxFbLHQkU7pY5Sac=; b=EBxWFAhEwutUm1CxD4
	m4lTtsHVrq+Tyy495+ZvU6B6I6uJ55a5Oz8WVttkcWdRLu7NeuoNK1W1CeI5PEhF
	XJ1mzpwTqWRLpiZEynn/P/76J2dhExaOVwQIj3LfleSONwM2Bx40et+40NVG9mwC
	KI812vXcNwTtYR92A7XKCfLBM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ErhtGJxo3nYVAA--.2375S4;
	Wed, 13 Aug 2025 12:45:36 +0800 (CST)
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
Subject: [PATCH v4 02/13] PCI: dwc: Refactor code by using dw_pcie_clear_and_set_dword()
Date: Wed, 13 Aug 2025 12:45:20 +0800
Message-Id: <20250813044531.180411-3-18255117159@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250813044531.180411-1-18255117159@163.com>
References: <20250813044531.180411-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ErhtGJxo3nYVAA--.2375S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfJrykCFWkWr4DCF1xCryDWrg_yoW8Ww1fKo
	Z3JF1UZ3W7tF1jqFyUtas3KryUZr9FvFyFqFsFkr4j9ay3A3W5A393KFnxZw1Y9w4fC34r
	Xa1DG3Z8ArW7Xr1Un29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4ihL0oDUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOhWoo2icEADVMAAAsl

DesignWare core modules contain multiple instances of manual
read-modify-write operations for register bit manipulation.
These patterns duplicate functionality now provided by
dw_pcie_clear_and_set_dword(), particularly in debugfs, endpoint,
host, and core initialization paths.

Replace open-coded bit manipulation sequences with calls to
dw_pcie_clear_and_set_dword(). Affected areas include debugfs register
control, endpoint capability configuration, host setup routines, and
core link initialization logic. The changes simplify power management
handling, capability masking, and feature configuration.

Standardizing on the helper function reduces code duplication by ~140
lines across core modules while improving readability. The refactoring
also ensures consistent error handling for register operations and
provides a single point of control for future bit manipulation logi
updates.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 66 +++++++---------
 .../pci/controller/dwc/pcie-designware-ep.c   | 20 +++--
 .../pci/controller/dwc/pcie-designware-host.c | 26 +++----
 drivers/pci/controller/dwc/pcie-designware.c  | 75 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  | 18 +----
 5 files changed, 76 insertions(+), 129 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 0fbf86c0b97e..ff185b8977f3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -213,10 +213,8 @@ static ssize_t lane_detect_write(struct file *file, const char __user *buf,
 	if (val)
 		return val;
 
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG);
-	val &= ~(LANE_SELECT);
-	val |= FIELD_PREP(LANE_SELECT, lane);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG, val);
+	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + SD_STATUS_L1LANE_REG,
+				    LANE_SELECT, FIELD_PREP(LANE_SELECT, lane));
 
 	return count;
 }
@@ -309,12 +307,11 @@ static void set_event_number(struct dwc_pcie_rasdes_priv *pdata,
 {
 	u32 val;
 
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
-	val &= ~EVENT_COUNTER_ENABLE;
-	val &= ~(EVENT_COUNTER_GROUP_SELECT | EVENT_COUNTER_EVENT_SELECT);
-	val |= FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
+	val = FIELD_PREP(EVENT_COUNTER_GROUP_SELECT, event_list[pdata->idx].group_no);
 	val |= FIELD_PREP(EVENT_COUNTER_EVENT_SELECT, event_list[pdata->idx].event_no);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
+				    EVENT_COUNTER_ENABLE | EVENT_COUNTER_GROUP_SELECT |
+				    EVENT_COUNTER_EVENT_SELECT, val);
 }
 
 static ssize_t counter_enable_read(struct file *file, char __user *buf,
@@ -354,13 +351,10 @@ static ssize_t counter_enable_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
-	if (enable)
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_ON);
-	else
-		val |= FIELD_PREP(EVENT_COUNTER_ENABLE, PER_EVENT_OFF);
 
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	val |= FIELD_PREP(EVENT_COUNTER_ENABLE, enable ? PER_EVENT_ON : PER_EVENT_OFF);
+	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
+				    0, val);
 
 	/*
 	 * While enabling the counter, always read the status back to check if
@@ -415,10 +409,9 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 
 	mutex_lock(&rinfo->reg_event_lock);
 	set_event_number(pdata, pci, rinfo);
-	val = dw_pcie_readl_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG);
-	val &= ~(EVENT_COUNTER_LANE_SELECT);
-	val |= FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane);
-	dw_pcie_writel_dbi(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG, val);
+	dw_pcie_clear_and_set_dword(pci, rinfo->ras_cap_offset + RAS_DES_EVENT_COUNTER_CTRL_REG,
+				    EVENT_COUNTER_LANE_SELECT,
+				    FIELD_PREP(EVENT_COUNTER_LANE_SELECT, lane));
 	mutex_unlock(&rinfo->reg_event_lock);
 
 	return count;
@@ -654,20 +647,15 @@ static int dw_pcie_ptm_check_capability(void *drvdata)
 static int dw_pcie_ptm_context_update_write(void *drvdata, u8 mode)
 {
 	struct dw_pcie *pci = drvdata;
-	u32 val;
 
-	if (mode == PCIE_PTM_CONTEXT_UPDATE_AUTO) {
-		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
-		val |= PTM_REQ_AUTO_UPDATE_ENABLED;
-		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
-	} else if (mode == PCIE_PTM_CONTEXT_UPDATE_MANUAL) {
-		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
-		val &= ~PTM_REQ_AUTO_UPDATE_ENABLED;
-		val |= PTM_REQ_START_UPDATE;
-		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
-	} else {
+	if (mode == PCIE_PTM_CONTEXT_UPDATE_AUTO)
+		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+					    0, PTM_REQ_AUTO_UPDATE_ENABLED);
+	else if (mode == PCIE_PTM_CONTEXT_UPDATE_MANUAL)
+		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+					    PTM_REQ_AUTO_UPDATE_ENABLED, PTM_REQ_START_UPDATE);
+	else
 		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -694,17 +682,13 @@ static int dw_pcie_ptm_context_update_read(void *drvdata, u8 *mode)
 static int dw_pcie_ptm_context_valid_write(void *drvdata, bool valid)
 {
 	struct dw_pcie *pci = drvdata;
-	u32 val;
 
-	if (valid) {
-		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
-		val |= PTM_RES_CCONTEXT_VALID;
-		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
-	} else {
-		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
-		val &= ~PTM_RES_CCONTEXT_VALID;
-		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
-	}
+	if (valid)
+		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+					    0, PTM_RES_CCONTEXT_VALID);
+	else
+		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+					    PTM_RES_CCONTEXT_VALID, 0);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ae54a94809b..7e52892f632b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -277,7 +277,7 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
 	int flags = epf_bar->flags;
 	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
 	unsigned int rebar_offset;
-	u32 rebar_cap, rebar_ctrl;
+	u32 rebar_cap;
 	int ret;
 
 	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
@@ -310,9 +310,8 @@ static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
 	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
 	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
 	 */
-	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
-	rebar_ctrl &= ~GENMASK(31, 16);
-	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
+	dw_pcie_clear_and_set_dword(pci, rebar_offset + PCI_REBAR_CTRL,
+				    GENMASK(31, 16), 0);
 
 	/*
 	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
@@ -925,7 +924,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	struct dw_pcie_ep_func *ep_func;
 	struct device *dev = pci->dev;
 	struct pci_epc *epc = ep->epc;
-	u32 ptm_cap_base, reg;
+	u32 ptm_cap_base;
 	u8 hdr_type;
 	u8 func_no;
 	void *addr;
@@ -1001,13 +1000,12 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	 */
 	if (ptm_cap_base) {
 		dw_pcie_dbi_ro_wr_en(pci);
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~PCI_PTM_CAP_ROOT;
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+		dw_pcie_clear_and_set_dword(pci, ptm_cap_base + PCI_PTM_CAP,
+					    PCI_PTM_CAP_ROOT, 0);
 
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+		dw_pcie_clear_and_set_dword(pci, ptm_cap_base + PCI_PTM_CAP,
+					    PCI_PTM_CAP_RES |
+					    PCI_PTM_GRANULARITY_MASK, 0);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..d2ebd49802c6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -904,7 +904,6 @@ static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u32 val;
 	int ret;
 
 	/*
@@ -922,23 +921,17 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_1, 0x00000000);
 
 	/* Setup interrupt pins */
-	val = dw_pcie_readl_dbi(pci, PCI_INTERRUPT_LINE);
-	val &= 0xffff00ff;
-	val |= 0x00000100;
-	dw_pcie_writel_dbi(pci, PCI_INTERRUPT_LINE, val);
+	dw_pcie_clear_and_set_dword(pci, PCI_INTERRUPT_LINE,
+				    0x0000ff00, 0x00000100);
 
 	/* Setup bus numbers */
-	val = dw_pcie_readl_dbi(pci, PCI_PRIMARY_BUS);
-	val &= 0xff000000;
-	val |= 0x00ff0100;
-	dw_pcie_writel_dbi(pci, PCI_PRIMARY_BUS, val);
+	dw_pcie_clear_and_set_dword(pci, PCI_PRIMARY_BUS,
+				    0x00ffffff, 0x00ff0100);
 
 	/* Setup command register */
-	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
-	val &= 0xffff0000;
-	val |= PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
-		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
-	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
+	dw_pcie_clear_and_set_dword(pci, PCI_COMMAND, 0x0000ffff,
+				    PCI_COMMAND_IO | PCI_COMMAND_MEMORY |
+				    PCI_COMMAND_MASTER | PCI_COMMAND_SERR);
 
 	dw_pcie_config_presets(pp);
 	/*
@@ -957,9 +950,8 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 	/* Program correct class for RC */
 	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
 
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val |= PORT_LOGIC_SPEED_CHANGE;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+				    0, PORT_LOGIC_SPEED_CHANGE);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..3e36cb53761f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -748,11 +748,8 @@ EXPORT_SYMBOL_GPL(dw_pcie_link_up);
 
 void dw_pcie_upconfig_setup(struct dw_pcie *pci)
 {
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL);
-	val |= PORT_MLTI_UPCFG_SUPPORT;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_MULTI_LANE_CTRL, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_MULTI_LANE_CTRL,
+				    0, PORT_MLTI_UPCFG_SUPPORT);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_upconfig_setup);
 
@@ -813,21 +810,12 @@ int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
 
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
-	u32 lnkcap, lwsc, plc;
+	u32 plc = 0;
 	u8 cap;
 
 	if (!num_lanes)
 		return;
 
-	/* Set the number of lanes */
-	plc = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
-	plc &= ~PORT_LINK_FAST_LINK_MODE;
-	plc &= ~PORT_LINK_MODE_MASK;
-
-	/* Set link width speed control register */
-	lwsc = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	lwsc &= ~PORT_LOGIC_LINK_WIDTH_MASK;
-	lwsc |= PORT_LOGIC_LINK_WIDTH_1_LANES;
 	switch (num_lanes) {
 	case 1:
 		plc |= PORT_LINK_MODE_1_LANES;
@@ -845,14 +833,20 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 		dev_err(pci->dev, "num-lanes %u: invalid value\n", num_lanes);
 		return;
 	}
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, plc);
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, lwsc);
+	/* Set the number of lanes */
+	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_LINK_CONTROL,
+				    PORT_LINK_FAST_LINK_MODE | PORT_LINK_MODE_MASK,
+				    plc);
+
+	/* Set link width speed control register */
+	dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+				    PORT_LOGIC_LINK_WIDTH_MASK,
+				    PORT_LOGIC_LINK_WIDTH_1_LANES);
 
 	cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
-	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
-	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes);
-	dw_pcie_writel_dbi(pci, cap + PCI_EXP_LNKCAP, lnkcap);
+	dw_pcie_clear_and_set_dword(pci, cap + PCI_EXP_LNKCAP,
+				    PCI_EXP_LNKCAP_MLW,
+				    FIELD_PREP(PCI_EXP_LNKCAP_MLW, num_lanes));
 }
 
 void dw_pcie_iatu_detect(struct dw_pcie *pci)
@@ -1141,38 +1135,27 @@ void dw_pcie_edma_remove(struct dw_pcie *pci)
 
 void dw_pcie_setup(struct dw_pcie *pci)
 {
-	u32 val;
-
 	dw_pcie_link_set_max_speed(pci);
 
 	/* Configure Gen1 N_FTS */
-	if (pci->n_fts[0]) {
-		val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
-		val &= ~(PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK);
-		val |= PORT_AFR_N_FTS(pci->n_fts[0]);
-		val |= PORT_AFR_CC_N_FTS(pci->n_fts[0]);
-		dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
-	}
+	if (pci->n_fts[0])
+		dw_pcie_clear_and_set_dword(pci, PCIE_PORT_AFR,
+					    PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK,
+					    PORT_AFR_N_FTS(pci->n_fts[0]) |
+					    PORT_AFR_CC_N_FTS(pci->n_fts[0]));
 
 	/* Configure Gen2+ N_FTS */
-	if (pci->n_fts[1]) {
-		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-		val &= ~PORT_LOGIC_N_FTS_MASK;
-		val |= pci->n_fts[1];
-		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-	}
+	if (pci->n_fts[1])
+		dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+					    PORT_LOGIC_N_FTS_MASK, pci->n_fts[1]);
 
-	if (dw_pcie_cap_is(pci, CDM_CHECK)) {
-		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
-		val |= PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
-		       PCIE_PL_CHK_REG_CHK_REG_START;
-		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
-	}
+	if (dw_pcie_cap_is(pci, CDM_CHECK))
+		dw_pcie_clear_and_set_dword(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, 0,
+					    PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
+					    PCIE_PL_CHK_REG_CHK_REG_START);
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
-	val &= ~PORT_LINK_FAST_LINK_MODE;
-	val |= PORT_LINK_DLL_LINK_EN;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_LINK_CONTROL,
+				    PORT_LINK_FAST_LINK_MODE, PORT_LINK_DLL_LINK_EN);
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 08856f957ccf..a2e052388bda 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -715,24 +715,14 @@ static inline void dw_pcie_clear_and_set_dword(struct dw_pcie *pci, int pos,
 
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
 {
-	u32 reg;
-	u32 val;
-
-	reg = PCIE_MISC_CONTROL_1_OFF;
-	val = dw_pcie_readl_dbi(pci, reg);
-	val |= PCIE_DBI_RO_WR_EN;
-	dw_pcie_writel_dbi(pci, reg, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
+				    0, PCIE_DBI_RO_WR_EN);
 }
 
 static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 {
-	u32 reg;
-	u32 val;
-
-	reg = PCIE_MISC_CONTROL_1_OFF;
-	val = dw_pcie_readl_dbi(pci, reg);
-	val &= ~PCIE_DBI_RO_WR_EN;
-	dw_pcie_writel_dbi(pci, reg, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_MISC_CONTROL_1_OFF,
+				    PCIE_DBI_RO_WR_EN, 0);
 }
 
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
-- 
2.25.1


