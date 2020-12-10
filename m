Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E55F2D646B
	for <lists+linux-pci@lfdr.de>; Thu, 10 Dec 2020 19:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404046AbgLJSFa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Dec 2020 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391429AbgLJSFY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Dec 2020 13:05:24 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36778C061793;
        Thu, 10 Dec 2020 10:04:44 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id b10so5398717ljp.6;
        Thu, 10 Dec 2020 10:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2pscJBqzkM2zDI7JC2pNLpw87RIapi+iZ8V2MUxssg=;
        b=neIjQRqLRs8+RHrvKWzprlomtojZHDMDVa3OnL58IjT/RQP66axILI0xv1SLZPembe
         b6w6ji9JnkDciiztRW/o0rRDJIh+LlBPjPrgt89psKH0zuncU8zovy4f6Sp0wudHsopD
         AjedyzYbOUGZG+5CLICQVdUq/MNFeFNqqC0DyZma1tjkAKRpWSXvStnp7+SQ7/oRdiXg
         j0HWueI3Ns9vUFPmBfruzSY9PSYemn+zZ81Hg+LMvN+hjMtCB1lxSMTKFC92QoXxCvqN
         vt0pdcUHZMzKqNzEX05wKWMys3jA4eRpXnQQ0/QdVQdKukv1fAifhTBfZtg2KlTSBZMP
         ELdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2pscJBqzkM2zDI7JC2pNLpw87RIapi+iZ8V2MUxssg=;
        b=dfhRlKRTTsVpIq8nlsBwImNVMwRdpyOwjFy3PXN5Yqbl0fjhATDWQGLc7X+LWZH/hO
         2fFJqJ9zyGKmST9NaJla2PFHZp8eJRSQ3cHGdSfKki5N9Vs421KEk9hB4hDaOtTCFzTm
         jk8tt1k009CWDxHdeiw+B9XGY+P0j3jIWb9nfY7dUcdqeo/CmbP9sVIHoRdePzEJzrmZ
         vnnbyHjW/TI9fouACpRYf1s6MALUX+qJqxswm+pOOe94D/Zoh6qZ2sC2VWBRB+/ZHT06
         B3GRglqSt0GSw3UqpNK7x++ScHFfDI8ALGth93In6BqVqb444Jp+d/lPsUSAL0/oQnoP
         9Yww==
X-Gm-Message-State: AOAM531hVGa1r8FBKpSPAbJ6KAj9388C3UTi+KePwOk8bv7hDIdAkkuL
        WQp7f8SRCBYM/RH9jCVelug=
X-Google-Smtp-Source: ABdhPJw1BV90OYZi0tKInUs0nesy6tFd9q+9u63aIEriW/zyil4vnntrEVS+x9RYY4np1Vt9h9dKjw==
X-Received: by 2002:a2e:8346:: with SMTP id l6mr3517312ljh.132.1607623482765;
        Thu, 10 Dec 2020 10:04:42 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id c136sm601855lfg.306.2020.12.10.10.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 10:04:42 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH v3 2/2] PCI: brcmstb: support BCM4908 with external PERST# signal controller
Date:   Thu, 10 Dec 2020 19:04:21 +0100
Message-Id: <20201210180421.7230-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201210180421.7230-1-zajec5@gmail.com>
References: <20201210180421.7230-1-zajec5@gmail.com>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
V2: Reorder BCM4908 in the enum pcie_type
    Use devm_reset_control_get_optional_exclusive()
    Don't move hw_rev read up in the code
---
 drivers/pci/controller/Kconfig        |  2 +-
 drivers/pci/controller/pcie-brcmstb.c | 32 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

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
index 9c3d2982248d..98536cf3af58 100644
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
 
@@ -206,6 +208,7 @@ enum {
 
 enum pcie_type {
 	GENERIC,
+	BCM4908,
 	BCM7278,
 	BCM2711,
 };
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
@@ -747,6 +758,17 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
 	writel(tmp, pcie->base + PCIE_RGR1_SW_INIT_1(pcie));
 }
 
+static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
+{
+	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
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
@@ -1206,6 +1228,7 @@ static int brcm_pcie_remove(struct platform_device *pdev)
 
 static const struct of_device_id brcm_pcie_match[] = {
 	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
+	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
 	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
 	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
 	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7278_cfg },
@@ -1262,6 +1285,11 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		clk_disable_unprepare(pcie->clk);
 		return PTR_ERR(pcie->rescal);
 	}
+	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
+	if (IS_ERR(pcie->perst_reset)) {
+		clk_disable_unprepare(pcie->clk);
+		return PTR_ERR(pcie->perst_reset);
+	}
 
 	ret = reset_control_deassert(pcie->rescal);
 	if (ret)
@@ -1279,6 +1307,10 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		goto fail;
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
+	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
+		goto fail;
+	}
 
 	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
 	if (pci_msi_enabled() && msi_np == pcie->np) {
-- 
2.26.2

