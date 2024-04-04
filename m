Return-Path: <linux-pci+bounces-5706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A718980E6
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 905B1B2639C
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF6713281A;
	Thu,  4 Apr 2024 05:16:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843E91311B7;
	Thu,  4 Apr 2024 05:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207763; cv=none; b=Z1hWAuplLWnFII32LOT+L9eJ98DXErf7dtmenKVLgMAAKE8+zFg2kOS099BifiM19893J5h3y2ThGLFW+d/Qkh7nRUqXvToXHfIaMIQptDoHHaWWJ0Gq1w1O4Dl74hkBJYCUHKNmVnaRsWPDa8jYmBZvD3d1UDcHCS+bXbkNtuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207763; c=relaxed/simple;
	bh=m6q7tpuRi911iyHKJb6eFPrPwIOrw9V4zQFTCetWP6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e67RgI76KBC80DJgMUzOoLvGcwqito5nSw2jfejGNiD4Y/CTCPZy7CIWeNSFDxHgOZbD28yInR/y6hw3uH3dHM/3v1TaXONRO38Wz+L3F3+bMnMgeWjvwt9j83nKPNKuF7UpvAG+mjKDBR2qJ9gRRByTVuo++tUS2RfWl2UNjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 72C171C1064;
	Thu,  4 Apr 2024 14:15:59 +0900 (JST)
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
Subject: [RESEND v7 35/37] sh: RTS7751R2D Plus OF defconfig
Date: Thu,  4 Apr 2024 14:14:46 +0900
Message-Id: <722ed8d38e712f6e7f14ea43dd4ce634940435fa.1712207606.git.ysato@users.sourceforge.jp>
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

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/configs/rts7751r2dplus-of_defconfig | 75 +++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 arch/sh/configs/rts7751r2dplus-of_defconfig

diff --git a/arch/sh/configs/rts7751r2dplus-of_defconfig b/arch/sh/configs/rts7751r2dplus-of_defconfig
new file mode 100644
index 000000000000..75f3fc4fc5e6
--- /dev/null
+++ b/arch/sh/configs/rts7751r2dplus-of_defconfig
@@ -0,0 +1,75 @@
+CONFIG_SYSVIPC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_PROFILING=y
+CONFIG_CPU_SUBTYPE_SH7751R=y
+CONFIG_MEMORY_START=0x0c000000
+CONFIG_SH_RTS7751R2D=y
+CONFIG_RTS7751R2D_PLUS=y
+CONFIG_HEARTBEAT=y
+CONFIG_CMDLINE="console=tty0 console=ttySC1,115200 root=/dev/sda1"
+CONFIG_CMDLINE_OVERWRITE=y
+CONFIG_MODULES=y
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_IPV6 is not set
+CONFIG_PCI=y
+CONFIG_HOTPLUG_PCI=y
+CONFIG_UEVENT_HELPER=y
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_SD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_ATA=y
+CONFIG_PATA_PLATFORM=y
+CONFIG_NETDEVICES=y
+CONFIG_8139TOO=y
+# CONFIG_8139TOO_PIO is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_HW_RANDOM=y
+CONFIG_SPI=y
+CONFIG_SPI_SH_SCI=y
+CONFIG_MFD_SM501=y
+CONFIG_FB=y
+CONFIG_FB_SH_MOBILE_LCDC=m
+CONFIG_FB_SM501=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+# CONFIG_LOGO_LINUX_VGA16 is not set
+# CONFIG_LOGO_LINUX_CLUT224 is not set
+# CONFIG_LOGO_SUPERH_MONO is not set
+# CONFIG_LOGO_SUPERH_VGA16 is not set
+CONFIG_SOUND=y
+CONFIG_SND=m
+CONFIG_SND_YMFPCI=m
+CONFIG_HID_GYRATION=y
+CONFIG_HID_PANTHERLORD=y
+CONFIG_HID_PETALYNX=y
+CONFIG_HID_SAMSUNG=y
+CONFIG_HID_SUNPLUS=y
+CONFIG_USB=y
+CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_R9701=y
+CONFIG_EXT2_FS=y
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_MINIX_FS=y
+CONFIG_NLS_CODEPAGE_932=y
+CONFIG_CRC_T10DIF=y
+CONFIG_DEBUG_FS=y
-- 
2.39.2


