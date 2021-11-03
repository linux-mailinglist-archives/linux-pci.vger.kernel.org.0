Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D2744489A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Nov 2021 19:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhKCSwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Nov 2021 14:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhKCSwe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Nov 2021 14:52:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F85DC061714;
        Wed,  3 Nov 2021 11:49:58 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y1so3075637plk.10;
        Wed, 03 Nov 2021 11:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3TSaUqFQ373KOcylCPvljRjsapR+eghqQwHcyVQXkYo=;
        b=ii33XPCm/NMGn3E3iCWe0wqAG/0f51JRs3YinU1BbTAxc5X5UCysala684ozI+XDXY
         R8mHIIv0bAlKXtBzSPCYPwj7im93EdPmt3jMRhgXv//BEYIq7B4R75JzFMhRkZ7cc3gG
         R7loLkP1C4vtm+tn1npDzmmwKPi0m19pa+7TceIlZ5Yhg8VKCF4jSzQg7OWT3jF0c5Fk
         DzIk7rad4VYcYqIMZ8c0KFrhJbcjvX17SsJTyabbXEo2nEq/ea6xpNWHZUfKkEEEuVaU
         G0ND+zB/0WDRNDQ69+BjZTaL4/TuhaGxuzWCrmQXtNHAvg5cwUwuSB+c/RUWRmZ1D+ye
         VNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3TSaUqFQ373KOcylCPvljRjsapR+eghqQwHcyVQXkYo=;
        b=0bAoCIkPWFQi5lcM5v0kN1UrldJHsyjVTYvw7iHWusbl0CAEKJkyW3U7LULsXm1TTW
         PAG7M2MuOics0emiPozvMODYl80VtY2hwddufVUJAY0vTEUefubF/MJh0QYr0qXOKXc7
         HakpeOyjGH1dnUheAC/6OnFFsYWs/GvB8lu9OOs0twQ3bGUQBbN9jXRE54u6CqvZ4kgX
         69rfww/go/UwySQ+Ges9P5tz4peDddrXFm2U84Y8wrWJRxYUwBsTbj6kJq3s0qFX/txq
         KMZVLQOazGToJYd1NcS/mz3tFiUraZv+IOlm9+UcVKKj9XAewSvdgb/TwT7sUbWIX+vR
         ynOw==
X-Gm-Message-State: AOAM531+FYkcrEDrfm8vNM2+XdP+ONGGtA4kPGMTYiSmbavx1IlooEaj
        IF8nXEpHWAUTIde5yQZijYFyNUItGa9ohA==
X-Google-Smtp-Source: ABdhPJzgbs8kLCJfJbnoJW1JqqKe9OKcGb5xUw327c8eClhY/MH+OcN0k+BFgN6+Je4t0EdmWDx9aA==
X-Received: by 2002:a17:903:1207:b0:138:e2f9:6c98 with SMTP id l7-20020a170903120700b00138e2f96c98mr41428638plh.11.1635965397471;
        Wed, 03 Nov 2021 11:49:57 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j6sm2379065pgq.0.2021.11.03.11.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 11:49:57 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 5/7] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Wed,  3 Nov 2021 14:49:35 -0400
Message-Id: <20211103184939.45263-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103184939.45263-1-jim2101024@gmail.com>
References: <20211103184939.45263-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This Broadcom STB PCIe RC driver has one port and connects directly to one
device, be it a switch or an endpoint.  We want to be able to turn on/off
any regulators for that device.  Control of regulators is needed because of
the chicken-and-egg situation: although the regulator is "owned" by the
device and would be best handled by its driver, the device cannot be
discovered and probed unless its regulator is already turned on.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 156 +++++++++++++++++++++++++-
 1 file changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ba4d6daf312c..aaf6a4cbeb78 100644
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
@@ -191,6 +192,15 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static int brcm_pcie_add_bus(struct pci_bus *bus);
+static void brcm_pcie_remove_bus(struct pci_bus *bus);
+static bool brcm_pcie_link_up(struct brcm_pcie *pcie);
+
+static const char * const supplies[] = {
+	"vpcie3v3",
+	"vpcie3v3aux",
+	"vpcie12v",
+};
 
 enum {
 	RGR1_SW_INIT_1,
@@ -295,8 +305,38 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supplies)];
+	unsigned int		num_supplies;
 };
 
+static int brcm_regulators_on(struct brcm_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int ret;
+
+	if (!pcie->num_supplies)
+		return 0;
+	ret = regulator_bulk_enable(pcie->num_supplies, pcie->supplies);
+	if (ret)
+		dev_err(dev, "failed to enable EP regulators\n");
+
+	return ret;
+}
+
+static int brcm_regulators_off(struct brcm_pcie *pcie)
+{
+	struct device *dev = pcie->dev;
+	int ret;
+
+	if (!pcie->num_supplies)
+		return 0;
+	ret = regulator_bulk_disable(pcie->num_supplies, pcie->supplies);
+	if (ret)
+		dev_err(dev, "failed to disable EP regulators\n");
+
+	return ret;
+}
+
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -722,6 +762,8 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.add_bus = brcm_pcie_add_bus,
+	.remove_bus = brcm_pcie_remove_bus,
 };
 
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
@@ -1148,6 +1190,47 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
+static int brcm_pcie_get_regulators(struct brcm_pcie *pcie, struct device *dev)
+{
+	const unsigned int ns = ARRAY_SIZE(supplies);
+	struct device_node *dn;
+	struct property *pp;
+	unsigned int i;
+	int ret;
+
+	/* This is for Broadcom STB/CM chips only */
+	if (pcie->type == BCM2711)
+		return 0;
+
+	dn = dev->of_node;
+	if (!dn)
+		return 0;
+
+	for_each_property_of_node(dn, pp) {
+		for (i = 0; i < ns; i++) {
+			char prop_name[64]; /* 64 is max size of property name */
+
+			snprintf(prop_name, 64, "%s-supply", supplies[i]);
+			if (strcmp(prop_name, pp->name) == 0)
+				break;
+		}
+		if (i >= ns || pcie->num_supplies >= ARRAY_SIZE(supplies))
+			continue;
+
+		pcie->supplies[pcie->num_supplies++].supply = supplies[i];
+	}
+
+	if (pcie->num_supplies == 0)
+		return 0;
+
+	ret = devm_regulator_bulk_get(dev, pcie->num_supplies,
+				      pcie->supplies);
+	if (ret)
+		dev_err(dev, "failed to get EP regulators\n");
+
+	return ret;
+}
+
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
@@ -1158,7 +1241,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-	return ret;
+	return brcm_regulators_off(pcie);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1174,6 +1257,9 @@ static int brcm_pcie_resume(struct device *dev)
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		goto err_disable_clk;
+	ret = brcm_regulators_on(pcie);
+	if (ret)
+		goto err_reset;
 
 	ret = brcm_phy_start(pcie);
 	if (ret)
@@ -1241,6 +1327,62 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{},
 };
 
+static int brcm_pcie_add_bus(struct pci_bus *bus)
+{
+	struct pci_host_bridge *hb = pci_find_host_bridge(bus);
+	struct brcm_pcie *pcie = (struct brcm_pcie *) hb->sysdata;
+	struct device *dev = &bus->dev;
+	int ret;
+
+	/*
+	 * We only care about a device that is directly connected
+	 * to the root complex, ie bus == 1 and slot == 0.
+	 */
+	if (bus->number != 1)
+		return 0;
+
+	ret = brcm_pcie_get_regulators(pcie, dev);
+	if (ret)
+		goto err_out;
+
+	ret = brcm_regulators_on(pcie);
+	if (ret)
+		goto err_out;
+
+	ret = brcm_pcie_linkup(pcie);
+	if (ret)
+		goto err_out;
+
+	return 0;
+
+err_out:
+	/*
+	 * If we have failed there is no point to return the exact reason,
+	 * as currently it will cause a WARNING() from
+	 * pci_alloc_child_bus().  We return -ENOLINK to the caller, which
+	 * unlike any other errors, will stop the PCIe tree exploration.
+	 */
+	return -ENOLINK;
+}
+
+static void brcm_pcie_remove_bus(struct pci_bus *bus)
+{
+	struct pci_host_bridge *hb = pci_find_host_bridge(bus);
+	struct brcm_pcie *pcie = (struct brcm_pcie *) hb->sysdata;
+	struct device *dev = &bus->dev;
+	int ret;
+
+	if (bus->number != 1)
+		return;
+
+	if (pcie->num_supplies > 0) {
+		ret = brcm_regulators_off(pcie, true);
+		if (ret)
+			dev_err(dev, "Could not turn of regulators\n");
+		pcie->num_supplies = 0;
+	}
+}
+
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
@@ -1332,7 +1474,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (!ret && !brcm_pcie_link_up(pcie))
+		ret = -ENODEV;
+
+	if (ret) {
+		brcm_pcie_remove(pdev);
+		return ret;
+	}
+
+	return 0;
+
 fail:
 	__brcm_pcie_remove(pcie);
 	return ret;
-- 
2.17.1

