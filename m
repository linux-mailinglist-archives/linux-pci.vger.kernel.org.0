Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC777B3AAD
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 14:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbfIPMug (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Sep 2019 08:50:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39534 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732862AbfIPMuf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Sep 2019 08:50:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so8604426wrj.6
        for <linux-pci@vger.kernel.org>; Mon, 16 Sep 2019 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ns66tHOzGfsnxVB+ZKZBcG/oWmkd/W2Vsc0YmaMU/U=;
        b=Q5FawH7TmHcmrJMh2wE4030BW9z4wCiBaYDKiZhIPjYFlog4b2prFnps+OkHchwF7B
         BWaCDWNrTbJbIX814Z2D5h+TTDekIF+hP8siamR1zpqAsqaDndamaHt0IGu+EMO6/dYu
         kBr37SZfWSxMuk+5Ejt54g735tjeiHuL7VfMSlZ7T1CWYUKhX2yqW2d+mGDA/7tFbW6Y
         jnQRPe+AsdsSdkd5du+0Y0gaxXti/Ck5pwYY6PpS3duyfFoBcg40g0xAVqvY9U8wnuVu
         BEGFw1H8sRxGF+XTyY970TQ0P3g0H/hpDVGNynPHd1JgNQE0/YFv7oR87w9IHARbttZo
         xfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ns66tHOzGfsnxVB+ZKZBcG/oWmkd/W2Vsc0YmaMU/U=;
        b=ZRnwbK5WavE/IsTFt6hWUrdX0Nh7jupJID5Z2I6BhrbPZpxld5RF5X/w2nGcl5k2RA
         lliB3llmIkjC0QOHINFG8t2gFKFPQGMjWX58hNy2pqdAxXd5Hrwr14W4z2LCZkntwYiS
         r++UAprjvfkdvayQ2wS23ee9lorSuJqIHajiHudNrEbxiwSpEb2CqVd3TQfslpFBVDEE
         PYYst/VjYsjd4o6M27D2Hy1FplrXKTL8gqz7+Sq0yW/QHX0xKJ14A6cyyaHQmMr8ck90
         CuFBhg/DA1/TNBe4sZOVNurC2UAAVXyQ2C5eloD9pw2MVUmi+fHYqRu1mduVUG4c4RJx
         BbRw==
X-Gm-Message-State: APjAAAULobpRv8uJkrb8epAnGpUJb3QxCD+oAe2l33GlBuhoAeP3apb7
        16S0tgduWiF4gvU1iWjPI+IScw==
X-Google-Smtp-Source: APXvYqzsfq/BuIwBYdAXlk/1o8lD0CLh/RoZ6Boua1yJWfbbATvUH6je8biFkwHt0aM1SZeaCwPcHQ==
X-Received: by 2002:a5d:4f8c:: with SMTP id d12mr10731444wru.150.1568638231062;
        Mon, 16 Sep 2019 05:50:31 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o12sm15109960wrm.23.2019.09.16.05.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 05:50:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, andrew.murray@arm.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        yue.wang@Amlogic.com, maz@kernel.org, repk@triplefau.lt,
        nick@khadas.com, gouwa@khadas.com
Subject: [PATCH v2 6/6] arm64: dts: khadas-vim3: add commented support for PCIe
Date:   Mon, 16 Sep 2019 14:50:22 +0200
Message-Id: <20190916125022.10754-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190916125022.10754-1-narmstrong@baylibre.com>
References: <20190916125022.10754-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
added commented and may be uncommented to disable USB3.0 from the
USB Complex and enable the PCIe controller.

The End User is not expected to uncomment the following except for
testing purposes, but instead rely on the firmware/bootloader to
update these nodes accordingly if PCIe mode is selected by the MCU.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  | 25 +++++++++++++++++++
 .../amlogic/meson-g12b-s922x-khadas-vim3.dts  | 25 +++++++++++++++++++
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  4 +++
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 25 +++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
index 3a6a1e0c1e32..124a80901084 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-a311d-khadas-vim3.dts
@@ -14,3 +14,28 @@
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
+ * The End User is not expected to uncomment the following except for
+ * testing purposes, but instead rely on the firmware/bootloader to
+ * update these nodes accordingly if PCIe mode is selected by the MCU.
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
index b73deb282120..bba98f982ad6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x-khadas-vim3.dts
@@ -14,3 +14,28 @@
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
+ * The End User is not expected to uncomment the following except for
+ * testing purposes, but instead rely on the firmware/bootloader to
+ * update these nodes accordingly if PCIe mode is selected by the MCU.
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
index 4fe7d33ebe8a..90815fa25ec6 100644
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
index 5233bd7cacfb..dbbf29a0dbf6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -68,3 +68,28 @@
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
+ * The End User is not expected to uncomment the following except for
+ * testing purposes, but instead rely on the firmware/bootloader to
+ * update these nodes accordingly if PCIe mode is selected by the MCU.
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
2.22.0

