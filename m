Return-Path: <linux-pci+bounces-14284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FD499A321
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 14:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B83F9B22E97
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FF71CB311;
	Fri, 11 Oct 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgLI7Kov"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE681217328
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 12:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648081; cv=none; b=WJaEY3oo6MhVQ7/zMDT9NlY9A1IWre8lnbUqskrknJtAr3CqmR96qsG+1ViK1sgjXixzSYV4bjMZRn9olRzSHI84vPD7E6l7uNOyTbBMkfF6+bUEVGKQnS2CbOJqmSQw9n85e6mTc3vsL+ItSKvWpw7GI9adhEwncEgNFWHkAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648081; c=relaxed/simple;
	bh=iNfrJBwwFI7j5pHupmrYIY4mz/G7Ry/1L5wK2FA8xok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD7RxNQisooH25zqLkZyCzR++ncY04qH7U73XjbSXvAB6aQAee1TaSIIHY9WmOcfvYk6HBk0SG4siVJpEjpLCME1QW6LvS6U286nLoG5BL6pj6aQczixMe3YIqB/GMj3N3k7Ydq/q5ylDJgBYVFBBFyL/Ln9u/Bsw5HBekVJ+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgLI7Kov; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C9CC4CED0;
	Fri, 11 Oct 2024 12:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728648081;
	bh=iNfrJBwwFI7j5pHupmrYIY4mz/G7Ry/1L5wK2FA8xok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qgLI7Kovi8eebYQTt4IZQw8f9+84xzVSM0uo/pdYjuS9gDfwzlPgmw/ryg9LdP9MP
	 Q+LvLSM/tgTXrYeDVXQmUFxfVmZBwbjehFwuA8mCVlFBRqsrxVcsWLsaq2q9LnaK5B
	 bq5cYZxhXWOODdBBRovUz4uMPjncdNhbu18ksWA3zfRdPqtd8aifLJf7Tr6BHmPxr6
	 YxxmkDgbxr2m9Bl66QQdu9txwxVuzwqpNNgaS2oBurLjBSMBOCHcd36UpyFdQupCgF
	 +wI1QHXcPgCROhT5iitMLa5VyjNyc6wt211JpGVGWcrxD+vfyFpqqgF4mHl/arVu+n
	 fMFoVqM9FOntg==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jingoo Han <jingoohan1@gmail.com>,
	linux-pci@vger.kernel.org
Cc: Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 1/6] PCI: endpoint: Introduce pci_epc_function_is_valid()
Date: Fri, 11 Oct 2024 21:01:10 +0900
Message-ID: <20241011120115.89756-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011120115.89756-1-dlemoal@kernel.org>
References: <20241011120115.89756-1-dlemoal@kernel.org>
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
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 79 +++++++++++------------------
 1 file changed, 31 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 17f007109255..b854f1bab26f 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -128,6 +128,18 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 }
 EXPORT_SYMBOL_GPL(pci_epc_get_next_free_bar);
 
+static bool pci_epc_function_is_valid(struct pci_epc *epc,
+				      u8 func_no, u8 vfunc_no)
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
@@ -145,10 +157,7 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
 {
 	const struct pci_epc_features *epc_features;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return NULL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return NULL;
 
 	if (!epc->ops->get_features)
@@ -218,10 +227,7 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return -EINVAL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
 	if (!epc->ops->raise_irq)
@@ -262,10 +268,7 @@ int pci_epc_map_msi_irq(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc))
-		return -EINVAL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
 	if (!epc->ops->map_msi_irq)
@@ -293,10 +296,7 @@ int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	int interrupt;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return 0;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return 0;
 
 	if (!epc->ops->get_msi)
@@ -329,11 +329,10 @@ int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 interrupts)
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
@@ -361,10 +360,7 @@ int pci_epc_get_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 {
 	int interrupt;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return 0;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return 0;
 
 	if (!epc->ops->get_msix)
@@ -397,11 +393,10 @@ int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
@@ -428,10 +423,7 @@ EXPORT_SYMBOL_GPL(pci_epc_set_msix);
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
@@ -459,10 +451,7 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 {
 	int ret;
 
-	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
-		return -EINVAL;
-
-	if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
+	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
 		return -EINVAL;
 
 	if (!epc->ops->map_addr)
@@ -489,12 +478,11 @@ EXPORT_SYMBOL_GPL(pci_epc_map_addr);
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
@@ -521,18 +509,16 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
 
@@ -561,10 +547,7 @@ int pci_epc_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
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
2.47.0


