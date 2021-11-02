Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB574424F9
	for <lists+linux-pci@lfdr.de>; Tue,  2 Nov 2021 02:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhKBBFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 21:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbhKBBFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 21:05:53 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C6CC061714
        for <linux-pci@vger.kernel.org>; Mon,  1 Nov 2021 18:03:17 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id br39so5111410qkb.8
        for <linux-pci@vger.kernel.org>; Mon, 01 Nov 2021 18:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=TGCcvZeZM6ScS8ns8C85ZEr+fwzxhkjRxhi7dzfBgNI=;
        b=DUEgIAioC6rdnfITi3YqrGdRixhkLtVH/opP9meQh/HhvUcr5e/czGWPXgXPT/al+t
         cQsfUiE1JmgB98HT7yDx9t7sXm4iXrnLYRCtVoVJtmnEvpQmFl3P9yYBTuEvXL2cLHHE
         XrGQ4rqN3fdrBJvQwt93OM6YJLqxN6EOUOWH5jJDeQyLg2Czc4y+CCXjoaHLTRGcvkgE
         GeSTl78AvyiMl5faZn6G+wL2LLATPF5zqfXDsVRhd+DE4gZCXCbDdoY5yJRgLyp66UMh
         f/qBUB6gkohISL/ycWZmr1KPGdW9JJC5qSgJi7IcCqdcjwr7HWTyVx3tgTX6WsYnwqIL
         /ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=TGCcvZeZM6ScS8ns8C85ZEr+fwzxhkjRxhi7dzfBgNI=;
        b=uh35bOdiW4FaMpIoE6ono9XImvPNHY7FXNn6os2/rSYbHDUq98qUScuqBG5zBq1liy
         iOXrhhkajg3xux6Rg+ADXP3EqCmy4ER/8Ds9nZ5fHDnQD0HAy7v86BO+zk/y/RCeA96d
         oMnYH9KRFcQjOtCBwWVtg43HpL2zd9pRVhrOghq/ycYWDyTXx5V+DZKqVRm2Jf6UnQnE
         e/1cf0BZ74hTtyzgtHLKLv/J0jWY8O8dfU0/8bVFbZv2GF6u7wJFGTjAB5jbStfUJIpv
         5stbxhaNPK6OQ4yowWoTLEouzBZmnjwPgM86UG9ehvTO7cA0mEBCfd5pGJiAxeBrlw1k
         g9tg==
X-Gm-Message-State: AOAM533iim361rnonK+tz6h7LkSjGiD+vwAbjJdoWeJuVd3nrAdfQljq
        jhcyHpy0E/6dOiDmOjBUoT7v+g==
X-Google-Smtp-Source: ABdhPJyBWeb4i1602rivILHKkuCx1txr9ds80E6KKnxWtLgok2J3iYCE8XXBj4AsgX0jYlXreReCJQ==
X-Received: by 2002:a05:620a:2950:: with SMTP id n16mr13331281qkp.405.1635814997042;
        Mon, 01 Nov 2021 18:03:17 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id m19sm6043282qkn.51.2021.11.01.18.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 18:03:16 -0700 (PDT)
Date:   Mon, 1 Nov 2021 22:03:11 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        helgaas@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YYCOTx68LXu1Tn1i@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Considering the current transition of the GPIO subsystem, remove all
dependencies of the legacy GPIO interface (linux/gpio.h and linux
/of_gpio.h) and replace it with the descriptor-based GPIO approach.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
V1 -> V2: Rewrite commit log and subject line to match PCI subsystem standard
V2 -> v3: Change gpiod_set_value_cansleep for gpiod_set_raw_value_cansleep
---
 drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..f08865ac0b40 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -11,13 +11,12 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
 #include <linux/mfd/syscon/imx7-iomuxc-gpr.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
 #include <linux/of_device.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
@@ -63,7 +62,7 @@ struct imx6_pcie_drvdata {
 
 struct imx6_pcie {
 	struct dw_pcie		*pci;
-	int			reset_gpio;
+	struct gpio_desc	*reset_gpio;
 	bool			gpio_active_high;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
@@ -526,11 +525,11 @@ static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	usleep_range(200, 500);
 
 	/* Some boards don't have PCIe reset GPIO. */
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+	if (imx6_pcie->reset_gpio) {
+		gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
 					imx6_pcie->gpio_active_high);
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+		gpiod_set_raw_value_cansleep(imx6_pcie->reset_gpio,
 					!imx6_pcie->gpio_active_high);
 	}
 
@@ -1025,22 +1024,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(pci->dbi_base);
 
 	/* Fetch GPIOs */
-	imx6_pcie->reset_gpio = of_get_named_gpio(node, "reset-gpio", 0);
 	imx6_pcie->gpio_active_high = of_property_read_bool(node,
 						"reset-gpio-active-high");
-	if (gpio_is_valid(imx6_pcie->reset_gpio)) {
-		ret = devm_gpio_request_one(dev, imx6_pcie->reset_gpio,
-				imx6_pcie->gpio_active_high ?
-					GPIOF_OUT_INIT_HIGH :
-					GPIOF_OUT_INIT_LOW,
-				"PCIe reset");
-		if (ret) {
-			dev_err(dev, "unable to get reset gpio\n");
-			return ret;
-		}
-	} else if (imx6_pcie->reset_gpio == -EPROBE_DEFER) {
-		return imx6_pcie->reset_gpio;
-	}
+	imx6_pcie->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+			imx6_pcie->gpio_active_high ?  GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
+	if (IS_ERR(imx6_pcie->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(imx6_pcie->reset_gpio),
+				"unable to get reset gpio\n");
 
 	/* Fetch clocks */
 	imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
-- 
2.31.1

