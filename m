Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42D758017B
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbiGYPQe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiGYPQI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:16:08 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCC1EAE2;
        Mon, 25 Jul 2022 08:13:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 17so10757577pfy.0;
        Mon, 25 Jul 2022 08:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2t980Sr9Ua/t6NokOYt+cxt415QzejuNvLB89UJ9Rvo=;
        b=LFZ/s5HrtNGmw5hwkrLpfaC/dPfWZLUZjBAOiqFovZXKstFpV5dPgTResg2x0L9Nmw
         Y/FusNB7i4AY2rm3fgv6cKpgB+k1V/kj2G/uTASgyesGFKMbP1evibXRfmSLHe7TI4T/
         iO/Tv4SCHthYZxJPdQVaq4QsPOfeJdvWDc022vRo+aKCOQmlCMABMcZrDl8VDHaAVmds
         IW2nzxDL8yb4hEkvmClggbKseAZ6m7tgT8PCQkSUqUnIJiNVjP1AFrklhFjbNsFc/naH
         UUBiHADaJ6dbBGP9PY0BtzKG+waRgE93t7y+R0/HuJvQnnsdwCkqT2IYJW47dgc16xeM
         /1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2t980Sr9Ua/t6NokOYt+cxt415QzejuNvLB89UJ9Rvo=;
        b=ZVkzFRG5W5AqIA/NVLgprSwLo9LGa2kf/3/8g0VDuWWEfpLy+GGy6YiDWRe7VFE6O2
         WlS2A+Izmd4Jp6zhEu7rs6kn0CI6HYBlstJW3kJniMhvlGEol84AYwZR9gE6SwNZ8IJF
         iVUhKy86LyzsinZOOlh/DPDSZ4S0y2A5otAYiylaDlYNz8CpF6vtxzmgKOjOQvttnycn
         U8A8s0XtLQQOWkGte+mVi+zgeElCz8FI1eCinkjQe8dzEujePqgDcAy58co50v4wGSh+
         bYlww0ZfMdenzCpCmkhSXO7KPg7e2Ra2SzSgy8n/ZPisNwmAuWJU7tEUTGYlPJic6DWk
         dW4Q==
X-Gm-Message-State: AJIora9aPrvjNTWaM3FppzGMNXAqpwX8ZPEeSXbBYFJaCvWJY87BGZgW
        q09bLIOn8IjMgKm7eAAkqJh4pHN6AtA=
X-Google-Smtp-Source: AGRyM1vBMjzcaPknwMkhetj0IuXkME38zOiwmYRnY7TDo+E1HRoMdNkswHOyoRS0JWccp6y0YoAyEQ==
X-Received: by 2002:aa7:9583:0:b0:52a:f076:5043 with SMTP id z3-20020aa79583000000b0052af0765043mr13423527pfj.9.1658762003654;
        Mon, 25 Jul 2022 08:13:23 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:23 -0700 (PDT)
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
Subject: [PATCH v3 1/7] PCI: brcmstb: Remove unnecessary forward declarations
Date:   Mon, 25 Jul 2022 11:12:50 -0400
Message-Id: <20220725151258.42574-2-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725151258.42574-1-jim2101024@gmail.com>
References: <20220725151258.42574-1-jim2101024@gmail.com>
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

