Return-Path: <linux-pci+bounces-19657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2621A0B48F
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B121C16255D
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995B3C1F;
	Mon, 13 Jan 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCn5FVWp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153A2BA49
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764079; cv=none; b=r2xtv64EAN1OgLCPDLGB5kA2ggKQo37cR6sw6OwPVOKoYbwYYi0fqxW0K4ze0JimjFwmDDyCCE2fSeVlS6aoiMztSpnd1idj5xXT+9ufApCvYYeS0mBaJE2IcQQo//tMi/WaOzj0ExO7tyWs2r4L+zbqHMEdIbDy6Q/Aufa4dQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764079; c=relaxed/simple;
	bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoW/yfls2J0D2U/WpnjbI6+TEy93ffe5uYkkuIA8sCixk4BpeumqWMrdlwiBy71H9cyXmX1FmghXhj9J8Y8PWb9tG/thyEPYd7I4niWtAmrBMIf4Q3HCi8Yh2tuPYWFBu+CWBaLdbZ/WZgO4uFSxLz+g1YyHvvFmCqlL1KwLHLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCn5FVWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68354C4CED6;
	Mon, 13 Jan 2025 10:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736764078;
	bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oCn5FVWp23YzeIG6OAGd37m2TzRoPpZsBFJdF8kBPbc4EsxnsXEiMfFbxgv8oUtx/
	 5FCZmnUE2bq9VP9hV23yqNrtiCH6PIsI8/qt22xcRZOs1owOljXPtaxY+MM6raPORY
	 kkosueF+ZZFYdq3KnpBetAAGl/PPyETXifYGIpKUsP1MoNoBVX8SHT6v1b+uw5Ty6N
	 nQUjoqR/kiPulnIQLalyjCTresusMNn39ePATaPLELDlZHkxqz6l6gcYk3wrGwswtE
	 2DRxuabAF+bPPef4eK3FUQHkXdHvws/1wwiZ+LOaUhNfjzzWJIe4clUH/fkeByxmHw
	 l86Au07nog57w==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v3 2/6] PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
Date: Mon, 13 Jan 2025 11:27:33 +0100
Message-ID: <20250113102730.1700963-10-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113102730.1700963-8-cassel@kernel.org>
References: <20250113102730.1700963-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884; i=cassel@kernel.org; h=from:subject; bh=Yp1kSs17kW6mzImsCQDNvZePX3qc9b5BoCNjhBaDlP0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJbXs0QWm/5cImE5d8lL+fNrG8OiTj6dprc8tZNNh+vS LKcYNIq6ShlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE7tsw/M/eNrf0+ip9UwfW 1ebt90/9r+Z4tfObt0rqoZhQh+6NH74wMszJ6/gy//JHPQFbAcHT84QcQ8IrGCaYyM46t054zil NZmYA
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


