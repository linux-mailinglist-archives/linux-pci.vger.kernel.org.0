Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFF72C568C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 15:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389970AbgKZOAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 09:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389434AbgKZOAA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 09:00:00 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F606C0613D4;
        Thu, 26 Nov 2020 05:59:59 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d20so2626720lfe.11;
        Thu, 26 Nov 2020 05:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ACPkTDQAZK0xYByBduKtvlFnDRihFgFiCOEVqxw6X2g=;
        b=MR+iOnzaIn06SpRb7DOfv8C2G+CwgVsNK5o5r6jn3obINL7n5jAJhx5MBgUkth3ErN
         inKqL+R4Le/t/Fmh8vZlxaEOyl5NYk7SScn+KALoMUPW6qSTp/1SZ9nrXqpWq3nhnp6I
         6+RuWArzwZg19LdzPh+F1/pXaLviVs2fWaesbElGgiBAhqmEXMWoaxT0ZNudSUR5FcLZ
         GVfRRN8yLvD/ndlCOoZ8cZuTKRxALc9fTyUpsI2EK9Xv2+T9Lun8Haxuq1O1i2e5B78s
         rfZdHCT67XyrmJ64sBNsmnertWA7DRy6PpFe/YfDVOU6IQptdQRHaI5F9EH+32hZoUqC
         BgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ACPkTDQAZK0xYByBduKtvlFnDRihFgFiCOEVqxw6X2g=;
        b=K4ZKHMZzGgAEh2JTh6aTfYrNkXUHM1CtU5wloy1XsLObUre/tEzo51j4wXJQyaRWbI
         Ugz3a8jm1Qgx1feU30aBiQjaZDDccrAK+wlANqNDPBc0GPCA70JqHVt4g8SuFc7HqpFf
         JRZ2irT4LEejoHqdkYJklyfdkxANRp0BZOQckwTTwjDmRPtt7h750m+VzO+tWMqHe9aE
         3nyX75zd71Lczssw0E4cLd3Gb7Nuelndw1vEOw3UzDoA7detk6Z4zwo3v0I3P/7Ja1L0
         JDSnj2mnRu6E8+AYGoJ3S3qVnvZsbtbVDzT03YP1+oplsdvHbD7PxbcDu7SVEaTADuJz
         5MCA==
X-Gm-Message-State: AOAM533fEdmph/XUPAz6uYnCg9he5CKIs1aT38Q5/Z7wNacJld+/Hcf8
        3Q7KyGjJHvNtAP8kVE66vJo=
X-Google-Smtp-Source: ABdhPJxwurX3dNLk+ame9lLugghLH/YZ8IMW6y2md6c7oeMLVSu2FXm76TyIitnkW09vNgneQ/ZELw==
X-Received: by 2002:a19:86c2:: with SMTP id i185mr1331525lfd.457.1606399197965;
        Thu, 26 Nov 2020 05:59:57 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id a11sm605188ljj.4.2020.11.26.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:59:57 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 2/2] PCI: brcmstb: support BCM4908 with external PERST# signal controller
Date:   Thu, 26 Nov 2020 14:59:39 +0100
Message-Id: <20201126135939.21982-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201126135939.21982-1-zajec5@gmail.com>
References: <20201126135939.21982-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 uses external MISC block for controlling PERST# signal. Use it
as a reset controller.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pcie-brcmstb.c | 33 +++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..d44c70bb88f6 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -273,7 +273,7 @@ config VMD
 
 config PCIE_BRCMSTB
 	tristate "Broadcom Brcmstb PCIe host controller"
-	depends on ARCH_BRCMSTB || ARCH_BCM2835 || COMPILE_TEST
+	depends on ARCH_BRCMSTB || ARCH_BCM2835 || ARCH_BCM4908 || COMPILE_TEST
 	depends on OF
 	depends on PCI_MSI_IRQ_DOMAIN
 	default ARCH_BRCMSTB
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 9c3d2982248d..10023da323d5 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -96,6 +96,7 @@
 
 #define PCIE_MISC_REVISION				0x406c
 #define  BRCM_PCIE_HW_REV_33				0x0303
+#define  BRCM_PCIE_HW_REV_3_20				0x0320
 
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT		0x4070
 #define  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK	0xfff00000
@@ -190,6 +191,7 @@
 struct brcm_pcie;
 static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val);
+static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
 
@@ -205,6 +207,7 @@ enum {
 };
 
 enum pcie_type {
+	BCM4908,
 	GENERIC,
 	BCM7278,
 	BCM2711,
@@ -230,6 +233,13 @@ static const struct pcie_cfg_data generic_cfg = {
 	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
 };
 
+static const struct pcie_cfg_data bcm4908_cfg = {
+	.offsets	= pcie_offsets,
+	.type		= BCM4908,
+	.perst_set	= brcm_pcie_perst_set_4908,
+	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
+};
+
 static const int pcie_offset_bcm7278[] = {
 	[RGR1_SW_INIT_1] = 0xc010,
 	[EXT_CFG_INDEX] = 0x9000,
@@ -282,6 +292,7 @@ struct brcm_pcie {
 	const int		*reg_offsets;
 	enum pcie_type		type;
 	struct reset_control	*rescal;
+	struct reset_control	*perst_reset;
 	int			num_memc;
 	u64			memc_size[PCIE_BRCM_MAX_MEMC];
 	u32			hw_rev;
@@ -747,6 +758,18 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
+static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
+{
+	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n") ||
+	    WARN_ONCE(pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20, "unsupported hardware revision\n"))
+		return;
+
+	if (val)
+		reset_control_assert(pcie->perst_reset);
+	else
+		reset_control_deassert(pcie->perst_reset);
+}
+
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
 {
 	u32 tmp;
@@ -1206,6 +1229,7 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
@@ -1262,11 +1286,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		clk_disable_unprepare(pcie->clk);
 		return PTR_ERR(pcie->rescal);
 	}
+	pcie->perst_reset = devm_reset_control_get_optional_shared(&pdev->dev, "perst");
+	if (IS_ERR(pcie->perst_reset)) {
+		clk_disable_unprepare(pcie->clk);
+		return PTR_ERR(pcie->perst_reset);
+	}
 
 	ret = reset_control_deassert(pcie->rescal);
 	if (ret)
 		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
 
+	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
+
 	ret = brcm_phy_start(pcie);
 	if (ret) {
 		reset_control_assert(pcie->rescal);
@@ -1278,8 +1309,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-
 	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
 	if (pci_msi_enabled() && msi_np == pcie->np) {
 		ret = brcm_pcie_enable_msi(pcie);
-- 
2.26.2

