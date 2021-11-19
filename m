Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A3B457887
	for <lists+linux-pci@lfdr.de>; Fri, 19 Nov 2021 23:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234752AbhKSWLW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 17:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbhKSWLS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 17:11:18 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A7EC061574;
        Fri, 19 Nov 2021 14:08:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id m15so9728000pgu.11;
        Fri, 19 Nov 2021 14:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dZMcHb3UiJ34ZchDQTmKgC2WeBRqnz1j82a2xIWNX7w=;
        b=lu51B37sYJkJFff+4OCkUTLnA/V4MDjFmyQPR4U9Pln9/Y3p+vQ2aUKyEYLW8FSDOn
         1+bKjMzPzfkb7vguoUrNQE3P/M19UcFi56ZBahJtXHXjw13M07zBwTrv6CuEjsEDj4Gh
         jqhcEyZm3eCxI1ozZDJgy0My2x/yb51EdzYGGuXxJrKZht4K73UPAyh/7R6Gsh/pwvOD
         Yo9dBIMF++AVYeY0n2C8szI5VZUehmKThdi1jOyJKqj1iy+VllTBP/+YO+z8fPH0hjb8
         U9H7HgAn070B2jiTL2dZF6Sqs9/eUlQPEbFt0tHErfhA71jokMJqU5Dpp+jXa0N/1BAm
         NxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dZMcHb3UiJ34ZchDQTmKgC2WeBRqnz1j82a2xIWNX7w=;
        b=CShpHcYsBUepc8nrpSxhdrFgtLLhdmO/27SbLEyN8rgjb+GGaa6cdTFuGuQ4t9CjjT
         A0UdSGaHQEHK/QDurMJf7h0VkQncAbw8GGE4OOtw42qk+O8bKRXsg0+fCBjyFVmlfl/z
         D2ZLb0L7Yz3fYt1sY0wN/LHuoXxLwjm93MS7tel0x/8SGvHZ8Hejumjn7Lf8B30MLJGx
         UKs2XI5X4do3q2Q+dfmaEcri4cUIxG8SzEtp/qyV1KSjZGjfQTZzSU/xGQY4JxhgoHNX
         uM5EU/ntvdtw4GZ5oiYw/ZcELLBxLIDP6MjcpBRotspYmCoRpfVyPIaMWr5EJDPk4Li/
         PPlQ==
X-Gm-Message-State: AOAM532/z99nEEJ8+5lRUSV0qL2av03iz8AqbGccFr9HO5KG0vqIRcVD
        K8g3aSqC2bsAmPWuwZaMSQJQk0xKvbghag==
X-Google-Smtp-Source: ABdhPJw6rrHXY3KSG+uA7dNZp1Vf6OmAYrr7871M3nftoCAxz8veEZvShrJI+j5PYP+AEEtWnO2CFA==
X-Received: by 2002:a05:6a00:1399:b0:49f:ae7d:cda6 with SMTP id t25-20020a056a00139900b0049fae7dcda6mr25962290pfg.10.1637359695710;
        Fri, 19 Nov 2021 14:08:15 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id t2sm612940pfd.36.2021.11.19.14.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:08:15 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 6/7] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Fri, 19 Nov 2021 17:07:53 -0500
Message-Id: <20211119220756.18628-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119220756.18628-1-jim2101024@gmail.com>
References: <20211119220756.18628-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This Broadcom STB PCIe RC driver has one port and connects directly to one
device, be it a switch or an endpoint.  We want to be able to leverage
the recently added mechansim that allocates and turns on/off subdevice
regulators.

All that needs to be done is to put the regulator DT nodes in the bridge
below host and to set the pci_ops methods add_bus and remove_bus.

Note that the pci_subdev_regulators_add_bus() method is wrapped for two
reasons:

   1. To acheive linkup after the voltage regulators are turned on.

   2. If, in the case of an unsuccessful linkup, to redirect
      any PCIe accesses to subdevices, e.g. the scan for
      DEV/ID.  This redirection is needed because the Broadcom
      PCIe HW wil issue a CPU abort if such an access is made when
      there is no linkup.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 81 +++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 5f373227aad6..9b4df253e79a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -191,6 +191,7 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static int brcm_pcie_add_bus(struct pci_bus *bus);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -295,6 +296,8 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool			refusal_mode;
+	struct subdev_regulators *sr;
 };
 
 /*
@@ -711,6 +714,18 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
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
@@ -722,6 +737,8 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
+	.add_bus = brcm_pcie_add_bus,
+	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
 static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie, u32 val)
@@ -1169,6 +1186,14 @@ static int brcm_pcie_suspend(struct device *dev)
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
@@ -1186,9 +1211,17 @@ static int brcm_pcie_resume(struct device *dev)
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
@@ -1220,6 +1253,8 @@ static int brcm_pcie_resume(struct device *dev)
 
 err_reset:
 	reset_control_rearm(pcie->rescal);
+err_regulator:
+	regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
@@ -1258,6 +1293,34 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{},
 };
 
+static int brcm_pcie_add_bus(struct pci_bus *bus)
+{
+	struct device *dev = &bus->dev;
+	struct brcm_pcie *pcie = (struct brcm_pcie *) bus->sysdata;
+	int ret;
+
+	if (!dev->of_node || !bus->parent || !pci_is_root_bus(bus->parent))
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
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
@@ -1349,7 +1412,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
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
@@ -1358,8 +1431,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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

