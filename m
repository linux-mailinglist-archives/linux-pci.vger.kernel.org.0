Return-Path: <linux-pci+bounces-17404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A42B9DA5C8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 11:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 202CF285712
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C92B198A39;
	Wed, 27 Nov 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiKtN7ud"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045DBD2FB
	for <linux-pci@vger.kernel.org>; Wed, 27 Nov 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703444; cv=none; b=ZTBjXSedJCD575xvnUhUHRBrSMA2sd3olWijBuk3BXEvKwQ2A0e1kbcdQYhlpWq9HIrpc7EMJBuenYhMAweuQth5se3DRHg30ileMzIxtqMoUkego0pJ8VG4CTtxt9Ml6KR269D53vb0N2ncgAVBvi9bxbXDgg5fhxW3kldlLpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703444; c=relaxed/simple;
	bh=obhY6AtGTkukXDhvCiyEMdDJkOGz3EhqkpEu/0NcHv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6NzZDAXm7Ixfuis07jzYrLvn44X7fehGI6eQDCHVioryeCuStanC6pbYU9uuGzMPH2WOMk8A3dEqIt8YnFHUGut9e9tPdNxighsfqKI2h5ERJrFTWCYHz2i4l50kzg9ropqNsR/X4wSNxKopURl2fyYUPakkIIpPAlfCPbfOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiKtN7ud; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EE6C4CED3;
	Wed, 27 Nov 2024 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732703443;
	bh=obhY6AtGTkukXDhvCiyEMdDJkOGz3EhqkpEu/0NcHv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YiKtN7udK3IURdKdjxAN1iEPHZJTVTsd91/m2f6xlPXpZhdnjB1jTxac+Q9yH1gDQ
	 UT/d0fI9TkqdLGoSixtO7tHV1KOxst57tE99mUSOQs4JHACKkPndgSGivLEniflIzA
	 p/sHfKZpgXYmLSGFKD3YOZcI2jv13Mk8aguU/WO0yShrnUYVhtjXuHZ7gJxGmD6kL4
	 Fc7kw7wGurJygQjdTEVoUYGJPHRE+yBCzc30f37WdmiJXj69jB6TtgXbsf2x9cPOs+
	 ayaRSk6tlS8FZHTLVQzgDpExiv4Gkj3RoGVf/XQfcTxllro898pVNUAN0sjPp+pYeA
	 CjFqvL8aasdMQ==
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
Subject: [PATCH v5 4/6] PCI: artpec6: Implement dw_pcie_ep operation get_features
Date: Wed, 27 Nov 2024 11:30:20 +0100
Message-ID: <20241127103016.3481128-12-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127103016.3481128-8-cassel@kernel.org>
References: <20241127103016.3481128-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=cassel@kernel.org; h=from:subject; bh=obhY6AtGTkukXDhvCiyEMdDJkOGz3EhqkpEu/0NcHv0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLdvuyL+BsRfMr+8CHWv/89zZeVmn9YExg4+Y2BR2Hm1 aAr7auiOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRyYsZ/rvJbZ3rm7PoSoh7 q+KRLxOnGPg6FZpwvtA4ct1ev9VcuZmR4ae6kdX+xwuDVK7O+N1/p3bZxvarclz+zqfTvnL8+jN PjgcA
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
---
 drivers/pci/controller/dwc/pcie-artpec6.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index f8e7283dacd4..234c8cbcae3a 100644
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


