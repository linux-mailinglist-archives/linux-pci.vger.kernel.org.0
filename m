Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C7D4403BD
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhJ2UGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhJ2UGJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:06:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA3C061714;
        Fri, 29 Oct 2021 13:03:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n18so7533496plc.2;
        Fri, 29 Oct 2021 13:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fs1h0oEJpXq+0v9+ITH8gAhhMpG3tKFNm2Sg0Y1iFCA=;
        b=AdSBhCOASd+zHNLdwvAGJ7h02CtSExXSpYpNdBAd9rvXWezBLKLb7ggDC7PUvR9NlE
         V34k00QzPQEAJhWOHF+JlGE5Oj36XP6JzwAdRYM8oRGMkXv/khoeVe6Zzz+pDQyzMvQR
         UgCJGH9nJ5/A90Kr0XRSargmAxXCb4U3RV2GIkE37RM7RQI9RjAsFnhheLF+qbsDbHEn
         FMMgu87v8vQkZD1esC1hDURGJE7sTMBzNICSXb0yHWuq4Se6DG6caQhu+lYWUNG7c8XG
         dX4mMz8/houceeN576nKHo2lBQJZ0aJ+l8Aye24Sv6+B41xI6+lZ1qKanQZNVP/eXvDE
         ENhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fs1h0oEJpXq+0v9+ITH8gAhhMpG3tKFNm2Sg0Y1iFCA=;
        b=x1Lvg63UVUGDDbZy/wByS5TYcoiKeGKUmw+4pHHQIk2fs3jZoCqf+Uu9wmh9ZP9TB1
         +GvPLYbGGxnX5Yaz2PJzBBJ0/DSW+0ebvVVdBQYk/LaiGhteMqB/Avd2Jq3T/u3EnwEf
         /GPdPMEaCaa+ax5BGmNtywQ5VV24Fv19ud3xFbXHaGfQCTsfbrVOXcpdZNjauTKDgaiu
         8W+eThfy6KrRYIFVgVCDcYzYHKELzPIlS6RxW7Cas7mPsIy2djh8n/17OA5pMTfMtoDa
         4pJkkwK1XSt73Ogjj9P0uuUGB1UWLbqCLsazAd28dwltkut2/EjiZ9prtpvFmuzl+fyJ
         V8IQ==
X-Gm-Message-State: AOAM530jH1zoTQTrBSaOJb+L5fik6/lMDF6lR2EB6Jvho7OoCa3rM+sZ
        xSs5oNXTqGwwOwZQ2nD63UumOvenfnhuyQ==
X-Google-Smtp-Source: ABdhPJzUJR0JVVGnwuS2gERt1y/KK+57eHJfq2QYnEfBbNOGUl7HS2gfq8Em/+N7DoKVduEC6dWO8w==
X-Received: by 2002:a17:902:bcc4:b0:141:bfc4:ada with SMTP id o4-20020a170902bcc400b00141bfc40adamr1112784pls.20.1635537819137;
        Fri, 29 Oct 2021 13:03:39 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:38 -0700 (PDT)
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
Subject: [PATCH v6 7/9] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Fri, 29 Oct 2021 16:03:15 -0400
Message-Id: <20211029200319.23475-8-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
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
 drivers/pci/controller/pcie-brcmstb.c | 164 +++++++++++++++++++++++++-
 1 file changed, 162 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ba4d6daf312c..6635e143cfcb 100644
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
@@ -192,6 +193,12 @@ static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
 
+static const char * const supplies[] = {
+	"vpcie3v3",
+	"vpcie3v3aux",
+	"vpcie12v",
+};
+
 enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
@@ -295,8 +302,38 @@ struct brcm_pcie {
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
@@ -1148,6 +1185,59 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
+static int brcm_pcie_get_regulators(struct brcm_pcie *pcie, struct pci_dev *dev)
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
+	pci_set_of_node(dev);
+	dn = dev->dev.of_node;
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
+	/*
+	 * We set the name ahead of time as the regulator core expects
+	 * it to exist when regulator_bulk_get() is called.
+	 */
+	dev_set_name(&dev->dev, "%04x:%02x:%02x.%d",
+		     pci_domain_nr(dev->bus),
+		     dev->bus->number, PCI_SLOT(dev->devfn),
+		     PCI_FUNC(dev->devfn));
+	/*
+	 * We cannot use devm_regulator_bulk_get() because the
+	 * downstream device may be removed w/o the regulator
+	 * first being disabled by the host bridge.
+	 */
+	ret = regulator_bulk_get(&dev->dev, pcie->num_supplies,
+				 pcie->supplies);
+
+	return ret;
+}
+
 static int brcm_pcie_suspend(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
@@ -1158,7 +1248,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-	return ret;
+	return brcm_regulators_off(pcie);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1174,6 +1264,9 @@ static int brcm_pcie_resume(struct device *dev)
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		goto err_disable_clk;
+	ret = brcm_regulators_on(pcie);
+	if (ret)
+		goto err_reset;
 
 	ret = brcm_phy_start(pcie);
 	if (ret)
@@ -1217,6 +1310,10 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
+	if (pcie->num_supplies) {
+		brcm_regulators_off(pcie);
+		regulator_bulk_free(pcie->num_supplies, pcie->supplies);
+	}
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
@@ -1241,6 +1338,57 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{},
 };
 
+static bool brcm_pcie_pci_subdev_can_prepare(struct pci_bus *bus, int devfn)
+{
+	/*
+	 * We only care about a device that is directly connected
+	 * to the root complex, ie bus == 1 and slot == 0.
+	 */
+	return (bus->number == 1 && PCI_SLOT(devfn) == 0);
+}
+
+static int brcm_pcie_pci_subdev_prepare(struct pci_bus *bus, int devfn,
+					struct pci_host_bridge *bridge,
+					struct pci_dev *pdev)
+{
+	struct brcm_pcie *pcie;
+	int ret = 0;
+
+	pcie = (struct brcm_pcie *) bridge->sysdata;
+	ret = brcm_pcie_get_regulators(pcie, pdev);
+	if (ret) {
+		pcie->num_supplies = 0;
+		if (ret != -EPROBE_DEFER)
+			dev_err(pcie->dev, "failed to get regulators (err=%d)\n", ret);
+		return ret;
+	}
+
+	ret = brcm_regulators_on(pcie);
+	if (ret)
+		goto err_out0;
+
+	ret = brcm_pcie_linkup(pcie);
+	if (ret)
+		goto err_out1;
+
+	/*
+	 * dev_set_name() was called in brcm_get_regulators().  Free the
+	 * string it allocated as it will be called again when
+	 * pci_setup_device() is invoked.
+	 */
+	kfree_const(pdev->dev.kobj.name);
+	pdev->dev.kobj.name = NULL;
+
+	return 0;
+
+err_out1:
+	brcm_regulators_off(pcie);
+err_out0:
+	regulator_bulk_free(pcie->num_supplies, pcie->supplies);
+	pcie->num_supplies = 0;
+	return ret;
+}
+
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
@@ -1327,12 +1475,24 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	bridge->pci_subdev_can_prepare = brcm_pcie_pci_subdev_can_prepare;
+	bridge->pci_subdev_prepare = brcm_pcie_pci_subdev_prepare;
 	bridge->ops = &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
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

