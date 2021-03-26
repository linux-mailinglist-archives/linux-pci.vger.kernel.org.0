Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0EA34AF33
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 20:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhCZTTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZTTS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 15:19:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053FC0613AA;
        Fri, 26 Mar 2021 12:19:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id dm8so7552923edb.2;
        Fri, 26 Mar 2021 12:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RkZZdk3QudoBe1sAkD0QhbZpJjcwJBNFIhvSYhdMvdI=;
        b=t+2UyPKsP4XR/NthDhhp2gU0ss4Ahhc+//T5Q4rYs4OpfFjQKmiXpN0Zer11AEr2JL
         naTyuWHWipdhLqLMfqDGq096qlSta8vKKLqeyGm18uCamymMSIhIzAyugwFCUWIS2cqm
         eo+J43o4BN743gQqOYOMpwmphYycNfuARBhJaZoP8u4ze1gj9KpzUw0dlg7hSHDW9E6P
         kofQ9AXLNuVXdUdzqLO7nZKUHDMF0G4O++zdrzOiLGsA0Q9Dp5X5YuN4GWhIdjQ+keNp
         tEeeE21MSnF4J69MEle1bfMSqt/zhXMc6NeaA1s2VMEm9bHC6/xpuy+HilL2xiFiadJg
         9cow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RkZZdk3QudoBe1sAkD0QhbZpJjcwJBNFIhvSYhdMvdI=;
        b=TG+ZhKguXapBkB5gs3m+JaiO8MmGiKa5296jQEUF2bDokK2aQsgZ/nAdr+MEM0c5qe
         JoUKQsauIiMdrfN3NLSTfchJLglU/dW3VdxaAheEdnC6dnHCh6xzsfJ+pyi6TC7VuPIb
         pc90B8HcrDiuPZ83shHXdRMKERepJWuwRwNs7s73QmG2FXtckA8OBm1MzxBfeaCwkPhB
         7ml6ihcm8v6fGH539gQOeF6U0uwJJ/lqoeM3YyBWobFLHas4crkpZH1yttZoeG2z3Vuk
         /KFhuCLOTOxZPHcogixYb5bQCscc6BmvfuCu1+fW0gjpqaSzAI4eflx6Y2oOfGZ3XsSc
         A5LA==
X-Gm-Message-State: AOAM533X5C3iH0uO9db6SlO3eIfw+J4GtIjIGqCuKwhRfu8YP3aCWKyX
        /Uz1DXTWHCBhsmKdLCfCjLWMQ1RuG10=
X-Google-Smtp-Source: ABdhPJzO2bYY91kOKz77RXey8eUwkdUAaGESFQ9o8UhmYKP8qs1zCbp2CmI/zGb/uNvlpFj3o5xHAg==
X-Received: by 2002:a05:6402:51cd:: with SMTP id r13mr17089295edd.116.1616786356281;
        Fri, 26 Mar 2021 12:19:16 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c19sm4739373edu.20.2021.03.26.12.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:19:15 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/6] PCI: brcmstb: Add control of EP voltage regulators
Date:   Fri, 26 Mar 2021 15:19:00 -0400
Message-Id: <20210326191906.43567-3-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326191906.43567-1-jim2101024@gmail.com>
References: <20210326191906.43567-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Control of EP regulators by the RC is needed because of the chicken-and-egg
situation: although the regulator is "owned" by the EP and would be best
handled on its driver, the EP cannot be discovered and probed unless its
regulator is already turned on.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 90 ++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e330e6811f0b..b76ec7d9af32 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -24,6 +24,7 @@
 #include <linux/pci.h>
 #include <linux/pci-ecam.h>
 #include <linux/printk.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -169,6 +170,7 @@
 #define SSC_STATUS_SSC_MASK		0x400
 #define SSC_STATUS_PLL_LOCK_MASK	0x800
 #define PCIE_BRCM_MAX_MEMC		3
+#define PCIE_BRCM_MAX_EP_REGULATORS	4
 
 #define IDX_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_INDEX])
 #define DATA_ADDR(pcie)			(pcie->reg_offsets[EXT_CFG_DATA])
@@ -295,8 +297,27 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	struct regulator_bulk_data supplies[PCIE_BRCM_MAX_EP_REGULATORS];
+	unsigned int		num_supplies;
 };
 
+static int brcm_set_regulators(struct brcm_pcie *pcie, bool on)
+{
+	struct device *dev = pcie->dev;
+	int ret;
+
+	if (!pcie->num_supplies)
+		return 0;
+	if (on)
+		ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
+	else
+		ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
+	if (ret)
+		dev_err(dev, "failed to %s EP regulators\n",
+			on ? "enable" : "disable");
+	return ret;
+}
+
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -1141,16 +1162,63 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
+static int brcm_pcie_get_regulators(struct brcm_pcie *pcie)
+{
+	struct device_node *child, *parent = pcie->np;
+	const unsigned int max_name_len = 64 + 4;
+	struct property *pp;
+
+	/* Look for regulator supply property in the EP device subnodes */
+	for_each_available_child_of_node(parent, child) {
+		/*
+		 * Do a santiy test to ensure that this is an EP node
+		 * (e.g. node name: "pci-ep@0,0").  The slot number
+		 * should always be 0 as our controller only has a single
+		 * port.
+		 */
+		const char *p = strstr(child->full_name, "@0");
+
+		if (!p || (p[2] && p[2] != ','))
+			continue;
+
+		/* Now look for regulator supply properties */
+		for_each_property_of_node(child, pp) {
+			int i, n = strnlen(pp->name, max_name_len);
+
+			if (n <= 7 || strncmp("-supply", &pp->name[n - 7], 7))
+				continue;
+
+			/* Make sure this is not a duplicate */
+			for (i = 0; i < pcie->num_supplies; i++)
+				if (strncmp(pcie->supplies[i].supply,
+					    pp->name, max_name_len) == 0)
+					continue;
+
+			if (pcie->num_supplies < PCIE_BRCM_MAX_EP_REGULATORS)
+				pcie->supplies[pcie->num_supplies++].supply = pp->name;
+			else
+				dev_warn(pcie->dev, "No room for EP supply %s\n",
+					 pp->name);
+		}
+	}
+	/*
+	 * Get the regulators that the EP devices require.  We cannot use
+	 * pcie->dev as the device argument in regulator_bulk_get() since
+	 * it will not find the regulators.  Instead, use NULL and the
+	 * regulators are looked up by their name.
+	 */
+	return regulator_bulk_get(NULL, pcie->num_supplies, pcie->supplies);
+}
+
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
 
 	brcm_pcie_turn_off(pcie);
-	ret = brcm_phy_stop(pcie);
+	brcm_phy_stop(pcie);
 	clk_disable_unprepare(pcie->clk);
 
-	return ret;
+	return brcm_set_regulators(pcie, false);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1163,6 +1231,10 @@ static int brcm_pcie_resume(struct device *dev)
 	base = pcie->base;
 	clk_prepare_enable(pcie->clk);
 
+	ret = brcm_set_regulators(pcie, true);
+	if (ret)
+		return ret;
+
 	ret = brcm_phy_start(pcie);
 	if (ret)
 		goto err;
@@ -1199,6 +1271,8 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_assert(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
+	brcm_set_regulators(pcie, false);
+	regulator_bulk_free(pcie->num_supplies, pcie->supplies);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
@@ -1289,6 +1363,16 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = brcm_pcie_get_regulators(pcie);
+	if (ret) {
+		dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
+		goto fail;
+	}
+
+	ret = brcm_set_regulators(pcie, true);
+	if (ret)
+		goto fail;
+
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
 		goto fail;
-- 
2.17.1

