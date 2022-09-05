Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02325AD993
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 21:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiIETZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 15:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiIETZT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 15:25:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449051D300;
        Mon,  5 Sep 2022 12:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC136B815CE;
        Mon,  5 Sep 2022 19:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C43CC4347C;
        Mon,  5 Sep 2022 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662405915;
        bh=QcA9P29C0sz6J16OH80UZGgfyJ/0RAYN/Ol8iwII854=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjsNdaOV3UxRhrTFbFDnG29YL3sykxiwO5qs3BoCGx10zUv1TMRkllWW3N5nRGByK
         6zVBAABQKIYsjuv+J/VRXmrq7OT74BubwtWywIky66KS6Mri3d1HW6WpkjuViIkCTz
         0oOvEzcxNLXsvKeWTpQkS3p95jWQKAgvLG+C2lrSglZ30AtOZ418cWj4pMQBAEqLQQ
         Ci1fc/+26Y8zBhtTLqTPZn00xvTT7l5vmnvzhcO/Q/dz77Q2nPGQQgyr4x+gaZWv5h
         /R5C7zW4JYwecJ3xSCYGYHoKsfa3LQ7ikgo47X1sVUcxurJN0i97vVqmeNVBFfr/0E
         BxN3eewDuVkQA==
Received: by pali.im (Postfix)
        id 1204F2145; Mon,  5 Sep 2022 21:25:13 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/7] bus: mvebu-mbus: add configuration space aperture
Date:   Mon,  5 Sep 2022 21:23:05 +0200
Message-Id: <20220905192310.22786-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220905192310.22786-1-pali@kernel.org>
References: <20220718202843.6766-1-maukka@ext.kapsi.fi>
 <20220905192310.22786-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Mauri Sandberg <maukka@ext.kapsi.fi>

Adds a new resource for describing PCI configuration space and accessor for it.

Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/bus/mvebu-mbus.c | 26 +++++++++++++++++++++++---
 include/linux/mbus.h     |  1 +
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 5dc2669432ba..9702c6ddbbe6 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -139,6 +139,7 @@ struct mvebu_mbus_state {
 	struct dentry *debugfs_devs;
 	struct resource pcie_mem_aperture;
 	struct resource pcie_io_aperture;
+	struct resource pcie_cfg_aperture;
 	const struct mvebu_mbus_soc_data *soc;
 	int hw_io_coherency;
 
@@ -950,6 +951,14 @@ void mvebu_mbus_get_pcie_io_aperture(struct resource *res)
 }
 EXPORT_SYMBOL_GPL(mvebu_mbus_get_pcie_io_aperture);
 
+void mvebu_mbus_get_pcie_cfg_aperture(struct resource *res)
+{
+	if (!res)
+		return;
+	*res = mbus_state.pcie_cfg_aperture;
+}
+EXPORT_SYMBOL_GPL(mvebu_mbus_get_pcie_cfg_aperture);
+
 int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr)
 {
 	const struct mbus_dram_target_info *dram;
@@ -1277,7 +1286,8 @@ static int __init mbus_dt_setup(struct mvebu_mbus_state *mbus,
 
 static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 						 struct resource *mem,
-						 struct resource *io)
+						 struct resource *io,
+						 struct resource *cfg)
 {
 	u32 reg[2];
 	int ret;
@@ -1290,6 +1300,8 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 	mem->end = -1;
 	memset(io, 0, sizeof(struct resource));
 	io->end = -1;
+	memset(cfg, 0, sizeof(struct resource));
+	cfg->end = -1;
 
 	ret = of_property_read_u32_array(np, "pcie-mem-aperture", reg, ARRAY_SIZE(reg));
 	if (!ret) {
@@ -1304,6 +1316,13 @@ static void __init mvebu_mbus_get_pcie_resources(struct device_node *np,
 		io->end = io->start + reg[1] - 1;
 		io->flags = IORESOURCE_IO;
 	}
+
+	ret = of_property_read_u32_array(np, "pcie-cfg-aperture", reg, ARRAY_SIZE(reg));
+	if (!ret) {
+		cfg->start = reg[0];
+		cfg->end = cfg->start + reg[1] - 1;
+		cfg->flags = IORESOURCE_MEM;
+	}
 }
 
 int __init mvebu_mbus_dt_init(bool is_coherent)
@@ -1359,9 +1378,10 @@ int __init mvebu_mbus_dt_init(bool is_coherent)
 
 	mbus_state.hw_io_coherency = is_coherent;
 
-	/* Get optional pcie-{mem,io}-aperture properties */
+	/* Get optional pcie-{mem,io,cfg}-aperture properties */
 	mvebu_mbus_get_pcie_resources(np, &mbus_state.pcie_mem_aperture,
-					  &mbus_state.pcie_io_aperture);
+					  &mbus_state.pcie_io_aperture,
+					  &mbus_state.pcie_cfg_aperture);
 
 	ret = mvebu_mbus_common_init(&mbus_state,
 				     mbuswins_res.start,
diff --git a/include/linux/mbus.h b/include/linux/mbus.h
index 4773145246ed..525b56ddd0c2 100644
--- a/include/linux/mbus.h
+++ b/include/linux/mbus.h
@@ -86,6 +86,7 @@ static inline int mvebu_mbus_get_io_win_info(phys_addr_t phyaddr, u32 *size,
 int mvebu_mbus_save_cpu_target(u32 __iomem *store_addr);
 void mvebu_mbus_get_pcie_mem_aperture(struct resource *res);
 void mvebu_mbus_get_pcie_io_aperture(struct resource *res);
+void mvebu_mbus_get_pcie_cfg_aperture(struct resource *res);
 int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr);
 int mvebu_mbus_add_window_remap_by_id(unsigned int target,
 				      unsigned int attribute,
-- 
2.20.1

