Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0E5637E2
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiGAQ1n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiGAQ1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:27:34 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6FA4160B;
        Fri,  1 Jul 2022 09:27:33 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id z16so2185688qkj.7;
        Fri, 01 Jul 2022 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aq233oq+uKalI3I/+pvH+si1LrClivhMQ+ALPeK7kxU=;
        b=CmdXWwQ+z8M3murr+6qzvEkmYpzk0I43cAxJbK+W96QiajT/U6ceya6i0opTKv3Mha
         uQe2n2/BF3ATh6tR/S8TNJ16ajE3v4PINitwmGDTg+R6iY0VZ35pK1CXabFzAKGf0niM
         Nl0NsEqzelWpv4hj2m3Vzn2FiJXsv5W4krDgXgPQddKiuzMoj8k9YbpU+6a18MKFJTwc
         t7xEprgtBsKeNbNw3lH+gNdPdhPrj4D6krOANqu9SUedvBbcYZVdKxN11FQikgIRJoxr
         HHlqyQCSgj9EONTkAnJh2P5vF6p2rWEVQJXDAeu5SpHiGYKtiiznLjtlpmmid+6qSsU1
         ykkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aq233oq+uKalI3I/+pvH+si1LrClivhMQ+ALPeK7kxU=;
        b=Ok7xlMx+bYx/M6wNdKRowsgzN0U/0jlusoEGSCq3nH2VEi28wgkVy93r8qLoyDDLth
         i/KvxEDjHDqfevokd2WGA6cc9BjR+B1ktQuhd5TcK62aVHMv8mFvPnQskaM/EYs9bI30
         2+R65icuXz7t9fU0/hJhx76GOzNuKHi99DVIQ5tnMTj5KktwPm0zhSkQQuVRgdIGZv5G
         xRvjhRzQ5IUD80hHK6KB8469LApL/Ly9eurtXZepebbl9J+CMvWBdKC5R1Gld5FlB+D4
         +oec2sVuvUEwnQLS3T0O4L0AsCBsH4DkeP71RntcbV0MPcJrV4T6x1QkG0HD8HgM9Dku
         mIOw==
X-Gm-Message-State: AJIora904NSzxmNn+XE03rbgqZxqvcusmegYfBifIflO0oNP92wAFdId
        V13oE6PvJ1Az3VVhJQXyVYGIHPmFbjc=
X-Google-Smtp-Source: AGRyM1vS6jT2mvdM4kcrJrxb99Cyvx+RrixMrt3TtmgH4fxL3QqKpc7XZ8BskwfdqqyXKfrfPJuCCQ==
X-Received: by 2002:a37:9f95:0:b0:6ae:fb2d:eee2 with SMTP id i143-20020a379f95000000b006aefb2deee2mr11080524qke.251.1656692852477;
        Fri, 01 Jul 2022 09:27:32 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006af08c26774sm17316175qko.47.2022.07.01.09.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:27:32 -0700 (PDT)
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
Subject: [PATCH v1 3/4] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Fri,  1 Jul 2022 12:27:24 -0400
Message-Id: <20220701162726.31346-4-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220701162726.31346-1-jim2101024@gmail.com>
References: <20220701162726.31346-1-jim2101024@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

[bhelgaas: fold in
https://lore.kernel.org/r/20220112013100.48029-1-jim2101024@gmail.com]
Link: https://lore.kernel.org/r/20220106160332.2143-7-jim2101024@gmail.com
Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 86 ++++++++++++++++++++++++---
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 661d3834c6da..a86bf502a265 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -196,6 +196,8 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static int brcm_pcie_linkup(struct brcm_pcie *pcie);
+static int brcm_pcie_add_bus(struct pci_bus *bus);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -329,6 +331,8 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool			refusal_mode;
+	struct subdev_regulators *sr;
 };
 
 static inline bool is_bmips(const struct brcm_pcie *pcie)
@@ -497,6 +501,33 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 	return 0;
 }
 
+static int brcm_pcie_add_bus(struct pci_bus *bus)
+{
+	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
+	int ret;
+
+	if (!bus->parent || !pci_is_root_bus(bus->parent))
+		return 0;
+
+	ret = pci_subdev_regulators_add_bus(bus);
+	if (ret)
+		return ret;
+
+	/* Grab the regulators for suspend/resume */
+	pcie->sr = bus->dev.driver_data;
+
+	/*
+	 * If we have failed linkup there is no point to return an error as
+	 * currently it will cause a WARNING() from pci_alloc_child_bus().
+	 * We return 0 and turn on the "refusal_mode" so that any further
+	 * accesses to the pci_dev just get 0xffffffff
+	 */
+	if (brcm_pcie_linkup(pcie) != 0)
+		pcie->refusal_mode = true;
+
+	return 0;
+}
+
 static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
 {
 	struct device *dev = &bus->dev;
@@ -826,6 +857,18 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
 	/* Accesses to the RC go right to the RC registers if slot==0 */
 	if (pci_is_root_bus(bus))
 		return PCI_SLOT(devfn) ? NULL : base + where;
+	if (pcie->refusal_mode) {
+		/*
+		 * At this point we do not have link.  There will be a CPU
+		 * abort -- a quirk with this controller --if Linux tries
+		 * to read any config-space registers besides those
+		 * targeting the host bridge.  To prevent this we hijack
+		 * the address to point to a safe access that will return
+		 * 0xffffffff.
+		 */
+		writel(0xffffffff, base + PCIE_MISC_RC_BAR2_CONFIG_HI);
+		return base + PCIE_MISC_RC_BAR2_CONFIG_HI + (where & 0x3);
+	}
 
 	/* For devices, write to the config space index register */
 	idx = PCIE_ECAM_OFFSET(bus->number, devfn, 0);
@@ -854,7 +897,7 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = pci_subdev_regulators_add_bus,
+	.add_bus = brcm_pcie_add_bus,
 	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
@@ -1327,6 +1370,14 @@ static int brcm_pcie_suspend(struct device *dev)
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
@@ -1344,9 +1395,17 @@ static int brcm_pcie_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	if (pcie->sr) {
+		ret = regulator_bulk_enable(pcie->sr->num_supplies, pcie->sr->supplies);
+		if (ret) {
+			dev_err(dev, "Could not turn on regulators\n");
+			goto err_disable_clk;
+		}
+	}
+
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
-		goto err_disable_clk;
+		goto err_regulator;
 
 	ret = brcm_phy_start(pcie);
 	if (ret)
@@ -1378,6 +1437,9 @@ static int brcm_pcie_resume(struct device *dev)
 
 err_reset:
 	reset_control_rearm(pcie->rescal);
+err_regulator:
+	if (pcie->sr)
+		regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
@@ -1488,10 +1550,6 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail;
 
-	ret = brcm_pcie_linkup(pcie);
-	if (ret)
-		goto fail;
-
 	pcie->hw_rev = readl(pcie->base + PCIE_MISC_REVISION);
 	if (pcie->type == BCM4908 && pcie->hw_rev >= BRCM_PCIE_HW_REV_3_20) {
 		dev_err(pcie->dev, "hardware revision with unsupported PERST# setup\n");
@@ -1513,7 +1571,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
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
@@ -1522,8 +1590,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 MODULE_DEVICE_TABLE(of, brcm_pcie_match);
 
 static const struct dev_pm_ops brcm_pcie_pm_ops = {
-	.suspend = brcm_pcie_suspend,
-	.resume = brcm_pcie_resume,
+	.suspend_noirq = brcm_pcie_suspend,
+	.resume_noirq = brcm_pcie_resume,
 };
 
 static struct platform_driver brcm_pcie_driver = {
-- 
2.17.1

