Return-Path: <linux-pci+bounces-19917-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A83CA129ED
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66147A048C
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E461AB6CC;
	Wed, 15 Jan 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeqyiJwQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D3B1AB6CB;
	Wed, 15 Jan 2025 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962416; cv=none; b=O38wGy+R4xUf0Q7iaJbbdFaYDpnhwAyVSb7p9jYw1fQnC8kkGP2Mr41ttlFXSkL/cRvUqUrebQzkx8RXUUaUlvHNq5lEgbaBJmcrPHgXu5ysouJcQWdWadbM6v16BuEnJULQqrk54zLjAQedfwOFFLjtt71BoWX8bfSNdXDESmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962416; c=relaxed/simple;
	bh=X1iUr4Z3xOp2+2SXrinRazhxNTDYDO8wPhrfSPaaZSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNbkV5tUSyViWNcmLx9a82CpOHMm1Y/52ieulW/nXnqvwcXp5D/O4piJY8gyBYgZGvWfUCZSsqERWWb+xySxOJxnluKeFy/qfNQ9AmElsuf0Y68mjwIY0sT0fJEkHei8jasdio5ZkO3ZDPkDDLY3THRG4pjWCfTAjC3XSqIDBY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeqyiJwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FE2C4CED1;
	Wed, 15 Jan 2025 17:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736962416;
	bh=X1iUr4Z3xOp2+2SXrinRazhxNTDYDO8wPhrfSPaaZSo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZeqyiJwQ9iZpAtxKr6wN9eWfGdHiYrJgQL5e7HznK240KZxasrQt6U6xrrjw5YbeB
	 KL8uk4SpYvjRObFhZbtlabjwjceDWuzBI/6sVKgRxReM7ddari+RbEHrr4rVsRaZml
	 +9j5GSHQlAARPemjSdclwryAtAJ743Ql6dNyiYy7MwZaH2exoCf5V/fBsRmHtMJfpS
	 27lCE+0/Di4H6Wr6ej36NGPwHlkZPX7JGTcbb+dx3KH0u36EIE9u1HYWvlQ0KDbUMe
	 GcOIEYVAe+TEAXcOjRFlxfUeXndppK0g8ArtOSBBvUYFN7hqPIj580FA/QGhJHKWF3
	 jcmomyEPWN2tQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 15 Jan 2025 18:32:31 +0100
Subject: [PATCH 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers for
 EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-en7581-pcie-pbus-csr-v1-2-40d8fcb9360f@kernel.org>
References: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
In-Reply-To: <20250115-en7581-pcie-pbus-csr-v1-0-40d8fcb9360f@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Configure PBus base address and address mask in order to allow the hw
detecting if a given address is on PCIE0, PCIE1 or PCIE2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..b172a46cf95a9c728291c5b7a88457d3b725681a 100644
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
@@ -127,6 +129,13 @@
 
 #define PCIE_MTK_RESET_TIME_US		10
 
+#define PCIE_EN7581_PBUS_ADDR(_n)	(0x00 + ((_n) << 3))
+#define PCIE_EN7581_PBUS_ADDR_MASK(_n)	(0x04 + ((_n) << 3))
+#define PCIE_EN7581_PBUS_BASE_ADDR(_n)	\
+	((_n) == 2 ? 0x28000000 :	\
+	 (_n) == 1 ? 0x24000000 : 0x20000000)
+#define PCIE_EN7581_PBUS_BASE_ADDR_MASK	GENMASK(31, 26)
+
 /* Time in ms needed to complete PCIe reset on EN7581 SoC */
 #define PCIE_EN7581_RESET_TIME_MS	100
 
@@ -931,7 +940,8 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
 static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
-	int err;
+	struct regmap *map;
+	int err, slot;
 	u32 val;
 
 	/*
@@ -945,6 +955,23 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	/* Wait for the time needed to complete the reset lines assert. */
 	msleep(PCIE_EN7581_RESET_TIME_MS);
 
+	map = syscon_regmap_lookup_by_compatible("airoha,en7581-pbus-csr");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	/*
+	 * Configure PBus base address and address mask in order to allow the
+	 * hw detecting if a given address is on PCIE0, PCIE1 or PCIE2.
+	 */
+	slot = of_get_pci_domain_nr(dev->of_node);
+	if (slot < 0)
+		return slot;
+
+	regmap_write(map, PCIE_EN7581_PBUS_ADDR(slot),
+		     PCIE_EN7581_PBUS_BASE_ADDR(slot));
+	regmap_write(map, PCIE_EN7581_PBUS_ADDR_MASK(slot),
+		     PCIE_EN7581_PBUS_BASE_ADDR_MASK);
+
 	/*
 	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
 	 * requires PHY initialization and power-on before PHY reset deassert.

-- 
2.48.0


