Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BED86FBABA
	for <lists+linux-pci@lfdr.de>; Tue,  9 May 2023 00:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbjEHWCC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 8 May 2023 18:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjEHWBm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 May 2023 18:01:42 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C94B7EF5;
        Mon,  8 May 2023 15:01:32 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f390fb063cso6536471cf.2;
        Mon, 08 May 2023 15:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683583291; x=1686175291;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JVDegyPLBHaeO/WL6svk+oLQ/anSvMh7xAxroWOQujU=;
        b=kTuy8jqFysJuvLb7gnRL5Tqn246Ww5uOuoqtvhrdCLtHoEmtnlt8PK/43Z7pITTDOV
         0vupBIf44m/pTISNw1bmMG0cV2wD9WebIfnAfOLxoBK/BrbKHvA4nleqlNy2AnzZLPRU
         993+98UWaf6T4pBTh5nIuWxlgU01PMqT2ux0X8hxiebpWklXCMQdWdA0ToljzxxJFDPy
         4nbFbJFsoysAwpZzlwTK5DQ7Y21wNrORYodO3bQKcmWXC2/GHMsEOtTYNrXKEUZmZwPr
         0tXJqcif20Cpp8l4FfYT8D3gRr5o9j8O7tbGwLtDRkYE5UMEBlLRt3Jl0l30iGb2FrJ6
         NyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583291; x=1686175291;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVDegyPLBHaeO/WL6svk+oLQ/anSvMh7xAxroWOQujU=;
        b=GWK2wYPWbriZR0kMJf3blDzjqIugjBDuO7nw1tzuHeZBfEkLot2niU4HltRnJ696Mc
         bbCQmahgUI48jkgKPI/jQbMV8eqUv7BUjBIsPZnNYJ6dz98FlQ7McgW+wp0IAFo7pD6G
         YZPr6ibSZyi8HZpSCk4owkgoxPf6nzaGU6WZTF/QqfgWBfPxmMfK1ZXrvVntTZN5vxer
         n7gzPnqhIvOOsnGThhPD2Aye5NZFiTaLR/4yjlNFc8EHPd0QmlqHaO1z8fazpsgrqsGm
         8y+sIGkT233hZl3iOkzgU0HyHwSxNTOxponcwuX5KXoT0GOw4aDJg/KTk5emz8yMcDTQ
         w1vA==
X-Gm-Message-State: AC+VfDx11petd08/sKIYtTGLCVXwmfKTYHUcVTz/PKlbGsGIM3K2sf99
        3ReFV8WVPKt3zA+ls+L0zkv4C7RWGfw=
X-Google-Smtp-Source: ACHHUZ5tYolHrufdF+0JL6lhhjvNKX9zGy6sdY2SImZ4jU4plm9dpx5gneEl3qUFV/aey1NA6jqiSw==
X-Received: by 2002:a05:622a:11c3:b0:3ee:b9bd:8da2 with SMTP id n3-20020a05622a11c300b003eeb9bd8da2mr18681205qtk.19.1683583291398;
        Mon, 08 May 2023 15:01:31 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id e11-20020ac8010b000000b003d7e923736asm3315176qtg.6.2023.05.08.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:01:31 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 2/5] PCI: brcmstb: Configure HW CLKREQ# mode appropriate for downstream device
Date:   Mon,  8 May 2023 18:01:22 -0400
Message-Id: <20230508220126.16241-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230508220126.16241-1-jim2101024@gmail.com>
References: <20230508220126.16241-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
deliberately set by the RC probe() into one of three mutually exclusive
modes:

  (a) No CLKREQ# expected or required, refclk is always available.
  (b) CLKREQ# is expected to be driven by downstream device when needed.
  (c) Bidirectional CLKREQ# for L1SS capable devices.

Previously, only (b) was supported by the driver, as almost all STB/CM
boards operate in this mode.  But now there is interest in activating L1SS
power savings from STB/CM customers, and also interest in accommodating
mode (a) for designs such as the RPi CM4 with IO board.

The HW+driver is able to tell us when mode (a) or (b) is needed.  All
devices should be functional using the RC-driver selected (a) or (b) mode.
For those with L1SS-capable devices that desire the power savings that come
with mode (c) we rely on the DT prop "brcm,enable-l1ss".  It would be nice
to do this automatically but there is no easy way to determine this at the
time the PCI RC driver executes its probe().  Using this mode only makes
sense when the downstream device is L1SS-capable and the OS has been
configured to activate L1SS (e.g. policy==powersupersave).

The "brcm,enable-l1ss" property has already been in use by Raspian Linux,
but this implementation adds more details and discerns between (a) and (b)
automatically.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index edf283e2b5dd..d30636a725d7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -48,10 +48,17 @@
 #define PCIE_RC_CFG_PRIV1_LINK_CAPABILITY			0x04dc
 #define  PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK	0xc00
 
+#define PCIE_RC_CFG_PRIV1_ROOT_CAP			0x4f8
+#define  PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK	0xf8
+
 #define PCIE_RC_DL_MDIO_ADDR				0x1100
 #define PCIE_RC_DL_MDIO_WR_DATA				0x1104
 #define PCIE_RC_DL_MDIO_RD_DATA				0x1108
 
+#define PCIE_0_RC_PL_PHY_DBG_CLKREQ2_0			0x1e30
+#define  CLKREQ2_0_CLKREQ_IN_CNT_MASK			0x3f000000
+#define  CLKREQ2_0_CLKREQ_IN_MASK			0x40000000
+
 #define PCIE_MISC_MISC_CTRL				0x4008
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_64B_MODE_MASK	0x80
 #define  PCIE_MISC_MISC_CTRL_PCIE_RCB_MPS_MODE_MASK	0x400
@@ -121,9 +128,12 @@
 
 #define PCIE_MISC_HARD_PCIE_HARD_DEBUG					0x4204
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK	0x2
+#define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK		0x200000
 #define  PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x08000000
 #define  PCIE_BMIPS_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK		0x00800000
-
+#define  PCIE_CLKREQ_MASK \
+	  (PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK | \
+	   PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK)
 
 #define PCIE_INTR2_CPU_BASE		0x4300
 #define PCIE_MSI_INTR2_BASE		0x4500
@@ -1024,13 +1034,58 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	return 0;
 }
 
+static void brcm_config_clkreq(struct brcm_pcie *pcie)
+{
+	bool l1ss = of_property_read_bool(pcie->np, "brcm,enable-l1ss");
+	void __iomem *base = pcie->base;
+	u32 clkreq_set, tmp = readl(base + PCIE_0_RC_PL_PHY_DBG_CLKREQ2_0);
+	bool clkreq_in_seen;
+
+	/*
+	 * We have "seen" CLKREQ# if it is asserted or has been in the past.
+	 * Note that the CLKREQ_IN_MASK is 1 if CLKREQ# is asserted.
+	 */
+	clkreq_in_seen = !!(tmp & CLKREQ2_0_CLKREQ_IN_MASK) ||
+		!!FIELD_GET(CLKREQ2_0_CLKREQ_IN_CNT_MASK, tmp);
+
+	/* Start with safest setting where we provide refclk regardless */
+	clkreq_set = readl(pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG) &
+		~PCIE_CLKREQ_MASK;
+
+	if (l1ss && IS_ENABLED(CONFIG_PCIEASPM)) {
+		/*
+		 * Note: For boards using a mini-card connector, this mode
+		 * (L1SS CLKREQ# mode) may not meet the TCRLon maximum time
+		 * of 400ns, as specified in 3.2.5.2.2 of the PCI Express
+		 * Mini CEM 2.0 specification.
+		 */
+		clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
+		dev_info(pcie->dev, "bi-dir CLKREQ# for L1SS power savings");
+	} else {
+		if (clkreq_in_seen && IS_ENABLED(CONFIG_PCIEASPM)) {
+			clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
+			dev_info(pcie->dev, "uni-dir CLKREQ# for L0s, L1 ASPM\n");
+		} else {
+			dev_info(pcie->dev, "CLKREQ# ignored; no ASPM\n");
+			/* Might as well unadvertise ASPM */
+			tmp = readl(base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY) &
+				~PCIE_RC_CFG_PRIV1_LINK_CAPABILITY_ASPM_SUPPORT_MASK;
+			writel(tmp, base + PCIE_RC_CFG_PRIV1_LINK_CAPABILITY);
+		}
+		/* Setting the field to 2 unadvertises L1SS support */
+		tmp = readl(base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
+		u32p_replace_bits(&tmp, 2, PCIE_RC_CFG_PRIV1_ROOT_CAP_L1SS_MODE_MASK);
+		writel(tmp, base + PCIE_RC_CFG_PRIV1_ROOT_CAP);
+	}
+	writel(clkreq_set, pcie->base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
+}
+
 static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 {
 	struct device *dev = pcie->dev;
 	void __iomem *base = pcie->base;
 	u16 nlw, cls, lnksta;
 	bool ssc_good = false;
-	u32 tmp;
 	int ret, i;
 
 	/* Unassert the fundamental reset */
@@ -1055,6 +1110,8 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		return -ENODEV;
 	}
 
+	brcm_config_clkreq(pcie);
+
 	if (pcie->gen)
 		brcm_pcie_set_gen(pcie, pcie->gen);
 
@@ -1073,14 +1130,6 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
 		 pci_speed_string(pcie_link_speed[cls]), nlw,
 		 ssc_good ? "(SSC)" : "(!SSC)");
 
-	/*
-	 * Refclk from RC should be gated with CLKREQ# input when ASPM L0s,L1
-	 * is enabled => setting the CLKREQ_DEBUG_ENABLE field to 1.
-	 */
-	tmp = readl(base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
-	tmp |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
-	writel(tmp, base + PCIE_MISC_HARD_PCIE_HARD_DEBUG);
-
 	return 0;
 }
 
-- 
2.17.1

