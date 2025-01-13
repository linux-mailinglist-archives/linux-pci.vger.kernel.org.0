Return-Path: <linux-pci+bounces-19661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C95A0B493
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 11:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F32F71887D84
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA14187554;
	Mon, 13 Jan 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k46+ZMIP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064BD235C07
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736764092; cv=none; b=i1BcpRB8+caDhDx/PO5kyGmxL+YJAGtz2RPRKKcJEg2mHrU16JzJ+V2i9sT8t3PCk7obicwFKXDTH1LOv78D0UJDxibADJXRtT1PY4MkAE2cdzG/Mrep57oi0DbeDOq5XaUusSP3viJl//ITeOC5EvPqAtn7llbes8c5GdFB/Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736764092; c=relaxed/simple;
	bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+UqxDSfW6rGRPVn9ouiKYp2NMfaY/VcuO012VZULTx0oI4qnvo4erBHyeXl9wi8rdlQfu08N2EyfPgopheW6eTwXRRG5EHscNDjwSL3Wy9i1V1kphv4nK0j3aWBE18BgXYNrKX9NMtas85VNNcLx7MedyD6q+vNgoq7AKIcZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k46+ZMIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEADDC4CED6;
	Mon, 13 Jan 2025 10:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736764091;
	bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k46+ZMIP6SHUP2Fkk1BFOsyeCxNX7n2Tbjur95ZFq5q2DbYzf7Sq7EDdqsA8gxEw5
	 570kJOPmVAKjtq8E9Y0dQK+N6RUIYBoAPh1pf8BclgS2AoQSKlvcj6V+7UmQC7mIvC
	 d5tqvfmtzqkpnwC1+bmRQXvrRUAgd99KDExOArPK3jp+uz2O4kmquwgbeLJQpflqNN
	 lAaxMVXiDX/VqfFItKZm0K1OR1kNR9F6xwBYmpfQKxM9JI+JctSA9RMh/y5e2JNAqS
	 g/K7zuvMLn60B2XgLZ2+GjAoNBJ7fDdNtAb9EFajN/cChTAQ2P4+8MBXv3SsExmI/6
	 VH9T+9u0N03Cg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 6/6] PCI: dw-rockchip: Describe resizable BARs as resizable BARs
Date: Mon, 13 Jan 2025 11:27:37 +0100
Message-ID: <20250113102730.1700963-14-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113102730.1700963-8-cassel@kernel.org>
References: <20250113102730.1700963-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=cassel@kernel.org; h=from:subject; bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJbXs08/n9iHc+0po1bBV95XOt7xmsjf82T498kUZ67P 91vNnQs7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBE7GMY/kpNM51z/fnWH8tX b7Xh0/42q2HXBuZbPxdmfDMJZlx2vlGE4X9Z2e8H766k1KS8PhzEVXg+4ctaAwNWl2L7hMSNJ9o X/eEBAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Looking at "11.4.4.29 USP_PCIE_RESBAR Registers Summary" in the rk3588 TRM,
we can see that none of the BARs are Fixed BARs, but actually Resizable
BARs.

I couldn't find any reference in the rk3568 TRM, but looking at the
downstream PCIe endpoint driver, rk3568 and rk3588 are treated as the same,
so the BARs on rk3568 must also be Resizable BARs.

Now when we actually have support for Resizable BARs, let's configure
these BARs as such.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index ce4b511bff9b..6a307a961756 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -273,12 +273,12 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3568 = {
 	.msi_capable = true,
 	.msix_capable = true,
 	.align = SZ_64K,
-	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_4] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
 /*
@@ -293,12 +293,12 @@ static const struct pci_epc_features rockchip_pcie_epc_features_rk3588 = {
 	.msi_capable = true,
 	.msix_capable = true,
 	.align = SZ_64K,
-	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_1] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
-	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_0] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_1] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
+	.bar[BAR_3] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_4] = { .type = BAR_RESERVED, },
-	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 };
 
 static const struct pci_epc_features *
-- 
2.47.1


