Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4AB646F5C3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 22:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhLIVSK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 16:18:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhLIVSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 16:18:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F30DC061353;
        Thu,  9 Dec 2021 13:14:31 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q16so6188372pgq.10;
        Thu, 09 Dec 2021 13:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dZMcHb3UiJ34ZchDQTmKgC2WeBRqnz1j82a2xIWNX7w=;
        b=lqGiEDu0rd3SGWitzAV7M5LlgIsh4Iro4EedGhj6mWVuOyODsFkxmc7bYwssiLDJXm
         XLBYQeedc7rcejAVsSvzU8yMAS3wwqheWxSCM+X67xWxV6bRNHT7a9fWYOJqfq5n4YA1
         LonbvZV4PJMXcDbV2G6eacIrO6DTULqyFBMmoC+jxJm6MdRQt3jtvfyziIh8o99LQs92
         NFRMEG8J/4pcSlErkvVU+I5b3KxoBkaMqRHijbGyN0YmqLC4ncAmiO6/HrNel0XEXyFX
         GgE/SmiHF2QvAT4RKfL7DJYFEjw0u5tSeXMMIMkXDbvCOZMtBYpOFJkDd15FWjXjF6C/
         pK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dZMcHb3UiJ34ZchDQTmKgC2WeBRqnz1j82a2xIWNX7w=;
        b=jGEf1fSyC3xcam1lGQGIBYj6zSqrFf7myVuBL4pyraMfYn0sM2eZ5x2nb17ZJfWQWq
         W/xIZF52MWV4VWDDn2ljOVhwZtPWUw/sKMVWc72LX0t2V9KFAv1MfEN7cIi6owACwkVA
         3ixo87iMpRBdPfKX1FrwoU1r0e62VjPZ0f02qvKxDVwt/EAjf9Ez36f3Q0K7QYuuNCAe
         0e/VQOdg/CK03WnQi4UZbXCF6ijvEKY23IHGeRk2mH3a/yxgZ5Gf33VxuAlEbAOEst92
         5j2KxDQLTr6DFVQ74ZZkWwHjoqpYKb16eN5raHTZ8bJpB9Zq7RBLqASTpbr0b0Vmpbsz
         qZ3Q==
X-Gm-Message-State: AOAM530sSTHR2+5yRoWVpfqBkJLbjksLUUeCmik/pdMYIzIsMG4R1R+U
        pAjHC4MsdcWmUNQROYUfsUWKB7KS9bs=
X-Google-Smtp-Source: ABdhPJzK49wvtB15D40vynDAko/WEB/IXGw5aiV4OaJ70GaDdaA7ZD5HgL7CDUPzO2q3QElPtBkCrA==
X-Received: by 2002:a62:33c6:0:b0:4a0:3a81:3489 with SMTP id z189-20020a6233c6000000b004a03a813489mr13984302pfz.59.1639084470512;
        Thu, 09 Dec 2021 13:14:30 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id y4sm617800pfi.178.2021.12.09.13.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 13:14:30 -0800 (PST)
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
Subject: [PATCH v10 6/7] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Thu,  9 Dec 2021 16:14:04 -0500
Message-Id: <20211209211407.8102-7-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209211407.8102-1-jim2101024@gmail.com>
References: <20211209211407.8102-1-jim2101024@gmail.com>
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

