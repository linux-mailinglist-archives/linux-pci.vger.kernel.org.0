Return-Path: <linux-pci+bounces-16981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4089CFFE0
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 17:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B64428289A
	for <lists+linux-pci@lfdr.de>; Sat, 16 Nov 2024 16:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C04A18785B;
	Sat, 16 Nov 2024 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebQEu/2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280B7F9CB
	for <linux-pci@vger.kernel.org>; Sat, 16 Nov 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731774981; cv=none; b=LtY1sTDi8jPGXEIkj1XZhBZNs8cyvWHU8szT1by+U9O+FRF1V5+M8kJDCRLEK5Av9FUa0wcKmiU9NIpzn2/6CGXjY/ulkj0/Q1fcJ/+HMROd/tKmwUHk/0h21LBXHTOpqHY2KirGfC2rif1gAJ+7G4/BHVTMrKfoRonpQ96sgvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731774981; c=relaxed/simple;
	bh=JLwPJicJGgYkPGo978p/3MyeYQOOa2tCmhPsQI6RZpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMM4tzf5TXIbklA9b/DG+EGuogmZU5YKbaRia6p9dTO7g3X5FHh6Lox25MBOeqFroDVC77t6Fyst+SLV+eApMVdltHoOdbbyhx/emZMFkRu8JjaENOC33ToJx7Qjdb01LLGaoDpWsifU5Mtq4xyGYksBwqsUzo0ImIpNXX3ceiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebQEu/2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D18C4CEC3;
	Sat, 16 Nov 2024 16:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731774978;
	bh=JLwPJicJGgYkPGo978p/3MyeYQOOa2tCmhPsQI6RZpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ebQEu/2ojNlcsIgDxLYb7qZqA6AE8O6CPl0GWkX7+T4nBh2FehwD/M58ENwbGoQ3s
	 IqV0tRyasK+HuyDMYtW9rJd+UVGBCsVsKJKZyQRPKyIle7QUmivZZeD8ZBgL6QEMhw
	 MyIljjijN2CudUjIGtUqWHLg8trDv8UWKHGvkfNtaIJVvWQfZjnl2C6bb6obuh7ryH
	 Jud+d8ATxMdTgOOZKvYTSQNZpM172z/JnKHIQ47zpe+jJr1Rw+bdJexHGoBbTavu/Q
	 6H0zeyskRBlUKqF+m5wp2QyR0ptABa0ZDBbZsx+riPIOVCi/mtZzff47UJtMESYrNY
	 Fyb5P48Ejlxog==
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
Subject: [PATCH v3 1/4] PCI: artpec6: Implement dw_pcie_ep operation get_features
Date: Sat, 16 Nov 2024 17:36:00 +0100
Message-ID: <20241116163558.2606874-7-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241116163558.2606874-6-cassel@kernel.org>
References: <20241116163558.2606874-6-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=cassel@kernel.org; h=from:subject; bh=JLwPJicJGgYkPGo978p/3MyeYQOOa2tCmhPsQI6RZpw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNItTn45dYE7IPvzveY/5xzSjHe0Vr0U8Jl2qPrvtQL5s nkF5qLHO0pZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRBzkM/9QkZTh9NdWWMNbe Xv7ad8Hv14ZWLLoXNjjmpqUt78/hs2P4X53AzOl+YuZyZsOjQX9Mjc0UYmZs+dGUIRm7ZenSGTN vswIA
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
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
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


