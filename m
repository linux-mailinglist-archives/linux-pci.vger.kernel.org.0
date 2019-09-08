Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A25EACEFC
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2019 15:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfIHNnP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Sep 2019 09:43:15 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50280 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbfIHNnM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Sep 2019 09:43:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id c10so10958499wmc.0
        for <linux-pci@vger.kernel.org>; Sun, 08 Sep 2019 06:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QWP79fY1JKJ4Q8J2pghEAh/SdWHmEms4TAuDdfokLg8=;
        b=YIGG+kJsJiFhCq3dqmypto366EH9ax3zhx8JVdur/EKxb+SmXYRhG28v5Z63pHp8zN
         OCBmiFSYfe7EbgzmvvQaWF4jBUbNCHjb9U0uhY77dUiOkRvq2CMyuS33EiGQ1utr7OIc
         FSZ93GRxpYLtF1fMwZa+LFkGEvZhyMQY8xVOcASm877jwvppWgo75O/hfqkKQO9lGgMA
         YU3yblmv3OwAATFQ7hetuxDEb7YPDEjN6U0gFc2BopqhFn6UIR0AkAOHbFOuRMJSyIwx
         OV9fpvur/5+VTfiqO6r29dWMVSjemOfYtPgj6bolH2f9y307wxErNay27xD8B2Elh0Vp
         qhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QWP79fY1JKJ4Q8J2pghEAh/SdWHmEms4TAuDdfokLg8=;
        b=SUcW3jpa3mzT8ntMq93rTGwXt1gEEmW2OwbVe5o1IyhABxYOpY4gJbit6rbzMw4FJU
         W2zZ77kvqPnE5IrfNWARXyj0UUZbPr10Gz/i+hq3Iu2hMHKp0xWpHXtgrwnDXHubqETK
         Tt62gerIchssPozufojbUcmF98O0LRcgkXxHMBQU4B0l0dJtQwPcbJpJecb/0Ui6yq+x
         X2IC03bTpaPsAvFqfYN8HdDXx6i0jDP3YHvIBHMgm+tXcYJ2cFV0dZNM3y86QGp8VQer
         9/4lvRuvC26TYgp3tLJS3gyEXOBPMbXo+Qxk9QZfZAa7P10DgdEvJxuyvMEWASC+QWV4
         /cqw==
X-Gm-Message-State: APjAAAWmkc7zIlib6DAiS4DVZ5E8cT4YE5sOfvI+Lx8Lv7+di13aaYXH
        +1KiTac9aaTu28Etw2/Z8OmmMw==
X-Google-Smtp-Source: APXvYqwdzoUJ+xfSz6GH/LJMRb9Td9tMK7kXH9Jy2I+h19yDQS7ztmE9hdHBq8Oox4JtUbGCGnVL4w==
X-Received: by 2002:a1c:ca02:: with SMTP id a2mr16087461wmg.127.1567950189470;
        Sun, 08 Sep 2019 06:43:09 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id t203sm14313902wmf.42.2019.09.08.06.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 06:43:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] arm64: dts: meson-g12a: Add PCIe node
Date:   Sun,  8 Sep 2019 13:42:57 +0000
Message-Id: <1567950178-4466-6-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds the Amlogic G12A PCI Express controller node, also
using the USB3+PCIe Combo PHY.

The PHY mode selection is static, thus the USB3+PCIe Combo PHY
phandle would need to be removed from the USB control node if the
shared differentil lines are used for PCIe instead of USB3.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 852cf9cf121b..7330dc37b7a6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -95,6 +95,39 @@
 		#size-cells = <2>;
 		ranges;
 
+		pcie: pcie@fc000000 {
+			compatible = "amlogic,g12a-pcie", "snps,dw-pcie";
+			reg = <0x0 0xfc000000 0x0 0x400000
+			       0x0 0xff648000 0x0 0x2000
+			       0x0 0xfc400000 0x0 0x200000>;
+			reg-names = "elbi", "cfg", "config";
+			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 0>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
+			bus-range = <0x0 0xff>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			ranges = <0x81000000 0 0 0x0 0xfc600000 0 0x00100000
+				  0x82000000 0 0xfc700000 0x0 0xfc700000 0 0x1900000>;
+
+			clocks = <&clkc CLKID_PCIE_PHY
+				  &clkc CLKID_PCIE_COMB
+				  &clkc CLKID_PCIE_PLL>;
+			clock-names = "general",
+				      "pclk",
+				      "port";
+			resets = <&reset RESET_PCIE_CTRL_A>,
+				 <&reset RESET_PCIE_APB>;
+			reset-names = "port",
+				      "apb";
+			num-lanes = <1>;
+			phys = <&usb3_pcie_phy PHY_TYPE_PCIE>;
+			phy-names = "pcie";
+			status = "disabled";
+		};
+
 		ethmac: ethernet@ff3f0000 {
 			compatible = "amlogic,meson-axg-dwmac",
 				     "snps,dwmac-3.70a",
-- 
2.17.1

