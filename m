Return-Path: <linux-pci+bounces-16749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ECD9C8854
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 12:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDC2282177
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 11:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9EE1F80DF;
	Thu, 14 Nov 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmKUD5ZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51151F77B0
	for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2024 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582221; cv=none; b=osvX4cnlFZc0aFTvix4IElFBHn9K7sHEZ5e2M5VleMfde+X2NjV9hZn0qQyrX4yyKSK+MaZZChvkecwqRx49ODM/D2eD3ndXB69rhQOldNF+xOvlwRxB3A6qsxhZBwKSpnKhubJIM3vEJ5voigLAmxQRkk0dIKx9DqlXbb9SVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582221; c=relaxed/simple;
	bh=oUrd/B6QQtwDFNLlM3M2EW72SiN6g4CCW5sNa5Udfcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGHcOvvKNyXNhL+wwPQpuRtOrEmtsIZsRvAvpSk8BkpwSbQ6ZoXdAtMg7lgmJMWTG76Jr/VjILrHlUFQNKaM8mZmlJc2lW0w6vHfwFKbvfaLWZZhBUHYx3r8JBWuse1tpkPDZiFICPdIiHvmfUyfAQ8soNSSA6pKdBTi0nvz1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmKUD5ZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFE3C4CECD;
	Thu, 14 Nov 2024 11:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731582220;
	bh=oUrd/B6QQtwDFNLlM3M2EW72SiN6g4CCW5sNa5Udfcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nmKUD5ZY2CA4/3a2xfQrXWv9PQ70VJEo4eTdCu2Jjn0XMX1jajQpiZkcAOvaSUfpe
	 KB092FbS40MTXmf8kqV7WBBlIbnV1MvbME+XfmiN/xCfzXf9VIQP7U5LG5FXDWvV/I
	 HRmW4YpYyGiGigLuT1BJsRaOSuyh01PPjgiGBC06jQ00YbrkirxZeczgayp7BxX74j
	 B4Yf1O95o2Uuz8fjrafHQVXKKyXiQHhns4xcps4RcRzUI2YYpZEZFdABqo9keogfvw
	 EqWk9DyEVlAM8dPJ/4h1zop2ORbC03u124gm1ZjjyU9zQMWYiOEX5OF0Wr/RQEtuF5
	 g717QEPX68TMQ==
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Niklas Cassel <cassel@kernel.org>,
	linux-arm-kernel@axis.com,
	linux-pci@vger.kernel.org
Subject: [PATCH 1/3] PCI: artpec6: Implement dw_pcie_ep operation get_features
Date: Thu, 14 Nov 2024 12:03:27 +0100
Message-ID: <20241114110326.1891331-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114110326.1891331-5-cassel@kernel.org>
References: <20241114110326.1891331-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1556; i=cassel@kernel.org; h=from:subject; bh=oUrd/B6QQtwDFNLlM3M2EW72SiN6g4CCW5sNa5Udfcs=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJNb/z7ahjK1/Jr4fcIkR0BhZEh1Yc77k+Xtdo/McFKx PJ4YcusjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk6yVGhgeazqud894vW1+V /m7p41ndkws4wmVb/iWyv1KMYfSSusHwv5zvr+C0K3ZLV3SLtX2U+7P4/+opns8sFJe6+ro9kxC oZAcA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

All non-DWC EPC drivers implement (struct pci_epc *)->ops->get_features().
All DWC EPC drivers implement (struct dw_pcie_ep *)->ops->get_features(),
except for pcie-artpec6.c.

epc_features has been required in pci-epf-test.c since commit 6613bc2301ba
("PCI: endpoint: Fix NULL pointer dereference for ->get_features()").

A follow-up commit will make further use of epc_features in EPC core code.

Implement epc_features in the only EPC driver where it is currently not
implemented.

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index f8e7283dacd47..234c8cbcae3af 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -369,9 +369,22 @@ static int artpec6_pcie_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	return 0;
 }
 
+static const struct pci_epc_features artpec6_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features *
+artpec6_pcie_get_features(struct dw_pcie_ep *ep)
+{
+	return &artpec6_pcie_epc_features;
+}
+
 static const struct dw_pcie_ep_ops pcie_ep_ops = {
 	.init = artpec6_pcie_ep_init,
 	.raise_irq = artpec6_pcie_raise_irq,
+	.get_features = artpec6_pcie_get_features,
 };
 
 static int artpec6_pcie_probe(struct platform_device *pdev)
-- 
2.47.0


