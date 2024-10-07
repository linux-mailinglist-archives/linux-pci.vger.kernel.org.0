Return-Path: <linux-pci+bounces-13962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D159F992C28
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 14:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527451F215DF
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720FE1D79A4;
	Mon,  7 Oct 2024 12:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eXWgJ8Wu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF201D6194
	for <linux-pci@vger.kernel.org>; Mon,  7 Oct 2024 12:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304806; cv=none; b=a+YXecDD3ojXVGo5JeDFYnOj32EaGFdXRlD0oe13Wiwo3WadfofPkzN51Q4wJ1i3rAaXQuJAanGc7HUlrGaFea8khFhD7htnsHHzhr1rf7ep0V/mtE+/g39a5zNX9WvfpXzHDLm2h+pEmQaFzBJ0vbaFpOtsV6r7ML4yEuRrxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304806; c=relaxed/simple;
	bh=ZEPzPLsXrcChWumoZ7SBiHMsSOTvRa3Wuhep1haX83c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7lU3ZI01kDSUomSpUpmQV9JFaPckmRLlaP9QaLrV8bpheYD6h1gNWffyJHugbNkWEeKC1NAB/CdZnJ3DpI2SzlIbLn0zsHUFIc5yuHQXNhXeEcYpB3yNwEm4Ni0xz3SfItcECtBhvfSZKN7SNfqc2zYjlAl4UHv3mqeGfCCZIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eXWgJ8Wu; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9957588566so116620866b.3
        for <linux-pci@vger.kernel.org>; Mon, 07 Oct 2024 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728304801; x=1728909601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7GLnpdk3kpJmE9r4o2PWhEgiezo/nwd6A/PFeKxkMs=;
        b=eXWgJ8Wu4/VpFTXBJ1CM9XxLbRpV1g7E3GjjpLf1vNQX6h1z+scbMxa4e3SaI2Lg8I
         Qi6xRh+LkS7KFLwDkK9zmsMtiXoHOQVgksIVcyqy6CTAxorHksjD7euzhk5QKIPSJbQ3
         jCSDy/RcRl4wQoQiu3X+FNyXBKIIy/aaEjZpF00z0Tka9AXCAQwTsLJru9PTNyIxta08
         0/Xo/IHJvZ0Gf4UEsoaKRfLuS+EPyF9+5eix51dSJxwtGJwZHIdINNHScQF3gWqgkyWK
         H46AQdeyLjgyp/JSOaR3Z42aZTPadmQVMLdp6GDJxD2QoQR1QAWkCpqr9Nystpnl6bGG
         K0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728304801; x=1728909601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7GLnpdk3kpJmE9r4o2PWhEgiezo/nwd6A/PFeKxkMs=;
        b=DyOnJCWrllv3K6vIWzFf97jk4QcLETDfTXBJsuR9y8Y5GzbJTITunTzs2zayQt+S9q
         engUbyzH3YFxeBN5PX5PVUTMAk3tw3QLw5b2LUjRMjvi9iSTncKYAQe29ob6ay6m8XFx
         e5mYnuAms7W29wTNQNNHWkEkU/uEaWvl6xIMxDxL5786K9LQtUd6duwX4LUZTbc8wFeV
         9eRZitXuAs/2QwBtWM65W6izemN9NdQevDU/N6drWJkFqfBJ778Y8SqYryVUU4s9Ag2h
         WvdShNh9Ugio1nnhD4mPaJ7kfRlL3jvsOBHriVN5kGtM279B3Njlbp/JU6DJhvm8b8LY
         kaeA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ1e84ZKMcAWRoK5jMnG9onrzmMpatDfHxOunuZ5KAICgiCdfVgDJ8qNKETIswUHbSdPi+gfwjHNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLBPIdBuugU6Q8ws1smXJhJZs/RX7qnY1jL2/jVflWJ+EPxn3e
	E5VoplT61xTWC44a3n8iuqF1o/UkB/T9OWn5vtPOUNrCozLJ6kuT3uaxhGs4aJU=
X-Google-Smtp-Source: AGHT+IFy0cMxJsF82yiNQcbJa9lSxuSDCs6OgxcKY5EqxFvjMZSr8FG4F668oRvYtnMpyYp5B4Dw5w==
X-Received: by 2002:a17:907:6d17:b0:a8d:2d2e:90e6 with SMTP id a640c23a62f3a-a991c00fb55mr1305844266b.60.1728304800909;
        Mon, 07 Oct 2024 05:40:00 -0700 (PDT)
Received: from localhost (host-87-21-212-62.retail.telecomitalia.it. [87.21.212.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9933db9c5bsm360605066b.162.2024.10.07.05.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:40:00 -0700 (PDT)
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
Subject: [PATCH v2 13/14] arm64: dts: Add DTS overlay for RP1 gpio line names
Date: Mon,  7 Oct 2024 14:39:56 +0200
Message-ID: <a29f2e534c2ea658fc7c1e61120476f4bd3c0585.1728300190.git.andrea.porta@suse.com>
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

This DT overlay contains the gpio-line-names property for
RaspberryPi 5.

It's intended to be loaded from userspace leveraging the RP1
driver interface through configfs, as follows:

cat rpi-rp1-gpios-5-b.dtbo > /sys/kernel/config/rp1-cfg/gpio_set_names

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 MAINTAINERS                                   |  1 +
 arch/arm64/boot/dts/broadcom/Makefile         |  3 +-
 .../boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso  | 62 +++++++++++++++++++
 3 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso

diff --git a/MAINTAINERS b/MAINTAINERS
index 032678fb2470..2b61d9a84dae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19384,6 +19384,7 @@ RASPBERRY PI RP1 PCI DRIVER
 M:	Andrea della Porta <andrea.porta@suse.com>
 S:	Maintained
 F:	arch/arm64/boot/dts/broadcom/rp1.dtso
+F:	arch/arm64/boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso
 F:	Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
 F:	Documentation/devicetree/bindings/misc/pci1de4,1.yaml
 F:	Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index 92565e9781ad..d384937b0536 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -11,7 +11,8 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-3-b.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb \
-			      bcm2837-rpi-zero-2-w.dtb
+			      bcm2837-rpi-zero-2-w.dtb \
+			      rpi-rp1-gpios-5-b.dtbo
 
 subdir-y	+= bcmbca
 subdir-y	+= northstar2
diff --git a/arch/arm64/boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso b/arch/arm64/boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso
new file mode 100644
index 000000000000..76a243a71644
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/rpi-rp1-gpios-5-b.dtso
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+/plugin/;
+
+&rp1_gpio {
+	gpio-line-names =
+		"ID_SDA", // GPIO0
+		"ID_SCL", // GPIO1
+		"GPIO2", // GPIO2
+		"GPIO3", // GPIO3
+		"GPIO4", // GPIO4
+		"GPIO5", // GPIO5
+		"GPIO6", // GPIO6
+		"GPIO7", // GPIO7
+		"GPIO8", // GPIO8
+		"GPIO9", // GPIO9
+		"GPIO10", // GPIO10
+		"GPIO11", // GPIO11
+		"GPIO12", // GPIO12
+		"GPIO13", // GPIO13
+		"GPIO14", // GPIO14
+		"GPIO15", // GPIO15
+		"GPIO16", // GPIO16
+		"GPIO17", // GPIO17
+		"GPIO18", // GPIO18
+		"GPIO19", // GPIO19
+		"GPIO20", // GPIO20
+		"GPIO21", // GPIO21
+		"GPIO22", // GPIO22
+		"GPIO23", // GPIO23
+		"GPIO24", // GPIO24
+		"GPIO25", // GPIO25
+		"GPIO26", // GPIO26
+		"GPIO27", // GPIO27
+		"PCIE_RP1_WAKE", // GPIO28
+		"FAN_TACH", // GPIO29
+		"HOST_SDA", // GPIO30
+		"HOST_SCL", // GPIO31
+		"ETH_RST_N", // GPIO32
+		"", // GPIO33
+		"CD0_IO0_MICCLK", // GPIO34
+		"CD0_IO0_MICDAT0", // GPIO35
+		"RP1_PCIE_CLKREQ_N", // GPIO36
+		"", // GPIO37
+		"CD0_SDA", // GPIO38
+		"CD0_SCL", // GPIO39
+		"CD1_SDA", // GPIO40
+		"CD1_SCL", // GPIO41
+		"USB_VBUS_EN", // GPIO42
+		"USB_OC_N", // GPIO43
+		"RP1_STAT_LED", // GPIO44
+		"FAN_PWM", // GPIO45
+		"CD1_IO0_MICCLK", // GPIO46
+		"2712_WAKE", // GPIO47
+		"CD1_IO1_MICDAT1", // GPIO48
+		"EN_MAX_USB_CUR", // GPIO49
+		"", // GPIO50
+		"", // GPIO51
+		"", // GPIO52
+		""; // GPIO53
+};
-- 
2.35.3


