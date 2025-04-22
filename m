Return-Path: <linux-pci+bounces-26423-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B92A974BE
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619A61763B5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD962980BE;
	Tue, 22 Apr 2025 18:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GQdYHbEW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576252980CF
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 18:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347929; cv=none; b=NiB/uVOvxoFlJYAel1UjaiU9xaMSQibICTdvFEDWTLZWl1QBk5b9Ip5tzoUnP0+xQuBD7c828zJKIfWBzUe3/rXX0E33T5280PM1/KQIP4OpJwgUA4XLCChnx+cOvlLelLjSt+q8p9wndy+SpQvZZzOqmlpvzRNlndeeLsACWEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347929; c=relaxed/simple;
	bh=f6qVhB8aAi3X12mmFwL92k5Ch2dSxKmTZjw4mfsFhCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MYSjO7+nLPUPn7AcASK+TeQhD71pfNMDheRKu1twvVJsuRf1eeg3KgQXoB2R+PIAFZjaKuGBTzb3ojCs7B2qUU7sY63I5Oxy6925m7kelFzQBOeI8hJoviQJ9obWDVkSlyJ3TXx51B7Zi72NgTP0WxKluRGGfHzjdXD82bz+I+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GQdYHbEW; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43cef035a3bso38940405e9.1
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 11:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745347925; x=1745952725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCnL7F4i57Kf+GfDwe1G9hYOGXQ66tk2hfUTnm8oSwI=;
        b=GQdYHbEWvb89nCxh2wFjpPer8xBjQAnoHBrlo65sq0WZwim2LxWobKOPS55fmkXo9o
         XfHGvx+EhajpFEqNgVJC/6yWNFt5kAfLcrdT89TBwhnVINWdc2YJepaXJ8Ioh4xwmFhw
         HJ/TNNsgfg9O7SqEEocc2RYh2hJp0pUoLhsbWOZmkUJgQYCu1KnuW6nfL3kKwU+wXFGP
         b2PCOFNuJ4T3T94O6zsuNEIBy3DWQeDcCl8aG2vxEjrViKAC5mx8bPrBWY+2wFTZYYzL
         pU+AeWh4f0VnARlQWpVManM44SiNx89Uve88lLdiyC33DysA32BTITDPUKSmLbxXb/JX
         Y6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347925; x=1745952725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCnL7F4i57Kf+GfDwe1G9hYOGXQ66tk2hfUTnm8oSwI=;
        b=t4yjBe3aJ+KuhNmI9p9AlzSHpUCilebZ4dDOrODMBXq4KazX/YP6Yl5fGQL782EdzA
         CTvOQrNhXa/IsRn1vyeoJn2u8FZw7zINw7fIA5pgXfVQSX6u3s+3y1OLAC7VHBUEiDT8
         JoSVcjf5+fa1QnOmAbuBT4hda/HFgOB5SFqAoONug0wokAdiEKBDG9Gxp0LKBnn0spFW
         7Wgk/oT1bV2JGvaqS9IHg9trDr4IPqGkSje/wm8nV1OJerM2HPYUnBI9AoyY8Oahm4lw
         Vec5/5pSXoXdlcIDDlSjPp4cq2kNfQAzgkoedNCjo7MZDU3ME+ZGTEgsr11QtDmu7mlk
         SJEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/en+s/GtyIrAQealkArLjeVVJch2OkYgliof32KlFf7UBIJC4AZmidcXrk0Y9CTQwgLmvGRWF2v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/CtClRG11fQjs3Wol6irAv6MHenBnq82Q4V+74CNgd/DdB/cX
	EBDIVz+IPJzBvRefjrZtAd2CPmfHd9dQwwd+mn2W3+aBCeW9vB7wk/4UpzTbQBg=
X-Gm-Gg: ASbGncuuCvnnybZPc/Ju/xMIxrR2dOCAvLKknSJ5TZ/0mO8DagAhkPTDQfwChc069yR
	/Ny4LsmNtIoY5r3zI1Y2nWKBfelSS3yFTVodf3SbWFfhAzzTYCKFn6F6csSKFsA2r+biJ2LXR0J
	99WdYe9f89oPo9tzdWUJWfEWjsHk+e9YP5ut/847iNjfnfT5Zwz/1ra+CBkQHgD4o67ddfcdS2g
	6EoT6aKqY4LaFpezDO06/ofFSvfMDK6zgPSJbUJTw0Q4LRutZZiJgqEKkne5+JQB9mnY5d7h024
	t+CZ0tgvir5aY4eq6rztgkR+96moK1ce0tFh7gSA9rOtC2UusU5hULJRdV/oUvpALm+tyZ8=
X-Google-Smtp-Source: AGHT+IG2Jj7d5RRakNbqTLk8uQeOXGHlszMiqzcikLcrCgbVm4zQiBKEQL2v+FIhhijjlatYNTRHDQ==
X-Received: by 2002:a05:600c:4fcf:b0:440:6a37:be0d with SMTP id 5b1f17b1804b1-4406abb245cmr159066125e9.15.1745347924576;
        Tue, 22 Apr 2025 11:52:04 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4407c5c7916sm126492715e9.27.2025.04.22.11.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:52:04 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 -next 02/12] dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
Date: Tue, 22 Apr 2025 20:53:11 +0200
Message-ID: <ab2f660d1de888b53137cf60bba364f08169745b.1745347417.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1745347417.git.andrea.porta@suse.com>
References: <cover.1745347417.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the gpio/pin/mux controller that is part of
the RP1 multi function device, and relative entries in MAINTAINERS file.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../pinctrl/raspberrypi,rp1-gpio.yaml         | 198 ++++++++++++++++++
 1 file changed, 198 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
new file mode 100644
index 000000000000..eec9a9b58542
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
@@ -0,0 +1,198 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
+
+maintainers:
+  - A. della Porta <andrea.porta@suse.com>
+
+description:
+  The RP1 chipset is a Multi Function Device containing, among other
+  sub-peripherals, a gpio/pinconf/mux controller whose 54 pins are grouped
+  into 3 banks.
+  It works also as an interrupt controller for those gpios.
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-gpio
+
+  reg:
+    maxItems: 3
+    description: One reg specifier for each one of the 3 pin banks.
+
+  '#gpio-cells':
+    description: The first cell is the pin number and the second cell is used
+      to specify the flags (see include/dt-bindings/gpio/gpio.h).
+    const: 2
+
+  gpio-controller: true
+
+  gpio-ranges:
+    maxItems: 1
+
+  gpio-line-names:
+    maxItems: 54
+
+  interrupts:
+    maxItems: 3
+    description: One interrupt specifier for each one of the 3 pin banks.
+
+  '#interrupt-cells':
+    description:
+      Specifies the Bank number [0, 1, 2] and Flags as defined in
+      include/dt-bindings/interrupt-controller/irq.h.
+    const: 2
+
+  interrupt-controller: true
+
+patternProperties:
+  '-state$':
+    oneOf:
+      - $ref: '#/$defs/raspberrypi-rp1-state'
+      - patternProperties:
+          '-pins$':
+            $ref: '#/$defs/raspberrypi-rp1-state'
+        additionalProperties: false
+
+$defs:
+  raspberrypi-rp1-state:
+    allOf:
+      - $ref: pincfg-node.yaml#
+      - $ref: pinmux-node.yaml#
+
+    description:
+      Pin controller client devices use pin configuration subnodes (children
+      and grandchildren) for desired pin configuration.
+      Client device subnodes use below standard properties.
+
+    properties:
+      pins:
+        description:
+          List of gpio pins affected by the properties specified in this
+          subnode.
+        items:
+          pattern: '^gpio([0-9]|[1-4][0-9]|5[0-3])$'
+
+      function:
+        enum: [ alt0, alt1, alt2, alt3, alt4, gpio, alt6, alt7, alt8, none,
+                aaud, dcd0, dpi, dsi0_te_ext, dsi1_te_ext, dsr0, dtr0, gpclk0,
+                gpclk1, gpclk2, gpclk3, gpclk4, gpclk5, i2c0, i2c1, i2c2, i2c3,
+                i2c4, i2c5, i2c6, i2s0, i2s1, i2s2, ir, mic, pcie_clkreq_n,
+                pio, proc_rio, pwm0, pwm1, ri0, sd0, sd1, spi0, spi1, spi2,
+                spi3, spi4, spi5, spi6, spi7, spi8, uart0, uart1, uart2, uart3,
+                uart4, uart5, vbus0, vbus1, vbus2, vbus3 ]
+
+        description:
+          Specify the alternative function to be configured for the specified
+          pins.
+
+      bias-disable: true
+      bias-pull-down: true
+      bias-pull-up: true
+      input-enable: true
+      input-schmitt-enable: true
+      output-enable: true
+      output-high: true
+      output-low: true
+      slew-rate:
+        description: 0 is slow slew rate, 1 is fast slew rate
+        enum: [ 0, 1 ]
+      drive-strength:
+        enum: [ 2, 4, 8, 12 ]
+
+    additionalProperties: false
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - reg
+  - compatible
+  - '#gpio-cells'
+  - gpio-controller
+  - interrupts
+  - '#interrupt-cells'
+  - interrupt-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    rp1 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        rp1_gpio: pinctrl@c0400d0000 {
+            reg = <0xc0 0x400d0000  0x0 0xc000>,
+                  <0xc0 0x400e0000  0x0 0xc000>,
+                  <0xc0 0x400f0000  0x0 0xc000>;
+            compatible = "raspberrypi,rp1-gpio";
+            gpio-controller;
+            #gpio-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+            interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+                         <1 IRQ_TYPE_LEVEL_HIGH>,
+                         <2 IRQ_TYPE_LEVEL_HIGH>;
+            gpio-line-names =
+                   "ID_SDA", // GPIO0
+                   "ID_SCL", // GPIO1
+                   "GPIO2", "GPIO3", "GPIO4", "GPIO5", "GPIO6",
+                   "GPIO7", "GPIO8", "GPIO9", "GPIO10", "GPIO11",
+                   "GPIO12", "GPIO13", "GPIO14", "GPIO15", "GPIO16",
+                   "GPIO17", "GPIO18", "GPIO19", "GPIO20", "GPIO21",
+                   "GPIO22", "GPIO23", "GPIO24", "GPIO25", "GPIO26",
+                   "GPIO27",
+                   "PCIE_RP1_WAKE", // GPIO28
+                   "FAN_TACH", // GPIO29
+                   "HOST_SDA", // GPIO30
+                   "HOST_SCL", // GPIO31
+                   "ETH_RST_N", // GPIO32
+                   "", // GPIO33
+                   "CD0_IO0_MICCLK", // GPIO34
+                   "CD0_IO0_MICDAT0", // GPIO35
+                   "RP1_PCIE_CLKREQ_N", // GPIO36
+                   "", // GPIO37
+                   "CD0_SDA", // GPIO38
+                   "CD0_SCL", // GPIO39
+                   "CD1_SDA", // GPIO40
+                   "CD1_SCL", // GPIO41
+                   "USB_VBUS_EN", // GPIO42
+                   "USB_OC_N", // GPIO43
+                   "RP1_STAT_LED", // GPIO44
+                   "FAN_PWM", // GPIO45
+                   "CD1_IO0_MICCLK", // GPIO46
+                   "2712_WAKE", // GPIO47
+                   "CD1_IO1_MICDAT1", // GPIO48
+                   "EN_MAX_USB_CUR", // GPIO49
+                   "", // GPIO50
+                   "", // GPIO51
+                   "", // GPIO52
+                   ""; // GPIO53
+
+            rp1-i2s0-default-state {
+                function = "i2s0";
+                pins = "gpio18", "gpio19", "gpio20", "gpio21";
+                bias-disable;
+            };
+
+            rp1-uart0-default-state {
+                txd-pins {
+                    function = "uart0";
+                    pins = "gpio14";
+                    bias-disable;
+                };
+
+                rxd-pins {
+                    function = "uart0";
+                    pins = "gpio15";
+                    bias-pull-up;
+                };
+            };
+        };
+    };
-- 
2.35.3


