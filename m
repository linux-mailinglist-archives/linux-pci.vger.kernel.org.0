Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BF3516D7F
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 11:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349916AbiEBJmg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 05:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384281AbiEBJme (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 05:42:34 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F0448396
        for <linux-pci@vger.kernel.org>; Mon,  2 May 2022 02:39:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4639E41982;
        Mon,  2 May 2022 09:38:58 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI: apple: Add support for optional PWREN GPIO
Date:   Mon,  2 May 2022 18:38:32 +0900
Message-Id: <20220502093832.32778-4-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502093832.32778-1-marcan@marcan.st>
References: <20220502093832.32778-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

WiFi and SD card devices on M1 Macs have a separate power enable GPIO.
Add support for this to the PCIe controller. This is modeled after how
pcie-fu740 does it.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/pci/controller/pcie-apple.c | 35 ++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index e3aa2d461739..5b73c03ebe94 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -518,6 +518,16 @@ static int apple_pcie_probe_port(struct device_node *np)
 	}
 
 	gpiod_put(gd);
+
+	gd = gpiod_get_from_of_node(np, "pwren-gpios", 0,
+				    GPIOD_OUT_LOW, "PWREN");
+	if (IS_ERR(gd)) {
+		if (PTR_ERR(gd) != -ENOENT)
+			return PTR_ERR(gd);
+	} else {
+		gpiod_put(gd);
+	}
+
 	return 0;
 }
 
@@ -526,7 +536,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 {
 	struct platform_device *platform = to_platform_device(pcie->dev);
 	struct apple_pcie_port *port;
-	struct gpio_desc *reset;
+	struct gpio_desc *reset, *pwren = NULL;
 	u32 stat, idx;
 	int ret, i;
 
@@ -535,6 +545,15 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	if (IS_ERR(reset))
 		return PTR_ERR(reset);
 
+	pwren = devm_gpiod_get_from_of_node(pcie->dev, np, "pwren-gpios", 0,
+					    GPIOD_OUT_LOW, "PWREN");
+	if (IS_ERR(pwren)) {
+		if (PTR_ERR(pwren) == -ENOENT)
+			pwren = NULL;
+		else
+			return PTR_ERR(pwren);
+	}
+
 	port = devm_kzalloc(pcie->dev, sizeof(*port), GFP_KERNEL);
 	if (!port)
 		return -ENOMEM;
@@ -557,12 +576,22 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
 	/* Assert PERST# before setting up the clock */
 	gpiod_set_value_cansleep(reset, 1);
 
+	/* Power on the device if required */
+	if (pwren)
+		gpiod_set_value_cansleep(pwren, 1);
+
 	ret = apple_pcie_setup_refclk(pcie, port);
 	if (ret < 0)
 		return ret;
 
-	/* The minimal Tperst-clk value is 100us (PCIe CEM r5.0, 2.9.2) */
-	usleep_range(100, 200);
+	/*
+	 * The minimal Tperst-clk value is 100us (PCIe CEM r5.0, 2.9.2)
+	 * If powering up, the minimal Tpvperl is 100ms
+	 */
+	if (pwren)
+		msleep(100);
+	else
+		usleep_range(100, 200);
 
 	/* Deassert PERST# */
 	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
-- 
2.35.1

