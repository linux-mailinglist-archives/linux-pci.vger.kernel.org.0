Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B915F5771DD
	for <lists+linux-pci@lfdr.de>; Sun, 17 Jul 2022 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiGPWZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 16 Jul 2022 18:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiGPWZP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 16 Jul 2022 18:25:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B4F1CB0C;
        Sat, 16 Jul 2022 15:25:14 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q5so6027386plr.11;
        Sat, 16 Jul 2022 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tz/IgNGyEGV4fc7STK4mOsJiKQO2/ubyNAHz5z15Usw=;
        b=DOTPQ8Y6YGHHfo9h5+ZTpIBzj0gNRRWgKknL74M2j8rttOK1fjAJlWAbkKDTHO2SfH
         KqdjZ3cnril1HBgShcvk6ylSx+TM2GkW00EAeTyn83qUnff4+r/YaDhp1vcY00vCZOWT
         rJItU6bgqr/beQYXW0qFO6f1EEv5HRZff7kgcFDFOboeLY0qHJqYkmXctu3IhaHThAYo
         JUscRHO3cRIuBAo47HweX1RB1xSSad32j6UpfBIlDMFbZS9UlGH/ojkSeQnY63Zr16m0
         xlCrERgiLUUl+dFYA31FAPY2ihBEv/jyatPzPiCpGpe4AaiXn3G1yuSt2M7omKxAAzso
         hLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tz/IgNGyEGV4fc7STK4mOsJiKQO2/ubyNAHz5z15Usw=;
        b=NGFA4OIauUdxGyRsGABQ+ZG6CRFn5eofNSSsPa3itbZbXhO++R6CbX0M0DJINozsxD
         Cf0EWV6U6Hb8U4XuUaLoFY4OMtHxOJ5tR1D2Ky7w1JhbiZy7sGrrAKrIg9T5IhkhqWb6
         qVzhLz6u2zk6oh2jQxumCGumXFqStUcUk6dEg9gg8BZNOZ3rfwrXB1ypL2K7w7BHPs3H
         xyqWVfOpbBncR9u2wp0SkMfnGXhyMQ3AUx8sv03VSkj4H+0t/GMYmEvRLMMpGeuqhM+d
         OzkvtUDyfLSrylaXIAaxCJkZYiyuAO65IKC9Vw8szm1wv98xWsaIjxJT4u1t3mg4tBY9
         ZKMg==
X-Gm-Message-State: AJIora8IBI7N+pZiRLdHpV+0R+qdtw7USIfckyifzsXcedGVN0lqAU7C
        RMhRYJnljSYhPm9OcFiSC0XwOwCJx20=
X-Google-Smtp-Source: AGRyM1u27yV/2Nbuj4EaXXrDnJH3IZWLywJjCfy0C5MTc7thtoLUboPkuWXfT936+GBOrPmsbVPkIw==
X-Received: by 2002:a17:90b:341:b0:1e0:cf43:df4f with SMTP id fh1-20020a17090b034100b001e0cf43df4fmr23848971pjb.126.1658010313987;
        Sat, 16 Jul 2022 15:25:13 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id y12-20020aa78f2c000000b00528c149fe97sm6318662pfr.89.2022.07.16.15.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 15:25:13 -0700 (PDT)
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
Subject: [PATCH v2 5/6] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Sat, 16 Jul 2022 18:24:52 -0400
Message-Id: <20220716222454.29914-6-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220716222454.29914-1-jim2101024@gmail.com>
References: <20220716222454.29914-1-jim2101024@gmail.com>
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
 drivers/pci/controller/pcie-brcmstb.c | 138 ++++++++++++++++++--------
 1 file changed, 99 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index f98a5338fa8e..88339fde0df7 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -262,6 +262,8 @@ struct brcm_pcie {
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
 	bool			refusal_mode;
+	bool			regulator_oops;
+	struct subdev_regulators *sr;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -1112,10 +1114,37 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
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
@@ -1124,12 +1153,19 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
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
+	/*
+	 * We return 0 and turn on the "refusal_mode" so that any further
+	 * accesses to the pci_dev just get 0xffffffff
+	 */
+	if (brcm_pcie_start_link(pcie) != 0)
+		pcie->refusal_mode = true;
 
 	/*
 	 * There is not much of a point to return an error as currently it
@@ -1137,22 +1173,7 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
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
@@ -1160,15 +1181,28 @@ static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
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
@@ -1267,7 +1301,7 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
 	pcie->bridge_sw_init_set(pcie, 1);
 }
 
-static int brcm_pcie_suspend(struct device *dev)
+static int brcm_pcie_suspend_noirq(struct device *dev)
 {
 	struct brcm_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
@@ -1287,12 +1321,20 @@ static int brcm_pcie_suspend(struct device *dev)
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
@@ -1328,15 +1370,27 @@ static int brcm_pcie_resume(struct device *dev)
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
@@ -1443,16 +1497,16 @@ static struct pci_ops brcm_pcie_ops = {
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
@@ -1526,10 +1580,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	ret = brcm_pcie_start_link(pcie);
-	if (ret)
-		goto fail;
-
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
 	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
@@ -1551,7 +1601,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
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
@@ -1560,8 +1620,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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

