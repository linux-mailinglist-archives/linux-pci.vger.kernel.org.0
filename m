Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B395AF643
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 22:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbiIFUnH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 16:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiIFUnG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 16:43:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C7B8B9A8;
        Tue,  6 Sep 2022 13:43:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id j12so120115pfi.11;
        Tue, 06 Sep 2022 13:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=BbfLC4ws9R3hOi3BD7bYuf4EI7Nopwizd0E+k/EX/0A=;
        b=MGxrErQNBHHEyo3yV2iAOVLhCgCaAvaYt7Bzz7VgtkO6RUXDbAKAf7+na033usLCiz
         A/GApEIG35dtYK2nsLsBx5s6I62ti3uJ6VyolvPzp5CbNDW5Jh0P+86lW/wklP1Fw5hp
         f2WEHsGtcJ5wk5PfnVocKHMSxZyPGA+B57twdpiPfsoLoQ/FemUeXT1MRuMmpJ8oUZG6
         70Qk9oF1Igmr56rvay46VFHMsAu71UFwA45E+sqFyq5rvSq9DCf1oX8xDQQMw9db9+iD
         3+AFlhaPb8Fa8e8ph4U9iznZYZi2FVn7HRroKZr4IBJ4cDsnTl+/RcBqHT85pjDAquVl
         Jg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BbfLC4ws9R3hOi3BD7bYuf4EI7Nopwizd0E+k/EX/0A=;
        b=Iji5PYPCYZvaR8dhA25ODUueocz9i4AHbju37GlbzkKa7P5cGMGxA345uG0yxMJ9b3
         fyclKR87a9WMynT+2AgKpbQth9ewJBkM8fw5dPnYoYHaSoglfEtk3vbglzIVhTa4WNjE
         YuWjhaXl7d+Yh2xFePphlCsb1qHeZrZFozSfYXSMPm7zlprbzO9hnwfGEkDrk1g7/AWY
         djBtQm2Y6lgLnojS9gI1Y+Y5fGhZnsOChIH4ENk7zvRXxQ4jLCL/35qgPWG3UQmLGM4N
         8HRrLtSZ5jsavhVKu7tEGN4o/R+EoNkQHP0LlYdyjaO+r5iPDNg/YkAPr3gRvOIl86mO
         U/2Q==
X-Gm-Message-State: ACgBeo29qq62htOa4mCUriUwEuQ33GHf+oxL1E2QrhLT/S3PlejQ96WY
        gsQycJlfBTb4vnNdQTyb8CQ=
X-Google-Smtp-Source: AA6agR4P7/Q89Ibh2uv7NJ/hfhkLqfRn1N8AF8nhdtd7xNbngL9NiJDO7m8sN3R3OuTpTW0EFFVBaA==
X-Received: by 2002:a63:8241:0:b0:42b:c6e8:d3e4 with SMTP id w62-20020a638241000000b0042bc6e8d3e4mr394812pgd.113.1662496985237;
        Tue, 06 Sep 2022 13:43:05 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b0016c57657977sm10359961plg.41.2022.09.06.13.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:43:04 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI: histb: switch to using gpiod API
Date:   Tue,  6 Sep 2022 13:43:00 -0700
Message-Id: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch switches the driver away from legacy gpio/of_gpio API to
gpiod API, and removes use of of_get_named_gpio_flags() which I want to
make private to gpiolib.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/pci/controller/dwc/pcie-histb.c | 39 ++++++++++++-------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index e2b80f10030d..43c27812dd6d 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -10,11 +10,11 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/pci.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
@@ -60,7 +60,7 @@ struct histb_pcie {
 	struct reset_control *sys_reset;
 	struct reset_control *bus_reset;
 	void __iomem *ctrl;
-	int reset_gpio;
+	struct gpio_desc *reset_gpio;
 	struct regulator *vpcie;
 };
 
@@ -212,8 +212,8 @@ static void histb_pcie_host_disable(struct histb_pcie *hipcie)
 	clk_disable_unprepare(hipcie->sys_clk);
 	clk_disable_unprepare(hipcie->bus_clk);
 
-	if (gpio_is_valid(hipcie->reset_gpio))
-		gpio_set_value_cansleep(hipcie->reset_gpio, 0);
+	if (hipcie->reset_gpio)
+		gpiod_set_value_cansleep(hipcie->reset_gpio, 1);
 
 	if (hipcie->vpcie)
 		regulator_disable(hipcie->vpcie);
@@ -235,8 +235,8 @@ static int histb_pcie_host_enable(struct dw_pcie_rp *pp)
 		}
 	}
 
-	if (gpio_is_valid(hipcie->reset_gpio))
-		gpio_set_value_cansleep(hipcie->reset_gpio, 1);
+	if (hipcie->reset_gpio)
+		gpiod_set_value_cansleep(hipcie->reset_gpio, 0);
 
 	ret = clk_prepare_enable(hipcie->bus_clk);
 	if (ret) {
@@ -298,10 +298,7 @@ static int histb_pcie_probe(struct platform_device *pdev)
 	struct histb_pcie *hipcie;
 	struct dw_pcie *pci;
 	struct dw_pcie_rp *pp;
-	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
-	enum of_gpio_flags of_flags;
-	unsigned long flag = GPIOF_DIR_OUT;
 	int ret;
 
 	hipcie = devm_kzalloc(dev, sizeof(*hipcie), GFP_KERNEL);
@@ -336,17 +333,19 @@ static int histb_pcie_probe(struct platform_device *pdev)
 		hipcie->vpcie = NULL;
 	}
 
-	hipcie->reset_gpio = of_get_named_gpio_flags(np,
-				"reset-gpios", 0, &of_flags);
-	if (of_flags & OF_GPIO_ACTIVE_LOW)
-		flag |= GPIOF_ACTIVE_LOW;
-	if (gpio_is_valid(hipcie->reset_gpio)) {
-		ret = devm_gpio_request_one(dev, hipcie->reset_gpio,
-				flag, "PCIe device power control");
-		if (ret) {
-			dev_err(dev, "unable to request gpio\n");
-			return ret;
-		}
+	hipcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(hipcie->reset_gpio);
+	if (ret) {
+		dev_err(dev, "unable to request reset gpio: %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiod_set_consumer_name(hipcie->reset_gpio,
+				      "PCIe device power control");
+	if (ret) {
+		dev_err(dev, "unable to set reset gpio name: %d\n", ret);
+		return ret;
 	}
 
 	hipcie->aux_clk = devm_clk_get(dev, "aux");
-- 
2.37.2.789.g6183377224-goog

