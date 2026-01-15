Return-Path: <linux-pci+bounces-44926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 015EAD23B90
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 10:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 317D830453BD
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970635F8B1;
	Thu, 15 Jan 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAm8REZz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72D33B94A;
	Thu, 15 Jan 2026 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768470680; cv=none; b=hnHMDA0B2PyhUH+hkJKpH32fX/qdL7V6X0G8FvneU22r1Ho+O/0nQFanlZocCRVxwnME10/ZXIWua3po0qPlPVJJmPaeIUrJwxi2/UreLWj/HNjg+LkQbhvpSPZFgPlyaQiurkjjltqVrEFXRVJqiPy+tA+y6XK8rEpGDdlWNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768470680; c=relaxed/simple;
	bh=HpqC5xx2JciOccRQs/mA4K61HFjvK3cJ4krLdRlhU9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ASsvRT0INfxX3u2L6fusKv9iEhHmbaDJY5AKVh/rsVCbIy1iZjUJC26ewPedtEOwn+GljVXL2Fe149c0xP+SYDpGAm8yaFrDitciBfrFIR90LJimiiw0oOZJd1wa254IP/ddlZV411r9jERqUc4777qUerg+3kIPiSIv5hja/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAm8REZz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3470FC16AAE;
	Thu, 15 Jan 2026 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768470680;
	bh=HpqC5xx2JciOccRQs/mA4K61HFjvK3cJ4krLdRlhU9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QAm8REZzpgJ6ozjkDjZvG74LFL6foGHUYhUPiID8BHk89ghMnX1FHRs/dptQuDsMR
	 ubn9o0aUETiUpCFZOqE8repG7S45r8PTGGNrgCYfkm/aiC4GnMZtbgvcipQd65Zefa
	 uHhlTOMBuQuvYyMVoqv7VXHhFvQu9+KbISTX89OizFUuofTWZf2b89pQHao0d0tgnl
	 sP1eTxrhMT5jxULYR+kMUoZ/I6CaVPjUORR/R4HhKheAaWteZhJAYhWj6YfG8xyCVc
	 jxmkcvGaJyM2Jyi+KMOiZarzNgz9HUFanWNiEg/xGEGrcfeaoa0yfUlPF+hkhow4Au
	 Rm5g+JcB2lbuQ==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 15 Jan 2026 10:50:49 +0100
Subject: [PATCH v3 3/6] irqchip/gic-v5: Split IRS probing into OF and
 generic portions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-gicv5-host-acpi-v3-3-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
In-Reply-To: <20260115-gicv5-host-acpi-v3-0-c13a9a150388@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Hanjun Guo <guohanjun@huawei.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.14.3

Split the IRS driver code into OF specific and generic portions in order
to pave the way for adding ACPI firmware bindings support.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v5-irs.c | 112 +++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 52 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index ce2732d649a3..7db44a91f043 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -545,15 +545,13 @@ int gicv5_irs_register_cpu(int cpuid)
 
 static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
 					void __iomem *irs_base,
-					struct fwnode_handle *handle)
+					bool noncoherent)
 {
-	struct device_node *np = to_of_node(handle);
 	u32 cr0, cr1;
 
-	irs_data->fwnode = handle;
 	irs_data->irs_base = irs_base;
 
-	if (of_property_read_bool(np, "dma-noncoherent")) {
+	if (noncoherent) {
 		/*
 		 * A non-coherent IRS implies that some cache levels cannot be
 		 * used coherently by the cores and GIC. Our only option is to mark
@@ -678,49 +676,13 @@ static void irs_setup_pri_bits(u32 idr1)
 	}
 }
 
-static int __init gicv5_irs_init(struct device_node *node)
+static int __init gicv5_irs_init(struct gicv5_irs_chip_data *irs_data)
 {
-	struct gicv5_irs_chip_data *irs_data;
-	void __iomem *irs_base;
-	u32 idr, spi_count;
-	u8 iaffid_bits;
-	int ret;
+	u32 spi_count, idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR2);
 
-	irs_data = kzalloc(sizeof(*irs_data), GFP_KERNEL);
-	if (!irs_data)
-		return -ENOMEM;
-
-	raw_spin_lock_init(&irs_data->spi_config_lock);
-
-	ret = of_property_match_string(node, "reg-names", "ns-config");
-	if (ret < 0) {
-		pr_err("%pOF: ns-config reg-name not present\n", node);
-		goto out_err;
-	}
-
-	irs_base = of_io_request_and_map(node, ret, of_node_full_name(node));
-	if (IS_ERR(irs_base)) {
-		pr_err("%pOF: unable to map GICv5 IRS registers\n", node);
-		ret = PTR_ERR(irs_base);
-		goto out_err;
-	}
-
-	gicv5_irs_init_bases(irs_data, irs_base, &node->fwnode);
-
-	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
-	iaffid_bits = FIELD_GET(GICV5_IRS_IDR1_IAFFID_BITS, idr) + 1;
-
-	ret = gicv5_irs_of_init_affinity(node, irs_data, iaffid_bits);
-	if (ret) {
-		pr_err("Failed to parse CPU IAFFIDs from the device tree!\n");
-		goto out_iomem;
-	}
-
-	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR2);
 	if (WARN(!FIELD_GET(GICV5_IRS_IDR2_LPI, idr),
 		 "LPI support not available - no IPIs, can't proceed\n")) {
-		ret = -ENODEV;
-		goto out_iomem;
+		return -ENODEV;
 	}
 
 	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR7);
@@ -729,14 +691,6 @@ static int __init gicv5_irs_init(struct device_node *node)
 	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR6);
 	irs_data->spi_range = FIELD_GET(GICV5_IRS_IDR6_SPI_IRS_RANGE, idr);
 
-	if (irs_data->spi_range) {
-		pr_info("%s detected SPI range [%u-%u]\n",
-						of_node_full_name(node),
-						irs_data->spi_min,
-						irs_data->spi_min +
-						irs_data->spi_range - 1);
-	}
-
 	/*
 	 * Do the global setting only on the first IRS.
 	 * Global properties (iaffid_bits, global spi count) are guaranteed to
@@ -760,6 +714,60 @@ static int __init gicv5_irs_init(struct device_node *node)
 	list_add_tail(&irs_data->entry, &irs_nodes);
 
 	return 0;
+}
+
+static int __init gicv5_irs_of_init(struct device_node *node)
+{
+	struct gicv5_irs_chip_data *irs_data;
+	void __iomem *irs_base;
+	u8 iaffid_bits;
+	u32 idr;
+	int ret;
+
+	irs_data = kzalloc(sizeof(*irs_data), GFP_KERNEL);
+	if (!irs_data)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&irs_data->spi_config_lock);
+
+	ret = of_property_match_string(node, "reg-names", "ns-config");
+	if (ret < 0) {
+		pr_err("%pOF: ns-config reg-name not present\n", node);
+		goto out_err;
+	}
+
+	irs_base = of_io_request_and_map(node, ret, of_node_full_name(node));
+	if (IS_ERR(irs_base)) {
+		pr_err("%pOF: unable to map GICv5 IRS registers\n", node);
+		ret = PTR_ERR(irs_base);
+		goto out_err;
+	}
+
+	irs_data->fwnode = of_fwnode_handle(node);
+	gicv5_irs_init_bases(irs_data, irs_base, of_property_read_bool(node, "dma-noncoherent"));
+
+	idr = irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
+	iaffid_bits = FIELD_GET(GICV5_IRS_IDR1_IAFFID_BITS, idr) + 1;
+
+	ret = gicv5_irs_of_init_affinity(node, irs_data, iaffid_bits);
+	if (ret) {
+		pr_err("Failed to parse CPU IAFFIDs from the device tree!\n");
+		goto out_iomem;
+	}
+
+	ret = gicv5_irs_init(irs_data);
+	if (ret)
+		goto out_iomem;
+
+	if (irs_data->spi_range) {
+		pr_info("%s detected SPI range [%u-%u]\n",
+						of_node_full_name(node),
+						irs_data->spi_min,
+						irs_data->spi_min +
+						irs_data->spi_range - 1);
+	}
+
+	return ret;
 
 out_iomem:
 	iounmap(irs_base);
@@ -818,7 +826,7 @@ int __init gicv5_irs_of_probe(struct device_node *parent)
 		if (!of_device_is_compatible(np, "arm,gic-v5-irs"))
 			continue;
 
-		ret = gicv5_irs_init(np);
+		ret = gicv5_irs_of_init(np);
 		if (ret)
 			pr_err("Failed to init IRS %s\n", np->full_name);
 	}

-- 
2.50.1


