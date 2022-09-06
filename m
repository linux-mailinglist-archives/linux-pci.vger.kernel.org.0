Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BEC5AF645
	for <lists+linux-pci@lfdr.de>; Tue,  6 Sep 2022 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiIFUnK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Sep 2022 16:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiIFUnI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Sep 2022 16:43:08 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566A08B9AF;
        Tue,  6 Sep 2022 13:43:07 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso2990940pjq.1;
        Tue, 06 Sep 2022 13:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LGZJeMOU/kTBjQcVTon7M5VthpZd4oM1G5QflDMIOBQ=;
        b=fD3UBHqC6pgBLZfaZsrdOXw+33kE9SoUOutYUEl6EUeEKwU8uoJvvGbhLsC9ZC4e4u
         0Y72dgEnu4HpKjNzFM3O8kGnGm+WN6QCCToLiWPk6uM6URU2PYDWIhrMfn1YVfJ6S8MY
         KyMKtm8ZoaX5Ss1aEdckR1fIF2r+LrAguDdfUh9wT/SIlNsHlMwGGJHuipHHotRSZUkb
         klDE+f/hG9BmSqiEUtONiiTU3lRxr8DIpKq2kvRSsU1eTW/A5BgnGjAt0u28k7Uwsw7w
         jd8zM0pjCBJoTCsTNl76FjtCoIYFSvNcnbJzH3VfECWqijdDFkTM1Eihyi3AHBbe+UFO
         4weA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LGZJeMOU/kTBjQcVTon7M5VthpZd4oM1G5QflDMIOBQ=;
        b=Etc1bI9PYnf2CRJrTiwlFXNGck1RF4XaGjxLBppftpkQPVELnW5Iu+bjOOB+VWFGry
         big+A/AL+1bmGbUOYOKCSG7eXiVUQvbBYMfycRym28lUv4qWq7VOfmgQT2DnapfhZyZK
         71gRpgCLY7EgzVfKfhPi8duEZzEgC/sZhgVbLYaH1B00PRBDwki4/XcigmmQ/9Zw1iW7
         oICfqJ3hazTfAwfxZsykqTTzr/k8oGRdnpoU/YC4s/5LIKVXDyMLa7SrxBhbexcHuLxL
         RPM8nPtGc7rzdWOpW7XNT56v8EcaZH8p+IB9VnzS0qBRx/w8wJoOZ5UU2ykVXcmKJoUd
         vksQ==
X-Gm-Message-State: ACgBeo1mG96d4IhcYFCQ1sBn8bNrTYY3bot4spZs6hlY2Fabh3S6a5Q9
        dpSc116k0b+LbPKIAJbkDCs=
X-Google-Smtp-Source: AA6agR4W+ESDz7rOE+2SCpKsgNzs+jF9w7UKtzuT+jaPk9C2uuxmgps98PDHB3sT8kR+kQkn0cKNLw==
X-Received: by 2002:a17:90b:254b:b0:200:a860:5bf9 with SMTP id nw11-20020a17090b254b00b00200a8605bf9mr3695228pjb.176.1662496986681;
        Tue, 06 Sep 2022 13:43:06 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:abc4:5d24:5a73:a96b])
        by smtp.gmail.com with ESMTPSA id u3-20020a170902e80300b0016c57657977sm10359961plg.41.2022.09.06.13.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 13:43:06 -0700 (PDT)
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
Subject: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Date:   Tue,  6 Sep 2022 13:43:01 -0700
Message-Id: <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
References: <20220906204301.3736813-1-dmitry.torokhov@gmail.com>
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
 drivers/pci/controller/pci-mvebu.c | 48 +++++++++---------------------
 1 file changed, 14 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 1ced73726a26..a54beb8f611c 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -11,14 +11,13 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/mbus.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 
@@ -1261,9 +1260,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	struct mvebu_pcie_port *port, struct device_node *child)
 {
 	struct device *dev = &pcie->pdev->dev;
-	enum of_gpio_flags flags;
 	u32 slot_power_limit;
-	int reset_gpio, ret;
+	int ret;
 	u32 num_lanes;
 
 	port->pcie = pcie;
@@ -1327,40 +1325,22 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 			 port->name, child);
 	}
 
-	reset_gpio = of_get_named_gpio_flags(child, "reset-gpios", 0, &flags);
-	if (reset_gpio == -EPROBE_DEFER) {
-		ret = reset_gpio;
+	port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
+					  port->name);
+	if (!port->reset_name) {
+		ret = -ENOMEM;
 		goto err;
 	}
 
-	if (gpio_is_valid(reset_gpio)) {
-		unsigned long gpio_flags;
-
-		port->reset_name = devm_kasprintf(dev, GFP_KERNEL, "%s-reset",
-						  port->name);
-		if (!port->reset_name) {
-			ret = -ENOMEM;
+	port->reset_gpio = devm_fwnode_gpiod_get(dev, of_fwnode_handle(child),
+						 "reset", GPIOD_OUT_HIGH,
+						 port->name);
+	ret = PTR_ERR_OR_ZERO(port->reset_gpio);
+	if (ret) {
+		if (ret	!= -ENOENT)
 			goto err;
-		}
-
-		if (flags & OF_GPIO_ACTIVE_LOW) {
-			dev_info(dev, "%pOF: reset gpio is active low\n",
-				 child);
-			gpio_flags = GPIOF_ACTIVE_LOW |
-				     GPIOF_OUT_INIT_LOW;
-		} else {
-			gpio_flags = GPIOF_OUT_INIT_HIGH;
-		}
-
-		ret = devm_gpio_request_one(dev, reset_gpio, gpio_flags,
-					    port->reset_name);
-		if (ret) {
-			if (ret == -EPROBE_DEFER)
-				goto err;
-			goto skip;
-		}
-
-		port->reset_gpio = gpio_to_desc(reset_gpio);
+		/* reset gpio is optional */
+		port->reset_gpio = NULL;
 	}
 
 	slot_power_limit = of_pci_get_slot_power_limit(child,
-- 
2.37.2.789.g6183377224-goog

