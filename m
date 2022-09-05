Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0810D5ACADA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiIEGb5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbiIEGba (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:30 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE9E326E3;
        Sun,  4 Sep 2022 23:31:29 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t70so1478847pgc.5;
        Sun, 04 Sep 2022 23:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=G2Q8X3FWNy+Mum1KFhHHSQCIItKgzpZiSb8mAdu3vck=;
        b=FBPmWKbk3BWYF+J3K1WZ+Ol82sdIUCowS0WjoBoeLJwP+LR5gAz/hqHX1gjYAVa5om
         NIgH7Qk6N5rigD1eJP5EuzqqWeBUI8rxO6FNbumER8jIOtzxax/MwNFhpzGpMzlxKr9x
         KHJ7i9RRjxYVABvDu4w+I2WlJTjEqjc2B4kijfECmGBvAZhSZMXJefbYqeLIph3SF4qn
         3n1+0jSFCH68oN7ImYI32e/dUNgIUelohNCH+XyjOKvH1oHWOKxSKn7Uxut1MpeOF0oa
         OMMldcVIUk/MvfKw67fTrKU0zEyg6YlcDYcuroJpaBs56j1Djz+Q6Fl7tyyophfaU0TY
         Hgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=G2Q8X3FWNy+Mum1KFhHHSQCIItKgzpZiSb8mAdu3vck=;
        b=c2lRBaATcbKjjJm/bzzl9zyWe2XDe6LOWe0bKB13Wy65h5RLz4TT9DVcVGY7ZFy2h5
         qZnnzeMhFp15BmLQ4iI6FiFCGCrfh4aVSRHEpa6JG1bWTrtjvuZmdkIsBLQuyitqQIdT
         qqekh6phUmtRJRiGq93eEg9Pt4SwuBMecZ1+kiL8KEhuRa+KsxKSb23av9pyuT+jbc9e
         8qydHmtoJR/YBXpvDn6/gqmfi1k4CRF6FlaO8rckaR9ffcaDiLBKRpNteQ58wS6JUm1L
         xUIlnL/L1dHuLTsjYlGSi01OOBbcNIlpYFlbSEwNO6ttFMS0/yn2HydS/GSSTZd37+bK
         cv8w==
X-Gm-Message-State: ACgBeo1MPeFZ+70ld6je2dEYjupEGbr09HjpHWhCJcjdUplnPWDP2t3o
        bmct8jxeXTl3JcUXVfDDi7o=
X-Google-Smtp-Source: AA6agR5x3Cd2bUFdFVhQSgyMvYn8olPbDNMNhdGlpAAhOjZvTLjZqt1otHo2lVL9RBMjcQPiw4Cbsg==
X-Received: by 2002:a05:6a00:10c7:b0:53b:5eb3:4648 with SMTP id d7-20020a056a0010c700b0053b5eb34648mr13563922pfu.67.1662359488945;
        Sun, 04 Sep 2022 23:31:28 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:28 -0700 (PDT)
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
Subject: [PATCH v1 08/11] regulator: bd71815: switch to using devm_fwnode_gpiod_get()
Date:   Sun,  4 Sep 2022 23:31:00 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-8-b29adfb27a6c@gmail.com>
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

diff --git a/drivers/regulator/bd71815-regulator.c b/drivers/regulator/bd71815-regulator.c
index acaa6607898e..c2b8b8be7824 100644
--- a/drivers/regulator/bd71815-regulator.c
+++ b/drivers/regulator/bd71815-regulator.c
@@ -571,11 +571,10 @@ static int bd7181x_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "No parent regmap\n");
 		return -ENODEV;
 	}
-	ldo4_en = devm_gpiod_get_from_of_node(&pdev->dev,
-					      pdev->dev.parent->of_node,
-						 "rohm,vsel-gpios", 0,
-						 GPIOD_ASIS, "ldo4-en");
 
+	ldo4_en = devm_fwnode_gpiod_get(&pdev->dev,
+					dev_fwnode(pdev->dev.parent),
+					"rohm,vsel", GPIOD_ASIS, "ldo4-en");
 	if (IS_ERR(ldo4_en)) {
 		ret = PTR_ERR(ldo4_en);
 		if (ret != -ENOENT)

-- 
b4 0.10.0-dev-fc921
