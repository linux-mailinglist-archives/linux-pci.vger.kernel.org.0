Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88CB5ACAE8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235976AbiIEGbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiIEGbL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:11 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DED530F49;
        Sun,  4 Sep 2022 23:31:09 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q15so7716026pfn.11;
        Sun, 04 Sep 2022 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=s5BObB/DFF43Zpjz+AxwbAQA1wE3EC6yd1PYO1tpkJ0=;
        b=eLC8Rb8Jtj6ohqIsxli11sh5mg6/lRM2jJY189w3rlTxUvSnPyQEKwgiFzri16qznK
         8Q1UK6BI5arOWJOW0tj1AFole4eAGnwtpWLBlNUo5DLvXjDf2L6w22Ztu0jF9lQM7v6B
         Mgw/mw3etr4vw1HQQFCWIU3BlD77SGHudPuPuFK4F9ujodYtIFvp6WmYCo+o/G/rhDel
         cW0w+zf7/RP7Nz0D6/Vjgje6fNrs1I/PeMd47xU/8sAWlLKDTbXsIi2Op/DBjE+aLmmC
         MAF22o/KivEly0jsBjH1TXScPbJfn9X2BkKRRH0cKrk4wP42LwxdMHRse73eSv3HS6NH
         jCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=s5BObB/DFF43Zpjz+AxwbAQA1wE3EC6yd1PYO1tpkJ0=;
        b=N2QkY+tY6eptkUxqcAucCwO7ynp3ALkii5EUhNYgpjM9hldOPsnqTtFY7KKz2W4h/F
         t/S9PjC8t7LHeLGrmX++B2EYbeJ0oiWHNriq/3rfP8LuUIR8iciZkyKhAaeJEscGfddn
         V2zGulDSRuE1ck/WKpybciuojE/H5SNUKK0hTY/ZjdMcVqFvmPzGHbZ51EYOo9bnk6K+
         VygqL0jkD+ixWMzSEwSm/YdXQ/crpB/IoCj6JAmSkP25FAUvP5fPwWRMnnxlGczum3ks
         B7mfI96oOqivhIYNOe+nm76qFMxbYv76XaFQERz4nQXdPH4MRfnpMAH1CBDi7VGwLVVm
         moHw==
X-Gm-Message-State: ACgBeo0D7Uc+yhYUDHEULCrMhLDTfMVZ9ZCEJWAG4HcO5G5hMfJBJl/m
        5lzcT21czTpR4WnIA8rwlT4=
X-Google-Smtp-Source: AA6agR6MPvi6YNNmbiAwPTRGnWV1I0ziWOWrr545AIf0+R4zt3mu9zZID4cCyo19DCCSuxN6bYnKJg==
X-Received: by 2002:a63:4566:0:b0:41d:353:46b4 with SMTP id u38-20020a634566000000b0041d035346b4mr41713619pgk.316.1662359468624;
        Sun, 04 Sep 2022 23:31:08 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:07 -0700 (PDT)
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
Subject: [PATCH v1 00/11] Get rid of [devm_]gpiod_get_from_of_node() public APIs
Date:   Sun,  4 Sep 2022 23:30:52 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-0-b29adfb27a6c@gmail.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
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

I would like to stop exporting OF-specific [devm_]gpiod_get_from_of_node()
so that gpiolib can be cleaned a bit. We can do that by switching drivers
to use generic fwnode API ([devm_]fwnode_gpiod_get()). By doing so we open
the door to augmenting device tree and ACPI information through secondary
software properties (once we teach gpiolib how to handle those).

I hope that relevant maintainers will take patches through their trees and
then we could merge the last one some time after -rc1.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

---
Dmitry Torokhov (11):
      PCI: tegra: switch to using devm_fwnode_gpiod_get
      drm/tegra: switch to using devm_fwnode_gpiod_get
      mtd: rawnand: stm32_fmc2: switch to using devm_fwnode_gpiod_get()
      usb: phy: tegra: switch to using devm_gpiod_get()
      usb: gadget: udc: at91: switch to using fwnode_gpiod_get_index()
      PCI: aardvark: switch to using devm_gpiod_get_optional()
      PCI: apple: switch to using fwnode_gpiod_get_index()
      regulator: bd71815: switch to using devm_fwnode_gpiod_get()
      regulator: bd9576: switch to using devm_fwnode_gpiod_get()
      watchdog: bd9576_wdt: switch to using devm_fwnode_gpiod_get()
      gpiolib: of: remove [devm_]gpiod_get_from_of_node() APIs

 drivers/gpio/gpiolib-devres.c          | 55 ----------------------------------
 drivers/gpio/gpiolib-of.c              |  1 -
 drivers/gpio/gpiolib-of.h              | 13 ++++++++
 drivers/gpu/drm/tegra/output.c         | 10 +++----
 drivers/mtd/nand/raw/stm32_fmc2_nand.c |  5 ++--
 drivers/pci/controller/pci-aardvark.c  | 23 +++++++-------
 drivers/pci/controller/pci-tegra.c     |  9 +++---
 drivers/pci/controller/pcie-apple.c    |  4 +--
 drivers/regulator/bd71815-regulator.c  |  7 ++---
 drivers/regulator/bd9576-regulator.c   | 17 ++++++-----
 drivers/usb/gadget/udc/at91_udc.c      |  8 +++--
 drivers/usb/phy/phy-tegra-usb.c        | 14 ++++++---
 drivers/watchdog/bd9576_wdt.c          | 51 ++++++++++++++++++-------------
 include/linux/gpio/consumer.h          | 48 -----------------------------
 14 files changed, 96 insertions(+), 169 deletions(-)
---
base-commit: 7fd22855300e693668c3397771b3a2b3948f827a
change-id: 20220903-gpiod_get_from_of_node-remove-de3032fc01de

Best regards,
-- 
Dmitry

