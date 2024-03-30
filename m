Return-Path: <linux-pci+bounces-5433-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D26F89293C
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 05:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BB3F1C2127B
	for <lists+linux-pci@lfdr.de>; Sat, 30 Mar 2024 04:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53409B662;
	Sat, 30 Mar 2024 04:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICJPjRGg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD478F56;
	Sat, 30 Mar 2024 04:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711772377; cv=none; b=bTME2DkVI31SaHbN4VQIaUcFgqGbsqIqETyVwWJe7+QJGebWm/iLTNgn3VPHOTXU9Pc/khA7MpLtXYWNw+mC7ke+hocjLVjmxxbcEF0n/IIxQf4Y5dWSzoOqp3Yq/bI4LtAemofe2/3cposzaRjRlApURvJbeQHSpQ3nytmc9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711772377; c=relaxed/simple;
	bh=PWaeozMIGpKKMKSCRnXNKHlQUzaWsxtzM/PgCIXS/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUtuK4D5JmmnItUCUrrFOrLwBrPjVEVQM6WyRpigwQ47EItJyV2k0czYSfESQ41QmGjnF9Xhw5J2RAhlxsP+rnezBw+bdPLUVeMr/QNNmdsS1K3FR/qnceDbNKJGuoF9aCqWzJqOpKPUNopCEDQF2u6XWaNnbjNUkT4ohfW9HyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICJPjRGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984A6C433B1;
	Sat, 30 Mar 2024 04:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711772375;
	bh=PWaeozMIGpKKMKSCRnXNKHlQUzaWsxtzM/PgCIXS/Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ICJPjRGgaGJCzWDRXLGghUcGHdRNC78NtVvRihRfIzF+VK1Uoax+3EXyUZbWQCP+5
	 CeoGWaxcoMB94HX2JhQLx+DxdL2NBLBw8wL4RCgSKKknSLHQZT7sFRoWTrHFVV9340
	 zn7o4xAFJtY2IkJBJ7xmHgKnoflWlNv2PF3mPmXXaVZD8jWvkygQllDoJrYBUFDaZ1
	 hl46JZ0BjaAIg3L7+kZo8UzGTfWXuved3q6vp+D8jAO31Gz7UvhMAKo01Ubmog/WD4
	 Q3d5enzWlXuBYRwO3noz7aV4DU3Xs6NmJiZIgoFRtaax0ZtDDIg1xoNMUc8RBi8NZD
	 ZzEDG9aQf5I5g==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v2 01/18] PCI: endpoint: Introduce pci_epc_function_is_valid()
Date: Sat, 30 Mar 2024 13:19:11 +0900
Message-ID: <20240330041928.1555578-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240330041928.1555578-1-dlemoal@kernel.org>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the epc core helper function pci_epc_function_is_valid() to
verify that an epc pointer, a physical function number and a virtual
function number are all valid. This avoids repeating the code pattern:

if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
	return err;

if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
	return err;

in many functions of the endpoint controller core code.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 79 +++++++++++------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index da3fc0795b0b..754afd115bbd 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -126,6 +126,18 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_next_free_bar);
 
+static inline bool pci_epc_function_is_valid(struct pci_epc *epc,
+					     u8 func_no, u8 vfunc_no)
+{
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return false;
+
+	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+		return false;
+
+	return true;
+}
+
 /**
  * pci_epc_get_features() - get the features supported by EPC
  * @epc: the features supported by *this* EPC device will be returned
@@ -143,10 +155,7 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 {
 	const struct pci_epc_features *epc_features;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return NULL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return NULL;
 
 	if (!epc->ops->get_features)
@@ -216,10 +225,7 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return -EINVAL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
 	if (!epc->ops->raise_irq)
@@ -260,10 +266,7 @@ int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc))
-		return -EINVAL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
 	if (!epc->ops->map_msi_irq)
@@ -291,10 +294,7 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	int interrupt;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return 0;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return 0;
 
 	if (!epc->ops->get_msi)
@@ -327,11 +327,10 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
 	int ret;
 	u8 encode_int;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
-	    interrupts < 1 || interrupts > 32)
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (interrupts < 1 || interrupts > 32)
 		return -EINVAL;
 
 	if (!epc->ops->set_msi)
@@ -359,10 +358,7 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	int interrupt;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return 0;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return 0;
 
 	if (!epc->ops->get_msix)
@@ -395,11 +391,10 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
-	    interrupts < 1 || interrupts > 2048)
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (interrupts < 1 || interrupts > 2048)
 		return -EINVAL;
 
 	if (!epc->ops->set_msix)
@@ -426,10 +421,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
 void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 			phys_addr_t phys_addr)
 {
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return;
 
 	if (!epc->ops->unmap_addr)
@@ -457,10 +449,7 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return -EINVAL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
 	if (!epc->ops->map_addr)
@@ -487,12 +476,11 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
 void pci_epc_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		       struct pci_epf_bar *epf_bar)
 {
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
-	    (epf_bar->barno == BAR_5 &&
-	     epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return;
 
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (epf_bar->barno == BAR_5 &&
+	    epf_bar->flags & PCI_BASE_ADDRESS_MEM_TYPE_64)
 		return;
 
 	if (!epc->ops->clear_bar)
@@ -519,18 +507,16 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	int ret;
 	int flags = epf_bar->flags;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions ||
-	    (epf_bar->barno == BAR_5 &&
-	     flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+		return -EINVAL;
+
+	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
 	    (flags & PCI_BASE_ADDRESS_SPACE_IO &&
 	     flags & PCI_BASE_ADDRESS_IO_MASK) ||
 	    (upper_32_bits(epf_bar->size) &&
 	     !(flags & PCI_BASE_ADDRESS_MEM_TYPE_64)))
 		return -EINVAL;
 
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
-		return -EINVAL;
-
 	if (!epc->ops->set_bar)
 		return 0;
 
@@ -559,10 +545,7 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return -EINVAL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
 	/* Only Virtual Function #1 has deviceID */
-- 
2.44.0


