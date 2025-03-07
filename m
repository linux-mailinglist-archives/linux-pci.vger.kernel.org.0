Return-Path: <linux-pci+bounces-23114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFFCA56814
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 13:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9B33AFD0F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 12:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CF14A4C6;
	Fri,  7 Mar 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBJ1kRJy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEED25771
	for <linux-pci@vger.kernel.org>; Fri,  7 Mar 2025 12:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741351672; cv=none; b=r76gPSOAb/ZElyv7nCV+QT2il9RcKvkTAbux4d48Am92IB/u2I7OuHlECPV3PimsTBCkpj5+X5m/EONLnEQ5lfThIjA+KaQHHGVfrK7o1hdUfd/J3/6Z7QanqIfyaviOy3LTAm6EYRH5hoY5Dr1KwXIbK8D4u1fapxE9Xj1K2jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741351672; c=relaxed/simple;
	bh=yMoYyGKM6FbagclOTpM00d2Qgsis276wrIoNJyyP4ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUCSS1myDZBMy+Bq8b3xHT6LD/CKekhNPXIbJNVKd7roTSO5n4AswlTw3CNOVt6f2UE/GJ0Ypir7csgOvafieBMQHXLqdcDIePz9p0eUvLQm7nwLUQUExOXKoUf5rzy9Fy6ItEjQ+NcjzLQB8uC9ne74cMjrLxdZi6PpjynKfqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBJ1kRJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02946C4CED1;
	Fri,  7 Mar 2025 12:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741351671;
	bh=yMoYyGKM6FbagclOTpM00d2Qgsis276wrIoNJyyP4ys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBJ1kRJym+MLwffziarp2SQHYX9pyoStle3jVRUQBNdBy3oDTq4dDapuJPRmxunJI
	 w09KYtz1P+421K4elybUlI8X05IOOYpOZqmovKrBpZlIvc346m7Ci7balOmeQn7gh4
	 48RPPPEeNBPlAXbIp29J89DRDMtZacL1bbuSjm7Dbak7nM7/+A2Mj9j5VWlkE/dApe
	 ey0VWv7kjjmylm40OXOcVQkFzoefoRSj6rKBMZ7McpOtFbi9jrlEhv8OfATBNEOJNQ
	 Aqkc4sqmjA1mdA9Di9IgxHvN4xsL2OE7CoEUwZQBsJfLAH/rydd2OlsTLSS9ZoAzEz
	 Z3hguMCot8d1A==
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
Subject: [PATCH v2 2/2] PCI: dw-rockchip: Hide broken ATS capability
Date: Fri,  7 Mar 2025 13:47:35 +0100
Message-ID: <20250307124732.704375-6-cassel@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307124732.704375-4-cassel@kernel.org>
References: <20250307124732.704375-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3114; i=cassel@kernel.org; h=from:subject; bh=yMoYyGKM6FbagclOTpM00d2Qgsis276wrIoNJyyP4ys=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNJPvXq6heN+eXtTh3Nz7VpNf+O8nt0i97p2qMsq3tJcz yKwftvDjlIWBjEuBlkxRRbfHy77i7vdpxxXvGMDM4eVCWQIAxenAExk1WyG/4VC5o0b+TZrSTI8 c2G0+L/5Cvfiiv25Eq4xz0ILbq6ZqMjw359lfYihXWdqwdfrhueelSuudWreHn436bgJ+wVufe2 97AA=
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


