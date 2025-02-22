Return-Path: <linux-pci+bounces-22085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A76BA4078C
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 11:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 325733BDCDB
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 10:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0561C2080D5;
	Sat, 22 Feb 2025 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAWwjkpd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D182D1FBE9B;
	Sat, 22 Feb 2025 10:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221060; cv=none; b=HJz9cifn1xrzKr3QgCqs0M/jMiF4Sgz62nikBBo2PfxwQBMEQ3/GRPrVk6k5kNSnhjm+5hIu6bhBjGpAE95l0kyUrbH2y4zoXXOtPqXCOB268WlkdidSb4IjKx/htzUQEtu5g8jj5TM4+T9eIPxykf7XCRjH4EaG7lO+rLFEzGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221060; c=relaxed/simple;
	bh=KklBsnKcVFSuYBzhg3x4RUn9m/fVl0ZPRbgJvxFW3Kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eLddnZnaWIjnQkbrBxB8iMdnc08VvaEjKxzWcCGUZPT4QctTpOLg/LUSQ+KGfznDTSn8vT476kQEV4jp50yIJUGddhsAsJ5tmOcyo9tU+dJ3JNHUf43EAwzfl/WKwG/zUCpQFL7YsuenRijvqfXmwmTZtvbupzH1nC95V2e8aBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAWwjkpd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF059C4CEE6;
	Sat, 22 Feb 2025 10:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740221060;
	bh=KklBsnKcVFSuYBzhg3x4RUn9m/fVl0ZPRbgJvxFW3Kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TAWwjkpd+5cFg6+zzP9oLs1xn1rF2z5+dbD0nvnQlS8YjnyJWHp+/gQ+4ueZrNcX+
	 V0O8iEW/VgTO8jrhysPvVMFU7IRTf8vApyrqogJRYxD04B55UpF/q1OQbTYv4Uzeyr
	 Y+46wNkZA8wPM+Df41iCJz/K6YVexwN3W47XLGYlC8ufvCexlmHXozu9VGPZsixfq6
	 tcvJNg2ATFeFuDPq/AU2abj3/aSJqLFBZYdO32ryolKyfrUqJjCF1bRvSlmKcxK3mR
	 wllzj44pFCV6bMynfX6RT5XkQgByYhYo1surtZDfu7wWaqxxm9HCGRaHu2cAThwwy1
	 OL9xpO93NtnOg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sat, 22 Feb 2025 11:43:45 +0100
Subject: [PATCH v3 2/2] PCI: mediatek-gen3: Configure PBUS_CSR registers
 for EN7581 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-en7581-pcie-pbus-csr-v3-2-e0cca1f4d394@kernel.org>
References: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
In-Reply-To: <20250222-en7581-pcie-pbus-csr-v3-0-e0cca1f4d394@kernel.org>
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
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 34 ++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 0f64e76e2111468e6a453889ead7fbc75804faf7..51103b7624c09ca957c22a25536dc9da25428e48 100644
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
+	u32 val, args[2], size, mask;
+	struct regmap *pbus_regmap;
+	resource_size_t addr;
 	int err;
-	u32 val;
 
 	/*
 	 * The controller may have been left out of reset by the bootloader
@@ -944,6 +950,32 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
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
+		return -EINVAL;
+
+	addr = entry->res->start - entry->offset;
+	err = regmap_write(pbus_regmap, args[0], lower_32_bits(addr));
+	if (err)
+		return err;
+
+	size = lower_32_bits(resource_size(entry->res));
+	mask = size ? GENMASK(31, __fls(size)) : 0;
+	err = regmap_write(pbus_regmap, args[1], mask);
+	if (err)
+		return err;
+
 	/*
 	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
 	 * requires PHY initialization and power-on before PHY reset deassert.

-- 
2.48.1


