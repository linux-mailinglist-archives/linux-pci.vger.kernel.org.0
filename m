Return-Path: <linux-pci+bounces-15448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130939B329A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 15:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4803282F86
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 14:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AC81DD556;
	Mon, 28 Oct 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MPPLteD8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC601DD553
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124440; cv=none; b=upMzGo2H+AsC3qqXCdk5K8erlmwz3zPnNjMuIQ7Cpoh2hOFjEWd3Z0M+ubzAhi9M81kyi/EkgsUz3oc3FDD6iORR3u/BmMLGQR3z0F2vJZ77V6XA5zyFzUjKSzjpTiaSemzgv2leXdovcWEKvAipnHKEpB1Ap6b29m6ekjDO5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124440; c=relaxed/simple;
	bh=oGXIehuDVhM9IZGFOIbJVctZ7APEguA/CTruZW7c9xI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OIP5y7HVLQ4H6aoXzyhslqLKHuJ1sLPAR18GMxZewjES99esLuExHdT2bE2ljF2XxtM7bFEwVp6CV4u8Bzlz3MPWeXnowT4b7/XS3gxVrS1OmciJIMRK98gnCV2dgGR64ExxZOafGdMgjkEcOvsDITmBTkzOxeVEF6CMSKQNljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MPPLteD8; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-5c9388a00cfso5049215a12.3
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730124435; x=1730729235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sd56aOkuMysyT2KB8hGYnKh+/GEDQ2ezHMqu8x8AMhU=;
        b=MPPLteD87R/wadZn4a2nT5HV8odzZi4L0RGQDxqzP47mMGphVJZ3sYL296+m+8P1+F
         d/b7VimwMFqUIa68BRZ4LVyOZpL0vhuv7mpqfNA2vZixiDryzsLw1pqNKgVc/Hn5x5o9
         vUUSkK3uWp30nHouLRax2ilB5IC2j3mYl1kuJYJZiL2Ld5xz+n9EMurtD+t25+02hkRz
         fvYIcK+u0FaAR9yZQvv4z5s7VPKak6ZycoUN7cRNo9OY3xDvvAf+Jia9+6v3331Azqt9
         5XT5IZDbdNlK/NLqbtCLDeNF6G4+IeDKr1uOy0RCinMMS9B35YmCqvVYKAE87sNveQ7W
         e85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124435; x=1730729235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sd56aOkuMysyT2KB8hGYnKh+/GEDQ2ezHMqu8x8AMhU=;
        b=wZqApfO/aRXYY+5OtflBk9DRmMwb3nwupHAsvSHwlAaYODc7up7YYnoHGrlPuEgrPn
         lJwRFeAPaTebkeelZvnQzf3orO+U9fwNJZzI2sGvrRLYu3nP9hJ3nRzXRvG8883v0o2V
         usMj9QcFX/pSn8CmlojwkV+zD9kkXna4/fWEHLwLAlzFrPY8unuHkHom3D0BKGb5PIsN
         nt3eK/V+Da4ZJ9L3NNWHcxPKGOJ29XqQ2QYM2+/GNehBeoKo2+HVoTl87rN6o5beYdJd
         Oxjuwd/sgVeeJpFkYLALfgVzL4DTmLZFqDcz7VfoFNodzOKkdtNZFeVfCZPXfceWG8lM
         I1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyzJyRFffeHWy3cMY2LNeTH/iYltPV2G8A2axqhHtnaWVOXXqi31AwEvfkg9ieqPGSI9cZpULSwOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cpsO0+7Kt+anmLf3/QWMALZS8AdQh8oecLzVOBRbU1iIkRF9
	uQFp8cslrcw2pI3QRResL64NREekk+dPw53C5R+zTX6zXHmOAYCsz4BgM3qi380=
X-Google-Smtp-Source: AGHT+IHnQmGNdgq4ua8lcOG0fpUd4ZzacA/KnXwPQaktYONOCK4jJ5VyW7kO53vvL4+ai760vMmRAQ==
X-Received: by 2002:a05:6402:40d5:b0:5c9:6623:a11a with SMTP id 4fb4d7f45d1cf-5cbbf94abc2mr7214438a12.25.1730124435216;
        Mon, 28 Oct 2024 07:07:15 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6347c06sm3197980a12.84.2024.10.28.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:07:14 -0700 (PDT)
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
Subject: [PATCH v3 01/12] dt-bindings: clock: Add RaspberryPi RP1 clock bindings
Date: Mon, 28 Oct 2024 15:07:18 +0100
Message-ID: <914978925d34cfb5bee10fe92603f98763af48b0.1730123575.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com>
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
---
 .../clock/raspberrypi,rp1-clocks.yaml         | 62 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 .../clock/raspberrypi,rp1-clocks.h            | 61 ++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h

diff --git a/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
new file mode 100644
index 000000000000..a123dd619f8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/raspberrypi,rp1-clocks.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RaspberryPi RP1 clock generator
+
+maintainers:
+  - Andrea della Porta <andrea.porta@suse.com>
+
+description: |
+  The RP1 contains a clock generator designed as three PLLs (CORE, AUDIO,
+  VIDEO), and each PLL output can be programmed though dividers to generate
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
+    description:
+      The index in the assigned-clocks is mapped to the output clock as per
+      definitions in include/dt-bindings/clock/raspberrypi,rp1-clocks.h.
+    const: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: xosc
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
+            clock-names =  "xosc";
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c27f3190737f..75a66e3e34c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19380,6 +19380,12 @@ F:	Documentation/devicetree/bindings/media/raspberrypi,pispbe.yaml
 F:	drivers/media/platform/raspberrypi/pisp_be/
 F:	include/uapi/linux/media/raspberrypi/
 
+RASPBERRY PI RP1 PCI DRIVER
+M:	Andrea della Porta <andrea.porta@suse.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
+F:	include/dt-bindings/clock/rp1.h
+
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
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


