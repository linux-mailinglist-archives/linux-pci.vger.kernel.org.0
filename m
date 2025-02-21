Return-Path: <linux-pci+bounces-22027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7694BA400D0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 21:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC0E77014FE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BAC253B44;
	Fri, 21 Feb 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgFaDA1M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725DC253359
	for <linux-pci@vger.kernel.org>; Fri, 21 Feb 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169617; cv=none; b=fMDVUva67FGf+0glJWr5FqspEYZWNbYGL2mZ3dHYe6FORC017hPkOmOi2niL1J7Ss2Nq06D8daTaNcNrS5O34RyjNnA11xMPgbcTfdHnmNfJ1NCMTB4c4uV7dELj041EJSbVLltq8mwzkkbvZz2yuZJpOa3cczlEsRZcJ2rAsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169617; c=relaxed/simple;
	bh=1LyqPB8VGK1Jxgl+h1/rXaUt9zwo9HtL8AJzA2oi8JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmBliIm0S5vPFPYz+hq5eXRnqoshTeCVAgaoEpWF8jzVL5Y41ImHL3H9ai/y4+/xG+4I3xegaEP7Gt2TLHSxchHcE6hjlMZ+yToFAFrvcQtHrcOB4NtaV35Mm02Okhpoo+EyadgFd2a8eIFVhi1dY1SUQ5SUPPjqHsYL4xNIm9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgFaDA1M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1BEC4CED6;
	Fri, 21 Feb 2025 20:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740169617;
	bh=1LyqPB8VGK1Jxgl+h1/rXaUt9zwo9HtL8AJzA2oi8JA=;
	h=From:To:Cc:Subject:Date:From;
	b=jgFaDA1MYtGjyogJS2kMagQaCe3qvjZ60m+cp1NgxdS8PEuVGK3GFlwY1pWVzG6mE
	 bgPlJiRfTFvuIEJvCX5HtANn6+gWxn8x26HAyHqFVLIf6Qo4dbgEJ2ZW3Uhwm3vJgj
	 xa5yg/Z3MKC1imRlxE0mM0n/Tlt2+RRisa9CK8+KurtloWXJ2aS9LzrMOeRs8JDDgS
	 yZnajhaMsPs1q5PIOCsVjlSuWBtVgKUHqIzGwPsL8P8kQUbeUnV/csY09hNeu057Rw
	 bCqsgw+JIPMvuO4T5JycCXYHM9QVfvyRqsmXkTAqxGrwzHHq6olPLfSson85jhRtbQ
	 SGuBi+5lqX3AQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCI: dwc: ep: Remove superfluous function dw_pcie_ep_find_ext_capability()
Date: Fri, 21 Feb 2025 21:26:47 +0100
Message-ID: <20250221202646.395252-3-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2208; i=cassel@kernel.org; h=from:subject; bh=1LyqPB8VGK1Jxgl+h1/rXaUt9zwo9HtL8AJzA2oi8JA=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJ3PGw7/LbLhzco5FfuVI55rgyqx89dShWNuKUuc9jhN iPXlt2nO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCR3DhGhmaOGdw//9mGWLjG 7sqbMlE+eXWi7nvBz03uhzJqTj2R92X4X2h2fNIMjsYz/xdWZv7iW1q9fUXVlcao+qvZ5ZqOVWm PmAE=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Remove the superfluous function dw_pcie_ep_find_ext_capability(), as it is
virtually identical to dw_pcie_find_ext_capability().

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 24 +++----------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index f9d7f3f989ad..20f2436c7091 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -102,24 +102,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie_ep *ep, u8 func_no, u8 cap)
 	return __dw_pcie_ep_find_next_cap(ep, func_no, next_cap_ptr, cap);
 }
 
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
 static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 				   struct pci_epf_header *hdr)
 {
@@ -230,7 +212,7 @@ static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
 	unsigned int offset, nbars;
 	int i;
 
-	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 	if (!offset)
 		return offset;
 
@@ -847,7 +829,7 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 	enum pci_barno bar;
 	u32 reg, i, val;
 
-	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	offset = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
@@ -970,7 +952,7 @@ int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	if (ep->ops->init)
 		ep->ops->init(ep);
 
-	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
+	ptm_cap_base = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
 
 	/*
 	 * PTM responder capability can be disabled only after disabling
-- 
2.48.1


