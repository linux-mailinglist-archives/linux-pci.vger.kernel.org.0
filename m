Return-Path: <linux-pci+bounces-20981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2F1A2CFA3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 22:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF16B16400D
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 21:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9322422F16B;
	Fri,  7 Feb 2025 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IsguQlAY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7BF1C831A
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738963872; cv=none; b=d2smWfPBREETbp8pzioItu0HyCVgFXLGqiGFOqCTQ2yrD4RTZ4gcY2lF4LSF6z/ynrDmfnrkNDEmSra7jYXrHGF1vyC4qvTrQBqldgSVBT7lLKUDtCXPKZKAEBzB1u6EVg08Bgmw1jp7o6qkUceRx3B4+O3fsAS0Z8+yu2gwcmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738963872; c=relaxed/simple;
	bh=TZUicfeAMILEnwIxb9xEAO04I+RmJCZPazH+xJUDDoY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k6AMw4w3822WQ7Go6rV4uG0EAT8YsZsEDzyx8yhs1kg1ysBe6K6+3V465lxXcl5+7UK+o2ZXSAavQOij1f1gb1RRoLLKyUJvgN+oDB+kTCCuxFh/1WqgWJ03I/jTWjjgkZR6vtV1Y7cUMKxJo0NqLsTmAVf1QbcbNVGi53wN23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IsguQlAY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaec111762bso608606066b.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 13:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738963866; x=1739568666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMUvbtsA5DsEuCVaRQsEVedbOqoTRGmICjeOt7R2GgQ=;
        b=IsguQlAYC283eGQbuQwmsxax2Idetel8fX/5JEN8vGsiUDw3BTSjHHoi0KtpwBXXLN
         Evz0nkGXpTrGPGt5WybKU1dHbUcq9HeQxP1rVTS8hXbN8XV0UfJ6HeumbcAjV0lcdSVz
         NYwIaEXaai0KXrsyb7QhB7+bTJEBdSdOgL6j8Aa5+FAfIm+XdsMc7j5LNiMt4e+CwnHO
         GitauW7yzX1uR4KU2gUgNgCyrmoka38SfZsXx7YAwsuYxO/YZuxxJYTu4YCxdhAl3zFB
         Ku+R1bLCnfk9iz/ceWamJiav1c0NmpDezy+7gLWYwbUHvf6/8Uk9s1hbQZo9H2Dw+K03
         zQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738963866; x=1739568666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMUvbtsA5DsEuCVaRQsEVedbOqoTRGmICjeOt7R2GgQ=;
        b=M3cn43jdSsL48JJro1Nqgm+DkhsQb7pIyqpJNyZgCaHaty+Er1R4zvp2XdF41sJMmr
         Pi7MKoPCB4/9ScgcHt62DKaDEMJ5vx9UFe9U1pQ5oTtFNLhpdD/50D8Lt3xui9c7Uqb5
         MgVsRY/AAydUuzyQN4J/TOoyYDcanoqYBN/6DT+ITdSmEaSXcFn5xWahGgpImqT/QaFd
         dSSDGU7Tdoa/XK3khWRrr48X3b1HKLp2Tx/LdFMeYxkcv+v/dlhAuJupp1O+/BS88Hqq
         +Ug1joTjkfQ0Fqhh2CGjUqCbGnP5+Ijh4UBZAnEGhhAYuwVLxnXNOLlBf0xRAhAWkQza
         tsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqJXCgS9OC1iZ0botckPsEcVQcqAb2dbEL5s5YBnsRAlqXRrk9ojzze+i6ev+/XP/Errecbl2H5is=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSpQKXF359jXfNa4TEVdLvLGcpZukyyv6GcQ5D1JRu+Ghodje
	bklU8koMLw979QIB1Zbebubn4C9HxYVoE3onZ9+lN6i+bhyX8jnJMpUL9GWUv/0=
X-Gm-Gg: ASbGncvpvEcyqK7046TBPY9eXu/LZCw4Mz0nviVftHDC+5aJQN8sVjnmuiNpjkQKVHp
	exrabpz8rhoaKvM8iQjRKcnk+Cnw0yG91ZWFU5D50VcSnTTWX3ear0enoeXjPtZEGQYkbgHSBAY
	fHNeEaLPUUTG0AzbQmR3L0LSG4pN6EJ4I6YU5N6yJDVOzCCEXotJNezICcQBUqYVhZGC0DCf083
	j74WmfnlPr9GONYxhVarbay5kxSenCgZ27c+7cljV/W6GtdWQ8HGWh+YJBkQMJF/CJ/h2NVeo4D
	lF17Mo9SRNyRZg71BJlMz2VCLC6AT7eA2RifMC+d0ntduWaz+TR+vj3Q85g=
X-Google-Smtp-Source: AGHT+IGxw8RmkdWRiBOE+V4K6YhzQQBZN/f/qODYZupDZrZmgY7l+ROzD9QDKgrRus5KdQsC+ufcWg==
X-Received: by 2002:a17:907:2d13:b0:ab7:6d4a:a746 with SMTP id a640c23a62f3a-ab789c87f67mr561681666b.51.1738963865621;
        Fri, 07 Feb 2025 13:31:05 -0800 (PST)
Received: from localhost (host-79-41-239-37.retail.telecomitalia.it. [79.41.239.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab78cd15ac3sm173925766b.126.2025.02.07.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:31:05 -0800 (PST)
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
Subject: [PATCH v7 07/11] arm64: dts: rp1: Add support for RaspberryPi's RP1 device
Date: Fri,  7 Feb 2025 22:31:47 +0100
Message-ID: <a3e6dc47b87a5e5ef64b03a54bc518eecd90ac4d.1738963156.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1738963156.git.andrea.porta@suse.com>
References: <cover.1738963156.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RaspberryPi RP1 is a multi function PCI endpoint device that
exposes several subperipherals via PCI BAR.
Add a dtb overlay that will be compiled into a binary blob
and linked in the RP1 driver.
This overlay offers just minimal support to represent the
RP1 device itself, the sub-peripherals will be added by
future patches.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 MAINTAINERS                           |  1 +
 arch/arm64/boot/dts/broadcom/rp1.dtso | 58 +++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso

diff --git a/MAINTAINERS b/MAINTAINERS
index f2ba6f565d30..4cb38064694e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19751,6 +19751,7 @@ F:	drivers/media/platform/raspberrypi/rp1-cfe/
 RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/rp1.dtso
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
new file mode 100644
index 000000000000..cdff061e2750
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path="";
+		__overlay__ {
+			compatible = "pci1de4,1";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			pci_ep_bus: pci-ep-bus@1 {
+				compatible = "simple-bus";
+				ranges = <0x00 0x40000000  0x01 0x00 0x00000000  0x00 0x00400000>;
+				dma-ranges = <0x10 0x00000000  0x43000000 0x10 0x00000000  0x10 0x00000000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+
+				rp1_clocks: clocks@40018000 {
+					compatible = "raspberrypi,rp1-clocks";
+					reg = <0x00 0x40018000 0x0 0x10038>;
+					#clock-cells = <1>;
+					clocks = <&clk_rp1_xosc>;
+					assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
+							  <&rp1_clocks RP1_PLL_SYS>,
+							  <&rp1_clocks RP1_PLL_SYS_SEC>,
+							  <&rp1_clocks RP1_CLK_SYS>;
+					assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
+							       <200000000>,  // RP1_PLL_SYS
+							       <125000000>,  // RP1_PLL_SYS_SEC
+							       <200000000>;  // RP1_CLK_SYS
+				};
+
+				rp1_gpio: pinctrl@400d0000 {
+					compatible = "raspberrypi,rp1-gpio";
+					reg = <0x00 0x400d0000  0x0 0xc000>,
+					      <0x00 0x400e0000  0x0 0xc000>,
+					      <0x00 0x400f0000  0x0 0xc000>;
+					gpio-controller;
+					#gpio-cells = <2>;
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+						     <1 IRQ_TYPE_LEVEL_HIGH>,
+						     <2 IRQ_TYPE_LEVEL_HIGH>;
+				};
+			};
+		};
+	};
+};
-- 
2.35.3


