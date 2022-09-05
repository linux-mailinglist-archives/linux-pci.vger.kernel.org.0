Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4C5ACAD2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Sep 2022 08:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiIEGbv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Sep 2022 02:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236726AbiIEGb2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Sep 2022 02:31:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 470D82DA9F;
        Sun,  4 Sep 2022 23:31:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q63so7285577pga.9;
        Sun, 04 Sep 2022 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=ynLt5at1fPNx8OKjwAxE9TZqe0qSgR0LfMKd2/ukQyE=;
        b=o0c6aYKNJPicMxZzE1PkKtIkQSLJsOwJFh3bcl+LYHEmHr5TaY61x79o0SD+ivoxZk
         DPf8vEmv/G+sAfYEywkQmzYS8TqIgrCK6wSXSLFwKEAK7Cbw08AkpqBT96rMRzPEVa0T
         aMMtmW+0f9glO6/cQ8keV15iEPs13h8fVonila+4g/ocL46xIqfFx7rDdBBE/MrAjqtO
         5sl8bIgqi3+F/6v0vHcDrNJ1k/oQaqO7VkvMD/DoMztr6Me8/am6pi66ZHOCMZneRwid
         Zb3n7NhsZprL3d7KX03DatOFU7DvGf4H7pflgVDpxL0aWedJ+FcdT7hgq54vmCH9Sgv5
         7z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ynLt5at1fPNx8OKjwAxE9TZqe0qSgR0LfMKd2/ukQyE=;
        b=P7waYVewIyop/JqOVDLJkNHGBoIaiNzfAnCEMVgldNM4L8z+7WE5eQL4QSNXYAT7cA
         +z49eKo++0qBkhTn4uC9YL7oQaTWpwDz3fKrxB25ycS6wroOm5ROKYXUbvE37HdJiiwI
         gg7k0DWPKrJ6bJBPVDDMTfbfTC0Inhoukt2sMAIVdQaevqWCxv1VnjHs27bSWZ9POkAu
         LNMksSx6mpZRcD4o5VvjIWw4xHtzN8KA+7i0Ii4g+aml1wX69ItHftaHzdtKFk5lSYgT
         4gcRGtBYFjVOgf+E9uN7y5ZAdpBin3G9QCe1W0WbMF7rJAuGS5XeL5wQ53n0Rnw1qja1
         nrtA==
X-Gm-Message-State: ACgBeo3JpXTV7CY5kAdpJgokPJkCl6TOQ9bPZg4C6frsIH7Mrqh/xTA+
        gVERTlUIr8plWquHjFSyLDk=
X-Google-Smtp-Source: AA6agR6nqqurcOlRTW5MwumdR49aUTj5edmtMHpG5pntto/Ic3d6LDisTkJ/i3KAH13zMjWGur9aVA==
X-Received: by 2002:a63:62c3:0:b0:434:2b09:6f62 with SMTP id w186-20020a6362c3000000b004342b096f62mr6851828pgb.374.1662359486505;
        Sun, 04 Sep 2022 23:31:26 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:7332:f188:2984:5930])
        by smtp.gmail.com with ESMTPSA id d197-20020a6336ce000000b0042254fce5e7sm5710653pga.50.2022.09.04.23.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 23:31:26 -0700 (PDT)
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
Subject: [PATCH v1 07/11] PCI: apple: switch to using fwnode_gpiod_get_index()
Date:   Sun,  4 Sep 2022 23:30:59 -0700
Message-Id: <20220903-gpiod_get_from_of_node-remove-v1-7-b29adfb27a6c@gmail.com>
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

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index a2c3c207a04b..d83817d3ff86 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -516,8 +516,8 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	u32 stat, idx;
 	int ret, i;
 
-	reset = gpiod_get_from_of_node(np, "reset-gpios", 0,
-				       GPIOD_OUT_LOW, "PERST#");
+	reset = fwnode_gpiod_get_index(of_fwnode_handle(np),
+				       "reset", 0, GPIOD_OUT_LOW, "PERST#");
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 

-- 
b4 0.10.0-dev-fc921
