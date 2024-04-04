Return-Path: <linux-pci+bounces-5700-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951B08980B0
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B919B1C26358
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E6712D1EF;
	Thu,  4 Apr 2024 05:15:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943B12C81A;
	Thu,  4 Apr 2024 05:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207751; cv=none; b=t6ZPBoGTiZDdqTRnWPok211JgREJ1a8gNsTw/S4Tq5D9x4mUs/8vBRrqHVW/gKuaMNvI97zzA+DfRU83WLl4sAjR+8CsFnZjR35Dymiyc0GmdjeYFGJbHhP5gd6CIVdoGqMWGMmf9UqoqvvCIsfPkFVYxtC4j8DBpaBkHxWMTgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207751; c=relaxed/simple;
	bh=PJg4Z83CmeMDocZYEZNk/vAESEkh9fTfxnSUiOQ3tlw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tN1Lj3wTKfBmatm34/8AByUtbL8KEjSswd9CtINpw9Y2IxIF7xlMP022nZhN7IDpf+zZRIVdeY1zQt2mg3yhKjNqTJcFnW/SKqOLSj2h1vBOKCHPV/4lpf+/PWekrxQ7CsmJRxTrbmO/41klPsnbJ/18r/foMPycSFgUqqPeTG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id C34E11C1017;
	Thu,  4 Apr 2024 14:15:47 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
	Shawn Guo <shawnguo@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
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
Subject: [RESEND v7 29/37] sh: SH7751R SoC Internal peripheral definition dtsi.
Date: Thu,  4 Apr 2024 14:14:40 +0900
Message-Id: <fe69e328ec617f91a09fa2d00506ba1a664085d8.1712207606.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712207606.git.ysato@users.sourceforge.jp>
References: <cover.1712207606.git.ysato@users.sourceforge.jp>
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


