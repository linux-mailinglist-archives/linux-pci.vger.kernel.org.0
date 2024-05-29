Return-Path: <linux-pci+bounces-7982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7038D300E
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E08DC28D0B6
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C1E1836D4;
	Wed, 29 May 2024 08:02:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF81836DD;
	Wed, 29 May 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969742; cv=none; b=J2ZWz4f4BciHm2x1rbpgDTvd36ipb4ghh6cNtlPs655cRsHOOtjRzl/B+djIvVVEAg7JZirbhw/q+C4ePd6Fs0p7QNtfEtQkapKSpj6l5mAfadOiETNPMWoHK5JZ1vSAY1dolreU1FMOzes8HFCTrrWv/GXUMxIgSNKdqAJGHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969742; c=relaxed/simple;
	bh=PJg4Z83CmeMDocZYEZNk/vAESEkh9fTfxnSUiOQ3tlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YJDNErdg5nx7tpM1IiGyMRKCeGH5zyU6GbxY6uN8Jv7AaIY33mS8GRc0rED2RNzICUNKONGMIptW1kTycXUpsk9VL04kcfCtHvYntlhYMCgGiWRl20yHGhtVaA0EXaLZDxKCpQctpskIoMNGTe327+ovA/QCrJgvvijzrLwGblU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id A01211C1026;
	Wed, 29 May 2024 17:02:18 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sam Ravnborg <sam@ravnborg.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [DO NOT MERGE v8 28/36] sh: SH7751R SoC Internal peripheral definition dtsi.
Date: Wed, 29 May 2024 17:01:14 +0900
Message-Id: <2a51197270763e51ee17a26be927f091ef01db5e.1716965617.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1716965617.git.ysato@users.sourceforge.jp>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SH7751R internal peripherals device tree.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/sh7751r.dtsi | 105 ++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 arch/sh/boot/dts/sh7751r.dtsi

diff --git a/arch/sh/boot/dts/sh7751r.dtsi b/arch/sh/boot/dts/sh7751r.dtsi
new file mode 100644
index 000000000000..61b2af5bebde
--- /dev/null
+++ b/arch/sh/boot/dts/sh7751r.dtsi
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the SH7751R SoC
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/clock/sh7750-cpg.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			compatible = "renesas,sh4", "renesas,sh2";
+			device_type = "cpu";
+			reg = <0>;
+			clocks = <&cpg SH7750_CPG_ICK>;
+			clock-names = "ick";
+			icache-size = <16384>;
+			icache-line-size = <32>;
+			dcache-size = <32768>;
+			dcache-line-size = <32>;
+		};
+	};
+
+	extal: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <0>;
+		clock-output-names = "extal";
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&shintc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		cpg: clock-controller@ffc00000 {
+			#clock-cells = <1>;
+			#power-domain-cells = <0>;
+			compatible = "renesas,sh7751r-cpg";
+			clocks = <&extal>;
+			clock-names = "extal";
+			reg = <0xffc00000 20>, <0xfe0a0000 16>;
+			reg-names = "FRQCR", "CLKSTP00";
+			renesas,mode = <0>;
+		};
+
+		shintc: interrupt-controller@ffd00000 {
+			compatible = "renesas,sh7751-intc";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <0xffd00000 20>, <0xfe080000 128>;
+			reg-names = "ICR", "INTPRI00";
+		};
+
+		/* sci0 is rarely used, so it is not defined here. */
+		scif1: serial@ffe80000 {
+			compatible = "renesas,scif-sh7751", "renesas,scif";
+			reg = <0xffe80000 0x100>;
+			interrupts = <0x700>,
+				     <0x720>,
+				     <0x760>,
+				     <0x740>;
+			interrupt-names = "eri", "rxi", "txi", "bri";
+			clocks = <&cpg SH7750_MSTP_SCIF>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			status = "disabled";
+		};
+
+		/* Normally ch0 and ch1 are used, so we will define ch0 to ch2 here. */
+		tmu0: timer@ffd80000 {
+			compatible = "renesas,tmu-sh7750", "renesas,tmu";
+			reg = <0xffd80000 12>;
+			interrupts = <0x400>,
+				     <0x420>,
+				     <0x440>,
+				     <0x460>;
+			interrupt-names = "tuni0", "tuni1", "tuni2", "ticpi2";
+			clocks = <&cpg SH7750_MSTP_TMU012>;
+			clock-names = "fck";
+			power-domains = <&cpg>;
+			#renesas,channels = <3>;
+		};
+
+		pcic: pci@fe200000 {
+			compatible = "renesas,sh7751-pci";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			device_type = "pci";
+			bus-range = <0 0>;
+			reg = <0xfe200000 0x0400>,
+			      <0xff800000 0x0100>;
+			status = "disabled";
+		};
+	};
+};
-- 
2.39.2


