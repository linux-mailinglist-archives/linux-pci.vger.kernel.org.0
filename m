Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3805ACAF0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiIEGcR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiIEGbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:52 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A5333351;
        Sun,  4 Sep 2022 23:31:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b196so7296244pga.7;
        Sun, 04 Sep 2022 23:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VWe/av2g9WxE2lj2h4x591V5ZwS8Z03/LcbryzxlkEA=;
        b=FPP2yq86L9skh15r7N1HDwfFXjfhwE04FqrGjpXWX3EoG+Hta/Nx22nPNJ/t8eL/IT
         995FRGeW2izU3ZnDl/g+qs7wv607HJhxhJLRKhjQySVeaGd/rcyGmQ5Dnqfcl11T18SW
         tf06zMMGUVVb++nYk6FQAZT51RRJv/TCyfcjagu1UIV6LyzKxdrLT9hwDVqC4uGAz5a0
         Be7w67SFlgs3U+MWq7aHprynEe0YTcQJZYCSCVTHuqqVBhC3GEdGsE0TTMUlhYcEurCk
         eJSLHJEc2TiP9THpBZ0gy6OAl61D32MouWj48AMltgxfb2ZvbZEmZcLtFm/YfFBmGpit
         62Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VWe/av2g9WxE2lj2h4x591V5ZwS8Z03/LcbryzxlkEA=;
        b=6Df7aSyM8QQcipYtJRQscdtKyoAjDGJp5apc10ZiWFI7Oj0Q56nw8mZdeTS5EdkTxy
         ErB/ljTSoVwuDOmQBo0pfbRmQaJFgIAgnowOw/b/0JV+DJVql5G5Az9/BmsZphkqq2VK
         8rYgHhQCC7TUi/8D+pYjvvdl3UWz9TCNTmf+bSZhwSsKAirJJvtnzKZ/DlbLS8AVofBc
         cCgB6sFjg7hmlG3NEwLe0Cggv+W7ZWyhD31l4BO2/RI7vzXiUUFyvuli0pctKlvnJYA5
         nj8rrANfIZFaOtvTm0CMy1WVSHgtcHLhbAg/182eEHvX4RZvkJg0YD6udd9Uw0ECNaRZ
         LppQ==
X-Gm-Message-State: ACgBeo2p8BrsKm2eQ6lNpoAfwI/fuFQ2OIihI4E912r/RB3+QrT3k+Ev
        r2+D9JfPv+M34/kgWT89IEI=
X-Google-Smtp-Source: AA6agR4W3IsValNDHTekJxMuYb/OG6bI5CbZaz1XpSVwcU2T/joFwOJw522EfWiYj1A+GUqUQaJ/Zw==
X-Received: by 2002:a65:588d:0:b0:42a:2778:164f with SMTP id d13-20020a65588d000000b0042a2778164fmr42341736pgu.616.1662359496367;
        Sun, 04 Sep 2022 23:31:36 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:35 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Airlie <airlied@linux.ie>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 11/11] gpiolib: of: remove [devm_]gpiod_get_from_of_node() APIs
Date:   Sun,  4 Sep 2022 23:31:03 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-11-b29adfb27a6c@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
References: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.10.0-dev-fc921
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

Now that everyone is using [devm_]fwnode_gpiod_get[_index]() APIs, we no
longer need to expose OF-specific [devm_]gpiod_get_from_of_node().

Note that we are keeping gpiod_get_from_of_node() but only as a private
to gpiolib function.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 16a696249229..fe9ce6b19f15 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -129,61 +129,6 @@ struct gpio_desc *__must_check devm_gpiod_get_index(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_gpiod_get_index);
 
-/**
- * devm_gpiod_get_from_of_node() - obtain a GPIO from an OF node
- * @dev:	device for lifecycle management
- * @node:	handle of the OF node
- * @propname:	name of the DT property representing the GPIO
- * @index:	index of the GPIO to obtain for the consumer
- * @dflags:	GPIO initialization flags
- * @label:	label to attach to the requested GPIO
- *
- * Returns:
- * On successful request the GPIO pin is configured in accordance with
- * provided @dflags.
- *
- * In case of error an ERR_PTR() is returned.
- */
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      const struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label)
-{
-	struct gpio_desc **dr;
-	struct gpio_desc *desc;
-
-	desc = gpiod_get_from_of_node(node, propname, index, dflags, label);
-	if (IS_ERR(desc))
-		return desc;
-
-	/*
-	 * For non-exclusive GPIO descriptors, check if this descriptor is
-	 * already under resource management by this device.
-	 */
-	if (dflags & GPIOD_FLAGS_BIT_NONEXCLUSIVE) {
-		struct devres *dres;
-
-		dres = devres_find(dev, devm_gpiod_release,
-				   devm_gpiod_match, &desc);
-		if (dres)
-			return desc;
-	}
-
-	dr = devres_alloc(devm_gpiod_release, sizeof(struct gpio_desc *),
-			  GFP_KERNEL);
-	if (!dr) {
-		gpiod_put(desc);
-		return ERR_PTR(-ENOMEM);
-	}
-
-	*dr = desc;
-	devres_add(dev, dr);
-
-	return desc;
-}
-EXPORT_SYMBOL_GPL(devm_gpiod_get_from_of_node);
-
 /**
  * devm_fwnode_gpiod_get_index - get a GPIO descriptor from a given node
  * @dev:	GPIO consumer
diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index a037b50bef33..b0e0723b12ab 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -365,7 +365,6 @@ struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
 
 	return desc;
 }
-EXPORT_SYMBOL_GPL(gpiod_get_from_of_node);
 
 /*
  * The SPI GPIO bindings happened before we managed to establish that GPIO
diff --git a/drivers/gpio/gpiolib-of.h b/drivers/gpio/gpiolib-of.h
index 8af2bc899aab..e0da568d6da3 100644
--- a/drivers/gpio/gpiolib-of.h
+++ b/drivers/gpio/gpiolib-of.h
@@ -3,6 +3,7 @@
 #ifndef GPIOLIB_OF_H
 #define GPIOLIB_OF_H
 
+struct device_node;
 struct gpio_chip;
 enum of_gpio_flags;
 
@@ -16,6 +17,10 @@ void of_gpiochip_remove(struct gpio_chip *gc);
 int of_gpio_get_count(struct device *dev, const char *con_id);
 bool of_gpio_need_valid_mask(const struct gpio_chip *gc);
 void of_gpio_dev_init(struct gpio_chip *gc, struct gpio_device *gdev);
+struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label);
 #else
 static inline struct gpio_desc *of_find_gpio(struct device *dev,
 					     const char *con_id,
@@ -38,6 +43,14 @@ static inline void of_gpio_dev_init(struct gpio_chip *gc,
 				    struct gpio_device *gdev)
 {
 }
+static inline
+struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
+					 const char *propname, int index,
+					 enum gpiod_flags dflags,
+					 const char *label)
+{
+	return ERR_PTR(-ENOSYS);
+}
 #endif /* CONFIG_OF_GPIO */
 
 extern struct notifier_block gpio_of_notifier;
diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index fe0f460d9a3b..37448ee17e81 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -615,54 +615,6 @@ struct gpio_desc *devm_fwnode_get_gpiod_from_child(struct device *dev,
 	return devm_fwnode_gpiod_get_index(dev, child, con_id, 0, flags, label);
 }
 
-#if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_OF_GPIO)
-struct device_node;
-
-struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label);
-
-#else  /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
-
-struct device_node;
-
-static inline
-struct gpio_desc *gpiod_get_from_of_node(const struct device_node *node,
-					 const char *propname, int index,
-					 enum gpiod_flags dflags,
-					 const char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-#endif /* CONFIG_GPIOLIB && CONFIG_OF_GPIO */
-
-#ifdef CONFIG_GPIOLIB
-struct device_node;
-
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      const struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label);
-
-#else  /* CONFIG_GPIOLIB */
-
-struct device_node;
-
-static inline
-struct gpio_desc *devm_gpiod_get_from_of_node(struct device *dev,
-					      const struct device_node *node,
-					      const char *propname, int index,
-					      enum gpiod_flags dflags,
-					      const char *label)
-{
-	return ERR_PTR(-ENOSYS);
-}
-
-#endif /* CONFIG_GPIOLIB */
-
 struct acpi_gpio_params {
 	unsigned int crs_entry_index;
 	unsigned int line_index;

-- 
b4 0.10.0-dev-fc921
