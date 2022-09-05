Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6645ACAC9
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbiIEGbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236651AbiIEGbS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:18 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F318B36;
        Sun,  4 Sep 2022 23:31:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x19so7758650pfr.1;
        Sun, 04 Sep 2022 23:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JcNarHX5vDGjVT4u3bJlQD1+cgrqWKhTPjcJ8WgPV+Y=;
        b=DxvplDrIsh+KijXXFdPyzxvt874fwO8Mrl8/8AeOKCJE+XbHxvUZFRKCE2GWxXKh/D
         umFYRihOe+jne0ztML2y6mc0jbRPpGBhC1g0NvUfpp6EeLk7jk01cUaRoaJOQGKx5afd
         lMrQqjCzBLO0lmmWRuQTMiLdS80KFr2EMlRBbDQ43Cvwei0LgWRjAJ8gs1Hh7H+I8nL+
         T7StbBazi7jgrWFhxeXo3Gac0AKQAJdX41kNsF1jErc6zj3GvAoSXS8rPqIvQoiy9CfD
         STWwhnuDN61n/ngUeJ4+XMum2eLhXHNuROQUxZWikj/bqGNqJIg0uK7dakXt3T7vhKRj
         +Zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JcNarHX5vDGjVT4u3bJlQD1+cgrqWKhTPjcJ8WgPV+Y=;
        b=pu2clfpNGZ9WCKsJshAhVnGjCJzT2QAL9lV2z7KJfmmDIvwICbCk/+Ftzhs+pLBzD5
         odPT9jJEPNBQX7A4a8CB83bdJzOjY02OPSUOWJCCQBkhpVOfHkEpnod9k57whjoYaz4J
         f27SD0nF0wKPHCUX7ySRociAs9bxSYefEACccXO1G+jP2M/p1OtQJ6phHSrzpygO2fDA
         q5RxIPe5HE2Z07gC+cx9yCSfPiMZb8VEKu0mSTqKLQHbi28y4nSdSPU+oannmwApCfzr
         MVC0+RGpceR7PRxIak8OaYf9NsYsToES6w7erbQl3lsambqFjJvl+kv7kcGQul/+fVmf
         JHiw==
X-Gm-Message-State: ACgBeo1s5/SwNvKxnBsII7vJMaj2+X0V5VYTwmzv7xVFPI4ZGaC5cGaT
        6BT3m9FhnfUrA1TWoZrI8Mw=
X-Google-Smtp-Source: AA6agR7ElJwXFJbXTWS13gywL0+xg7ynmUWpG94uiTchE1mDeAqtJvkeWg4KKm6lqy6WE6s/yuBdHA==
X-Received: by 2002:a63:fc11:0:b0:430:41b4:acf5 with SMTP id j17-20020a63fc11000000b0043041b4acf5mr19872386pgi.408.1662359476546;
        Sun, 04 Sep 2022 23:31:16 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:16 -0700 (PDT)
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
Subject: [PATCH v1 03/11] mtd: rawnand: stm32_fmc2: switch to using devm_fwnode_gpiod_get()
Date:   Sun,  4 Sep 2022 23:30:55 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-3-b29adfb27a6c@gmail.com>
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

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 87c1c7dd97eb..7e466b840368 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -1799,9 +1799,8 @@ static int stm32_fmc2_nfc_parse_child(struct stm32_fmc2_nfc *nfc,
 		nand->cs_used[i] = cs;
 	}
 
-	nand->wp_gpio = devm_gpiod_get_from_of_node(nfc->dev, dn,
-						    "wp-gpios", 0,
-						    GPIOD_OUT_HIGH, "wp");
+	nand->wp_gpio = devm_fwnode_gpiod_get(nfc->dev, of_fwnode_handle(dn),
+					      "wp", GPIOD_OUT_HIGH, "wp");
 	if (IS_ERR(nand->wp_gpio)) {
 		ret = PTR_ERR(nand->wp_gpio);
 		if (ret != -ENOENT)

-- 
b4 0.10.0-dev-fc921
