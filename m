Return-Path: <linux-pci+bounces-20641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C9A24FD3
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 20:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E560C162CB1
	for <lists+linux-pci@lfdr.de>; Sun,  2 Feb 2025 19:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BB51FBC8E;
	Sun,  2 Feb 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbN+JRDr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7E8F6C;
	Sun,  2 Feb 2025 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738524894; cv=none; b=chD6Hg4uPXHe5mGa3BUyP+4nU+kA40jlHSFlzgnWucwqLONrTHFSszx5Q48vVytiUyBwlGIgfTXenAJx3Y+4L059+WQqpRGlzJtCiQYW4Ka9EV5G7rvciNtqZBPCcKFzniEs4zry6QlPCT294XQgCZ+B+eJKLVErbXPDS2m/Q0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738524894; c=relaxed/simple;
	bh=K2iI3AiKvjoEFvWs1oYEwnuQSWAbsXtBtq6KCTpCm8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=diQy30dKn3LxNF3a1q86irOpKFb3IqCzxbCoCsV+uW9fiarLKrqZqf6Aqt0RONF3LNf53lazSu9uJm8INusb/jn2noB7Dp686ax69WtLzUQcZwtZUzzz887tlMUIGpEFA0fWh0vTPEX+tV4pcqYRKz6wcz30B8n2rTfuR11QK4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbN+JRDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD378C4CED1;
	Sun,  2 Feb 2025 19:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738524894;
	bh=K2iI3AiKvjoEFvWs1oYEwnuQSWAbsXtBtq6KCTpCm8s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FbN+JRDrD7nKr2dLBNZOe1qC5aTOv060C1/q8JE2jiFqpQZfLWCDIQ+vBM7WVNPF0
	 CbNRTCsKPrraZwXbK+C6dIr8cRj8OoVb9fRzlKOqMkm9LWL0FWD7KpDaXQv6PnTzar
	 VYyYAbh0aY7JvMwLHcXdW/SeuLmpwdKUqCHbcN0YrtVzJZpxOZy/I0wErBhtYsTRJm
	 X2FTJAE44lFt05ch1YlEgJpGSE0vyBL87XergSHCM8bjAxtRsL1BGqHaFAZmZmqAXl
	 Myfn6cCiNzhPR32po55YKJNj9dVSeM5yczAgBdD94pJWhv+PV5PgwM7GMTBpvSf7Wt
	 /3kw0y5UnTBoA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 02 Feb 2025 20:34:24 +0100
Subject: [PATCH v2 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-en7581-pcie-pbus-csr-v2-2-65dcb201c9a9@kernel.org>
References: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
In-Reply-To: <20250202-en7581-pcie-pbus-csr-v2-0-65dcb201c9a9@kernel.org>
To: Ryder Lee <ryder.lee@mediatek.com>, 
 Jianjun Wang <jianjun.wang@mediatek.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2

Configure PBus base address and address mask to allow the hw
to detect if a given address is on PCIE0, PCIE1 or PCIE2.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 30 ++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index aa24ac9aaecc749b53cfc4faf6399913d20cdbf2..9c2a592cae959de8fbe9ca5c5c2253f8eadf2c76 100644
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
@@ -945,6 +955,24 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
 	/* Wait for the time needed to complete the reset lines assert. */
 	msleep(PCIE_EN7581_RESET_TIME_MS);
 
+	map = syscon_regmap_lookup_by_phandle(dev->of_node,
+					      "mediatek,pbus-csr");
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	/*
+	 * Configure PBus base address and address mask to allow the
+	 * hw to detect if a given address is on PCIE0, PCIE1 or PCIE2.
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
2.48.1


