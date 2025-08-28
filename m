Return-Path: <linux-pci+bounces-35026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D8DB39F9A
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 16:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5DF5644F9
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56C3128AD;
	Thu, 28 Aug 2025 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XQL+eLbc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0628013C8E8;
	Thu, 28 Aug 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756389661; cv=none; b=rC5WOB6+tfXsk39idZShQ7keBBBtSZxZJV0mvZJ8UnDd72J0BCVXeUJxXobhGdZTk2QZv817eeKjWV/Biawmqj22dVXjv2tC9pIMBzbrShvBxysB47hhMWTVsyWSJ9VNdj9mAq5K8gvkhDqfFWdGJ16o8Jz1o/p3o1H0Gp3sVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756389661; c=relaxed/simple;
	bh=cOXxouYpYuk+Do623nt2bL6E4GCUfvCfr1lLgnnFa40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpk8DW5WVSE2NWx34p0v6EL06PPqCJUcacn1eNxtM5LA1KLquewl1hxW23BMLl4GgMSaj2jlHeVmwyuQNm3qRrT2f35Cx12QVy+HKbU9xeMgUhAcBeAC5egbN8X2GYPgNW/5FVE8fYrPusqsrQl/+P/8FMAj9+nuhDpA2RzAYiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XQL+eLbc; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=sw
	UmOCG3BXRSDD4bZYro9X3xvdGLXd9ngQpXNKUAoTg=; b=XQL+eLbcWgkKm7s/wO
	QVgGq/3GvXFDn2pdocMHKyqdj6FB4nKC60rP0dUTPbsDXP8YShJCmkaEyc6m9G+Q
	a1Sc3+I0HwydwxpcurLFGpgH7niswnZhP0a87yEEaWWVn7x/0hvlTOl65Fp9aD+k
	lYseCTC3mzlc+MHHmqP+5kIvA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAXBtYDYbBoN0ahAw--.5480S4;
	Thu, 28 Aug 2025 22:00:38 +0800 (CST)
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
Subject: [PATCH v5 02/13] PCI: dwc: Refactor code by using dw_pcie_*_dword()
Date: Thu, 28 Aug 2025 21:59:40 +0800
Message-Id: <20250828135951.758100-3-18255117159@163.com>
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
X-CM-TRANSID:QCgvCgAXBtYDYbBoN0ahAw--.5480S4
X-Coremail-Antispam: 1Uf129KBjvAXoWfJrykCw18uFW5Zr4DGF1xXwb_yoW8Xry7uo
	Z3XF15W3W7JF10qFy8tasxKryUZrnFvFy5XFsFkw4jkay3A3W5A39agF13Zw4Y9w4xC34r
	Xa1kG3Z8Zr47Xr17n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4iD3kGUUUUU
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiQwG3o2iwWuZ9YAADss

DesignWare core modules contain multiple instances of manual
read-modify-write operations for register bit manipulation.
These patterns duplicate functionality now provided by
dw_pcie_*_dword(), particularly in debugfs, endpoint,
host, and core initialization paths.

Replace open-coded bit manipulation sequences with calls to
dw_pcie_*_dword(). Affected areas include debugfs register
control, endpoint capability configuration, host setup routines, and
core link initialization logic. The changes simplify power management
handling, capability masking, and feature configuration.

Standardizing on the helper function reduces code duplication by ~140
lines across core modules while improving readability. The refactoring
also ensures consistent error handling for register operations and
provides a single point of control for future bit manipulation logic
updates.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 48 +++++-------
 .../pci/controller/dwc/pcie-designware-ep.c   | 19 ++---
 .../pci/controller/dwc/pcie-designware-host.c | 26 +++----
 drivers/pci/controller/dwc/pcie-designware.c  | 75 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h  | 16 +---
 5 files changed, 66 insertions(+), 118 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 0fbf86c0b97e..652e7cf691aa 100644
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
@@ -415,10 +413,9 @@ static ssize_t counter_lane_write(struct file *file, const char __user *buf,
 
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
@@ -654,20 +651,15 @@ static int dw_pcie_ptm_check_capability(void *drvdata)
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
+		dw_pcie_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+				  PTM_REQ_AUTO_UPDATE_ENABLED);
+	else if (mode == PCIE_PTM_CONTEXT_UPDATE_MANUAL)
+		dw_pcie_clear_and_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+					    PTM_REQ_AUTO_UPDATE_ENABLED, PTM_REQ_START_UPDATE);
+	else
 		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -694,17 +686,13 @@ static int dw_pcie_ptm_context_update_read(void *drvdata, u8 *mode)
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
+		dw_pcie_set_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+				  PTM_RES_CCONTEXT_VALID);
+	else
+		dw_pcie_clear_dword(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL,
+				    PTM_RES_CCONTEXT_VALID);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0ae54a94809b..e5b59b2c2292 100644
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
+	dw_pcie_clear_dword(pci, rebar_offset + PCI_REBAR_CTRL,
+			    GENMASK(31, 16));
 
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
@@ -1001,13 +1000,11 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	 */
 	if (ptm_cap_base) {
 		dw_pcie_dbi_ro_wr_en(pci);
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~PCI_PTM_CAP_ROOT;
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+		dw_pcie_clear_dword(pci, ptm_cap_base + PCI_PTM_CAP,
+				    PCI_PTM_CAP_ROOT);
 
-		reg = dw_pcie_readl_dbi(pci, ptm_cap_base + PCI_PTM_CAP);
-		reg &= ~(PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
-		dw_pcie_writel_dbi(pci, ptm_cap_base + PCI_PTM_CAP, reg);
+		dw_pcie_clear_dword(pci, ptm_cap_base + PCI_PTM_CAP,
+				    PCI_PTM_CAP_RES | PCI_PTM_GRANULARITY_MASK);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..ded18122f5a6 100644
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
+	dw_pcie_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
+			  PORT_LOGIC_SPEED_CHANGE);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 89aad5a08928..77b66af73ab3 100644
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
+	dw_pcie_set_dword(pci, PCIE_PORT_MULTI_LANE_CTRL,
+			  PORT_MLTI_UPCFG_SUPPORT);
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
+		dw_pcie_set_dword(pci, PCIE_PL_CHK_REG_CONTROL_STATUS,
+				  PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS |
+				  PCIE_PL_CHK_REG_CHK_REG_START);
 
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
-	val &= ~PORT_LINK_FAST_LINK_MODE;
-	val |= PORT_LINK_DLL_LINK_EN;
-	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
+	dw_pcie_clear_and_set_dword(pci, PCIE_PORT_LINK_CONTROL,
+				    PORT_LINK_FAST_LINK_MODE, PORT_LINK_DLL_LINK_EN);
 
 	dw_pcie_link_set_max_link_width(pci, pci->num_lanes);
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ae18b657938a..fadc8bcb06bc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -727,24 +727,12 @@ static inline void dw_pcie_set_dword(struct dw_pcie *pci, int pos,
 
 static inline void dw_pcie_dbi_ro_wr_en(struct dw_pcie *pci)
 {
-	u32 reg;
-	u32 val;
-
-	reg = PCIE_MISC_CONTROL_1_OFF;
-	val = dw_pcie_readl_dbi(pci, reg);
-	val |= PCIE_DBI_RO_WR_EN;
-	dw_pcie_writel_dbi(pci, reg, val);
+	dw_pcie_set_dword(pci, PCIE_MISC_CONTROL_1_OFF, PCIE_DBI_RO_WR_EN);
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
+	dw_pcie_clear_dword(pci, PCIE_MISC_CONTROL_1_OFF, PCIE_DBI_RO_WR_EN);
 }
 
 static inline int dw_pcie_start_link(struct dw_pcie *pci)
-- 
2.49.0


