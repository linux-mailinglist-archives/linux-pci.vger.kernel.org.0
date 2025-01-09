Return-Path: <linux-pci+bounces-19593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4828A070DB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA2D188A8C0
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11872214A70;
	Thu,  9 Jan 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtutVlZy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBC221518F
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413636; cv=none; b=QmZqAqpIl+v34laCyURheW9D38wPHLEfRLRWRbIlNDGvyLHh9l2+zTjpbYk6lIwDoRPKhPB2DzSsnL999OpRyoRRN4ql4JaT7tzdvBGXf3cbIkQb8AgRAnas+J/P59f0At3/Ws0B9N6i9nnOomClTMkK4XsTPT/2G9Ypt1gVoQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413636; c=relaxed/simple;
	bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JDA24WWmFQSA8n9Awt3ZErBalKlz/zkN4D31pX4GBPLkjI3FxFgYHmrjxccsK4+6MTKTTC7HtQYhcUkHkbht8sO1m2l0gHK2FlNWneqzbQen3eSV8DFy0UV5IkD7n6SCNJPy/my/iVnV8E+umEyZiVx+3Y9ZOcw7ubVSMJAVlAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtutVlZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829C2C4AF09;
	Thu,  9 Jan 2025 09:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736413635;
	bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WtutVlZyRIACTOtnvwlvjvrTHx5y8mnjHkFwWplImlUcKof5nJbBtKpi97qbZ4XyU
	 hZszVFUh07Pu5JQZQprk0uhrUQmz5+j/60BQkySIR6y8XGzFqeA6tFnI4+7GfBgoiU
	 pAE5fGWiTbPRJ3v8QzaSjCgNXhW4zOoYviQeHth1HiXiAnXA/Zq2nDqeS8Bc7N32FH
	 pof8KKAWMqaGZ0m6K44q8gBo3BxItA085OexnxgrSNiVrTzt0tB5OCuA1d35c5t46L
	 jQEiN6F0gUS8JykpfHwLOrNvyRupKPWJXn0iZ/T3MTI0vF3V25p5FHHB1JBickrHcS
	 KLF5YVPka6ldg==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 2/6] PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
Date: Thu,  9 Jan 2025 10:06:54 +0100
Message-ID: <20250109090652.110905-10-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109090652.110905-8-cassel@kernel.org>
References: <20250109090652.110905-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=cassel@kernel.org; h=from:subject; bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLrJ24UWm/5cImE5d8lL+fNrG8OiTj6dprc8tZNNh+vS LKcYNIq6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE9EoYGQ7Oy9jYz8Tqe3f3 co6bAQlWrS5T7/BcOiZVx+kukyDzt4qRYXN0eXmk+VxXp7s9qwXuzJ0TrPTn7YXIutsXVHIj0xO msQIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Move dw_pcie_ep_find_ext_capability() so that it is located next to
dw_pcie_ep_find_capability().

Additionally, a follow-up commit requires this to be defined earlier
in order to avoid a forward declaration.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 8e07d432e74f..6b494781da42 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -102,6 +102,24 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
 }
 
+static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
+{
+	u32 header;
+	int pos = PCI_CFG_SPACE_SIZE;
+
+	while (pos) {
+		header = dw_pcie_readl_dbi(pci, pos);
+		if (PCI_EXT_CAP_ID(header) == cap)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (!pos)
+			break;
+	}
+
+	return 0;
+}
+
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
@@ -690,24 +708,6 @@ void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
-static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
-{
-	u32 header;
-	int pos = PCI_CFG_SPACE_SIZE;
-
-	while (pos) {
-		header = dw_pcie_readl_dbi(pci, pos);
-		if (PCI_EXT_CAP_ID(header) == cap)
-			return pos;
-
-		pos = PCI_EXT_CAP_NEXT(header);
-		if (!pos)
-			break;
-	}
-
-	return 0;
-}
-
 static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 {
 	unsigned int offset;
-- 
2.47.1


