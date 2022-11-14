Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89206289C4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 20:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbiKNTtR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 14:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbiKNTs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 14:48:56 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F8CF75;
        Mon, 14 Nov 2022 11:48:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g24so11055341plq.3;
        Mon, 14 Nov 2022 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vyb04QF6WOviRSsxNxXugj6HWLnfLaTGenocXZ3ssCY=;
        b=ce4IvakUyWb+mgcTgEpB1LG7v3+47YR4xPyNIg67avm23p/tG+pOT6HcQ0b+R4UfOu
         E7GmFhV2EYceMIWJOm1SQHI3FUqIY43CesIrEuOKy50ZQfBj1+7/iIoOof9SR27vmD68
         F+aTNa8KFAsgz3SjSjbFH9jVIeaX/mv0AK7aYyx4Hv4YOF7O/wfX5b/14Cu7xfnAio2G
         ZQ93yBe3nl19LcikDE3/fWRr3z3/tqFy8sApjhph8MMijGgoVJOYq1C0ynhVLE4VGZZz
         8e7i7pZWV8tF6aupvHRnd1a8PBmYPmZOXa3uM8q7R71HVbRgfuxdWqyr/p1yFkibMG3i
         iKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vyb04QF6WOviRSsxNxXugj6HWLnfLaTGenocXZ3ssCY=;
        b=NoIoA0TwZ7/wSrGHvLdtj9v9d/+XSvQRTJvAwd3TCOonrYgeKZWUSICOa50MK5zJQz
         5SMdPQx1ILTzDncX6/bARWqLCVcLfCCBMWnCxF3s70LA2AWVgbERMpOjkEnI161isu6l
         hLhdY8OJuvXYAjnlghgR87TG6MxfQyew2zucq46lcEMApjVXDXaxtbVpE7AOZuPzhWj2
         A3mAepOYhk8Ts4iWewM2ojcgpju5IyspmtsUdHjSfaElCNN9qzysxLX/eCxVrLODYccC
         4+pKFpm4vebdX+5ZpJLyt0VUpGH9/4PgVd53yECZnVDh7RA0hgBlRT+JudUuErEy4ddd
         uTyg==
X-Gm-Message-State: ANoB5pl/ObSbBa9vOWva5JTtl9VwrFK/3XXctu3/NsgcmLc/KBXV5Ekp
        eR9BPi8p0SO9MW8cS7GWSfg=
X-Google-Smtp-Source: AA0mqf4Dwe9kYtu+e65Y2upPLiiuDKKuoOdF2u5dTvJcqDJUmJA0jvMywXPWWNsQbZ4PdStAAwV8jQ==
X-Received: by 2002:a17:902:f353:b0:187:85d:2522 with SMTP id q19-20020a170902f35300b00187085d2522mr834521ple.17.1668455303761;
        Mon, 14 Nov 2022 11:48:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:718:95ee:2678:497])
        by smtp.gmail.com with ESMTPSA id h3-20020a056a00000300b0056c6c63fda6sm7121341pfk.3.2022.11.14.11.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 11:48:23 -0800 (PST)
Date:   Mon, 14 Nov 2022 11:48:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI: mvebu: switch to using gpiod API
Message-ID: <Y3KbhIi4ZsSO7+Cl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

v2:
 - free port->reset_name when reset GPIO is not found (Pali)
 - remove stray tab (Pali)

I know Pali mentioned that there are pending changes to pci-mvebu, but I
do not see any movement there, so I wonder if we could get this one
applied so we can continue cleaning up gpiolib code.

Thanks!

 drivers/pci/controller/pci-mvebu.c | 50 ++++++++++--------------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 73db99035c2b..b77a77615cc6 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -11,7 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
 #include <linux/mbus.h>
@@ -19,7 +19,6 @@
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 
@@ -1262,9 +1261,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	struct mvebu_pcie_port *port, struct device_node *child)
 {
 	struct device *dev = &pcie->pdev->dev;
-	enum of_gpio_flags flags;
 	u32 slot_power_limit;
-	int reset_gpio, ret;
+	int ret;
 	u32 num_lanes;
 
 	port->pcie = pcie;
@@ -1328,40 +1326,24 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
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
+		if (ret != -ENOENT)
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
+		devm_kfree(dev, port->reset_name);
+		port->reset_name = NULL;
 	}
 
 	slot_power_limit = of_pci_get_slot_power_limit(child,
-- 
2.38.1.431.g37b22c650d-goog


-- 
Dmitry
