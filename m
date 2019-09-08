Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E144ACF01
	for <lists+linux-pci@lfdr.de>; Sun,  8 Sep 2019 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfIHNnM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 8 Sep 2019 09:43:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42468 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfIHNnM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 8 Sep 2019 09:43:12 -0400
Received: by mail-wr1-f67.google.com with SMTP id q14so10999844wrm.9
        for <linux-pci@vger.kernel.org>; Sun, 08 Sep 2019 06:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MPMNuIvBDuMpXWllYYYQc+uQUL5Apc6pCcccd/3M7DI=;
        b=1YogVn8kGos8KYTq7iFgHl8nNKzFAwaR62cZ1BnEPVcRFJF/CtzJpgnRxieBcmpBns
         BMc+Ppn2v3xM9ZWWG42Iv9Q3g4cpCEhC44zuVO585NDvAuOTD9b19ZhQwh34UD98voaj
         daaCrnsdN+1Egwx4tVBs5FD/Xy8l2Odfcz1gsIPIhaHoE8jDpfkxr1Vip00kqwk4dDIz
         LXhm/1DtkeWECYKe1P3ceIHzK57O3oL5PRURDiSYO/WIg1QTpKSZXlwRwamN+hzQ9M3g
         hNQPVbxrvwxM6klB5rCKV0ZIUA/qOfK49v2dI3LSrgfECoW6bUUlaLUbCExtmLmEc5oc
         s2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MPMNuIvBDuMpXWllYYYQc+uQUL5Apc6pCcccd/3M7DI=;
        b=AqENcbn8pHhserQW6MwqWtqUoTxk8ugf3G7zZCeNK0WayVdNTwKUQdvZ38tbPujEeQ
         /qRsaIFWtkXPKQ08an4kult5utIXA6c4HrPiTOwdbEckZxDLQmFMkUx8cMzdIHAl+Aan
         gJfxw9P8nVX5aUYJv4/KDiOIUXuzZrFbY6Mne+7085sMzneOp1IZaPF3nsznHeVmjYwx
         eYS6m1vhxyxrdCjvkMEUg3RN7rxvQkgsptf/YY2h4FaMpnNKbQXy8kNumnRAmyju2Mt3
         x08gatnRfFrRQayeADkNWQbNMCKniyE0Q/eLeb71qsEWfMqZ73yI34Z8EQL/pWDNoyFX
         mF8A==
X-Gm-Message-State: APjAAAXFej1EDGz6kc8ybNubqtiapHbynp/h54WLdYs7uMUrpDBR1pY9
        OTbyOWTekbEY1T+91euLt/RVmg==
X-Google-Smtp-Source: APXvYqwNyG0t5TErz2/QR2NwfTw/s/xk+uFaC9e+6aRneeul+t9o7Pn0tGNVJy66USrGio+WoOlNeg==
X-Received: by 2002:adf:f482:: with SMTP id l2mr15178200wro.103.1567950190158;
        Sun, 08 Sep 2019 06:43:10 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.gmail.com with ESMTPSA id t203sm14313902wmf.42.2019.09.08.06.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Sep 2019 06:43:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, yue.wang@Amlogic.com, kishon@ti.com
Cc:     repk@triplefau.lt, Neil Armstrong <narmstrong@baylibre.com>,
        maz@kernel.org, linux-amlogic@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] arm64: dts: khadas-vim3: add commented support for PCIe
Date:   Sun,  8 Sep 2019 13:42:58 +0000
Message-Id: <1567950178-4466-7-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
References: <1567950178-4466-1-git-send-email-narmstrong@baylibre.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
an USB3.0 Type A connector and a M.2 Key M slot.
The PHY driving these differential lines is shared between
the USB3.0 controller and the PCIe Controller, thus only
a single controller can use it.

The needed DT configuration when the MCU is configured to mux
the PCIe/USB3.0 differential lines to the M.2 Key M slot is
added commented and may uncommented to disable USB3.0 from the
USB Complex and enable the PCIe controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  | 22 +++++++++++++++++++
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  | 22 +++++++++++++++++++
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  4 ++++
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 22 +++++++++++++++++++
 4 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
index 3a6a1e0c1e32..0577b1435cbb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
@@ -14,3 +14,25 @@
 / {
 	compatible = "khadas,vim3", "amlogic,a311d", "amlogic,g12b";
 };
+
+/*
+ * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
+ * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
+ * an USB3.0 Type A connector and a M.2 Key M slot.
+ * The PHY driving these differential lines is shared between
+ * the USB3.0 controller and the PCIe Controller, thus only
+ * a single controller can use it.
+ * If the MCU is configured to mux the PCIe/USB3.0 differential lines
+ * to the M.2 Key M slot, uncomment the following block to disable
+ * USB3.0 from the USB Complex and enable the PCIe controller.
+ */
+/*
+&pcie {
+	status = "okay";
+};
+
+&usb {
+	phys = <&usb2_phy0>, <&usb2_phy1>;
+	phy-names = "usb2-phy0", "usb2-phy1";
+};
+ */
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
index b73deb282120..1ef5c2f04f67 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
@@ -14,3 +14,25 @@
 / {
 	compatible = "khadas,vim3", "amlogic,s922x", "amlogic,g12b";
 };
+
+/*
+ * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
+ * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
+ * an USB3.0 Type A connector and a M.2 Key M slot.
+ * The PHY driving these differential lines is shared between
+ * the USB3.0 controller and the PCIe Controller, thus only
+ * a single controller can use it.
+ * If the MCU is configured to mux the PCIe/USB3.0 differential lines
+ * to the M.2 Key M slot, uncomment the following block to disable
+ * USB3.0 from the USB Complex and enable the PCIe controller.
+ */
+/*
+&pcie {
+	status = "okay";
+};
+
+&usb {
+	phys = <&usb2_phy0>, <&usb2_phy1>;
+	phy-names = "usb2-phy0", "usb2-phy1";
+};
+ */
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 8647da7d6609..eac5720dc15f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -246,6 +246,10 @@
 	linux,rc-map-name = "rc-khadas";
 };
 
+&pcie {
+	reset-gpios = <&gpio GPIOA_8 GPIO_ACTIVE_LOW>;
+};
+
 &pwm_ef {
         status = "okay";
         pinctrl-0 = <&pwm_e_pins>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index 5233bd7cacfb..d9c7cbedce53 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -68,3 +68,25 @@
 	clock-names = "clkin1";
 	status = "okay";
 };
+
+/*
+ * The VIM3 on-board  MCU can mux the PCIe/USB3.0 shared differential
+ * lines using a FUSB340TMX USB 3.1 SuperSpeed Data Switch between
+ * an USB3.0 Type A connector and a M.2 Key M slot.
+ * The PHY driving these differential lines is shared between
+ * the USB3.0 controller and the PCIe Controller, thus only
+ * a single controller can use it.
+ * If the MCU is configured to mux the PCIe/USB3.0 differential lines
+ * to the M.2 Key M slot, uncomment the following block to disable
+ * USB3.0 from the USB Complex and enable the PCIe controller.
+ */
+/*
+&pcie {
+	status = "okay";
+};
+
+&usb {
+	phys = <&usb2_phy0>, <&usb2_phy1>;
+	phy-names = "usb2-phy0", "usb2-phy1";
+};
+ */
-- 
2.17.1

