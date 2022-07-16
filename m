Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00C5771E2
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 00:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbiGPWZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGPWZG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 18:25:06 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64161C90D;
        Sat, 16 Jul 2022 15:25:03 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q16so4378014pgq.6;
        Sat, 16 Jul 2022 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t980Sr9Ua/t6NokOYt+cxt415QzejuNvLB89UJ9Rvo=;
        b=btw5XrakHqLCANSGGcPCwykCuMW+uWDyGBpvXhBgHIWc6faYy9lvuO0yWoysOD4Osc
         B0ZW21i/kxeidBUbpCmSMc+D/nG3mbqG58MgyyVGYPlrebTSENIEuFtHm9VqixzHrdhC
         K+xIqvcrW+OCBcYSkrqGooLtrT50DJkcegulQQCLfxr1YJ99N8IOBZ38ktZIBK1l1rk+
         UoJ1eOXZqg/HpoSHvSW3x7gMPFYTZNiUtVqTVZZfAkMb0OV9vExykJ6hs2sfUIEUwqp6
         AfHDevK2PM7xlxIa50qm1ZTVnEDg1KivKszUtslXGREOojlLerBmOFh696rJkqVGcrvR
         cOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t980Sr9Ua/t6NokOYt+cxt415QzejuNvLB89UJ9Rvo=;
        b=Tl5z5WIy6ys3t4w3Dlyckq8LxnYNDe22ESqRmFaSujr0s3tHYXOX9fzeBGlK6tuw2l
         0b06voMzIeyvISZqY1kkt9hpFUphxJZA3PcjhhNy3dsXz0VHXU/eAccy3OBNvGbRljpH
         JTo+sNDPldasYMYOsf/9DsfM+cQJlw60dAPpVlb0kcUDu7eSvC6nGc2UMwc5SHFL6M6l
         tUEKF1kTd54gTHD825nRHp/HA2chm8DL7Igh2WM8Q2QqeB56IuggaRMRqzpMhS5BEo1G
         9dkNWL4IkgXjVYulzmA+5/l/KqqYufe1eaYQovSqWsrsPGpoK0n7tvbYdJHHKBPxIR55
         pp9g==
X-Gm-Message-State: AJIora/5AZnTZafvrlupwnjgyxWapUlhFfQ90AVzXM/WkRSw4SqnFAtk
        3qA8zwZFfermP2Y/nk+ozp3UU8HlBM8=
X-Google-Smtp-Source: AGRyM1vpz9BlnN446bNduG5jz5tzTPzLj1QJBWr+u0iX5PrsyctvYCdKO3rS0henDyCN5Ij0quH+eg==
X-Received: by 2002:a05:6a00:1a86:b0:52a:d419:9552 with SMTP id e6-20020a056a001a8600b0052ad4199552mr21432933pfv.70.1658010303160;
        Sat, 16 Jul 2022 15:25:03 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm6318662pfr.89.2022.07.16.15.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 15:25:02 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] PCI: brcmstb: Remove unnecessary forward declarations
Date:   Sat, 16 Jul 2022 18:24:48 -0400
Message-Id: <20220716222454.29914-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220716222454.29914-1-jim2101024@gmail.com>
References: <20220716222454.29914-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The forward function declarations in this driver are removed.  Besides
that, some constant structure definitions are moved towards a lower
position in the file.  There are no changes to the code that has been
moved.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 149 +++++++++++++-------------
 1 file changed, 72 insertions(+), 77 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e61058e13818..bd88a0a46c63 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -190,11 +190,6 @@
 
 /* Forward declarations */
 struct brcm_pcie;
-static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
-static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val);
-static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
-static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
-static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -223,66 +218,6 @@ struct pcie_cfg_data {
 	void (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 };
 
-static const int pcie_offsets[] = {
-	[RGR1_SW_INIT_1] = 0x9210,
-	[EXT_CFG_INDEX]  = 0x9000,
-	[EXT_CFG_DATA]   = 0x9004,
-};
-
-static const int pcie_offsets_bmips_7425[] = {
-	[RGR1_SW_INIT_1] = 0x8010,
-	[EXT_CFG_INDEX]  = 0x8300,
-	[EXT_CFG_DATA]   = 0x8304,
-};
-
-static const struct pcie_cfg_data generic_cfg = {
-	.offsets	= pcie_offsets,
-	.type		= GENERIC,
-	.perst_set	= brcm_pcie_perst_set_generic,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-};
-
-static const struct pcie_cfg_data bcm7425_cfg = {
-	.offsets	= pcie_offsets_bmips_7425,
-	.type		= BCM7425,
-	.perst_set	= brcm_pcie_perst_set_generic,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-};
-
-static const struct pcie_cfg_data bcm7435_cfg = {
-	.offsets	= pcie_offsets,
-	.type		= BCM7435,
-	.perst_set	= brcm_pcie_perst_set_generic,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-};
-
-static const struct pcie_cfg_data bcm4908_cfg = {
-	.offsets	= pcie_offsets,
-	.type		= BCM4908,
-	.perst_set	= brcm_pcie_perst_set_4908,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-};
-
-static const int pcie_offset_bcm7278[] = {
-	[RGR1_SW_INIT_1] = 0xc010,
-	[EXT_CFG_INDEX] = 0x9000,
-	[EXT_CFG_DATA] = 0x9004,
-};
-
-static const struct pcie_cfg_data bcm7278_cfg = {
-	.offsets	= pcie_offset_bcm7278,
-	.type		= BCM7278,
-	.perst_set	= brcm_pcie_perst_set_7278,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
-};
-
-static const struct pcie_cfg_data bcm2711_cfg = {
-	.offsets	= pcie_offsets,
-	.type		= BCM2711,
-	.perst_set	= brcm_pcie_perst_set_generic,
-	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
-};
-
 struct brcm_msi {
 	struct device		*dev;
 	void __iomem		*base;
@@ -775,18 +710,6 @@ static void __iomem *brcm_pcie_map_conf32(struct pci_bus *bus, unsigned int devf
 	return base + DATA_ADDR(pcie);
 }
 
-static struct pci_ops brcm_pcie_ops = {
-	.map_bus = brcm_pcie_map_conf,
-	.read = pci_generic_config_read,
-	.write = pci_generic_config_write,
-};
-
-static struct pci_ops brcm_pcie_ops32 = {
-	.map_bus = brcm_pcie_map_conf32,
-	.read = pci_generic_config_read32,
-	.write = pci_generic_config_write32,
-};
-
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp, mask =  RGR1_SW_INIT_1_INIT_GENERIC_MASK;
@@ -1316,6 +1239,66 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const int pcie_offsets[] = {
+	[RGR1_SW_INIT_1] = 0x9210,
+	[EXT_CFG_INDEX]  = 0x9000,
+	[EXT_CFG_DATA]   = 0x9004,
+};
+
+static const int pcie_offsets_bmips_7425[] = {
+	[RGR1_SW_INIT_1] = 0x8010,
+	[EXT_CFG_INDEX]  = 0x8300,
+	[EXT_CFG_DATA]   = 0x8304,
+};
+
+static const struct pcie_cfg_data generic_cfg = {
+	.offsets	= pcie_offsets,
+	.type		= GENERIC,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
+static const struct pcie_cfg_data bcm7425_cfg = {
+	.offsets	= pcie_offsets_bmips_7425,
+	.type		= BCM7425,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
+static const struct pcie_cfg_data bcm7435_cfg = {
+	.offsets	= pcie_offsets,
+	.type		= BCM7435,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
+static const struct pcie_cfg_data bcm4908_cfg = {
+	.offsets	= pcie_offsets,
+	.type		= BCM4908,
+	.perst_set	= brcm_pcie_perst_set_4908,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
+static const int pcie_offset_bcm7278[] = {
+	[RGR1_SW_INIT_1] = 0xc010,
+	[EXT_CFG_INDEX] = 0x9000,
+	[EXT_CFG_DATA] = 0x9004,
+};
+
+static const struct pcie_cfg_data bcm7278_cfg = {
+	.offsets	= pcie_offset_bcm7278,
+	.type		= BCM7278,
+	.perst_set	= brcm_pcie_perst_set_7278,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
+};
+
+static const struct pcie_cfg_data bcm2711_cfg = {
+	.offsets	= pcie_offsets,
+	.type		= BCM2711,
+	.perst_set	= brcm_pcie_perst_set_generic,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
 	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
@@ -1328,6 +1311,18 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{},
 };
 
+static struct pci_ops brcm_pcie_ops = {
+	.map_bus = brcm_pcie_map_conf,
+	.read = pci_generic_config_read,
+	.write = pci_generic_config_write,
+};
+
+static struct pci_ops brcm_pcie_ops32 = {
+	.map_bus = brcm_pcie_map_conf32,
+	.read = pci_generic_config_read32,
+	.write = pci_generic_config_write32,
+};
+
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
-- 
2.17.1

