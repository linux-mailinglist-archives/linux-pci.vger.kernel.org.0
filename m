Return-Path: <linux-pci+bounces-20605-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B841BA24299
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 19:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FEE3A21FC
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2025 18:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB18F1E3784;
	Fri, 31 Jan 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8PXNaIx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484F7081F
	for <linux-pci@vger.kernel.org>; Fri, 31 Jan 2025 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348227; cv=none; b=P2RP1xHtbD78iy8RnoENQzTd7Oq15bDvnB4PtjArMf1OswokUkp4muOEK2e/5qpOorJHy7X9ckna6eBXxpr8arxI8xEX6PtfeMSljLfCX0X/+4P8zuWgg2gyV06Anw0nTXWxexF9P/z/tQnEx1uUwOBw7gyhZcUVVlysYairM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348227; c=relaxed/simple;
	bh=rO4LIJQIfHIs43mgpVGBJ2DomywdwncmsQISfke15cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9HPTjLEORVTiKlKMl0sLa0FlhEbgiIwquZqCx4TAGZMIOO+QMG9HHkgDGCN5FXOGFJM+WbpKTXZN33rp7o+gLh3WSM4EwUF72Fy0habRz53oOWoLPxUdLjzZo0DuMUsv0fZNpMnbJRPMLpu3OQIT0Pe6xnjBcSb0UWH/UdUNe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8PXNaIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC4C4CED1;
	Fri, 31 Jan 2025 18:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738348227;
	bh=rO4LIJQIfHIs43mgpVGBJ2DomywdwncmsQISfke15cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m8PXNaIxHq0ZN+4KdVie3eFIgXDaq9Wo1b8/psvcPrpJmvi9/QKIaMp9BDfozJ+ak
	 y9cc8tYMwIMSIu+GmzHLFwpizfDqWuB1dd23UV13VBLOepbCvSAIz45QSvCTJqyidq
	 l7HCyyjUXGosUkTIeHe8IOr/o6W4i860VyPcP6Vpwt3iWSy89bK5JEBUzXNvXr+wRT
	 Qr034lveoRPCPXjCq5Fh6hDIHMpksVZChrbaihpAmZvfrYrp8ulQntLUdo8NWljX9u
	 NN3CCKGX1HPPMu7jkiWJqH1jYMYRogCesvAqIOn5balep2thB1MsfnKotuD85OzFrL
	 onTZKAH1Xbgyw==
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
Subject: [PATCH v4 3/7] PCI: dwc: ep: Move dw_pcie_ep_find_ext_capability()
Date: Fri, 31 Jan 2025 19:29:52 +0100
Message-ID: <20250131182949.465530-12-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131182949.465530-9-cassel@kernel.org>
References: <20250131182949.465530-9-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1955; i=cassel@kernel.org; h=from:subject; bh=rO4LIJQIfHIs43mgpVGBJ2DomywdwncmsQISfke15cw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLniq1aaZJ8aD+bSOC/wqilDs/+C0jPX5rKd8Zr0qebH nsm7bUI7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEtNgYGfak97dxT5GWZt54 b4POHAHPDxF8q+rm8pjfsVh7arpl7W6G/xHfpnoqL7IRfxq7XvLlfI77+pV7o98v/vz+/5GPhqX OsYwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Move dw_pcie_ep_find_ext_capability() so that it is located next to
dw_pcie_ep_find_capability().

Additionally, a follow-up commit requires this to be defined earlier
in order to avoid a forward declaration.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
2.48.1


