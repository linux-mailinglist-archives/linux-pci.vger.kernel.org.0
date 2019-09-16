Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B00DB3AAE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 14:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbfIPMuj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 08:50:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32957 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732859AbfIPMud (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 08:50:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id b9so5162975wrs.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Sep 2019 05:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+4tUhg/FYSoCjPdeGmyIF23gJp8e0cOaQveyAhmml58=;
        b=biQL4vPtAO/eRyWG2pyM/1VRI6KGVgdG5RnuFyTEFhuLwWJ0kLQemGQgyafw5Yb0gJ
         aeb3+1ZecPorUyn8KoLfh4DVYmhqryNYpNytuFGtbGL5IkmAVY87xaB8jOFJRRRPOtjc
         1d5beDepFLUIB8is3UjvUbQLHyfvb5KztvPpqTVVRw2GOaOugDnrSYHhYMBkJoSnTQBl
         4pjLcbCERC5yomdTYxsqApKyrp7RAZjbWTigH2zqTGkgV+VBlqZZhDo2BJRyK8tdtqTr
         D6nW5MmlWgGz59KjXp9S80X7hDeXR/LVifjFQ1vGMdUTiFgEjCF0fGNl7Tt3STp8oVDV
         d8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+4tUhg/FYSoCjPdeGmyIF23gJp8e0cOaQveyAhmml58=;
        b=sue1o7DP2wx1YKMcvHVRfuOi8r8GtMWqPQfTt2NBh63/9Lwq41RUgLAaJuZOpflQAi
         yX5Jyf+C5DAW0FIZNTbeB9Yev8z9J+s65hoanKLN92aIujZIwMZRqmL6ZMGmdYUcQvI+
         gS3JLYgNJlZI772MzCd7hfz/NDKpPh02UIiMuT1WpGbqdWLYWEWbk1Q8hNR4kqz0Qy37
         T8T92irZTB3xZouTj4W1KABgnBFWOSLGZLwxbZZ+9/83EEdq0S4vay3Hh21VKzFGd+oQ
         4gdZ868Wanp6l8pybc2AlqC521xe6lFSuya5cXrJz+/OlpfNfb0Wdk0nnVwHl8gIiNXw
         XrKw==
X-Gm-Message-State: APjAAAUlH8CbQc1Q59cxZeDupaMfIek4T7iLuY8wHtY8tYy5L8j6+Bg6
        oZWHCmf/7J4HHweX6payGR4xOEIT+8oU1A==
X-Google-Smtp-Source: APXvYqy1hNq5WUJY3HgMK8Ka9tQQvMhhGJR9MlmF5V00NBgLlsE0SBGYjU7dlURi2Bms3zgjzUlcIQ==
X-Received: by 2002:adf:e48f:: with SMTP id i15mr20030170wrm.26.1568638230051;
        Mon, 16 Sep 2019 05:50:30 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm15109960wrm.23.2019.09.16.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:50:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 5/6] arm64: dts: meson-g12a: Add PCIe node
Date:   Mon, 16 Sep 2019 14:50:21 +0200
Message-Id: <20190916125022.10754-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This adds the Amlogic G12A PCI Express controller node, also
using the USB3+PCIe Combo PHY.

The PHY mode selection is static, thus the USB3+PCIe Combo PHY
phandle would need to be removed from the USB control node if the
shared differential lines are used for PCIe instead of USB3.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 33 +++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  4 +++
 2 files changed, 37 insertions(+)

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
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 91492819d0d8..ee9ea3c69433 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -135,6 +135,10 @@
 	power-domains = <&pwrc PWRC_SM1_ETH_ID>;
 };
 
+&pcie {
+	power-domains = <&pwrc PWRC_SM1_PCIE_ID>;
+};
+
 &pwrc {
 	compatible = "amlogic,meson-sm1-pwrc";
 };
-- 
2.22.0

