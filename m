Return-Path: <linux-pci+bounces-1905-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FA78281C7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F084B25D61
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A8A3D992;
	Tue,  9 Jan 2024 08:24:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B173D97F;
	Tue,  9 Jan 2024 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 45B201C0E56;
	Tue,  9 Jan 2024 17:24:46 +0900 (JST)
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
Subject: [DO NOT MERGE v6 36/37] sh: LANDISK OF defconfig
Date: Tue,  9 Jan 2024 17:23:33 +0900
Message-Id: <3ad8ee7654e34b1b8788b6a832e219f0547ca7ab.1704788539.git.ysato@users.sourceforge.jp>
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

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/configs/landisk-of_defconfig | 104 +++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 arch/sh/configs/landisk-of_defconfig

diff --git a/arch/sh/configs/landisk-of_defconfig b/arch/sh/configs/landisk-of_defconfig
new file mode 100644
index 000000000000..1a70884c675b
--- /dev/null
+++ b/arch/sh/configs/landisk-of_defconfig
@@ -0,0 +1,104 @@
+CONFIG_SYSVIPC=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_KEXEC=y
+CONFIG_CPU_SUBTYPE_SH7751R=y
+CONFIG_MEMORY_START=0x0c000000
+CONFIG_SH_OF_BOARD=y
+CONFIG_HEARTBEAT=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_ADVANCED_ROUTER=y
+CONFIG_IP_PNP=y
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+CONFIG_ATALK=m
+CONFIG_PCI=y
+CONFIG_PCI_SH7751=y
+CONFIG_PCCARD=y
+CONFIG_YENTA=y
+CONFIG_UEVENT_HELPER=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_BLK_DEV_SR=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_ATA=y
+CONFIG_PATA_ARTOP=y
+CONFIG_PATA_OF_PLATFORM=y
+CONFIG_ATA_GENERIC=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_MD=m
+CONFIG_MD_LINEAR=m
+CONFIG_MD_RAID0=m
+CONFIG_MD_RAID1=m
+CONFIG_NETDEVICES=y
+CONFIG_TUN=m
+CONFIG_8139CP=y
+CONFIG_USB_PEGASUS=m
+CONFIG_USB_RTL8150=m
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_SH_SCI=y
+CONFIG_HW_RANDOM=y
+CONFIG_SOUND=m
+CONFIG_HID_A4TECH=m
+CONFIG_HID_BELKIN=m
+CONFIG_HID_CHERRY=m
+CONFIG_HID_CYPRESS=m
+CONFIG_HID_EZKEY=m
+CONFIG_HID_GYRATION=m
+CONFIG_HID_MICROSOFT=m
+CONFIG_HID_MONTEREY=m
+CONFIG_HID_PANTHERLORD=m
+CONFIG_HID_PETALYNX=m
+CONFIG_HID_SAMSUNG=m
+CONFIG_HID_SUNPLUS=m
+CONFIG_USB_HID=m
+CONFIG_USB=y
+CONFIG_USB_MON=y
+CONFIG_USB_EHCI_HCD=y
+# CONFIG_USB_EHCI_TT_NEWSCHED is not set
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_PRINTER=m
+CONFIG_USB_STORAGE=m
+CONFIG_USB_STORAGE_DATAFAB=m
+CONFIG_USB_STORAGE_FREECOM=m
+CONFIG_USB_STORAGE_ISD200=m
+CONFIG_USB_STORAGE_SDDR09=m
+CONFIG_USB_STORAGE_SDDR55=m
+CONFIG_USB_STORAGE_JUMPSHOT=m
+CONFIG_USB_SERIAL=m
+CONFIG_USB_SERIAL_FTDI_SIO=m
+CONFIG_USB_SERIAL_PL2303=m
+CONFIG_USB_EMI62=m
+CONFIG_USB_EMI26=m
+CONFIG_USB_SISUSBVGA=m
+CONFIG_RENESAS_SH7751_INTC=y
+CONFIG_RENESAS_SH7751IRL_INTC=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+CONFIG_REISERFS_FS=y
+CONFIG_ISO9660_FS=m
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_NTFS_FS=m
+CONFIG_NTFS_RW=y
+CONFIG_TMPFS=y
+CONFIG_ROMFS_FS=y
+CONFIG_UFS_FS=m
+CONFIG_NFS_FS=m
+CONFIG_NFSD=m
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_932=y
+CONFIG_INIT_STACK_NONE=y
+CONFIG_CRC_T10DIF=y
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_FTRACE is not set
+CONFIG_SH_STANDARD_BIOS=y
-- 
2.39.2


