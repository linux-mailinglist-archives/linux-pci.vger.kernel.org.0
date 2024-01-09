Return-Path: <linux-pci+bounces-1899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A44AE82818E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A53B23E18
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192473C473;
	Tue,  9 Jan 2024 08:24:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCB73C064;
	Tue,  9 Jan 2024 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 870E31C0D93;
	Tue,  9 Jan 2024 17:24:35 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Bin Meng <bmeng@tinylab.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
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
Subject: [DO NOT MERGE v6 30/37] sh: add RTS7751R2D Plus DTS
Date: Tue,  9 Jan 2024 17:23:27 +0900
Message-Id: <ca3c1a7f7b42d99a3a6522e0dd2154b36d899dcf.1704788539.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1704788539.git.ysato@users.sourceforge.jp>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas RTS7751R2D Plus devicetree.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/rts7751r2dplus.dts | 180 ++++++++++++++++++++++++++++
 arch/sh/boot/dts/sh7751r.dtsi       |   4 +
 2 files changed, 184 insertions(+)
 create mode 100644 arch/sh/boot/dts/rts7751r2dplus.dts

diff --git a/arch/sh/boot/dts/rts7751r2dplus.dts b/arch/sh/boot/dts/rts7751r2dplus.dts
new file mode 100644
index 000000000000..e649fcaa817c
--- /dev/null
+++ b/arch/sh/boot/dts/rts7751r2dplus.dts
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the Renesas RTS7751R2D Plus
+ */
+
+/dts-v1/;
+
+#include "sh7751r.dtsi"
+
+/ {
+	model = "Renesas RTS7715R2D Plus";
+	compatible = "renesas,rts7751r2d", "renesas,sh7751r";
+
+	aliases {
+		serial0 = &scif1;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+
+	r2dintc: interrupt-controller@a4000000 {
+		compatible = "renesas,sh7751-irl-ext";
+		reg = <0xa4000000 0x02>;
+		interrupt-controller;
+		#address-cells = <0>;
+		#interrupt-cells = <1>;
+		renesas,enable-bit = <0 11>,		/* PCI INTD */
+				     <1 9>,		/* CF IDE */
+				     <2 8>,		/* CF CD */
+				     <3 12>,		/* PCI INTC */
+				     <4 10>,		/* SM501 */
+				     <5 6>,		/* KEY */
+				     <6 5>,		/* RTC ALARM */
+				     <7 4>,		/* RTC T */
+				     <8 7>,		/* SDCARD */
+				     <9 14>,		/* PCI INTA */
+				     <10 13>,		/* PCI INTB */
+				     <11 0>,		/* EXT */
+				     <12 15>;		/* TP */
+	};
+
+	display@0 {
+		compatible = "smi,sm501";
+		reg = <0x10000000 0x03e00000
+		       0x13e00000 0x00200000>;
+		interrupt-parent = <&r2dintc>;
+		interrupts = <4>;
+		mode = "640x480-16@60";
+		little-endian;
+		smi,devices = "usb-host", "uart0";
+		swap-fb-endian;
+
+		crt {
+			smi,flags = "use-init-done",
+				    "disable-at-exit",
+				    "use-hwcursor",
+				    "use-hwaccel";
+		};
+
+		panel {
+			bpp = <16>;
+			edid = [00 ff ff ff ff ff ff 00 00 00 00 00 00 00 00 00
+				00 00 01 04 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 f0 0a 80 fb 20 e0 25 10 32 60
+				02 00 00 00 00 00 00 06 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+				00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 bd];
+			smi,flags = "use-init-done",
+				    "disable-at-exit",
+				    "use-hwcursor",
+				    "use-hwaccel";
+		};
+		misc-timing {
+			ex = <16>;
+			xc = "internal-pll";
+			us = "disable";
+		};
+		misc-control {
+			pad = <24>;
+			usbclk = "crystal";
+			sh = "active-low";
+		};
+		gpio-pin-control {
+			pin@0 {
+				gpio-port;
+			};
+			pin@1 {
+				function;
+			};
+		};
+
+		gpio-i2c {
+			 i2c@0 {
+			       sda = <1>;
+			       scl = <2>;
+			       delay = <100>;
+			       timeout = <1000>;
+			 };
+		};
+	};
+
+	compact-flash@b4001000 {
+		compatible = "renesas,rts7751r2d-ata", "ata-generic";
+		reg = <0xb4001000 0x0e>, <0xb400080c 2>;
+		reg-shift = <1>;
+		interrupt-parent = <&r2dintc>;
+		interrupts = <1>;
+	};
+
+	flash@0 {
+		compatible = "cfi-flash";
+		reg = <0x00000000 0x02000000>;
+		device-width = <2>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "U-Boot";
+			reg = <0x00000000 0x00040000>;
+		};
+
+		partition@1 {
+			label = "Environemt";
+			reg = <0x00040000 0x00040000>;
+		};
+
+		partition@2 {
+			label = "Kernel";
+			reg = <0x00080000 0x001c0000>;
+		};
+
+		partition@3 {
+			label = "Flash_FS";
+			reg = <0x00240000 0x00dc0000>;
+		};
+	};
+};
+
+&xtal {
+	clock-frequency = <22222222>;
+};
+
+&cpg {
+	renesas,mode = <5>;
+};
+
+&scif1 {
+	status = "okay";
+};
+
+&pcic {
+	ranges = <0x02000000 0 0xfd000000 0xfd000000 0 0x01000000>,
+		 <0x01000000 0 0x00000000 0xfe240000 0 0x00040000>;
+	dma-ranges = <0x02000000 0 0x0c000000 0x0c000000 0 0x04000000>;
+
+	interrupt-map = <0x0000 0 0 1 &r2dintc 9>,
+			<0x0000 0 0 2 &r2dintc 10>,
+			<0x0000 0 0 3 &r2dintc 3>,
+			<0x0000 0 0 4 &r2dintc 0>,
+			<0x0800 0 0 1 &r2dintc 10>,
+			<0x0800 0 0 2 &r2dintc 3>,
+			<0x0800 0 0 3 &r2dintc 0>,
+			<0x0800 0 0 4 &r2dintc 9>,
+			<0x1000 0 0 1 &r2dintc 3>,
+			<0x1000 0 0 2 &r2dintc 0>,
+			<0x1000 0 0 3 &r2dintc 9>,
+			<0x1000 0 0 4 &r2dintc 10>;
+			interrupt-map-mask = <0x1800 0 0 7>;
+	pci-bar = <0 0xab000001>, <2 0xd0000000>;
+	pci-command-reg-io-space;
+	status = "okay";
+};
diff --git a/arch/sh/boot/dts/sh7751r.dtsi b/arch/sh/boot/dts/sh7751r.dtsi
index f006f7bacf99..02d1e8c3eef2 100644
--- a/arch/sh/boot/dts/sh7751r.dtsi
+++ b/arch/sh/boot/dts/sh7751r.dtsi
@@ -142,6 +142,10 @@ pcic: pci@fe200000 {
 			bus-range = <0 0>;
 			reg = <0xfe200000 0x0400>,
 			      <0xff800000 0x0100>;
+			pci-command-reg-special-cycle;
+			pci-command-reg-parity-error-response;
+			pci-command-reg-bus-master;
+			pci-command-reg-memory-space;
 			status = "disabled";
 		};
 	};
-- 
2.39.2


