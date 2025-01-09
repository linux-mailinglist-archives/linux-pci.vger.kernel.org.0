Return-Path: <linux-pci+bounces-19597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF192A070EB
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69936188A902
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841A8215071;
	Thu,  9 Jan 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X18kmc8A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6AC215072
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413646; cv=none; b=aJhXnhrv1MSS41JPrhc9pyr6IrT/tSV9ygUeIpUTcW2uBgCGjoCTkJSyjqlm2xnUieNCcfQ6lEL9RZTxL4ZVNGqD+z6naoKyZm7yMguWGikLl/ygJuAjkMLwSOe/Me3Ym2gB3JsOtiqBzqmpNMf80YgyqeHFjJF6qWS5tz5YqFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413646; c=relaxed/simple;
	bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1801Ov2HtQF2oeB30ImJXBT7g2jUciAyS2Scmum77FcZhvHvoKfRrdCzJGVOx6vHP727C/yW0BlhQl/xoVNIGpAbcVqi1hk7UD+KGSt2FsXJ6V28wMuduipzGQC9MRMAo04Thol0jmK4Za4BKl9s4zt9P5JVNAB30zTY7fMCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X18kmc8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F90C4CED2;
	Thu,  9 Jan 2025 09:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736413646;
	bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X18kmc8A6vFgxxnB7m37j4OZRb4cTcp4oI70EwmaR/7qGXk/yLNUPPQpoiDAziJnv
	 q2Ntlqhpiupa4cr2eGxa46Ji4zoJFL0bLrxBYcsnkq6hYFywMBLrWD9GGXjiqmJpwx
	 kBKAZKp36NWquCvevCnOQkjLRfE86y8UY4WSr44mJqJ03qTHYt4ApDiqjIO7y5z4z+
	 eVgcZ4StE+uGGYLxVum6j9SoP3ou+P6pwIYxY4nv7UmvEC1kJXk6MdzF9sKJmn86oR
	 ITS+GtImU3s2yx9TLAIv0JfjTKThybIf5oDfaNysHrxLFzwz4p7mlyA+El0wcuM75l
	 XBXKhGks0xS5Q==
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
Subject: [PATCH v2 6/6] PCI: dw-rockchip: Describe resizable BARs as resizable BARs
Date: Thu,  9 Jan 2025 10:06:58 +0100
Message-ID: <20250109090652.110905-14-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109090652.110905-8-cassel@kernel.org>
References: <20250109090652.110905-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2520; i=cassel@kernel.org; h=from:subject; bh=YjPRYyKxFWfwBGyFIc8FXbd9BDk5/XxDt0/Kay6MfyM=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLrJ246/n9iHc+0po1bBV95XOt7xmsjf82T498kUZ67P 91vNnQs7ihlYRDjYpAVU2Tx/eGyv7jbfcpxxTs2MHNYmUCGMHBxCsBEvikx/OH15mtycl+6LmPH 5d2xpo5+f3WCVzNdFWYW2n32mnPX/ReMDHs8D19b2zv3/f+sw+yaT60NhMsC7ma/6KgN1a2Qdov N4AQA
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


