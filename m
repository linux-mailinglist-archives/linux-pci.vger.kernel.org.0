Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0196B3802
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 09:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjCJIFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 03:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCJIFq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 03:05:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F7FADC1A;
        Fri, 10 Mar 2023 00:05:44 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 770016603057;
        Fri, 10 Mar 2023 08:05:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678435542;
        bh=ebCM08ufe5E1iAUMnwY8wnvvUUxgSIMI/R2bN0GLQpg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Maju10yWI03tnIoSxVSfo7QR92+4mOr9qV0DlC536arN4Em9X9GPJswonO7+I6phb
         B8uLGXv6E0EkEMIvpuUexz0S0XJMz+W+aMt5dX1IVcYnWM4gDItUq352e/IDfTaDZo
         3/lVnUNHECJm4h5IW/lPwb1ing4D5wMVUXzX8vgtNKbvUhbfHgaJCtTnty9fcRTSf4
         WZNW1/Nt4ctJwCgqe6N8dycf6jaORaV3YCGjYIbjyFlbptufWEzluAuojFw+DfNZvC
         K1wmtPOf2ocTJ5xpE553vZ8UCIK3VM/7fm8abE35VpJTIJlutSeTfo9P1R1jzw9hGm
         fG06Ni0L5hMKA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>,
        kernel@collabora.com, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 1/7] irqchip/gic-v3: Add a DMA Non-Coherent flag
Date:   Fri, 10 Mar 2023 08:05:12 +0000
Message-Id: <20230310080518.78054-2-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310080518.78054-1-lucas.tanure@collabora.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The GIC600 integration in RK356x, used in rk3588, doesn't support
any of the shareability or cacheability attributes, and requires
both values to be set to 0b00 for all the ITS and Redistributor
tables.

This is loosely based on prior work from XiaoDong Huang and
Peter Geis fixing this issue specifically for Rockchip 356x.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 973ede0197e3..1c334dfeb647 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -42,6 +42,7 @@
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_23144	(1ULL << 2)
+#define ITS_FLAGS_DMA_NON_COHERENT		(1ULL << 3)
 
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING	(1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED	(1 << 1)
@@ -2359,6 +2360,13 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
 	its_write_baser(its, baser, val);
 	tmp = baser->val;
 
+	if (its->flags & ITS_FLAGS_DMA_NON_COHERENT) {
+		if (tmp & GITS_BASER_SHAREABILITY_MASK)
+			tmp &= ~GITS_BASER_SHAREABILITY_MASK;
+		else
+			gic_flush_dcache_to_poc(base, PAGE_ORDER_TO_SIZE(order));
+	}
+
 	if ((val ^ tmp) & GITS_BASER_SHAREABILITY_MASK) {
 		/*
 		 * Shareability didn't stick. Just use
@@ -3055,6 +3063,7 @@ static u64 its_clear_vpend_valid(void __iomem *vlpi_base, u64 clr, u64 set)
 
 static void its_cpu_init_lpis(void)
 {
+	struct its_node *its = list_first_entry(&its_nodes, struct its_node, entry);
 	void __iomem *rbase = gic_data_rdist_rd_base();
 	struct page *pend_page;
 	phys_addr_t paddr;
@@ -3096,6 +3105,9 @@ static void its_cpu_init_lpis(void)
 	gicr_write_propbaser(val, rbase + GICR_PROPBASER);
 	tmp = gicr_read_propbaser(rbase + GICR_PROPBASER);
 
+	if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
+		tmp &= ~GICR_PROPBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ val) & GICR_PROPBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GICR_PROPBASER_SHAREABILITY_MASK)) {
 			/*
@@ -3120,6 +3132,9 @@ static void its_cpu_init_lpis(void)
 	gicr_write_pendbaser(val, rbase + GICR_PENDBASER);
 	tmp = gicr_read_pendbaser(rbase + GICR_PENDBASER);
 
+	if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
+		tmp &= ~GICR_PENDBASER_SHAREABILITY_MASK;
+
 	if (!(tmp & GICR_PENDBASER_SHAREABILITY_MASK)) {
 		/*
 		 * The HW reports non-shareable, we must remove the
@@ -5005,6 +5020,7 @@ static int __init its_compute_its_list_map(struct resource *res,
 static int __init its_probe_one(struct resource *res,
 				struct fwnode_handle *handle, int numa_node)
 {
+	struct device_node *np = to_of_node(handle);
 	struct its_node *its;
 	void __iomem *its_base;
 	u64 baser, tmp, typer;
@@ -5076,6 +5092,9 @@ static int __init its_probe_one(struct resource *res,
 	its->get_msi_base = its_irq_get_msi_base;
 	its->msi_domain_flags = IRQ_DOMAIN_FLAG_MSI_REMAP;
 
+	if (np && !of_dma_is_coherent(np))
+		its->flags |= ITS_FLAGS_DMA_NON_COHERENT;
+
 	its_enable_quirks(its);
 
 	err = its_alloc_tables(its);
@@ -5095,6 +5114,9 @@ static int __init its_probe_one(struct resource *res,
 	gits_write_cbaser(baser, its->base + GITS_CBASER);
 	tmp = gits_read_cbaser(its->base + GITS_CBASER);
 
+	if (its->flags & ITS_FLAGS_DMA_NON_COHERENT)
+		tmp &= ~GITS_CBASER_SHAREABILITY_MASK;
+
 	if ((tmp ^ baser) & GITS_CBASER_SHAREABILITY_MASK) {
 		if (!(tmp & GITS_CBASER_SHAREABILITY_MASK)) {
 			/*
-- 
2.39.2

