Return-Path: <linux-pci+bounces-13951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 850BA992BF1
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 14:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93971C22355
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059B71D2F7E;
	Mon,  7 Oct 2024 12:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="N3wj3Vze"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620CB1D27A7
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 12:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304791; cv=none; b=I35jdRC8mQz82FgKFCGQ4E4ox4LthLS/KpsnjgAASAwjrHj7NCDn0nuYQfmr/F9TjpjG5J6sAioq7uUpamPGyC1FLAwGPEKXN/3x64oorMbvoDBGgvaFxvvDuijy8yPDZRR/LowJZsYS2sohvcrKDM7fbst/lc14p2D0Cz6NqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304791; c=relaxed/simple;
	bh=wOd0gYffD7Ea7XGJvlfViJgSA9wreC2I5ALhOoujWJc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T609z0ZTpv3ZLmmb4UqdY8O+zDm8IdN4IvgjDLQXTx/+5qSU9UY8DEg9XM3U8MkEPTtaU2bf7w/8RhQwSrb7aMs/iBOnTww2wBVC+vznJ6NRFjD+xB+3N1ahJdhR+gha+paOiUIfG5XTmDTWums9j5bm0uJv8qYL90jwYiR/FKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=N3wj3Vze; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so6161192a12.0
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2024 05:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728304788; x=1728909588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hff3hwplvjS7DHpYfcjvqwcC7w2WA0fQ36PlDSvv8i4=;
        b=N3wj3Vzet14P/QBOc1ahCd4/b5hQj2e3+E9Dg5cQRqsW3dpIcAm6CkUvl41unLQK0E
         24hNJnAEy4bWpiUVVRXnUsr5WxcfhT8tRBO7/AymhxA7oDP+MfaTl6ML8DYH7Mw3n61a
         VE5ulik0jemr5cLTj1IZnyhIiIAXtq2lCY6fioaGyWGQ+RQX9icmmwf2RSzuTqbg2zDM
         dwFK/m4Yi2Wt2GIDqwnJJeHrm0bZ1JwI9HhAiWGsreVQKKg2i+7s6U01neVPckZzazxN
         J7wJQtlMQRQHilHvpWd1GutRtD9Kqm6gSpSzmsGWD8/la3yTE4R1AGfL2VsJH+gUmcH6
         JATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304788; x=1728909588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hff3hwplvjS7DHpYfcjvqwcC7w2WA0fQ36PlDSvv8i4=;
        b=tASDKMwM0cvLNpNzVUi6f4EUn3GboGYk8J9OSyanNsmJwkUnU5blWy3hR1x7/vibCq
         Hc3Ynsqs4ti2ZA0KrmyoONgXlZUhcqXgjau/h/0f1rfOSwyZ6tn9VFOHMDXH2w5OHxw8
         5detmy7VJfYgXUiaQq6emhlxIf4WTRqEZDCa8jU7SuiEpTkp2Gi3Z/QeXouPiXrQ4FFW
         5vXa9Xj/K1bO6lobyDhnxg2tENX3ztjBC39JMCSBSMSfmSrHgxBOh/qMsFqnIEbBM+RS
         ZuVwaj86S9xP5T7IJDJAEfzEHrhkpPcB0HlcQRFuuIgssgVFN6fci616Extfbj/jWP4L
         Jsjg==
X-Forwarded-Encrypted: i=1; AJvYcCXwBCzOqLUuHqbNG9dXzzgzSY5Hiyx0Gj+pOUeKD6ZkfWT+VIkG1jM7ms4vdaz0LjXThZb/9ay6T9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82h47FsIrRCjcxnO2dISZm8n0kS1WaYIrRPMOJWxRhI7xCB5Y
	JgISUyX4VH4y6nYoCw0EwqGuAGnZQRRqcx+wzNdzlIwB79MynVhP9blSB5KIjIY=
X-Google-Smtp-Source: AGHT+IG39yyCQQwIdr0FHbii9W3N4TgGlPJNvmDYGj8uTq9UAYZemTRIY+ZDrTbe3KLyHK0TjFyzoA==
X-Received: by 2002:a17:906:d553:b0:a8d:1545:f48a with SMTP id a640c23a62f3a-a991c0531eamr1096917866b.61.1728304787631;
        Mon, 07 Oct 2024 05:39:47 -0700 (PDT)
Received: from localhost (host-87-21-212-62.retail.telecomitalia.it. [87.21.212.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e784a4bsm373450466b.114.2024.10.07.05.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:39:47 -0700 (PDT)
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
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
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
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH v2 02/14] dt-bindings: pinctrl: Add RaspberryPi RP1 gpio/pinctrl/pinmux bindings
Date: Mon,  7 Oct 2024 14:39:45 +0200
Message-ID: <0589448fa41bf7f3e951a75b70226a9873db554f.1728300189.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1728300189.git.andrea.porta@suse.com>
References: <cover.1728300189.git.andrea.porta@suse.com>
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
---
 .../pinctrl/raspberrypi,rp1-gpio.yaml         | 169 ++++++++++++++++++
 MAINTAINERS                                   |   2 +
 2 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
new file mode 100644
index 000000000000..46e071ec6251
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/raspberrypi,rp1-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 GPIO/Pinconf/Pinmux Controller submodule
+
+maintainers:
+  - Andrea della Porta <andrea.porta@suse.com>
+
+description:
+  The RP1 chipset is a Multi Function Device containing, among other sub-peripherals,
+  a gpio/pinconf/mux controller whose 54 pins are grouped into 3 banks. It works also
+  as an interrupt controller for those gpios.
+
+  Each pin configuration node lists the pin(s) to which it applies, and one or
+  more of the mux function to select on those pin(s), and their configuration.
+  The pin configuration and multiplexing supports the generic bindings.
+  For details on each properties (including the meaning of "pin configuration node"),
+  you can refer to ./pinctrl-bindings.txt.
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
+additionalProperties:
+  anyOf:
+    - type: object
+      additionalProperties: false
+      allOf:
+        - $ref: pincfg-node.yaml#
+        - $ref: pinmux-node.yaml#
+
+      description:
+        Pin controller client devices use pin configuration subnodes (children
+        and grandchildren) for desired pin configuration.
+        Client device subnodes use below standard properties.
+
+      properties:
+        pins:
+          description:
+            A string (or list of strings) adhering to the pattern "gpio[0-5][0-9]"
+        function: true
+        bias-disable: true
+        bias-pull-down: true
+        bias-pull-up: true
+        slew-rate:
+          description: 0 is slow slew rate, 1 is fast slew rate
+          enum: [ 0, 1 ]
+        drive-strength:
+          enum: [ 2, 4, 8, 12 ]
+
+    - type: object
+      additionalProperties:
+        $ref: "#/additionalProperties/anyOf/0"
+
+allOf:
+  - $ref: pinctrl.yaml#
+
+required:
+  - reg
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+  - interrupts
+  - "#interrupt-cells"
+  - interrupt-controller
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
+            rp1_uart0_14_15: rp1_uart0_14_15 {
+                pin_txd {
+                    function = "uart0";
+                    pins = "gpio14";
+                    bias-disable;
+                };
+
+                pin_rxd {
+                    function = "uart0";
+                    pins = "gpio15";
+                    bias-pull-up;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 75a66e3e34c9..c55d12550246 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19384,7 +19384,9 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	include/dt-bindings/clock/rp1.h
+F:	include/dt-bindings/misc/rp1.h
 
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
-- 
2.35.3


