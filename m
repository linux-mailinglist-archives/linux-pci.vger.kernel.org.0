Return-Path: <linux-pci+bounces-23301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1718BA59035
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6787C188D7F4
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CBC224B01;
	Mon, 10 Mar 2025 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIfzMIhK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28912253ED
	for <linux-pci@vger.kernel.org>; Mon, 10 Mar 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600152; cv=none; b=Vxt/Re5xDI0BHkqp/RqvVZoUUpwjloyQ6GkNvF834wHI8bfCGSS0YymP2KY50AO4ftiN3mQRly6/VLMCNg0wYK+J475xwXyWLRrUBzreMobbO7KwsCehzQh+aqFn7NXCLhyCrPp/yeTWQnP1fAP6wYBb3ktvOPHcL5xT5Jzg5XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600152; c=relaxed/simple;
	bh=yMoYyGKM6FbagclOTpM00d2Qgsis276wrIoNJyyP4ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Clm1ypvVziEGm6oLBX87Uc+wzX2mK9+qG1NAAT+zACobEO4oqFHA+OQP2F9y05hdPV/1G5qOfdfUC6IvGJWZlx3F7QJZTJSR92DcklbH2+d1Cp301biAtr+msqCquQz2g0KHuKoOporFro05Pc5uXYkFT44vkRgVo4RUW6Fvkls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIfzMIhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD25BC4CEE5;
	Mon, 10 Mar 2025 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741600152;
	bh=yMoYyGKM6FbagclOTpM00d2Qgsis276wrIoNJyyP4ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eIfzMIhKDL7LfJT3bKcGj2WL0jUzprjjHhKjEwU2xOEMcAigwlaGpKOFeUNPGdvuD
	 9ZiBSfhUSDKywYn9NuOPBHSe6dvRBoIl5Z1KWgAnYMbV6zmyN/e1SJaAT1/Wv9SBuF
	 JyCSulHZAMRJedhmtO7/tSSAt3p7w45ao9gsuJfJL8SmtlASsKlJld371Nia/gfSnv
	 ZDzPHW/f/4P7d8t380scWsRJTrM22d++II1UYMGZgnfNZ+WTFMIuVzMhSWNc3clSWJ
	 KzIzAYaOYRxcxVzc4Y8WfsZS0W1S6A/vFCBP2aQjmk+7BLVo68anX1r1Ld50Bq64jw
	 XpRg0bOf9GvtQ==
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v3 2/2] PCI: dw-rockchip: Hide broken ATS capability
Date: Mon, 10 Mar 2025 10:48:28 +0100
Message-ID: <20250310094826.842681-6-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310094826.842681-4-cassel@kernel.org>
References: <20250310094826.842681-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=cassel@kernel.org; h=from:subject; bh=yMoYyGKM6FbagclOTpM00d2Qgsis276wrIoNJyyP4ys=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNLPbS3YwnG/vL2pw7m5dq2mv3Fez26Re1071GUVb2muZ xFYv+1hRykLgxgXg6yYIovvD5f9xd3uU44r3rGBmcPKBDKEgYtTACbSk8nwP84vaFcDb8O6DvuX 6oUFeTZza05pnb5qZhaglGc76+pSb4b/+dZbS5c+8Des59rp2aX77OOWn8tvuXFta+Fdv9Jj0y8 HZgA=
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

When running the rk3588 in endpoint mode, with an Intel host with IOMMU
enabled, the host side prints:

  DMAR: VT-d detected Invalidation Time-out Error: SID 0

When running the rk3588 in endpoint mode, with an AMD host with IOMMU
enabled, the host side prints:

  iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT device=63:00.0 address=0x42b5b01a0]

Rockchip has confirmed that the ATS support for rk3588 only works when
running the PCIe controller in RC mode [0].

Usually, to handle these issues, we add a quirk for the PCI vendor and
device ID in drivers/pci/quirks.c with quirk_no_ats(). That is because
we cannot usually modify the capabilities on the EP side.

In this case, we can modify the capabilities on the EP side. Thus, hide the
broken ATS capability on rk3588 when running in EP mode. That way,
we don't need any quirk on the host side, and we see no errors on the host
side, and we can run pci_endpoint_test successfully, with the IOMMU
enabled on the host side.

[0] https://lore.kernel.org/linux-pci/93cdce39-1ae6-4939-a3fc-db10be7564e5@rock-chips.com/

Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index 836ea10eafbb..bc4339252a03 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -242,6 +242,32 @@ static const struct dw_pcie_host_ops rockchip_pcie_host_ops = {
 	.init = rockchip_pcie_host_init,
 };
 
+/*
+ * ATS does not work on rk3588 when running in EP mode.
+ * After a host has enabled ATS on the EP side, it will send an IOTLB
+ * invalidation request to the EP side. The rk3588 will never send a completion
+ * back and eventually the host will print an IOTLB_INV_TIMEOUT error, and the
+ * EP will not be operational. If we hide the ATS cap, things work as expected.
+ */
+static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct device *dev = pci->dev;
+
+	/* Only hide the ATS cap for rk3588 running in EP mode */
+	if (!of_device_is_compatible(dev->of_node, "rockchip,rk3588-pcie-ep"))
+		return;
+
+	if (dw_pcie_ep_hide_ext_capability(pci, PCI_EXT_CAP_ID_SECPCI,
+					   PCI_EXT_CAP_ID_ATS))
+		dev_err(dev, "failed to hide ATS cap\n");
+}
+
+static void rockchip_pcie_ep_pre_init(struct dw_pcie_ep *ep)
+{
+	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
+}
+
 static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
@@ -314,6 +340,7 @@ rockchip_pcie_get_features(struct dw_pcie_ep *ep)
 
 static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
 	.init = rockchip_pcie_ep_init,
+	.pre_init = rockchip_pcie_ep_pre_init,
 	.raise_irq = rockchip_pcie_raise_irq,
 	.get_features = rockchip_pcie_get_features,
 };
-- 
2.48.1


