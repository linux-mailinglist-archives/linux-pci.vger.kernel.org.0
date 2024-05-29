Return-Path: <linux-pci+bounces-7990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451D8D305A
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEB51F2B272
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE46619DF57;
	Wed, 29 May 2024 08:02:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC49199EA5;
	Wed, 29 May 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969756; cv=none; b=SiUMZmgVgDLrMA7NKmoCecQBX1q8q/qdFZcazP+QLj5y2FMQkZVlvuc9NfPrjuSS+VI5E5rf5kzDcm+/b1ULTqb5gLOEcO4YarcfCynKSb7ru2SDEprPqYXVu9wQyajo4Pwai+aB+mAhPy2DOukHYDZdFRo4FxKdSdMXYXtapXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969756; c=relaxed/simple;
	bh=HfCnaCGFqb9NsLZ2tSL9t0qOwxfZXHeNec47VwxbtkU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S6YFfhlc90SFWo0YEcmHD45AKZy+T+cai6K+WFMTtPF6dwHRhsizpU0mact6LjDPg3g8iVcH0j+h6DOeT8XDgddOA4OHmCCRkhn6yDmeL5OFs2JuzoFMupmtgeb8E+/k1La7ejXej5dEy3uJtRJIXMA8y3S0S6b8QQ9MAKaLUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 278291C1083;
	Wed, 29 May 2024 17:02:33 +0900 (JST)
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
Subject: [DO NOT MERGE v8 36/36] sh: j2_defconfig: update
Date: Wed, 29 May 2024 17:01:22 +0900
Message-Id: <60abd745155c465b775c3c876c0b71f0756d25a6.1716965617.git.ysato@users.sourceforge.jp>
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

I've changed some symbols related to DeviceTree,
so let's take care of those changes.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/configs/j2_defconfig | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/sh/configs/j2_defconfig b/arch/sh/configs/j2_defconfig
index 2eb81ebe3888..cdc8ed244618 100644
--- a/arch/sh/configs/j2_defconfig
+++ b/arch/sh/configs/j2_defconfig
@@ -1,18 +1,15 @@
-CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CPU_SUBTYPE_J2=y
 CONFIG_MEMORY_START=0x10000000
-CONFIG_MEMORY_SIZE=0x04000000
 CONFIG_CPU_BIG_ENDIAN=y
-CONFIG_SH_DEVICE_TREE=y
-CONFIG_SH_JCORE_SOC=y
+CONFIG_SH_OF_BOARD=y
 CONFIG_HZ_100=y
+CONFIG_SMP=y
 CONFIG_CMDLINE_OVERWRITE=y
 CONFIG_CMDLINE="console=ttyUL0 earlycon"
-CONFIG_BINFMT_ELF_FDPIC=y
 CONFIG_BINFMT_FLAT=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -21,7 +18,6 @@ CONFIG_INET=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_NETDEVICES=y
-CONFIG_SERIAL_EARLYCON=y
 CONFIG_SERIAL_UARTLITE=y
 CONFIG_SERIAL_UARTLITE_CONSOLE=y
 CONFIG_I2C=y
@@ -30,8 +26,6 @@ CONFIG_SPI_JCORE=y
 CONFIG_WATCHDOG=y
 CONFIG_MMC=y
 CONFIG_MMC_SPI=y
-CONFIG_CLKSRC_JCORE_PIT=y
-CONFIG_JCORE_AIC=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
@@ -40,3 +34,4 @@ CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_UTF8=y
+CONFIG_INIT_STACK_NONE=y
-- 
2.39.2


