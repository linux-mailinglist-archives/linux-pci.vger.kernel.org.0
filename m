Return-Path: <linux-pci+bounces-27689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B22AB64C2
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 09:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A883A7FEC
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 07:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974341F78E0;
	Wed, 14 May 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXGPGGgo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2781F3B8A;
	Wed, 14 May 2025 07:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208626; cv=none; b=NREw9bADDPIOpFRhi4QnNwt/a5Z3ITwWSHlOfkeLrRgf/I/rh/YbeKymRW2qSKRjncjSvlk+2zYRVcxYR02M65JWOSIRZsrs61SfplRKW2c8jdaGWPbnvyyppUGtAD+1ZNAWJvd2UuHZLQlPaggFZklotAwWDtm/eQC90nVr9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208626; c=relaxed/simple;
	bh=aA8oXqSx8pMm/jG1knFZKUSb8eq19i4/3ip8tFNLR1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5/w/PrDr7wB68/yKOg70WY/dM60a1IcCjn9qU1xsgwIStrrxCoW6DbJuDv69ZK9FKA/Ay+4V1n9pAduJNYoEdKyZs2DvKEnKb8YDF963fKkkBw+aB7TKDeFFxLdlmlFkHmwale7b5D658nDU5xWUj+xFMYGirepZkCjZ21xU40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXGPGGgo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C57C4CEF3;
	Wed, 14 May 2025 07:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747208626;
	bh=aA8oXqSx8pMm/jG1knFZKUSb8eq19i4/3ip8tFNLR1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXGPGGgo8CoB1f4qnhxIbmcsFxJcRmX+kuo5tCLJj7dpfVG9M2R7sUzjtQVXAQkIe
	 O88+uWM6OWhRUV3NNHd5FpEH2SqiIDbPHnpZuS2i2z0RqR8xFlqo+Clz68zpW6oE2h
	 EEq+W1odXW1O9p0bzTb6L1sDwESNfymLQ/iDp7IGiw4vAlcdR4MHGuh2MFEJ/rGJlp
	 WcEl1RM9z3MljxDvPUMNnpwpRUXjFA64xtoc0BtFMqClpZl0s26iWf3zUEMMJylKut
	 TjINl3xKMYtxiqhUKMGIby4jY9LZMlGubNsQCT44VLsxAUjGb1ketLBF97QJFcCqeR
	 cJXphq8B48MVA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	stable+noautosel@kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 5/6] PCI: endpoint: Cleanup set_msi() callback
Date: Wed, 14 May 2025 09:43:18 +0200
Message-ID: <20250514074313.283156-13-cassel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514074313.283156-8-cassel@kernel.org>
References: <20250514074313.283156-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8144; i=cassel@kernel.org; h=from:subject; bh=aA8oXqSx8pMm/jG1knFZKUSb8eq19i4/3ip8tFNLR1Q=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGDJUPCefYf1xvHaTSzJbRJX8wpIKpqfxtstvpmw+/zzuk u6S1z3LOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRTz6MDHs+zok9kfPv8kOn xccky9TqpN7lnfwzMzxPVjI1OW36pVMM/1O0rxU+WxgvbrLowvSp01Kc/IIfXUm/k9s0+d63eyn x+XwA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The kdoc for pci_epc_set_msi() says:
"Invoke to set the required number of MSI interrupts."
the kdoc for the callback pci_epc_ops->set_msi() says:
"ops to set the requested number of MSI interrupts in the MSI capability
register"

pci_epc_ops->set_msi() does however expect the parameter 'interrupts' to
be in the encoding as defined by the MMC Multiple Message Capable field.

Nowhere in the kdoc does it say that the number of interrupts should be
in MMC encoding.

Thus, it is very confusing that the wrapper function (pci_epc_set_msi())
and the callback function (pci_epc_ops->set_msi()) both take a parameter
named interrupts, but they both expect completely different encodings.

Cleanup the API so that the wrapper function and the callback function
will have the same semantics, i.e. the parameter represents the number
of interrupts, regardless of the internal encoding of that value.

Also rename the parameter 'interrupts' to 'nr_irqs', in both the wrapper
function and the callback function, such that the name is unambiguous.

Cc: <stable+noautosel@kernel.org> # this is simply a cleanup
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c |  3 ++-
 drivers/pci/controller/dwc/pcie-designware-ep.c  |  5 +++--
 drivers/pci/controller/pcie-rcar-ep.c            |  6 +++---
 drivers/pci/controller/pcie-rockchip-ep.c        |  5 +++--
 drivers/pci/endpoint/pci-epc-core.c              | 11 ++++-------
 include/linux/pci-epc.h                          |  5 ++---
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 569cb7481d45..f09f29ed27ed 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -220,10 +220,11 @@ static void cdns_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 	clear_bit(r, &ep->ob_region_map);
 }
 
-static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 mmc)
+static int cdns_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 nr_irqs)
 {
 	struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
 	struct cdns_pcie *pcie = &ep->pcie;
+	u8 mmc = order_base_2(nr_irqs);
 	u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
 	u16 flags;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 307c862588a4..230e82674591 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -536,11 +536,12 @@ static int dw_pcie_ep_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 }
 
 static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			      u8 interrupts)
+			      u8 nr_irqs)
 {
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *ep_func;
+	u8 mmc = order_base_2(nr_irqs);
 	u32 val, reg;
 
 	ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
@@ -550,7 +551,7 @@ static int dw_pcie_ep_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	reg = ep_func->msi_cap + PCI_MSI_FLAGS;
 	val = dw_pcie_ep_readw_dbi(ep, func_no, reg);
 	val &= ~PCI_MSI_FLAGS_QMASK;
-	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, interrupts);
+	val |= FIELD_PREP(PCI_MSI_FLAGS_QMASK, mmc);
 	dw_pcie_dbi_ro_wr_en(pci);
 	dw_pcie_ep_writew_dbi(ep, func_no, reg, val);
 	dw_pcie_dbi_ro_wr_dis(pci);
diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
index 9da39a4617b6..a8a966844cf3 100644
--- a/drivers/pci/controller/pcie-rcar-ep.c
+++ b/drivers/pci/controller/pcie-rcar-ep.c
@@ -256,15 +256,15 @@ static void rcar_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn, u8 vfn,
 	clear_bit(atu_index + 1, ep->ib_window_map);
 }
 
-static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
-				u8 interrupts)
+static int rcar_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn, u8 nr_irqs)
 {
 	struct rcar_pcie_endpoint *ep = epc_get_drvdata(epc);
 	struct rcar_pcie *pcie = &ep->pcie;
+	u8 mmc = order_base_2(nr_irqs);
 	u32 flags;
 
 	flags = rcar_pci_read_reg(pcie, MSICAP(fn));
-	flags |= interrupts << MSICAP0_MMESCAP_OFFSET;
+	flags |= mmc << MSICAP0_MMESCAP_OFFSET;
 	rcar_pci_write_reg(pcie, flags, MSICAP(fn));
 
 	return 0;
diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 85ca7d9b4c77..a0a85080c31d 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -308,10 +308,11 @@ static void rockchip_pcie_ep_unmap_addr(struct pci_epc *epc, u8 fn, u8 vfn,
 }
 
 static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
-				    u8 multi_msg_cap)
+				    u8 nr_irqs)
 {
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
+	u8 mmc = order_base_2(nr_irqs);
 	u32 flags;
 
 	flags = rockchip_pcie_read(rockchip,
@@ -319,7 +320,7 @@ static int rockchip_pcie_ep_set_msi(struct pci_epc *epc, u8 fn, u8 vfn,
 				   ROCKCHIP_PCIE_EP_MSI_CTRL_REG);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_MASK;
 	flags |=
-	   (multi_msg_cap << ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
+	   (mmc << ROCKCHIP_PCIE_EP_MSI_CTRL_MMC_OFFSET) |
 	   (PCI_MSI_FLAGS_64BIT << ROCKCHIP_PCIE_EP_MSI_FLAGS_OFFSET);
 	flags &= ~ROCKCHIP_PCIE_EP_MSI_CTRL_MASK_MSI_CAP;
 	rockchip_pcie_write(rockchip, flags,
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 092b14918b46..ea698551f9d8 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -302,28 +302,25 @@ EXPORT_SYMBOL_GPL(pci_epc_get_msi);
  * @epc: the EPC device on which MSI has to be configured
  * @func_no: the physical endpoint function number in the EPC device
  * @vfunc_no: the virtual endpoint function number in the physical function
- * @interrupts: number of MSI interrupts required by the EPF
+ * @nr_irqs: number of MSI interrupts required by the EPF
  *
  * Invoke to set the required number of MSI interrupts.
  */
-int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs)
 {
 	int ret;
-	u8 encode_int;
 
 	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
-	if (interrupts < 1 || interrupts > 32)
+	if (nr_irqs < 1 || nr_irqs > 32)
 		return -EINVAL;
 
 	if (!epc->ops->set_msi)
 		return 0;
 
-	encode_int = order_base_2(interrupts);
-
 	mutex_lock(&epc->lock);
-	ret = epc->ops->set_msi(epc, func_no, vfunc_no, encode_int);
+	ret = epc->ops->set_msi(epc, func_no, vfunc_no, nr_irqs);
 	mutex_unlock(&epc->lock);
 
 	return ret;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 82837008b56f..15d10c07c9f1 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -100,7 +100,7 @@ struct pci_epc_ops {
 	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      phys_addr_t addr);
 	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-			   u8 interrupts);
+			   u8 nr_irqs);
 	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 	int	(*set_msix)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			    u16 interrupts, enum pci_barno, u32 offset);
@@ -286,8 +286,7 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     u64 pci_addr, size_t size);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr);
-int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
-		    u8 interrupts);
+int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
 int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
 int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		     u16 interrupts, enum pci_barno, u32 offset);
-- 
2.49.0


