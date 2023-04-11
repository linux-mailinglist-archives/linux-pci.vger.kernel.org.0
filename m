Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85E96DE1B0
	for <lists+linux-pci@lfdr.de>; Tue, 11 Apr 2023 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjDKQ7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Apr 2023 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDKQ7f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Apr 2023 12:59:35 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A17D55AE;
        Tue, 11 Apr 2023 09:59:31 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso11677744pjs.0;
        Tue, 11 Apr 2023 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681232370; x=1683824370;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pz7RRU4Oi3qZv3Qdyqljld/j1CUJUkM+0FqeJPWLDVw=;
        b=gcpL9u+yTli4Khhf+9R67jknSpYlyDm2uletw7svjMvqipcYdajonTjV7wtuj8jBKO
         3Q+1OAEO+T6PF8QBkuc5Molr4qcEwBB+cI0/+vVxKh7hGNUCOkTknAsHlN5uy25WsOII
         AhjmftM2otJoUmBnykkdgEU844d/f2Sk/YnC3pz4CZWiyVBmcA7WUKu7zl6RsMwm9Uc5
         O9KSnxVBOVtHdgtbS0tCCnOy1cvLLV4zbk8iC++rri4yQJ9xGc9vDh3hhcG84OmEGhqc
         iXKbr8xLe4vLEo2WATukcr1Ja4FVmIlq9++84Byh6piB/3Du1/X78dqbaGq64yPDEJ5/
         PKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232370; x=1683824370;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pz7RRU4Oi3qZv3Qdyqljld/j1CUJUkM+0FqeJPWLDVw=;
        b=Oj1abWk7Sk9gnKNnRqQ4xIesXgE70tbTC4gWjLmgIH271X6bTgTTNipQtmgPLaNUOh
         uc1VONddSPew4ujRExcirGl+2ZYmv7hOBhTBUmJ+q1mAJ1GCogWUZBGDnyn89QcolDyY
         jIg8e+VhKya3oGlHRqKUbwVUa9MLKF5qC+cKv2SM7BOTQAOKjO5HcartEgyfO+3lkI+h
         IbnOhE+VqR+fBBYrW89EYNY0TuN4b6uP/KUNReyPTIbWEO+RWZrIQ14RKfc6qisbJ0tP
         Skch0BVpFRnden1k37kRTdbmjwFVKQsuRtCNeaoZbOoxiRDt3CGrGaZSCBl6lj/rIWbw
         Yuhg==
X-Gm-Message-State: AAQBX9dcT4ZiHZV/ipPG0GIIyiIMNqrONf4iYtruAYxNeL92siGknRKb
        tJMbV+2/po+DOOHlj2r1bKFpa2o9q0A=
X-Google-Smtp-Source: AKy350a/aXYFy5VtjtJkN4Wa3nk6Q34ae7qff6JsZNKrhRQtyfBBFfgLuDP1TCAdb29CXMJiL2akvw==
X-Received: by 2002:a05:6a20:6d9a:b0:d9:3440:9a26 with SMTP id gl26-20020a056a206d9a00b000d934409a26mr14558006pzb.20.1681232370451;
        Tue, 11 Apr 2023 09:59:30 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id m6-20020aa79006000000b0063989aab89fsm3484519pfo.23.2023.04.11.09.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:59:30 -0700 (PDT)
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
Subject: [PATCH v2 2/3] PCI: brcmstb: CLKREQ# accomodations of downstream device
Date:   Tue, 11 Apr 2023 12:59:17 -0400
Message-Id: <20230411165919.23955-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230411165919.23955-1-jim2101024@gmail.com>
References: <20230411165919.23955-1-jim2101024@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, must be
deliberately set by the probe() into one of three mutually exclusive modes:

  (a) No CLKREQ# expected or required, refclk is always available.
  (b) CLKREQ# is expected to be driven by downstream device when needed.
  (c) Bidirectional CLKREQ# for L1SS capable devices.

Previously, only (b) was supported by the driver, as almost all STB/CM
boards operate in this mode.  But now there is interest in activating L1SS
power savings from STB/CM customers, and also interest in accomodating mode
(a) for designs such as the RPi CM4 with IO board.

The HW+driver is able to tell us when mode (a) mode is needed.  But there
is no easy way to tell if L1SS mode should be configured.  In certain
situations, getting this wrong may cause a panic during boot time.  So we
rely on the DT prop "brcm,enable-l1ss" to tell us when mode (c) is desired.
Using this mode only makes sense when the downstream device is L1SS-capable
and the OS has been configured to activate L1SS
(e.g. policy==powersupersave).

This property has already been in use by Raspian Linux, but this
immplementation adds more details and discerns between (a) and (b)
automatically.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index edf283e2b5dd..56b96aa02221 100644
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
+		 * Note: This (l1ss) mode may not meet requirement for
+		 * downstream devices that require CLKREQ# assertion to
+		 * clock active within 400ns.
+		 */
+		clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
+		dev_info(pcie->dev, "bi-dir CLKREQ# for l1ss-capable devs\n");
+		dev_info(pcie->dev, "ASPM policy should be set to \"powersupersave\"\n");
+	} else {
+		if (clkreq_in_seen && IS_ENABLED(CONFIG_PCIEASPM)) {
+			clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
+			dev_info(pcie->dev, "uni-dir CLKREQ# for ASPM\n");
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

