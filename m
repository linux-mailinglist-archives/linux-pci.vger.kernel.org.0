Return-Path: <linux-pci+bounces-27690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7387AB64C4
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 09:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DED8173A47
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736F01F78E0;
	Wed, 14 May 2025 07:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoRun6yP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5391F3B8A
	for <linux-pci@vger.kernel.org>; Wed, 14 May 2025 07:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208630; cv=none; b=kf8qUbtctWg88ZF2KFESgGtMr/PQgqjlWjgY60Kfk2nhcj5EhZmOwKuvIgNnVwpOGl1nAcUAC7T4x1vPkQSH5KVEGRxAbxihNvrzdJznvi/aKxfnYYGphi7Y9jz+QOc6sFCh/u9KAiPSJ5F1Gug+gOV+3f6NCImkdhIDTeEwE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208630; c=relaxed/simple;
	bh=nPKp14D+edh9tfbi4JKELE+B8OCwYcGrmzr5/7HZ46g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KjQYCh7mze71mcwOPwaP5cDTliWniXEmWdbrobGfCewUPuFNYdnkSN3eVubJJCUyGgut/bQUg2l99ZZ7nnFy/bHTVcIFYDYt6s1cTiLxrh2rrtlpkAyFoVdbf61wQrdRTbOvFMxNba7LlPpnn/RoA4xQXAYqJPxZnvyvvxyCFvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoRun6yP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5C3C4CEF5;
	Wed, 14 May 2025 07:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747208629;
	bh=nPKp14D+edh9tfbi4JKELE+B8OCwYcGrmzr5/7HZ46g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MoRun6yPn38VMWoOZlW8kxgZtZSJT6doP4w913CNM5HVUXrcbaJbpsmnmlH2E/vKF
	 2NvgQkwROJy0StcthJk+5+mVe5Pxh6AtU1S9WGZl1vCH5vZIwVAPuuRkCxqGkD78Fh
	 uOOXH+1U0VjuFaPSC+H5W2giv9f7CXhZnoG0l4ZJfZ7FU91ADCWiQy63gXQ7NoaKNa
	 D1sNBa9WrVvVCsngkNRmhQQ5+4lYq/DNkZhHXfGMFiCiyIRXAwVR/FB0QEa1LuyqGE
	 lQpYXDYCMDuwssKNDiyV+mlYsZxxhCYOD/W4tEgXbMBPZebNsuvkuii6hqBoA4UakD
	 C+66WQLEImLQw==
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
Subject: [PATCH v3 6/6] PCI: endpoint: Cleanup set_msix() callback
Date: Wed, 14 May 2025 09:43:19 +0200
Message-ID: <20250514074313.283156-14-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514074313.283156-8-cassel@kernel.org>
References: <20250514074313.283156-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7518; i=cassel@kernel.org; h=from:subject; bh=nPKp14D+edh9tfbi4JKELE+B8OCwYcGrmzr5/7HZ46g=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUPKdsvn6w3nrrm+2mJ/+EdFVPuz3T2Xe52cstLEYzp s66F/2zo6OUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQAT4ZVkZFg0+/zkMLmtR3bq t1fvlBc6upxztXPMvYSiQknGvafaa1cx/DP70nJw4wM9Rp5TOtc4DIIWljcLu83RDfqiMrkv8nO gEQsA
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
will have the same semantics, i.e. the parameter represents the number
of interrupts, regardless of the internal encoding of that value.

Also rename the parameter 'interrupts' to 'nr_irqs', in both the wrapper
function and the callback function, such that the name is unambiguous.

Cc: <stable+noautosel@kernel.org> # this is simply a cleanup
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c |  8 +++-----
 drivers/pci/controller/dwc/pcie-designware-ep.c  |  7 +++----
 drivers/pci/endpoint/pci-epc-core.c              | 11 +++++------
 include/linux/pci-epc.h                          |  6 +++---
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index f09f29ed27ed..0e9ebe956e7a 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -286,21 +286,19 @@ static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
-				 u16 interrupts, enum pci_barno bir,
-				 u32 offset)
+				 u16 nr_irqs, enum pci_barno bir, u32 offset)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
 	u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
 	u32 val, reg;
-	u16 actual_interrupts = interrupts + 1;
 
 	fn = cdns_pcie_get_fn_from_vfn(pcie, fn, vfn);
 
 	reg = cap + PCI_MSIX_FLAGS;
 	val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
 	val &= ~PCI_MSIX_FLAGS_QSIZE;
-	val |= interrupts; /* 0's based value */
+	val |= nr_irqs - 1; /* encoded as N-1 */
 	cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
 
 	/* Set MSI-X BAR and offset */
@@ -310,7 +308,7 @@ static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u8 vfn,
 
 	/* Set PBA BAR and offset.  BAR must match MSI-X BAR */
 	reg = cap + PCI_MSIX_PBA;
-	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
 	cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 230e82674591..6770318c0636 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -580,13 +580,12 @@ static int dw_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			       u16 interrupts, enum pci_barno bir, u32 offset)
+			       u16 nr_irqs, enum pci_barno bir, u32 offset)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
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
+	val |= nr_irqs - 1; /* encoded as N-1 */
 	dw_pcie_writew_dbi(pci, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_TABLE;
@@ -605,7 +604,7 @@ static int dw_pcie_ep_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	reg = ep_func->msix_cap + PCI_MSIX_PBA;
-	val = (offset + (actual_interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
+	val = (offset + (nr_irqs * PCI_MSIX_ENTRY_SIZE)) | bir;
 	dw_pcie_ep_writel_dbi(ep, func_no, reg, val);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ea698551f9d8..ca7f19cc973a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -361,29 +361,28 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msix);
  * @epc: the EPC device on which MSI-X has to be configured
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
- * @interrupts: number of MSI-X interrupts required by the EPF
+ * @nr_irqs: number of MSI-X interrupts required by the EPF
  * @bir: BAR where the MSI-X table resides
  * @offset: Offset pointing to the start of MSI-X table
  *
  * Invoke to set the required number of MSI-X interrupts.
  */
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-		     u16 interrupts, enum pci_barno bir, u32 offset)
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
+		     enum pci_barno bir, u32 offset)
 {
 	int ret;
 
 	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
-	if (interrupts < 1 || interrupts > 2048)
+	if (nr_irqs < 1 || nr_irqs > 2048)
 		return -EINVAL;
 
 	if (!epc->ops->set_msix)
 		return 0;
 
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msix(epc, func_no, vfunc_no, interrupts - 1, bir,
-				 offset);
+	ret = epc->ops->set_msix(epc, func_no, vfunc_no, nr_irqs, bir, offset);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 15d10c07c9f1..4286bfdbfdfa 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -103,7 +103,7 @@ struct pci_epc_ops {
 			   u8 nr_irqs);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			    u16 interrupts, enum pci_barno, u32 offset);
+			    u16 nr_irqs, enum pci_barno, u32 offset);
 	int	(*get_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*raise_irq)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			     unsigned int type, u16 interrupt_num);
@@ -288,8 +288,8 @@ void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr);
 int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
-int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-		     u16 interrupts, enum pci_barno, u32 offset);
+int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
+		     enum pci_barno, u32 offset);
 int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr, u8 interrupt_num,
-- 
2.49.0


