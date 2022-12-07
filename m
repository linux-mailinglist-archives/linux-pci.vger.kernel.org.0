Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57ED6462F4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Dec 2022 22:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLGVHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Dec 2022 16:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLGVHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Dec 2022 16:07:15 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA27716F5;
        Wed,  7 Dec 2022 13:07:15 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g1so10532640pfk.2;
        Wed, 07 Dec 2022 13:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V995C6MwqtUAmTG71E4cb1Pyxeu/S0wZo/QPEUz5JyI=;
        b=LpQoDdBWH7AjZeARZIav9Ud/rp1eZav/ptYhNkj5zUs0aFgG1QvN3QpxTsdlTLfxQR
         +U07pkjcNK24yiRBCGfqbHKVQqHgZ59x8Dukmo3jhYItpStJGQjJgkbeY9lg1t8S9HGH
         yGRbNfl//dN49Tx0QTg8BglhjxBCcorbXlOzpdqMB3sdPYF+NFd1pmGteUpI7OtIWlhA
         1+xvxpxN4T+QcploU54kSawaYMNk6EXzxqMI/1E/0ZhlMNFuVXM/C0Y1B1N5MMofO0dx
         4jd5ol7KDGkncltwAkp2x7T9KHW1CeEtawu+NB5s9UxB7+BX9lBuaYLLHsGYDBU6fMYI
         ckew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V995C6MwqtUAmTG71E4cb1Pyxeu/S0wZo/QPEUz5JyI=;
        b=2aLi7dWWnA9++GHcLTSzoTGnqQOXT/PzoOFK+Cyp4g/OkH+/iNfJNxPnwXz9uEZwNE
         GQJr5ufWMbpX4UbppzhQs6lTtCs15Qk/f+72WcH/lHCUgUVM8f9enmY9NOvTpURbsM+B
         vNsVJ+V9m2ZKKAAyHJssmrWTsmyG5pA+pVXH3YdzwLlFTw/18TOgqyDhWIckJAOBgfPc
         0OZC2lZumxBFENsgI3Tu2VKFS8tz2KDCBDqpEalEvbbk+TQiy0TkXdWYP4IT4ZKAcog7
         C0MztG8DzcqlP9wQFEN51Y86ixOQ7EDzVG7mVFkeE2dCnZftINZ/Sww99tQo8AvssiVM
         kBlw==
X-Gm-Message-State: ANoB5pkuNMkZ6qSKAw6N9Gk82fpCjkN2Vt7A7ZRTKrl17vODiUKMVbtE
        ywV8Ikls2DbbGdYWU8VrenE=
X-Google-Smtp-Source: AA0mqf4TRbwld+Rgp66Y4tIL68ENi6FOYJj8KLqyjxn7dTcjwWbWKSIY7F4QVxHmA4adoAqSlKP3pA==
X-Received: by 2002:a63:f5a:0:b0:470:18d4:f18d with SMTP id 26-20020a630f5a000000b0047018d4f18dmr66492091pgp.295.1670447234255;
        Wed, 07 Dec 2022 13:07:14 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:7a61:38c7:d37a:7f43])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00187197c499asm15102485pli.164.2022.12.07.13.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 13:07:13 -0800 (PST)
Date:   Wed, 7 Dec 2022 13:07:10 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: mvebu: switch to using gpiod API
Message-ID: <Y5EAft42YiT66mVj@google.com>
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

v3:
 - add #include <linux/irqchip/chained_irq.h> to avoid compile errors.
   This was previously included indirectly via linux/of_gpio.h ->
   linux/gpio/driver.h

v2:
 - free port->reset_name when reset GPIO is not found (Pali)
 - remove stray tab (Pali)

This is the last user of of_get_named_gpio_flags() in the "next" tree.

Thanks!

 drivers/pci/controller/pci-mvebu.c | 51 ++++++++++--------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 73db99035c2b..600964ba174c 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -11,15 +11,15 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/init.h>
 #include <linux/irqdomain.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/mbus.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 
@@ -1262,9 +1262,8 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
 	struct mvebu_pcie_port *port, struct device_node *child)
 {
 	struct device *dev = &pcie->pdev->dev;
-	enum of_gpio_flags flags;
 	u32 slot_power_limit;
-	int reset_gpio, ret;
+	int ret;
 	u32 num_lanes;
 
 	port->pcie = pcie;
@@ -1328,40 +1327,24 @@ static int mvebu_pcie_parse_port(struct mvebu_pcie *pcie,
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
2.39.0.rc0.267.gcb52ba06e7-goog


-- 
Dmitry
