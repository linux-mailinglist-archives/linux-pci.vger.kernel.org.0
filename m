Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E159352198
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 23:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235398AbhDAVWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234541AbhDAVWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 17:22:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E292C0613E6;
        Thu,  1 Apr 2021 14:22:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a12so2340647pfc.7;
        Thu, 01 Apr 2021 14:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VnZEjn3FMdva8ipBLV073OJdSwGTGi+Qmw1GQKtSJk=;
        b=rqKnVniAJqaznlfyFZnoH63rR6cVFwpgQ1QdlN2GJJEUGkszt41VRZqO4rpJeSuS5W
         ulfVwYfHvp8XURH5eqZdXRk3HjvyAmp8qq3bJ134fXnzYTTtscawCWC+iF+uCpSQq89a
         7bW6bFpsWlfi63s1qgjE0H7ml3Y/BX9AFUA/0lQa0EGHhXKLZp8OCrL8X/Fvj+OpRhay
         d8f4T1l7t7sDxVP0p4nHlV1Vhc3gElYaA9PN8KVvin04fuQM3P6l9OTxU70AZWusuLfE
         7/3vfT1uuQBVsMGt7v8BuPnU1bO9Rg9jgyDouparceLhXtuvpk6SUpfvnPtYgLP2LB0t
         MpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VnZEjn3FMdva8ipBLV073OJdSwGTGi+Qmw1GQKtSJk=;
        b=kgHySyivoxEL47D8qPKEW7DaOW8jsg7NkStkOnGBNOMjbuTnxc9U45zv43K5NNflNr
         s5NlBJ3u5XQFe+LrcGqbM1bhgVADQn1jcGEPxSuQsnH5nL3x42qpvm+qph7j1Cq3GHwF
         Az18zYG//0bBPeebq4kkD0934xC7EboVC9RP65i5Du47r51ESOSbc+bAtilMZnAdYIgx
         NKzd915+jn324bZNkbYF2On8MthFjoVCEN5CJwG74Wot802zBn4CPuWs+Ph2oNe7KqDt
         Hy2DSA+zQbBoj2sq1Yz0Km4RyGzvM86bM3TVrswzAEjOtH73fIdtEEG2sh/z4I2ZP7Li
         J3hA==
X-Gm-Message-State: AOAM533lZWiUJNj3baYDTlDLiTzDI7CRO/Z+YHN1BBVXRVgnPtnu53qM
        ka8CRRlntxwitq3YkVNnrHGwJ3eVp3E=
X-Google-Smtp-Source: ABdhPJwgmmrtZmxhTHaTcSUUdrBWSClYS0FE/GSnCuAlxz39mj1gVVrWBKV+9SHfDMvk4TEKO0KzZQ==
X-Received: by 2002:a05:6a00:b86:b029:207:8ac9:85de with SMTP id g6-20020a056a000b86b02902078ac985demr9011916pfj.66.1617312120361;
        Thu, 01 Apr 2021 14:22:00 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id q5sm5926707pfk.219.2021.04.01.14.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 14:22:00 -0700 (PDT)
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
Subject: [PATCH v4 3/6] PCI: brcmstb: Add control of slot0 device voltage regulators
Date:   Thu,  1 Apr 2021 17:21:43 -0400
Message-Id: <20210401212148.47033-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210401212148.47033-1-jim2101024@gmail.com>
References: <20210401212148.47033-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This Broadcom STB has one port and connects directly to one device, be it a
switch or an endpoint.  We want to be able to turn on/off any regulators
for that device.  Control of regulators is needed because of the
chicken-and-egg situation: although the regulator is "owned" by the device
and would be best handled by its driver, the device cannot be discovered
and probed unless its regulator is already turned on.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 83 +++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 4ce1f3a60574..1b0de0c7da60 100644
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
@@ -192,6 +194,11 @@ static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
 
+static const char * const supplies[] = {
+	"vpcie12v-supply",
+	"vpcie3v3-supply",
+};
+
 enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
@@ -295,8 +302,27 @@ struct brcm_pcie {
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
@@ -1112,9 +1138,10 @@ static inline int brcm_phy_start(struct brcm_pcie *pcie)
 	return pcie->rescal ? brcm_phy_cntl(pcie, 1) : 0;
 }
 
-static inline int brcm_phy_stop(struct brcm_pcie *pcie)
+static inline void brcm_phy_stop(struct brcm_pcie *pcie)
 {
-	return pcie->rescal ? brcm_phy_cntl(pcie, 0) : 0;
+	if (pcie->rescal)
+		brcm_phy_cntl(pcie, 0);
 }
 
 static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
@@ -1141,16 +1168,45 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
+static int brcm_pcie_get_regulators(struct brcm_pcie *pcie)
+{
+	struct device_node *np = pcie->np;
+	struct property *pp;
+	const unsigned int ns = ARRAY_SIZE(supplies);
+	unsigned int i;
+	int ret = 0;
+
+	/* Look for specific pcie regulators in the RC DT node. */
+	for_each_property_of_node(np, pp) {
+		for (i = 0; i < ns; i++)
+			if (strcmp(supplies[i], pp->name) == 0)
+				break;
+		if (i >= ns)
+			continue;
+
+		if (pcie->num_supplies < PCIE_BRCM_MAX_EP_REGULATORS)
+			pcie->supplies[pcie->num_supplies++].supply
+				= supplies[i];
+		else
+			dev_warn(pcie->dev, "No room for supply %s\n",
+				 supplies[i]);
+	}
+
+	if (pcie->num_supplies)
+		ret = devm_regulator_bulk_get(pcie->dev, pcie->num_supplies,
+					      pcie->supplies);
+	return ret;
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
@@ -1165,6 +1221,10 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = brcm_set_regulators(pcie, true);
+	if (ret)
+		return ret;
+
 	ret = brcm_phy_start(pcie);
 	if (ret)
 		goto err;
@@ -1201,6 +1261,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_assert(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
+	brcm_set_regulators(pcie, false);
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
@@ -1291,6 +1352,18 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = brcm_pcie_get_regulators(pcie);
+	if (ret) {
+		pcie->num_supplies = 0;
+		if (ret != -EPROBE_DEFER)
+			dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
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

