Return-Path: <linux-pci+bounces-28588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A29AC7C15
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8EBC500199
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 10:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FF328ECE9;
	Thu, 29 May 2025 10:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JRnGmBG5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AE328DF30
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 10:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515692; cv=none; b=V4jeAp3Fs7Yj6bSjVyPg6NMM1XTO2dQNDtEmjVV1AJJ7tPLX6U9/vpAq0d53RrPYmwoxNMR4FPeZQp7wQewENXoVB7TLsteoFkRgCK7xfxj+VCM1ngj4q+BmqJTyyYDvCC3c+qppGincklfbu/tX6DpIvypB54UhfZA1nifNT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515692; c=relaxed/simple;
	bh=eMe4mQgSX9Szv7WKunt7QkqAZDsYcLcx7lYQqW43qQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAtvHuZdk/anD+JqQl8qgsscKry0J4AmmffXt2+ToJc6m+H9Oi827zZ0xc8KbXSIuY+KbXBAF1fOhRVF1160h6cK/MHnRxzICq/Qjbktq99y0dttJYcX1iwYr8Hm4SGoolbyo712UHK2V4KV7Ktzrt1JxHsyRryi7Um2eZueeAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JRnGmBG5; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so107236466b.2
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 03:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748515686; x=1749120486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZmKSMbzA96hgjOUpKAldzAt0+MepqVPTK1rf+kG3Dk=;
        b=JRnGmBG5is2o8lvsqz8w2umJdPhKNDP9HpwMFkGrOCkYuaG6PCHZDSOdhLt5l/6rvb
         UwbpL2JVcEl5eG2A/q131FAD3Ftnf4y2JTy7Ghgm2dm7dr0ekl9jWEJ0GP26mZgzndCd
         fZ2g6MIgQXo4lt5Ma3pzO9mdcIn64Eeq6Kh5uATfwnm5RpL2LX17ni+l/X+xMScs4II0
         W7ROqJAHmRF70mP3Lim0pBQHj+SMnIHzDDnU74R+VWstyuRtatwyPlTojCBxFpKQTXw8
         uk8xQjGKMqDKTC6H0+EVgWzV57ch2Brev1BAWtMXNz6s9Hd/yVzjHqS+o/47ZCJdV7up
         82fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748515686; x=1749120486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZmKSMbzA96hgjOUpKAldzAt0+MepqVPTK1rf+kG3Dk=;
        b=j9DBjzCRS+NZbumKy6ZR07C3mijNiXD4Y8N/uzuhThUpgiL1u08T0XYj3tnntI8l04
         d9jL7EcMqrr3yH+G9E2i/ux8hrPmOYQnclVlSS8kIDBLgtgs5JjqTPgfM2qyWhfI6wD4
         VIMsJETwXwM2b+4mDSNOB0gUXeaEFxDJqzk1Tn05VGoruGmHtBnnCVIG1GG+6HPEpUJV
         3m0aRgqbiZQv4eCoXifogkEOmAhsYPoIGuRaY2obQoUjNcHddhhX9oOCRk5tl+1GbxdT
         1E4uQP0MMQCLcuNlkg0D5YDExgMhjqdnLcCkUPRRIS4gIhuYgMkdMqVTHyn3YIQNdAer
         FzcQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1v4i5st76s3rPZOaGc8IitzNNONoXX6APOpCEPEuoQw/9d6NE6KFieJrdkTZ1SRkqVTdKWqt5/O8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKDwWqWWWL4cWrdgB/Z9RO1CIgDeTiyxbnh+PrGsc1X1UgBC9m
	FfkTAGNcYGQLrrh6AJWB+Ot7PecWv/6dwwlBDddOM4OO7gJYZCLHO42ewdDu8Hx5gFc=
X-Gm-Gg: ASbGncuc0qV9eVeqYv8rjjyNK8ZLArDEp25b9NqHVr3EK8TdpVFVMAi2xkQA9W+zC1X
	NHpjLjkZuquRLimIXLkd1AlaI86WnVSLUG/LiTID1nk1ARN9WwO0zsqIzM6c3QuooxHCR5UnRM+
	m01tXQLT+dIOkshZ0hzdWC6JCc//lAH8kmbX0UUYy/83mLDuJ2OcBMFQNWZjPp+ZPcpPR/+f4kk
	rp8TsE0ePXFctzhb905UCakucvQZASjoRwTkivrtOa5rP4BBw/cI0R0+dhyXO6eiPqKByfrQUlE
	IuH5QRmXv7IIK5eUcrDpw35lg0NAzPS0c/Sd/yeBsB+Ujp5qwTbGBmedLwEcDRsHkKzU7QbGdZF
	4EHdrf7RTViaiNYs/rnoEdw==
X-Google-Smtp-Source: AGHT+IGh8TR0aTk3/840g4wSBI4XDXnF7+SV7GWaCLcPzE7octWCVbP3trjbOevfutoSZKgkJ9B+LQ==
X-Received: by 2002:a17:907:7b9f:b0:ad8:9428:6a4a with SMTP id a640c23a62f3a-adadee31232mr162318866b.32.1748515685891;
        Thu, 29 May 2025 03:48:05 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5e2bf045sm119807466b.108.2025.05.29.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:48:05 -0700 (PDT)
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
Subject: [PATCH v10] arm64: dts: rp1: Add support for RaspberryPi's RP1 device
Date: Thu, 29 May 2025 12:49:23 +0200
Message-ID: <20250529104940.23053-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748514765.git.andrea.porta@suse.com>
References: <cover.1748514765.git.andrea.porta@suse.com>
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
 arch/arm64/boot/dts/broadcom/rp1-common.dtsi | 42 ++++++++++++++++++++
 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi  | 14 +++++++
 2 files changed, 56 insertions(+)
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-common.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi

diff --git a/arch/arm64/boot/dts/broadcom/rp1-common.dtsi b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
new file mode 100644
index 000000000000..5002a375eb0b
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1-common.dtsi
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/raspberrypi,rp1-clocks.h>
+
+pci_ep_bus: pci-ep-bus@1 {
+	compatible = "simple-bus";
+	ranges = <0x00 0x40000000  0x01 0x00 0x00000000  0x00 0x00400000>;
+	dma-ranges = <0x10 0x00000000  0x43000000 0x10 0x00000000  0x10 0x00000000>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	rp1_clocks: clocks@40018000 {
+		compatible = "raspberrypi,rp1-clocks";
+		reg = <0x00 0x40018000 0x0 0x10038>;
+		#clock-cells = <1>;
+		clocks = <&clk_rp1_xosc>;
+		assigned-clocks = <&rp1_clocks RP1_PLL_SYS_CORE>,
+				  <&rp1_clocks RP1_PLL_SYS>,
+				  <&rp1_clocks RP1_PLL_SYS_SEC>,
+				  <&rp1_clocks RP1_CLK_SYS>;
+		assigned-clock-rates = <1000000000>, // RP1_PLL_SYS_CORE
+				       <200000000>,  // RP1_PLL_SYS
+				       <125000000>,  // RP1_PLL_SYS_SEC
+				       <200000000>;  // RP1_CLK_SYS
+	};
+
+	rp1_gpio: pinctrl@400d0000 {
+		compatible = "raspberrypi,rp1-gpio";
+		reg = <0x00 0x400d0000  0x0 0xc000>,
+		      <0x00 0x400e0000  0x0 0xc000>,
+		      <0x00 0x400f0000  0x0 0xc000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupts = <0 IRQ_TYPE_LEVEL_HIGH>,
+			     <1 IRQ_TYPE_LEVEL_HIGH>,
+			     <2 IRQ_TYPE_LEVEL_HIGH>;
+	};
+};
diff --git a/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi b/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
new file mode 100644
index 000000000000..0ef30d7f1c35
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rp1-nexus.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+rp1_nexus {
+	compatible = "pci1de4,1";
+	#address-cells = <3>;
+	#size-cells = <2>;
+	ranges = <0x01 0x00 0x00000000
+		  0x02000000 0x00 0x00000000
+		  0x0 0x400000>;
+	interrupt-controller;
+	#interrupt-cells = <2>;
+
+	#include "rp1-common.dtsi"
+};
-- 
2.35.3


