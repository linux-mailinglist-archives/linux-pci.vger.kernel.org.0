Return-Path: <linux-pci+bounces-450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19D804EA5
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 10:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB60B20D1B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 09:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396F04CE19;
	Tue,  5 Dec 2023 09:47:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 673101A2;
	Tue,  5 Dec 2023 01:47:19 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 0AC691C096F;
	Tue,  5 Dec 2023 18:47:17 +0900 (JST)
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
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guo Ren <guoren@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Bin Meng <bmeng@tinylab.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Tom Rix <trix@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
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
Subject: [DO NOT MERGE v5 37/37] sh: j2_defconfig: update
Date: Tue,  5 Dec 2023 18:45:56 +0900
Message-Id: <cd86054aee22dfd94d66abffad0347a2dbdbe23e.1701768028.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
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


