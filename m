Return-Path: <linux-pci+bounces-19595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEDEA070E9
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 812E47A064E
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F446215186;
	Thu,  9 Jan 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+CYZ2Hp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32453215172
	for <linux-pci@vger.kernel.org>; Thu,  9 Jan 2025 09:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736413641; cv=none; b=shgkXVbQUPecWH3SSmslhaJruNDa3JzmICPT++r2QVY0sFYGrEOA+RDW6SD8xTWVF6qIemu0S8LEBFO4LKJSAhJd5oJHReIXkXhDNl1cHNXljZ5WOB9YMvECd8yKdTFTAWnaYT5ubCDsqkPq2mKMBGxxj/xjSc+1S6qXa1sLQAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736413641; c=relaxed/simple;
	bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cJVAM9bngGp90uOmfHj8+chty/L8cY2x8xg8lZ1bJeg7pP5ba1P4IQ0X3KW225qdIdESpg0o8mcbP1m9IJ4AwFDX/GkcqvcIRTedtb7WNw4Md8HOd/fcidYAftAUbz4MHqsnFbHcaahZAq65ty0xsNjmKMuWzTIV63spsH+NOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+CYZ2Hp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8243C4CED2;
	Thu,  9 Jan 2025 09:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736413640;
	bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p+CYZ2HpzwuL9iuRFV+jVselwwSqzqWw9d7hi9EKARqvc44d0pkTtm77lfVrNsYdH
	 SpsFX+5LRVGY/f1AVqj7umhg/+wr02txG7TddALCd+CSsvKDcuA2L1LaGQGaZ1tHWz
	 031K/bxdxPdQ7pDjtgBS6prtoL6jS1wC6KNGCy1EkSFWlfmmwKrG3mOL9T/kmkpKtw
	 Rgk/ZkvHKoZic8LeH1uo7UF61Jl7/KWtEq9jIRNk0LmK3zfpTz8qWpiXCJd18Bf+A7
	 Cg7DgvE5wxhvK/YZDCfy+X1B5zEDdqfiC1Fz+KKkcAUpUlBl2X6241/hlmajp2tyYF
	 RmnnHr0WW0oBA==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 4/6] PCI: keystone: Describe resizable BARs as resizable BARs
Date: Thu,  9 Jan 2025 10:06:56 +0100
Message-ID: <20250109090652.110905-12-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109090652.110905-8-cassel@kernel.org>
References: <20250109090652.110905-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286; i=cassel@kernel.org; h=from:subject; bh=dsOF55gCBp2ClK+Wep4E7OIkJHnlYk6Yk3WYdTKco9M=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLrJ2568+TkMpljEbNvz44466Vl/KLw8oqb9oK3JPxPH tS9Yqh3oaOUhUGMi0FWTJHF94fL/uJu9ynHFe/YwMxhZQIZwsDFKQATSWhnZJiymunz309/nOUc WTh2a8y66DFp4pbqaxJ2H3mvvmF48VWVkWGS2cllgUuUVkxetfKCkP+qk2tCu+S0ltRyaui1Tp1 iXMkEAA==
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Looking at "12.2.2.4.15 PCIe Subsystem BAR Configuration" in the
AM65x TRM:
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf

We can see that BAR2 and BAR5 are not Fixed BARs, but actually Resizable
BARs.

Now when we actually have support for Resizable BARs, let's configure
these BARs as such.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 63bd5003da45..fdc610ec7e5e 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -966,10 +966,10 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.msix_capable = true,
 	.bar[BAR_0] = { .type = BAR_RESERVED, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
-	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_2] = { .type = BAR_RESIZABLE, },
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
-	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
+	.bar[BAR_5] = { .type = BAR_RESIZABLE, },
 	.align = SZ_1M,
 };
 
-- 
2.47.1


