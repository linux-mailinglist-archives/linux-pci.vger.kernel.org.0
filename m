Return-Path: <linux-pci+bounces-7984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819978D3020
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9531C25E2C
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3208218732A;
	Wed, 29 May 2024 08:02:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828DE184119;
	Wed, 29 May 2024 08:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969746; cv=none; b=Mf6Tpl3doEzBOqeTCFmxVpiXnXkM7nPbHGabRTnE6ZbEbenSc2gwPMG7swOzAeI8Yef4gTjejrImQdPEAk720QD5xiPiOLz313RNY1Hc0yow4ctK4b2DrYMCZHPvCiOxQiTh+JOWhSN0LPcigtJpRRXH6d099ddpsefx2RUfZi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969746; c=relaxed/simple;
	bh=kt9MVUVLoRjG4UUyYQiJw6Pi6MQWcJLl9nI+3iP/ezI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IG/bNGUXMEY4zHwRkXMUsre7wP1T7rxXP1xQr+cwcGHhtzfsMe6DRK2DGVuh/WlxRhURA/nBKGK6PD1c33cEbVSuYDdfWg8LPEDYFLPbuNgyEUeX5eBmEkw9YUFBus8G0yXc9ZwyYGh5WLqLza9E+NHCxyelc8s576IjN5bn5lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 3C24B1C103A;
	Wed, 29 May 2024 17:02:22 +0900 (JST)
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
Subject: [DO NOT MERGE v8 30/36] sh: Add IO DATA LANDISK dts
Date: Wed, 29 May 2024 17:01:16 +0900
Message-Id: <ffded7fc0fb4d1d8cc0191dee1a8c780f65a1fdd.1716965617.git.ysato@users.sourceforge.jp>
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

IO DATA DEVICE Inc. LANDISK HDL-U devicetree.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/landisk.dts | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 arch/sh/boot/dts/landisk.dts

diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
new file mode 100644
index 000000000000..1ac1f532947b
--- /dev/null
+++ b/arch/sh/boot/dts/landisk.dts
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for the IO DATA DEVICE LANDISK
+ */
+
+/dts-v1/;
+
+#include "sh7751r.dtsi"
+
+/ {
+	model = "IO DATA Device LANDISK";
+	compatible = "iodata,landisk", "renesas,sh7751r";
+
+	aliases {
+		serial0 = &scif1;
+	};
+
+	chosen {
+		stdout-path = "serial0:9600n8";
+	};
+
+	memory@c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+
+	julianintc: interrupt-controller@b0000005 {
+		compatible = "renesas,sh7751-irl-ext";
+		reg = <0xb0000005 0x01>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		/*
+		 * b7: Not assigned
+		 * b6: Power switch
+		 * b5: Not assigned
+		 * b4: Not assigned
+		 * b3: PCI-INTD
+		 * b2: PCI-INTC
+		 * b1: PCI-INTB
+		 * b0: PCI-INTA
+		 */
+		renesas,enable-reg = <15 11 15 15 8 7 6 5>;
+	};
+};
+
+&extal {
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
+	dma-ranges = <0x02000000 0 0x0c000000 0x0c000000 0 0x04000000>,
+		     <0x02000000 0 0xd0000000 0xd0000000 0 0x00000004>;
+	interrupt-map = <0x0000 0 0 1 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+			<0x0000 0 0 2 &julianintc 6 IRQ_TYPE_LEVEL_LOW>,
+			<0x0000 0 0 3 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+			<0x0000 0 0 4 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+			<0x0800 0 0 1 &julianintc 6 IRQ_TYPE_LEVEL_LOW>,
+			<0x0800 0 0 2 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+			<0x0800 0 0 3 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+			<0x0800 0 0 4 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+			<0x1000 0 0 1 &julianintc 7 IRQ_TYPE_LEVEL_LOW>,
+			<0x1000 0 0 2 &julianintc 8 IRQ_TYPE_LEVEL_LOW>,
+			<0x1000 0 0 3 &julianintc 5 IRQ_TYPE_LEVEL_LOW>,
+			<0x1000 0 0 4 &julianintc 6 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-map-mask = <0x1800 0 0 7>;
+	status = "okay";
+};
-- 
2.39.2


