Return-Path: <linux-pci+bounces-23175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3144DA5763E
	for <lists+linux-pci@lfdr.de>; Sat,  8 Mar 2025 00:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9497A4F49
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B11214802;
	Fri,  7 Mar 2025 23:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exc99kmd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A62147EB;
	Fri,  7 Mar 2025 23:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741390683; cv=none; b=vA+iMho3czxiV0lRROUpYUUyXCmqVI/1aluRjQFmAfnHU6J3Cfog8aBoGvM+oPs5BeU6akhis+3T42vYxAedAOmVKkqc6MW3O95Z+w25FSkQl9zCv1b6pNd2jfYEzAnUY0BNziy9mTIFrQdxYyIYqDJUerZ2M3q5usatf7qXD8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741390683; c=relaxed/simple;
	bh=9huYHohH+gOJUkoeThHaODlEFocAowbh3DJVYqegdA4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijtJhUII+wIsFobmwHAtr75jtN//UiKtqTF0yiUlwA0A6Z3+1l9Cq3A/W8UWggNdllaNuHn7HEznZ9cb4kf0z4Xvyi0q5VNUrtncFKyWGz1VTM2UzT8vVxHl77CrhwonZtbnF0fAfaBEmyE6FYyI3sR69Zfl7oC7CeRarPlzDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exc99kmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0311C4CEEE;
	Fri,  7 Mar 2025 23:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741390682;
	bh=9huYHohH+gOJUkoeThHaODlEFocAowbh3DJVYqegdA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=exc99kmdGHpYV6kL6OhjqqdbMWYSyTNNn80GYi2Uc+VGV55ZsasQb1TE6cGi5R6to
	 38jeJdJmaoQrR9WMNt9kfO/wzRwJ8vSP1XRtHW22eTs9DdavO/Ye5cXvtEY5hYsMXZ
	 PbTWPMGSCekt20ls3uamd0Xi2PLFd/LjElBtXUnHmepsGBFqztBbEDGcurcL+6iGUM
	 0PG9WS0ohUvDp11N5TeD1pnusirSM1jZiMfVNEqF41rVNMqttdhmHsv5IT8DusD+Vs
	 gm9ePcCelLJErYpjQlWNp8P3gqtxbqrVukcyKMtvW5n9Rur+rjzM8YTbUUq51t0R6p
	 lxFlFr0Tfm6ag==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] PCI: dwc: Look up 'config' address
Date: Fri,  7 Mar 2025 17:37:43 -0600
Message-Id: <20250307233744.440476-4-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307233744.440476-1-helgaas@kernel.org>
References: <20250307233744.440476-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Set pp->parent_bus_offset based on the parent bus address from the "config"
reg entry if it exists.

.cpu_addr_fixup(res->start) (if implemented) should return the parent bus
address corresponding to res->start.

Sets pp->parent_bus_offset, but doesn't use it, so no functional change
intended yet.
---
 .../pci/controller/dwc/pcie-designware-host.c | 42 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 43 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index b9eaba157dae..e22f650ada5a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -423,7 +423,11 @@ static int dw_pcie_cfg0_setup(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct device_node *np = dev->of_node;
 	struct resource *res;
+	int index;
+	u64 reg_addr, fixup_addr;
+	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (!res) {
@@ -434,6 +438,44 @@ static int dw_pcie_cfg0_setup(struct dw_pcie_rp *pp)
 	pp->cfg0_size = resource_size(res);
 	pp->cfg0_base = res->start;
 
+	/* [mem 0x7ff00000-] in example */
+	dev_info(dev, "%pR config CPU physical\n", res);
+
+	/* Look up "config" address on parent bus */
+	reg_addr = 0;
+	index = of_property_match_string(np, "reg-names", "config");
+	if (index >= 0) {
+		of_property_read_reg(np, index, &reg_addr, NULL);
+		/* [ia  0x8ff00000-] in example */
+		dev_info(dev, "%#010llx config reg[%d] parent bus addr\n",
+			 reg_addr, index);
+	} else {
+		reg_addr = res->start;
+		dev_warn(dev, "%#010llx assumed parent bus addr (no config reg-names entry)\n",
+			 reg_addr);
+	}
+
+	fixup = pci->ops->cpu_addr_fixup;
+	if (fixup) {
+		fixup_addr = fixup(pci, res->start);
+		dev_info(dev, "%#010llx result of %ps(%#010llx)\n",
+			 fixup_addr, fixup, res->start);
+		if (reg_addr == fixup_addr) {
+			dev_info(dev, "%#010llx config reg[%d] == %#010llx; %ps is redundant\n",
+				 reg_addr, index, fixup_addr, fixup);
+		} else {
+			dev_warn(dev, "%#010llx config reg[%d] != %#010llx fixed up addr; DT is broken\n",
+				 reg_addr, index, fixup_addr);
+			reg_addr = fixup_addr;
+		}
+	}
+
+	/* 0x7ff00000 - 0x8ff00000 == 0xf0000000 */
+	pp->parent_bus_offset = res->start - reg_addr;
+	dev_info(dev, "%#010llx config parent bus offset\n",
+		 pp->parent_bus_offset);
+
+
 	pp->va_cfg0_base = devm_pci_remap_cfg_resource(dev, res);
 	if (IS_ERR(pp->va_cfg0_base))
 		return PTR_ERR(pp->va_cfg0_base);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ac23604c829f..eeca38ec3a2b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -362,6 +362,7 @@ struct dw_pcie_rp {
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
 	u32			cfg0_size;
+	u64			parent_bus_offset;
 	resource_size_t		io_base;
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
-- 
2.34.1


