Return-Path: <linux-pci+bounces-26422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 560BEA974B4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 20:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C1C176433
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 18:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCF6298983;
	Tue, 22 Apr 2025 18:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OYb+/mD4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00A2980A8
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745347927; cv=none; b=tH7RKmr65++ga5DbhMbX+K1hLvmjSY7SGTscsfh8yAkSq5ij8F1uNHK0ZKF2OzFYjROwqcNumyn4kEi4yYQJu3tDwk+ymQvODQPyTmq8X4LpmANrt/ra9tU3RxRoythp3Z3qnm+hZBsMGP6dCseYgtoaj1ySd/7bd9kiWrs7CPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745347927; c=relaxed/simple;
	bh=J4if3MPmbylWo1ZVh61aotFj5BEvXmzuoQeC/6MOGrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGjV+GuU7cHB/5A0kSrLeVjDMEWmtliq3Wsmq8C6xUGWVMkOl/i5p0rvjyUavbT+OYBv7XGJ3Lw2LURP22oneEVwCS5kxFeAz0NGeEcGyox45TOS8+1QQcZSD7ejm1uCExpAFM3KkOAVXh7EFh9k/oB3R9dKXJVj4Fl61+Di0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OYb+/mD4; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso2930804f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 11:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745347923; x=1745952723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qcu3jY9KMaHOfphKfi7ZmlunMsnQwTpMnv18LDk4Xi8=;
        b=OYb+/mD43KxvslHkE+be33XNCxmbg6PL4/7oF8zHVaf4RnI2Uiw1cVHX2QLrOw2l8/
         LuFkdTbOfibHaudhe6KJBj6cAEAUpTVM8HyOIOn+brGcLfWJDV2RKw58osfhQtae3es+
         +LiChjN/fyD80zD1XTbr7WhGOuSh5/yIpYKzHKZpsS/zwvzLCaLOovF/TWrNGO7g9hbp
         KYD2Jg3yfzihnqGpX5JwF1OtTLS19WgFI+bcZnQu2QefIhlrd5DH1zC3pr02uJ8on+H5
         SSw7DUTBmF/WYciiaKtGqUhNUK5R++sZNvQwCEhWC2jg94l70pGRXsbZKtjn+/XZk8gD
         1HkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745347923; x=1745952723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qcu3jY9KMaHOfphKfi7ZmlunMsnQwTpMnv18LDk4Xi8=;
        b=kEDbly9y5tJw26ja19UVOE6Q3gvz7QpS0HZ8ioM/lt4ENSU3vLKqF2FWNA5rxBzyO+
         uMWBi6d38yaQItciR5iRRpZcQ2M0TSeEGg1MDWHm74V+7bw7WowIxH/P8o5PEaUagPHz
         9lL2gPxEE2icxwn0sq+SD0lUZ5R0NQ1kqdZVpg+2VFYTcA3qGKjbb3Y3xJgaOAC2zKnq
         0wePuFt2Qg7CpO4YgT2wdgBLpqIBn9z+NGGxO2UHnjRYQrTnM8O5ZdfgwgZ5PPkcEQtB
         8z1XJ+5gD7WN1hIGy79Pvx/lCH/0dMi8VBQiKQB3PtGM0EFwsuLIZzHYdWvvgPB3XPHj
         OYVg==
X-Forwarded-Encrypted: i=1; AJvYcCVMGWi2bQ3+rAqNRelU2v7qptzLRkCBhuggwNqmfjVaj+RvOk1ILqY0sNbTcANGTA8ILN4b2wACAXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZ01yEIVbvD3OL+SNTazNoTASHKn8X6uqq9IEAGxh5NOtg0oZ
	8n4TsmO+/TuGKzWarkA+gOlfa8beFi9fMYPzLWz+M7NKRlTl/CamI86dMRf4y4c=
X-Gm-Gg: ASbGncvlliqNbS5y7kSacyK21NvWb3RfuMHoX7WjAStufbl0/XE770qr91xk9e5xdTg
	cI5x1YKpNvVPF9UwQNebqxJDgPH11BdmcJCZwmxUX8A42W3UrhTYca/gwJS8Iqh9AYA4ElSt9YL
	DbTpK3fYLlIjEhJODDI5+oUciXrFYTv0Vx1RvCFAPthe7ICEpJZzEfMU4S2zIb6n0RIjXvz8bDk
	xt55yWkvHHkbjWfti67supLG74wldBA8+pzsfE0eOg5FhqQ/F4xUI2Oo4ZvN8j3GaL0l7Vjw9sf
	G/wJLDvOjbNZzx9cZ6goXdufbNPsBPjm/x/oA09ELqhOzJXwPjQzYLXTkEYVoNB8XOzmznL5Vh5
	/vmuYdw==
X-Google-Smtp-Source: AGHT+IEZoxLoFKU0LNFEK9F73zcTzEI4zRl148882yqWcJii83moL7TB2SWLs+i6wWKOFDdv3o01wQ==
X-Received: by 2002:a05:6000:2408:b0:391:39bd:a381 with SMTP id ffacd0b85a97d-39efba5af0dmr12597344f8f.30.1745347923459;
        Tue, 22 Apr 2025 11:52:03 -0700 (PDT)
Received: from localhost (93-44-188-26.ip98.fastwebnet.it. [93.44.188.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39f069df9fcsm10861032f8f.16.2025.04.22.11.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 11:52:03 -0700 (PDT)
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
Subject: [PATCH v9 -next 01/12] dt-bindings: clock: Add RaspberryPi RP1 clock bindings
Date: Tue, 22 Apr 2025 20:53:10 +0200
Message-ID: <83ec97c16b7a26245b497ac81539437ecbfe5bf2.1745347417.git.andrea.porta@suse.com>
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

Add device tree bindings for the clock generator found in RP1 multi
function device, and relative entries in MAINTAINERS file.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 .../clock/raspberrypi,rp1-clocks.yaml         | 58 ++++++++++++++++++
 .../clock/raspberrypi,rp1-clocks.h            | 61 +++++++++++++++++++
 2 files changed, 119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h

diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
new file mode 100644
index 000000000000..cc4491f7ee5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 clock generator
+
+maintainers:
+  - A. della Porta <andrea.porta@suse.com>
+
+description: |
+  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
+  VIDEO), and each PLL output can be programmed through dividers to generate
+  the clocks to drive the sub-peripherals embedded inside the chipset.
+
+  Link to datasheet:
+  https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
+
+properties:
+  compatible:
+    const: raspberrypi,rp1-clocks
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+    description:
+      The available clocks are defined in
+      include/dt-bindings/clock/raspberrypi,rp1-clocks.h.
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
+
+    rp1 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clocks@c040018000 {
+            compatible = "raspberrypi,rp1-clocks";
+            reg = <0xc0 0x40018000 0x0 0x10038>;
+            #clock-cells = <1>;
+            clocks = <&clk_rp1_xosc>;
+        };
+    };
diff --git a/include/dt-bindings/clock/raspberrypi,rp1-clocks.h b/include/dt-bindings/clock/raspberrypi,rp1-clocks.h
new file mode 100644
index 000000000000..248efb895f35
--- /dev/null
+++ b/include/dt-bindings/clock/raspberrypi,rp1-clocks.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (C) 2021 Raspberry Pi Ltd.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_RASPBERRYPI_RP1
+#define __DT_BINDINGS_CLOCK_RASPBERRYPI_RP1
+
+#define RP1_PLL_SYS_CORE		0
+#define RP1_PLL_AUDIO_CORE		1
+#define RP1_PLL_VIDEO_CORE		2
+
+#define RP1_PLL_SYS			3
+#define RP1_PLL_AUDIO			4
+#define RP1_PLL_VIDEO			5
+
+#define RP1_PLL_SYS_PRI_PH		6
+#define RP1_PLL_SYS_SEC_PH		7
+#define RP1_PLL_AUDIO_PRI_PH		8
+
+#define RP1_PLL_SYS_SEC			9
+#define RP1_PLL_AUDIO_SEC		10
+#define RP1_PLL_VIDEO_SEC		11
+
+#define RP1_CLK_SYS			12
+#define RP1_CLK_SLOW_SYS		13
+#define RP1_CLK_DMA			14
+#define RP1_CLK_UART			15
+#define RP1_CLK_ETH			16
+#define RP1_CLK_PWM0			17
+#define RP1_CLK_PWM1			18
+#define RP1_CLK_AUDIO_IN		19
+#define RP1_CLK_AUDIO_OUT		20
+#define RP1_CLK_I2S			21
+#define RP1_CLK_MIPI0_CFG		22
+#define RP1_CLK_MIPI1_CFG		23
+#define RP1_CLK_PCIE_AUX		24
+#define RP1_CLK_USBH0_MICROFRAME	25
+#define RP1_CLK_USBH1_MICROFRAME	26
+#define RP1_CLK_USBH0_SUSPEND		27
+#define RP1_CLK_USBH1_SUSPEND		28
+#define RP1_CLK_ETH_TSU			29
+#define RP1_CLK_ADC			30
+#define RP1_CLK_SDIO_TIMER		31
+#define RP1_CLK_SDIO_ALT_SRC		32
+#define RP1_CLK_GP0			33
+#define RP1_CLK_GP1			34
+#define RP1_CLK_GP2			35
+#define RP1_CLK_GP3			36
+#define RP1_CLK_GP4			37
+#define RP1_CLK_GP5			38
+#define RP1_CLK_VEC			39
+#define RP1_CLK_DPI			40
+#define RP1_CLK_MIPI0_DPI		41
+#define RP1_CLK_MIPI1_DPI		42
+
+/* Extra PLL output channels - RP1B0 only */
+#define RP1_PLL_VIDEO_PRI_PH		43
+#define RP1_PLL_AUDIO_TERN		44
+
+#endif
-- 
2.35.3


