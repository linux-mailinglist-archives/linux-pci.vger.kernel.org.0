Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE12B2C8007
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 09:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgK3Idi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 03:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgK3Idh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 03:33:37 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268EEC0613D4;
        Mon, 30 Nov 2020 00:32:57 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id y10so16472995ljc.7;
        Mon, 30 Nov 2020 00:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HyXbdo2hXDjhZebrj1MjXRgu3sgvcOhu5l8NPDQBwRI=;
        b=WJ5AxPuYwLEAJRDdmAsTi8cZHbG2C1sDtyObblBhGXjJJFHcpe6gjSskGed2AgSZdp
         d3YXocVCwGt8ep0xsYgz+r91onJh4GnwdmcK/6L1TlxZpzqb8RToXnYBQAEaHS8EWiwy
         QXslelUKLHG8HoMC0RxM97yiEW4aQe9sJmwBYt/xFvgB2p3S7sH/vlvebBW0C8a6G5LH
         Ljvv7PbpnTg2YjPL6Jv0TXjXC9Of2SA9M5cVmWUCJ+9l2YXrGc7sjXoIHpBCfPtXya+L
         uddgtiygw7Gs3KtO/cTNZBILyXLw8dBtFd1pfN3tSb+Zt7V3BpqFBtdessu5Ml1zKm/W
         LOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyXbdo2hXDjhZebrj1MjXRgu3sgvcOhu5l8NPDQBwRI=;
        b=OGCGVCCecIbFlAfpwocVRm57zvjhqeUkZ5ycS13pXlPF8DApBdFUUW78wJHIbooqmt
         sa2rM3rfUwSvb/cNXfr1IzOuPmA6FoaRwiAYzi49COlf39+znSLWist+I6hDhfalqQ17
         C4/zRNdjcxKfq8DitHrbSlYYCD/dAj84Ma45S8yfMaEX5ZVjAk/rs8rq0XgxsScDQAQk
         vs5x+6KYbppdzIvJadG0MSQiI3PCV9m+KxKL0X5kNXX/BFFGFzBsAQ+d2L4pDUwxtnLZ
         OfpzYaAGFHkQz9SOw5ibJpEvbA9emOQrwzMNmy74xKePfkwJb+wsnjuMdnY99n6vTcrU
         YSiw==
X-Gm-Message-State: AOAM530mcS9KNDbJkrSO0SY9Btrmclzyi/W6wZ1m2Hf8UTrloXY8rYZW
        szVuThRSemOwq+XWpY+xwLFHiRYIkTE=
X-Google-Smtp-Source: ABdhPJy6IT6LoolcCk/kaXobihraCsDZDLQCY0VHa91NksmJz9Ctv3qa0cg9dS2PCZswndkINvIVQQ==
X-Received: by 2002:a05:651c:c7:: with SMTP id 7mr8636307ljr.116.1606725175530;
        Mon, 30 Nov 2020 00:32:55 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id y81sm2355420lfc.100.2020.11.30.00.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:32:54 -0800 (PST)
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
Subject: [PATCH V2 2/2] PCI: brcmstb: support BCM4908 with external PERST# signal controller
Date:   Mon, 30 Nov 2020 09:32:23 +0100
Message-Id: <20201130083223.32594-3-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130083223.32594-1-zajec5@gmail.com>
References: <20201130083223.32594-1-zajec5@gmail.com>
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

