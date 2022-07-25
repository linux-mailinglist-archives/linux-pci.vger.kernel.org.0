Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFC58017E
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 17:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbiGYPQk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 11:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235089AbiGYPQL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 11:16:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492111EC42;
        Mon, 25 Jul 2022 08:13:38 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id y1so2617017pja.4;
        Mon, 25 Jul 2022 08:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JE8bRC6uYHCtiV8R8EE5D5GYSiT8jkroOdZWcPrNIso=;
        b=dJPeHC17hBf5NkCv/C83Oow9fLbq2L9cbdIVaIvvEUSgLtdOZ2BsIevw0UK4GWIdpT
         UdPxLsui6l4A1Hrz/VlNNftUqOgSuWGcg3ajaQgRTYke+lNBhKmYiKpCGf/YLmQeCvH3
         LJ1wgktinCSwxPVXHPgUqatA+WoI+fLLeOd0hsckOveIb8WY3Z3LFyhDJBH1qkkMEKwr
         ELaljoH1+paxcH1QdDkCEjeEAagMI7/FIRXrcHP4MK2KgIZJj52wgq6JdMrMMnZX1jqx
         t1dA6gykJBj+Q1EcrdHxdkySKvWF6pdAD7y2wxNPBc+Ph/fXbPkNXrywVf6rkBVrBVxa
         qdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JE8bRC6uYHCtiV8R8EE5D5GYSiT8jkroOdZWcPrNIso=;
        b=1xA4HeDQTyGqw3W5KtKDmVXyv4BCzm27FcdpE0zVLZBBEzAwg1v+MQ0IA02F5yjFzv
         /5y/Pb+wR4goJjZ4lKgru6FQKDR5GBn//BLoNuDZVODshjmZbmlTzXzGeIg55IvJ9vW/
         Eb3Q4MpXHyl8MCiHK7SVLMCWKZ6KYulZdbVHQMuXdAblhwooM/A88oK9ta1Ksyw4M6Gh
         /F7CZ2Ry9inP5zJla91AF9BH6H9BmK0CbXsJXsQIUggdFXzCbttcC4XIw1EZY+UdKrFW
         Gs9cjempw8mJAgjfiukpg7kXmQy6P0XiDN5oO538hGEna/OTLT+EO0eEl6BycVCEqRrh
         BzCA==
X-Gm-Message-State: AJIora9Jff7Rrq8HyW0R/QZTlO+5SVI0neZzSMOm+8nuqj7D0islK/hh
        uTk/xhQQtxxLp7BMf7JaS0zywi1c/ZY=
X-Google-Smtp-Source: AGRyM1vE7L8X4jFX0/CbMVa/j1CVPqAjkMZJ1o95jHXF818zgQj4imyni/y+UHauWYM0NPcWXTXuLA==
X-Received: by 2002:a17:90a:880a:b0:1ef:76fb:d8b6 with SMTP id s10-20020a17090a880a00b001ef76fbd8b6mr15047682pjn.69.1658762016747;
        Mon, 25 Jul 2022 08:13:36 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ecc900b001641b2d61d4sm6649667plh.30.2022.07.25.08.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 08:13:36 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/7] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Mon, 25 Jul 2022 11:12:54 -0400
Message-Id: <20220725151258.42574-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220725151258.42574-1-jim2101024@gmail.com>
References: <20220725151258.42574-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This Broadcom STB PCIe RC driver has one port and connects directly to one
device, be it a switch or an endpoint.  We want to be able to leverage the
recently added mechanism that allocates and turns on/off subdevice
regulators.

All that needs to be done is to put the regulator DT nodes in the bridge
below host and to set the pci_ops methods add_bus and remove_bus.

Note that the pci_subdev_regulators_add_bus() method is wrapped for two
reasons:

   1. To achieve link up after the voltage regulators are turned on.

   2. If, in the case of an unsuccessful link up, to redirect any PCIe
      accesses to subdevices, e.g. the scan for DEV/ID.  This redirection
      is needed because the Broadcom PCIe HW will issue a CPU abort if such
      an access is made when the link is down.

The pci_subdev_regulators_remove_bus() is wrapped as well as
we must avoid invoking it if we see that there is a collision
in the use of dev->driver_data.

[bhelgaas: fold in
https://lore.kernel.org/r/20220112013100.48029-1-jim2101024@gmail.com]
Link: https://lore.kernel.org/r/20220106160332.2143-7-jim2101024@gmail.com
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 134 ++++++++++++++++++--------
 1 file changed, 95 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 1be6e71142d8..aa199b0a39e2 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -261,6 +261,8 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool			regulator_oops;
+	struct subdev_regulators *sr;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1100,10 +1102,37 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 	struct subdev_regulators *sr;
 	int ret;
 
-	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
+	sr = alloc_subdev_regulators(dev);
+	if (!sr)
+		return -ENOMEM;
+
+	ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
+	if (ret) {
+		dev_err(dev, "failed to get regulators for downstream device\n");
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
+	if (ret) {
+		dev_err(dev, "failed to enable regulators for downstream device\n");
+		regulator_bulk_free(sr->num_supplies, sr->supplies);
+		return ret;
+	}
+	dev->driver_data = sr;
+
+	return 0;
+}
+
+static int brcm_pcie_add_bus(struct pci_bus *bus)
+{
+	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
+	struct device *dev = &bus->dev;
+	int ret;
+
+	if (!bus->parent || !pci_is_root_bus(bus->parent) || !pcie)
 		return 0;
 
-	if (dev->driver_data) {
+	if (dev->of_node && dev->driver_data) {
 		/*
 		 * Oops, this is unfortunate.  We are using the port
 		 * driver's driver_data field to store our regulator info
@@ -1112,12 +1141,15 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 		 * may still be okay if there are no regulators.
 		 */
 		dev_err(dev, "root port dev.driver_data non-NULL; something wrong\n");
-		return 0;
+
+	} else if (dev->of_node) {
+		ret = pci_subdev_regulators_add_bus(bus);
+		/* Grab the regulators for suspend/resume */
+		pcie->sr = bus->dev.driver_data;
 	}
 
-	sr = alloc_subdev_regulators(dev);
-	if (!sr)
-		return -ENOMEM;
+	/* Try to start the link. */
+	brcm_pcie_start_link(pcie);
 
 	/*
 	 * There is not much of a point to return an error as currently it
@@ -1125,22 +1157,7 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 	 * return the error if it is -ENOMEM.  Note that we are always
 	 * doing a dev_err() for other erros.
 	 */
-	ret = regulator_bulk_get(dev, sr->num_supplies, sr->supplies);
-	if (ret) {
-		dev_err(dev, "failed to get regulators for downstream device\n");
-		return 0;
-	}
-
-	ret = regulator_bulk_enable(sr->num_supplies, sr->supplies);
-	if (ret) {
-		dev_err(dev, "failed to enable regulators for downstream device\n");
-		regulator_bulk_free(sr->num_supplies, sr->supplies);
-		return 0;
-	}
-
-	dev->driver_data = sr;
-
-	return 0;
+	return ret == -ENOMEM ? ret : 0;
 }
 
 static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
@@ -1148,15 +1165,28 @@ static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
 	struct device *dev = &bus->dev;
 	struct subdev_regulators *sr = dev->driver_data;
 
-	if (!dev->of_node || !sr || !bus->parent || !pci_is_root_bus(bus->parent))
-		return;
-
 	if (regulator_bulk_disable(sr->num_supplies, sr->supplies))
 		dev_err(dev, "failed to disable regulators for downstream device\n");
 	regulator_bulk_free(sr->num_supplies, sr->supplies);
 	dev->driver_data = NULL;
 }
 
+static void brcm_pcie_remove_bus(struct pci_bus *bus)
+{
+	struct device *dev = &bus->dev;
+	struct brcm_pcie *pcie;
+
+	if (!dev->of_node || !dev->driver_data || !bus->parent ||
+	    !pci_is_root_bus(bus->parent))
+		return;
+
+	pcie = (struct brcm_pcie *) bus->sysdata;
+	if (pcie && pcie->sr) {
+		pci_subdev_regulators_remove_bus(bus);
+		pcie->sr = NULL;
+	}
+}
+
 /* L23 is a low-power PCIe link state */
 static void brcm_pcie_enter_l23(struct brcm_pcie *pcie)
 {
@@ -1253,7 +1283,7 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
-static int brcm_pcie_suspend(struct device *dev)
+static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
@@ -1273,12 +1303,20 @@ static int brcm_pcie_suspend(struct device *dev)
 		return ret;
 	}
 
+	if (pcie->sr) {
+		ret = regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
+		if (ret) {
+			dev_err(dev, "Could not turn off regulators\n");
+			reset_control_reset(pcie->rescal);
+			return ret;
+		}
+	}
 	clk_disable_unprepare(pcie->clk);
 
 	return 0;
 }
 
-static int brcm_pcie_resume(struct device *dev)
+static int brcm_pcie_resume_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	void __iomem *base;
@@ -1313,15 +1351,27 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		goto err_reset;
 
+	if (pcie->sr) {
+		ret = regulator_bulk_enable(pcie->sr->num_supplies,
+					    pcie->sr->supplies);
+		if (ret) {
+			dev_err(dev, "Could not turn on regulators\n");
+			goto err_reset;
+		}
+	}
+
 	ret = brcm_pcie_start_link(pcie);
 	if (ret)
-		goto err_reset;
+		goto err_regulator;
 
 	if (pcie->msi)
 		brcm_msi_set_regs(pcie->msi);
 
 	return 0;
 
+err_regulator:
+	if (pcie->sr)
+		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_reset:
 	reset_control_rearm(pcie->rescal);
 err_disable_clk:
@@ -1428,16 +1478,16 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = pci_subdev_regulators_add_bus,
-	.remove_bus = pci_subdev_regulators_remove_bus,
+	.add_bus = brcm_pcie_add_bus,
+	.remove_bus = brcm_pcie_remove_bus
 };
 
 static struct pci_ops brcm_pcie_ops32 = {
 	.map_bus = brcm_pcie_map_conf32,
 	.read = pci_generic_config_read32,
 	.write = pci_generic_config_write32,
-	.add_bus = pci_subdev_regulators_add_bus,
-	.remove_bus = pci_subdev_regulators_remove_bus,
+	.add_bus = brcm_pcie_add_bus,
+	.remove_bus = brcm_pcie_remove_bus
 };
 
 static int brcm_pcie_probe(struct platform_device *pdev)
@@ -1510,10 +1560,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	ret = brcm_pcie_start_link(pcie);
-	if (ret)
-		goto fail;
-
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
 	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
@@ -1535,7 +1581,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
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
@@ -1544,8 +1600,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 MODULE_DEVICE_TABLE(of, brcm_pcie_match);
 
 static const struct dev_pm_ops brcm_pcie_pm_ops = {
-	.suspend = brcm_pcie_suspend,
-	.resume = brcm_pcie_resume,
+	.suspend_noirq = brcm_pcie_suspend_noirq,
+	.resume_noirq = brcm_pcie_resume_noirq,
 };
 
 static struct platform_driver brcm_pcie_driver = {
-- 
2.17.1

