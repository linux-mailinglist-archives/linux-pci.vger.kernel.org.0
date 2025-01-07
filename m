Return-Path: <linux-pci+bounces-19456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1083A0490D
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24ADB1886C7F
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622A1B4F0E;
	Tue,  7 Jan 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5TbEcca"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649901F1902
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273733; cv=none; b=GDBNQ48L2qt9VRkh1vCqzmDtYZPfjMKF9ZIUU64HSWXYDY0BNhAZwicGuY7E5RhbtLEpBF/ZozAdS7C2oApF14/uGhPrLDnzz98gwBZgKLO8HRewQTkS5Zh1+uVFEn22sV3aszX/WC8txK6ToA2yI2uwr1kXMXRdGz4gEEMqFDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273733; c=relaxed/simple;
	bh=v3Kwhm0BhDUuD1HxjafB0VtsUe6IRB51dWNCDvdZGWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VoIBzYlMeLrNUQyIRACqaJQIT7LFkJUazWvJiGLvlRPtb27OpWHiAdRSpavOB+arSDUwHl0DPgm0/ganGoI+W94mw5SL8DthLXbcBQr4xtcYljJ9oyUmnV5sF9ZUzOOsjxfmhY4Tkrx9nN2WL5t/yTTX/Twqx7SFckd+HC4c29A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5TbEcca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF00C4CED6;
	Tue,  7 Jan 2025 18:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273733;
	bh=v3Kwhm0BhDUuD1HxjafB0VtsUe6IRB51dWNCDvdZGWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F5TbEccanVoIJ8TMC9T/bSLyYqpJHN+hdXnZKNHWofJ1BW65oBKajK3nTQSTeRyWX
	 vF5dlV1WAjRhnN8hd9hwhiG+y+msgysrGh8Erp0KL7UOTGxJCfgtIL7sMWjKQzc7hI
	 W4Ow55AzV06oHocICNFkxxN8rBzOpJFT2uBIjc6ABCbwV/j3emBkOLc/tnRBMST/wX
	 Ucmf88AHMmJXg8Fx3cVdjNKazCjdfYAcswU7ewa6f+etX6lWKTraA4w5QvVsSVvHVy
	 qqBnP5e3zBg3VO89MQCrRgKJTkUnYfBPZpHTlv5xJdL/VqosvlvZiDaulQEPoTC3gu
	 EPaUK+bD6Ou1w==
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
Subject: [PATCH 3/6] PCI: dwc: endpoint: Add support for BAR type BAR_RESIZABLE
Date: Tue,  7 Jan 2025 19:14:53 +0100
Message-ID: <20250107181450.3182430-11-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107181450.3182430-8-cassel@kernel.org>
References: <20250107181450.3182430-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9696; i=cassel@kernel.org; h=from:subject; bh=v3Kwhm0BhDUuD1HxjafB0VtsUe6IRB51dWNCDvdZGWQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJr8xX0ntfnB1gKX/+Rw2r0dmKgkqd/gY72pfRLnQ+DT 16fsftWRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYi58XwVyzspviaZywKuZfD Z/3f7XfX8J/G17QJfHkb5/0oLFITyWL472icYvN0IUPUnLCWlq/9fHWXj07787x8yY7ba1pab3x Zxg8A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

The DWC databook specifies three different BARn_SIZING_SCHEME_N
- Fixed Mask (0)
- Programmable Mask (1)
- Resizable BAR (2)

Each of these sizing schemes have different instructions for how to
initialize the BAR.

The DWC driver currently does not support resizable BARs.

Instead, in order to somewhat support resizable BARs, the DWC EP driver
currently has an ugly hack that force sets a resizable BAR to 1 MB, if
such a BAR is detected.

Additionally, this hack only works if the DWC glue driver also has lied
in their EPC features, and claimed that the resizable BAR is a 1 MB fixed
size BAR.

This is unintuitive (as you somehow need to know that you need to lie in
your EPC features), but other than that it is overly restrictive, since a
resizable BAR is capable of supporting sizes different than 1 MB.

Add proper support for resizable BARs in the DWC EP driver.

Note that the pci_epc_set_bar() API takes a struct pci_epf_bar which tells
the EPC driver how it wants to configure the BAR.

struct pci_epf_bar only has a single size struct member.

This means that an EPC driver will only be able to set a single supported
size. This is perfectly fine, as we do not need the complexity of allowing
a host to change the size of the BAR. If someone ever wants to support
resizing a resizable BAR, the pci_epc_set_bar() API can be extended in the
future.

With these changes, the DWC EP driver will be able to support resizable
BARs (we intentionally only support a single supported resizable BAR size).
This means that an EPC driver does not need to lie in EPC features, and an
EPF driver will be able to set an arbitrary size (not be forced to a 1 MB
size), just like BAR_PROGRAMMABLE.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 192 ++++++++++++++++--
 1 file changed, 177 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 6b494781da42..60380d704397 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -223,6 +223,138 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	ep->bar_to_atu[bar] = 0;
 }
 
+static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
+						enum pci_barno bar)
+{
+	u32 reg, bar_index;
+	unsigned int offset, nbars;
+	int i;
+
+	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
+	if (!offset)
+		return offset;
+
+	reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+	nbars = (reg & PCI_REBAR_CTRL_NBAR_MASK) >> PCI_REBAR_CTRL_NBAR_SHIFT;
+
+	for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
+		reg = dw_pcie_readl_dbi(pci, offset + PCI_REBAR_CTRL);
+		bar_index = reg & PCI_REBAR_CTRL_BAR_IDX;
+		if (bar_index == bar)
+			return offset;
+	}
+
+	return 0;
+}
+
+static u32 dw_pcie_ep_bar_size_to_rebar_cap(size_t size)
+{
+	u32 val;
+
+	/*
+	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
+	 * thus disallow a requested BAR size smaller than 1 MB.
+	 * Disallow a requested BAR size larger than 128 TB.
+	 */
+	if (size < SZ_1M || size > (SZ_128G * 1024))
+		return 0;
+
+	val = ilog2(size);
+	val -= 20;
+
+	/* Sizes in REBAR_CAP start at BIT(4). */
+	return BIT(val + 4);
+}
+
+static int dw_pcie_ep_set_bar_resizable(struct dw_pcie_ep *ep, u8 func_no,
+					struct pci_epf_bar *epf_bar)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	size_t size = epf_bar->size;
+	int flags = epf_bar->flags;
+	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	unsigned int rebar_offset;
+	u32 rebar_cap, rebar_ctrl;
+
+	rebar_offset = dw_pcie_ep_get_rebar_offset(pci, bar);
+	if (!rebar_offset)
+		return -EINVAL;
+
+	rebar_cap = dw_pcie_ep_bar_size_to_rebar_cap(size);
+	if (!rebar_cap)
+		return -EINVAL;
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	/*
+	 * You should not write a BAR mask for a resizable BAR. The BAR mask
+	 * is automatically derived by the controller every time the "selected
+	 * size" bits are updated, see "Figure 3-26 Resizable BAR Example for
+	 * 32-bit Memory BAR0" in DWC EP databook 5.96a. We simply need to write
+	 * BIT(0) to set the BAR enable bit.
+	 */
+	dw_pcie_ep_writel_dbi2(ep, func_no, reg, BIT(0));
+	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
+
+	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, 0);
+		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
+	}
+
+	/*
+	 * Bits 31:0 in PCI_REBAR_CAP define "supported sizes" bits for sizes
+	 * 1 MB to 128 TB. Bits 31:16 in PCI_REBAR_CTRL define "supported sizes"
+	 * bits for sizes 256 TB to 8 EB. Disallow sizes 256 TB to 8 EB.
+	 */
+	rebar_ctrl = dw_pcie_readl_dbi(pci, rebar_offset + PCI_REBAR_CTRL);
+	rebar_ctrl &= ~GENMASK(31, 16);
+	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CTRL, rebar_ctrl);
+
+	/*
+	 * The "selected size" (bits 13:8) in PCI_REBAR_CTRL are automatically
+	 * updated when writing PCI_REBAR_CAP, see "Figure 3-26 Resizable BAR
+	 * Example for 32-bit Memory BAR0" in DWC EP databook 5.96a.
+	 */
+	dw_pcie_writel_dbi(pci, rebar_offset + PCI_REBAR_CAP, rebar_cap);
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
+static int dw_pcie_ep_set_bar_programmable(struct dw_pcie_ep *ep, u8 func_no,
+					   struct pci_epf_bar *epf_bar)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	size_t size = epf_bar->size;
+	int flags = epf_bar->flags;
+	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+
+	dw_pcie_dbi_ro_wr_en(pci);
+
+	dw_pcie_ep_writel_dbi2(ep, func_no, reg, lower_32_bits(size - 1));
+	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
+
+	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
+		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, upper_32_bits(size - 1));
+		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
+	}
+
+	dw_pcie_dbi_ro_wr_dis(pci);
+
+	return 0;
+}
+
+static enum pci_epc_bar_type dw_pcie_ep_get_bar_type(struct dw_pcie_ep *ep,
+						     enum pci_barno bar)
+{
+	const struct pci_epc_features *epc_features = ep->ops->get_features(ep);
+
+	return epc_features->bar[bar].type;
+}
+
 static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			      struct pci_epf_bar *epf_bar)
 {
@@ -230,9 +362,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
 	size_t size = epf_bar->size;
+	enum pci_epc_bar_type bar_type;
 	int flags = epf_bar->flags;
 	int ret, type;
-	u32 reg;
 
 	/*
 	 * DWC does not allow BAR pairs to overlap, e.g. you cannot combine BARs
@@ -264,19 +396,30 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		goto config_atu;
 	}
 
-	reg = PCI_BASE_ADDRESS_0 + (4 * bar);
-
-	dw_pcie_dbi_ro_wr_en(pci);
-
-	dw_pcie_ep_writel_dbi2(ep, func_no, reg, lower_32_bits(size - 1));
-	dw_pcie_ep_writel_dbi(ep, func_no, reg, flags);
-
-	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
-		dw_pcie_ep_writel_dbi2(ep, func_no, reg + 4, upper_32_bits(size - 1));
-		dw_pcie_ep_writel_dbi(ep, func_no, reg + 4, 0);
+	bar_type = dw_pcie_ep_get_bar_type(ep, bar);
+	switch (bar_type) {
+	case BAR_FIXED:
+		/*
+		 * There is no need to write a BAR mask for a fixed BAR (except
+		 * to write 1 to the LSB of the BAR mask register, to enable the
+		 * BAR). Write the BAR mask regardless. (The fixed bits in the
+		 * BAR mask register will be read-only anyway.)
+		 */
+		fallthrough;
+	case BAR_PROGRAMMABLE:
+		ret = dw_pcie_ep_set_bar_programmable(ep, func_no, epf_bar);
+		break;
+	case BAR_RESIZABLE:
+		ret = dw_pcie_ep_set_bar_resizable(ep, func_no, epf_bar);
+		break;
+	default:
+		ret = -EINVAL;
+		dev_err(pci->dev, "Invalid BAR type\n");
+		break;
 	}
 
-	dw_pcie_dbi_ro_wr_dis(pci);
+	if (ret)
+		return ret;
 
 config_atu:
 	if (!(flags & PCI_BASE_ADDRESS_SPACE))
@@ -710,9 +853,10 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_deinit);
 
 static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 {
+	struct dw_pcie_ep *ep = &pci->ep;
 	unsigned int offset;
 	unsigned int nbars;
-	u32 reg, i;
+	u32 reg, i, val;
 
 	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
 
@@ -727,9 +871,27 @@ static void dw_pcie_ep_init_non_sticky_registers(struct dw_pcie *pci)
 		 * PCIe r6.0, sec 7.8.6.2 require us to support at least one
 		 * size in the range from 1 MB to 512 GB. Advertise support
 		 * for 1 MB BAR size only.
+		 *
+		 * For a BAR that has been configured via dw_pcie_ep_set_bar(),
+		 * advertise support for only that size instead.
 		 */
-		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL)
-			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, BIT(4));
+		for (i = 0; i < nbars; i++, offset += PCI_REBAR_CTRL) {
+			/*
+			 * While the RESBAR_CAP_REG_* fields are sticky, the
+			 * RESBAR_CTRL_REG_BAR_SIZE field is non-sticky (it is
+			 * sticky in certain versions of DWC PCIe, but not all).
+			 *
+			 * RESBAR_CTRL_REG_BAR_SIZE is updated automatically by
+			 * the controller when RESBAR_CAP_REG is written, which
+			 * is why RESBAR_CAP_REG is written here.
+			 */
+			if (ep->epf_bar[i])
+				val = dw_pcie_ep_bar_size_to_rebar_cap(ep->epf_bar[i]->size);
+			else
+				val = BIT(4);
+
+			dw_pcie_writel_dbi(pci, offset + PCI_REBAR_CAP, val);
+		}
 	}
 
 	dw_pcie_setup(pci);
-- 
2.47.1


