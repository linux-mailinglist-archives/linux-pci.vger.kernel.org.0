Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428A75ACAFA
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiIEGb0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236114AbiIEGbV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:21 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7C30F49;
        Sun,  4 Sep 2022 23:31:19 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s206so7309512pgs.3;
        Sun, 04 Sep 2022 23:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=nEbjUfr7fwqueSmjAsD0W8GSCJGEGPrp4ULUwjjyEJA=;
        b=BwhSxhJHuNZubY5udVF0benef1V78QThc+I+5pdGaAhS9f7czmXQ0+lX6fLemCXOdl
         3fHYh5mFxmh6vXpEgGgoJfSt54Hg8m+uS1Wxx8zGEMMd3IMEilC7XzLCelQyUpIGADDa
         eHrlp4RIUpSke6IDMjI2wRpqP3Xcu9nVikuwws6JGbz1bpaNy+xlA1aWhyGXSVM8Bgez
         rR7uraO+M+9xWjLBH/xW3NfDDpH5H4xC8AhL1rqmFoqQ1YQUTwU9vSojevfdF4bc76Qh
         TW0gqThzNTQaw7vPqkwkLSNXzYRvK/UJpAMinaSHE472WQuIkYWNlxKNX/l2rblcn6fr
         t2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nEbjUfr7fwqueSmjAsD0W8GSCJGEGPrp4ULUwjjyEJA=;
        b=yJSdm/l4GjWeG0vrBX0GybvU0acNKoaYp4dMUtfPhCG4pvzqjlRdTGjbx6JmFpw9mZ
         KvYyfTJauh9A26IzUOB541TePVsLkgSc3jeH37daQIPyQr7aeSt4hKRwWqQBPm4gu6JB
         +BTVYo+HIkbRsO+Um4vSPXmK4LKqEOm64aJi5qKPUpv3qPz9sdxmedSl3lUyNLVecxIv
         CGNCcGXt11FKmvRNZUhX438/c3RTisGymb39989yfEycKeXEA2hfi70ykD4tWOaNKKL2
         QJFA1qtYHbtFiZ1v4hE6ZbEYtOpqUmQLG4AXZoart1ZPr2AD8tC+MbLPtiiLwaO/tJ6r
         u95Q==
X-Gm-Message-State: ACgBeo1SRrdaupz2mg/6UePF0drna3xm7LoMsfCmhjUt2EuB6xyPGN8q
        wgt3+PD7jLHGVqEi7MXycmg=
X-Google-Smtp-Source: AA6agR7O3xsaJm3PXWVEz8pTAeV7SFmhqqPNXXBFz2iOIaqf7IbZO/oITkU5Ekfa+HSas+vh7tCo8A==
X-Received: by 2002:a05:6a00:2293:b0:53b:93ec:1dc1 with SMTP id f19-20020a056a00229300b0053b93ec1dc1mr8858576pfe.62.1662359479124;
        Sun, 04 Sep 2022 23:31:19 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:18 -0700 (PDT)
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
Subject: [PATCH v1 04/11] usb: phy: tegra: switch to using devm_gpiod_get()
Date:   Sun,  4 Sep 2022 23:30:56 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-4-b29adfb27a6c@gmail.com>
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
device property API.

I believe that the only reason the driver, instead of the standard
devm_gpiod_get(), used devm_gpiod_get_from_of_node() is because it
wanted to set up a pretty consumer name for the GPIO, and we now have
a special API for that.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 68cd4b68e3a2..f0240107edb1 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -1440,16 +1440,22 @@ static int tegra_usb_phy_probe(struct platform_device *pdev)
 			return err;
 		}
 
-		gpiod = devm_gpiod_get_from_of_node(&pdev->dev, np,
-						    "nvidia,phy-reset-gpio",
-						    0, GPIOD_OUT_HIGH,
-						    "ulpi_phy_reset_b");
+		gpiod = devm_gpiod_get(&pdev->dev, "nvidia,phy-reset",
+				       GPIOD_OUT_HIGH);
 		err = PTR_ERR_OR_ZERO(gpiod);
 		if (err) {
 			dev_err(&pdev->dev,
 				"Request failed for reset GPIO: %d\n", err);
 			return err;
 		}
+
+		err = gpiod_set_consumer_name(gpiod, "ulpi_phy_reset_b");
+		if (err) {
+			dev_err(&pdev->dev,
+				"Failed to set up reset GPIO name: %d\n", err);
+			return err;
+		}
+
 		tegra_phy->reset_gpio = gpiod;
 
 		phy = devm_otg_ulpi_create(&pdev->dev,

-- 
b4 0.10.0-dev-fc921
