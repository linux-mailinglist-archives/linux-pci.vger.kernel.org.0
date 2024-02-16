Return-Path: <linux-pci+bounces-3597-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9C5857DFA
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B11C24E4F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 13:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563552CCB4;
	Fri, 16 Feb 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6gzawSV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EB312BEAE
	for <linux-pci@vger.kernel.org>; Fri, 16 Feb 2024 13:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091158; cv=none; b=udaEgFhfTsZ8CNpv15hGDrdUxZzlF2ilZtxgG3o31Xpek89OKwVY8+1m/3DAawJBZ5GowDGElCTkp+syLN8GZA/hOVTTFuuNZSJm8Wcixp1oxAc63RIh60bXGaIIMl1pAMwSmIfJbHtaWAQ6N481j5T3pKiHEv8I8l9fmZdrfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091158; c=relaxed/simple;
	bh=8Ufu011BmQfgfw0J1ViC6Kig13gGx6HTPL4lnM8zu4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiU+Wr5NMA5SksvwyUbfmG80FEjnqexmlG9zFp5Cn6QDiV9yPjmGxuBNA4lGXgrzDUhy5NS6rYIj7pmry+5zD7eUeR1ZWRj+Sj51zN4Y+GHN9PImnqLOordI3FspckT3ffGCYp5ewKQYP5lPr9IBDWuKBbLLfDH0XenqseNDWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6gzawSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83348C433C7;
	Fri, 16 Feb 2024 13:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708091157;
	bh=8Ufu011BmQfgfw0J1ViC6Kig13gGx6HTPL4lnM8zu4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N6gzawSVcPD3GbCXOj+Wr4ou6fKFOmEbAFk+rplkNpnPpIiWb5iMWjJ5GKpI6Wap2
	 5pGHD5FHaay0Bq1Wrrb3Rdv3Crua9sXXz28jcM7VF13Y0To2EZwF+5bLmT3sTfd7VU
	 cSFQo9z5caiUFj+glK8vNQei4BnAaoAeWkgm361HKWG44aXVIZPnzk9Ib5c5DpSjcC
	 YuzvGibBJW5HtvW+LnwV+iYPH73L+1PfisZkT060Ld2riJTm6EbHo4M+Xs64964wFt
	 GnCxytJZX0PmEHgJSLekHPStlVvTAXY9tnS5kDWQs80s6/HW4/O2KNi7RkmuKpm0KX
	 ZDSRo36C02ONg==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] PCI: endpoint: Drop only_64bit on reserved BARs
Date: Fri, 16 Feb 2024 14:45:15 +0100
Message-ID: <20240216134524.1142149-3-cassel@kernel.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240216134524.1142149-1-cassel@kernel.org>
References: <20240216134524.1142149-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of a reserved BAR is that EPF drivers should not touch
them.

The definition of only_64bit is that the EPF driver must configure this
BAR as 64-bit. (An EPF driver is not allowed to choose if this BAR should
be configured as 32-bit or 64-bit.)

Thus, it does not make sense to put only_64bit of a BAR that EPF drivers
are not allow to touch.

Drop the only_64bit property from hardware descriptions that are of type
reserved BAR.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Kishon Vijay Abraham I <kishon@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-keystone.c     | 2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c | 2 +-
 drivers/pci/endpoint/pci-epc-core.c           | 7 -------
 include/linux/pci-epc.h                       | 5 +++++
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index b2b93b4fa82d..844de4418724 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -924,7 +924,7 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
 	.linkup_notifier = false,
 	.msi_capable = true,
 	.msix_capable = true,
-	.bar[BAR_0] = { .type = BAR_RESERVED, .only_64bit = true, },
+	.bar[BAR_0] = { .type = BAR_RESERVED, },
 	.bar[BAR_1] = { .type = BAR_RESERVED, },
 	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
 	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 265f65fc673f..639bc2e12476 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -415,7 +415,7 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
 		.bar[BAR_1] = { .type = BAR_RESERVED, },
 		.bar[BAR_2] = { .only_64bit = true, },
 		.bar[BAR_3] = { .type = BAR_RESERVED, },
-		.bar[BAR_4] = { .type = BAR_RESERVED, .only_64bit = true, },
+		.bar[BAR_4] = { .type = BAR_RESERVED, },
 		.bar[BAR_5] = { .type = BAR_RESERVED, },
 	},
 };
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 7fe8f4336765..da3fc0795b0b 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -120,13 +120,6 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
 		/* If the BAR is not reserved, return it. */
 		if (epc_features->bar[i].type != BAR_RESERVED)
 			return i;
-
-		/*
-		 * If the BAR is reserved, and marked as 64-bit only, then the
-		 * succeeding BAR is also reserved.
-		 */
-		if (epc_features->bar[i].only_64bit)
-			i++;
 	}
 
 	return NO_BAR;
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 4ccb4f4f3883..cc2f70d061c8 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -164,6 +164,11 @@ enum pci_epc_bar_type {
  *		should be configured as 32-bit or 64-bit, the EPF driver must
  *		configure this BAR as 64-bit. Additionally, the BAR succeeding
  *		this BAR must be set to type BAR_RESERVED.
+ *
+ *		only_64bit should not be set on a BAR of type BAR_RESERVED.
+ *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
+ *		touch, then both BARx and BARx+1 must be set to type
+ *		BAR_RESERVED.)
  */
 struct pci_epc_bar_desc {
 	enum pci_epc_bar_type type;
-- 
2.43.1


