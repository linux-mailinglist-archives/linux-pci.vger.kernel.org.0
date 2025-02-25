Return-Path: <linux-pci+bounces-22294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 251DCA436EB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 09:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0FFA169E9F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 08:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65C25C6EF;
	Tue, 25 Feb 2025 08:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HazrX7jc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283312153E6;
	Tue, 25 Feb 2025 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740470656; cv=none; b=q53eiMEYdau22iiVINjlRmPB7UigZRwLjGSJ/+bQjAii0BjYfB9CFk51wR9Ucyyh+tFeOyz3jvD3QCntnpJwhkCDJrvZSJWBT9t7O8CqMAEDTMcvZgezzeRIZlj7KPKI9P+ikUqpb54JnJ8AeJuMFiZh2oa1sH/h+2mzLGK8is4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740470656; c=relaxed/simple;
	bh=UIr6nl14PNT9O4sqrjXYAxiPPUTsIADVOWslxLJu8eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X4IZgrMHF/6V2NYvgM4MSNa6I3ML3DTU8GOK9knJw8Rx3WBnhYzwTQdsXiRP/rWp2vzBaB2/0vyT/Wg5mmTW93GUA4aW1rbo1/ogMFjFI4IjQHC0WxAt8hmb4azQSTxXl56YRPuaQ7n7L7pd7lBSB28ebS/EyIZct6H72z6rvBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HazrX7jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA54C4CEE2;
	Tue, 25 Feb 2025 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740470655;
	bh=UIr6nl14PNT9O4sqrjXYAxiPPUTsIADVOWslxLJu8eE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HazrX7jcNWGDWPn00kfwIVFAZrjrOIBlHvF+GFuYvJW8uoqNS3ZZRIdbOhlVlMZlX
	 X3Op2ucNDqG6zvoE/1kq8WIEibknLRURU287GeRnMXwegTD6rBSZDv+0vOs2xF3UW1
	 AeEA9ZrFrsJh/Ke3stfrdxT7GPdxnHATTSCx3AU3HJVOonvZLgLz7amEVY+sD06SGu
	 0KbZqydZzhF/vAzBsf7V3m8s7ZE2jgTnBzF36r8mK2jGdrTPjBHXBJa2FA5Zlvzj9h
	 5l+ib7csstl5fMKyONEYosEt5Fqw/SNWUDIbQmLZnsq5FJ1HawjZ46XmzlLqBMzdPz
	 vEgzTqDtIV36A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Tue, 25 Feb 2025 09:04:07 +0100
Subject: [PATCH v4 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-en7581-pcie-pbus-csr-v4-2-24324382424a@kernel.org>
References: <20250225-en7581-pcie-pbus-csr-v4-0-24324382424a@kernel.org>
In-Reply-To: <20250225-en7581-pcie-pbus-csr-v4-0-24324382424a@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
X-Mailer: b4 0.14.2

Configure PBus base address and address mask to allow the hw
to detect if a given address is accessible on PCIe controller.

Fixes: f6ab898356dd ("PCI: mediatek-gen3: Add Airoha EN7581 support")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 0f64e76e2111468e6a453889ead7fbc75804faf7..3583e5481dc8a6a357738048fc341c22204527d9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -15,6 +15,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of_device.h>
@@ -24,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 #include <linux/reset.h>
 
 #include "../pci.h"
@@ -930,9 +932,13 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 
 static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 {
+	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 	struct device *dev = pcie->dev;
+	struct resource_entry *entry;
+	struct regmap *pbus_regmap;
+	u32 val, args[2], size;
+	resource_size_t addr;
 	int err;
-	u32 val;
 
 	/*
 	 * The controller may have been left out of reset by the bootloader
@@ -944,6 +950,26 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	/* Wait for the time needed to complete the reset lines assert. */
 	msleep(PCIE_EN7581_RESET_TIME_MS);
 
+	/*
+	 * Configure PBus base address and base address mask to allow the
+	 * hw to detect if a given address is accessible on PCIe controller.
+	 */
+	pbus_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+							   "mediatek,pbus-csr",
+							   ARRAY_SIZE(args),
+							   args);
+	if (IS_ERR(pbus_regmap))
+		return PTR_ERR(pbus_regmap);
+
+	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
+	if (!entry)
+		return -ENODEV;
+
+	addr = entry->res->start - entry->offset;
+	regmap_write(pbus_regmap, args[0], lower_32_bits(addr));
+	size = lower_32_bits(resource_size(entry->res));
+	regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
+
 	/*
 	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
 	 * requires PHY initialization and power-on before PHY reset deassert.

-- 
2.48.1


