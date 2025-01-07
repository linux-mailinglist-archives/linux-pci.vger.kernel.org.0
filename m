Return-Path: <linux-pci+bounces-19459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E33A04910
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 19:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F65C1886CD0
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 18:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7138F1E0DE2;
	Tue,  7 Jan 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9epLKEB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420911DF25C
	for <linux-pci@vger.kernel.org>; Tue,  7 Jan 2025 18:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736273741; cv=none; b=RgFNyS32r2XK59S76yzzNE2sU4eRzWkKpqM0nsPO/qNvpxcunjQs9/UnQyONxhhhbiO2o1+aOWASb02BX4TNfRksp8U1HBdOrxgQaU+z1VwtsU0ztJCvRzJINMEMCrUYmDlyYhiM6tpwNVrDkIMZU1MvZzzNLRt8Ham/3PXm//g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736273741; c=relaxed/simple;
	bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5lJfamczqeTxO3UrvivzDXe8VadQv99TCR2viUBeIWhc3zw3dom5Za43qAy9lQqtBylWdrT07Pi7ezyJxlxH162BAGc1T9cC3XSEr3R3QsM+3CzWtLUVrlpad3Xp3HywtC/rMbfVwj4Yd60YBo5njUFPLRP2SMEpXOGyuX/Dsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9epLKEB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84EC5C4CED6;
	Tue,  7 Jan 2025 18:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736273740;
	bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9epLKEB4Ua0wOU1NBLxEUWtamnLKpupf0LIemEnjpkyMiMSs4md8jN2hzrdUEsbN
	 k7wT3PzAW00qFQEKXJBExWjwVdPc0ONgqoMhAmZPsduIr3eHh8Y7hULBQP0nb4b1z7
	 DJ+2SR0O6yybFeWckPVGq4J+gxkwwtNJaM4xH2tIUdIkw+gfcA46hKYlfWUGpSPRVB
	 ULNSB6pyx17N1rafrODipXv4cL8/Wu/jXDnxfiCt8+Un5HpOVBGbxX8kCfbXzAaGrb
	 mOzusBs/OHIwt15jDMr563IMjPFYQrbYxlPr8SNZRzvZRO9XTP/SKg2KWBMDP0N7K3
	 6mwVmt16xE4aA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 6/6] PCI: dw-rockchip: Describe resizable BARs as resizable BARs
Date: Tue,  7 Jan 2025 19:14:56 +0100
Message-ID: <20250107181450.3182430-14-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107181450.3182430-8-cassel@kernel.org>
References: <20250107181450.3182430-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=cassel@kernel.org; h=from:subject; bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJr8xWP/59YxzOtaeNWwVce1/qe8drIX/Pk+DdJlOfuT /ebDR2LO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRz2YM/yOVrx/Z1DTJ9Nd8 9VmOh55c8LWziInhl2mZVl3z4aCQazgjw9aC19+viiXdnalpl/cvY9uM3NVWYd/OLAmaVynj6vd FgBMA
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


