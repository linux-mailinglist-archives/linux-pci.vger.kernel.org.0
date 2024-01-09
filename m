Return-Path: <linux-pci+bounces-1908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 340CD8281FA
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82442B251B9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13836381B3;
	Tue,  9 Jan 2024 08:31:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6957922065;
	Tue,  9 Jan 2024 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id DF4CA1C0268;
	Tue,  9 Jan 2024 17:23:42 +0900 (JST)
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
Subject: [DO NOT MERGE v6 02/37] sh: Kconfig unified OF supported targets.
Date: Tue,  9 Jan 2024 17:22:59 +0900
Message-Id: <e5d965a1ba1447466c4a70c95b1e3aa8c1aebe4b.1704788539.git.ysato@users.sourceforge.jp>
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

Targets that support OF should be treated as one board.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/Kconfig        |  1 +
 arch/sh/boards/Kconfig | 24 ++++++++++++++----------
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 7500521b2b98..ecca128c15fa 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -710,6 +710,7 @@ choice
 	prompt "Kernel command line"
 	optional
 	default CMDLINE_OVERWRITE
+	depends on !OF || USE_BUILTIN_DTB
 	help
 	  Setting this option allows the kernel command line arguments
 	  to be set.
diff --git a/arch/sh/boards/Kconfig b/arch/sh/boards/Kconfig
index 109bec4dad94..e7e52779ef62 100644
--- a/arch/sh/boards/Kconfig
+++ b/arch/sh/boards/Kconfig
@@ -19,16 +19,9 @@ config SH_DEVICE_TREE
 	select TIMER_OF
 	select COMMON_CLK
 	select GENERIC_CALIBRATE_DELAY
-
-config SH_JCORE_SOC
-	bool "J-Core SoC"
-	select SH_DEVICE_TREE
-	select CLKSRC_JCORE_PIT
-	select JCORE_AIC
-	depends on CPU_J2
-	help
-	  Select this option to include drivers core components of the
-	  J-Core SoC, including interrupt controllers and timers.
+	select GENERIC_IRQ_CHIP
+	select SYS_SUPPORTS_PCI
+	select GENERIC_PCI_IOMAP if PCI
 
 config SH_SOLUTION_ENGINE
 	bool "SolutionEngine"
@@ -293,6 +286,7 @@ config SH_LANDISK
 	bool "LANDISK"
 	depends on CPU_SUBTYPE_SH7751R
 	select HAVE_PCI
+	select SYS_SUPPORTS_PCI
 	help
 	  I-O DATA DEVICE, INC. "LANDISK Series" support.
 
@@ -369,6 +363,16 @@ config SH_APSH4AD0A
 	help
 	  Select AP-SH4AD-0A if configuring for an ALPHAPROJECT AP-SH4AD-0A.
 
+config SH_OF_BOARD
+	bool "General Open Firmware boards"
+	select SH_DEVICE_TREE
+	select CLKSRC_JCORE_PIT if CPU_J2
+	select JCORE_AIC if CPU_J2
+	select HAVE_PCI if CPU_SUBTYPE_SH7751R
+	help
+	  This board means general OF supported targets.
+
+
 source "arch/sh/boards/mach-r2d/Kconfig"
 source "arch/sh/boards/mach-highlander/Kconfig"
 source "arch/sh/boards/mach-sdk7780/Kconfig"
-- 
2.39.2


