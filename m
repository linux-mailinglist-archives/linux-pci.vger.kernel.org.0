Return-Path: <linux-pci+bounces-27618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC950AB4CC3
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 09:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF94A7ABEA1
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 07:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AA74315E;
	Tue, 13 May 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmQu+hpT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3E83FBA7
	for <linux-pci@vger.kernel.org>; Tue, 13 May 2025 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747121492; cv=none; b=gXv7OwsEGa1OcoifzqijskhwOKs+Lfd2SJLR5qc59MjLuJPArVgrYfaOUwvDzSAETJY9d79MmbmFonKkCaUGNl5zEL67xcnzCAcJj8SQXIIzp4ERdHoCRSO4HTaXJMI7mx1rsbNtSrDGarlfwtwVMYSMw6z/rLTOC62sLAxAOrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747121492; c=relaxed/simple;
	bh=koC1+zLzIK9W43U+GQCH7F5Wa+eAIla+DZnqtpGb4Os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9foIIkQyatcGbAZdsp4qQ1AMj/++NxEemJ3EGaUP8x/LIE0gi/H7D4ovUDdzuF5tLtFgk5t/CKxxOCWkS/BzyNnbmFn2JU58rZyT5hNgdyzAGUvbklgYsl7FUhUIYrQ6sC2VZfxDlJEg0Bnmgfh9H6BIU/2jNrzqlD1Hk4gKSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmQu+hpT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B720C4CEE4;
	Tue, 13 May 2025 07:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747121492;
	bh=koC1+zLzIK9W43U+GQCH7F5Wa+eAIla+DZnqtpGb4Os=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmQu+hpTOLhYMP5J0F/9UJU2Wz+eeFAOoCRH0Vd8sJc1iJpqUPFETLrhfSJ44jqai
	 +Lw3vsutkC/iT+VvtpUWF4sIoQOZzSggKrYyGq6pE6fONSCjXd9IkAiRV/k1DjCZcS
	 NItBziI34c8vv/sk2uBwDnqnWXcnHOdpw1IRTG7dMYjR+CTTRQn7ufbIMrsY/pzWNs
	 +4sohlnkINerW0fj1dSD7PDPZPazzkrEZJdytQDe5yFSJUu6KMzqohhGoRAWN/jtFE
	 nk56p/bmoGsxNjPB/NV5TI/C9p7iKeFSz3Kea3pvkffX4KwZM0NesLorR0MKENd5tA
	 lHtCraGl2ZnFg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 6/6] PCI: endpoint: cleanup set_msix() callback
Date: Tue, 13 May 2025 09:31:01 +0200
Message-ID: <20250513073055.169486-14-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513073055.169486-8-cassel@kernel.org>
References: <20250513073055.169486-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4342; i=cassel@kernel.org; h=from:subject; bh=koC1+zLzIK9W43U+GQCH7F5Wa+eAIla+DZnqtpGb4Os=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDKUvhodU43ex3vwV2ZvQNc94aAmceszTzZWMe+eLHlw7 1XvgMdzO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRf/8ZGWbe/WkxV2XN/mkb FR5Lv5++frd2kWfqiRne0ywvGkzW5xFn+MMRYBMR+PVoz6U5D+S3HXBlXOxeotnwJmrxAz0dkW1 8duwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The kdoc for pci_epc_set_msix() says:
"Invoke to set the required number of MSI-X interrupts."
the kdoc for the callback pci_epc_ops->set_msix() says:
"ops to set the requested number of MSI-X interrupts in the MSI-X
capability register"

pci_epc_ops->set_msix() does however expect the parameter 'interrupts' to
be in the encoding as defined by the Table Size field.

Nowhere in the kdoc does it say that the number of interrupts should be
in Table Size encoding.

Thus, it is very confusing that the wrapper function (pci_epc_set_msix())
and the callback function (pci_epc_ops->set_msix()) both take a parameter
named interrupts, but they both expect completely different encodings.

Cleanup the API so that the wrapper function and the callback function
will have the same semantics.

Cc: <stable+noautosel@kernel.org> # this is simply a cleanup
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c | 5 ++---
 drivers/pci/controller/dwc/pcie-designware-ep.c  | 5 ++---
 drivers/pci/endpoint/pci-epc-core.c              | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index bbb310135977..542533a8c56a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -294,14 +294,13 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
-	u16 actual_interrupts = interrupts + 1;
 
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	reg = cap + PCI_MSIX_FLAGS;
 	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts; /* 0's based value */
+	val |= interrupts - 1; /* encoded as N-1 */
 	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
 
 	/* Set MSI-X BAR and offset */
@@ -311,7 +310,7 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index d74d21c42559..0d204149a6e2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -586,7 +586,6 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *ep_func;
 	u32 val, reg;
-	u16 actual_interrupts = interrupts + 1;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
 	if (!ep_func || !ep_func->msix_cap)
@@ -597,7 +596,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	reg = ep_func->msix_cap + PCI_MSIX_FLAGS;
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts; /* 0's based value */
+	val |= interrupts - 1; /* encoded as N-1 */
 	dw_pcie_writew_dbi(pci, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
@@ -605,7 +604,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
-	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 7b4a9292f801..ea4e64249949 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -382,7 +382,7 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, vfunc_no, interrupts - 1, bir,
+	ret = epc->ops->set_msix(epc, func_no, vfunc_no, interrupts, bir,
 				 offset);
 	mutex_unlock(&epc->lock);
 
-- 
2.49.0


