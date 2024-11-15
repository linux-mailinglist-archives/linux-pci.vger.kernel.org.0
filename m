Return-Path: <linux-pci+bounces-16839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C95479CDAD9
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40610B21678
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532D718C018;
	Fri, 15 Nov 2024 08:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmg3V4tH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276941885BF
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660494; cv=none; b=ijGTs6XNyVTUROJGby/J+1d/SJg3t3SVZRIg8q0HnAKS2NgrixQS8FlFsyzyWR+QQV8qOmjrNPaXyXRWfREzJ9ZtLd4IXfqRaT4xmzRxCz1PLTefXHVwqsK3rJwFYrlhCDowL9vM2wHFFvaAbIP/+M1UZ+voxIo/zpv2T2T30mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660494; c=relaxed/simple;
	bh=SlN/xkv2h1nTy/SSDUnI5IQ0q1BJajoSiTu2IIeDb/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4kJ9jaSfGQTy8no3ZE/dAF+0TOxnKN4dPHXGeUUJ1zmCkUwjnEYiwdHjVWv16Ap0qY+FeZF/guuVBoGyaSXCZLWKA9Y2umDcyuen1L8xmNWQIT5AN7oRrvz0yG2J1qh2+tE2nXGogp6w+uzGHhNVQC5cohgM1xYoBqkZmJkSTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmg3V4tH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8D9C4CECF;
	Fri, 15 Nov 2024 08:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731660493;
	bh=SlN/xkv2h1nTy/SSDUnI5IQ0q1BJajoSiTu2IIeDb/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cmg3V4tHc/MM7B6k6bqYBk+8iCLggOOhRTETWGFYI/FCUHu6hNwICxNqDACRMccZk
	 SRag8OOMtQ8sxKL8nF6VURpO4/QUwkyAQJkTHM7f282TjepJ7QgywH5o101G/rDqtX
	 ZvZuf3VIQmGioF3ztQnT/mhdq4QoiR93cZiyjJPcQnax85IAdTkbEviHn3+V0j0Geg
	 HJGsHIszGhHKAyRjTKVoYjtWkcSBLFLn9rCPeBLm5HG6h0wWiXLZtJ84xHQPaZBl58
	 8L9oL+/b4Il/27zB3lyU8iK+ndX9Cb6OLN0MrhtCAFACbEy4OVlQJBzO3wVJjB3lyq
	 43UIriOaNl0Cg==
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
Subject: [PATCH v2 2/3] PCI: endpoint: Add size check for fixed size BARs in pci_epc_set_bar()
Date: Fri, 15 Nov 2024 09:47:51 +0100
Message-ID: <20241115084749.1915915-7-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115084749.1915915-5-cassel@kernel.org>
References: <20241115084749.1915915-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1826; i=cassel@kernel.org; h=from:subject; bh=SlN/xkv2h1nTy/SSDUnI5IQ0q1BJajoSiTu2IIeDb/0=; b=kA0DAAoWyWQxo5nGTXIByyZiAGc3CrqhPVIdOid5GHu/GV/jqvrdHKpCjmasbS3a1Uu/s76wz oh1BAAWCgAdFiEETfhEv3OLR5THIdw8yWQxo5nGTXIFAmc3CroACgkQyWQxo5nGTXJHNQEAu20a en/pfGWCTId9Nr9Ftb4bruLKDJWVawO07skWjesBAJg9PAXbG/ZYxuWJMOVx5D2sCnMTXWtRJzc Jr2UCx/YO
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


