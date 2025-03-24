Return-Path: <linux-pci+bounces-24513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6706A6D803
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 11:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC4E188683C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 10:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1B025DB16;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ID7w09Sx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7019C542;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742810678; cv=none; b=tMeiWV7wv+flXYNSfhM7QnMCIyWAte1k7em2itTSYveMpLWW0CmZqASQfMMX9+BvliTqcWxyBhSSUTW8JXzrshGYThwd3PhDi5d1lRFxvGAp+S8eTczPw0XexUc33Gkn8Wl3bhlvfj44qPeP9EOEXwzsVHtiDN0AEZuW45qM5bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742810678; c=relaxed/simple;
	bh=AVSjKBtBaOpk+lLRbW0/2ZysYOxqeHDouXkZrG+dMgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdldDpqZ44oBi1sOB/OPsXjqXg8X8THSVhHkimMb8M0beOOUpx/A0KOpfhgmvVD1Q+m7hTSTJuDRc43+IEzr6s1rWomnh+ok7H4PK+XwXe7AHy1apRI14AsJgznTTpX69twqhS7QQMSTGJCVsQVkkSE/ycFU2A4HlH3Vxa2AUtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ID7w09Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EC3CC4AF0C;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742810678;
	bh=AVSjKBtBaOpk+lLRbW0/2ZysYOxqeHDouXkZrG+dMgA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ID7w09SxV6Rjg1coHJb0YknmHtis3mkKJyYhU6bxaxP8eJsfujY7GqfFLgekHJCfT
	 J4evfOFAJUZiCbsnJ/Skv1Lxw9UoQ2gUWy3iMUuv98AweM8k+ipXWNstS20ynI4Pjt
	 7UvJFUQaEn0gc99MpT0mcuhYFahrh6JBI4LjE0k7VW7XpjYdPv4ZW39oRSFf05+2Wg
	 1aT13i9b/LjC//Is3ejkqh0G7eIY2G/EwvNTdiS0IRuFGZFPo62bIuQnOmItbkF/CL
	 eKJm9Jd3g+x2KLklAkl6Vny2kTErbGZQVqfi3VBR/3XBZiJeBlIA+oPt4/4il5a8T7
	 X4PiHAwXRevLQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448E6C36005;
	Mon, 24 Mar 2025 10:04:38 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Mon, 24 Mar 2025 15:34:36 +0530
Subject: [PATCH v2 2/3] PCI: dwc: Add sysfs support for PTM context
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-pcie-ptm-v2-2-c7d8c3644b4a@linaro.org>
References: <20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org>
In-Reply-To: <20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14763;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=QeazHBVh/L0Qmh1L1EgNAubfunKPCWG5rl2kIN1kdcY=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBn4S4zz0YjUW26AE0yVKs+57/x1lwD2BzPf4P47
 awEWCbheG6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZ+EuMwAKCRBVnxHm/pHO
 9bTiB/0VKjpW5JgjTfSmfaKac1gXRy54fWUsQO9dqWOaASLwv/eE0pbD9fl782poOBT5sWonNK0
 Yww9Vay2nXSQx85Ht708R2oUeAGG6vrtAgfXMGdcG8/WsdncSKfHEor/Uid1c5yA+51O6biaQzn
 ApgijQqtFPZIT2RWyI70BcH7E508kBBfMBniCw6ZbynBfzweFPGV7ppfiwPTVv/Hp/4BN/Hm8Tv
 HAA5WMyVeL+zq7Zkas9VtdTNaPh11CQ8PE3VOorsbHsWcqedlHhgwgGRSPxgkWAfot5ICOVpsLg
 xlMZACmBhkGbVvTlQO7FBXdYhs2/mOAC8ife4PZ+EK1aKCYt
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Synopsys Designware PCIe IPs support PTM capability as defined in the PCIe
spec r6.0, sec 6.22. The PTM context information is exposed through Vendor
Specific Extended Capability (VSEC) registers on supported controller
implementation.

Hence, add support for exposing these context information to userspace
through the sysfs interface for the DWC controllers (both RC and EP).
Currently, only Qcom controllers are supported. For adding support for
DWC vendor controllers, dwc_pcie_ptm_vsec_ids[] needs to be extended.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/Makefile                |   2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |   3 +
 drivers/pci/controller/dwc/pcie-designware-sysfs.c | 254 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.c       |   6 +
 drivers/pci/controller/dwc/pcie-designware.h       |  21 ++
 include/linux/pcie-dwc.h                           |   8 +
 7 files changed, 296 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 54565eedc52cc36bc393e257d093c4671aff7b39..ca7c1ff7a6807bf0aec24778dc10c02c7e8680c7 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PCIE_DW) += pcie-designware.o
+obj-$(CONFIG_PCIE_DW) += pcie-designware.o pcie-designware-sysfs.o
 obj-$(CONFIG_PCIE_DW_DEBUGFS) += pcie-designware-debugfs.o
 obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 5a6174e107c20c897cfa142687e219c5ecafb8c6..d1a07cebc4c21f1a81048730bcf40fa8e1dba0b1 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -705,6 +705,7 @@ void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
+	pcie_designware_sysfs_exit(pci);
 	dwc_pcie_debugfs_deinit(pci);
 	dw_pcie_edma_remove(pci);
 }
@@ -880,6 +881,8 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 
 	dwc_pcie_debugfs_init(pci);
 
+	pcie_designware_sysfs_init(pci, DW_PCIE_EP_TYPE);
+
 	return 0;
 
 err_remove_edma:
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6501fb062c70e56eb301ca71fcd642f7be33a252..faaabc5446ebde5adcdf5ab03e0cf3569636b79b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -550,6 +550,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dwc_pcie_debugfs_init(pci);
 
+	pcie_designware_sysfs_init(pci, DW_PCIE_RC_TYPE);
+
 	return 0;
 
 err_stop_link:
@@ -574,6 +576,7 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
+	pcie_designware_sysfs_exit(pci);
 	dwc_pcie_debugfs_deinit(pci);
 
 	pci_stop_root_bus(pp->bridge->bus);
diff --git a/drivers/pci/controller/dwc/pcie-designware-sysfs.c b/drivers/pci/controller/dwc/pcie-designware-sysfs.c
new file mode 100644
index 0000000000000000000000000000000000000000..1723444e408c90dee0c8d0b526c6887969451d6c
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-sysfs.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Linaro Ltd.
+ * Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include "pcie-designware.h"
+
+static int dw_pcie_ptm_check_capability(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	pci->ptm_vsec_offset = dw_pcie_find_ptm_capability(pci);
+
+	return pci->ptm_vsec_offset;
+}
+
+static int dw_pcie_ptm_context_update_store(void *drvdata, const char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	if (sysfs_streq(buf, "auto")) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val |= PTM_REQ_AUTO_UPDATE_ENABLED;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else if (sysfs_streq(buf, "manual")) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val &= ~PTM_REQ_AUTO_UPDATE_ENABLED;
+		val |= PTM_REQ_START_UPDATE;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static ssize_t dw_pcie_ptm_context_update_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+	if (FIELD_GET(PTM_REQ_AUTO_UPDATE_ENABLED, val))
+		return sysfs_emit(buf, "auto\n");
+
+	/*
+	 * PTM_REQ_START_UPDATE is a self clearing register bit. So if
+	 * PTM_REQ_AUTO_UPDATE_ENABLED is not set, then it implies that
+	 * manual update is used.
+	 */
+	return sysfs_emit(buf, "manual\n");
+}
+
+static int dw_pcie_ptm_context_valid_store(void *drvdata, bool valid)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	if (valid) {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val |= PTM_RES_CCONTEXT_VALID;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	} else {
+		val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+		val &= ~PTM_RES_CCONTEXT_VALID;
+		dw_pcie_writel_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL, val);
+	}
+
+	return 0;
+}
+
+static ssize_t dw_pcie_ptm_context_valid_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 val;
+
+	val = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_RES_REQ_CTRL);
+
+	return sysfs_emit(buf, "%u\n", !!FIELD_GET(PTM_RES_CCONTEXT_VALID, val));
+}
+
+static ssize_t dw_pcie_ptm_local_clock_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_LOCAL_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t dw_pcie_ptm_master_clock_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_MASTER_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t dw_pcie_ptm_t1_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t dw_pcie_ptm_t2_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T1_T2_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t dw_pcie_ptm_t3_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static ssize_t dw_pcie_ptm_t4_show(void *drvdata, char *buf)
+{
+	struct dw_pcie *pci = drvdata;
+	u32 msb, lsb;
+
+	do {
+		msb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB);
+		lsb = dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_LSB);
+	} while (msb != dw_pcie_readl_dbi(pci, pci->ptm_vsec_offset + PTM_T3_T4_MSB));
+
+	return sysfs_emit(buf, "%llu\n", ((u64) msb) << 32 | lsb);
+}
+
+static bool dw_pcie_ptm_context_update_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_context_valid_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_local_clock_visible(void *drvdata)
+{
+	/* PTM local clock is always visible */
+	return true;
+}
+
+static bool dw_pcie_ptm_master_clock_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t1_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t2_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t3_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_RC_TYPE) ? true : false;
+}
+
+static bool dw_pcie_ptm_t4_visible(void *drvdata)
+{
+	struct dw_pcie *pci = drvdata;
+
+	return (pci->mode == DW_PCIE_EP_TYPE) ? true : false;
+}
+
+struct pcie_ptm_ops dw_pcie_ptm_ops = {
+	.check_capability = dw_pcie_ptm_check_capability,
+	.context_update_store = dw_pcie_ptm_context_update_store,
+	.context_update_show = dw_pcie_ptm_context_update_show,
+	.context_valid_store = dw_pcie_ptm_context_valid_store,
+	.context_valid_show = dw_pcie_ptm_context_valid_show,
+	.local_clock_show = dw_pcie_ptm_local_clock_show,
+	.master_clock_show = dw_pcie_ptm_master_clock_show,
+	.t1_show = dw_pcie_ptm_t1_show,
+	.t2_show = dw_pcie_ptm_t2_show,
+	.t3_show = dw_pcie_ptm_t3_show,
+	.t4_show = dw_pcie_ptm_t4_show,
+	.context_update_visible = dw_pcie_ptm_context_update_visible,
+	.context_valid_visible = dw_pcie_ptm_context_valid_visible,
+	.local_clock_visible = dw_pcie_ptm_local_clock_visible,
+	.master_clock_visible = dw_pcie_ptm_master_clock_visible,
+	.t1_visible = dw_pcie_ptm_t1_visible,
+	.t2_visible = dw_pcie_ptm_t2_visible,
+	.t3_visible = dw_pcie_ptm_t3_visible,
+	.t4_visible = dw_pcie_ptm_t4_visible,
+};
+
+void pcie_designware_sysfs_init(struct dw_pcie *pci,
+				    enum dw_pcie_device_mode mode)
+{
+	pci->mode = mode;
+	pcie_ptm_create_sysfs(pci->dev, pci, &dw_pcie_ptm_ops);
+}
+
+void pcie_designware_sysfs_exit(struct dw_pcie *pci)
+{
+	pcie_ptm_destroy_sysfs();
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3d1d95d9e38057dd1389e2d57d701ce4f4fa6f7f..1e858c15991f0f87e0711b9a9eec9c44d43fef4b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -329,6 +329,12 @@ u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_find_rasdes_capability);
 
+u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci)
+{
+	return dw_pcie_find_vsec_capability(pci, dwc_pcie_ptm_vsec_ids);
+}
+EXPORT_SYMBOL_GPL(dw_pcie_find_ptm_capability);
+
 int dw_pcie_read(void __iomem *addr, int size, u32 *val)
 {
 	if (!IS_ALIGNED((uintptr_t)addr, size)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 2d1de81d47b67fc0df941484b1d92d986b2b4dbd..27a729b9c13f17dd635bc2976a0b5d4c7aeff5f9 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -260,6 +260,21 @@
 
 #define PCIE_RAS_DES_EVENT_COUNTER_DATA		0xc
 
+/* PTM register definitions */
+#define PTM_RES_REQ_CTRL		0x8
+#define PTM_RES_CCONTEXT_VALID		BIT(0)
+#define PTM_REQ_AUTO_UPDATE_ENABLED	BIT(0)
+#define PTM_REQ_START_UPDATE		BIT(1)
+
+#define PTM_LOCAL_LSB			0x10
+#define PTM_LOCAL_MSB			0x14
+#define PTM_T1_T2_LSB			0x18
+#define PTM_T1_T2_MSB			0x1c
+#define PTM_T3_T4_LSB			0x28
+#define PTM_T3_T4_MSB			0x2c
+#define PTM_MASTER_LSB			0x38
+#define PTM_MASTER_MSB			0x3c
+
 /*
  * The default address offset between dbi_base and atu_base. Root controller
  * drivers are not required to initialize atu_base if the offset matches this
@@ -500,6 +515,8 @@ struct dw_pcie {
 	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
 	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
 	struct gpio_desc		*pe_rst;
+	u16			ptm_vsec_offset;
+	enum			dw_pcie_device_mode mode;
 	bool			suspended;
 	struct debugfs_info	*debugfs;
 };
@@ -516,6 +533,7 @@ void dw_pcie_version_detect(struct dw_pcie *pci);
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_rasdes_capability(struct dw_pcie *pci);
+u16 dw_pcie_find_ptm_capability(struct dw_pcie *pci);
 
 int dw_pcie_read(void __iomem *addr, int size, u32 *val);
 int dw_pcie_write(void __iomem *addr, int size, u32 val);
@@ -537,6 +555,9 @@ void dw_pcie_setup(struct dw_pcie *pci);
 void dw_pcie_iatu_detect(struct dw_pcie *pci);
 int dw_pcie_edma_detect(struct dw_pcie *pci);
 void dw_pcie_edma_remove(struct dw_pcie *pci);
+void pcie_designware_sysfs_init(struct dw_pcie *pci,
+				enum dw_pcie_device_mode mode);
+void pcie_designware_sysfs_exit(struct dw_pcie *pci);
 
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 8ff778e7aec0ef60462ea69245c76a91c81b76b9..b15057fa6c0ef1794b72c9279b49787fe56302c4 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -35,4 +35,12 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	{}
 };
 
+static const struct dwc_pcie_vsec_id dwc_pcie_ptm_vsec_ids[] = {
+	{ .vendor_id = PCI_VENDOR_ID_QCOM, /* EP */
+	  .vsec_id = 0x03, .vsec_rev = 0x1 },
+	{ .vendor_id = PCI_VENDOR_ID_QCOM, /* RC */
+	  .vsec_id = 0x04, .vsec_rev = 0x1 },
+	{ }
+};
+
 #endif /* LINUX_PCIE_DWC_H */

-- 
2.43.0



