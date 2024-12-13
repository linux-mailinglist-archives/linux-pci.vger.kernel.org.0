Return-Path: <linux-pci+bounces-18382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4059F0F33
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7137A1647D8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC9D1E1A28;
	Fri, 13 Dec 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtX4T4U9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83BE1E0E10
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100422; cv=none; b=CMdX4Bw8xZ9jL33T3MCHzmySPwcO84WDTlpMKTTTTyQo+jA3vZJNAxT9cjmQ0QImzJA9TeKgyMXs+A7RHv0tqUd7Hx7+xtW3+nG064PBVA0ifSqiNKvhWgkJAUT/lgjSzX1uZgx04ohvbDQEJ+BpTkH+ueybFb0huqhfhN5lj3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100422; c=relaxed/simple;
	bh=zv0UrLQJcLbh4LKqOpzblK7DRJPEARLfSBhrVvqoUII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bFH/uCbMgFMOvnS9fn0/Ew21dITPXdkm3ZNCKyq00+8FBOYbGFI4gntx4Ye7MTPLdhZpk/5NJpAN8kazzu0CkD5UQiUkQvFvWho64IO6oyfPckK968yL66+sabXl9JeymPtGUFCznug3WToXaG9ul9jT+rZJ8q4xA8Om9r8x6v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtX4T4U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FE2C4CED2;
	Fri, 13 Dec 2024 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100422;
	bh=zv0UrLQJcLbh4LKqOpzblK7DRJPEARLfSBhrVvqoUII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JtX4T4U9i7KTutiv5gqdVh38VOkCLV60y8NGgJFcIflkazTWxoSS7QaoHUQuHSIHT
	 ZYTwKTLjBFz32VERKSSXhLkML9DP2XBez8fxRUVgkm/oIrSGTVBEtI2zAYtH7CztCL
	 fnPJF2KiDqL8H7OIq6wfWsXwtOAkaCwXluAs/Yq1BQkfLIr4hJcS5/OkfuJTE/qEZd
	 25z3CJptZhgCcffdhEPmgyxvzUuPriDt9qhwX1AX9JwGXhlx7fPVryrngAHy0GWK+0
	 6foypsNoDMWQ9sAvzhPA6BVKaRBBGi8nwIOvoaN5OX12IBhgq0+fMzLtSl18TZpy98
	 ET0xOlg7RrtFQ==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v6 5/6] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
Date: Fri, 13 Dec 2024 15:33:06 +0100
Message-ID: <20241213143301.4158431-13-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213143301.4158431-8-cassel@kernel.org>
References: <20241213143301.4158431-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=cassel@kernel.org; h=from:subject; bh=zv0UrLQJcLbh4LKqOpzblK7DRJPEARLfSBhrVvqoUII=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJjXJfsjVqe/21hTkbBZQE7s/sb1125a1BzyL9J4fMu6 1MzjGx8O0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjARtk2MDB8/lDDKR/+z05a6 r521+UzpefV9qYZ7TTId1intS7JZasnI8KpNgqFfPZ03165RZx/Tq2sBecm5ciVRz/V/H7him8b PBAA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

A BAR of type BAR_FIXED has a fixed BAR size (the size cannot be changed).

When using pci_epf_alloc_space() to allocate backing memory for a BAR,
pci_epf_alloc_space() will always set the size to the fixed BAR size if
the BAR type is BAR_FIXED (and will give an error if you the requested size
is larger than the fixed BAR size).

However, some drivers might not call pci_epf_alloc_space() before calling
pci_epc_set_bar(), so add a check in pci_epc_set_bar() to ensure that an
EPF driver cannot set a size different from the fixed BAR size, if the BAR
type is BAR_FIXED.

The pci_epc_function_is_valid() check is removed because this check is now
done by pci_epc_get_features().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bed7c7d1fe3c..c69c133701c9 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -609,10 +609,17 @@ EXPORT_SYMBOL_GPL(pci_epc_clear_bar);
 int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		    struct pci_epf_bar *epf_bar)
 {
-	int ret;
+	const struct pci_epc_features *epc_features;
+	enum pci_barno bar = epf_bar->barno;
 	int flags = epf_bar->flags;
+	int ret;
 
-	if (!pci_epc_function_is_valid(epc, func_no, vfunc_no))
+	epc_features = pci_epc_get_features(epc, func_no, vfunc_no);
+	if (!epc_features)
+		return -EINVAL;
+
+	if (epc_features->bar[bar].type == BAR_FIXED &&
+	    (epc_features->bar[bar].fixed_size != epf_bar->size))
 		return -EINVAL;
 
 	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
-- 
2.47.1


