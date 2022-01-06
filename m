Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6707486746
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 17:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbiAFQEA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 11:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiAFQD5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jan 2022 11:03:57 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767EC0611FD;
        Thu,  6 Jan 2022 08:03:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so5055798pjl.0;
        Thu, 06 Jan 2022 08:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DuPkQ5sJoarT7nOT3y0NDaQHC98tJ10BZ2FpiUiaoT0=;
        b=hs141GemNiIYC645rkaWmPGU/cIQynFBAT58jQnntoZID+1wXx4MlJaujLCkEeQCJi
         olJAdRjvFs0alvLaVcE8FWSglnEZa+lokGG11DJw+6nE4eqwCdZYW+JUqwCAmBajNIZw
         Rr9CW/O0Uq/BGOYL1ZFwksXuELwLC5vEpMoPn1GaRQkXcspZQsjrnlVxx+XeFYZzeNdk
         Fbqv6wisS4wK91X8l5XK+zi4Uk99GghGOQ6bB5lD2Tprs9THST8d0c9iZV7LawUrBTP2
         yBVuZHzCWex38lqu7k2OrsvGQ0WNusP6ynl/kDA3blT9xCDlYn4kxZ2/WrFV3O3nNc/I
         kEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DuPkQ5sJoarT7nOT3y0NDaQHC98tJ10BZ2FpiUiaoT0=;
        b=yc5y1iXHiZMrSDSuHgaC06J3/zXgfmq1LIQfPYQ1MH3hEnwg2SJfVAdU7i7Md4Joo+
         qZMryhfShzlKDY+NgYI/16YCA35SJ3nE5t5LcAcN7ZgCzvNVfMTcavISAAG7mP6SNwpI
         +KJVm55ikewi1NL3+XvV7kx2LMBgZB3fx7DnM3A/DWv2Qgel5U39LA4bkQItuSr9Dt6a
         NBU8ruzH1tKXsfgG/u+Rx+/0rx2SolwjCZSYpHeir66qL6fqvOW54N9nOsSfF65iQwit
         XLMTfu2wQYambPoJCD85++EQzsx6Kx4tSehXwKsOQS6BCJPiqaMoBBkydll+4Nb4JMI4
         uW/A==
X-Gm-Message-State: AOAM531OejDDFOlJyNWXop6iCJ6/mHd0xHuJfYJse+kJ+CcYBWZ1ZQzI
        i1ykCCzjjERthVvcp+vzxDpj0dlkbRE=
X-Google-Smtp-Source: ABdhPJzMZupo5IIDS7Tqb1VjLSsvQrC6oumwLxgThY354rxsvCxWbaP9fCl5UoJUIS+WoVqw/nCaGA==
X-Received: by 2002:a17:902:b184:b0:149:be5f:c6f3 with SMTP id s4-20020a170902b18400b00149be5fc6f3mr17597855plr.174.1641485036618;
        Thu, 06 Jan 2022 08:03:56 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id q19sm2376316pgb.77.2022.01.06.08.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 08:03:56 -0800 (PST)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v11 6/7] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Thu,  6 Jan 2022 11:03:29 -0500
Message-Id: <20220106160332.2143-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220106160332.2143-1-jim2101024@gmail.com>
References: <20220106160332.2143-1-jim2101024@gmail.com>
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
 drivers/pci/controller/pcie-brcmstb.c | 82 +++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 7d46eccf17ff..3c1b2fefe7e1 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -192,6 +192,8 @@ static inline void brcm_pcie_bridge_sw_init_set_generic(struct brcm_pcie *pcie,
 static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
+static int brcm_pcie_linkup(struct brcm_pcie *pcie);
+static int brcm_pcie_add_bus(struct pci_bus *bus);
 
 enum {
 	RGR1_SW_INIT_1,
@@ -304,6 +306,8 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	bool			refusal_mode;
+	struct subdev_regulators *sr;
 };
 
 /*
@@ -467,6 +471,34 @@ static int pci_subdev_regulators_add_bus(struct pci_bus *bus)
 	return 0;
 }
 
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
 static void pci_subdev_regulators_remove_bus(struct pci_bus *bus)
 {
 	struct device *dev = &bus->dev;
@@ -785,6 +817,18 @@ static void __iomem *brcm_pcie_map_conf(struct pci_bus *bus, unsigned int devfn,
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
@@ -796,7 +840,7 @@ static struct pci_ops brcm_pcie_ops = {
 	.map_bus = brcm_pcie_map_conf,
 	.read = pci_generic_config_read,
 	.write = pci_generic_config_write,
-	.add_bus = pci_subdev_regulators_add_bus,
+	.add_bus = brcm_pcie_add_bus,
 	.remove_bus = pci_subdev_regulators_remove_bus,
 };
 
@@ -1245,6 +1289,14 @@ static int brcm_pcie_suspend(struct device *dev)
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
@@ -1262,9 +1314,17 @@ static int brcm_pcie_resume(struct device *dev)
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
@@ -1296,6 +1356,8 @@ static int brcm_pcie_resume(struct device *dev)
 
 err_reset:
 	reset_control_rearm(pcie->rescal);
+err_regulator:
+	regulator_bulk_disable(pcie->sr->num_supplies, pcie->sr->supplies);
 err_disable_clk:
 	clk_disable_unprepare(pcie->clk);
 	return ret;
@@ -1425,7 +1487,17 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 
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
@@ -1434,8 +1506,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
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

