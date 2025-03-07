Return-Path: <linux-pci+bounces-23113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76410A56813
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A704A175E0F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D83217F36;
	Fri,  7 Mar 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbtG1ZMF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD520F06C
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351668; cv=none; b=l5S8Ndm5pXoQy4+TARqzsydax7r01pt2ERhjjEOX54qq/Nh8cRYp9KN80HbuKndE93M6e5JlYIfv9QJKMdpQiU34vFPR7Bj+Zj3/hjBH8cgf7+DZG8UoQ7OJZr3wtbWwVY1Lq7T1H8hLO5hp03GswQy9ziIiHne3OSb6XDu7B0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351668; c=relaxed/simple;
	bh=EXWgdA5zPTltOnxenAQytrNbeINQ16wRUkuJVLLiGic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEcoX9qRlBYkSrO/c2CywfyJpAJ1b8l2evCt8LJ+7CfW2TTy92wR7W2MpD3DR9gcS+xgdvrdo2Bp76dFPMHj0niPlPfzUzkZ4PpMCAvSQ4hpAyHJ+YSgbs3J0Bl442b62nU3SISVYkRM+GPYWOmfJEJ0gRTGGH90BqW1b4pwCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbtG1ZMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE870C4CED1;
	Fri,  7 Mar 2025 12:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741351668;
	bh=EXWgdA5zPTltOnxenAQytrNbeINQ16wRUkuJVLLiGic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbtG1ZMFsyLJLNC1YrPTe9nwGM7haQl1sXapchjA9MqA0D8v8VhMovVT8ydFiXBrp
	 SL5Poh9xBxDpOnln+1PPk/qZFnGj2ZS0eHzF5OAdab8Ld81uM0ZQ3u6cdp6luq4ApX
	 7AOuXFJiZpuM4Oi7lSUuxXZ/A/ZyXHJyKardmDS9CaCVeFnLjNYXV1fiJzlcHwql7t
	 BWA9lJcR35u8nvae6Nww88oRLMKDJimwOVZ6EpmzMVmXgzDUhd50ZrVzAysqb2ERFV
	 fECr9eg9qqyOu1kT0A3FhGvDrgH5RscHBwM+YLVt/KC3RCsaH4Va3Twpko6O+uGU7i
	 fvvVY+NIQW6sg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 1/2] PCI: dwc: ep: Add dw_pcie_ep_hide_ext_capability()
Date: Fri,  7 Mar 2025 13:47:34 +0100
Message-ID: <20250307124732.704375-5-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307124732.704375-4-cassel@kernel.org>
References: <20250307124732.704375-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3308; i=cassel@kernel.org; h=from:subject; bh=EXWgdA5zPTltOnxenAQytrNbeINQ16wRUkuJVLLiGic=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJPvXo6IeO54e9K26oYv5j2T7HV6g/nxp5XKwhJag22a BPYmH6mo5SFQYyLQVZMkcX3h8v+4m73KccV79jAzGFlAhnCwMUpABN5l8zIcOv1Z+3yUx2XQvca 8N0J2bf/YXRgbfPiygVs91avWeod+5Thf1SbR8w0S91cz6XS6902R90V+Plk4tFzBwvnMWfGPNn cwAsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add dw_pcie_ep_hide_ext_capability() which can be used by an endpoint
controller driver to hide a capability.

This can be useful to hide a capability that is buggy, such that the
host side does not try to enable the buggy capability.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 38 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  7 ++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a8568808b5e5..d671fea1e7c6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -102,6 +102,44 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
 }
 
+/**
+ * dw_pcie_ep_hide_ext_capability - Hide a capability from the linked list
+ * @pci: DWC PCI device
+ * @prev_cap: Capability preceding the capability that should be hidden
+ * @cap: Capability that should be hidden
+ *
+ * Return: 0 if success, errno otherwise.
+ */
+int dw_pcie_ep_hide_ext_capability(struct dw_pcie *pci, u8 prev_cap, u8 cap)
+{
+	u16 prev_cap_offset, cap_offset;
+	u32 prev_cap_header, cap_header;
+
+	prev_cap_offset = dw_pcie_find_ext_capability(pci, prev_cap);
+	if (!prev_cap_offset)
+		return -EINVAL;
+
+	prev_cap_header = dw_pcie_readl_dbi(pci, prev_cap_offset);
+	cap_offset = PCI_EXT_CAP_NEXT(prev_cap_header);
+	cap_header = dw_pcie_readl_dbi(pci, cap_offset);
+
+	/* cap must immediately follow prev_cap. */
+	if (PCI_EXT_CAP_ID(cap_header) != cap)
+		return -EINVAL;
+
+	/* Clear next ptr. */
+	prev_cap_header &= ~GENMASK(31, 20);
+
+	/* Set next ptr to next ptr of cap. */
+	prev_cap_header |= cap_header & GENMASK(31, 20);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+	dw_pcie_writel_dbi(pci, prev_cap_offset, prev_cap_header);
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index a03b3799fb27..2d1de81d47b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -781,6 +781,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
 int dw_pcie_ep_raise_msix_irq_doorbell(struct dw_pcie_ep *ep, u8 func_no,
 				       u16 interrupt_num);
 void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar);
+int dw_pcie_ep_hide_ext_capability(struct dw_pcie *pci, u8 prev_cap, u8 cap);
 struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no);
 #else
@@ -838,6 +839,12 @@ static inline void dw_pcie_ep_reset_bar(struct dw_pcie *pci, enum pci_barno bar)
 {
 }
 
+static inline int dw_pcie_ep_hide_ext_capability(struct dw_pcie *pci,
+						 u8 prev_cap, u8 cap)
+{
+	return 0;
+}
+
 static inline struct dw_pcie_ep_func *
 dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
 {
-- 
2.48.1


