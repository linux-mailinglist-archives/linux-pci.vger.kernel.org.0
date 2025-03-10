Return-Path: <linux-pci+bounces-23300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DD2A59032
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D51417A4754
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D4225412;
	Mon, 10 Mar 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5dYFyxA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CD1225408
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600149; cv=none; b=GS4wU0ZZC1eYkQdYkirkqEJ3y6/wW/CvfvLhdh51yUR8v5z/67DmAXVqEqcwUUa2/fH/JOJCc9f2oNAq32vpTzrjz6lH52wnXPtHg+5vJ3uE56Rczri7hcw7MQDOG5bt6bT4iyrHSYkuyPAc0/iliWBnYnBqtJZbw764IfPG80E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600149; c=relaxed/simple;
	bh=QZzcsXxR9LkyaevHXqOUxhdR/SsoGvydUJWITsm58rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIUdXT02RRrWIyv9wv6hGGPRBc6bJCvCALgHuqG5GKoYx00QUanH4a1ZSQetb6fvd+XgRYJqcy4dZJ6KD/5l5tl1AWG7qS0VoW7GSCA5HrVZZhGuVbaBlmsC7ZZz6TN0hsRAoPq80+jq56uttA3bxyy24VaeEHIpsQtAduL13V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5dYFyxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1791BC4CEE5;
	Mon, 10 Mar 2025 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741600149;
	bh=QZzcsXxR9LkyaevHXqOUxhdR/SsoGvydUJWITsm58rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C5dYFyxABYfJoQuOAaAbk9pFFoC1gzMR46lfYlnQZmGiy3lvFc/9WVxcz8eoy0OGA
	 or04fgwo8JQ1iMgl2NTu+Ddu6FJZotgoNqStCeI8x2UdYZ/WhmBqiJuegmvleZJTrY
	 0QnAucsEq/dI0H3CzJosUoAMTrNNupGMvph8J9D5YHIp577c84lYAEMRfMhhoPBx42
	 pJ3idDGXWMNmCmP8UjT6laBjsiHiRjwFkhx+W5AtZnaf5NbmDdb43a6PjTtogl4osW
	 xsc6K+6jzwyiCHLUOOAv4FQfBrHW1GqsnD6e4I4VwUZJmbjXMgqrSFoJfSgc5+pBAL
	 24QqPgWy2vdiw==
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
Subject: [PATCH v3 1/2] PCI: dwc: ep: Add dw_pcie_ep_hide_ext_capability()
Date: Mon, 10 Mar 2025 10:48:27 +0100
Message-ID: <20250310094826.842681-5-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310094826.842681-4-cassel@kernel.org>
References: <20250310094826.842681-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3361; i=cassel@kernel.org; h=from:subject; bh=QZzcsXxR9LkyaevHXqOUxhdR/SsoGvydUJWITsm58rU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPbS0QvJYj+VtkS1v+ulvqK7NkCu4tY/mrEu2Skbok5 0x2SGRaRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACayfwfDP1PP7j1Ho6YFnWm/ x7r1bLO32iyZL6sEuVb/W/jxxPa2XRcZGTYZ9j5+kC/R/eSn2EY9PebKU1/rDq2INHroaijc5ZD 6gRcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Add dw_pcie_ep_hide_ext_capability() which can be used by an endpoint
controller driver to hide a capability.

This can be useful to hide a capability that is buggy, such that the
host side does not try to enable the buggy capability.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 39 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  7 ++++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index a8568808b5e5..9768703a37b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -102,6 +102,45 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
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
+EXPORT_SYMBOL_GPL(dw_pcie_ep_hide_ext_capability);
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


