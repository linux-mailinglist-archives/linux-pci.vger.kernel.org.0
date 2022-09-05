Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D75ACAF4
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiIEGbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbiIEGbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48390326C7;
        Sun,  4 Sep 2022 23:31:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id y29so7787796pfq.0;
        Sun, 04 Sep 2022 23:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=f1PZzsaMnOlN09CVwbSU1GebwD1POC8hMtOU/HbCocM=;
        b=pdli+4eCvdWbxLZpx0O/e5Ud3wuQ5WWZPs7wxvLZ8aWyeshw5o3oRO/WG8ev2Aaq1m
         BX/Fr0/H0104qGs68GxhCwuFDG+PdZ2DrBRO+OPQVwRTpp7rdrBwbaXxSj0nC7vBM+b5
         GXjvKR+R9YSnP5K560kQKQaswuG1HWEF9p6rBSHyfMHnnKCObj/NMkW/0nwlLU7coaJN
         lMlGTVarp6ddLZqLDpTSWdUVPPyTlQJyHZXKdGvmnZujDf4OJXr1QpZ4olhMYA2SJhx8
         m53y0aRnHgIB7peKEuEd6JQIyv+D3WxGZ668VhcUTC58GT5LurfYxI/+Of47FfV3GuNG
         TzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=f1PZzsaMnOlN09CVwbSU1GebwD1POC8hMtOU/HbCocM=;
        b=XnsaJkNm0Luife6pDSeeE6Cb5qfp5+5gsLEPjA/1N0/LbPCflKz8WWvguE/x3NyShJ
         jj9+63B3sUUgAh4PTn+z0MKs5j4P1X0Te3+rXwVNRMsBlymK5svglI4gw29w6UpdDvMx
         rBCvK1bIgnWVFmKmPJykdk6ru86DmYrgbQWFvu2a4r0GY6Fro3ZLPorZhrWEc/qLYRO0
         cYTpDTbkUvy65EdMSrb1seIIwWcCnzLy7Bd+i7aeUOhm8L3IXMazWDfrP+p2w1kZm+s3
         Buh0nWGTzDFyeeF63IaMnGeSeYFRSwnr2vqe+MZEffuJCxfmvgm5Mu4ZBFCpfeezOkZo
         QuwA==
X-Gm-Message-State: ACgBeo379u/1EFaMUi7ahc2itN3FSYVS+CpgwFugZpBZpSE1q3y9XoaO
        m0CiCVuAt/5cblY/P+rl18U=
X-Google-Smtp-Source: AA6agR5cvvg/UZg1XV6YqtMeu4gBydqn31I2YyYPcH2GdlFOcXWs2FB6+oFFKzKdNcI+NqL1V/14Sg==
X-Received: by 2002:aa7:978c:0:b0:537:d68e:3a27 with SMTP id o12-20020aa7978c000000b00537d68e3a27mr28251047pfp.71.1662359481595;
        Sun, 04 Sep 2022 23:31:21 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:21 -0700 (PDT)
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
Subject: [PATCH v1 05/11] usb: gadget: udc: at91: switch to using fwnode_gpiod_get_index()
Date:   Sun,  4 Sep 2022 23:30:57 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-5-b29adfb27a6c@gmail.com>
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

I would like to stop exporting OF-specific gpiod_get_from_of_node()
so that gpiolib can be cleaned a bit, so let's switch to the generic
fwnode property API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index 728987280373..1db1dbbab79a 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1779,12 +1779,14 @@ static void at91udc_of_init(struct at91_udc *udc, struct device_node *np)
 	if (of_property_read_u32(np, "atmel,vbus-polled", &val) == 0)
 		board->vbus_polled = 1;
 
-	board->vbus_pin = gpiod_get_from_of_node(np, "atmel,vbus-gpio", 0,
-						 GPIOD_IN, "udc_vbus");
+	board->vbus_pin = fwnode_gpiod_get_index(of_fwnode_handle(np),
+						 "atmel,vbus", 0, GPIOD_IN,
+						 "udc_vbus");
 	if (IS_ERR(board->vbus_pin))
 		board->vbus_pin = NULL;
 
-	board->pullup_pin = gpiod_get_from_of_node(np, "atmel,pullup-gpio", 0,
+	board->pullup_pin = fwnode_gpiod_get_index(of_fwnode_handle(np),
+						   "atmel,pullup", 0,
 						   GPIOD_ASIS, "udc_pullup");
 	if (IS_ERR(board->pullup_pin))
 		board->pullup_pin = NULL;

-- 
b4 0.10.0-dev-fc921
