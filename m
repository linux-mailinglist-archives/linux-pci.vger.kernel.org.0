Return-Path: <linux-pci+bounces-37864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1299BBD0C64
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 23:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC26A3BF219
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 20:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B092522A1;
	Sun, 12 Oct 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsc6IO06"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC73246763
	for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 20:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760302758; cv=none; b=RYLNMXZsSp4oWAUTfGvppOD71TCchOV7Mjrz3c5hqzjkPtVIVEt9KSp/skLDZtuiReOdMDFzwoy182b2R13n6UrtR6e/qu0U4t9onC4N+RUEFebLPXNEv3UBvNh44njK8NqNs5emuiHu1KQUd1g0OI4BkSTR7h9ebZpxg+XJbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760302758; c=relaxed/simple;
	bh=Y9B4pzLzBUoQ9UIuQ9tIIiCjBmPz1CktqXuCtCWM/sI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iykhiZ+Oj0VBoMjjKpYzOW5KEPki/TRT9Zwy1DwXxm0OSyAgK55RZziA5RXFCMcQEsZqlQkO0MBnugdle3BOBN0lsJ07SIi3L9wpdZf7qkxh3nYWRVmILd/bzyDvzjw13yUwIxuF8OScnFEnWi379EHgPmICz13fF8qpgupNMrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsc6IO06; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so3212232f8f.0
        for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760302755; x=1760907555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfCCKZmM8pHKKYsT+xDhYQD00mwQ4CthcxXjlQ/ajbw=;
        b=nsc6IO06Tlyq7aYcLRg/jr0M5+naBwyxEy3UUtJgdS2QAN7AeRMzf966b4s3JQMt+u
         jikZHsnMSBBTUO1c0LPzA8f5RwKmwOqmLgGrYeZM/7uCJGxaal7l/JGi9wqzk0K1vsNh
         7qL6dJ3PvoajOHpb4MoTHGOH7TvWfes4ndwnpU8a0fgEv1Pr5htOAvsi2Qpvj41JobjL
         JMrCydbyzBvNlOvh5G1zQVfRuKVAO9/gdo78K0b3XDqFV/2STAfeMurhyvZtRc7SwG42
         X7NeznZn6ivEjz8TKQScgYgmCImPpV7AI4CGFAiql6XhwuwOT4Xcsd759VXRVFqtdI6M
         dTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760302755; x=1760907555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfCCKZmM8pHKKYsT+xDhYQD00mwQ4CthcxXjlQ/ajbw=;
        b=SPI1g9v0G3EE7ubJOtf1srsipgqpqfIF/XW/Pgrb56x6PLdchizsvIN6HWxDwhtEIX
         a90Bw2Mp7y4o6qN/1rOMEtotYlbCXTEMDnaEwkkIWXMCyk+aneHrfsLLVHDrVvIE/g8g
         /QC+2RKOGhYQRSoOz1Qy6jvGzsAmwV06AL0vE2q7XtVBv0Ni06FYir8ZJjS+tkOlEsgQ
         da6ktoWJWEAaTCAfxcXrSV8d6bM/yo3JMh+FY7Iu4pmElGfgkrBxkjJf2t74tVqTzbIB
         9rqjPaUhvVTZ5PUzWazuaem1cDDLskorsJXsck++Su86DlU19GnsEnZc3wbThRQI1/Vx
         9Snw==
X-Forwarded-Encrypted: i=1; AJvYcCUTS8vP4R2U8hvINa8YX9+nWvH6RtzwJYz3L3t9xnNvK3vwpx5PCd9liT7AojB9v29uKas/drxWUOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7ddnY3daIxDzTxTmkj9vj8QKngaGF2ENnvXiyzWPJQiczGV7
	bHHmxWgUCpQ4COTVjEsfCvQj0LTimCcv2axJkIRvT5fLT7kfxffHfU3x
X-Gm-Gg: ASbGncs56VvBiDLaldNteHvWOapzO64x0tjep2RnxjfS245o1vIsIRI4fOvGm+NIhlG
	NqOgl0/6CaW4JY0IbvidTLM+++lHsSINzkdfNsrDQRcCvHb6/ORcDoZBVRlaCQwYI10+We+/7st
	OmaN8U+gZMHD8CfB9vS4btfi23K9/cAUHxTiiwZX6h2c8SiueaYc8aAGRYzp1K2mekawgjFTApt
	K3T5SdjYaVNqJtB21F6u1yedlaZ1eQuIn2sP7eHsmU3CpnEUPJZRCkydLu0u8RW+TAW+fnpi4/z
	V49fplzFAC/7vLUHQgUaeu+nOWZsPWp6PEApDQQPB7iUp6BQZN+pgWtdDXMexq2DRaRxuiOiec3
	KOGfjpyZhoCaYEZgAXlXMhaaof8eDxBxF7WsQiPoZSjkehwMr+LvYJ0SsP11R7ebj2OR3rB8Jvw
	P1CMzp1dNP
X-Google-Smtp-Source: AGHT+IH7sgN1Uipv2qIehYyfPkgfd4Xy/W9AcNWaxkV0fmExJBTYScLNQstD+s0qCJYHU+iZtjXiGQ==
X-Received: by 2002:a05:6000:4027:b0:401:2cbf:ccad with SMTP id ffacd0b85a97d-425829e78e9mr16695402f8f.17.1760302754926;
        Sun, 12 Oct 2025 13:59:14 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm156506505e9.10.2025.10.12.13.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 13:59:14 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Subject: [PATCH v5 5/5] PCI: mediatek: add support for Airoha AN7583 SoC
Date: Sun, 12 Oct 2025 22:56:59 +0200
Message-ID: <20251012205900.5948-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251012205900.5948-1-ansuelsmth@gmail.com>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the second PCIe Root Complex present on Airoha AN7583
SoC.

This is based on the Mediatek Gen1/2 PCIe driver and similar to Gen3
also require workaround for the reset signals.

Introduce a new flag to skip having to reset signals and also introduce
some additional logic to configure the PBUS registers required for
Airoha SoC.

While at it, also add additional info on the PERST# Signal delay
comments and use dedicated macro.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 92 ++++++++++++++++++++------
 1 file changed, 70 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 1678461e56d3..3340c005da4b 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -148,6 +148,7 @@ enum mtk_pcie_flags {
 	NO_MSI = BIT(2), /* Bridge has no MSI support, and relies on an
 			  * external block
 			  */
+	SKIP_PCIE_RSTB	= BIT(3), /* Skip calling RSTB bits on PCIe probe */
 };
 
 /**
@@ -684,28 +685,32 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
 	}
 
-	/* Assert all reset signals */
-	writel(0, port->base + PCIE_RST_CTRL);
-
-	/*
-	 * Enable PCIe link down reset, if link status changed from link up to
-	 * link down, this will reset MAC control registers and configuration
-	 * space.
-	 */
-	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
-
-	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
-	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
-	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
-	 */
-	msleep(100);
-
-	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
-	val = readl(port->base + PCIE_RST_CTRL);
-	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
-	       PCIE_MAC_SRSTB | PCIE_CRSTB;
-	writel(val, port->base + PCIE_RST_CTRL);
+	if (!(soc->flags & SKIP_PCIE_RSTB)) {
+		/* Assert all reset signals */
+		writel(0, port->base + PCIE_RST_CTRL);
+
+		/*
+		 * Enable PCIe link down reset, if link status changed from
+		 * link up to link down, this will reset MAC control registers
+		 * and configuration space.
+		 */
+		writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
+
+		/*
+		 * Described in PCIe CEM specification revision 3.0 sections
+		 * 2.2 (PERST# Signal) and 2.2.1 (Initial Power-Up (G3 to S0)).
+		 *
+		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
+		 * for the power and clock to become stable.
+		 */
+		msleep(PCIE_T_PVPERL_MS);
+
+		/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
+		val = readl(port->base + PCIE_RST_CTRL);
+		val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
+		       PCIE_MAC_SRSTB | PCIE_CRSTB;
+		writel(val, port->base + PCIE_RST_CTRL);
+	}
 
 	/* Set up vendor ID and class code */
 	if (soc->flags & NEED_FIX_CLASS_ID) {
@@ -826,6 +831,41 @@ static int mtk_pcie_startup_port(struct mtk_pcie_port *port)
 	return 0;
 }
 
+static int mtk_pcie_startup_port_an7583(struct mtk_pcie_port *port)
+{
+	struct mtk_pcie *pcie = port->pcie;
+	struct device *dev = pcie->dev;
+	struct pci_host_bridge *host;
+	struct resource_entry *entry;
+	struct regmap *pbus_regmap;
+	resource_size_t addr;
+	u32 args[2], size;
+
+	/*
+	 * Configure PBus base address and base address mask to allow
+	 * the hw to detect if a given address is accessible on PCIe
+	 * controller.
+	 */
+	pbus_regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node,
+							   "mediatek,pbus-csr",
+							   ARRAY_SIZE(args),
+							   args);
+	if (IS_ERR(pbus_regmap))
+		return PTR_ERR(pbus_regmap);
+
+	host = pci_host_bridge_from_priv(pcie);
+	entry = resource_list_first_type(&host->windows, IORESOURCE_MEM);
+	if (!entry)
+		return -ENODEV;
+
+	addr = entry->res->start - entry->offset;
+	regmap_write(pbus_regmap, args[0], lower_32_bits(addr));
+	size = lower_32_bits(resource_size(entry->res));
+	regmap_write(pbus_regmap, args[1], GENMASK(31, __fls(size)));
+
+	return mtk_pcie_startup_port_v2(port);
+}
+
 static void mtk_pcie_enable_port(struct mtk_pcie_port *port)
 {
 	struct mtk_pcie *pcie = port->pcie;
@@ -1210,6 +1250,13 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
 	.flags = NEED_FIX_CLASS_ID,
 };
 
+static const struct mtk_pcie_soc mtk_pcie_soc_an7583 = {
+	.ops = &mtk_pcie_ops_v2,
+	.startup = mtk_pcie_startup_port_an7583,
+	.setup_irq = mtk_pcie_setup_irq,
+	.flags = NEED_FIX_CLASS_ID | SKIP_PCIE_RSTB,
+};
+
 static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
 	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
 	.ops = &mtk_pcie_ops_v2,
@@ -1219,6 +1266,7 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
 };
 
 static const struct of_device_id mtk_pcie_ids[] = {
+	{ .compatible = "airoha,an7583-pcie", .data = &mtk_pcie_soc_an7583 },
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
-- 
2.51.0


