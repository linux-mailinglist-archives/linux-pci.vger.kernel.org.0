Return-Path: <linux-pci+bounces-18381-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2CF9F0F32
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B586A2825A9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8DE1E200F;
	Fri, 13 Dec 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwu/WgSg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C291E2318
	for <linux-pci@vger.kernel.org>; Fri, 13 Dec 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100419; cv=none; b=V4bCZYPXqmELW1naHsP6UbvAfO2P9RfOjJKnyJzCjLVZgPVdYQD6quZ1PXmMe91oCY1B5/2vveXB7dZzeglLZNV4+hrvhWoSrJM0DnSiUe702OtjXTIwlMz4lHkxjPFdaN0D2VT2AmVZn5b7uvGpePr4xyukgSgoLu73wbPJsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100419; c=relaxed/simple;
	bh=YkSK1OJRY9aMlx2OTK8VC5n9q/GmDamEjTb97bvOfC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BrYJAh8IUfuscea+6kSmJ6i2eQmCZPlHMB6row7qi1maf+2q0RQmQkPq3V883d3QZptBdkEScF5GF9KRdaNXBLnWA8MIBELBTurgQ/aMRyYVNdG7wj4+45II9NLbPU5cVtRU1nzWiF5YpHnDeuLCmAEcNPj69u06kE2BGJESO14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwu/WgSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2F0C4CED2;
	Fri, 13 Dec 2024 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100419;
	bh=YkSK1OJRY9aMlx2OTK8VC5n9q/GmDamEjTb97bvOfC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fwu/WgSgpHuGU9ZnThHrI6iQf0q9x47yEKhPJJrYeyUaivRCrGqUksF6fliHmqip1
	 qtbxkzS69SRw606h2QlenkevALPp83hgkdp1D0prO5V7FQohexx8T2nUZF41Lqj6E5
	 xMog9UgFAgfOV27Ucn8+ZZwFunm1G8EZByhIosi4B7gVqv84f26IEN3LZ3qzB7tIVp
	 WLC5Rjic0AIko0SQB0gXxx/KlfLaAMowy6bGNNNrKnoKSDMAhxpxsl52T5Vc9ibAQg
	 dr4qwRCyXOIjCqKc5TnZKVAl+1JB/TtbHYE9xRtMXxL03Ay9HNAfFWNE6WA3F5hUWR
	 datEUEKuPt/ug==
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
Subject: [PATCH v6 4/6] PCI: artpec6: Implement dw_pcie_ep operation get_features
Date: Fri, 13 Dec 2024 15:33:05 +0100
Message-ID: <20241213143301.4158431-12-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213143301.4158431-8-cassel@kernel.org>
References: <20241213143301.4158431-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=cassel@kernel.org; h=from:subject; bh=YkSK1OJRY9aMlx2OTK8VC5n9q/GmDamEjTb97bvOfC4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJjXBfvDTzttXQlH+fnv3PYunc0u6y7e83LyFfXzbb7t bOQO39ORykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACYir8zIcJtzh9FrH/tJlmwG C06URJ+TOH/2956Oa3uMdvy3KTC/kMbIsPeVuCKX6Bafa5+U1ktOKqmolps+1dzZeb9s3e+Tmdw sTAA=
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

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
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
2.47.1


