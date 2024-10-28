Return-Path: <linux-pci+bounces-15454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5669B32BB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 15:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D2E282F7F
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2024 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248B1DE4C0;
	Mon, 28 Oct 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SMecslP5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86041DD55F
	for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730124452; cv=none; b=mGQFfNABS9QtehlKT8ZmsyoZ/px7DEMLIp5F4TyGPd6PPpHU3qH8Comej2/FLGbyJPgJgfSHKsxZAROjHg5zVYQ5Ak3MkIq7f/h9UNEFqqOq3x1y+WqJgUnegSSFrEys0W7r+zL0QUxJRhGQFd1vrlBvY/3rY3oX/9DkhM/ML9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730124452; c=relaxed/simple;
	bh=jVpFSFjRvCO431pFJM5NtQyQ/ko6vIsiLp52mklCu98=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSg0+hqYXo3cRQtImLUy5/8+rAZZCiPE+uYhYpPlL26l7BcshTHSJFwlyR+Pf6zOjwPtIQrxZVBxrgb04uUVBg8ki+d94tpQ3dNIJHtvU+e+TS08YbL0garBvrTKughXa89TK1e9mPEexPQw0CPvfoVW/nOKEE1n3IM1fwxrf7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SMecslP5; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99f629a7aaso690727566b.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Oct 2024 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1730124445; x=1730729245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVZZiKyJj7ZnmSyKDxiL2Ewqy8l9yzTHRtpEpGvvetk=;
        b=SMecslP5R+XHNDJJDRWjDaPp0yrVA66icFom+/n2LAvdC5i6tr67KO6e6M8pi99om8
         EX8I0CuW83XGmvWJcTJE8OUGjh8Ugceo6LqmmdE7TFrXthgeGTxG8j99HMndi3+o/Czr
         vUuVd6ts9DdMJM5HnlX4Ns1ChGNqGIU9GM4ifn4WcgZgwbxfDzvMlvXOdqkQMnZRZ8oI
         ttI0wQ0IUWoerN3nlfjeqGDLIqv3MRpITPDrD6CHwWpBYqAo1qy429TecWu8oq3KDVf/
         Id6yvj5xXBGazXhXcKeyA4N/S/JM83J9MnHaApCktpqHZe5MqoiR1XGT6nA0zZervsko
         pw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730124445; x=1730729245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVZZiKyJj7ZnmSyKDxiL2Ewqy8l9yzTHRtpEpGvvetk=;
        b=fxevZkbopBgwT+fBfeYRguyssT5rwR1s4W4anBSp0mJFF686paNpV/zKb0JRFuHmDC
         VQdLlrP9HbgP7ufL3aLyiwFpk4QpHYt5+LMs9Hn8sfhObxgpV7hhu0HXb9A/p3LJYnp4
         9haQEiGQ7xGRfLSnPA1ARqDlJZ5YKjj0ydmz2Xfy1GCiCpDEi/Ap2DNFDzdXVBK6iTlA
         XAwesBAaWJ8+sWDpFrPODkDx9sErbzEWRkrYuqJQxX5cmkFQNbQBjhkBW3ve++OGhFig
         9AN7trPAEqBf8n4Wbd2IHZmQo9IpJsMNrLfTFjSQeIPz46MCEkT4b1N6qkxmmk6GWM/N
         xTiA==
X-Forwarded-Encrypted: i=1; AJvYcCX6sVeqE4sQXN4dqhODUx9j3zKwnqMjclcNIEDKdvEW83HWyTEjUYCUCpjVaGkLFDML53I3sijSdCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCtVz9dJnuVWhq5F3WNh9WSR4I5qW58+0I7LWT7Ym+wuAEJba
	zVAtl3rK/01wy1J2JOMsXRBXmDCJdvbOetj90jkQO2pE18Nqft76ekCCRM9zi1Q=
X-Google-Smtp-Source: AGHT+IEQdbITjqhgIXETXbiDGS9CpxFITbMxPJxEoYU59S+9lkAwLuR8Fmvi9lRxn9X6MPz0PlOOOw==
X-Received: by 2002:a17:907:1c92:b0:a99:f9fa:5c01 with SMTP id a640c23a62f3a-a9de391b292mr763533366b.32.1730124445300;
        Mon, 28 Oct 2024 07:07:25 -0700 (PDT)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dec7d16sm378731766b.21.2024.10.28.07.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 07:07:24 -0700 (PDT)
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
Subject: [PATCH v3 09/12] arm64: dts: rp1: Add support for RaspberryPi's RP1 device
Date: Mon, 28 Oct 2024 15:07:26 +0100
Message-ID: <1f4cec50493ec5d3168735c0a005771787e5cd59.1730123575.git.andrea.porta@suse.com>
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

RaspberryPi RP1 is a multi function PCI endpoint device that
exposes several subperipherals via PCI BAR.
Add a dtb overlay that will be compiled into a binary blob
and linked in the RP1 driver.
This overlay offers just minimal support to represent the
RP1 device itself, the sub-peripherals will be added by
future patches.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
NOTE: this patch should be taken by the same maintainer that will take
"[PATCH v3 10/12] misc: rp1: RaspberryPi RP1 misc driver", since they
are closely related in terms of compiling.

 MAINTAINERS                           |  1 +
 arch/arm64/boot/dts/broadcom/rp1.dtso | 61 +++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1.dtso

diff --git a/MAINTAINERS b/MAINTAINERS
index 06277969a522..510a071ede78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19383,6 +19383,7 @@ F:	include/uapi/linux/media/raspberrypi/
 RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/rp1.dtso
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
new file mode 100644
index 000000000000..8d1bbf207a30
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
@@ -0,0 +1,61 @@
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
+				ranges = <0xc0 0x40000000
+					  0x01 0x00 0x00000000
+					  0x00 0x00400000>;
+				dma-ranges = <0x10 0x00000000
+					      0x43000000 0x10 0x00000000
+					      0x10 0x00000000>;
+				#address-cells = <2>;
+				#size-cells = <2>;
+
+				rp1_clocks: clocks@c040018000 {
+					compatible = "raspberrypi,rp1-clocks";
+					reg = <0xc0 0x40018000 0x0 0x10038>;
+					#clock-cells = <1>;
+					clocks = <&clk_rp1_xosc>;
+					clock-names = "xosc";
+					assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
+							  <&rp1_clocks RP1_PLL_SYS>,
+							  <&rp1_clocks RP1_CLK_SYS>;
+					assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
+							       <200000000>,  // RP1_PLL_SYS
+							       <200000000>;  // RP1_CLK_SYS
+				};
+
+				rp1_gpio: pinctrl@c0400d0000 {
+					compatible = "raspberrypi,rp1-gpio";
+					reg = <0xc0 0x400d0000  0x0 0xc000>,
+					      <0xc0 0x400e0000  0x0 0xc000>,
+					      <0xc0 0x400f0000  0x0 0xc000>;
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


