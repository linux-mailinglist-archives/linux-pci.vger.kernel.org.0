Return-Path: <linux-pci+bounces-16838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF08C9CDAD8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416CDB21669
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A7F18BC3D;
	Fri, 15 Nov 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXIgM08Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45E174EE4
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660491; cv=none; b=culUjmVIzQD3ZgnXkWaNRwrR3prD07DavvgBrA4chCoCv+NMpQDZgXqhrKXIiYNAsBqTOe0fr3eS9wKvA/ZwV4R8SQ0L3R7VLmZFhcojlzmcMGeYC9CiVw50qijbr79hJuUHVEFutxvG+TShoW9VxXu1r26pK7ef3F9FU/GIlJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660491; c=relaxed/simple;
	bh=ZaQEFikrQCPkgci4zERm89mOSxRy4C3e1t5aLqXhiC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kI5A3WUPOVfIVV7gXpIh4d50GQrRMo5eledS/aLo0YldYPxxMV0Gge1qxwHg4H2ivdtIZ9Or5GPVFbrJEQ4nxJes6rM+Nxim5PLQA0/OtWwldz19Vltg3ujitlDjPyeZvvksnzdryePPxGmvKy9LYUzYzXIgrhLc3bIRNNK8hpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXIgM08Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4897C4CECF;
	Fri, 15 Nov 2024 08:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731660491;
	bh=ZaQEFikrQCPkgci4zERm89mOSxRy4C3e1t5aLqXhiC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXIgM08YqYmfH9YNimxk42qitR3pz5NXCgdOBWwa7q/uA/GLG8INamFWyx24/naTm
	 2+t87oo+6+porPdkkWCBxNYQug6dpSUI7YiHTKx+uM4s+itfxWnTfPIxBA5NQysQjt
	 ybzfiFnF+8VdzUe91aU4GcKiJyRNgMDmJisI9YX5CcoF42g/XM5mrE2vPMsoSN4Qna
	 AB0xPVmPzafwZW+NZgIQzfLWYYlD+k1jXE7JkfINWv68Ro+/E2cd0VOKSW33BgPMSJ
	 UWf/lPGfK+4pPJLm4wOKTwqUOjA33+plJlnQ3gbr2YDc3xSY9tqohJCmcRYE9ER6Iv
	 utCaZxgkBKzJQ==
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
Subject: [PATCH v2 1/3] PCI: artpec6: Implement dw_pcie_ep operation get_features
Date: Fri, 15 Nov 2024 09:47:50 +0100
Message-ID: <20241115084749.1915915-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115084749.1915915-5-cassel@kernel.org>
References: <20241115084749.1915915-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1598; i=cassel@kernel.org; h=from:subject; bh=ZaQEFikrQCPkgci4zERm89mOSxRy4C3e1t5aLqXhiC4=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLNuXY9y/y8uLZ869znp1dx/z+700mZ8flVVZXC327eT fxZpcfSOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRKUYM/z17mFvCPFt9Ipez ln9YfU7d6MfuQ9M8ex941Lyv7GYVUWL4X3BZ57nJh6fZOxyepRWKqyazPeavraqtWi5UW1MoEd3 DAwA=
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


