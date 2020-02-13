Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC45715B76C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 03:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgBMC7x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 21:59:53 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40557 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgBMC7w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Feb 2020 21:59:52 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so2266620pgk.7;
        Wed, 12 Feb 2020 18:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8BL8vP5NMTytKwhGPCvc8BMjPI7WOjnt3iXA7k4tMW0=;
        b=AYDo7SGzZo1jCJpr+m7BD1pY3VP53RipV5laq/W2ASp6gfmJ3iAqMdM9Bi4euhNhfm
         92pi4BlyDTC/S5maH98qaD96PimUhXZCY/2hp5iMNsQr6QKAGMbrpj4sEb9Nsst41+0a
         SkPVA4PtURhsqCZpqoeENGYJpBcOdXD6Ybkr0zgtEwmN5Kd7PuVXJi+4ErI/NCt/diO7
         5kzpq9sZ4kT/LcUqEn2mqgVM0UwJkt5ygGVi5s+IWWOLvHRC65zFVr3iHRXMmPgKaSBL
         cTzOT0u3p6Q87UX/MevuG1pJ3Q/FRXSGy+g0XMevZDEAYbssYiOe0o0kDNX3Q/SXzuuo
         vqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8BL8vP5NMTytKwhGPCvc8BMjPI7WOjnt3iXA7k4tMW0=;
        b=IPm/dz6vWpSsriPJEUoTbvdxNQFrYydoAuZNn7Yv5LgFR9eJ51l4V1iku2Ix1HeNDD
         su3iPTJnwwzoxiKh4gJtABl++7rUsEjo84a3D3vNST8oq3pLuiZDC1/ch0jeRjaXkZ3q
         Y/tnMaJVL90nrDeY+h/ddMyJrC1dUAX38emS3FqZtOJg2MuDCJVebOfVfvcCcz3fR9fU
         cfJN2LbyOyMjXdP0os4UovQfK4Uv0Fr24ahRUfGsx3s1+si07Bh8mHxPx9efoV8zTxk5
         9QuBfcWR0ItTsyIsM2E+mx2ldCIZs0kz4zANEq2vRTdhOCKT9WKEyTZrErxWuiLhKouh
         qzmw==
X-Gm-Message-State: APjAAAUEsMAfpXMgJuPIu9B1OMmJsrWB2uPOq1ChcerOGWwgSfUb0MVQ
        kUCxurX2VdVSjFDgNR/Vt+g=
X-Google-Smtp-Source: APXvYqwK+4zKLSl6S5rlqW83Vct22r2bYLt3O1CMcbxDrjJ6dMSoXBvT82hT9HnOw5OQvRnaOzcPUA==
X-Received: by 2002:aa7:979a:: with SMTP id o26mr11705841pfp.257.1581562791654;
        Wed, 12 Feb 2020 18:59:51 -0800 (PST)
Received: from localhost.localdomain ([125.130.116.2])
        by smtp.gmail.com with ESMTPSA id 64sm602643pfd.48.2020.02.12.18.59.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 18:59:51 -0800 (PST)
From:   Jaedon Shin <jaedon.shin@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, Jaedon Shin <jaedon.shin@gmail.com>
Subject: [PATCH 2/3] PCI: brcmstb: Add regulator support
Date:   Thu, 13 Feb 2020 11:59:29 +0900
Message-Id: <20200213025930.27943-3-jaedon.shin@gmail.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200213025930.27943-1-jaedon.shin@gmail.com>
References: <20200213025930.27943-1-jaedon.shin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ARM-based Broadcom STB SoCs have GPIO-based voltage regulator for PCIe
turning off/on power supplies.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 drivers/gpio/gpio-brcmstb.c           | 13 ++++-
 drivers/pci/controller/pcie-brcmstb.c | 76 +++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 05e3f99ae59c..0cee5fcd2782 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -777,7 +777,18 @@ static struct platform_driver brcmstb_gpio_driver = {
 	.remove = brcmstb_gpio_remove,
 	.shutdown = brcmstb_gpio_shutdown,
 };
-module_platform_driver(brcmstb_gpio_driver);
+
+static int __init brcmstb_gpio_init(void)
+{
+	return platform_driver_register(&brcmstb_gpio_driver);
+}
+subsys_initcall(brcmstb_gpio_init);
+
+static void __exit brcmstb_gpio_exit(void)
+{
+	platform_driver_unregister(&brcmstb_gpio_driver);
+}
+module_exit(brcmstb_gpio_exit);
 
 MODULE_AUTHOR("Gregory Fong");
 MODULE_DESCRIPTION("Driver for Broadcom BRCMSTB SoC UPG GPIO");
diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 34581a6a7313..0e0ca39a680b 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -23,6 +23,7 @@
 #include <linux/of_platform.h>
 #include <linux/pci.h>
 #include <linux/printk.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/string.h>
@@ -173,8 +174,79 @@ struct brcm_pcie {
 	int			gen;
 	u64			msi_target_addr;
 	struct brcm_msi		*msi;
+#ifdef CONFIG_REGULATOR
+	int			num_regs;
+	struct regulator	**regs;
+#endif
 };
 
+#ifdef CONFIG_REGULATOR
+static void brcm_pcie_regulator_enable(struct brcm_pcie *pcie)
+{
+	int i, ret;
+
+	for (i = 0; i < pcie->num_regs; i++) {
+		if (!pcie->regs[i])
+			continue;
+
+		ret = regulator_enable(pcie->regs[i]);
+		if (ret)
+			dev_err(pcie->dev, "Failed to enable regulator\n");
+	}
+}
+
+static void brcm_pcie_regulator_disable(struct brcm_pcie *pcie)
+{
+	int i, ret;
+
+	for (i = 0; i < pcie->num_regs; i++) {
+		if (!pcie->regs[i])
+			continue;
+
+		ret = regulator_disable(pcie->regs[i]);
+		if (ret)
+			dev_err(pcie->dev, "Failed to disable regulator\n");
+	}
+}
+
+static void brcm_pcie_regulator_init(struct brcm_pcie *pcie)
+{
+	struct device_node *np = pcie->dev->of_node;
+	struct device *dev = pcie->dev;
+	const char *name;
+	struct regulator *reg;
+	int i;
+
+	pcie->num_regs = of_property_count_strings(np, "supply-names");
+	if (pcie->num_regs <= 0) {
+		pcie->num_regs = 0;
+		return;
+	}
+
+	pcie->regs = devm_kcalloc(dev, pcie->num_regs, sizeof(pcie->regs[0]),
+				  GFP_KERNEL);
+	if (!pcie->regs) {
+		pcie->num_regs = 0;
+		return;
+	}
+
+	for (i = 0; i < pcie->num_regs; i++) {
+		if (of_property_read_string_index(np, "supply-names", i, &name))
+			continue;
+
+		reg = devm_regulator_get_optional(dev, name);
+		if (IS_ERR(reg))
+			continue;
+
+		pcie->regs[i] = reg;
+	}
+}
+#else
+static inline void brcm_pcie_regulator_enable(struct brcm_pcie *pcie) { }
+static inline void brcm_pcie_regulator_disable(struct brcm_pcie *pcie) { }
+static inline void brcm_pcie_regulator_init(struct brcm_pcie *pcie) { }
+#endif
+
 /*
  * This is to convert the size of the inbound "BAR" region to the
  * non-linear values of PCIE_X_MISC_RC_BAR[123]_CONFIG_LO.SIZE
@@ -898,6 +970,7 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
 {
 	brcm_msi_remove(pcie);
 	brcm_pcie_turn_off(pcie);
+	brcm_pcie_regulator_disable(pcie);
 	clk_disable_unprepare(pcie->clk);
 	clk_put(pcie->clk);
 }
@@ -955,6 +1028,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	brcm_pcie_regulator_init(pcie);
+	brcm_pcie_regulator_enable(pcie);
+
 	ret = brcm_pcie_setup(pcie);
 	if (ret)
 		goto fail;
-- 
2.21.0

