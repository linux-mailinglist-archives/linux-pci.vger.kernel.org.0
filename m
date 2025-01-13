Return-Path: <linux-pci+bounces-19668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC60A0BAF2
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC80165799
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 15:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945CE233530;
	Mon, 13 Jan 2025 14:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P+ZnVWWk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C764C22F83A
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780252; cv=none; b=LdPimGrJOvJZg5jHC8MtTfrBxOu9BDhZqQSWf0gr+UbPpFfVKnE8qEV8EX5Rp1Ln61Wv3WJ6wwId2N8FFe2WK3XXQVRInGX3WTDmpweXjfyct7SteOtnzteNbY/JUtAZXSxm4yslECpmmXMhht3DC958/E9+EFhCfl+I2pDFnu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780252; c=relaxed/simple;
	bh=ALUusHixIh+6t2TqYn6+YhebtqgJ/QM68HSsU3QM9Vk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=etrw54WUotNXVqeel/adWotHwZrBi/Wi9IriM3CxIiBJkzebNgXorNiEqf+mkJfgF5cB+8i7vppcaVGrc4Bm87ctpjeQK7Cj+aVDYp0bGQyMtP/0y0vt4XMIC28e72tK0I24iYwX9FgjaAbOZ7iFdnBPlQ+piMTI0iNEG8ZSeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P+ZnVWWk; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so8503816a12.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 06:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736780247; x=1737385047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpVNvS0mWns4dmdghCPgwZp6P+vFcnqkJJZ/qXumsoE=;
        b=P+ZnVWWkXnJchYA0SvI6TpeW7IqfMPIP7cAHmXpSAGeaLUMRYS8lHorb43YYqPUOdM
         TT++0W6jNpmQTsAMWgssk7kww9UiwRuxewN5F+H2LCc+I9bhIQ9PL6xOVXIvF00DV5Yp
         z6n9oJNL6sT1JIC7Utb+yt0elzW3NDS7C7X+DvevJPRMnWjG2JtPN4RRL01bv1jxRfRR
         0aVB5uhHhp2XiDI6gn3yamZNUxCbkPInsnxJMOMSKsTuKScb6bwffbf6QYiIr07xcxJg
         XzYIzPFbn8hEoKnnjBl/buBbws+p75d412s1hONvlW31NpEJjYOs5IcJshjYHcR8hRr4
         dHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736780247; x=1737385047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpVNvS0mWns4dmdghCPgwZp6P+vFcnqkJJZ/qXumsoE=;
        b=nNvU6lJC5xRHyYZGcU17HrOy2o3uKR+u4JGKQz9VlwKbBftujfeNUjd9zrtvr8tCrL
         mwQweUXLFTRwewDlyOuNvQMQ1LSU7ZMJ66Nm4GjifPfXTLbUmWEBEOUcVP1nEhR7C7ki
         I8nfiS8DPP0BKunrQI2XjX0oM6oEFE5LjMjtK+ctKBn9Za8Ap/ywZQXEzLHRHsbjxcwN
         FwmXCFEulvG69LRr9fswlTkCMxySFi9gCLaqCPi8576X8QwEgE0EVtI41LirF4VbtNUX
         iQczX9yZAIrQi59iMl7vuIulYvZjnghqtPxVkBjsvSSDxJh/RtXXEZlKrrzbPVmd2wTa
         Qxbg==
X-Forwarded-Encrypted: i=1; AJvYcCU9Y3WDTGUiVKGyx04FXs3djpcXTDOBdxO3jHMcRO+85qxZrMMqIEFCg8HXmh8wjFlZNh0ykg6+7zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZDzMJTNtOnWN5kXw5yxTGmFgwV/dWvhZLAJ61iZe+6hJ7BT0
	OEGuEzGF7quVy5EUTh7WE59TMos0u4e7waRqSurzhq5s2EWb2UukKnBM4LgRI4E=
X-Gm-Gg: ASbGncvER8Sqwqt6wALbWOtPfIHwAgNa4GytO5h785/DpEWXJfrm2I0U0Bib+qd7PZk
	P5eqzXq9yx2R/M/NXYfvl1y4/jYl/VGphHBN322KO+9aV+HqiRQy9DxAMSgSp3i5LtNwPad/Ll2
	5p/JS7O//q6CFNdJ7W4myArUcdHOi/k3Ghcd73B92V+91xkcZNgBGEdH5TG8ub3ITnodMRA72tA
	crYIS1eOaVhjSLSY7q+3vzmePt9sjjmqm0lGDoM7AVnNVuaVndt1jhQc5uluO3GQNJ7IhMOjCXo
	p+F6F1Wp3ixgDGWg5epPyeL1WRc=
X-Google-Smtp-Source: AGHT+IEV3Z8XO81JL30T5HSM10iuFAo+SAF8yUhouvdLGjnlVbS73zWwGY/9ygJKvEqqZt+dO6jvIQ==
X-Received: by 2002:a17:907:d9e:b0:aae:c3c1:1361 with SMTP id a640c23a62f3a-ab2ab6bfe9amr2116824666b.44.1736780247027;
        Mon, 13 Jan 2025 06:57:27 -0800 (PST)
Received: from localhost (host-87-14-236-197.retail.telecomitalia.it. [87.14.236.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b1ccasm509989866b.158.2025.01.13.06.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:57:26 -0800 (PST)
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
Subject: [PATCH v6 04/10] dt-bindings: misc: Add device specific bindings for RaspberryPi RP1
Date: Mon, 13 Jan 2025 15:58:03 +0100
Message-ID: <c22fa1e06926cf946ea3cb6647e9e27441f26398.1736776658.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1736776658.git.andrea.porta@suse.com>
References: <cover.1736776658.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RP1 is a MFD that exposes its peripherals through PCI BARs. This
schema is intended as minimal support for the clock generator and
gpio controller peripherals which are accessible through BAR1.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../devicetree/bindings/misc/pci1de4,1.yaml   | 135 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/pci1de4,1.yaml

diff --git a/Documentation/devicetree/bindings/misc/pci1de4,1.yaml b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
new file mode 100644
index 000000000000..034c7077b27d
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/pci1de4,1.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/pci1de4,1.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 MFD PCI device
+
+maintainers:
+  - Andrea della Porta <andrea.porta@suse.com>
+
+description:
+  The RaspberryPi RP1 is a PCI multi function device containing
+  peripherals ranging from Ethernet to USB controller, I2C, SPI
+  and others.
+  The peripherals are accessed by addressing the PCI BAR1 region.
+
+allOf:
+  - $ref: /schemas/pci/pci-ep-bus.yaml
+
+properties:
+  compatible:
+    additionalItems: true
+    maxItems: 3
+    items:
+      - const: pci1de4,1
+
+  '#interrupt-cells':
+    const: 2
+    description: |
+      Specifies respectively the interrupt number and flags as defined
+      in include/dt-bindings/interrupt-controller/irq.h.
+      The supported values for the interrupt number are:
+        - IO BANK0: 0
+        - IO BANK1: 1
+        - IO BANK2: 2
+        - AUDIO IN: 3
+        - AUDIO OUT: 4
+        - PWM0: 5
+        - ETH: 6
+        - I2C0: 7
+        - I2C1: 8
+        - I2C2: 9
+        - I2C3: 10
+        - I2C4: 11
+        - I2C5: 12
+        - I2C6: 13
+        - I2S0: 14
+        - I2S1: 15
+        - I2S2: 16
+        - SDIO0: 17
+        - SDIO1: 18
+        - SPI0: 19
+        - SPI1: 20
+        - SPI2: 21
+        - SPI3: 22
+        - SPI4: 23
+        - SPI5: 24
+        - UART0: 25
+        - TIMER0: 26
+        - TIMER1: 27
+        - TIMER2: 28
+        - TIMER3: 29
+        - USB HOST0: 30
+        - USB HOST0-0: 31
+        - USB HOST0-1: 32
+        - USB HOST0-2: 33
+        - USB HOST0-3: 34
+        - USB HOST1: 35
+        - USB HOST1-0: 36
+        - USB HOST1-1: 37
+        - USB HOST1-2: 38
+        - USB HOST1-3: 39
+        - DMA: 40
+        - PWM1: 41
+        - UART1: 42
+        - UART2: 43
+        - UART3: 44
+        - UART4: 45
+        - UART5: 46
+        - MIPI0: 47
+        - MIPI1: 48
+        - VIDEO OUT: 49
+        - PIO0: 50
+        - PIO1: 51
+        - ADC FIFO: 52
+        - PCIE OUT: 53
+        - SPI6: 54
+        - SPI7: 55
+        - SPI8: 56
+        - PROC MISC: 57
+        - SYSCFG: 58
+        - CLOCKS DEFAULT: 59
+        - VBUSCTRL: 60
+
+  interrupt-controller: true
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - pci-ep-bus@1
+
+examples:
+  - |
+    pci {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        rp1@0,0 {
+            compatible = "pci1de4,1";
+            ranges = <0x01 0x00 0x00000000  0x82010000 0x00 0x00  0x00 0x400000>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            pci_ep_bus: pci-ep-bus@1 {
+                compatible = "simple-bus";
+                ranges = <0x00 0x40000000  0x01 0x00 0x00000000  0x00 0x00400000>;
+                dma-ranges = <0x10 0x00000000  0x43000000 0x10 0x00000000  0x10 0x00000000>;
+                #address-cells = <2>;
+                #size-cells = <2>;
+
+                rp1_clocks: clocks@40018000 {
+                    compatible = "raspberrypi,rp1-clocks";
+                    reg = <0x00 0x40018000 0x0 0x10038>;
+                    #clock-cells = <1>;
+                    clocks = <&clk_rp1_xosc>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ceed86755da4..4bc77e3fa80d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19578,6 +19578,7 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
 F:	Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
 F:	include/dt-bindings/clock/rp1.h
-- 
2.35.3


