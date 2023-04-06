Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804D76D9739
	for <lists+linux-pci@lfdr.de>; Thu,  6 Apr 2023 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbjDFMqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Apr 2023 08:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236102AbjDFMql (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Apr 2023 08:46:41 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CE8688;
        Thu,  6 Apr 2023 05:46:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l12so39373280wrm.10;
        Thu, 06 Apr 2023 05:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680785197; x=1683377197;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VLxoW5y1R83hkSnD1MmOuzxD79U32sgmpKhC9YwkeDs=;
        b=bHz4rowJ+MjuUKIkFKvXR5vKVLrDKlEPY0EyjWJcNuDkiYy2pP/CGtk+wQtHbRtj/o
         khtPO2Vz+DwyyDhOG7wamf0DHO9gainxUYO+5pPqGW2sI8iZKR4dqpdmJzATCe+dzAq+
         BmwPzzodDVCapZ2xG7ht0JfQQy3H6HfkhcinoUelFkyEmZYDj9SvejC46e1ukn9Ssw0K
         2de/9ziaR4AFYxJLjzXXZGFd9KcvnHENwhexajYqC1rA0JXFnfoe/VKE/CtinaUOKzkm
         9Sszti+GKggVNiU8cEezo3+9Aegx51ieKrbApjDN9c08OYMGjs23wRXcTEZmDSRJoYwE
         XDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785197; x=1683377197;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VLxoW5y1R83hkSnD1MmOuzxD79U32sgmpKhC9YwkeDs=;
        b=D8pv+quijokM/o7I4sApyp0djpvXCrKpclRuhu8b5q72Q5nfDdd8j3b2qJB0TXy2bl
         4fJXp9WvmXmYN82lTMfKck3TzhXYDItz8Ebmd0r/7wNjrQ+prCKwNUlFIPvdooXHcefT
         wLS5WijfBcge0QEOYaKYqAEQTDXSIVoB0z4dFqqlXY6RNiPdqyqgoJIfbiulUtkwJTIT
         VcAV52UU+iGt+eRfzhLq5v6WIFAxm133jS1EdLbwJxgO5CvLC3GRkUv2cD7A9JW22qKw
         bIKEI5S1tCEn3R/vpXJmRAEI0+UIkhXIB6f5lInvF7aIlHzGqb6FBbeiCo/imTxfzhAI
         leiA==
X-Gm-Message-State: AAQBX9fxD2zZjmJb5BnibtcOlHazw5YsNf9WlSgOPHqS7JtChok54U8o
        gVZR5Dq2ZR83c3tPNlk/1Zf0ZrNkpxU=
X-Google-Smtp-Source: AKy350bqaDPR+pYT/WpBKiT+AlPWHWZ5fnJYBs9nDIIaxrq+hiW7GnxP0OclEbG8oA58u2Q5x+5Stw==
X-Received: by 2002:adf:ed51:0:b0:2ee:c582:a67d with SMTP id u17-20020adfed51000000b002eec582a67dmr1439826wro.31.1680785197400;
        Thu, 06 Apr 2023 05:46:37 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id n10-20020adff08a000000b002c5534db60bsm1686714wro.71.2023.04.06.05.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:46:36 -0700 (PDT)
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
Subject: [PATCH v1 2/3] PCI: brcmstb: Clkreq# accomodations of downstream device
Date:   Thu,  6 Apr 2023 08:46:23 -0400
Message-Id: <20230406124625.41325-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230406124625.41325-1-jim2101024@gmail.com>
References: <20230406124625.41325-1-jim2101024@gmail.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Broadcom STB/CM PCIe HW core, which is also used in RPi SOCs, may be
set into three mutually exclusive modes:

  (a) No clkreq# expected or required, refclk is always available.
  (b) Clkreq# is expected to be driven by downstream device when needed.
  (c) Bidirectional clkreq# for L1SS capable devices.

Previously, only (b) was supported by the driver, as almost all STB boards
operate in this mode.  But now there is interest in activating L1SS power
savings from STB customers, and also interest in accomodating mode (a) for
designs such as the RPi CM4 with IO board.

The HW can tell us when mode (a) mode is needed.  But there is no easy way
to tell if L1SS mode is needed.  Unfortunately, getting this wrong causes a
panic during boot time.  So we rely on the DT prop "brcm,enable-l1ss" to
tell us when mode (c) is desired.  This property has already been in
use by Raspian Linux, but this immplementation adds more details and
discerns between (a) and (b) automatically.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217276
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 69 +++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index edf283e2b5dd..129eee7bdbc1 100644
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
+	 * We have "seen" clkreq# if it is asserted or has been in the past.
+	 * Note that the CLKREQ_IN_MASK is 1 if clkreq# is asserted.
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
+		 * Endpoints that require CLKREQ# assertion to clock active
+		 * within 400ns.
+		 */
+		clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_L1SS_ENABLE_MASK;
+		dev_info(pcie->dev, "bi-dir clkreq; l1ss-capable devs only\n");
+		dev_info(pcie->dev, "ASPM policy must be set to powersupersave\n");
+	} else {
+		if (clkreq_in_seen && IS_ENABLED(CONFIG_PCIEASPM)) {
+			clkreq_set |= PCIE_MISC_HARD_PCIE_HARD_DEBUG_CLKREQ_DEBUG_ENABLE_MASK;
+			dev_info(pcie->dev, "uni-dir clkreq for ASPM\n");
+		} else {
+			dev_info(pcie->dev, "clkreq ignored; no ASPM\n");
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

