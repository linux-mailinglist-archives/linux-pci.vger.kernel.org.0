Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6F441C19
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 15:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhKAOFm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 10:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAOFm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Nov 2021 10:05:42 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB652C061714
        for <linux-pci@vger.kernel.org>; Mon,  1 Nov 2021 07:03:08 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id bp7so11329302qkb.10
        for <linux-pci@vger.kernel.org>; Mon, 01 Nov 2021 07:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=vAqbtjNRsMv6GLJP4TOcGidnTwH9qfmL1MAA54bPcrQ=;
        b=GNaBm93A51Bbuq8faqsXLGwvbBXFu60JtlT6b5OO00TmxnCP0o4983K3WdJVDo5ZEG
         QyEmMiedpoBE5li2sgkGAMFos4f9MfsFtwbezAI+ek5YUxYm0kqzV5Yl1OjyY+kUK5zP
         fqVfN+/efouhK2j4kIgN8GhLRmpmSffR7uxZ39kAEpnTP1zGQH9nNZ0g4tC8oDW29ZB8
         QjI3H0ZwZmFDqiUdvCi8orv+0s742MpDaT5X9j2EkDZ5tdOwlpQHrLQSKgd3R7ej3eKd
         R+0UHRy7PX05TjgUdMiOnE0gYjlQSW4K/Zj9Nya9t9S6nEfYJJuf5NEeIpP841bove+D
         P0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=vAqbtjNRsMv6GLJP4TOcGidnTwH9qfmL1MAA54bPcrQ=;
        b=U6NSyoCZTLe7S9UyPxmuKaosc3kF68WqRNHCYuoRrJdPIPsuF3KoaSnCQnNOCLGGHV
         jIS0EZsy3ThJBpZxNI2lk3fSMQt8gUOr+yaFoX5XdSkYb7JbEdLh7wPnp0R31jU0MKbc
         jFRIEk8gJZGT3NmWJkUgzZUyINBj7Uvo7IFiWSR5IjuIcnGa9a1obMRySN18YDBnRA7X
         FwHdj57VDAVIo8QHXcYLUiyw/gT/gWctb3gsaI4gsBtB9nVDXYPQTd0TF+++6F0912dJ
         KEhtArVIKhFoiX1pMsMvBX0JUlN06sRfhydRJfIBjJSBoytg7TUDIeuCtWAQPO3QV33i
         tT1w==
X-Gm-Message-State: AOAM533CcjF8xSaqL4PCzh+DL2Li2btBz5mnQTRWou0rkSOeCh+x+w06
        mc6YMZ+9QJrkZggVV9TR38m2cA==
X-Google-Smtp-Source: ABdhPJwTRMg1a0Lk2Pj6GJ7O5h3tD9vKAJbB1Z5snXpbFRqN9p4JsZnNjdmBTtzWNHtKW6ng0ZEatw==
X-Received: by 2002:a05:620a:4721:: with SMTP id bs33mr23096566qkb.0.1635775387822;
        Mon, 01 Nov 2021 07:03:07 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id 18sm2010955qty.42.2021.11.01.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 07:03:07 -0700 (PDT)
Date:   Mon, 1 Nov 2021 11:03:01 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     hongxing.zhu@nxp.com, l.stach@pengutronix.de,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        helgaas@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] PCI: imx6: Replace legacy gpio interface for gpiod
 interface
Message-ID: <YX/zlRqmxbLRnTqT@fedora>
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
---
 drivers/pci/controller/dwc/pci-imx6.c | 30 +++++++++------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80fc98acf097..589cbd600d17 100644
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
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
 					imx6_pcie->gpio_active_high);
 		msleep(100);
-		gpio_set_value_cansleep(imx6_pcie->reset_gpio,
+		gpiod_set_value_cansleep(imx6_pcie->reset_gpio,
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

