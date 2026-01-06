Return-Path: <linux-pci+bounces-44087-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D05CF7856
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 10:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BB203121BE0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAF1519AC;
	Tue,  6 Jan 2026 09:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="QB0TQuWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m3275.qiye.163.com (mail-m3275.qiye.163.com [220.197.32.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3912F6925
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 09:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767691138; cv=none; b=Qj0pvMXOzflWSRx+X46MrCrHM72Nahbk2UPnZun7aDgKne5B9Ednk3x2+7bxedf6kWC7PZ5zedgfmz8FT6slGmq0tBEaJw0S4JDYZtDWZ25ysakwKC3DU0HykzczMEtZJM/khILb3Tg/xwNi4+PLhxD64Dg+HnyT23vMqpfczH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767691138; c=relaxed/simple;
	bh=qeBtlAl8F1tuaPcxAYATOwylg2Vy+T1vpHc4a4/GCn0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jq9zjqaKlxmLx7iDzscRWppXRkKeJSaMoV0wOC1WFzCncgc8qfr8CJF79nrXYf/jBuawFNZ9OPcUziQ53hQExuxOA5ojIt7r0X/honR+i6sTbhmbIrhLKWMkychY8wH6ysuAFjn5PmRBCRB4dD7oroYIuZxpq6xoIishUWxY3T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=QB0TQuWz; arc=none smtp.client-ip=220.197.32.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2faab4829;
	Tue, 6 Jan 2026 17:18:50 +0800 (GMT+08:00)
From: Shawn Lin <shawn.lin@rock-chips.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/2] PCI: dwc: Add LTSSM tracing support to debugfs
Date: Tue,  6 Jan 2026 17:18:38 +0800
Message-Id: <1767691119-28287-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
X-HM-Tid: 0a9b929a145509cekunm960b3024166f93e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtLTlYaS00dQkweGRpOS0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=QB0TQuWzncQcG7xaEDg/Mb/C7uRhXYieZQu0yfl1/pX5mMuqy9Nqg6maBHSOianagwlmjG+4BY3+huoctXWmGjbkPJVg8v7paL62B54/5wx6GIdvDxNBWH/LPc9MgYBGgaAgDiqUuKllkVNDj3rHbhe2Z5SaUBvR/WfQlhOSwBQ=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=aBj8Utrniq8SlTD9HEuIz3zb59ewyLcmf8DwOngwudI=;
	h=date:mime-version:subject:message-id:from;
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Some platforms may provide LTSSM trace functionality, recording historical
LTSSM state transition information. This is very useful for debugging, such
as when certain devices cannot be recognized. Add an ltssm_trace operation
node in debugfs for platform which could provide these information to show
the LTSSM history.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 .../controller/dwc/pcie-designware-debugfs.c  | 44 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  6 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index df98fee69892..569e8e078ef2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -511,6 +511,38 @@ static int ltssm_status_open(struct inode *inode, struct file *file)
 	return single_open(file, ltssm_status_show, inode->i_private);
 }
 
+static struct dw_pcie_ltssm_history *dw_pcie_ltssm_trace(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->ltssm_trace)
+		return pci->ops->ltssm_trace(pci);
+
+	return NULL;
+}
+
+static int ltssm_trace_show(struct seq_file *s, void *v)
+{
+	struct dw_pcie *pci = s->private;
+	struct dw_pcie_ltssm_history *history;
+	enum dw_pcie_ltssm val;
+	u32 loop;
+
+	history = dw_pcie_ltssm_trace(pci);
+	if (!history)
+		return 0;
+
+	for (loop = 0; loop < history->count; loop++) {
+		val = history->states[loop];
+		seq_printf(s, "%s (0x%02x)\n", ltssm_status_string(val), val);
+	}
+
+	return 0;
+}
+
+static int ltssm_trace_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, ltssm_trace_show, inode->i_private);
+}
+
 #define dwc_debugfs_create(name)			\
 debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
 			&dbg_ ## name ## _fops)
@@ -552,6 +584,11 @@ static const struct file_operations dwc_pcie_ltssm_status_ops = {
 	.read = seq_read,
 };
 
+static const struct file_operations dwc_pcie_ltssm_trace_ops = {
+	.open = ltssm_trace_open,
+	.read = seq_read,
+};
+
 static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
 	struct dwc_pcie_rasdes_info *rinfo = pci->debugfs->rasdes_info;
@@ -644,6 +681,12 @@ static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 			    &dwc_pcie_ltssm_status_ops);
 }
 
+static void dwc_pcie_ltssm_trace_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
+{
+	debugfs_create_file("ltssm_trace", 0444, dir, pci,
+			    &dwc_pcie_ltssm_trace_ops);
+}
+
 static int dw_pcie_ptm_check_capability(void *drvdata)
 {
 	struct dw_pcie *pci = drvdata;
@@ -922,6 +965,7 @@ void dwc_pcie_debugfs_init(struct dw_pcie *pci, enum dw_pcie_device_mode mode)
 			err);
 
 	dwc_pcie_ltssm_debugfs_init(pci, dir);
+	dwc_pcie_ltssm_trace_debugfs_init(pci, dir);
 
 	pci->mode = mode;
 	pci->ptm_debugfs = pcie_ptm_create_debugfs(pci->dev, pci,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5cd27f5739f1..0df18995b7fe 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -395,6 +395,11 @@ enum dw_pcie_ltssm {
 	DW_PCIE_LTSSM_UNKNOWN = 0xFFFFFFFF,
 };
 
+struct dw_pcie_ltssm_history {
+    enum dw_pcie_ltssm *states;
+    u32 count;
+};
+
 struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
@@ -499,6 +504,7 @@ struct dw_pcie_ops {
 			      size_t size, u32 val);
 	bool	(*link_up)(struct dw_pcie *pcie);
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
+	struct dw_pcie_ltssm_history * (*ltssm_trace)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
 	int	(*assert_perst)(struct dw_pcie *pcie, bool assert);
-- 
2.43.0


