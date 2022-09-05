Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD685ACAF7
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236913AbiIEGcJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiIEGbj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:39 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7932B92;
        Sun,  4 Sep 2022 23:31:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso2796362pjd.4;
        Sun, 04 Sep 2022 23:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zVe7w76eC6bgTDoVT05JO9xbEs/H8FGbqX7haQWgZL4=;
        b=kACI45UuEBwpfjjyassFNG0U98Hr0eJu20A/vSxogzN+vfXjugJ8KzkYn5wwKX5gbB
         uJeLI0QAz/+xelvX3OGbdcJTSgu2dNpdrSGSQg4famb7eeB/AbL7WHoZEDiXHjg2hnUR
         4PSFIifn7lLM+A5nAaRKBTzgdAw7qg0BfzTpJ86cTaNvjX02vYPt0RebiXWe/iwHmm8q
         zGwFv8Qb/Nc0B3WMsCOQ/E4dqsgR2yN3yxu1FOcDO2Kb6oKm+SyvVHxf73Na21XGjNsa
         qHG58A2uebJOTkVIVHXCa9lAAMCpYNCKRv84xKCdiCS3bEdL5OBKRFVk2atPS95mlJqb
         +oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zVe7w76eC6bgTDoVT05JO9xbEs/H8FGbqX7haQWgZL4=;
        b=JODw5gaEMrBFTuNbAR0TtONbKrOsvPU0BrD2Xb1G6XvrWJLwvKc+erj48QP7IDstkY
         CXr8qY2LXeOLy5J4rEcMCTPCjsdur7tvN3hJJJIV0AdK6kO8lxHXG7GnoT82I3I9WKbX
         yY3gAbfMM0CL2dZXpzZ+BgZH2vs8zCrPNjjjKo5wOzm0n76hgRnb0RpbIF/UyH/lYoYB
         qYvlt/JV86ANtH8vyLMCOfzbqofOiUAl+BcqM/0PWk44zx5H0RRhWHk4MHfdIx+Uuh+Y
         BOcXAIfTW3fla1DwBEStEmjN2Zd3xR/n2g6L45adHa7Iy79DK/xeT7KaAeH1eZEnYVVW
         mOsA==
X-Gm-Message-State: ACgBeo3pDF36Hphw37XUXyGcAv24LDUyyvZUCVAR7CTYFuQh8NHSW9l/
        7LqgTjg2+enJBwZB9hLIEE0=
X-Google-Smtp-Source: AA6agR41wNIiOLemySzBG0aXdzuGwcXJzGb1vIFW9PWKwOZh9QVyUeHaIw4+NjnqDzJgWjv579LMTw==
X-Received: by 2002:a17:902:b581:b0:172:a34e:18fd with SMTP id a1-20020a170902b58100b00172a34e18fdmr46918225pls.163.1662359491466;
        Sun, 04 Sep 2022 23:31:31 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:31 -0700 (PDT)
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
Subject: [PATCH v1 09/11] regulator: bd9576: switch to using devm_fwnode_gpiod_get()
Date:   Sun,  4 Sep 2022 23:31:01 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-9-b29adfb27a6c@gmail.com>
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

I would like to stop exporting OF-specific devm_gpiod_get_from_of_node()
so that gpiolib can be cleaned a bit, so let's switch to the generic
fwnode property API.

While at it switch the rest of the calls to read properties in
bd957x_probe() to the generic device property API as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/regulator/bd9576-regulator.c b/drivers/regulator/bd9576-regulator.c
index aa42da4d141e..393c8693b327 100644
--- a/drivers/regulator/bd9576-regulator.c
+++ b/drivers/regulator/bd9576-regulator.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
@@ -939,8 +940,8 @@ static int bd957x_probe(struct platform_device *pdev)
 	}
 
 	ic_data->regmap = regmap;
-	vout_mode = of_property_read_bool(pdev->dev.parent->of_node,
-					 "rohm,vout1-en-low");
+	vout_mode = device_property_read_bool(pdev->dev.parent,
+					      "rohm,vout1-en-low");
 	if (vout_mode) {
 		struct gpio_desc *en;
 
@@ -948,10 +949,10 @@ static int bd957x_probe(struct platform_device *pdev)
 
 		/* VOUT1 enable state judged by VOUT1_EN pin */
 		/* See if we have GPIO defined */
-		en = devm_gpiod_get_from_of_node(&pdev->dev,
-						 pdev->dev.parent->of_node,
-						 "rohm,vout1-en-gpios", 0,
-						 GPIOD_OUT_LOW, "vout1-en");
+		en = devm_fwnode_gpiod_get(&pdev->dev,
+					   dev_fwnode(pdev->dev.parent),
+					   "rohm,vout1-en", GPIOD_OUT_LOW,
+					   "vout1-en");
 		if (!IS_ERR(en)) {
 			/* VOUT1_OPS gpio ctrl */
 			/*
@@ -986,8 +987,8 @@ static int bd957x_probe(struct platform_device *pdev)
 	 * like DDR voltage selection.
 	 */
 	platform_set_drvdata(pdev, ic_data);
-	ddr_sel =  of_property_read_bool(pdev->dev.parent->of_node,
-					 "rohm,ddr-sel-low");
+	ddr_sel = device_property_read_bool(pdev->dev.parent,
+					    "rohm,ddr-sel-low");
 	if (ddr_sel)
 		ic_data->regulator_data[2].desc.fixed_uV = 1350000;
 	else

-- 
b4 0.10.0-dev-fc921
