Return-Path: <linux-pci+bounces-16750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5BE9C8855
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD99D1F2162C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 11:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E6D1F6688;
	Thu, 14 Nov 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO1Lh1jA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBCF1DA113
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582223; cv=none; b=ad3AuL7tRbphRPtw7AU2CvTExsNjnHGFEZFYW4tFdW6ueygmp/H1KXB3whBH5hNTfYasirVGZsuoDxwIEVM4XKNTdEXYemLT94vzJxNswhRJumTROYCXQukVgFLCj/P6OcBT5txtV6kSm1Lp0hSGJ9gS005l2pf6YMytUaqW5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582223; c=relaxed/simple;
	bh=MATHqujhnAZlTONcB8NdFoRympzQ0lwOsgTO+x9Od04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGjwOJ3ZrRlgibPt7cotlsr0Yx96u1HC1iZhOafOcHVjZQAUIjs9yVRaXkcRBl+JWNu/3X1rf7wvlXxEqNogmq/ZCV/9bF/GGsSCVPV/dHFvlflfx8Fff2z9VuuhKpl7XzpBno63kbAGkG47c7gEtJTFsqC029ET4kvxIHYIYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO1Lh1jA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B20C4CED4;
	Thu, 14 Nov 2024 11:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731582223;
	bh=MATHqujhnAZlTONcB8NdFoRympzQ0lwOsgTO+x9Od04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YO1Lh1jAp3NUpX3juakPpSvyyhiKzNshrZ0/M+zE1RQrdui7Wm36NM8+NL9ujNYPk
	 v2ybU+SYo/CL/oS/n8frVqZQL/jlV3ov6yGksI19SGFojaj8W25n5nyhm0oEmCRc2a
	 q67vUWZ0EgxyJ7XcsgsY6/mKNRToe/KwUyFQxCnKpj3LEc7ZkVeTd1ZTJ+OnLVObWD
	 8gfmsadL+jJ7HvgzzLXBp2USAMI1HwCyBvnKcY2jD89m0d5EHV+zcu2E2x9p5qqMKx
	 1FFe2L6gYPcDEm2KSkKVyKcX1KWkqGz3Cv5LML22fdIJZ+xVD+stnzXnAzKspAuMAh
	 FhZLAwTd8R4yg==
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
Subject: [PATCH 2/3] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
Date: Thu, 14 Nov 2024 12:03:28 +0100
Message-ID: <20241114110326.1891331-7-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114110326.1891331-5-cassel@kernel.org>
References: <20241114110326.1891331-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=cassel@kernel.org; h=from:subject; bh=MATHqujhnAZlTONcB8NdFoRympzQ0lwOsgTO+x9Od04=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJNb/xb8abOZfKz+5NKbtUxKn0vkNnySPOZ3We7J25Xc tTNXjQYdpSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAifeqMDAetMuvuxR05J8Kz ytI9g/f89ZV1leLTEx/UmD6xWR7D9Yfhv9Mt/qjmNSv3f/4uM51NXe3bkvKLVb9mPDrEvfzAkZb VHCwA
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

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index bed7c7d1fe3c3..c69c133701c92 100644
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
2.47.0


