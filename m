Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347903ED455
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 14:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhHPMv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Aug 2021 08:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhHPMv4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Aug 2021 08:51:56 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A43C061764
        for <linux-pci@vger.kernel.org>; Mon, 16 Aug 2021 05:51:25 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id r9so24737608lfn.3
        for <linux-pci@vger.kernel.org>; Mon, 16 Aug 2021 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qZdhYYT1zB+MdC+Yqp4whvhQkhkLU/Csdaetwkst58=;
        b=LNMI+vqIUvJzBhhCtX6uk4LLm8f3FA9UJFhfXLpoTff6EgpuZaND8FrW/Dl7kWUIl6
         88XkPJnkN3w+TRL3iz7PkUhAqZyNeeuatth6K694weFvsGfHA1X6EZ337qDupAe9jqnl
         Cexwkl9vrvSyPIG8OfWAVSava27pWK22pEqSXZOVg0ugzB5DdV1bbe0+WMYoxKpBUaHh
         zCMyC6uNjwcPfmEjtZMQFcMZQAEB/zHFneuhdIhAnb4jFW8wv+TXGdc4wyzNcrZ4gqbf
         g5XuhlrWhasZEF1vwASBw7HQtD3DbEH/GkzPpHalscypDyTWBHaLFS2+hi6fKCySC9Gz
         61Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5qZdhYYT1zB+MdC+Yqp4whvhQkhkLU/Csdaetwkst58=;
        b=pTlxfhjSITElBNHUEc5y5a4Lq5FZqSSwFEIk0vGgcMfxeAHSysXek203a0ozNlYk9T
         emh0ow4dQZBmQJzligvodITuMmsHNPcKfaZse8iGxZ98VrHqImyN34OVpzofk8opaGVp
         oF1vZvcyXKNslOKl7YLxnZC4Fa1Siubl+32V3yEyOBkjlDTmMRTWRkIcbRgpb8YydAt0
         1F+wU7kbWy2M/ahDKYfUwKp+4SRW6XALLQRkufcR2X0PxPiJzeX887ydR0Mnep8FYtVi
         gOai6yo0tZMmt1hFoloCjk7S5QWX0MAdEiLg/kRRFia1i/wd6SQvffwXZhspO42hnxsI
         +fFA==
X-Gm-Message-State: AOAM533HwYK4DDTUI9VHtSdCg9WZNxBGGT2yLSQT+0QBDS9TH4xzoL9t
        WTSsn4nuxLlMvR//0AIoZZE=
X-Google-Smtp-Source: ABdhPJydKm4xrIQEVfZZwEZj1TD8+hxFbtc7NSwwNsEuHXW1lIepJ8N1GzkEvA5C5LVrjzGQqQnftg==
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr12112940lfo.66.1629118283669;
        Mon, 16 Aug 2021 05:51:23 -0700 (PDT)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id j15sm954635ljq.108.2021.08.16.05.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 05:51:23 -0700 (PDT)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH] PCI: brcmstb: implement BCM4908 support
Date:   Mon, 16 Aug 2021 14:50:29 +0200
Message-Id: <20210816125029.16879-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

BCM4908 is Broadcom's 64-bit platform with Broadcom's own Brahma-B53
CPU(s). It uses the same PCIe hardware block as STB (Set-Top-Box) family
but in a slightly different revision & setup.

Registers in BCM4908 variant are mostly the same but controller setup
differs a bit. It requires setting few extra registers and takes
slightly different bars setup.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 drivers/pci/controller/pcie-brcmstb.c | 137 +++++++++++++++++++++++---
 1 file changed, 123 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index cc30215f5a43..24bc7efcfdd5 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -51,15 +51,20 @@
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
 #define PCIE_MISC_MISC_CTRL				0x4008
+#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE		0x00000080
+#define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE		0x00000400
+#define  PCIE_MISC_MISC_CTRL_PCIE_IN_WR_COMBINE		0x00000800
 #define  PCIE_MISC_MISC_CTRL_SCB_ACCESS_EN_MASK		0x1000
 #define  PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK	0x2000
 #define  PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK	0x300000
+#define  PCIE_MISC_MISC_CTRL_BURST_ALIGN_MASK		0x00080000
 
 #define  PCIE_MISC_MISC_CTRL_SCB0_SIZE_MASK		0xf8000000
 #define  PCIE_MISC_MISC_CTRL_SCB1_SIZE_MASK		0x07c00000
 #define  PCIE_MISC_MISC_CTRL_SCB2_SIZE_MASK		0x0000001f
 #define  SCB_SIZE_MASK(x) PCIE_MISC_MISC_CTRL_SCB ## x ## _SIZE_MASK
 
+
 #define PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO		0x400c
 #define PCIE_MEM_WIN0_LO(win)	\
 		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LO + ((win) * 8)
@@ -115,6 +120,9 @@
 #define PCIE_MEM_WIN0_LIMIT_HI(win)	\
 		PCIE_MISC_CPU_2_PCIE_MEM_WIN0_LIMIT_HI + ((win) * 8)
 
+#define PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_OFFSET		0x40ac
+#define  PCIE_MISC_UBUS_BAR_CONFIG_ACCESS_EN		0x00000001
+
 #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
@@ -131,6 +139,13 @@
 #define PCIE_EXT_CFG_DATA				0x8000
 #define PCIE_EXT_CFG_INDEX				0x9000
 
+#define PCIE_CPU_INTR1_INTR_MASK_CLEAR_OFFSET		0x940c
+#define  PCIE_CPU_INTR1_PCIE_INTA_CPU_INTR		0x00000002
+#define  PCIE_CPU_INTR1_PCIE_INTB_CPU_INTR		0x00000004
+#define  PCIE_CPU_INTR1_PCIE_INTC_CPU_INTR		0x00000008
+#define  PCIE_CPU_INTR1_PCIE_INTD_CPU_INTR		0x00000010
+#define  PCIE_CPU_INTR1_PCIE_INTR_CPU_INTR		0x00000020
+
 #define  PCIE_RGR1_SW_INIT_1_PERST_MASK			0x1
 #define  PCIE_RGR1_SW_INIT_1_PERST_SHIFT		0x0
 
@@ -746,13 +761,19 @@ static inline void brcm_pcie_bridge_sw_init_set_7278(struct brcm_pcie *pcie, u32
 
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val)
 {
-	if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
-		return;
+	if (pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
+		brcm_pcie_perst_set_7278(pcie, val);
+	} else {
+		if (WARN_ONCE(!pcie->perst_reset, "missing PERST# reset controller\n"))
+			return;
 
-	if (val)
-		reset_control_assert(pcie->perst_reset);
-	else
-		reset_control_deassert(pcie->perst_reset);
+		if (val)
+			reset_control_assert(pcie->perst_reset);
+		else
+			reset_control_deassert(pcie->perst_reset);
+	}
+
+	usleep_range(10000, 20000);
 }
 
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val)
@@ -861,6 +882,86 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 	return 0;
 }
 
+static int brcm_pcie_setup_bcm4908(struct brcm_pcie *pcie)
+{
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	void __iomem *base = pcie->base;
+	struct device *dev = pcie->dev;
+	struct resource_entry *entry;
+	u32 burst_align;
+	u32 burst;
+	u32 tmp;
+	int win;
+
+	pcie->perst_set(pcie, 0);
+
+	msleep(500);
+
+	if (!brcm_pcie_link_up(pcie)) {
+		dev_err(dev, "link down\n");
+		return -ENODEV;
+	}
+
+	/* setup lgacy outband interrupts */
+	tmp = PCIE_CPU_INTR1_PCIE_INTA_CPU_INTR |
+	      PCIE_CPU_INTR1_PCIE_INTB_CPU_INTR |
+	      PCIE_CPU_INTR1_PCIE_INTC_CPU_INTR |
+	      PCIE_CPU_INTR1_PCIE_INTD_CPU_INTR;
+	writel(tmp, base + PCIE_CPU_INTR1_INTR_MASK_CLEAR_OFFSET);
+
+	win = 0;
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		struct resource *res = entry->res;
+		u64 pcie_addr;
+
+		if (resource_type(res) != IORESOURCE_MEM)
+			continue;
+
+		if (win >= BRCM_NUM_PCIE_OUT_WINS) {
+			dev_err(pcie->dev, "too many outbound wins\n");
+			return -EINVAL;
+		}
+
+		tmp = 0;
+		u32p_replace_bits(&tmp, res->start / SZ_1M,
+				  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_BASE_MASK);
+		u32p_replace_bits(&tmp, res->end / SZ_1M,
+				  PCIE_MISC_CPU_2_PCIE_MEM_WIN0_BASE_LIMIT_LIMIT_MASK);
+		writel(tmp, base + PCIE_MEM_WIN0_BASE_LIMIT(win));
+
+		pcie_addr = res->start - entry->offset;
+		writel(lower_32_bits(pcie_addr), pcie->base + PCIE_MEM_WIN0_LO(win));
+		writel(upper_32_bits(pcie_addr), pcie->base + PCIE_MEM_WIN0_HI(win));
+
+		win++;
+	}
+
+	writel(0xf, base + PCIE_MISC_RC_BAR1_CONFIG_LO);
+
+	tmp = PCIE_MISC_UBUS_BAR_CONFIG_ACCESS_EN;
+	writel(tmp, base + PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_OFFSET);
+
+	tmp = readl(base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+	u32p_replace_bits(&tmp, PCI_CLASS_BRIDGE_PCI << 8,
+			  PCIE_RC_CFG_PRIV1_ID_VAL3_CLASS_CODE_MASK);
+	writel(tmp, base + PCIE_RC_CFG_PRIV1_ID_VAL3);
+
+	/* Burst */
+	burst = 0x1; /* 128 B */
+	burst_align = 1;
+
+	tmp = readl(base + PCIE_MISC_MISC_CTRL);
+	u32p_replace_bits(&tmp, burst_align, PCIE_MISC_MISC_CTRL_BURST_ALIGN_MASK);
+	u32p_replace_bits(&tmp, burst, PCIE_MISC_MISC_CTRL_MAX_BURST_SIZE_MASK);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_CFG_READ_UR_MODE_MASK);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_IN_WR_COMBINE);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE);
+	u32p_replace_bits(&tmp, 1, PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE);
+	writel(tmp, base + PCIE_MISC_MISC_CTRL);
+
+	return 0;
+}
+
 static int brcm_pcie_setup(struct brcm_pcie *pcie)
 {
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
@@ -1284,6 +1385,13 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->perst_reset);
 	}
 
+	if (pcie->type == BCM4908) {
+		/* On BCM4908 we can read rev early and perst_set needs it */
+		pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
+
+		pcie->perst_set(pcie, 1);
+	}
+
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
@@ -1295,16 +1403,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = brcm_pcie_setup(pcie);
-	if (ret)
-		goto fail;
+	if (pcie->type == BCM4908) {
+		ret = brcm_pcie_setup_bcm4908(pcie);
+		if (ret)
+			goto fail;
+	} else {
+		ret = brcm_pcie_setup(pcie);
+		if (ret)
+			goto fail;
+	}
 
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
-	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
-		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
-		ret = -ENODEV;
-		goto fail;
-	}
 
 	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
 	if (pci_msi_enabled() && msi_np == pcie->np) {
-- 
2.26.2

