Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CEA4378B4
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhJVOJ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbhJVOJu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 10:09:50 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A00C061224;
        Fri, 22 Oct 2021 07:07:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 75so3433920pga.3;
        Fri, 22 Oct 2021 07:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+7GShJO/vFXregS3LjDBjs7+CHBjOeZ46IIUcz+82c=;
        b=aD3uV1d1rh3SsCQNd4/bjpuRFgXpnkRF1jXcLQqkp3tzCGhC6SHFtTkh3idy9iuakK
         4By1yuPRVYMe9HZg/enPGNAXIF1vMCfuzhFRLKtZDC/+lM5OYQZcWflAHfJBQCmg4wMu
         PMQgpMXgnJeMVg58ymO2Jp7G0a1UNU8gq4uzADvyUJLRnWbJVVHn+kZE2Iusf3BhU6oT
         F460+zafzgY0kwlwnFqUNFg9MHFvns6aviYMmLHMIsnUetcDB79cXOX5hXHjhTgBpnlk
         75rPhoO/aLsqLMIOyFjSxUOk7u3hQMtxuBqiGcVFPihB/Fs/RXv3e8hF0qveCIvjmmPd
         F1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+7GShJO/vFXregS3LjDBjs7+CHBjOeZ46IIUcz+82c=;
        b=UbPiyWFkRJ1E/D1oOtZjF2oQx4RCdP2WrzqOtGzZs4Nfizl9VHHgtZ3l036gcrV70P
         VctVUnlPjzMQagTrwzJV42d8Er7JMQRmFaabxNISunHrW5aPJbfSx8OTradtPlWzmCz1
         is30m8VXEVFrqwxwwL4WBrvQpo3Lr+LkJomhkQEP9PMofODRwFE9dPFC7SYpsZlUQcYT
         UciJ4jpQXV2L3WxzvNrupYHd+2IyHxd2y94kpUlX3aNf4c4CesbS5SRXVYFdizZdNPPO
         is+7A/1K29Lb0mDluafQNRf92aW2C6whPQISgrgVMM+zUo9ikp8/b0Wb7KkYMvX3fZkl
         DGBw==
X-Gm-Message-State: AOAM530e5cKRrn4EyZZPuhX7iufLIIMf/qcZyXsW3S5bbEEzz8h0Niqb
        EjXYWrqf6TQtAXIT6VjosAUdE0z883dUMw==
X-Google-Smtp-Source: ABdhPJwQLhAuM9RJahLcrYBc+wH1UumKiFKoS2YMyYKRw9+SGSh7JIrnTm5XjsuFe2gT/b+99l7U0w==
X-Received: by 2002:a63:2cd8:: with SMTP id s207mr9681631pgs.312.1634911652294;
        Fri, 22 Oct 2021 07:07:32 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id e12sm9482990pfl.67.2021.10.22.07.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:07:31 -0700 (PDT)
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
Subject: [PATCH v5 4/6] PCI: brcmstb: Add control of subdevice voltage regulators
Date:   Fri, 22 Oct 2021 10:06:57 -0400
Message-Id: <20211022140714.28767-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211022140714.28767-1-jim2101024@gmail.com>
References: <20211022140714.28767-1-jim2101024@gmail.com>
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
 drivers/pci/controller/pcie-brcmstb.c | 148 +++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index ba4d6daf312c..35924af1c3aa 100644
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
@@ -192,6 +193,13 @@ static inline void brcm_pcie_perst_set_4908(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_7278(struct brcm_pcie *pcie, u32 val);
 static inline void brcm_pcie_perst_set_generic(struct brcm_pcie *pcie, u32 val);
 
+static const char * const supplies[] = {
+	"vpcie3v3-supply",
+	"vpcie3v3aux-supply",
+	"brcm-ep-a-supply",
+	"brcm-ep-b-supply",
+};
+
 enum {
 	RGR1_SW_INIT_1,
 	EXT_CFG_INDEX,
@@ -295,8 +303,27 @@ struct brcm_pcie {
 	u32			hw_rev;
 	void			(*perst_set)(struct brcm_pcie *pcie, u32 val);
 	void			(*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supplies)];
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
@@ -1148,6 +1175,55 @@ static void brcm_pcie_turn_off(struct brcm_pcie *pcie)
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
+		for (i = 0; i < ns; i++)
+			if (strcmp(supplies[i], pp->name) == 0)
+				break;
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
@@ -1158,7 +1234,7 @@ static int brcm_pcie_suspend(struct device *dev)
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
 
-	return ret;
+	return brcm_set_regulators(pcie, false);
 }
 
 static int brcm_pcie_resume(struct device *dev)
@@ -1174,6 +1250,9 @@ static int brcm_pcie_resume(struct device *dev)
 	ret = reset_control_reset(pcie->rescal);
 	if (ret)
 		goto err_disable_clk;
+	ret = brcm_set_regulators(pcie, true);
+	if (ret)
+		goto err_reset;
 
 	ret = brcm_phy_start(pcie);
 	if (ret)
@@ -1217,6 +1296,10 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 	brcm_phy_stop(pcie);
 	reset_control_rearm(pcie->rescal);
 	clk_disable_unprepare(pcie->clk);
+	if (pcie->num_supplies) {
+		(void)brcm_set_regulators(pcie, false);
+		regulator_bulk_free(pcie->num_supplies, pcie->supplies);
+	}
 }
 
 static int brcm_pcie_remove(struct platform_device *pdev)
@@ -1241,6 +1324,56 @@ static const struct of_device_id brcm_pcie_match[] = {
 	{},
 };
 
+static int brcm_pcie_pci_subdev_prepare(bool query, struct pci_bus *bus, int devfn,
+					struct pci_host_bridge *bridge,
+					struct pci_dev *pdev)
+{
+	struct brcm_pcie *pcie;
+	int ret = 0;
+
+	/*
+	 * We only care about a device that is directly connected
+	 * to the root complex, ie bus == 1 and slot == 0.
+	 */
+	if (query)
+		return (bus->number == 1 && PCI_SLOT(devfn) == 0);
+
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
+	ret = brcm_set_regulators(pcie, true);
+	if (ret)
+		goto err_out0;
+
+	ret = brcm_pcie_linkup(pcie);
+	if (ret)
+		goto err_out1;
+
+	/*
+	 * dev_set_name() was called in brcm_set_regulators().  Free the
+	 * string it allocated as it will be called again when
+	 * pci_setup_device() is invoked.
+	 */
+	kfree_const(pdev->dev.kobj.name);
+	pdev->dev.kobj.name = NULL;
+
+	return 0;
+
+err_out1:
+	brcm_set_regulators(pcie, false);
+err_out0:
+	regulator_bulk_free(pcie->num_supplies, pcie->supplies);
+	pcie->num_supplies = 0;
+	return ret;
+}
+
 static int brcm_pcie_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node, *msi_np;
@@ -1327,12 +1460,23 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		}
 	}
 
+	bridge->pci_subdev_prepare = brcm_pcie_pci_subdev_prepare;
 	bridge->ops = &brcm_pcie_ops;
 	bridge->sysdata = pcie;
 
 	platform_set_drvdata(pdev, pcie);
 
-	return pci_host_probe(bridge);
+	ret = pci_host_probe(bridge);
+	if (ret)
+		goto fail;
+
+	if (!brcm_pcie_link_up(pcie)) {
+		brcm_pcie_remove(pdev);
+		return -ENODEV;
+	}
+
+	return 0;
+
 fail:
 	__brcm_pcie_remove(pcie);
 	return ret;
-- 
2.17.1

